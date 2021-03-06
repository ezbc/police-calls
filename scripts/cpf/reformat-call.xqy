xquery version "1.0-ml";
import module namespace cpf = "http://marklogic.com/cpf" at "/MarkLogic/cpf/cpf.xqy";
import module namespace json = "http://marklogic.com/xdmp/json"
    at "/MarkLogic/json/json.xqy";

(: example string
"{"address":"100 S HENRY ST","city":"MADISON","state":"WI","zip":""}"
:)
declare function local:jsonStringToXML($string as xs:string)
{
  let $element := <json>{json:transform-from-json(xdmp:from-json-string($string),
                                                  json:config("custom")
                                                  )
                         }
                  </json>
  return $element
};

(: reformats doc :)
declare function local:transformDoc($docs)
{
  for $doc in $docs
  let $address := local:jsonStringToXML($doc/row/address/@human_address)
  return 
  (<call type="object">{$doc/row/text()}
    <incident_number type="integer">{$doc/row/incident_number/text()}</incident_number>
    <id type="integer">{fn:string($doc/row/@_id)}</id>
    <type type="string">{$doc/row/type/text()}</type>
    <description type="string">{$doc/row/description/text()}</description>
    <date_time type="date_time">{$doc/row/date_time/text()}</date_time>
    <address type="object">
      <street type="string">{$address/address/text()}</street>
      <city type="string">{$address/city/text()}</city>
      <state type="string">{$address/state/text()}</state>
      <zip type="integer">{$address/zip/text()}</zip>
      <geo type="object">
        <lat type="float">{fn:number($doc/row/address/@latitude)}</lat>
        <lng type="float">{fn:number($doc/row/address/@longitude)}</lng>
      </geo>
    </address>
  </call>)
};

(: Parses URI and reformats doc :)
declare function local:createReformattedDoc($doc)
{
    for $doc in fn:doc($doc)
    let $oldDoc := $doc
    let $uri := fn:document-uri($oldDoc)
    let $newDoc := local:transformDoc($doc)
    let $oldUriTokens := fn:tokenize($uri, "/")
    return (xdmp:node-replace(fn:doc($uri)/*,
                             $newDoc
                             )
    )
};

(:
declare function local:createReformattedDoc($doc)
{
  return (xdmp:log("success"))
};:)

declare variable $cpf:document-uri as xs:string external;
declare variable $cpf:transition as node() external;

(: Determine the transition type in the pipeline :)
if (cpf:check-transition($cpf:document-uri,$cpf:transition)) then try
{
    let $message := "successful run test.xqy"
    let $doc := $cpf:document-uri
    return ( 
            local:createReformattedDoc($doc),
            cpf:success( $cpf:document-uri, $cpf:transition, () )
    )
}
catch ($e) {
    cpf:failure( $cpf:document-uri, $cpf:transition, $e, () )
}
else ()
