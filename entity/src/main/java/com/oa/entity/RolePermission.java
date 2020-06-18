package com.oa.entity;


public class RolePermission {

  private long id;
  private String roleId;
  private long permissionId;


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


  public long getPermissionId() {
    return permissionId;
  }

  public void setPermissionId(long permissionId) {
    this.permissionId = permissionId;
  }

  @Override
  public String toString() {
    return "RolePermission{" +
            "id=" + id +
            ", roleId='" + roleId + '\'' +
            ", permissionId=" + permissionId +
            '}';
  }
}
