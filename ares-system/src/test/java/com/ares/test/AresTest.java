package com.ares.test;

import org.junit.Test;
import org.springframework.core.io.ClassPathResource;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * @description:
 * @author: Young
 * @date: 2021/04/22
 * @see: com.ares.test.AresTest.java
 **/
public class AresTest {

    @Test
    public void test() {
        StringBuffer sb = new StringBuffer();
        try {
            ClassPathResource resource = new ClassPathResource("CHANGELOG.md");
            InputStream inputStream = resource.getInputStream();
            InputStreamReader reader = new InputStreamReader(inputStream);
            BufferedReader bufferedReader = new BufferedReader(reader);
            String result = null;
            while ((result = bufferedReader.readLine()) != null) {
                sb.append(result);
            }

            bufferedReader.close();
            reader.close();
            inputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(sb);
    }
}
