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

package com.ares.core.model.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Map;

/**
 * @description:
 * @author: Young
 * @date: 2023/8/2
 * @see: com.ares.core.model.query.BaseQuery.java
 **/
@Data
@Schema
public class BaseQuery {
    /**
     * 开始时间
     */
    @Schema
    private String beginTime;
    /**
     * 结束时间
     */
    @Schema
    private String endTime;
    @Schema
    private String sortColumn;
    @Schema
    private String sortAsc;
    @Schema
    private String sort;
    /**
     * 请求参数
     */
    @Schema(hidden = true)
    private Map<String, Object> params;

}
