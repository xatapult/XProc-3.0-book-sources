<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">

  <p:input port="source" href="input/processable.zip"/>
  <p:output port="result"/>

  <!-- Identify the main zip file: -->
  <p:identity name="original-zip-file"/>
  
  <!-- Test for the main file being present: -->
  <p:archive-manifest/>
  <p:if test="empty(/c:archive/c:entry[@name eq 'demo.html'])">
    <p:error code="no-demo-html">
      <p:with-input>
        <message>The ZIP file does not contain the correct file.</message>
      </p:with-input>
    </p:error>
  </p:if>

  <!-- 1 - Extract the demo.html file: -->
  <p:unarchive include-filter="demo.html">
    <p:with-input pipe="@original-zip-file"/>
  </p:unarchive>
  
  <!-- 2 - Change it by inserting a reference to another image -->
  <p:insert match="body" position="last-child">
    <p:with-input port="insertion">
      <p>Old logo: <img src="additional-images/old.png" width="100"/></p>
    </p:with-input>
  </p:insert>

</p:declare-step>
