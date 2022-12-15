package com.ares.message.persistence.service;

import com.ares.message.persistence.model.AresDocument;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2022/1/5
 * @see: com.ares.message.persistence.service.ElasticsearchService.java
 */
public interface IElasticsearchService {

    public void save(AresDocument document) ;

    public void saveAll(List<AresDocument> documents);

    public void delete(AresDocument document) ;

    public void deleteById(String id) ;

    public List<AresDocument> query(String value);

    public Iterable<AresDocument> queryByFiled(String fieldName, Object value, Pageable pageable);

    public Iterable<AresDocument> queryAll(Pageable pageable);
    
}
