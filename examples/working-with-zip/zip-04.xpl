<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
  exclude-inline-prefixes="#all">

  <p:input port="source" href="input/processable.zip"/>
  <p:output port="result"/>

  <!-- Identify the main zip file: -->
  <p:identity name="original-zip-file"/>

  <!-- Set up things: -->
  <p:variable name="zip-file-uri" select="p:document-property(., 'base-uri')"/>
  <p:variable name="main-file" select="'demo.html'"/>
  <p:variable name="additional-image" select="'old.png'"/>
  <p:variable name="img-target-folder" select="'img'"/>
  <p:variable name="img-source-folder" select="'additional-images'"/>

  <!-- Test for the main file being present: -->
  <p:archive-manifest/>
  <p:if test="empty(/c:archive/c:entry[@name eq $main-file])">
    <p:error code="no-demo-html">
      <p:with-input>
        <message>The ZIP file {$zip-file-uri} does not contain a {$main-file} file.</message>
      </p:with-input>
    </p:error>
  </p:if>

  <!-- Change the manifest so it includes the additional image: -->
  <p:variable name="source-image-location"
    select="resolve-uri($img-source-folder || '/' || $additional-image, static-base-uri())"/>
  <p:insert match="/*" position="last-child">
    <p:with-input port="insertion">
      <c:entry href="{$source-image-location}"
        name="{$img-target-folder}/{$additional-image}"/>
    </p:with-input>
  </p:insert>
  <p:identity name="amended-manifest"/>

  <!-- Extract the zip file: -->
  <p:unarchive>
    <p:with-input pipe="@original-zip-file"/>
  </p:unarchive>

  <!-- Add a reference to the additional image to the main file: -->
  <p:for-each>
    <p:if test="p:document-property(., 'base-uri') eq $main-file">
      <p:insert match="body" position="last-child">
        <p:with-input port="insertion">
          <p>Old logo: 
            <img src="{$img-source-folder}/{$additional-image}" width="100"/>
          </p>
        </p:with-input>
      </p:insert>
    </p:if>
  </p:for-each>

  <!-- Create a new archive and store it: -->
  <p:archive>
    <p:with-input port="manifest" pipe="@amended-manifest"/>
    <p:with-input port="archive">
      <p:empty/>
    </p:with-input>
  </p:archive>
  <p:store href="../../build/zip-result.zip"/>

  <!-- As a report, output its manifest: -->
  <p:archive-manifest/>

</p:declare-step>
