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
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 通知公告
 */
@Data
public class SysNoticeDto extends BaseModel {
    private static final long serialVersionUID = -15853869213165737L;
    /**
     * 到期时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date deadline;
    /**
     * 内容
     */
    private String noticeContent;
    /**
     * 状态：0：正常1：关闭
     */
    private String noticeStatus;
    /**
     * 标题
     */
    private String noticeTitle;
    /**
     * 类别：1：通知2：公告
     */
    private String noticeType;
    /**
     * 备注
     */
    private String remark;
}
