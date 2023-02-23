package com.ares.test;

import com.ares.message.handler.AresMessageHandler;
import com.ares.message.utils.AresMessageUtil;

/*
 * @description:
 * @author: Young
 * @date: 2021/11/2
 * @see: com.ares.test.test.java
 */
public class test {
    public static void main(String[] args) throws Exception {
        String password = "root1234";
        //String[] arr = ConfigTools.genKeyPair(512);
        ////System.out.println("privateKey:" + arr[0]);
        //System.out.println("publicKey:" + arr[1]);
        //System.out.println("password:" + ConfigTools.decrypt(arr[0],password));

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

        AresMessageUtil.sendMessage("ares", "success", 1024 * 1024, false, 2, new AresMessageHandler<String>());

    }
}
