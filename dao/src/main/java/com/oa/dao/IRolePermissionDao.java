package com.oa.dao;

import com.oa.entity.RolePermission;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-13 11:44
 */
@Mapper
public interface IRolePermissionDao {
    @Select("select * from role_permission")
    List<RolePermission> findAllRolePermission();

    @Select("select * from role_permission where roleId = #{rid}")
    List<RolePermission> findRolePermissionByRid(@Param("rid") String rid);

    @Select("select * from role_permission where permissionId = #{pid}")
    List<RolePermission> findRolePermisssionByPid(@Param("pid") Integer pid);

    @Insert("insert into role_permission (roleId,permissionId) values (#{rid},#{pid})")
    int addRolePermission(@Param("rid") String rid,@Param("pid") Integer pid);

    @Delete("delete from role_permission where roleId = #{rid}")
    int deleteAllByRid(@Param("rid") String rid);

    @Delete("delete from role_permission where id = #{id}")
    int deleteById(@Param("id")Integer id);
}
