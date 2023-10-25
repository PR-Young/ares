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

package com.ares.core.persistence.service.impl;

import com.ares.core.model.query.SysDeptQuery;
import com.ares.core.model.tree.TreeSelect;
import com.ares.core.persistence.dao.ISysDeptDao;
import com.ares.core.persistence.entity.SysDept;
import com.ares.core.persistence.service.ISysDeptService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * @author young
 */
@Service
public class SysDeptServiceImpl implements ISysDeptService {

    private ISysDeptDao sysDeptDao;

    @Autowired
    public SysDeptServiceImpl(ISysDeptDao sysDeptDao) {
        this.sysDeptDao = sysDeptDao;
    }


    @Override
    public PageInfo<SysDept> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysDept> lists = sysDeptDao.list(map);
        PageInfo<SysDept> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysDept obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysDeptDao.insert(obj);
    }

    @Override
    public void update(SysDept obj) {
        obj.setModifyTime(new Date());
        sysDeptDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysDeptDao.deleteByIds(ids);
    }

    @Override
    public SysDept getById(Long id) {
        return sysDeptDao.getById(id);
    }

    @Override
    public List<SysDept> list(SysDeptQuery obj) {
        List<SysDept> lists = sysDeptDao.selectList(obj);
        return lists;
    }

    @Override
    public SysDept getByDeptId(Long id) {
        return sysDeptDao.getByDeptId(id);
    }

    @Override
    public List<TreeSelect> buildDeptTree() {
        List<SysDept> deptList = sysDeptDao.getAllDept();
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
