package ${entityPackage};

import com.ares.core.model.query.BaseQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;


@Data
@Schema(description = "查询实体")
public class ${entityName}Query extends BaseQuery{

}
