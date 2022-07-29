package com.ares.test;

import com.ares.AresSystemApplication;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @description:
 * @author: Young
 * @date: 2021/03/01
 * @see: com.ares.test AresBaseTest.java
 **/
@RunWith(SpringRunner.class)
@SpringBootTest(classes = AresSystemApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class AresBaseTest {
    protected static final Logger log = LoggerFactory.getLogger(AresBaseTest.class);

    @Test
    public void contextLoads() {
        log.info("ok!");
    }
}
