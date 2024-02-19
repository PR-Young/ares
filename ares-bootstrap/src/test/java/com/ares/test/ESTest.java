/*
 *
 *  * ****************************************************************************
 *  * * Copyright (c) 2021 - 9999, ARES
 *  * *
 *  * * Licensed under the Apache License, Version 2.0 (the "License");
 *  * * you may not use this file except in compliance with the License.
 *  * * You may obtain a copy of the License at
 *  * *
 *  * *        http://www.apache.org/licenses/LICENSE-2.0
 *  * *
 *  * * Unless required by applicable law or agreed to in writing, software
 *  * * distributed under the License is distributed on an "AS IS" BASIS,
 *  * * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * * See the License for the specific language governing permissions and
 *  * * limitations under the License.
 *  * ***************************************************************************
 *
 */

package com.ares.test;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch._types.AcknowledgedResponse;
import co.elastic.clients.elasticsearch.core.*;
import co.elastic.clients.elasticsearch.indices.*;
import co.elastic.clients.json.jackson.JacksonJsonpMapper;
import co.elastic.clients.transport.rest_client.RestClientTransport;
import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/*
 * @description:
 * @author: Young
 * @date: 2021/12/30
 * @see: com.ares.test.ESTest.java
 */
public class ESTest {
    public static void main(String[] args) throws Exception {
        ESTest test = new ESTest();
        HttpHost httpHost = new HttpHost("localhost", 9200, "http");
        RestClient restClient = RestClient.builder(httpHost).build();
        RestClientTransport transport = new RestClientTransport(restClient, new JacksonJsonpMapper());
        ElasticsearchClient client = new ElasticsearchClient(transport);
        //创建索引
        //test.createIndex(client);
        //查询索引
        test.getIndex(client);
        //删除索引
        //test.delIndex(client);
        //插入数据
        //test.insertData(client);
        //修改数据
        //test.updateData(client);
        //查询数据
        //test.getData(client);
        //删除数据
        //test.delData(client);
        //test.getData(client);
        //批量插入数据
        //test.batchInsertData(client);
        //批量删除
        //test.batchDelData(client);
        //全量查询
        //test.searchData(client);
        //条件查询
        //test.searchData2(client);
        //分页查询
        //test.searchData3(client);
        //查询排序
        //test.searchData4(client);
        //过滤字段
        //test.searchData5(client);
        //组合查询
        //test.searchData6(client);
        //范围查询
        //test.searchData7(client);
        //模糊查询
        //test.searchData8(client);
        //高亮查询
        //test.searchData9(client);
        //聚合操作
        //test.searchData10(client);
        //分组查询
        //test.searchData11(client);
    }

    private void createIndex(ElasticsearchClient client) throws IOException {
        CreateIndexRequest people = new CreateIndexRequest.Builder().index("people").build();
        CreateIndexResponse response = client.indices().create(people);
        boolean acknowledged = response.acknowledged();
        System.out.println("索引操作：" + acknowledged);
    }

    private void getIndex(ElasticsearchClient client) throws IOException {
        GetIndexRequest getPeople = new GetIndexRequest.Builder().index("people").build();
        GetIndexResponse getResponse = client.indices().get(getPeople);
        System.out.println(getResponse.result());
    }

    private void delIndex(ElasticsearchClient client) throws IOException {
        DeleteIndexRequest delPeople = new DeleteIndexRequest.Builder().index("people").build();
        AcknowledgedResponse delResponse = client.indices().delete(delPeople);
        System.out.println(delResponse.acknowledged());
    }

    private void insertData(ElasticsearchClient client) throws IOException {
        People people = new People();
        people.setName("张三");
        people.setSex("男");
        people.setAge(30);
        IndexRequest<People> request = new IndexRequest.Builder<People>()
                .index("people")
                .id("1001")
                .document(people).build();
        IndexResponse indexResponse = client.index(request);
        System.out.println(indexResponse);
    }

    private void updateData(ElasticsearchClient client) throws IOException {
        Map<String,Object> map = new HashMap<>();
        map.put("age", 29);
        UpdateRequest<People, Map> request = new UpdateRequest.Builder<People,Map>()
                .index("people").id("1001").doc(map).build();
        UpdateResponse response = client.update(request,People.class);
        System.out.println(response);
    }

    private void getData(ElasticsearchClient client) throws IOException {
        GetRequest request = new GetRequest.Builder().index("people").id("1001").build();
        GetResponse response = client.get(request,People.class);
        System.out.println(response);
    }

    private void delData(ElasticsearchClient client) throws IOException {
        DeleteRequest request = new DeleteRequest.Builder().index("people").id("1001").build();
        DeleteResponse response = client.delete(request);
        System.out.println(response);
    }

    //private void batchInsertData(ElasticsearchClient client) throws IOException {
    //    BulkRequest request = new BulkRequest.Builder()..build();
    //    request.add(new IndexRequest().index("people").id("1001")
    //            .source(XContentType.JSON, "name", "tom", "sex", "男", "age", 20));
    //    request.add(new IndexRequest().index("people").id("1002")
    //            .source(XContentType.JSON, "name", "里斯", "sex", "男", "age", 30));
    //    request.add(new IndexRequest().index("people").id("1003")
    //            .source(XContentType.JSON, "name", "美美", "sex", "女", "age", 20));
    //    request.add(new IndexRequest().index("people").id("1004")
    //            .source(XContentType.JSON, "name", "tom1", "sex", "男", "age", 40));
    //    request.add(new IndexRequest().index("people").id("1005")
    //            .source(XContentType.JSON, "name", "里斯1", "sex", "男", "age", 23));
    //    request.add(new IndexRequest().index("people").id("1006")
    //            .source(XContentType.JSON, "name", "美美1", "sex", "女", "age", 20));
    //    request.add(new IndexRequest().index("people").id("1007")
    //            .source(XContentType.JSON, "name", "tom3", "sex", "男", "age", 26));
    //    request.add(new IndexRequest().index("people").id("1008")
    //            .source(XContentType.JSON, "name", "里斯3", "sex", "男", "age", 25));
    //    request.add(new IndexRequest().index("people").id("1009")
    //            .source(XContentType.JSON, "name", "美美3", "sex", "男", "age", 27));
    //    BulkResponse response = client.bulk(request, RequestOptions.DEFAULT);
    //    System.out.println(response.getTook());
    //    System.out.println(response.getItems());
    //}
    //
    //private void batchDelData(ElasticsearchClient client) throws IOException {
    //    BulkRequest request = new BulkRequest();
    //    request.add(new DeleteRequest().index("people").id("1002"));
    //    request.add(new DeleteRequest().index("people").id("1003"));
    //    request.add(new DeleteRequest().index("people").id("1004"));
    //    BulkResponse response = client.bulk(request, RequestOptions.DEFAULT);
    //    System.out.println(response.getTook());
    //    System.out.println(response.getItems());
    //}
    //
    //private void searchData(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest();
    //    request.indices("people");
    //    request.source(new SearchSourceBuilder().query(QueryBuilders.matchAllQuery()));
    //    SearchResponse response = client.search(request, RequestOptions.DEFAULT);
    //    SearchHits hits = response.getHits();
    //    System.out.println(hits.getTotalHits());
    //    System.out.println(response.getTook());
    //    for (SearchHit hit : hits) {
    //        System.out.println(hit.getSourceAsString());
    //    }
    //}
    //
    //private void searchData2(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest();
    //    request.indices("people");
    //    request.source(new SearchSourceBuilder().query(QueryBuilders.termQuery("age", 20)));
    //    SearchResponse response = client.search(request, RequestOptions.DEFAULT);
    //    SearchHits hits = response.getHits();
    //    System.out.println(hits.getTotalHits());
    //    System.out.println(response.getTook());
    //    for (SearchHit hit : hits) {
    //        System.out.println(hit.getSourceAsString());
    //    }
    //}
    //
    //private void searchData3(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest();
    //    request.indices("people");
    //    SearchSourceBuilder query = new SearchSourceBuilder().query(QueryBuilders.matchAllQuery());
    //    //(当前页码-1)*每页显示条数
    //    query.from(0).size(2);
    //    request.source(query);
    //    SearchResponse response = client.search(request, RequestOptions.DEFAULT);
    //    SearchHits hits = response.getHits();
    //    System.out.println(hits.getTotalHits());
    //    System.out.println(response.getTook());
    //    for (SearchHit hit : hits) {
    //        System.out.println(hit.getSourceAsString());
    //    }
    //}
    //
    //private void searchData4(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest();
    //    request.indices("people");
    //    SearchSourceBuilder query = new SearchSourceBuilder().query(QueryBuilders.matchAllQuery());
    //    query.sort("age", SortOrder.DESC);
    //    request.source(query);
    //    SearchResponse response = client.search(request, RequestOptions.DEFAULT);
    //    SearchHits hits = response.getHits();
    //    System.out.println(hits.getTotalHits());
    //    System.out.println(response.getTook());
    //    for (SearchHit hit : hits) {
    //        System.out.println(hit.getSourceAsString());
    //    }
    //}
    //
    //private void searchData5(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest();
    //    request.indices("people");
    //    SearchSourceBuilder query = new SearchSourceBuilder().query(QueryBuilders.matchAllQuery());
    //    String[] excludes = {};
    //    String[] includes = {"name"};
    //    query.fetchSource(includes, excludes);
    //    request.source(query);
    //    SearchResponse response = client.search(request, RequestOptions.DEFAULT);
    //    SearchHits hits = response.getHits();
    //    System.out.println(hits.getTotalHits());
    //    System.out.println(response.getTook());
    //    for (SearchHit hit : hits) {
    //        System.out.println(hit.getSourceAsString());
    //    }
    //}
    //
    //private void searchData6(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest();
    //    request.indices("people");
    //    SearchSourceBuilder query = new SearchSourceBuilder();
    //    BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
    //    //boolQueryBuilder.must(QueryBuilders.matchQuery("age", 20));
    //    //boolQueryBuilder.mustNot(QueryBuilders.matchQuery("sex", "男"));
    //    boolQueryBuilder.should(QueryBuilders.matchQuery("age", 25));
    //    boolQueryBuilder.should(QueryBuilders.matchQuery("age", 20));
    //    query.query(boolQueryBuilder);
    //    request.source(query);
    //    SearchResponse response = client.search(request, RequestOptions.DEFAULT);
    //    SearchHits hits = response.getHits();
    //    System.out.println(hits.getTotalHits());
    //    System.out.println(response.getTook());
    //    for (SearchHit hit : hits) {
    //        System.out.println(hit.getSourceAsString());
    //    }
    //}
    //
    //private void searchData7(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest();
    //    request.indices("people");
    //    SearchSourceBuilder query = new SearchSourceBuilder();
    //    RangeQueryBuilder rangeQuery = QueryBuilders.rangeQuery("age");
    //    rangeQuery.gte(25).lte(50);
    //    query.query(rangeQuery);
    //    request.source(query);
    //    SearchResponse response = client.search(request, RequestOptions.DEFAULT);
    //    SearchHits hits = response.getHits();
    //    System.out.println(hits.getTotalHits());
    //    System.out.println(response.getTook());
    //    for (SearchHit hit : hits) {
    //        System.out.println(hit.getSourceAsString());
    //    }
    //}
    //
    //private void searchData8(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest();
    //    request.indices("people");
    //    SearchSourceBuilder query = new SearchSourceBuilder();
    //    FuzzyQueryBuilder fuzzyQuery = QueryBuilders.fuzzyQuery("name", "tom").fuzziness(Fuzziness.ONE);
    //    query.query(fuzzyQuery);
    //    request.source(query);
    //    SearchResponse response = client.search(request, RequestOptions.DEFAULT);
    //    SearchHits hits = response.getHits();
    //    System.out.println(hits.getTotalHits());
    //    System.out.println(response.getTook());
    //    for (SearchHit hit : hits) {
    //        System.out.println(hit.getSourceAsString());
    //    }
    //}
    //
    //private void searchData9(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest();
    //    request.indices("people");
    //    SearchSourceBuilder query = new SearchSourceBuilder();
    //    TermQueryBuilder termQuery = QueryBuilders.termQuery("name", "tom");
    //    HighlightBuilder highlightBuilder = new HighlightBuilder();
    //    highlightBuilder.preTags("<font color='red'>");
    //    highlightBuilder.postTags("</font>");
    //    highlightBuilder.field("name");
    //    query.highlighter(highlightBuilder);
    //    query.query(termQuery);
    //    request.source(query);
    //    SearchResponse response = client.search(request, RequestOptions.DEFAULT);
    //    SearchHits hits = response.getHits();
    //    System.out.println(hits.getTotalHits());
    //    System.out.println(response.getTook());
    //    for (SearchHit hit : hits) {
    //        System.out.println(hit.getSourceAsString());
    //    }
    //}
    //
    //private void searchData10(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest();
    //    request.indices("people");
    //    SearchSourceBuilder query = new SearchSourceBuilder();
    //    AggregationBuilder aggregationBuilder = AggregationBuilders.max("maxAge").field("age");
    //    query.aggregation(aggregationBuilder);
    //    request.source(query);
    //    SearchResponse response = client.search(request, RequestOptions.DEFAULT);
    //    SearchHits hits = response.getHits();
    //    System.out.println(hits.getTotalHits());
    //    System.out.println(response.getTook());
    //    for (SearchHit hit : hits) {
    //        System.out.println(hit.getSourceAsString());
    //    }
    //}
    //
    //private void searchData11(ElasticsearchClient client) throws IOException {
    //    SearchRequest request = new SearchRequest.Builder()
    //            .aggregations("age",AggregationBuilders.terms().format("ageGroup").build()._toAggregation())
    //            .build();
    //
    //    SearchResponse response = client.search(request,null);
    //    HitsMetadata hits = response.hits();
    //    System.out.println(hits.total());
    //    System.out.println(response.hits());
    //    for (Object hit : hits.hits()) {
    //        System.out.println(hit);
    //    }
    //}
}
