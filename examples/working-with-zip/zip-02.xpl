<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">

  <p:input port="source" href="input/processable.zip"/>
  <p:output port="result"/>

  <!-- Test for the main file being present: -->
  <p:archive-manifest/>
  <p:if test="empty(/c:archive/c:entry[@name eq 'demo.html'])">
    <p:error code="no-demo-html">
      <p:with-input>
        <message>The ZIP file does not contain the correct file.</message>
      </p:with-input>
    </p:error>
  </p:if>

</p:declare-step>
