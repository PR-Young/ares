/*
 * !******************************************************************************
 *  * Copyright (c) 2021 - 9999, ARES
 *  *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  *
 *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *  *****************************************************************************
 */

package com.ares.core.persistence.model;


import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.ares.core.model.base.BaseModel;
import io.swagger.v3.oas.annotations.media.Schema;

import java.io.Serializable;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
@Schema(title = "SysUser对象", description = "系统用户")
public class SysUser extends BaseModel implements Serializable {

    private static final long serialVersionUID = 1335150848291052716L;
    @Schema(description = "帐号")
    @ExcelProperty(value = "帐号", index = 1)
    private String account;
    @Schema(description = "用户名")
    @ExcelProperty(value = "用户名", index = 2)
    private String userName;
    @Schema(description = "密码")
    @ExcelIgnore
    private String password;
    @Schema(description = "电话")
    @ExcelProperty(value = "电话", index = 3)
    private String phoneNumber;
    @Schema(description = "邮箱")
    @ExcelProperty(value = "邮箱", index = 4)
    private String email;
    @Schema(description = "头像")
    @ExcelIgnore
    private String avatar;
    @ExcelIgnore
    private String[] roleIds;
    @ExcelIgnore
    private boolean isAdmin;
    @ExcelIgnore
    private String deptId;
    @ExcelIgnore
    private String postId;
    @Schema(description = "状态")
    @ExcelIgnore
    private int status;

    public SysUser() {
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String[] getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(String[] roleIds) {
        this.roleIds = roleIds;
    }

    public boolean isAdmin() {
        return isAdmin(getId());
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public static boolean isAdmin(String userId) {
        return userId != null && "1".equals(userId);
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
