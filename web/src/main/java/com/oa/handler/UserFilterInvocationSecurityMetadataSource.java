package com.oa.handler;

import com.oa.entity.Permission;
import com.oa.entity.Role;
import com.oa.service.IPermissionService;
import com.oa.service.IUserService;
import org.mybatis.logging.Logger;
import org.mybatis.logging.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;

import java.util.Collection;
import java.util.List;

/**
 * @description:    FilterInvocationSecurityMetadataSource（权限资源过滤器接口）继承了 SecurityMetadataSource（权限资源接口）
 * Spring Security是通过SecurityMetadataSource来加载访问时所需要的具体权限；Metadata是元数据的意思。
 * 自定义权限资源过滤器，实现动态的权限验证
 * 它的主要责任就是当访问一个url时，返回这个url所需要的访问权限
 * @author: MagicXianyu
 * @date: 2020-06-16 14:47
 */
@Component
public class UserFilterInvocationSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {

    public UserFilterInvocationSecurityMetadataSource(){
        System.out.println("UserFilterInvocationSecurityMetadataSource  >>>  Loding......");
    }

    @Autowired
    IPermissionService permissionService;

    private AntPathMatcher antPathMatcher = new AntPathMatcher();

//    private static final Logger log = LoggerFactory.getLogger(MyFilterInvocationSecurityMetadataSource.class);

    /**
     * 每个资源访问时都会经过此方法,进行判定此资源是否需要所需的权限才能够访问
     * @param o
     * @return
     * @throws IllegalArgumentException
     */
    @Override
    public Collection<ConfigAttribute> getAttributes(Object o) throws IllegalArgumentException {
        String requestUrl = ((FilterInvocation) o).getRequestUrl();
        //去数据库查询资源
        List<Permission> list = permissionService.findAllPermission();
//        System.out.println("当前访问的路径 >>> "+ requestUrl);
//        System.out.println("/js/ok == "+requestUrl+"   >>>   "+(antPathMatcher.match("/js/ok",requestUrl)));
        for (Permission permission : list) {
            if(permission.getUrl().trim().length()!=0){
                Permission parent = permissionService.findPermissionByParentId((int)permission.getParentId());
                String url = parent.getMenuUrl()+"/"+permission.getUrl()+"**";
//                System.out.println("url  ::  "+url);
                if( antPathMatcher.match(url,requestUrl) && permission.getRoles().size() > 0 ){
                    List<Role> roles = permission.getRoles();
//                    System.out.println(roles);
                    int size = roles.size();
                    String[] values = new String[size];
                    for (int i = 0; i < size; i++) {
                        values[i] = roles.get(i).getName();
                    }
//                    System.out.print("当前访问路径是"+requestUrl+",这个url所需要的访问权限是{ ");
//                    for (String value : values) {
//                        System.out.print(value+" ");
//                    }
//                    System.out.println("}");
                    return SecurityConfig.createList(values);
                }
            }
        }
        /**
         * @Description: 如果本方法返回null的话，意味着当前这个请求不需要任何角色就能访问
         * 此处做逻辑控制，如果没有匹配上的，返回一个默认具体权限，防止漏缺资源配置
         **/
//        System.out.println("当前访问路径是{"+requestUrl+"},这个url所需要的访问权限是{ROLE_LOGIN}");
        return SecurityConfig.createList("ROLE_LOGIN");
    }


    /**
     * @Description: 此处方法如果做了实现，返回了定义的权限资源列表，
     * Spring Security会在启动时校验每个ConfigAttribute是否配置正确，
     * 如果不需要校验，这里实现方法，方法体直接返回null即可。
     * @return
     */
    @Override
    public Collection<ConfigAttribute> getAllConfigAttributes() {
        return null;
    }

    /**
     * @Description: 方法返回类对象是否支持校验，
     * web项目一般使用FilterInvocation来判断，或者直接返回true
     * @param clazz
     * @return
     */
    @Override
    public boolean supports(Class<?> clazz) {
        return FilterInvocation.class.isAssignableFrom(clazz);
    }
}
