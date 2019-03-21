<!-- 1. Pipeline document: -->
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">

  <!-- 2. Pipeline port declarations: -->
  <p:input port="source" primary="true"/>
  <p:output port="result" primary="true"/>

  <!-- 3. Convert document to HTML: -->
  <p:xslt>
    <p:with-input  port="stylesheet" href="xsl/basic-conversion.xsl"/>
  </p:xslt>
  
</p:declare-step>