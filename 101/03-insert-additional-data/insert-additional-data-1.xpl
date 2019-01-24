<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
  name="html-conversion-pipeline">

  <p:input port="source" primary="true"/>
  <p:output port="result" primary="true"/>
  
  <p:option name="additional-header-info-file" 
    select="'../documents/additional-header-contents.xml'"/>
  <p:input port="header-info">
    <p:document href="{$additional-header-info-file}"/>
  </p:input>
  
  <p:xslt>
    <p:with-input port="stylesheet" href="xsl/basic-conversion.xsl"/>
  </p:xslt>
  
  <p:insert match="/html/head" position="last-child">
    <p:with-input port="insertion" select="/*/*">
      <p:pipe step="html-conversion-pipeline" port="header-info"/>
    </p:with-input>
  </p:insert>
  
  <!-- 1. Add viewport to process the <add-additional-data> element -->
  <p:viewport match="add-additional-data">
    <!-- 2. Process the data into a table using an XSLT -->
    <p:xslt>
      <!-- 3. Get the data to convert, relative to the source document -->
      <p:with-input port="source" href="{resolve-uri(/*/@source, base-uri())}"
      <p:with-input port="stylesheet" href="xsl/convert-additional-data.xsl"/>
    </p:xslt>
  </p:viewport>
  <!-- 4. The <add-additional-data> element is replaced by the result of the 
    <p:viewport>'s sub-pipeline -->
  
</p:declare-step>