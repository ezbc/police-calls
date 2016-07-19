
# create a triggers DB
echo
echo Creating triggers DB...

curl \
-X POST \
--anyauth \
-u admin:admin \
--header "Content-Type:application/json" \
-d@'configs/config-triggers-DB.json' \
http://localhost:8002/manage/v2/databases

# create a forest and attach it to the triggers DB
echo
echo Creating triggers forest...

curl \
-X POST \
--anyauth \
-u admin:admin \
-d@'configs/config-forest-create.json' \
-i \
-H "Content-type: application/json" \
http://localhost:8002/manage/v2/forests

curl \
-X PUT \
--digest \
-u admin:admin \
-H "Content-type: application/json" \
-d@'configs/config-forest-attach.json' \
http://localhost:8002/manage/v2/databases/police-calls-Triggers/properties

# link the data DB to the triggers DB
echo
echo Linking data DB to triggers DB...

curl \
-X PUT \
--digest \
-u admin:admin \
-H "Content-type: application/json" \
-d@'configs/config-link-triggers-DB.json' \
http://localhost:8002/manage/v2/databases/police-calls-DB/properties

# load default pipelines on triggers DB
echo
echo Loading default pipelines...

curl \
-X POST \
--anyauth \
--user admin:admin \
--header "Content-Type:application/json" \
-d@'configs/config-pipeline-defaults.json' \
http://localhost:8002/manage/v2/databases/police-calls-Triggers/pipelines?format=json

# create a new pipeline
echo
echo Creating new pipeline...

curl \
-X POST \
--anyauth \
--user admin:admin \
--header "Content-Type:application/xml" \
-d@'configs/config-pipeline.xml' \
http://localhost:8002/manage/v2/databases/police-calls-Triggers/pipelines?format=xml

# create a CPF domain with status change handling and the custom pipeline
echo
echo Creating CPF domain...

curl \
-X POST \
--anyauth \
--user admin:admin \
--header "Content-Type:application/json" \
-d@'configs/config-domain-setup.json' \
http://localhost:8002/manage/v2/databases/police-calls-Triggers/domains?format=json

# install and configure the CPF
echo
echo Installing CPF...

curl \
-X POST \
--anyauth \
--user admin:admin \
--header "Content-Type:application/json" \
-d@'configs/config-cpf-install.json' \
http://localhost:8002/manage/v2/databases/police-calls-Triggers/cpf-configs?format=json


# deploy the action module
echo
echo Deploying the action module...

curl \
-X PUT \
--anyauth \
--user admin:admin \
--data-binary @'reformat-call.xqy' \
-H "Content-type:application/xqy" \
"http://localhost:7004/v1/documents?uri=/load/reformat-call.xqy&database=police-calls-Mod"

#http://localhost:8000/v1/ext/cpf/load/reformat-call.xqy
