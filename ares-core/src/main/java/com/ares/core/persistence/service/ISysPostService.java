package com.ares.core.persistence.service;

import com.ares.core.persistence.model.system.SysPost;

import java.util.List;

/**
 * @author young
 */
public interface ISysPostService extends IBaseService<SysPost> {

    public List<SysPost> getAll();

}
