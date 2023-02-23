package com.ares.message.persistence.model;

import lombok.Data;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.persistence.model.AresMessageEvent.java
 **/
@Data
public class AresMessageEvent<T> {

    private T obj;

}
