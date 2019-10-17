<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">

  <p:input port="source" primary="true"/>
  <p:output port="result" primary="true"/>
  
  <p:option name="additional-header-info-file"
    select="'../documents/additional-header-contents.xml'"/>

  <p:xslt>
    <p:with-input port="stylesheet" href="xsl/basic-conversion.xsl"/>
  </p:xslt>
  
  <p:insert match="/html/head" position="last-child">
    <p:with-input port="insertion" select="/*/*">
      <p:document href="{$additional-header-info-file}"/>
    </p:with-input>
  </p:insert>
  
</p:declare-step>