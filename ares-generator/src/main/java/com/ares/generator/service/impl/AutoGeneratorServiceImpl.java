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

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.StrUtil;
import com.ares.config.gen.GeneratorConfig;
import com.ares.generator.model.query.Column;
import com.ares.generator.model.query.ColumnType;
import com.ares.generator.model.query.DataType;
import com.ares.generator.model.query.EntityDataModel;
import com.ares.generator.model.vo.GenProperties;
import com.ares.generator.service.IAutoGeneratorService;
import com.ares.generator.service.IGenPropertiesService;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * @description:
 * @author: Young
 * @date: 2020/11/11
 * @see: com.ares.generator.persistence.service AutoGeneratorService.java
 **/
@Slf4j
@Service
public class AutoGeneratorServiceImpl implements IAutoGeneratorService {

    private GeneratorConfig config;
    private IGenPropertiesService genPropertiesService;

    @Autowired
    public AutoGeneratorServiceImpl(GeneratorConfig config,
                                    IGenPropertiesService genPropertiesService) {
        this.config = config;
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
    public byte[] generator(String flag, String tableName) {
        init();
        return gen(flag, tableName);
    }

    @Override
    public Connection getConn(String flag) {
        String driver, url, user, pwd;
        if ("master".equalsIgnoreCase(flag)) {
            driver = config.getDriverClassName();
            url = config.getUrl();
            user = config.getUsername();
            pwd = config.getPassword();
        } else {
            driver = config.getSlaveDriverClassName();
            url = config.getSlaveUrl();
            user = config.getSlaveUsername();
            pwd = config.getSlavePassword();
        }
        Connection con = null;
        //注册驱动
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, user, pwd);
        } catch (Exception e) {
            log.error("获取数据连接失败，{}", e.getMessage());
        }
        return con;
    }

    private byte[] gen(String flag, String tableName) {
        Assert.notNull(tableName);
        String tablePrefix;
        if ("master".equalsIgnoreCase(flag)) {
            tablePrefix = config.getTablePrefix();
        } else {
            tablePrefix = config.getSlaveTablePrefix();
        }
        Connection con = getConn(flag);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ZipOutputStream zip = new ZipOutputStream(outputStream);
        String entityDir = autoCodePath();
        try {
            //根据实体包名创建目录
            if (!FileUtil.exist(entityDir)) {
                FileUtil.mkdir(entityDir);
                log.info("创建目录：{} 成功！ ", entityDir);
            }

            EntityDataModel entityModel = getEntityModel(flag, con, tableName, tablePrefix);
            switch (config.getGeneratorLevel()) {
                case 1:
                    generateCode(entityModel, "Entity.ftl", "", ".java", zip);
                    generateCode(entityModel, "EntityDto.ftl", "", "Dto.java", zip);
                    generateCode(entityModel, "EntityQuery.ftl", "", "Query.java", zip);
                    generateCode(entityModel, "EntityMapper.ftl", "", "Mapper.xml", zip);
                    generateCode(entityModel, "EntityDao.ftl", "I", "Dao.java", zip);
                    generateCode(entityModel, "EntityManager.ftl", "", "Manager.java", zip);
                    generateCode(entityModel, "EntityManagerImpl.ftl", "", "ManagerImpl.java", zip);
                    break;
                case 2:
                    generateCode(entityModel, "Entity.ftl", "", ".java", zip);
                    generateCode(entityModel, "EntityDto.ftl", "", "Dto.java", zip);
                    generateCode(entityModel, "EntityQuery.ftl", "", "Query.java", zip);
                    generateCode(entityModel, "EntityMapper.ftl", "", "Mapper.xml", zip);
                    generateCode(entityModel, "EntityDao.ftl", "I", "Dao.java", zip);
                    generateCode(entityModel, "EntityManager.ftl", "", "Manager.java", zip);
                    generateCode(entityModel, "EntityManagerImpl.ftl", "", "ManagerImpl.java", zip);
                    generateCode(entityModel, "IEntityService.ftl", "I", "Service.java", zip);
                    generateCode(entityModel, "EntityServiceImpl.ftl", "", "ServiceImpl.java", zip);
                    break;
                case 3:
                    generateCode(entityModel, "Entity.ftl", "", ".java", zip);
                    generateCode(entityModel, "EntityDto.ftl", "", "Dto.java", zip);
                    generateCode(entityModel, "EntityQuery.ftl", "", "Query.java", zip);
                    generateCode(entityModel, "EntityDao.ftl", "I", "Dao.java", zip);
                    generateCode(entityModel, "EntityManager.ftl", "", "Manager.java", zip);
                    generateCode(entityModel, "EntityManagerImpl.ftl", "", "ManagerImpl.java", zip);
                    generateCode(entityModel, "IEntityService.ftl", "I", "Service.java", zip);
                    generateCode(entityModel, "EntityServiceImpl.ftl", "", "ServiceImpl.java", zip);
                    generateCode(entityModel, "EntityMapper.ftl", "", "Mapper.xml", zip);
                    generateCode(entityModel, "EntityApiController.ftl", "", "ApiController.java", zip);
                    generateCode(entityModel, "View.ftl", "", ".vue", zip);
                    generateCode(entityModel, "View-js.ftl", "", ".ts", zip);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            log.error("代码生成出错 {}", e.getMessage());
        } finally {
            try {
                zip.close();
                deleteFiles(entityDir);
            } catch (IOException e) {
                log.error("error: ", e);
            }
        }
        return outputStream.toByteArray();
    }

    private void generateCode(EntityDataModel dataModel, String templateName, String filePrefix, String fileSuffix, ZipOutputStream zip)
            throws IOException, TemplateException {
        //获取模板路径
        String templatePath = config.getTemplatePath();
        templatePath = templatePath.replace("/", File.separator).replace("\\", File.separator);
        log.info("当前模板路径为：{}", templatePath);
        String outDir = autoCodePath();

        if (fileSuffix.contains("xml")) {
            dataModel.setInsertValue(handleSQL(dataModel.getColumns(), "insert"));
            dataModel.setUpdateValue(handleSQL(dataModel.getColumns(), "update"));
            dataModel.setStrColumn(handleSQL(dataModel.getColumns(), "columnList"));
        }

        String file = outDir + File.separator + filePrefix + dataModel.getEntityName() + fileSuffix;
        if (FileUtil.exist(file)) {
            boolean delete = FileUtil.del(file);
            log.info("文件：{} 已存在，删除:{}", file, delete);
            if (!delete) {
                return;
            }
        }

        //获取模板对象
        Configuration conf = new Configuration();
        File temp = new File(templatePath);
        conf.setDirectoryForTemplateLoading(temp);
        Template template = conf.getTemplate(templateName);
        Writer writer = new FileWriter(file);
        //填充数据模型
        template.process(dataModel, writer);
        writer.close();
        log.info("代码生成成功，文件位置：{}", file);

        try (FileInputStream inputStream = new FileInputStream(new File(file))) {
            zip.putNextEntry(new ZipEntry(new File(file).getName()));
            byte[] buffer = new byte[inputStream.available()];
            int len;
            while ((len = inputStream.read(buffer)) > 0) {
                zip.write(buffer, 0, len);
            }
            zip.flush();
            zip.closeEntry();
        }
    }

    @Override
    public String handleSQL(List<Column> columns, String flag) {
        StringBuffer sb = new StringBuffer();
        switch (flag) {
            case "columnList":
                for (Column column : columns) {
                    sb.append("`").append(column.getColumnName()).append("`,");
                }
                break;
            case "insert":
                sb.append("#{id,jdbcType=BIGINT},\n");
                for (Column column : columns) {
                    sb.append("#{").append(column.getName()).append(",jdbcType=").append(column.getJdbcType()).append("},\n");
                }
                sb.append("#{creator,jdbcType=BIGINT},\n")
                        .append("#{createTime,jdbcType=TIMESTAMP},\n")
                        .append("#{modifier,jdbcType=BIGINT},\n")
                        .append("#{modifyTime,jdbcType=TIMESTAMP}");
                break;
            case "update":
                for (Column column : columns) {
                    sb.append("<if test=\"").append(column.getName()).append("!= null\">\n")
                            .append("`").append(column.getColumnName()).append("`=#{").append(column.getName()).append(",jdbcType=")
                            .append(column.getJdbcType()).append("},").append("\n")
                            .append("</if>\n");
                }
                sb.append("<if test=\"creator != null\">\n")
                        .append("`CREATOR_` = #{creator,jdbcType=TIMESTAMP},\n")
                        .append("</if>\n")
                        .append("<if test=\"createTime != null\">\n")
                        .append("`CREATE_TIME_` = #{createTime,jdbcType=TIMESTAMP},\n")
                        .append("</if>\n")
                        .append("<if test=\"modifier != null\">\n")
                        .append("`MODIFIER_` = #{modifier,jdbcType=TIMESTAMP},\n")
                        .append("</if>\n")
                        .append("<if test=\"modifyTime != null\">\n")
                        .append("`MODIFY_TIME_` = #{modifyTime,jdbcType=TIMESTAMP},\n")
                        .append("</if>");
                break;
            default:
                break;
        }
        return sb.toString();
    }

    @Override
    public EntityDataModel getEntityModel(String flag, Connection con, String tableName, String tablePrefix)
            throws Exception {
        String basePackage = config.getBasePackage();
        String daoPackage = config.getDaoPackage();
        String servicePackage = config.getServicePackage();
        String controllerPackage = config.getControllerPackage();


        //查询表属性,格式化生成实体所需属性
        String sql;
        if ("master".equalsIgnoreCase(flag)) {
            sql = "SELECT table_name, column_name, column_comment, column_type, column_key, column_default "
                    + " FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '" + tableName + "' " + "AND table_schema = '" + config.getDatabaseName() + "'";
        } else {
            sql = "select \"column_name\",udt_name as column_type , '' as column_comment "
                    + "from information_schema.columns where table_schema='" + config.getDatabaseName() + "' and table_name='" + tableName + "' ";
        }
        List<Column> columns = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Column col = new Column();
                String name = rs.getString("column_name");
                String type = rs.getString("column_type");
                String comment = rs.getString("column_comment");
                String annotation = null;
                if ("ID_".equalsIgnoreCase(name)
                        || "CREATE_TIME_".equalsIgnoreCase(name)
                        || "MODIFY_TIME_".equalsIgnoreCase(name)
                        || "CREATOR_".equalsIgnoreCase(name)
                        || "MODIFIER_".equalsIgnoreCase(name)) {
                    continue;
                }
                type = ColumnType.getJavaType(type);
                col.setName(StrUtil.lowerFirst(StrUtil.toCamelCase(name)));
                col.setColumnName(name);
                col.setType(type);
                col.setAnnotation(annotation);
                col.setComment(comment);
                col.setJdbcType(DataType.getJdbcType(type));
                columns.add(col);
            }
        }
        EntityDataModel dataModel = new EntityDataModel();
        dataModel.setEntityPackage(basePackage);
        dataModel.setDaoPackage(daoPackage);
        dataModel.setServicePackage(servicePackage);
        dataModel.setControllerPackage(controllerPackage);
        dataModel.setAuthor(config.getAuthor());
        if (StrUtil.isNotBlank(tablePrefix)) {
            dataModel.setEntityName(StrUtil.upperFirst(StrUtil.toCamelCase(StrUtil.removePrefix(tableName, tablePrefix))));
            dataModel.setEntityName1(StrUtil.lowerFirst(StrUtil.toCamelCase(StrUtil.removePrefix(tableName, tablePrefix))));
        } else {
            dataModel.setEntityName(StrUtil.upperFirst(StrUtil.toCamelCase(tableName)));
            dataModel.setEntityName1(StrUtil.lowerFirst(StrUtil.toCamelCase(tableName)));
        }
        dataModel.setTableName(tableName);
        dataModel.setColumns(columns);
        return dataModel;
    }

    private void deleteFiles(String url) {
        File file = new File(url);
        if (file.isDirectory()) {
            File[] files = file.listFiles();
            for (File f : files != null ? files : new File[0]) {
                FileUtil.del(f);
            }
        }
    }

    private String autoCodePath() {
        String path = config.getProjectPtah();
        path = path.replace("/", File.separator).replace("\\", File.separator);
        return path + File.separator + "autocode";
    }
}
