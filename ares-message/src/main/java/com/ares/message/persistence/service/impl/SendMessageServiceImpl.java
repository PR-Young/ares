package com.ares.message.persistence.service.impl;

import com.ares.message.persistence.service.ISendEmailService;
import com.ares.message.persistence.service.ISendMessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.function.Supplier;

/**
 * @description:
 * @author: Young
 * @date: 2020/08/05
 * @see: com.ares.message.persistence.service SendMessageService.java
 **/
@Service
public class SendMessageServiceImpl implements ISendMessageService {
    private static Logger logger = LoggerFactory.getLogger(SendMessageServiceImpl.class);

    @Resource
    private ISendEmailService emailService;

    /**
     * 异步发送
     */
    @Override
    public void sendAsync() {
        CompletableFuture<Map<String, Object>> future =
                CompletableFuture.supplyAsync(new Supplier<Map<String, Object>>() {
                                                  @Override
                                                  public Map<String, Object> get() {
                                                      Map<String, Object> map = new HashMap<>(10);
                                                      map.put("template", "");
                                                      map.put("receivers", new ArrayList<>());
                                                      map.put("vars", new HashMap<>(10));
                                                      return map;
                                                  }
                                              }
                );
        future.thenAcceptAsync(map -> emailService.send(String.valueOf(map.get("template")), (List<String>) map.get("receivers"), (Map<String, Object>) map.get("vars")));

        try {
            System.out.println(future.get());
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }

    }
}
