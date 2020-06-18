package com.oa.controller;

import com.oa.vo.PageUtil;
import com.oa.entity.Permission;
import com.oa.entity.RolePermission;
import com.oa.service.IPermissionService;
import com.oa.service.IRolePermissionService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.*;
import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-12 8:41
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    IPermissionService permissionService;
    @Autowired
    IRolePermissionService rolePermissionService;

    @RequestMapping("/findAll")
    public @ResponseBody PageUtil findAll(PageUtil<Permission> pageUtil) throws IOException {
        List<Permission> allPermission = permissionService.findAllPermission();
        pageUtil.setData(allPermission);
        pageUtil.setCode(0);
        pageUtil.setMsg("");
        pageUtil.setCount((long)allPermission.size());
        return pageUtil;
    }

    @RequestMapping("/add")
    public @ResponseBody PageUtil add(PageUtil<Permission> pageUtil,Permission permission,@Param("location") String location){
        if(permission.getType()==-1||permission.getType()==0){
            permission.setMenuUrl(location);
        }else{
            permission.setUrl(location);
        }
        int i = permissionService.addPermission(permission);

        if(i==1) {
            pageUtil.setCode(0);
        } else{
            pageUtil.setCode(1);
        }
        return pageUtil;
    }

    @RequestMapping("/update")
    public @ResponseBody PageUtil update(PageUtil<Permission> pageUtil,Permission permission,@Param("location") String location){

        if(permission.getType()==-1||permission.getType()==0){
            permission.setMenuUrl(location);
        }else{
            permission.setUrl(location);
        }
        System.out.println(permission.toString());
        int i = permissionService.updatePermission(permission);
        if(i==1){
            pageUtil.setCode(0);
        }else{
            pageUtil.setCode(1);
            pageUtil.setMsg("更新出错,请联系管理员 ");
        }

        return pageUtil;
    }

    @RequestMapping("/delete")
    public @ResponseBody PageUtil delete(PageUtil<Permission> pageUtil,@RequestParam("id") Integer pid){
        List<RolePermission> rolePermisssionList = rolePermissionService.findRolePermisssionByPid(pid);
        System.out.println(pid);
        //删除之前先把角色权限对应关系表中所有的有关此权限的角色对应关系的数据删除
        for (RolePermission rolePermission:rolePermisssionList) {
            rolePermissionService.deleteById((int) rolePermission.getId());
        }
        //删除权限
        int i = permissionService.deletePermission(pid);
        if(i==1){
            pageUtil.setCode(0);
        }else{
            pageUtil.setCode(1);
            pageUtil.setMsg("删除失败，数据出错，请联系管理员");
        }
        return pageUtil;
    }

    /**
     * 判断是否存在此父Id
     * @param pageUtil
     * @param permission
     * @return
     */
    @RequestMapping("/isExistParent")
    public @ResponseBody PageUtil isExistParent(PageUtil pageUtil,Permission permission){
        int pid = (int)permission.getParentId();
        List<Permission> list = permissionService.findAllPermission();
        pageUtil.setCode(1);
        pageUtil.setMsg("不存在此父ID，请检视ID是否填写正确");
        if(pid==0) {
            pageUtil.setCode(0);
            return pageUtil;
        }
        for (Permission permission1 : list) {
            if (permission1.getId() == pid) {
                pageUtil.setCode(0);
                break;
            }
        }
        return pageUtil;
    }

}
