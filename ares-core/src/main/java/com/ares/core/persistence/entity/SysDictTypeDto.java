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
 * 字典类别
 */
@Data
public class SysDictTypeDto extends BaseModel {
    private static final long serialVersionUID = -8641334815971550904L;
    /**
     * 字典名称
     */
    private String dictName;
    /**
     * 字典类别
     */
    private String dictType;
    /**
     * 状态
     */
    private String status;
    /**
     * 备注
     */
    private String remark;
}
