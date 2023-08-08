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

package com.ares.blog.controller;

import com.ares.blog.persistence.service.IMyBlogService;
import com.ares.core.common.log.Log;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.utils.ServletUtils;
import com.ares.system.model.query.ArticlesQuery;
import com.ares.system.persistence.service.IArticlesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @description:
 * @author: Young
 * @date: 2021/04/19
 * @see: com.ares.blog.controller.MyBlogController.java
 **/
@Log(isIgnore = true)
@RestController
@RequestMapping("/blog/*")
public class MyBlogController {
    private IMyBlogService blogService;
    private IArticlesService articlesService;

    @Autowired
    public MyBlogController(IMyBlogService blogService, IArticlesService articlesService) {
        this.blogService = blogService;
        this.articlesService = articlesService;
    }

    @GetMapping("updateInfo")
    public AjaxResult getUpdateInfo() {
        return AjaxResult.successData(blogService.getUpdateInfo());
    }

    @PostMapping("saveUpdateInfo")
    public AjaxResult saveUpdateInfo() {
        Map<String, Object> parameter = ServletUtils.getParameter();
        String content = String.valueOf(parameter.get("content"));
        return AjaxResult.successData(blogService.saveUpdateInfo(content));
    }


    @GetMapping("updateInfo1")
    public AjaxResult getUpdateInfo1() {
        return AjaxResult.successData(blogService.getUpdateInfo1());
    }

    @GetMapping("getArticles")
    public AjaxResult getArticles() {
        ArticlesQuery articles = new ArticlesQuery();
        articles.setStatus("1");
        return AjaxResult.successData(articlesService.list(articles));
    }

    @GetMapping("getArticle/{id}")
    public AjaxResult getArticles(@PathVariable Long id) {
        return AjaxResult.successData(articlesService.getById(id));
    }
}
