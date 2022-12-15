package com.ares.blog.persistence.service.impl;

import com.ares.blog.persistence.service.IMyBlogService;
import com.ares.core.utils.JsonUtils;
import com.ares.system.persistence.model.Articles;
import com.ares.system.persistence.service.IArticlesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
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

    @Autowired
    public MyBlogServiceImpl(IArticlesService articlesService) {
        this.articlesService = articlesService;
    }

    @Override
    public String getUpdateInfo() {
        StringBuffer sb = new StringBuffer();
        try {
            ClassPathResource resource = new ClassPathResource("/");
            String path = resource.getURL().getPath();
            path = path.replace("target/classes/", "src/main/resources/CHANGELOG.md");
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
            ClassPathResource resource = new ClassPathResource("/");
            String path = resource.getURL().getPath();
            path = path.replace("target/classes/", "src/main/resources/CHANGELOG.md");
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
        Articles articles = new Articles();
        articles.setType("1");
        articles.setStatus("1");
        List<Articles> list = articlesService.list(articles);
        return JsonUtils.toJson(list);
    }
}
