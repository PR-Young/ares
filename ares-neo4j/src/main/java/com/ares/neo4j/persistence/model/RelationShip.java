package com.ares.neo4j.persistence.model;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.neo4j.core.schema.GeneratedValue;
import org.springframework.data.neo4j.core.schema.Id;


/**
 * @description:
 * @author: Young
 * @date: 2020/10/28
 * @see: com.ares.neo4j.persistence.model RelationShip.java
 **/
@Data
@Builder
public class RelationShip {

    @Id
    @GeneratedValue
    private Long id;

    private String indexName;

    private UserGraph userGraph;

    private DepartmentGraph departmentGraph;

    private String post;
}
