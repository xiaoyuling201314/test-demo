package com.dayuan.util;

import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import org.apache.commons.codec.binary.Base64;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.geom.RoundRectangle2D;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

public class QrcodeUtil {
    private static final int BLACK = 0xFF000000;
    private static final int WHITE = 0xFFFFFFFF;

    // 二维码图片宽度
    public static final int QRCODE_WIDTH = 150;
    // 二维码图片高度
    public static final int QRCODE_HEIGHT = 150;

    private QrcodeUtil() {
    }

    public static BufferedImage toBufferedImage(BitMatrix matrix) {
        int width = matrix.getWidth();
        int height = matrix.getHeight();
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                image.setRGB(x, y, matrix.get(x, y) ? BLACK : WHITE);
            }
        }
        return image;
    }

    public static void writeToFile(BitMatrix matrix, String format, File file) throws IOException {
        BufferedImage image = toBufferedImage(matrix);
        if (!ImageIO.write(image, format, file)) {
            throw new IOException("Could not write an image of format " + format + " to " + file);
        }
    }

    public static void writeToStream(BitMatrix matrix, String format, OutputStream stream) throws IOException {
        BufferedImage image = toBufferedImage(matrix);
        if (!ImageIO.write(image, format, stream)) {
            throw new IOException("Could not write an image of format " + format);
        }
    }

    /**
     * 生成并保存二维码
     *
     * @param request
     * @param qrName
     * @param qrContent
     * @param rootPath
     * @throws Exception
     */
    public static void generateSamplingQrcode(HttpServletRequest request, String qrName, String qrContent, String rootPath) throws Exception {
        String format = "png";// 二维码的图片格式
        Hashtable<EncodeHintType, String> hints = new Hashtable<EncodeHintType, String>();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8"); // 内容所使用字符集编码

        BitMatrix bitMatrix = new MultiFormatWriter().encode(qrContent, BarcodeFormat.QR_CODE, QRCODE_WIDTH, QRCODE_HEIGHT, hints);
        // 生成二维码
        File outputFile = new File(rootPath + qrName);
        if (!outputFile.exists()) {
            outputFile.mkdirs();
        }
        MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
    }

    /**
     * 生成二维码
     *
     * @param qrContent
     * @param width
     * @param height
     * @return
     * @throws Exception
     * @author Dz
     */
    public static BufferedImage generateQrcode(String qrContent, int width, int height) throws Exception {

        Hashtable<EncodeHintType, String> hints = new Hashtable<EncodeHintType, String>();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8"); // 内容所使用字符集编码

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
     * 生成二维码
     *
     * @param qrContent 二维码内容
     * @param width     宽度
     * @param height    高度
     * @param margin    边缘
     * @return
     * @throws Exception
     * @author Dz
     */
    public static BufferedImage generateQrcode(String qrContent, int width, int height, int margin) throws Exception {

        Hashtable<EncodeHintType, Object> hints = new Hashtable<>();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8"); // 内容所使用字符集编码
        hints.put(EncodeHintType.MARGIN, margin);

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
     * 生成logo二维码
     *
     * @param qrContext 二维码内容
     * @param qrPath    保存二维码的文件路径
     * @param qrW       二维码宽度
     * @param qrH       二维码高度
     * @param logoPath  logo文件路径，不需要logo可以传null
     * @author Dz
     */
    public static boolean generateQrcode(String qrContext, String qrPath, int qrW, int qrH, String logoPath) {
        try {
            QRCodeWriter writer = new QRCodeWriter();

            Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
            //设置字符编码
            hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
            // 选择H档容错度，即使30%的图案被遮挡，也可以被正确扫描，这是保证之后添加LOGO图标的关键
            hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
            //设置边框
            hints.put(EncodeHintType.MARGIN, 0);

            BitMatrix matrix = writer.encode(qrContext, BarcodeFormat.QR_CODE, qrW, qrH, hints);
            BufferedImage qrImg = MatrixToImageWriter.toBufferedImage(matrix);

            //不能直接使用二维码的BufferedImage对象,否则logo变灰
            BufferedImage bg = new BufferedImage(qrW, qrH, BufferedImage.TYPE_INT_BGR);
            Graphics2D g = bg.createGraphics();

            //画二维码
            g.drawImage(qrImg, 0, 0, qrW, qrH, null);

            //画logo
            if (logoPath != null && !"".equals(logoPath)) {
                File logo = new File(logoPath);
                if (logo.exists()) {
                    BufferedImage logoImg = ImageIO.read(logo);
                    logoImg = setRadius(logoImg, 10, 2, 4);

                    int logoW = qrW * 3 / 10;
                    int logoH = qrH * 3 / 10;
                    int logoX = (qrW - logoW) / 2;
                    int logoY = (qrH - logoH) / 2;

                    //缩小LOGO
                    logoImg = reduceImage(logoImg, logoW, logoH);

                    g.setColor(Color.WHITE);
                    g.setStroke(new BasicStroke(2));
                    g.fillRect(logoX, logoY, logoW, logoH);
                    g.drawImage(logoImg, logoX, logoY, logoW, logoH, null);
                }
            }
            g.dispose();
            bg.flush();

            ImageIO.write(bg, qrPath.substring(qrPath.lastIndexOf(".") + 1), new File(qrPath));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 生成logo二维码
     *
     * @param qrContext 二维码内容
     * @param qrPath    保存二维码的文件路径
     * @param qrW       二维码宽度
     * @param qrH       二维码高度
     * @param imgStr    logo图片base64，不需要logo可以传null
     * @author Dz
     */
    public static boolean generateQrcode2(String qrContext, String qrPath, int qrW, int qrH, String imgStr) {
        try {
            QRCodeWriter writer = new QRCodeWriter();

            Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
            //设置字符编码
            hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
            //选择H档容错度，即使30%的图案被遮挡，也可以被正确扫描，这是保证之后添加LOGO图标的关键
            hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
            //设置边框
            hints.put(EncodeHintType.MARGIN, 0);

            BitMatrix matrix = writer.encode(qrContext, BarcodeFormat.QR_CODE, qrW, qrH, hints);
            BufferedImage qrImg = MatrixToImageWriter.toBufferedImage(matrix);

            //不能直接使用二维码的BufferedImage对象,否则logo变灰
            BufferedImage bg = new BufferedImage(qrW, qrH, BufferedImage.TYPE_INT_BGR);
            Graphics2D g = bg.createGraphics();

            //画二维码
            g.drawImage(qrImg, 0, 0, qrW, qrH, null);

            //画logo
            if (imgStr != null && !"".equals(imgStr)) {
                Base64 decoder = new Base64();
                byte[] bytes = decoder.decode(imgStr.split(",")[1]);
                ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
                BufferedImage logoImg = ImageIO.read(bais);
                logoImg = setRadius(logoImg, 10, 2, 4);

                int logoW = qrW * 3 / 10;
                int logoH = qrH * 3 / 10;
                int logoX = (qrW - logoW) / 2;
                int logoY = (qrH - logoH) / 2;

                //缩小LOGO
                logoImg = reduceImage(logoImg, logoW, logoH);

                g.setColor(Color.WHITE);
                g.setStroke(new BasicStroke(2));
                g.fillRect(logoX, logoY, logoW, logoH);
                g.drawImage(logoImg, logoX, logoY, logoW, logoH, null);
            }
            g.dispose();
            bg.flush();

            ImageIO.write(bg, qrPath.substring(qrPath.lastIndexOf(".") + 1), new File(qrPath));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 生成logo二维码
     *
     * @param qrContext 二维码内容
     * @param qrW       二维码宽度
     * @param qrH       二维码高度
     * @param imgStr    logo图片base64，不需要logo可以传null
     * @return
     * @author Dz
     */
    public static InputStream generateQrcode3(String qrContext, int qrW, int qrH, String imgStr) {
        ByteArrayOutputStream os = null;
        InputStream is = null;
        try {
            QRCodeWriter writer = new QRCodeWriter();

            Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
            //设置字符编码
            hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
            //选择H档容错度，即使30%的图案被遮挡，也可以被正确扫描，这是保证之后添加LOGO图标的关键
            hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
            //设置边框
            hints.put(EncodeHintType.MARGIN, 0);

            BitMatrix matrix = writer.encode(qrContext, BarcodeFormat.QR_CODE, qrW, qrH, hints);
//			BufferedImage qrImg = MatrixToImageWriter.toBufferedImage(matrix);
            //去白边
            BufferedImage qrImg = deleteWhite(matrix);

            //不能直接使用二维码的BufferedImage对象,否则logo变灰
            BufferedImage bg = new BufferedImage(qrW, qrH, BufferedImage.TYPE_INT_BGR);
            Graphics2D g = bg.createGraphics();

            //画二维码
            g.drawImage(qrImg, 0, 0, qrW, qrH, null);

            //画logo
            if (imgStr != null && !"".equals(imgStr)) {
                Base64 decoder = new Base64();
                byte[] bytes = decoder.decode(imgStr.split(",")[1]);
                ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
                BufferedImage logoImg = ImageIO.read(bais);
                logoImg = setRadius(logoImg, 10, 2, 4);

                int logoW = qrW * 3 / 10;
                int logoH = qrH * 3 / 10;
                int logoX = (qrW - logoW) / 2;
                int logoY = (qrH - logoH) / 2;

                //缩小LOGO
                logoImg = reduceImage(logoImg, logoW, logoH);

                g.drawImage(logoImg, logoX, logoY, logoW, logoH, null);
            }
            g.dispose();
            bg.flush();

            os = new ByteArrayOutputStream();
            ImageIO.write(bg, "png", os);
            is = new ByteArrayInputStream(os.toByteArray());

            return is;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    public static void writeBitMatricToFile(BitMatrix bm, String format, File file) {
        BufferedImage image = toBufferedImage(bm);
        try {
            if (!ImageIO.write(image, format, file)) {
                throw new RuntimeException("Can not write an image to file" + file);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    public static void parseCode(File file) {
        try {
            MultiFormatReader formatReader = new MultiFormatReader();

            if (!file.exists()) {
                return;
            }

            BufferedImage image = ImageIO.read(file);

            LuminanceSource source = new BufferedImageLuminanceSource(image);
            Binarizer binarizer = new HybridBinarizer(source);
            BinaryBitmap binaryBitmap = new BinaryBitmap(binarizer);

            Map hints = new HashMap();
            hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");

            Result result = formatReader.decode(binaryBitmap, hints);

            System.out.println("解析结果 = " + result.toString());
            System.out.println("二维码格式类型 = " + result.getBarcodeFormat());
            System.out.println("二维码文本内容 = " + result.getText());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 生成条形码 huht 2019-8-16
     *
     * @param qrContent
     * @param width
     * @param height
     * @return
     * @throws Exception
     */
    public static BufferedImage generateQrcode2(String qrContent, int width, int height) throws Exception {

        Hashtable<EncodeHintType, String> hints = new Hashtable<EncodeHintType, String>();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8"); // 内容所使用字符集编码

        BitMatrix bitMatrix = new MultiFormatWriter().encode(qrContent, BarcodeFormat.CODE_128, width, height, hints);

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
     * 缩小图片
     *
     * @param src
     * @param new_w
     * @param new_h
     */
    public static BufferedImage reduceImage(BufferedImage src, int new_w, int new_h) {
        // 得到图片
        int old_w = src.getWidth();
        // 得到源图宽
        int old_h = src.getHeight();
        // 得到源图长
        BufferedImage newImg = null;
        // 判断输入图片的类型
        switch (src.getType()) {
            case 13:
                // png,gifnewImg = new BufferedImage(new_w, new_h,
                // BufferedImage.TYPE_4BYTE_ABGR);
                break;
            default:
                newImg = new BufferedImage(new_w, new_h, BufferedImage.TYPE_INT_RGB);
                break;
        }
        Graphics2D g = newImg.createGraphics();
        // 从原图上取颜色绘制新图
        g.drawImage(src, 0, 0, old_w, old_h, null);
        g.dispose();
        // 根据图片尺寸压缩比得到新图的尺寸
        newImg.getGraphics().drawImage(src.getScaledInstance(new_w, new_h, Image.SCALE_SMOOTH), 0, 0, null);
        // 调用方法输出图片文件
        return newImg;
    }

    /**
     * 图片设置圆角
     *
     * @param srcImage 图片
     * @param radius   圆角半径
     * @param border   边框
     * @param padding  填充
     * @return
     * @throws IOException
     */
    public static BufferedImage setRadius(BufferedImage srcImage, int radius, int border, int padding) throws IOException {
        int width = srcImage.getWidth();
        int height = srcImage.getHeight();
        int canvasWidth = width + padding * 2;
        int canvasHeight = height + padding * 2;

        BufferedImage image = new BufferedImage(canvasWidth, canvasHeight, BufferedImage.TYPE_INT_ARGB);
        Graphics2D gs = image.createGraphics();
        gs.setComposite(AlphaComposite.Src);
        gs.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        gs.setColor(Color.WHITE);
        gs.fill(new RoundRectangle2D.Float(0, 0, canvasWidth, canvasHeight, radius, radius));
        gs.setComposite(AlphaComposite.SrcAtop);
        gs.drawImage(setClip(srcImage, radius), padding, padding, null);
        if (border != 0) {
            gs.setColor(Color.GRAY);
            gs.setStroke(new BasicStroke(border));
            gs.drawRoundRect(padding, padding, canvasWidth - 2 * padding, canvasHeight - 2 * padding, radius, radius);
        }
        gs.dispose();
        return image;
    }

    /**
     * 图片切圆角
     *
     * @param srcImage
     * @param radius
     * @return
     */
    public static BufferedImage setClip(BufferedImage srcImage, int radius) {
        int width = srcImage.getWidth();
        int height = srcImage.getHeight();
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        Graphics2D gs = image.createGraphics();

        gs.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        gs.setClip(new RoundRectangle2D.Double(0, 0, width, height, radius, radius));
        gs.drawImage(srcImage, 0, 0, null);
        gs.dispose();
        return image;
    }

    /**
     * 去白边的话，调用这个方法
     *
     * @param matrix
     * @return
     */
    private static BufferedImage deleteWhite(BitMatrix matrix) {
        int[] rec = matrix.getEnclosingRectangle();
        int resWidth = rec[2] + 1;
        int resHeight = rec[3] + 1;

        BitMatrix resMatrix = new BitMatrix(resWidth, resHeight);
        resMatrix.clear();
        for (int i = 0; i < resWidth; i++) {
            for (int j = 0; j < resHeight; j++) {
                if (matrix.get(i + rec[0], j + rec[1])) {
                    resMatrix.set(i, j);
                }
            }
        }

        int width = resMatrix.getWidth();
        int height = resMatrix.getHeight();
        BufferedImage image = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                image.setRGB(x, y, resMatrix.get(x, y) ? BLACK
                        : WHITE);
            }
        }
        return image;
    }

}
