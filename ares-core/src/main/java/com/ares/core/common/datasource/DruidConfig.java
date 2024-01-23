package com.ares.core.common.datasource;

import com.alibaba.druid.filter.config.ConfigTools;
import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.spring.boot3.autoconfigure.DruidDataSourceBuilder;
import com.alibaba.druid.spring.boot3.autoconfigure.properties.DruidStatProperties;
import com.alibaba.druid.util.Utils;
import com.ares.core.utils.SpringUtils;
import jakarta.servlet.*;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @description:
 * @author: Young
 * @date: 2020/07/10
 * @see: com.ares.core.common.datasource.DruidConfig.java
 **/
@Configuration
public class DruidConfig {

    private boolean slaveEnabled = false;
    private boolean neo4jEnabled = false;

    @Bean
    @ConfigurationProperties("spring.datasource.druid.master")
    public DataSource masterDataSource(DruidProperties druidProperties) {
        DruidDataSource dataSource = DruidDataSourceBuilder.create().build();
        return druidProperties.dataSource(dataSource);
    }

    @Bean
    @ConfigurationProperties("spring.datasource.druid.slave")
    @ConditionalOnProperty(prefix = "spring.datasource.druid.slave", name = "enabled", havingValue = "true")
    public DataSource slaveDataSource(DruidProperties druidProperties) {
        DruidDataSource dataSource = DruidDataSourceBuilder.create().build();
        slaveEnabled = true;
        return druidProperties.dataSource(dataSource);
    }

    @Bean
    @ConfigurationProperties("spring.datasource.druid.neo4j")
    @ConditionalOnProperty(prefix = "spring.datasource.neo4j.slave", name = "enabled", havingValue = "true")
    public DataSource neo4jDataSource(DruidProperties druidProperties) {
        DruidDataSource dataSource = DruidDataSourceBuilder.create().build();
        neo4jEnabled = true;
        return druidProperties.dataSource(dataSource);
    }

    @Bean(name = "dynamicDataSource")
    @Primary
    public DynamicDataSource dataSource(DataSource masterDataSource,
                                        DataSource slaveDataSource) throws Exception {
        Map<Object, Object> targetDataSources = new HashMap<>();
        String password = ((DruidDataSource) masterDataSource).getPassword();
        String key = ((DruidDataSource) masterDataSource).getConnectProperties().getProperty("config.decrypt.key");
        ((DruidDataSource) masterDataSource).setPassword(ConfigTools.decrypt(key, password));
        targetDataSources.put(DataSourceType.MASTER.name(), masterDataSource);
        if (slaveEnabled) {
            String slavePassword = ((DruidDataSource) slaveDataSource).getPassword();
            String slaveKey = ((DruidDataSource) slaveDataSource).getConnectProperties().getProperty("config.decrypt.key");
            ((DruidDataSource) slaveDataSource).setPassword(ConfigTools.decrypt(slaveKey, slavePassword));
            targetDataSources.put(DataSourceType.SALVE.name(), slaveDataSource);
        }
        if (neo4jEnabled) {
            setDataSource(targetDataSources, DataSourceType.SALVE.name(), "neo4jDataSource");
        }
        return new DynamicDataSource(masterDataSource, targetDataSources);
    }

    @Bean
    public JdbcTemplate jdbcTemplate(DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }

    /**
     * 设置数据源
     *
     * @param targetDataSources 备选数据源集合
     * @param sourceName        数据源名称
     * @param beanName          bean名称
     */
    public void setDataSource(Map<Object, Object> targetDataSources, String sourceName, String beanName) {
        try {
            DataSource dataSource = SpringUtils.getBean(beanName);
            ((DruidDataSource) dataSource).setTestWhileIdle(false);
            ((DruidDataSource) dataSource).setValidationQuery("CALL db.labels()");
            targetDataSources.put(sourceName, dataSource);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 去除监控页面底部的广告
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @Bean
    @ConditionalOnProperty(name = "spring.datasource.druid.stat-view-servlet.enabled", havingValue = "true")
    public FilterRegistrationBean removeDruidFilterRegistrationBean(DruidStatProperties properties) {
        // 获取web监控页面的参数
        DruidStatProperties.StatViewServlet config = properties.getStatViewServlet();
        // 提取common.js的配置路径
        String pattern = config.getUrlPattern() != null ? config.getUrlPattern() : "/druid/*";
        String commonJsPattern = pattern.replaceAll("\\*", "js/common.js");
        final String filePath = "support/http/resources/js/common.js";
        // 创建filter进行过滤
        Filter filter = new Filter() {
            @Override
            public void init(FilterConfig filterConfig) throws ServletException {
            }

            @Override
            public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
                    throws IOException, ServletException {
                chain.doFilter(request, response);
                // 重置缓冲区，响应头不会被重置
                response.resetBuffer();
                // 获取common.js
                String text = Utils.readFromResource(filePath);
                // 正则替换banner, 除去底部的广告信息
                text = text.replaceAll("<a.*?banner\"></a><br/>", "");
                text = text.replaceAll("powered.*?shrek.wang</a>", "");
                response.getWriter().write(text);
            }

            @Override
            public void destroy() {
            }
        };
        FilterRegistrationBean registrationBean = new FilterRegistrationBean();
        registrationBean.setFilter(filter);
        registrationBean.addUrlPatterns(commonJsPattern);
        return registrationBean;
    }

    //@Bean
    //@ConditionalOnProperty(name = "spring.datasource.druid.web-stat-filter.enabled", havingValue = "true")
    //public FilterRegistrationBean webStatFilter() {
    //    FilterRegistrationBean bean = new FilterRegistrationBean();
    //    Map<String, String> initParams = new HashMap<>();
    //    initParams.put("exclusions", "*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*");
    //    bean.setFilter(new WebStatFilter());
    //    bean.setInitParameters(initParams);
    //    bean.setUrlPatterns(Arrays.asList("/*"));
    //    return bean;
    //}

}
