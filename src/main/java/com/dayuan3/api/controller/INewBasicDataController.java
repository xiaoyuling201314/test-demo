package com.dayuan3.api.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.util.ZipUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dayuan.bean.data.*;
import com.dayuan.service.data.*;
import com.dayuan.util.StringUtil;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.api.common.ErrCode;
import com.dayuan3.api.common.MiniProgramJson;
import com.dayuan3.api.vo.*;
import com.dayuan3.common.util.SystemConfigUtil;
import com.github.xiaoymin.knife4j.annotations.ApiOperationSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.ReentrantReadWriteLock;
import java.util.stream.Collectors;

/**
 * 基础数据API
 *
 * @author Dz
 * @version 1.0
 * @date 2025/6/13 14:23
 * @description 类的功能描述
 */
@Slf4j
@Api(tags = "基础数据")
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/basic")
public class INewBasicDataController {

    private final BaseFoodTypeService  baseFoodTypeService;
    private final BaseFoodItemService baseFoodItemService;
    private final BaseDetectItemService baseDetectItemService;
    private final TbCheckPlanService tbCheckPlanService;
    private final BaseStandardService baseStandardService;
    private final BaseDeviceService baseDeviceService;
    private final BaseDeviceParameterService baseDeviceParameterService;
    @Autowired
    private InspectionUnitService inspectionUnitService;

    /**
     * 资源地址
     */
    @Value("${resourcesUrl}")
    private String resourcesUrl;
    /**
     * 文件根目录
     */
    @Value("${resources}")
    private String resources;
    /**
     * 基础数据文件临时目录
     */
    @Value("${basicDataTemp}")
    private String basicDataTemp;
    /**
     * 食品数据压缩文件目录
     */
    @Value("${foodZipPath}")
    private String foodZipPath;
    /**
     * 样品检测项目数据压缩文件目录
     */
    @Value("${foodItemZipPath}")
    private String foodItemZipPath;
    /**
     * 检测项目压缩文件目录
     */
    @Value("${itemZipPath}")
    private String itemZipPath;
    /**
     * 仪器检测项目压缩文件目录
     */
    @Value("${deviceItemZipPath}")
    private String deviceItemZipPath;

//    @Valid
//    @ApiOperation("查询样品")
//    @ApiOperationSupport(order = 1)
//    @GetMapping("/getFood/{orderNumber}")
////    public MiniProgramJson<Boolean> checkOrderNumber(@Valid @RequestBody CheckOrderReqVO reqVO) {
//    public MiniProgramJson<Boolean> checkOrderNumber(@PathVariable("orderNumber") String orderNumber) {
//        Boolean isValid = tbSamplingService.checkOrderNumber(orderNumber);
//        if (!isValid) {
//            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL,"订单号无效或已占用", isValid);
//        } else {
//            return MiniProgramJson.ok("订单号有效", isValid);
//        }
//    }
//
//    @ApiOperation("新增订单")
//    @ApiOperationSupport(order = 2)
//    @PostMapping("/create")
//    public MiniProgramJson<Object> createMatches(@Valid @RequestBody CreateOrderReqVO reqVO) throws MiniProgramException {
//        TbSampling sampling = new TbSampling();
//        BeanUtil.copyProperties(reqVO, sampling);
//
//        List<TbSamplingDetail> details = new ArrayList<>();
//        reqVO.getOrderItems().forEach(orderItem -> {
//            TbSamplingDetail detail = new TbSamplingDetail();
//            BeanUtil.copyProperties(orderItem, detail);
//            details.add(detail);
//        });
//
//        //创建订单
//        int orderId = tbSamplingService.createOrder(sampling, details);
//
//        // 返回什么？前端支付
//        if (orderId != 0) {
//            return MiniProgramJson.ok("下单成功", orderId);
//        } else {
//            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL,"下单失败", orderId);
//        }
//    }


    @GetMapping("/page/foodItem")
    @ApiOperation("1.分页查询样品与检测项目数据")
    @ApiOperationSupport(order = 1)
    @ApiImplicitParams({
            @ApiImplicitParam(name="foodName",value="样品名称", required=false,dataType="String", example = "宁夏菜心"),
            @ApiImplicitParam(name="current",value="页码", required=false, dataType="Long", example = "1"),
            @ApiImplicitParam(name="size",value="每页显示记录数（默认100）",required=false,dataType="Long")
    })
    public MiniProgramJson<PageVo<FoodItemPageRespVo>> foodItemPage(
            @RequestParam(value = "foodName", required = false) String foodName,
            @RequestParam(value = "current", required = false, defaultValue = "1") Long current,
            @RequestParam(value = "size", required = false, defaultValue = "100") Long size) {

        // 分页模糊查询样品
        LambdaQueryWrapper<BaseFoodType> queryWrapper = new LambdaQueryWrapper<>();
        if (StrUtil.isNotBlank(foodName)) {
            queryWrapper.like(BaseFoodType::getFoodName, foodName)
                    .or().like(BaseFoodType::getFoodNameOther, foodName);
        }
        Page<BaseFoodType> foodPage = baseFoodTypeService.page(Page.of(current, size), queryWrapper);

        // 转换成VO
        PageVo<FoodItemPageRespVo> pageVo = new PageVo<>();
        BeanUtil.copyProperties(foodPage, pageVo);

        // 有数据，查询计划检测项目
        if (!foodPage.getRecords().isEmpty()) {

            // 默认检测项目ID(克百威)
            String defaultItemId = StringUtil.isNotEmpty(SystemConfigUtil.OTHER_CONFIG.getString("default_item_id")) ? SystemConfigUtil.OTHER_CONFIG.getString("default_item_id") : "0be23435970e69e0b36ae62113b149ff";
            BaseDetectItem defaultItem = baseDetectItemService.getById(defaultItemId);
            if (defaultItem == null) {
                return MiniProgramJson.error(ErrCode.DATA_ABNORMAL,"默认检测项目不存在", null);
            }

            // 获取该日期是星期几，1 表示周日，2 表示周一，以此类推
            int dayOfWeek= DateUtil.dayOfWeek(new Date());

            // 查询样品计划检测项目
            List<Map<String, Object>> checkPlans = tbCheckPlanService.getPlans(dayOfWeek, foodPage.getRecords().stream().map(BaseFoodType::getId).collect(Collectors.toList()));

            // 样品检测项目数据VO
            List<FoodItemPageRespVo> foodItemPageVos = new ArrayList<>();
            // 转换成VO
            foodPage.getRecords().forEach(food -> {
                FoodItemPageRespVo foodItemPageVo = new FoodItemPageRespVo();
                foodItemPageVo.setFoodId(food.getId());
                foodItemPageVo.setFoodName(food.getFoodName());
                foodItemPageVo.setFoodAlias(food.getFoodNameOther());

                // 获取相应计划
                Map<String, Object> checkPlan = checkPlans.stream().filter(plan -> plan.get("foodId").equals(food.getId())).findFirst().orElse(null);
                if (checkPlan != null) {
                    foodItemPageVo.setItemId(checkPlan.get("itemId").toString());
                    foodItemPageVo.setItemName(checkPlan.get("itemName").toString());
                    foodItemPageVo.setPrice(checkPlan.get("price").toString());
                } else {
                    // 默认
                    foodItemPageVo.setItemId(defaultItemId);
                    foodItemPageVo.setItemName(defaultItem.getDetectItemName());
                    foodItemPageVo.setPrice(NumberUtil.roundStr(defaultItem.getPrice(),2));
                }
                foodItemPageVos.add(foodItemPageVo);
            });

            pageVo.setRecords(foodItemPageVos);
        }

        return MiniProgramJson.data(pageVo);
    }
    @GetMapping("/queryInspUnit")
    @ApiOperation("2.根据冷链单位ID查询经营单位")
    @ApiImplicitParams({
            @ApiImplicitParam(name="coldId",value="冷链单位ID",required = true,dataType="Integer"),
            @ApiImplicitParam(name="companyCode",value="仓口名称或编号",required = false,dataType="String")
    })
    public MiniProgramJson<List<InspectionUnitRespVo>> queryInspUnit(@RequestParam(required = true) Integer coldId,
                                                                     @RequestParam(required = false)String companyCode) {
        List<InspectionUnitRespVo> list= inspectionUnitService.queryByColdId(coldId,companyCode);
        return MiniProgramJson.data(list);
    }
    @GetMapping("/getReCheck")
    @ApiOperation("3.查询复检单价，单位为元")
    public MiniProgramJson<BigDecimal> getReCheck() {
        BigDecimal reCheckPrice = BigDecimal.valueOf(SystemConfigUtil.OTHER_CONFIG.getDouble("re_check_price"));
        return MiniProgramJson.data(reCheckPrice);
    }


    /************************************************** 以下，仪器接口 ************************************************/

    /**
     * 食品数据压缩文件读写锁
     */
    final ReentrantReadWriteLock foodZipLock = new ReentrantReadWriteLock();
    @GetMapping("/zip/food")
    @ApiOperation("11.（仪器接口）获取全部样品数据zip文件")
    public MiniProgramJson<String> foodZip() {
        //  获取读锁
        foodZipLock.readLock().lock();

        //  压缩文件下载地址
        String downloadUrl = resourcesUrl + basicDataTemp + foodZipPath;

        // 1.获取最新数据更新时间
        BaseFoodType lastUpdate = baseFoodTypeService.getOne(new LambdaQueryWrapper<BaseFoodType>()
                .orderByDesc(BaseFoodType::getUpdateDate)
                .last("limit 1"));
        if (lastUpdate == null) {
            return MiniProgramJson.ok("暂无数据");
        }

        // 查询条件
        LambdaQueryWrapper<BaseFoodType> queryWrapper = new LambdaQueryWrapper<BaseFoodType>()
                .eq(BaseFoodType::getChecked,1);

        // 2.获取食品数据总数量，防止数据删除后未能更新
        long rowTotal = baseFoodTypeService.count(queryWrapper);

        // 3.查询压缩文件是否存在
        String dirPath = resources + basicDataTemp + foodZipPath;
        String fileName = "food_" + rowTotal + "_" + DateUtil.format(lastUpdate.getUpdateDate(), "yyyyMMddHHmmss");
        String jsonFileName = fileName + ".json";
        String zipFileName = fileName + ".zip";

        if (!FileUtil.exist(dirPath + zipFileName)) {
            //  3.1.不存在则生成压缩文件

            //  获取写锁
            foodZipLock.readLock().unlock();
            foodZipLock.writeLock().lock();

            // 查询全部已审核样品
            List<BaseFoodType> foodList = baseFoodTypeService.list(queryWrapper);
            List<FoodZipRespVo> foodZipRespVos = new ArrayList<>();
            foodList.forEach(food -> {
                FoodZipRespVo foodZipRespVo = new FoodZipRespVo();
                BeanUtil.copyProperties(food, foodZipRespVo);
                foodZipRespVos.add(foodZipRespVo);
            });
            //  写入JSON文件
            File jsonFile = FileUtil.writeString(JSONObject.toJSONString(foodZipRespVos), dirPath + jsonFileName, "UTF-8");
            //  压缩文件
            ZipUtil.zip(jsonFile);

//            // 锁降级，防止在释放写锁后，其他线程获取写锁并修改数据
//            foodZipLock.readLock().lock();
//            foodZipLock.writeLock().unlock();

            //  释放锁
            foodZipLock.writeLock().unlock();

        } else {
            //  释放锁
            foodZipLock.readLock().unlock();
        }

        //  4.返回下载地址
        downloadUrl += zipFileName;
        return MiniProgramJson.data(downloadUrl);
    }


    /**
     * 样品检测项目数据压缩文件读写锁
     */
    final ReentrantReadWriteLock foodItemZipLock = new ReentrantReadWriteLock();
    @GetMapping("/zip/foodItem")
    @ApiOperation("12.（仪器接口）获取全部样品检测项目数据zip文件")
    public MiniProgramJson<String> foodItemZip() {
        //  获取读锁
        foodItemZipLock.readLock().lock();

        //  压缩文件下载地址
        String downloadUrl = resourcesUrl + basicDataTemp + foodItemZipPath;

        // 1.获取最新数据更新时间
        BaseFoodItem lastUpdate = baseFoodItemService.getOne(new LambdaQueryWrapper<BaseFoodItem>()
                .orderByDesc(BaseFoodItem::getUpdateDate)
                .last("limit 1"));
        if (lastUpdate == null) {
            return MiniProgramJson.ok("暂无数据");
        }

        // 样品查询条件
        LambdaQueryWrapper<BaseFoodType> foodQueryWrapper = new LambdaQueryWrapper<BaseFoodType>()
                .eq(BaseFoodType::getChecked, 1);
        List<BaseFoodType> foodList = baseFoodTypeService.list(foodQueryWrapper);

        // 检测项目查询条件
        LambdaQueryWrapper<BaseDetectItem> itemQueryWrapper = new LambdaQueryWrapper<BaseDetectItem>()
                .eq(BaseDetectItem::getChecked, 1);
        List<BaseDetectItem> itemList = baseDetectItemService.list(itemQueryWrapper);

        // 关联表查询条件
        LambdaQueryWrapper<BaseFoodItem> foodItemQueryWrapper = new LambdaQueryWrapper<BaseFoodItem>()
                .eq(BaseFoodItem::getChecked, 1)
                .in(BaseFoodItem::getFoodId, foodList.stream().map(BaseFoodType::getId).collect(Collectors.toList()))
                .in(BaseFoodItem::getItemId, itemList.stream().map(BaseDetectItem::getId).collect(Collectors.toList()));

        // 2.获取样品检测项目数据总数量，防止数据删除后未能更新；（过滤已删除和未审核的样品、检测项目）
        long rowTotal = baseFoodItemService.count(foodItemQueryWrapper);

        // 3.查询压缩文件是否存在
        String dirPath = resources + basicDataTemp + foodItemZipPath;
        String fileName = "foodItem_" + rowTotal + "_" + DateUtil.format(lastUpdate.getUpdateDate(), "yyyyMMddHHmmss");
        String jsonFileName = fileName + ".json";
        String zipFileName = fileName + ".zip";

        if (!FileUtil.exist(dirPath + zipFileName)) {
            //  3.1.不存在则生成压缩文件

            //  获取写锁
            foodItemZipLock.readLock().unlock();
            foodItemZipLock.writeLock().lock();

            // 查询全部样品检测项目
            List<BaseFoodItem> foodItemList = baseFoodItemService.list(foodItemQueryWrapper);
            List<FoodItemZipRespVo> foodItemZipRespVos = new ArrayList<>();
            foodItemList.forEach(foodItem -> {
                FoodItemZipRespVo foodItemZipRespVo = new FoodItemZipRespVo();
                BeanUtil.copyProperties(foodItem, foodItemZipRespVo);
                foodItemZipRespVos.add(foodItemZipRespVo);
            });
            //  写入JSON文件
            File jsonFile = FileUtil.writeString(JSONObject.toJSONString(foodItemZipRespVos), dirPath + jsonFileName, "UTF-8");
            //  压缩文件
            ZipUtil.zip(jsonFile);

//            // 锁降级，防止在释放写锁后，其他线程获取写锁并修改数据
//            foodItemZipLock.readLock().lock();
//            foodItemZipLock.writeLock().unlock();

            //  释放锁
            foodItemZipLock.writeLock().unlock();

        } else {
            //  释放锁
            foodItemZipLock.readLock().unlock();
        }

        //  4.返回下载地址
        downloadUrl += zipFileName;
        return MiniProgramJson.data(downloadUrl);
    }


    /**
     * 检测项目数据压缩文件读写锁
     */
    final ReentrantReadWriteLock itemZipLock = new ReentrantReadWriteLock();
    @GetMapping("/zip/item")
    @ApiOperation("13.（仪器接口）获取全部检测项目数据zip文件")
    public MiniProgramJson<String> itemZip() {
        //  获取读锁
        itemZipLock.readLock().lock();

        //  压缩文件下载地址
        String downloadUrl = resourcesUrl + basicDataTemp + itemZipPath;

        // 1.获取最新数据更新时间
        BaseDetectItem lastUpdate = baseDetectItemService.getOne(new LambdaQueryWrapper<BaseDetectItem>()
                .eq(BaseDetectItem::getChecked,1)
                .orderByDesc(BaseDetectItem::getUpdateDate)
                .last("limit 1"));
        if (lastUpdate == null) {
            return MiniProgramJson.ok("暂无数据");
        }

        // 查询条件
        LambdaQueryWrapper<BaseDetectItem> queryWrapper = new LambdaQueryWrapper<BaseDetectItem>()
                .eq(BaseDetectItem::getChecked,1);

        // 2.获取检测项目数据总数量，防止数据删除后未能更新
        long rowTotal = baseDetectItemService.count(queryWrapper);

        // 3.查询压缩文件是否存在
        String dirPath = resources + basicDataTemp + itemZipPath;
        String fileName = "item_" + rowTotal + "_" + DateUtil.format(lastUpdate.getUpdateDate(), "yyyyMMddHHmmss");
        String jsonFileName = fileName + ".json";
        String zipFileName = fileName + ".zip";

        if (!FileUtil.exist(dirPath + zipFileName)) {
            //  3.1.不存在则生成压缩文件

            //  获取写锁
            itemZipLock.readLock().unlock();
            itemZipLock.writeLock().lock();

            // 查询全部检测项目
            List<BaseDetectItem> itemList = baseDetectItemService.list(queryWrapper);

            // 获取检测标准信息
            List<BaseStandard> standardList;
            if (!itemList.isEmpty()) {
                standardList = baseStandardService.list(new LambdaQueryWrapper<BaseStandard>()
                        .in(BaseStandard::getId, itemList.stream().map(BaseDetectItem::getStandardId).collect(Collectors.toList())));
            } else {
                standardList = new ArrayList<>();
            }

            List<ItemZipRespVo> itemZipRespVos = new ArrayList<>();
            List<BaseStandard> finalStandardList = standardList;
            itemList.forEach(item -> {
                ItemZipRespVo itemZipRespVo = new ItemZipRespVo();
                BeanUtil.copyProperties(item, itemZipRespVo);
                itemZipRespVo.setItemName(item.getDetectItemName());

                // 检测标准
                BaseStandard standard = finalStandardList.stream().filter(s -> s.getId().toString().equals(item.getStandardId())).findFirst().orElse(null);
                if (standard != null) {
                    itemZipRespVo.setStandardId(standard.getId());
                    itemZipRespVo.setStandardCode(standard.getStdCode());
                    itemZipRespVo.setStandardName(standard.getStdName());
                }

                itemZipRespVos.add(itemZipRespVo);
            });
            //  写入JSON文件
            File jsonFile = FileUtil.writeString(JSONObject.toJSONString(itemZipRespVos), dirPath + jsonFileName, "UTF-8");
            //  压缩文件
            ZipUtil.zip(jsonFile);

//            // 锁降级，防止在释放写锁后，其他线程获取写锁并修改数据
//            itemZipLock.readLock().lock();
//            itemZipLock.writeLock().unlock();

            //  释放锁
            itemZipLock.writeLock().unlock();

        } else {
            //  释放锁
            itemZipLock.readLock().unlock();
        }

        //  4.返回下载地址
        downloadUrl += zipFileName;
        return MiniProgramJson.data(downloadUrl);
    }


    /**
     * 仪器检测项目数据压缩文件读写锁
     */
    final ReentrantReadWriteLock deviceItemZipLock = new ReentrantReadWriteLock();
    @GetMapping("/zip/deviceItem/{serialNumber}")
    @ApiOperation("14.（仪器接口）获取全部仪器检测项目数据zip文件")
    public MiniProgramJson<String> deviceItemZip(@PathVariable("serialNumber")String serialNumber) {
        //  获取读锁
        deviceItemZipLock.readLock().lock();

        //  压缩文件下载地址
        String downloadUrl = resourcesUrl + basicDataTemp + deviceItemZipPath;

        // 1.获取仪器型号
        BaseDevice device = baseDeviceService.getOne(new LambdaQueryWrapper<BaseDevice>()
                .eq(BaseDevice::getSerialNumber, serialNumber));
        if (device == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND, "找不到该编号仪器");
        }

        // 2.获取最新数据更新时间
        BaseDeviceParameter lastUpdate = baseDeviceParameterService.getOne(new LambdaQueryWrapper<BaseDeviceParameter>()
                .eq(BaseDeviceParameter::getDeviceTypeId,device.getDeviceTypeId())
                .orderByDesc(BaseDeviceParameter::getUpdateDate)
                .last("limit 1"));
        if (lastUpdate == null) {
            return MiniProgramJson.ok("暂无数据");
        }

        // 查询条件
        LambdaQueryWrapper<BaseDeviceParameter> queryWrapper = new LambdaQueryWrapper<BaseDeviceParameter>()
                .eq(BaseDeviceParameter::getDeviceTypeId,device.getDeviceTypeId());

        // 3.获取该系列仪器检测项目数据总数量，防止数据删除后未能更新
        long rowTotal = baseDetectItemService.count();

        // 4.查询压缩文件是否存在
        String dirPath = resources + basicDataTemp + deviceItemZipPath;
        String fileName = "deviceItem_" + device.getDeviceTypeId() + "_" + rowTotal + "_" + DateUtil.format(lastUpdate.getUpdateDate(), "yyyyMMddHHmmss");
        String jsonFileName = fileName + ".json";
        String zipFileName = fileName + ".zip";

        if (!FileUtil.exist(dirPath + zipFileName)) {
            //  4.1.不存在则生成压缩文件

            //  获取写锁
            deviceItemZipLock.readLock().unlock();
            deviceItemZipLock.writeLock().lock();

            // 查询全部该系列仪器检测项目
            List<BaseDeviceParameter> deviceItemList = baseDeviceParameterService.list(queryWrapper);

            List<DeviceItemZipRespVo> deviceItemZipRespVos = new ArrayList<>();
            deviceItemList.forEach(deviceItem -> {
                deviceItemZipRespVos.add(BeanUtil.toBean(deviceItem, DeviceItemZipRespVo.class));
            });
            //  写入JSON文件
            File jsonFile = FileUtil.writeString(JSONObject.toJSONString(deviceItemZipRespVos), dirPath + jsonFileName, "UTF-8");
            //  压缩文件
            ZipUtil.zip(jsonFile);

//            // 锁降级，防止在释放写锁后，其他线程获取写锁并修改数据
//            deviceItemZipLock.readLock().lock();
//            deviceItemZipLock.writeLock().unlock();

            //  释放锁
            deviceItemZipLock.writeLock().unlock();

        } else {
            //  释放锁
            deviceItemZipLock.readLock().unlock();
        }

        //  4.返回下载地址
        downloadUrl += zipFileName;
        return MiniProgramJson.data(downloadUrl);
    }

}
