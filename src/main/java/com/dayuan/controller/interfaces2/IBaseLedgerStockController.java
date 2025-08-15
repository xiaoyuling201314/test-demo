package com.dayuan.controller.interfaces2;

import com.dayuan.bean.InterfaceJson;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.ledger.BaseLedgerStockService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.DyFileUtil;
import com.dayuan.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.math.BigDecimal;
import java.util.*;

/**
 * 进货台账接口
 * @author Dz
 *
 */
@RestController
@RequestMapping("/iBaseLedgerStock")
public class IBaseLedgerStockController extends BaseInterfaceController {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private BaseLedgerStockService stockService;
	@Autowired
	private DataCheckRecordingService checkRecordingService;

	@Value("${resources}")
	private String resources;
	@Value("${resourcesUrl}")
	private String resourcesUrl;

	/**
	 * 新增/编辑进货台账
	 * @param request
	 * @param response
	 * @param userToken
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public InterfaceJson save(HttpServletRequest request, HttpServletResponse response, String userToken, BaseLedgerStock bean) {
		InterfaceJson aj = new InterfaceJson();
		try {
			//token验证
			TSUser user = tokenExpired(userToken);

			required(bean.getCheckRecordingId(), WebConstant.INTERFACE_CODE1, "参数checkRecordingId不能为空");
			required(bean.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");
			required(bean.getBusinessId(), WebConstant.INTERFACE_CODE1, "参数businessId不能为空");
			required(bean.getParam1(), WebConstant.INTERFACE_CODE1, "参数param1不能为空");
			required(bean.getFoodName(), WebConstant.INTERFACE_CODE1, "参数foodName不能为空");
			required(bean.getStockCount(), WebConstant.INTERFACE_CODE1, "参数stockCount不能为空");
			required(bean.getSize(), WebConstant.INTERFACE_CODE1, "参数size不能为空");

			String filePath = "stock/";
			String path = resources + filePath;
			File file=new File(path);
			if(!file.exists()){
				DyFileUtil.createFolder(path);
			}

			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

			//进货证明图片
			String	StockProof_Img = null;
			//检验证明图片
			String	CheckProof_Img=null;
			//检疫证明图片
			String	QuarantineProof_Img=null;

			BaseLedgerStock stock0 = stockService.queryByRid(bean.getCheckRecordingId());
			if (stock0 != null) {
				bean.setId(stock0.getId());

				//如果是更新图片 则把原来的加上去
				if(bean.getStockProof_Img()!=null){
					StockProof_Img=stock0.getStockProof_Img();
				}
				if(bean.getCheckProof_Img()!=null){
					CheckProof_Img=stock0.getCheckProof_Img();
				}
				if(bean.getQuarantineProof_Img()!=null){
					QuarantineProof_Img=stock0.getQuarantineProof_Img();
				}
			}

			for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
				String keyName=entity.getKey();
				if(keyName!=null){
					//截取前4位标识
					keyName = keyName.substring(0, 4);
				}
				// 获得原始文件名
				MultipartFile mf = entity.getValue();
				String  fileName = mf.getOriginalFilename();
				switch (keyName) {
					//进货凭证
					case "img1":
						MultipartFile img1=entity.getValue();
						// 进货证明图片
						if (null != img1 && img1.getSize() != 0) {
							String fileOldName = img1.getOriginalFilename();
							String ext = fileOldName.substring(fileOldName.lastIndexOf("."));
							fileName = UUID.randomUUID() + ext;
							uploadFile(request, filePath, img1, fileName);
							if(StockProof_Img==null){
								StockProof_Img=	fileName;
							}else{
								StockProof_Img+=","+fileName;
							}

						}
						break;
					//检验证明
					case "img2":
						MultipartFile img2=entity.getValue();
						// 检验证明图片
						if (null != img2 && img2.getSize() != 0) {
							String fileOldName = img2.getOriginalFilename();
							String ext = fileOldName.substring(fileOldName.lastIndexOf("."));
							fileName = UUID.randomUUID() + ext;
							uploadFile(request, filePath, img2, fileName);
							if(CheckProof_Img==null){
								CheckProof_Img=	fileName;
							}else{
								CheckProof_Img+= ","+fileName;
							}
						}
						break;
					//检疫证明
					case "img3":
						MultipartFile img3=entity.getValue();
						// 检疫证明图片
						if (null != img3 && img3.getSize() != 0) {
							String fileOldName = img3.getOriginalFilename();
							String ext = fileOldName.substring(fileOldName.lastIndexOf("."));
							fileName = UUID.randomUUID() + ext;
							uploadFile(request, filePath, img3, fileName);
							if(QuarantineProof_Img==null){
								QuarantineProof_Img= fileName;
							}else{
								QuarantineProof_Img+= ","+fileName;
							}
						}
						break;

					default:
						break;
				}

			}

			// 新增
			if (stock0 == null) {
				bean.setStockProof_Img(StockProof_Img);
				bean.setQuarantineProof_Img(QuarantineProof_Img);
				bean.setCheckProof_Img(CheckProof_Img);

				bean.setCreate_by(user.getId());
				bean.setCreate_date(new Date());
				bean.setUpdate_by(user.getId());
				bean.setUpdate_date(bean.getCreate_date());
				stockService.insertSelective(bean);

			// 更新
			} else {
				bean.setStockProof_Img(StockProof_Img);
				bean.setQuarantineProof_Img(QuarantineProof_Img);
				bean.setCheckProof_Img(CheckProof_Img);

				bean.setUpdate_by(user.getId());
				bean.setUpdate_date(new Date());
				stockService.updateBySelective(bean);
			}

		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			e.printStackTrace();
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
	}

	/**
	 * 检测数据溯源
	 * @param request
	 * @param response
	 * @param userToken
	 * @param rid
	 * @return 检测数据ID
	 */
	@RequestMapping(value = "/queryByRid", method = RequestMethod.POST)
	public InterfaceJson queryByRid(HttpServletRequest request, HttpServletResponse response, String userToken, Integer rid) {
		InterfaceJson aj = new InterfaceJson();
		try {
			//token验证
			TSUser user = tokenExpired(userToken);
			required(rid, WebConstant.INTERFACE_CODE1, "参数rid不能为空");

            String filePath = "stock/";

			//通过检测数据ID查询台账
			BaseLedgerStock ledgerStock = stockService.queryByRid(rid);

			if (ledgerStock == null) {
				DataCheckRecording dcr = checkRecordingService.getById(rid);
				if (dcr != null) {
					ledgerStock = stockService.queryByBatchNumber(dcr.getRegId(), dcr.getRegUserId(), dcr.getFoodName(), null, DateUtil.formatDate(dcr.getCheckDate(), "yyyy-MM-dd"));
				}
			}
            if (ledgerStock != null) {
				String checkProofImg = ledgerStock.getCheckProof_Img();
				if (!StringUtil.isEmpty(checkProofImg)) {
					String[] checkProofImgs = checkProofImg.split(",");
					StringBuffer imgStr1 = new StringBuffer();
					for (String imgName : checkProofImgs) {
						imgStr1.append(resourcesUrl+filePath+imgName+",");
					}
					imgStr1.deleteCharAt(imgStr1.length()-1);
					ledgerStock.setCheckProof_Img(imgStr1.toString());
				}

				String quarantineProofImg = ledgerStock.getQuarantineProof_Img();
				if (!StringUtil.isEmpty(quarantineProofImg)) {
					String[] quarantineProofImgs = quarantineProofImg.split(",");
					StringBuffer imgStr2 = new StringBuffer();
					for (String imgName : quarantineProofImgs) {
						imgStr2.append(resourcesUrl+filePath+imgName+",");
					}
					imgStr2.deleteCharAt(imgStr2.length()-1);
					ledgerStock.setQuarantineProof_Img(imgStr2.toString());
				}

				String stockProofImg = ledgerStock.getStockProof_Img();
				if (!StringUtil.isEmpty(stockProofImg)) {
					String[] stockProofImgs = stockProofImg.split(",");
					StringBuffer imgStr3 = new StringBuffer();
					for (String imgName : stockProofImgs) {
						imgStr3.append(resourcesUrl+filePath+imgName+",");
					}
					imgStr3.deleteCharAt(imgStr3.length()-1);
					ledgerStock.setStockProof_Img(imgStr3.toString());
				}
			}

			if (ledgerStock != null) {
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("id", ledgerStock.getId());
				map.put("checkRecordingId", ledgerStock.getCheckRecordingId());
				map.put("regId", ledgerStock.getRegId());
				map.put("regName", ledgerStock.getParam1());
				map.put("businessId", ledgerStock.getBusinessId());
				map.put("opeShopCode", ledgerStock.getOpeShopCode());

				map.put("foodName", ledgerStock.getFoodName());
				map.put("batchNumber", ledgerStock.getBatchNumber());
				map.put("size", ledgerStock.getSize());
				map.put("expirationDate", ledgerStock.getExpirationDate());
				map.put("stockDate", ledgerStock.getStockDate());
				map.put("stockCount", ledgerStock.getStockCount());
				map.put("productionDate", ledgerStock.getProductionDate());
				map.put("productionPlace", ledgerStock.getProductionPlace());

				map.put("supplierId", ledgerStock.getSupplierId());
				map.put("supplier", ledgerStock.getSupplier());
				map.put("supplierUser", ledgerStock.getSupplierUser());
				map.put("supplierTel", ledgerStock.getSupplierTel());

				map.put("stockProof", ledgerStock.getStockProof());
				map.put("stockProofImg", ledgerStock.getStockProof_Img());
				map.put("checkProof", ledgerStock.getCheckProof());
				map.put("checkProofImg", ledgerStock.getCheckProof_Img());
				map.put("quarantineProof", ledgerStock.getQuarantineProof());
				map.put("quarantineProofImg", ledgerStock.getQuarantineProof_Img());

				map.put("memo", ledgerStock.getMemo());
				map.put("accessory", ledgerStock.getAccessory());
				map.put("deleteFlag", ledgerStock.getDelete_flag());

				aj.setObj(map);
			}

		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
	}

}
