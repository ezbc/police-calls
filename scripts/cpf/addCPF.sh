curl -X POST  --anyauth --user admin:admin --header "Content-Type:application/json" \
-d@setup-cpf.json http://localhost:8002/manage/v2/databases/police-calls-DB/cpf-configs?format=json
