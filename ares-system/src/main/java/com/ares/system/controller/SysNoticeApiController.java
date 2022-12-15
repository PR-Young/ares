package com.ares.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.exception.UserException;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.core.persistence.model.page.TableDataInfo;
import com.ares.core.persistence.model.system.SysNotice;
import com.ares.core.persistence.service.ISysNoticeService;
import com.ares.core.utils.StringUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * @description: 通知
 * @author: Young
 */
@RestController
@RequestMapping("/system/notice/*")
@Api(value = "通知公告API", tags = {"通知公告"})
public class SysNoticeApiController extends BaseController {

    private ISysNoticeService sysNoticeService;

    @Autowired
    public SysNoticeApiController(ISysNoticeService sysNoticeService) {
        this.sysNoticeService = sysNoticeService;
    }

    @SaCheckPermission("notice:list")
    @RequestMapping("list")
    @ApiOperation(value = "通知公告列表", response = TableDataInfo.class)
    public TableDataInfo list(SysNotice sysNotice) {
        startPage();
        List<SysNotice> sysNoticeList = sysNoticeService.list(sysNotice);
        return getDataTable(sysNoticeList);
    }

    @GetMapping("{noticeId}")
    @ApiOperation(value = "根据Id获取通知公告", response = Object.class)
    public Object getInfo(@PathVariable String noticeId) {
        return AjaxResult.successData(sysNoticeService.getById(noticeId));
    }

    @SaCheckPermission("notice:edit")
    @PostMapping("edit")
    @ApiOperation(value = "新增/修改通知公告", response = Object.class)
    public Object edit(@Validated @RequestBody SysNotice sysNotice) throws Exception {
        if (StringUtils.isEmpty(sysNotice.getId())) {
            sysNotice.setCreator(SecurityUtils.getUser().getId());
            sysNoticeService.insert(sysNotice);
        } else {
            sysNotice.setModifier(SecurityUtils.getUser().getId());
            sysNoticeService.update(sysNotice);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("notice:delete")
    @DeleteMapping("{noticeIds}")
    @ApiOperation(value = "删除通知公告", response = Object.class)
    public Object remove(@PathVariable String[] noticeIds) {
        sysNoticeService.deleteByIds(Arrays.asList(noticeIds));
        return AjaxResult.success();
    }

    @GetMapping("noticeNum")
    @ApiOperation(value = "获取通知公告数量", response = Object.class)
    public Object noticeNum() throws UserException {
        return AjaxResult.successData(sysNoticeService.noticeNum(SecurityUtils.getUser().getId()));
    }

    @GetMapping("getNotices")
    @ApiOperation(value = "通知公告时间线", response = Object.class)
    public Object getNotices() throws UserException {
        return AjaxResult.successData(sysNoticeService.getNotices(SecurityUtils.getUser().getId()));
    }
}
