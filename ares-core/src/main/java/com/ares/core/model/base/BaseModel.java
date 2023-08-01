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

package com.ares.core.model.base;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
@Data
public class BaseModel implements Serializable {
    private static final long serialVersionUID = 2513447910190608371L;
    @Schema(description = "主键")
    @ExcelProperty(value = "序号", index = 0)
    private String id;
    @Schema(description = "创建人")
    @ExcelIgnore
    private String creator;
    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ExcelIgnore
    private Date createTime;
    @Schema(description = "修改人")
    @ExcelIgnore
    private String modifier;
    @Schema(description = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ExcelIgnore
    private Date modifyTime;

    /** =============================查询参数================================= */
    /**
     * 开始时间
     */
    @JsonIgnore
    @ExcelIgnore
    @Schema(hidden = true)
    private String beginTime;
    /**
     * 结束时间
     */
    @JsonIgnore
    @ExcelIgnore
    @Schema(hidden = true)
    private String endTime;
    @JsonIgnore
    @ExcelIgnore
    @Schema(hidden = true)
    private String sortColumn;
    @JsonIgnore
    @ExcelIgnore
    @Schema(hidden = true)
    private String sortAsc;
    @JsonIgnore
    @ExcelIgnore
    @Schema(hidden = true)
    private String sort;
    /**
     * 请求参数
     */
    @ExcelIgnore
    @Schema(hidden = true)
    private Map<String, Object> params;

}
