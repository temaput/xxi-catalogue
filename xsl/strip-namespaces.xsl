<?xml version="1.0" encoding="UTF-8"?>
<!---
     strip-namespaces.xsl
     This stylesheet should completly remove all namespaces
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- keep comments -->
<xsl:template match="comment()">
    <xsl:copy>
        <xsl:apply-templates/>
    </xsl:copy>

</xsl:template>

<xsl:template match="*">
    <!-- remove element prefix -->
    <xsl:element name="{local-name()}">
        <!-- attributes -->
        <xsl:for-each select="@*">
            <!-- no attribute prefixes -->
            <xsl:attribute name="{local-name()}">
                <xsl:value-of select="." />
            </xsl:attribute>
        </xsl:for-each>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>


</xsl:stylesheet>

