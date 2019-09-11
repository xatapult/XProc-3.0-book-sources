<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">

  <p:input port="source" content-types="text"/>
  <p:output port="result" content-types="xml"/>

  <p:xslt>
    <p:with-input port="stylesheet" href="text-02.xsl"/>
  </p:xslt>
  
</p:declare-step>
