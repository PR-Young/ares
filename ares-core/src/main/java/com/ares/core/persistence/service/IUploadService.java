package com.ares.core.persistence.service;

import org.springframework.web.multipart.MultipartFile;

/**
 * @description:
 * @author: Young
 * @date: 2020/09/25
 * @see: com.ares.core.persistence.service UploadService.java
 **/
public interface IUploadService {

    public String upload(String path, MultipartFile file) throws Exception ;
}
