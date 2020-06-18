package com.oa.config;

import com.alibaba.fastjson.support.config.FastJsonConfig;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.nio.charset.Charset;
import java.util.List;

/**
 * 1、@Configuration ：声明配置类
 * 2、@ComponentScan ：开启包扫描
 * 3、@EnableWebMvc  ：开启处理器映射器、映射器解析器
 * @description:配置MVC文件
 * @author: MagicXianyu
 * @date: 2020-06-15 12:33
 */
@Configuration  //声明配置类
@ComponentScan(basePackages = {"com.oa","com.oa.handler"},
        useDefaultFilters = false,
        includeFilters = {
                @ComponentScan.Filter(
                        type = FilterType.ANNOTATION,
                        classes = Controller.class),
                @ComponentScan.Filter(
                        type = FilterType.ANNOTATION,
                        classes = Configuration.class)
        }) //扫描包
//@EnableWebMvc   //启用SpringMVC相关注解和默认配置    WebMvcConfigurationSupport不需配置
public class SpringMvcConfig extends WebMvcConfigurationSupport {

    public SpringMvcConfig(){
        System.out.println("SpringMVC >>> loding......");
    }

    //把根目录下的静态资源放开，不过访问静态资源时，请求路径前要加上“/xx/”
    @Override
    protected void addResourceHandlers(ResourceHandlerRegistry registry) {
        System.out.println("addResourceHandlers(资源拦截过滤)  >>>  Loding......");
//        registry.addResourceHandler("/x/js/**").addResourceLocations("classpath:/js/");
//        registry.addResourceHandler("/x/css/**").addResourceLocations("classpath:/css/");
//        registry.addResourceHandler("/x/data/**").addResourceLocations("classpath:/data/");
//        registry.addResourceHandler("/x/font/**").addResourceLocations("classpath:/font/");
//        registry.addResourceHandler("/x/imgs/**").addResourceLocations("classpath:/imgs/");
//        registry.addResourceHandler("/x/lib/**").addResourceLocations("classpath:/lib/");

    }

    //给访问jsp的请求加上前缀（“/”） 和后缀 (".jsp")
    @Override
    protected void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/pages/",".jsp");
    }

    //这里表示，访问/hello3路径后，进入名为hello的视图去
    @Override
    protected void addViewControllers(ViewControllerRegistry registry) {
//        registry.addViewController("/hello3").setViewName("hello");
    }


    //加了fastjson的依赖后，这里配置引用fastjson，以及设置编码
    @Override
    protected void configureMessageConverters(List<HttpMessageConverter<?>> converters) {

        FastJsonHttpMessageConverter converter = new FastJsonHttpMessageConverter();
        converter.setDefaultCharset(Charset.forName("UTF-8"));

        FastJsonConfig config = new FastJsonConfig();
        config.setCharset(Charset.forName("UTF-8"));

        converter.setFastJsonConfig(config);

        converters.add(converter);
    }



}
