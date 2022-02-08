package com.ares.system.controller;

import com.ares.core.controller.BaseController;
import com.ares.core.persistence.model.system.SysDictData;
import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.core.persistence.model.page.TableDataInfo;
import com.ares.core.persistence.service.SysDictDataService;
import com.ares.core.utils.StringUtils;
import com.ares.system.common.shiro.ShiroUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;


@RestController
@RequestMapping("/system/dict/data/*")
@Api(value = "字典数据API", tags = {"字典数据"})
public class SysDictDataApiController extends BaseController {

    @Resource
    SysDictDataService sysDictDataService;


    @RequiresPermissions("sysDictData:list")
    @RequestMapping("list")
    @ApiOperation(value = "字典数据列表", response = TableDataInfo.class)
    public TableDataInfo list(SysDictData sysDictData) {
        startPage();
        List<SysDictData> sysDictDataList = sysDictDataService.list(sysDictData);
        return getDataTable(sysDictDataList);
    }

    @GetMapping("{sysDictDataId}")
    @ApiOperation(value = "根据Id获取字典数据", response = Object.class)
    public Object getInfo(@PathVariable String sysDictDataId) {
        return AjaxResult.successData(sysDictDataService.getById(sysDictDataId));
    }

    @RequiresPermissions("sysDictData:edit")
    @PostMapping("edit")
    @ApiOperation(value = "编辑字典数据", response = Object.class)
    public Object edit(@Validated @RequestBody SysDictData sysDictData) throws Exception {
        if (StringUtils.isEmpty(sysDictData.getId())) {
            sysDictData.setCreator(ShiroUtils.getUserId());
            sysDictDataService.insert(sysDictData);
        } else {
            sysDictData.setModifier(ShiroUtils.getUserId());
            sysDictDataService.update(sysDictData);
        }
        return AjaxResult.success();
    }

    @RequiresPermissions("sysDictData:delete")
    @DeleteMapping("{sysDictDataIds}")
    @ApiOperation(value = "删除字典数据", response = Object.class)
    public Object remove(@PathVariable String[] sysDictDataIds) {
        sysDictDataService.deleteByIds(Arrays.asList(sysDictDataIds));
        return AjaxResult.success();
    }

    @GetMapping("dictType/{dictType}")
    @ApiOperation(value = "根据类别获取字典数据", response = Object.class)
    public Object getDicts(@PathVariable String dictType) {
        return AjaxResult.successData(sysDictDataService.getDicts(dictType));
    }
}
