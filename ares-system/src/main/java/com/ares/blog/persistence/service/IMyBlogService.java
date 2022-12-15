package com.ares.blog.persistence.service;

/**
 * @description:
 * @author: Young
 * @date: 2021/04/19
 * @see: com.ares.blog.persistence.service.MyBlogService.java
 **/
public interface IMyBlogService {

    public String getUpdateInfo();

    public boolean saveUpdateInfo(String content);

    public String getUpdateInfo1();
}
