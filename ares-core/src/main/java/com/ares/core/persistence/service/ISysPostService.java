package com.ares.core.persistence.service;

import com.ares.core.persistence.model.SysPost;

import java.util.List;

/**
 * @author young
 */
public interface ISysPostService extends IBaseService<SysPost> {

    public List<SysPost> getAll();

}
