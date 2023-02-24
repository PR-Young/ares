package com.ares.core.persistence.service;

import com.ares.core.persistence.model.SysDictData;

import java.util.List;

public interface ISysDictDataService extends IBaseService<SysDictData> {

    public List<SysDictData> getDicts(String dictType);

}
