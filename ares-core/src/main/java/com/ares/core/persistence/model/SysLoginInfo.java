/*
 *
 *  * !******************************************************************************
 *  *  * Copyright (c) 2021 - 9999, ARES
 *  *  *
 *  *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  *  * you may not use this file except in compliance with the License.
 *  *  * You may obtain a copy of the License at
 *  *  *
 *  *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *  *
 *  *  * Unless required by applicable law or agreed to in writing, software
 *  *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  *  * See the License for the specific language governing permissions and
 *  *  * limitations under the License.
 *  *  *****************************************************************************
 *
 */

package com.ares.core.persistence.model;

import com.ares.core.model.base.BaseModel;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.apache.ibatis.type.JdbcType;

import java.util.Date;

@Data
@ApiModel(value = "SysLoginInfo对象", description = "")
@TableName("sys_login_info")
public class SysLoginInfo extends BaseModel {
    @ApiModelProperty("")
    @TableField(value = "browser", jdbcType = JdbcType.VARCHAR, javaType = true)
    private String browser;
    @ApiModelProperty("")
    @TableField(value = "ip_addr", jdbcType = JdbcType.VARCHAR, javaType = true)
    private String ipAddr;
    @ApiModelProperty("")
    @TableField(value = "login_location", jdbcType = JdbcType.VARCHAR, javaType = true)
    private String loginLocation;
    @ApiModelProperty("")
    @TableField(value = "login_time", jdbcType = JdbcType.TIMESTAMP, javaType = true)
    private Date loginTime;
    @ApiModelProperty("")
    @TableField(value = "msg", jdbcType = JdbcType.VARCHAR, javaType = true)
    private String msg;
    @ApiModelProperty("")
    @TableField(value = "os", jdbcType = JdbcType.VARCHAR, javaType = true)
    private String os;
    @ApiModelProperty("")
    @TableField(value = "`status`", jdbcType = JdbcType.VARCHAR, javaType = true)
    private String status;
    @ApiModelProperty("")
    @TableField(value = "user_name", jdbcType = JdbcType.VARCHAR, javaType = true)
    private String userName;
}
