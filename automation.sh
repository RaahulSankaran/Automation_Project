sudo apt-get install update
sudo apt-get install apache2

myname=raahul
apache=$(systemctl status apache2)
echo "Apache status:" $apache
currentdate=$(date '+%d%m%Y-%H%M%S')

sudo tar -zcvf ${myname}-httpd-logs-$currentdate.tar /var/log/apache2/*.log

s3_bucket=upgrad-raahul
mv ${myname}-httpd-logs-{$currentdate}.tar /tmp
chmod +x /tmp/${myname}-httpd-logs-$currentdate.tar

aws s3 /
cp /tmp/${myname}-httpd-logs-${currentdate}.tar \
s3://%{s3_bucket}/${myname}-httpd-logs-${currentdate}.tar

size=$(du -h /tmp/${myname}-httpd-logs-$currentdate.tar)

echo "httpd-logs \t"$currentdate "\ttar \t" $size>>/var/www/html/inventory.html
