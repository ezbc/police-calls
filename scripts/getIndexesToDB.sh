
echo
echo Adding element range indexes to police-calls-DB

curl \
-X GET \
--anyauth \
--digest \
--user admin:admin \
--header "Accept:application/json" \
-d '{"format": "json"}' \
http://localhost:8002/manage/v2/databases/police-calls-DB/properties
