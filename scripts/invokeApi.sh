# invokes the REST API
curl --anyauth \
--user admin:admin \
-X POST \
-d@"./myRestConfig.xml" -i \
-H "Content-type:application/xml" \
http://localhost:8002/v1/rest-apis

