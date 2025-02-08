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
public class ${entityName}Dto extends BaseModel{
<#list columns as column>
    /**
    *
    */
    private ${column.type} ${column.name};
</#list>
}
