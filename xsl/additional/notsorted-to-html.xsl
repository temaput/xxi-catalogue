<?xml version="1.0"?>
<!-- transforms nonsorted catalog xml to html for preview -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

    <xsl:output method="html" indent="yes" encoding="utf-8"/>
    <xsl:template match="/">
        <html lang="ru">
            <head>
                <meta charset="utf8"/>
                <title>Содержание</title>
            </head>
            <body>
                <hgroup>
                    <h1>Содержание каталога</h1>
                    <p>Осень 2013</p>
                </hgroup>
                <ul>
                    <xsl:apply-templates select="Каталог/группа" mode="contents"/>
                </ul>
                <table bordercolor="black" border="1px" cellspacing="0" cellpadding="4">
                    <caption>
                        <xsl:text>Всего изданий: </xsl:text>
                        <xsl:value-of select="count(//издание)"/>
                    </caption>
                    <thead>
                        <tr  bgcolor="#B0C4DE" align="center">
                            <th>Заголовок</th>
                            <th>Подзаголовок</th>
                            <th>Автор</th>
                            <th>Издательство</th>
                            <th>Код</th>
                            <th>Цена</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="Каталог/группа" mode="price"/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="группа" mode="price">
        <tr>
            <td colspan="6">
                <h3>
                    <a>
                        <xsl:attribute name="name">
                            <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:value-of select="название_группы"/>
                    </a>
                </h3>
            </td>
        </tr>
        <xsl:apply-templates select="издание"/>
        <xsl:apply-templates select="группа" mode="price"/>
    </xsl:template>

    <xsl:template match="издание">
        <tr>
            <td>
                <xsl:number/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="заголовок"/>
            </td>
            <td>
                <xsl:value-of select="подзаголовок"/>
            </td>
            <td>
                <xsl:value-of select="автор"/>
            </td>
            <td>
                <xsl:value-of select="город"/>
                <xsl:text>:</xsl:text>
                <xsl:value-of select="издательство"/>
            </td>
            <td>
                <xsl:value-of select="код"/>
            </td>
            <td>
                <xsl:value-of select="цена"/>
                <xsl:text> руб.</xsl:text>
            </td>
        </tr>
    </xsl:template>







    <xsl:template match="группа" mode="contents">
        <li>
            <xsl:choose>
                <xsl:when test="издание">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="concat('#',generate-id(.))"/>
                        </xsl:attribute>
                        <xsl:value-of select="название_группы"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="название_группы"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="группа">
                <ul>
                    <xsl:apply-templates select="группа" mode="contents"/>
                </ul>
            </xsl:if>
        </li>
    </xsl:template>
</xsl:stylesheet>
