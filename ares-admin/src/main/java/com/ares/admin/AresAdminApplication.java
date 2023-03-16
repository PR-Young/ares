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

package com.ares.admin;

import cn.dev33.satoken.dao.SaTokenDaoRedisJackson;
import com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration;
import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.jdbc.JdbcRepositoriesAutoConfiguration;
import org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.Configuration;
import springfox.boot.starter.autoconfigure.OpenApiAutoConfiguration;

/**
 * @description:
 * @author: Young
 * @date: 2020/09/16
 * @see: com.ares.admin.AresAdminApplication.java
 **/
@Configuration
@EnableAdminServer
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class, JdbcRepositoriesAutoConfiguration.class,
        OpenApiAutoConfiguration.class, DynamicDataSourceAutoConfiguration.class,
        SaTokenDaoRedisJackson.class,RedisAutoConfiguration.class})
public class AresAdminApplication {
    public static void main(String[] args) {
        SpringApplication.run(AresAdminApplication.class, args);
    }
}
