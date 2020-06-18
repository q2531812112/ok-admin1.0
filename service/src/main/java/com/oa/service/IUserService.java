package com.oa.service;

import com.oa.entity.Users;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-08 9:32
 */

public interface IUserService{
    List<Users> findUserLikeAccountName(String accountName);
    List<Users> findAllUser();
    List<Users> findAllUser(int limit,int page);
    Users findUserById(String id);
    Users findUserByAccountName(String accname);
    int saveUser(Users user,String rid);
    int StartUserStatusByUid(String[] uids);
    int StartUserStatusByUid(List<String> uids);
    int StopUserStatusByUid(List<String> uids);
    int StopUserStatusByUid(String[] uids);
    int DelUserByUid(String[] uids);
    int DelUserByUid(List<String> uids);
    int updateUserById(Users user,String rid);
    int updateUserById(Users user);
    int updateMyUserById(Users user);
    int updateLoginUserById(Users user);
    int updatePasswordById(String currentPassword,String password,String uid);
}
