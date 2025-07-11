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

package com.ares.system.controller;

import com.ares.core.model.base.AjaxResult;
import com.ares.core.utils.ServletUtils;
import com.ares.message.persistence.entity.AresDocument;
import com.ares.message.service.IElasticsearchService;
import com.ares.system.service.IIndexService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @description: 主页
 * @author: Young
 * @date: 2020/09/14
 * @see: com.ares.system.controller IndexApiController.java
 **/
@Slf4j
@RestController
@RequestMapping("/index/*")
@Tag(name = "IndexApiController", description = "index")
public class IndexApiController {
    private IIndexService indexService;
    private IElasticsearchService elasticsearchService;

    @Autowired
    public IndexApiController(IIndexService indexService, IElasticsearchService elasticsearchService) {
        this.indexService = indexService;
        this.elasticsearchService = elasticsearchService;
    }

    @GetMapping("panelGroup")
    public Object getPanelGroup() {
        return AjaxResult.successData(indexService.getPanelGroup());
    }

    @GetMapping("lineChartData")
    public Object getLineChartData() {
        return AjaxResult.successData(indexService.getLineChartData());
    }

    @GetMapping("lineChart")
    public Object getLineChart() {
        return AjaxResult.successData(indexService.getLineChart());
    }

    @PostMapping("query")
    public Object query() {
        Map<String, Object> parameter = ServletUtils.getParameter();
        String searchValue = String.valueOf(parameter.get("searchValue"));
        Iterable<AresDocument> aresDocuments = elasticsearchService.query(searchValue);
        return AjaxResult.successData(aresDocuments);
    }
}
