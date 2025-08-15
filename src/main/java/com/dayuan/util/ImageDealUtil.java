package com.dayuan.util;

import com.alibaba.fastjson.JSONObject;
import com.dayuan3.common.util.SystemConfigUtil;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.name.Rename;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;

/**
 * @Description
 * @Author xiaoyl
 * @Date 2022-03-11 13:33
 * 使用文档可参考：https://max.book118.com/html/2021/0523/6243114043003151.shtm
 */
public class ImageDealUtil {
    /**
     * @return
     * @Description 使用给定的图片生成指定大小的图片, 并输出到指定的路径
     * @Date 2022/03/11 13:40
     * @Author xiaoyl
     * @Param oldFilePath 要压缩的图片路径
     * @Param width 宽度
     * @Param height 高度
     * @Param thumbnailPath 缩略图存放目录
     */
    public static void GenerateFixedSizeImage(String oldFilePath, int width, int height, String thumbnailPath) throws IOException {
        File file = new File(thumbnailPath);
        if (!file.exists() && !file.isDirectory()) {
            file.mkdir();
        }
        Thumbnails.of(oldFilePath).size(width, height).keepAspectRatio(false).toFiles(file, Rename.NO_CHANGE);//指定的目录一定要存在,否则报错
//            Thumbnails.of(oldFilePath).
//                    scale(0.5).// 图片缩放80%, 不能和size()一起使用
//                    outputQuality(0.2).// 图片质量压缩80%
//                    toFiles(new File(thumbnailPath), Rename.NO_CHANGE);//指定的目录一定要存在,否则报错

    }

    /**
     * @return
     * @Description 将指定目录下所有图片生成缩略图
     * @Date 2022/03/14 14:39
     * @Author xiaoyl
     * @Param oldFilePath 要压缩的图片目录
     * @Param width 宽度
     * @Param height 高度
     * @Param thumbnailPath 缩略图存放目录
     */
    public static void GenerateDirectoryThumbnail(String oldFilePath, int width, int height, String thumbnailPath) throws IOException {
        File file = new File(thumbnailPath);
        if (!file.exists() && !file.isDirectory()) {
            file.mkdir();
        }
        Thumbnails.of(new File(oldFilePath).listFiles()).
                size(width, height).keepAspectRatio(false).//keepAspectRatio:是否保持纵横比 true、/false
                toFiles(new File(thumbnailPath), Rename.NO_CHANGE);//指定的目录一定要存在,否则报错
    }


    /**
     * @return
     * @Description 将指定图片进行压缩到指定目录下
     * @Date 2022/03/14 14:39
     * @Author xiaoyl
     * @Param size 要压缩的图片目录
     * @Param thumbnailPath 缩略图存放目录
     */
    public static void GenerateDirectoryThumbnail(String oldFilePath, double size, String thumbnailPath) throws IOException {
        File file = new File(thumbnailPath);
        if (!file.exists() && !file.isDirectory()) {
            file.mkdir();
        }
        Thumbnails.of(new File(oldFilePath))
                .scale(size)//压缩大小
                //.outputQuality(1f)//压缩质量
                .toFiles(new File(thumbnailPath), Rename.NO_CHANGE);//指定的目录一定要存在,否则报错
    }

    /**
     * @return
     * @Description 传入文件名称，校验文件是否为图片
     * @Date 2022/03/17 11:37
     * @Author xiaoyl
     * @Param
     */
    public static boolean checkIsImage(String fileName) {
        Boolean isImage = false;
        JSONObject object = SystemConfigUtil.OTHER_CONFIG.getJSONObject("system_config");
        //生成缩略图的格式，默认为jpeg,jpg,png，有系统参数imageType则从系统参数中获取
        String imageType = "jpeg,jpg,png";
        if (object.getJSONArray("imageType") != null) {
            imageType = object.getJSONArray("imageType").toJSONString();
        }
        String ext = FilenameUtils.getExtension(fileName);
        if (StringUtils.isNotBlank(ext) && imageType.indexOf(ext) > -1) {
            isImage = true;
        }
        return isImage;
    }

    /**
     * 通过读取文件并获取其width及height的方式，来判断判断当前文件是否图片，是图片的话返回宽x高。
     *
     * @param imageFile
     * @return
     */
    public static String getImageSize(InputStream imageFile) {
        BufferedImage img = null;
        try {
            img = ImageIO.read(imageFile);
            if (img == null || img.getWidth(null) <= 0 || img.getHeight(null) <= 0) {
                return "";
            }
            return img.getWidth() + "x" + img.getHeight();
        } catch (Exception e) {
            return "";
        } finally {
            img = null;
        }
    }


    /**
     * 压缩图片byte[]
     *
     * @param photo  图片的byte数组
     * @param width  压缩宽度
     * @param height 压缩高度
     * @return byte[]
     */
    public byte[] getCompressImage(byte[] photo, int width, int height) {
        ByteArrayInputStream in = new ByteArrayInputStream(photo);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            BufferedImage bi = ImageIO.read(in);
            bi = Thumbnails.of(bi).size(120, 120).asBufferedImage();
            ImageIO.write(bi, "png", baos);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return baos.toByteArray();
    }

    public static void main(String[] args) throws Exception {
//        ImageDealUtil.GenerateFixedSizeImage("D:\\resources\\dykjfw\\files\\Enforce\\2c922ba27a4b27f1017a5acd01e5570e.jpg",80,80,"D:\\resources\\dykjfw\\files\\new_Enforce");
        //String result = ImageDealUtil.getImageSize(new FileInputStream("E:\\resources\\dykjfw\\files\\Enforce\\402891f57f867ef2017f868227550003.jpg"));
        //System.out.println("图片宽高为：" + result);
        GenerateDirectoryThumbnail("E:\\resources\\dykjfw\\files\\Enforce\\402891f57f8c2fda017f8c2fe7260004_copy.png", 0.5f, "E:\\resources\\dykjfw\\files\\Enforce\\xxoo\\");
    }
}
