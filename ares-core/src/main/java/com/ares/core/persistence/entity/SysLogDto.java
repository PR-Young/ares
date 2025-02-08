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

package com.ares.core.persistence.entity;


import com.ares.core.model.base.BaseModel;
import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * @description: 系统日志
 * @author: Young 2020/01/27
 **/
@Data
@Accessors(chain = true)
public class SysLogDto extends BaseModel implements Serializable {

    private static final long serialVersionUID = -2925066346168762533L;
    /**
     * 主机IP
     */
    private String hostIp;
    /**
     * 用户名
     */
    private String userName;
    /**
     * url地址
     */
    private String url;
    /**
     * 操作参数
     */
    private String operParams;
    /**
     * 备注
     */
    private String notes;
    /**
     * 请求方式
     */
    private String requestMethod;
}
