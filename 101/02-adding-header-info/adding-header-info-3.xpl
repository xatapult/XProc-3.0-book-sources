<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0" name="html-conversion-pipeline">

  <!-- 1. Make a default connection for the source input port to a document: -->
  <p:input port="source" primary="true">
    <p:document href="../documents/example-contents-1.xml"/>
  </p:input>
  <p:output port="result" primary="true"/>

  <!-- 2. Supply a fixed default document for the header-info port: -->
  <p:input port="header-info">
    <p:inline>
      <additional-header-contents>
        <link rel="stylesheet" type="text/css" href="style-1.css"/>
        <script type="text/javascript" src="javascript-1.js"/>
      </additional-header-contents>
    </p:inline>
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
