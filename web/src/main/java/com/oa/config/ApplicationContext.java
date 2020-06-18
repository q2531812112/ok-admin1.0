package com.oa.config;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.oa.dao.IPermissionDao;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.mybatis.spring.annotation.MapperScans;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.annotation.MultipartConfig;
import java.beans.PropertyVetoException;
import java.io.IOException;

/**
 * 1、@Configuration ：声明配置类
 * 2、@MapperScan    ：扫描生成dao实现类：
 * 3、@EnableTransactionManagement ：声明事物管理
 * 4、@PropertySource  ： 导入properties配置文件
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-15 12:13
 */

/**
 *configuration   此注解标明配置类的身份
 *下面的步骤相当于xml配置文件中的开启spring扫描，开启默认注解，不过排除掉controller注解
 */

@Configuration  //声明配置类
@MapperScan("com.oa.dao")
@ComponentScan(
        basePackages = {"com.oa","com.oa.handler"},
        useDefaultFilters = true,
        excludeFilters = {@ComponentScan.Filter(type = FilterType.ANNOTATION, classes = Controller.class)})
@EnableTransactionManagement    //开启事务处理器支持
//@PropertySource("classpath:jdbc.properties")    //导入jdbc配置
public class ApplicationContext  {

    public ApplicationContext(){
        System.out.println("ApplicationContext >>> Loding......");
    }


    /**
     *提供数据源
     *
     */
    @Bean //数据源
    public ComboPooledDataSource c3p0DataSource(
            @Value("com.microsoft.sqlserver.jdbc.SQLServerDriver") String driver,
            @Value("jdbc:sqlserver://localhost:1433;databasename=OAManagerSystem") String url,
            @Value("sa") String name,
            @Value("123456") String password) throws PropertyVetoException {

        ComboPooledDataSource comboPooledDataSource = new ComboPooledDataSource();
        comboPooledDataSource.setDriverClass(driver);
        comboPooledDataSource.setJdbcUrl(url);
        comboPooledDataSource.setUser(name);
        comboPooledDataSource.setPassword(password);
        return comboPooledDataSource;
    }


    /**
     *创建SqlSessionFactoryBean工厂
     *
     */
    @Bean   //SqlSession工厂
    public SqlSessionFactory sqlSessionFactory(@Autowired ComboPooledDataSource dataSource) throws Exception {
        SqlSessionFactoryBean  factoryBean = new SqlSessionFactoryBean ();
        factoryBean.setDataSource(dataSource);//设置数据源
        return factoryBean.getObject();
    }

    @Bean   //扫描Dao包接口
    public MapperScannerConfigurer scanner(@Autowired ComboPooledDataSource dataSource) throws Exception {
        MapperScannerConfigurer scanner = new MapperScannerConfigurer();
        scanner.setBasePackage("com.oa.dao");
        scanner.setSqlSessionFactoryBeanName("sqlSessionFactory");
        return scanner;
    }



    /**
     *声明事务管理器
     *
     */
    @Bean   //Spring自动管理事务管理器
    public DataSourceTransactionManager getDataSourceTransactionManager(@Autowired ComboPooledDataSource dataSource){
        DataSourceTransactionManager transactionManager = new DataSourceTransactionManager();
        transactionManager.setDataSource(dataSource);
        return transactionManager;
    }


    @Bean   //配置Multipart文件上传配置器
    public MultipartResolver multipartResolver() throws IOException{
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setDefaultEncoding("UTF-8");
        //设置临时文件路径,不设置的话这个路径就是Servlet容器的临时目录,如:E:\apache-tomcat-7.0.70\work\Catalina\localhost\spittr
        multipartResolver.setUploadTempDir(new FileSystemResource("D:/JAVA/ideaProject/oa/web/target/web-1.0-SNAPSHOT/imgs/temp/"));
        //设置所有大小的文件都会写入到磁盘中
        multipartResolver.setMaxInMemorySize(0);
        //设置最大文件上传大小2M
        multipartResolver.setMaxUploadSize(2097152);
        return multipartResolver;
    }



}
