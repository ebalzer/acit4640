yum -y install @core wget epel-release vim git tcpdump nmap-ncat mariadb-server mariadb php php-mysql php-fpm
yum -y install nginx
#yum -y update
firewalld-cmd
firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent

systemctl restart firewalld
firewall-cmd --zone=public --list-all


systemctl start nginx

systemctl enable nginx

systemctl start mariadb
mysql -u root < mariadb_security_config.sql
systemctl enable mariadb

systemctl restart mariadb

cp wp_mariadb_config.sql /home/admin/wp_mariadb_config.sql


cp php.ini /etc/php.ini
cp www.conf /etc/php-fpm.d/www.conf
systemctl start php-fpm
systemctl enable php-fpm

cp nginx.conf /etc/nginx/nginx.conf
cp info.php /usr/share/nginx/html/info.php
systemctl restart nginx



mysql -u root -pP@ssw0rd < wp_mariadb_config.sql
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp wp-config.php wordpress/wp-config.php
rsync -avP wordpress/ /usr/share/nginx/html/
mkdir /usr/share/nginx/html/wp-content/uploads
chown -R admin:nginx /usr/share/nginx/html/*
systemctl restart nginx