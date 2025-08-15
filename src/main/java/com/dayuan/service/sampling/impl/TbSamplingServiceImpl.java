package com.dayuan.service.sampling.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.data.BaseDevicesItem;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.sampling.TbSamplingDetailRecevie;
import com.dayuan.bean.system.TSOperation;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.exception.MyException;
import com.dayuan.mapper.dataCheck.DataCheckRecordingMapper;
import com.dayuan.mapper.sampling.TbSamplingDetailMapper;
import com.dayuan.mapper.sampling.TbSamplingDetailRecevieMapper;
import com.dayuan.mapper.sampling.TbSamplingMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.model.sampling.TbSamplingDetailReport;
import com.dayuan.service.data.BaseDetectItemService;
import com.dayuan.service.data.BaseDevicesItemService;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.service.data.TbFileService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.service.system.TSOperationService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.DyFileUtil;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.api.common.ErrCode;
import com.dayuan3.api.common.MallBookUtil;
import com.dayuan3.api.common.MiniProgramException;
import com.dayuan3.api.vo.pay.PayReqVO;
import com.dayuan3.common.bean.InspectionReportPrice;
import com.dayuan3.common.bean.InspectionUnitUserRequester;
import com.dayuan3.common.bean.TbSamplingRequester;
import com.dayuan3.common.service.InspectionReportPriceService;
import com.dayuan3.common.service.OrderhistoryService;
import com.dayuan3.common.service.TakeSamplingPriceService;
import com.dayuan3.common.service.TbSamplingRequesterService;
import com.dayuan3.common.util.GeneratorOrder;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.common.util.WeChatUtil;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.service.IncomeService;
import com.dayuan3.terminal.service.RequesterUnitService;
import com.trhui.mallbook.domain.common.BaseResponse;
import com.trhui.mallbook.domain.response.hf.HfPaymentOrderResponse;
import lombok.RequiredArgsConstructor;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author Dz
 * @description 针对表【tb_sampling(抽检单表)】的数据库操作Service实现
 * @createDate 2025-06-11 12:43:52
 */
@Service
@RequiredArgsConstructor
public class TbSamplingServiceImpl extends ServiceImpl<TbSamplingMapper, TbSampling>
        implements TbSamplingService {

    private static final Logger log = Logger.getLogger("payLog");

    @Autowired
    private DataCheckRecordingMapper dataCheckRecordingMapper;
    @Autowired
    private TbSamplingDetailMapper samplingDetailMapper;

    @Autowired
    private BaseDevicesItemService baseDevicesItemService;
    @Autowired
    private TbSamplingDetailRecevieMapper recevieMapper;
    @Autowired
    private BaseRegulatoryObjectService regService;
    @Autowired
    private BaseFoodTypeService baseFoodTypeService;
    @Autowired
    private BaseDetectItemService baseDetectItemService;
    @Autowired
    private TSOperationService tSOperationService;
    @Autowired
    private TbFileService fileService;
    @Autowired
    private BaseDetectItemService detectItemService;
    @Autowired
    private OrderhistoryService orderhistoryService;
    @Autowired
    private RequesterUnitService requesterUnitService;
    @Autowired
    private TbSamplingRequesterService samplingRequesterService;
    @Autowired
    private TakeSamplingPriceService takeSamplingPriceService;
    @Autowired
    private InspectionReportPriceService inspectionReportPriceService;
    @Autowired
    private IncomeService incomeService;

    @Value("${resources}")
    private String resources;    //项目资源文件夹
    @Value("${filePath}")
    private String filePath;
    @Value("${opeSignaturePath}")
    private String opeSignaturePath;    //抽样-经营户签名
    @Value("${shoppingReceipt}")
    private String shoppingReceipt;    //抽样-购样小票
    @Value("${reportCodeValidity}")
    private int reportCodeValidity;

    private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public synchronized void insert(TbSampling t) throws Exception {
        this.save(t);
    }

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotal(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
            //			page.setRowOffset(page.getRowOffset());
            //			page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
            //			page.setRowOffset(page.getRowOffset());
            //			page.setRowTail(page.getRowTail());
        }

        List dataList = getBaseMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 根据数据来源查询 最大 单号
     *
     * @param samplingNo
     * @return
     */
    public String queryLastCode(String samplingNo) {
        return getBaseMapper().queryLastCode(samplingNo);
    }

    /**
     * 新增抽检单
     *
     * @param sampling 抽样单
     * @param list     抽样明细
     * @param user     登录用户
     * @param file     经营户签名和购样小票的压缩文件
     * @param
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public TbSampling addSampling(TbSampling sampling, List<TbSamplingDetail> list, TSUser user, MultipartFile file) throws Exception {

        //        if (sampling.getPersonal().shortValue() == 0) {
        //            BaseRegulatoryObject reg = regService.queryById(sampling.getRegId());
        //            if (reg == null || reg.getChecked() == 0 || reg.getDeleteFlag() == 1) {
        //                throw new MyException("监管对象["+sampling.getRegName()+"]已删除或未审核，请更新监管对象数据", "监管对象["+sampling.getRegName()+"]已删除或未审核，请更新监管对象数据", WebConstant.INTERFACE_CODE5);
        //            } else if (!reg.getRegName().equals(sampling.getRegName())) {
        //                throw new MyException("监管对象["+sampling.getRegName()+"]的regId与regName不匹配，请更新监管对象数据", "监管对象["+sampling.getRegName()+"]的regId与regName不匹配，请更新监管对象数据", WebConstant.INTERFACE_CODE2);
        //            }
        //        }
        //
        //        //保存抽样单
        //        sampling.setDepartId(user.getDepartId());
        //        sampling.setPointId(user.getPointId());
        //
        //        sampling.setSamplingUserid(user.getId());
        //        sampling.setSamplingUsername(user.getRealname());

        synchronized (this) {
            this.insert(sampling);
        }
        //获取抽样单号
        sampling = getById(sampling.getId());

        //        String rootPath = WebConstant.res.getString("resources") + WebConstant.res.getString("samplingQr");
        //        DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建
        //        String samplingQrPath = WebConstant.res.getString("samplingQrPath");
        //        sampling.setQrcode(sampling.getSamplingNo() + ".png");
        //        File qrFile = new File(rootPath + sampling.getQrcode());
        //        if (!qrFile.exists()) {
        //            //生成二维码
        //            QrcodeUtil.generateSamplingQrcode(null, sampling.getQrcode(), samplingQrPath + sampling.getSamplingNo(), rootPath);
        //        }

        //抽样单不关联抽检任务  --Dz 20201104
        //        sampling.setTaskId(null);

        int codeNum = 1;//抽样明细编号

        List<TbSamplingDetail> detailList = new ArrayList<TbSamplingDetail>();
        for (TbSamplingDetail detail : list) {
            String[] checkItems = detail.getItemId().split(",");
            String[] checkItemsName = detail.getItemName().split(",");

            for (int j = 0; j < checkItems.length; j++) {
                BaseFoodType f = baseFoodTypeService.getById(detail.getFoodId());
                if (f == null || f.getChecked() == 0 || f.getDeleteFlag() == 1) {
                    throw new MyException("样品[" + detail.getFoodName() + "]已删除或未审核，请更新食品种类数据", "样品[" + detail.getFoodName() + "]已删除或未审核，请更新食品种类数据", WebConstant.INTERFACE_CODE5);
                } else if (!f.getFoodName().equals(detail.getFoodName())) {
                    throw new MyException("样品[" + detail.getFoodName() + "]的foodId与foodName不匹配，请更新食品种类数据", "样品[" + detail.getFoodName() + "]的foodId与foodName不匹配，请更新食品种类数据", WebConstant.INTERFACE_CODE2);
                }

                BaseDetectItem t = baseDetectItemService.getById(checkItems[j]);
                if (t == null || t.getChecked() == 0 || t.getDeleteFlag() == 1) {
                    throw new MyException("检测项目[" + checkItemsName[j] + "]已删除或未审核，请更新检测项目数据", "检测项目[" + checkItemsName[j] + "]已删除或未审核，请更新检测项目数据", WebConstant.INTERFACE_CODE5);
                } else if (t == null || !t.getDetectItemName().equals(checkItemsName[j])) {
                    throw new MyException("检测项目[" + checkItemsName[j] + "]的itemId与itemName不匹配，请更新检测项目数据", "检测项目[" + checkItemsName[j] + "]的itemId与itemName不匹配，请更新检测项目数据", WebConstant.INTERFACE_CODE2);
                }

                TbSamplingDetail tsd = new TbSamplingDetail();
                tsd.setFoodId(detail.getFoodId());
                tsd.setFoodName(detail.getFoodName());
                tsd.setSampleNumber(detail.getSampleNumber());
                //                tsd.setOpeShopName(detail.getOpeShopName());
                tsd.setPurchaseDate(detail.getPurchaseDate());
                tsd.setSupplier(detail.getSupplier());
                tsd.setSupplierPerson(detail.getSupplierPerson());
                tsd.setSupplierPhone(detail.getSupplierPhone());
                tsd.setSupplierAddress(detail.getSupplierAddress());
                tsd.setBatchNumber(detail.getBatchNumber());
                tsd.setPurchaseAmount(detail.getPurchaseAmount());
                tsd.setOrigin(detail.getOrigin());
                tsd.setRemark(detail.getRemark());

                tsd.setSamplingId(sampling.getId());
                tsd.setItemId(checkItems[j]);
                tsd.setItemName(checkItemsName[j]);
                //                tsd.setStatus((short) 0);
                //                tsd.setUpdateDate(new Date());
                //                tsd.setSampleCode(sampling.getSamplingNo() + "-" + codeNum);

                tsd.setSampleTubeCode(detail.getSampleTubeCode());

                tsd.setParam3(detail.getParam3());

                codeNum++;

                boolean allocation = true;    //分配仪器检测任务
                List<TSOperation> btnList = tSOperationService.queryAllPrivilegs(user.getRoleId());
                for (TSOperation operation : btnList) {
                    if ("321-13".equals(operation.getOperationCode())) {    //禁止检测分配
                        allocation = false;
                        break;
                    }
                }

                //1.根据检测项目和用户权限查询所有可分配的仪器
                List<BaseDevicesItem> rels = null;
                if (allocation) {
                    rels = baseDevicesItemService.queryDeviceByDetectName(sampling.getPointId(), checkItems[j]);
                }

                if (rels != null && rels.size() > 0) {
                    // 2.设置明细表 接收仪器recevieDevice为优先级第一的仪器
                    tsd.setRecevieDevice(rels.get(0).getSerialNumber());
                    //                    samplingDetailService.save(tsd);
                    samplingDetailMapper.insert(tsd);

                    // 3.将明细发给所有的仪器，并设置优先级
                    for (int i = 0; i < rels.size(); i++) {
                        TbSamplingDetailRecevie recevie = new TbSamplingDetailRecevie();
                        recevie.setSdId(tsd.getId());
                        recevie.setRecevieSerialNumber(rels.get(i).getSerialNumber());
                        recevie.setPriority((short) (rels.size() - i));
                        recevieMapper.insert(recevie);
                    }
                } else {
                    //                    samplingDetailService.save(tsd);
                    samplingDetailMapper.insert(tsd);
                }

                detailList.add(tsd);
            }
        }

        if (file != null) {    //旧版接口，上传经营户签名
            if (!".zip.gz".contains(DyFileUtil.getFileExtension(file.getOriginalFilename()))) {
                //                String fileName = sampling.getSamplingNo() + DyFileUtil.getFileExtension(file.getOriginalFilename());
                //                String path = resources + opeSignaturePath;
                //                FileOutputStream fos = null;
                //                fos = FileUtils.openOutputStream(new File(path + fileName));
                //                IOUtils.copy(file.getInputStream(), fos);
                //                fos.close();
                //                sampling.setOpeSignature(fileName);

            } else {    //新版接口，上传购样小票、经营户签名压缩文件
                //解压
                //                String ucp = resources + opeSignaturePath + "temp/" + sampling.getSamplingNo() + "/";    //临时文件
                //                ZipUtils.uncompress(file.getInputStream(), ucp);

                //保存购样小票、经营户签名
                //                File[] fs = new File(ucp).listFiles();
                //                for (File f : fs) {
                //                    if (f.getName().contains("receipt_")) {    //购样小票
                //                        String fName = UUIDGenerator.generate() + DyFileUtil.getFileExtension(f);
                //                        String fPath = filePath + shoppingReceipt + fName;
                //                        DyFileUtil.saveFile(f, resources + fPath);
                //
                //                        TbFile tbFile = new TbFile();
                //                        tbFile.setSourceId(sampling.getId());
                //                        tbFile.setSourceType("shoppingRec");
                //                        tbFile.setFileName(fName);
                //                        tbFile.setFilePath(fPath);
                //                        tbFile.setSorting((short) 0);
                //                        tbFile.setDeleteFlag((short) 0);
                //                        PublicUtil.setCommonForTable(tbFile, true, user);
                //                        fileService.insert(tbFile);
                //
                //                    } else if (f.getName().contains("sign_")) {    //经营户签名
                //
                ////                        String fName = sampling.getSamplingNo() + DyFileUtil.getFileExtension(f);
                ////                        String fPath = opeSignaturePath + fName;
                ////                        DyFileUtil.saveFile(f, resources + fPath);
                ////                        sampling.setOpeSignature(fName);
                //                    }
                //                }

                //删除临时文件
                //                DyFileUtil.deleteFolder(ucp);
            }
        }

        PublicUtil.setCommonForTable(sampling, true, user);
        updateById(sampling);

        //更新已抽样入场登记样品
        //        deliveryService.updateSamplingId(sampling, detailList);

        return sampling;
    }

    //抽样单不关联抽检任务  --Dz 20201104
    //    /**
    //     * 抽样明细匹配检测任务明细方法
    //     *
    //     * @param taskDetails
    //     * @param detail
    //     * @return
    //     */
    //    private String getTaskDetailId(List<TbTaskDetail> taskDetails, TbSamplingDetail detail) {
    //        String taskDetailID = "";
    //        if (taskDetails != null && taskDetails.size() > 0) {
    //            for (TbTaskDetail tbTaskDetail : taskDetails) {
    //                if (tbTaskDetail.getItem() == null || "".equals(tbTaskDetail.getItem().trim()) || tbTaskDetail.getItem().contains(detail.getItemName())) {
    //
    //                    //1.如果检测项目相同，进一步匹配样品
    //                    List<Integer> childFoodIds = baseFoodTypeService.querySonFoods(Integer.parseInt(tbTaskDetail.getSampleId()));
    //                    if (childFoodIds != null && childFoodIds.contains(detail.getFoodId())) {
    //                        //2.检测样品相同或是其子类，则返回任务明细ID
    //                        taskDetailID = tbTaskDetail.getId().toString();
    //                        break;
    //                    }
    //
    //                }
    //            }
    //        }
    //        return taskDetailID;
    //    }

    //    /**
    //     * 根据用户权限和时间下载抽样单信息
    //     *
    //     * @param param
    //     * @return
    //     * @author xyl 2017-09-14
    //     */
    //    public List<TbSampling> queryByPid(Map<String, Object> param) {
    //        return getBaseMapper().queryByPid(param);
    //    }

    /**
     * 订单(微信)
     *
     * @param sampling 抽样单
     * @param list     抽样明细
     * @param user     登录用户
     * @param file     经营户签名和购样小票的压缩文件
     * @param
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public TbSampling addSampling2(TbSampling sampling, List<TbSamplingDetail> list, TSUser user, InspectionUnitUser uintUser, MultipartFile file, List<TbSamplingRequester> reqList) throws Exception {
        //        short personal = sampling.getPersonal();
        Date start = new Date();
        //System.out.println("微信下单方法开始---"+DateUtil.formatDate(start, "yyyy-MM-dd HH:mm:ss"));
        if (sampling.getId() != null) {//编辑
            //1.查看订单是否存在
            TbSampling bean = getById(sampling.getId());
            if (bean != null) {//订单存在

                //2.更新订单详情 扫描袋
                /*for (TbSamplingDetail detail : list) {
                    if(detail.getId()!=null){//已存在
					TbSamplingDetailCode  code=		samplingDetailCodeService.queryBySamplingDetailId(detail.getId());
					code.setBagCode(detail.getSampleTubeCode());//补录code
					samplingDetailCodeService.updateById(code);
					samplingDetailService.updateByPrimaryKeySelective(detail);
					}else{//目前不允许新增

					}

				}*/
                //3.更新订单状态
                bean.setOrderStatus(sampling.getOrderStatus());
                Date now = new Date();
                //                bean.setSamplingDate(now);
                bean.setUpdateDate(now);
                updateById(bean);

            } else {
                throw new MyException("操作失败，订单不存在!");
            }

            return sampling;

        } else {//新增
            RequesterUnit requesterUnit = null;
            //非一单多用下的特殊情况，下单时regId为空的处理，根据名字自查委托单位ID shit
            //            if (reqList == null && sampling.getRegId() == null && StringUtil.isNotEmpty(sampling.getRegName())) {
            //                //根据委托单位名称去查询校验其唯一性
            //                requesterUnit = requesterUnitService.selectByName(sampling.getRegName(), null);
            //                sampling.setRegId(requesterUnit.getId());
            //                sampling.setRegLinkPhone(requesterUnit.getLinkPhone());
            //                sampling.setTakeSamplingAddress(requesterUnit.getCompanyAddress());
            //
            //            }
            //            if (personal == 2) {
            //                //订单生成十分严格 找不到用户 直接退出返回空
            ////                if (uintUser == null || uintUser.getId() == null) {
            ////                    throw new MyException("下单失败，请重新登录。");
            ////                }
            //
            //            } else {
            //                throw new Exception("这方法只生成订单");
            //            }
            //            Date now = new Date();
            //            sampling.setCreateBy(uintUser.getId().toString());
            //            sampling.setCreateDate(now);
            //            sampling.setSamplingUserid(uintUser.getId().toString());
            //            sampling.setSamplingUsername(uintUser.getRealName());
            //            sampling.setParam3(uintUser.getPhone());
            //            if (uintUser.getUserType() == 0 || uintUser.getInspectionId() == null) {
            //                String companyName = StringUtil.isEmpty(uintUser.getRealName()) ? uintUser.getPhone() : uintUser.getRealName();
            //                sampling.setInspectionCompany(companyName);
            //            } else {
            //                sampling.setInspectionId(uintUser.getInspectionId());
            //                sampling.setInspectionCompany(uintUser.getCompanyName());
            //            }
            start = new Date();
            //System.out.println("微信下单方法开始---"+DateUtil.formatDate(start, "yyyy-MM-dd HH:mm:ss"));
            this.insert(sampling);
            //写入订单与委托单位关联表
            if (reqList == null) {
                //                TbSamplingRequester bean = new TbSamplingRequester(sampling.getId(), sampling.getRegId(), sampling.getRegName(), sampling.getCreateBy(), sampling.getCreateDate(), sampling.getUpdateBy(), sampling.getUpdateDate(), sampling.getRegLinkPhone(), sampling.getTakeSamplingAddress());
                //                if (requesterUnit != null) {
                //                    bean.setParam3("异常订单");
                //                }
                //                samplingRequesterService.insertSelective(bean);
            } else {
                for (TbSamplingRequester req : reqList) {
                    req.setSamplingId(sampling.getId());
                    req.setCreateBy(sampling.getCreateBy());
                    req.setCreateDate(sampling.getCreateDate());
                    req.setUpdateBy(sampling.getCreateBy());
                    req.setUpdateDate(sampling.getCreateDate());
                    samplingRequesterService.insertSelective(req);
                }
            }
            //System.out.println("2-1  生成抽样单:"+DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")+"响应时长："+(new Date().getTime()-start.getTime()));
            //获取订单单号
            sampling = getById(sampling.getId());


            //2019-11-19 因为订单是不需要二维码的  因为要提高并发效率 现关闭生成二维码 huht
/*	String rootPath=WebConstant.res.getString("resources")+WebConstant.res.getString("samplingQr");
		DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建
		String samplingQrPath=WebConstant.res.getString("samplingQrPath");
		sampling.setQrcode(sampling.getSamplingNo()+".png");
		File qrFile =new File(rootPath+sampling.getQrcode());
		if(!qrFile.exists()){
			//生成二维码
			QrcodeUtil.generateSamplingQrcode(null, sampling.getQrcode(), samplingQrPath + sampling.getSamplingNo(), rootPath);
		}*/
            //System.out.println("  生成二维码:"+DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")+"响应时长："+(new Date().getTime()-start.getTime()));
            int codeNum = 1;//抽样明细编号
            double inspectionFee = 0.0;    //检测费用
            List<Integer> foodIds = new ArrayList<>();
            List<String> suppliers = new ArrayList<>();
            List<Integer> supplierIds = new ArrayList<>();
            List<String> opes = new ArrayList<>();
            for (TbSamplingDetail detail : list) {
                foodIds.add(detail.getFoodId());//添加样品id
                suppliers.add(detail.getSupplier());
                //                supplierIds.add(detail.getSupplierId());
                //                opes.add(detail.getOpeShopName());
                //                detail.setSamplingId(sampling.getId());
                //                detail.setStatus((short) 0);
                //                detail.setUpdateDate(new Date());
                //                detail.setSampleCode(sampling.getSamplingNo() + "-" + codeNum);
                //
                //                BaseDetectItem item = detectItemService.queryById(detail.getItemId());
                //                if (item == null) {
                //                    throw new Exception("找不到检测项目，ID:" + detail.getItemId());
                //                }
                //                detail.setInspectionFee(item.getPrice() * item.getDiscount());//检测费用
                //                inspectionFee += detail.getInspectionFee();
                //                samplingDetailService.save(detail);
                //                codeNum++;
/*
			TbSamplingDetailCode samplingDetailCode = new TbSamplingDetailCode();
			samplingDetailCode.setSamplingDetailId(detail.getId());
			samplingDetailCode.setBagCode(detail.getSampleTubeCode());
			samplingDetailCodeService.insert(samplingDetailCode);*/

            }
            //System.out.println("2-2  保存抽样详情:"+DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")+"响应时长："+(new Date().getTime()-start.getTime()));
            //保存 委托单位、样品历史
            //            orderhistoryService.saveOrderhistory2(sampling.getRegId(), foodIds, uintUser.getId());
            //System.out.println("2-3  保存委托单位历史:"+DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")+"响应时长："+(new Date().getTime()-start.getTime()));
            //orderObjhistoryService.saveOrderhistory3(supplierIds,suppliers, opes, uintUser.getId());
            //System.out.println("2-4  保存来源历史:"+DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")+"响应时长："+(new Date().getTime()-start.getTime()));

            //订单
	/*	if(inspectionFee!=sampling.getInspectionFee()){ //处理检测项目金额和实际不符 现在有了报告费用，所以关闭此方法 2020/1/9
			sampling.setInspectionFee(inspectionFee);
			sampling.setUpdateBy(uintUser.getId().toString());
			sampling.setUpdateDate(now);
			updateBySelective(sampling);
		}*/
            //System.out.println("2-5  更新订单内容:"+DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")+"响应时长："+(new Date().getTime()-start.getTime()));

            //System.out.println("微信下单方法结束---"+DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
            return sampling;
        }
    }

    /**
     * 新增订单(自助终端)
     *
     * @param sampling 抽样单
     * @param list     抽样明细
     * @param
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public TbSampling addSampling3(TbSampling sampling, List<TbSamplingDetail> list, InspectionUnitUser uintUser,
                                   List<InspectionUnitUserRequester> requestLists) throws Exception {
        Date now = new Date();    //创建日期
        short personal = 1;
        //        short personal = sampling.getPersonal();
        if (personal == 2) {
            //            if (uintUser == null || uintUser.getId() == null) {
            //                throw new MyException("下单失败，请重新登录。");
            //            }

            //样品码重复
		/*	Set<String> repeatCodes = new HashSet<String>();
			for (TbSamplingDetail detail : list) {
				List<TbSamplingDetailCode> tsdc = samplingDetailCodeService.queryByBagCode(detail.getSampleTubeCode());
				if (tsdc!=null && tsdc.size()>0){
					repeatCodes.add(detail.getSampleTubeCode());
				}
			}
			if(repeatCodes.size()>0){
				StringBuffer strBuffer = new StringBuffer();
				for (String repeatCode : repeatCodes){
					strBuffer.append(repeatCode+"|");
				}
				strBuffer.deleteCharAt(strBuffer.length()-1);
				throw new MyException("下单失败，样品码["+strBuffer.toString()+"]异常，请更换样品袋后再结算。");
			}*/

			/*//生成取报告码
			int i=1;
			TbSampling tb = null;
			do{
				String reportCode = RandomStringUtils.random(6,true,true).toUpperCase();

				if(!this.isRepeat(reportCode)) {
					sampling.setReportCode(reportCode);
				}else if(i==10){
					throw new Exception("生成报告码失败");
				}

				i++;
			}while (tb != null);*/
        } else {
            throw new Exception("这方法只生成订单");
        }
        //        sampling.setCreateBy(uintUser.getId().toString());
        //        sampling.setCreateDate(now);
        //        sampling.setUpdateBy(uintUser.getId().toString());
        //        sampling.setUpdateDate(now);
        this.insert(sampling);
        //写入订单与委托单位关联表
        List<TbSamplingRequester> sampleRequestList = null;
        TbSamplingRequester bean = null;
        if (requestLists != null) {//供应商用户批量写入
            sampleRequestList = new ArrayList<TbSamplingRequester>();
            for (InspectionUnitUserRequester request : requestLists) {
                bean = new TbSamplingRequester(sampling.getId(), request.getRequestId(), request.getRequestName(), sampling.getCreateBy(), sampling.getCreateDate(), sampling.getUpdateBy(), sampling.getUpdateDate(), request.getParam1(), request.getParam2());
                sampleRequestList.add(bean);
            }
            if (sampleRequestList.size() > 0) {
                samplingRequesterService.saveBatch(sampleRequestList);
            }
        } else {
            //            bean = new TbSamplingRequester(sampling.getId(), sampling.getRegId(), sampling.getRegName(), sampling.getCreateBy(), sampling.getCreateDate(), sampling.getUpdateBy(), sampling.getUpdateDate(), sampling.getRegLinkPhone(), sampling.getTakeSamplingAddress());
            samplingRequesterService.insertSelective(bean);
        }

        //获取订单单号
        sampling = getById(sampling.getId());

        //2019-11-19 因为订单是不需要二维码的  因为要提高并发效率 现关闭生成二维码 huht
		/*String rootPath=WebConstant.res.getString("resources")+WebConstant.res.getString("samplingQr");
		DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建
		String samplingQrPath=WebConstant.res.getString("samplingQrPath");
		sampling.setQrcode(sampling.getSamplingNo()+".png");
		File qrFile =new File(rootPath+sampling.getQrcode());
		if(!qrFile.exists()){
			//生成二维码
			QrcodeUtil.generateSamplingQrcode(null, sampling.getQrcode(), samplingQrPath + sampling.getSamplingNo(), rootPath);
		}*/

        int codeNum = 1;//抽样明细编号
        double inspectionFee = 0.0;    //检测费用
        List<TbSamplingDetail> detailList = new ArrayList<TbSamplingDetail>();
        //add by xiaoyuling 2019-07-23 保存样品、委托单位、来源等历史纪录
        List<Integer> foodIds = new ArrayList<>();
        List<String> suppliers = new ArrayList<>();
        List<Integer> supplierIds = new ArrayList<>();
        List<String> opes = new ArrayList<>();
        for (TbSamplingDetail detail : list) {
            //            foodIds.add(detail.getFoodId());//添加样品id
            //            suppliers.add(detail.getSupplier());
            //            supplierIds.add(detail.getSupplierId());
            //            opes.add(detail.getOpeShopName());
            //
            //            detail.setSamplingId(sampling.getId());
            //            detail.setStatus((short) 0);
            //            detail.setUpdateDate(new Date());
            //            detail.setSampleCode(sampling.getSamplingNo() + "-" + codeNum);
            //delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
            /*detail.setSampleTubeCode(detail.getSampleTubeCode());*/

            BaseDetectItem item = detectItemService.getById(detail.getItemId());
            if (item != null) {
                inspectionFee += detail.getInspectionFee();
            } else {
                throw new Exception("找不到检测项目，ID:" + detail.getItemId());
            }
            //            samplingDetailService.save(detail);
            samplingDetailMapper.insert(detail);
            codeNum++;
			/*delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
			TbSamplingDetailCode samplingDetailCode = new TbSamplingDetailCode();
			samplingDetailCode.setSamplingDetailId(detail.getId());
			samplingDetailCode.setBagCode(detail.getSampleTubeCode());
			samplingDetailCode.setCreateDate(now);
			samplingDetailCode.setUpdateDate(now);
			samplingDetailCodeService.insert(samplingDetailCode);*/

            //			String [] checkItems=detail.getItemId().split(",");
            //			String [] checkItemsName=detail.getItemName().split(",");
            //			for (int j = 0; j < checkItems.length; j++) {
            //				TbSamplingDetail tsd = new TbSamplingDetail();
            //				BeanUtils.copyProperties(detail, tsd);
            //
            //				tsd.setSamplingId(sampling.getId());
            //				tsd.setItemId(checkItems[j]);
            //				tsd.setItemName(checkItemsName[j]);
            //				tsd.setStatus((short) 0);
            //				tsd.setUpdateDate(new Date());
            //				tsd.setSampleCode(sampling.getSamplingNo()+"-"+codeNum);
            //				tsd.setSampleTubeCode(detail.getSampleTubeCode());
            //				tsd.setInspectionFee(detail.getInspectionFee());//检测费用
            //
            //				codeNum++;
            //
            //				samplingDetailService.save(tsd);
            //
            //				TbSamplingDetailCode samplingDetailCode = new TbSamplingDetailCode();
            //				samplingDetailCode.setSamplingDetailId(tsd.getId());
            //				samplingDetailCode.setBagCode(tsd.getSampleTubeCode());
            //				samplingDetailCodeService.insert(samplingDetailCode);
            //			}

        }
        //保存 委托单位、样品历史
        //        orderhistoryService.saveOrderhistory2(sampling.getRegId(), foodIds, uintUser.getId());
        //orderObjhistoryService.saveOrderhistory3(supplierIds,suppliers, opes, uintUser.getId());
        //订单 delete by xiaoyl 2019-11-21 高并发导致死锁问题
		/*sampling.setInspectionFee(inspectionFee);
		sampling.setCreateBy(uintUser.getId().toString());
		sampling.setCreateDate(now);
		sampling.setUpdateBy(uintUser.getId().toString());
		sampling.setUpdateDate(now);
		updateBySelective(sampling);*/

        return sampling;
    }

    /**
     * 根据抽样单号查询抽样信息
     *
     * @param samplingNo 抽样单号
     * @return
     * @author xyl 2017-09-20
     */
    public TbSampling queryBySamplingNo(String samplingNo) {
        return getBaseMapper().queryBySamplingNo(samplingNo);
    }

    /**
     * 分页查询订单信息
     */
    public Page loadDatagrid2(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
            page.setRowTotal(getBaseMapper().getRowTotal2(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常s
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
            //			page.setRowOffset(page.getRowOffset());
            //			page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
            //			page.setRowOffset(page.getRowOffset());
            //			page.setRowTail(page.getRowTail());
        }

        List<TbSampling> dataList = getBaseMapper().loadDatagrid2(page);
        page.setResults(dataList);
        return page;
    }


    /**
     * 重新分配检测任务接收设备
     *
     * @param list 抽样明细
     * @throws MissSessionExceprtion
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public int updateReceviesStatus(List<TbSamplingDetail> list) throws Exception {
        TbSamplingDetailRecevie recevie = null;
        int count = 1; //返回下发状态
        int allCount = list.size();//分配任务数量
        int success = 0;//下发成功数量
        int failure = 0;//下发失败数量
        int noDevice = 0;//没有接收仪器任务数量
        for (TbSamplingDetail detail : list) {
            TbSampling sampling = getById(detail.getSamplingId());
            List<BaseDevicesItem> rels = baseDevicesItemService.queryDeviceByDetectName(sampling.getPointId(), detail.getItemId());    //根据检测项目和用户权限查询所有可分配的仪器
            List<TbSamplingDetailRecevie> sdrs = recevieMapper.queryBySdId(detail.getId());    //根据抽样明细ID，获取已分配检测任务
            if (sdrs.size() == 0) {    //首次下发检测任务
                if (rels.size() > 0) {
                    // 1.设置明细表 接收仪器recevieDevice为优先级第一的仪器
                    detail.setRecevieDevice(rels.get(0).getSerialNumber());
                    //                    samplingDetailService.updateById(detail);
                    samplingDetailMapper.updateById(detail);
                    // 2.将明细发给所有的仪器，并设置优先级
                    for (BaseDevicesItem rel : rels) {
                        recevie = new TbSamplingDetailRecevie();
                        recevie.setSdId(detail.getId());
                        recevie.setRecevieSerialNumber(rel.getSerialNumber());
                        recevie.setPriority(rel.getPriority());
                        PublicUtil.setCommonForTable(recevie, true);
                        recevieMapper.insert(recevie);
                    }

                    success++;
                } else {
                    noDevice++;
                }

            } else {    //重发检测任务

                //判断检测点是否删减了仪器;有,则删除该仪器检测任务
                Iterator ite1 = sdrs.iterator();
                TbSamplingDetailRecevie sdr = null;
                while (ite1.hasNext()) {//遍历已分配检测任务
                    sdr = (TbSamplingDetailRecevie) ite1.next();

                    for (int i = 0; i < rels.size(); i++) {    //遍历可分配仪器
                        if (sdr.getRecevieSerialNumber().equals(rels.get(i).getSerialNumber())) {    //已分配检测任务中存在该检测仪器，不需删除该检测任务
                            break;
                        }
                        if (i == rels.size() - 1) {    //该仪器不存在，删除检测任务
                            ite1.remove();
                            recevieMapper.deleteByPrimaryKey(sdr.getId());
                        }
                    }
                }

                //判断检测点是否新增了仪器;有,则新增该仪器检测任务
                Iterator ite2 = rels.iterator();
                BaseDevicesItem bdi = null;
                while (ite2.hasNext()) {//遍历可分配仪器
                    bdi = (BaseDevicesItem) ite2.next();

                    for (int i = 0; i < sdrs.size(); i++) {    //遍历已分配检测任务
                        if (bdi.getSerialNumber().equals(sdrs.get(i).getRecevieSerialNumber())) {    //已分配检测任务中存在该检测仪器，不需新增该检测任务
                            break;
                        }
                        if (i == sdrs.size() - 1) {    //该仪器不存在，新增检测任务
                            recevie = new TbSamplingDetailRecevie();
                            recevie.setSdId(detail.getId());
                            recevie.setRecevieSerialNumber(bdi.getSerialNumber());
                            recevie.setPriority(bdi.getPriority());
                            PublicUtil.setCommonForTable(recevie, true);
                            recevieMapper.insert(recevie);

                            sdrs.add(recevie);
                        }
                    }
                }

                //重发检测任务
                //                TbSamplingDetail tsd = samplingDetailService.getById(detail.getId()); //抽样明细
                TbSamplingDetail tsd = samplingDetailMapper.selectById(detail.getId()); //抽样明细
                if (tsd != null) {
                    if (sdrs.size() == 0) {//无仪器可接收任务
                        //清空接收仪器唯一编码
                        //                        tsd.setStatus((short) 0);
                        tsd.setRecevieDevice(null);
                        //                        samplingDetailService.updateById(tsd);
                        samplingDetailMapper.updateById(tsd);

                        noDevice++;

                    } else if (sdrs.size() == 1) {//重发到当前仪器
                        success++;

                    } else {    //重发到下一台仪器
                        int notReceivedNum = 0; //未接收仪器数量
                        for (TbSamplingDetailRecevie sdr1 : sdrs) {
                            //设置当前待接收仪器的任务状态为拒绝
                            if (sdr1.getRecevieSerialNumber().equals(tsd.getRecevieDevice())) {
                                sdr1.setRecevieStatus((short) 2);
                                PublicUtil.setCommonForTable(sdr1, false);
                                recevieMapper.updateByRejectStatus(sdr1);
                            }
                            //计算未接收仪器数量
                            if (sdr1.getRecevieStatus() == 0) {
                                notReceivedNum++;
                            }
                        }

                        //判断是否所有仪器拒绝任务，是则开始新一轮下发检测任务，否则重发到下一台仪器
                        if (notReceivedNum == 0) {
                            //所有仪器拒绝任务，重置所有仪器任务状态为未接收
                            recevieMapper.updateResetRecevieStatusBySdId(tsd.getId());
                        }

                        //获取下一条仪器任务
                        TbSamplingDetailRecevie tsdr = recevieMapper.queryNextDeviceBySdid(tsd.getId());

                        //更新任务明细接收仪器唯一编码
                        //                        tsd.setStatus((short) 0);
                        tsd.setRecevieDevice(tsdr.getRecevieSerialNumber());
                        PublicUtil.setCommonForTable(tsd, false);
                        //                        samplingDetailService.updateById(tsd);
                        samplingDetailMapper.updateById(tsd);

                        success++;
                    }

                } else {
                    //重发任务失败
                    failure++;
                }

            }
        }

        if (allCount == success) {
            count = 1;    //成功
        } else if (allCount == noDevice) {
            count = 0;    //无仪器
        } else if (allCount == failure) {
            count = -1;    //失败
        } else if (success > 0) {
            count = 2;    //部分成功
        } else if (noDevice > 0) {
            count = 0;    //无仪器
        } else {
            count = -1;    //失败
        }

        return count;
    }


    /**
     * 保存抽样单的视频文件地址
     *
     * @param samplingId
     * @param filePath
     * @author LuoYX
     * @date 2018年8月21日
     */
    public void updateSamplingVideoPath(Integer samplingId, String filePath) {
        getBaseMapper().updateSamplingVideoPath(samplingId, filePath);
    }

    /**
     * 根据APP抽样单ID查询抽样信息
     *
     * @param param2 APP抽样单ID
     * @return
     */
    public TbSampling queryByParam2(String param2) {
        return getBaseMapper().queryByParam2(param2);
    }

    /**
     * 根据送检单位用户查询订单信息
     *
     * @param userIds
     * @param createDate          订单创建时间
     * @param orderType           排序方式： 0 下单时间，1收样时间
     * @param status              订单状态0_暂存,1_待支付,2_完成,3_取消
     * @param rowStart，rowEnd分页参数
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月3日
     */
    public List<TbSampling> queryByInspectionUnit(Integer userIds, String createDate, Integer orderType, Integer status, Integer rowStart, Integer rowEnd, String satrtTime, String endTime) {
        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
        return getBaseMapper().queryByInspectionUnit(userIds, createDate, orderType, status, rowStart, rowEnd, satrtTime, endTime, recheckNumber);
    }

    /**
     * 查询订单总数
     *
     * @param userIds
     * @param createDate 下单时间
     * @param orderType  排序方式： 0 下单时间，1收样时间
     * @param status
     * @return
     */
    public int queryByInspectionUnitCount(Integer userIds, String createDate, Integer orderType, Integer status) {
        return getBaseMapper().queryByInspectionUnitCount(userIds, createDate, orderType, status);
    }

    /**
     * 微信端开发票查询已支付订单
     *
     * @param userId   送检用户id
     * @param start    开始时间
     * @param end      结束时间
     * @param rowStart 开始条数
     * @param rowEnd   结束条数
     * @return
     */
    public List<TbSampling> queryByInspectionUnit2(Integer userId, String start, String end, Integer rowStart, Integer rowEnd) {
        return getBaseMapper().queryByInspectionUnit2(userId, start, end, rowStart, rowEnd);
    }


    /**
     * 根据订单ID和送检单位ID查询订单相关信息
     *
     * @param samplingId
     * @param inspectionId
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月9日
     */
    public TbSampling queryByIdAndInspection(Integer samplingId, Integer inspectionId) {
        return getBaseMapper().queryByIdAndInspection(samplingId, inspectionId);
    }

    /**
     * 修改订单状态
     *
     * @param orderStatus
     * @param id
     */
    public void updateSamplingStatus(short orderStatus, Integer id) throws Exception {
        getBaseMapper().updateSamplingStatus(orderStatus, id);
    }

    //	/**
    //	 * 查询分页数据列表(订单)
    //	 * @param page
    //	 * @return
    //	 */
    //	public List<TbSampling> loadDatagridOrder(Page page){
    //		return getBaseMapper().loadDatagridOrder(page);
    //	}
    //
    //	/**
    //	 * 查询记录总数量(订单)
    //	 * @param page
    //	 * @return
    //	 */
    //	public int getRowTotalOrder(Page page){
    //		return getBaseMapper().getRowTotalOrder(page);
    //	}

    /**
     * 根据抽样单号查询送检订单信息
     *
     * @param samplingId
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月27日
     */
    public TbSampling queryBySamplingId(Integer samplingId) {
        return getBaseMapper().queryBySamplingId(samplingId);
    }

    /**
     * 根据订单号查看收费纪录
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年8月1日
     */
    public List<TbSampling> loadDatagridForIncome(Page page) {
        List<TbSampling> list = getBaseMapper().loadDatagridForIncome(page);
        if (list != null && list.size() > 0) {
            for (TbSampling bean : list) {
                //                double d = bean.getInspectionFee() + bean.getPrintingFee();
                //                bean.setTotalFee(d);
            }
        }
        return list;
    }

    /**
     * 根据订单号查看收费总数量
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年8月1日
     */
    public int getRowTotalForIncome(Page page) {
        return getBaseMapper().getRowTotalForIncome(page);
    }

    /**
     * 根据送检人手机号查询已支付订单信息
     *
     * @param phone     送检人手机号
     * @param startTime 下单时间查询范围-开始时间
     * @param endTime   下单时间查询范围-结束时间
     * @return
     */
    public List<TbSampling> queryByPhone(String phone, String startTime, String endTime) {
        return getBaseMapper().queryByPhone(phone, startTime, endTime);
    }

    /**
     * 定时取消超时订单
     * 2019-8-30 huht
     *
     * @param samplingDate
     */
    public void UpdateByOrderStatus(Date samplingDate) {
        getBaseMapper().UpdateByOrderStatus(samplingDate);
    }

    /**
     * 根据订单ID查询订单信息(查询出订单关联的多个委托单位ID)
     *
     * @param id
     * @return
     * @author shit
     */
    public TbSampling selectById(Integer id) {
        return getBaseMapper().selectById(id);
    }


    /**
     * 根据委托单位ID和抽样单ID查询报告信息
     *
     * @param requestId  委托单位ID
     * @param samplingId 抽样单ID
     * @return
     */
    public TbSampling selectByReqestId(Integer requestId, Integer samplingId) {
        return getBaseMapper().selectByReqestId(requestId, samplingId);
    }

    /**
     * 根据状态查询取样数据
     *
     * @param status   是否取样:0 待接收，1 待取样，2  已取样
     * @param pageNo
     * @param pageSize
     * @return
     * @author shit
     */
    public List<TbSampling> querySampingList(Integer status, int pageNo, int pageSize, Integer userId) {
        return getBaseMapper().querySampingList(status, pageNo, pageSize, userId);
    }

    /**
     * 更改订单的取样状态
     *
     * @param tbSampling
     * @author shit
     */
    public int updateTask(TbSampling tbSampling) {
        return getBaseMapper().updateTask(tbSampling);
    }

    /**
     * 查询取样的个数
     *
     * @param userId
     * @author shit
     */
    public Map<String, Object> selectTakeNums(Integer userId) {
        return getBaseMapper().selectTakeNums(userId);
    }

    /**
     * 清空之前的报告费订单主表的printing_fee字段
     *
     * @param samplingId
     * @author shit
     */
    public void emptyPrintingFee(Integer samplingId) {
        getBaseMapper().emptyPrintingFee(samplingId);
    }

    /**
     * 查询时间范围内的订单总金额
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年3月13日
     */
    public double queryTotalMoney(Page page) {
        return getBaseMapper().queryTotalMoney(page);
    }


    public double queryTotalMoney2(Page page) {
        return getBaseMapper().queryTotalMoney2(page);
    }

    /**
     * 查询超时待支付订单
     *
     * @param d
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年3月20日
     */
    public List<TbSampling> queryAllTimeOutOrder(Date d) {
        return getBaseMapper().queryAllTimeOutOrder(d);
    }


    /**
     * @return
     * @Description 读取检测项目json文件
     * @Date 2020/09/23 13:28
     * @Author xiaoyl
     * @Param 基础数据
     */
    public List<TbSamplingDetailReport> readItemGroupFile(HttpServletRequest request, List<TbSamplingDetailReport> samplingDetailList) {
        List<TbSamplingDetailReport> samplingDetailList2 = new ArrayList<>();
        //读取JSON文件
        String dir = request.getSession().getServletContext().getRealPath("/js/json/itemGroup.json");
        try {
            File file = new File(dir);
            if (file.exists()) {
                String str = FileUtils.readFileToString(file, "UTF-8");
                net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(str);
                if (samplingDetailList != null && samplingDetailList.size() > 0) {
                    for (TbSamplingDetailReport bean : samplingDetailList) {
                        JSONObject obj = null;
                        boolean isNormal = true;//是否普通检测项目
                        for (int i = 0; i < jsonArray.length(); i++) {
                            obj = jsonArray.getJSONObject(i);
                            if (bean.getItemName().equals(obj.getString("itemGroupName"))) {//检测项目名称匹配
                                isNormal = false;//自定义检测项目
                                net.sf.json.JSONArray childList = net.sf.json.JSONArray.fromObject(obj.get("itemList"));
                                for (int j = 0; j < childList.length(); j++) {//添加自定义的检测项目
                                    TbSamplingDetailReport bean2 = new TbSamplingDetailReport();
                                    BeanUtils.copyProperties(bean, bean2);
                                    bean2.setItemName(childList.getJSONObject(j).getString("item"));
                                    bean2.setIsCustomItem(1);//自定义检测项目
                                    bean2.setItemNumber(childList.length());
                                    samplingDetailList2.add(bean2);
                                }
                            }
                        }
                        if (isNormal) {
                            samplingDetailList2.add(bean);
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("异常日志：" + e.getMessage());
            return samplingDetailList2;
        }
        return samplingDetailList2;
    }

    /**
     * @return
     * @Description 批量复核检测报告
     * @Date 2020/10/29 16:43
     * @Author xiaoyl
     * @Param idas 抽样单/送检单ID
     * @Param reviewName 复核人员签名/姓名
     * @Param approvalSignature 复核人员签名/姓名
     * @Param idas 抽样单/送检单ID
     */
    public int reviewSamplingBatch(Integer[] idas, String reviewName, String approvalSignature, String userId) {
        return getBaseMapper().reviewSamplingBatch(idas, reviewName, approvalSignature, userId);
    }

    /**
     * 新增订单
     *
     * @param sampling 订单
     * @param details  订单明细
     * @param reqUnits 委托单位
     * @param user     送检人
     * @param
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public TbSampling addOrder(TbSampling sampling, List<TbSamplingDetail> details, List<TbSamplingRequester> reqUnits, InspectionUnitUser user) throws Exception {
        //        //订单类型
        //        sampling.setPersonal((short) 2);
        //        sampling.setOrderStatus((short) 0);
        //        sampling.setDeleteFlag((short) 0);
        //        sampling.setSamplingDate(new Date());
        //        sampling.setStatus((short) 0);
        //        sampling.setIsTakeSampling((short) 0);
        //        sampling.setExpedited((short) 0);
        //        //打印费用
        //        sampling.setPrintingFee((double) 0);
        //        //送检人
        //        sampling.setSamplingUserid(user.getId()+"");
        //        sampling.setSamplingUsername(user.getRealName());
        //        sampling.setParam3(user.getPhone());
        //        //只有一个委托单位，写到订单主表
        //        if (reqUnits.size() == 1) {
        //            sampling.setRegId(reqUnits.get(0).getRequestId());
        //            sampling.setRegName(reqUnits.get(0).getRequestName());
        //            sampling.setRegLinkPhone(reqUnits.get(0).getParam1());
        //        }
        //
        //        //个人用户，写入送检用户
        //        if (0 == user.getUserType()) {
        //            sampling.setInspectionCompany(user.getRealName());
        //
        //            //企业和供货商用户，写入送检企业
        //        } else {
        //            sampling.setInspectionId(user.getInspectionId());
        //            sampling.setInspectionCompany(user.getInspectionName());
        //        }
        insert(sampling);

        //获取订单单号
        sampling = getById(sampling.getId());

        //检测费用
        double checkMoney = 0.0;
        List<TbSamplingDetail> detailList = new ArrayList<TbSamplingDetail>();
        //保存样品、委托单位、来源等历史纪录
        List<Integer> foodIds = new ArrayList<Integer>();
        List<String> suppliers = new ArrayList<String>();
        List<Integer> supplierIds = new ArrayList<Integer>();
        List<String> opes = new ArrayList<String>();
        //订单明细
        for (int i = 0; i < details.size(); i++) {
            //            foodIds.add(details.get(i).getFoodId());
            //            suppliers.add(details.get(i).getSupplier());
            //            supplierIds.add(details.get(i).getSupplierId());
            //            opes.add(details.get(i).getOpeShopName());
            //
            //            details.get(i).setSamplingId(sampling.getId());
            //            details.get(i).setStatus((short) 0);
            //            details.get(i).setSampleCode(sampling.getSamplingNo() + "-" + (i+1));

            BaseDetectItem item = detectItemService.getById(details.get(i).getItemId());
            if (null == item) {
                throw new Exception("检测项目[" + details.get(i).getItemName() + "]不存在");

                //            } else if (details.get(i).getOfferId() != null && details.get(i).getOfferId() != item.getOfferId()
                //                    && details.get(i).getDiscount() != null && details.get(i).getDiscount() != item.getDiscount()) {
                //                throw new Exception("活动已结束，请重新下单");

            } else {
                //检测费
                //                details.get(i).setInspectionFee(item.getDiscount() * item.getPrice());
                checkMoney += details.get(i).getInspectionFee();
            }
            //            samplingDetailService.save(details.get(i));
            samplingDetailMapper.insert(details.get(i));
        }
        //检测费用
        //        sampling.setCheckMoney(checkMoney);

        //        //上门服务
        //        double takeSamplingMoney = 0;
        //        if (1 == sampling.getTakeSamplingModal()) {
        //            TakeSamplingPrice price = takeSamplingPriceService.queryByRequestUnitId(reqUnits.get(0).getId());
        //            if (price != null) {
        //                takeSamplingMoney = price.getPrice().doubleValue();
        //            }
        //        }
        //        sampling.setTakeSamplingMoney(takeSamplingMoney);

        //报告费用
        double reportFee = 0.0;
        //订单委托单位
        for (int i = 0; i < reqUnits.size(); i++) {
            reqUnits.get(i).setSamplingId(sampling.getId());
            //            PublicUtil.setCommonForTable1(reqUnits.get(i), true, user);

            //第二个委托单位算
            if (i > 0) {
                InspectionReportPrice reportPrice = inspectionReportPriceService.queryByInspectionUnitId(reqUnits.get(i).getId());
                if (reportPrice != null) {
                    reportFee += reportPrice.getReportPrice();
                }
            }
        }
        samplingRequesterService.saveBatch(reqUnits);

        //        //订单费用(不含打印费)
        //        sampling.setInspectionFee(checkMoney + takeSamplingMoney + reportFee);
        //
        //        PublicUtil.setCommonForTable1(sampling, true, user);
        //        updateBySelective(sampling);
        //
        //        //保存 委托单位、样品历史
        //        orderhistoryService.saveOrderhistory2(sampling.getRegId(), foodIds, user.getId());

        return sampling;
    }

    /**
     * 上门取样状态修改
     *
     * @param tbSampling
     * @return
     */
    public AjaxJson updateTaskState(TbSampling tbSampling, InspectionUnitUser user) throws Exception {
        AjaxJson ajaxJson = new AjaxJson();
        if (user == null) {
            throw new MyException("用户登录失效，请重新登录！");
        }
        //        Short isTakeSampling = tbSampling.getIsTakeSampling();
        //        tbSampling.setTakeSamplingUserid(user.getId());
        //        PublicUtil.setCommonForTable1(tbSampling, false, user);
        //        if (isTakeSampling == 0) {//0 待接收（表示取样人员放弃该任务，清空该任务对应的取样人员信息）
        //            int count = this.updateTask(tbSampling);//更改订单的取样状态
        //            if (count <= 0) {
        //                throw new MyException("取消任务失败，刷新查看任务最新状态！");
        //            }
        //        } else if (isTakeSampling == 1) {//1 待取样（表示取样人员接收该任务，保存该任务对应的取样人员信息）
        ////            String takeSamplingUsername = StringUtil.isEmpty(user.getRealName()) ? user.getPhone() : user.getRealName();
        ////            tbSampling.setTakeSamplingUsername(takeSamplingUsername);
        ////            tbSampling.setTakeGetDate(new Date());
        //            int count = this.updateTask(tbSampling);//更改订单的取样状态
        //            if (count <= 0) {
        //                throw new MyException("接受任务失败，刷新查看任务最新状态！");
        //            }
        //        } else if (isTakeSampling == 2) {//2  已取样（表示取样人员完成任务，更改任务状态和保存完成时间）
        ////            tbSampling.setTakeFoodDate(new Date());
        //            int count = this.updateTask(tbSampling);//更改订单的取样状态
        //            if (count <= 0) {
        //                throw new MyException("确认取样失败，刷新查看任务最新状态！");
        //            }
        //        }
        ajaxJson.setMsg("操作成功!");
        return ajaxJson;
    }

    /**
     * 根据有效报告码获取订单
     *
     * @param reportCode 有效期内的报告码
     * @return
     */
    public TbSampling queryByReportCode(String reportCode) {
        //获取有效期时间
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, -reportCodeValidity);
        return getBaseMapper().queryByReportCode(reportCode, sdf.format(calendar.getTime()));
    }

    /**
     * 有效期+7天内报告码是否重复
     *
     * @param reportCode 报告码
     * @return true 重复
     */
    public boolean isRepeat(String reportCode) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, -(reportCodeValidity + 7));
        TbSampling sampling = getBaseMapper().queryByReportCode(reportCode, sdf.format(calendar.getTime()));
        return sampling != null;
    }


    /****************************************************** 快检新模式 Dz 2025.6.11 ******************************************************/
    @Override
    public boolean checkOrderNumber(String orderNumber) {
        boolean isValid = true;
        // 1.验证订单号格式：A+反写年份后两位+8位数字
        String regex = "^A[5-9]2\\d{8}$";
        isValid = StrUtil.isNotBlank(orderNumber) && orderNumber.matches(regex);

        // 2.验证订单号是否已占用
        TbSampling sampling =getOne(new LambdaQueryWrapper<TbSampling>()
                .eq(TbSampling::getOrderNumber, orderNumber)
                .ne(TbSampling::getOrderStatus, 4),false);

        //以下方法如果有多条数据会抛出异常
       /* TbSampling sampling = lambdaQuery()
                .eq(TbSampling::getOrderNumber, orderNumber)
                .ne(TbSampling::getOrderStatus,4)
                .one();*/
        if (sampling != null) {
            isValid = false;
        }

        return isValid;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int createOrder(TbSampling sampling, List<TbSamplingDetail> details) {
        //  1.验证订单号
        Boolean isValid = checkOrderNumber(sampling.getOrderNumber());
        if (!isValid) {
            return 0;
        } else {
            // 1.获取检测项目
            List<BaseDetectItem> items = baseDetectItemService.listByIds(details.stream().map(TbSamplingDetail::getItemId).collect(Collectors.toList()));

            // 2.处理订单详情信息
            for (int i = 0; i < details.size(); i++) {
                //样品码规则：11位单号-2位流水号，例如：A5200000001-01
                details.get(i).setSampleCode(String.format("%s-%02d", sampling.getOrderNumber(), i + 1));
                details.get(i).setIsRecheck(0);
                details.get(i).setRecevieStatus(0);
                // 检测费
                String detailItemId = details.get(i).getItemId();
                Double detailItemPrice = items.stream().filter(item -> item.getId().equals(detailItemId)).map(BaseDetectItem::getPrice).findFirst().orElse(0.0);
                details.get(i).setInspectionFee((int) (detailItemPrice * 100));
            }

            // 3.保存订单信息
            sampling.setOrderTime(new Date());
            sampling.setOrderStatus(1);
            sampling.setIsSampling(1);

            sampling.setOrderFees((details.stream().mapToInt(TbSamplingDetail::getInspectionFee).sum()));
            save(sampling);

            // 4.保存订单详情
            details.stream().forEach(detail -> {
                detail.setSamplingId(sampling.getId());
            });
            //            samplingDetailService.saveBatch(details);
            samplingDetailMapper.insert(details);

            return sampling.getId();
        }
    }

    @Override
    public int paid(int id) {
        // 返回值：1_成功,0_失败,-1_订单不存在,-2_恢复订单失败（单号已使用）
        int result = 1;

        TbSampling order = getById(id);
        if (order == null) {
            // 订单不存在
            result = -1;

        } else {
            // 订单状态:1_待支付,2_已支付,3_已完成,4_取消,5_检测中,6_复检中
            switch (order.getOrderStatus()) {
                case 1:
                    //add by xiaoyl 2025/07/22 电子抽样订单,修改为当前用户已取样状态
                    if(order.getOrderType()==2){
                        order.setSamplingUserid(order.getOrderUserid());
                        order.setSamplingUsername(order.getOrderUsername());
                        order.setSamplingTime(new Date());
                        order.setIsSampling(2);
                    }
                    order.setOrderStatus(2);
                    updateById(order);
                    break;

                case 4:
                    // 恢复已取消订单
                    // 1.判断订单号重复
                    List<TbSampling> sameOrders = lambdaQuery()
                            .eq(TbSampling::getOrderNumber, order.getOrderNumber())
                            .ne(TbSampling::getId, order.getId())
                            .ne(TbSampling::getOrderStatus, 4)
                            .list();
                    if (!sameOrders.isEmpty()) {
                        // 订单号已使用
                        result = -2;

                    } else {
                        // 恢复已取消订单，恢复订单状态为已支付
                        order.setOrderStatus(2);
                        updateById(order);
                    }
                    break;

                // 已支付、已完成订单不做处理
                default:
                    break;
            }
        }
        return result;
    }

    @Override
    public String payManyAsyncSplit(PayReqVO payReqVO) throws Exception {
        BaseResponse<HfPaymentOrderResponse> payResult = null;
        String payCode = null;
        try {
            TbSampling order = getBaseMapper().queryBySamplingId(payReqVO.getOrderId());
            if (order==null) {
                throw new Exception("找不到订单信息！");
            }else{
                InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
                Income bean = incomeService.selectBySamplingId(payReqVO.getOrderId(), null, payReqVO.getTransactionType());
                if (bean != null) {//有记录直接更新
                    Date now = new Date();
                    int s = DateUtil.getBetweenTime(now, bean.getUpdateDate());
                    //重新生成：支付接口2小时有效，所以设置失效后重新生成
                    if (bean.getStatus() == 1) {
                        payCode = "-1";
                    } /*else if (s < 7000 && StringUtils.isNotEmpty(bean.getPayNumber())) {
                        payCode = bean.getPayNumber();
                    }*/ else {
                        String merOrderId = GeneratorOrder.generate(user.getId());
                        payReqVO.setMerOrderId(merOrderId);
                        payReqVO.setOpenId(user.getOpenId());
                        payReqVO.setOrderFees(bean.getMoney());
                        payReqVO.setOrderNumber(order.getOrderNumber());
                        //调用汇付支付接口，返回支付码
                        payResult = MallBookUtil.guaranteePayManyAsyncSplit(payReqVO);
                        if (!payResult.getCode().equals("0000")) {
                            log.error("汇付接口执行异常：" + payResult.getMsg());
                            throw new Exception("2.汇付接口执行异常：" + payResult.getMsg());
                        }
                        payCode = payResult.getData().getPayCode();
                        bean.setNumber(merOrderId);
                      /*  String payNumber=payCode;
                        if(payReqVO.getPayType().equals(PaymentType.WX_JSAPI.getCode())){
                            payNumber="";

                        }*/
                        bean.setPayNumber(""); //预支付标识先暂存流水号字段 支付成功后替换为 流水号
                        PublicUtil.setCommonForTable1(bean, false, user);
                        incomeService.updateById(bean);
                        WeChatUtil.setInfolog(1, "预支付信息", "预支付标识过期,重新调起预支付，订单号=" + payReqVO.getOrderId() + ";商户订单号=" + merOrderId, user);
                    }
                } else {//无记录新增
                    String merOrderId = GeneratorOrder.generate(user.getId());
                    payReqVO.setMerOrderId(merOrderId);
                    payReqVO.setOpenId(user.getOpenId());
                    if(payReqVO.getTransactionType()==1){
                        int money = reCheckMoney(order.getId(),order.getOrderNumber());
                        payReqVO.setOrderFees(money);
                    }else{
                        payReqVO.setOrderFees(order.getOrderFees());
                    }

                    payReqVO.setOrderNumber(order.getOrderNumber());
                    //调用汇付支付接口，返回支付码
                    payResult = MallBookUtil.guaranteePayManyAsyncSplit(payReqVO);
                    if (!payResult.getCode().equals("0000")) {
                        throw new Exception("2.汇付接口执行异常：" + payResult.getMsg());
                    }
                    payCode = payResult.getData().getPayCode();
                   /* String payNumber=payCode;
                    if(payReqVO.getPayType().equals(PaymentType.WX_JSAPI.getCode())){
                        payNumber="";
                    }*/
                    //预支付标识先暂存流水号字段 支付成功后替换为 流水号
                    bean = new Income(merOrderId, payReqVO.getOrderId(), (short) 1, (short) 0, "", payReqVO.getTransactionType(), payReqVO.getOrderFees(), (short) 0);
                    bean.setDeleteFlag(0);
                    PublicUtil.setCommonForTable1(bean, true, user);
                    //预支付信息存入流水表
                    incomeService.saveOrUpdate(bean);
                    WeChatUtil.setInfolog(1, "预支付信息", "生成收款码，订单号=" + payReqVO.getOrderId() + ";商户订单号=" + merOrderId, user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("调起微信支付失败，异常原因："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            throw new Exception(e);
        }
        return payCode;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void recheck(int orderId, int recheckFees) throws MiniProgramException {
        TbSampling order = getById(orderId);
        if (order == null || 3 != order.getOrderStatus()) {
            // 1.订单不存在或订单状态异常（仅限已完成订单可复检）
            throw new MiniProgramException(ErrCode.DATA_ABNORMAL, null, "订单不存在或订单状态异常（仅限已完成订单可复检）");

        } else {
            // 2.查询订单检测不合格记录
            List<DataCheckRecording> checkRecords = dataCheckRecordingMapper.selectList(new LambdaQueryWrapper<DataCheckRecording>()
                    .eq(DataCheckRecording::getConclusion, "不合格")
                    .eq(DataCheckRecording::getSamplingId, orderId));
            if (checkRecords.isEmpty()) {
                // 找不到订单检测不合格记录
                throw new MiniProgramException(ErrCode.DATA_NOT_FOUND, null, "找不到订单检测不合格记录");
            }

            // 3.查询复检样品（不合格样品）
            List<TbSamplingDetail> samples = samplingDetailMapper.selectList(new LambdaQueryWrapper<TbSamplingDetail>()
                    .in(TbSamplingDetail::getId, checkRecords.stream().map(DataCheckRecording::getSamplingDetailId).collect(Collectors.toList()))
                    .eq(TbSamplingDetail::getIsRecheck, 0));
            if (samples.isEmpty()) {
                // 找不到复检样品（不合格样品）
                throw new MiniProgramException(ErrCode.DATA_NOT_FOUND, null, "找不到复检样品（不合格样品）");
            }

            // 4.处理复检数据
            // 计算单项复检费用（向下取整）
            int recheckFee = recheckFees / samples.size();
            // 余数费用
            int remainder = recheckFees % samples.size();
            // 处理每项复检样品
            for (int i = 0; i < samples.size(); i++) {
                // 不合格样品（原数据）
                TbSamplingDetail sample = samples.get(i);

                // 复制复检样品信息
                TbSamplingDetail recheckSample = new TbSamplingDetail();
                BeanUtils.copyProperties(sample, recheckSample);
                recheckSample.setId(null);
                recheckSample.setIsRecheck(0);
                recheckSample.setItemId(null);
                recheckSample.setItemName(null);
                recheckSample.setInspectionFee((i == 0 ? recheckFee + remainder : recheckFee));
                recheckSample.setRecheckDetailId(sample.getId());
                recheckSample.setRecevieStatus(0);
                recheckSample.setRecevieDevice("");
                recheckSample.setOperatingTime(null);
                recheckSample.setPrintCodeTime(null);
                recheckSample.setPrintCodeNum((short)0);
                samplingDetailMapper.insert(recheckSample);

                // 原样品信息改为已申请复检
                sample.setIsRecheck(1);
                samplingDetailMapper.updateById(sample);
            }
        }

        // 更新订单费用
        LambdaUpdateWrapper<TbSampling> updateWrapper = new LambdaUpdateWrapper<TbSampling>()
                .set(TbSampling::getOrderFees, (order.getOrderFees() + recheckFees))
                .set(TbSampling::getReportTime, null)
                .set(TbSampling::getOrderStatus, 6)

                .eq(TbSampling::getId, order.getId());
        update(updateWrapper);
    }

    @Override
    public List<TbSampling> queryReCheck(String startTime, String endTime) {
        return getBaseMapper().queryReCheck(startTime,endTime);
    }
    @Override
    public int reCheckMoney(Integer samplingId,String orderNumber) throws Exception {
        List<TbSamplingDetail> foodList=samplingDetailMapper.queryUnqualifiedFoodNum(samplingId);
        if(foodList.size()==0){
            throw new Exception(String.format("订单：%s 没有需要复检的样品",orderNumber));
        }
        BigDecimal reCheckPrice = BigDecimal.valueOf(SystemConfigUtil.OTHER_CONFIG.getDouble("re_check_price"));
        int money = reCheckPrice.multiply(BigDecimal.valueOf(100))
                .multiply(BigDecimal.valueOf(foodList.size()))
                .intValue();
        return money;
    }
}




