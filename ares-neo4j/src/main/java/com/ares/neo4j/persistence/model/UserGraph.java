package com.ares.neo4j.persistence.model;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.neo4j.core.schema.GeneratedValue;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;


/**
 * @description:
 * @author: Young
 * @date: 2020/10/28
 * @see: com.ares.neo4j.persistence.model UserGraph.java
 **/
@Node
@Builder
@Data
public class UserGraph {

    @Id
    @GeneratedValue
    private Long id;

    private String name;
}
