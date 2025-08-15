#Dz 2022/10/09 每月数据汇总
CREATE PROCEDURE `monthly_statistics2`(IN `_start_ymd` DATE, IN `_end_ymd` DATE)
BEGIN

    #初始化数据
    DECLARE _min_date DATE DEFAULT '2019-01-01'; #最小日期，在此之前的数据汇总到这个月

    #结果
    DECLARE _sampling_num INT(11) DEFAULT 0; #抽样单数量
    DECLARE _purchase_num DOUBLE(10,2) DEFAULT 0.0;	#抽样基数
    DECLARE _check_num INT(11) DEFAULT 0;	#检测数量
    DECLARE _unqualified_num INT(11) DEFAULT 0;	#不合格数量
    DECLARE _dispose_number INT(11) DEFAULT 0;	#已处理数量
    DECLARE _destroy_number DOUBLE(10,2) DEFAULT 0.0;	#销毁食品数量

    DECLARE _his_ms_id INT(11) DEFAULT 0; #历史数据_每月统计ID
    DECLARE _his_sampling_num INT(11) DEFAULT 0; #历史数据_抽样单数量
    DECLARE _his_purchase_num DOUBLE(10,2) DEFAULT 0.0;	#历史数据_抽样基数
    DECLARE _his_check_num INT(11) DEFAULT 0;	#历史数据_抽样基数
    DECLARE _his_unqualified_num INT(11) DEFAULT 0;	#历史数据_不合格数量
    DECLARE _his_dispose_number INT(11) DEFAULT 0;	#历史数据_已处理数量
    DECLARE _his_destroy_number DOUBLE(10,2) DEFAULT 0.0;	#历史数据_销毁食品数量

    #查询条件
    DECLARE _query_date1 VARCHAR(25); #统计月-开始时间
    DECLARE _query_date2 VARCHAR(25); #统计月-结束时间

    #机构
    DECLARE _depart_id INT(11);
    DECLARE _no_more_record INT DEFAULT 0;
    DECLARE _depart_ids CURSOR FOR SELECT id FROM t_s_depart WHERE delete_flag = 0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _no_more_record = 1; #这是条件处理,针对NOT FOUND的条件,当没有记录时赋值为1

    SET _start_ymd = (SELECT STR_TO_DATE(DATE_FORMAT(_start_ymd,'%Y-%m-01'),'%Y-%m-%d'));	#当月第一天
    SET _end_ymd = (SELECT LAST_DAY(_end_ymd));	#当月最后一天


    #开始日期小于最小日期
    IF _start_ymd < _min_date THEN

        #打开游标
        OPEN _depart_ids;
        #把第一行数据写入变量中,游标也随之指向了记录的第一行
        FETCH _depart_ids INTO _depart_id;

        #机构循环
        depart_loop:LOOP
            IF _no_more_record = 1 THEN
                SET _no_more_record = 0;
                LEAVE depart_loop;
            END IF;

            #重置
            SET _his_ms_id = 0; #历史数据_每月统计ID
            SET _his_sampling_num = 0; #历史数据_抽样单数量
            SET _his_purchase_num = 0.0;	#历史数据_抽样基数
            SET _his_check_num = 0;	#历史数据_检测数量
            SET _his_unqualified_num = 0;	#历史数据_不合格数量
            SET _his_dispose_number = 0; #历史数据_已处理数量
            SET _his_destroy_number = 0.0; #历史数据_销毁食品数量

            SET _query_date2 = (SELECT CONCAT(LAST_DAY(_min_date), ' 23:59:59')); #统计结束时间

-- 			#抽样数量
-- 			SET _sampling_num =
-- 				(SELECT COUNT(1) FROM tb_sampling
-- 					WHERE delete_flag = 0
-- 						AND sampling_date <= _query_date2
-- 						AND depart_id IN (SELECT id FROM t_s_depart
-- 							WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'))
-- 				);

            #抽样数量、抽样基数
            SELECT COUNT(DISTINCT ts.id), SUM(IF(tsd.purchase_amount IS NULL, 0.0, tsd.purchase_amount))
            INTO _sampling_num, _purchase_num
            FROM tb_sampling ts
                     LEFT JOIN tb_sampling_detail tsd ON ts.id = tsd.sampling_id
            WHERE ts.delete_flag = 0
              AND ts.sampling_date <= _query_date2
              AND ts.depart_id IN (SELECT id FROM t_s_depart
                                   WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'));

            IF _purchase_num IS NULL THEN
                SET _purchase_num = 0.0;
            END IF;

            #检测数量、不合格数量
            SELECT COUNT(1), SUM(IF(conclusion = '不合格', 1, 0)) INTO _check_num, _unqualified_num
            FROM data_check_recording
            WHERE delete_flag = 0 AND param7 = 1
              AND check_date <= _query_date2
              AND depart_id IN (SELECT id FROM t_s_depart
                                WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'));

            IF _unqualified_num IS NULL THEN
                SET _unqualified_num = 0;
            END IF;

            #已处理数量、销毁食品数量
            SELECT COUNT(DISTINCT dut.id), SUM(dud.dispose_value1)
            INTO _dispose_number, _destroy_number
            FROM data_check_recording dcr
                     INNER JOIN data_unqualified_treatment dut ON dcr.rid = dut.check_recording_id
                     INNER JOIN data_unqualified_dispose dud ON dut.id = dud.unid
            WHERE dcr.delete_flag = 0 AND dcr.param7 = 1
              AND dcr.check_date <= _query_date2
              AND dcr.conclusion = '不合格'
              AND dcr.depart_id IN (SELECT id FROM t_s_depart
                                    WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'))
              AND dut.deal_method = 1;

            IF _destroy_number IS NULL THEN
                SET _destroy_number = 0.0;
            END IF;

            #历史数据
            SELECT id, sampling_number, purchase_number, check_number, unqualified_number
            INTO _his_ms_id, _his_sampling_num, _his_purchase_num, _his_check_num, _his_unqualified_num
            FROM data_monthly_statistics WHERE yyyy_mm = DATE_FORMAT(_min_date,'%Y-%m') AND depart_id = _depart_id;
            #避免没有查询出数据，就结束循环
            SET _no_more_record = 0;

            IF _his_ms_id = 0 THEN
                #插入数据
                INSERT INTO data_monthly_statistics(`yyyy_mm`, `depart_id`,`sampling_number`,`purchase_number`,
                                                    `check_number`, `unqualified_number`, `dispose_number`, `destroy_number`,
                                                    `delete_flag`, `create_date`, `update_date`)
                VALUES (DATE_FORMAT(_min_date,'%Y-%m'), _depart_id, _sampling_num, _purchase_num, _check_num,
                        _unqualified_num, _dispose_number, _destroy_number, 0, NOW(), NOW());

            ELSEIF _sampling_num != _his_sampling_num OR _purchase_num != _his_purchase_num OR _check_num != _his_check_num
                OR _unqualified_num != _his_unqualified_num OR _dispose_number != _his_dispose_number
                OR _destroy_number != _his_destroy_number THEN
                #更新数据
                UPDATE data_monthly_statistics SET sampling_number = _sampling_num, purchase_number = _purchase_num, check_number = _check_num,
                                                   unqualified_number = _unqualified_num, dispose_number = _dispose_number, destroy_number = _destroy_number,
                                                   delete_flag = 0, update_date = NOW() WHERE id = _his_ms_id;

            END IF;

            FETCH _depart_ids INTO _depart_id;

            #结束机构循环
        END LOOP depart_loop;
        #关闭游标，释放资源
        CLOSE _depart_ids;

        #最小日期当月数据已统计，开始日期改为下个月
        SET _start_ymd = (SELECT DATE_ADD(_min_date, INTERVAL 1 MONTH));

    END IF;



    #年月循环
    month_loop:LOOP
        IF _start_ymd > _end_ymd THEN	#开始日期大于结束日期
            LEAVE	month_loop;
        END IF;


        SET _query_date1 = (SELECT DATE_FORMAT(_start_ymd, '%Y-%m-01 00:00:00'));
        SET _query_date2 = (SELECT CONCAT(LAST_DAY(_start_ymd), ' 23:59:59'));

        #打开游标
        OPEN _depart_ids;
        #把第一行数据写入变量中,游标也随之指向了记录的第一行
        FETCH _depart_ids INTO _depart_id;

        #机构循环
        depart_loop:LOOP
            IF _no_more_record = 1 THEN
                SET _no_more_record = 0;
                LEAVE depart_loop;
            END IF;

            #重置
            SET _his_ms_id = 0; #历史数据_每月统计ID
            SET _his_sampling_num = 0; #历史数据_抽样单数量
            SET _his_purchase_num = 0.0;	#历史数据_抽样基数
            SET _his_check_num = 0;	#历史数据_检测数量
            SET _his_unqualified_num = 0;	#历史数据_不合格数量
            SET _his_dispose_number = 0; #历史数据_已处理数量
            SET _his_destroy_number = 0.0; #历史数据_销毁食品数量

-- 			#抽样数量
-- 			SET _sampling_num =
-- 				(SELECT COUNT(1) FROM tb_sampling
-- 					WHERE delete_flag = 0
-- 						AND sampling_date BETWEEN _query_date1 AND _query_date2
-- 						AND depart_id IN (SELECT id FROM t_s_depart
-- 							WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'))
-- 				);

            #抽样数量、抽样基数
            SELECT COUNT(DISTINCT ts.id), SUM(IF(tsd.purchase_amount IS NULL, 0.0, tsd.purchase_amount))
            INTO _sampling_num, _purchase_num
            FROM tb_sampling ts
                     LEFT JOIN tb_sampling_detail tsd ON ts.id = tsd.sampling_id
            WHERE ts.delete_flag = 0
              AND ts.sampling_date BETWEEN _query_date1 AND _query_date2
              AND ts.depart_id IN (SELECT id FROM t_s_depart
                                   WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'));

            IF _purchase_num IS NULL THEN
                SET _purchase_num = 0.0;
            END IF;

            #检测数量、不合格数量
            SELECT COUNT(1), SUM(IF(conclusion = '不合格', 1, 0)) INTO _check_num, _unqualified_num
            FROM data_check_recording
            WHERE delete_flag = 0 AND param7 = 1
              AND check_date BETWEEN _query_date1 AND _query_date2
              AND depart_id IN (SELECT id FROM t_s_depart
                                WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'));

            IF _unqualified_num IS NULL THEN
                SET _unqualified_num = 0;
            END IF;

            #已处理数量、销毁食品数量
            SELECT COUNT(DISTINCT dut.id), SUM(dud.dispose_value1)
            INTO _dispose_number, _destroy_number
            FROM data_check_recording dcr
                     INNER JOIN data_unqualified_treatment dut ON dcr.rid = dut.check_recording_id
                     INNER JOIN data_unqualified_dispose dud ON dut.id = dud.unid
            WHERE dcr.delete_flag = 0 AND dcr.param7 = 1
              AND dcr.check_date BETWEEN _query_date1 AND _query_date2
              AND dcr.conclusion = '不合格'
              AND dcr.depart_id IN (SELECT id FROM t_s_depart
                                    WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'))
              AND dut.deal_method = 1;

            IF _destroy_number IS NULL THEN
                SET _destroy_number = 0.0;
            END IF;

            #历史数据
            SELECT id, sampling_number, purchase_number, check_number, unqualified_number, dispose_number, destroy_number
            INTO _his_ms_id, _his_sampling_num, _his_purchase_num, _his_check_num, _his_unqualified_num, _his_dispose_number, _his_destroy_number
            FROM data_monthly_statistics WHERE yyyy_mm = DATE_FORMAT(_start_ymd,'%Y-%m') AND depart_id = _depart_id;
            #避免没有查询出数据，就结束循环
            SET _no_more_record = 0;

            IF _his_ms_id = 0 THEN
                #插入数据
                INSERT INTO data_monthly_statistics(`yyyy_mm`, `depart_id`,`sampling_number`, `purchase_number`, `check_number`, `unqualified_number`,
                                                    `dispose_number`, `destroy_number`, `delete_flag`, `create_date`, `update_date`)
                VALUES (DATE_FORMAT(_start_ymd,'%Y-%m'), _depart_id, _sampling_num, _purchase_num, _check_num,
                        _unqualified_num, _dispose_number, _destroy_number, 0, NOW(), NOW());

            ELSEIF _sampling_num != _his_sampling_num OR _purchase_num != _his_purchase_num OR _check_num != _his_check_num
                OR _unqualified_num != _his_unqualified_num OR _dispose_number != _his_dispose_number
                OR _destroy_number != _his_destroy_number THEN
                #更新数据
                UPDATE data_monthly_statistics SET sampling_number = _sampling_num, purchase_number = _purchase_num, check_number = _check_num,
                                                   unqualified_number = _unqualified_num, dispose_number = _dispose_number, destroy_number = _destroy_number,
                                                   delete_flag = 0, update_date = NOW() WHERE id = _his_ms_id;

            END IF;

            FETCH _depart_ids INTO _depart_id;

            #结束机构循环
        END LOOP depart_loop;
        #关闭游标，释放资源
        CLOSE _depart_ids;

        #开始日期改为下个月
        SET _start_ymd = (SELECT DATE_ADD(_start_ymd, INTERVAL 1 MONTH));

        #结束年月循环
    END LOOP month_loop;


END
;

#xiaoyl 2022/09/28
# 不合格食品种类统计，首先给指定样品编码下的样品设置固定的ID和食品类别，默认是空，月度统计之前进行更新
CREATE PROCEDURE `unqualified_foodType_statistics`(IN `_depart_id` int,IN `startDate` VARCHAR(30),IN `endDate` VARCHAR(30))
BEGIN
 --     update base_food_type set other_parent_id=10011, other_type='肉类' where food_code like '000100010002%';
--     update base_food_type set other_parent_id=10012, other_type='水产' where food_code like '000100010003%';
--     update base_food_type set other_parent_id=10013, other_type='蔬菜' where food_code like '0001000100010001%';
--     update base_food_type set other_parent_id=10014, other_type='水果' where food_code like '0001000100010005%';

	DECLARE vegat_food_code VARCHAR(32) DEFAULT null;	-- 蔬菜的code
	DECLARE fruits_food_code VARCHAR(32) DEFAULT null;	-- 水果的code
	DECLARE meat_food_code VARCHAR(32) DEFAULT null;	-- 肉类的code
	DECLARE shuichang_food_code VARCHAR(32) DEFAULT null;	-- 水产的code
	select food_code into vegat_food_code from base_food_type where delete_flag=0 and food_name='蔬菜';
	select food_code into fruits_food_code from base_food_type where delete_flag=0 and food_name='水果';
    select food_code into meat_food_code from base_food_type where delete_flag=0 and food_name='畜牧业农产品';
    select food_code into shuichang_food_code from base_food_type where delete_flag=0 and food_name='渔业农产品';
	 SELECT _depart_id depart_id, food_parent_type,count(*) unqualified_num FROM data_check_recording dcr
		 left join (SELECT id, food_name,
			CASE
			 WHEN food_code LIKE CONCAT(vegat_food_code,'%') THEN '蔬菜'
			 WHEN food_code LIKE CONCAT(fruits_food_code,'%') THEN '水果'
			 WHEN food_code LIKE CONCAT(meat_food_code,'%') THEN '肉类'
			 WHEN food_code LIKE CONCAT(shuichang_food_code,'%') THEN '水产'
			 ELSE '其他'
			END 'food_parent_type'
			FROM base_food_type
			WHERE delete_flag=0) food on dcr.food_id=food.id
			WHERE dcr.delete_flag = 0 and dcr.param7=1
			AND dcr.check_date >= CONCAT(startDate, ' 00:00:00') AND dcr.check_date < CONCAT(endDate, ' 00:00:00')
			AND dcr.conclusion='不合格'
			AND dcr.depart_id IN (SELECT id FROM t_s_depart
			WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'))
			GROUP BY food.food_parent_type desc;
END
;

#xiaoyl 2022/09/21 东营可视化大屏不合格数据统计中间表
CREATE PROCEDURE `depart_monthly_statistics`(IN `_depart_id` int,IN `startMonth` VARCHAR(30),IN `endMonth` VARCHAR(30) )
BEGIN
	#查询json
	DECLARE his_ms_id INT(11) DEFAULT 0; #历史数据_每月统计ID
	DECLARE food_type_statistics_json MEDIUMTEXT DEFAULT NULL; #食品类型不合格统计
	DECLARE food_statistics_json MEDIUMTEXT DEFAULT NULL;	#食品名称不合格数量top  10
	DECLARE item_statistics_json MEDIUMTEXT DEFAULT NULL;	#检测项目不合格数量top 10统计
	DECLARE reg_statistics_json MEDIUMTEXT DEFAULT NULL;	#市场不合格数量top  10
	DECLARE point_statistics_json MEDIUMTEXT DEFAULT NULL;	#检测室不合格数量top 10统计

	# 不合格食品种类统计，首先给指定样品编码下的样品设置固定的ID和食品类别，默认是空，月度统计之前进行更新
	-- 			update base_food_type set other_parent_id=10011, other_type='肉类' where food_code like '000100010002%';
-- 			update base_food_type set other_parent_id=10012, other_type='水产' where food_code like '000100010003%';
-- 			update base_food_type set other_parent_id=10013, other_type='蔬菜' where food_code like '0001000100010001%';
-- 			update base_food_type set other_parent_id=10014, other_type='水果' where food_code like '0001000100010005%';
		DECLARE vegat_food_code VARCHAR(32) DEFAULT null;	-- 蔬菜的code
		DECLARE fruits_food_code VARCHAR(32) DEFAULT null;	-- 水果的code
		DECLARE meat_food_code VARCHAR(32) DEFAULT null;	-- 肉类的code
		DECLARE shuichang_food_code VARCHAR(32) DEFAULT null;	-- 水产的code
		select food_code into vegat_food_code from base_food_type where delete_flag=0 and food_name='蔬菜';
		select food_code into fruits_food_code from base_food_type where delete_flag=0 and food_name='水果';
        select food_code into meat_food_code from base_food_type where delete_flag=0 and food_name='畜牧业农产品';
		select food_code into shuichang_food_code from base_food_type where delete_flag=0 and food_name='渔业农产品';

			SELECT  JSON_ARRAYAGG(JSON_OBJECT('depart_id',depart_id,'food_parent_type',food_parent_type,'unqualified_num',unqualified_num
	,'dispose_number',dispose_number,'sampling_num',sampling_num
	) ) INTO food_type_statistics_json
				FROM (
				 SELECT _depart_id depart_id,food_parent_type,count(DISTINCT dcr.rid) unqualified_num
					,SUM(dud.dispose_value1) dispose_number -- 销毁食品数量
					,SUM(IF(tsd.purchase_amount IS NULL, 0.0, tsd.purchase_amount)) sampling_num  -- 抽样基数
				FROM data_check_recording dcr
					 left join (SELECT id, food_name,
							CASE
							 WHEN food_code LIKE CONCAT(vegat_food_code,'%') THEN '蔬菜'
							 WHEN food_code LIKE CONCAT(fruits_food_code,'%') THEN '水果'
							 WHEN food_code LIKE CONCAT(meat_food_code,'%') THEN '肉类'
							 WHEN food_code LIKE CONCAT(shuichang_food_code,'%') THEN '水产'
							 ELSE '其他'
							END 'food_parent_type'
							FROM base_food_type
							WHERE delete_flag=0) food on dcr.food_id=food.id
							LEFT JOIN data_unqualified_treatment dut ON dcr.rid = dut.check_recording_id
						  LEFT JOIN data_unqualified_dispose dud ON dut.id = dud.unid AND dut.deal_method = 1
						  LEFT JOIN tb_sampling_detail tsd ON tsd.id=dcr.sampling_detail_id
-- 			      LEFT JOIN	tb_sampling ts on ts.id=tsd.sampling_id
						WHERE dcr.delete_flag = 0 and dcr.param7=1  -- and  ts.delete_flag=0
						AND dcr.check_date >= CONCAT(startMonth, ' 00:00:00') AND dcr.check_date < CONCAT(endMonth, ' 00:00:00')
						and dcr.conclusion='不合格'
						AND dcr.depart_id IN (SELECT id FROM t_s_depart
						WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'))
						GROUP BY food.food_parent_type desc
				)temp;

		#食品名称不合格数量
			SELECT  JSON_ARRAYAGG(JSON_OBJECT(
			'depart_id',depart_id,'total_num',total_num,'qualified_num',qualified_num, 'unqualified_num', unqualified_num
			, 'food_id', food_id, 'food_name', food_name)) INTO food_statistics_json
			FROM (
			 SELECT _depart_id depart_id,COUNT(1) total_num,SUM(IF(conclusion = '合格', 1, 0)) qualified_num,
							SUM(IF(conclusion = '不合格', 1, 0)) unqualified_num,food_id,food_name
							FROM data_check_recording
							WHERE delete_flag = 0 and param7=1
							AND check_date >= CONCAT(startMonth, ' 00:00:00') AND check_date < CONCAT(endMonth, ' 00:00:00')
							AND depart_id IN (SELECT id FROM t_s_depart
							WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'))
							GROUP BY food_id HAVING unqualified_num>0 order by unqualified_num desc
-- 										limit 0,10
			) temp;
		#检测项目不合格数量
			SELECT  JSON_ARRAYAGG(JSON_OBJECT(
			'depart_id',depart_id,'total_num',total_num,'qualified_num',qualified_num, 'unqualified_num', unqualified_num
			, 'item_id', item_id, 'item_name', item_name))  INTO item_statistics_json
			FROM (
			 SELECT _depart_id depart_id,COUNT(1) total_num,SUM(IF(conclusion = '合格', 1, 0)) qualified_num,
							SUM(IF(conclusion = '不合格', 1, 0)) unqualified_num,item_id,item_name
							FROM data_check_recording
							WHERE delete_flag = 0 and param7=1
							AND check_date >= CONCAT(startMonth, ' 00:00:00') AND check_date < CONCAT(endMonth, ' 00:00:00')
							AND depart_id IN (SELECT id FROM t_s_depart
							WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'))
							GROUP BY item_id HAVING unqualified_num>0 order by unqualified_num desc
-- 										limit 0,10
			) temp;
		#市场不合格数量
			SELECT  JSON_ARRAYAGG(JSON_OBJECT(
			'depart_id',depart_id,'total_num',total_num,'qualified_num',qualified_num, 'unqualified_num', unqualified_num
			, 'reg_id', reg_id, 'reg_name', reg_name))  INTO reg_statistics_json
			FROM (
			 SELECT _depart_id depart_id,COUNT(1) total_num,SUM(IF(conclusion = '合格', 1, 0)) qualified_num,
							SUM(IF(conclusion = '不合格', 1, 0)) unqualified_num,dcr.reg_id,dcr.reg_name
							FROM data_check_recording dcr
							left join base_regulatory_object obj on obj.id=dcr.reg_id
							WHERE dcr.delete_flag = 0 and dcr.param7=1
							AND dcr.check_date >= CONCAT(startMonth, ' 00:00:00') AND dcr.check_date < CONCAT(endMonth, ' 00:00:00')
							AND dcr.depart_id IN (SELECT id FROM t_s_depart
							WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%')) and obj.delete_flag=0
							GROUP BY dcr.reg_id HAVING unqualified_num>0 order by unqualified_num desc
-- 										limit 0,10
			) temp;
		#检测室不合格数量
			SELECT  JSON_ARRAYAGG(JSON_OBJECT(
			'depart_id',depart_id,'total_num',total_num,'qualified_num',qualified_num, 'unqualified_num', unqualified_num
			, 'point_id', point_id, 'point_name', point_name))  INTO point_statistics_json
			FROM (
			 SELECT _depart_id depart_id,COUNT(1) total_num,SUM(IF(conclusion = '合格', 1, 0)) qualified_num,
							SUM(IF(conclusion = '不合格', 1, 0)) unqualified_num,point_id,dcr.point_name
							FROM data_check_recording dcr
							left join base_point p on dcr.point_id=p.id
							WHERE dcr.delete_flag = 0 and dcr.param7=1
							AND dcr.check_date >= CONCAT(startMonth, ' 00:00:00') AND check_date < CONCAT(endMonth, ' 00:00:00')
							AND dcr.depart_id IN (SELECT id FROM t_s_depart
							WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%')) and p.delete_flag=0
							GROUP BY point_id HAVING unqualified_num>0 order by unqualified_num desc
-- 										limit 0,10
			) temp;




		#查询当前机构指定月的数据记录ID
		SELECT id INTO his_ms_id FROM depart_month_statistics WHERE yyyy = DATE_FORMAT(startMonth,'%Y')
		AND mm=DATE_FORMAT(startMonth,'%m') AND depart_id = _depart_id;

		IF his_ms_id = 0 THEN
			#插入数据
			INSERT INTO depart_month_statistics(`yyyy`,`mm`, `depart_id`,`food_type_statistics`,
				`food_statistics`, `item_statistics`, `reg_statistics`, `point_statistics`, `delete_flag`, `create_date`, `update_date`)
			VALUES (DATE_FORMAT(startMonth,'%Y'),DATE_FORMAT(startMonth,'%m'), _depart_id, food_type_statistics_json, food_statistics_json,
				item_statistics_json,reg_statistics_json,point_statistics_json,0, NOW(), NOW());
		ELSE
			#更新数据
			UPDATE depart_month_statistics SET food_type_statistics = food_type_statistics_json, food_statistics = food_statistics_json,
				item_statistics = item_statistics_json,reg_statistics=reg_statistics_json,point_statistics=point_statistics_json,
				delete_flag = 0, update_date = NOW() WHERE id = his_ms_id;

		END IF;
END
;

#xiaoyl 2022/05/31 甘肃项目：质量统计存储过程，首先根据检测点进行分组，然后根据父级机构ID进行分组；优化查询效率
CREATE PROCEDURE `QualityStatistics`( IN departCode VARCHAR ( 32 ), IN startTime VARCHAR ( 30 ), IN endTime VARCHAR ( 30 ) )
BEGIN
-- 首先根据检测点进行分组，然后根据父级机构ID进行分组；优化查询效率
select temp.depart_id,temp.depart_name,temp.season,-- 单位ID,单位名称
	count( IF ( temp.point_type = 0 AND temp.point_type_id = 1, 1, NULL ) ) AS zf_point_num,-- 政府检测室总数
	count( IF ( temp.point_type = 0 AND temp.point_type_id != 1, 1, NULL ) ) AS qy_point_num,-- 企业检测室总数
	count( IF ( temp.point_type = 1 AND temp.point_type_id = 1, 1, NULL ) ) AS car_point_num,-- 快检车总数
sum(temp.unq_quality) unq_quality,sum(temp.total_effective_num) total_effective_num,sum(temp.total_invalid_num) total_invalid_num,-- 不合格数量，用来计算检出率,总有效数量,总无效数量
sum(temp.zf_total_num) zf_total_num,sum(temp.qy_total_num) qy_total_num,sum(temp.car_total_num) car_total_num,-- 政府检测总量,企业检总测量,快检车检测总量
sum(temp.zf_effective_num) zf_effective_num,sum(temp.qy_effective_num) qy_effective_num,sum(temp.car_effective_num) car_effective_num,-- 政府检测室有效数量,企业检测室有效数量,快检车有效数量
sum(temp.zf_invalid_num) zf_invalid_num,sum(temp.qy_invalid_num) qy_invalid_num,sum(temp.car_invalid_num) car_invalid_num,-- 政府检测室无效数量,企业检测室无效数量,快检车无效数量
sum(temp.data_quality) data_quality,sum(temp.deal_number) deal_number,sum(temp.stay_number) stay_number,sum(temp.deal_no_standard) deal_no_standard -- 数据质量:出现次数,合规处理,未处置,处置不当
from (
SELECT
	(SELECT id  FROM t_s_depart  WHERE depart_code = SUBSTRING( dp.depart_code, 1, LENGTH( departCode ) + 2 )  LIMIT 0, 1  ) AS depart_id,-- 单位ID
	( SELECT depart_name  FROM t_s_depart  WHERE depart_code = SUBSTRING( dp.depart_code, 1, LENGTH( departCode ) + 2 )  LIMIT 0, 1  ) AS depart_name,-- 单位名称
	SUBSTRING( dp.depart_code, 1, LENGTH( departCode ) + 2 ) depart_code,
    quarter( r.check_date ) season,
	CASE quarter( r.check_date )
            when 1 then '一'
            when 2 then '二'
            when 3 then '三'
            when 4 then '四'
            else '' END as  season_str,
	r.point_id,bp.point_type,bp.point_type_id,
	COUNT( 1 ) total_num,-- 检测总数
	SUM( CASE WHEN  r.param6 = 0 AND r.conclusion='不合格' THEN 1 ELSE 0 END ) unq_quality, -- 不合格数量，用来计算检出率
	SUM( CASE WHEN r.param6 = 0 THEN 1 ELSE 0 END ) total_effective_num,-- 总有效数量
	SUM( CASE WHEN r.param6 != 0 THEN 1 ELSE 0 END ) total_invalid_num,-- 总无效数量
	SUM( CASE WHEN bp.point_type = 0 AND bp.point_type_id = 1 THEN 1 ELSE 0 END ) zf_total_num,-- 政府检测总量
	SUM( CASE WHEN bp.point_type = 0 AND bp.point_type_id != 1 THEN 1 ELSE 0 END ) qy_total_num,-- 企业检总测量
	SUM( CASE WHEN bp.point_type = 1 AND bp.point_type_id = 1 THEN 1 ELSE 0 END ) car_total_num,-- 快检车检测总量
	SUM( CASE WHEN r.param6 = 0 AND bp.point_type = 0 AND bp.point_type_id = 1   THEN 1 ELSE 0 END ) zf_effective_num,-- 政府检测室有效数量
	SUM( CASE WHEN r.param6 = 0 AND bp.point_type = 0 AND bp.point_type_id != 1 THEN 1 ELSE 0 END ) qy_effective_num,-- 企业检测室有效数量
	SUM( CASE WHEN r.param6 = 0 AND bp.point_type = 1 AND bp.point_type_id = 1  THEN 1 ELSE 0 END ) car_effective_num,-- 快检车有效数量
	SUM( CASE WHEN  r.param6 != 0 AND bp.point_type = 0 AND bp.point_type_id = 1  THEN 1 ELSE 0 END ) zf_invalid_num,-- 政府检测室无效数量
	SUM( CASE WHEN  r.param6 != 0 AND bp.point_type = 0 AND bp.point_type_id != 1  THEN 1 ELSE 0 END ) qy_invalid_num,-- 企业检测室无效数量
	SUM( CASE WHEN  r.param6 != 0 AND bp.point_type = 1 AND bp.point_type_id = 1  THEN 1 ELSE 0 END ) car_invalid_num, -- 快检车无效数量
	SUM( CASE WHEN  r.param6 =9 AND bp.point_type = 1 AND bp.point_type_id = 1  THEN 1 ELSE 0 END ) data_quality, -- 数据质量:出现次数
	  SUM( CASE WHEN r.param6 = 0 AND r.conclusion='不合格' AND r.handled_assessment=0 THEN 1 ELSE 0 END ) deal_number,-- 合规处理
    SUM( CASE WHEN r.param6 = 0 AND r.conclusion='不合格' AND r.handled_assessment is null THEN 1 ELSE 0 END ) stay_number,-- 未处置
    SUM( CASE WHEN r.param6 = 0 AND r.conclusion='不合格' AND  r.handled_assessment>=1 THEN 1 ELSE 0 END ) deal_no_standard -- 处置不当
FROM
	data_check_recording r
	INNER JOIN base_point bp ON bp.id = r.point_id
	INNER JOIN t_s_depart dp ON r.depart_id = dp.id

WHERE r.delete_flag = 0 AND r.param1=1 AND r.check_date BETWEEN startTime  AND endTime
	AND dp.depart_code LIKE CONCAT( departCode, '%' )
GROUP BY r.point_id)temp
GROUP BY temp.depart_id
ORDER BY temp.depart_code;

END;

#xiaoyl 2022/05/25 甘肃项目：数据有效性统计存储过程,首先根据检测点进行分组，然后根据父级机构ID进行分组；优化查询效率
CREATE PROCEDURE `QueryEffectiveData`( IN departCode VARCHAR ( 32 ), IN startTime VARCHAR ( 30 ), IN endTime VARCHAR ( 30 ) )
BEGIN
-- 首先根据检测点进行分组，然后根据父级机构ID进行分组；优化查询效率
select temp.depart_id,temp.depart_name,-- 单位ID,单位名称
count( IF ( temp.point_type = 0 AND temp.point_type_id = 1, 1, NULL ) ) AS zf_point_num,-- 政府检测室总数
count( IF ( temp.point_type = 0 AND temp.point_type_id != 1, 1, NULL ) ) AS qy_point_num,-- 企业检测室总数
count( IF ( temp.point_type = 1 AND temp.point_type_id = 1, 1, NULL ) ) AS car_point_num,-- 快检车总数
sum(temp.total_effective_num) total_effective_num,sum(temp.total_invalid_num) total_invalid_num,-- 总有效数量,总无效数量
sum(temp.zf_total_num) zf_total_num,sum(temp.qy_total_num) qy_total_num,sum(temp.car_total_num) car_total_num,-- 政府检测总量,企业检总测量,快检车检测总量
sum(temp.zf_effective_num) zf_effective_num,sum(temp.qy_effective_num) qy_effective_num,sum(temp.car_effective_num) car_effective_num,-- 政府检测室有效数量,企业检测室有效数量,快检车有效数量
sum(temp.zf_invalid_num) zf_invalid_num,sum(temp.qy_invalid_num) qy_invalid_num,sum(temp.car_invalid_num) car_invalid_num -- 政府检测室无效数量,企业检测室无效数量,快检车无效数量
from (
SELECT
	(SELECT id  FROM t_s_depart  WHERE depart_code = SUBSTRING( dp.depart_code, 1, LENGTH( departCode ) + 2 )  LIMIT 0, 1  ) AS depart_id,-- 单位ID
	( SELECT depart_name  FROM t_s_depart  WHERE depart_code = SUBSTRING( dp.depart_code, 1, LENGTH( departCode ) + 2 )  LIMIT 0, 1  ) AS depart_name,-- 单位名称
	SUBSTRING( dp.depart_code, 1, LENGTH( departCode ) + 2 ) depart_code,
	r.point_id,bp.point_type,bp.point_type_id,
	COUNT( 1 ) total_num,-- 检测总数
	SUM( CASE WHEN r.param6 = 0 THEN 1 ELSE 0 END ) total_effective_num,-- 总有效数量
	SUM( CASE WHEN r.param6 != 0 THEN 1 ELSE 0 END ) total_invalid_num,-- 总无效数量
	SUM( CASE WHEN bp.point_type = 0 AND bp.point_type_id = 1 THEN 1 ELSE 0 END ) zf_total_num,-- 政府检测总量
	SUM( CASE WHEN bp.point_type = 0 AND bp.point_type_id != 1 THEN 1 ELSE 0 END ) qy_total_num,-- 企业检总测量
	SUM( CASE WHEN bp.point_type = 1 AND bp.point_type_id = 1 THEN 1 ELSE 0 END ) car_total_num,-- 快检车检测总量
	SUM( CASE WHEN r.param6 = 0 AND bp.point_type = 0 AND bp.point_type_id = 1   THEN 1 ELSE 0 END ) zf_effective_num,-- 政府检测室有效数量
	SUM( CASE WHEN r.param6 = 0 AND bp.point_type = 0 AND bp.point_type_id != 1 THEN 1 ELSE 0 END ) qy_effective_num,-- 企业检测室有效数量
	SUM( CASE WHEN r.param6 = 0 AND bp.point_type = 1 AND bp.point_type_id = 1  THEN 1 ELSE 0 END ) car_effective_num,-- 快检车有效数量
	SUM( CASE WHEN  r.param6 != 0 AND bp.point_type = 0 AND bp.point_type_id = 1  THEN 1 ELSE 0 END ) zf_invalid_num,-- 政府检测室无效数量
	SUM( CASE WHEN  r.param6 != 0 AND bp.point_type = 0 AND bp.point_type_id != 1  THEN 1 ELSE 0 END ) qy_invalid_num,-- 企业检测室无效数量
	SUM( CASE WHEN  r.param6 != 0 AND bp.point_type = 1 AND bp.point_type_id = 1  THEN 1 ELSE 0 END ) car_invalid_num -- 快检车无效数量

FROM
	data_check_recording r
	INNER JOIN base_point bp ON bp.id = r.point_id
	INNER JOIN t_s_depart dp ON r.depart_id = dp.id

WHERE r.delete_flag = 0 AND r.param1=1  AND r.check_date BETWEEN startTime  AND endTime
	AND dp.depart_code LIKE CONCAT( departCode, '%' )
GROUP BY r.point_id)temp
GROUP BY temp.depart_id
ORDER BY temp.depart_code;

END;

#Dz 20211202 更新仪器胶体金项目配置
CREATE PROCEDURE `updateDeviceConfig`()
BEGIN
    #仪器检测配置ID2
    DECLARE _device_parameter_id2 VARCHAR(50) DEFAULT NULL;
    #仪器检测配置_仪器类别ID
    DECLARE _device_type_id VARCHAR(50) DEFAULT NULL;
    #仪器检测配置_检测项目ID
    DECLARE _item_id VARCHAR(50) DEFAULT NULL;
    #仪器检测配置_检测模块
    DECLARE _project_type VARCHAR(50) DEFAULT NULL;
    #仪器检测配置_检测方法
    DECLARE _detect_method VARCHAR(50) DEFAULT NULL;

    #仪器检测配置ID
    DECLARE _device_parameter_id VARCHAR(50);
    DECLARE _no_more_record INT DEFAULT 0;
    DECLARE _device_parameter_ids CURSOR FOR SELECT id FROM base_device_parameter WHERE delete_flag=0 AND project_type='胶体金';
    #这个是个条件处理,针对NOT FOUND的条件,当没有记录时赋值为1
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _no_more_record = 1;

    #打开游标
    OPEN _device_parameter_ids;
    #把第一行数据写入变量中,游标也随之指向了记录的第一行
    FETCH _device_parameter_ids INTO _device_parameter_id;

    #仪器检测配置循环
    device_parameter_loop:LOOP
        IF _no_more_record = 1 THEN
            SET _no_more_record = 0;
            LEAVE device_parameter_loop;
        END IF;

        #重置参数
        SET _device_parameter_id2 = '';
        SET _device_type_id = '';
        SET _item_id = '';
        SET _project_type = '';
        SET _detect_method = '';

        #历史数据
        SELECT device_type_id, item_id, project_type, detect_method
        INTO _device_type_id, _item_id, _project_type, _detect_method
        FROM base_device_parameter WHERE id = _device_parameter_id;
        #避免没有查询出数据，就结束循环
        SET _no_more_record = 0;

        CASE _detect_method
            WHEN '定性比色' THEN
                UPDATE `base_device_parameter` SET `detect_unit` = 'ppb', `operation_password` = NULL, `food_code` = NULL, `invalid_value` = 0.050000, `check_hole1` = NULL, `check_hole2` = NULL, `wavelength` = 410, `pre_time` = NULL, `dec_time` = 300, `stdA0` = NULL, `stdA1` = NULL, `stdA2` = NULL, `stdA3` = NULL, `stdB0` = NULL, `stdB1` = NULL, `stdB2` = NULL, `stdB3` = NULL, `stdA` = NULL, `stdB` = NULL, `national_stdmin` = NULL, `national_stdmax` = NULL, `yin_min` = NULL, `yin_max` = NULL, `yang_min` = NULL, `yang_max` = NULL, `yinT` = 0.040000, `yangT` = 0.040000, `absX` = 0.000000, `ctAbsX` = 1, `division` = NULL, `parameter` = 0, `trailingEdgeC` = NULL, `trailingEdgeT` = NULL, `suspiciousMin` = NULL, `suspiciousMax` = NULL, `reserved1` = '0.8695', `reserved2` = '0.87', `reserved3` = '1', `reserved4` = NULL, `reserved5` = NULL, `remark` = NULL, `delete_flag` = 0, `update_by` = NULL, `update_date` = NOW() WHERE `id` = _device_parameter_id;

                #更新或新增摄像头定性比色
                SELECT id INTO _device_parameter_id2 FROM base_device_parameter WHERE delete_flag=0 AND device_type_id = _device_type_id
                                                                                  AND item_id = _item_id AND project_type = '胶体金' AND detect_method = '摄像头定性比色' LIMIT 0,1;
                #避免没有查询出数据，就结束循环
                SET _no_more_record = 0;

                IF _device_parameter_id2='' THEN
                    INSERT INTO `base_device_parameter` (`id`, `device_type_id`, `item_id`, `project_type`, `detect_method`, `detect_unit`, `operation_password`, `food_code`, `invalid_value`, `check_hole1`, `check_hole2`, `wavelength`, `pre_time`, `dec_time`, `stdA0`, `stdA1`, `stdA2`, `stdA3`, `stdB0`, `stdB1`, `stdB2`, `stdB3`, `stdA`, `stdB`, `national_stdmin`, `national_stdmax`, `yin_min`, `yin_max`, `yang_min`, `yang_max`, `yinT`, `yangT`, `absX`, `ctAbsX`, `division`, `parameter`, `trailingEdgeC`, `trailingEdgeT`, `suspiciousMin`, `suspiciousMax`, `reserved1`, `reserved2`, `reserved3`, `reserved4`, `reserved5`, `remark`, `delete_flag`, `create_date`, `update_date`) VALUES ((SELECT REPLACE((SELECT UUID()),'-','')), _device_type_id, _item_id, '胶体金', '摄像头定性比色', 'ppb', NULL, NULL, 10.000000, NULL, NULL, 410, NULL, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10.000000, 10.000000, NULL, 1, NULL, 0, NULL, NULL, NULL, NULL, '0.95', '0.95', '2', NULL, NULL, NULL, 0, NOW(), NOW());

                ELSE
                    UPDATE  `base_device_parameter` SET `detect_unit` = 'ppb', `operation_password` = NULL, `food_code` = NULL, `invalid_value` = 10.000000, `check_hole1` = NULL, `check_hole2` = NULL, `wavelength` = 410, `pre_time` = NULL, `dec_time` = 300, `stdA0` = NULL, `stdA1` = NULL, `stdA2` = NULL, `stdA3` = NULL, `stdB0` = NULL, `stdB1` = NULL, `stdB2` = NULL, `stdB3` = NULL, `stdA` = NULL, `stdB` = NULL, `national_stdmin` = NULL, `national_stdmax` = NULL, `yin_min` = NULL, `yin_max` = NULL, `yang_min` = NULL, `yang_max` = NULL, `yinT` = 10.000000, `yangT` = 10.000000, `absX` = NULL, `ctAbsX` = 1, `division` = NULL, `parameter` = 0, `trailingEdgeC` = NULL, `trailingEdgeT` = NULL, `suspiciousMin` = NULL, `suspiciousMax` = NULL, `reserved1` = '0.95', `reserved2` = '0.95', `reserved3` = '2', `reserved4` = NULL, `reserved5` = NULL, `remark` = NULL, `delete_flag` = 0, `update_by` = NULL, `update_date` = NOW() WHERE `id` = _device_parameter_id2;

                END IF;



            WHEN '摄像头定性比色' THEN
                UPDATE  `base_device_parameter` SET `detect_unit` = 'ppb', `operation_password` = NULL, `food_code` = NULL, `invalid_value` = 10.000000, `check_hole1` = NULL, `check_hole2` = NULL, `wavelength` = 410, `pre_time` = NULL, `dec_time` = 300, `stdA0` = NULL, `stdA1` = NULL, `stdA2` = NULL, `stdA3` = NULL, `stdB0` = NULL, `stdB1` = NULL, `stdB2` = NULL, `stdB3` = NULL, `stdA` = NULL, `stdB` = NULL, `national_stdmin` = NULL, `national_stdmax` = NULL, `yin_min` = NULL, `yin_max` = NULL, `yang_min` = NULL, `yang_max` = NULL, `yinT` = 10.000000, `yangT` = 10.000000, `absX` = NULL, `ctAbsX` = 1, `division` = NULL, `parameter` = 0, `trailingEdgeC` = NULL, `trailingEdgeT` = NULL, `suspiciousMin` = NULL, `suspiciousMax` = NULL, `reserved1` = '0.95', `reserved2` = '0.95', `reserved3` = '2', `reserved4` = NULL, `reserved5` = NULL, `remark` = NULL, `delete_flag` = 0, `update_by` = NULL, `update_date` = NOW() WHERE `id` = _device_parameter_id;

                #更新或新增定性比色
                SELECT id INTO _device_parameter_id2 FROM base_device_parameter WHERE delete_flag=0 AND device_type_id = _device_type_id
                                                                                  AND item_id = _item_id AND project_type = '胶体金' AND detect_method = '定性比色' LIMIT 0,1;
                #避免没有查询出数据，就结束循环
                SET _no_more_record = 0;

                IF _device_parameter_id2='' THEN
                    INSERT INTO `base_device_parameter` (`id`, `device_type_id`, `item_id`, `project_type`, `detect_method`, `detect_unit`, `operation_password`, `food_code`, `invalid_value`, `check_hole1`, `check_hole2`, `wavelength`, `pre_time`, `dec_time`, `stdA0`, `stdA1`, `stdA2`, `stdA3`, `stdB0`, `stdB1`, `stdB2`, `stdB3`, `stdA`, `stdB`, `national_stdmin`, `national_stdmax`, `yin_min`, `yin_max`, `yang_min`, `yang_max`, `yinT`, `yangT`, `absX`, `ctAbsX`, `division`, `parameter`, `trailingEdgeC`, `trailingEdgeT`, `suspiciousMin`, `suspiciousMax`, `reserved1`, `reserved2`, `reserved3`, `reserved4`, `reserved5`, `remark`, `delete_flag`, `create_date`, `update_date`) VALUES ((SELECT REPLACE((SELECT UUID()),'-','')), device_type_id, _item_id, '胶体金', '定性比色', 'ppb', NULL, NULL, 0.050000, NULL, NULL, 410, NULL, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.040000, 0.040000, 0.000000, 1, NULL, 0, NULL, NULL, NULL, NULL, '0.8695', '0.87', '1', NULL, NULL, NULL, 0, NOW(), NOW());

                ELSE
                    UPDATE `base_device_parameter` SET `detect_unit` = 'ppb', `operation_password` = NULL, `food_code` = NULL, `invalid_value` = 0.050000, `check_hole1` = NULL, `check_hole2` = NULL, `wavelength` = 410, `pre_time` = NULL, `dec_time` = 300, `stdA0` = NULL, `stdA1` = NULL, `stdA2` = NULL, `stdA3` = NULL, `stdB0` = NULL, `stdB1` = NULL, `stdB2` = NULL, `stdB3` = NULL, `stdA` = NULL, `stdB` = NULL, `national_stdmin` = NULL, `national_stdmax` = NULL, `yin_min` = NULL, `yin_max` = NULL, `yang_min` = NULL, `yang_max` = NULL, `yinT` = 0.040000, `yangT` = 0.040000, `absX` = 0.000000, `ctAbsX` = 1, `division` = NULL, `parameter` = 0, `trailingEdgeC` = NULL, `trailingEdgeT` = NULL, `suspiciousMin` = NULL, `suspiciousMax` = NULL, `reserved1` = '0.8695', `reserved2` = '0.87', `reserved3` = '1', `reserved4` = NULL, `reserved5` = NULL, `remark` = NULL, `delete_flag` = 0, `update_by` = NULL, `update_date` = NOW() WHERE `id` = _device_parameter_id2;

                END IF;




            WHEN '定性消线' THEN
                UPDATE `base_device_parameter` SET `detect_unit` = 'ppb', `operation_password` = NULL, `food_code` = NULL, `invalid_value` = 0.050000, `check_hole1` = NULL, `check_hole2` = NULL, `wavelength` = 410, `pre_time` = NULL, `dec_time` = 300, `stdA0` = NULL, `stdA1` = NULL, `stdA2` = NULL, `stdA3` = NULL, `stdB0` = NULL, `stdB1` = NULL, `stdB2` = NULL, `stdB3` = NULL, `stdA` = NULL, `stdB` = NULL, `national_stdmin` = NULL, `national_stdmax` = NULL, `yin_min` = NULL, `yin_max` = NULL, `yang_min` = NULL, `yang_max` = NULL, `yinT` = 0.040000, `yangT` = 0.040000, `absX` = 0.000000, `ctAbsX` = 1, `division` = NULL, `parameter` = 0, `trailingEdgeC` = NULL, `trailingEdgeT` = NULL, `suspiciousMin` = NULL, `suspiciousMax` = NULL, `reserved1` = '0.8695', `reserved2` = '0.87', `reserved3` = '1', `reserved4` = NULL, `reserved5` = NULL, `remark` = NULL, `delete_flag` = 0, `update_by` = NULL, `update_date` = NOW() WHERE `id` = _device_parameter_id;

                #更新或新增摄像头定性消线
                SELECT id INTO _device_parameter_id2 FROM base_device_parameter WHERE delete_flag=0 AND device_type_id = _device_type_id
                                                                                  AND item_id = _item_id AND project_type = '胶体金' AND detect_method = '摄像头定性消线' LIMIT 0,1;
                #避免没有查询出数据，就结束循环
                SET _no_more_record = 0;

                IF _device_parameter_id2='' THEN
                    INSERT INTO `base_device_parameter` (`id`, `device_type_id`, `item_id`, `project_type`, `detect_method`, `detect_unit`, `operation_password`, `food_code`, `invalid_value`, `check_hole1`, `check_hole2`, `wavelength`, `pre_time`, `dec_time`, `stdA0`, `stdA1`, `stdA2`, `stdA3`, `stdB0`, `stdB1`, `stdB2`, `stdB3`, `stdA`, `stdB`, `national_stdmin`, `national_stdmax`, `yin_min`, `yin_max`, `yang_min`, `yang_max`, `yinT`, `yangT`, `absX`, `ctAbsX`, `division`, `parameter`, `trailingEdgeC`, `trailingEdgeT`, `suspiciousMin`, `suspiciousMax`, `reserved1`, `reserved2`, `reserved3`, `reserved4`, `reserved5`, `remark`, `delete_flag`, `create_date`, `update_date`) VALUES ((SELECT REPLACE((SELECT UUID()),'-','')), _device_type_id, _item_id, '胶体金', '摄像头定性消线', 'ppb', NULL, NULL, 10.000000, NULL, NULL, 410, NULL, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10.000000, 10.000000, NULL, 1, NULL, 0, NULL, NULL, NULL, NULL, '0.95', '0.95', '2', NULL, NULL, NULL, 0, NOW(), NOW());

                ELSE
                    UPDATE  `base_device_parameter` SET `detect_unit` = 'ppb', `operation_password` = NULL, `food_code` = NULL, `invalid_value` = 10.000000, `check_hole1` = NULL, `check_hole2` = NULL, `wavelength` = 410, `pre_time` = NULL, `dec_time` = 300, `stdA0` = NULL, `stdA1` = NULL, `stdA2` = NULL, `stdA3` = NULL, `stdB0` = NULL, `stdB1` = NULL, `stdB2` = NULL, `stdB3` = NULL, `stdA` = NULL, `stdB` = NULL, `national_stdmin` = NULL, `national_stdmax` = NULL, `yin_min` = NULL, `yin_max` = NULL, `yang_min` = NULL, `yang_max` = NULL, `yinT` = 10.000000, `yangT` = 10.000000, `absX` = NULL, `ctAbsX` = 1, `division` = NULL, `parameter` = 0, `trailingEdgeC` = NULL, `trailingEdgeT` = NULL, `suspiciousMin` = NULL, `suspiciousMax` = NULL, `reserved1` = '0.95', `reserved2` = '0.95', `reserved3` = '2', `reserved4` = NULL, `reserved5` = NULL, `remark` = NULL, `delete_flag` = 0, `update_by` = NULL, `update_date` = NOW() WHERE `id` = _device_parameter_id2;

                END IF;




            WHEN '摄像头定性消线' THEN
                UPDATE  `base_device_parameter` SET `detect_unit` = 'ppb', `operation_password` = NULL, `food_code` = NULL, `invalid_value` = 10.000000, `check_hole1` = NULL, `check_hole2` = NULL, `wavelength` = 410, `pre_time` = NULL, `dec_time` = 300, `stdA0` = NULL, `stdA1` = NULL, `stdA2` = NULL, `stdA3` = NULL, `stdB0` = NULL, `stdB1` = NULL, `stdB2` = NULL, `stdB3` = NULL, `stdA` = NULL, `stdB` = NULL, `national_stdmin` = NULL, `national_stdmax` = NULL, `yin_min` = NULL, `yin_max` = NULL, `yang_min` = NULL, `yang_max` = NULL, `yinT` = 10.000000, `yangT` = 10.000000, `absX` = NULL, `ctAbsX` = 1, `division` = NULL, `parameter` = 0, `trailingEdgeC` = NULL, `trailingEdgeT` = NULL, `suspiciousMin` = NULL, `suspiciousMax` = NULL, `reserved1` = '0.95', `reserved2` = '0.95', `reserved3` = '2', `reserved4` = NULL, `reserved5` = NULL, `remark` = NULL, `delete_flag` = 0, `update_by` = NULL, `update_date` = NOW() WHERE `id` = _device_parameter_id;

                #更新或新增定性消线
                SELECT id INTO _device_parameter_id2 FROM base_device_parameter WHERE delete_flag=0 AND device_type_id = _device_type_id
                                                                                  AND item_id = _item_id AND project_type = '胶体金' AND detect_method = '定性消线' LIMIT 0,1;
                #避免没有查询出数据，就结束循环
                SET _no_more_record = 0;

                IF _device_parameter_id2='' THEN
                    INSERT INTO `base_device_parameter` (`id`, `device_type_id`, `item_id`, `project_type`, `detect_method`, `detect_unit`, `operation_password`, `food_code`, `invalid_value`, `check_hole1`, `check_hole2`, `wavelength`, `pre_time`, `dec_time`, `stdA0`, `stdA1`, `stdA2`, `stdA3`, `stdB0`, `stdB1`, `stdB2`, `stdB3`, `stdA`, `stdB`, `national_stdmin`, `national_stdmax`, `yin_min`, `yin_max`, `yang_min`, `yang_max`, `yinT`, `yangT`, `absX`, `ctAbsX`, `division`, `parameter`, `trailingEdgeC`, `trailingEdgeT`, `suspiciousMin`, `suspiciousMax`, `reserved1`, `reserved2`, `reserved3`, `reserved4`, `reserved5`, `remark`, `delete_flag`, `create_date`, `update_date`) VALUES ((SELECT REPLACE((SELECT UUID()),'-','')), device_type_id, _item_id, '胶体金', '定性消线', 'ppb', NULL, NULL, 0.050000, NULL, NULL, 410, NULL, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.040000, 0.040000, 0.000000, 1, NULL, 0, NULL, NULL, NULL, NULL, '0.8695', '0.87', '1', NULL, NULL, NULL, 0, NOW(), NOW());

                ELSE
                    UPDATE `base_device_parameter` SET `detect_unit` = 'ppb', `operation_password` = NULL, `food_code` = NULL, `invalid_value` = 0.050000, `check_hole1` = NULL, `check_hole2` = NULL, `wavelength` = 410, `pre_time` = NULL, `dec_time` = 300, `stdA0` = NULL, `stdA1` = NULL, `stdA2` = NULL, `stdA3` = NULL, `stdB0` = NULL, `stdB1` = NULL, `stdB2` = NULL, `stdB3` = NULL, `stdA` = NULL, `stdB` = NULL, `national_stdmin` = NULL, `national_stdmax` = NULL, `yin_min` = NULL, `yin_max` = NULL, `yang_min` = NULL, `yang_max` = NULL, `yinT` = 0.040000, `yangT` = 0.040000, `absX` = 0.000000, `ctAbsX` = 1, `division` = NULL, `parameter` = 0, `trailingEdgeC` = NULL, `trailingEdgeT` = NULL, `suspiciousMin` = NULL, `suspiciousMax` = NULL, `reserved1` = '0.8695', `reserved2` = '0.87', `reserved3` = '1', `reserved4` = NULL, `reserved5` = NULL, `remark` = NULL, `delete_flag` = 0, `update_by` = NULL, `update_date` = NOW() WHERE `id` = _device_parameter_id2;

                END IF;

            END CASE;

        #获取下一行记录
        FETCH _device_parameter_ids INTO _device_parameter_id;

        #结束机构循环
    END LOOP device_parameter_loop;
    #关闭游标，释放资源
    CLOSE _device_parameter_ids;

END
;


#xiaoyl 2021/03/05 快检车统计
CREATE PROCEDURE `QueryCarStatistics`(in departId int,in pointType int,in checkDateStart varchar(20),in checkDateEnd varchar(20))
BEGIN
	select t2.depart_name area_depart_name,bp.id point_id,bp.point_name,count(dcr.id) num,
	SUM(CASE WHEN dcr.conclusion='合格' THEN 1 ELSE 0 END) qualified,
	SUM(CASE WHEN dcr.conclusion='不合格' THEN 1 ELSE 0 END) unqualified
	from base_point bp
	STRAIGHT_JOIN (SELECT * FROM t_s_depart t1
	WHERE t1.delete_flag=0 and t1.depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart t2 WHERE t2.id=departId),'%')) t ON bp.depart_id=t.id
	 left join t_s_depart t2 on t2.depart_code=SUBSTR(t.depart_code,1,6)
	left join  (select * from data_check_recording dcr1 where dcr1.delete_flag=0 AND dcr1.param1=1  and dcr1.check_date >=checkDateStart and dcr1.check_date <=checkDateEnd) dcr on dcr.point_id=bp.id
	where bp.point_type = pointType  and bp.delete_flag=0
	GROUP BY bp.point_name
	ORDER BY  t2.depart_code asc,num desc,qualified desc;

END;
#Dz 2020/11/19 更新任务进度
CREATE FUNCTION `updateTaskProgress`(`startDate` VARCHAR(20),`endDate` VARCHAR(20)) RETURNS int(11)
BEGIN
	#更新任务进度(只统计抽样检测结果)

	#检测室任务ID
	DECLARE detailIds1 INT(11);
	DECLARE detailId1 INT(11);
	DECLARE taskId1 INT(11);
	DECLARE taskPid1 INT(11);
	DECLARE taskSDate1 VARCHAR(20);
	DECLARE taskEDate1 VARCHAR(20);
	DECLARE foodId1 INT(11);
	DECLARE itemId1 VARCHAR(32);
	DECLARE departId1 INT(11);
	DECLARE pointId1 INT(11);
	DECLARE checkNum1 INT(11);

	#机构任务ID
-- 	DECLARE detailIds2 INT(11);
	DECLARE detailId2 INT(11);
	DECLARE taskId2 INT(11);
	DECLARE taskPid2 INT(11);
	DECLARE foodId2 INT(11);
	DECLARE itemId2 VARCHAR(32);
	DECLARE departId2 INT(11);
	DECLARE pointId2 INT(11);
	DECLARE checkNum2 INT(11);

	DECLARE _no_more_record INT DEFAULT 0;
-- 	DECLARE _point_task_detail_ids CURSOR FOR SELECT id FROM tb_task_detail WHERE receive_nodeid IS NOT NULL;
	DECLARE detailIds1 CURSOR FOR SELECT ttd.id taskDetailIds FROM tb_task tt INNER JOIN tb_task_detail ttd ON tt.id = ttd.task_id WHERE tt.delete_flag=0 AND tt.task_status IN (1,2) AND tt.task_sdate>=CONCAT(startDate, ' 00:00:00') AND tt.task_sdate<=CONCAT(endDate, ' 23:59:59') AND ttd.receive_nodeid IS NOT NULL;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET _no_more_record = 1; #这个是个条件处理,针对NOT FOUND的条件,当没有记录时赋值为1

		#打开游标
		OPEN detailIds1;
		#把第一行数据写入变量中,游标也随之指向了记录的第一行
		FETCH detailIds1 INTO detailId1;

		#机构循环
		detail_loop1:LOOP
			IF _no_more_record = 1 THEN
				SET _no_more_record = 0;
				LEAVE detail_loop1;
			END IF;

			#重置
			SET taskId1 = 0;
			SET taskPid1 = 0;
			SET taskSDate1 = '';
			SET taskEDate1 = '';
			SET foodId1 = 0;
			SET itemId1 = '';
			SET departId1 = 0;
			SET pointId1 = 0;
			SET checkNum1 = 0;

			SELECT tt.id taskId, tt.task_detail_pId pTaskId, DATE_FORMAT(tt.task_sdate, '%Y-%m-%d 00:00:00'), DATE_FORMAT(tt.task_edate, '%Y-%m-%d 23:59:59'),
				ttd.sample_id foodId, ttd.item_id itemId, ttd.receive_pointid departId, ttd.receive_nodeid pointId
				INTO taskId1, taskPid1, taskSDate1, taskEDate1, foodId1, itemId1, departId1, pointId1
			FROM tb_task tt
				INNER JOIN tb_task_detail ttd ON tt.id = ttd.task_id
			WHERE tt.delete_flag=0 AND tt.task_status IN (1,2)
-- 				AND tt.task_sdate>=CONCAT(startDate, ' 00:00:00') AND tt.task_sdate<=CONCAT(endDate, ' 23:59:59')
				AND ttd.id=detailId1
			;

			#检测数量(只统计抽样检测结果)
			IF itemId1 = '' OR itemId1 IS NULL THEN
				SET checkNum1 = (SELECT count(1) FROM data_check_recording WHERE delete_flag=0 AND data_type = 0 AND check_date >= taskSDate1 AND check_date <= taskEDate1 AND point_id=pointId1 AND food_id IN (SELECT id FROM base_food_type WHERE food_code LIKE CONCAT((SELECT food_code FROM base_food_type WHERE id=foodId1),'%')));

			ELSE
				SET checkNum1 = (SELECT count(1) FROM data_check_recording WHERE delete_flag=0 AND data_type = 0 AND check_date >= taskSDate1 AND check_date <= taskEDate1 AND point_id=pointId1 AND food_id IN (SELECT id FROM base_food_type WHERE food_code LIKE CONCAT((SELECT food_code FROM base_food_type WHERE id=foodId1),'%')) AND item_id=itemId1);
			END IF;

			#更新数据
			UPDATE tb_task_detail SET sample_number=checkNum1 WHERE id=detailId1;
			UPDATE tb_task SET sample_number=(SELECT SUM(sample_number) FROM tb_task_detail WHERE task_id=taskId1) WHERE id=taskId1;

			#重置
			SET detailId2 = 0;
			SET taskId2 = taskId1;
			SET taskPid2 = taskPid1;
			SET foodId2 = 0;
			SET itemId2 = '';
			SET departId2 = 0;
			SET pointId2 = 0;
			SET checkNum2 = 0;

			#循环更新上级任务进度
			detail_loop2:LOOP
				IF taskPid2 = 0 OR taskPid2 IS NULL THEN
					LEAVE detail_loop2;
				END IF;

				#更新任务明细
				UPDATE tb_task_detail SET sample_number=(SELECT sample_number FROM tb_task WHERE id=taskId2) WHERE id=taskPid2;

				SELECT tt.id taskId, tt.task_detail_pId pTaskId, ttd.sample_id foodId, ttd.item_id itemId, ttd.receive_pointid departId, ttd.receive_nodeid pointId
				INTO taskId2, taskPid2, foodId2, itemId2, departId2, pointId2
			FROM tb_task tt
				INNER JOIN tb_task_detail ttd ON tt.id = ttd.task_id
			WHERE tt.delete_flag=0 AND tt.task_status IN (1,2)
				AND ttd.id=taskPid2
			;

			#更新任务主表
			UPDATE tb_task SET sample_number=(SELECT SUM(sample_number) FROM tb_task_detail WHERE task_id=taskId2) WHERE id=taskId2;

			#结束循环
			END LOOP detail_loop2;

			FETCH detailIds1 INTO detailId1;

		#结束循环
		END LOOP detail_loop1;
		#关闭游标，释放资源
		CLOSE detailIds1;

	RETURN 0;
END
;

#Dz 2020/08/10
# 取消订单
CREATE PROCEDURE `cancelOrder`( timeOut VARCHAR ( 32 ) )
BEGIN
# 更新income表的交易流水为关闭状态
UPDATE income SET `status` = 3,update_date = NOW( ),update_by = 'dings'
WHERE `status` = 0 AND transaction_type=0 AND sampling_id IN (select id from tb_sampling where order_status = 1
	AND sampling_date <= timeOut );
# 更新订单表的状态为取消状态
UPDATE tb_sampling
SET order_status = 3,
update_date = NOW( ),
update_by = 'dings'
WHERE
	order_status = 1
	AND sampling_date <= timeOut;
END;

#Dz 2019/6/5
#创建`updateDepartPK`过程
CREATE PROCEDURE `updateDepartPK`()
BEGIN
	DECLARE _id VARCHAR(32);
	DECLARE _depart_pid VARCHAR(32);
	DECLARE _tid int;
	DECLARE _pid int;
	DECLARE done INT DEFAULT FALSE;
	DECLARE mycursor CURSOR FOR SELECT id,depart_pid,tid FROM t_s_depart WHERE id!='1';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN mycursor;
		myLoop:LOOP
			FETCH mycursor INTO _id,_depart_pid,_tid;
			IF done THEN
				LEAVE myLoop;
			END IF;
			SELECT tid INTO _pid FROM t_s_depart WHERE id=_depart_pid;
			UPDATE t_s_depart SET pid=_pid WHERE id=_id;
			COMMIT ;
		END LOOP myLoop;
	CLOSE mycursor;
END;


#创建`QueryUnqualifiedPercentData`过程
CREATE PROCEDURE `QueryUnqualifiedPercentData`(in statistics_id INT)
BEGIN
	DECLARE title VARCHAR(20480);
	DECLARE num int DEFAULT 0;
	DECLARE resultList CURSOR FOR
	SELECT GROUP_CONCAT(DISTINCT
        CONCAT(
          'MAX(IF(aa.item_name = ''',
          t.item_name,'''and food_type=''',t.food_type,''', ROUND(aa.unqualified/aa.num,2), 0)) AS ''',
          t.item_name,t.food_type,''''
        )
      ) as title
FROM data_item t
WHERE t.statistics_id=statistics_id GROUP BY food_type ORDER BY sorting DESC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET num=1;
SET @sql='';
OPEN resultList;

REPEAT
 		FETCH resultList into title;
			IF num!=1 THEN
					IF @sql='' THEN
							SELECT title into @sql;
				ELSE
					SELECT CONCAT(@sql,',',title) into @sql;
					END IF;
			END IF;

UNTIL num END REPEAT;
 CLOSE resultList;

SET @sql=CONCAT('SELECT aa.reg_name,',@sql,',SUM(ROUND(aa.unqualified/aa.num,2)) sum',' FROM
				data_item aa WHERE unqualified!=0');

IF statistics_id is not null and statistics_id <> '' then
SET statistics_id = statistics_id;
SET @sql = CONCAT(@sql, ' AND statistics_id = \'',statistics_id, '\'');
END IF;


SET @sql = CONCAT(@sql, ' GROUP BY reg_name ORDER BY sorting DESC');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;


#创建`QueryUnqualifiedData`过程
CREATE PROCEDURE `QueryUnqualifiedData`(in statistics_id INT)
BEGIN
	DECLARE title VARCHAR(20480);
	DECLARE num int DEFAULT 0;
	DECLARE resultList CURSOR FOR
	SELECT GROUP_CONCAT(DISTINCT
        CONCAT(
          'MAX(IF(aa.item_name = ''',
          t.item_name,'''and food_type=''',t.food_type,''', aa.unqualified, 0)) AS ''',
          t.item_name,t.food_type,''''
        )
      ) as title
FROM data_item t
WHERE t.statistics_id=statistics_id GROUP BY food_type ORDER BY sorting DESC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET num=1;
SET @sql='';
OPEN resultList;

REPEAT
 		FETCH resultList into title;
			IF num!=1 THEN
					IF @sql='' THEN
							SELECT title into @sql;
				ELSE
					SELECT CONCAT(@sql,',',title) into @sql;
					END IF;
			END IF;

UNTIL num END REPEAT;
 CLOSE resultList;

SET @sql=CONCAT('SELECT aa.reg_name,',@sql,',SUM(aa.unqualified) sum',' FROM
				data_item aa WHERE unqualified!=0');

IF statistics_id is not null and statistics_id <> '' then
SET statistics_id = statistics_id;
SET @sql = CONCAT(@sql, ' AND statistics_id = \'',statistics_id, '\'');
END IF;


SET @sql = CONCAT(@sql, ' GROUP BY reg_name ORDER BY sorting DESC');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;


#创建`QueryData`过程
CREATE PROCEDURE `QueryData`(in statistics_id INT)
BEGIN
	DECLARE title VARCHAR(20480);
	DECLARE num int DEFAULT 0;
DECLARE resultList CURSOR FOR
SELECT GROUP_CONCAT(DISTINCT
        CONCAT(
          'MAX(IF(aa.item_name = ''',
          t.item_name,'''and food_type=''',t.food_type,''', aa.num, 0)) AS ''',
          t.item_name,t.food_type,''''
        )
      ) as title
FROM data_item t
WHERE t.statistics_id=statistics_id GROUP BY food_type ORDER BY sorting DESC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET num=1;
SET @sql='';
OPEN resultList;
REPEAT
 		FETCH resultList into title;
			IF num!=1 THEN
					IF @sql='' THEN
							SELECT title into @sql;
				ELSE
					SELECT CONCAT(@sql,',',title) into @sql;
					END IF;
			END IF;

UNTIL num END REPEAT;
 CLOSE resultList;


SET @sql=CONCAT('SELECT aa.reg_name,',@sql,',SUM(aa.num) sum',' FROM
				data_item aa');

IF statistics_id is not null and statistics_id <> '' then
SET statistics_id = statistics_id;
SET @sql = CONCAT(@sql, ' Where statistics_id = \'', statistics_id, '\'');
END IF;

SET @sql = CONCAT(@sql, ' GROUP BY reg_name ORDER BY sorting DESC');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;


#创建`monthly_statistics`过程
CREATE PROCEDURE `monthly_statistics`(IN `_month_mm` int)
BEGIN

	#初始化数据
  DECLARE _init_flag INT(11) DEFAULT 0; #初始化
	#DECLARE _min_date VARCHAR(7) DEFAULT '2019-01'; #最小日期，在此之前的数据汇总到这个月
	DECLARE _min_date DATE DEFAULT '2019-01-01'; #最小日期，在此之前的数据汇总到这个月

	#结果
	DECLARE _sampling_num INT(11) DEFAULT 0; #抽样单数量
	DECLARE _check_num INT(11) DEFAULT 0;	#检测数量
	DECLARE _unqualified_num INT(11) DEFAULT 0;	#不合格数量

	DECLARE _his_ms_id INT(11) DEFAULT 0; #历史数据_每月统计ID
	DECLARE _his_sampling_num INT(11) DEFAULT 0; #历史数据_抽样单数量
	DECLARE _his_check_num INT(11) DEFAULT 0;	#历史数据_检测数量
	DECLARE _his_unqualified_num INT(11) DEFAULT 0;	#历史数据_不合格数量

	#年月
	DECLARE _yyyy_mm DATE;
	#DECLARE _month_mm INT(4) DEFAULT 2;	#预计执行次数		=>  改为调用参数(统计最近多少个月，不含当月)
	DECLARE _month_mm0 INT(4) DEFAULT 0;	#已执行次数

	#机构
	DECLARE _depart_id INT(11);
	DECLARE _no_more_record INT DEFAULT 0;
	DECLARE _depart_ids CURSOR FOR SELECT id FROM t_s_depart WHERE delete_flag = 0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET _no_more_record = 1; #这个是个条件处理,针对NOT FOUND的条件,当没有记录时赋值为1

/*
	#创建调试临时表
	DROP TABLE IF EXISTS monthly_statistics_temp_table ;
	CREATE TEMPORARY TABLE monthly_statistics_temp_table(
		`id` INT(11) NOT NULL AUTO_INCREMENT,
		`action` VARCHAR(100) DEFAULT NULL,
		`ms_id` INT(11) DEFAULT NULL,
		`yyyy_mm` VARCHAR(100) DEFAULT NULL,
		`depart_id` INT(11) DEFAULT NULL,
		`sampling_num` INT(11) DEFAULT NULL,
		`check_num` INT(11) DEFAULT NULL,
		`unqualified_num` INT(11) DEFAULT NULL,
		`his_sampling_num` INT(11) DEFAULT NULL,
		`his_check_num` INT(11) DEFAULT NULL,
		`his_unqualified_num` INT(11) DEFAULT NULL,
		PRIMARY KEY(`id`)
	) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
*/

	SET _init_flag = (SELECT COUNT(1) FROM data_monthly_statistics WHERE delete_flag = 0);

	SET _yyyy_mm = (SELECT STR_TO_DATE(DATE_FORMAT(NOW(),'%Y-%m-01'),'%Y-%m-%d'));

	#年月循环
	month_loop:LOOP
		IF (_init_flag > 0 && _month_mm <= _month_mm0) #非初始化，汇总最近几个月数据
			|| (_init_flag = 0 && _yyyy_mm <= _min_date) THEN	#初始化，汇总到最小日期数据
				LEAVE	month_loop;
		END IF;

		SET _month_mm0 = _month_mm0 + 1;
		SET _yyyy_mm = (DATE_SUB(_yyyy_mm , INTERVAL 1 MONTH));

		#打开游标
		OPEN _depart_ids;
		#把第一行数据写入变量中,游标也随之指向了记录的第一行
		FETCH _depart_ids INTO _depart_id;

		#机构循环
		depart_loop:LOOP
			IF _no_more_record = 1 THEN
				SET _no_more_record = 0;
				LEAVE depart_loop;
			END IF;

			#重置
			SET _his_ms_id = 0; #历史数据_每月统计ID
			SET _his_sampling_num = 0; #历史数据_抽样单数量
			SET _his_check_num = 0;	#历史数据_检测数量
			SET _his_unqualified_num = 0;	#历史数据_不合格数量

			#抽样数量
			SET _sampling_num =
				(SELECT COUNT(1) FROM tb_sampling
					WHERE delete_flag = 0
						AND sampling_date >= CONCAT(_yyyy_mm, ' 00:00:00') AND sampling_date < DATE_ADD(CONCAT(_yyyy_mm, ' 00:00:00'),INTERVAL 1 MONTH)
						AND depart_id IN (SELECT id FROM t_s_depart
							WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'))
				);

			#检测数量、不合格数量
			SELECT COUNT(1), SUM(IF(conclusion = '不合格', 1, 0)) INTO _check_num, _unqualified_num
				FROM data_check_recording
				WHERE delete_flag = 0 and param7=1
				AND check_date >= CONCAT(_yyyy_mm, ' 00:00:00') AND check_date < DATE_ADD(CONCAT(_yyyy_mm, ' 00:00:00'),INTERVAL 1 MONTH)
				AND depart_id IN (SELECT id FROM t_s_depart
					WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'));

			IF _unqualified_num IS NULL THEN
				SET _unqualified_num = 0;
			END IF;

			#SELECT _sampling_num, _check_num, _unqualified_num;

			#历史数据
			SELECT id, sampling_number, check_number, unqualified_number
				INTO _his_ms_id, _his_sampling_num, _his_check_num, _his_unqualified_num
				FROM data_monthly_statistics WHERE yyyy_mm = DATE_FORMAT(_yyyy_mm,'%Y-%m') AND depart_id = _depart_id;
			#避免没有查询出数据，就结束循环
			SET _no_more_record = 0;

			#SELECT _his_ms_id, _his_sampling_num, _his_check_num, _his_unqualified_num;
/*
			#INSERT INTO monthly_statistics_temp_table(`action`) VALUES ('NOTHING');
			INSERT INTO monthly_statistics_temp_table(`action`, `ms_id`,`yyyy_mm`, `depart_id`,
					`sampling_num`, `check_num`, `unqualified_num`, `his_sampling_num`, `his_check_num`, `his_unqualified_num`)
				VALUES ('NOTHING', _his_ms_id, DATE_FORMAT(_yyyy_mm,'%Y-%m'), _depart_id,
					_sampling_num, _check_num, _unqualified_num, _his_sampling_num, _his_check_num, _his_unqualified_num);
*/

			IF _his_ms_id = 0 THEN
				#插入数据
				INSERT INTO data_monthly_statistics(`yyyy_mm`, `depart_id`,`sampling_number`,
					`check_number`, `unqualified_number`, `delete_flag`, `create_date`, `update_date`)
				VALUES (DATE_FORMAT(_yyyy_mm,'%Y-%m'), _depart_id, _sampling_num, _check_num,
					_unqualified_num, 0, NOW(), NOW());

				/*
				#调试
				INSERT INTO monthly_statistics_temp_table(`action`, `ms_id`,`yyyy_mm`, `depart_id`,
					`sampling_num`, `check_num`, `unqualified_num`, `his_sampling_num`, `his_check_num`, `his_unqualified_num`)
				VALUES ('INSERT', _his_ms_id, DATE_FORMAT(_yyyy_mm,'%Y-%m'), _depart_id,
					_sampling_num, _check_num, _unqualified_num, _his_sampling_num, _his_check_num, _his_unqualified_num);
				*/

			ELSEIF _sampling_num != _his_sampling_num OR _check_num != _his_check_num
				OR _unqualified_num != _his_unqualified_num THEN
				#更新数据
				UPDATE data_monthly_statistics SET sampling_number = _sampling_num, check_number = _check_num,
					unqualified_number = _unqualified_num, delete_flag = 0, update_date = NOW() WHERE id = _his_ms_id;

				/*
				#调试
				INSERT INTO monthly_statistics_temp_table(`action`, `ms_id`,`yyyy_mm`, `depart_id`,
					`sampling_num`, `check_num`, `unqualified_num`, `his_sampling_num`, `his_check_num`, `his_unqualified_num`)
				VALUES ('UPDATE', _his_ms_id, DATE_FORMAT(_yyyy_mm,'%Y-%m'), _depart_id,
					_sampling_num, _check_num, _unqualified_num, _his_sampling_num, _his_check_num, _his_unqualified_num);

			ELSE
				#调试
				INSERT INTO monthly_statistics_temp_table(`action`, `ms_id`,`yyyy_mm`, `depart_id`,
					`sampling_num`, `check_num`, `unqualified_num`, `his_sampling_num`, `his_check_num`, `his_unqualified_num`)
				VALUES ('--', _his_ms_id, DATE_FORMAT(_yyyy_mm,'%Y-%m'), _depart_id,
					_sampling_num, _check_num, _unqualified_num, _his_sampling_num, _his_check_num, _his_unqualified_num);
			*/
			END IF;

			FETCH _depart_ids INTO _depart_id;

		#结束机构循环
		END LOOP depart_loop;
		#关闭游标，释放资源
		CLOSE _depart_ids;

	#结束年月循环
	END LOOP month_loop;



	#初始化数据，汇总最小日期数据
	IF _init_flag = 0 && _yyyy_mm = _min_date THEN

		#打开游标
		OPEN _depart_ids;
		#把第一行数据写入变量中,游标也随之指向了记录的第一行
		FETCH _depart_ids INTO _depart_id;

		#机构循环
		depart_loop:LOOP
			IF _no_more_record = 1 THEN
				SET _no_more_record = 0;
				LEAVE depart_loop;
			END IF;

			#重置
			SET _his_ms_id = 0; #历史数据_每月统计ID
			SET _his_sampling_num = 0; #历史数据_抽样单数量
			SET _his_check_num = 0;	#历史数据_检测数量
			SET _his_unqualified_num = 0;	#历史数据_不合格数量

			#抽样数量
			SET _sampling_num =
				(SELECT COUNT(1) FROM tb_sampling
					WHERE delete_flag = 0
						AND sampling_date < DATE_ADD(CONCAT(_yyyy_mm, ' 00:00:00'),INTERVAL 1 MONTH)
						AND depart_id IN (SELECT id FROM t_s_depart
							WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'))
				);

			#检测数量、不合格数量
			SELECT COUNT(1), SUM(IF(conclusion = '不合格', 1, 0)) INTO _check_num, _unqualified_num
				FROM data_check_recording
				WHERE delete_flag = 0
				AND check_date < DATE_ADD(CONCAT(_yyyy_mm, ' 00:00:00'),INTERVAL 1 MONTH)
				AND depart_id IN (SELECT id FROM t_s_depart
					WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = _depart_id),'%'));

			IF _unqualified_num IS NULL THEN
				SET _unqualified_num = 0;
			END IF;

			#SELECT _sampling_num, _check_num, _unqualified_num;

			#历史数据
			SELECT id, sampling_number, check_number, unqualified_number
				INTO _his_ms_id, _his_sampling_num, _his_check_num, _his_unqualified_num
				FROM data_monthly_statistics WHERE yyyy_mm = DATE_FORMAT(_yyyy_mm,'%Y-%m') AND depart_id = _depart_id;
			#避免没有查询出数据，就结束循环
			SET _no_more_record = 0;

			#SELECT _his_ms_id, _his_sampling_num, _his_check_num, _his_unqualified_num;
/*
			#INSERT INTO monthly_statistics_temp_table(`action`) VALUES ('NOTHING');
			INSERT INTO monthly_statistics_temp_table(`action`, `ms_id`,`yyyy_mm`, `depart_id`,
					`sampling_num`, `check_num`, `unqualified_num`, `his_sampling_num`, `his_check_num`, `his_unqualified_num`)
				VALUES ('NOTHING', _his_ms_id, DATE_FORMAT(_yyyy_mm,'%Y-%m'), _depart_id,
					_sampling_num, _check_num, _unqualified_num, _his_sampling_num, _his_check_num, _his_unqualified_num);
*/

			IF _his_ms_id = 0 THEN
				#插入数据
				INSERT INTO data_monthly_statistics(`yyyy_mm`, `depart_id`,`sampling_number`,
					`check_number`, `unqualified_number`, `delete_flag`, `create_date`, `update_date`)
				VALUES (DATE_FORMAT(_yyyy_mm,'%Y-%m'), _depart_id, _sampling_num, _check_num,
					_unqualified_num, 0, NOW(), NOW());

				/*
				#调试
				INSERT INTO monthly_statistics_temp_table(`action`, `ms_id`,`yyyy_mm`, `depart_id`,
					`sampling_num`, `check_num`, `unqualified_num`, `his_sampling_num`, `his_check_num`, `his_unqualified_num`)
				VALUES ('INSERT', _his_ms_id, DATE_FORMAT(_yyyy_mm,'%Y-%m'), _depart_id,
					_sampling_num, _check_num, _unqualified_num, _his_sampling_num, _his_check_num, _his_unqualified_num);
				*/

			ELSEIF _sampling_num != _his_sampling_num OR _check_num != _his_check_num
				OR _unqualified_num != _his_unqualified_num THEN
				#更新数据
				UPDATE data_monthly_statistics SET sampling_number = _sampling_num, check_number = _check_num,
					unqualified_number = _unqualified_num, delete_flag = 0, update_date = NOW() WHERE id = _his_ms_id;

				/*
				#调试
				INSERT INTO monthly_statistics_temp_table(`action`, `ms_id`,`yyyy_mm`, `depart_id`,
					`sampling_num`, `check_num`, `unqualified_num`, `his_sampling_num`, `his_check_num`, `his_unqualified_num`)
				VALUES ('UPDATE', _his_ms_id, DATE_FORMAT(_yyyy_mm,'%Y-%m'), _depart_id,
					_sampling_num, _check_num, _unqualified_num, _his_sampling_num, _his_check_num, _his_unqualified_num);

			ELSE
				#调试
				INSERT INTO monthly_statistics_temp_table(`action`, `ms_id`,`yyyy_mm`, `depart_id`,
					`sampling_num`, `check_num`, `unqualified_num`, `his_sampling_num`, `his_check_num`, `his_unqualified_num`)
				VALUES ('--', _his_ms_id, DATE_FORMAT(_yyyy_mm,'%Y-%m'), _depart_id,
					_sampling_num, _check_num, _unqualified_num, _his_sampling_num, _his_check_num, _his_unqualified_num);
			*/
			END IF;

			FETCH _depart_ids INTO _depart_id;

		#结束机构循环
		END LOOP depart_loop;
		#关闭游标，释放资源
		CLOSE _depart_ids;

	END IF;

	#查看调试
	#SELECT * FROM monthly_statistics_temp_table;
	#删除调试临时表
	#DROP TABLE monthly_statistics_temp_table;

END;


#创建`importData`过程
CREATE PROCEDURE `importData`()
BEGIN
	DECLARE id1 VARCHAR(32);-- id PK
	DECLARE check_date1 VARCHAR(20);-- 检测时间
	DECLARE reg_name1 VARCHAR(50); -- 抽检市场/单位名称
	DECLARE reg_user_name1 VARCHAR(50); -- 抽检档口名称
	DECLARE food_name1 VARCHAR(50);-- 样品名称
	DECLARE food_type_name1 VARCHAR(50); -- 样品种类
	DECLARE item_name1 VARCHAR(50); -- 检测项目
	DECLARE check_result1 VARCHAR(50); -- 检测值
	DECLARE limit_value1 VARCHAR(50); -- 标准值
	DECLARE check_unit1 VARCHAR(50); -- 检测值/标准值单位
	DECLARE check_accord1 VARCHAR(50); -- 判断依据
	DECLARE conclusion1 VARCHAR(50); -- 检测结论
	DECLARE check_username1 VARCHAR(50); -- 检测人
	DECLARE point_name1 VARCHAR(50); -- 检测点
	DECLARE done INT DEFAULT FALSE;

	DECLARE mycursor CURSOR FOR
	(SELECT
		`检测编号★`,`抽检日期★`,`抽检市场/单位名称★`,`档口/车牌号 (门牌号)`,`样品名称`,`样品种类`,
		`检测项目★`,`检测值★`,`标准值`,`检测值/标准值单位`,`判断依据`,`检测结论★`,`检测人`,`检测点`
	FROM cc420);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN mycursor;
		myLoop:LOOP
			FETCH mycursor INTO id1,check_date1,reg_name1,reg_user_name1,food_name1,food_type_name1,
				item_name1,check_result1,limit_value1,check_unit1,check_accord1,conclusion1,check_username1,point_name1;
			IF done THEN
				LEAVE myLoop;
			END IF;
			INSERT into data_check_recording(
				id,check_date,reg_name,reg_user_name,
				food_name,food_type_name,
				item_name,check_result,limit_value,check_unit,conclusion,check_username,point_name,check_accord,

				check_accord_id,reg_id,reg_user_id,
				food_id,food_type_id,
				item_id,point_id,depart_id,data_source,param3
			) VALUES (
				id1,check_date1,reg_name1,reg_user_name1,food_name1,food_type_name1,
				item_name1,check_result1,limit_value1,check_unit1,conclusion1,check_username1,point_name1,check_accord1,

				(SELECT id FROM base_detect_standard WHERE standard_name=check_accord1 AND delete_flag=0 LIMIT 0,1),

				(SELECT id FROM base_regulatory_object WHERE reg_name=reg_name1 AND delete_flag=0
						AND depart_id=(SELECT depart_id FROM base_point WHERE point_name=point_name1 AND delete_flag=0  LIMIT 0,1)),
				(SELECT id FROM base_regulatory_business WHERE ope_shop_code=reg_user_name1 AND delete_flag=0
						AND reg_id=(SELECT id FROM base_regulatory_object WHERE reg_name=reg_name1 AND delete_flag=0
							AND depart_id=(SELECT depart_id FROM base_point WHERE point_name=point_name1 AND delete_flag=0 LIMIT 0,1)
						)
				),

				(SELECT id FROM base_food_type WHERE food_name=food_name1 AND delete_flag=0 LIMIT 0,1),
				(SELECT id FROM base_food_type WHERE food_name=food_type_name1 AND delete_flag=0 LIMIT 0,1),
				(SELECT id FROM base_detect_item WHERE detect_item_name=item_name1 AND delete_flag=0 LIMIT 0,1),
				(SELECT id FROM base_point WHERE point_name=point_name1 AND delete_flag=0 LIMIT 0,1),
				(SELECT depart_id FROM base_point WHERE point_name=point_name1 AND delete_flag=0 LIMIT 0,1),
				4,'201804201520'
			);
			COMMIT ;
		END LOOP myLoop;
	CLOSE mycursor;
END;


#创建`getParentList`函数
CREATE FUNCTION `getParentList`(rootId varchar(100)) RETURNS varchar(1000) CHARSET utf8
BEGIN
DECLARE fid varchar(100) default '';
DECLARE str varchar(1000) default rootId;

WHILE rootId is not null  do
    SET fid =(SELECT depart_pid FROM t_s_depart WHERE id = rootId);
    IF fid is not null THEN
        SET str = concat(str, ',', fid);
        SET rootId = fid;
    ELSE
        SET rootId = fid;
    END IF;
END WHILE;
return str;
END;


#创建`getParentDepartList`函数
CREATE FUNCTION `getParentDepartList`(rootId varchar(100)) RETURNS varchar(1000) CHARSET utf8
BEGIN
DECLARE fid varchar(100) default '';
DECLARE str varchar(1000) default rootId;

WHILE rootId is not null do
    SET fid =(SELECT depart_pid FROM t_s_depart WHERE id = rootId);
    IF fid is not null AND fid != '' THEN
        SET str = concat(str, ',', fid);
        SET rootId = fid;
    ELSE
        SET rootId = fid;
    END IF;
END WHILE;
return str;
END;


#创建`getMenuChildLst`函数
CREATE FUNCTION `getMenuChildLst`(rootId VARCHAR(32)) RETURNS varchar(5120) CHARSET utf8
BEGIN
     DECLARE sTemp VARCHAR(5120);
     DECLARE sTempChd VARCHAR(5120);
			SET SESSION group_concat_max_len=5120;
     SET sTemp =NULL;
     SET sTempChd =rootId;

     WHILE sTempChd is not null DO
				IF sTemp IS null THEN
					  SET sTemp =rootId;
				ELSE
					SET sTemp = concat(sTemp,',',sTempChd);
				END IF;
       SELECT group_concat(id) INTO sTempChd FROM t_s_function where FIND_IN_SET(parent_id,sTempChd)>0 and delete_flag=0;
     END WHILE;
     RETURN sTemp;
   END;


#创建`getFoodParentList`函数
CREATE FUNCTION `getFoodParentList`(rootId varchar(100)) RETURNS varchar(5120) CHARSET utf8
BEGIN
DECLARE fid VARCHAR(5120) default '';
DECLARE str VARCHAR(5120) default rootId;
SET SESSION group_concat_max_len=5120;
WHILE rootId is not null  do
    SET fid =(SELECT parent_id FROM base_food_type WHERE id = rootId);
    IF fid is not null THEN
        SET str = concat(str, ',', fid);
        SET rootId = fid;
    ELSE
        SET rootId = fid;
    END IF;
END WHILE;
return str;
END;


#创建`getChildLst`函数
CREATE FUNCTION `getChildLst`(`rootId` int) RETURNS varchar(5120) CHARSET utf8
BEGIN
     DECLARE sTemp text;
     DECLARE sTempChd text;
		 SET SESSION group_concat_max_len=10240;
     SET sTemp =NULL;
     SET sTempChd =rootId;

     WHILE sTempChd is not null DO
				IF sTemp IS null THEN
					  SET sTemp =rootId;
				ELSE
					SET sTemp = concat(sTemp,',',sTempChd);
				END IF;
       SELECT group_concat(CAST(id AS CHAR)) INTO sTempChd FROM base_food_type where delete_flag=0 AND FIND_IN_SET(parent_id,sTempChd)>0;
     END WHILE;
     RETURN sTemp;
   END;


#创建`getChildDepartLst`函数
CREATE FUNCTION `getChildDepartLst`(rootId VARCHAR(32)) RETURNS varchar(5120) CHARSET utf8
BEGIN
     DECLARE sTemp VARCHAR(5120);
     DECLARE sTempChd VARCHAR(5120);
SET SESSION group_concat_max_len=5120;
     SET sTemp =NULL;
     SET sTempChd =rootId;

     WHILE sTempChd is not null DO
				IF sTemp IS null THEN
					  SET sTemp =rootId;
				ELSE
					SET sTemp = concat(sTemp,',',sTempChd);
				END IF;
       SELECT group_concat(id) INTO sTempChd FROM t_s_depart where FIND_IN_SET(depart_pid,sTempChd)>0;
     END WHILE;
     RETURN sTemp;
   END;


#创建`user`过程
CREATE PROCEDURE `abc`(in sfood VARCHAR(20))
BEGIN

  select  * from base_food_type where food_name = sfood or food_name_other like concat(concat('%',sfood ),'%');

END;


#创建`user`视图
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `user` AS SELECT
	`t_s_user`.`id` AS `id`,
	`t_s_user`.`workers_id` AS `workers_id`,
	`t_s_user`.`user_name` AS `user_name`,
	`t_s_user`.`password` AS `password`,
	`t_s_user`.`realname` AS `realname`,
	`t_s_user`.`depart_id` AS `depart_id`,
	`t_s_user`.`point_id` AS `point_id`,
	`t_s_user`.`role_id` AS `role_id`,
	`t_s_user`.`status` AS `status`,
	`t_s_user`.`sorting` AS `sorting`,
	`t_s_user`.`create_by` AS `create_by`,
	`t_s_user`.`create_date` AS `create_date`,
	`t_s_user`.`update_by` AS `update_by`,
	`t_s_user`.`update_date` AS `update_date`,
	`t_s_user`.`delete_flag` AS `delete_flag`,
	`t_s_user`.`login_count` AS `login_count`,
	`t_s_user`.`login_time` AS `login_time`
FROM
	`t_s_user`;

CREATE FUNCTION `getChildTaskList`(rootId VARCHAR(32)) RETURNS text CHARSET utf8
BEGIN
     DECLARE sTempChd1 text;
     DECLARE sTempChd2 text;
     DECLARE sTemp1 text;
     DECLARE sTemp2 text;

     SET sTempChd1 =rootId;
     SET sTempChd2 =rootId;
     SET sTemp1 =NULL;
     SET sTemp2 =NULL;

     WHILE sTempChd2 is not null DO
			IF sTemp1 IS null THEN
				SET sTemp1 = rootId;
			ELSE
				SET sTemp1 = sTempChd2;
			END IF;

			IF sTemp2 IS null THEN
				SET sTemp2 =rootId;
			ELSE
				SET sTemp2 = concat(sTemp2,',',sTempChd2);
			END IF;

			SELECT group_concat(id) INTO sTempChd1 FROM tb_task_detail where FIND_IN_SET(task_id,sTemp1)>0;
			SELECT group_concat(id) INTO sTempChd2 FROM tb_task where FIND_IN_SET(task_detail_pId,sTempChd1)>0;

     END WHILE;
     RETURN sTemp2;
   END;