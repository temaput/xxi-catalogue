<?xml version="1.0"?>
<!-- catalog-to-notsorted.xsl
     Creating catalog structure from flat xml exported from 1C -->

<!-- this is first to run
     creates notsorted.xml
     arranges all units inside the tree structure wich will
     form the contents of the new catalog
     the structure is from s:contents
     additional sequences are in s:sequence
     -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:s="http://www.classica21.ru/catalogue/structure"
    exclude-result-prefixes="s"
    >
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>

    <xsl:preserve-space elements="s:*"/>
    <xsl:strip-space elements="*"/>
    <xsl:key name="by-group" match="издание" use="concat(тип, '+', группа)"/>
    <xsl:key name="by-series" match="издание" 
        use="concat(тип, '+', группа, '+', серия)"/>

    <xsl:key name="sequences" match="s:sequence" use="s:first"/>
    <xsl:key name="series" match="издание" use="серия"/>

    <xsl:param name="structure_doc" select="'structure.xml'"/>
    <xsl:variable name="contents" select="document($structure_doc)/s:structure/s:contents"/>
    <xsl:variable name="sequences" select="document($structure_doc)/s:structure/s:sequences"/>
    <xsl:variable name="source" select="/"/>

    <xsl:template match="/">
        <Каталог>
            <sequences xmlns="http://www.classica21.ru/catalogue/structure">
                <!-- reproduce handmade sequences -->
                <xsl:for-each select="$sequences/s:sequence">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
                <!-- here we need to collect all natural sequences based on 
                     their series name -->
                <xsl:for-each
                    select="//издание[count(. | key('series', серия)[1]) = 1]">
                    <xsl:sort select="серия"/>
                    <xsl:variable name="serieName" select="серия"/>
                    <xsl:if test="$serieName != '' and count(key('series', $serieName)) &gt; 1">
                        <sequence>
                            <name><xsl:value-of select="$serieName"/></name>
                                <xsl:for-each
                                    select="key('series', $serieName)">
                                    <xsl:sort select="код" data-type="number"/>
                                    <xsl:if test="position()=1">
                                        <first><xsl:value-of select="код"/></first>
                                    </xsl:if>
                                </xsl:for-each>
                                <attached>
                                    <xsl:for-each
                                        select="key('series', $serieName)">
                                        <xsl:sort select="код" data-type="number"/>
                                        <xsl:if test="position() &gt; 1">
                                            <item><xsl:value-of select="код"/></item>
                                        </xsl:if>
                                    </xsl:for-each>
                                </attached>
                        </sequence>
                    </xsl:if>
                </xsl:for-each>
            </sequences>
            <xsl:apply-templates select="$contents/s:group"/>
        </Каталог>
    </xsl:template>

        
    <xsl:template match="s:contents//s:group">
        <!-- Группа (или подгруппа) каталога -->
        <группа>
            <название_группы><xsl:value-of select="s:name"/></название_группы>
            <!-- Собираем содержимое группы -->
            <xsl:apply-templates select="s:included-groups/s:groupdef"/>
            <!-- Подгруппы -->
            <xsl:apply-templates select="s:subgroups/s:group"/>
        </группа>
    </xsl:template>

    <!-- ****************************************
        Формируем фильтр: Группа - Тип - +Серия
        **************************************** -->

    <xsl:template match="s:groupdef">
        <xsl:variable name="groupName" select="."/>
        <!-- Собираем типы -->
        <xsl:apply-templates select="ancestor::s:group[1]/s:included-types/s:typedef">
            <xsl:with-param name="groupName" select="$groupName"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="s:typedef">
        <xsl:param name="groupName"/>
        <xsl:variable name="typeName" select="."/>
        <xsl:choose>
            <xsl:when test="ancestor::s:group[1]/s:included-series">
                <!-- Группа - это серия -->
                <xsl:apply-templates 
                    select="ancestor::s:group[1]/s:included-series/s:seriesdef">
                    <xsl:with-param name="groupName" select="$groupName"/>
                    <xsl:with-param name="typeName" select="$typeName"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <!-- Группа - обычная группа: переходим к набору изданий -->
                <xsl:apply-templates select="$source/Каталог">
                    <xsl:with-param name="groupName" select="$groupName"/>
                    <xsl:with-param name="typeName" select="$typeName"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="s:seriesdef">
        <!-- Отрабатываем дополнительный параметр фильтра когда группа состоит из серии -->
        <xsl:param name="groupName"/>
        <xsl:param name="typeName"/>
        <xsl:variable name="seriesName" select="concat('+', .)"/>
        <xsl:apply-templates select="$source/Каталог">
            <xsl:with-param name="groupName" select="$groupName"/>
            <xsl:with-param name="typeName" select="$typeName"/>
            <xsl:with-param name="seriesName" select="$seriesName"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- ****************************************
         Закончили формировать фильтры 
         **************************************** -->


    <xsl:template match="Каталог">
        <xsl:param name="groupName"/>
        <xsl:param name="typeName"/>
        <xsl:param name="seriesName"/>
        <xsl:choose>
            <xsl:when test="$seriesName">
                <xsl:apply-templates mode="copy"
                    select="key('by-series',
                    concat($typeName, '+', $groupName, $seriesName))">
                    <xsl:with-param name="currentSeriesName" select="$seriesName"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="check"
                    select="key('by-group', concat($typeName, '+', $groupName))">
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="издание" mode="check">
            <!-- not inside the series, lets check that it will go inside some series later to reduce doubling -->
            <xsl:variable name="belongsToSeries" select="серия"/>
            <xsl:if test="not($belongsToSeries)">
                <xsl:apply-templates select="." mode="copy" />
            </xsl:if>

            <xsl:if test="$belongsToSeries and not($contents//s:seriesdef[. = $belongsToSeries])"> 
                <xsl:apply-templates select="." mode="copy" />
            </xsl:if>
    </xsl:template>

    <xsl:template match="издание" mode="copy">
            <xsl:copy>
                <xsl:copy-of select="заголовок"/>
                <xsl:copy-of select="подзаголовок"/>
                <xsl:copy-of select="автор"/>
                <xsl:copy-of select="город"/>
                <xsl:copy-of select="издательство"/>
                <xsl:copy-of select="страниц"/>
                <xsl:copy-of select="дополнительно"/>
                <xsl:copy-of select="переплет"/>
                <xsl:copy-of select="код"/>
                <xsl:copy-of select="цена"/>
                <xsl:copy-of select="серия"/>
                <xsl:variable name="annotation" select="аннотация"/>
                <аннотация>
                    <xsl:value-of
                        select="normalize-space(translate($annotation, '&#xA;&#xD;', ''))"/>
                </аннотация>
                <xsl:variable name="index" select="код"/>
                <xsl:if test="$sequences/s:sequence[key('sequences', $index)]">
                    <xsl:copy-of 
                        select="$sequences/s:sequence[count(. | key('sequences', $index))=1]/s:attached"/>
                </xsl:if>
            </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
