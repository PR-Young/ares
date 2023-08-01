package com.ares.system.controller;

import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import ${entityPackage}.${entityName};
import com.ares.core.model.page.TableDataInfo;
import ${servicePackage}.I${entityName}Service;
import com.ares.core.utils.StringUtils;
import com.ares.core.common.security.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import cn.dev33.satoken.annotation.SaCheckPermission;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;


@RestController
@RequestMapping("/${entityName1}/*")
@Tag(name = "${entityName}ApiController", description = "API")
public class ${entityName}ApiController extends BaseController {

private I${entityName}Service ${entityName1}Service;

@Autowired
public ${entityName}ApiController(I${entityName}Service ${entityName1}Service){
this.${entityName1}Service = ${entityName1}Service;
}

@SaCheckPermission("${entityName1}:list")
@GetMapping("list")
@Operation(summary = "列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
public TableDataInfo list(${entityName} ${entityName1}) {
startPage();
List<${entityName}> ${entityName1}List = ${entityName1}Service.list(${entityName1});
return getDataTable(${entityName1}List);
}

@GetMapping("{${entityName1}Id}")
@Operation(summary = "根据Id获取信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
public Object getInfo(@PathVariable String ${entityName1}Id) {
return AjaxResult.successData(${entityName1}Service.getById(${entityName1}Id));
}

@SaCheckPermission("${entityName1}:edit")
@PostMapping("edit")
@Operation(summary = "编辑信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
public Object edit(@Validated @RequestBody ${entityName} ${entityName1}) throws Exception{
if (StringUtils.isEmpty(${entityName1}.getId())) {
${entityName1}.setCreator(SecurityUtils.getUser().getId());
${entityName1}Service.insert(${entityName1});
} else {
${entityName1}.setModifier(SecurityUtils.getUser().getId());
${entityName1}Service.update(${entityName1});
}
return AjaxResult.success();
}

@SaCheckPermission("${entityName1}:delete")
@DeleteMapping("{${entityName1}Ids}")
@Operation(summary = "删除信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
public Object remove(@PathVariable String[] ${entityName1}Ids) {
${entityName1}Service.deleteByIds(Arrays.asList(${entityName1}Ids));
return AjaxResult.success();
}
}
