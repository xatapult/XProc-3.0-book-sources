<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:ex="#examples" version="3.0">

  <p:output port="result" sequence="true"/>

  <p:declare-step type="ex:loader">
    <p:output port="result" sequence="true" content-types="json"/>
    <p:option name="url" required="true"/>
    
    <p:load href="{$url}"/>
    <p:variable name="next-url" select=".('next')"/>
    <p:if test="exists($next-url)">
      <p:output port="result" sequence="true">
        <p:pipe step="copy" port="result"/>
        <p:pipe step="next" port="result"/>
      </p:output>
      <p:identity name="copy"/>
      <ex:loader name="next" url="{$next-url}"/>
    </p:if>
  </p:declare-step>

  <ex:loader url="https://swapi.co/api/people"/>
  
  <p:identity>
    <p:with-input select="for $someone in array:flatten(.('results')) 
                            return $someone('name')"/>
  </p:identity>

</p:declare-step>
