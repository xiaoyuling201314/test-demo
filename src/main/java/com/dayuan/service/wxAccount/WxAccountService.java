package com.dayuan.service.wxAccount;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.Page;
import com.dayuan.bean.wxAccount.wxAccount;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.wxAccount.wxAccountMapper;
import com.dayuan.model.wxAccount.wxAccountModel;
import com.dayuan.service.BaseService;

@Service
public class WxAccountService extends BaseService<wxAccount, Integer> {

	@Autowired
	private wxAccountMapper mapper;
	
	@Override
	public BaseMapper<wxAccount, Integer> getMapper() {
		
		return mapper;
	}
	
	/**
	 * 查询公众号送检人数
	 * @param model
	 * @return
	 */
	public List<wxAccountModel> selectSamUserNumByDepartCode(wxAccountModel model) {
		
		return mapper.selectSamUserNumByDepartCode(model);
	}

    /**
	 * 查询公众号送检数量
	 * @param model
	 * @return
	 */
	public List<wxAccountModel> selectSamNumByDepartCode(wxAccountModel model) {
		
		return mapper.selectSamNumByDepartCode(model);
	}

    /**
     * 查询公众号检测批次
     * @param model
     * @return
     */
  public List<wxAccountModel> selectRecordingNumByDepartCode(wxAccountModel model) {
	  
	return mapper.selectRecordingNumByDepartCode(model);
  }

    /**
   * 根据公众号查询 送样单列表
   * @param page
   * @param t
   * @return
   * @throws Exception
   */
  public Page loadDatagrid2(Page page, wxAccountModel t) throws Exception{
		// 初始化分页参数
		if (null == page) {
			page = new Page();
		}
		// 设置查询条件
		page.setObj(t);

		// 每次查询记录总数量,防止新增或删除记录后总数量错误
		page.setRowTotal(mapper.getRowTotal2(page));

		// 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
		page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
		
		//查看页不存在,修改查看页序号
		if(page.getPageNo() <= 0){
			page.setPageNo(1);
			page.setRowOffset(page.getRowOffset());
			page.setRowTail(page.getRowTail());
		}else if(page.getPageNo() > page.getPageCount()){
			page.setPageNo(page.getPageCount());
			page.setRowOffset(page.getRowOffset());
			page.setRowTail(page.getRowTail());
		}
		
		List<wxAccountModel> dataList = mapper.loadDatagrid2(page);
		page.setResults(dataList);
		return page;
	}
  
}
