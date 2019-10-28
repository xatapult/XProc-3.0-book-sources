<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">

  <p:input port="source" href="input/processable.zip"/>
  <p:output port="result"/>

  <!-- Identify the main zip file: -->
  <p:identity name="original-zip-file"/>

  <!-- Set up things: -->
  <p:variable name="zip-file-uri" select="p:document-property(., 'base-uri')"/>
  <p:variable name="main-file" select="'demo.html'"/>
  <p:variable name="additional-image" select="'old.png'"/>
  <p:variable name="img-target-folder" select="'img'"/>

  <!-- Test for the main file being present: -->
  <p:archive-manifest/>
  <p:if test="empty(/c:archive/c:entry[@name eq $main-file])">
    <p:error code="no-demo-html">
      <p:with-input>
        <message>The ZIP file {$zip-file-uri} does not contain 
          a {$main-file} file.</message>
      </p:with-input>
    </p:error>
  </p:if>

  <!-- Extract and change the main file: -->
  <p:unarchive include-filter="{$main-file}">
    <p:with-input pipe="@original-zip-file"/>
  </p:unarchive>
  <p:insert match="body" position="last-child">
    <p:with-input port="insertion">
      <p>Old logo: 
        <img src="{$img-target-folder}/{$additional-image}" width="100"/>
      </p>
    </p:with-input>
  </p:insert>

</p:declare-step>
