<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">

  <p:documentation>
    The proverbial "Hello World" XProc pipeline...
  </p:documentation>

  <!-- ================================================================== -->
  <!-- SETUP: -->

  <p:output port="result" primary="true" sequence="false"/>

  <!-- ================================================================== -->

  <p:identity>
    <p:with-input>
      <hello-xproc timestamp="{current-dateTime()}"/>
    </p:with-input>
  </p:identity>

</p:declare-step>