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

/**
 * 系统参数
 */
@Data
public class SysPropertiesDto extends BaseModel {
    private static final long serialVersionUID = -8344592553043367264L;
    /**
     * 参数别名
     */
    private String alias;
    /**
     * 参数描述
     */
    private String description;
    /**
     * 参数分组
     */
    private String group;
    /**
     * 参数名称
     */
    private String name;
    /**
     * 参数值
     */
    private String value;
}
