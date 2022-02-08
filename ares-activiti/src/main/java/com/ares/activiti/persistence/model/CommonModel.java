package com.ares.activiti.persistence.model;

import lombok.Data;
import org.activiti.engine.impl.persistence.entity.ModelEntityImpl;

/**
 * @description:
 * @author: Young
 * @date: 2020/08/27
 * @see: com.ares.activiti.persistence.model NewModel.java
 **/
@Data
public class CommonModel extends ModelEntityImpl {
    private String desc;
    private int revisionNext;
    private PersistentState persistentState;

}
