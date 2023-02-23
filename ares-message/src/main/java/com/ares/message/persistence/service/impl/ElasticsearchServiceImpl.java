package com.ares.message.persistence.service.impl;

import com.ares.message.persistence.dao.AresDocumentRepository;
import com.ares.message.persistence.model.AresDocument;
import com.ares.message.persistence.service.IElasticsearchService;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.MatchAllQueryBuilder;
import org.elasticsearch.index.query.MatchQueryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.query.NativeSearchQuery;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2022/1/5
 * @see: com.ares.message.persistence.service.ElasticsearchService.java
 */
@Service
public class ElasticsearchServiceImpl implements IElasticsearchService {

    private AresDocumentRepository repository;
    private ElasticsearchRestTemplate restTemplate;

    @Autowired
    public ElasticsearchServiceImpl(AresDocumentRepository repository, ElasticsearchRestTemplate restTemplate) {
        this.repository = repository;
        this.restTemplate = restTemplate;
    }

    @Override
    public void save(AresDocument document) {
        repository.save(document);
    }

    @Override
    public void saveAll(List<AresDocument> documents) {
        repository.saveAll(documents);
    }

    @Override
    public void delete(AresDocument document) {
        repository.delete(document);
    }

    @Override
    public void deleteById(String id) {
        repository.deleteById(id);
    }

    @Override
    public List<AresDocument> query(String value) {
        List<AresDocument> aresDocuments = new ArrayList<>();
        MatchQueryBuilder key = new MatchQueryBuilder("key", value);
        MatchQueryBuilder name = new MatchQueryBuilder("name", value);
        MatchQueryBuilder body = new MatchQueryBuilder("body", value);
        MatchQueryBuilder content = new MatchQueryBuilder("content", value);

        BoolQueryBuilder queryBuilder = new BoolQueryBuilder();
        queryBuilder.should(key).should(name).should(body).should(content);
        NativeSearchQuery query = new NativeSearchQuery(queryBuilder);

        SearchHits<AresDocument> iterable = restTemplate.search(query, AresDocument.class);
        iterable.getSearchHits().forEach(document -> {
            aresDocuments.add(document.getContent());
        });

        return aresDocuments;
    }

    @Override
    public Iterable<AresDocument> queryByFiled(String fieldName, Object value, Pageable pageable) {
        List<AresDocument> aresDocuments = new ArrayList<>();
        MatchQueryBuilder queryBuilder = new MatchQueryBuilder(fieldName, value);
        NativeSearchQuery query = new NativeSearchQuery(queryBuilder);
        query.setPageable(pageable);
        SearchHits<AresDocument> documents = restTemplate.search(query, AresDocument.class);
        documents.getSearchHits().forEach(document -> {
            aresDocuments.add(document.getContent());
        });
        return aresDocuments;
    }

    @Override
    public Iterable<AresDocument> queryAll(Pageable pageable) {
        List<AresDocument> aresDocuments = new ArrayList<>();
        MatchAllQueryBuilder queryBuilder = new MatchAllQueryBuilder();
        NativeSearchQuery query = new NativeSearchQuery(queryBuilder);
        query.setPageable(pageable);
        SearchHits<AresDocument> documents = restTemplate.search(query, AresDocument.class);
        documents.getSearchHits().forEach(document -> {
            aresDocuments.add(document.getContent());
        });
        return aresDocuments;
    }

}
