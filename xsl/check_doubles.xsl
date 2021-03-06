<?xml version="1.0" encoding="UTF-8"?>
<!-- checkdoubles.xsl
     check *.icml file for doubles -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:key name="in-icml" match="XMLElement[@MarkupTag='XMLTag/код']"
        use="Content"/>
    <xsl:param name="source_file" select="'source_file.xml'"/>
    <xsl:variable name="source" select="document($source_file)/Каталог"/>
    <xsl:variable name="target" select="/"/>

    <xsl:template match="/">
        <html lang="ru">
            <head>
                <meta charset="utf-8"/>
                <title>Задвоения</title>
            </head>
            <body>
                <h1>Задвоения</h1>

                <table bordercolor="black" border="1px" cellspacing="0" cellpadding="4">
                    <thead>
                        <tr  bgcolor="#B0C4DE" align="center">
                            <th>Заголовок</th>
                            <th>Подзаголовок</th>
                            <th>Автор</th>
                            <th>Код</th>
                            <th>Группа</th>
                            <th>Тип</th>
                            <th>Количество</th>
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
        <xsl:if test="count(key('in-icml', $SKU)) &gt; 1">
            <tr>
                <td><xsl:value-of select="$unit/заголовок"/></td>
                <td><xsl:value-of select="$unit/подзаголовок"/></td>
                <td><xsl:value-of select="$unit/автор"/></td>
                <td><xsl:value-of select="$unit/код"/></td>
                <td><xsl:value-of select="$unit/группа"/></td>
                <td><xsl:value-of select="$unit/тип"/></td>
                <td><xsl:value-of select="count(key('in-icml', $SKU))"/></td>
            </tr>
        </xsl:if>
    </xsl:template>


</xsl:stylesheet>

