
# Change the triggers DB so that police-calls-triggers can be deleted
curl -X PUT --digest -u admin:admin -H "Content-type: application/xml" \
-d '<database-properties><triggers-database>Triggers</triggers-database></database-properties>'  \
http://localhost:8002/manage/v2/databases/police-calls-DB/properties

# Remove the triggers DB
curl -X DELETE --anyauth -u admin:admin --header "Content-Type:application/json" \
http://localhost:8002/manage/v2/databases/police-calls-Triggers

# Remove the triggers DB
curl -X DELETE --anyauth -u admin:admin --header "Content-Type:application/json" \
http://localhost:8002/manage/v2/databases/police-calls-DB/domains/police-calls-domain
