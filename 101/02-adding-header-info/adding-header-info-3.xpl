<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
  name="html-conversion-pipeline">

  <p:input port="source" primary="true"/>
  <p:output port="result" primary="true"/>
  
  <p:option name="additional-header-info-file" 
    select="'../documents/additional-header-contents.xml'"/>
  
  <p:input port="header-info">
    <!-- 1. Load the document only when nothing is connected to this port -->
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
  
</p:declare-step>