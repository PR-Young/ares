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

package com.ares.generator.service.impl;


import cn.hutool.core.lang.Assert;
import com.ares.config.gen.GeneratorConfig;
import com.ares.generator.model.query.EntityDataModel;
import com.ares.generator.model.vo.GenProperties;
import com.ares.generator.persistence.manager.GeneratorManager;
import com.ares.generator.service.IAutoGeneratorService;
import com.ares.generator.service.IGenPropertiesService;
import com.ares.generator.service.IGeneratorService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/04/28
 **/
@Slf4j
@Service
public class GeneratorServiceImpl implements IGeneratorService {

    private GeneratorManager generatorManager;
    private GeneratorConfig config;
    private IAutoGeneratorService autoGeneratorService;

    private IGenPropertiesService genPropertiesService;

    @Autowired
    public GeneratorServiceImpl(GeneratorManager generatorManager,
                                GeneratorConfig config,
                                IAutoGeneratorService autoGeneratorService,
                                IGenPropertiesService genPropertiesService) {
        this.generatorManager = generatorManager;
        this.config = config;
        this.autoGeneratorService = autoGeneratorService;
        this.genPropertiesService = genPropertiesService;
    }

    private void init() {
        GenProperties properties = genPropertiesService.getByUser();
        if (null != properties) {
            config.setBasePackage(properties.getBasePackage());
            config.setEntityPackage(properties.getEntityPackage());
            config.setDaoPackage(properties.getDaoPackage());
            config.setServicePackage(properties.getServicePackage());
            config.setControllerPackage(properties.getControllerPackage());
            config.setAuthor(properties.getAuthor());
            config.setGeneratorLevel(properties.getGenLevel());
            config.setTablePrefix(properties.getTablePrefix());
        }
    }

    @Override
    public List<Map<String, Object>> tables(String flag, Map<String, Object> map) {
        List<Map<String, Object>> tables = new ArrayList<>();
        if ("master".equalsIgnoreCase(flag)) {
            tables = generatorManager.getTables(map);
        } else {
            tables = generatorManager.getSlaveTables();
        }

        return tables;
    }

    @Override
    public PageInfo<Map<String, Object>> columns(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> columnList = generatorManager.getColumnsByTable(map);
        PageInfo<Map<String, Object>> columnPageInfo = new PageInfo<>(columnList);
        return columnPageInfo;
    }

    @Override
    public List<Map<String, Object>> selectTableColumnListByTableName(String flag, String tableName) {
        if ("master".equalsIgnoreCase(flag)) {
            return generatorManager.selectTableColumnListByTableName(tableName);
        } else {
            return generatorManager.selectTableColumnListByTableName(tableName);
        }
    }

    @Override
    public LinkedHashMap<String, Object> preview(String flag, String tableName) {
        Assert.notNull(tableName);
        init();
        LinkedHashMap<String, Object> result = new LinkedHashMap<>();
        String tablePrefix;
        if ("master".equalsIgnoreCase(flag)) {
            tablePrefix = config.getTablePrefix();
        } else {
            tablePrefix = config.getSlaveTablePrefix();
        }
        Connection con = autoGeneratorService.getConn(flag);

        try {
            ByteArrayOutputStream entity = null, entityDto = null, entityQuery = null, entityMapper = null, entityDao = null, entityManager = null, entityManagerImpl = null, iEntityService = null, entityServiceImpl = null, entityApiController = null, view = null, viewjs = null;
            EntityDataModel entityModel = autoGeneratorService.getEntityModel(flag, con, tableName, tablePrefix);
            switch (config.getGeneratorLevel()) {
                case 1:
                    entity = generateCode(entityModel, "Entity.ftl", "", ".java");
                    entityDto = generateCode(entityModel, "EntityDto.ftl", "", ".java");
                    entityQuery = generateCode(entityModel, "EntityQuery.ftl", "", "Query.java");
                    entityMapper = generateCode(entityModel, "EntityMapper.ftl", "", "Mapper.xml");
                    entityDao = generateCode(entityModel, "EntityDao.ftl", "I", "Dao.java");
                    entityManager = generateCode(entityModel, "EntityManager.ftl", "", "Manager.java");
                    entityManagerImpl = generateCode(entityModel, "EntityManagerImpl.ftl", "", "ManagerImpl.java");
                    break;
                case 2:
                    entity = generateCode(entityModel, "Entity.ftl", "", ".java");
                    entityDto = generateCode(entityModel, "EntityDto.ftl", "", ".java");
                    entityQuery = generateCode(entityModel, "EntityQuery.ftl", "", "Query.java");
                    entityMapper = generateCode(entityModel, "EntityMapper.ftl", "", "Mapper.xml");
                    entityDao = generateCode(entityModel, "EntityDao.ftl", "I", "Dao.java");
                    iEntityService = generateCode(entityModel, "IEntityService.ftl", "I", "Service.java");
                    entityServiceImpl = generateCode(entityModel, "EntityServiceImpl.ftl", "", "ServiceImpl.java");
                    entityManager = generateCode(entityModel, "EntityManager.ftl", "", "Manager.java");
                    entityManagerImpl = generateCode(entityModel, "EntityManagerImpl.ftl", "", "ManagerImpl.java");
                    break;
                case 3:
                    entity = generateCode(entityModel, "Entity.ftl", "", ".java");
                    entityDto = generateCode(entityModel, "EntityDto.ftl", "", ".java");
                    entityQuery = generateCode(entityModel, "EntityQuery.ftl", "", "Query.java");
                    entityDao = generateCode(entityModel, "EntityDao.ftl", "I", "Dao.java");
                    iEntityService = generateCode(entityModel, "IEntityService.ftl", "I", "Service.java");
                    entityServiceImpl = generateCode(entityModel, "EntityServiceImpl.ftl", "", "ServiceImpl.java");
                    entityMapper = generateCode(entityModel, "EntityMapper.ftl", "", "Mapper.xml");
                    entityApiController = generateCode(entityModel, "EntityApiController.ftl", "", "ApiController.java");
                    view = generateCode(entityModel, "View.ftl", "", ".vue");
                    viewjs = generateCode(entityModel, "View-js.ftl", "", ".ts");
                    entityManager = generateCode(entityModel, "EntityManager.ftl", "", "Manager.java");
                    entityManagerImpl = generateCode(entityModel, "EntityManagerImpl.ftl", "", "ManagerImpl.java");
                    break;
                default:
                    break;
            }
            result.put("Entity.ftl", entity.toString("utf-8"));
            result.put("EntityDto.ftl", entityDto.toString("utf-8"));
            result.put("EntityQuery.ftl", entityQuery.toString("utf-8"));
            result.put("EntityDao.ftl", entityDao.toString("utf-8"));
            result.put("IEntityService.ftl", iEntityService.toString("utf-8"));
            result.put("EntityServiceImpl.ftl", entityServiceImpl.toString("utf-8"));
            result.put("EntityMapper.ftl", entityMapper.toString("utf-8"));
            result.put("EntityApiController.ftl", entityApiController.toString("utf-8"));
            result.put("index.ftl", view.toString("utf-8"));
            result.put("js.ftl", viewjs.toString("utf-8"));
            result.put("EntityManager.ftl", entityManager.toString("utf-8"));
            result.put("EntityManagerImpl.ftl", entityManagerImpl.toString("utf-8"));
        } catch (Exception e) {
            log.error("代码生成出错 {}", e.getMessage());
        }
        return result;
    }


    private ByteArrayOutputStream generateCode(EntityDataModel dataModel, String templateName, String filePrefix, String fileSuffix)
            throws IOException, TemplateException {
        //获取模板路径
        String templatePath = config.getTemplatePath();
        templatePath = templatePath.replace("/", File.separator).replace("\\", File.separator);
        log.info("当前模板路径为：{}", templatePath);

        if (fileSuffix.contains("xml")) {
            dataModel.setInsertValue(autoGeneratorService.handleSQL(dataModel.getColumns(), "insert"));
            dataModel.setUpdateValue(autoGeneratorService.handleSQL(dataModel.getColumns(), "update"));
            dataModel.setStrColumn(autoGeneratorService.handleSQL(dataModel.getColumns(), "columnList"));
        }

        //获取模板对象
        Configuration conf = new Configuration();
        File temp = new File(templatePath);
        conf.setDirectoryForTemplateLoading(temp);
        Template template = conf.getTemplate(templateName);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        Writer writer = new OutputStreamWriter(outputStream);
        //填充数据模型
        template.process(dataModel, writer);
        writer.close();
        return outputStream;
    }
}
