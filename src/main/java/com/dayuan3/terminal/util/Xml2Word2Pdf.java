package com.dayuan3.terminal.util;

import com.aspose.cells.License;
import com.aspose.words.Document;
import com.aspose.words.SaveFormat;
import com.dayuan.exception.MyException;
import com.dayuan.util.StringUtil;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateNotFoundException;
import org.apache.commons.codec.binary.Base64;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Hashtable;
import java.util.Map;

/**
 * Author: shit
 * Date: 2020-01-14 13:12
 * Content: xml->word->pdf (通过freemarker把通过word生成的xml模板动态添加数据并生成word文档,通过aspose.word把word文档转为pdf文档)
 * Description: aspose.word需付费购买,目前使用破解版
 * otherDescription:需要引入freemarker的jar和aspose-words-jdk16-16.4.0.jar
 * 其他方式:听说使用Python的pdfkit更为方便好用,效果更佳;
 */
public class Xml2Word2Pdf {

    private static Configuration configuration = null;

    /**
     * 初始化配置并设置默认编码UTF-8
     */
    static {
        configuration = new Configuration();
        configuration.setDefaultEncoding("UTF-8");
    }

    /**
     * 通过模板文件创建word文档(模板文件的格式可到网站进行在线格式化,网址推荐:https://tool.oschina.net/codeformat/xml/)
     *
     * @param templateFilePath 模板文件路径(完整路径,不包含文件如:E:/workSpace/SpringBootDemo/templates)
     * @param tpmplateFileName 模板文件名称
     * @param outFilePath      输出文件路径(完整路径,包含文件名称 如:E:/workSpace/SpringBootDemo/templates/report.doc)
     */
    public static void createWord(String templateFilePath, String tpmplateFileName, String outFilePath, Map<String, Object> dataMap)throws Exception {
        //需要对模板文件和生成后文件的地址进行校验（不做路径校验，如果同时创建多分，岂不是重复校验，所以调用前请自行校验路径是否存在）
        try {
            //如果不传模板文件路径就默认取resources下的templates文件夹中的模板文件
            if (StringUtil.isEmpty(templateFilePath)) {
                configuration.setClassForTemplateLoading(Xml2Word2Pdf.class, "/templates");
            } else {
                String projectPath = Xml2Word2Pdf.class.getResource("/").getPath().replaceFirst("/", "").replaceAll("WEB-INF/classes/", "");
                //String projectPath = "D:\\dykjfw\\src\\main\\webapp\\";//测试使用 TODO 提交的时候注释掉
                templateFilePath = projectPath.replaceAll("%20", " ") + templateFilePath;
                configuration.setDirectoryForTemplateLoading(new File(templateFilePath)); // XML文件所存在的位置
            }
            //获取文档XML模板
            Template template = configuration.getTemplate(tpmplateFileName);
            //设置输出文件位置和文件名
            File outFile = new File(outFilePath);
            Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "UTF-8"));
            template.process(dataMap, out);
            out.close();
        } catch (TemplateNotFoundException te) {
            te.printStackTrace();
            throw new MyException("找不到模板文件"+tpmplateFileName);
        } catch (Exception e) {
            e.printStackTrace();
            throw new MyException("文档生成失败！");
        }

    }

    /**
     * 验证aspose.word组件是否授权：无授权的文件有水印标记
     */
    public static boolean getLicense() {
        boolean result = false;
        try {
            InputStream is = Xml2Word2Pdf.class.getClassLoader().getResourceAsStream("\\license.xml");
            License aposeLic = new License();
            aposeLic.setLicense(is);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    /**
     * 使用aspose.word把word文档转为pdf文档
     *
     * @param sourceFile word文档绝对路径(如:E:/pdf/report.doc)
     * @param destFile   pdf文档绝对路径(如:E:/pdf/report.pdf)
     */
    public static String word2Pdf(String sourceFile, String destFile) throws Exception {
        //此处也需要对路径和文件进行校验（不做路径校验，如果同时创建多分，岂不是重复校验，所以调用前请自行校验路径是否存在）
        destFile = StringUtil.isEmpty(destFile) ? sourceFile.replace(".doc", ".pdf") : destFile;
        // 验证License 若不验证则转化出的pdf文档会有水印产生
        if (!getLicense()) {
            throw new MyException("生成PDF文档,验证License失败!");
        }
        try {
            File file = new File(destFile);  //新建一个空白pdf文档
            FileOutputStream os = new FileOutputStream(file);
            Document doc = new Document(sourceFile);//通过sourceFile创建word文档对象
            doc.save(os, SaveFormat.PDF);//全面支持DOC, DOCX, OOXML, RTF HTML, OpenDocument, PDF, EPUB, XPS, SWF 相互转换
            os.close();
            //生成pdf后删除word文件 TOOD 先注释
            File delFile = new File(sourceFile);
            if (delFile.exists()) {
                delFile.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new MyException("生成PDF文档失败!");
        }
        return destFile;
    }


    /**
     * 图片转base64编码
     *
     * @param imgFilePath 图片路径
     * @return 返回base64编码字符串
     */
    public static String img2Base64(String imgFilePath) {
        InputStream in = null;
        byte[] data = null;
        try {
            File file = new File(imgFilePath);
            if (file.exists()) {
                in = new FileInputStream(imgFilePath);
                data = new byte[in.available()];
                in.read(data);
                in.close();
            } else {
                return "";
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        BASE64Encoder encoder = new BASE64Encoder();
        return encoder.encode(data);
    }

    //把String字符串转为二维码并转base64编码输出
    public static String str2Base64(String str) {
        try {
            BufferedImage image = generateQrcode(0, str, 200, 200);
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            //输出二维码图片流
            ImageIO.write(image, "png", outputStream);
            return Base64.encodeBase64String(outputStream.toByteArray());
        } catch (Exception e) {
            System.out.println("-----------------------图片转base64失败--------------------------");
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 生成二维码
     *
     * @param margin    白边宽度
     * @param qrContent
     * @param width
     * @param height
     * @return
     * @throws Exception
     */
    public static BufferedImage generateQrcode(int margin, String qrContent, int width, int height) throws Exception {
        Hashtable<EncodeHintType, Object> hints = new Hashtable<EncodeHintType, Object>();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8"); // 内容所使用字符集编码
        hints.put(EncodeHintType.MARGIN, margin); //设置白边
        BitMatrix bitMatrix = new MultiFormatWriter().encode(qrContent, BarcodeFormat.QR_CODE, width, height, hints);

        // 创建BufferedImage对象
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        // 获取Graphics2D
        Graphics2D graphics = image.createGraphics();
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, width, height);
        // 画图
        graphics.setColor(Color.BLACK);
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                if (bitMatrix.get(i, j) == true) {
                    graphics.fillRect(i, j, 1, 1);
                }
            }
        }
        //释放对象
        graphics.dispose();

        return image;
    }

    /**
     * 简单的测试
     *
     * @remark 需要在D盘创建templates文件夹并准备相应的的xml和图片
     */
    public static void main(String[] args) throws Exception {
        /*long old = System.currentTimeMillis();
        //基本参数的定义
        String sourceFile = "D:/templates/report.doc";//生成的word文档路径和名称
        String templatePath = "D:/templates";//模板路径
        String templateName = "check_2003.xml";//模板名称
        String imagePath = "D:/templates/signature.jpg";//测试图片路径和名称
        //dataMap的赋值
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("samplingNo", "298293492SJDK");
        dataMap.put("myImage", ima2Base64(imagePath));
        //创建word文档
        createWord(templatePath, templateName, sourceFile, dataMap);
        //word文档转pdf文档
        word2Pdf(sourceFile, null);
        long now = System.currentTimeMillis();
        System.out.println("共耗时：" + ((now - old) / 1000.0) + "秒");  //转化用时*/

        //测试str转base64编码
        //System.out.println(str2Base64("http://192.168.19.222:8080/dykjfw/reportPrint/report?samplingId=126&reportNumber=&scan=1"));
    }
}
