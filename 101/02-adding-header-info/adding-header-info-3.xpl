<!-- 1. Provide a name for the step: -->
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
  name="html-conversion-pipeline">

  <p:input port="source" primary="true"/>
  <p:output port="result" primary="true"/>
  
  <!-- 2. Define additional input port -->
  <p:input port="header-info"/>
  
  <p:xslt>
    <p:with-input port="stylesheet" href="xsl/basic-conversion.xsl"/>
  </p:xslt>
  
  <p:insert match="/html/head" position="last-child">
    <p:with-input port="insertion" select="/*/*">
      <!-- 3. Connect the insertion port of p:insert to the header-info 
        port of the step: -->
      <p:pipe step="html-conversion-pipeline" port="header-info"/>
    </p:with-input>
  </p:insert>
  
</p:declare-step>