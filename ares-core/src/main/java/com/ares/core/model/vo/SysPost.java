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
import com.ares.core.persistence.entity.SysPostDto;
import io.github.linpeilie.annotations.AutoMapper;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@AutoMapper(target = SysPostDto.class)
@Schema(title = "SysPost对象", description = "岗位对象")
public class SysPost extends BaseModel {
    private static final long serialVersionUID = -5311455714157532240L;
    @Schema(description = "岗位编号")
    private String postCode;
    @Schema(description = "岗位名称")
    private String postName;
}
