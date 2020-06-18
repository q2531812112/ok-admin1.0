package com.oa.dao;

import com.oa.entity.Permission;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-12 8:10
 */

@Mapper
public interface IPermissionDao {
    @Select("select * from permission")
    @Results({
            @Result(id = true,column = "id",property = "id"),
            @Result(column = "name",property = "name"),
            @Result(column = "menuUrl",property = "menuUrl"),
            @Result(column = "url",property = "url"),
            @Result(column = "type",property = "type"),
            @Result(column = "parentId",property = "parentId"),
            @Result(column = "createTime",property = "createTime"),
            @Result(column = "id",property = "roles",many = @Many(select = "com.oa.dao.IRoleDao.findRoleByPid",fetchType = FetchType.LAZY))
    })
    List<Permission> findAllPermission();

    @Select("select * from permission where id = #{parentId}")
    Permission findPermissionByParentId(@Param("parentId") Integer parentId);

    @Insert("insert into permission (name,menuUrl,url,type,parentId,createTime) values (#{name},#{menuUrl},#{url},#{type},#{parentId},GETDATE())")
    int addPermission(Permission permission);

    @Update("update permission set name = #{name},menuUrl = #{menuUrl},url = #{url},type = #{type},parentId = #{parentId} where id = #{id}")
    int updatePermission(Permission permission);

    @Delete("delete from permission where id = #{pid}")
    int deletePermission(@Param("pid") int pid);

    @Select("select @@IDENTITY")
    int getIDENTITY();
}
