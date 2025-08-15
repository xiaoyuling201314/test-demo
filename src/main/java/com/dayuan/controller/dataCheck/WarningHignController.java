package com.dayuan.controller.dataCheck;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.mapper.dataCheck.DataUnqualifiedTreatmentMapper;
import org.apache.log4j.Logger;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.model.dataCheck.CheckResultModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.DataCheck.DataUnqualifiedTreatmentService;
import com.dayuan.service.ledger.BaseLedgerStockService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.google.common.base.Objects;

import groovy.util.logging.Slf4j;

/**
 * @author yzh
 * @Date 2020年6月29日 功能描述
 */
@Slf4j
@RequestMapping("/warninghign")
@Controller
public class WarningHignController {

	@Autowired
	private DataCheckRecordingService dataCheckRecordingService;

	@Autowired
	private DataUnqualifiedTreatmentService treatmentService;

	@Autowired
	private BaseLedgerStockService baseLedgerStockService;
	
	@Autowired
	JdbcTemplate jdbc;

	/**
	 * 进入不合格待处理列表
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
		String start = DateUtil.xDayAgo(-30);
		String end = DateUtil.date_sdf.format(new Date());
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		return new ModelAndView("/waring/list");
	}

	/**
	 * 查询检测结果数据列表
	 *
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/datagrid")
	@ResponseBody
	public AjaxJson datagrid(HttpServletRequest request, CheckResultModel model, String regTypeId, Page page,
			HttpServletResponse response, String indexNum) {
		AjaxJson jsonObj = new AjaxJson();

		try {
			// 获取当前用户信息
			page.setOrder("desc");
			Map map = treatmentService.dataPermission("/dataCheck/unqualified/list.do");
			model.setDepartArr((Integer[]) map.get("departArr"));
			model.setPointArr((Integer[]) map.get("pointArr"));
			model.setUserRegId((Integer) map.get("userRegId"));
			if (StringUtil.isNotEmpty(regTypeId)) {
				model.setRegTypeId(regTypeId);
			}
            //高级搜索时间范围，覆盖默认时间范围
            Map<String, String> dateMap = page.getDateMap();
            if (null != dateMap) {
                if (StringUtil.isNotEmpty(dateMap.get("checkDateStartDate"))) {
                    model.setCheckDateStartDateStr(dateMap.get("checkDateStartDate"));
                }
                if (StringUtil.isNotEmpty(dateMap.get("checkDateEndDate"))) {
                    model.setCheckDateEndDateStr(dateMap.get("checkDateEndDate"));
                }
            }
			
			
			Short dealMethod = model.getDealMethod();
			if (dealMethod != null && dealMethod == 1) {
//				page = treatmentService.loadDealDatagrid(page, model);
				page = treatmentService.loadDatagrid(page, model, DataUnqualifiedTreatmentMapper.class, "loadDealDatagrid", "getDealRowTotal");
			} else {
				page = treatmentService.loadDatagrid(page, model);
			}
			List<CheckResultModel> list = (List<CheckResultModel>) page.getResults();
			list.stream().forEach(item -> {
				getbaseLedger(item);
			});
			// page = dealMethod != null && dealMethod == 1 ?
			// treatmentService.loadDealDatagrid(page, model) :
			// treatmentService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			Log.error("******************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName()
					+ "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			e.printStackTrace();
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}



	// 推送消息
	@ResponseBody
	@RequestMapping("/sendMessage")
	public AjaxJson sendMessage(String id) throws Exception {
		AjaxJson jsonObj = new AjaxJson();
		CheckResultModel checkResult = dataCheckRecordingService.getRecording(Integer.valueOf(id));
		if(checkResult !=null && Objects.equal(checkResult.getIssend(), "1")){
			jsonObj.setObj(false);
		}else{
			jsonObj.setObj(true);
		}
		jdbc.update("update data_check_recording set issend = 1 , update_date = '"+  LocalDateTime.now() +"' where rid = " + id);
		jsonObj.setSuccess(true);
		jsonObj.setMsg("操作成功");
		return jsonObj;
	}

	// 获取溯源信息
	public void getbaseLedger(CheckResultModel checkResult) {
		Integer id = Integer.valueOf(checkResult.getId());
		CheckResultModel s = dataCheckRecordingService.getRecording(id);
		checkResult.setOrigin(s.getOrigin());
		checkResult.setBatchNumber(s.getBatchNumber());
		checkResult.setSupplierAddress(s.getSupplierAddress());

		//item.setLedgerStock(ledgerStock != null ? ledgerStock : new BaseLedgerStock());
	}
}
