package com.oa.entity;


public class UserRole {

  private long id;
  private String roleId;
  private String userId;


  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }


  public String getRoleId() {
    return roleId;
  }

  public void setRoleId(String roleId) {
    this.roleId = roleId;
  }


  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  @Override
  public String toString() {
    return "UserRole{" +
            "id=" + id +
            ", roleId='" + roleId + '\'' +
            ", userId='" + userId + '\'' +
            '}';
  }
}
