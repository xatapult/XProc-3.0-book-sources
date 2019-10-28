<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">

  <p:input port="source" href="input/processable.zip"/>
  <p:output port="result"/>

  <!-- Set up things: -->
  <p:variable name="zip-file-uri" select="p:document-property(., 'base-uri')"/>
  <p:variable name="main-file" select="'demo.html'"/>

  <!-- Test for the main file being present: -->
  <p:archive-manifest/>
  <p:if test="empty(/c:archive/c:entry[@name eq $main-file])">
    <p:error code="no-demo-html">
      <p:with-input>
        <message>The ZIP file {$zip-file-uri} does not contain a 
          {$main-file} file.</message>
      </p:with-input>
    </p:error>
  </p:if>

</p:declare-step>
