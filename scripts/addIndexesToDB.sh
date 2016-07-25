
echo
echo Adding element range indexes to police-calls-DB

curl \
-X PUT \
--anyauth \
--digest \
--user admin:admin \
--header "Content-Type:application/json" \
-d@'configs/config-element-range-indexes.json' \
http://localhost:8002/manage/v2/databases/police-calls-DB/properties

echo
echo Adding geospatial element indexes to police-calls-DB

curl \
-X PUT \
--anyauth \
--digest \
--user admin:admin \
--header "Content-Type:application/json" \
-d@'configs/config-geospatial-indexes.json' \
http://localhost:8002/manage/v2/databases/police-calls-DB/properties

