package com.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.oa.dao.IRoleDao;
import com.oa.entity.Role;
import com.oa.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-10 20:04
 */
@Service
@Transactional
public class RoleServiceImpl implements IRoleService {
    @Autowired
    IRoleDao roleDao;
    public List<Role> findAllRole() {
        return roleDao.findAllRole();
    }

    public List<Role> findAllRole(int limit, int page) {
        PageHelper.startPage(page,limit);
        List<Role> list = roleDao.findAllRole();
        System.out.println(list.toString());
        return list;
    }

    public List<Role> findRoleByRname(String rname) {
        return roleDao.findRoleByRname(rname);
    }

    public int addRole(Role role) {
        return roleDao.addRole(role);
    }

    public int deleteRole(String[] rids) {
        int i=0;
        for (String str:rids) {
            i = roleDao.deleteRole(str);
        }
        return 1;
    }

    public int updateRole(Role role) {
        return roleDao.updateRole(role);
    }
}
