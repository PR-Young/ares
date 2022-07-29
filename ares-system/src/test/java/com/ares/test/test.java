package com.ares.test;

import com.alibaba.druid.filter.config.ConfigTools;

import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;

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
        System.out.println("password:" + ConfigTools.decrypt(arr[0],password));

    }
}
