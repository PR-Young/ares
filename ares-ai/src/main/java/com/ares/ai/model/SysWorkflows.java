/*
 *
 *  * ****************************************************************************
 *  * * Copyright (c) 2021 - 9999, ARES
 *  * *
 *  * * Licensed under the Apache License, Version 2.0 (the "License");
 *  * * you may not use this file except in compliance with the License.
 *  * * You may obtain a copy of the License at
 *  * *
 *  * *        http://www.apache.org/licenses/LICENSE-2.0
 *  * *
 *  * * Unless required by applicable law or agreed to in writing, software
 *  * * distributed under the License is distributed on an "AS IS" BASIS,
 *  * * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * * See the License for the specific language governing permissions and
 *  * * limitations under the License.
 *  * ***************************************************************************
 *
 */

package com.ares.ai.model;

import com.ares.ai.persistence.entity.SysWorkflowsDto;
import com.ares.core.model.base.BaseModel;
import io.github.linpeilie.annotations.AutoMapper;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * @description:
 * @author: young
 * @date: 2025-05-15 13:15:01
 **/
@Data
@AutoMapper(target = SysWorkflowsDto.class)
@Schema(title = "SysWorkflows对象", description = "")
public class SysWorkflows extends BaseModel {
    @Schema(description = "")
    private Integer appId;
    @Schema(description = "")
    private String graph;
    @Schema(description = "")
    private String workflowName;
}
