<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:fn="http://www.w3.org/2005/xpath-functions"
exclude-result-prefixes="xs fn">

<xsl:template match="@* | node()">
    <xsl:copy>
        <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
</xsl:template>

<xsl:param name="withoutLeadingZeros">
  <xsl:call-template name="remove-leading-zeros">
      <xsl:with-param name="text" select="//fieldToSubstring3"/>
  </xsl:call-template>
</xsl:param>
<xsl:param name="stringLength" select="string-length($withoutLeadingZeros)"/>



<xsl:template match="fieldToSubstring3"> <!-- This if the actual field your xml should include -->
  <dotAdded_FieldToSubstring3>
    <xsl:value-of select="substring($withoutLeadingZeros, 0, $stringLength - 1 )"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="substring($withoutLeadingZeros, $stringLength - 1 )"/>
  </dotAdded_FieldToSubstring3>
</xsl:template>

<!-- in case of a string you need to remove leading zeroes effectively, not risking conversion with number() -->
<xsl:template name="remove-leading-zeros">
    <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="starts-with($text,'0')">
                <xsl:call-template name="remove-leading-zeros">
                    <xsl:with-param name="text"
                        select="substring-after($text,'0')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
