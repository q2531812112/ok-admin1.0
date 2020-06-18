package com.oa.dao;

import com.oa.entity.UserRole;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-10 11:33
 */
@Mapper
public interface IUserRoleDao {
    @Select("select * from user_role")
    List<UserRole> findAllUserRole();

    @Delete("delete from user_role where userId = #{uid} ")
    int delUserRoleByUid(String uid);

    @Insert("insert into user_role (roleId,userId) values (#{roleId},#{userId})")
    int addUserRole(UserRole userRole);

    @Update("update user_role set roleId = #{rid} where userId = #{uid}")
    int updateUserRoleByUid(@Param("uid") String uid,@Param("rid") String rid);
}
