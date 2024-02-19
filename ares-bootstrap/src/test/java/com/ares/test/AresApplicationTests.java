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

package com.ares.test;


import com.alibaba.fastjson.JSON;
import com.ares.core.model.listener.ElasticsearchEvent;
import com.ares.core.utils.SpringUtils;
import com.ares.message.persistence.dao.AresDocumentRepository;
import com.ares.message.persistence.entity.AresDocument;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.client.elc.ElasticsearchTemplate;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

public class AresApplicationTests extends AresBaseTest {

    @Resource
    AresDocumentRepository repository;
    @Resource
    private ElasticsearchTemplate restTemplate;


    @Test
    public void testES() {

        AresDocument demo = new AresDocument("1", "ares-name", "ares-key", "this is a test content.", "this is a test body!");
        repository.save(demo);
        ElasticsearchEvent event = new ElasticsearchEvent(demo);
        SpringUtils.publishEvent(event);

        System.out.println("==================================");
        Pageable pageable = PageRequest.of(0, 10);
        Page<AresDocument> page = repository.findByContentIsContaining("content", pageable);
        System.out.println("search content:" + JSON.toJSON(page.getContent()));
        System.out.println("==================================");
        System.out.println("all:" + JSON.toJSON(repository.findAll()));
    }

    @Test
    public void testExcel() throws Exception {
        //InputStream in = new FileInputStream("E:\\GitHub\\ares\\doc\\test.xlsx");
        //ISysUserService userService = SpringUtils.getBean(ISysUserService.class);
        //AnalysisEventListener listener = new UserDataListener(true, "");
        //EasyExcel.read(in, SysUser.class, listener).sheet().doRead();
    }

    @Test
    public void test() {
        String result = null;
        try {
            ClassPathResource resource = new ClassPathResource("CHANGELOG.md");
            InputStream inputStream = resource.getInputStream();
            InputStreamReader reader = new InputStreamReader(inputStream);
            BufferedReader bufferedReader = new BufferedReader(reader);

            while ((result = bufferedReader.readLine()) != null) {
                System.out.println(result);
            }

            bufferedReader.close();
            reader.close();
            inputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testElas() {
        //MatchQueryBuilder builder = new MatchQueryBuilder("category", "小米");
        //NativeSearchQuery query = new NativeSearchQuery(builder);
        //SearchHits<Map> search = restTemplate.search(query, Map.class);
        //search.stream().forEach(item -> {
        //    System.out.println(item);
        //});
    }

}
