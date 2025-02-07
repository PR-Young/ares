package ${daoPackage};

import ${entityPackage}.${entityName};
import org.apache.ibatis.annotations.Mapper;

/**
* @description:
* @author: ${author}
* @date: ${createTime}
**/
@Mapper
public interface I${entityName}Dao extends IBaseDao<${entityName}Dto, ${entityName}Query>{

}
