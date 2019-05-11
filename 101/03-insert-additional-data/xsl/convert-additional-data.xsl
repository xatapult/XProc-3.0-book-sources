<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">

  <xsl:template match="/">
   <table>
     <tr>
       <th>City</th>
       <th>Temp (C)</th>
       <th>Rain</th>
     </tr>
     <xsl:for-each select="/*/weather" expand-text="true">
       <tr>
         <td>{@city}</td>
         <td>{@temperature}</td>
         <td>{@rain}</td>
       </tr>
     </xsl:for-each>
   </table>
  </xsl:template>

</xsl:stylesheet>
