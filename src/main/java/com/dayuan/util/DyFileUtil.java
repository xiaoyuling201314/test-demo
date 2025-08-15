package com.dayuan.util;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.serializer.ValueFilter;
import com.dayuan.common.WebConstant;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.FrameGrabber;
import org.bytedeco.javacv.Java2DFrameConverter;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

/**
 * 工具类
 * Description:
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月23日
 */
public class DyFileUtil {

    private static final Logger logger = Logger.getLogger(DyFileUtil.class);

    public static String getrealPath(HttpServletRequest request, String root) {
        String realPath = request.getRealPath("\\") + root;
        createFolder(realPath);
        return realPath;
    }

    /**
     * 新建目录(file.mkdirs()可创建多级目录)
     *
     * @param folderPath 目录
     */
    public static int createFolder(String folderPath) {
        String txt = folderPath;
        int state = 0;
        try {
            File myFilePath = new File(txt);
            txt = folderPath;
            if (!myFilePath.exists()) {
                myFilePath.mkdirs();
            }
            return state;
        } catch (Exception e) {
            state = -1;
            e.printStackTrace();
        }
        return state;
    }

    /**
     * 获取文件名
     *
     * @param filePath
     * @return
     */
    public static String getFileName(String filePath) {
        filePath = filePath.trim();
        return filePath.substring(filePath.lastIndexOf("/") + 1);
    }

    /**
     * 获取文件扩展名
     *
     * @param filePath
     * @return
     */
    public static String getFileExtension(String filePath) {
        filePath = filePath.trim();
        return filePath.substring(filePath.lastIndexOf("."));
    }

    /**
     * 获取文件扩展名
     *
     * @param file
     * @return
     */
    public static String getFileExtension(File file) {
        return file.getName().substring(file.getName().lastIndexOf("."));
    }

    /**
     * 保存文件
     *
     * @param file
     * @param outputFilePath 输出文件的绝对路径
     */
    public static void saveFile(File file, String outputFilePath) {
        try {
            saveFile(new FileInputStream(file), outputFilePath);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    /**
     * 保存文件
     *
     * @param file
     * @param outputFilePath 输出文件的绝对路径
     */
    public static void saveFile(MultipartFile file, String outputFilePath) {
        try {
            saveFile(file.getInputStream(), outputFilePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 保存文件
     *
     * @param inputStream
     * @param outputFilePath 输出文件的绝对路径
     */
    public static void saveFile(InputStream inputStream, String outputFilePath) {
        try {
            File file = new File(outputFilePath);
            if (!file.exists()) {
                file.getParentFile().mkdirs();
            }

            byte[] bs = new byte[1024];
            int len;
            FileOutputStream os = new FileOutputStream(file);
            while ((len = inputStream.read(bs)) != -1) {
                os.write(bs, 0, len);
            }
            os.flush();
            os.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 写入JSON数据
     *
     * @param object         JSON
     * @param outputFilePath 输出文件的绝对路径
     * @throws IOException
     */
    public static void writeToJSON(Object object, String outputFilePath) throws IOException {
        File file = new File(outputFilePath);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
        }
        BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), StandardCharsets.UTF_8));
        out.write(JSONObject.toJSONString(object, new ValueFilter() {
            @Override
            public Object process(Object object, String name, Object value) {
                if (value == null) return "";
                return value;
            }
        }, SerializerFeature.WriteDateUseDateFormat, SerializerFeature.WriteNullListAsEmpty));
        out.flush();
        out.close();
    }

    /**
     * 文件下载方法
     *
     * @param fileName       文件名
     * @param outputFilePath 文件所在的绝对路径
     * @param fileName       要下载的文件名称
     * @return
     */
    @SuppressWarnings("finally")
    public static ResponseEntity<byte[]> download(HttpServletRequest request, HttpServletResponse response, String outputFilePath,
                                                  String fileName) {

        System.out.println(outputFilePath);
        System.out.println(fileName);
        ResponseEntity<byte[]> responseEntity = null;
        String dfileName = "";
        HttpHeaders headers = new HttpHeaders();
        try {
            dfileName = URLEncoder.encode(fileName, "UTF-8");

            File file = new File(outputFilePath + File.separator + fileName);// 文件绝对路径
            if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {
                headers.add("Content-disposition", "attachment; filename=\"" + dfileName + "\"");
                responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);// HttpStatus.CREATED
            } else {
                headers.setContentDispositionFormData("attachment", dfileName);
                headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
                responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);// HttpStatus.CREATED
            }

        } catch (UnsupportedEncodingException e) {
            logger.error("文件下载异常====================" + e.getMessage());
        } catch (IOException e) {
            logger.error("文件下载异常====================" + e.getMessage());
        } finally {
            return responseEntity;
        }

    }

    @SuppressWarnings("finally")
    public static ResponseEntity<byte[]> download2(HttpServletRequest request, HttpServletResponse response, String outputFilePath,
                                                   String fileName, String filename) {
        System.out.println(outputFilePath);
        System.out.println(fileName);
        ResponseEntity<byte[]> responseEntity = null;
        HttpHeaders headers = new HttpHeaders();
        try {
            // 转码，免得文件名中文乱码
            filename = URLEncoder.encode(filename, "UTF-8") + ".doc";
            File file = new File(outputFilePath + File.separator + fileName);// 文件绝对路径
            if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {
                headers.add("Content-disposition", "attachment; filename=\"" + filename + "\"");
                responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);// HttpStatus.CREATED
            } else {
                headers.add("Content-Disposition", "attachment; filename=" + filename);
                responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);// HttpStatus.CREATED
            }
        } catch (UnsupportedEncodingException e) {
            logger.error("文件下载异常====================" + e.getMessage());
        } catch (IOException e) {
            logger.error("文件下载异常====================" + e.getMessage());
        } finally {
            return responseEntity;
        }

    }


    /**
     * 验证字符串是否为正确路径名的正则表达式
     */
    private static final String matches = "[A-Za-z]:[\\+|/+][^:?\"><*]*";

    /**
     * 通过 sPath.matches(matches) 方法的返回值判断是否正确
     * sPath 为上传的文件路径字符串
     */
    static boolean flag = false;

    /**
     * 文件
     */
    static File file;

    /**
     * 根据路径删除指定的目录或文件，无论存在与否
     *
     * @param deletePath
     * @return
     */
    public static boolean deleteFolder(String deletePath) {
        flag = false;
        if (deletePath.matches(matches)) {
            file = new File(deletePath);
            // 判断目录或文件是否存在
            if (!file.exists()) {
                // 不存在返回 false
                return flag;
            } else {
                // 判断是否为文件
                if (file.isFile()) {
                    // 为文件时调用删除文件方法
                    return deleteFile(deletePath);
                } else {
                    // 为目录时调用删除目录方法
                    return deleteDirectory(deletePath);
                }
            }
        } else {
            System.out.println("要传入正确路径！");
            return false;
        }
    }

    /**
     * 删除单个文件
     *
     * @param filePath 文件路径
     * @return
     */
    private static boolean deleteFile(String filePath) {
        flag = false;
        file = new File(filePath);
        // 路径为文件且不为空则进行删除
        if (file.isFile() && file.exists()) {
            file.delete();// 文件删除
            flag = true;
        }
        return flag;
    }

    /**
     * 删除目录（文件夹）以及目录下的文件
     *
     * @param dirPath
     * @return
     */
    private static boolean deleteDirectory(String dirPath) {
        // 如果sPath不以文件分隔符结尾，自动添加文件分隔符
        if (!dirPath.endsWith(File.separator)) {
            dirPath = dirPath + File.separator;
        }
        File dirFile = new File(dirPath);
        // 如果dir对应的文件不存在，或者不是一个目录，则退出
        if (!dirFile.exists() || !dirFile.isDirectory()) {
            return false;
        }
        flag = true;
        // 获得传入路径下的所有文件
        File[] files = dirFile.listFiles();
        // 循环遍历删除文件夹下的所有文件(包括子目录)
        if (files != null) {
            for (File file1 : files) {
                if (file1.isFile()) {
                    // 删除子文件
                    flag = deleteFile(file1.getAbsolutePath());
                    System.out.println(file1.getAbsolutePath() + " 删除成功");
                    if (!flag) {
                        break;// 如果删除失败，则跳出
                    }
                } else {// 运用递归，删除子目录
                    flag = deleteDirectory(file1.getAbsolutePath());
                    if (!flag) {
                        break;// 如果删除失败，则跳出
                    }
                }
            }
        }

        if (!flag) {
            return false;
        }
        // 删除当前目录
        return dirFile.delete();
    }

    /**
     * 创建单个文件
     *
     * @param filePath 文件所存放的路径
     * @return
     */
    public static boolean createFile(String filePath) {
        File file = new File(filePath);
        if (file.exists()) {// 判断文件是否存在
            System.out.println("目标文件已存在" + filePath);
            return false;
        }
        if (filePath.endsWith(File.separator)) {// 判断文件是否为目录
            System.out.println("目标文件不能为目录！");
            return false;
        }
        if (!file.getParentFile().exists()) {// 判断目标文件所在的目录是否存在
            // 如果目标文件所在的文件夹不存在，则创建父文件夹
            System.out.println("目标文件所在目录不存在，准备创建它！");
            if (!file.getParentFile().mkdirs()) {// 判断创建目录是否成功
                System.out.println("创建目标文件所在的目录失败！");
                return false;
            }
        }
        try {
            if (file.createNewFile()) {// 创建目标文件
                System.out.println("创建文件成功:" + filePath);
                return true;
            } else {
                System.out.println("创建文件失败！");
                return false;
            }
        } catch (IOException e) {// 捕获异常
            e.printStackTrace();
            System.out.println("创建文件失败！" + e.getMessage());
            return false;
        }
    }

    /**
     * 创建目录(如果目录存在就删掉目录)
     *
     * @param destDirName 目标目录路径
     * @return
     */
    public static boolean createDir(String destDirName) {
        File dir = new File(destDirName);
        if (dir.exists()) {// 判断目录是否存在
            System.out.println("目标目录已存在!");
            //return false;
            return deleteDirectory(destDirName);
        }
        System.out.println("已删除原目录并重新创建!");
        if (!destDirName.endsWith(File.separator)) {// 结尾是否以"/"结束
            destDirName = destDirName + File.separator;
        }
        if (dir.mkdirs()) {// 创建目标目录
            System.out.println("创建目录成功！" + destDirName);
            return true;
        } else {
            System.out.println("创建目录失败！");
            return false;
        }
    }

    /**
     * 创建临时文件
     *
     * @param prefix  前缀字符串定义的文件名;必须至少有三个字符长
     * @param suffix  后缀字符串定义文件的扩展名;如果为null后缀".tmp" 将被使用
     * @param dirName 该目录中的文件被创建。对于默认的临时文件目录nullis来传递
     * @return 一个抽象路径名新创建的空文件。
     * @throws IllegalArgumentException -- 如果前缀参数包含少于三个字符
     * @throws IOException              -- 如果文件创建失败
     * @throws SecurityException        -- 如果SecurityManager.checkWrite(java.lang.String)方法不允许创建一个文件
     */
    public static String createTempFile(String prefix, String suffix, String dirName) {
        File tempFile = null;
        if (dirName == null) {// 目录如果为空
            try {
                tempFile = File.createTempFile(prefix, suffix);// 在默认文件夹下创建临时文件
                return tempFile.getCanonicalPath();// 返回临时文件的路径
            } catch (IOException e) {// 捕获异常
                e.printStackTrace();
                System.out.println("创建临时文件失败：" + e.getMessage());
                return null;
            }
        } else {
            // 指定目录存在
            File dir = new File(dirName);// 创建目录
            if (!dir.exists()) {
                // 如果目录不存在则创建目录
                if (createDir(dirName)) {
                    System.out.println("创建临时文件失败，不能创建临时文件所在的目录！");
                    return null;
                }
            }
            try {
                tempFile = File.createTempFile(prefix, suffix, dir);// 在指定目录下创建临时文件
                return tempFile.getCanonicalPath();// 返回临时文件的路径
            } catch (IOException e) {// 捕获异常
                e.printStackTrace();
                System.out.println("创建临时文件失败!" + e.getMessage());
                return null;
            }
        }
    }

    /**
     * 文件上传
     *
     * @param filePath 文件上传根路径
     * @param file     文件
     * @param reName   重命名
     * @return 文件名
     * @throws IOException
     * @author shit
     */
    public static String uploadFile(String filePath, MultipartFile file, String reName) throws IOException {
        String path = WebConstant.res.getString("resources") + filePath;
        File myFilePath = new File(path);
        if (!myFilePath.exists()) {
            myFilePath.mkdirs();
        }
        // reName为空时表示不对文件重命名
        String fileName = reName == null ? file.getOriginalFilename() : reName;
        if (!StringUtil.isEmpty(fileName)) {
            FileOutputStream fos = null;
            fos = FileUtils.openOutputStream(new File(path + fileName));
            IOUtils.copy(file.getInputStream(), fos);
            fos.close();
            return fileName;
        }
        return null;
    }

    /**
     * 文件上传
     *
     * @param filePath 文件上传根路径
     * @param file     文件
     * @return 文件名
     * @throws IOException
     */
    public static void uploadFile(String filePath, MultipartFile file) throws IOException {
        String path = WebConstant.res.getString("resources") + filePath;
        File myFilePath = new File(path);
        if (!myFilePath.getParentFile().exists()) {
            myFilePath.mkdir();
        }
        // reName为空时表示不对文件重命名
        if (!StringUtil.isEmpty(filePath)) {
            FileOutputStream fos = null;
            fos = FileUtils.openOutputStream(new File(path));
            IOUtils.copy(file.getInputStream(), fos);
            fos.close();
        }
    }

    /**
     * 下载文件
     *
     * @param url
     * @param filePath
     */
    public static boolean downloadFile(String url, String filePath) {
        Date start = new Date();
        //System.out.println("-----------------------下载开始   ---------------------------"+ start);
        boolean down = true;
        CloseableHttpClient httpclient = HttpClients.createDefault();
        try {

            HttpGet httpGet = new HttpGet(url);
            CloseableHttpResponse response1 = httpclient.execute(httpGet);
            try {
                //System.out.println(response1.getStatusLine());
                HttpEntity httpEntity = response1.getEntity();
                long contentLength = httpEntity.getContentLength();
                InputStream is = httpEntity.getContent();
                // 根据InputStream 下载文件
                ByteArrayOutputStream output = new ByteArrayOutputStream();
                File file = new File(filePath);
                if (!file.exists()) {
                    file.getParentFile().mkdirs();
                }
                byte[] buffer = new byte[4096];
                int r = 0;
                while ((r = is.read(buffer)) > 0) {
                    output.write(buffer, 0, r);
                }

                FileOutputStream fos = new FileOutputStream(filePath);
                output.writeTo(fos);
                output.flush();


                output.close();
                fos.close();
                EntityUtils.consume(httpEntity);
            } finally {
                response1.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println(e.getMessage());
            down = false;
        } finally {
            try {
                Date end1 = new Date();
                //System.out.println("-----------------------下载结束---------------------------"+  end1);
                System.err.println("本次下载时间：" + DateUtil.getBetweenTime(start, end1));
                httpclient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return down;
    }

    /***
     * 获取指定目录下的所有的文件（不包括文件夹），采用了递归
     *
     * @param obj file OR path
     * @return
     */
    public static ArrayList<File> getListFiles(Object obj) {
        File directory = null;
        if (obj instanceof File) {
            directory = (File) obj;
        } else {
            directory = new File(obj.toString());
        }
        ArrayList<File> files = new ArrayList<File>();
        if (directory.isFile()) {
            files.add(directory);
            return files;
        } else if (directory.isDirectory()) {
            File[] fileArr = directory.listFiles();
            for (int i = 0; i < fileArr.length; i++) {
                File fileOne = fileArr[i];
                files.addAll(getListFiles(fileOne));
            }
        }
        return files;
    }


    /**
     * 截取视频第六帧的图片
     *
     * @param filePath 视频路径
     * @param dir      文件存放的根目录（传递的值为空就返回base64,否则返回文件路径）
     * @return 图片的相对路径 例：1.png
     */
    public static String videoImage(String filePath, String dir, String pngPath) {
        File sourceFile = new File(filePath);
        if (!sourceFile.exists()) {
            logger.error("生成视频图片失败,视频文件不存在====================");
            return "";
        }

        if (StringUtil.isNotEmpty(dir) && StringUtil.isNotEmpty(pngPath)) {
            File file = new File(dir + pngPath);
            if (file.exists()) {
                return pngPath;
            }
        }

        String base64 = null;
        try {
            FFmpegFrameGrabber ff = FFmpegFrameGrabber.createDefault(filePath);
            ff.start();
            int ffLength = ff.getLengthInFrames();
            Frame f;
            int i = 0;
            while (i < ffLength) {
                f = ff.grabImage();
                //截取第6帧
                if ((i > 5) && (f.image != null)) {
                    //生成图片的相对路径 例如：uuid.png
                    pngPath = StringUtil.isEmpty(pngPath) ? getPngPath() : pngPath;
                    //执行截图并放入指定位置
                    String targerFilePath = StringUtil.isEmpty(dir) ? "" : dir + pngPath;
                    base64 = doExecuteFrame(f, targerFilePath);
                    break;
                }
                i++;
            }
            ff.stop();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("生成视频图片失败====================" + e.getMessage());
            return "";
        }
        return base64 == null ? pngPath : base64;
    }

    /**
     * 生成图片的相对路径
     *
     * @return 图片的相对路径 例：1.png
     */
    private static String getPngPath() {
        return getUUID() + ".png";
    }


    /**
     * 生成唯一的uuid
     *
     * @return uuid
     */
    private static String getUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }


    /**
     * 截取缩略图
     *
     * @param f                       Frame
     * @param targerFilePath:封面图片存放路径
     */
    private static String doExecuteFrame(Frame f, String targerFilePath) {
        String png_base64 = null;
        if (null == f || null == f.image) {
            return null;
        }
        try {
            Java2DFrameConverter converter = new Java2DFrameConverter();
            BufferedImage bi = converter.getBufferedImage(f);
            bi = Thumbnails.of(bi).size(100, 100).asBufferedImage();
            if (StringUtil.isEmpty(targerFilePath)) {
                ByteArrayOutputStream baos = new ByteArrayOutputStream();//io流
                ImageIO.write(bi, "png", baos);//写入流中
                byte[] bytes = baos.toByteArray();//转换成字节
                BASE64Encoder encoder = new BASE64Encoder();
                png_base64 = encoder.encodeBuffer(bytes).trim();//转换成base64串
                png_base64 = png_base64.replaceAll("\n", "").replaceAll("\r", "");//删除 \r\n
            } else {
                ImageIO.write(bi, "png", new File(targerFilePath));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return png_base64;
    }

}
