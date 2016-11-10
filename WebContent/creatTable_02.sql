use dev_tsh;
drop table if exists `t_sys_user`;
CREATE TABLE `t_sys_user` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(50) NOT NULL COMMENT '密码',
    `realname` VARCHAR(30) DEFAULT NULL COMMENT '用户真实姓名',
    `sex` VARCHAR(2) DEFAULT NULL COMMENT '性别 1、男 2、女',
    `certiType` VARCHAR(2) DEFAULT NULL COMMENT '证件类型 1、身份证',
    `certiCode` VARCHAR(18) DEFAULT NULL COMMENT '证件号码',
    `age` TINYINT(2) DEFAULT 0 COMMENT '年龄',
    `mobilePhone` VARCHAR(13) DEFAULT NULL COMMENT '电话号码',
    `email` VARCHAR(50) DEFAULT NULL COMMENT '电子邮箱',
    `address` VARCHAR(200) DEFAULT NULL COMMENT '家庭住址',
    `status` INT(11) DEFAULT NULL COMMENT '用户状态',
    `registerDate` DATE DEFAULT NULL COMMENT '用户注册时间',
    `levHosDate` DATE DEFAULT NULL COMMENT '出院时间',
    `createDate` DATETIME DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    `createBy` VARCHAR(20) DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL,
    KEY `i_tsu_name` (`username`),
    KEY `i_tsu_pwd` (`password`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '用户信息表';

drop table if exists t_sys_menu;
CREATE TABLE `t_sys_menu` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `menuNo` VARCHAR(20) DEFAULT NULL COMMENT '菜单编号',
    `name` VARCHAR(50) DEFAULT NULL COMMENT '菜单名称',
    `description` VARCHAR(100) DEFAULT NULL COMMENT '描述',
    `invokeUrl` VARCHAR(150) DEFAULT NULL COMMENT 'URL地址',
    `createBy` VARCHAR(20) DEFAULT NULL,
    `createDate` DATETIME DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    KEY `i_tsm_mn` (`menuNo`),
    PRIMARY KEY (`id`)
)  ENGINE=INNODB AUTO_INCREMENT=28 DEFAULT CHARSET=UTF8 COMMENT '访问菜单表';

drop table if exists t_sys_role;
CREATE TABLE `t_sys_role` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` varchar(20) default null comment '角色名称',
    `description` VARCHAR(50) DEFAULT NULL COMMENT '描述',
    `roleNo` VARCHAR(20) DEFAULT NULL COMMENT '角色编码',
    `status` VARCHAR(2) DEFAULT NULL COMMENT '角色状态 0表示不可注册 1表示可注册',
    `createBy` VARCHAR(20) DEFAULT NULL,
    `createDate` DATETIME DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    KEY `i_tsr_rn` (`roleNo`)
)  ENGINE=INNODB CHARSET=UTF8 COMMENT '角色表';

drop table if exists t_sys_menu_role;
CREATE TABLE `t_sys_menu_role` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `description` VARCHAR(50) DEFAULT NULL COMMENT '描述',
    `roleNo` VARCHAR(20) DEFAULT NULL COMMENT '角色编码',
    `menuNo` VARCHAR(20) DEFAULT NULL COMMENT '菜单编号',
    `createBy` VARCHAR(20) DEFAULT NULL,
    `createDate` DATETIME DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    KEY `i_tsmr_rn` (`roleNo`),
    KEY `i_tsmr_mn` (`menuNo`)
)  ENGINE=INNODB CHARSET=UTF8 COMMENT '角色表';

drop table if exists t_sys_role_user;
CREATE TABLE `t_sys_role_user` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `description` VARCHAR(50) DEFAULT NULL COMMENT '描述',
    `roleNo` VARCHAR(20) DEFAULT NULL COMMENT '角色编码',
    `userId` VARCHAR(20) DEFAULT NULL COMMENT '用户id',
    `createBy` VARCHAR(20) DEFAULT NULL,
    `createDate` DATETIME DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    KEY `i_tsru_rn` (`roleNo`),
    KEY `i_tsru_ui` (`userId`)
)  ENGINE=INNODB CHARSET=UTF8 COMMENT '角色表用户关联表';



drop table if exists `t_tsh_assess`;
CREATE TABLE `t_tsh_assess` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `assCode` VARCHAR(6) DEFAULT NULL COMMENT '自评题目编码',
    `title` VARCHAR(500) NOT NULL COMMENT '自评题目',
    `remark` VARCHAR(500) NOT NULL COMMENT '备注',
    `type` VARCHAR(50) DEFAULT NULL COMMENT '类型',
    `typeCode` VARCHAR(20) DEFAULT NULL COMMENT '类型编码',
    `flushDate` DATE DEFAULT NULL COMMENT '更新时间',
    `status` VARCHAR(2) DEFAULT NULL COMMENT '状态 0、保存 1、发布 2、禁用',
    `createDate` DATETIME DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    `createBy` VARCHAR(20) DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '甲亢自评表';

drop table if exists `t_tsh_assess_score`;
CREATE TABLE `t_tsh_assess_score` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `assessId` VARCHAR(20) NOT NULL COMMENT '自评表id',
    `option` VARCHAR(200) DEFAULT NULL COMMENT '选项',
    `score` TINYINT(3) DEFAULT NULL COMMENT '选项分数',
    `createDate` DATETIME DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    `createBy` VARCHAR(20) DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '甲亢自评表对应分数';


drop table if exists `t_dictionary`;
CREATE TABLE `t_dictionary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dataKey` varchar(100) DEFAULT NULL COMMENT '数据key',
  `dataValue` varchar(100) DEFAULT NULL COMMENT '数据value',
  `dataType` varchar(100) DEFAULT NULL COMMENT '数据类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT '字典表';

drop table if exists `t_tsh_assess_user`;
CREATE TABLE `t_tsh_assess_user` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `assessId` VARCHAR(20) NOT NULL COMMENT '自评表id',
    `evaId` VARCHAR(20) DEFAULT NULL COMMENT '评测结果表id',
    `userId` VARCHAR(20) DEFAULT NULL COMMENT '用户id',
    `score` TINYINT(3) DEFAULT NULL COMMENT '选项分数',
    `scoreId` VARCHAR(20) DEFAULT NULL COMMENT '分数表id',
    `type` VARCHAR(50) DEFAULT NULL COMMENT '类型',
    `typeCode` VARCHAR(20) DEFAULT NULL COMMENT '类型编码',
    `createDate` DATETIME DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    `createBy` VARCHAR(20) DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '患者自评表信息';


drop table if exists `t_tsh_eva_result`;
CREATE TABLE `t_tsh_eva_result` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `userId` VARCHAR(20) DEFAULT NULL COMMENT '用户id',
    `username` VARCHAR(30) DEFAULT NULL COMMENT '用户名',
    `totalScore` DECIMAL(8 , 2 ) DEFAULT NULL COMMENT '评测总分',
    `totalItem` TINYINT(3) DEFAULT NULL COMMENT '总项目数',
    `evaDate` DATETIME DEFAULT NULL COMMENT '评测时间',
    `result` VARCHAR(500) DEFAULT NULL COMMENT '评论结果',
    `status` VARCHAR(2) DEFAULT NULL COMMENT '评论状态 1、未评论 2、已评论',
    `assessUserId` BIGINT(20) DEFAULT NULL COMMENT '评论用户id',
    `assessUserName` VARCHAR(30) DEFAULT NULL COMMENT '评论用户名',
    `resultDate` date default null comment '评论时间',
    `createDate` DATETIME DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    `createBy` VARCHAR(20) DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '患者评测结果表';

drop table if exists `t_tsh_follow_up`;
CREATE TABLE `t_tsh_follow_up` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `userId` VARCHAR(20) DEFAULT NULL COMMENT '用户id',
    `followDate` DATE DEFAULT NULL COMMENT '随访时间',
    `status` VARCHAR(2) DEFAULT NULL COMMENT '访问状态 1、未访问 2、已访问',
    `followedDate` DATE DEFAULT NULL COMMENT '实际访问时间',
	`result` varchar(500) comment '访问结果',
    `createDate` DATETIME DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    `createBy` VARCHAR(20) DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '随访时间设置表';

drop table if exists `t_tsh_bbs_topic`;
CREATE TABLE `t_tsh_bbs_topic` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `topicName` VARCHAR(20) DEFAULT NULL COMMENT '主题名称',
    `status` VARCHAR(2) DEFAULT NULL COMMENT '主题状态',
    `userId` varchar(20) default null comment '创建用户id',
    `createDate` DATETIME DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    `createBy` VARCHAR(20) DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '主题名称';

drop table if exists `t_tsh_bbs_post`;
CREATE TABLE `t_tsh_bbs_post` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`topicId` varchar(20) DEFAULT NULL COMMENT '主题id',
    `topicName` VARCHAR(20) DEFAULT NULL COMMENT '主题名称',
    `postName` varchar(300) default null comment '帖子名称',
    `postContent` longtext default null comment '帖子内容',
    `status` VARCHAR(2) DEFAULT NULL COMMENT '帖子状态',
    `userId` varchar(20) default null comment '帖子用户id',
    `username` varchar(20) default null comment '帖子用户名',
    `realname` varchar(20) default null comment '帖子用户真实姓名',
    `createDate` DATETIME DEFAULT NUlL,
    `updateDate` DATETIME DEFAULT NULL,
    `createBy` VARCHAR(20) DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '话题表';

drop table if exists `t_tsh_bbs_reply`;
CREATE TABLE `t_tsh_bbs_reply` (
    `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`postId` varchar(20) DEFAULT NULL COMMENT '帖子id',
    `postName` VARCHAR(20) DEFAULT NULL COMMENT '帖子名称',
    `replyContent` VARCHAR(500) DEFAULT NULL COMMENT '回复内容',
	`userId` VARCHAR(20) DEFAULT NULL COMMENT '回复用户id',
    `username` varchar(20) default null comment '回复用户名',
    `realname` varchar(20) default null comment '回复用户真实姓名',
    `floor` varchar(20) default null comment '楼层',
    `status` VARCHAR(2) DEFAULT NULL COMMENT '回复状态 ',
    `createDate` DATETIME DEFAULT NULL,
    `updateDate` DATETIME DEFAULT NULL,
    `createBy` VARCHAR(20) DEFAULT NULL,
    `updateBy` VARCHAR(20) DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '回复表';


