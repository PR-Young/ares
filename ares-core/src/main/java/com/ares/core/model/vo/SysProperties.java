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

package com.ares.core.model.vo;


import com.ares.core.model.base.BaseModel;
import com.ares.core.persistence.entity.SysPropertiesDto;
import io.github.linpeilie.annotations.AutoMapper;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@AutoMapper(target = SysPropertiesDto.class)
@Schema(title = "SysProperties对象", description = "系统参数")
public class SysProperties extends BaseModel {
    private static final long serialVersionUID = -8344592553043367264L;
    @Schema(description = "参数别名")
    private String alias;
    @Schema(description = "参数描述")
    private String description;
    @Schema(description = "参数分组")
    private String group;
    @Schema(description = "参数名称")
    private String name;
    @Schema(description = "参数值")
    private String value;
}
