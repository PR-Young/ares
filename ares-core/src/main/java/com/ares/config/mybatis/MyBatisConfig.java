package com.ares.config.mybatis;

import org.apache.ibatis.io.VFS;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.boot.autoconfigure.SpringBootVFS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.core.type.classreading.CachingMetadataReaderFactory;
import org.springframework.core.type.classreading.MetadataReader;
import org.springframework.core.type.classreading.MetadataReaderFactory;
import org.springframework.util.ClassUtils;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

/**
 * @description:
 * @author: Young
 * @date: 2020/07/10
 * @see: com.ares.config.mybatis.MyBatisConfig.java
 **/
@Configuration
public class MyBatisConfig {
    @Autowired
    private Environment env;

    private static final String DEFAULT_RESOURCE_PATTERN = "**/*.class";
    private static final String CLASSPATH_ALL_URL_PREFIX = "classpath*:";


    public static String setTypeAliasesPackage(String typeAliasesPackage) {
        if (typeAliasesPackage == null || typeAliasesPackage.trim().isEmpty()) {
            throw new IllegalArgumentException("typeAliasesPackage 不能为空");
        }
        ResourcePatternResolver resolver = (ResourcePatternResolver) new PathMatchingResourcePatternResolver();
        MetadataReaderFactory metadataReaderFactory = new CachingMetadataReaderFactory(resolver);
        Set<String> allResult = new HashSet<>();
        try {
            for (String aliasesPackage : typeAliasesPackage.split(",")) {
                aliasesPackage = CLASSPATH_ALL_URL_PREFIX
                        + ClassUtils.convertClassNameToResourcePath(aliasesPackage.trim()) + "/" + DEFAULT_RESOURCE_PATTERN;
                Resource[] resources = resolver.getResources(aliasesPackage);
                if (resources != null && resources.length > 0) {
                    for (Resource resource : resources) {
                        if (resource.isReadable()) {
                            MetadataReader metadataReader = metadataReaderFactory.getMetadataReader(resource);
                            allResult.add(metadataReader.getClassMetadata().getClassName().substring(0, metadataReader.getClassMetadata().getClassName().lastIndexOf(".")));

                        }
                    }
                }
            }
            if (allResult.isEmpty()) {
                throw new RuntimeException("mybatis typeAliasesPackage 路径扫描错误, 参数 typeAliasesPackage: " + typeAliasesPackage + " 未找到任何包");
            }
            return String.join(",", allResult);
        } catch (IOException e) {
            throw new RuntimeException("扫描 mybatis typeAliasesPackage 时发生错误", e);
        }
    }

    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        String typeAliasesPackage = env.getProperty("mybatis.type-aliases-package");
        String mapperLocations = env.getProperty("mybatis.mapper-locations");
        String configLocation = env.getProperty("mybatis.config-location");
        typeAliasesPackage = setTypeAliasesPackage(typeAliasesPackage);
        VFS.addImplClass(SpringBootVFS.class);

        final SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        sessionFactory.setTypeAliasesPackage(typeAliasesPackage);
        sessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources(mapperLocations));
        sessionFactory.setConfigLocation(new DefaultResourceLoader().getResource(configLocation));
        return sessionFactory.getObject();
    }
}
