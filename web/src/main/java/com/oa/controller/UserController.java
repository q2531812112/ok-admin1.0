package com.oa.controller;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oa.vo.PageUtil;
import com.oa.entity.Users;
import com.oa.service.IUserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-08 9:52
 */
@Controller
@RequestMapping("/user")
public class UserController {


    @Autowired
    IUserService userService;


    /**
     * 查询所有用户，如果传入了用户名字则跟据查询用户
     * @param username
     * @throws IOException
     */
    @RequestMapping("/findAll")
    public @ResponseBody PageUtil findAll(@Param("username") String username,
                                          @Param("limit") int limit,
                                          @Param("page") int page) {
        PageUtil<Users> usersPage = new PageUtil<>();
        List<Users> list = null;
        if(username!=null) {
            list = userService.findUserLikeAccountName(username);
        }else{
            list = userService.findAllUser();
        }
        usersPage.setData(list);
        int count = list.size();//数据总数量
        usersPage.setCount((long)count);
        usersPage.setMsg("查询成功");
        return usersPage;
    }

    /**
     * 添加一个用户
     * @param user
     * @param roleId
     * @return
     * @throws JsonProcessingException
     */
    @RequestMapping("/add")
    public @ResponseBody PageUtil addUser(Users user, String roleId){
        PageUtil<Users> usersPage = new PageUtil<>();
        String id = UUID.randomUUID().toString().replace("-", "");
        user.setId(id);
        user.setStatus(user.getStatus()==0?1:0);
        //将javaUtils中的Date转换为数据库的Date
//        Timestamp date = new Timestamp(new java.util.Date().getTime());
//        user.setCreateTime(date);
//        System.out.println(user.getId()+"   "+roleId);
        int i = userService.saveUser(user,roleId);
        if(i == 1){
            usersPage.setCode(0);
        }else if(i == 0){
            usersPage.setCode(1);
            usersPage.setMsg("添加失败!可能邮箱或用户名已被注册");
        }
        return usersPage;
    }


    @RequestMapping("/batchNormal")
    public @ResponseBody PageUtil batchNormal(String idsStr) {
        PageUtil<Users> usersPage = new PageUtil<>();
        String[] stringTemp = idsStr.split(",");
        int i = userService.StartUserStatusByUid(stringTemp);
        if(i==0){
            System.out.println("启用失败");
            usersPage.setCode(1);
            usersPage.setMsg("批量启用失败，请联系管理员");
        }else {
            System.out.println("启用成功");
            usersPage.setCode(0);
        }
        return usersPage;
    }

    @RequestMapping("/batchStop")
    public @ResponseBody PageUtil batchStop(String idsStr) {
        PageUtil<Users> usersPage = new PageUtil<>();
        String[] stringTemp = idsStr.split(",");
        int i = userService.StopUserStatusByUid(stringTemp);
        if(i==0){
            System.out.println("停用失败");
            usersPage.setCode(1);
            usersPage.setMsg("批量停用失败，请联系管理员");
        }else {
            System.out.println("停用成功");
            usersPage.setCode(0);
        }
        return usersPage;
    }

    @RequestMapping("/batchDel")
    public @ResponseBody PageUtil batchDel(String idsStr)  {
        PageUtil<Users> usersPage = new PageUtil<>();
        String[] stringTemp = idsStr.split(",");
        int i = userService.DelUserByUid(stringTemp);
        if(i==0){
            System.out.println("删除失败");
            usersPage.setCode(1);
            usersPage.setMsg("批量删除失败，请联系管理员处理");
        }else {
            System.out.println("删除成功");
            usersPage.setCode(0);
        }
        return usersPage;
    }

    @RequestMapping("/update")
    public @ResponseBody PageUtil update(Users user,String roleId){
        PageUtil<Users> usersPage = new PageUtil<>();
        int i = userService.updateUserById(user,roleId);
        if(i==0){
            usersPage.setCode(1);
            usersPage.setMsg("修改失败，请联系管理员处理");
        }else{
            usersPage.setCode(0);
        }
        return usersPage;
    }

    @RequestMapping("/delete")
    public @ResponseBody PageUtil delete(String id){
        PageUtil<Users> usersPage = new PageUtil<>();
        System.out.println(id);

        return usersPage;
    }


    @RequestMapping("/myUserUpdate")
    public @ResponseBody PageUtil myUserUpdate(Users user,PageUtil pageUtil, HttpServletRequest request){
        if(user.getPortrait().length()==0||user.getPortrait()==null) {
            user.setPortrait(null);
        }
        System.out.println(user.toString());
        int i = userService.updateMyUserById(user);
        if(i==1){
            pageUtil.setCode(0);
        }else{
            pageUtil.setCode(1);
            pageUtil.setMsg("编辑失败");
        }
        return pageUtil;
    }

    @RequestMapping("/myUser")
    public @ResponseBody PageUtil myUser(@RequestParam("uid") String id) {
        PageUtil<Users> pageUtil = new PageUtil<>();
        Users user = userService.findUserById(id);
        if(user!=null){
            List<Users> userList = new ArrayList<>();
            userList.add(user);
            pageUtil.setData(userList);
            pageUtil.setCode(0);
        }else{
            pageUtil.setCode(1);
            pageUtil.setMsg("没有找到用户");
        }
        return pageUtil;
    }

    @RequestMapping("/myUpdatePassword")
    public @ResponseBody PageUtil myUpdatePassword(PageUtil pageUtil,
                                                   @RequestParam("currentPassword") String currentPassword,
                                                   @RequestParam("password")String password,
                                                   @RequestParam("id") String id){
        int i = userService.updatePasswordById(currentPassword, password, id);
        switch (i){
            case 1:
                pageUtil.setCode(0);
                break;

            case 2:
                pageUtil.setCode(1);
                pageUtil.setMsg("原来的密码不一致!");
                break;

            default:
                pageUtil.setCode(1);
                pageUtil.setMsg("出现未知错误，请联系管理员");
        }
        return pageUtil;
    }

}
