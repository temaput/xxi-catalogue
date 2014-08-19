<?xml version="1.0" encoding="UTF-8"?>
<!-- this one sorts structured price
     should run after catalog-to-notsorted before sorted-to-icml
     uses sequences embeded inside the units for custom ordering
     the special cases
     -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:data="http://classica21.ru/catalogue" >

    <xsl:output method="xml" indent="yes" encoding="utf-8"/>
    <xsl:key name="attached" match="издание" use="attached/item"/>

    <xsl:template match="/">
        <Каталог>
            <xsl:apply-templates select="Каталог/группа"/>
        </Каталог>
    </xsl:template>

    <xsl:template match="группа">
        <xsl:copy>
            <xsl:copy-of select="название_группы"/>
            <xsl:apply-templates select="издание">
                <xsl:sort select="translate(заголовок, '&#xBB;&#xAB;', '')"/>
                <xsl:sort select="подзаголовок"/>
                <xsl:sort select="автор"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="группа"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="издание">
        <xsl:if test="not(key('attached', код))">
            <xsl:copy-of select="."/>
            <xsl:if test="attached">
                <xsl:for-each select="attached/item">
                    <xsl:variable name="index" select="."/>
                    <xsl:copy-of
                        select="//издание[код = $index]"/>
                </xsl:for-each>
            </xsl:if>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>

