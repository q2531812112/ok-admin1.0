package com.oa.service.impl;

import com.oa.dao.IRolePermissionDao;
import com.oa.entity.RolePermission;
import com.oa.service.IRolePermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-13 11:49
 */
@Service
@Transactional
public class RolePermissionServiceImpl implements IRolePermissionService {
    @Autowired
    IRolePermissionDao rolePermissionDao;
    public List<RolePermission> findAllRolePermission() {
        return rolePermissionDao.findAllRolePermission();
    }

    public List<RolePermission> findRolePermissionByRid(String rid) {
        return rolePermissionDao.findRolePermissionByRid(rid);
    }

    public List<RolePermission> findRolePermisssionByPid(Integer pid) {
        return rolePermissionDao.findRolePermisssionByPid(pid);
    }

    public int addRolePermission(String rid, Integer pid) {
        return rolePermissionDao.addRolePermission(rid, pid);
    }

    public int deleteAllByRid(String rid) {
        return rolePermissionDao.deleteAllByRid(rid);
    }

    public int deleteById(Integer id) {
        return rolePermissionDao.deleteById(id);
    }
}
