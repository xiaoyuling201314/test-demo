//package com.dayuan.controller.interfaces2;
//
//import java.util.Date;
//import java.util.List;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.RestController;
//import org.springframework.web.multipart.MultipartFile;
//
//import com.dayuan.bean.InterfaceJson;
//import com.dayuan.bean.delivery.TbDelivery;
//import com.dayuan.bean.delivery.TbDeliveryPerson;
//import com.dayuan.bean.system.TSUser;
//import com.dayuan.common.PublicUtil;
//import com.dayuan.common.WebConstant;
//import com.dayuan.exception.MyException;
//import com.dayuan.model.delivery.DeliveryModel;
//import com.dayuan.service.delivery.TbDeliveryService;
//import com.dayuan.service.detect.DepartService;
//import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
//import com.dayuan.util.DyFileUtil;
//import com.dayuan.util.StringUtil;
//import com.dayuan.util.UUIDGenerator;
//
///**
// * 入场登记接口
// * @author Dz
// *
// */
//@RestController
//@RequestMapping("/iDelivery")
//public class IDeliveryController extends BaseInterfaceController {
//
//	@Autowired
//	private TbDeliveryService deliveryService;
//	@Autowired
//	private DepartService departService;
//	@Autowired
//	private BaseRegulatoryObjectService regulatoryObjectService;
//
//	@RequestMapping(value = "/download")
//	@ResponseBody
//	public InterfaceJson download(HttpServletRequest request, HttpServletResponse response, String userToken, Date deliveryDate) {
//		response.addHeader("Access-Control-Allow-Origin", "*");
//
//		InterfaceJson aj = new InterfaceJson();
//		try {
//			//必填验证
//			TSUser user = tokenExpired(userToken);	//token验证
//
//			List<Integer> departIds = departService.querySonDeparts(user.getDepartId());
//
//			List<Integer> regIds = regulatoryObjectService.queryRegIdsByDepartIds(departIds);
//			//根据登记日期获取入场信息
//			List<DeliveryModel> deliveryModel = deliveryService.queryByDeliveryDate(deliveryDate, regIds);
//
//			aj.setObj(deliveryModel);
//
//		} catch (MyException e) {
//			e.printStackTrace();
//			setAjaxJson(aj, e.getCode(), e.getText());
//		} catch (Exception e) {
//			e.printStackTrace();
//			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//		}
//
//		return aj;
//	}
//
//	@RequestMapping(value = "/save")
//	@ResponseBody
//	public InterfaceJson save(HttpServletRequest request, HttpServletResponse response, String userToken, TbDeliveryPerson deliveryPerson, TbDelivery delivery,
//			@RequestParam(value = "deliveryImg", required = false) List<MultipartFile> deliveryImg) {
//		response.addHeader("Access-Control-Allow-Origin", "*");
//
//		InterfaceJson aj = new InterfaceJson();
//		try {
//			//必填验证
//			TSUser user = tokenExpired(userToken);	//token验证
////			required(deliveryPerson.getLicensePlate(), WebConstant.INTERFACE_CODE1, "参数licensePlate不能为空");
////			required(deliveryPerson.getOwnerName(), WebConstant.INTERFACE_CODE1, "参数ownerName不能为空");
////			required(deliveryPerson.getOwnerPhone(), WebConstant.INTERFACE_CODE1, "参数ownerPhone不能为空");
//
////			required(delivery.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");
////			required(delivery.getRegName(), WebConstant.INTERFACE_CODE1, "参数regName不能为空");
////			required(delivery.getOpeId(), WebConstant.INTERFACE_CODE1, "参数opeId不能为空");
////			required(delivery.getOpeCode(), WebConstant.INTERFACE_CODE1, "参数opeCode不能为空");
////			required(delivery.getFoodId(), WebConstant.INTERFACE_CODE1, "参数foodId不能为空");
////			required(delivery.getFoodName(), WebConstant.INTERFACE_CODE1, "参数foodName不能为空");
//
//			delivery.setDeliveryDate(new Date());
//			delivery.setDepartId(user.getDepartId());
//			PublicUtil.setCommonForTable(deliveryPerson, true, user);
//			PublicUtil.setCommonForTable(delivery, true, user);
//
//			String fPath = "";
//			String fName = "";
//			String fileName = "";
//			for(MultipartFile img : deliveryImg) {
//				fPath = "/" + WebConstant.res.getString("deliveryImage");	//文件目录
//				fName = UUIDGenerator.generate()+DyFileUtil.getFileExtension(img.getOriginalFilename());	//文件名
//				fileName = uploadFile(request, fPath, img, fName);	//保存
//
//				if(StringUtil.isNotEmpty(delivery.getPhotos())) {
//					delivery.setPhotos(delivery.getPhotos() + "," + fPath + fName);
//				}else {
//					delivery.setPhotos(fPath + fName);
//				}
//			}
//
////			MultipartFile img = deliveryImg;
////			fPath = WebConstant.res.getString("filePath") + "delivery/";	//文件目录
////			fName = UUIDGenerator.generate()+"."+DyFileUtil.getFileExtension(img.getOriginalFilename());	//文件名
////			fileName = uploadFile(request, fPath, img, fName);	//保存
////
////			if(StringUtil.isNotEmpty(delivery.getPhotos())) {
////				delivery.setPhotos(delivery.getPhotos() + "," + fName);
////			}else {
////				delivery.setPhotos(fName);
////			}
//
//			//保存
//			deliveryService.save(delivery, deliveryPerson);
//
//			aj.setObj(delivery.getId());
//		} catch (MyException e) {
//			e.printStackTrace();
//			setAjaxJson(aj, e.getCode(), e.getText());
//		} catch (Exception e) {
//			e.printStackTrace();
//			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//		}
//
//		return aj;
//	}
//
//	@RequestMapping(value = "/queryDeliveryById")
//	@ResponseBody
//	public InterfaceJson queryDeliveryById(HttpServletRequest request, HttpServletResponse response, String userToken, TbDelivery delivery) {
//		response.addHeader("Access-Control-Allow-Origin", "*");
//
//		InterfaceJson aj = new InterfaceJson();
//		try {
//			//必填验证
//			TSUser user = tokenExpired(userToken);	//token验证
//
//			//根据登记日期获取入场信息
//			DeliveryModel deliveryModel = deliveryService.queryDeliveryById(delivery.getId());
//
//			aj.setObj(deliveryModel);
//
//		} catch (MyException e) {
//			setAjaxJson(aj, e.getCode(), e.getText());
//		} catch (Exception e) {
//			e.printStackTrace();
//			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//		}
//
//		return aj;
//	}
//
//
//}
