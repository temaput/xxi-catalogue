<!-- strip-whitespace.xsl
     removes trailing spaces, converts $ to linefeed -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/Каталог">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="издание">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="издание/*">
        <xsl:copy>
            <xsl:value-of select="translate(normalize-space(.), '$','&#x2028;')" />
        </xsl:copy>
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>

