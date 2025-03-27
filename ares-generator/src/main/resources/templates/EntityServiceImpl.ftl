package ${servicePackage}.impl;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import ${entityPackage}.${entityName};
import ${daoPackage}.I${entityName}Dao;
import ${servicePackage}.I${entityName}Service;
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
public class ${entityName}ServiceImpl implements I${entityName}Service {

    private I${entityName}Dao ${entityName1}Dao;
    private Converter converter;

    @Autowired
    public ${entityName}ServiceImpl(I${entityName}Dao ${entityName1}Dao, Converter converter){
        this.${entityName1}Dao = ${entityName1}Dao;
        this.converter = converter;
    }

    @Override
    public PageInfo<${entityName}> list(int pageNo, int pageSize, ${"Map<String, Object>"} map) {
        PageHelper.startPage(pageNo, pageSize);
        List<${entityName}> lists = converter.convert(${entityName1}Dao.list(map), ${entityName}.class);
        PageInfo<${entityName}> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(${entityName} obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        ${entityName}Dto dto = converter.convert(obj, ${entityName}Dto.class);
        ${entityName1}Dao.insert(dto);
    }

    @Override
    public void update(${entityName} obj) {
        obj.setModifyTime(new Date());
        ${entityName}Dto dto = converter.convert(obj, ${entityName}Dto.class);
        ${entityName1}Dao.update(dto);
    }

    @Override
    public void deleteByIds(${"List<Long>"} ids) {
        ${entityName1}Dao.deleteByIds(ids);
    }

    @Override
    public ${entityName} getById(Long id) {
        return converter.convert(${entityName1}Dao.getById(id), ${entityName}.class);
    }

    @Override
    public List<${entityName}> list(${entityName}Query obj) {
        List<${entityName}> lists = converter.convert(${entityName1}Dao.selectList(obj), ${entityName}.class);
        return lists;
    }

}
