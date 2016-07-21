

echo
echo Deleting forests for DB and Modules...
for ((i=1; i<=3; i++)) do
    echo police-calls-DB-$i
    curl --anyauth \
    --user admin:admin \
    -X PUT \
    -d '{"enabled":false}' \
    http://localhost:8002/manage/v2/forests/police-calls-DB-$i?properties

    curl --anyauth \
    --user admin:admin \
    -X DELETE \
    http://localhost:8002/manage/v2/forests/police-calls-DB-$i?level=full

    echo police-calls-Mod-$i
    curl --anyauth \
    --user admin:admin \
    -X DELETE \
    http://localhost:8002/manage/v2/forests/police-calls-Mod-$i?level=full

    echo police-calls-Triggers-$i
    curl --anyauth \
    --user admin:admin \
    -X DELETE \
    http://localhost:8002/manage/v2/forests/police-calls-Triggers-0$i?level=full
done

echo
echo Deleting DB...

curl --anyauth \
--user admin:admin \
-X DELETE \
http://localhost:8002/manage/v2/databases/police-calls-DB

echo
echo Deleting modules...

curl --anyauth \
--user admin:admin \
-X DELETE \
http://localhost:8002/manage/v2/databases/police-calls-Mod

