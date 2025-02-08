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

package com.ares.system.model.vo;

import com.ares.core.model.base.BaseModel;
import com.ares.system.persistence.entity.ArticlesDto;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

@Data
@AutoMapper(target = ArticlesDto.class)
public class Articles extends BaseModel {
    /**
     * 
     */
    private String content;
    /**
     * 
     */
    private String name;
    /**
     * 
     */
    private String status;
    /**
     * 
     */
    private String type;
    /**
     * 
     */
    private String title;
}
