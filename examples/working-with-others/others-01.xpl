<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">

  <!-- 1 - Define an output port for a simple report document. 
    We don't need an input port -->
  <p:output port="result"/>

  <!-- 2 - Define options to pass in the input and output base directory -->
  <p:option name="input-directory" select="'input'"/>
  <p:option name="output-base-directory" select="'output'"/>

  <!-- 3 - Create a list of files in the input directory -->
  <p:directory-list path="{$input-directory}"/>

  <!-- 4 - Loop over all files in the input directory -->
  <p:for-each>
    <p:with-input select="//c:file"/>

    <!-- 5 - Load the file and determine its content-type -->
    <p:load href="{$input-directory}/{/*/@name}"/>
    <p:variable name="content-type" select="p:document-property(., 'content-type')"/>

    <!-- 6 - Based on the content type, store the document in a 
      particular directory -->
    <p:choose>
      <p:when test="$content-type eq 'application/xml'">
        <p:store href="{$output-base-directory}/xml"/>
      </p:when>
      <p:when test="$content-type eq 'image/jpeg'">
        <p:store href="{$output-base-directory}/jpg"/>
      </p:when>
      <p:otherwise>
        <p:store href="{$output-base-directory}/junk"/>
      </p:otherwise>
    </p:choose>

  </p:for-each>

  <!-- 7 - Just return the number of processed documents -->
  <p:count/>
  
</p:declare-step>
