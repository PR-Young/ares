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

package com.ares.core.service.impl;

import com.ares.core.model.query.SysDeptQuery;
import com.ares.core.model.tree.TreeSelect;
import com.ares.core.model.vo.SysDept;
import com.ares.core.persistence.entity.SysDeptDto;
import com.ares.core.persistence.manager.SysDeptManager;
import com.ares.core.service.ISysDeptService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * @author young
 */
@Service
public class SysDeptServiceImpl implements ISysDeptService {

    private SysDeptManager deptManager;
    private Converter converter;

    @Autowired
    public SysDeptServiceImpl(SysDeptManager deptManager, Converter converter) {
        this.deptManager = deptManager;
        this.converter = converter;
    }


    @Override
    public PageInfo<SysDept> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysDeptDto> list = deptManager.list(pageNo, pageSize, map);
        PageInfo<SysDept> pageInfo = list.convert(dto -> {
            SysDept v = converter.convert(dto, SysDept.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysDept obj) {
        SysDeptDto sysDeptDto = converter.convert(obj, SysDeptDto.class);
        deptManager.insert(sysDeptDto);
    }

    @Override
    public void update(SysDept obj) {
        SysDeptDto sysDeptDto = converter.convert(obj, SysDeptDto.class);
        deptManager.update(sysDeptDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        deptManager.deleteByIds(ids);
    }

    @Override
    public SysDept getById(Long id) {
        return converter.convert(deptManager.getById(id), SysDept.class);
    }

    @Override
    public PageInfo<SysDept> list(SysDeptQuery obj) {
        List<SysDeptDto> lists = deptManager.selectList(obj);
        PageInfo<SysDeptDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysDept> page = pageInfo.convert(dto -> {
            SysDept v = converter.convert(dto, SysDept.class);
            return v;
        });
        return page;
    }

    @Override
    public SysDept getByDeptId(Long id) {
        return converter.convert(deptManager.getByDeptId(id), SysDept.class);
    }

    @Override
    public List<TreeSelect> buildDeptTree() {
        List<SysDept> deptList = converter.convert(deptManager.getAllDept(), SysDept.class);
        return buildTree(0L, deptList);
    }

    @Override
    public List<TreeSelect> buildTree(Long parentId, List<SysDept> deptList) {
        List<TreeSelect> trees = new LinkedList<>();
        for (SysDept sysDept : deptList) {
            TreeSelect tree = new TreeSelect();
            if (parentId.equals(sysDept.getParentDeptId())) {
                tree.setId(sysDept.getId());
                tree.setLabel(sysDept.getDeptName());
                if (sysDept.getChildCount() > 0) {
                    tree.setChildren(buildTree(sysDept.getId(), deptList));
                }
                trees.add(tree);
            }
        }
        return trees;
    }
}
