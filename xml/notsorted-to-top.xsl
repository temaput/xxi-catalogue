<?xml version="1.0"?>
<!-- makes list of selected units to appear with covers and annotations
     should be run after catalog-to-notsorted
     feed with notsorted.xml
     
     !takes top from data/topselection.xml but looks only for SKU there
     the rest info it gets from the feeded xml

     groups series, sequences from catalog-to-notsorted.xsl and 
     also groups units with similar name and author 

     if run with series=off will ignore the series and sequences aswell
     (i.e. will only group multivolum units)

     creates file: links on img/XXX.jpg for the cover field
     XXX = SKU
     -->
<xsl:stylesheet version="1.0"
    xmlns:data="http://classica21.ru/catalogue"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>
    <xsl:key name="multivolume" match="издание" 
        use="translate(concat(заголовок, '+', автор),'&#160;&#x20;','')"/> 
    <xsl:key name="inTop" match="издание" use="код"/>
    <xsl:key name="inSeries" match="sequence" use="attached/item"/>
    <xsl:key name="firstInSeries" match="sequence" use="first"/>

    <xsl:variable name="topSelection" 
        select="document('topselection.xml')/Каталог"/>
    <xsl:param name="series" select="'on'"/>

    <xsl:template match="/Каталог">
        <Каталог>
            <топ>
                <xsl:apply-templates select="группа">
                </xsl:apply-templates>
            </топ>
        </Каталог>
    </xsl:template>

    <xsl:template match="группа">
        <xsl:apply-templates select="издание" mode="route">
            <xsl:sort select="заголовок"/>
            <xsl:sort select="подзаголовок"/>
            <xsl:sort select="автор"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="группа">
        </xsl:apply-templates>
    </xsl:template>


    <xsl:template match="издание" mode="route">
        <xsl:variable name="SKU" select="код"/>
        <xsl:if test="$topSelection[key('inTop', $SKU)]">
            <xsl:choose>
                <xsl:when 
                    test="count(key('multivolume', 
                    translate(concat(заголовок, '+', автор),'&#160;&#x20;',''))) &gt; 1">
                    <!-- we have a multivolume process only the first -->
                    <xsl:if test="count(. | key('multivolume', 
                        translate(concat(заголовок, '+', автор),'&#160;&#x20;',''))[1])=1">
                        <xsl:apply-templates select="." mode="multivolume"/>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="$series = 'on'">
                    <xsl:choose>
                        <xsl:when test="key('inSeries', $SKU)"/> <!-- do nothing -->
                        <xsl:when test="key('firstInSeries', $SKU)">
                            <xsl:apply-templates select="." mode="sequence">
                                <xsl:with-param name="sequence"
                                    select="key('firstInSeries', $SKU)"/>
                            </xsl:apply-templates>
                            <!-- going through the series -->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="simple"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="." mode="simple"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template match="издание" mode="simple">
        <!-- we have a simple process it here -->
        <xsl:copy>
            <топ_метка>
                <xsl:text> &#xD;</xsl:text>
            </топ_метка>
            <xsl:if test="автор != ''">
                <топ_автор>
                    <xsl:value-of select="автор"/>
                    <xsl:text> &#xD;</xsl:text>
                </топ_автор>
            </xsl:if>
            <xsl:call-template name="printGroup"/>
            <топ_заголовок>
                <xsl:value-of select="заголовок"/>
                <xsl:text> </xsl:text>
                <xsl:if test="подзаголовок = ''">
                    <xsl:text> &#xD;</xsl:text>
                </xsl:if>
            </топ_заголовок>
            <xsl:if test="подзаголовок != ''">
                <топ_подзаголовок>
                    <xsl:value-of select="подзаголовок"/>
                    <xsl:text> &#xD;</xsl:text>
                </топ_подзаголовок>
            </xsl:if>
            <xsl:call-template name="printCover"/>
            <xsl:if test="аннотация != ''">
                <топ_аннотация>
                    <xsl:value-of select="аннотация"/>
                    <xsl:text> &#xD;</xsl:text>
                </топ_аннотация>
            </xsl:if>
            <xsl:call-template name="printPrice"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="издание" mode="sequence">
        <xsl:param name="sequence"/>
        <xsl:copy>
            <топ_метка>
                <xsl:text> &#xD;</xsl:text>
            </топ_метка>
            <xsl:call-template name="printGroup"/>
            <топ_заголовок>
                <xsl:value-of select="$sequence/name"/>
                <xsl:text> &#xD;</xsl:text>
            </топ_заголовок>
            <xsl:call-template name="printCover"/>
            <xsl:if test="аннотация != ''">
                <топ_аннотация>
                    <xsl:value-of select="аннотация"/>
                    <xsl:text> &#xD;</xsl:text>
                </топ_аннотация>
            </xsl:if>
            <xsl:apply-templates select="." mode="sequence_block"/>

            <xsl:for-each select="$sequence/attached/item">
                <xsl:variable name="SKU" select="."/>
                <xsl:apply-templates select="//издание[код=$SKU]"
                    mode="sequence_block"/>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="издание" mode="sequence_block">
        <подзаголовок_вып>
            <xsl:if test="автор != ''">
                <xsl:value-of select="автор"/>
                <xsl:text> &#xD;</xsl:text>
            </xsl:if>
            <xsl:value-of select="заголовок"/>
            <xsl:text> </xsl:text>
            <xsl:if test="подзаголовок != ''">
                <xsl:value-of select="подзаголовок"/>
            </xsl:if>
            <xsl:text>&#xD;</xsl:text>
        </подзаголовок_вып>
        <xsl:call-template name="printPrice"/>
    </xsl:template>


    <xsl:template match="издание" mode="multivolume">
        <xsl:copy>
            <топ_метка>
                <xsl:text> &#xD;</xsl:text>
            </топ_метка>
            <xsl:if test="автор != ''">
                <топ_автор>
                    <xsl:value-of select="автор"/>
                    <xsl:text> &#xD;</xsl:text>
                </топ_автор>
            </xsl:if>
            <xsl:call-template name="printGroup"/>
            <топ_заголовок>
                <xsl:value-of select="заголовок"/>
                <xsl:text> &#xD;</xsl:text>
            </топ_заголовок>
            <xsl:for-each select="key('multivolume', 
                translate(concat(заголовок, '+', автор),'&#160;&#x20;',''))">
                <xsl:sort select="подзаголовок"/>
                <xsl:if test="position() = 1">
                    <xsl:call-template name="printCover"/>
                    <xsl:if test="аннотация != ''">
                        <топ_аннотация>
                            <xsl:value-of select="аннотация"/>
                            <xsl:text> &#xD;</xsl:text>
                        </топ_аннотация>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="key('multivolume', 
                translate(concat(заголовок, '+', автор),'&#160;&#x20;',''))">
                <xsl:sort select="подзаголовок"/>
                <подзаголовок_вып>
                    <xsl:value-of select="подзаголовок"/>
                    <xsl:text> &#xD;</xsl:text>
                </подзаголовок_вып>
                <xsl:call-template name="printPrice"/>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

    <xsl:template name="printCover">
        <обложка>
            <xsl:attribute name="href">
                <!--><xsl:text>img/000.jpg</xsl:text></!-->
                    <xsl:text>file://img/</xsl:text>
                    <xsl:value-of select="код"/>
                    <xsl:text>.jpg</xsl:text>
            </xsl:attribute>
        </обложка>
    </xsl:template>

    <xsl:template name="printGroup">
        <группа>
            <xsl:choose>
                <xsl:when test="ancestor::группа[3]">
                    <подзаголовок_группы>
                        <xsl:value-of select="ancestor::группа[2]/название_группы"/>
                    </подзаголовок_группы>
                    <заголовок_группы>
                        <xsl:value-of select="ancestor::группа[3]/название_группы"/>
                    </заголовок_группы>
                </xsl:when>
                <xsl:when test="ancestor::группа[2]">
                    <подзаголовок_группы>
                        <xsl:value-of select="ancestor::группа[1]/название_группы"/>
                    </подзаголовок_группы>
                    <заголовок_группы>
                        <xsl:value-of select="ancestor::группа[2]/название_группы"/>
                    </заголовок_группы>
                </xsl:when>
                <xsl:otherwise>
                    <заголовок_группы>
                        <xsl:value-of select="ancestor::группа[1]/название_группы"/>
                    </заголовок_группы>
                </xsl:otherwise>
            </xsl:choose>
        </группа>
    </xsl:template>

    <xsl:template name="printPrice">
        <топ_код>
            <xsl:text>код </xsl:text>
            <xsl:value-of select="код"/>
        </топ_код>
        <топ_цена>
            <xsl:text>&#x9;</xsl:text>
            <xsl:value-of select="цена"/>
            <xsl:text> руб.</xsl:text>
            <xsl:text> &#xD;</xsl:text>
        </топ_цена>
    </xsl:template>



</xsl:stylesheet>
