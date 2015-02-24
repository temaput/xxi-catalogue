<?xml version="1.0" encoding="UTF-8"?>
<!-- Compares raw xml from 1C with the resulted icml file and finds
     all missed books. -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

    <xsl:output method="html" doctype-system="about:legacy-compat" indent="yes" encoding="utf-8"/>
    <xsl:key name="in-icml" match="XMLElement[@MarkupTag='XMLTag/код']"
        use="Content"/>
    <xsl:param name="source_file" select="'source_file.xml'"/>
    <xsl:variable name="source" select="document($source_file)/Каталог"/>
    <xsl:variable name="target" select="/"/>

    <xsl:template match="/">
        <html lang="ru">
            <head>
                <meta charset="utf-8"/>
                <title>Пропущенные издания</title>
            </head>
            <body>
                <h1>Пропущенные издания</h1>
                <h2>Источник: <small><xsl:value-of select="$source_file"/></small></h2>
                <h2>Количество изданий в источнике:  <small><xsl:value-of select="count($source/издание)"/></small></h2>
                <h2>Количество изданий, попавших в верстку: <small> <xsl:value-of select="count(//XMLElement[@MarkupTag='XMLTag/код'])" />
                </small></h2>

                <table bordercolor="black" border="1px" cellspacing="0" cellpadding="4">
                    <thead>
                        <tr  bgcolor="#B0C4DE" align="center">
                            <th>Заголовок</th>
                            <th>Подзаголовок</th>
                            <th>Автор</th>
                            <th>Код</th>
                            <th>Группа</th>
                            <th>Тип</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="$source/издание/код"/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="код">
        <xsl:apply-templates select="$target/Document">
            <xsl:with-param name="unit" select="parent::издание"/>
            <xsl:with-param name="SKU" select="."/>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="Document">
        <xsl:param name="unit"/>
        <xsl:param name="SKU"/>
        <xsl:if test="not(key('in-icml',$SKU))">
            <tr>
                <td><xsl:value-of select="$unit/заголовок"/></td>
                <td><xsl:value-of select="$unit/подзаголовок"/></td>
                <td><xsl:value-of select="$unit/автор"/></td>
                <td><xsl:value-of select="$unit/код"/></td>
                <td><xsl:value-of select="$unit/группа"/></td>
                <td><xsl:value-of select="$unit/тип"/></td>
            </tr>
        </xsl:if>
    </xsl:template>


</xsl:stylesheet>
