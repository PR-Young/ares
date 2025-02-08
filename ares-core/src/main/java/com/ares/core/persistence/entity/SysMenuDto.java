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
import com.ares.core.serializer.LongJsonDeserializer;
import com.ares.core.serializer.LongJsonSerializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @description: 系统菜单
 * @author: Young 2020/01/23
 **/
@Data
public class SysMenuDto extends BaseModel implements Serializable {

    private static final long serialVersionUID = -7528858814504220374L;
    /**
     * 菜单名称
     */
    private String name;
    /**
     * 菜单描述
     */
    private String description;
    /**
     * 菜单地址
     */
    private String url;
    /**
     * 菜单路由
     */
    private String path;
    /**
     * 
     */
    private Integer isBlank;
    /**
     * 父菜单
     */
    @JsonSerialize(using = LongJsonSerializer.class)
    @JsonDeserialize(using = LongJsonDeserializer.class)
    private Long pId;
    /**
     * 菜单图标
     */
    private String icon;
    /**
     * 菜单权限
     */
    private String perms;
    /**
     * 菜单分类，0：目录1：菜单2：按钮
     */
    private Integer type;
    /**
     * 菜单排序
     */
    private Integer order;
    /**
     * 是否可见
     */
    private Integer visible;

    private Integer childCount;

    /**
     * 子菜单
     */
    private List<SysMenuDto> children = new ArrayList<SysMenuDto>();
}
