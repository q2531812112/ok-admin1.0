package com.oa.service;

import com.oa.entity.RolePermission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-13 11:48
 */
public interface IRolePermissionService {
    List<RolePermission> findAllRolePermission();
    List<RolePermission> findRolePermissionByRid(String rid);
    List<RolePermission> findRolePermisssionByPid(Integer pid);
    int addRolePermission(String rid,Integer pid);
    int deleteAllByRid(String rid);
    int deleteById(Integer id);
}
