package com.dayuan3.terminal.controller;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.model.sampling.TbSamplingDetailReport;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;
import com.dayuan3.common.service.TbSamplingRequesterService;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.service.RequesterUnitService;
import com.dayuan3.terminal.util.WXPayUtil;
import com.dayuan3.terminal.util.Xml2Word2Pdf;
import org.apache.commons.compress.archivers.ArchiveOutputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.*;

/**
 * Author: shit
 * Date: 2020-01-14 16:52
 * Content: 检测报告转pdf文档,预览检测报告和下载检测报告文档
 */
@Controller
@RequestMapping("/rpt")
public class CheckReportController {

    private Logger log = Logger.getLogger(CheckReportController.class);

    @Autowired
    private TbSamplingService tbSamplingService;
    @Autowired
    private TbSamplingRequesterService tbSamplingRequesterService;
    @Autowired
    private TbSamplingDetailService tbSamplingDetailService;
    @Autowired
    private RequesterUnitService requesterUnitService;


    /**
     * 生成PDF文档并返回地址(调用前提是报告结果已经全部出来)
     *
     * @param samplingId  订单ID
     * @param requestIds  委托单位ID集合
     * @param rN          报告编号：4位随机数，同编号表示同一份报告
     * @param collectCode 收样编号
     * @return
     */
    @RequestMapping("/create_pdf")
    @ResponseBody
    public String createPdf(Integer samplingId, Integer[] requestIds, Integer rN, String collectCode, HttpServletResponse response) throws Exception {
        List<String> filePaths = new ArrayList<>();//存储生成的多个pdf文件路径
        String page = null;
        try {
            String resources = WebConstant.res.getString("resources");
            Date now = new Date();
            String dateStr = DateUtil.yyyymmddhhmmssSSS.format(now);
            String printDate = DateUtil.datetimeFormat.format(now);
            //1.查询订单对应的委托单位列表
            requestIds = requestIds != null && requestIds.length <= 0 ? null : requestIds;
            List<RequesterUnit> reList = tbSamplingRequesterService.queryRequestList(samplingId, requestIds);
//            if (reList != null && reList.size() > 0) {
//                for (RequesterUnit ru : reList) {
//                    //查询之前是否有生成文档,有就不在生成,直接获取文档路径
//                    TbSamplingReportPrintlog tbLog = tbSamplingReportPrintlogService.selectByIdAndCode(samplingId, ru.getId(), collectCode);
//                    if (tbLog != null) {
//                        if (StringUtil.isEmpty(tbLog.getFilePath())) {
//                            String fileUrl = getPdfUrl(samplingId, ru.getId(), rN, collectCode, ru, printDate);
//                            tbLog.setFilePath(fileUrl);
//                            tbLog.setGeneratorDate(now);
//                            tbLog.setSamplingId(samplingId);
//                            tbLog.setCollectCode(collectCode);
//                            tbLog.setUpdateDate(now);
//                            tbSamplingReportPrintlogService.updateBySelective(tbLog);
//                        }
//                        filePaths.add(tbLog.getFilePath());
//                    } else {
//                        String fileUrl = getPdfUrl(samplingId, ru.getId(), rN, collectCode, ru, printDate);
//                        tbLog = new TbSamplingReportPrintlog();
//                        tbLog.setCreateDate(now);
//                        tbLog.setUpdateDate(now);
//                        tbLog.setFilePath(fileUrl);
//                        tbLog.setGeneratorDate(now);
//                        tbLog.setSamplingId(samplingId);
//                        tbLog.setCollectCode(collectCode);
//                        tbLog.setRequestId(ru.getId());
//                        tbSamplingReportPrintlogService.insertSelective(tbLog);
//                        filePaths.add(tbLog.getFilePath());
//                    }
//                }
//            }

            if (filePaths.size() > 1) {
                //文档生成完毕且数据保存成功就进行文档的打包操作
                //创建文件夹
                String path = resources + "/report/temp_download";//临时文件夹
                File file = new File(path);
                //判断文件夹是否存在，如果不存在，则创建此文件夹
                if (!file.exists()) {
                    file.mkdirs();
                }
                String zipFileName = "检测报告" + dateStr + ".zip";
                File zipFile = null;
                List<File> filelist = new ArrayList<>();
                //把多个文件放入到list集合中
                for (String everPath : filePaths) {
                    File file1 = new File(resources + everPath);
                    if (file1.exists()) {//文件存在才保存进去，不存在就不保存
                        filelist.add(file1);
                    }
                }
                // 打成压缩包
                zipFile = new File(path + "/" + zipFileName);
                FileOutputStream zipFos = new FileOutputStream(zipFile);
                ArchiveOutputStream archOut = new ArchiveStreamFactory().createArchiveOutputStream(ArchiveStreamFactory.ZIP, zipFos);
                if (archOut instanceof ZipArchiveOutputStream) {
                    ZipArchiveOutputStream zos = (ZipArchiveOutputStream) archOut;
                    for (File wordFile : filelist) {
                        ZipArchiveEntry zipEntry = new ZipArchiveEntry(wordFile, wordFile.getName());
                        zos.putArchiveEntry(zipEntry);
                        zos.write(FileUtils.readFileToByteArray(wordFile));
                        zos.closeArchiveEntry();
                        zos.flush();
                    }
                    zos.close();
                }
                zipFos.close();
                // 输出到客户端
                OutputStream out = null;
                out = response.getOutputStream();
                response.reset();
                response.setHeader("Content-Disposition", "attachment;filename=" + new String(zipFileName.getBytes("GB2312"), "ISO-8859-1"));
                response.setContentType("application/octet-stream; charset=utf-8");
                response.setCharacterEncoding("UTF-8");
                out.write(FileUtils.readFileToByteArray(zipFile));
                out.flush();
                out.close();
                // 输出客户端结束后，删除压缩包
                if (zipFile.exists()) {
                    zipFile.delete();
                }
            } else if (filePaths.size() == 1) {//把该pdf文件输出到客户端
                OutputStream out = null;
                out = response.getOutputStream();
                response.reset();
                response.setHeader("Content-Disposition", "attachment;filename=" + new String(("检测报告" + dateStr + ".pdf").getBytes("GB2312"), "ISO-8859-1"));
                response.setContentType("application/octet-stream; charset=utf-8");
                response.setCharacterEncoding("UTF-8");
                out.write(FileUtils.readFileToByteArray(new File(resources + filePaths.get(0))));
                out.flush();
                out.close();
            }
//        } catch (MyException me) {
//            log.error("*************************" + me.getMessage() + me.getStackTrace());
//            me.printStackTrace();
//            page = me.getMessage();
//            page = new String(page.getBytes("utf-8"), "iso8859-1");
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            page = e.getMessage();
            page = new String(page.getBytes("utf-8"), "iso8859-1");
        }
        return "<center><h3 style='color:red;'>" + page + "</h3></center>";
    }


    /**
     * @param samplingId  订单ID
     * @param requestId   委托单位ID
     * @param rN          报告编号：4位随机数，同编号表示同一份报告
     * @param collectCode 收样编号
     * @param ru          委托单位对象
     * @param printDate   打印时间
     * @throws Exception
     */
    private String getPdfUrl(Integer samplingId, Integer requestId, Integer rN, String collectCode, RequesterUnit ru, String printDate) throws Exception {
        //==========================1.参数查询=============================
        //1.查询主订单信息
        TbSampling sampling = tbSamplingService.getById(samplingId);
        //2.查询送检样品明细(rN可传可不传)
        List<TbSamplingDetailReport> samplingDetails = tbSamplingDetailService.queryOrderDetailBySamplingId(samplingId, rN, collectCode);
        //自定义条数 用于测试
/*        int i = 0;
        List<TbSamplingDetailReport> samplingDetails2 = new ArrayList<>();
        for (TbSamplingDetailReport samplingDetail : samplingDetails) {
            i++;
            if(i<=11){
                samplingDetails2.add(samplingDetail);
            }
        }
        samplingDetails = samplingDetails2;
        System.out.println(samplingDetails.size());*/

        //========================2.图片处理================================
        JSONObject reportConfig = SystemConfigUtil.REPORT_CONFIG;
        String projectPath = CheckReportController.class.getResource("/").getPath().replaceFirst("/", "").replaceAll("WEB-INF/classes/", "");
        //projectPath = "D:\\dykjfw\\src\\main\\webapp\\";//测试使用 TODO 提交的时候注释掉
        String reportTitle = reportConfig.getString("report_title");//报告名称
        String checkUsername1 = samplingDetails.size() > 0 ? samplingDetails.get(samplingDetails.size() - 1).getCheckUsername() : "";
        String checkDate1 = "";
        int pageNo = samplingDetails.size();//共几页
        pageNo = pageNo % 10 == 0 ? pageNo / 10 : (pageNo / 10) + 1;
        //add by xiaoyl 2020-02-26 生成pdf文件时，设置检测机构、地址和电话从检测点读取
        String pointName = "";//检测中心名字
        String pointAddress = "";////检测中心名字
        String pointPhone = "";////检测中心名字

        String signCode = "";//	审核人员签名，base64字符串
        String approveCode = "";//批准人员签名，base64字符串
        String signatureCode = "";// 电子签章，base64字符串

        if (samplingDetails.size() > 0) {
            if (samplingDetails.get(samplingDetails.size() - 1).getCheckDate() != null) {
                checkDate1 = DateUtil.date_sdf.format(samplingDetails.get(samplingDetails.size() - 1).getCheckDate());
            }
            if (samplingDetails.get(samplingDetails.size() - 1).getPointName() != null) {
                pointName = samplingDetails.get(samplingDetails.size() - 1).getPointName();
            }
            if (samplingDetails.get(samplingDetails.size() - 1).getPointAddress() != null) {
                pointAddress = samplingDetails.get(samplingDetails.size() - 1).getPointAddress();
            }
            if (samplingDetails.get(samplingDetails.size() - 1).getPointPhone() != null) {
                pointPhone = samplingDetails.get(samplingDetails.size() - 1).getPointPhone();
            }
            if (samplingDetails.get(samplingDetails.size() - 1).getReviewImage() != null) {
                signCode = samplingDetails.get(samplingDetails.size() - 1).getReviewImage();
            }
            if (samplingDetails.get(samplingDetails.size() - 1).getApproveImage() != null) {
                approveCode = samplingDetails.get(samplingDetails.size() - 1).getApproveImage();
            }
            if (samplingDetails.get(samplingDetails.size() - 1).getSignatureImage() != null) {
                signatureCode = samplingDetails.get(samplingDetails.size() - 1).getSignatureImage();
            }
        }

        String checkCodeStr = WebConstant.res.getString("reportPath") + sampling.getId() + "&scan=1&requestId=" + requestId;//防伪码字符串
        //String signatureFile = projectPath + reportConfig.getString("signature_file");//盖章图片
        //String signFile = projectPath + reportConfig.getString("sign_file");//审核人图片路径
        //String approveFile = projectPath + reportConfig.getString("approve_file");//批准人图片路径

        //拿到需要的图片的base64编码
        String checkCode = StringUtil.isNotEmpty(checkCodeStr) ? Xml2Word2Pdf.str2Base64(checkCodeStr) : "";
//        String signatureCode = StringUtil.isNotEmpty(signatureFile) ? Xml2Word2Pdf.ima2Base64(signatureFile) : "";
//        String signCode = StringUtil.isNotEmpty(signFile) ? Xml2Word2Pdf.ima2Base64(signFile) : "";
//        String approveCode = StringUtil.isNotEmpty(approveFile) ? Xml2Word2Pdf.ima2Base64(approveFile) : "";


        //========================3.路径定义与参数整理=============================
        Map<String, Object> dataMap = new HashMap<>();
        String filePath = "report/" + UUIDGenerator.generate() + ".doc";
        String rootPath = WebConstant.res.getString("resources");
        String sourceFile = rootPath + filePath;//UUIDGenerator.generate()
        dataMap.put("reportTitle", reportTitle);
        dataMap.put("pageNo", pageNo);
        dataMap.put("printDate", printDate);
        dataMap.put("checkUsername1", checkUsername1);
        dataMap.put("checkDate1", checkDate1);

        dataMap.put("pointName", pointName);
        dataMap.put("pointAddress", pointAddress);
        dataMap.put("pointPhone", pointPhone);

        dataMap.put("checkCode", checkCode);
        dataMap.put("signatureCode", signatureCode);
        dataMap.put("signCode", signCode);
        dataMap.put("approveCode", approveCode);
        dataMap.put("sampling", sampling);
        dataMap.put("request", ru);
        dataMap.put("samplingDetails", samplingDetails);
        //dataMap.put("emptys", new ArrayList[10 - samplingDetails.size()]);
        dataMap.put("reportConfig", reportConfig);
        //========================4.文档生成=============================
        //判断目录是否存在，不存在就创建
        File myFilePath = new File(rootPath + "report/");
        if (!myFilePath.exists()) {
            myFilePath.mkdirs();
        }
        int showReq = WXPayUtil.getShowReq();
        String templateFileName = "check_report.ftl";
        if(showReq==1||showReq==2){
            templateFileName = "check_report2.ftl";
        }
        Xml2Word2Pdf.createWord(projectPath + "\\templates\\", templateFileName, sourceFile, dataMap);

        Xml2Word2Pdf.word2Pdf(sourceFile, null);

        //对一单多用检测报告打印记录表tb_sampling_report_printlog进行数据新增
        return filePath.replace(".doc", ".pdf");
    }


    /**
     * 扫描委托单位二维码页面
     *
     * @param id 委托单位ID
     * @return
     * @discription 目的在于简化链接 即降低二维码复杂程度
     */
    @RequestMapping("/sc{id}")
    @ResponseBody
    public ModelAndView scanQrcode(@PathVariable Integer id) {
        Map<String, Object> map = new HashMap<>();
        try {
            RequesterUnit unit = requesterUnitService.queryById(id);
            if (unit != null) {//扫描次数加1
                if (unit.getScanNum() == null) {
                    unit.setScanNum((short) 1);
                } else {
                    unit.setScanNum((short) (unit.getScanNum() + 1));
                }
                requesterUnitService.updateBySelective(unit);
            }
            map.put("unit", unit);
            map.put("id", id);
            //获取进货数量的显示和必填配置传入界面
            map.put("showReq", WXPayUtil.getShowReq());
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/terminal/requester/scanQrcode", map);
    }


    /**
     * @param model
     * @param samplingId  订单ID
     * @param requestId   委托单位ID
     * @param collectCode 收样编号
     * @return
     */
    @RequestMapping("/report")
    public String doGet(Model model, Integer samplingId, Integer requestId, String collectCode) {
        model.addAttribute("samplingId", samplingId);
        model.addAttribute("collectCode", collectCode);
        if (requestId != null) {
            model.addAttribute("requestId", requestId);
//            //查询之前是否有生成文档,有就不在生成,直接获取文档路径
//            TbSamplingReportPrintlog tbLog = tbSamplingReportPrintlogService.selectByIdAndCode(samplingId, requestId, collectCode);
//            if (tbLog != null && StringUtil.isNotEmpty(tbLog.getFilePath())) {
//                model.addAttribute("filePath", tbLog.getFilePath());
//            } else {
//                model.addAttribute("filePath", "");
//            }
        }
        return "/terminal/report/report_pdf";
    }

    public static void main(String[] args) throws Exception {
        //String projectPath = CheckReportController.class.getResource("/").getPath().replaceFirst("/", "").replaceAll("WEB-INF/classes/", "");
        String projectPath = "D:\\dykjfw\\src\\main\\webapp\\";//测试使用 TODO 提交的时候注释掉
        //拿到需要的图片的base64编码
        //========================3.路径定义与参数整理=============================
        Map<String, Object> dataMap = new HashMap<>();
        String filePath = "report/" + UUIDGenerator.generate() + ".doc";
        String rootPath = WebConstant.res.getString("resources");
        String sourceFile = rootPath + filePath;//UUIDGenerator.generate()


        TbSampling sampling = new TbSampling();
//        sampling.setSamplingNo("Z202010080013");
//        sampling.setInspectionCompany("送检单位名称");
        sampling.setParam3("17872561868");
        RequesterUnit ru  = new RequesterUnit();
        ru.setRequesterName("黔西县王兰蔬菜店");
        ru.setCompanyAddress("我就是单位的地址啦啦啦");



        dataMap.put("request", ru);

        dataMap.put("reportTitle", "中检达元(黔西)检测技术有限公司");
        //dataMap.put("pageNo", "Z202010080013");
        dataMap.put("printDate", "2020-10-13 10:13:39");
        dataMap.put("sampling", sampling);



        dataMap.put("checkUsername1", "陈凤");
        dataMap.put("checkDate1", "2020-10-08");

        dataMap.put("pointAddress", "贵州省毕节市黔西县花都大道黔西北农副产品交易中心A2区二层");
        dataMap.put("pointPhone", "17872561868");



        dataMap.put("signCode", "iVBORw0KGgoAAAANSUhEUgAAAR0AAACbCAIAAADQlthdAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ\n" +
                "bWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdp\n" +
                "bj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6\n" +
                "eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDIxIDc5LjE1\n" +
                "NTc3MiwgMjAxNC8wMS8xMy0xOTo0NDowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJo\n" +
                "dHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlw\n" +
                "dGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAv\n" +
                "IiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RS\n" +
                "ZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpD\n" +
                "cmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTQgKFdpbmRvd3MpIiB4bXBNTTpJbnN0\n" +
                "YW5jZUlEPSJ4bXAuaWlkOjUyRUEwNjhEN0RGQTExRUFCRjREOTAzNDAzODMwRjc3IiB4bXBNTTpE\n" +
                "b2N1bWVudElEPSJ4bXAuZGlkOjUyRUEwNjhFN0RGQTExRUFCRjREOTAzNDAzODMwRjc3Ij4gPHht\n" +
                "cE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NTJFQTA2OEI3REZBMTFF\n" +
                "QUJGNEQ5MDM0MDM4MzBGNzciIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6NTJFQTA2OEM3REZB\n" +
                "MTFFQUJGNEQ5MDM0MDM4MzBGNzciLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94\n" +
                "OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7BhWiNAAA5/0lEQVR42uxdB1gUyRJ2A5sTu0vO\n" +
                "WRBUEAUMIFFRQBQkCCJiwOypmBXTmfVOMeecEFABc1YwYTwlKCgiKiCCkjO82h1YVyWzC8ib/+7z\n" +
                "U5iZ7unpv7qquqoaU1VV1QkFChQiBQblFQoUKK9QoEB5hQIFyisUKFCgvEKBAuUVChQor1CgQIHy\n" +
                "CgUKlFcoUKC8QoECBcorFChQXqFAgfIKBQoUKK9QoEB5hQIFyisUKFCgvEKBopWARYcARUuQl5cX\n" +
                "Hh7uOmzozu3b0NFAeYVCBKisrNy/d89wV5fCosLoe9FZWV/F0UpU1B0HB4fp06ehvELxf4HU1NSA\n" +
                "2XNKy8oLCgpzc/PweLw4WgkK2hJ153bMowezA2YBk/+IkcGjkwNFs1FUWNBZR6ezjnZ45HlNLU0m\n" +
                "kyWOVnbv3n3t6pXcnJzxEyYOHjy4v6UVul6h6NDAYHLzcvPy86o6VeFw4pLRLJakrKzsrIAAfd3O\n" +
                "Fy6cR/VAFB2eVtjPn9Ou3bhZVlZeVSUuDe3Ll4z796KmTJnyJTPrS+YXlFcoOjjKy8qAWhy2pIy0\n" +
                "lKyMjPjWK32DrhIS+LSMjJDTodHRUSivUHRkKCgqdO3aJTMza9gwZwaTERV1VxytEAiEN2+SVqxY\n" +
                "icViSkpKEhISUF6h6MiAlWT0aD8MFnviZHBk5IUXL16IqaGYx0/KKyr1dLQHDxp49+6dgoJ8lFco\n" +
                "OjJKy8pZDFpeXp6srOzIkT5iamX+vLkDbK1YkpIJr99EhEd8//Yd5RWKjoycnBygFg6Ly8jIOHBg\n" +
                "v5ha6aJv8O1bTtS9B8VFRZoa6kQiEeUVio4Mf//x6uoa5RXlJaUlaWlp4mtISUlRT1c7P7/wTWJS\n" +
                "QkI8yisUHRlycvJcLodAILBZrLu3boJCKKaGRozwMu/XDxrKyc093+53sVBeoWgpkt6+GzrEsW/v\n" +
                "3g9jnsTFxYmpleDTwTt376uoLCeTSBniXBhRXqFoF5g7Z/aNm7cjL1w0MzOVk5MTUyuwWGGxmMys\n" +
                "bAwGo6SsjPIKRQeHu7tHxpdMJ4fBqirKkpIsMbXSp28/EoEgKyVVUFg0ceIklFcoOjhycnMwmE4P\n" +
                "YmKOHj+ZnJwsplZeJySMHOmtq9e5E98JifIKRQdHSXFJVVWnrKws+HtxUZGYWpGWkXn18tX3b99x\n" +
                "OOzOHTvb+ZigeSIoWgoyhcKg0WYHzLwbFVVWViamVqg0evSDhzgMBovD3r57B+VVNSorK1NS3p89\n" +
                "c+bBg4cY3j59GRaH27VrJ4fDRafmHw0CQaITpmrLtu3lFRWfP30SUyvl5eW8WVRVVVVR+e8/G1Fe\n" +
                "VePevagBAwYWFxdjOmEqarI+5eVkHZ2cbG3tOtI8e/fu3bNnz+zt7SkUyv8Dr4qKikpKSqytrFNS\n" +
                "UgKXLhvu7iGOVioqKnR0tFSVVS5fvdb+Sx21kn0Fhua0qdPLSssqK6sqhFKpt2zdBmS7cvlSh5lk\n" +
                "sbGxxsY9hg8fbtS9++ngk9nZWR2eV3Q6XVFRycjIkEqlSEtxxNQKjUotLiosLCrU1tLQ72LQ3gel\n" +
                "SvxIT0/r26c3j8QYUAA79evb19XV1cPdzdDQEOmDhrpaVUfBzZs3eFONRpVkMbFYrBSXu2L5svz8\n" +
                "/KoOje1bt8BbU8jkif7jxdTEvegok169CATCrh3b2/+AtAavNv37rwQez+VwgFa+vqMEP79z5xYM\n" +
                "E0KtU6dOdIwZ9jjmEQgPdTWVLnq6PFGC5WkEenp62dnZHZhXCfFxA+xsB9rZ6ep2FlMTd+/c7m9h\n" +
                "ode58wAb67y8PJRXVQ8fPCARCRQyacvmf4V/DpaomampBB4HE9FhsH1lZWUHmGFlZWVrVq+UkOAZ\n" +
                "rvBeeByOv0h3sjDv9z75XTvpZG5uTkREREJ8vMjWq21bWSwmhUpVUVEpLS0VR59fvXwJwwhKoIK8\n" +
                "LGhAKK8QYXPn2rWrv/980aIFFBKRTqXgcLgXL553GPkNS7GNjRWyWAkAK3Zb9ae4uPjbt285Od8z\n" +
                "MtIDFy3S0+1MoZDoNJqHh/vr1wktf/67t0lqamq8XSYu5+SJ4+J4hcOHDsrLyVpZmPc0Nmq19Wrj\n" +
                "hvUODg5BQZtu3LheWFjY7nhVF1JTU3lynS/S79+L7kiqUUVFxdy5c11dXbBY3tsRJCTgT1glWrMP\n" +
                "UVF3IyMi9u7Z1cOwO5PJZLFYXA4bRJgw20NDQ0XSlp2tLUEC7zjYvkA8xiSIKhKJOMLDncOW/Pjx\n" +
                "YyuM3rEjh+VkpVkM+ro1q+fNnhUfF/vH8Co9PR2MXeQDP3v6pEPaHtu2bSUSiQ72Aztra3c1MBBf\n" +
                "QwUF+d+/f1+2JNDVxcXNzc3XdyToAjgcVorL89HhsFiwciVZDOAV4kACGHbv9vVrpkhaX7liOUiQ\n" +
                "zjraWVlfxfF2b16/BmsCqAtS+M2bN+IbxoULF/bs2XOk9wgGjSolxdFUV3NzHWbQRffSxYuNf0ib\n" +
                "x1tU0en04pJi+NiwznZIN/SkSZNjX8UGBweXlpWa9zMX+fOjo6LSMzKAVMuXLcvK/saLnav6cZiF\n" +
                "Sa+eZBL51p07QKXyiopv33ORnyM6gqGRkaj25T9/+gQfMTk5+eCBAzNnBYj8NeUBcrIMBhN0HJAM\n" +
                "4vte5eVlFeVl71NSu3bvHhUVnZmZlfQumUwm0+j0PyaOqaioOOPLF0RTKiws6Kg7PBw2Oys7CyZ7\n" +
                "RWVF854ACxEwAQy2z58+ng4Ofvf+fWlpKYVMKSkpPhUcXFJSyrff2HAZiNjsrG+ICwiu/5CaSqNS\n" +
                "fUZ6DXNxhQ6sW7PqS+bXtPQMkGJcLnfqVJEVPY+6f59Oo5JJhE+fPpaXl4u8pnRg4GIsDkehUvtb\n" +
                "9ldQUBDfx1qzZi38D395+vSJ1wjP/v0tDh0+amlp2adPnz+GV/Dh8TgcyNHKyvIOHNBUUlLC9w5W\n" +
                "KSkqNv6uuLjYuLh4mKzHjh4NjzwvISEB+hu/nkQZrAxVlZVkMqm0tAzGDrS7wqLivPx80JNyc/OG\n" +
                "DRtaxV+Q1FRU/MaOVVFRJZFInXjl1D98z8lds2bNjBkzuVxORHh4127dRfWOuTm5hYVFQKeQkODx\n" +
                "/hN0dDqLdgyNjAwT3yTGxcclJSXBO0pJkcT91QoLCj6npctIy+h30R3h6d7u9oXrwefPn/F8Mxom\n" +
                "ARjZHdK+in31Ukmpmk5bgjbVaR3l53/jA5jz+nXCRP/xTCajxg7iCSAuR5JIwONrvA5gLME/EI+I\n" +
                "tBSXyWSuWLE8IiLi/PnIWp+flZWlo6PDSwpU5An7v/9eIdrXDA4+BbSnUMhXr1yqqKgQ/RZZQjwY\n" +
                "V2Ax9jQ2hmVZeGMjhw+Rt7hjR/XJQyC/mnpvG69XoCjDYgV/IRGJHTKa7l50VP/+lmXl5UAMb2+v\n" +
                "4W4/YueAAMXFJZWVlTAX09M+r1m7jm8aga5YWVUJhlAOqMdSXC6sA8WlpXBZdjZodzz3Q1f9Lgbd\n" +
                "uoHuB8+EGQyq16yA2aqqaixWnTmF2dlZDoMHp6Qk83ywHz85OjrMnDlLtG9qYdGfRgO9tOzkyVNm\n" +
                "vftSqVTRPv/mjRswUEwGM+VDSlFREciRav0zKsrJyQkW6lWrVo4fP0GEkXeLFwdi+Bji5Agtkmsc\n" +
                "bH/AevX1a2a1PorHRUdHdbzFauyY0aC/wYyPjAiv8X1HjfEb7eHhTqdS4Zsha071INR46uRlZZB1\n" +
                "iUwiqaoowUMiws8Fbf4XNLeQkJBmONy2bgmCpykpynfiVXqRAftH9MtybCy8jraWBrzCgwcPRP78\n" +
                "QwcPAG+tLS2IBIlPQn52sDMV5XnvJclipqSkiGyPZE4AyDUalQI69v3799vpvnBd2L17FzKlNDU1\n" +
                "Xr9+3fF4BVqKYBIDK7Zt22pm0osXN8hh9+7VCzikLC8nLSUlLOlgdhKJBOMehs7OzkePHAbNsIV9\n" +
                "OHf2jLCshQkqjjd99eoVPFxGWoooIfEx9YPIn//82VNYqykkwrixo8FeFfw85HQwlURCFOYBAwaI\n" +
                "pK2nTx7XfItO1lZW5eVlf5ge+OVLBoY/k9zdhmtra7fAN1qen59/5crlsLAzEnhcaVm51whPpyHO\n" +
                "ba4Hgg0Ewu/ggf3Bp0OuX7vqNtxVTU3t/sNHmVnZmVmPcDhcbkFhZVUVLGggGpcuXSbJZiOx26Zm\n" +
                "pgwGs+UdAGIHbd5cWVEOgwzfe/Omf3xG+YrjTSlkMs8fSCYVFBJjYmIUFJVE+3wiiWRm2otMJvbo\n" +
                "YcyrdpaTs3LliuTk949jHgUFbb527drp0LA3b96IpK2XL18yGXRVVZUX/71avmJ5c44galtxPgdW\n" +
                "W76oWbF8aTM1yczMiIjw/hbmMDVBjcLynNG8B27695+2fbWM9PTwc+eASEjHKCQSQUICLIRq75Zh\n" +
                "9w3r1jx6+OD7d154EeKuEEf4krl5P1AmYRmBRsHmycz8Iqb3raysWLZ0Sa+ePXoYdjfQ79L4GxsZ\n" +
                "H3To0AE2W1JGRkpZSfF08Ck5OVktTTV+ekSfsWP8kHCWgFmzWv4iTx7H6Ghpng0NGTPa18SkV/Me\n" +
                "0sa8srGxQTxaWzZvatKNaWlpU6ZM9vDw6Kzz0ypHkMADr8CKzchIb8P3ggVKW0tT4JsRKHhga82Z\n" +
                "PevC+cjCwoJW6EY2v+YEkjQgJSUVFxcn1ua2btmCmMpDhzg1ePHMmTNGjPAc6jykj5nZ4EH29UQz\n" +
                "fP/+/Z+NG0F5FkRgKSkqQCtAM8F3NzMzjaixYFsIKytLRXlZy/7mXC63qKjoj+TVUGeeqiYtLfX+\n" +
                "fXJj/a3x8fv27YFbBFGtGIE3ugbHjx9rqzcKDw+HufKLvQQ8d+K54P769Olja3bm+LGjKspK8D+d\n" +
                "TouNfSXu5lavXo0oC2P9fGu9oLS0FPSL+LjYif7+gvExNOwKJBk9evTv19++dQsox2QyR3p76nfR\n" +
                "Q744g05DvjdYoX379J4/fz6s9mVlogmiz87O5nKrUzOnT53S7Oe0Ja/y8/OMexjBCzSYtHP58qXR\n" +
                "vj4eHu6enh4wrMLWi3BICyiBFv363rlzp41eJ//woYPI7hBCdSaDYWTYzcrS8sL5863fn/9ePIcZ\n" +
                "CZMPeuLrM7IVWgRe4fhTf4Cd7e+/BRt4S9BmXR0dJImGn2hMG2xvB/+UkZZO+VmwPrgfffzoEdBg\n" +
                "5aSlgU69ehqrq6tWG3IUslV/c1idwkQUMSykBH22s7PF47Cqykoa6mpv3yb9kbyCVQUZKbBAar3g\n" +
                "48ePFy+cP3LoIMxSmKk4obQLTXU1b68R96Lv3r1z24WP4cNd586d/a2N0gdLSkpUVJTpNMrWLZus\n" +
                "rS15sUsczuZ//2lScoFoEREezk9YUgfhc69V9jA2rF9PJhI5kixNTU3hnxcUFJw9E2ZmaoKIG2VF\n" +
                "hS66vKRPYBSIRUUFhdCQ08LXP34co6yshGw8cGoKfQYuXqisrAArP5lE9PbyFHnnwb6Vl5eDDg51\n" +
                "ciQSJHbtbFFWclvyCqQXMmRgcghLNbDjr16+6DvKR0FB/iePEEECJmsPI8Pjx49npLel+fS7JF64\n" +
                "YB7ilkV0Ujtbm5aofMnv3o4fP3aEp8cE/3EfU1Ob8YQvXzIsLS2QcVuyZElreaHmUCkkUChMTU2q\n" +
                "Fb+SkpkzZ+rp6Ung8YIS08A9KoVsamISfu5ccHDw168/tuPA8nRxGSrBjy1ErCkSSWLmjOnXr18D\n" +
                "Kdy9W5fOOlpAxYsXIkXeeWtra6A5i0FTVlLo17dP1tevfyqvpk+fKtjbhn+GhoZGRETY2lhJcbm/\n" +
                "BCwrKym6ubkdOngATNji5pqS4gPoMHzpyxO/BAmJv/9e3owdD2HY2dkJbDM9vc7NCAvy9vZGnqAg\n" +
                "Jwcca51xuHL5smFXAzaLqaqq+vFj6tMnjw0Nu/OqoHXqpKOjPXcOL8hdistxcHQc7eubzQtEFvLC\n" +
                "PXk8erQvhURE1jESgaAoLwNqyLRp1UbOh5QU+4F2JL5aG3VXxKr+1q1B8PGsLXnZBhoaGrm5uS18\n" +
                "YJvxCuSBYfduyLf3cBvet28fvFC+HcwnWRlpORnpER7uZ86EwUeqaseYPGkir898kz08/FzLH3jq\n" +
                "xAm+XCfwYtgx2Fcv/2uaSvP9O1gsiOt5pajjAOuHk6MjjUrFYjEcNptOo8lKS9NoVCT7C7B69ap3\n" +
                "72opRvDo4QPEDoQhxPIuxXTu3Pnizx7CxDevA2ZMl5Ligtpia20lwj7zkrutraZNmQT2nqqKcnFx\n" +
                "ccuf2Ta8evTwobGxca37aZIspoe7+7SpU7Kzsr63ONSgFfD58ydEIuDxeHd3N1E9dsb0qTJSUsiT\n" +
                "p06e3DSeT57MoFEU5GRg2RcOURU3Qk6fBgWPxIt+wPC3y8h0Ki/mU11NZef2rXVt0D18cB9RT3qb\n" +
                "mYIpCOub23DXDx9+jdiwH2grK8OVk5OlUUjLlwaKsNvAf29PdyfHwdCHY0cPi+SZrcorJF572ZLF\n" +
                "JCIR87MnmsVimffrc/58pAiLmbQCQHsR5AL93dyt7VrxIeW9nKwMMjhg2b94/qyRN+7fvxeJdpdk\n" +
                "MbYEBbXalw0ICOjSpYu2hhqL9SNMhMlkbt0SlJ5WZ5mXgFkzORxJeVkZUxPjLrqdsRhMyOngWq8c\n" +
                "5uyI59PP33+cqLpdWlo6O2AWLJAqygoECfwy0dG1lXj1OOYRqNdAHrbkj708AbX8x4+DDyMc9PVH\n" +
                "4N3bJBCf8FXIZPKZM2dEPmKILQHLIKj+TDr9v/9eNOiTDAsL1dTUDJg1g0wmmpiYtA6jdm7fLlnz\n" +
                "WUlCJ/86OznUH0RSWVkpJyvLpFM5bEkOm8Vms86eCavr4ksXzhOJPBtWWlrq99WseUhN/aCtXb19\n" +
                "P2XyRBEOi7h4lZeX9+BeNEjZqVOm+Iz0Ftb0YGwU5BUE+aQMOu1LRkbVn4ZPnz6CBYjD8rz/4vBi\n" +
                "FxYWmpv3lZGWEk7BenD/Xn0ma1YW2B49jYzCz51hMGi3bt0S9yDExcXp6XaGRon8kA4Gg04BLRC4\n" +
                "RSSAagdWU/23A69u3rjuP84P7h00aCBo1PVcHPPoIRicHBZDQV5eJHHr27YETZ40YeIEfyRcuNZy\n" +
                "N/n5+Z8+fWpG7UdR8gpYFBIScvXKpXlzZ4P9h8PhEF+QANpamr6jfBISEuB70GlURAt3HTqk6g9E\n" +
                "UVGRrbUlHo/t0cNQTJUPQUXp29sUCTIgk4jIcPn7jw8LC3ubVPuWpa2NlV5nbWcnxyOHD4lNYuaC\n" +
                "zQbq+swZM4h8zwqsS5JMBl9EUpUVFZBYRPj6jdxXtR9gC0K2wWpcTg6DB9hY9THrNcrHq+WxlJs3\n" +
                "bapRmjDQ1Ye1JbZcOB9xYN8eU5NeCgryhw7ub21egSbAi4TwcKdSyHUl2w9zdoqMiBCsSz4jRyDh\n" +
                "EUpKSgkJ8VV/Jt68fh0cHCy+QraODoOEDZXLly/Z2tog4wka9epVK0eM8Lxx44YgkSRo8yakBsbF\n" +
                "85Fi6lJBQcGJY8e66neh86NeELcKi8ngcNi7dmx/9vRJbzMT/hYWT2g+edKoAlswAV68eNHgZRoa\n" +
                "GlqaGtAQmUx6+/ZtS97i5IljWEwnF+chFAoFdPj793haQFLiG9BBYl+9dHQYbGVltWXzJg83F+C8\n" +
                "nVV/Cpk43NWlVXlVXFxkZ2vze4QeEm/q5jbcxcXl0KEDwhId5gGZv01BJZMeND1j7P8H27dtFUSa\n" +
                "yshIIz8cPHiQYJccGXawNw7s33c+MlK5JtvfxtpKHHEe4eHnlJWVWPy684hrBGnOx8dbEOXs7jYc\n" +
                "TDsalQw9f/z4sQhbnzZlMob/whvWr2uJgnDr5g1lJQUNNVVry/7Q+c2bN/OncTFfeyWM9h3Vt2+f\n" +
                "BfPmprxPzsr6ypWURAJ9zMzMWolXoHpuWL++W7duSJwBsu2Ax+NAlC4JXHzj+rVbt27WemNy8juE\n" +
                "htJSnA8fUn4x1n19fdLS2lGV4P+ePwfRMGfOnDZpXUNDHVkTFBXkM/lwcLCvLp82YbyBvl6tEg0Q\n" +
                "EhxcKaIiE7xMp79XTPQfD1+YKCEBCjyJLxah6e7du/5iRJmZmiEbu2ACNOhoaRKGOTsTeG4L/N7d\n" +
                "O1uivWP4SjWTX7TMfoAdom5UVFQcP3Hi6NEjwhdnpKdXH2VCo92uYzKLmFcv/3uhoa4mlNNGGurs\n" +
                "7Orq+uTJ4wbzW0G8IXf5+fn+khC+dvVKAgHPZDLWrF7VTvaCVWqOXh89atTzRju7RQWTXsZI3VIQ\n" +
                "WqB6SQjZq/PmzunT2+QXCxZhGQheFWWllhdbhifs2rlDSkqKV6GSyxHSRHCDB9nPCQj43c7xGuEJ\n" +
                "xhKJRAIGiHbLxGHwIAIeT6VSxo8bA+po8x4yc8ZfIA4662iDEWjer2/9m3uBixeOGuk1cMAAeCOx\n" +
                "+y0+pKQ4DxnCYNARieXs5HTu3Nmou40tpQREAhmMfJ7TwSeFf/U6IZ7LYRNqtAtQby5futjmvJo8\n" +
                "aQI/0YOAw2JIJMLr1rIG4ZOvWb1SeDkaYGfTv38tZT3xP9eFRr7LmjWrm10UCSRjdHS0t7eXICBG\n" +
                "YCfDkrV82dI7t2/Xde+4sX4gZJHoiufPRCmGQLllSzK76etBT169ak7Oy/NnTwXFlUE01B/elZGR\n" +
                "wUuUnPFXwMwZYIM1VUg1mVdv3rzma/adhg11Xr5sWZPuLS0pmT9vLvJiLsOG/vLbJYGLhOYKEnmJ\n" +
                "3bY1qG15lRAfx1NweUo2b/p6ii6iolY8fhxz9uyZxYsWSApt9CGQlZER/qdxD6MxY0ZPnTJl/dq1\n" +
                "To4O8BNTk54jvb1gYDc3MUlUgLKy0g0b1lHIFFBGSEQCsg+LcBv64zZ8+N07t+t/Qs+ePZFbOJIs\n" +
                "0VZ7Bk0MJEsXPV0mg968WOStNXHegFUr/67/4hk1wasMOv1h08vgNEcPTHn/PiK8ObmZqampyKdi\n" +
                "s1gZvx21MvOvaUyh3CqBYjNBbEeVNU7IPUMmCoNOw2J4nR/u6vLu3VuRN/Tq1cuxY/2I/H1VkKZg\n" +
                "qfJN1h/xx6Dd7di2NSQk5MKF82fOhBUX/xR/fP58ZMs31hMTEykkYld9PWsrCzVVFXU1FZAoXA4X\n" +
                "tLvk5GSBeTx+rN8QJ8eDB2pxPQ93GUYmk9hsyYkT/Vu4/QC3w6INCg6sFWAXDR06hMvlgB7o5DCo\n" +
                "efWkcnK+29nacDmcFcsbWA94u2pj/RbOmw3DPsHfvxlttWocEwwT4uDyHzf299/a2toIXExSXDav\n" +
                "BliNhjPGb3Rb8aqsrGzbtm2g2yAV95H+dO/eLTz83K4dOyJFkfsNinRgYCDiDACoKCtyOGxh7Qv5\n" +
                "y0ivEeJ+2a9fM636W5iZVIduammo371zKzf3JyPKy/NHCcRtW37VJkxNetFp1F49jTduWN/CzmxY\n" +
                "v47LZvv5+miqqx09cvjY0SPqarzURrakZLNt78rKil9e53cUFhRISEh4j3BfvnQxmUT+Je6+PfLq\n" +
                "7t3bCK/GjqmFJ5YW5jUBGbi42JezZ88UXrjG+PkWFhS0FbsePLjv4e6GJJn/gvBzzYxgAuN769at\n" +
                "VlaWYBZXB6pSyGBCgJoNPwHbJjIiYs3qVSChkWgGdVWVpKREcb/p9WtXSSTSUOchYNwm/xx7DgsI\n" +
                "6Cnamuo8K4Xf4aCfDwrk+QPNTKk0ntKxdu2alqnf8YbdDAy7d0UG+eyZ0POR4Q6DByoqyMMqLg59\n" +
                "4YdW9SEFRANSzmjtmtXNe0ir8srLy4MvgDEgBX+l3J07UlxOtf9dmgs/gbHT4x8lKojb0NLSaFtP\n" +
                "hrvb8J826PiGV/NixqOj7qqqqNRWLYwEBtKVK1eQbIXbt27JSHOlayIYLl68IO53BBWrLo/u58+f\n" +
                "oBsGXXRhcsObz5k985cLKioqpkyaGBl+DlTBgFkzW9KNwYPsYS70MOoWGLgINPC9e3f6jx8DQ43j\n" +
                "AdvCfeH68de0qVQy73wjWLVSGl12pc14def2LSl+AcrVK2vJCIqPj1OsrgzRaWngQoFE9/cf+8vM\n" +
                "O3bsaBtS63xkhFZNoaXqCrVY7N8rmuC/2bhx47Bhw5AjvR0G2Xt6uNWof0onjh/7pSzRfy9eAKkk\n" +
                "JKqd6ZEiKjnUbEEuxZVEqiFAl37feoYFzX/cuB6GvLMUdu3Y1nzt4P59Go2XxNW9W9dVfy93dBwM\n" +
                "QnZJ4MLt24Ik+cHy4lu3t20NYjEZ/fqa0WnkloR9thKvCgsLlPj5FDAPnzx5XKtSq6ujU503HrhI\n" +
                "8POkxDdODg5Ifo7A3AoLDWnD6RUX9+oX17aurm5jbrwXHb1ixXIkVIJGpbJYTBkZaRKRqK2luXjh\n" +
                "gro8ue5ubjJSHHl+zsgl8a9X9WD+3DmwEPXpbQbqg19tFi/wCq5Zt3o1jUL53fRqPObMCYAR1tXR\n" +
                "RnY4UvnVcx8+vK+v30VCAi+BwyUmioVXiI9KVUWxs47WsJaFrbYSrzIzv/AXcCyZSIDp9fsFT588\n" +
                "ZvATS0GQ79yx9ZffOvPLoQmCekhEQl2Bp62DhQvmsdmSAo+CnZ1d/ddnZ2fPnTNbgh8uYNS9m4aq\n" +
                "cnXCOR6/ccOGrKysepVPNyqZJC3FO8Ro357dbfjWoFDAdPf18SISJVJrqxQN0tPCwnzC+PF0KnXG\n" +
                "jBnNayUnJwca8vJ0g1dmMBhfvlQXEgVeESR4blJglpiOBndzGQoiD0nPEc4GQPIG2yOvVv69ApmC\n" +
                "/S3MS0qKazXiTU168euEEH7fJHn8+PGwYUOFnc59+vQWx2EwTfJt7tu7Z8QIz1EjvevaToGXCgsN\n" +
                "HevnJ6jYARY/k7+lDhqOh4fbtatXG2zId5QP4tWAOX06+FSbvCyofL4+Pvw+YLsb6L14/qzWwT8T\n" +
                "FipV48kMXLy4eW3t4Zfsl5WVBaGzft0P58eVy5dgBMz7mElzOQf27xMozO/fJ3/69Knl77hv726Q\n" +
                "e2QSEfRPQcRCbOwrMHeB3iwWy3fUqHo2xNuGV/1rfH3/bKzT/Tp0yBBkp2jrb14mBFMmT0Ziz5BH\n" +
                "iXuLtoXuLDc3t65dDZC5yJFksRh0xCsDEnf69KmNj4sdM2YMhUSikEkwq86ePds2r5OQ0FVfd/my\n" +
                "JUoK8nQata6ToNetW2vWsweSARQQENCMhspKS2k0GsggggReTlZaeF36778X/JhSrqqyIu8CgoSt\n" +
                "jc1f06d5urtqaGgiRZ2aHW28e+dOQaiKkpIS8KqoqOjkyeO8XLKa7DIkUjzm0cP2wqvk5Hd0vo6n\n" +
                "oqRYUFDnYendu1VHzSxcMLeua4I2b+Kfp1ZNrbCwkHZIqmfPnoKEw/Bze3ixyHzfBrLgDBs6NDo6\n" +
                "uklP+5qZCcYVsmRduXy5Td7oQ0qKn++ooE3/aGtqLAlcnF5Hkbm1a9eC1GDQaCD1/9m4oamtlJSU\n" +
                "jPQawbc/CTQaNTz8nPCqCDpL9aGykkwdLQ3ExJXA4/bs2jHQzsbCvJ+bq0u3bgbh58414yRyW2tr\n" +
                "EF5G3Qz8Ro28fy+KRJQQFKsEtRDDi7eprvtPJpPbBa9yvn8HBQ+ZFvUnh7kMrT7+Y9HCBXWN+949\n" +
                "uwWbs/CN3ye/a1eMysvLGzduHFuSZdjNALqJyDlgF0uSNcje/mojtL5aFM5v36wt+zs78SKVzoaF\n" +
                "iimHsn6cO3tGoIHXE/W3d88e+DowEbU0NZq6dACFHty/R6dWx+9NnTLlN6fCU0kWY6iz0xDHwWoq\n" +
                "KkweGFh+iP28OQFysrKCHuroaHt7j7jYuBrDZWVl06ZOhkUJjDc6laQoJ+swaOD6tastzPtSKBRQ\n" +
                "/4x6GC0JXCgjLa2kpEgkEkf7jmoXvFo0f37NWZ1S9Z9F8DjmUfXByatX/f7bK1cuS0tLC1fFGD92\n" +
                "TLsi1dkzYWpq1bWOQVdBNhbhxRcsmN+SM6xAw1GQl4f/QUJraWgUtXr5xLdvk3Q76/D3FaX7mJrU\n" +
                "dUzZ9WvXRni480r/EYnq6urfvjU53dPaqr+ighySHP17VdOHD+7Dw2VlZbS1NN68TgD7NjExcfHC\n" +
                "+ZMmTnBzdf09p9aoe/eIiIgGhwsUKPN+fRwG29vZWjs7D7G1tY2MjCwvL4+PjxN2VygqyHu6D5eV\n" +
                "kQEStj2v3r17y6qpA7x39676L75x/SoSPdhFT1cQqAKvvXTpEg8PdxAoYPELDungcDj/vXjefkgF\n" +
                "4tayfz+YEOqqKoo1ZXpNTEzu3LndwieDQO3Xtw+iRlLI5FQxHNlWPw4ePFAdestkbPp3Y63XvHr5\n" +
                "smZx/lFzAZZomKZRUXdhdtZflA9G7+KFSHlZab5IUvpnw7rfr4mNfYWriXdJTHzzyxBdungxJCQk\n" +
                "NDQElCPQRTnsavfJ5EkT4Lf1D2/9r19cXDTBf5zgWM0zjTM9OolbhCNaG51Oa9A3evPmdYGOh3hX\n" +
                "jx07Ap9HsFmE4Rv9PY17HDt6WBynRbUEly5eGO3rA0au46CBaqrKILP/mj5VVJ0cN2a04Oy2Boux\n" +
                "iByfP33iedjxeBaLWVcVCnhTsBvxeKwE7yQKHPKxZKTYXA4vzhMUKn19/ZiYR3U1AYoMhpcIY929\n" +
                "q94Yv1F1qDMxEhI4JMzl5Ik6z4vJysqKiAjPzPwyYcIESf6BywcO7G/J68PThM9bOh0c3Ma8AiIh\n" +
                "rnN+INmmxghmwSLu7u5ma2NVc/A7Dtm8GmhnFxoa2oZRgvXAx2ckTClegA9fNNy5LcpaSNu3bamp\n" +
                "ASzTyu9VWVnRp7cpMqtAD6znyri4uK4Gevp6nRE/DYfDBuVKWUmRw5bsYWTIz3OR9nB3O3ni+O/3\n" +
                "DnFygqnSt4+ZspJ8WFjtp4TcvXu3Ez8lHgyqK5cvNabz0KWgzZtbeL7uhQsXYO6N8fMFld7MzKyR\n" +
                "Pn0x8urokcMIMTrraDdmr+nypUu1FMnAYkF19vRwnzt3TqV4Nqxyc3NjHj1KT0u7dvXq6dOnm2cL\n" +
                "xcXFSnE5ZCLB2to6PFzE0UbXrl0F4QLWBY1GbbBukWgRfOoEQQKPFHn2qjeg/s2bNww6XZKv9i9a\n" +
                "MA9WsOTk5IkT/OELIhoH4mEjEiSOHT0i7FEEAwmE0ehRPnKy0l6eHnU9PyYmhk6j4Hknm2POtKIf\n" +
                "GHqLxWB1tLWwWMwvZSPagFfxcXFEIpEtyYJhaDDiG6YyaOHIhqlw1U4mk+k3ejT8SlS9QizRvLy8\n" +
                "0JDTw11dJ0+aGLh4UfduBmAXqamqkPhV74wMu0Gj7m5u2dlZ+flNyBK9Fx0tkuLsvwOIykus5M/O\n" +
                "Yc6tWhYOhqWXcY/B9gOg6frdTnGxrwTfTlio3759O+T0acPu3QTb+sgOJFLFZBR/uxk500xdXf1r\n" +
                "3ad4gB7IK1JNJMJzfrGvxAfQJxUU5JCer1m9svE3iotXy5ctRVQXV5dh9Vz24sXzjRvWC9dOEMB7\n" +
                "hGcLa4sj5YtDQ3g4Exbm5eXJZktyuRwpLpcoQUBsOcWfjwJCdE4qmQTCCdQSLkdy+bIle/fujRAP\n" +
                "YRqJkydPCno4bqxfq7W7Z/cuSSZDSkoKlLq9e3bX7+JfErgI7CtkUfq9ElNxcTE8TVlJqU9vMzqN\n" +
                "ampqCgJu0aKFoFyBPAWmaair11/FNioqiueT5HJA/KWnt0ZlocLCwt5mZkiSAfx588b1NuYVLAjI\n" +
                "RjDgzeuEWq9JSkoa7TsKUTBgcIXPjEOwNLDJgTClfHz6+HHjhnVWVv1B1lpbWdZasQg5rFZHW9uy\n" +
                "v8XcOQE7tm1dsngRKKLnzp27cvnyhg3rWUwmErUNf8rJypw4cawNeRUdHcVkMLj8EKFB9gNa52zi\n" +
                "L18yQO1EcsO6djVo8Pob168JxrauyoGfP38uKSkBiwX+DgotphMGni8jLQ0KXoNnpkRHRyOTBD5n\n" +
                "fFxsa2iAx47aD7CZP3cOLzvGwKBJ0VL4TmLAgf378gsK1VWVnZyGaGhq/fLbZ0+fHjp8eN++vfn5\n" +
                "BchPysrLgWAuTo5kEuX6zesfU3l5PiVlpY1sDuQKkCExKfHShfPl5ZUpqaklxYXpGZnwq+T3KdXH\n" +
                "QCnI21rb5BXkgT4Fq1Y3A4Mu+vompmagrP5OPFs7uzFjfuSnUCgUQk0kS5vAzKy3n6/Prt28Aw1S\n" +
                "Uz/CMk4mU8Td6KqVf8MH+mfD+h07tm/csKHB65WVeRWOYSzBlq4oL6/1GuRoOXt7Xqm2l/+9UFZW\n" +
                "KC4qKS0pHjt2bBd9g/qfD6slWHoMJivjyxcajdYKw3708KF3ye+zsr/zkptWrZKXl2/CzSJnOUh9\n" +
                "mKx4PE6ay/4otNkCsyE1NXXK5El8UwErmMxcDse8Xz+BA83VxaXmu66o31LKzs4G43jRwgW6urqC\n" +
                "oEHe6ofHU0kkkLWg8kmyWP3N+x47dqz1t31Eixl/TUPebkTdlr0IAR9LTUUFPqKRoeEoH+/G1JNw\n" +
                "G+6KlOUgEgjPGqrEBDqhqUnPpYGL4BY3t0bFeX5Iea+vp2Paswesh/Pmib2cIwhrWVlZZJIGLlrY\n" +
                "1NtFzKuvmZmI7oT5OXviccwjDodDp9OQxQEJtZKTk122dDFwQ9hbaMmvQgpYvKiWaKaHDx9ERET4\n" +
                "+oxksVgy0lIgQhCCCmiqIC/n6eHuMmxoUlIiPJl/UnpZ1Z+PSRP9ead0Mpkwa69cuSLWtuBzTJs2\n" +
                "xca6P6LMZ2c1XOAhNvYVrOrIJ5g/b0797t/I8HOYmqzQxouJjx8/IpXfYQo1MuGt2SguLnJ25kWB\n" +
                "E/mTuann+omeV5MnTaje555YXcUmIT7ed5QPh80SqFsgb6hU6pLAxR9rW0OGDh3CK0WExcrKyCCG\n" +
                "BNAjLy93184d8BxBcZUfjngMRlpaGgzrlSuWXbp4QSQpA+Kbr/n5+c27l+ewxmGRbNnr18TLq+Tk\n" +
                "d0j5J17a784djbll5cq/wUjmnX7SUAmxo0cPg3Q4cewIfEp1NdXSRteQgtGbMH4ck2/39u3XT6wj\n" +
                "sHb1at6BqGq8QgnTpkxuRkymyHhVWlq6eNFCQfYhLBo3b94ICJhJEQrcArYoKSkGzJpRj1Z2985t\n" +
                "KoWMfNS1a9ceOXxYRVlJSoqL+fkAbyVFBU9PjxGe7nfv3s7Py2vNUwmbh+zsrIkTxut36XzwwL5r\n" +
                "V6+UlTUtM+9jaqqOtpaasgI/5e6G+PoJzEd25An8KpHx8XGNuQvoB3KTTCbJycq8q7v4xOlTJ/m5\n" +
                "VTLLliymUclPnzShgHtZaemM6dOM+VvMjo4O4huBB/eikWpzwHwYiubpOyLjVXp6Wj1WHJVC4bDZ\n" +
                "a9esSW/EOfaCvGDsb05ChLcK8vJ1pQC1W7x5nTDA1sauJohk0YL5uU2JcgJaammod+UXZA8NOS2+\n" +
                "fi6YNxeMX1h8QJD5jfbNb0SdVxDnMONrzmeQSXxTe3wDaBNMMASQz4rBNDIgSID/XjwnEQmIBaGu\n" +
                "ptbIQ4CagYF2NjT+aa7Q0MMHzTyXQ2S8ysvL09fvoqyk2KvnTwcHGxkZ+vh4v01KbMySAtds374N\n" +
                "2fsT5JkJP23oEKfzkREtrzze+qisrFixbInAvwIGIRicqxuquvrDcP36VV9P968pk2DGD3cZ1rzC\n" +
                "lA3i0cOHgk353o0+QePLlwx6jYMOi8EumD/v92uCg08hBhUSwHrkyJGm9i2OF3dbXajUwrxfgXjC\n" +
                "2VatXCHJZHDYkvAiK5Yva/Y4i9K+unr1srKigqKCHCygbEnJlSuWh4WFNvJ0cTCiVq1aqaeri+zH\n" +
                "/xIczWIxra0s27ZqigicOl8zDx48uGfXTnm+u7k60Wjy5MZInJyc76rKSgpysjA15eXlxCFZsrK+\n" +
                "Mhl0mPc9jHgFlZ48jmnkjS/5mbzVuU9ammmfP/9+jbDDNqRZ6+2rVy9BplD5B4FbW1mJ4wM9f/ZU\n" +
                "0ElXl6EteZSI/RZHjxwe7eON5K40XqEfN8aPzWb/EsSEkAp08aWBi9LS0jqGWw/B06dPhw8frqVZ\n" +
                "nfMCKof/uHHnIyPrt9ot+1sg1w9xdBDHaPiM9AJe9TI2Ah1h7549jb/R28tT8OF69jSu9ZqZM2c6\n" +
                "OToQCISgOoosNIjbt24KWjE3Nxf568OQWvTrh+dXNwL76mXTfYBi5FWTkJubu2rlSm1tbVDokRQA\n" +
                "Fou1du3qB/ejjXsYYfgl9b5kpFd1UIBqt/LvFaoqyryDpPiVMNatXQ1jUqv3CaTP9KmTkbQ/sFRF\n" +
                "niYzdSqvzL+SgrwUl/PvP01LoZ/oP+7HjO/bp54r7969U9TcEhTGPXqM9PbqbWbKDzoZKPLP4ekx\n" +
                "HEnKBBOu5SehtBmvTp44LsXlgnjA8FcmMKO2b9uCrHIgm/X19XnBI/r6VR0debm5586Gbdywjsbf\n" +
                "LBo00K7WzR/QFTXUVZGSLFwpblGRKI9jPM03fpBDJ0BUN1J1F8DRYbCAVzbWlmIaqL17dvuM9O7L\n" +
                "T/G0tbUR7cPjYmMZdGpvU15ak7co6uC3Nq8+ffy4ZtVK5DBPGn8nERZeEHJXhApEp6S8RxK/QXjs\n" +
                "2bWr6v8AkyZOAJw6depe3WkggYGLkCo0bLZkWtpnkbRbUlKyaOFCbU3NIY6DaVQyg0FvfCoEgoKC\n" +
                "gl69jAX7KxwOR0xD9DYpScDeBgs2NglJiYlYfs4iFoPx9fEWSfhl6/Hq6ZPH+/ft5SeQ/rCjhjgM\n" +
                "jrp79/dU4sGDq0/7XFibc6mDARS/N43IvTt86ACJKAGrOxaDvXv3tkiaPn7sWPVRn1QqFou93/TK\n" +
                "yfv27vn5eApxnfxy5/YtE5Oexnyfir3o9MBv2dkmPXvAY7t21ScRCZk1ZUBbCGwrxC+Wl5eD1mdh\n" +
                "buE3ZmxpaQniOp/517SLF86fjYjs07evoP64UL5G9U8ePLj//du3Th0aMCBa2tqNCGxVBQ2xE/+/\n" +
                "WzdviaRp3lHVvKMosUpKCi+ePzPt3aepTxgyxHnAABt+wCfG23vE3n37xTRKWVlZSUlvv37N4oVW\n" +
                "ZWeL6rEuQ4ckxMcrqyjn5eZNmTqVyz9CQAQQtzAODQ0x79dXeA5RyKQ9u3c3tDS/QTI1QO150Z7q\n" +
                "w7QhIiIikJwaPB63vmWn4AjrgQkJ8UcOHWzJdtDBA/v59Ubx9Z8s2kJn3ZTJE0FJM+QfqjBokL1o\n" +
                "3NeHD5GJ1ZkKkyZNEmGHxcirbVuCLPtbCG/sgtk9duzYJ48bjl5JT0+XqKmAk9C4UJr2jJLi4sLC\n" +
                "whaW/gs/d5ZAwJv1MobFYUng4nb1gj4jvTZt2iS+5wOvyGTy9KmT7QfaTZ48+fcqaM3ArJl/KcnL\n" +
                "2g+whTm2fNkS0XZYLLyChXXJ4kU/TrLBYHoYGY3w9Gg8Q9LS0hQV5DGNSBj5I5D2+bOebuchjg5b\n" +
                "t25ttqP5wP59YAIh2Y1eXp7/b8u1N78ULkiWkNPBLX8arFQ4/rHRgFE+I0Xe204ilytAA8Gp4wic\n" +
                "nZ2asY+5d89u5PauBl06wLQA6YhUSB5oZ/u56UH3YKPOmR2ATAV4zuhRo/4PNeGTJ09sWL8uqcVH\n" +
                "yezasY1EIHAkWQQ8TkFRQRxZ/aLk1dukRBsb65+PcJeeNnVq8/SfUydP1Bzma9AB5sTHj6mWFhYO\n" +
                "/FRZEpm0cMH869evNf72oqIil2FDySQir7oOBvP/4CYVE06fOsmiU5GYHkU52XfiOfpRNLy6e+eO\n" +
                "t5cXsrOJpBhKcTlr1qx596759dMPHTqI8EpSklVXiPQfh3179wxzdiISJZAwyEGDBj2439iI6bNn\n" +
                "wqpr/bLZnz9/QhnSPF2aTCK4uQ7rrKOlICf36OFDMTXUUl7l5eUOG+r8S2bHoEEDs7K+tvDJ//77\n" +
                "r6As1pl2eW5I8wAaHSxWXfX1qg8ZwePWrll14cL5BusBz5wx3djYSEtTA3iFMqQZgEGW4rC6GeiR\n" +
                "ySRPN1ek0Fp75FX4ubOddXWE66uwWKyJE/1FEhUKyjRSXwqHxW3bGtTBvnHsq5cW/foKqn4DrCwt\n" +
                "EuLj67q+oKDApFdP4JWerg7oBbGxr1CeNAlbtwYx6NSu+rq84p54vLjLmzafV7t37yIRf1Qp6t7V\n" +
                "IOX9+5YcnPELDh48QOAnF4ClPm/e3I73pWGBOnhgn3m/PoLgfQkJiRXLl509e/b3tB/4iaAmFJVK\n" +
                "EVUc0/8JwkJDiAQ8k0YlEwk9exg+jokRd4vN4VVeXt6ypYHCW73+/uMyM7+ItmdHjx4VPH/unDkd\n" +
                "9ZMDYUJDTysrK8JHF8ip3r3NPnxIEc7LunL5Ep1GZfFLAvfs2UNMB+x2SJw8fsysl7GsjBRMpOEu\n" +
                "w1pn6JrMq6dPnyjwT7Yn84rCYkGINrK0SFMxxs8PMT/4JzjO79jfPjn5nba2JhbLOxSQxWTCDKDT\n" +
                "aGy25HBXlxvXeWVW58yehcdhCfzRuHrlMsqWRpPqKI1M1NZQxeNw/S3M6zkutC159TjmEaOmijoO\n" +
                "h+2i1/nFixdNbTLt8+esrCxEY4T3hL+AYIY18MKFyKDN/6anp+fk5Kxft6Z6W5k/kzb9s7HDz4BX\n" +
                "r14qKirisFgalSIvJyu8XbF40QI9XV3dztrjxvJkTXBwMEqYxuB08CmYPzQKCYPhbflkZma2WtNN\n" +
                "4FVc7CukTg3iyJJksR4/blQ9HVh5QdspKipKTHw9eZL/5k0bN6zn0aZvb1PkIDnE54FsfjOZDA6H\n" +
                "DU0IDhEmECRa7l38I5Cfn79zx3bB4Ua8Ulsa6oKj9Gg0qpamBovFjHn0COVMw/b5/n0gpLS0NLp3\n" +
                "7dLbtFdSYmJrtt4EXtlYWQHvkTgaBQX5xDcNnOlQVlaKnFWVn58HpCopKYmPiw0KCiouLgZjTEND\n" +
                "w8K83/Fjx86eCUMSTn8pEQPUIpGIvr6jopuevPBHo6KiwtHRARFeqqqqwCU2myV8HATKmYZM1rID\n" +
                "+/bgsDxNB1b+c2fCWk39axqvPnz4sHDBPOSgDdBTaVRqPR5hQXRFZWVFPeVsfinIeOf27WNHjyxf\n" +
                "tgSk9Rg/X8fB9kC8Zy1Oh/6DdZjTwZI1R8jKyco4OQ5ms1jaWhr//fcCZU79cHZyYNApE8aNoVHJ\n" +
                "2tqNOnutDXiVnpYmLcUVBFLoaGshhYW/fv2akZGeEB9XCKsSf12qrEaLXkPgrhGhy/4Pxdu3b/fs\n" +
                "3qWupgprl4a66v170V+/ZqK0qQfHjh4GJcislzGFRAT1b8uWoA8pKW3Sk4Z5tXD+POFSfiPch9+6\n" +
                "cR3YRadRkCjQFcuXvH+fjH5UMaEgP3//vr329vaFhYXoaNSDLZs3IQdDykpLEQkSU6dMacPOYHjc\n" +
                "aiiblb9SVVVWdWJLsooKC4tKeCfosCWZq1evlpaWkZOTNzE17YQCRRuhpLh4/749y5Yty/6eQyUT\n" +
                "u+gbbN4c1MO4Z1v2qUHm/TVtCpNORXwKGP7ZdfYDBy5auODbt2xURqJoD3AZNgyPw3LYkrAGeLi7\n" +
                "toeZ2fB69eZ1grWVVWFxibQUZ9q0aUZGPUxMzVAZiaI94NPHjzP+mnbm3Dkw/2lU6o4d2zw8vdpF\n" +
                "zZIGeQXIzc2prKyS4FXxpaLfEkV7QH5e3vp1a7Zs2/b9W468nLTfmPGzAgKQU3zaAxp1DiqDwUQ/\n" +
                "JIr2g9ycnF3bt4aFhn77lkMiSCxZumzc+Antq8ZWY9YrFCjaDxLfvB40yD4jLb2wuFRZRXnunNn+\n" +
                "Eya2t06ivELxJ2Hp4kW79u79kvGFQqVa9rc4dvwEnU5vh/1EeYXiz0BpScna1X+vWbe+sKjE2LD7\n" +
                "9Vu3GQxGu+0tHv1gKNo/Hsc8WrXy7zPnIqhk0sYN6/r07deeSYWuVyj+AISeDnbz8KyqrDQw0D94\n" +
                "8KChUY/232cs+tlQtGfs2bXT1c0dg+nk5en+6FHMH0EqdL1C0X4RFxt7/Pixffv2W1lZurm5D3F2\n" +
                "/oM6j9pXKNopkt4mdsJgnz1/Jisr98d1Hl2vUKBAeYUCBcorFChQXqFAgQLlFQoUKK9QoEB5hQIF\n" +
                "CpRXKFCgvEKBAuUVChQoUF6hQIHyCgUKlFcoUKBAeYUCBcorFChQXqFAgQLlFQoUKK9QoEB5hQIF\n" +
                "ih/4nwADAA8VLatuaDpdAAAAAElFTkSuQmCC");//审核
        dataMap.put("approveCode", "iVBORw0KGgoAAAANSUhEUgAAAR0AAACbCAIAAADQlthdAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ\n" +
                "bWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdp\n" +
                "bj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6\n" +
                "eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDIxIDc5LjE1\n" +
                "NTc3MiwgMjAxNC8wMS8xMy0xOTo0NDowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJo\n" +
                "dHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlw\n" +
                "dGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAv\n" +
                "IiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RS\n" +
                "ZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpD\n" +
                "cmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTQgKFdpbmRvd3MpIiB4bXBNTTpJbnN0\n" +
                "YW5jZUlEPSJ4bXAuaWlkOjRDRDJCNTU2N0RGQTExRUE4NzEyOTkyQTcwRkQzNkExIiB4bXBNTTpE\n" +
                "b2N1bWVudElEPSJ4bXAuZGlkOjRDRDJCNTU3N0RGQTExRUE4NzEyOTkyQTcwRkQzNkExIj4gPHht\n" +
                "cE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NENEMkI1NTQ3REZBMTFF\n" +
                "QTg3MTI5OTJBNzBGRDM2QTEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6NENEMkI1NTU3REZB\n" +
                "MTFFQTg3MTI5OTJBNzBGRDM2QTEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94\n" +
                "OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz6a4ElFAABDJklEQVR42uxdB1wUx9veu9vrvXBH\n" +
                "O3rvCKjYQcWCvfcaS+zGaBJN7CX23qIx9t4VsBcUBRRQEVCR3vv1Xr45yN9PAREV9CD7xPC7252b\n" +
                "3Z2d5y0z7zuD0uv1EAIECBoUKIRXCBAgvEKAAOEVAgQIrxAgQIDwCgEChFcIECC8QoAAAcIrBAgQ\n" +
                "XiFAgPAKAQIECK8QIEB4hQABwisECBAgvEKAAOEVAgTNAujGvsDVy5fcnR1KiouQtkaA8KoBkJ6W\n" +
                "OmnihN59+3l7eBEIxMa4hEqlKiosjImJRl4kguZvB4LuvmHdmrXrNojEkquXLob26VutwKuUZJFI\n" +
                "1LJV66+5ilajaeHj9SIphYCDR48d1b5dRy9vb2srGwaTibxXBN8Z+kZARnpaVeV0GJ2fl1vtrFAg\n" +
                "4HMNXf+XubN0Ot3XXCgl6WVQp44w6v+VrxWXIygv1yNA8F3RKHagHtKzaUSUgbSQQq6odpZIItnY\n" +
                "2ICz2zZvS05K/LJLAELmZGdnZWUrJWIqieRowzdjUcHDMBhMDIxBxCWC7wu4MSpls03cPb3SUt4o\n" +
                "ZNLyijJbyP79s1gs1s3DKyo2gUDAlRQXf27lSS8TI8LDHz9+cOPGLRad3srPX1heqkNBEolUA0G7\n" +
                "9u2jUGnIe0XQDHlFo9G8vXxK8/J1OlXq69d+/i2rFRBLJFwGuUIgVavU9axTJpMmvnh+9MjBC+fP\n" +
                "i8ViIh5rZc5TyeQQCiosKvL0bjFs2Mg+/fu7e3kjLxVB8+SVQSnhsGqtCnyQSiU1PTqxSMhiMWQy\n" +
                "RVl5+SerysxIf5WSPG/evKzMVAtzbpcuncpKSqMePcETyN179ORyzRYtW+Hh5Y3BIOYfgubOK41a\n" +
                "BWNguVSmVMhr8kooFikUSo1Gi4XruoH0tLSTJ45u2rQRFOJwOXbW1jKx9Ma1691C+61ZO3jEqNFU\n" +
                "xORD8J/ilUqtgnR6PA6PRqFqGdhAoVQqtVIH4XC13EBZWenN69fPXzj3MPIhSq/1cnURCQVyuUSj\n" +
                "R7u6e8/7ZUGnzl2RN4fgv8grGA2LxRKdXiuXV9dXKBSKTCTo9VpwbTqT/e64XCaLfhwVHhF+/vSp\n" +
                "stIyNAZmsxhMpklcXHzrwMB27QeNGD3O3tEJeWcI6mUxadRqtUar0WBg0BVFWBjLZLGaPK+kYjF4\n" +
                "JpFMrVIpa/KKxWLL5DIWg6JSqWJjY4A6SoiLiwi7mpX+Vqc3zFXz2EyFUlFaUujs5rZyzbrgrt1g\n" +
                "GEb6ypdBp9Oh0ehm+WjJyUklxcUV5eUarTo3NycpMbG8pEin1em0kEAg0OogqUwMelRFhQCFxf32\n" +
                "y4Kp02c0cX2FxciAC1U5hVWLlahUkSkUJoMxdNgwlE6LRulYDBaVRhkzYYJEJD514ri9s2vffn16\n" +
                "hPZBFNTXozmR6sXzZ4Lych2kDwu78uL585SUZJFQDJx5DARhwHNiMJBWg4JQGp2WQqZSKfTiimKN\n" +
                "ToPSowQy9ZMnsVObur4iU2kKlQ7UrtZq3z9eUlKcEB/35s0rGpVSXFxKgAlEMrlcIFAo5dJC2c4d\n" +
                "u8ZOGP84/oWZuTlopDrq1+uBj4ZCOPNfQEZ6WvLLxLdv37xKSbl65apIUK5S61BoiEDCgk4ilSio\n" +
                "VJxGoQKePIxCKXV6LAyrlWpg77A4JiQynkiml5dJHLi8DZs2N3k7UCAU9OvfKz09zc7ODqqM5YuP\n" +
                "exoeHn7o4N+Z2fkEGPJ0dyopKdPIZA4OdsB5GjtunIOjMwOAWS8jWKPRAHJhsTik2zVLAI9o65Yt\n" +
                "Ls5O9+/dfv7iZXrqKxwGQyYT27VtHR0dVVZWodZBIpHa0pK2aNEfeXl5eDzB08Mbi8WaW1oSiSQA\n" +
                "Ey5XJpO1C2whk8pKBdJt23cyWeymzSvDSLpQIBaJlUrV48fRwMzdsn59ekY6jUEnk4gu9vzcvPzC\n" +
                "wqIKkXL8uJHb9+wHjfIFtg3w3EA7An8N6YXND3/8Nn/rzr/AB3tr0/ETJt6DodLiUoFQdPL8VXBw\n" +
                "6qSxM2bNZbOBOiLTaPSPVbJp01oUGi2RyPx93AcOGf4t77+x8ho7tPGXSmRFxaX5RSV4FGTNN2Wy\n" +
                "mEUlJRKZ3MHBXi6XlpWUSaWq1MxMFtsE6UYIqmHnts3zf/oJOIbWtnZalaqktFQhV1IZjPZtAhcu\n" +
                "WerrF/DJGpKSEjt3bM2kM8oqxG/Ss4Ah9G4UR6NW4/D4JqavXqUkHzt6+PXrdBgDSURiB0tztVqj\n" +
                "UGthDGrh74vdvXxc3Tx69wyWCCWODo4IqRDUiukz57Rv3/7N61emZhbl5eXArnP39KLSaBQKtZ41\n" +
                "jB0xmMtkJL7N/2n2zHekgiqHo2GDmdPIqDXK/cvSN0Qi4f49O02ZdDwGIsIQjQRTCRh7Pm/V8qVv\n" +
                "U18Ds62qWNrbVDMWhUGCfdwcdTotklOAoMERdvkCDQexiBhzM1PQLb/9DdSurz53qE0iEedmZXXv\n" +
                "0lkoqPB0c5UrZRlZGWw2O7egeMvOPb1693u/cFFBPglHwOPxoX37IN4RggYH6ITDBvbHwBi1Vhf/\n" +
                "KOq7BLt97cxGQV7eymVL7Kwt+/fqhsdiCHisFqXn29jicQS5VAZsP3d3j2o/AYoL2M3gX6dOQchY\n" +
                "OYKGhUqlGj5kQKUhBu3dv9/axu673MZn+Fevkl+SyBQra5uqr4+jHuzauS3syhUsjAXaVilXwBj9\n" +
                "L38smTBpilIh93CyLipXhfYIrvlgSqVSKJYwWHQnZzekHyBoWPTu3vnW3Yc6CBrWu9fw0RO+123U\n" +
                "l1fP4p9mZKT3HzhEp9U+S4g/cODv0yeOkckERzs7jUaNJ5AGDR4ydsIkfiXr8oRCPJ6AhlTt2wfV\n" +
                "nOwvKiwqFivoTLqFBR/pBwgaENfCr8Y8fkQlQGoIu3TV6u94J/Xi1dMnMTu2bly8bPXp40cPHTr4\n" +
                "5nWKQqUmEPBoFFquVk2YOGnAoCFW1rbvyiuUCqCUsCjIhMutWVvVmmc6nU6r02IgJOoPQcOgsCB/\n" +
                "7MjBWo3Ov2Wrg0ePWdvaGzWvjh45OGHceAIef+fmbYlEAqEgC74FCqV3dXUfOnxkl5AeXB6vxrAH\n" +
                "WqvTq/RQWWlJLS5Zfj74O3feAhzu03MIr1OSDvy9393DY+TocUjmIoKPQaGQjxzYV2XI6oOWr1r9\n" +
                "fUn1CV7l5ub8/ffepUtXcZg0PBYuLyvX6SBbe6ug4OBBg4e3Dmz3sck1YPuhK1ekAQSreTY29gn4\n" +
                "a+9Qr4DaaZN/uPMwmogBXpli0pTpSAdCUCv6hYYkv3ymVEA/jB/dvlPwd7+fWngFLLTn8U+PHzu6\n" +
                "d99fBDTK3tJEJBITyPi2HQJnzV0Q2KYdi82pu1KtTgP+ElAQk8GoOWhRUmTQV1j8p0P7BBUVgNsM\n" +
                "PEqh1sMwFuk9CGrFri2bnifEi5XagMCALbv3GcU9VZvP0mg0M6f+AI4zCbANl2PFpltxKAN6drl1\n" +
                "PVwqkdRzUiwnO9OESiSjoLHDhgJuvH9KLpexCbCbjYVW++kZYaDcA1t4Y1AQi0IEJuV/ambz5PFj\n" +
                "Q4cMGj582M4dW5B53jpw/sxJBoziUAgEHKa4qNBI7gqu4RqhyBQK+GDIspRIrKz5o8ePmzl3wWel\n" +
                "FZqZWzo4OcXEPT908lSXkC6jxv/w/85lfn6FQvPHtJn1SQq6e/tWenqaVg/17d/3k0qyOWH50sVr\n" +
                "V67S6nVKHZSV/nra9NmIUvrYWMWY4cPQKFSpRPEs/okJ9wNXv7S46P6d2/cjIyUiEYlKtbWzbdmy\n" +
                "NYvNppAp1ra231RfVQUxvXzx7ODf+86fPikUCr6Mr8eOHASVcymErIz0949fuXgOHI+Pja5PJds3\n" +
                "b2CRsYB/v/86/78jgBf9tsCWb9YvpIsplQza6vjRgw1+CalU8pUrDRsDBIKKPj2D6XiITSeHXb5Y\n" +
                "7WzMo4eOFuY8MnBHDNEPwIvAVEb3sBlUDpMxeEC/SxfONd69QY1X9f49O//eu6tm4BYFg5KIRfWp\n" +
                "4dCBfdamTNAcK5f+8R8hVULcU9ADBvTp4WFvCz6sW7W8wS+xeuUSdxeXZYt/r2F1K57Gxvyx6LfJ\n" +
                "P0youfq3seF5wlMnGxM8DOHQ0JOYR9UpV1HOZxoidOloyMaEScOiQGNSsChcJbWoOEOUD/i/e0jX\n" +
                "p09imxivasWA3j2CAnzrWXjimJEwGkVEo6Ii7/4nWKXTebk69ekZ4unsAF78vl07GvwKwAMx4xoS\n" +
                "lqgEnEqlenf85vVrvp4eNDyWWDmXMXv6j8arpirKJ4wexmNgyTBEwqFOnTxSs8yurZsgQ8hFz9io\n" +
                "hyXFRamvU/bv2fHXnu3g3+ihA9kUmI7HULCGR2VQSI2hur8przQaDQ0PXzxzup49wJzNAGLGlE4u\n" +
                "LSn+L9BqyuQJDtYWP4wbCXzZ9WtWNsYlhg/t7+VmD97CrOlTQX+6dfPGvr929+wWwqHTeFQqm0gg\n" +
                "og0DuWlvU42wfUD/uXEt3NmaS8MatA24z7jYxzWLKZVKOgHr5mj7sXqexT8Nbh3ApeDxGBSNSEhO\n" +
                "etm0eSWVSLZtWlfPccXLly4CTYWHoImjhms1mmZPqkdRD8g49JQJY8k4zJwZ0xrJIXGwtegZ0gkI\n" +
                "6sDWfp4eLny+OY2MY5II1iwWC4sjAcOJRPpn314jbB9gmoYEdwIaBl/5r2dQhyfRUbWW3LFpAyiW\n" +
                "lZFWR21qtaq9nw+5UjmfPnW8afOqPmPr/+++/zKPSTCMQm7bvK7ZkyolKYmOgzu29HWwMhvYJ7SR\n" +
                "rvL3vr2ARd4eLjQSwY5vNqhf7xaebmQinoyHmWTChHFj4p4Y1pwzziaKfxoD6MSoZMLaNas+1pcE\n" +
                "lSuTH9iz85MVzpg6iYw26L2J48Y0uCn4TcPzPmvBLUF5hVKlAY/t5eXbvAeLgcPQO6SrNZ+fmZ2t\n" +
                "0WoPHTvRsPWDLnj3zq0b169v3LS5hY8n8Dd0Wg3w24HMLi0ts7W2mTjphwEDB73LVDBOYGEYi4Zk\n" +
                "Wii4XZv5v/z2sQyjrkEdLdjM8VOmGSLmCvOfxMYEBXWuNQWLzWZDegiPgq5cvgRMRwKB0Ljj7EYy\n" +
                "hOrhYEtGQQwCpqgwv3krq77du3na2/q5ueJgOD8vp6GqValUj6Me7t6x1dfb045vjkNDVqacQH8f\n" +
                "IPEJMDRr+o+Jz58Dm1wqlTaJVlq7cokF07Cb7uYNH7VfsjMzKgNQ86qGNwP9PMFXXx/P0tLiWgvb\n" +
                "cFk4FGRCJ8tk0iasr8CbxuHqtTJZeVlZcVGRHoKsrW2a935WG9euiY15zKBTi3KK457Gstgc/dct\n" +
                "jZj65nVMdPT5s2finj5Vq9V4PEynM21srCRiMc/UNCM9XQtBF86e7923f9NqqKTERBaTWSZQEEnk\n" +
                "2kNv5fIAP+8Txw+bmplXTQo/jjPsWpj4IlGj1tQsz7e2sXd0zCyOEYhlCfFxbdq2b0jT7Ju1y+2b\n" +
                "N7w83GZNmxobHfXJwnFPn4CehcOh+gwYQPpIOzYDPE+I37hudUi3rqmZeTfvR0ZcvUyn0efNnfkF\n" +
                "VYnFoiOHDgZ1bBfcof28ubMfRUXhcHDLlv40Gv1l8uvIB9GWfEtnZ5fCctGk8WOaHKkA5AoFUK0U\n" +
                "EpZGr13OHj90UKFSDhs++l9DDII6tfKjEbG+3l4fWzmQRCRy6RS1Tp/69m2jx902EkaPHF5QUv46\n" +
                "NW3Pvv03rkd0Cv7oniDAibx6+ZJIKgNSu1v3ns2VVFqtpnNQh1at/O/eu3flyiUikbh8yVKlFnoW\n" +
                "F1//SjLSUiMiwqMeRj2MvK9Qq635lgMG9n/8OLqwIF8gEGbn5Pj5t9y6c3dhfsHhQwfi4uJ4HNbu\n" +
                "fQeaYnMRiYSyMiEGxgiFwlqV1W+/zD916vy7I5F3bwF/jEYhSw2bRSlqNZTweAKJiIOEEINBb6q8\n" +
                "2vPX/hHDhkmVKtChmHVuWV9QkH/71i29HiLisU4urs2VV2FXLqtUajKFMnbCeBKJ5Ozq5uVoXVhU\n" +
                "al5pxnwSaW9Td243gEjE+fp4sVh0LBZXVlp64tQpFIQZOLDfwt8Xm3BN8ZW5PCeOH32ZlFRaWrpn\n" +
                "719NNI2NwWAoNAaZq1apap4N7tjezsmxW4//l8JZmemxsXEoGEZh8KWlJVRaLVqOyWaXlRnGD+uT\n" +
                "CmikvOrTrz+wAzMysih4rL2Dc10aXyYTi8RqQ7jtwGqRlM0J27ZsZjPpZ8+HvXq9nsM2Wbd65dED\n" +
                "+zkm7LrXSZXL5c8S4vf/tffu7VvAfbLhm7HZrKzs3PLy8hZ+fv0GDQkMbNOhQyfMh3HSEWFXNRo1\n" +
                "Bo0J6dajiTaXQqkgE9DlCp1MJqt2KvLO7cdP4uLjnrx/EIXC0JgUiUQpFAgM+bi12oFkIh6PE6tV\n" +
                "AkF5U+UVMI5JFKKPt9OTmIT7d26G9h3wsZLFxUVorRq41xZ8/rtBy0sXz18LD1cqlEGdgwcNHkoi\n" +
                "N22nCziQyS+TGFSykyPfwcEZjUYHtmu7ZcN6B0fnguLCWn8S/TgqNjrm+OGDSa9eW1mY+/n6Rj16\n" +
                "VFAhZDK5f/65LqBVq4+lihbk5cbcj5SLJG3atGm6csq/ZasTx06C/pr04kW1oZ3ePXsGBvj6tvD/\n" +
                "wG6kkLFkorhcMnLkCM/KXacrKsrfvnnz+OEDsVCUnpU5bcYMLpdLIOAISlVJSUlT5ZVhfkAPaTV6\n" +
                "CoUEZGcdJTVaDRYHo1UqMzMz8DUzM+Pnn+aev3CpSpAfPHqsrKx07rwFTZpXM6ZNwWLQmfnFFy9f\n" +
                "qJrW4/LMmAymTg+hawwmiYSCubNmHD16TKWDzDhMPIzJysmrEEv6Dx4yY8ZMYCrXbdrdvB5RUlaC\n" +
                "QqFHjh7TdNcyaNOmg2GnCwgyt7B8n1Qb1ywXKVW7//ogndEwj5wQB4xG0MhDhwy7e+vGuTNnwi5d\n" +
                "VCgURUJJVUc6cvioLZ8H/C6dDuLxeE2VV+CNikQSYVlJVRRJHSUvXjgnlKoIaNATUEBI9+oVWlYu\n" +
                "JBMMHQKHx1UI5ZcvXZw1Z17T7SIPIu+lvk4hEQh4HK5zl25VB2VSKYRB4/GwRP6B0XLh3Nlff1lQ\n" +
                "UVbo4MDPyckrK69gsNkD+nZdtfpPvpV1fS53IyJCpNBYmnF69e7ThId5dDoiASPTaCIj74vFYirV\n" +
                "EK6uVCiWL12yZsUf3j5+H4hmjQboJVOuKaRDT5s6WSWR5gvFqMpUEcPeURDEN2f7+fqnvHih1WhU\n" +
                "WkgqljRVXhlUub9f+JWLwFkXS+p6DA8PLxQag8ei/vhtYblUDqQLm04aOGgQsHMWL10MCrRs2bLp\n" +
                "kgqIzLmzppvxuJmZ2afOXnj3IHpIX1JUqNEo2wX9uzzD09iYX+b//CjqIYVCRsPYtPSc/v37Dx42\n" +
                "0t3NzbnewzkikTAu9jEwqsdN+KFJ54Zi0GgYjaHSsSwWG4v9t9+ePXVUpIJ+WvB7NVJtXL+mvKTM\n" +
                "hMk0jM7LFFqlBg9BLXy83D29grt1a9+hA55AMDHhXjp7ava0KXQifPv2zfETJzfkKrHfcsr8yD/7\n" +
                "2/l7dgzwnjdzah3FlEqFv5sLAbiVGEN2DQ4DMSmErp3a9e3VoyoQavz4MVVz6k0OSqUyNCTYxpzD\n" +
                "ohKnT57w/qnI+3c4FDyPQV6zegX4umrpH0BDO9ny6STDAHGrli0ePviSZJknMY+oOAwNj8nPzWnS\n" +
                "USkvXyTY8mhmTPKPkydVHZHLZeYm9B5d278f3Xf39o3ePTuDFnO2MXW1s4QMAVDowQP7379zG5Sv\n" +
                "Fqf65HEUn03ncxksGhG8mu8fbwGeZOP6tZkZGaNGjzG3sLC2qVdWM5FIUqvUQpk0KzOzds9Kozly\n" +
                "6MD1G9eKioroDKpcpdAq1EotpJIobt57CDiFwaJAG/7zz+FzJ08/ffbM0cm5aQndJb//Fnn/Ho/L\n" +
                "FYjla9Zvev9UeloajcZo3aZ12NWLgorSnZu3mptxcvIKIAh97OihYcNHfdl2pgf37xOrtOdOHTOz\n" +
                "sHw3ovg29TX4AN4FAIfDUalVZBLZysb2O7bMJ6NMgFcALB00GpNRmYEOCk+ZOCq/RHhp5Z9VP5RI\n" +
                "xIsX/rpvzy4SEUuAIQ7P7M2bt8AXvX7rZseOQe9fyNvDNfzGLb4ln0qjszlsFAajL69o4BXNv4yO\n" +
                "QoHgHSPbt/ar569uXQ+3N2dbsMgjB/WptcD+3Tuq6gQimozF4DGQCZM6oE+vxQsX+rm6EmA0DKOw\n" +
                "aIiKRVUKJH5OdnbTErpAWdHxBnrcuBZW7dS2zRtGDx20aMFcEhFi0GErDhk85JhRwyoqyr/miv17\n" +
                "hFBx2JyszONHj4waNXzy5IltWvqD9iNhISoeBVcaBQB4HPbc6ZNGHfL/8oUJGWNryvT1dgdfy8vL\n" +
                "QDt6OdnqKpVP4vNnHrZWXBrRxYZLxQE9b94ntLthMmPT+uphgRnpRAh6k/raoPFkstaeLnwThgmT\n" +
                "IhBUfP88EZVKFdLF4AaAlwJEQkba25pldJV4/8jpE0fdbM07BHgP6dujZvkXz+I5NENGDHjIEQP7\n" +
                "Xb14MT3tbeKL51Vng9u2plSmT+/fu/vFswQYY/j8155dTYhU4HEcbc1Ab2jh5Vzz7O4dW93sLAb0\n" +
                "6sJjkzhsEpdO3rNj22dl1tRERXkZl0rlkgk+zk5AVOEqKYSFIC4VzyRiaDiIhkeZs+jUyszZHl2C\n" +
                "jbn1XiUnmtJxZkzi2JHDwdcVyxZWzj08AJ/37tnOJGMDnO34HDoQGaOGDuwQ6BvUIRAUeJn4vFqm\n" +
                "0qCeIeD4mzevqhICA9yc7cxNWDRSRnqaUeRfvUpJZpFwVVrr/q0bHyv2PrV2bdvMZ9GsTGhLFv1S\n" +
                "rZhMKrU0McSSLPhpRk52ZrWzVy5fAN0ROBpO9lagQuD6YzEGvf08If5DE/x56pvXRtsz7t6+ScSh\n" +
                "TTjsl4nPap5dtWyxq51Fn+6dGCSDQgsPu/KVlwPuBFCAoC7gk5gzSSYUQ0gBHY+iEzBkDMrVzmZA\n" +
                "r17tW/oTsGg2kzZ7xrTi4iJj5lXck2g2BeLS8XOn/ZibnUXEYbp17ghs2hsRl604JC9HS9BsHm4u\n" +
                "mRlpOp22lb+Xp5uDp4ujQiF/V0Pyy8Sp40aCRnCqjEKu6pyBvt5mHAaTTnyb9sZY8hqPHNzPJODA\n" +
                "87RwcSopLvwkr04dP8KjEU3phOWLF1YrdvN6uMGkDPDVajU1fX17K3NqpXNx9Yph2Z0bYYZNZl3t\n" +
                "rd8vdvvmDRaVQKdS16xcbpzLnhw9dBDc9tLFv9V6dv2alS3cnYLbGyY3x4wc/DUXAlL5wP6/TExM\n" +
                "rM04bf3cWWQsDrwjT5df5v98IyIsNyc7Lye7yokvLS1ZtWJZ9ONHxq/tHz28z6HCTAK6T5fOU8eN\n" +
                "Aq30PP5pwtNY8MHTgU/DQ/Nmz6gae5g2daKPp0un9q17h4ZU/VYqlfzx689siiHDCojjxOfx78yu\n" +
                "zu3adGrbkoiD7t65aSy8AvC0t6RUOnynjv7zycI/z55hy2OzSXDN9ZWWL/oVVLJ3ey1rUK5fu7qq\n" +
                "OVr6eOgNixyo/bwMe2olv3zxfrHpUyZVrWUFCEjBY50cbGfPnBYT/ejN61dG0jNGDRtsUMg/z631\n" +
                "7O7tW0yZFB6DvHbNCs1XrDtQUlzUv1c3MgFrYcJwsDIlwigXRztAM6VS0aTHA+/fve1sYwqEshmF\n" +
                "RMdi+FyWTCpRKhQ7N6/nUMl7tm+uKgb8rl8W/MS34NhZmU0YO9IwQfw0NqCFB4vy7+anQLi/q1Ot\n" +
                "UnUPat+nRzCNiL56+YIR8WrjmpVVIw0H9n7C1QE6xIRO7RTob8NjbFq3ptrZP5ctAZXs3ra5hh6L\n" +
                "IMKYqom2V5XreyxfbJisWLt8cbWSr1NSzDgsBysLg94LDPB0c8FVDqBRiLjuXTsfPfzPvTu3gJX4\n" +
                "HdfN83R1srQwi4urfWGtDWtWWnLA+4WSkxK/nFQlxQHerqASBwtO1ejhsiW/CxvUI/9eiH78kMck\n" +
                "8xhECsYwrGVmwng3bi7439DOrZsRQDUB38nB1tzZzsrO2qpfaAidYFiCHJi7BBzm6uXz79epUatb\n" +
                "+Xq2DfCGUdDxY4eNiFeZaWlAEKBRqFlTJtUtZfv1MsQaDwjtwmWQ/tm3p9rZ44f/ARpp9OABH1Il\n" +
                "mYKDq9Kjz544Bo5EPYgEny049JobE4PeY8FltfT1ImBhUAyYBEAC8ZhUEvz/k9++7k7vG9zf3PNO\n" +
                "ysrM+NjZ336eY0IjkLDQk5jHX+xQtQnwNmORWWTDlNfoEUMLC/L0zQVJL5+DHkInoFzsLK0tONev\n" +
                "h1cb1BGLRT5utquWL27TskWnNgEBPh5ELBr3v9CHVi39Y99bZhAIL2AEgl7k4+rkZs8HWn3V8qVG\n" +
                "xCuAHkEdWUSsJYuRl/PRmcc3r1OqRs/9PRzB37Mnq6+AI5GIDx/YB0Ts5QvndVptQUEeaCBTJpVe\n" +
                "OYa19PdfQRngGFTRI+rBvVqvEtQu0M3RxsPZwcbCIjionZeLgxWXYcVj8OgEYqWxumvrRqPtN9s3\n" +
                "rbc2ZZlymJcunv+yGtasWIqHIGcrQ5rJ6hXL9M0LLxMTAENoOMjFzqprcPv3HXjgNAa1a92pTYv2\n" +
                "/h525iY0HKqVtxvwLUlYFA2PcbC1unUjoprQX7F0YVFRAfgwpF8o0IEkNLR54/oGvNsGiGMKbBcY\n" +
                "GXmfQFBLJKKPlVnw008kIt7exgJIGBoVC+Oqbw5CJlOGjBg1adKkPv0H+Hu5FhflFReJVBCkA3J3\n" +
                "2OAlK9aUlBZ5+3gBkj18GNn6w5Rp0LJ5ebkJ8XFCqYJKpYGfvHz9Vq4UycQSmdKwXxCVTCAQse0C\n" +
                "/N5fKd7YQKXRgPzF4fBqtfrLanBydtEYdlcqenj3bttOnZpZWo0h4AsNMen0gpzcqdOm/X/coEYz\n" +
                "bcLE7IJCLpOIxxP1ehQJT9BpNcUlpRQaLTr2qaWlVc0NpXAEwt/7dv22aLmnt09MzGNTc3PQjYwr\n" +
                "PtDDy0etBY+nEteWyAlw8vjRi2ERv/48V6VQ3LwWjkFjcdjakzcjH0ZNmz79afyzqjuzNOf9vGDB\n" +
                "zNk/lZWWODk7CMolp48cfp9UmRnpJ44eu3HrxptXyTgsViqXW1tZ2Ds4JyUmQ1qUl3eLjp2CnJ2d\n" +
                "gPzo2bsPi83BYIx0e0hgkzyKeiAWS4gkLQH/hQsDDRg8NCbWViQQvCOV/ouWypDJpEa49gHgj0YH\n" +
                "wTiUHoVWqpT/34NheNX6dRPHj6kQye3sTMFbrigpJhvEK+ri5at29o611uZg5zBoyAjAKzs7B0it\n" +
                "p+BJYrH4+8dbvI/iokIqAQ0U0K7NG2qelYjFNKKBRUWFBb/9PA9Xuaji/dsfHdMErfcw8t7Fs2fP\n" +
                "nT1dUrnMbXl5WZV22/CebfMyKRE0JZNEsDDheDrYuNny+VwGlYjBoqCxI4cCydWtQwcg+JuKkVNU\n" +
                "VOjuYG1twjBn0V48T/het/H2zeuxo4bZWplv2Wh0azY+uHcL9AErLpWARZ88cbiGlfgMqJ1Kl0m3\n" +
                "8o+FQLm1b1VXGFBBXi6QNzHRUfdu37KhMzgwNrRblwYc02oAXoGH6Vs5h93ez7vmhgZ//GJIlPrz\n" +
                "T0Ms6YjB/S05dGD+Pk94Ws/K79y+aWZqYgit2LGtai7rxImjvXr1IFPwRCLG29XRz82VRsB5ujiN\n" +
                "GTXs7JmTkyeM8XS1nzl1MpdBLywsaCq8Aj53C3cnaw7TlEFN+nD+4BtceuqkiefPntJXbjRRJW3t\n" +
                "rcyMbcORBXOnMSm47p1aU3Go8rLSOkru3r4ZPALwNuuu0IJJPn7k4IuEeHcrC0smA/DKuPwrLBbb\n" +
                "p3//K+E3YuOeJybEt27f8d2puJjoFWvX4dHQpElTwddyQRmNTqsQCuu5+eLpk8eHDjdMkEdF3mvT\n" +
                "vuOpUyd+W/BzaXm5Jd+ca8IqKS55mZLaOTho6ZrVQZ27kisziFsHtnV3dZQp5Cq1EliJPJ5pk3Ae\n" +
                "YAxcUlxcXCro0KGNq5vHN7giMB9Onzqh0+oeRt718PK1tra5evnixQvngAerhaBDR0+gGjgQ9Wvx\n" +
                "KjmFSScWFReJVXrA+Loas7J3de8ZWmu8+LvwZTt7p6uXLtAoFLVOgyNgc/Nz3z/buP5VPQ300F59\n" +
                "LTm/lpQKMdgPCLNyqWFWauaM6SyWIfMHjYGFYjEWhuuzJODG9X/+vOA3DpU6fdqU3JxcTw+3stJi\n" +
                "Go1kYcaTSuQatWrUqLFduoT06dMP+95SO1wuz8XF9eb1cDaLGRZ+pVXrNk2CV2qNWqFUYNBASOG+\n" +
                "TYeOenB/1px54MPmjevm/DQfeL9rN24xNCCDvGPPvrbvCUcjAc/U/NWrlwUFBaOGDqZ+vP+AHhsZ\n" +
                "eQ98EHzo7QsqymdNn1JaJuzYqeOUH6cxGMyxEyb+Om+OOY8HGh+Ng8EPG4pU0CfXD6znO+aZmnUO\n" +
                "6SaHoOfPEt4dfPEsIezaDSYJO3/hosoH1gHNVhnWB31sw+//OfHKjRvWAVIBjprQqdfDw6eMHy8q\n" +
                "KSERCFKJooVfwIYNm2Ji43fv2T9w0BDsh+tXgUv0DA3FYmG1WpWTld1UBrvepr4hEokwCsLjcQ1S\n" +
                "IRC9mZnpwFn9WIHox1HgVRCxqOSXL9q28t25Yytk2P26R8rbzMFDhxthE+lRwONQazR6bCXqKMnn\n" +
                "Ww0d0Merck2L9+XIkRNnI27c/HXh7znZho7h7uWFgvQH9h3oGBQ0eNiw/PzcosJCo8trPPjXboMf\n" +
                "tWJJ1VeZVOrhZA+OLJo/5908Q7egDkQs2s7CVC6TfXTyNCWpbZvWVWHXFBhNQEEmJKIZk0Ej4l2d\n" +
                "7KMeRn7awb1/19bSxNna1NvdUVy/Dey+O66FX2UQcSQUql/Pbl9f25mTRw/+s0//YXDm//z1vLdv\n" +
                "3qxcutjVzopJwtHwcFW6Mp0AHz30z/s7YhkbJo0bQauUxn1DQ74gzL9fj64MPAwklx3fvMo9qygv\n" +
                "c7bkGizG4NYhXdoCeR9x9UpD3W2DKT5nVzfABNb/Fhb944+Fb1PTeBT87J9/+Xf0ViotLy41ZbPQ\n" +
                "kOF911rJ2TMnfX1bRD2KBi4ZDofRoiGFHiqRyS3tbPbs3Rf7NKE+i/36B7Ris5kmHFZBfh5wsZqE\n" +
                "vlKqwH9qLIyWy+RfISJ1d2/dGDd25OBhowQCgUgoqDI3QDsUFuSfOXViwphRrfxbBPr5Ll+6vKSo\n" +
                "BAOhFEoNEFjD+ve7EnFz5JhxdeuB74iM9LdPnkSjKu209h06fK7BVlxU8DQmpk3bVho9NHjwkKrl\n" +
                "bxlMFt/aCouGEuISpFIJk0KiUahGNH/1rxfo6GzYA87SsnJaKW3Lpq3A/Z04fCSbY1JVQKNWA6dT\n" +
                "JJWSCXiNtrp9UlJcNHbMmIjrN8BnIgYl1+qVKi0ODQ0dPHD4iBFdunYj13thMwKR6OXjHxV5n2fC\n" +
                "u3X9moent/Hz6mViIoNNEwmEvv5+X1xJeVlZaEg3nd4Q17L4t4XLlyydMGGCVqc7d+Z0lYTGwliD\n" +
                "wwxBbA4dtGdGdj6bSY+KjnEw+rTrstJSQZlQr610XT7fC1q/ZiWLzTZMu0NQr7593x0fPGLU3UdP\n" +
                "ZUrVlKnTly5dJpRKjY5X4Gn1MBpfudnJzm1bQAuQYMz8hb+j0f+ui5KTk43DYRlosgmPC3yJ938b\n" +
                "HnZlxrTpGdk5RBg0mV6u0Xs4O/r4+Q0aNKhv/4FfcDMjR42NCA9n0+HXKUlNQl8ZMvMFhmiVjsHB\n" +
                "X1wJgUCg0ckapZpCpQnFYoVcvm/PLpVSC4Q0FgPhcbBSqUZhMW3bBJYJKtLSMvV66Pa9ew5NYS0D\n" +
                "8EQwjAMKloqHHZ0+bwnkxOcJO7fv6tOn58OHDwcM7NOuQ6d3p9q274RBQTotKizsUnZunkqjNSL/\n" +
                "qsqIl4jF3YM7FhTkl5WVmpvQTWiEX+bMer/Ywwf3bLhMSza9U9vW7+x+iUQyb+6cqjsBbntlQjBk\n" +
                "b2n+lQlU4Od8M5aDBbelt4fRbpT2gXf6919AwoF3/Cwh7mvqycvNHj96hKUpz8KExaKRmBS8l6t9\n" +
                "aNeg0cMGzfxx8ssXz4BhvH7tah6HAQTYuFHDmsr8nkqlbBtgsDu21MiE+CSG9AvtFOg3ZfxIHpMc\n" +
                "9yTm/VPl5WXWPBrw4U05BAwamjtnjhHNC1fh7p1bPboEgQ/zf5oJ3hmfx6i2b1XkvTscMo5LwU+f\n" +
                "+u86RInPn/n5+ECVSVNk7L8Djz/NmFFRXv71r6FPaIiNuWFw/3ClB2/MAFIGdHFmZT5vxNVLX19h\n" +
                "fFzcs4T4N69TXjxPKC0p1nwYdzKwfy8KyWCnVOtkRo6zp47PmDrpczPTUl+lcKn4GT+MaeXt2tLH\n" +
                "o1pTKJVKT2drMgyxaAaryt+vRUPNhjcYrzZvXAcEoVgs4tBJeAwaCOBqBc6dPmlGJ3EouMMHDR09\n" +
                "IuwyoTL6FnhTVWrKjMe5FtZgAzIH/t7HN2WZs6njx4ww8h4D+kqXTm2YFByDRkn6cD2GBkdszCM8\n" +
                "FgWjIL65maa579qsVqs7tfbjkrELZk21NmXv2r61pkTzcLIyZeK4dINQ8/XybCheNcx4oEQiPn/+\n" +
                "3Oix4//Zt0cglLm42IweO6H6BH9BAQqNgrFYvpUN+Drtx8kKlRpICblWr9JD40ePiot/1q1nr4ay\n" +
                "b9u2a4/F4vEE4pnTZ4WCCmN2HnQ6rWHVVbWaTMA3trdz+sQJjVqPQkGbt25uumub1hO7Nm98Eh1H\n" +
                "opCEIiGBROhUw3dFoVChoX3EIhWFQgJGeH5OblFhwbeYF64nsrOyhgwZhsXiFi9ahDFsHTIAXeOd\n" +
                "ZaSnkckkoCGrbv3MuUtMKlkPQfPmzEpJfnng8BEzc4sGbFN7e4eOQUFkCgnSa3Kys4z59Wu1WpHI\n" +
                "EIai0+sUckUjRnWoVNfCwoBvTqORQ3v1ad6kkkrE29atVUOQlTU/Lu4JgUiws3eoWWzRkpWgT8qk\n" +
                "ciIGLRSLCwryvymv9HVGZLm4us2YNWf71k0arZpKgXv16lezjEgkBB0ISOeqSRU//5ZpmVm5ebkb\n" +
                "Nm91cXVv8GYFwrhVq9YEPIHFYu7ds6va2WvhV8+fPa1r0JSbr4mNoFDIQLe6ubnR6PTGu9DrlKSX\n" +
                "qemgAy1Y8BuBQGz4kAi93nh49SopqbRCxKIS7Bzsc/ILevftj68tAYdKp8+eO1MuU1ApZIVGs3PH\n" +
                "lm/Kq7oDmtBodF5uzpb164h4HN/a2tXdsxaprNeTSBStWof538g7k8VuWB1VfUrN3jE3vwiDRus/\n" +
                "nC4rzM8fNqDf8GHDBvbpqVAovnsPAH5OWUmxDtiCak2jXujwgf0EwwvXh/bq1Rj1G1Wo7oljh4Eg\n" +
                "t3OwYzLY5WXSIUNHfazk4pXrbGxsZZWWApnyabmmMxju2m80f7Xgp1kKuVqHg3b/dbDWsEiFSq5R\n" +
                "q4FMc/fw+jYt2yowkMflFhXmRz6IfLdlePTjR6HdQ5gsujPPNCzsuk6r/e49AI/Hp6ZmwzAk/njC\n" +
                "dQPY6pkZG7btouNQApWea9o0wvy/GMkvX1y+dI5Nghl0hkSqcHZ2cHB0qmPe79cly4aPHDN5zIit\n" +
                "23a+r35Bj83OznwWH4/H4WKjH71OSVEoZEKxUC5Xt27XsU/fPp27hDQir4BVevnSFSwM9Qjt5eXb\n" +
                "olYbQSwSwRgYhUbhGii09JOg0ehdunQ9e/aUTqP5e98ePt9669YtMU9ivVxdIK36UVzirOlTjGF/\n" +
                "ujevXhEJWJVGzf/fPnr1Mbc+VznMnDYFi4IAqRb+PMfEhNe8eRV25UJqdrGNKd3b1/fI4WOhfftV\n" +
                "C0WohmEjRrNYLP+A1g8i7wJv/NWr109joyvKykQiESASAUcEhmJZaYlMY2h5Ih6CAc2evdy2Y+fV\n" +
                "K5dq9VQbhlf//P2XVqNV6KDps38iEkm1dQWovKy8uKQEQqPIZMo3a9+OQcFbtu2AMehpM2YT8bCF\n" +
                "hfng/n3T09IjY+OdHW1Wr91oDJ0gKjKSTCZJyoX2H0kar2lufa4n8+DenSsRNxkkuKWX7+/LV9U0\n" +
                "RA3BhZUhTnrIkKiam51t2EgUjTYxKPxCFpsDPjQhXkU/jiRggO9EoTMYcoX8xxkzaxVPwPIG4j4h\n" +
                "Pu5R1KOc7IwdWzY9iX9Ko5CAQY5BoWRyFY1GBSors6BEroWYBByTgGZzOGgYqhAJeThMUZk8JTm5\n" +
                "sXiVkpK07s+1eAIc2KKFj2/t4W1KhUKpUKJhDIFIqHUH5YaFWCy6dfPGm1evL1085+npAewrJoOK\n" +
                "heE3b9MOHj7h5OQQHhEWFNy5wXdr/jIwWUyVUg1EoY2tfWN4MlKJZOqkCUwyDngF5y9dAYIPMKcy\n" +
                "9iIDOHVFRUX79+2DMajSkmIMFiuTKfA4jEKhBtoeaNGKCqFQJLKwsp0yZYqDo2Fj7O87Og/IsG7N\n" +
                "yukzZ9eRwvfmddLjR1FmplQvb6+1a9f07jPQ+382lFqtqiiviI1+XF5eBp5aIRUpVQqRUIKBYSyw\n" +
                "pmAMi0YBNp5UKtNotB4e7qChh3Yd7eTkgoJQVBrV2cXFysYWdJvePTpfv3EHVZmT0lh24JJFi4RS\n" +
                "BQWPWbpidU3OyKRSoVAAXiT4CwSghaUVDDfi4i3JSS+3bdl07uw5NBpNIuI8PDwwWLi4GFtaVpGa\n" +
                "lgmc9pUrlhoyu3A44xGu4D1VaR8Go1EGA188T0h+m2Vrzi4vF967AwTOjZPHjgNhDRgCmIYjEPv1\n" +
                "7Rcb82jUmDEZ6RlANU2YNGXn1k0SsUij1d25fRuLhZNfv5n907xO7QK7hHT7vrxKSUqUy2S4OpfW\n" +
                "OfzPfkGF0tPbRo9C6yHUvF9+BTrn2NF/9u7dW1pciILQJSVlRCLB29s7LzudxWB2Dg6+e+d2uVBk\n" +
                "ybf09gn09vE1t7RwcHR2dfcAzKkKef1QvavLiktQeohKwHTu0rVReFVWVhoREVHpfBNaBLSqWUAu\n" +
                "lz2IvOfmbsgtJ5NItnZ2jaElQFvHx8cBCXT+7CkSDu/r5a1RKalM+vPEF1m5xVW55WPHjFy2bIX1\n" +
                "d93lqVYoFHK4Mg2qMdgObLzVy5eQYUggEOBw2HGjRqn10KQJE9AoCNgOFeVlxWWl5eUlIpHg1MlT\n" +
                "aBSGy+Vs27Th7p1bwNLMLTSs2AMTMHQq3sLCevO27bjvKo8O/LUrIuzqmUvhdRc7c/IUmYR1cXWP\n" +
                "T3iqVGrnzZ4GNLNSKacymGw2w5Rn/jY9PTMz5/nLZHNTEzKRlFdQsGjpci/fFt4+LeqTKTNmyIAX\n" +
                "zxKBxTxw0BCOiUmj8Grrxg0ShWGz4Dlz59bqOD17Fl9SWgzeh1gsJhHwEom4YdtaKBDs27f38MGD\n" +
                "OTnZBDze38cHD3iLwaalplIFtAEDB1nyrZctXSKSKHp072GEpIIM0SoSoMPxKEgsEjd45dfCr167\n" +
                "cdeaz4W0OgiNhrEYndawM3r4lat29vZYLOZFUpJ/C98NW7YbLEA8QS6Xgy44aNhwoUBoZmZ2+8b1\n" +
                "W/fubd223T+gVQOmqX8BcrIyJ06Zfvf2jbqtxFs3wjOzCnx9XF6lpOTkFrdrH1iZiZc7ZMTw2JjH\n" +
                "z18kCYUSGo2xcs2fbm7uHTt2Ai3/LuWiPrgRfiXsylUgB1Uq7ZIanuoHt/LFeJYQZ1j5GgWR0MA6\n" +
                "L6k9ezfy7uFDfwNrnkPBkbDQ4t9/acCFhLZt22przTfnsV1szd0c+BY8FgkPOztYL1+2OPL+nX8D\n" +
                "7SUSJtMw6NenR4ixrTFUhSOH/wE+MZBwi37+uWFrlsmkJgwyHQhvez6PTQcvi0YmONlazf9pdkTY\n" +
                "5devkg0TMV+3xda3QWF+PsawoXvtKwGXlZacO3l8/aoVPYPaA8uNyyG1buluwTU8ryWXaW9r4WBr\n" +
                "3i0k+PeFCy5fPJ+QEAcMuS+7jZzsLCsuy4bHAN1p/txZjRJ3CwQbl82s0neTx4z+WLHoRw8P7N9z\n" +
                "/+4tSxMak0LYvXNbgzT0vbu37W2sKUR8Gx+PX+b86GxvDaOh4I7t9u7eWXMRrH59ehiG3bGY5JeJ\n" +
                "Rthp9uzaga+0HPbt3tmwNQPOzJ31IxZtqJzLZqxdvTLqQSQwGZpW+KxYKGSQCG0CWlQ7DiTmjesR\n" +
                "A/r1BOKUx6S4O1jZmDJtzNlnzx7v0bMTeGQGDE2f8sO1iKt1LItff0ilEm8XO1MmiYzDmDBode/P\n" +
                "8uV24Lo1K4vLKnhkYoVUvnjVRxWiQFihUinZbA6BgFdp9F8/JV9RUbZixdJtm3e4udgPG9D3WsTN\n" +
                "QwePjJrww7TpM2ztah9P43K5QNqJ1Nr7d267unvUqrS/Y6wAiUSA0IYk35eJzxu2ZmC5rd+0vW27\n" +
                "jsCz6hrSg0AkQk0NgvKytq0CYCx8696DqiNAWNy7ffPx46g9e3cB39CEwzDhslUqtUKpAS/R1cMt\n" +
                "PS01PiEBxqLOh0UEde3WUAORfbp3TktLxxMJKo027vHjTwwTfBl3c7OzgT9gzqCC/rppzeo6SoK+\n" +
                "MmXSuJVLFllyGMAgSYh/+jUyI/zKBSsLnq2V6ZABvdr4eYOrz583J6tyI+c68NfunRwKyYRO3bh2\n" +
                "lRHK453bN3Pohk0a616i9T+I5Jcv/LxcgMB7W7ltaVZW5vP4pwN6dLHkUPk8Jo9NcbTlmfOYZAJq\n" +
                "5PC+vt6ubCo+tEtbrgnZt4VbYm2bYn4xlvz6s5MVz97SMEoBfLz65l99ruMxY9IPQPSRMWh7S/O6\n" +
                "F/HJycl2d3Hw83QB7KYS4KKiwi9+tsRn8XQU5GjG6dImgM/juDrbnzlzoj4/fPE8gc/l2HFNBvTq\n" +
                "boS9Z+niRdbmJng05OFsh3DpXxtPLFqz4g96ZTjjX7u2FeTnzp4+xYzHMWWRzGhYBz7PkseiEmG+\n" +
                "pdnsWdPS0w3bW48dPcDJmuvv4UAhYbKzsxrwZlYv/d3WlLn89/lAl2xct7qx8hq3bzKEKdAqsxJT\n" +
                "PrUJWkZ6mqebU4dWviwylkHCZ2R8+e7ID+7dZmMgJx4bUDTA2+Oz0oc9HO0Jhqxk+OmTaGPrQ4+i\n" +
                "HnArR1Y6tQ9EGFU1DuHtYsjpALYxh4LzdLblMcjgA+jWZBiiYCB7K96WTeufJcQXFf4rpvfv2+Xl\n" +
                "wp88ZggRA02bPKEBb+bA3t0WTMqsyePIWGjC2PrmyH42rx7ev2sgVeXk4NYNf9YnZzOkSyfg8PHo\n" +
                "JCoek5uT/TVe+Mo/fqVhIGsTlos1P/zKZ6Ssz58zi0XEEdHQ2sqV4o0NnTu1xWLhht2Sveli2e+G\n" +
                "TXFNacB0J7EpOFMG2ZRBIeMwng52Rw8eePTwXkV52Ye+xjMsBho6sFu/7oZleuupUuqD1Ncplgxq\n" +
                "7+B2thbc0JCg+u+k8dm8SnyWYEIxRAAO6Nmt5h7bNZGdlWljZeZkY84kwxw6GYiir3zUsyePMQlY\n" +
                "PouBMyQ+1Hftint3b5MwkAmd2KlNgBGOthcXFaYkv0QYVYU3KUmOfB4Zh6Lg0EwS1prH6dK+zcpl\n" +
                "S/Nza19NKCS4nY0lM8DXkQJDNALu5rXwBrkNkUgY4OHSztOFR6NY8jgK+Wfs9PkldmDYlUvbtm6p\n" +
                "2nv8k0hPe8ug4U2YBB6HzGPRvn5NGH3lpsOTxo605hqodfXC2fr8JDsri07BMyhEIoxJS32D9F0j\n" +
                "B+gnZ8+c2rV968XzZwry8+robMVFBQw81K9bsK0FD3hjVjxWbPSjr78BQUV5j6C2HrYW5kyavaXZ\n" +
                "J8fGGoBXn4sB/UINvGKTmFR8NQ3+Nfjj13nUyqCT6+FX6nkbVYs+/blqBdJxmw2GD+7d1s/T29mO\n" +
                "yyBbmjA8HK3f7ef9xZDLZD27dAzwcnSzM+TdZn2+fd7okSlSiSQ9PUOlVikUChiD+ayYkbqxbPX6\n" +
                "8RN/wKGg/r16V3l9dWP6jNlY2HD5pMRECEGzwN/7dj+IjGSxWRmZmb1798LhsVQqjUAgfE2dQFVO\n" +
                "HDuCTCHqdFBqet7z+KdWtnZfEnjfqBAJhfY2ljgMxKJhKXi4sCC/IQ3x16+szNkmVAIwCO/cul53\n" +
                "YaVS4e5sDwSJtTmvnkYsAmPGq+SXoAP37NrBypQzf85MiURMxaG7dGzzNXWqlEp/LxcXG7Nh/XsB\n" +
                "EXzy2KEvq6fReaXT6Tq2C8TDkJOdGQWPycvNbtj6nyXEBfp5mzJIJgxyUuIndjoc0i8UX6mhox9F\n" +
                "If2ySUOjUXdu37JfjyA+j4HHQGKRqKKinEkh9goJ/ppqB/bu5m5v4WZvCSR11R6WX4ZGtwNlMpmg\n" +
                "ogKDMkTrEIi4jIyMhq3f26fFtt176XS6WqlsE+CXlVnXBiItWwWSiYbQradPYhs22Q4xyb4x9mzf\n" +
                "nJOdZcLlFRYJwq5do1Cp165cqpDI+V+RsvDr/FkZGW+JZMqbtNyY+Cf9Bw758giyxn5+YOwyGEyl\n" +
                "BioqNoywl5YUN/gl/ANazV/4B4NBx+FgN2eX5JcvPlbSw9NLqdSwqaQjhw5pjWDFGARf6gKV/bli\n" +
                "+dLlq06dOBnSNahzF0MQIPDhwV8q9Qv32hk9YuDVq5dMzS1y8vIexTzy8fX/qsjMxm4CtUqV8ipJ\n" +
                "q4cqSiRapQqNapQrTpz846q162EYhYHUbVu3vHrhXO36KrANk82k0Kipb98o5PKGurqxbcXb7LF5\n" +
                "/RocHnfsyCECAX/8zPmqgzqdwWooyMv7ggp/mjn1ceR9PBp+8CDq4eOnAS0DvzbiubGbAI/H9+gd\n" +
                "SkBBOAxKodJjsY2VhD9i9PjNO/ZYWVooZcpRQwbNnDyhZg4lk8UO6RaKw2DVCmXc0ydIB22KeJWc\n" +
                "mJH2dtrs2WG3Hhw8dopGZ1Qdr8q5DvrMjY5UKuWEMUOTXzwfNGhYfHL6ps1bHRwbYCnvRucVCo3e\n" +
                "s/uAq4u9QgspdIZA+Ma71tDho89dvWFra4ElwPv3/zOkX+/Hjx4qFB/opS4hIRKJiEwmZmakIX20\n" +
                "KWLyxDHgnebl5rX29ezRq+/7DAF/HZyc6l+VVqMZPXzQ3Vs3UBjM2q07N65b9cOU6Q3mc38DjBrS\n" +
                "32D74g0bvTX2tQoL8vv06Fq5E41BbPi4uWzauP7x/wYAn8TGsEg4Ppc5uG8vnU6LDKw1LaSnpVpw\n" +
                "KO4Ohm1Box7cf//UgX2G1cL37txez6rycrL9vZydrHhmbINLtmXD2ga8z2/Eq7S3b/x8PLasX/1t\n" +
                "LqdQKDZvWId5b/kOIg7To3vIo6gHgFdMApaEhhhEWCQSIj21aaFfr27dOrbhMqldO7Wtdur4kQPg\n" +
                "Rf/yU732hgPy3caMEdTG186cDTrJ5YvnGvY+oW/WIt9+HYWwK5cc7a2rhhSqVtkBTDPnsZlEmIJB\n" +
                "kTBQAwZVIfgG2Ll1o6eTdTs/w8aNNYM8z585QcbDfbt3/WQ99+/etmBT/Twc3Bz5/Xt1e9UIEc9Q\n" +
                "834TgMzXIq4GtvLHYQw2YVUMVZUSmzVtMmIHNiEcPfi3pyO/S/uWQFBu+LMWw+dt6mszKsGFb1a3\n" +
                "BD9+9BCPRfFytQV/+/ft0UjJDZ+9InFThEajfhoTXVxUlJr65tHDBwqV1MfH7/clq4gkEjIM0CRQ\n" +
                "WJDn6WjraG+bmZXfukOncxcvoWosugaMfx9Hu6zcgpiEeC8f35qVKOTyPTu3L1r4q7u7W25+jpW1\n" +
                "7a3bkXWsm9sExi2atMYzztXR/jsA7R/cpsWMiWOALuIx6FKp9GPFfqvc23riqCE1z964HtY20MfB\n" +
                "hmdvZQrKHPxnX6PGiKKNSiwZofJEo9HItO/3xZY/VwgrymVyeZlQHB0XR/qIlQFe09iJk82ZxKNH\n" +
                "T8dGP3p3vKS4aOnihTOnTZo9e66VtU12buHOHVvHjvuhcdfuRcQhAmPGi4Q4Gx4twMOOjkedO33y\n" +
                "k+XHDu1HMKwVCSU8jc3KzNi6fq2zlamFCb1Lx9b+LTxc7K0i7939Brf9n/CvEDRdjBs+8M2rlLdv\n" +
                "0/xatoy4/eCT5ZNfPu/Szl8q1Wj1EJVKNmEyRBKxVKkCNkf30L4rV/8JVNa3MHOQN4fAaHHp7Knn\n" +
                "zxIgFFogUa3btK0+P3Hz8N66az/wb3RaqEwgFUqAMwb1HzDo1r2ow8dOfhtSGYxSRF8hME5UlJe1\n" +
                "b+nt7OIcHnFn2oxpG7furP9vkxKfJSUmxsY8VqnVY8dP9Ato/Y1vHuEVAmOETqebPnns/Tu3gT2n\n" +
                "R6ETEl9RvjQB5PsMdyGvEIERYtf2zefPnjE1M83ILgy7dqtpkQrRVwiMEWmpr1r6uptyzd5m5W3e\n" +
                "umXajNlN7hEQXiEwLqhUKh9X6+7dely8cAUmEN9kZDfFp4CRF4nAqDB1wmgbGzuhRJFXWBr9JKaJ\n" +
                "PgXiXyEwIqxaujDs6iUMGj5w5MSRY4d9/VsivEKA4Kuwc9umLZs2mpiYRNyK3LF53ZARo5vusyD+\n" +
                "FQKjwMVzp6f8MNba2uZl0qsVq1bPW/Bbk34chFcIvj/CL1+Y+sNYb1/f23ejuoZ0uXT1WlN/IoRX\n" +
                "CL4zdDqdj6sdlULOLyiWq/VpmZlkMqWpPxQyHojgO+PMicNYNFqh1OQVlmbkZDcDUkHIuAWC74vs\n" +
                "rIy5M6a18Gvx6tWbrdu2Wljwm8dzNWc70JAGg6QkGjdmTJl49dJ5NoddUFSaU1iGwWCax3M1Z32F\n" +
                "kMrIUVFeduXSuaDgzvFJafsOHGw2pDL0PeA1Nu/+V6WQEY4ZIYYN7JWakiwQSdlcs9j4Z83p0eAv\n" +
                "63CIiYXgK1GQn/v4QSSHzUnPKz50/FRzs5WQcXYE3wUTxwxNf/1aJJQUCcQ5BYXNTEwj44EIvgMS\n" +
                "n8VfunDe3MIy/nXaydOnmp/tg+grBN8aarVq2sQxcpn8/KXw0WNG7v37YPN7RkRfIfjWWLNiSXz8\n" +
                "E5VWq9ZoVv25vlk+I6KvEHxTZGdltPH3otGoKekF1yOuhnQPbZaPicQxIfimWLbk9+IKSXG5LLhj\n" +
                "m+ZKKoRXCL4pigryr1y4AGkhNaTr229AM35Sg39VtymIGIoIGgqJL56hIEAqyNyENWDg4Gb8pAZ9\n" +
                "VfcoJziLhCwgaBD4BbSiUGkaCL5zL9KSb9WMnxQZt0DwTSEQVGjUao4Jt3k/ZmPxCgl0QvBfBqKv\n" +
                "ECBAeIUAQVPA/wkwACDsN0/FL6+CAAAAAElFTkSuQmCC");//批准

        dataMap.put("signatureCode", "iVBORw0KGgoAAAANSUhEUgAAAPoAAAD8CAYAAABetbkgAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ\n" +
                "bWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdp\n" +
                "bj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6\n" +
                "eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDIxIDc5LjE1\n" +
                "NTc3MiwgMjAxNC8wMS8xMy0xOTo0NDowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJo\n" +
                "dHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlw\n" +
                "dGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAv\n" +
                "IiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RS\n" +
                "ZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpD\n" +
                "cmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTQgKFdpbmRvd3MpIiB4bXBNTTpJbnN0\n" +
                "YW5jZUlEPSJ4bXAuaWlkOjkyM0I0QjBBNURDMTExRUFBQzNDRDE2MUQ2QUQ5Q0E3IiB4bXBNTTpE\n" +
                "b2N1bWVudElEPSJ4bXAuZGlkOjkyM0I0QjBCNURDMTExRUFBQzNDRDE2MUQ2QUQ5Q0E3Ij4gPHht\n" +
                "cE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6OTIzQjRCMDg1REMxMTFF\n" +
                "QUFDM0NEMTYxRDZBRDlDQTciIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6OTIzQjRCMDk1REMx\n" +
                "MTFFQUFDM0NEMTYxRDZBRDlDQTciLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94\n" +
                "OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz6QApaeAABqHklEQVR42ux9B5RUxdb17ZkBJEcV\n" +
                "URQUxYA5Y8458cw56xMVc3g+c3pGFDMGzDlnURTFDEYEFQSVJCg5TOzu+m/9s+vr3Wfqpg4z3TNd\n" +
                "a501Pd031K1bp07a51RMOU3aYvjbxN0oulbhUiuXVnKp2qUOLm3m0houtXapPY6rdWm2S3vh81yX\n" +
                "Orq01KVuLvV36UccMw/XcXDcLHwe69LP+FzuUqIAnl/PmzLMm2RpOoQYsBKHFWxbHsyomWs3lw5w\n" +
                "6SOXpru0N5h6TZfiYN6KPPVD3+9LLCp6ulS69INLy1z6zaWfsCjMbYLFzsHzl1qJ0YuiaWZe26U9\n" +
                "XdrApTYubQVmbwUK05KQdA4kbxlpTfJ31qRi+BzHvZQ4z68ZTUFL/W9cWujSBJeWuPSpS3Wl11ti\n" +
                "9JbcLnRpfTDfxvjsx1w25lMWs8eotLU4vpzOjQUsEklxnXK6Tx3+LxPHeLUqlz4npv/apbcKRPUv\n" +
                "MXqppdmBuRqe7pDUfVzqAdV7Rx+GU2CIcmI2my+DJXJM/F9LEtowf5lYDJLCV5IAmetV4G8c11tO\n" +
                "LDpl9Luic4ykby36+xV8Co+79EhpijUvRi9Gh1u2fe6KCb+NSye6tI5L/SzHJSyS1jBgTDCwokWg\n" +
                "gpg2KfptrlWH67chZjQSPk7XMep8kvokGZkXByUWjZjQIGJ0PXPtMosPYRTuNc6lu516h2BJ7pQY\n" +
                "vSiatqnPdulUSNKuHhJbquO2MbKp6kbtrRDMFsWmDmvn1wlNwDCvtP2VZaGK07tPkmYQ81D5F7n0\n" +
                "t0uvuPQCmL/UilB1L/OwJ5tL29ql81za1aUuFuYsp2e32dTS3mY1nKVi2DYXNvLKsI87C6Zqj3to\n" +
                "ZtYe89Vd+gOL08oB164j+1320TB2XDxXmfAB8HOWOenORt2/51360KXX8BylVqCM3goToToP9m4h\n" +
                "2ODa9tThraOglg90qaeQijGa+FK1riM1OkYSsMzxdprp2PdfsPMXQFX+zKVPXNrJpclQh7WJoL3d\n" +
                "y6BRrIv3sAhq/DS8H/15Ma55oEvv4Jm2c2mKS3uAybZ1qa9Lk/CMq4QYHzY/FDG5XOyMCWJMiTbi\n" +
                "2ce79CqYfnSJXQuP0VvjBVY3M2dba9jcQ8BQFR6OsphQ08sE81eB2SqIiQ3zGan2vkvtnFS8egSk\n" +
                "7oZOPbjlb/yW76al/4ouTXXqnYoHuXQIFhftSf/OpUEu9RLnsVSvo+fnsWpFjJ4Upkwbcb37XXrd\n" +
                "pZFOyXNfsKp7sTeNGDsDTN7fMpml84klWYVQb2X7CddsBan1rEtjXJpY4GOiNRmDmNMLwdEYp3Is\n" +
                "hJ18VH9e9PxChLzAmvarU4/muxGLTKmVGD3r1gvMfSQmtm6VkDZKMLW0p5WQ7lLavevSXS59ACbR\n" +
                "17+0mYzbDk49TqALzIMNMB7LC0ltHHcxof2wOROjcW0tFowbXLrPpTmlqVpi9KhNx4p7w1a9zqmH\n" +
                "fkrnGoefpJOqTDjZuGmJ/bJLb0ANbyltVZhxeiy3d+lg/HWEX8N4+5Ww3TnUaLQnw/TzoAHd69R7\n" +
                "6xeUpnCJ0YNaORw/2/s4lzjMVE4S24BTuM106WHY5JPA5Plsm0BiflEEY70Z/A1Hwd6XrcZp6J13\n" +
                "hLov4/MzwPT/hp+j1EqMntaMk2mwSxsJ6S0nFquS5ntGr2mH0T8u/eLUI8D+zmE/O0EVtjUNof0K\n" +
                "/dNhvs+KaPz3dWk1pz4CcLxL+wnVXgktySAHeSFejhZdDb0916l3Fpaa46RDnVogreDS6S796ZIC\n" +
                "VbtU5VLcpYSgOvyWoOM1LXHpIpcG5rGvB7n0l0svuLSW5feLqD8TXOqVw3tf5dIhjfheznNprBhj\n" +
                "M/61LtXQe6oE1eKdLaFzHndpF1Wa5y364Xd0aRZNijgmTw1NmiQmmPkbF5PvI5cecmmLRujvKXTf\n" +
                "WjA+/z5M9O2gHN13O7rmwY38joaLZ7IxfC3+58VYvqcbXTrcpU4lRm9ZNAQTxEwEPWGWQkKYiVNH\n" +
                "TM6T5luXHnTp0CZYmLgfF4nfTxC/752j++5AGsw0l8pcesSlkS51DHG+Pmb5LO6/oUu7u/SxB9Mn\n" +
                "6H3VYbGO43ONOP6tEqM3f1oFavqDQoqzah4niSClwmKXXnGpXRP1fzNiuPkurS5+3xm/JXMsfbu5\n" +
                "NB3XnOnSnTQmWr3eCset49JrLh0gzn/UpSku7eTSiln0o7VLW7t0GrQXXoDr6N0lhOZTg++5zxe4\n" +
                "1L3E6IVP5ZAsUZj8ew9pEBfSWzL4RJfOcmmlJn5mbXPPQ59+t6ihp4p+v5qj+2qH7XvEOMxcCn6D\n" +
                "F2kxmESSvodLs8mPcVeOF773xPuME6P/49Iy+j4uGH4GtKQSoxc4o8dCHnsW1HKW4rXE2HViAhia\n" +
                "69KZBfTMPYiZfrAsdDfgtyp6hp1zdO+nxNhUWcaL6RKct4FYHIblYVwOsdxfO1d/IjMsLhaCBC1K\n" +
                "LYLZo2REFVJLOP449a6IKd/k0jCnHq9tiiow5tqgsTgWqzHd1zv1sNS789R/nS12mUvrRThnsZMq\n" +
                "y1ThNISYmmf4nY47Jkf9nUDjFUc4UYcN3wQ+wBHvYzbFwmvp9zfyMJY6rVWnBesyVqZunQ5t9gSu\n" +
                "odZJwW7N3InjO11zT9fhu8dJFdVoseG1WJGtXhWwFZVQM9mOqxNqnqELYQtmc/+uLvX0+b0nqeBa\n" +
                "Mq8d4dqP4Dytkm4ufrtdqNQKUq0sB2M62KKyP4Xf2rr0P/r9dDpvII3x+3l+72Wwu68XoVL2znNo\n" +
                "rla8/59d2q8lS/RiwtRoKfy2S/vTd3WEqHII9ML1z3Sl091duoUkUCZNZ5uNhETZ0uMYjZU3ySAa\n" +
                "Az40wvV/wN82TsOqq7Uk2b/AfXSK6jk5GNfOArGm2xT8rSJgShLItA7UFzPGk3PQj4EAN9mavvc8\n" +
                "aHBa05iJcdJS3WRTJgXwRs+NpZDyawPs9B+nvtxXCTBToPRveMZZ8kjAiwyVPQUv8SY57Mf35KXf\n" +
                "ywf8Yvowx6V9Ql77ULKR93RpBEKFDpxv+reX8P84ckpl4khcBTa2g/G5zqU7KGR1Ah17NUlQjU34\n" +
                "26V+Lh1Gz5mtLXwArvNwyOO3cekWl8aQn0DG4KsE8EaRg3HVluSMKxa1fYiH99WLyb8XKmYuSSK6\n" +
                "trEcs5xLnwsVO8y1TaxcT8ov8Hk2HHFGDb0Vx55L1/8CDswoz6FDYj+K7zaia0516Sh8/zAtbtX0\n" +
                "+z/0TvplaY79TIvcuhHP1/f+RYTdqulvpUDYGa/80XhXzZ7Ry4qA2W+xhMwMYydFbFnTNy51yEM/\n" +
                "tkSYSXqAT/Q4fiWydxM+AJxuQMVdDMYL8nqfjPOWhy1vvn86wrNsS4zblb4/kxYac92rALnVn38j\n" +
                "/4NEEGbj+7iWrrUIIJpMgDdDXfqaNL5aAtkY0NRCkCINoldzZ/RCh7COtzB5kpxtUlV/NA8wyB2A\n" +
                "ErMxnZakrUI41xSQX144c2UB79ju95e431EWZNhxIZ5pf8tC1Y0Y+mdIfIn3vwGSUAk8wt1ZjG9f\n" +
                "gV//JMv31Y5yG2oJDWlUeaPO15E5oheXS0uM3rikVal7hMdUSvJq4X2eksOYMi80X1qYbSaYaUAI\n" +
                "zaGLS7/SuftbjtnDg6mroJ5fSBL+M8v5owjmy8zS26dfa5EKex2+u0MsKEtEf76ET2IJaVFmoR2S\n" +
                "xTj/R9znJI/j7oE51DfENfu4dBuN43zMmWpC0sUFBqDa4/0UJaOXZ2DLNTaNoMFPEpnQWVIsApeE\n" +
                "xGSHpd2hitqY70FIvijXu5vOn25xnMWg1mtgyDGwfRXUWXPMJHx3jOX654jJaj5vGxAinIbjHoAZ\n" +
                "ME/4OCSjj6LEmgQYxjD6PhmOdZmwrQ8JcFIqzI+w1z9VOE/not8JmCdVFsz8iwgpFjWjr5hlAkK+\n" +
                "6T7B5EaC11pwziyNsqV+iCW/bYnPqwCJHERrQTU01zgt4PhvcNyx+L89nv8Xj+PvFGg/BTu1Y4Dz\n" +
                "y9iyr4vFSDv/3sFY/wM4rv7+CdJwJtDnX7LAuHPq7bM+x/1Ax70d8R7doXHMg0+jEoxdSbH2OrFI\n" +
                "foAU56Jl9IoAmzKfFAvANX8qmIodbTbwy1E5Sui42pIFVUcJEufTpP45w/tcSdd+PQBsM0N41w3G\n" +
                "/TbL8VuQPZ8gybVGiD69juNnQbVNkmPtI7L5zXsZDFCMYXQTfbg/5BicBEcia5QfUd+38FkoVQhf\n" +
                "R9jQpXE2LiE13pYHMbpYGb2QvevfeDB40qI+3wH7ONt7bk/qK+PkWWV9mQpYmO82ENdZAw47v3ut\n" +
                "Tef/4+MwXJFCVn+Cuf+i9NnzgAy7E3nylcKPofu7Xsjnf1+o/GahuIIWgRGQhAlkp5mQ4c2kEl8Z\n" +
                "cpEfTaFGbQIciXi8WWy8xuQJMS+ycZpdL5yLldC2OB2WTcM3XFq5GBm90OzzzuTRni1WVFv47JEc\n" +
                "3nuyYPKR0CxWJwfaXDjUHOrnSHGdt/D9+QH3e4budY7HMet4JOCEoSkRn/8d0gCS5Gg8BQyo1drH\n" +
                "iBG3wXhoANAgaAEKi0+YJKWfLX1OQqrWQD1fP8BRWRlSW/Gjk8XiuIggtDUWM3EyzYGS1z1Du3gy\n" +
                "SdJlHkzODqI2Obz/eXTt2y3S3vx2Fklu892eFkYPqvqyMx03xuOY9YWJsgQOI21PLyCcwA+wVXW/\n" +
                "b8Ix10R8/m2Q0z5RYBBuJA3C5BScQv3/SWAbwuTFl8GfMl+YRjKmvZdPVp3+vGaO3v258C0spIWm\n" +
                "jhxzpqRYnGz2DUuMHp1WJlvUyy7nyf5QQLgom1pp13hIoCk04duIUNYoPMMpQtUf63Ov9vTMXqrq\n" +
                "lpaxMOGrAWDOroh9M0BlRoY2ZQfhhJpNMWgNJHkBn3W46l9kI79G4JZuIRldIthqLcCgf4vz/qLf\n" +
                "euYhFfpCGmtTXqxGpcqOVVMIbrFF4ygxug91IucWh88SFkk+IUtoZTZ0DPVjB4EoUyRhmb4LuObZ\n" +
                "pDLeavl9PbK7eRyeoWOOg93cwyL5nouI4b5UgF/YdBqOeLz+vB00BwXmH5mFY+xiMWa/0mITh7Yw\n" +
                "ABqAOebdHGQdei10b9J41xFGo45w8jVk2mxTYvRw9KwPEIYx6xMLwDZ6lCT4NiKUxdL2RJos2/lc\n" +
                "byPhAJPQy96kyjKj/4CIiUOSdRcLRt5mhvjRy0KDqCLv81O06OxKJsq9iOvXUQGKKOWivhOmTkfV\n" +
                "sF4cFxKZL2C6+cxf4ISYGpH+uoT6tkmh5YwUEoOvBltHecTKeWLPiJjHnS/q6+H5Zxy4Odbg1J8P\n" +
                "uOZndP5/xW97i+sbSTJNQDzrVHopqSeJKbYM+Wz9cf0l0E6SJFmnUyLLGLy7f6DaX0EMsGvE8byU\n" +
                "nu1qMc5veYzxn7DNB0ATPDlPpuTXYtwrBVa+ksZnjoj8tGhGlw//qsguSgpiO3fFJurz0UiXjMH2\n" +
                "fEVMutmkwmrajc49JaQEupHOl1GEXSzY9eFQb2+h40xmm7GPRwc4+Ww0jMyjaQJjP5SclXfA+Wg8\n" +
                "+3fQIt0/YlpsNWlyNuDWnuQjMEjISozpUkIn5uPdLw8T6UeRAVdDaa4Mvf5FmE8tltE5lHcvTd5l\n" +
                "FLtUFnstDJy1DF7gf+cY4/4eLTbTLP0bJvDZ4yjNcQM67saQtv/zPnnsjI7bCf9fLJJlThX/fxkh\n" +
                "8WMJJNOdZJsbx9PxlMk2GKAYs2HCXSpVwLJ1hibbmSHNCRs90AgC6iWS7LXCVmd8/B+qvp68U5Lo\n" +
                "9ZBPG3ZdqsRvRvCs7yUGO1dhtyGiT79gci8RaLXWtLIfSszzOqmbfpJtKYFneFeWa8T9WbWvhhfa\n" +
                "pGQug+3OZabeC/mchonPUPUlq6SnXzsdL8PnNQhochB54t+LKC3nh0AXrkdh1rnAncssus+Av8h3\n" +
                "6fBqYvYqYnT2zJs+7d7SbfQDLfa4bZX+MQP8OMNV78xRf9eAlFMAjSwvIKyTLYitH2lRYwTdAT73\n" +
                "+dgitaXUM8gsmQewskC2ra9SO55cHfBs24HMDjbLA6HG9/wd4/sbJvfKYLgkACwGxXh9hHF9S9jc\n" +
                "9wOws5PIWvxCNaxNtxJMKLMITVKNU7N9G9LqOOuNJXwVOWs7NVdGjwU4IbYkpuFijUlLSGqHDO5/\n" +
                "nLjOYzmaACb8M4/yArrTfYytvKkl/Mb47bk+oa6LLRO6i0qVe+aMMXPOkULKm8XibAKw/NvnXX0m\n" +
                "rm1i/lcIaX4vLaRfw8NcSSE3A1v12immNwBHe0NDesJHDX9MpReaVD5Sfx34UBpz26g9RQQgqRoW\n" +
                "oTQO06dbokTfWYTQZPJAJgkKrS0q+mWWnOlsQ3KdCKhxqSUxpY5s06cpzutYEHRne9xjP0uSSzvC\n" +
                "uc+3jE8PqLFLoDncRWmVowJguDHhVdZ0uYDCmvfyLzKNHqW+VpIWMZbCfbKWwG8RYLtzoPV1I5Mg\n" +
                "VwlLuaJVhVO2lnLZjTfezOvjWhqjzxA2ua2u29QICQNtIfm/xsrfyiM5w4AarssSYHEUIb+4uMRC\n" +
                "YZevR/fdwqLWP+ATalwsHGh9MD5PUcbaXJVe9tl47FdVqWKKvEHFFQHhTS6CcRjGn8duGhbT+yl5\n" +
                "5XryhfxIoBnbPfa1MHMNMbX2DayLBalG5OmzhtfYORkDYZeHwRxwOekqocIr5AG0CEa/08Mulyr7\n" +
                "thHNhGct6rOmfTzyxydB4mca45xIEre1sDUfp+M+sCS79MVz13rYzRXENL9SaM84vw73wJIbRt9G\n" +
                "aAUqZGIN12fvJxxxrEpfjn63o7DoNNJ0Rnlc/zZLuq9Z4DcUiLSFyrs81xBEEjZvhPm6LRh1p4Dj\n" +
                "NhWwbGmrL6OFYLPmzuj3+gBiZKWWqNe+TEgA/u0Nir2OUen7oY9DEkPUScMe+NWFyj2HmJ9RaSbU\n" +
                "sr+QaF0tC9erNEYnUdqn9ihvTAgyhlwOpvj7lhYmCfL+Hkz4fZ7oRq3/SiyMMerXfNJCvOzRxymn\n" +
                "/TZ67zerhmW6WIJXC2ixkfDH5Hm+boEkHQkz9grpvmJh9Eow+RLyZfwCNb5jc2T0gyzQVrkXVhjk\n" +
                "mI0eE1rBXCQksP1qPKR7gFkesTDCJ0gR3TQErLInnXcM2e9GaziQpPOvpIafBmANP/exyr8o5MsI\n" +
                "L46wIOh4d5FDyUnWVti1mrYOeKYXRTzeVr7rMg9taapKlZvySk0dREzNud+reTgjH8Zisr5KVfdh\n" +
                "rezoiD6c1hFt75/oXl+FOGd9CrXWEpDG/K0RWZhbNUdG/9YSL49bUG9h6miXEWO9IOLaM7GSLgWw\n" +
                "Q25ZdIZAunk5gnaLEBb6yRIaG0rfnWa5Pk/YD5W9npkEkJjn7qVS5ae4jtohhH030YDB5BnexedZ\n" +
                "BtD9ePHYUICDvqd3ZBaW97EwGS9zUN31/nS9lyy/j7cwQnuLOh9lD/jXEfoLm9QzRaXX2RsV8ryh\n" +
                "4h1XiXx2LuLxUnNj9GuUdwko8/1dKlwZq4MhEb+xoNOWWFIbTW742pTj3EdMuodUw4IOh4XEQP8j\n" +
                "pIvxvssaZx/4LCp1FsfjZjQ+91qQa2bhvMSSJ/+3iNvOCgFJPYfG0Die2qjUtseV5CAbQsARo41c\n" +
                "EALwYugrknobW0JWRivjumxbCdTZsyHnS0yl1xZ4O4Tkv11onyYt9eKQ8307Aaipplx2A7CpjZCv\n" +
                "XxCMHuTMelN5F4xIeNjUQSWeZHmn21V6bfU6YpJZFFK7wmd17g1mnamiFZYcQhPTwcQ1qDaeqP2E\n" +
                "D+EB2GnzyW5tp9JLEhs170kffwfHmjvCTp4l1NTf8L0JeWkE3xHiesMJ9NNaLNA/I3HkQ49kGwch\n" +
                "RFOEIYgJzDhca/n9aYuJsIJKFaFUcBpGqST7hpgzt3gc20ally1TKn33lijALe2p/1TMx1oC1Zh3\n" +
                "+5cKX96rYCX6tSGz0aJW5ziQ8r0TkCz7i3RKvu9ksrmNN3s07Mo3hT3eGyGszSLYcrXC2eZle+4O\n" +
                "0Ep7+u4BD5ttLXoO28S+wiOU1R/prvzdVIS/HDgObQku4yj918S8zTvaRPhCbhQLfLlKFYy4PCC/\n" +
                "4VuS5j0tQuMPoVF1ETDXmzKYhz1Uw0027vHx9TCWgAE9UXeEPVQIJBNj54ScXGxK0aSMvoEKVyHm\n" +
                "rAyvvyFpBP/A0y0rwr5DHuOXKbTFJZsWQJ1/N0NAQ1vCBdyF7/5BX1YJcf4Ai1PPSOeflHfBw9ND\n" +
                "2o77YUyewULyOt3vUNI2llAUog1lobFz9Hoyf1qLd6HEomCjA5R/XTzOzjNFNrnE9udZzsnzxXx8\n" +
                "wbJwSm3jcfru5oj36y5s9jhh4WvJhjcmRZtiZPRHLUwuGf3GLO+xjwBWyLLPjwNVNY4Y/0rqQyf8\n" +
                "XhUys8yLLiTQyCUqVT9905DnP06qYbnFC24zI04iAND2iGpo5r8Ikuklem5FvgRZMLICzjPehWUC\n" +
                "OaK42OLZHjiHXcgk8XOmPkdOU78qrOPhcORMtRkhF84wPh7J7MPFdxd5ZMs9muE93xJzlHf65dBh\n" +
                "/2Jj9AEeTM7MPjlH99qS7NwkAVHMvdeBei3tegU7yoRFfguZcOJlB35OpoSxv7aPkA1lCxmZ2mu2\n" +
                "3UeOiAAlVSIOvRCe+KmE7HvPcqzs/x0infhWmExv+0QPbLa5DfrbirAB3wrn5e8qd4UfDWJxmkcS\n" +
                "1e3CZv/JI4koCq1Az5YU4eUa6seofKH+8sXoD3nY5IkIMV1ZuyvITFhMjo+FGMTFAJ48bonhy328\n" +
                "OlK8+xvYiydgwl0YIuy3g5gwPwlb3IvWUenVTH+yAH2GBmT+zQAzLAXi7xM4zK5CLPp/CNFtjmyv\n" +
                "laGu9xbOv78taj3ThwGLyEPinbWzhFeXKHtRia6q4TZPxpYfkOP5uQY5XdkpfJOH1qRC+B+CaBOV\n" +
                "vntukuz2Ko8EqIJm9GMszjeJZY9Sf/2/WH2DEhlYYhhG/1SlF1OUTjpp+/aBurtYNdy3bHQIG+pH\n" +
                "4a31g/EeAhU7bpnchsmM13aYBzSTt4Lqg8mUzU47iwNSTF8lr/W5Fn/LGeQHmYr+rwYGCfKY72jB\n" +
                "v5t6dLnMqLyJGFuCteQW118IjEa22Y/3Ct4wZaiWENYh19pLXhh9Wx8Pe4Kw4VGcDr9GCMEdLfwA\n" +
                "1YKB9oDnewjs6akWGGJrkiCyImkQEGSwsH/7eYyR9ADPRd+HE258O4KXvuEz1vNUbjb9awsT4Vaf\n" +
                "Y3aDF9r8P0ZgGFZUDctSV4pccy902rMqvYoNowtzlWU2WkjxWrGoJCgf4Fz6/gOVmwKUfchXUkvA\n" +
                "rqUYvyWk1cUKmdFfsWSlscR6L4MHuJXU0+1CHH+5BQ5r7n+yJavtV49Q2mkWaftEwL270sr8lkB1\n" +
                "nWzJ+dZ0A4WZTqZn3ZsWuVc90GVjkTbaVFmI9ynv6rK2PeNt8fe+CHWxCv27Cl/EMkyRy+uJoed5\n" +
                "YDqYvoZWmLDMm2zpcErLriaIbBUY3cy5IwqV0Q+12MF1gln2zTCxgF/CqSHOeV+AIw5WqSIXBojx\n" +
                "sLIXcHAoDdMkaAz3iY177QVmwlT/EmAPw8gPWxaYlaEJvAEH30uNiZ7KgExt9aWqYSHE9wTU9w1L\n" +
                "WuxzquEGlvGQC3oYh9vNKr0m/ecAE8XFXB1IyUcJi6k3JMfj9i31ySDnqonxzb7tWxUao3ciAEtS\n" +
                "OBr4BW6fwbUrLDHOoInQgxxLBk/MKZfvEDBjnliAHhQru1Hnjcr1YsC918UL+5O85pwLf6LyLyvU\n" +
                "m8JIW8ERWFagjN4dUtomfUeJZx9A43O/Sq/MIkNPG2TRpw4qVcFWCR/LyyLqUi0iLGcLk8Mw/ZE5\n" +
                "Hrd7qB+844tBzdVGRGc2GqM/GJCw8qLKvg77JyLLLOj4QRYvtqwg+iG80LxAsN3MGyicRb/dEXDv\n" +
                "l8R95iHBpuA348shjaNwnsE0PCAWf6Omvw5HZo1AGEahVsDdy2KRxnxciHfKWuZrluv8RziOF4o5\n" +
                "kgvqbQHRJARqLgHTrVehMPpyIvXOZv/kAgiwikrfjy0MsOVIkbF1t+jnhSK8ZraCesUipWQZpD4+\n" +
                "9z2WjpuvCnwDvjzRAfDCz/FJ5DlVpWrP3+fhSwnjZDtLxLvZiTZHeNbZVNjH45p3BUBlc0GDBYgp\n" +
                "QUxeRwvi1wjBNjmjH29hbOnkyNWWOX1V+p5mt0Y4d5BquB/aNFoxdydUll8sVFmcbZK6qNQ2wONb\n" +
                "IJPLikIJjP030O60w1RWbGF1+5qA7DKDm79UMG4SyL7XITWvJyG0VKWXpBrqc49u0BqTKlqlo0w2\n" +
                "hRgvzJZalV53zkC1y5uS0Y+1oM0k01+VYxtzkGDWO0Kcc6A45zqKkU5ExtndIbH3d3pg0yWdQBNs\n" +
                "jRbO7OsCfVihwm3gsNgjd34TqLPvq4a1AGcg/LcChbJ4EbiXcAnzI4CZ8j02Z4lwcJVKryRrYMnt\n" +
                "m4rRKyyhClkaanQe1R5+yYNVcJ330UIL6G1RK2cETEZZlGBKSFjrFi2c0cPQHRao7kA4UYchuWa6\n" +
                "JQ7+IvILeokciCqRDHMNRQBOK6Dn7qFSdfTZA7+MGF0/5ylNxeiDLOE0CXPdJ48DdLNFSgeds7mI\n" +
                "4+8n+nsdJT4M9UEoHRsy3HcNcOBdS4wcSFcL2KsXzHYhnKgXe0BjtxPHPwzU3TLSFtrnuO8rIf04\n" +
                "0/3R96F5WKtS+7ixB/67bJJ6snm4l3zSUE2NrbIAOKK2086DCnxaBiABiVy7JoPneNECtxxO4Rft\n" +
                "JNrGJyNpcSOpeM2dzhbvUle2uQBAnCcwT8wWUV7zajWVXvjT2OEX0HfP5bjfbSia86UKVwrNzwHI\n" +
                "WzqZz5XZ9j3Th9PA+0UBCQ4nhMAd/2o578qIfZElhKMWlxxFXuD1RUJDrZg0vKdXT4rVf1Fi1Kxp\n" +
                "Y2HyRY2lbylU+9eJEesIhJLrai7/FfPv+gyvs47QaAyD15AKvywg2pMRo/tBVWcFMHlNyIyjuy3n\n" +
                "3p/Bg1wirvGKCrfX1UZ0zs+IxcYQS10Xk4Inj8xuepd+u7uAgS3FQodFjKRwTXUG4HxLvpbD6Pvh\n" +
                "eejzZsgYtGUfRqWhJHS4sCQj+bZsLIm+sU+8PBP16Hk676kswPx3WPDKvQJw6V97pFg+QYCaP+kZ\n" +
                "/xBSfaBwHrUpMWuj0+YibDpKvKNX6bcj8tSH9cTcO8MncWg3hKRX8YhOsFSvFQCfOHw+azcGo98t\n" +
                "stOWWvKId82A0RcFMPnmyKlujQHrY8naulP0Y5wPGm2gGNTdCYDhINlE+h4qVfo2xo5K1Yd/rMR0\n" +
                "jU7ribzyxwOAS93y2JdLxFw5TiSyjBOgHhsoqJxSWatUqjS03J/+iXwzen8RL+fa1bzZgM0MiHmE\n" +
                "Fiopzul3bxMe+xG5wQmPHPWLKa/aqOQHewAv9iYzxGC35yMccxqyw7gU0/aW51gRWIEOJcZrVDpR\n" +
                "SPIfRcpxd5UqWOlVpSfX9A7dbyr8VFeohnUQTMq07Rpbibh6guDkCQoDt8kno48K8LTPjpic/yAB\n" +
                "AoJ20ThH3Pcvn3BDH5W+YYQfiq6/StXrlru3TKWXFFeNv7lficJV8xmuGhbc6C8g0xc2Qr9eImks\n" +
                "+aRahSti0kql9tAzaDmTO1IZMYszI0bfw8LcMm5+RYTrceXQOzNwugWV/dUD9qQYbJ062U8FbzQh\n" +
                "sdFJ2OvdS0zW5HSESm0q4VeCWWY8npmHvrTBgnIjHHKcX254o9rC9FeHyB+ZThpzHNrLUiFY18sH\n" +
                "o3/hwehJykLqloGaU6eCK7cYWp/CDGG31rnagrgaqtI3V2CaSKtpgtT/EpM1LbWzhLImKHv9OemE\n" +
                "UwC0ZHLf1tAQ18ac2wmx/beBjKy0JOtwkdJlQJDqeTcZvqA2EbWWOBaPOiGE9shVeC1GduhiC9yV\n" +
                "H/DiCIPHRfeGRVg9P8/Q8bUD5Z/zJNlRede84wEdW2K0Jqe9xPubpBoWu+A00D/Ee7zJg4nPAgZ+\n" +
                "NJxcL0Pzew6m3JfASywkyHcUWgYIdHeVXiwziMpJ6HhVbLomW0aXzrOtxYoVt6xifSPkDZuKKzMj\n" +
                "PLwpKfVnhHM6wJYxfRtieREfCqCMjoWPpAF+vYRVLwhaDQv8D8hrX1EF19lnusQjG1JlQUmYdg/g\n" +
                "ngch4nSHOGbvDJ/5Alqsqon3DP/9HRaJF5bRb6Ib1qmGGyW8HKHzvLPoeREWB+NhnRMhjvgg4aON\n" +
                "ebCtSq/WykUB2wq89FKV+6IDJco/HQVp+CCiOVd7CIfWCME9quqLUBh6CtJ8oUptecxO4I8IbbfE\n" +
                "Y448KZh9YAbPoe3/uULAmlpzRqN+IIzgC1vwYbG4WVx4Fs8N2XEd/uDiDRuFPO84iwdTx0yDatDt\n" +
                "ptK3IBpKnvMBKlVUn/do006by4jR1y8xTtHRciq7steacS8ihjJM9YZKFfL8D82bswPALwrHZ9KX\n" +
                "W1R6YYpa4fDTv+2cC0a/WTUse1On0rcZPjZkp9emc5aEVDuWo1j3C5astXEquIbcReT80yGXS/Ey\n" +
                "u2L1n+mhmi0uxceLjmI50AYWCGm81JIK3V6lKsR47eDyNF3nTzD7HTBBwhZ+7Ef3SRKjLyMV/ops\n" +
                "GX11whDzRgzs/RsWYfUsByLozQgrnDEbpgtQwc8WfPtaKri8kRKhmZsg2T8RuHYzsM+r9B1NSlT4\n" +
                "3vlM8A5bqYbFLBhVF/MJxyo4C23a8Gxlr7r0UIS+XSZ8AlWEnOMEnowZ/fwQOef53Nt5JRqg+VDF\n" +
                "zW+9kELKxSOqsPJ2CcDqj7a8zLPhiLsCKjz/dliJgZqtRF9LNawaOwYO2LsIdnquByNPJQj3JQif\n" +
                "cTTgRpGRlgzAw9voFIHr4N1YFczhlbNh9JEWRmcmfyPPaLHBFob8n0rfV3sllV5Y0Hjzjw7QLM4V\n" +
                "54ynZynD+U+BOpUYqNmRTgu9VgBapqmG2zJ9TTiRdiHSVCXOfTnCuCdJk+wREVy2wOKUi4dFygXd\n" +
                "4DWhxkpGPz6PL6Ij2c6/UEzR4M7/J8ASW1gk8TfKv67bQ+L4bUsM0Oxpe6QX23ZSvSbAEXymxbT9\n" +
                "TTXc/kv6jHYkyf9phv0eQXxo1Haul3BUpozeQ6DhJH2lcrw/lJC4L1J+b3t8d5BwlOiFYBdhn51s\n" +
                "8abrcMgaFhVvjJDobUuM0GypL8JoEv/Bu+hMVA334nPgUzIIyY6CySVfPKnsdQnGQhBlGq69k8zT\n" +
                "OWB0rhT7g/IpWeZ34WcseefsUPheZV42J4jOpPvsa0lY+VIM7iOqYR2wiwSSaSFs8wOEg8PQkS1g\n" +
                "sq8IHMNyLYjBN0bK8ULxvj8BEKwbSUtNh3g4pY3E/hap2n+KzLkRiOa08kmz7pxltp6x0ReS6s6a\n" +
                "xD5RGb0d7BW/AhNT8mS7tiGPerXyLh5xvgjxvW9JWFkV6vkii7edc+i/bSGT/uwscd/FRG1UeuVX\n" +
                "ltqDLcLDL0mmo7KXTvsGC2erRnie1iq1W5Fx7Mkw9wVRGf0wC4MnBXb4kDza5ibM9WKAeaBBL7+K\n" +
                "2PzxHmrbPT5myBEtYOLHKM14ZAuQ4hMtuQ03KO8KsLfSsacI0NVIIehmBTh781lNZ7JKr0DDlWJf\n" +
                "icrow4QdkxDSvSpE/ng2tCacID1Dxk1fES/VaxeOHREp4K1wnomYbFCs1I+e+a1m/qx7i/nweIh3\n" +
                "XEFCQ//d0xJ2mw3nbrcmfLYTPMAzSWDfe4Zl9K4qfU/xuEX9eaAAX+6xItxwb0DsVHvtD2xBtuph\n" +
                "AqXVt5k/71bIpdgswjkDPTS+WmSzrVYAz3WDAM/UCvDM9X6MHhM53zUWJxyrLpsW6MvdU7ygd1Sp\n" +
                "Mquh94TpNbQFjkFXn0zETQGv5mqyUzFOhVK3X/sCPqbFp5qSbqr84Li2bLWNxMNKG/0HVdjVTg9S\n" +
                "6bu7vpbHMGCxUC/yOhutZ57KYuePIiWzB9+hwqP+nBBkOnx1ncr9ji65oAEU1quBX2oJZdh9Youq\n" +
                "BElFm7f93iJ4obKm2AUtnNEv8Xifu7awcbiDshJXhKNtgQUf0rPAn+M1ikotRfIV79W2nzynzGnY\n" +
                "NsXfpFkM6K9uCafw28cunUr/X+PSAKfltr3FO03i/y4taAzWdelEPH97lz516UUagx9dOsOlrVya\n" +
                "3QT96+HSQS695dLNLrXxOfY9l2pcqnApBoqDdNuuwRkWG+YXAXmVRSYezeHKdGieYadc6eOnFop8\n" +
                "25LUujglCJnKuLEWYrqM89BqtGPy4EbuT0fAZA+BU/hNlb77UWUAqImxJsZGXwztJAFVfh0/1X1j\n" +
                "S5om15XW312e5UPuAofCN/RQ+XR2fEDPc3oLZPR/ifdZST6YhUWgpuaCTrJ40nU8+mLVODvd9gJq\n" +
                "7T+IWE1R/iWqbgm43hqU/lpN73QJCeUd+JwKIeD/cWmRS53xf4z+avrEpeuzVFE2cml7+r8Kaki+\n" +
                "2gEu/eZST5eOc+lRl6pbkMq6nFDg6qC6OnjPyzeRqtqY7TOXPnJpsUvTXJrr0h34P5dNm8LtXGoL\n" +
                "U3EVl/ZyaaBLqwWcq8BjtS5dFeKdtqb/9Xnlwszu5ae6H6Yc3w0aglaa9iHABFqCDKdrjmqEFXVf\n" +
                "ut8OBVrZJF8wUGmKhcnYKlE4KoMavhO0g68QkpvuE49PQpPSCWMzQO+IKjInhkj6mihU90oRTx/u\n" +
                "p7o/F6BSnOcDQHkEKsk0JIysGNBZYyfe00gvxSS4nN+CJuKpHgs20x+l8GMk6gSB+DD8PjN9+KVa\n" +
                "wLPngslnw2fwJ+blT8DSc9rpYwFh7FOgrsdFxRlT3GI8C13pIJjq0+laxBzlDduKTB6ulvkFFoD9\n" +
                "RO54dwrwH5XBYC8H7aGfT9rf1oA+mqo0p+N+H7SgSfkkgWSSPu/25BIDNyCd6HIWKsRcDeDMZyp9\n" +
                "mydJY5F5ub3QWsNQHaWeqhBCqSM58BIEoDH7tWlBuq6XRP/JRwJUeTB6dxWusP18oHYOUqk9zhZG\n" +
                "AN90B+BhDBak3+BpnIcBvlilbxI/gvptqnl8i4FoCdj2cgJWJAMY/RcRkWhJEl6XHesNZ9lwAE7G\n" +
                "inwISXr+fQ7H2okQKly+bGXkE7A0X0CmUxU0gT8wf3mPNTax/DAr5wuYujmvjt71sTZG7y3AA1IK\n" +
                "zPVRx9dE6t8M3HSysm80J2meCi5ufyCy2OaGuN7DdN5NIg21Pzys27YQWOz+EaTJ4haEkuuEDMfh\n" +
                "sKl/h2Sss4xLHKrwMlowz/IQTp3AA99QOuwgQGvXgpBcDzkG5RBKgxEmSwoGNQkru/r4g64SvGrO\n" +
                "49yUE22Mfo7yLxv1fMjCBgMgMTeF5P4B9sdUsXDw59ehGg2hCh7bK3tVTt5gbxH6OAVY7n09Yuhm\n" +
                "VW1JpZtfiMDotcp/88nmRCcGjMVfyGh8E8KKCzp+anE+69yQ/xIqTdPTPmG79aB9vgnhlRC2tQrp\n" +
                "u9IJNvcRjybQ31oSsnfbGP0GC5OzvTAkQ9UuBju6PVLsviXvo22g9RZJH4nvFuL7o/CABwBsoOvE\n" +
                "b6DshfZeEqudgubREiZz55AaUJhtpZsbrY3cdAZSae1PV/89knw+61pU43+Q+KLn4bPQBJjBXxUM\n" +
                "3hUa6f1guk9CvAczX68N8SzLCwdejUqvJTfOxuhviJvFBaNvl6OBXo9UlZvwQFNUetlmpqXQEqLc\n" +
                "o0Kl9kc3A/dmC7I9d4vI5GYzwBVayPisDKfZ8T6Sty1ligXREjjqjoDJdAMEzV8ex8dpbmot4UHk\n" +
                "I3ym0ku1BfmSjrdct5JU94lGCNqKEnBaapyA/q1ybDvOF+l3qyCmu8zijRyBWGWUVVvaXHu2ILX9\n" +
                "gpATVMbWD1Ylb7t0aGrsyHcQRHViXlaRMPo7ZJgtSYws89u3Iw3hlxCQ7Z0I5ZgknwL3c0dm9L0D\n" +
                "MtaeipDvexhUoF2Vvaj8jYQxtlXcXAmVPd5R6XXdTBHIMAUT+orB/VtlV5iv2NT2PyNI8qSwLUsM\n" +
                "nk4dYC/PEGqyF5m8gulw3O0Ek3Fd4SD+wQOAM5Gc30Fzdn0SjHGyz00/FxgeNCeca2F0Xuk/8lF7\n" +
                "2yFG/Y0A5hsGO8HDdp4UYpD7q4ZF9mep4HryG4uX8nELmpgX+jCzbRHnd62jIKu2QGZuA0bclQSV\n" +
                "dua+4rFoVkEj/QXe7xugft9OEvY8j8IRrM7bwtW81dgLSEryyos/WPSpimLpSSwCRzGjH2EJq3F4\n" +
                "bbyHvbBzAMjGEG+i8BW+m6n8t06S4bsHxTX91MwR4tjBLWjS3hkgtW2/JVtw7v4ZkK41HhBhwxOL\n" +
                "4BAeROG1FXD+KISU2QHqtbca7+57MZh/fQiv51X61sjmuHM8rtWPMCw15L2vJrNCM/ua/LDKJz11\n" +
                "nEfs+Y6Q6iF39G5yYHwN72W/CC+FN2ew1XxbXTWs2NmqBU3cayLa5ZJubiHj1B6MZXOSGRv8fYBO\n" +
                "1hRSdRMIj9HifO0A/hGfp1juuRfZ8gbN9rOYr7VgTsah7O7zHLytch0h5Mw1NE5gC5PyNkNMAmnQ\n" +
                "f+4BEugJCfIgQC2aLkIqqy6Re5pquAljF4vDbTHsw0Eq3E4WV/pEA54R1z6pBTH5Kj6eXrmHntfv\n" +
                "b7WQseoTME4zVMN9C/YUnnGFvI5VVWrH3R4Uf78c8GIdZ3/ZZ1HxovEhUqs7q9RuM6beeyXF5Z8z\n" +
                "qvtm5OmLq4a7PpoYa0UOB3k/n3DaPyiV8yxim308QiD/JhPASOxLxLUmtDA19PYMwmrKglno00LG\n" +
                "awdASe9FePl3i4S+AhrpG5ax+sgj4lEVccynwaQdjvt8AsdzmA1MY6RF1FA2m1H99a5G5SZeOIkY\n" +
                "vZricaagoJaSua7jfnXIQZiFgfgQifv7E+ObovvfWFbaGappa6ItD+hjHyAGOxL1hH3XjyRB6wjQ\n" +
                "3AqPlX1JxAnmZbtf1EI97DrbayCiUGFi6Nrx9i5Myp2QRBV0ThyMOQam776Yz5kK0k3J8VytGu6d\n" +
                "rufE6hUo+mAKPySdVB05hSR63d5FQnwuW1f6fCsKQvR1aWOX9kRBhDVdWgnH9HZpJ3zWhQNecWk9\n" +
                "/L8JXWuOS0+4dLtLfzVRoYOtnfq6dXoMl7i0lIocdHCpE+p7dcD301EMQhf++APP2gnnLkb9sFYu\n" +
                "VeKddMNz/oRCIboIwW64XtimfH67AEVJ/nTqa6r1QB8Wok9t8Lvu4zwU8tA12f5Gf9vhuNXwnHNx\n" +
                "vziut7pLy+g8XXxkuEsjm7hAxXyXPsfnQ1AgxfDELy6dj3dzOgqo6He2B8i0xRi3NVwaj6Inv+F9\n" +
                "6evPculbPH8u2gqYG7ol0FdFfPz1/59XsEP+IAeEccQtI1Uu19DRVpSPnvDwvrfCKnkhJPk7AZLp\n" +
                "F/gKCiE81JeiC8VCdRmonLmkGwtEqh+l0sspG5isjDqdpxpu3GiOXUU13gYZbYg3uPhEHWFP/s+h\n" +
                "NoMerEZkwOSj0H8F7KKRquFuqX60CUJ1j1om6U4FqAqeLZIOaj2ypJRPfDsoxTQbSooxXIDJG8/R\n" +
                "9RMiTJugBYUXlWEFAr99yPIMP/tk9mnH8V107GhgOBq73ycLZ9xiMuN0+O0gB0khC0XQvTZEPLCp\n" +
                "aWuVquxpnA57FWA/NxR5/javd1MxuezHdDg3kyHOTQZ8nxT3qSMwRw3Nt30K4B1VkPBIErptkQq3\n" +
                "DZOOhx/aRH1vS7F5U+d9kUqVl9K+q/Md5GcnaVU3sbiER2peIdHqFk/p53DCFVLOeU9RiED5hLiS\n" +
                "AQyeS+ZPWjSjMCCbMAuITEmWW/zWAPVVCO/nFoEwM32/rggciANEYtJ8aGbLINW1w7qXNtinwqHj\n" +
                "1TqBCrHpvusNJ4YJR9hdTmFtTqCrrO7j0qUuLaCKofzOuKKnoXy3GJxNZlOOCvFbGMed7Zoxy3cV\n" +
                "dP2P4ej6qkDezwr0eTn0txrzqNDb7y59IMY5Sc5ezbuz9GRb0UntCqGc1G4e5mV1d1LlgQuxaU/m\n" +
                "EJcGIzowFy9pWQH29X8u9XPpMXoxvMOGjaH0s9QFMFJUL7t5z464vx/zOhkyO99XRw3OcmnHAmJy\n" +
                "3U526ksyf0bf/Rue8kJvep5/Qwt1BbzwpvxzP/MWdhOqW41K37Dh0SJQX7ho5IQAfHCh0K0hVfJ4\n" +
                "AJItE1Xb715LcmAOJC190tDlzYtgDu2CHI5iKjn9liWObkBv+u+uxj0/jrx2cWFjva1yW0xRO18u\n" +
                "zcMDH6vSS+8WQ8rlyxa7PV/OtzAMmosQW8KSztkSkoq0kNmoCe67hnBuGibn8tGHGEfRJCE9eMJN\n" +
                "V7mrJ9ae4vMaPrhVHiXkG0UyQdZX6aWBM/G2V+cgJJYPB98sj8SjQmfYVVS0rcHbAblp5vUxjVjN\n" +
                "qDNhNuoohLuEIOIrmYlWKxg9KUow5apT91smhiwTdT0KXXTL4PpbUtrep0U2wc7LwrNeG8KL35ja\n" +
                "wQJgxFcskrGPoSbDSFR++QsFIMLGxDuAT2SN900bqf+nCfOLATNvG8BMF2DJzUFxEesdmyHT2SSX\n" +
                "bVJwnH6ISq+drQEID0PFfQ5JG/9F5Y4jYU9tSnhx3rTgh5BJAYVE+4SsYhKFakjaJ/MgxeVC8hvU\n" +
                "yWIa994ezzYnYr6EzJzUoa4zc5wQZqPDLGmudcS/FQ7simoLeiuhclcYcn2k3HmpeYcD9ZbpZFuE\n" +
                "xP8fKSvud1WcGzVsE7KYRzZOt1yey/NkRBFJcSmRP1XphVH5GU8HtLpTwHXKSYXnVNQvVPQCp1Ho\n" +
                "BOp7NZBxxm7/wEj0dVX6/tl1wtO7ICQ6yCs/+uIQDh49sW8D3PALFKT4CR3+HRLdK5vI7AutLCiv\n" +
                "jkXq2OkMZ2IYfHoiR4tCXKWXEWNGnxfiHQ4vcmfa1gKubKsF93sIBFwFIj6zLFmYHwMym0umPxCp\n" +
                "3QlCHi4jzfA+w+irkl3LlWXilB/eO+LN1wHjLrUM2G2wpS+ne8RJ3auwOPD0inuVxwQ7FDjp9ZFe\n" +
                "+Ak9y6Ain3x6pZ4dYJvnyv5e5IPD/1okcPA9p6jms3HlSwIh95KFYY1ZeBvmuV9i00ceQmgern24\n" +
                "yn5TkceJh7hmXJzw961kIcU4QRXrKK+7u8+NVoC6qe3lleEYiFu8wrr6zI7i3IFU7KKPpR7WXij3\n" +
                "47UZwTeqYeG8fjQRT28Gk281FVz4PxnR5v7SUnLKBl39GyaRl99gXBFrTV6YdbmdtxZyT2BBs+0n\n" +
                "+CzseC8v+5o+728xIl43Q1D1zqDPZ9P7q6bwWpye4//b6FsJ9a1OpRenm+eTcrerkDi2zRbvCFgo\n" +
                "zNZBW1HHvWzUsWDewUj43w+Age6i4IOxT45sRpPwGEjdsIkqfrXhfrF4iRUBLHi8P/cocXSFan5b\n" +
                "XO1GY/a8JW36Ep+x12an3nRxew/f0Pmwl6VGJreDegkO514RnOAvkClnUlXrCKjU1tTOWmRh9Bry\n" +
                "2vbxUE1m+jhojGS4IqCTDxOj3y48np/D3hmIKhw6iWVt5Kf/iYGZAsnzOcyQ1iq1Ef2NzWwiriEy\n" +
                "4TIpAhlk09cSwy+zaA0Pqea7SeVmJAlf9nEsn6L8N2z4E8zaySLpt4cZ+k+IykozoH0FbT4ylBh9\n" +
                "Kd6bEdSvGBt9IzEJ6shFbx76fIvDYWIE8MSXCHsda+mk8VLeCQl8hQVI0w+DMyfgfhvi+LEqVRe7\n" +
                "uU3GTXxU9AQ5U73eR5WQ2jYHn1noq8Si/XUzR7ftTONwe4jjh3sUn1AU+fkFknwLca7WPF+DDR8P\n" +
                "SGNe4GMiVUC75TTVSnrH/+eM644XyM44o7qbG75nqWrxMlRsxkbPVun1qG30BSSt2aT9a1IH5UOc\n" +
                "bjEHvoWDQTsh7sbKeYQYyDEU021uO7Ss6sPES1T69rvM9OxRrvFwvNnsdJ4HI5o5o29G0YWrfI5b\n" +
                "Cf6jrvBRnQ1b2A+j8L7HtbrBC/+k8q4S+6by3p5pQ0s9CWb0MwyjM3yUve4cuvHCpreGA2F3eLw7\n" +
                "w3k0EPbM5fBO/uYxOX+luP3uAqj/b7L774T6sqYKV6PdbH2zUAXvX1VsNCRkTNsWC5+DxUCq9XHV\n" +
                "cG/uuOW43zN0GBXTji2T8ay7C0CNdlpfCO3UMJbUUPeFkFlmCfUeE+L+a0Gj/RLnjYGpEFS2bC7l\n" +
                "oxtmNxEv7QjsYh5ilgUww7DKM7McwE9Vek2td4WkrkSS/wh40ifSg0aFMu5GSTp/Q+rvW2QTLubj\n" +
                "xZ2gnEh12pnpJ1kcenX4TpaV8lL/92vGjL4KaaivwPb9AIxkM3e29bjOusCff4O4ed+AxcXgVPpA\n" +
                "U7gI/PcMolnnBIDWnlKpqrTLwE/L6Lt+psLMt8IZUytedDblf/8nBmcPktq7wYbxmpxdSHMw19Op\n" +
                "jgdjdT0fK+BIMPd4n2sNagaMvpkP0MXUsR/joZZ7ZcYlIibEvNqMGLsLTL8fEf4Ns3/5PDh+T8zA\n" +
                "KXkEcjm2hPn6IUzZeXh3xmxYYnmHo3yuO5IkeqVK3+nl/5sMOkn9U5fGOPVllk3lE8dJlbmNoTiF\n" +
                "XzvcpYku/Wj5raP4Xyf0/+zSNJc+dFKlprnpey9ERZb+Lq3l0hSXerq0WYYJ+oe69LJTHM2rostO\n" +
                "lu/KxVjPR4GHVihK0COgYEWZTz90KWddqno1+m4/l3o59WWLi73p+XQtPq+PvwkxpqbpKkFvu3QZ\n" +
                "PodpA1CxRvPPES4dhe//Yzm2G322le0eZ/lOv+MrnfpS3wnBuzW497emIoVuq1M1k1aWSdHZ52HO\n" +
                "cWkoJtd3Tn1t8r9QtWQVl9amijX67wEu7e3U18nu6/FQuqO67vtF9N064hhd/moBBvFvVMHR/092\n" +
                "6stILcLDT8DnV5rBxNwr4PfeIF2RptZJ1ftWTnrVIK+FRf6+WFS3MQuDfn8PNYPx1HPwTqe+QpFc\n" +
                "OHUt9j+x2H3h0gjHv+SaabpSzUkQUFtgbFuHOE/zy+9g0LZOfTUiXfnpbgjGeyzn7IqFxyxQpjSY\n" +
                "pirw7ar6+wpaueWLLvNYbbhtDibXTRft3ybkALeiFdTWKjyYvwySRBfSfxbfa2kzF9JMFUn5n0ya\n" +
                "roW3Y8AxZowMg7cPkOZBra/H98c2E0Y3gupJzF8tGTcE838GwRe2nerSGdA+2/ocpzfdeA4LigJD\n" +
                "ak14JrRcBUn8D44fD6m81HKt6Zj7PXC9BPGuqfPYixnqb/xt46RqiXHbxqKu6Yu/EGIAFqMDXYVU\n" +
                "mYyB7A7pYzraDQ9qJu5yYuHR19nfqd/h41eXnsL3y5zm3Y4KwawxGuNWEa4ddRHYDovO6GYytkYt\n" +
                "/iSDczUPnefSTfRdnRj/sS5NAkPfBeb2a0vovfj1aRI0jx703o25XU68rQyjf2lR5XjS6CqZO7j0\n" +
                "jFCd33Hqt66ZiZVqc3TsF6jyk6E6a0Z+wKVBOFcz5wlg5M548HIMTldi6jaQ2LtDom2B1fII6odW\n" +
                "q6Y2cybXY7N9BkyrMmBiFZL5D25GjJ5t6yK0KsPkEyG9r8mxr4bV/Tip7mW00MRIMFZwOMAWskmI\n" +
                "0kytPTyXrQjt4+UZvJautWMWqYQ6HnkAEgGuKtKc80xy1HO9WUPYWLxXbvpHLWDcM63yooB3aIy4\n" +
                "/w8qfZeWGnjtl1LiTTtOmH+fXmrcUiRyQZZFBU6gtLn2pYkRiS7KUSrqrwSXDFvF1QtuW5lFnYLm\n" +
                "SiOQe3FNI91vIOFR6ojRDfKxCglgaSe9YUHHMaNXqezL4B7cDCGp+aZyAC+yLf30AlVIGUjlw+R1\n" +
                "Eyr8ji1Hld5Pg9oJjalhPiKAbrUil+E5cyx71lcQtpkSNoJ2ivXL0pZ5MWSIotTSQ2qbRLDnlAiJ\n" +
                "aa/scfClmK2bP4c/5VXhxDNOz4qQjrptS68nrS2Db6qxWo3wDUifTI0thPaJeOmG2AvfrvQuG70N\n" +
                "iOAdN8xqnEGPOvVx3cctx+ow5EEuXRfR886L/ybNeNxjBd4/vRj3Fu8kiX6buP1MZnTzQM94vMwE\n" +
                "xec6F8DDreyk75XVnJsOIQ4JwXhM5n2ehMjG5IDzL3dpD8eOagxqm+Eezam1R1ToB6ceNdepgBm9\n" +
                "3MKvLJzL+duYpRxzLSU2MJb6pUYoXeuVc3spkl0WwJP4NtIFM9lmtjlkqnmllWa6M0prSwWUMPRT\n" +
                "E82JfNH2lmo6jxdoXbxTRS33GlEG7v9y6mXtt19FpRkZZpuPunCN9SD6Xnpjg+896p51inCtzihr\n" +
                "pXPo71G5230mn3RjxJLM7yBRKBvH37UBjjjbts47NSNG701JIrY5d1wBhXR5zzWTg871Hw+zMboD\n" +
                "RpCb+8Upu2lpQMpdLjaM02l6FyCTaIFHnHdoSCmiCwMcr+o3ipTF/XSZnuUKPGVyWoRCkLkM6ezg\n" +
                "Uf3UK95+fjPznsdQruwfys+X9eFuRGmzpurjiUKaV6Of1bQodfNi9IstaY0yjXHriAMW5rhOqNLx\n" +
                "nbLvNDKW/v8sxPV6ofDFHz4TdXyBVzA9ImRsu0ZF200kLK2HQhNhJPrPzTRcdkFAnb1KFITcMWRB\n" +
                "lFzSOBE/N8xuNPFXWZDJkzsC8cT2X52oNvNwDiShLnK4v0tHI199msdAPkMVNt4lSdzNpyrtGz7V\n" +
                "Ur+GNrA9TJVCnmSPezAXM9jLYMh8xoWPQ7FD6ReQvoFdmyGjXyLARneTeStpEio17WK5TjuqrZAt\n" +
                "dVLpG4qaGPpSzPs4GH8PPi/MPk51BK8z6ns2nd7JUmpHFsJ7Ecn5slbaYhyzg3DU7WKp2WVoMqp9\n" +
                "XBKibx0KpFRSNyocUOuBULuiEfuzBpU3ksxuvru1yJh4Cw/wVmfyV0yylNDSsNNzSaLaNNCbUCTE\n" +
                "CM8fUe3okRy9CyVgr6Yo5DyqkDMoiNFtaJtaslMWoxJpJp1cESWabSWGP0PJpx4+jiJT6vgDqEuX\n" +
                "K3thfYMEOyei87CiQBwtW3nUWTelhPdson7dJZidt+76QhXHppaHAoZt6ttzKfOrMD+fw/OYZ33U\n" +
                "41qDIEQSNB7mnH+LeoymhHO2/e9FGpZBwpmNG8xuOwuk/8B2oZdFkUBbDbmrM+ykbVslbUf3D3n+\n" +
                "RwEOIr0IPQiIZzGrjG8Ihyj7J1Zt4r5dK2qS11EZo1UKFEJ8E2zpxy1zZqCl9prcYGFUwD3Ycfk2\n" +
                "mTGmBp3Z2/DmHDxPZ2gIipxvpnzUMq9yX7YL/ctS4zshJt0si2odhtaGh3aOsG2CMnQGYJGwFej7\n" +
                "FnHjQQXABLlSKW3hrTMLqI9b06TihehfBTieZVggbYLhEHHsLgLnb7AktaiPbisGuaeo9cZOucF0\n" +
                "rak50ng6qdRORtWC0U0/zvZj9BjZh0stCS7SLpuURUx9Bax8ZhAOtByjnXU3UPldGz3cBN7OXEUa\n" +
                "vOhK8YxzC7Tyal9ka3FfRxbo4rmC8DEYsplAawJn8ZfHnPsBv28FXuGtrS7xMXW8tIL9oUU/HNJB\n" +
                "fArxZjWp7ZXEm2eFYXQHddRlPD2RZajND4H0prBPx3gM8nSoLXGfBaKpmTzb7YruI7VsdIFrKdID\n" +
                "vBS1yQuV2f8Q2pJmjsfAPK0sdRauDQjRzqG5+KflfhOIKW3awM3ieqeG8CGNIWlunHGLyTyoU5Zt\n" +
                "mb0ueLylHLBEyc3L0vveSoTVHgXZBvQJ1LU2eexmQ4jPm2FI50VMrm2LqM+7kOZ1bQH3s5dKbUho\n" +
                "C49drRpundQGIK6bfASQ0bzWtMTgjd1uK9gyV0SbgnxVy6vUnm81BJbhLa/vs53rdcF7hESPC2Y3\n" +
                "q3c20mYHH4+52Xf7fsvAOyp9y9+zSOVqDozeqUgLc/SFI3S3IujrkVCXvWLiDyjvDRP2Fc63pIi1\n" +
                "m+PYL3CG5TrniXuGAYJtISCutUKaK4DeGmiafpvN1VpiphIh9FpEvPnxsGOe9YlBvovj2gRcazKp\n" +
                "MGOwqo2GSVAqglCisB75Y6iwh7L4HC5SDTf9bIMw3XRx/Pdkdysq2DLAcu9zxLmjAxKuWkHbUwSK\n" +
                "YYy72a9+d5ufyG8QnvaBPfIq5hdS0bG82xCbfyFEJtRDIV/Qpsp729pTShO4RBmaHw9bcO28SaJm\n" +
                "zg3pnJ5g+GMBNOsIJvtO4Dm87snbjp8U4FhelSId7G23VpSJwujrUj0qCXtkh5yXR7i7gE7aSAMW\n" +
                "7iWmHe7THz2oByCZQG5XUwW89TBlL2BZohKFpXVhMs71Seb50EMdN/Oet1J+0eO4Qyi6NVUFl1hr\n" +
                "qxoWgjQe91qCjLcOYnRbWOgT4ZDjnVaNh28PD+/z1cJRUSXsketVqmrsA/TbCQIcsDnCOAs80gaf\n" +
                "LGBPb4mKl1aACfmdj6AaBwRcLzrvUqEFV0ID5WufLK5zWoj+nAPGjgugjOErvbislIlEdyh7ySs/\n" +
                "PYGkFBujf+hhg9u2jx1igXhe46GeL8ACdFxpMpaoESHJI31Sd5fCgT0EDJek8JcCVJuvx4JtWogs\n" +
                "yuXpWkaam62Ra8NEoIJiwhd6OOSY2fWNNgiAu04FdngLj3ttFMJ+/wOInyBQQSwHoJUSlchGPaCy\n" +
                "f6D86+QbB1kCDrvtRUYgg3f+EyFdNklw9GrY7HWU/xGZ0ZlRnrc45GSaos3hsAqAN0NChIt2Ut5V\n" +
                "TZ5HCK3Qcseb62JSWiTD0Vpw3tkStLjSy9MBAjAoiaofZW0myWRmVJxXWC20RHfgrlcezM715A7I\n" +
                "YtDOFYO1BIvEtqUJVWL0AqdtARL6WmBPash21vDX/4IWE8/cEAJUNkowufGRGfXdSPV1MmV09vaN\n" +
                "tqjwceF9PyeLwToWndWe8/dU/RZEpUlUomKidkisesYjA8723b4hrjtKpVeSWQgGjxNQ5oWgBTrs\n" +
                "Q+wpMnpM+ipntI1BaCLTQVozBEimRCUqBjoLkSVbYkwdSftbQlzrTZGSasyCJDTfhWHSsqOEGirJ\n" +
                "c8556nWkVjxTesklKlFaoZVrkIhVZ8nhHx1w/sVCXa8i4Wps8w/D9IV3avFrelP2L/BZF4U3BeLN\n" +
                "fswK/+udP452Sq3USk03vRvOFS5tAJLbe1cHnL82/mp+S4Df4uA3s23WU2E6UhGyw/rCT7i0Mxg9\n" +
                "7qT2eip3Uts46f3Mb3XpY5eml95z0bcyJ31LrlLLvP3s0vkuHejSEpd6uHRvwDltiNEVCdc4ftPX\n" +
                "eTnMzWMqfEf1Jot6w772uFGCGL2cPutO9YQWUEhND0x/J9zWQ3rLpy1deqPE6Ckzr9QatWmh+rpT\n" +
                "v99hNWngMZrPL7l0cNgXGbZVY0WqJcY2q02SrqV/X6cAB+4Cp34/reexmvq1SzHIZ2VwH/0itshx\n" +
                "3zd0sttv7giXRri0S8TzkkXE5BXNjNHPhFCtdlKbJ7LQ0jvm/i/01TJwMMwh9E8lgeoZQFOt0ksy\n" +
                "FwK9J4AKK/vELrl81Y0q2t5iD1oKMJSjqECHgDCmF2BiIXDVq2X47F/SOzs8h+GkvXKYRNQ6y0o9\n" +
                "rRCuGlLk0Ru9Z8I+lNlWJbLU4vh8UJTrZtKRhyzonFpLXP2YAhvAm0MmEuhEmhni2A0i3OdTOm93\n" +
                "fLc5QiG/Ih2yLRIhVkWlkYOxuJxrud7BIt954wySM2TedC5KcB2rUhVHg4oeBi2Uj2IhW5MYvTwD\n" +
                "Rh9Pod6yImX0oSJTzjB6LfHXb1Gvm4m6c7pLWzv1W/rGLDacwvd7w1GwrEBUoQ9cuhCf/3TpG4/j\n" +
                "FrlURf/Piuhv+MmlbfD5PZeOxPkdXFrLpXdd+sOlrk79PuaV8Gk48NC+Jryz7YUKr2237yL0pwOI\n" +
                "m97u+NUsx9OYJwe4NNqlsU79FsO6791cWh5qZz98/7tLS6FyJvB5CbzRxs780KUdcI1ExP7E8Y71\n" +
                "fvLbuvSQSydbnInL4dh4Aarrq7o0mPjIOL0rBK/Oh/kcfoyyKMXDq05ClJwyv+1RQCvlmdSvy3yO\n" +
                "GyhK83ybQaaT3Fb4GEsOvRedbSmysZTSIqNu+9xPpPj+GmBCRKkWpPJAW2TRp/4iU7LMA2n2aYFK\n" +
                "880smHneCtmA04ZEvXZZhiuPltRfkfOJHVGKVssrID0KoW1Cn1f0Oe56l9rSaqk1l50i3OdLl96h\n" +
                "/7Vj8mKhJSyG5H4SkQxuv4n/J9Mxv4rrhGlLxTl34ztb01GJ3hGcs47Q5n6Gw3O8hxakcN4SaE6O\n" +
                "5RrlAfddG+9Dz6uNXVqfwlDrCOfcPtAuVsJ3J0Ij2oa0u0JqJ+JvndBEJL9+EfnKWaw+51kKSDLg\n" +
                "Pk62/LEFkCxxkij+53Xc9x4FBqLca2NRaEMJTWcnkQU1i6S/OX9HiwN0bETHoKlfZu49M0BC6/f2\n" +
                "VsjrXq7SN3AYQu+4DKgwzu56D+nIeu+wPqCdKDvS7LTTx+eeu1I5pRpoXtr38QbqIsy31D+YhfEb\n" +
                "ZylesnUBSfO+ot91BDevIi3zG5XBJqfZdOwQMYnrBA6+htTVJQWQZrov9fcinzJA86jABde5Ozri\n" +
                "/aZ7qKY2yKIpEfQ4mMEwz4VQvU0Bjomqfs93WwbVqWDqPcFAPeFEHCMKJAzCNVbG5NLq7pUZVDw5\n" +
                "MoR5c1KIax5Ix3wVcM8Lc2wmPF5AjH6PgMjWCfXdLAAbZXL9bGKPGkzyEam1CXLExYTq8SHUtXy0\n" +
                "WMhYb0f6PBN/t3NpnksT8f/ZUPV0u8Olq136Firi+VC1w7b7XbrEpbddWujSqfhe3681rvkVVNU+\n" +
                "+G0GnFhGRbvZpZtcqqFnrbXc678u7QGVrxW++xvP3JbeS3uALGbQtbrDWWYwELpvtzj16MZfQo7n\n" +
                "PI9j6kJgNlYX73I5xxsa+jAckjvCuTfBpaPI2ajfzxQ4ODVthd/N878FB2lfl7q49ECBqOzasXkG\n" +
                "YRdi4vdWGJPDXfo+oztkmI9cRo4iZYn3VYtSOqNyrLqHqSITE2ru5dTX41FfS0qjsfjubzp3aMiK\n" +
                "nm0QRuPvTKx+ZyH9bqV85K2omOBD6PckOv4fMgPGeRQquDtAciUsBT2C6OoIzrhxHu9j9xDVebkQ\n" +
                "wzwVrj5/Ow98xL6W8ednWq9AnXBviQw1YwazVnxDNvfIRXGCkTSZlhGj16r0HVgnRA3yZ8HoK6B0\n" +
                "1QQsMh+Jqp5/ilK7/0W8OmGp3LmpmCyHedzzJvx+leW3QXT+7xTvZTXNlBSOQYVV8A7r+5uNLj72\n" +
                "uHdvpEXOQ7HMu8EAb+GdJOnZxsEEmILyQy9ifH7C/y+hGm/Qzqi7i8XL9j72oGOGBNj6ZreUqLv/\n" +
                "HE3nS2+6XGDbFiCTn0b8Y0BoXD0miUhJl6ZgdLlq/kiTtlKksnLi/c2NNHjLZ2m77eXBxMYfcYul\n" +
                "dh1vJyULZj4vSlx/4nFfXXaoE9n3TwmpFZTW2M3yHW9O8AEh9TpGBLXYdg3xYjBDa5MmMSiE3f1h\n" +
                "hk6salrAbeCTf+DrkBrYfQVQxehrsr+XYmHWfxfBt6UgGMqamtHNBPuZOiy9hkZizRbe5HzSZUC4\n" +
                "/YrB/Ec13ALnA2gkLO1f87jebHG+LipwKMWkV8PLMb9vS6g4Pk87x94W/TAb+V0pqu9+Dclq0Hav\n" +
                "ZzAOHEU4L4fju3uI2mcn0DHbBUCGgwocrqBSuwLFRLFF421fRqWXK+i92pyv15KG1VSQ2UstCDhT\n" +
                "xnkRRRjGZIt9COOMk84um/NrPuLPT8CZU2OJ0yvEr993aTUgzvLZdH/uclJ5vNoJtTt+G0ExSwfO\n" +
                "uO5wGHolspwLZ495Jo1me86l2UBgGUfPIeRIGwjkl4yL62ffi5xa5pqVFPt2gKTTcd+VQ8aYHYsT\n" +
                "pzX9H9Uh2gkxfy/EnWnauTXGpVFwJvXCvXejY4bhffyOGHhrOCEPoWM6WxBfm7p0lUubY54twHhp\n" +
                "p9scxNG74th2eA/P4d7d8f3BOGcuxltjKkzdBN2H4S4dH9Kpm6t2uUvXkBNUCSd2azgmJ6KvS7O6\n" +
                "Ww5Xp2NpZWZnHO/GauK576hwe0Hnkn6k/nHCzS0kDY70OX9tqsYp4+InWtB3CjbiPeK7q0jtrcZY\n" +
                "LBCIve/Jibkq7Eu5vXRY+oOkRv+Q52wMbeJXi8pr6KCQZlBtCFRgkrD8cluiwXlC4EnapxHn4iai\n" +
                "NHQl5t8ylb6X2icoMZ31PXOZ2vcFMNx9sJrX0ApZJlbLPRESOrsRUXHr0/9HInyk0zYvwHefuPS0\n" +
                "x/ndgQ3vYEFwPQINwYE0GUbhkX0sKLylFJqqRBiuD8I9bQS+XSPMprn0F8JxtUL6bQyJa0JntaBl\n" +
                "kH7HEtJNh2d64Lf26Ecb0iaqIPFXcelFCntpzWSQDzLOtGVA7v2FZ+6HZ2LkWwLPXI5+d4HUMuO1\n" +
                "SITkdHsQz3AxoQrbYO5qbWo6zlsV59ZCwrfDfZYSWrMzNLEa/M95BCs0ojQfQqG0VsSPJt1bS/Nx\n" +
                "Lm2fszvmeKVaFXakWcmNzVFnKQ89E57YTo2wgh5nWcG/Fo7CRfBSP4eMrDfhRHtEaAN8jm1Tu5fp\n" +
                "9zPgKef7nokqt0bKHkKgFrP33Dj8Pwz/P4b/R9J9hnnUwa+FhvC3kJjLYI/OgE07EzbsPDz7P8iK\n" +
                "WiDqmikPvwqP6WxIKc48W17Y31ejJPFaoOVRTPQplb7Fltc71NGOLeHzMOHI0yPOg1PJydmFrrdj\n" +
                "I2qYa5HE5q3NeLNElUGWYqNJdAfSZ3/Yw4Msdn2SPvcCKOUFHzswV62N5bvNScqUwx7dO6Tdq23G\n" +
                "pyy4dAdajQEUVVhW5R4EyqkFeKWGbEyH3ssC8oE4kH5SotrAFV3o/yRduw9939XS9x4CK26azlkY\n" +
                "LY7l818DsMjIjgSw7i/Df2G0k5/FNf5xUhl+jpgfsj1H2pXRQo7BNVbAWLUDjYfEHoD/FaT94QRQ\n" +
                "ae2k8jUaq+l3cyfunaCxSkKjMu9XH/NdLm+cLaPzS+HPJ0I9b4cBj5FawgD9KkJy5bOtbfnO9Eer\n" +
                "8P+DmrsrVDs9+GPRzw5QS/tCJf0BiDmv9hAm2qOEhnOEc2kr6sM0ckzG8U46i3P6CcZ30AedLqxT\n" +
                "Mj+AGvsTFqzVcMy+uJZ5L4/BgbUazIcOQLUtj/vOJ8RcnK71ueU5ZgvTxlZfri99Xt7HLHKEY9Iv\n" +
                "/bIXMcRAUNSmx/N5IOwak8mfBl/EyfnmkLnWCqbP5bm+eQXdLBOPoy0PXcFmGgYIaDkxOy8QScAz\n" +
                "X8CK/lsemfxky/dlJOneB7WH/XSdS7ejb2znj0W/25AUlm2ik4LU7km2uML15wHGuAfu3dtJZXrN\n" +
                "hFQ1TLGqYIZOwibeHZDQLz368qlTn6kVwzNlMoG88p7niTG2MTr3t6fH9Vejz4ud4BzrjhGEQ53P\n" +
                "sX82sjS/3knl3cdpDlY4qbqLul3p5AEuXpYFkwcx/uUIW8ScVI25JEn0BEir0O/k0RmykZOOyzaq\n" +
                "sK266TKomzEMODeTKqodYD+SVPZqrSFtjSr2B6n2RmWcg77tQeNXS5O9LySYUfXl4lLlw+QxoYo/\n" +
                "meH4JXwklEMLma2Qw2T6vNDyu17IDhBSv30I4cTv7i6EIbeHdN8WJsrGkNxa6xkME8GhcT+/EZn8\n" +
                "SLpfHTF2mZNeb1Ev+M/kowNleYwd6hd/BryeXL0yKbywCi/kfQ9bOtvW3/Ld+6RB9INUlDbtek6q\n" +
                "UowDtd28ED2xLg247z5gtCrYr8sRA+5Lk3+UsMeWCru6GzQfx4lWdWV1oTq3D3FO+wjX7+zB9NwW\n" +
                "eWgApmmTZarQANoF3HeRGIdKLCg6jq8jP59BWn8Ps0gvhLqs8hN0zgynYR2AfLWj4M8pI5WdfStG\n" +
                "253k1CdZLc0Xo+ezJUiSlBHx/U25HA0sucxHOmXaNrd8p1XyM8kB9THZepUkOc8XtiEvYg8G3Hcg\n" +
                "SY8VnFSYTRdBWJcmbZKkclI42mqxGFTRYhO2XeqkwDLKCS6HdTKYI2xIZ0v6vAbMiFY+i+wmHsKg\n" +
                "nZgvQYJnmZMegrsQPhZtmrwOpn4LTD8KGprOnryNztnQyWXoyt7a4p5P0jsoI7PVkHlH2sH7a746\n" +
                "k88SuUYt0Rs6nC6cLNKBl8DvOlb6tUtv+pgEUe3zbSzfa6+0jgzoCMG/nXqU2luYmKzWb0XPwSiv\n" +
                "oZY+2tRSB4vI504qBt+OFq6/BEOUg7kXw6btiEWhnBahME1L5r1p7Mx7+A72n0Ev/o1+runSSWBU\n" +
                "HS3YwQlOh2xPi1NHjIdGq+m49u+Q+Hs6KU/6ibhXa4z/b/BPbCVMkaDdS6bAl7EmzbOLI5iWMcz7\n" +
                "lRvBJj+X7quchlVjjOAbj/mXv9ZI5Wtf8Ng/mhPrOYZ4bY7ufasHCoo3t9uQvr/CkvZpNrEfTd8d\n" +
                "GuLevwnUnMEtT6Oklbvw2xt0/1YUy/4eySCmwszbEcZ8ZgbosDpCZAXd4xqxF59fimzYenkzQiDB\n" +
                "NhVzxaQV/w3MRlKgFm0IPJOqnK85X44EGwWswlL0qZaw7GY+zGqMGH62qnsYlVqv0BrPfB7ZczHR\n" +
                "B1Oswqhk/4UTLdu2K9m984UdzDZflfCSj6HfLxDOOEWONW7tIIXLYIKsgRX8Y3G+liSrkJeZVfXN\n" +
                "Yf9XkWf4Xep7u5DPXQ2Pu03t1eFBjbqa4KQq9NY6qY0CHNiK6wbcYy3SQlrBTtbP+gpU5p9pjpQJ\n" +
                "T/g/QtuI0no66fj9oTCNVoAW0QVRijWgKWk1/XBoirEA52Cu2v2k0VWRVpNwUlVw2+H7A6FZefFX\n" +
                "LBcdqsiBQhC2DYW6eA8mRi09SMxpCAPUkNMBWTgnticn29OYXJeR6u6QF3wK7rUFeeUNA2jb8gT8\n" +
                "blTV+Zb7aZV3UziA1if7fAqet5VFhTSx6AHUr2VOOtS1Egy/dgTVXbdzoBbraw3BxJ6GSVWByaaZ\n" +
                "YxgmG4eiPkDf/dqKxOhvYzHn/i0HU2FtPOs7GH89BxaAYXXf7qAFeWEIBpS2/hw48TRjd8U1F8Gx\n" +
                "uynGep7TsDLP7Dwx+d5OKpybwKKewP0Nk5v59y8sQLnisSZV3b0KDSQplTUutmKOoiIHVe1QgGce\n" +
                "Rf8/Io4dSb+dg9pxRg2sFemnM7HJg7zfOx6qqCkMYVMlTXEHWTRyKhWDdAhW/EEG6cPdAo65UfTp\n" +
                "kpDXfoeSe7b0OObfdN21PI65i44ZHyIv/lKPxJkwpkHSp2ZALuhQqjkYp/kcx3zi1NPTG5Pv8u11\n" +
                "t7Vr4bDhLZeT5JjgctGPQ808IeI99iRn1DiEt/YR3l1uE+izlm4HQyLEIOWSpF5/JMJGpu3vNIxV\n" +
                "z7eElhioYRxRJ6HPHyGc1pE0is7k8Y/6vuZ7aB8ORQAOpf+vcMLt51XupAAwyucebOLs7nHMChEj\n" +
                "Qd9avouKrtTv/5Mcz2tt6jyH98dzOkYhtOWgsj8I9b7RWlMwum4HOKn4epmlT8aeMeqXzhA7y0lH\n" +
                "Wvk1jsefTrahl8nyuwjHrQWV2zZOXvhoff1jnPSa27+Q+q29+zs66ftZvwBTRj/fe6QSG6DLRNh6\n" +
                "/TMY45Xg9fXbWFGr7SZLbQQW4TCtP5lFFY432Imz/fbwmH99BMMGmZN/if/12A1GWM2WMzEWphuj\n" +
                "M3+HubG50xBMlamv6nky7RJOOhjNzOnWMJ/OanSOa8ISOvuTShynqjRxKh8tixqG3bhRZ1DdIUpX\n" +
                "jaDrjLRkRrEauDGV+JG0YYQaZk9Zfp9queYVovDhfej/iqhz9g1t+Bh2fB+n649APXWZRcVVbzKt\n" +
                "PTDWp/rJJXTcUI/3xBVw/oDZFOR1NxV+dhW/rUbllzTdJvawmw6P991Q3W1mXDbRnQTVYa8l9T1O\n" +
                "ptyApuC3pi6Mt75gsFpi8IQlVHJqFve6g64zQZQjOkaEmI4Esy1A4chJtMFAUCjkMB8G2o1+ewI2\n" +
                "t/n/ZJ+Ku6bwxH8y3LDCFDjgwpVP02/7RRzLUXTuvT7HDaPjHvY45lk6RqfPrm45ZmuUwToH7y4J\n" +
                "X0932qiyExaBhSKN2OxAq0tMnYXFZLoldTjTeXW9KEbCIeNaqmeXrc+pqBndweDbNoJgRk9QFZgr\n" +
                "M7zP1UIKeVX8UHAiOZCo65CU+CnixhY/+Gzd3B7Seg7FU21bELenKjFRd4w5DcUo+dmGCQfc8Axw\n" +
                "EX+GLAt9WkDuvqwg8zfKcPPv//WIzc8HMy3E+MwQTrc4lSGfAO1xrtAQk3S9qLu26Hz6ZyxMXkVM\n" +
                "XkX3GJHDLaaLktG5nJMi9Z1LUCWI2aOqsIZuo/MXiHLGXaj4429iy5vbLbXJO6OohG2P9REedeB5\n" +
                "A0AGvvC2RdcFFHh8OYPn7uhjhizNAKwxUDCKX3mqo0IU3bw/ADDzSAbAn0QAaKbG8v2DIZ//QICY\n" +
                "RgptNEEmqNyp6Jam5rFCYfTuqE/GL2kZDaCsTqNQ/eXwCPcYK17s4R4q5G7i+4epZLBUe8dbbM7J\n" +
                "dI/36bd36fv+HrXXkthypwOqrxiJPofqz2cyviuKyjeKNKTNI17r3Ag7zZ5Ix74q7OztgE5bIEph\n" +
                "d7DY3b/RMZPx/0KYUgtp04NKspMTZA78HmJxGBri2c+xLBq1QjAZJk+GLNHdbBk95iN5JpIKN1uo\n" +
                "7gmhxiuCa3YNuOeeFnVtGpxlr2OHlJmkYj4DZ9Ywcp4tBezzAXH/+0W54M/ot58tZY/lBg8bWiTL\n" +
                "i3jW90Rd9ruyHPuHhdQzTq1NIlyD4cGDA44dJlT3ViJuLgttehW/7AEfxm5Y+DrBNu+Dv+ugeOfj\n" +
                "4no3A8PQHnPgEfhQtE/iAjzLYyjK2StEwcxaS/yefUumJJSR5D9iD7yCYPRYATH7NWIQ48JBF7dU\n" +
                "lFXYnSRMrTAVsDVRMgM1UQnACE/kH+FEWuqziaAGiHxH59xpsav5t2zH/kTLdSeBGYLOXYVq0c0L\n" +
                "sfMJb3zxChbzOp8qsVdn+WzSnt8jh3P2FQH0qhaRIiPJq0Ns39ViVPeYx4TXKK4DwLicEMFhN6km\n" +
                "mZd6k88CsrbwfuaSFkJqsKpZaTlugYdHWdPZdFwfqO9PWq4xOEfjf50lKaRriPNOUeF3ly0TyUxm\n" +
                "N5d/YbssLg1utItjs3yuQeK5bstRwdPb4amfIxKzqmmh4q3CpxTa1k/5TFONit81GPLXgF8+igA1\n" +
                "XGMrJgAX5vuLgFi7wXJtXdzgCSe9pNQsnGsKO3wBvLrBh/8JTPI84LM7O6mabjOBpZ8ClNN0gXzT\n" +
                "vz1EoBINoNjJSS+ywO1Zpz5VdjyhyY4GTnxT/K/TS9/N0fjrpCFdlOJIQuAFFf0oxztx8LxBFWta\n" +
                "O+m1AJ7F35dAuubd5RjPMoEkzLQNsIBlMm0dgZ/XYJt1MD8XC+AN52eYSkrTPMBBTdsKYLWxSeGu\n" +
                "cGLMs6h4DKiJCyfdfMSabddkL+mzcAB2g7TfIg/PtRXdL9PNJTenVNA989DH36jUdZD3fXkfP4Pj\n" +
                "s93Sm/BU236fJUBMHbJ8njeERN8/w+usIZyqRl1PkvSupg1FlWUrLqekuoejCky+hyxx9lqy4eMW\n" +
                "j/wHsEU70GIyDJ79hxvxGf5l8eJHpY3IA59r2hSRgdNCHNsB8egJEfYqaxfw+wXwDwzL0fO8IJhu\n" +
                "8wyusZoA1MQF2q1G7HpqQDGTlPdOuyVGD0lPC2+x9HTa4LIKXmunRDmjrir3Ww/n0hm8HcXJz85w\n" +
                "o49/VMN95WXRiEqV2rNeAaVX0O8uppyiaTo55SokfXCGm7IkxygnVX6pr2MvFFFqzbNpO71KJCWF\n" +
                "ae3gG+pAPiPei4ArGHPi1HjY5H8V8qAUIqPHfJx2unKILoqwETF7meW8JDka9aYFOrlfVzz5qMQH\n" +
                "pSaadsbqenZHOPVFLZKOd4034/g1TH4snHWJgn/KAlU1Ysp74/fVCK6aEPH1uA9s1oBbupRU8BKB\n" +
                "2gpAkjQLubbhMhHOPbuYnrVYX9AaxOzKwuhxD0Y3iSlHeVSJKVHLoVWp4GfSkiadIBwHb4D4c0To\n" +
                "dYnRs3TUHGhJYrAlxDC6jp11g0qTvcVRa0QxrqOMxFofUBbPKwNPblOMz17sL+5A4f20vaS4iL0n\n" +
                "KW7bszT5WwztL6DGSiRLJYUUrxUw60nF/PyNKYHz+QIlXt3PdufEmNnIb1+5ADWWEuWOzrcweI3w\n" +
                "5Ughwfb4KB/4conRG5E5tgHDLhMvU77AJKGbeLVegoyxvUtM0WwWn454lpNFlZ24KPEkhUBc5Cf8\n" +
                "rzmMUXObDGsD+VZrqSCSFH9tiDqTPzxYBZcdbq6M2hwY/VxUwZlAjLsE+evSsy61Pq5fN6C5LOC5\n" +
                "Dn0VCu1BDFxnyWdPCDhtnSXX+PmSdC9KOsDyLjkCw2Ezm+9mFgpMdGxO49KcX/iRloQD6WyxeVyT\n" +
                "ovzRRiXmKRop/4oFvprwWNxrLdDp6c3VQWtDxsUcJ297pjd203uc65RRvfWNqW8eJySTSXstsyDz\n" +
                "+Du9Ja+uA/5FBii/5jKWhdj0xhbb4O9eTio9VNHfpHiXBtpa7qRg0rrpNOADihQ9GfNAkhY8Mi4f\n" +
                "xGWUjPpWoxqWmPYrW6Xrnu1ckpxNThehCs8cj3AZJ6PESbLXibi4AVA9Xexe9WxV91gzUyNPUKka\n" +
                "7cqS8poI8MKy/b5rls9RXsQTpzxkFluu58/qwovOpZ1rRMmxpEovHy4BU7pG4CFF/h5KjB6Ajhoq\n" +
                "GNjmnLGVnJYMPzyLXPGyIpbgZSpcjfJcPZ/eZeUuUaKrVoTKan1wE+yr0Z73rxChaTFaULE4gmJ5\n" +
                "WBT6q/Sa7VxTXhak9Ksxr6XE95A0XUtqdU5pPZW+k4sX5Jk96V7INlMVtldLHMtYM/MUZeL80hsR\n" +
                "nuLU1wVzyGGnxDWNA6eMfisX15rk0o8uveXSKKc+x/nXks8sctvYqa8BeKiTvlmh+Ws24TSfk+SQ\n" +
                "igknq97oUtch1LvqvthiRzRPkrQYQ0a6qulSIQGkw66OygnVWrKdZHVYjdT70KVdStI5FGmtaLyw\n" +
                "petEUpJEPNaJ9yN3YVmvNK7+Ej3YZV/80l8+38qQIrqS7HL4Tu+LXkGSQwlpX05SJ2kJ1+m2zKU7\n" +
                "XXrZpW9KAvv/2vIYW713/ZlOqmqubjUUGisjKa2E5HYs/+tCI3rP+5FOqvpsiw5/xlRpstma3pN8\n" +
                "Z6d+z3BudU6q6ogiJi8TaqWi35WYkDpOq8sQf+rUlx9a4EQve1SMTZdPPsypL6GsY9Z9EffW1Vp4\n" +
                "f/UEqeWKmFw5qX3Hecyl+aRNpr2d+hLWpdYIjN4cVstjXNoVtvbB9H0tSe6YeN6YkPqOOE62ebDt\n" +
                "h7r0gkudnPq6Z583g/m1rlNf310vjo/C9vazImNYTJnJJfjFAF1Yc3rfpa9gh79WYuumlejFzvia\n" +
                "0S90aQuLi8P2v9fzlnswvd684DmXdnRpTZdudelxp77WnWka6dcWE7oQmu5LFT5v59JmYO7fXFoN\n" +
                "Elyr5h0s5oyp+WfU83KxSCYtZpZt7I7DOJVaSXXPuZQ/EhN6VSFtkiSZyoSEj1kmLvsIyi330iru\n" +
                "3VBtVwIj6c96lxRdlPCdJhoD7b/QO8/c5NIM+CAODjinTtjRSpg4DD1mZtd/WwltSqvnumKr3vnm\n" +
                "2tKULDF6PpverklXDj0fdqexL5MWZpaSzDB1UqiprOpzJVuv9jZU/3JI1tZgAL11U38sChPAjPNg\n" +
                "F+t+z3bqtw6qgeQ12P/eoA3R/w503BIw3GY4p6+TKo3M9jWr1DWW54sJZmZJHfNYGHUbDV/GM2D0\n" +
                "UisxeqMz/BAwfX/63njgExZJHhMSy7FM8pjFtlcBi4hfq4SvwbSlTn1EoWuAD8GvsXodF31TQqNJ\n" +
                "CkYvd1JOtwoPjUa3j10aDg2m1EqM3ihNOoe4aWn3P9iM3T3OTwjbXVnUfUdIt5hYOGIevoAyD0mY\n" +
                "TUuSBpL0WHDYbLEtZjFhj8cwVkaK11kYXWslOuLxUgH5I0qM3lLGCswUVKy/C+x4rf7+4dJ+Tv2O\n" +
                "qF4SixlApssasjmmkh59TIpFKemkx6HlguH4mBiSuaXG4YhFSwlGdywmSjlMDFvTPodbnHqsweLS\n" +
                "lGu5jF5onvuYE87LvoFT7zHfA8ft5qTHjo3EiwlGKbMwuZdGIRkyZrGZnZBSX9GCxppC0uJPcJx0\n" +
                "SGq5YHyv7Zh/cOl+l9Zy6p1qnzj18OFSyzOjFwMSrpBDdH5bScmmEXgDnfr9zwc79fvJ2ZhNEbPH\n" +
                "LL/JRYb3oUt6SN9YgKpe5qTvO8b7jyXEIhQTmkPSh7FHQ1Kv79TvVf+MUwxbGZUYvdR8FqKYhWm9\n" +
                "mo6Z7+nU7yenVfz2LvXLwJZOOA3huMryXssCNAFlMQuUh7Zha1rl/hMMr73z9zn14cAS9LfIVPdS\n" +
                "eaTspHvQ+GnpvqVL+7p0glMPkdWtewgm5VYrVOekz/leLeHjW9BNh+m0Y03H0Sei71e59DqYXP//\n" +
                "dWk6lGz05izVc7Ew6tRZjT5b5FJn2PXa1teAnecg/TVwRaPStHdax637grmN518vFB2cdNCJaX84\n" +
                "9buJdhLff4l7d0bfZzr1CTla/V4eC8Yk2Nm6DzpM93fp1ZcYvdSiSf+gxcHEoDXDre7Uo+bGOakt\n" +
                "fTWzD4UPYIxT7+TSRRQ1kGYWJK0+/nv4C1bBdbX9rD3iGn57IM5/H0y9pPSqSoxeavlj/JjFhg7b\n" +
                "VsJiMLM0rC27/T8BBgDxT2EDWHUhmAAAAABJRU5ErkJggg==");//盖章


        String checkCodeStr = WebConstant.res.getString("reportPath") + 33 + "&scan=1&requestId=" + 66;//防伪码字符串
        String checkCode = StringUtil.isNotEmpty(checkCodeStr) ? Xml2Word2Pdf.str2Base64(checkCodeStr) : "";
        dataMap.put("checkCode", checkCode);

        /*dataMap.put("checkUsername1", checkUsername1);
        dataMap.put("checkDate1", checkDate1);

        dataMap.put("pointName", pointName);
        dataMap.put("pointAddress", pointAddress);
        dataMap.put("pointPhone", pointPhone);


        dataMap.put("signatureCode", signatureCode);
        dataMap.put("signCode", signCode);
        dataMap.put("approveCode", approveCode);
        dataMap.put("sampling", sampling);
        dataMap.put("request", ru);
        dataMap.put("samplingDetails", samplingDetails);
        //dataMap.put("emptys", new ArrayList[10 - samplingDetails.size()]);
        dataMap.put("reportConfig", reportConfig);*/




        //========================4.文档生成=============================
        //判断目录是否存在，不存在就创建
        File myFilePath = new File(rootPath + "report/");
        if (!myFilePath.exists()) {
            myFilePath.mkdirs();
        }
        Xml2Word2Pdf.createWord(projectPath + "\\templates\\", "check_report_非2003版本.ftl", sourceFile, dataMap);
        Xml2Word2Pdf.word2Pdf(sourceFile, null);

        //对一单多用检测报告打印记录表tb_sampling_report_printlog进行数据新增
        String replace = filePath.replace(".doc", ".pdf");
        System.out.println("文件路径为========================" + replace);
    }
}
