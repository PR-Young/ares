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
import com.ares.core.persistence.entity.SysNoticeDto;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.github.linpeilie.annotations.AutoMapper;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

@Data
@AutoMapper(target = SysNoticeDto.class)
@Schema(title = "SysNotice对象", description = "通知公告")
public class SysNotice extends BaseModel {
    private static final long serialVersionUID = -15853869213165737L;
    @Schema(description = "到期时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date deadline;
    @Schema(description = "内容")
    private String noticeContent;
    @Schema(description = "状态：0：正常1：关闭")
    private String noticeStatus;
    @Schema(description = "标题")
    private String noticeTitle;
    @Schema(description = "类别：1：通知2：公告")
    private String noticeType;
    @Schema(description = "备注")
    private String remark;
}
