package com.oa.service;

import com.oa.entity.Role;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-10 20:03
 */
public interface IRoleService {

    List<Role> findAllRole();

    List<Role> findAllRole(int limit,int page);

    List<Role> findRoleByRname(String rname);

    int addRole(Role role);

    int deleteRole(String[] rids);

    int updateRole(Role role);
}
