curl -X POST --anyauth --user admin:admin \
--header "Content-Type:application/xml" -d@pipeline-options.xml \
http://localhost:8002/manage/v2/databases/police-calls-Triggers/pipelines?format=json
