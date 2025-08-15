package com.dayuan.util;


import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

/**
 * Author: shit
 * Date: 2019-03-19 08:51
 * Content:
 */
public class CreateImgUtil {
   /* private BufferedImage image;
    private int imageWidth = 167;  //图片的宽度
    private int imageHeight = 123; //图片的高度

    //生成图片文件
    @SuppressWarnings("restriction")
    public void createImage(String fileLocation) {
        BufferedOutputStream bos = null;
        if (image != null) {
            try {
                FileOutputStream fos = new FileOutputStream(fileLocation);
                bos = new BufferedOutputStream(fos);
                JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(bos);
                encoder.encode(image);
                bos.close();

                //引入改jdk私有jar需要配置maven windows用;号隔开 linix用:号隔开
                           <!--<compilerArguments>-->
                        <!--<verbose/>-->
                        <!--<bootclasspath>${java.home}\lib\rt.jar;${java.home}\lib\jce.har</bootclasspath>-->
                    <!--</compilerArguments>-->


            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (bos != null) {//关闭输出流
                    try {
                        bos.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    public void graphicsGeneration(String name, String path) {
        int x = imageWidth / 4;
        if (StringUtil.isNotEmpty(name)) {
            if (name.length() > 2) {
                x = imageWidth / 8;
            }
            if (name.length() > 3) {
                x = imageWidth / 100;
            }
        }
        int y = 70;
        image = new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_INT_RGB);
        //设置图片的背景色
        Graphics2D main = image.createGraphics();
        main.setColor(new Color(255, 255, 255));
        main.fillRect(0, 0, imageWidth, imageHeight);

        /*//***********************设置下面的提示框
     Graphics2D tip = image.createGraphics();
     //设置字体颜色，先设置颜色，再填充内容
     tip.setColor(Color.black);
     //设置字体
     Font titleFont = new Font("宋体", Font.BOLD, 40);
     tip.setFont(titleFont);
     tip.drawString(name, x, y);
     createImage(path);

     }*/


    /***
     * 创建缩略图（压缩图片）
     * @throws InterruptedException
     * @throws IOException
     */
  /*  public static String reduceImg(String imgsrc) {
        imgsrc = "D:\\bb.png";
        String imagePath = "D:\\cc.png";
        int widthdist = 120;          //自定义压缩
        int heightdist = 90;
        Float rate = 0.0f;          //按原图片比例压缩（默认）
        try {
            File srcfile = new File(imgsrc);
            // 检查图片文件是否存在
            if (!srcfile.exists()) {
                System.out.println("文件不存在");
            }
            // 如果比例不为空则说明是按比例压缩
            if (rate != null && rate > 0) {
                //获得源图片的宽高存入数组中
                int[] results = getImgWidthHeight(srcfile);
                if (results == null || results[0] == 0 || results[1] == 0) {
                    return null;
                } else {
                    //按比例缩放或扩大图片大小，将浮点型转为整型
                    widthdist = (int) (results[0] * rate);
                    heightdist = (int) (results[1] * rate);
                }
            }
            // 开始读取文件并进行压缩
            Image src = ImageIO.read(srcfile);
            // 构造一个类型为预定义图像类型之一的 BufferedImage
            BufferedImage tag = new BufferedImage((int) widthdist, (int) heightdist, BufferedImage.TYPE_INT_RGB);
            //绘制图像  getScaledInstance表示创建此图像的缩放版本，返回一个新的缩放版本Image,按指定的width,height呈现图像
            //Image.SCALE_SMOOTH,选择图像平滑度比缩放速度具有更高优先级的图像缩放算法。
            tag.getGraphics().drawImage(src.getScaledInstance(widthdist, heightdist, Image.SCALE_SMOOTH), 0, 0, null);
            //创建文件输出流
            FileOutputStream out = new FileOutputStream(imagePath);
            //将图片按JPEG压缩，保存到out中
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            encoder.encode(tag);
            //关闭文件输出流
            out.close();
            return imagePath;
        } catch (Exception ef) {
            ef.printStackTrace();
        }
        return null;
    }
*/

 /*   */

    /**
     * 获取图片宽度和高度
     *
     * @param
     * @return 返回图片的宽度
     *//*
    public static int[] getImgWidthHeight(File file) {
        InputStream is = null;
        BufferedImage src = null;
        int result[] = {0, 0};
        try {
            // 获得文件输入流
            is = new FileInputStream(file);
            // 从流里将图片写入缓冲图片区
            src = ImageIO.read(is);
            result[0] = src.getWidth(null); // 得到源图片宽
            result[1] = src.getHeight(null);// 得到源图片高
            is.close();  //关闭输入流
        } catch (Exception ef) {
            ef.printStackTrace();
        }

        return result;
    }*/
    public static void createImage(String path, String name) throws Exception {
        File file = new File(path);
        Font font = new Font("宋体", Font.BOLD, 38);//设置字体大小
        BufferedImage bi = new BufferedImage(167, 123, BufferedImage.TYPE_INT_RGB);//设置图片宽高
        Graphics2D g2 = (Graphics2D) bi.getGraphics();
        g2.setBackground(Color.WHITE);//WHITE
        g2.clearRect(0, 0, 200, 200);//清空给定矩形内的指定像素
        g2.setPaint(Color.BLACK);
        g2.setFont(font);
        FontRenderContext context = g2.getFontRenderContext();
        Rectangle2D bounds = font.getStringBounds(name, context);
        double x = (167 - bounds.getWidth()) / 2;
        double y = (123 - bounds.getHeight()) / 2;
        double ascent = -bounds.getY();
        double baseY = y + ascent;
        g2.drawString(name, (int) x, (int) baseY);
        ImageIO.write(bi, "jpg", file);
    }

    public static void main(String[] args) throws Exception {
        createImage("D:/abcd.jpg", "张正挑哪");
    }

}
