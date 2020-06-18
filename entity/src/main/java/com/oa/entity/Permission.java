package com.oa.entity;


import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.List;

public class Permission {

  private long id;
  private String name;
  private String menuUrl;
  private String url;
  private long type;
  private long parentId;
  private java.sql.Timestamp createTime;
  private List<Role> roles;

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getMenuUrl() {
    if(menuUrl==null||menuUrl.equals("null")||menuUrl.length()==0)
      setMenuUrl("");
    return menuUrl;
  }

  public void setMenuUrl(String menuUrl) {
    this.menuUrl = menuUrl;
  }


  public String getUrl() {
    if(url==null||url.equals("null")||url.length()==0)
      setUrl("");
    return url;
  }

  public void setUrl(String url) {
    this.url = url;
  }


  public long getType() {
    return type;
  }

  public void setType(long type) {
    this.type = type;
  }


  public long getParentId() {
    return parentId;
  }

  public void setParentId(long parentId) {
    this.parentId = parentId;
  }

  public List<Role> getRoles() {
    return roles;
  }

  public void setRoles(List<Role> roles) {
    this.roles = roles;
  }

  @JSONField(format = "yyyy-MM-dd HH:mm:ss")
  public java.sql.Timestamp getCreateTime() {
    return createTime;
  }

  public void setCreateTime(java.sql.Timestamp createTime) {
    this.createTime = createTime;
  }

  @Override
  public String toString() {
    return "Permission{" +
            "id=" + id +
            ", name='" + name + '\'' +
            ", menuUrl='" + menuUrl + '\'' +
            ", url='" + url + '\'' +
            ", type=" + type +
            ", parentId=" + parentId +
            ", createTime=" + createTime +
            ", roles=" + roles +
            '}';
  }
}
