<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:ex="#examples" version="3.0">

  <!-- 1 - Define the output port as a sequence: -->
  <p:output port="result" sequence="true"/>

  <!-- 2 - Define a subpipeline that will call itself recursively to 
           load all the documents: -->
  <p:declare-step type="ex:loader">
    <p:output port="result" sequence="true" content-types="json"/>
    <p:option name="url" required="true"/>
    
    <!-- 3 - Load the requested document: -->
    <p:load href="{$url}"/>
    <!-- 4 - Put the address of the next page in a variable: -->
    <p:variable name="next-url" select=".('next')"/>
    <!-- 5 - If the next page's URL is not (), get it: -->
    <p:if test="$next-url">
      <!-- 6 - Output the loaded document and the next document(s): -->
      <p:output port="result" sequence="true">
        <p:pipe step="copy" port="result"/>
        <p:pipe step="next" port="result"/>
      </p:output>
      <p:identity name="copy"/>
      <ex:loader name="next" url="{$next-url}"/>
    </p:if>
  </p:declare-step>

  <!-- 7 - Call the loader to get all the documents: -->
  <ex:loader url="https://swapi.co/api/people"/>

</p:declare-step>
