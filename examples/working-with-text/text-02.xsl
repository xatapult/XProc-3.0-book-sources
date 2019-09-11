<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  exclude-result-prefixes="#all"
  version="3.0" expand-text="true">

  <xsl:template match="/">
    <lines>
      <xsl:apply-templates/>
    </lines>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:for-each select="tokenize(., '[&#10;&#13;]+')[normalize-space(.) ne '']">
      <line>{.}</line>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
