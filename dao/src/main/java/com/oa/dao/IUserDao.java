package com.oa.dao;

import com.oa.entity.Users;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-08 8:55
 */
@Mapper
public interface IUserDao {
    @Select("select * from users where id != '30b1aa68367042f0ae593903e933f608'")
    @Results(value = {
            @Result(id = true, column = "id", property = "id")
            , @Result(column = "accountName", property = "accountName")
            , @Result(column = "accountPassword", property = "accountPassword")
            , @Result(column = "name", property = "name")
            , @Result(column = "sex", property = "sex")
            , @Result(column = "status", property = "status")
            , @Result(column = "email", property = "email")
            , @Result(column = "loginSum", property = "loginSum")
            , @Result(column = "createTime", property = "createTime")
            , @Result(column = "loginTime", property = "loginTime")
            , @Result(column = "birthday", property = "birthday")
            , @Result(column = "statement",property = "statement")
            , @Result(column = "portrait",property = "portrait")
            , @Result(
                column = "id",property = "roles",many = @Many(select = "com.oa.dao.IRoleDao.findRoleByUid",fetchType = FetchType.LAZY)
            )
    },id = "usersMapper")
    List<Users> findAllUser();

    @Select("select * from users where accountName like '%${accname}%' and id != '30b1aa68367042f0ae593903e933f608' ")
    @ResultMap("usersMapper")
    List<Users> findUserLikeAccountName(String accname);

    @Select("select * from users where accountName = #{accname} ")
    @ResultMap("usersMapper")
    Users findUserByAccountName(String accname);

    @Select("select * from users where id = #{id} ")
    @ResultMap("usersMapper")
    Users findUserById(String id);

    @Insert("insert into users (id,accountName,accountPassword,name,status,email,loginSum,createTime) values (#{id},#{accountName},#{accountPassword},#{name},#{status},#{email},#{loginSum},GETDATE())")
    int saveUser(Users user);

    @Update("update users set status = 1 where id = #{uid}")
    int StartUserStatusByUid(@Param("uid") String uid);

    @Update("update users set status = 0 where id = #{uid}")
    int StopUserStatusByUid(@Param("uid") String uid);

    @Delete("delete from users where id = #{uid} ")
    int DelUserByUid(@Param("uid") String uid);

    @Update("<script>update users set accountName = #{accountName}<if test=\"accountPassword!=null\">,accountPassword = #{accountPassword}</if>,name = #{name},status = #{status},email = #{email} where id = #{id}</script>")
    int updateUserById(Users user);

    @Update("<script>update users set name = #{name},sex = #{sex},statement = #{statement}<if test=\"portrait!=null\">,portrait = #{portrait}</if>,email = #{email},birthday = #{birthday} where id = #{id}</script>")
    int updateMyUserById(Users user);

    @Update("update users set loginSum = #{loginSum},loginTime = #{loginTime} where id = #{id}")
    int updateLoginUserById(Users user);

    @Update("update users set accountPassword = #{password} where id = #{uid}")
    int updatePasswordById(@Param("password") String password,@Param("uid") String uid);
}
