

# if on windows git bash, replace with Windows filepath
export file=$( readlink -f ../data/police-calls.xml )
export file="${file/\/c\//\/C:/}"
echo Loading $file...
echo 

# import data with content pump
mlcp.sh import \
-host localhost \
-port 7004 \
-username admin \
-password admin \
-mode local \
-input_file_path $file \
-input_file_type aggregates \
-aggregate_record_element row \
-output_uri_replace "$file,'/calls/'"
