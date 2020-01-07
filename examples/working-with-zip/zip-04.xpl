<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
  exclude-inline-prefixes="#all">

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

  <!-- 1 - Change the manifest so it includes the additional image: -->
  <p:insert match="/*" position="last-child">
    <p:with-input port="insertion">
      <c:entry href="{resolve-uri('additional-images/old.png', static-base-uri())}"
        name="img/old.png"/>
    </p:with-input>
  </p:insert>
  <p:identity name="amended-manifest"/>

  <!-- 2 - Extract the zip file: -->
  <p:unarchive>
    <p:with-input pipe="@original-zip-file"/>
  </p:unarchive>

  <!-- 3 - Add a reference to the additional image to the main file: -->
  <p:for-each>
    <p:if test="p:document-property(., 'base-uri') eq 'demo.html'">
      <p:insert match="body" position="last-child">
        <p:with-input port="insertion">
          <p>Old logo: <img src="img/old.png" width="100"/></p>
        </p:with-input>
      </p:insert>
    </p:if>
  </p:for-each>

  <!-- 4 - Create a new archive and store it: -->
  <p:archive>
    <p:with-input port="manifest" pipe="@amended-manifest"/>
  </p:archive>
  <p:store href="build/zip-result.zip"/>

  <!-- 5 - As a report, output its manifest: -->
  <p:archive-manifest relative-to="build/zip-result.zip/"/>

</p:declare-step>
