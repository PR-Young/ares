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

package com.ares.blog.service.impl;

import com.ares.blog.service.IMyBlogService;
import com.ares.core.service.ISysPropertiesService;
import com.ares.core.utils.JsonUtils;
import com.ares.system.model.query.ArticlesQuery;
import com.ares.system.model.vo.Articles;
import com.ares.system.service.IArticlesService;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;

/**
 * @description:
 * @author: Young
 * @date: 2021/04/19
 * @see: com.ares.blog.persistence.service.MyBlogService.java
 **/
@Slf4j
@Service
public class MyBlogServiceImpl implements IMyBlogService {
    private IArticlesService articlesService;
    private ISysPropertiesService sysPropertiesService;

    @Autowired
    public MyBlogServiceImpl(IArticlesService articlesService, ISysPropertiesService sysPropertiesService) {
        this.articlesService = articlesService;
        this.sysPropertiesService = sysPropertiesService;
    }

    @Override
    public String getUpdateInfo() {
        StringBuffer sb = new StringBuffer();
        String versionInfo = sysPropertiesService.getValueByAlias("version.info");
        String path = versionInfo.replace("/", File.separator);
        try (FileInputStream fileInputStream = new FileInputStream(path);
             InputStreamReader reader = new InputStreamReader(fileInputStream, "UTF-8");
             BufferedReader bufferedReader = new BufferedReader(reader)) {
            String result = null;
            while ((result = bufferedReader.readLine()) != null) {
                sb.append(result).append(" \n");
            }
        } catch (Exception e) {
            log.error("getUpdateInfo error: ", e);
        }
        return sb.toString();
    }

    @Override
    public boolean saveUpdateInfo(String content) {
        String versionInfo = sysPropertiesService.getValueByAlias("version.info");
        String path = versionInfo.replace("/", File.separator);
        try (FileOutputStream fileOutputStream = new FileOutputStream(path);
             OutputStreamWriter writer = new OutputStreamWriter(fileOutputStream, "UTF-8");) {
            writer.write(content);
        } catch (Exception e) {
            log.error("saveUpdateInfo error: ", e);
            return false;
        }
        return true;
    }

    @Override
    public String getUpdateInfo1() {
        ArticlesQuery articles = new ArticlesQuery();
        articles.setType("1");
        articles.setStatus("1");
        PageInfo<Articles> list = articlesService.list(articles);
        return JsonUtils.toJson(list.getList());
    }
}
