curl --anyauth \
--user admin:admin \
-X DELETE \
http://localhost:8002/manage/v2/databases/ukhealth-DB

curl --anyauth \
--user admin:admin \
-X DELETE \
http://localhost:8002/manage/v2/databases/ukhealth-Mod

for ((i=1; i<=3; i++)) do
    echo ukhealth-DB-$i
    curl --anyauth \
    --user admin:admin \
    -X DELETE \
    http://localhost:8002/manage/v2/forests/ukhealth-DB-$i?level=full
    curl --anyauth \
    --user admin:admin \
    -X DELETE \
    http://localhost:8002/manage/v2/forests/ukhealth-Mod-$i?level=full
done
