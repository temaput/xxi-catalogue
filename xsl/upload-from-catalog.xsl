<?xml version="1.0"?>
<!-- Get data from previous (edited) catalogue for uploading to 1C -->
<xsl:stylesheet version="1.0"
    xmlns="http://www.classica21.ru"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:data="http://classica21.ru/catalogue" >
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>

    <xsl:template match="/">
        <Каталог>
            <xsl:apply-templates select="основной/прайс/яч_код/код"/>
        </Каталог>
    </xsl:template>


    <xsl:template match="основной/прайс/яч_код/код">
        <издание>
            <xsl:apply-templates select="../preceding-sibling::яч_наименование[1]/заголовок" />
            <xsl:apply-templates select="../preceding-sibling::яч_наименование[1]/подзаголовок" />
            <xsl:apply-templates select="../preceding-sibling::яч_автор[1]/автор" />
            <xsl:apply-templates select="../preceding-sibling::яч_издательство[1]/город" />
            <xsl:apply-templates select="../preceding-sibling::яч_издательство[1]/издательство" />
            <xsl:apply-templates select="../preceding-sibling::яч_издательство[1]/страниц" />
            <xsl:apply-templates select="../preceding-sibling::яч_издательство[1]/дополнительно" />
            <xsl:apply-templates select="../preceding-sibling::яч_издательство[1]/переплет" />
            <код><xsl:value-of select="."/></код>
        </издание>
    </xsl:template>
    <xsl:template match="основной/прайс/*/*">
        <xsl:if test="normalize-space(string(.)) != ''">
            <xsl:element name="{local-name(.)}">
                <xsl:value-of select="translate(.,'&#x2028;', '$')"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>

