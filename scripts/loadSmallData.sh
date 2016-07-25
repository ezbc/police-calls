

# if on windows git bash, replace with Windows filepath
export file=$( readlink -f ../data/police-calls-small.xml )
export file="${file/\/c\//\/C:/}"
echo Loading $file...
echo 

# import data with content pump
# regex ^ replaces the first character (empty) of the string
# @_uuid uses the element attribute _uuid to assign the URI
mlcp.sh import \
-host localhost \
-port 7004 \
-username admin \
-password admin \
-mode local \
-input_file_path $file \
-input_file_type aggregates \
-aggregate_record_element row \
-output_uri_replace "^,'/calls/call/'" \
-uri_id @_uuid
