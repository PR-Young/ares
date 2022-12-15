package com.ares.generator.persistence.service;

/**
 * @description:
 * @author: Young
 * @date: 2020/11/11
 * @see: com.ares.generator.persistence.service AutoGeneratorService.java
 **/
public interface IAutoGeneratorService {

    public byte[] generator(String tableName);


    public byte[] generator(String driver, String url, String user, String pwd, String tableName, String tablePrefix) ;

    public String autoCodePath();
}
