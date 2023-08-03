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

package com.ares.core.persistence.service;

import com.ares.core.model.query.SysDeptQuery;
import com.ares.core.model.tree.TreeSelect;
import com.ares.core.persistence.model.SysDept;

import java.util.List;

/**
 * @author young
 */
public interface ISysDeptService extends IBaseService<SysDept, SysDeptQuery> {

    SysDept getByDeptId(String id);

    List<TreeSelect> buildDeptTree();

    List<TreeSelect> buildTree(String parentId, List<SysDept> deptList);

}
