package com.ares.test.leetcode;


import org.junit.jupiter.api.Test;

/**
 * @description:
 * @author: Young
 * @date: 2020/09/28
 * @see: com.ares.test.leetcode AresTest.java
 **/
public class AresTest {

    @Test
    public void testPath() {
        String path = AresTest.class.getResource("/").getPath();

        System.out.println(path);
    }
}
