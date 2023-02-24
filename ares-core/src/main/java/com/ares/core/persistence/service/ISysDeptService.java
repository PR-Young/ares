package com.ares.core.persistence.service;

import com.ares.core.persistence.model.SysDept;
import com.ares.core.model.tree.TreeSelect;

import java.util.List;

/**
 * @author young
 */
public interface ISysDeptService extends IBaseService<SysDept> {

    public SysDept getByDeptId(String id);

    public List<TreeSelect> buildDeptTree() ;

    public List<TreeSelect> buildTree(String parentId, List<SysDept> deptList) ;

}
