package com.oa.service.impl;

import com.oa.dao.IPermissionDao;
import com.oa.dao.IRolePermissionDao;
import com.oa.entity.Permission;
import com.oa.service.IPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-12 8:17
 */
@Service
public class PermissionServiceImpl implements IPermissionService {

    @Autowired
    IPermissionDao permissionDao;

    @Autowired
    IRolePermissionDao rolePermissionDao;


    public List<Permission> findAllPermission() {
        return permissionDao.findAllPermission();
    }

    public Permission findPermissionByParentId(Integer parentId) {
        return permissionDao.findPermissionByParentId(parentId);
    }

    /**
     * 每次添加权限时，WEB_MANAGER角色都会拥有此权限的访问权，而其他的角色都需要WEB_MANAGER授权才可以访问
     * @param permission
     * @return
     */
    public int addPermission(Permission permission) {
        int i = permissionDao.addPermission(permission);
        int identity = permissionDao.getIDENTITY();
        int ii = rolePermissionDao.addRolePermission("6769f5342e4844d4929971f9b7b7971a", identity);
        return i==1&&ii==1?1:0;
    }

    public int updatePermission(Permission permission) {
        return permissionDao.updatePermission(permission);
    }

    public int deletePermission(Integer pid) {
        return permissionDao.deletePermission(pid);
    }


}
