package com.ares.system.persistence.service;

import com.ares.system.persistence.model.PanelGroup;
import com.ares.system.persistence.model.line.LineChart;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young
 * @date: 2020/09/14
 * @see: com.ares.system.persistence.service IndexService.java
 **/
public interface IIndexService {


    public List<PanelGroup> getPanelGroup() ;


    public Map<String, Object> getLineChartData();

    public LineChart getLineChart() ;
}
