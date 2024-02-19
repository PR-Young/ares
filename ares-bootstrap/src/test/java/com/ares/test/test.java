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

import com.alibaba.druid.filter.config.ConfigTools;

/*
 * @description:
 * @author: Young
 * @date: 2021/11/2
 * @see: com.ares.test.test.java
 */
public class test {
    public static void main(String[] args) throws Exception {
        String password = "root1234";
        String[] arr = ConfigTools.genKeyPair(512);
        //System.out.println("privateKey:" + arr[0]);
        System.out.println("publicKey:" + arr[1]);
        String pwd = ConfigTools.encrypt(arr[0], password);
        System.out.println("password:" + pwd);
        System.out.println(ConfigTools.decrypt(arr[1],pwd));

        //Integer keySize = 512;
        //String[] keyArr = CryptoUtils.genKeyPair(keySize);
        //
        //String privateKey = keyArr[0];
        //System.out.println("私钥： "+privateKey);
        //String publicKey = keyArr[1];
        //System.out.println("公钥： "+publicKey);
        //
        //// 奇异的私钥加密 公钥解密
        //String encryptPwd = CryptoUtils.encrypt
        //        ( privateKey,"root1234");
        //System.out.println("加密后密码: "+encryptPwd);
        //
        //String decryptPwd = CryptoUtils.decrypt(publicKey, encryptPwd);
        //// yourPassWord
        //System.out.println("解密后密码: "+decryptPwd);

        //AresMessageUtil.sendMessage("ares", "success", 1024 * 1024, false, 2, new AresMessageHandler<String>());

        //Server server = new Server();
        //server.copyTo();
        //System.out.println(server);
    }
}
