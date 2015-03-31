<#include "*/annotation.ftl">
package ${entity.javaPackage};
<#if entity.additionalImports?has_content>

<#list entity.additionalImports as importPackage>
import ${importPackage};
</#list>
</#if>
<#if entity.superclassEntity?has_content && entity.superclassEntity.additionalImports?has_content>

<#list entity.superclassEntity.additionalImports as importPkg>
import ${importPkg};
</#list>
</#if>
<#if entity.hasKeepSections>

// THIS CODE IS GENERATED BY greenDAO, EDIT ONLY INSIDE THE "KEEP"-SECTIONS

// KEEP INCLUDES - put your custom includes here
<#if keepIncludes?has_content>
${keepIncludes!}
</#if>
// KEEP INCLUDES END
<#else>

// THIS CODE IS GENERATED BY greenDAO, DO NOT EDIT. Enable "keep" sections if you want to edit.
</#if>

/**
 * Entity mapped to table ${entity.tableName}.
 */
<@print_annotations entity.annotations, ""/>
public class ${entity.className} extends ${entity.classNameBase} <#if
entity.interfacesToImplement?has_content> implements <#list entity.interfacesToImplement
as ifc>${ifc}<#if ifc_has_next>, </#if></#list></#if> {

<#if entity.hasKeepSections>
    // KEEP FIELDS - put your custom fields here
<#if keepFields?has_content>
${keepFields!}
</#if>
    // KEEP FIELDS END

</#if>
<#if entity.constructors>
    <@print_annotations entity.emptyConstructorAnnotations, "    "/>
    public ${entity.className}() {<#if entity.superclassEntity?has_content>
        super();</#if>
    }
<#if entity.propertiesPk?has_content && entity.propertiesPk?size != entity.properties?size>

    public ${entity.className}(<#list entity.propertiesPk as
property>${property.javaType} ${property.propertyName}<#if property_has_next>, </#if></#list>) {
<#list entity.propertiesPk as property>
        this.${property.propertyName} = ${property.propertyName};
</#list>
    }
</#if>
<#if entity.superclassEntity?has_content>

    public ${entity.className}(<#list entity.superclassEntity.properties as
property>${property.javaType} ${property.propertyName}<#if property_has_next>, </#if></#list>) {
        super(<#list entity.superclassEntity.properties as
property>${property.propertyName}<#if property_has_next>, </#if></#list>);
    }
</#if>

    <@print_annotations entity.fullConstructorAnnotations, "    "/>
    public ${entity.className}(<#if entity.superclassEntity?has_content><#list
entity.superclassEntity.properties as property>${property.javaType} ${property.propertyName}<#if
property_has_next || entity.properties?has_content>, </#if></#list></#if><#list entity.properties as
property>${property.javaType} ${property.propertyName}<#if property_has_next>, </#if></#list>) {
        super(<#if entity.superclassEntity?has_content><#list
entity.superclassEntity.properties as property>${property.propertyName}<#if
property_has_next || entity.properties?has_content>, </#if></#list></#if><#list entity.properties as
property>${property.propertyName}<#if property_has_next>, </#if></#list>);
    }
</#if>
<#if entity.hasKeepSections>

    // KEEP METHODS - put your custom methods here
<#if keepMethods?has_content>
${keepMethods!}
</#if>
    // KEEP METHODS END
</#if>
}