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

package com.ares.flow.service.impl;


import com.ares.core.model.vo.SysDictData;
import com.ares.core.service.ISysDictDataService;
import jakarta.annotation.Resource;
import org.dromara.warm.flow.core.dto.Tree;
import org.dromara.warm.flow.ui.service.CategoryService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2025/7/17
 * @see: com.ares.flow.service.impl.CategoryServiceImpl.java
 **/
@Service
public class CategoryServiceImpl implements CategoryService {
    @Resource
    private ISysDictDataService dictDataService;

    @Override
    public List<Tree> queryCategory() {
        List<Tree> trees = new ArrayList<>();
        List<SysDictData> sysProcessCategory = dictDataService.getDicts("sys_process_category");
        for (SysDictData sysDictData : sysProcessCategory) {
            Tree tree = new Tree(sysDictData.getDictValue(), sysDictData.getDictLabel(), null, null);
            trees.add(tree);
        }
        return trees;
    }
}
