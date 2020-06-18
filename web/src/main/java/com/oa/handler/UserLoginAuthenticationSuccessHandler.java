package com.oa.handler;

import com.google.gson.Gson;
import com.oa.entity.Users;
import com.oa.service.IUserService;
import com.oa.service.impl.UserServiceImpl;
import com.oa.vo.JsonData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.sql.Timestamp;

/**
 * Created by linziyu on 2019/2/9.
 *
 * 用户验证成功处理类
 */

@Component
public class UserLoginAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    @Autowired
    IUserService userService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        Users user = (Users)authentication.getPrincipal();

        //获取登录用户的IP
//        WebAuthenticationDetails details = (WebAuthenticationDetails)authentication.getDetails();

        user.setLoginSum(user.getLoginSum()+1);
        user.setLoginTime(new Timestamp(new Date().getTime()));
        int i = userService.updateLoginUserById(user);
        System.out.println(i==1?"用户信息已更新":"用户信息更新失败");
        JsonData jsonData = new JsonData(200,"登录成功");
        String json = new Gson().toJson(jsonData);
//        log.info("{}","handle_success");
        response.setContentType("application/json;charset=utf-8");
        PrintWriter out = response.getWriter();

        out.write(json);
        out.flush();
        out.close();
    }
}
