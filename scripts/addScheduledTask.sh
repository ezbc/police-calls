# deploying the task script
echo
echo Deploying the task script...

curl \
-X PUT \
--anyauth \
--user admin:admin \
--data-binary @'tasks/get-recent-data.xqy' \
-H "Content-type:application/xqy" \
"http://localhost:7004/v1/documents?uri=/load/get-recent-data.xqy&database=police-calls-Mod"

# Configuring the scheduled task
echo
echo Adding scheduled task to police-calls-DB...

curl \
-X POST \
--digest \
--user admin:admin \
--data-binary @'configs/config-scheduled-task.json' \
-H "Content-type: application/json" \
http://localhost:8002/manage/v2/tasks?group-id=Default
