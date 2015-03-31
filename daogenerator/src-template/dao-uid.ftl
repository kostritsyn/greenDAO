<#-- Override update, insert, delete methods -->
<#if entity.toOneRelations?has_content || entity.toManyRelations?has_content
    || (entity.superclassEntity?has_content && (entity.superclassEntity.toOneRelations?has_content
    || entity.superclassEntity.toManyRelations?has_content))>
    @Override
    public long insert(${entity.className} entity) {
        <#if entity.superclassEntity?has_content && entity.superclassEntity.toOneRelations?has_content>
        <#list entity.superclassEntity.toOneRelations as toOne>

        ${toOne.targetEntity.className} ${toOne.name} = entity.get${toOne.name?cap_first}();
        daoSession.insert(${toOne.name});
        entity.set${toOne.fkProperties[0].propertyName?cap_first}(${toOne.name}.get${entity.pkProperty.propertyName?cap_first}());
        </#list>
        </#if>
        <#if entity.toOneRelations?has_content>
        <#list entity.toOneRelations as toOne>

        ${toOne.targetEntity.className} ${toOne.name} = entity.get${toOne.name?cap_first}();
        daoSession.insert(${toOne.name});
        entity.set${toOne.fkProperties[0].propertyName?cap_first}(${toOne.name}.get${entity.pkProperty.propertyName?cap_first}());
        </#list>
        </#if>

        long entityId = super.insert(entity);
        <#if entity.superclassEntity?has_content && entity.superclassEntity.toManyRelations?has_content>

        <#list entity.superclassEntity.toManyRelations as toMany>
        ${toMany.targetEntity.classNameDao} ${toMany.name}Dao = daoSession.get${toMany.targetEntity.classNameDao}();
        for (${toMany.targetEntity.className} elem : entity.get${toMany.name?cap_first}()) {
            elem.set${toMany.targetProperties[0].propertyName?cap_first}(entity.get${entity.pkProperty.propertyName?cap_first}());
        }
        ${toMany.name}Dao.insertInTx(entity.get${toMany.name?cap_first}());
        </#list>
        </#if>
        <#if entity.toManyRelations?has_content>
        <#list entity.toManyRelations as toMany>

        ${toMany.targetEntity.classNameDao} ${toMany.name}Dao = daoSession.get${toMany.targetEntity.classNameDao}();
        for (${toMany.targetEntity.className} elem : entity.get${toMany.name?cap_first}()) {
            elem.set${toMany.targetProperties[0].propertyName?cap_first}(entity.get${entity.pkProperty.propertyName?cap_first}());
        }
        ${toMany.name}Dao.insertInTx(entity.get${toMany.name?cap_first}());
        </#list>
        </#if>

        return entityId;
    }

    public ${entity.className} select(${entity.pkType} key) {
        assertSinglePk();

        if (key == null) {
            return null;
        }

        <#if entity.toOneRelations?has_content || (entity.superclassEntity?has_content
            && entity.superclassEntity.toOneRelations?has_content)>
        ${entity.className} entity = loadDeep(key);
        <#else>
        ${entity.className} entity = load(key);
        </#if>

        if (entity == null) {
            return null;
        }

        <#if entity.superclassEntity?has_content>
        <#list entity.superclassEntity.toManyRelations as toMany>
        entity.get${toMany.name?cap_first}();
        </#list>
        </#if>
        <#list entity.toManyRelations as toMany>
        entity.get${toMany.name?cap_first}();
        </#list>

        return entity;
    }
</#if>