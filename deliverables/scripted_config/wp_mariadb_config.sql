## Wordpress Database Setup
CREATE DATABASE wordpress;
CREATE USER wordpress_user@localhost IDENTIFIED BY 'P@ssw0rd';
GRANT ALL PRIVILEGES ON wordpress.* to wordpress_user@localhost;

#Reload privilege tables
FLUSH PRIVILEGES;
