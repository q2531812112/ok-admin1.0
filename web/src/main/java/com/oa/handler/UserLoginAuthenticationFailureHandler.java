package com.oa.handler;

import com.google.gson.Gson;
import com.oa.vo.JsonData;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by linziyu on 2019/2/9.
 *
 * 用户验证失败处理类
 */

@Component
public class UserLoginAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {



    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        System.out.println("exception   >>>   "+exception.getMessage());
        JsonData jsonData = null;
        if(exception.getMessage().equals("Bad credentials")){
            jsonData = new JsonData(401,"密码错误");
        }else{
             jsonData = new JsonData(401,exception.getMessage());
        }
        String json = new Gson().toJson(jsonData);
        response.setContentType("application/json;charset=utf-8");
        PrintWriter out = response.getWriter();

        out.write(json);
        out.flush();
        out.close();



    }
}
