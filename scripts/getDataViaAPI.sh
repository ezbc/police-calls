
DATETIME=$(date +%Y%m%d)
echo calls-$DATETIME.xml

curl -X GET \
-H "X-App-Token:KWMbbqr3lsHllH1QWoK17sKRg" \
https://data.cityofmadison.com/resource/4gss-84dk.xml?\$where=date_time\>\'2016-07-01T00:00:00\'\&\$order=date_time


#\$\$app_token=KWMbbqr3lsHllH1QWoK17sKRg
#-H -d@"http-header.xml" \

# two different datasets:
# sf9b-g7bs 
# 4gss-84dk
