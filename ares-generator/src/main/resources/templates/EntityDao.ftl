package ${daoPackage};

import ${entityPackage}.${entityName};
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface I${entityName}Dao extends IBaseDao<${entityName},${entityName}Query>{

}
