package com.oa.dao;

import com.oa.entity.Role;
import com.oa.entity.Users;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-08 16:35
 */
@Mapper
public interface IRoleDao {

    @Select("select * from role where id in (select roleId from user_role where userId = #{uid})")
    @Results(value = {
            @Result(id = true,column = "id",property = "id"),
            @Result(column = "name",property = "name"),
            @Result(column = "statement",property = "statement"),
            @Result(column = "createUserName",property = "createUserName"),
            @Result(column = "createTime",property = "createTime")
    },id = "roleMapper")
    List<Role> findRoleByUid(@Param("uid") String uid);

    @Select("select * from role where id in (select roleId from role_permission where permissionId = #{pid})")
    @ResultMap("roleMapper")
    List<Role> findRoleByPid(@Param("pid") Integer pid);

    @Select("select * from role")
    @ResultMap("roleMapper")
    List<Role> findAllRole();

    @Select("select * from role where name like '%${name}%'")
    List<Role> findRoleByRname(@Param("name") String name);

    @Insert("insert into role (id,name,statement,createUserName,createTime) values (#{id},#{name},#{statement},#{createUserName},GETDATE())")
    int addRole(Role role);

    @Delete("delete from role where id = #{rid} and id != '6769f5342e4844d4929971f9b7b7971a'")
    int deleteRole(@Param("rid") String rid);

    @Update("update role set name = #{name},statement = #{statement} where id = #{id}")
    int updateRole(Role role);
}
