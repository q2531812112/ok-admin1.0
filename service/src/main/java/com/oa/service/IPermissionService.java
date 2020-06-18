package com.oa.service;

import com.oa.entity.Permission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-12 8:16
 */

public interface IPermissionService {
    List<Permission> findAllPermission();
    Permission findPermissionByParentId(Integer parentId);
    int addPermission(Permission permission);
    int updatePermission(Permission permission);
    int deletePermission(Integer pid);

}
