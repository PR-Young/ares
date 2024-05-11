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


import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.junit.jupiter.api.Test;
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
public class AresTest extends AresBaseTest{

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

    @Test
    public void testJasypt() {
        StandardPBEStringEncryptor stringEncryptor = new StandardPBEStringEncryptor();
        stringEncryptor.setAlgorithm("PBEWithMD5AndDES");
        stringEncryptor.setPassword("ares-2024");
        String pwd = stringEncryptor.encrypt("root1234");
        String dpwd = stringEncryptor.decrypt(pwd);

        System.out.println("加密后：" + pwd);
        System.out.println("解密后：" + dpwd);
    }
}
