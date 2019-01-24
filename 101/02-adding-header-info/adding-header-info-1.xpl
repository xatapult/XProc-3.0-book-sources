<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">

  <p:input port="source" primary="true"/>
  <p:output port="result" primary="true"/>
  
  
  <!-- 1. Define filename in variable: -->
  <p:variable name="additional-header-info-file" 
    select="'../documents/additional-header-contents.xml'"/>

  <p:xslt>
    <p:with-input port="stylesheet" href="xsl/basic-conversion.xsl"/>
  </p:xslt>
  
  <!-- 2. The p:xslt step and the p:insert step implicitly connect -->
  
  <!-- 3. Insert the additional information: -->
  <p:insert match="/html/head" position="last-child">
    <p:with-input port="insertion" select="/*/*">
      <p:document href="{$additional-header-info-file}"/>
    </p:with-input>
  </p:insert>
  
</p:declare-step>