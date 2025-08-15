package com.dayuan.service;

import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.DyFileUtil;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.lang.reflect.Method;
import java.util.*;

public abstract class BaseService<T, ID extends java.io.Serializable> {

    public abstract BaseMapper<T, ID> getMapper();

    private TSDepartService departService = null;
    private BasePointService basePointService = null;

    private TSDepartService getDepartService() {
        if (departService == null) {
            departService = (TSDepartService) ContextHolderUtils.getBean("TSDepartServiceImpl");
        }
        return departService;
    }

    private BasePointService getBasePointService() {
        if (basePointService == null) {
            basePointService = (BasePointService) ContextHolderUtils.getBean("basePointService");
        }
        return basePointService;
    }

    public void insert(T t) throws Exception {
        getMapper().insert(t);
    }

    public void insertSelective(T t) throws Exception {
        getMapper().insertSelective(t);
    }

    public void updateById(T t) throws Exception {
        getMapper().updateByPrimaryKey(t);
    }

    public void updateBySelective(T t) throws Exception {
        getMapper().updateByPrimaryKeySelective(t);
    }

    @SuppressWarnings("unchecked")
    public int delete(ID... ids) throws Exception {
        if (ids == null || ids.length < 1) {
            return 0;
        }
        return getMapper().deleteByPrimaryKey(ids);
    }

    public int delete2(List<ID> ids, String updateUserId) throws Exception {
        if (ids == null || ids.size() == 0) {
            return 0;
        }
        return getMapper().deleteByPrimaryKeys(ids, updateUserId);
    }

    public T queryById(ID id) throws Exception {
        return getMapper().selectByPrimaryKey(id);
    }

    public List<T> queryByIds(ID[] ids) throws Exception {
        return getMapper().queryByIds(ids);
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
        page.setRowTotal(getMapper().getRowTotal(page));

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

        List<T> dataList = getMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 数据列表分页方法
     */
    public Page loadDatagrid(Page page, BaseModel t, BaseMapper bm) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(bm.getRowTotal(page));

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

        List<T> dataList = bm.loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 数据列表分页方法
     *
     * @param page               分页
     * @param t                  条件参数
     * @param c                  查询方法的类
     * @param loadDatagridMethod 查询列表数据方法
     * @param getRowTotalMethod  查询记录总数方法
     * @return
     * @throws Exception
     */
    public Page loadDatagrid(Page page, BaseModel t, Class c, String loadDatagridMethod, String getRowTotalMethod) throws Exception {
        Object bean = ContextHolderUtils.getBean(c);

        //获取查询列表数据方法
        Method m1 = c.getDeclaredMethod(loadDatagridMethod, Page.class);
        //获取查询记录总数方法
        Method m2 = c.getDeclaredMethod(getRowTotalMethod, Page.class);

        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal((Integer) m2.invoke(bean, page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
        }

        List<T> dataList = (List<T>) m1.invoke(bean, page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 根据更新时间查询数据
     *
     * @param lastUpdateTime
     * @return
     * @author xyl
     */
    public List<T> queryByUpdateDate(String lastUpdateTime) {
        return getMapper().queryByUpdateDate(lastUpdateTime);
    }

    /**
     * 通过三级菜单地址，获取当前用户查看数据权限
     * 机构用户默认查看本部，机构数据权限：
     * 查看本部：查看当前机构下的数据
     * 查看直管：查看当前机构和直属检测点的数据
     * 查看下级：查看当前机构及管辖下的所有机构和检测点的数据
     * 检测点用户只能查看当前检测点下的数据，无论是否已配置查看下级等相关权限
     * 监管对象用户只能查看当前监管对象下的数据，无论是否已配置查看下级等相关权限
     *
     * @param url 三级菜单地址
     * @return
     * @throws Exception
     */
    public Map dataPermission(String url) throws Exception {

//		TSFunctionService tSFunctionService = (TSFunctionService) ContextHolderUtils.getBean("tSFunctionService");
//		TSOperationService tSOperationService = (TSOperationService) ContextHolderUtils.getBean("tSOperationService");
//
//		TSFunction tsFunction = tSFunctionService.queryByFunctionUrl(url);
//		List<TSOperation> btnList = tSOperationService.queryByRoleIdAndFunctionId(PublicUtil.getSessionUser().getRoleId(),tsFunction.getId());
//		JSONArray json=new JSONArray().fromObject(btnList);
		
		Map<String,Object> map = new HashMap<String,Object>();
		Integer departID = null;
		Integer pointID = null;
		ArrayList<Integer> lis = new ArrayList<>();
		TSUser tsUser = PublicUtil.getSessionUser();

		//检测点、监管对象用户权限
		if(tsUser!=null){
			departID = tsUser.getDepartId();

			if(null != tsUser.getRegId()){	//监管对象用户
				pointID = tsUser.getPointId();
				map.put("departArr", null);
				map.put("pointArr", null);
				map.put("userRegId", tsUser.getRegId());
				map.put("handleState", 2);//处置标识,-1查询失败,0下级1直管2本部,多选默认最大权限
				return map;

			}else if(null != tsUser.getPointId()){	//检测点用户
				pointID = tsUser.getPointId();
				map.put("departArr", null);
				map.put("pointArr", new Integer[]{tsUser.getPointId()});
				map.put("userRegId", null);
				map.put("handleState", 2);//处置标识,-1查询失败,0下级1直管2本部,多选默认最大权限
				return map;
			}

		}else {
			map.put("departArr", null);
			map.put("pointArr", null);
			map.put("userRegId", null);
			map.put("handleState", -1);
			return map;
		}

		//获取菜单权限
		HttpSession session = ContextHolderUtils.getSession();
		JSONArray jsonArr = JSONArray.fromObject(session.getAttribute("btnList"));
		Iterator<Object> ja = jsonArr.iterator();
		while (ja.hasNext()){
			JSONObject job = (JSONObject) ja.next();
			if(job.get("functionUrl").equals(url)){
				//获取操作名称(operationCode不唯一,不作为判断条件)
				String operationName = job.get("operationName").toString();
				if(operationName.contains("本部")) lis.add(2);
				if(operationName.contains("直管")) lis.add(1);
				if(operationName.contains("下级")) lis.add(0);
			}
		}

		//机构用户权限
		//拿到处置标识,0下级1直管2本部,多选默认最大权限
		int handleState = 2;	//默认本部
		if(lis.size() > 0){
			handleState = Collections.min(lis);
		}
		
		List<Integer> pointArr = new ArrayList<Integer>();
		if(handleState == 0){//所有(下级)
			// 获取当前机构和其下属机构ID
			List<TSDepart> sDeparts = getDepartService().getAllSonDepartsByID(departID);
			List<Integer> departArr = new ArrayList<Integer>();
			if(sDeparts !=null && sDeparts.size()>0) {
				for(TSDepart sDepart : sDeparts) {
					departArr.add(sDepart.getId());
				}
			}
			//获取当前用户下的所有检测点
			List<BasePoint> points = getBasePointService().queryByDepartId(departID, "Y", null, new Integer[]{0,1,2});
			for(BasePoint point : points){
				pointArr.add(point.getId());
			}
			if(departArr.size()>0){
				map.put("departArr", departArr.toArray(new Integer[departArr.size()]));
			}
			if(pointArr.size()>0){
				map.put("pointArr", pointArr.toArray(new Integer[pointArr.size()]));
			}
			map.put("userRegId", null);
			map.put("handleState", 0);
			
		}else if(handleState == 1){//直管
			//获取当前用户下的直管检测点
			List<BasePoint> points = getBasePointService().selectByDepartid(departID,null);
			for(BasePoint point : points){
				pointArr.add(point.getId());
			}
			if(null != departID){
				map.put("departArr", new Integer[]{departID});
			}else{
				map.put("departArr", null);
			}
			if(pointArr.size()>0){
				map.put("pointArr", pointArr.toArray(new Integer[pointArr.size()]));
			}
			map.put("userRegId", null);
			map.put("handleState", 1);
			
		}else if(handleState == 2){//本部
			if(null!= departID){
				map.put("departArr", new Integer[]{departID});
			}else{
				map.put("departArr", null);
			}
			if(null != pointID){
				map.put("pointArr", new Integer[]{pointID});
			}else{
				map.put("pointArr", null);
			}
			map.put("userRegId", null);
			map.put("handleState", 2);
		}
		
		return map;
	}

	/**
	 * 通过三级菜单地址，获取当前用户查看数据权限
	 * 		查看直管：查看直属检测点
	 * 		查看下级：直属+所有下级机构检测点
	 * @param url	三级菜单地址
	 * @param  departID 机构ID
	* @Date 2020/10/21 14:44
	* @Author xiaoyl
	* @Param
	* @return
	*/
	public Map dataPermissionForVedio(String url,Integer departID) throws Exception{

		Map<String,Object> map = new HashMap<String,Object>();
		ArrayList<Integer> lis = new ArrayList<>();
		//获取菜单权限
		HttpSession session = ContextHolderUtils.getSession();
		JSONArray jsonArr = JSONArray.fromObject(session.getAttribute("btnList"));
		Iterator<Object> ja = jsonArr.iterator();
		while (ja.hasNext()){
			JSONObject job = (JSONObject) ja.next();
			if(job.get("functionUrl").equals(url)){
				//获取操作名称(operationCode不唯一,不作为判断条件)
				String operationName = job.get("operationName").toString();
				if(operationName.contains("直管")) lis.add(1);
				if(operationName.contains("下级")) lis.add(0);
			}
		}
		//机构用户权限
		//拿到处置标识,0下级1直管,多选默认最大权限
		int handleState = 1;	//默认直管
		if(lis.size() > 0){
			handleState = Collections.min(lis);
		}

		List<Integer> pointArr = new ArrayList<Integer>();
		if(handleState == 0){//所有(下级)
			// 获取当前机构和其下属机构ID
			List<TSDepart> sDeparts = getDepartService().getAllSonDepartsByID(departID);
			List<Integer> departArr = new ArrayList<Integer>();
			if(sDeparts !=null && sDeparts.size()>0) {
				for(TSDepart sDepart : sDeparts) {
					departArr.add(sDepart.getId());
				}
			}
			//获取当前用户下的所有检测点
			List<BasePoint> points = getBasePointService().queryByDepartId(departID, "Y", null, new Integer[]{0,1,2});
			for(BasePoint point : points){
				pointArr.add(point.getId());
			}
			if(departArr.size()>0){
				map.put("departArr", departArr.toArray(new Integer[departArr.size()]));
			}
			if(pointArr.size()>0){
				map.put("pointArr", pointArr.toArray(new Integer[pointArr.size()]));
			}
			map.put("userRegId", null);
			map.put("handleState", 0);

		}else if(handleState == 1){//直管
			//获取当前用户下的直管检测点
			List<BasePoint> points = getBasePointService().selectByDepartid(departID,null);
			for(BasePoint point : points){
				pointArr.add(point.getId());
			}
			if(null != departID){
				map.put("departArr", new Integer[]{departID});
			}else{
				map.put("departArr", null);
			}
			if(pointArr.size()>0){
				map.put("pointArr", pointArr.toArray(new Integer[pointArr.size()]));
			}
			map.put("userRegId", null);
			map.put("handleState", 1);

		}
		return map;
	}



	/**
	 * 通过三级菜单地址，获取当前用户查看数据权限
	 * 机构用户默认查看本部，机构数据权限：
	 * 		查看本部：查看当前机构下的数据
	 * 		查看直管：查看当前机构和直属检测点的数据
	 * 		查看下级：查看当前机构及管辖下的所有机构和检测点的数据
	 * 检测点用户只能查看当前检测点下的数据，无论是否已配置查看下级等相关权限
	 * 监管对象用户只能查看当前监管对象下的数据，无论是否已配置查看下级等相关权限
	 * @param url	三级菜单地址
	 * @return
	 * @throws Exception
	 */
	public Map dataPermission(String url,TSUser tsUser) throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		Integer departID = null;
		Integer pointID = null;
		ArrayList<Integer> lis = new ArrayList<>();

		//检测点、监管对象用户权限
		if(tsUser!=null){
			departID = tsUser.getDepartId();

			if(null != tsUser.getRegId()){	//监管对象用户
				pointID = tsUser.getPointId();
				map.put("departArr", null);
				map.put("pointArr", null);
				map.put("userRegId", tsUser.getRegId());
				map.put("handleState", 2);//处置标识,-1查询失败,0下级1直管2本部,多选默认最大权限
				return map;

			}else if(null != tsUser.getPointId()){	//检测点用户
				pointID = tsUser.getPointId();
				map.put("departArr", null);
				map.put("pointArr", new Integer[]{tsUser.getPointId()});
				map.put("userRegId", null);
				map.put("handleState", 2);//处置标识,-1查询失败,0下级1直管2本部,多选默认最大权限
				return map;
			}

		}else {
			map.put("departArr", null);
			map.put("pointArr", null);
			map.put("userRegId", null);
			map.put("handleState", -1);
			return map;
		}

		//获取菜单权限
		HttpSession session = ContextHolderUtils.getSession();
		JSONArray jsonArr = JSONArray.fromObject(session.getAttribute("btnList"));
		Iterator<Object> ja = jsonArr.iterator();
		while (ja.hasNext()){
			JSONObject job = (JSONObject) ja.next();
			if(job.get("functionUrl").equals(url)){
				//获取操作名称(operationCode不唯一,不作为判断条件)
				String operationName = job.get("operationName").toString();
				if(operationName.contains("本部")) lis.add(2);
				if(operationName.contains("直管")) lis.add(1);
				if(operationName.contains("下级")) lis.add(0);
			}
		}

		//机构用户权限
		//拿到处置标识,0下级1直管2本部,多选默认最大权限
		int handleState = 2;	//默认本部
		if(lis.size() > 0){
			handleState = Collections.min(lis);
		}

		List<Integer> pointArr = new ArrayList<Integer>();
		if(handleState == 0){//所有(下级)
			// 获取当前机构和其下属机构ID
			List<TSDepart> sDeparts = getDepartService().getAllSonDepartsByID(departID);
			List<Integer> departArr = new ArrayList<Integer>();
			if(sDeparts !=null && sDeparts.size()>0) {
				for(TSDepart sDepart : sDeparts) {
					departArr.add(sDepart.getId());
				}
			}
			//获取当前用户下的所有检测点
			List<BasePoint> points = getBasePointService().queryByDepartId(departID, "Y", null, new Integer[]{0,1,2});
			for(BasePoint point : points){
				pointArr.add(point.getId());
			}
			if(departArr.size()>0){
				map.put("departArr", departArr.toArray(new Integer[departArr.size()]));
			}
			if(pointArr.size()>0){
				map.put("pointArr", pointArr.toArray(new Integer[pointArr.size()]));
			}
			map.put("userRegId", null);
			map.put("handleState", 0);

		}else if(handleState == 1){//直管
			//获取当前用户下的直管检测点
			List<BasePoint> points = getBasePointService().selectByDepartid(departID,null);
			for(BasePoint point : points){
				pointArr.add(point.getId());
			}
			if(null != departID){
				map.put("departArr", new Integer[]{departID});
			}else{
				map.put("departArr", null);
			}
			if(pointArr.size()>0){
				map.put("pointArr", pointArr.toArray(new Integer[pointArr.size()]));
			}
			map.put("userRegId", null);
			map.put("handleState", 1);

		}else if(handleState == 2){//本部
			if(null!= departID){
				map.put("departArr", new Integer[]{departID});
			}else{
				map.put("departArr", null);
			}
			if(null != pointID){
				map.put("pointArr", new Integer[]{pointID});
			}else{
				map.put("pointArr", null);
			}
			map.put("userRegId", null);
			map.put("handleState", 2);
		}

        return map;
    }

    /**
     * @param filePath 文件路径
     * @param file     文件
     * @param newName  是否取新名字:如果上传的是图片则获取图片的宽高拼接到新名字中UUID_宽x高；用于微信端查看使用
     * @return
     * @Description
     * @Date 2021/09/07 9:06
     * @Author xiaoyl
     */
    protected String getFileName2WidthAndHeight(String filePath, MultipartFile file, boolean newName) throws Exception {
        String result = "";
        if (file != null && file.getSize() > 0) {
            if (newName) {
                result += filePath + UUIDGenerator.generate();
                BufferedImage bufferedImage = ImageIO.read(file.getInputStream());
                if (bufferedImage != null) {//上传的是图片，获取宽高
                    result += "_" + bufferedImage.getWidth() + "x" + bufferedImage.getHeight();
                }
                if ("blob".equals(file.getOriginalFilename())) {
                    result += ".png";
                } else {
                    result += DyFileUtil.getFileExtension(file.getOriginalFilename());
                }
            } else {
                result = filePath + file.getOriginalFilename();
            }
            return result;
        } else {
            return result;
        }
    }

    /**
     * 保存文件
     *
     * @param file
     * @param filePath
     * @throws Exception
     */
    protected void saveFile(MultipartFile file, String filePath) throws Exception {
        try {
            DyFileUtil.uploadFile(filePath, file);
        } catch (Exception e) {
            e.printStackTrace();
            throw new MyException("文件保存失败!", "文件保存失败!", WebConstant.INTERFACE_CODE11);
        }
    }


    /**
     * 删除服务器上面的文件
     *
     * @param filePath
     * @return
     */
    protected boolean delServerFile(String filePath) {
        if (StringUtil.isNotEmpty(filePath)) {
            String resources = WebConstant.res.getString("resources");
            File file = new File(resources + filePath);
            return file.exists() && file.isFile() && file.delete();
        } else {
            return false;
        }
    }

	protected String getFileName(String filePath, MultipartFile file, boolean newName) throws Exception {
		if (file != null && file.getSize() > 0) {
			if (newName) {
				return filePath + UUIDGenerator.generate() + DyFileUtil.getFileExtension(file.getOriginalFilename());
			} else {
				return filePath + file.getOriginalFilename();
			}
		} else {
			return "";
		}
	}
	protected String getFileName(MultipartFile file) throws Exception {
		if ("blob".equals(file.getOriginalFilename())) {
			return UUIDGenerator.generate() +".png";
		} else {
			return UUIDGenerator.generate() + DyFileUtil.getFileExtension(file.getOriginalFilename());
		}
	}
}
