package com.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.oa.dao.IUserDao;
import com.oa.dao.IUserRoleDao;
import com.oa.entity.Role;
import com.oa.entity.UserRole;
import com.oa.entity.Users;
import com.oa.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-08 9:33
 */
@Service
@Transactional
public class UserServiceImpl implements IUserService {

    @Autowired
    IUserDao userDao;
    @Autowired
    IUserRoleDao userRoleDao;


    private final BCryptPasswordEncoder ENCODER = new BCryptPasswordEncoder();

    public List<Users> findUserLikeAccountName(String accountName) {
        return userDao.findUserLikeAccountName(accountName);
    }

    public List<Users> findAllUser() {
        return userDao.findAllUser();
    }

    public List<Users> findAllUser(int limit, int page) {
        PageHelper.startPage(page,limit);
        List<Users> list = userDao.findAllUser();
        return list;
    }

    public Users findUserById(String id) {
        return userDao.findUserById(id);
    }

    public Users findUserByAccountName(String accname) {
        return userDao.findUserByAccountName(accname);
    }

    public int saveUser(Users user,String rid) {
        UserRole userRole = new UserRole();
        if(rid==null||rid.trim().length()==0){
            userRole.setRoleId("6769f5342e4844d4929971f9b7b7971c");
        }else{
            userRole.setRoleId(rid);
        }
        userRole.setUserId(user.getId());
        user.setAccountPassword(ENCODER.encode(user.getAccountPassword()));
        int i1 = userDao.saveUser(user);
        int i = userRoleDao.addUserRole(userRole);
        return i==1&&i1==1?1:0;
    }

    public int StartUserStatusByUid(String[] uids) {
        int i=0;
        for (String str:uids) {
            i = userDao.StartUserStatusByUid(str);
        }
        return i;
    }

    public int StartUserStatusByUid(List<String> uids) {
        int i=0;
        for (String str:uids) {
            i = userDao.StartUserStatusByUid(str);
        }
        return i;
    }

    public int StopUserStatusByUid(List<String> uids) {
        int i=0;
        for (String str:uids) {
            i = userDao.StopUserStatusByUid(str);
        }
        return i;
    }

    public int StopUserStatusByUid(String[] uids) {
        int i=0;
        for (String str:uids) {
            i = userDao.StopUserStatusByUid(str);
        }
        return i;
    }

    public int DelUserByUid(String[] uids) {int i=0;
        for (String str:uids) {
            int r = userRoleDao.delUserRoleByUid(str);
            int u = userDao.DelUserByUid(str);
            System.out.println("r="+r+"u="+u);
            if(r==1||r==0) {
                if(u == 1) {
                    i = 1;
                }
            }
        }
        return i;
    }

    public int DelUserByUid(List<String> uids) {int i=0;
        for (String str:uids) {
            int r = userRoleDao.delUserRoleByUid(str);
            int u = userDao.DelUserByUid(str);
            System.out.println("r="+r+"u="+u);
            if(r==1||r==0) {
                if(u == 1) {
                    i = 1;
                }
            }
        }
        return i;
    }

    public int updateUserById(Users user,String rid) {
        if(user.getAccountPassword()!=null&&user.getAccountPassword().trim().length()!=0) {
            user.setAccountPassword(ENCODER.encode(user.getAccountPassword()));
        }else{
            user.setAccountPassword(null);
        }
        System.out.println(user.toString());
        List<UserRole> allUserRole = userRoleDao.findAllUserRole();
        int isExistUid = 0;
        //判断角色用户对应表中是否存在用户Id，如果存在则修改用户的角色Id，否则新增一个角色用户权限对应关系数据
        for (UserRole userRole : allUserRole) {
            if(userRole.getUserId().equals(user.getId())) {
                isExistUid = 1;
                break;
            }
        }
        int i1=0;
        if(isExistUid==1){
            i1 = userRoleDao.updateUserRoleByUid(user.getId(), rid);
        }else{
            UserRole userRole = new UserRole();
            userRole.setRoleId(rid);
            userRole.setUserId(user.getId());
            i1 = userRoleDao.addUserRole(userRole);
        }
        int i = userDao.updateUserById(user);
        return i==1&&i1==1?1:0;
    }

    public int updateUserById(Users user) {
        user.setAccountPassword(ENCODER.encode(user.getAccountPassword()));
        return userDao.updateUserById(user);
    }

    public int updateMyUserById(Users user) {
        return userDao.updateMyUserById(user);
    }

    public int updateLoginUserById(Users user) {
        return userDao.updateLoginUserById(user);
    }

    /**
     * 检查原来的密码是否输入正确，若不正确返回：2
     * 若正确则修改原来的密码，返回：1
     * @param currentPassword
     * @param password
     * @param uid
     * @return
     */
    public int updatePasswordById(String currentPassword,String password, String uid) {
        Users user = findUserById(uid);
        int i=0;
        if(ENCODER.matches(currentPassword,user.getAccountPassword())){
            String encode = ENCODER.encode(password);
            i = userDao.updatePasswordById(encode,uid);
        }else{
            i = 2;
        }
        return i;
    }

}
