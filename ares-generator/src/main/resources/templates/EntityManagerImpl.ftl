package ${servicePackage}.impl;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import ${entityPackage}.${entityName};
import ${daoPackage}.I${entityName}Dao;
import ${servicePackage}.${entityName}Manager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.core.utils.StringUtils;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @description:
* @author: ${author}
* @date: ${createTime}
**/
@Service
public class ${entityName}ManagerImpl implements ${entityName}Manager {

    private I${entityName}Dao ${entityName1}Dao;

    @Autowired
    public ${entityName}ManagerImpl(I${entityName}Dao ${entityName1}Dao){
        this.${entityName1}Dao = ${entityName1}Dao;
    }

    @Override
    public PageInfo<${entityName}Dto> list(int pageNo, int pageSize, ${"Map<String, Object>"} map) {
        PageHelper.startPage(pageNo, pageSize);
        List<${entityName}Dto> lists = ${entityName1}Dao.list(map);
        PageInfo<${entityName}Dto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(${entityName}Dto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        ${entityName1}Dao.insert(obj);
    }

    @Override
    public void update(${entityName}Dto obj) {
        obj.setModifyTime(new Date());
        ${entityName1}Dao.update(obj);
    }

    @Override
    public void deleteByIds(${"List<Long>"} ids) {
        ${entityName1}Dao.deleteByIds(ids);
    }

    @Override
    public ${entityName}Dto getById(Long id) {
        return ${entityName1}Dao.getById(id);
    }

    @Override
    public PageInfo<${entityName}Dto> list(${entityName}Query obj) {
        List<${entityName}Dto> lists = ${entityName1}Dao.selectList(obj);
        PageInfo<${entityName}Dto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<${entityName}Dto> list(${"Map<String, Object>"} params) {
         return ${entityName1}Dao.list(params);
    }

    @Override
    public List<${entityName}Dto> selectList(${entityName}Query obj) {
         return ${entityName1}Dao.selectList(obj);
    }
}
