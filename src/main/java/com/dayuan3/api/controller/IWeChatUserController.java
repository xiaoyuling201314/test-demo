package com.dayuan3.api.controller;

import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.wx.inspection.VerifyCodeVO;
import com.dayuan.service.system.TSFunctionService;
import com.dayuan.util.CacheManager;
import com.dayuan.util.CipherUtil;
import com.dayuan.util.DyFileUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.admin.service.InspectionUnitUserService;
import com.dayuan3.admin.service.chain.ColdChainUnitService;
import com.dayuan3.api.common.ErrCode;
import com.dayuan3.api.common.MiniProgramException;
import com.dayuan3.api.common.MiniProgramJson;
import com.dayuan3.api.common.VerifyUtil;
import com.dayuan3.api.vo.*;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.common.util.WeChatConfig;
import com.github.xiaoymin.knife4j.annotations.ApiSort;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Description 用户管理
 *
 * @Author xiaoyl
 * @Date 2025/6/11 11:37
 */
@Api(tags = "用户管理")
@ApiSort(1)
@RestController
@RequestMapping("/api/user")
public class IWeChatUserController {

    private final Logger log = Logger.getLogger("INTERFACES");
    @Value("${wxSystemUrl}")
    private String systemUrl;
    @Autowired
    private InspectionUnitService inspectionUnitService;
    @Autowired
    private InspectionUnitUserService unitUserService;

    @Autowired
    private ColdChainUnitService coldChainUnitService;

    @ApiOperation(value = "1.获取微信授权URL",position = 1)
    @ApiImplicitParam(name = "returnURI", value = "微信授权回调地址",defaultValue = "http://ltlj.chinafst.cn/wxApp")
    @GetMapping("/authURL")
    public MiniProgramJson getAuthUrl(String returnURI) {
        // 这里可以返回前端需要的微信授权URL
        String returnURIStr = StringUtil.isEmpty(returnURI) ? WeChatConfig.redirectUri : URLEncoder.encode(returnURI);
        String authUrl = WeChatConfig.authUrl.replace("APPID", WeChatConfig.appId).replace("RETURNURI", returnURIStr);
        return MiniProgramJson.data(authUrl);
    }

    @Autowired
    private TSFunctionService tSFunctionService;

    @ApiOperation(value = "2.校验手机号码",position = 2)
    @GetMapping("/checkPhone")
    public MiniProgramJson<Boolean> checkPhone(String phone) {
        InspectionUnitUser user = unitUserService.queryUserLogin(null, phone, null);
        if (null != user) {
            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL,"该手机号已被注册", false);
        } else {
            return MiniProgramJson.ok("订单号有效", true);
        }
    }
    /**
     * 用户注册:个人注册填写参数：code，coldUnitId：-1，companyCode，companyName，creditCode,companyType：1，phone,password
     *
     * @return
     */
    @ApiOperation(value = "3.用户注册",position = 3)
//    @ApiImplicitParam(name = "code", value = "微信公众号授权code", required = true, paramType = "query",defaultValue = "9F98CFB453CCD16C9B53A8E3E222A0B1")
    @PostMapping("/register")
    public MiniProgramJson<InspectionUnitUserRespVo> register(InspectionUnitUserReqVo bean,
//                                    @RequestParam(required = false)String code,
                                    @RequestParam(name = "files", required = false) MultipartFile[] files) {
        String openId = "";
        try {
//            VerifyUtil.isEmpty(code, "code", "用户授权code不能为空");
            InspectionUnitUser user = unitUserService.queryUserLogin(null, bean.getPhone(), null);
            // 用户已存在
            if (null != user) {
                return MiniProgramJson.error(ErrCode.USER_NAME_EXISTS, "该手机号已被注册！");
            }
            // code不为空，根据code获取openid
        /*    if (StringUtil.isNotEmpty(code) && !code.equals("9F98CFB453CCD16C9B53A8E3E222A0B1")) {
                openId = WeChatConfig.getOpenId(code);
                if (openId == null || "".equals(openId.trim())) {
                    return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "获取用户OpenId失败");
                }
            }
            user = unitUserService.queryUserLogin(openId, null, null);
            if (user != null) {// 用户已注册
                return MiniProgramJson.error(ErrCode.DATA_REPEAT, "该微信号已绑定账号！");
            }*/

            user=unitUserService.saveOrUpdateUser(bean,openId, files,0);
            return MiniProgramJson.ok("注册成功");
        } catch (MiniProgramException e) {
            return MiniProgramJson.error(e.getErrCode());
        } catch (Exception e) {
            log.error("未知错误：" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "."
                    + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "未知错误" + e.getMessage());
        }
    }

    @ApiOperation("4.用户登录")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "loginType", dataType = "Integer",
                    value = "登录类型：1：通过授权code自动登录（非首次登录），2：通过手机号码+密码登录，同时需要传入授权code", paramType = "query",defaultValue = "2"),
            @ApiImplicitParam(name = "code", value = "微信公众号授权code", required = true, paramType = "query",defaultValue = "9F98CFB453CCD16C9B53A8E3E222A0B1"),
            @ApiImplicitParam(name = "phone", value = "手机号码", paramType = "query"),
            @ApiImplicitParam(name = "password", value = "用户密码，MD5加密一次", paramType = "query")
    })
    @PostMapping("login")
    public MiniProgramJson<InspectionUnitUserRespVo> login(
                                @RequestParam(required = false, defaultValue = "1") Integer loginType,
                                 String code, String phone, String password,
                                 @RequestParam(required = false) String valideCode) {
        try {
            // 校验必填参数
            InspectionUnitUser user = null;
            String openId = null;
            //登录方式：1：通过授权code自动登录，2：通过手机号码+密码登录，同时需要传入授权code
            switch (loginType) {
                case 1:
                    VerifyUtil.isEmpty(code, "code", "获取用户授权失败，请重新进入系统");
                    openId = WeChatConfig.getOpenId(code);
                    if (openId != null && !"".equals(openId.trim())) {
                        user = unitUserService.queryUserLogin(openId, null, null);
                    }
                    if (user == null) {
                        return MiniProgramJson.error(ErrCode.AUTO_LOGIN_ERROR);
                    }
                    break;

                // 登录方式：账号 + 密码
                case 2:
                    VerifyUtil.isEmpty(phone, "登录账号", null);
                    VerifyUtil.isEmpty(password, "密码", null);
                    VerifyUtil.isEmpty(code, "用户授权code", null);
                    if (password.length() == 32) {
                        password = CipherUtil.encodeByMD5(password);
                    } else {
                        password = CipherUtil.generatePassword(password);
                    }
                    user = unitUserService.queryUserLogin(null, phone, password);
                    // code不为空，根据code获取openid
                    log.info("用户授权code："+code);
                    if (user!=null && !code.equals("9F98CFB453CCD16C9B53A8E3E222A0B1")) {
                        openId = WeChatConfig.getOpenId(code);
                    }
                    log.info("用户openid："+openId);
                    break;
                case 3:
                    // 手机号码+验证码登录
                    VerifyUtil.isEmpty(phone, "手机号码", null);
                    VerifyUtil.isEmpty(valideCode, "验证码", null);
                    VerifyCodeVO vo = CacheManager.getSMS(phone);
                    if (vo == null) {
                        throw new MiniProgramException(ErrCode.PARAM_ILLEGAL, "请先发送验证码", null);
                    } else if (!valideCode.equals(vo.getVerifyCode())) {
                        throw new MiniProgramException(ErrCode.PARAM_ILLEGAL, "验证码错误", null);
                    }
                    user = unitUserService.queryUserLogin(null, phone, null);
                    // code不为空，根据code获取openid
                    if (user!=null && StringUtil.isNotEmpty(code)) {
                        openId = WeChatConfig.getOpenId(code);
                    }
                    break;
                default:
                    break;
            }
            if (user == null) {
                return MiniProgramJson.error(ErrCode.LOGIN_FAILED, "");
            }
            if (StringUtil.isNotEmpty(openId) && StringUtil.isNotEmpty(user.getOpenId())
                    && !openId.equals(user.getOpenId())) {
                return MiniProgramJson.error(ErrCode.USER_NAME_NOT_EXISTS, "该账号已被其他用户绑定");
            } else if(StringUtil.isNotEmpty(openId)){
                user.setOpenId(openId);
            }
            user.setLoginTime(new Date());
            user.setLoginCount((short) (user.getLoginCount() + 1));
            unitUserService.updateBySelective(user);

            // 第1步，先登录上
            StpUtil.login("S_" + user.getId(), "WX");
            StpUtil.getTokenSession().set("user", user);
            // 第2步，获取 Token相关参数
            SaTokenInfo tokenInfo = StpUtil.getTokenInfo();
            // 第3步,查询所属经营单位
           InspectionUnit unitObj=inspectionUnitService.queryUnitById(user.getInspectionId());
            //个人账号，设置冷链单位名称为用户姓名
            if(unitObj.getCompanyType()==1){
                unitObj.setColdUnitName(unitObj.getCompanyName());
            }
            InspectionUnitRespVo respUnit=new InspectionUnitRespVo();
            BeanUtil.copyProperties(unitObj,respUnit);

            //第4步,查询菜单权限,从系统参数配置中读取用户类型对应的角色ID查找菜单权限
            com.alibaba.fastjson.JSONObject monitorObj = SystemConfigUtil.WXUSER_ROLE_CONFIG;
            //4.1获取 userType 对象
            JSONObject userType = monitorObj.getJSONObject("userType");
            //4.2根据 key 获取子对象
            JSONObject targetObj = userType.getJSONObject(user.getType().toString());
            List<TSFunctionRespVo> menuList = tSFunctionService.getRolesForWX(targetObj.getString("roleId"),3,1);
            if(menuList.size()==0){
                return MiniProgramJson.error(ErrCode.NO_PERMISSION, "权限不足，请联系管理员确认！");
            }
            InspectionUnitUserRespVo respVo=new InspectionUnitUserRespVo();
            respVo.setToken(tokenInfo.tokenValue);
            respVo.setUser(user);
            if(StringUtil.isNotEmpty(respUnit.getFilePath())){
                respUnit.setFilePath(systemUrl+"resources/"+respUnit.getFilePath());
            }
            respVo.setRespUnit(respUnit);
            respVo.setMenuList(menuList);
            return MiniProgramJson.data(respVo);
        } catch (MiniProgramException e) {
            return MiniProgramJson.error(e.getErrCode(), e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            log.error("未知错误：" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "."
                    + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, e.getMessage());
        }
    }
    @GetMapping("/queryColdUnit")
    @ApiOperation("5.查询冷链单位信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name="keywords",value="单位名称关键字查询",required=false,dataType="String")
    })
    public MiniProgramJson<List<ColdChainUnitRespVo>> queryColdUnit(@RequestParam(value = "keywords", required = false) String keywords) {
        List<ColdChainUnitRespVo> list= coldChainUnitService.queryAllUnit(keywords);
        return MiniProgramJson.data(list);
    }
 /*  @GetMapping("/queryInspUnit")
    @ApiOperation("2.根据冷链单位ID查询经营单位")
    @ApiImplicitParams({
            @ApiImplicitParam(name="coldId",value="冷链单位ID",required = true,dataType="Integer"),
            @ApiImplicitParam(name="companyCode",value="仓口名称或编号",required = false,dataType="String")
    })
    public MiniProgramJson<List<InspectionUnitRespVo>> queryInspUnit(@RequestParam(required = true) Integer coldId,
                                                                     @RequestParam(required = false)String companyCode) {
        List<InspectionUnitRespVo> list= inspectionUnitService.queryByColdId(coldId,companyCode);
        return MiniProgramJson.data(list);
    }*/
    @ApiOperation(value = "6.查询用户信息")
    @PostMapping("/getUserInfo")
    public MiniProgramJson<InspectionUnitUserRespVo> getUserInfo() {
        try {
            InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
            //查询所属经营单位
            InspectionUnit unitObj=inspectionUnitService.queryUnitById(user.getInspectionId());
            //个人账号，设置冷链单位名称为用户姓名
            if(unitObj.getCompanyType()==1){
                unitObj.setColdUnitName(unitObj.getCompanyName());
            }
            InspectionUnitRespVo respUnit=new InspectionUnitRespVo();
            BeanUtil.copyProperties(unitObj,respUnit);
            //封装返回数据对象
            InspectionUnitUserRespVo respVo=new InspectionUnitUserRespVo();
            respVo.setUser(user);
           /* if(StringUtil.isNotEmpty(respUnit.getFilePath())){
                respUnit.setFilePath(systemUrl+"resources/"+respUnit.getFilePath());
            }*/
            // 图片地址
            if(StrUtil.isNotBlank(respUnit.getFilePath())) {
                String resourcesUrl = systemUrl + "resources/";
                String[] photos = respUnit.getFilePath().split(",");
                StringBuffer photosUrl = new StringBuffer();
                for (String photo : photos) {
                    photosUrl.append(resourcesUrl).append(photo).append(",");
                }
                respUnit.setFilePath(photosUrl.substring(0, photosUrl.length() - 1));
            }
            respVo.setRespUnit(respUnit);
            return MiniProgramJson.data(respVo);
        }catch (Exception e) {
            log.error("未知错误：" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "."
                    + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "未知错误" + e.getMessage());
        }
    }
    @ApiOperation(value = "7.修改用户信息",position = 3)
    @PostMapping("/saveUser")
    public MiniProgramJson saveUser(InspUnitUserUpdateReqVo bean,
                                    @RequestParam(name = "files", required = false) MultipartFile[] files) {
        try {
            VerifyUtil.isEmpty(bean.getId(), "id", "用户ID不能为空");
            VerifyUtil.isEmpty(bean.getInspectionId(), "inspectionId", "经营单位ID不能为空");
            InspectionUnitUser oldUser = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
            InspectionUnitUserReqVo requestBean=new InspectionUnitUserReqVo();
            BeanUtil.copyProperties(bean,requestBean);
            unitUserService.saveOrUpdateUser(requestBean,null, files,1);
            //更新会话中的用户信息
            InspectionUnitUser user = unitUserService.queryUserLogin(null, oldUser.getPhone(), null);
            StpUtil.getTokenSession().set("user",user);
            return MiniProgramJson.ok("修改成功");
        } catch (Exception e) {
            log.error("未知错误：" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "."
                    + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "未知错误" + e.getMessage());
        }
    }

    @ApiOperation(value = "8.修改密码")
    @ApiImplicitParams({
            @ApiImplicitParam(name="oldpsw",value="旧密码：md5加密",required=true,dataType="String"),
            @ApiImplicitParam(name="psw",value="新密码：md5加密",required=true,dataType="String")
    })
    @PostMapping("/updatePsw")
    public MiniProgramJson updatePsw(@RequestParam(required = true) String oldpsw,
                                                               @RequestParam(required = true) String psw) {
        try {
            InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
            user=unitUserService.queryById(user.getId());
            //用户当前密码
            String currentPsw = user.getPassword();
            //传入旧密码加密
            String cr_oldpsw2 =oldpsw.length() == 32 ? CipherUtil.encodeByMD5(oldpsw) : CipherUtil.generatePassword(oldpsw);
            //传入新密码加密
            String cr_psw2 = psw.length() == 32 ? CipherUtil.encodeByMD5(psw) : CipherUtil.generatePassword(psw);
            if (!cr_oldpsw2.equals(currentPsw)) {
                return MiniProgramJson.error(ErrCode.OLD_PASSWORD_ERROR, "旧密码错误" );
            }
            if (cr_psw2.equals(currentPsw)) {
                return MiniProgramJson.error(ErrCode.PARAM_ILLEGAL, "新密码不能和旧密码相同" );
            }
            PublicUtil.setCommonForTable1(user,false,user);
            user.setPassword(cr_psw2);
            unitUserService.updateBySelective(user);
            return MiniProgramJson.ok("修改成功");
        } catch (Exception e) {
            log.error("未知错误：" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "."
                    + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "未知错误" + e.getMessage());
        }
    }
    @GetMapping("/logout")
    @ApiOperation("9.退出登录")
    public MiniProgramJson logout() {
        try {
            InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
            if(user==null){
                return MiniProgramJson.error(ErrCode.USER_NAME_NOT_EXISTS,"用户未登录，退出失败");
            }
            InspectionUnitUser iuu = unitUserService.queryById(user.getId());
            PublicUtil.setCommonForTable1(iuu, false,user);
            unitUserService.delOpenid(iuu);
            StpUtil.logout();
        }catch(Exception e){
            log.error("未知错误：" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "."
                    + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, e.getMessage());
        }
        return MiniProgramJson.ok("退出成功");
    }
    @GetMapping("/checkLogin")
    @ApiOperation("10.校验Token是否有效：resultCode：0有效，4000：无效")
    public MiniProgramJson checkLogin() {
        if (!StpUtil.isLogin()) {
            return MiniProgramJson.error(ErrCode.INVALID_TOKEN,"用户TOKEN失效，请重新登录");
        }
        return MiniProgramJson.ok("用户TOKEN有效");
    }
   /* @GetMapping("/deleteFile")
    @ApiOperation("10.附件删除")
    public MiniProgramJson logout(String delFilePath) {
        try {
            InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
            if(user==null){
                return MiniProgramJson.error(ErrCode.USER_NAME_NOT_EXISTS,"用户未登录，退出失败");
            }
            InspectionUnit unit=inspectionUnitService.queryById(user.getInspectionId());
            String relaPath=delFilePath.substring(delFilePath.indexOf("files"));
            File deleFile=new File(WebConstant.res.getString("resources") + delFilePath);
            if (deleFile.isFile() && deleFile.exists()) {
                deleFile.delete();// 文件删除
            }
            String filePath=unit.getFilePath().replace(relaPath, "");
//            unit.setFilePath(totalFileUrl);
            inspectionUnitService.saveOrUpdate(unit);
        }catch(Exception e){
            log.error("未知错误：" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "."
                    + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, e.getMessage());
        }
        return MiniProgramJson.ok("删除成功");
    }*/
}
