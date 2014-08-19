<?xml version="1.0"?>
<!-- Get data from previous (edited) catalogue for uploading to 1C -->
<xsl:stylesheet version="1.0"
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
            <заголовок><xsl:value-of select="../preceding-sibling::яч_наименование[1]/заголовок"/></заголовок>
            <подзаголовок><xsl:value-of select="../preceding-sibling::яч_наименование[1]/подзаголовок"/></подзаголовок>
            <автор><xsl:value-of select="../preceding-sibling::яч_автор[1]/автор"/></автор>
            <город><xsl:value-of select="../preceding-sibling::яч_издательство[1]/город"/></город>
            <издательство><xsl:value-of select="../preceding-sibling::яч_издательство[1]/издательство"/></издательство>
            <страниц><xsl:value-of select="../preceding-sibling::яч_издательство[1]/страниц"/></страниц>
            <дополнительно><xsl:value-of select="../preceding-sibling::яч_издательство[1]/дополнительно"/></дополнительно>
            <переплет><xsl:value-of select="../preceding-sibling::яч_издательство[1]/переплет"/></переплет>
            <код><xsl:value-of select="."/></код>
        </издание>
    </xsl:template>
</xsl:stylesheet>

