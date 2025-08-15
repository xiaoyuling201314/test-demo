package com.dayuan.service.DataCheck;

import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.data.TbFile;
import com.dayuan.bean.dataCheck.DataUnqualifiedDispose;
import com.dayuan.bean.dataCheck.DataUnqualifiedTreatment;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.mapper.dataCheck.DataUnqualifiedTreatmentMapper;
import com.dayuan.model.dataCheck.CheckResultModel;
import com.dayuan.model.dataCheck.DataUnqualifiedTreatmentModel;
import com.dayuan.service.BaseService;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.data.TbFileService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.*;
import com.dayuan3.common.util.SystemConfigUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 抽样检测
 *
 * @author Bill
 */
@Service
public class DataUnqualifiedTreatmentService extends BaseService<DataUnqualifiedTreatment, Integer> {


    @Autowired
    private DataUnqualifiedTreatmentMapper mapper;
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private BasePointService pointService;
    @Autowired
    private TSDepartService departService;
    @Autowired
    private TbFileService fileService;
    @Autowired
    private DataUnqualifiedDisposeService disposeService;

    @Value("${resources}")
    private String resources;    //项目资源文件夹
    @Value("${filePath}")
    private String filePath;
    @Value("${supervisorSign}")
    private String supervisorSign;    //不合格处理-监督人签名
    @Value("${treatment}")
    private String treatmentPath;    //不合格处理-取证文件
    @Value("${thumbnailPath}")
    private String thumbnailPath;//不合格取证图片缩略图

    public DataUnqualifiedTreatmentMapper getMapper() {
        return mapper;
    }

    public CheckResultModel getRecording(Integer id) {
        return mapper.getRecording(id);
    }

    /**
     * 通过检测数据ID获取不合格处理
     *
     * @param rid
     * @return
     */
    public DataUnqualifiedTreatment queryByRid(Integer rid) {
        return mapper.queryByRid(rid);
    }

    private static final int firstPageSize = 0;

//    public Page loadDealDatagrid(Page page, BaseModel t) {
//        // 初始化分页参数
//        if (null == page) {
//            page = new Page();
//        }
//        // 设置查询条件
//        page.setObj(t);
//        // 每次查询记录总数量,防止新增或删除记录后总数量错误
//        page.setRowTotal(mapper.getDealRowTotal(page));
//        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
//        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
//        List<CheckResultModel> dataList = mapper.loadDealDatagrid(page);
//        List<CheckResultModel> list2 = new ArrayList<>();
//        int max = dataList.size() > page.getPageSize() ? page.getPageSize() : dataList.size();
//        for (int i = 0; i < max; i++) {
//            list2.add(dataList.get(i));
//        }
//        page.setResults(list2);
//        return page;
//    }

    /**
     * 插入不合格处理数据与处置明细记录
     *
     * @param dataCheckModel
     * @param user           登录用户ID（不合格处理接口调用此方法必填）
     * @param file           不合格处理取证材料
     */
    public Integer addSelective(DataUnqualifiedTreatmentModel dataCheckModel, TSUser user, MultipartFile file) throws Exception {
        DataUnqualifiedTreatment treatment = dataCheckModel.getTreatment();

        //通过检测数据ID获取旧不合格处理
        DataUnqualifiedTreatment oldTreatment =null;
        //add by xiaoyl 2022/05/19 start 根据系统参数配置是否更新不合格处理考核状态,如果没有配置系统参数则设置默认为1关闭
        Integer assessmentState = SystemConfigUtil.GS_ASSESSMENT_CONFIG==null? 1 : SystemConfigUtil.GS_ASSESSMENT_CONFIG.getInteger("assessment_state");
        if(null!=assessmentState && assessmentState==0){//过滤掉已删除的数据
            oldTreatment= mapper.queryByRid2GS(treatment.getCheckRecordingId());
        }else{
            oldTreatment = this.queryByRid(treatment.getCheckRecordingId());
        }
        //add by xiaoyl 2022/05/19 end
//        DataUnqualifiedTreatment oldTreatment= this.queryByRid(treatment.getCheckRecordingId());
        if (oldTreatment != null) {
            treatment.setId(oldTreatment.getId());
        }

        if (null != treatment.getId()) {//处理中数据进一步处理-->更新操作
            DataUnqualifiedTreatment baseBean = mapper.selectByPrimaryKey(treatment.getId());
            if (baseBean == null) {//app上传不合格处理数据:待处理中数据处理进行新增操作
                if (user != null) {
                    PublicUtil.setCommonForTable(treatment, true, user);
                } else {
                    PublicUtil.setCommonForTable(treatment, true);
                    user = PublicUtil.getSessionUser();
                }

                mapper.insertSelective(treatment);
            } else {//处理中数据进一步处理-->更新操作
                if (user != null) {
                    PublicUtil.setCommonForTable(treatment, true, user);
                } else {
                    PublicUtil.setCommonForTable(treatment, true);
                    user = PublicUtil.getSessionUser();
                }

                mapper.updateByPrimaryKeySelective(treatment);
            }
        } else {
            if (user != null) {
                PublicUtil.setCommonForTable(treatment, true, user);
            } else {
                PublicUtil.setCommonForTable(treatment, true);
                user = PublicUtil.getSessionUser();
            }
            mapper.insertSelective(treatment);
        }
        //插入不合格处置明记录
        List<DataUnqualifiedDispose> disposeList = dataCheckModel.getDisposeList();
        if (disposeList != null && !disposeList.isEmpty()) {
            for (DataUnqualifiedDispose dispose : disposeList) {
                Integer disposeID = dispose.getDisposeId();
                if (null == disposeID) {
                    continue;
                }
                if (dispose.getDisposeValue() == null) {
                    dispose.setDisposeValue("");
                }
                if (user != null) {
                    PublicUtil.setCommonForTable(dispose, true, user);
                } else {
                    PublicUtil.setCommonForTable(dispose, true);
                }
                dispose.setUnid(treatment.getId());
                dispose.setCheckRecordingId(treatment.getCheckRecordingId());
                disposeService.insertSelective(dispose);
            }
        }

        if (file != null) {
            //解压
            String ucp = resources + filePath + "temp/" + UUIDGenerator.generate() + "/";    //临时文件
            ZipUtils.uncompress(file.getInputStream(), ucp);

            //保存处理证据、监督人签名
            File[] fs = new File(ucp).listFiles();
           // update by xiaoyl 2022-03-16 不合格处理附件生成缩略图
            for (File f : fs) {
                String fName = UUIDGenerator.generate() + DyFileUtil.getFileExtension(f);
                String fPath = "";//相对路径：files/Enforce/402891f57f96658f017f96658fd70002.jpg
                TbFile tbFile = new TbFile();
                if (f.getName().contains("treatment_")) {    //处理证据
                    fPath = filePath + treatmentPath + fName ;
                    tbFile.setSourceType("Enforce");
                    DyFileUtil.saveFile(f, resources + fPath);
                    //图片生成缩略图
                    if(ImageDealUtil.checkIsImage(f.getName())) {
                        String filePathRoot=resources+filePath + treatmentPath;
                        String oldfilePath=filePathRoot+ fName;//原始图片路径
                        String directoryPath=filePathRoot+thumbnailPath;//缩略图存放路径
                        ImageDealUtil.GenerateFixedSizeImage(oldfilePath,30,30,directoryPath);
                    }
                } else if (f.getName().contains("sign_")) {    //监督人签名
                    fPath = filePath + supervisorSign + fName;
                    tbFile.setSourceType("signPic");
                    DyFileUtil.saveFile(f, resources + fPath);
                    tbFile.setFilePath(fPath);
                } else {
                    continue;
                }
                tbFile.setSourceId(treatment.getId());
                tbFile.setFileName(fName);
                tbFile.setFilePath(fPath);
                tbFile.setSorting((short) 0);
                tbFile.setDeleteFlag((short) 0);
                PublicUtil.setCommonForTable(tbFile, true, user);
                fileService.insert(tbFile);
            }
            //删除临时文件
            DyFileUtil.deleteFolder(ucp);
         /*  delete by xiaoyl 2022-03-16 不合格处理附件生成缩略图，优化附件上传方法
          for (File f : fs) {
                String fName = UUIDGenerator.generate() + DyFileUtil.getFileExtension(f);
                String fPath = "";
                TbFile tbFile = new TbFile();
                if (f.getName().contains("treatment_")) {    //处理证据
                    fPath = filePath + treatmentPath + fName;
                    tbFile.setSourceType("Enforce");

                } else if (f.getName().contains("sign_")) {    //监督人签名
                    fPath = filePath + supervisorSign + fName;
                    tbFile.setSourceType("signPic");

                } else {
                    continue;
                }
                DyFileUtil.saveFile(f, resources + fPath);

                tbFile.setSourceId(treatment.getId());
                tbFile.setFileName(fName);
                tbFile.setFilePath(fPath);
                tbFile.setSorting((short) 0);
                tbFile.setDeleteFlag((short) 0);
                PublicUtil.setCommonForTable(tbFile, true, user);
                fileService.insert(tbFile);
            }
            //删除临时文件
            DyFileUtil.deleteFolder(ucp);*/
        }
        return treatment.getId();

    }

    /**
     * 获取当月不合格处理数量（首页统计）
     *
     * @param tsUser
     * @return
     * @throws Exception
     */
    public Map<String, Object> queryProcessingNum(TSUser tsUser) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        StringBuffer sbuffer = new StringBuffer();
        if (null != tsUser) {
            String start = DateUtil.firstDayOfMonth();
            String end = DateUtil.lastDayOfMonth() + " 23:59:59";
            if (StringUtil.isNotEmpty(tsUser.getPointId())) {

                //不合格处理
                sbuffer.setLength(0);
                //update by xiaoyl 2022/05/18 增加不合格处理删除状态条件dut.delete_flag已处理中过滤掉删除的数据；
                sbuffer.append("SELECT " +
                        "	SUM(CASE WHEN dcr.conclusion = '不合格' and dut.deal_method is null  THEN 1 ELSE 0 END ) untreated, " +
                        "	SUM(CASE WHEN dcr.conclusion = '不合格' and dut.deal_method = 0 THEN 1 ELSE 0 END ) processing, " +
                        "	SUM(CASE WHEN dcr.conclusion = '不合格' and (dut.deal_method = 1 and dut.delete_flag=0) THEN 1 ELSE 0 END ) processed " +
                        "FROM data_check_recording dcr " +
                        "LEFT JOIN data_unqualified_treatment dut ON dut.check_recording_id = dcr.rid and dut.delete_flag=0 " +
                        "WHERE dcr.delete_flag = 0 and dcr.param7 = 1 and dcr.depart_id = ? and dcr.point_id = ? and dcr.check_date>=? and dcr.check_date<=?  ");
                List<Map<String, Object>> mapList3 = jdbcTemplate.queryForList(sbuffer.toString(), tsUser.getDepartId(), tsUser.getPointId(), start, end);
                Map<String, Object> map3 = null;
    			if(mapList3!=null && mapList3.size()>0) {
    				map3 = mapList3.get(0);
    			}else {
    				map3 = new HashMap<String, Object>();
    				map3.put("untreated", "0");
    				map3.put("processing", "0");
    				map3.put("processed", "0");
    			}

                map.put("untreated", StringUtil.isNotEmpty(map3.get("untreated")) ? map3.get("untreated") : 0);    //待处理
                map.put("processing", StringUtil.isNotEmpty(map3.get("processing")) ? map3.get("processing") : 0);    //处理中
                map.put("processed", StringUtil.isNotEmpty(map3.get("processed")) ? map3.get("processed") : 0);    //已处理

            } else if (StringUtil.isNotEmpty(tsUser.getDepartId())) {
                TSDepart depart = departService.getById(tsUser.getDepartId());
                String departCode = depart.getDepartCode();
//				String departCode = PublicUtil.getSessionUserDepart().getDepartCode();
                //不合格处理
                sbuffer.setLength(0);
                //update by xiaoyl 2022/05/18 增加不合格处理删除状态条件dut.delete_flag 已删除的重新算入待处理中，已处理中过滤掉删除的数据
                sbuffer.append("SELECT " +
                        "	SUM(CASE WHEN dcr.conclusion = '不合格' and dut.deal_method is null  THEN 1 ELSE 0 END ) untreated, " +
                        "	SUM(CASE WHEN dcr.conclusion = '不合格' and dut.deal_method = 0 THEN 1 ELSE 0 END ) processing, " +
                        "	SUM(CASE WHEN dcr.conclusion = '不合格' and (dut.deal_method = 1 and dut.delete_flag=0) THEN 1 ELSE 0 END ) processed " +
                        "FROM data_check_recording dcr " +
                        "LEFT JOIN data_unqualified_treatment dut ON dut.check_recording_id = dcr.rid and dut.delete_flag=0 " +
                        "WHERE dcr.delete_flag = 0  and dcr.param7 = 1 and  dcr.depart_id in (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code like CONCAT(?,'%')) and dcr.check_date>=? and dcr.check_date<=? ");
                List<Map<String, Object>> mapList3 = jdbcTemplate.queryForList(sbuffer.toString(), departCode, start, end);
                Map<String, Object> map3 = null;
    			if(mapList3!=null && mapList3.size()>0) {
    				map3 = mapList3.get(0);
    			}else {
    				map3 = new HashMap<String, Object>();
    				map3.put("untreated", "0");
    				map3.put("processing", "0");
    				map3.put("processed", "0");
    			}

                map.put("untreated", StringUtil.isNotEmpty(map3.get("untreated")) ? map3.get("untreated") : 0);    //待处理
                map.put("processing", StringUtil.isNotEmpty(map3.get("processing")) ? map3.get("processing") : 0);    //处理中
                map.put("processed", StringUtil.isNotEmpty(map3.get("processed")) ? map3.get("processed") : 0);    //已处理

            }
        }
        return map;
    }

    /**
     * 根据检测数据ID查询溯源信息
     *
     * @param id 检测数据ID
     * @return
     */
    public BaseRegulatoryObject selectSourceByRid(Integer id)throws Exception {
        return mapper.selectSourceByRid(id);
    }

    /**
     * 删除不合格处理
     * @param ids
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public void deleteData(String ids) throws Exception {
        String[] idsArr = ids.split(",");
        for (String id: idsArr) {
            this.delete(Integer.parseInt(id));
            disposeService.deleteByUnid(Integer.parseInt(id));
        }
    }


}
