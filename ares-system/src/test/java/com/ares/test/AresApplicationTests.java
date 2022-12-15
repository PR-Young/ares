package com.ares.test;


import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.event.AnalysisEventListener;
import com.ares.core.persistence.model.listener.UserDataListener;
import com.ares.core.persistence.model.system.SysUser;
import com.ares.core.persistence.service.ISysUserService;
import com.ares.core.utils.SpringUtils;
import org.junit.jupiter.api.Test;
import org.springframework.core.io.ClassPathResource;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;

public class AresApplicationTests extends AresBaseTest {

    //@Resource
    //AresDocumentRepository repository;
    //
    //
    //@Test
    //public void testES() {
    //
    //    AresDocument demo = new AresDocument("1", "ares-name", "ares-key", "this is a test content.", "this is a test body!");
    //    //repository.save(demo);
    //    ElasticsearchEvent event = new ElasticsearchEvent(demo);
    //    SpringUtils.publishEvent(event);
    //
    //    System.out.println("==================================");
    //    Pageable pageable = PageRequest.of(0, 10);
    //    Page<AresDocument> page = repository.findByContentIsContaining("content", pageable);
    //    System.out.println("search content:" + JSON.toJSON(page.getContent()));
    //    System.out.println("==================================");
    //    System.out.println("all:" + JSON.toJSON(repository.findAll()));
    //}

    @Test
    public void testExcel() throws Exception {
        InputStream in = new FileInputStream("E:\\GitHub\\ares\\doc\\test.xlsx");
        ISysUserService userService = SpringUtils.getBean(ISysUserService.class);
        AnalysisEventListener listener = new UserDataListener(true, "");
        EasyExcel.read(in, SysUser.class, listener).sheet().doRead();
    }

    @Test
    public void test() {
        String result = null;
        try {
            ClassPathResource resource = new ClassPathResource("CHANGELOG.md");
            InputStream inputStream = resource.getInputStream();
            InputStreamReader reader = new InputStreamReader(inputStream);
            BufferedReader bufferedReader = new BufferedReader(reader);

            while ((result = bufferedReader.readLine()) != null) {
                System.out.println(result);
            }

            bufferedReader.close();
            reader.close();
            inputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
