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
@Schema(title = "${entityName}Dto对象",description = "")
public class ${entityName}Dto extends BaseModel{
<#list columns as column>
    @Schema(description = "")
    private ${column.type} ${column.name};
</#list>
}
