package com.oa.entity;


import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.sql.Timestamp;
@JsonIgnoreProperties(value = { "handler" })
public class Role {

  private String id;
  private String name;
  private String statement;
  private String createUserName;
  private Timestamp createTime;


  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getStatement() {
    return statement;
  }

  public void setStatement(String statement) {
    this.statement = statement;
  }


  public String getCreateUserName() {
    return createUserName;
  }

  public void setCreateUserName(String createUserName) {
    this.createUserName = createUserName;
  }


  @JSONField(format = "yyyy-MM-dd HH:mm:ss")
  public Timestamp getCreateTime() {
    return createTime;
  }

  public void setCreateTime(Timestamp createTime) {
    this.createTime = createTime;
  }


  @Override
  public String toString() {
    return "Role{" +
            "id='" + id + '\'' +
            ", name='" + name + '\'' +
            ", statement='" + statement + '\'' +
            ", createUserName='" + createUserName + '\'' +
            ", createTime=" + createTime +
            '}';
  }
}
