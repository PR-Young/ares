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

package com.ares.blog.persistence.service.impl;

import com.ares.blog.persistence.service.IMyBlogService;
import com.ares.core.persistence.service.ISysPropertiesService;
import com.ares.core.utils.JsonUtils;
import com.ares.system.model.query.ArticlesQuery;
import com.ares.system.model.vo.Articles;
import com.ares.system.persistence.service.IArticlesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2021/04/19
 * @see: com.ares.blog.persistence.service.MyBlogService.java
 **/
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
        try {
            String versionInfo = sysPropertiesService.getValueByAlias("version.info");
            String path = versionInfo.replace("/", File.separator);
            FileInputStream fileInputStream = new FileInputStream(path);
            InputStreamReader reader = new InputStreamReader(fileInputStream, "UTF-8");
            BufferedReader bufferedReader = new BufferedReader(reader);
            String result = null;
            while ((result = bufferedReader.readLine()) != null) {
                sb.append(result).append(" \n");
            }

            bufferedReader.close();
            reader.close();
            fileInputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    @Override
    public boolean saveUpdateInfo(String content) {
        try {
            String versionInfo = sysPropertiesService.getValueByAlias("version.info");
            String path = versionInfo.replace("/", File.separator);
            FileOutputStream fileOutputStream = new FileOutputStream(path);
            OutputStreamWriter writer = new OutputStreamWriter(fileOutputStream, "UTF-8");
            writer.write(content);
            writer.close();
            fileOutputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public String getUpdateInfo1() {
        ArticlesQuery articles = new ArticlesQuery();
        articles.setType("1");
        articles.setStatus("1");
        List<Articles> list = articlesService.list(articles);
        return JsonUtils.toJson(list);
    }
}
