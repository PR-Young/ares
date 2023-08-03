package com.ares.admin;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.jdbc.JdbcRepositoriesAutoConfiguration;
import org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.Configuration;

/**
 * @description:
 * @author: Young
 * @date: 2020/09/16
 * @see: com.ares.admin.AresAdminApplication.java
 **/
@Configuration
@EnableAdminServer
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class, JdbcRepositoriesAutoConfiguration.class,
        RedisAutoConfiguration.class})
public class AresAdminApplication {
    public static void main(String[] args) {
        SpringApplication.run(AresAdminApplication.class, args);
    }
}
