use dev_tsh;
#初始化角色数据
insert into t_sys_role(name,description,roleNo,status,createBy,createDate,updateBy,updateDate) values('医生','医生','1','0','0',now(),'0',now());
insert into t_sys_role(name,description,roleNo,status,createBy,createDate,updateBy,updateDate) values('患者','病人','2','1','0',now(),'0',now());
#插入字典表甲亢类型信息
insert into t_dictionary(dataKey,dataType,dataValue) values ('10001','assType','阳性症状');
insert into t_dictionary(dataKey,dataType,dataValue) values ('10002','assType','阴性症状');
#插入医生信息，医生默认登入密码为：1234 用户名为：lsj
insert into t_sys_user(username,password,realname,sex,certiType,certiCode,age,mobilePhone,email,address,status,registerDate)
values('lsj','MTIzNA==','张三','1','1','350566199266178923','12','18673652617','jjie199@qq.com','湖南长沙','1','2016-5-7');

insert into t_sys_role_user(description,roleNo,userId)
select '医生','1',max(id) from t_sys_user;
commit;