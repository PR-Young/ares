
package com.ares.bootstrap.service.Impl;

import cn.dev33.satoken.stp.StpUtil;
import com.ares.core.common.security.SecurityUtils;
import org.jeecg.modules.jmreport.api.JmReportTokenServiceI;
import org.springframework.stereotype.Service;

/**
 * @description:
 * @author: Young
 * @date: 2023/12/29
 * @see: com.ares.core.common.jmreport.JimuReportTokenService.java
 **/
@Service
public class JimuReportTokenServiceImpl implements JmReportTokenServiceI {
    @Override
    public String getToken() {
        return StpUtil.getTokenValue();
    }

    @Override
    public String getUsername(String token) {
        return SecurityUtils.getUser().getUserName();
    }

    @Override
    public String[] getRoles(String token) {
        return new String[]{"admin", "lowdeveloper", "dbadeveloper"};
    }

    @Override
    public String[] getPermissions(String token) {
        //drag:datasource:testConnection   仪表盘数据库连接测试
        //onl:drag:clear:recovery          清空回收站
        //drag:analysis:sql                SQL解析
        //drag:design:getTotalData         仪表盘对Online表单展示数据
        return new String[]{"drag:datasource:testConnection", "onl:drag:clear:recovery", "drag:analysis:sql", "drag:design:getTotalData"};
    }

    @Override
    public Boolean verifyToken(String token) {
        return true;
    }
}
