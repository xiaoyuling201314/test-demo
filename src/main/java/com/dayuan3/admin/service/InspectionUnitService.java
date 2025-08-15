package com.dayuan3.admin.service;

import com.dayuan.common.PublicUtil;
import com.dayuan.service.BaseService;
import com.dayuan.util.CipherUtil;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.mapper.InspectionUnitMapper;
import com.dayuan3.api.vo.InspectionUnitRespVo;
import com.dayuan3.terminal.model.InspectionUnitModel;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.List;

/**
 * @author xiaoyl
 * @date 2019年7月1日
 */
@Service
public class InspectionUnitService extends BaseService<InspectionUnit, Integer> {
    @Autowired
    private InspectionUnitMapper mapper;

    public InspectionUnitMapper getMapper() {
        return mapper;
    }

    public InspectionUnit queryByCreditCode(String creditCode) {
        return mapper.queryByCreditCode(creditCode);
    }

    /**
     * 后台调用企查查接口查询送检单位信息
     *
     * @param creditCode
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月27日
     */
    public InspectionUnit queryRequesterByInterface(String key, String secretKey, String url, String creditCode) {
        InspectionUnit model = mapper.queryByCreditCode(creditCode);
        if (model != null) {// 查询本地数据，若已注册过则直接返回送检单位信息
            return model;
        } else {// 调用企查查接口获取数据
            return queryInterface(key, secretKey, url, creditCode);
//        	return null;//update by xiaoyl 2019-10-17 若在本地库中为找到则提示用户先去公司登记
        }
    }

    /**
     * 调用企查查接口获取企业基本信息，并写入数据库
     *
     * @param key
     * @param secretKey
     * @param url
     * @param creditCode
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月29日
     */
    private InspectionUnit queryInterface(String key, String secretKey, String url, String creditCode) {
        long time = System.currentTimeMillis() / 1000;
        HttpClient httpClient = HttpClients.createDefault();
        // "http://api.qichacha.com/ECIV4/Search?key= key
        // &keyword=91440116771190375E&dtype=json"
        System.out.println("开始前时间：" + System.currentTimeMillis());
        String getUrl = String.format("%s?key=%s&keyword=%s&dtype=json", url, key, creditCode);
        InspectionUnit bean = null;
        String Token = CipherUtil.getMessageDigest((key + time + secretKey).getBytes());
        try {

            HttpGet httppost = new HttpGet(getUrl);
            // 验证加密值（key+Timespan+SecretKey组成的32位md5加密的大写字符串） String Token =
            CipherUtil.getMessageDigest((key + time + secretKey).getBytes());
            httppost.addHeader("Token", Token.toUpperCase());
            httppost.addHeader("Timespan", "" + time + "");
            HttpResponse response = httpClient.execute(httppost);
            InputStream is = response.getEntity().getContent();

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            byte[] buf = new byte[1024];
            int len;
            while ((len = is.read(buf)) != -1) {
                out.write(buf, 0, len);
            }
            String string = out.toString("UTF-8");
            out.close();
            is.close();
            System.out.println("结束前时间：" + System.currentTimeMillis());
            // 解析返回的json数据
            // 查询成功返回示例：{"OrderNumber":"ECI2019072909151893088096","Paging":{"PageSize":10,"PageIndex":1,"TotalRecords":1},"Result":[{"KeyNo":"d5e018c967e42f4916a98a2f039d339a","Name":"广州达元食品安全技术有限公司","OperName":"石松","StartDate":"2005-03-09
            // 00:00:00","Status":"在业","No":"440108000018792","CreditCode":"91440116771190375E"}],"Status":"200","Message":"查询成功"}
            // 查询无结果示例：{"OrderNumber":"ECI2019072909161216380909","Paging":null,"Result":null,"Status":"201","Message":"查询无结果"}
            JSONObject obj = JSONObject.fromObject(string);
            if (obj.get("Status").equals("200")) {
                JSONArray jsonArray = JSONArray.fromObject(obj.get("Result"));
                if (jsonArray.length() > 0) {// 读取企业信息
                    for (int i = 0; i < jsonArray.length(); i++) {
                        bean = new InspectionUnit();
                        obj = jsonArray.getJSONObject(i);
                        bean.setCompanyName(obj.get("Name").toString());// 送检单位名称
                        bean.setLegalPerson(obj.get("OperName").toString());// 法人名称
                        String status = obj.get("Status").toString();
                        bean.setCreditCode(obj.get("CreditCode").toString());// 社会统一信用代码
                        bean.setParam1(status);// 企业状态文字说明
                        bean.setCreateBy(String.valueOf(1));
                        bean.setCreateDate(new Date());
                        mapper.insertSelective(bean);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("社会信用代码查询异常：" + e.getMessage());
            bean = null;
        }
        return bean;
    }

    /**
     * 进行导出数据的查询
     *
     * @param model
     * @return
     * @author shit
     */
    public List<InspectionUnit> quaryList(InspectionUnitModel model) {
    	return mapper.quaryList(model);
    }
    
    /**
     * 查询更新的送检用户
     * @param lastUpdateTime
     * @return
     */
    public 	List<InspectionUnit> queryAll(String lastUpdateTime){
    	
        return mapper.queryAll(lastUpdateTime);
    }
    
    
    /**
     * 查询报告费单价未添加的送检单位
     * @param lastUpdateTime
     * @return
     */
    public 	List<InspectionUnit> getReqInsUtil(InspectionUnitModel model){
        return mapper.getReqInsUtil(model);
    }
    /**
     * Description 根据冷链单位查询经营单位信息
     * @Author xiaoyl
     * @Date 2025/6/17 14:51
     */
    public List<InspectionUnitRespVo> queryByColdId(Integer coldUnitID,String companyCode) {
        return mapper.queryByColdId(coldUnitID,companyCode);
    }

    public InspectionUnit saveOrUpdate(InspectionUnit bean) {
        boolean isCreate = bean.getId() == null;
        //根据冷链单位ID和仓口号查询改单位是否存在，存在则修改
        InspectionUnit olaBean= mapper.queryByCompanyCode(bean.getColdUnitId(),bean.getCompanyName(),bean.getCompanyCode());
        if(olaBean!=null){
            bean.setId(olaBean.getId());
            isCreate=false;
        }
        if(isCreate){
            bean.setChecked((short)1);
            bean.setCreateDate(new Date());
            mapper.insertSelective(bean);
        }else{
            bean.setUpdateDate(new Date());
            mapper.updateByPrimaryKeySelective(bean);
        }
        return bean;
    }

    public InspectionUnit queryUnitById(Integer inspectionId) {
        return mapper.queryUnitById(inspectionId);
    }
}
