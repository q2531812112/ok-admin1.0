package com.oa.entity;


import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@JsonIgnoreProperties(value = { "handler" })//使用了Mybatis级关联，必须设置这个属性才能使用Jackson转换
public class Users implements UserDetails {

  private String username;
  private String password;

  private String id;
  private String accountName;
  private String accountPassword;
  private String name;
  private int sex;
  @JSONField(format = "yyyy-MM-dd")
  private Date birthday;
  private String statement;
  private String portrait;
  private long status;
  private String email;
  private long loginSum;
  @JSONField(format = "yyyy-MM-dd HH:mm:ss")
  private Timestamp createTime;
  @JSONField(format = "yyyy-MM-dd HH:mm:ss")
  private Timestamp loginTime;

  private List<Role> roles;


  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public List<Role> getRoles() {
    return roles;
  }

  public void setRoles(List<Role> role) {
    this.roles = role;
  }

  public String getAccountName() {
    return accountName;
  }

  public void setAccountName(String accountName) {
    username = accountName;
    this.accountName = accountName;
  }


  public String getAccountPassword() {
    return accountPassword;
  }

  public void setAccountPassword(String accountPassword) {
    password = accountPassword;
    this.accountPassword = accountPassword;
  }

  @Override
  public String toString() {
    return "Users{" +
            "id='" + id + '\'' +
            ", accountName='" + accountName + '\'' +
            ", accountPassword='" + accountPassword + '\'' +
            ", name='" + name + '\'' +
            ", sex=" + sex +
            ", birthday=" + birthday +
            ", statement='" + statement + '\'' +
            ", portrait='" + portrait + '\'' +
            ", status=" + status +
            ", email='" + email + '\'' +
            ", loginSum=" + loginSum +
            ", createTime=" + createTime +
            ", loginTime=" + loginTime +
            ", roles=" + roles +
            '}';
  }

  public int getSex() {
    return sex;
  }

  public void setSex(int sex) {
    this.sex = sex;
  }

  public Date getBirthday() {
    return birthday;
  }

  public void setBirthday(Date birthday) {
    this.birthday = birthday;
  }

  public String getStatement() {
    return statement;
  }

  public void setStatement(String statement) {
    this.statement = statement;
  }

  public String getPortrait() {
    return portrait;
  }

  public void setPortrait(String portrait) {
    this.portrait = portrait;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public long getStatus() {
    return status;
  }

  public void setStatus(long status) {
    this.status = status;
  }


  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }


  public long getLoginSum() {
    return loginSum;
  }

  public void setLoginSum(long loginSum) {
    this.loginSum = loginSum;
  }

  public Timestamp getCreateTime() {
    return createTime;
  }

  public void setCreateTime(Timestamp createTime) {
    this.createTime = createTime;
  }

  public Timestamp getLoginTime() {
    return loginTime;
  }

  public void setLoginTime(Timestamp loginTime) {
    this.loginTime = loginTime;
  }

  /////////////////////////////////实现类UserDetail实现方法
  @JSONField(serialize = false)
  public Collection<? extends GrantedAuthority> getAuthorities() {
    List<GrantedAuthority> auths = new ArrayList<GrantedAuthority>();
    List<Role> roles = getRoles();
    for(Role role : roles)
    {
      auths.add(new SimpleGrantedAuthority(role.getName()));
    }
    return auths;
  }

  public String getPassword() {
    return this.password;
  }

  public String getUsername() {
    return this.username;
  }

  public boolean isAccountNonExpired() {
    return true;
  }

  public boolean isAccountNonLocked() {
    return true;
  }

  public boolean isCredentialsNonExpired() {
    return true;
  }

  public boolean isEnabled() {
    return true;
  }
}
