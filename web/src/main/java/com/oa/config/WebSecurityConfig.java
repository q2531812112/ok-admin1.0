package com.oa.config;

import com.oa.entity.Users;
import com.oa.handler.*;
import com.oa.service.impl.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.ObjectPostProcessor;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @description:    Spirng Security 核心配置类
 * @author: MagicXianyu
 * @date: 2020-06-15 19:14
 */


@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{


    private final static BCryptPasswordEncoder ENCODER = new BCryptPasswordEncoder();
    @Bean
    public PasswordEncoder passwordEncoder(){
        return new PasswordEncoder() {
            @Override
            public String encode(CharSequence charSequence) {
                return ENCODER.encode(charSequence);
            }

            @Override
            public boolean matches(CharSequence charSequence, String s) {
                return ENCODER.matches(charSequence,s);
            }
        };
    }

    @Bean
    public UserDetailsServiceImpl myUserDetailService(){
        return new UserDetailsServiceImpl();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setHideUserNotFoundExceptions(false);
        provider.setUserDetailsService(myUserDetailService());
        provider.setPasswordEncoder(passwordEncoder());

        return provider;
    }



    @Autowired
    private UserLoginAuthenticationFailureHandler userLoginAuthenticationFailureHandler; //登录失败处理器

    @Autowired
    private UserLoginAuthenticationSuccessHandler userLoginAuthenticationSuccessHandler; //登陆成功处理器

    @Autowired
    private UserLogoutSuccessHandler userLogoutSuccessHandler;  //退出登录处理器



    @Autowired
    private UserAuthenticationAccessDeniedHandler userAuthenticationAccessDeniedHandler;//自定义错误（403）返回数据

    @Autowired
    private UserFilterInvocationSecurityMetadataSource filterMetadataSource; //权限过滤器（当前url所需要的访问权限）

    @Autowired
    private UserAccessDecisionManager myAccessDecisionManager;//权限决策器

    /**
     * 放行的资源
     * @param web
     * @throws Exception
     */
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/pages/other/**","/css/**","/font/**","/data/**","/imgs/**","/js/**","/lib/**","/pages/other/**");
    }


    /**
     * HttpSecurity包含了原数据（主要是url）
     * 通过withObjectPostProcessor将MyFilterInvocationSecurityMetadataSource和MyAccessDecisionManager注入进来
     * 此url先被MyFilterInvocationSecurityMetadataSource处理，然后 丢给 MyAccessDecisionManager处理
     * 如果不匹配，返回 MyAccessDeniedHandler
     * @param http
     * @throws Exception
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        System.out.println("configure  >>>  Loding......");
//        http
//                .authorizeRequests()
//                    //静态资源等不需要验证
//                    .antMatchers("/css/**").permitAll()
//                    .antMatchers("/data/**").permitAll()
//                    .antMatchers("/font/**").permitAll()
//                    .antMatchers("/imgs/**").permitAll()
//                    .antMatchers("/js/**").permitAll()
//                    .antMatchers("/lib/**").permitAll()
//                    .antMatchers("/pages/other/**").permitAll()
//                    .anyRequest().authenticated()
//                .and()
//                    .headers()
//                    .frameOptions()
//                    .sameOrigin()
//                .and()
//                    .logout()
//                    .logoutUrl("/logout.do")
//                    .logoutSuccessHandler(userLogoutSuccessHandler)//登出处理
//                    .permitAll()
//                .and()
//                    .authorizeRequests()
//                    .withObjectPostProcessor(new ObjectPostProcessor<FilterSecurityInterceptor>() {
//                        @Override
//                        public <O extends FilterSecurityInterceptor> O postProcess(O object) {
//                            object.setSecurityMetadataSource(filterMetadataSource);
//                            object.setAccessDecisionManager(myAccessDecisionManager);
//                            return object;
//                        }
//                    })
//                .and()
//                    .csrf().disable()
//                    .exceptionHandling().accessDeniedHandler(userAuthenticationAccessDeniedHandler);//无权限的处理
//                ;

        http.authorizeRequests()
                .withObjectPostProcessor(new ObjectPostProcessor<FilterSecurityInterceptor>() {
                        @Override
                        public <O extends FilterSecurityInterceptor> O postProcess(O object) {
                            object.setSecurityMetadataSource(filterMetadataSource);
                            object.setAccessDecisionManager(myAccessDecisionManager);
                            return object;
                        }
                    })
                .and()
                    .formLogin().loginPage("/pages/other/login.jsp").loginProcessingUrl("/login.do")
                    .usernameParameter("username").passwordParameter("password")
                    .failureHandler(userLoginAuthenticationFailureHandler)
                    .successHandler(userLoginAuthenticationSuccessHandler)
                    .permitAll()
                .and()
                    .logout()
                    .logoutUrl("/logout.do")
                    .logoutSuccessHandler(userLogoutSuccessHandler)
                    .permitAll()
                .and()
                    .headers()
                    .frameOptions()
                    .sameOrigin()
                .and()
                    .csrf().disable()
                    .exceptionHandling().accessDeniedHandler(userAuthenticationAccessDeniedHandler);

    }


}
