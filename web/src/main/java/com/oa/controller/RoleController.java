package com.oa.controller;

import com.oa.entity.*;
import com.oa.service.IPermissionService;
import com.oa.service.IRolePermissionService;
import com.oa.service.IRoleService;
import com.oa.vo.PageUtil;
import com.oa.vo.TreeNode;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-10 21:28
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    IRoleService roleService;
    @Autowired
    IPermissionService permissionService;
    @Autowired
    IRolePermissionService rolePermissionService;

    @RequestMapping("/findAll")
    public @ResponseBody
    PageUtil findAll(@Param("name") String name,
                     PageUtil<Role> usersPage) {
        List<Role> list = null;
        if(name!=null) {
            list = roleService.findRoleByRname(name);
        }else{
            list = roleService.findAllRole();
        }
        usersPage.setData(list);

        int count = list.size();//数据总数量
        usersPage.setCount((long)count);
        usersPage.setMsg("查询成功");
        return usersPage;
    }


    @RequestMapping("/add")
    public @ResponseBody PageUtil add(@RequestParam("name") String name,
                                      @RequestParam("statement") String statement,
                                      @RequestParam("permissionIds") String permissionIds,
                                      @RequestParam("createUserName") String createUserName,
                                      PageUtil usersPage){

        String id = UUID.randomUUID().toString().replace("-", "");
        Role role = new Role();
        role.setId(id);
        role.setName(name);
        role.setStatement(statement);
        role.setCreateUserName(createUserName);
        if(role.getCreateUserName()==null) {
            role.setCreateUserName("未知");
        }
        int i = roleService.addRole(role);
        String[] pids = permissionIds.split(",");
        for (String pid : pids) {//添加权限
            int pid_temp = Integer.parseInt(pid);
            //TODO 需小改
            int ii = rolePermissionService.addRolePermission(role.getId(), pid_temp);
        }

        if(i == 1){
            usersPage.setCode(0);
        }else{
            usersPage.setCode(1);
            usersPage.setMsg("添加失败!");
        }
        return usersPage;
    }

    @RequestMapping("/batchDel")
    public @ResponseBody PageUtil delete(String idsStr,PageUtil usersPage){
        String[] stringTemp = idsStr.split(",");
        int i = roleService.deleteRole(stringTemp);
        if(i==0){
            usersPage.setCode(1);
            usersPage.setMsg("修改失败，请联系管理员处理");
        }else{
            usersPage.setCode(0);
        }
        return usersPage;
    }

    @RequestMapping("/update")
    public @ResponseBody PageUtil update(@RequestParam("id") String id,
                                         @RequestParam("name") String name,
                                         @RequestParam("statement") String statement,
                                         PageUtil<Role> pageUtil,
                                         @RequestParam("permissionIds") String permissionIds){
        Role role = new Role();
        role.setId(id);
        role.setName(name);
        role.setStatement(statement);

        //更新角色信息
        roleService.updateRole(role);


        //更新角色权限
        int i = rolePermissionService.deleteAllByRid(role.getId());//直接删除角色权限关系表中的所有关于此角色的数据
        String[] pids = permissionIds.split(",");
        for (String pid : pids) {//重新添加权限
            int pid_temp = Integer.parseInt(pid);
            int ii = rolePermissionService.addRolePermission(role.getId(), pid_temp);
        }
        return pageUtil;
    }


    /**
     * 获取权限节点树,并判断是否被选中
     * @param usersPage
     * @param rid
     * @return
     */
    @RequestMapping("/findTree")
    public @ResponseBody PageUtil findPermissionTree(PageUtil<TreeNode> usersPage,String rid){
        List<Permission> list = permissionService.findAllPermission();
        List<TreeNode> treeNodeList = new ArrayList<>();

        List<RolePermission> rolePermissionByRidList = null;
        if(rid!=null||rid.trim().length()!=0) {
           rolePermissionByRidList = rolePermissionService.findRolePermissionByRid(rid);
        }

        //init节点VO
        for (Permission permission : list) {
            TreeNode treeNode = new TreeNode();
            treeNode.setId((int)permission.getId());
            treeNode.setName(permission.getName());
            treeNode.setParentId((int)permission.getParentId());
            //判断此节点是否是父节点
            for (Permission permission1 : list) {
                if(permission.getId()==permission1.getParentId()) {
                    treeNode.setIsParent(true);
                    break;
                }
            }
            if(rolePermissionByRidList!=null) {
                //判断此节点是否被选中
                for (RolePermission rolePermission : rolePermissionByRidList) {
                    if (permission.getId() == rolePermission.getPermissionId() && rolePermission.getRoleId().equals(rid)) {
                        treeNode.setChecked(true);
                    }
                }
            }
            treeNodeList.add(treeNode);
        }
        usersPage.setData(treeNodeList);
        return usersPage;
    }
}
