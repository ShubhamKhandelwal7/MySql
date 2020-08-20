CREATE DATABASE vtapp;
USE vtapp;
CREATE USER 'vtapp_user'@'localhost' IDENTIFIED BY 'cOmPlIcAtEdPaSsWoRd';
GRANT ALL PRIVILEGES ON vtapp TO 'vtapp_user'@'localhost';