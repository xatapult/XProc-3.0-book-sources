<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:template match="/document">
    <html>
      <head>
        <title>
          <xsl:value-of select="title"/>
        </title>
      </head>
      <body>
        <xsl:apply-templates select="* except title"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="div">
    <!-- Unwrap the div elements from each other: -->
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="* except ./div"/>
    </xsl:copy>
    <xsl:apply-templates select="div"/>
  </xsl:template>

  <xsl:template match="div/title">
    <!-- Find out how deep this div is nested to get the right heading level: -->
    <xsl:variable name="nesting-level" as="xs:integer" select="count(ancestor::div)"/>
    <xsl:element name="h{$nesting-level}">
      <xsl:copy-of select="@*"/>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="para">
    <p>
      <xsl:apply-templates select="@* | node()"/>
    </p>
  </xsl:template>

</xsl:stylesheet>
