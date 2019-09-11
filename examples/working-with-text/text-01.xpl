<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">

  <p:input port="source" content-types="text"/>
  <p:output port="result" content-types="text"/>

  <p:text-replace pattern="^.*#.*$" replacement="" flags="m"/>
</p:declare-step>
