package com.oa.test;

import com.oa.config.ApplicationContext;
import com.oa.config.SpringMvcConfig;
import com.oa.dao.IPermissionDao;
import com.oa.entity.Permission;
import com.oa.utils.GetUserIp;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-16 15:33
 */
@Transactional
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {ApplicationContext.class,SpringMvcConfig.class})
public class TestAll {
    @Autowired
    IPermissionDao permissionDao;

    @Test
    public void show(){
        List<Permission> list = permissionDao.findAllPermission();
        for (Permission permission : list) {
            System.out.println(permission.toString());
        }
    }

    @Test
    public void getIp(){
        System.out.println(GetUserIp.getLocalIPForCMD());
    }


}
