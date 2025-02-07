package ${entityPackage};

import com.ares.core.model.base.BaseModel;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

/**
* @description:
* @author: ${author}
* @date: ${createTime}
**/
@Data
@AutoMapper(target = ${entityName}Dto.class)
@Schema(title = "${entityName}对象",description = "")
public class ${entityName} extends BaseModel{
<#list columns as column>
    @Schema(description = "")
    private ${column.type} ${column.name};
</#list>
}
