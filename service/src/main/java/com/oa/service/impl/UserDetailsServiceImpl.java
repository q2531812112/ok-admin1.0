package com.oa.service.impl;

import com.oa.entity.Users;
import com.oa.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-16 8:10
 */
@Component
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    IUserService userService;

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Users user = userService.findUserByAccountName(username);
        if(user==null){
            throw new UsernameNotFoundException("没有找到用户");
        }else{
            if (user.getStatus()==0){
                throw new UsernameNotFoundException("用户已被关闭");
            }
        }
        return user;
    }
}
