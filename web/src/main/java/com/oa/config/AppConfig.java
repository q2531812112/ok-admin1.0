package com.oa.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.filter.HttpPutFormContentFilter;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.*;
import javax.servlet.annotation.HandlesTypes;
import java.util.EnumSet;

/**
 *  1、ServletContext：web容器全局上下文对象 ，它由web容器负责初始化，为后面的spring容器提供宿主环境。
 *    addServlet：注册servlet，通过对应类的构造传入初始化参数
 *    addListener：注册监听器，通过对应类的构造传入初始化参数
 *    addFilter：注册过滤器，通过对应类的构造传入初始化参数、
 *    addMapping：添加匹配路径
 * 2、AnnotationConfigWebApplicationContext ：该类为spring框架提供的配置文件注册类
 *     用于加载配置文件存储到web容器中的map集合中,以便初始化servlet、listener等web组件类时使用
 *     register方法：用于注册配置类
 *
 *   继承AbstractAnnotationConfigDispatcherServletInitializer :: 用于加载DispatcherServlet
 *   实现WebApplicationInitializer :: 相当于web.xml
 *
 * @author: MagicXianyu
 * @date: 2020-06-15 12:57
 */

@Configuration
public class AppConfig implements WebApplicationInitializer {       // extends AbstractAnnotationConfigDispatcherServletInitializer
    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {

        /***************************注册SPRINGMVC***************************/
        //1.1创建AnnotationConfigWebApplicationContext
        AnnotationConfigWebApplicationContext mvcContext = new AnnotationConfigWebApplicationContext();
        //1.2springMVC的注册配置类
        mvcContext.register(SpringMvcConfig.class);
        //1.3创建mvc核心控制器,并将注册的springMVC配置类传入
        ServletRegistration.Dynamic dispatcherServlet = servletContext.addServlet("DispatcherServlet",
                new DispatcherServlet(mvcContext));
        //1.4为核心控制器配置拦截路径
        dispatcherServlet.addMapping("*.do");
        //给springmvc添加启动时机
        dispatcherServlet.setLoadOnStartup(1);


        /****************************注册SPRINGAPPLICATIONCONTEXT**************************/
        //2.1创建AnnotationConfigWebApplicationContext
        AnnotationConfigWebApplicationContext springContext = new AnnotationConfigWebApplicationContext();
        //2.2spring的配置类
        springContext.register(ApplicationContext.class);
        //2.3创建初始化spring容器的监听器,并将注册的spring配置类传入
        servletContext.addListener(new ContextLoaderListener(springContext));


        /***************************注册字符编码过滤器***************************/
        //3.1注册解决乱码过滤器,设置字符集utf-8
        FilterRegistration.Dynamic encodingFilter = servletContext.addFilter("characterFilter",new CharacterEncodingFilter("utf-8"));
        //3.2添加拦截的类型
        EnumSet<DispatcherType> enumSet = EnumSet.noneOf(DispatcherType.class);
        enumSet.add(DispatcherType.REQUEST);
        enumSet.add(DispatcherType.FORWARD);
        //3.3添加拦截路径
        encodingFilter.addMappingForUrlPatterns(enumSet, true,"/*");

        /***************************注册PUT提交方式***************************/
        FilterRegistration.Dynamic httpPutFormContentFilter = servletContext.addFilter("httpPutFormContentFilter",new HttpPutFormContentFilter());
        httpPutFormContentFilter.addMappingForUrlPatterns(enumSet,true,"/*");


    }
}
