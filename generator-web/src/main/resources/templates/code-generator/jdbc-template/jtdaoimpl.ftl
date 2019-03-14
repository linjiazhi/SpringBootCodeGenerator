import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.getJdbcTemplate();
import org.springframework.stereotype.Repository;

import java.util.List;

/**
* ${classInfo.classComment}
* @author ${authorName} ${.now?string('yyyy-MM-dd')}
*/
@Repository
public class ${classInfo.className}Dao extends BaseHomeDao{

    public int add(${classInfo.className} ${classInfo.className?uncap_first}) {
        return getJdbcTemplate().update("insert into ${classInfo.tableName}  (<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index gt 0>${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#if></#list></#if> ) values (<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem >?<#if fieldItem_has_next>,</#if></#list></#if> )",
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index gt 0 >${classInfo.className?uncap_first}.get${fieldItem.fieldName?cap_first}()<#if fieldItem_has_next>,</#if></#if></#list></#if>);
    }

    public int update(${classInfo.className} ${classInfo.className?uncap_first}) {
        return getJdbcTemplate().update("UPDATE  ${classInfo.tableName}  SET <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index gt 0 >${fieldItem.columnName}=?<#if fieldItem_has_next>,</#if></#if></#list></#if>"
        +" where <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=?<#break ></#if></#list></#if>",
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
            <#list classInfo.fieldList as fieldItem ><#if fieldItem_index gt 0 >${classInfo.className?uncap_first}.get${fieldItem.fieldName?cap_first}(),</#if></#list>
            <#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0 >${classInfo.className?uncap_first}.get${fieldItem.fieldName?cap_first}()</#if></#list>
        </#if>;
    }

    public int delete(int id) {
        return getJdbcTemplate().update("DELETE from ${classInfo.tableName} where <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=?<#break ></#if></#list></#if>",id);
    }

    public ${classInfo.className} getById(long id) {
        String sql = new StringBuilder().append("select * from ${classInfo.className} where id=").append(id).toString();
        log.debug(sql);
        return getJdbcTemplate().queryForObject(sql, rowMapper);
    }

    public List<${classInfo.className}> getList() {
    String sql = "select * from ${classInfo.className} ";
    log.debug(sql);
    return getJdbcTemplate().query(sql, rowMapper);
    }

    protected RowMapper<${classInfo.className}> rowMapper = new BeanPropertyRowMapper<>(${classInfo.className}.class);

}
