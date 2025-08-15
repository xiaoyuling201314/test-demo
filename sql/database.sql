#20250610 冷链单位信息管理，经营单位管理
CREATE TABLE `cold_chain_unit` (
	`id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
	`reg_name` VARCHAR ( 100 ) DEFAULT NULL COMMENT '单位名称',
	`depart_id` INT ( 11 ) DEFAULT NULL COMMENT '所属组织机构ID',
	`reg_type` INT ( 11 ) DEFAULT NULL COMMENT '单位类型：0 企业，1 个人',
	`credit_code` VARCHAR ( 100 ) DEFAULT NULL COMMENT '统一社会信用代码',
	`company_name` VARCHAR ( 100 ) DEFAULT NULL COMMENT '企业名称',
	`legal_person` VARCHAR ( 12 ) DEFAULT NULL COMMENT '法人名称',
	`legal_phone` VARCHAR ( 12 ) DEFAULT NULL COMMENT '法人联系方式',
	`link_user` VARCHAR ( 20 ) DEFAULT NULL COMMENT '联系人',
	`link_phone` VARCHAR ( 20 ) DEFAULT NULL COMMENT '联系方式',
	`link_idcard` VARCHAR ( 20 ) DEFAULT NULL COMMENT '联系人身份证',
	`region_id` DOUBLE DEFAULT NULL COMMENT '所属区域id',
	`reg_address` VARCHAR ( 200 ) DEFAULT NULL COMMENT '详细地址',
	`place_x` VARCHAR ( 30 ) DEFAULT NULL COMMENT '坐标x，经度',
	`place_y` VARCHAR ( 30 ) DEFAULT NULL COMMENT '坐标y，纬度',
	`qrcode` VARCHAR ( 100 ) DEFAULT NULL COMMENT '二维码',
	`file_path` VARCHAR ( 100 ) DEFAULT NULL COMMENT '附件',
	`remark` VARCHAR ( 200 ) DEFAULT NULL COMMENT '备注',
	`checked` SMALLINT ( 6 ) DEFAULT NULL COMMENT '审核状态',
	`delete_flag` SMALLINT ( 6 ) DEFAULT '0' COMMENT '删除状态',
	`sorting` SMALLINT ( 6 ) DEFAULT NULL COMMENT '排序',
	`create_by` VARCHAR ( 32 ) DEFAULT NULL COMMENT '创建人id',
	`create_date` DATETIME DEFAULT NULL COMMENT '创建时间',
	`update_by` VARCHAR ( 32 ) DEFAULT NULL COMMENT '修改人id',
	`update_date` DATETIME DEFAULT NULL COMMENT '修改时间',
	`param1` VARCHAR ( 20 ) DEFAULT NULL COMMENT '预留参数1',
	`param2` VARCHAR ( 250 ) DEFAULT '' COMMENT '预留参数2',
	`param3` VARCHAR ( 100 ) DEFAULT NULL COMMENT '预留参数3',
	PRIMARY KEY ( `id` ),
KEY `inx_departId` ( `reg_type`, `depart_id` ) USING BTREE
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '冷链单位信息管理';

CREATE TABLE `inspection_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cold_unit_id` int(11) DEFAULT NULL COMMENT '冷链单位ID',
  `company_name` varchar(100) DEFAULT NULL COMMENT '名称',
  `company_code` varchar(50) DEFAULT NULL COMMENT '仓口编号',
  `company_type` smallint(6) DEFAULT '0' COMMENT '类型：0企业，1个人',
  `credit_code` varchar(100) DEFAULT NULL COMMENT '统一社会信用代码',
  `legal_person` varchar(32) DEFAULT NULL COMMENT '法定代表人',
  `legal_phone` varchar(20) DEFAULT NULL COMMENT '法人联系方式',
  `company_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `link_user` varchar(12) DEFAULT NULL COMMENT '联系人',
  `link_phone` varchar(50) DEFAULT NULL COMMENT '联系方式',
  `qrcode` varchar(100) DEFAULT NULL COMMENT '二维码',
  `scan_num` smallint(6) DEFAULT '0' COMMENT '扫描二维码次数',
  `business_cope` varchar(300) DEFAULT NULL COMMENT '经营范围',
  `longitude` varchar(16) DEFAULT NULL COMMENT '坐标X,经度',
  `latitude` varchar(16) DEFAULT NULL COMMENT '坐标y，纬度',
  `file_path` varchar(200) DEFAULT NULL COMMENT '附件地址',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `checked` smallint(6) DEFAULT NULL COMMENT '审核状态（0 未审核，1 已审核）',
  `delete_flag` smallint(6) DEFAULT '0' COMMENT '删除状态',
  `sorting` smallint(6) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `param1` varchar(20) DEFAULT NULL COMMENT '预留参数1',
  `param2` varchar(250) DEFAULT NULL COMMENT '预留参数2',
  `param3` varchar(100) DEFAULT NULL COMMENT '预留参数3',
  PRIMARY KEY (`id`),
  KEY `inx_cold_unit_id` (`cold_unit_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='经营者管理';

INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b36bbb30095', '1477', '1477-1', '监管对象新增', 'icon iconfont icon-zengjia', 0, 1, '2c922b9a6208996e0162093432720002', '2020-10-12 13:09:33', '2c922b9a6208996e0162093432720002', '2020-10-12 13:09:33', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b36f57a0096', '1477', '1477-2', '编辑监管对象', 'icon iconfont icon-xiugai', 0, 2, '2c922b9a6208996e0162093432720002', '2020-10-12 13:09:48', '2c922b9a6208996e0162093432720002', '2020-10-12 13:09:48', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b3724b70097', '1477', '1477-3', '监管对象删除', 'icon iconfont icon-shanchu text-del', 0, 3, '2c922b9a6208996e0162093432720002', '2020-10-12 13:10:00', '2c922b9a6208996e0162093432720002', '2020-10-12 13:10:00', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b37673d0098', '1477', '1477-4', '监管对象审核', NULL, 0, 4, '2c922b9a6208996e0162093432720002', '2020-10-12 13:10:17', '2c922b9a6208996e0162093432720002', '2020-10-12 13:10:17', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b37dd7c0099', '1477', '1477-5', '查看二维码', 'icon iconfont icon-erweima', 0, 5, '2c922b9a6208996e0162093432720002', '2020-10-12 13:10:47', '2c922b9a6208996e0162093432720002', '2020-10-12 13:10:47', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b3852e3009b', '1477', '1477-7', '销售台账', 'icon iconfont icon-xiaoshou2', 1, 7, '2c922b9a6208996e0162093432720002', '2020-10-12 13:11:17', '2c922b9a6208996e0162093432720002', '2020-10-12 13:16:27', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b3887f2009c', '1477', '1477-8', '监管对象导入', 'icon iconfont icon-daoru', 0, 8, '2c922b9a6208996e0162093432720002', '2020-10-12 13:11:31', '2c922b9a6208996e0162093432720002', '2020-10-12 13:11:31', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b38be99009d', '1477', '1477-9', '经营户导入', 'icon iconfont icon-daoru', 0, 9, '2c922b9a6208996e0162093432720002', '2020-10-12 13:11:45', '2c922b9a6208996e0162093432720002', '2020-10-12 13:12:18', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b390187009e', '1477', '1477-10', '监管对象导出', 'icon iconfont icon-daochu', 0, 10, '2c922b9a6208996e0162093432720002', '2020-10-12 13:12:02', '2c922b9a6208996e0162093432720002', '2020-10-12 13:12:02', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b397e49009f', '1477', '1477-11', '经营户导出', 'icon iconfont icon-daochu', 0, 11, '2c922b9a6208996e0162093432720002', '2020-10-12 13:12:34', '2c922b9a6208996e0162093432720002', '2020-10-12 13:12:34', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b39bd5400a0', '1477', '1477-12', '经营户新增', 'icon iconfont icon-zengjia', 0, 12, '2c922b9a6208996e0162093432720002', '2020-10-12 13:12:50', '2c922b9a6208996e0162093432720002', '2020-10-12 13:12:50', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b39f70300a1', '1477', '1477-13', '经营户编辑', 'icon iconfont icon-xiugai', 0, 13, '2c922b9a6208996e0162093432720002', '2020-10-12 13:13:05', '2c922b9a6208996e0162093432720002', '2020-10-12 13:13:05', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b3a2b3b00a2', '1477', '1477-14', '经营户删除', 'icon iconfont icon-shanchu text-del', 0, 14, '2c922b9a6208996e0162093432720002', '2020-10-12 13:13:18', '2c922b9a6208996e0162093432720002', '2020-10-12 13:13:18', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b3a5a1100a3', '1477', '1477-15', '经营户审核', NULL, 0, 15, '2c922b9a6208996e0162093432720002', '2020-10-12 13:13:30', '2c922b9a6208996e0162093432720002', '2020-10-12 13:13:30', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b3a9a8000a4', '1477', '1477-16', '经营户其他信息', NULL, 0, 16, '2c922b9a6208996e0162093432720002', '2020-10-12 13:13:47', '2c922b9a6208996e0162093432720002', '2020-10-12 13:13:47', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c747aed4d01751b3af81700a5', '1477', '1477-17', '导出二维码', 'icon iconfont icon-daochu', 0, 17, '2c922b9a6208996e0162093432720002', '2020-10-12 13:14:11', '2c922b9a6208996e0162093432720002', '2020-10-12 13:14:11', NULL);
INSERT INTO `t_s_operation` (`id`, `function_id`, `operation_code`, `operation_name`, `function_icon`, `delete_flag`, `sorting`, `create_by`, `create_date`, `update_by`, `update_date`, `remark`) VALUES ('2c922b9c78d95c2a01791bab20880012', '1477', '1477-18', '上传照片', 'icon iconfont icon-ai-img', 0, 18, '2c922b9c729cb29701729cb683870001', '2021-04-29 11:27:50', '2c922b9c729cb29701729cb683870001', '2021-04-29 11:29:20', NULL);
