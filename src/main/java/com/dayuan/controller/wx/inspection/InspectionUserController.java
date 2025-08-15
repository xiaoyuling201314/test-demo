package com.dayuan.controller.wx.inspection;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.wx.inspection.InspectionUser;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.exception.MyException;
import com.dayuan.model.wx.inspection.InspectionUserModel;
import com.dayuan.service.wx.inspection.InspectionUserService;
import com.dayuan.util.CipherUtil;
import com.dayuan.util.StringUtil;
import com.dayuan.util.wx.UserContext;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * 查看你送我检信息的用户Controller
 * Created by shit on 2018/8/3.
 */
@Controller
@RequestMapping("/wx/inspectionUser")
public class InspectionUserController {
    private static Boolean success = false;
    private static Integer userId = null;
    private final Logger log = Logger.getLogger(InspectionUserController.class);
    @Autowired
    private InspectionUserService inspectionUserService;

    /**
     * 根据公众号id查询关注人列表
     *
     * @param model
     * @param page
     * @return
     * @throws MissSessionExceprtion
     */
    @RequestMapping(value = "datagrid")
    @ResponseBody
    public AjaxJson datagrid(InspectionUserModel model, Page page) throws MissSessionExceprtion {
        AjaxJson jsonObj = new AjaxJson();
        try {
            if (model.getDateEnd() != null) {
                model.setDateEnd(model.getDateEnd() + "23:59:59");
            }
            page = inspectionUserService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return jsonObj;
    }


    /**
     * 个人中心
     *
     * @return
     */
    @RequestMapping("/userCenter")
    public String userCenter(HttpServletRequest request, Model model, String mobilePhone) {
        //判断是否登陆的拦截方法
        InspectionUser inspection_user = (InspectionUser) request.getSession().getAttribute("inspection_user");
        if (inspection_user == null) {//获取不到用户
            return InspectionInformationController.mainUrl;
        }
        model.addAttribute("mobilePhone", inspection_user);
        model.addAttribute("createDate", inspection_user.getCreateDate());
        model.addAttribute("openid", inspection_user.getOpenid());
        return "/wx/inspection/userCenter";
    }

    /**
     * 个人中心2
     *
     * @return
     */
    @RequestMapping("/userCenter2")
    public String userCenter2(HttpServletRequest request, Model model) {
        //判断是否登陆的拦截方法
        InspectionUser inspection_user = (InspectionUser) request.getSession().getAttribute("inspection_user");
        if (inspection_user == null) {//获取不到用户
            return InspectionInformationController.mainUrl;
        }
        model.addAttribute("inspectionUser", inspection_user);
        return "/wx/inspection/userCenter2";
    }

    /**
     * 退出登陆
     *
     * @return
     */
    @RequestMapping("/dropOut")
    public String dropOut(HttpServletRequest request, Model model, String openid) {
        //判断是否登陆的拦截方法
        request.getSession().invalidate();//清除session中所有信息removeAttribute（“name”）删除指定信息
        model.addAttribute("openid", openid);
        return "/wx/inspection/login";
    }

    /**
     * 退出登陆2
     *
     * @return
     */
    @RequestMapping("/dropOut2/{openid}.dykj1{departId}58y.do")
    public String dropOut2(HttpServletRequest request, Model model, InspectionUser inspectionUser) {
        //判断是否登陆的拦截方法
        request.getSession().invalidate();//清除session中所有信息removeAttribute（“name”）删除指定信息
        model.addAttribute("inspectionUser", inspectionUser);
        return "/wx/inspection/login2";
    }

    /**
     * 更换手机号码
     *
     * @return
     */
    @RequestMapping("/replacePhone")
    public String replacePhone(HttpServletRequest request, Model model, String openid) {
        //判断是否登陆的拦截方法
        InspectionUser inspection_user = (InspectionUser) request.getSession().getAttribute("inspection_user");
        if (inspection_user == null) {//获取不到用户
            return InspectionInformationController.mainUrl;
        }
        model.addAttribute("openid", openid);
        return "/wx/inspection/replacePhone";
    }

    /**
     * 更换手机号码2
     *
     * @return
     */
    @RequestMapping("/replacePhone3")
    public String replacePhone3(HttpServletRequest request, Model model, String openid, String departId) {
        model.addAttribute("openid", openid);
        model.addAttribute("departId", departId);
        return "/wx/inspection/replacePhone2";
    }

    @RequestMapping("/save")
    @ResponseBody
    public AjaxJson register(HttpServletRequest request, String openid, String mobilePhone, String userName, String password, String verificationCode) {
        CipherUtil cipher = new CipherUtil();
        //当用户点击菜单进入该界面或者登陆界面进行一次授权,获取微信名称
        AjaxJson ajaxJson = new AjaxJson();
        //可能存在的情况如下
        //2.此次是登录,并非注册,登录成功就直接跳转到内部界面
        try {
            if (StringUtil.isEmpty(openid)) {
                throw new MyException("获取用户信息失败");
            }
            if (StringUtil.isEmpty(mobilePhone) && StringUtil.isEmpty(verificationCode)) {//手机号和验证码为空
                if (!StringUtil.isEmpty(userName) && !StringUtil.isEmpty(password)) {//账号密码不为空,此时为登录
                    password = CipherUtil.generatePassword(password); // 加密算法
                    InspectionUser inspectionUser = inspectionUserService.selectUserByUserNameOrPassword(userName, password, openid);
                    request.getSession().setAttribute("inspection_user", inspectionUser);
                    request.getSession().setAttribute("openid2", inspectionUser.getOpenid());
                    ajaxJson.setMsg("登录成功");
                } else {
                    ajaxJson.setMsg("账号密码不能为空");
                    ajaxJson.setSuccess(false);
                }
            } else {
                InspectionUser user = inspectionUserService.selectByOpenid(openid);
                if (user != null) {
                    throw new MyException("该微信已绑定用户");
                }
                //获取验证码对象
                VerifyCodeVO vo = UserContext.getVerifyCodeInSession();
                if (vo != null) {
                    //1.验证码不正确或者手机号码不是发送短信的号码
                    if (!mobilePhone.equals(vo.getPhoneNumber())) {
                        throw new MyException("手机号和验证码不匹配");
                    }
                    if (!vo.getVerifyCode().equals(verificationCode)) {
                        throw new MyException("验证码输入错误");
                    }
                    //2.该手机号码已经注册过了
                    inspectionUserService.selectInspectionUser(mobilePhone);
                    if (!StringUtil.isEmpty(password)) {
                        //3.此次是注册,注册成功页面就提示注册成功,点击确定就跳转到内部界面
                        InspectionUser inspectionUser = new InspectionUser();
                        inspectionUser.setOpenid(openid);
                        //inspectionUser.setWechat("人生若只如初见");
                        inspectionUser.setUserName(mobilePhone);//第一次注册,以电话号码为用户名
                        inspectionUser.setMobilePhone(mobilePhone);//第一次注册,以电话号码为用户名
                        password = CipherUtil.generatePassword(password); // 加密算法
                        inspectionUser.setPassword(password);
                        inspectionUserService.insert(inspectionUser);
                        ajaxJson.setMsg("注册成功");
                    }
                } else {
                    throw new MyException("验证码失效，请从新发送验证码");
                }
            }
        } catch (MyException e) {
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            ajaxJson.setMsg("操作异常");
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }

    @RequestMapping("/selectUser")
    @ResponseBody
    public AjaxJson selectUser(String username) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            //通过账号名称查询用户
            InspectionUser inspectionUser = inspectionUserService.selectUserByUsername(username);
        } catch (MyException e) {
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        } catch (Exception e) {
            ajaxJson.setMsg("账号不存在");
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }

    /**
     * 重置密码
     *
     * @param mobilePhone
     * @param verificationCode
     * @return
     */
    @RequestMapping("/confirmCode")
    @ResponseBody
    public AjaxJson confirmCode(String mobilePhone, String verificationCode) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            //获取验证码对象
            VerifyCodeVO vo = UserContext.getVerifyCodeInSession();
            if (vo != null) {
                if (!mobilePhone.equals(vo.getPhoneNumber())) {
                    throw new MyException("手机号和验证码不匹配");
                }
                if (!vo.getVerifyCode().equals(verificationCode)) {
                    throw new MyException("验证码输入错误");
                }
                //通过手机号码和账号名称查询用户
                InspectionUser inspectionUser = inspectionUserService.selectUserByPhone(mobilePhone);
                userId = inspectionUser.getId();
                success = true;
            } else {
                throw new MyException("验证码失效，请从新发送验证码");
            }
        } catch (MyException e) {
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("操作异常");
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }


    @RequestMapping("/changePassword")
    @ResponseBody
    public AjaxJson changePassword(String password) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            //修改密码
            if (success) {
                inspectionUserService.changePassword(userId, password);
                ajaxJson.setMsg("密码修改成功");
            } else {
                ajaxJson.setMsg("密码修改失败");
                ajaxJson.setSuccess(false);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("密码修改失败");
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }


    /**
     * 发送短信获取验证码方法
     *
     * @param mobilePhone
     * @return
     */
    @RequestMapping("/sendVerifyCode")
    @ResponseBody
    public AjaxJson sendVerifyCode(String mobilePhone) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            inspectionUserService.sendVerifyCode(mobilePhone);
        } catch (MyException e) {
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("操作异常");
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }


    @RequestMapping("/login3")
    @ResponseBody
    public AjaxJson login2(HttpServletRequest request, InspectionUser inspectionUser) {
        //当用户点击菜单进入该界面或者登陆界面进行一次授权,获取微信名称
        AjaxJson ajaxJson = new AjaxJson();
        String openid = inspectionUser.getOpenid();
        String mobilePhone = inspectionUser.getMobilePhone();
        String verificationCode = inspectionUser.getVerificationCode();
        try {
            if (StringUtil.isEmpty(inspectionUser.getOpenid())) {
                throw new MyException("获取用户信息失败");
            }
            if (StringUtil.isEmpty(mobilePhone)) {
                throw new MyException("手机号码不能为空");
            }
            if (StringUtil.isEmpty(verificationCode)) {
                throw new MyException("验证码不能为空");
            }
            //获取验证码对象
            VerifyCodeVO vo = UserContext.getVerifyCodeInSession();
            if (vo != null) {
                //1.验证码不正确或者手机号码不是发送短信的号码
                if (!mobilePhone.equals(vo.getPhoneNumber())) {
                    throw new MyException("手机号和验证码不匹配");
                }
                if (!vo.getVerifyCode().equals(verificationCode)) {
                    throw new MyException("验证码输入错误");
                }
                //查询用户
                InspectionUser inspectionUser2 = inspectionUserService.selectUserPhoneAndOpenid2(mobilePhone, inspectionUser.getDepartId());
                if (inspectionUser2 == null) {//用户不存在就是新增
                    inspectionUser.setCreateDate(new Date());
                    inspectionUser.setBindTime(new Date());//设置绑定时间
                    inspectionUserService.insert(inspectionUser);
                    request.getSession().setAttribute("inspection_user", inspectionUser);
                }
                if (inspectionUser2 != null) {//存在就是编辑
                    inspectionUser2.setUpdateDate(new Date());
                    inspectionUser2.setOpenid(openid);
                    inspectionUser2.setStatus(0);
                    inspectionUser2.setBindTime(new Date());//设置绑定时间
                    inspectionUser2.setBindNumber(inspectionUser2.getBindNumber() + 1);
                    inspectionUser2.setDepartId(inspectionUser.getDepartId());
                    //以下设置一些可有可无参数
                    inspectionUser2.setSex(inspectionUser.getSex());
                    inspectionUser2.setNickName(inspectionUser.getNickName());
                    inspectionUser2.setCity(inspectionUser.getCity());
                    inspectionUser2.setCountry(inspectionUser.getCountry());
                    inspectionUser2.setHeadimgurl(inspectionUser.getHeadimgurl());
                    inspectionUserService.updateBindUser(inspectionUser2);//绑定的编辑
                    request.getSession().setAttribute("inspection_user", inspectionUser2);
                }
                request.getSession().setAttribute("openid2", openid);
                ajaxJson.setMsg("登录成功");
            } else {
                throw new MyException("验证码失效，请重新发送验证码");
            }
        } catch (MyException e) {
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("操作异常");
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }


    @RequestMapping("/login2")
    @ResponseBody
    public AjaxJson login2(HttpServletRequest request, String mobilePhone, String verificationCode, String openid) {
        //当用户点击菜单进入该界面或者登陆界面进行一次授权,获取微信名称
        AjaxJson ajaxJson = new AjaxJson();
        try {
            if (StringUtil.isEmpty(openid)) {
                throw new MyException("获取用户信息失败");
            }
            if (StringUtil.isEmpty(mobilePhone)) {
                throw new MyException("手机号码不能为空");
            }
            if (StringUtil.isEmpty(verificationCode)) {
                throw new MyException("验证码不能为空");
            }
            //获取验证码对象
            VerifyCodeVO vo = UserContext.getVerifyCodeInSession();
            if (vo != null) {
                //1.验证码不正确或者手机号码不是发送短信的号码
                if (!mobilePhone.equals(vo.getPhoneNumber())) {
                    throw new MyException("手机号和验证码不匹配");
                }
                if (!vo.getVerifyCode().equals(verificationCode)) {
                    throw new MyException("验证码输入错误");
                }

                //查询用户
                InspectionUser inspectionUser = inspectionUserService.selectUserPhoneAndOpenid(mobilePhone);
                if (inspectionUser == null) {//用户不存在就是新增
                    inspectionUser = new InspectionUser();
                    inspectionUser.setOpenid(openid);
                    inspectionUser.setCreateDate(new Date());
                    inspectionUser.setMobilePhone(mobilePhone);//第一次注册,以电话号码为用户名
                    inspectionUserService.insert(inspectionUser);
                }
                if (inspectionUser != null && StringUtil.isEmpty(inspectionUser.getOpenid())) {//存在就是编辑
                    inspectionUser.setUpdateDate(new Date());
                    inspectionUser.setOpenid(openid);
                    inspectionUser.setBindNumber(inspectionUser.getBindNumber() + 1);
                    inspectionUserService.updateBindUser(inspectionUser);//绑定的编辑
                }
                request.getSession().setAttribute("openid2", openid);
                request.getSession().setAttribute("inspection_user", inspectionUser);
                ajaxJson.setMsg("登录成功");
            } else {
                throw new MyException("验证码失效，请重新发送验证码");
            }
        } catch (MyException e) {
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("操作异常");
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }


    @RequestMapping("/replacePhone2")
    @ResponseBody
    public AjaxJson replacePhone2(HttpServletRequest request, String mobilePhone, String verificationCode, String departId) {
        //当用户点击菜单进入该界面或者登陆界面进行一次授权,获取微信名称
        AjaxJson ajaxJson = new AjaxJson();
        try {
            //判断是否登陆的拦截方法
            if (StringUtil.isEmpty(mobilePhone)) {
                throw new MyException("手机号码不能为空");
            }
            if (StringUtil.isEmpty(verificationCode)) {
                throw new MyException("验证码不能为空");
            }
            //获取验证码对象
            VerifyCodeVO vo = UserContext.getVerifyCodeInSession();
            if (vo != null) {
                //1.验证码不正确或者手机号码不是发送短信的号码
                if (!mobilePhone.equals(vo.getPhoneNumber())) {
                    throw new MyException("手机号和验证码不匹配");
                }
                if (!vo.getVerifyCode().equals(verificationCode)) {
                    throw new MyException("验证码输入错误");
                }

                InspectionUser inspection_user = (InspectionUser) request.getSession().getAttribute("inspection_user");
                if (inspection_user == null) {
                    throw new MyException("用户失效，请重新登录");
                }
                String oldPhone = inspection_user.getMobilePhone();
                if (oldPhone.equals(mobilePhone)) {
                    throw new MyException("新号码和旧号码不能相同");
                }
                inspection_user.setMobilePhone(mobilePhone);
                inspectionUserService.replacePhoneByUser(inspection_user);//更改当前用户的电话号码
                ajaxJson.setMsg("更换成功");
                request.getSession().setAttribute("inspection_user", inspection_user);
            } else {
                throw new MyException("验证码失效，请重新发送验证码");
            }
        } catch (MyException e) {
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("操作异常");
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }


    @RequestMapping(value = "/untie_user", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson untieUser(String openid, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            HttpSession session = request.getSession();
            //判断是否登陆的拦截方法
            InspectionUser inspection_user = (InspectionUser) session.getAttribute("inspection_user");
            if (inspection_user == null) {//获取不到用户
                ajaxJson.setSuccess(false);
                ajaxJson.setMsg("获取用户信息失败，请退出后重新登陆");
                return ajaxJson;
            }
            //解绑操作只能本人解绑
            if (StringUtil.isNotEmpty(inspection_user.getOpenid()) && inspection_user.getOpenid().equals(openid)) {
                inspection_user.setOpenid(null);
                inspection_user.setStatus(1);//设置状态为解绑
                inspectionUserService.untieUser(inspection_user);//解绑
                session.invalidate();//清除session中所有信息removeAttribute（“name”）删除指定信息
            } else {
                ajaxJson.setSuccess(false);
                ajaxJson.setMsg("解绑用户和当前登陆用户不匹配！");
            }
            ajaxJson.setMsg("解绑成功");
        } catch (Exception e) {
            log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            ajaxJson.setMsg("解绑失败，请联系管理员");
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }


    /**
     * 保存地址
     *
     * @return
     */
    @RequestMapping(value = "/save_address", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson saveAddress(HttpServletRequest request, InspectionUser inspectionUser) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            HttpSession session = request.getSession();
            InspectionUser sessionUser = (InspectionUser) session.getAttribute("inspection_user");
            inspectionUserService.saveAddress(inspectionUser, sessionUser);
            ajaxJson.setMsg("信息保存成功");
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("操作失败");
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }
}
