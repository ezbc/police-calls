xquery version "1.0-ml";

declare function local:getMadData($lastDocTimestamp)
{
  (: Query the Madison data API for all documents later than timestamp :)
  let $query := fn:concat("?$where=date_time>'",$lastDocTimestamp,"'&amp;$order=date_time")
  let $domain := "https://data.cityofmadison.com/resource/4gss-84dk.xml"
  let $url := fn:concat($domain, $query)
  let $response := xdmp:http-get($url,
       <options xmlns="xdmp:http">
         <headers>
           <X-App-Token>KWMbbqr3lsHllH1QWoK17sKRg</X-App-Token>
         </headers>
       </options>)[2]

  return $response/response/row/row
};

declare function local:loadMadData($lastDocTimestamp)
{
  (: get the data from the Mad Api :)
  let $docs := local:getMadData($lastDocTimestamp)
  return 
    if (fn:not(fn:empty($docs)))
    then (
      (: change the timestamp to the latest provided by the Madison API :)
      let $lastDocTimestamp := fn:max(xs:dateTime($docs/date_time/text()))
      return
        (fn:concat("Number of docs retrieved: ", fn:count($docs)),
         fn:concat("For timestamps greater than: ", $lastDocTimestamp),
          (: load each new document :)
          (for $doc in $docs
            (: assign random, but unique uri :)
            let $uri := fn:concat("/calls/",fn:string($doc/@_uuid))
            return 
              (xdmp:document-insert($uri, $doc)
              )
            ),

          (for $lastDocTimestamp in $lastDocTimestamp
             return local:loadMadData($lastDocTimestamp)
           )
      )
    )
    else ()
};

(: get document with latest timestamp:)
let $lastDocTimestamp := cts:max(cts:element-reference(xs:QName("date_time")))

return (xdmp:log($lastDocTimestamp), local:loadMadData($lastDocTimestamp))
