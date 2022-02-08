package com.ares.system.controller;

import com.ares.core.controller.BaseController;
import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.core.persistence.model.page.TableDataInfo;
import com.ares.core.persistence.model.system.SysDept;
import com.ares.core.persistence.service.SysDeptService;
import com.ares.core.utils.StringUtils;
import com.ares.system.common.shiro.ShiroUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;


@RestController
@RequestMapping("/sysDept/*")
@Api(value = "部门管理API", tags = {"部门管理"})
public class SysDeptApiController extends BaseController {

    @Resource
    SysDeptService sysDeptService;

    @RequiresPermissions("sysDept:list")
    @RequestMapping("list")
    @ApiOperation(value = "部门列表", response = TableDataInfo.class)
    public TableDataInfo list(SysDept sysDept) {
        startPage();
        List<SysDept> sysDeptList = sysDeptService.list(sysDept);
        return getDataTable(sysDeptList);
    }

    @GetMapping("{sysDeptId}")
    @ApiOperation(value = "根据Id获取部门信息", response = Object.class)
    public Object getInfo(@PathVariable String sysDeptId) {
        return AjaxResult.successData(sysDeptService.getByDeptId(sysDeptId));
    }

    //@RequiresPermissions("sysDept:edit")
    @PostMapping("edit")
    @ApiOperation(value = "编辑部门信息", response = Object.class)
    public Object edit(@Validated @RequestBody SysDept sysDept) throws Exception {
        if (StringUtils.isEmpty(sysDept.getId())) {
            sysDept.setCreator(ShiroUtils.getUserId());
            sysDeptService.insert(sysDept);
        } else {
            sysDept.setModifier(ShiroUtils.getUserId());
            sysDeptService.update(sysDept);
        }
        return AjaxResult.success();
    }

    //@RequiresPermissions("sysDept:delete")
    @DeleteMapping("{sysDeptIds}")
    @ApiOperation(value = "删除部门", response = Object.class)
    public Object remove(@PathVariable String[] sysDeptIds) {
        sysDeptService.deleteByIds(Arrays.asList(sysDeptIds));
        return AjaxResult.success();
    }

    @RequestMapping("treeselect")
    @ApiOperation(value = "部门树列表", response = Object.class)
    public Object tree(HttpServletRequest request, HttpServletResponse response) {
        return AjaxResult.successData(sysDeptService.buildDeptTree());
    }
}
