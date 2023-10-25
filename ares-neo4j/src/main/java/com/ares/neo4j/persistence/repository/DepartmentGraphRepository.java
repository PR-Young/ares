/*
 * !******************************************************************************
 *  * Copyright (c) 2021 - 9999, ARES
 *  *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  *
 *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *  *****************************************************************************
 */

package com.ares.neo4j.persistence.repository;

import com.ares.neo4j.persistence.entity.DepartmentGraph;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.stereotype.Repository;

/**
 * @description:
 * @author: Young
 * @date: 2020/10/28
 * @see: com.ares.neo4j.persistence.dao DepartmentGraphRepostory.java
 **/
@Repository
public interface DepartmentGraphRepository extends Neo4jRepository<DepartmentGraph, Long> {
}
