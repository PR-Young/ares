package com.ares.test;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.HttpHost;
import org.elasticsearch.action.admin.indices.delete.DeleteIndexRequest;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.action.delete.DeleteRequest;
import org.elasticsearch.action.delete.DeleteResponse;
import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.support.master.AcknowledgedResponse;
import org.elasticsearch.action.update.UpdateRequest;
import org.elasticsearch.action.update.UpdateResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.indices.CreateIndexRequest;
import org.elasticsearch.client.indices.CreateIndexResponse;
import org.elasticsearch.client.indices.GetIndexRequest;
import org.elasticsearch.client.indices.GetIndexResponse;
import org.elasticsearch.common.unit.Fuzziness;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.*;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.aggregations.AggregationBuilder;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.sort.SortOrder;

import java.io.IOException;

/*
 * @description:
 * @author: Young
 * @date: 2021/12/30
 * @see: com.ares.test.ESTest.java
 */
public class ESTest {
    public static void main(String[] args) throws Exception {
        ESTest test = new ESTest();
        RestHighLevelClient client = new RestHighLevelClient(
                RestClient.builder(new HttpHost("localhost", 9200, "http"))
        );
        //创建索引
        //test.createIndex(client);
        //查询索引
        //test.getIndex(client);
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
        test.searchData11(client);
        client.close();
    }

    private void createIndex(RestHighLevelClient client) throws IOException {
        CreateIndexRequest people = new CreateIndexRequest("people");
        CreateIndexResponse response = client.indices().create(people, RequestOptions.DEFAULT);
        boolean acknowledged = response.isAcknowledged();
        System.out.println("索引操作：" + acknowledged);
    }

    private void getIndex(RestHighLevelClient client) throws IOException {
        GetIndexRequest getPeople = new GetIndexRequest("people");
        GetIndexResponse getResponse = client.indices().get(getPeople, RequestOptions.DEFAULT);
        System.out.println(getResponse.getAliases());
        System.out.println(getResponse.getMappings());
        System.out.println(getResponse.getSettings());
    }

    private void delIndex(RestHighLevelClient client) throws IOException {
        DeleteIndexRequest delPeople = new DeleteIndexRequest("people");
        AcknowledgedResponse delResponse = client.indices().delete(delPeople, RequestOptions.DEFAULT);
        System.out.println(delResponse.isAcknowledged());
    }

    private void insertData(RestHighLevelClient client) throws IOException {
        IndexRequest request = new IndexRequest();
        request.index("people").id("1001");
        People people = new People();
        people.setName("张三");
        people.setSex("男");
        people.setAge(30);
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(people);
        request.source(json, XContentType.JSON);
        IndexResponse indexResponse = client.index(request, RequestOptions.DEFAULT);
        System.out.println(indexResponse.getResult());
    }

    private void updateData(RestHighLevelClient client) throws IOException {
        UpdateRequest request = new UpdateRequest();
        request.index("people").id("1001");
        request.doc(XContentType.JSON, "age", 29);
        UpdateResponse response = client.update(request, RequestOptions.DEFAULT);
        System.out.println(response.getResult());
    }

    private void getData(RestHighLevelClient client) throws IOException {
        GetRequest request = new GetRequest();
        request.index("people").id("1001");
        GetResponse response = client.get(request, RequestOptions.DEFAULT);
        System.out.println(response.getSourceAsString());
    }

    private void delData(RestHighLevelClient client) throws IOException {
        DeleteRequest request = new DeleteRequest();
        request.index("people").id("1001");
        DeleteResponse response = client.delete(request, RequestOptions.DEFAULT);
        System.out.println(response.getResult());
    }

    private void batchInsertData(RestHighLevelClient client) throws IOException {
        BulkRequest request = new BulkRequest();
        request.add(new IndexRequest().index("people").id("1001")
                .source(XContentType.JSON, "name", "tom", "sex", "男", "age", 20));
        request.add(new IndexRequest().index("people").id("1002")
                .source(XContentType.JSON, "name", "里斯", "sex", "男", "age", 30));
        request.add(new IndexRequest().index("people").id("1003")
                .source(XContentType.JSON, "name", "美美", "sex", "女", "age", 20));
        request.add(new IndexRequest().index("people").id("1004")
                .source(XContentType.JSON, "name", "tom1", "sex", "男", "age", 40));
        request.add(new IndexRequest().index("people").id("1005")
                .source(XContentType.JSON, "name", "里斯1", "sex", "男", "age", 23));
        request.add(new IndexRequest().index("people").id("1006")
                .source(XContentType.JSON, "name", "美美1", "sex", "女", "age", 20));
        request.add(new IndexRequest().index("people").id("1007")
                .source(XContentType.JSON, "name", "tom3", "sex", "男", "age", 26));
        request.add(new IndexRequest().index("people").id("1008")
                .source(XContentType.JSON, "name", "里斯3", "sex", "男", "age", 25));
        request.add(new IndexRequest().index("people").id("1009")
                .source(XContentType.JSON, "name", "美美3", "sex", "男", "age", 27));
        BulkResponse response = client.bulk(request, RequestOptions.DEFAULT);
        System.out.println(response.getTook());
        System.out.println(response.getItems());
    }

    private void batchDelData(RestHighLevelClient client) throws IOException {
        BulkRequest request = new BulkRequest();
        request.add(new DeleteRequest().index("people").id("1002"));
        request.add(new DeleteRequest().index("people").id("1003"));
        request.add(new DeleteRequest().index("people").id("1004"));
        BulkResponse response = client.bulk(request, RequestOptions.DEFAULT);
        System.out.println(response.getTook());
        System.out.println(response.getItems());
    }

    private void searchData(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        request.source(new SearchSourceBuilder().query(QueryBuilders.matchAllQuery()));
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }

    private void searchData2(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        request.source(new SearchSourceBuilder().query(QueryBuilders.termQuery("age", 20)));
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }

    private void searchData3(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        SearchSourceBuilder query = new SearchSourceBuilder().query(QueryBuilders.matchAllQuery());
        //(当前页码-1)*每页显示条数
        query.from(0).size(2);
        request.source(query);
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }

    private void searchData4(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        SearchSourceBuilder query = new SearchSourceBuilder().query(QueryBuilders.matchAllQuery());
        query.sort("age", SortOrder.DESC);
        request.source(query);
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }

    private void searchData5(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        SearchSourceBuilder query = new SearchSourceBuilder().query(QueryBuilders.matchAllQuery());
        String[] excludes = {};
        String[] includes = {"name"};
        query.fetchSource(includes, excludes);
        request.source(query);
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }

    private void searchData6(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        SearchSourceBuilder query = new SearchSourceBuilder();
        BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
        //boolQueryBuilder.must(QueryBuilders.matchQuery("age", 20));
        //boolQueryBuilder.mustNot(QueryBuilders.matchQuery("sex", "男"));
        boolQueryBuilder.should(QueryBuilders.matchQuery("age", 25));
        boolQueryBuilder.should(QueryBuilders.matchQuery("age", 20));
        query.query(boolQueryBuilder);
        request.source(query);
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }

    private void searchData7(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        SearchSourceBuilder query = new SearchSourceBuilder();
        RangeQueryBuilder rangeQuery = QueryBuilders.rangeQuery("age");
        rangeQuery.gte(25).lte(50);
        query.query(rangeQuery);
        request.source(query);
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }

    private void searchData8(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        SearchSourceBuilder query = new SearchSourceBuilder();
        FuzzyQueryBuilder fuzzyQuery = QueryBuilders.fuzzyQuery("name", "tom").fuzziness(Fuzziness.ONE);
        query.query(fuzzyQuery);
        request.source(query);
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }

    private void searchData9(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        SearchSourceBuilder query = new SearchSourceBuilder();
        TermQueryBuilder termQuery = QueryBuilders.termQuery("name", "tom");
        HighlightBuilder highlightBuilder = new HighlightBuilder();
        highlightBuilder.preTags("<font color='red'>");
        highlightBuilder.postTags("</font>");
        highlightBuilder.field("name");
        query.highlighter(highlightBuilder);
        query.query(termQuery);
        request.source(query);
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }

    private void searchData10(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        SearchSourceBuilder query = new SearchSourceBuilder();
        AggregationBuilder aggregationBuilder = AggregationBuilders.max("maxAge").field("age");
        query.aggregation(aggregationBuilder);
        request.source(query);
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }

    private void searchData11(RestHighLevelClient client) throws IOException {
        SearchRequest request = new SearchRequest();
        request.indices("people");
        SearchSourceBuilder query = new SearchSourceBuilder();
        AggregationBuilder aggregationBuilder = AggregationBuilders.terms("ageGroup").field("age");
        query.aggregation(aggregationBuilder);
        request.source(query);
        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        SearchHits hits = response.getHits();
        System.out.println(hits.getTotalHits());
        System.out.println(response.getTook());
        for (SearchHit hit : hits) {
            System.out.println(hit.getSourceAsString());
        }
    }
}
