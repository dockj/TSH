#创建数据库
drop database if exists dev_tsh;
create database dev_tsh default character set utf8 collate 'utf8_general_ci';

create user 'dev_tsh'@'%' identified by 'dev_tsh';
grant all on dev_tsh.* to 'dev_tsh'@'%';