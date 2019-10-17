<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
  name="html-conversion-pipeline">

  <p:input port="source" primary="true"/>
  <p:output port="result" primary="true"/>
 
  <p:input port="header-info"/>
  
  <p:xslt>
    <p:with-input port="stylesheet" href="xsl/basic-conversion.xsl"/>
  </p:xslt>
  
  <p:insert match="/html/head" position="last-child">
    <p:with-input port="insertion" select="/*/*">
      <p:pipe step="html-conversion-pipeline" port="header-info"/>
    </p:with-input>
  </p:insert>
  
  <p:viewport match="add-additional-data">
    <p:xslt>
      <p:with-input port="source" href="{resolve-uri(/*/@source, base-uri())}"/>
      <p:with-input port="stylesheet" href="{/*/@stylesheet}"/>
    </p:xslt>
  </p:viewport>
  
</p:declare-step>