package com.dayuan.controller.system;

import com.dayuan.common.WebConstant;
import com.dayuan.util.CodecUtils;
import com.dayuan.util.SFTPUtil;
import com.dayuan.util.StringUtil;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.SftpException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

/**
 * Author: shit
 * Date: 2019-05-10 09:58
 * Content:PDF预览Controller
 */
@Controller
@RequestMapping("/pdf")
public class PdfPreviewController {
    @Value("${ftpKey}")
    private String ftpKey;
    @Value("${ftpAddress}")
    private String ftpAddress;
    @Value("${ftpPort}")
    private String ftpPort;
    @Value("${ftpUserName}")
    private String ftpUserName;
    @Value("${ftpPassword}")
    private String ftpPassword;
    private final String resources = WebConstant.res.getString("resources");

    @RequestMapping("/preview")
    public String preview(Model model, String file,String fileName,@RequestParam(required = true, defaultValue = "100")String zoom) {
        try {
            model.addAttribute("file", file);
            if(StringUtil.isNotEmpty(fileName)){
                fileName = URLEncoder.encode(fileName, "UTF-8");
                fileName = fileName.replace("+", "%20");
                model.addAttribute("fileName", fileName);
            }
            model.addAttribute("zoom", zoom);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/common/previewPdf";
    }


    /**
     * 获取pdf文件流 （跨域pdf）
     * 前台传递url是完整路径 如：http://192.168.19.54:8899/lxgl/resources/files/resoult/bb.pdf（请确保该路径可直接访问）
     *
     * @param request
     * @param response
     */
    @RequestMapping(value = "/pdfStreamCrossDomain")
    public void pdfStreamCrossDomain(HttpServletRequest request, HttpServletResponse response) {
        try {
            String url=request.getParameter("url");
            //如果是法律法规或者食品标准在线预览，由于文件名中有不少关键字符导致无法链接访问，所以需要通过FTP将文件下载回来才能进行预览，
            if(url.contains("法律法规") || url.contains("食品标准")){
                getFSTStreamCrossDomain(request, response);
            }else{
                getStreamCrossDomain(request, response);
            }
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JSchException e) {
            e.printStackTrace();
        } catch (SftpException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取pdf文件流 （本地pdf）
     * 前台传递filePath不是完整路径 如：files/resoult/bb.pdf
     *
     * @param request
     * @param response
     */
    @RequestMapping(value = "/pdfStreamLocal")
    @ResponseBody
    public void pdfStreamLocal(HttpServletRequest request, HttpServletResponse response) {
        try {
            getStreamLocal(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    /**
     * 把FST系统文件url转换为流的形式返回（解决跨域预览pdf文件问题）
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void getFSTStreamCrossDomain(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, JSchException, SftpException {
        String destUrl = request.getParameter("url");// 远程文件途径（请确保该路径可直接访问）
        SFTPUtil sftp = new SFTPUtil();
        sftp.connectServer(CodecUtils.aesDecrypt(ftpAddress, ftpKey), Integer.parseInt(CodecUtils.aesDecrypt(ftpPort, ftpKey)), CodecUtils.aesDecrypt(ftpUserName, ftpKey), CodecUtils.aesDecrypt(ftpPassword, ftpKey));
        String downloadPath=destUrl.substring(destUrl.indexOf("pdf/")+4);
        byte[] fileByte = sftp.downloadFile(downloadPath);
        sftp.close();
        if(fileByte!=null && fileByte.length>0){
            response.setContentType("application/octet-stream");
            response.setCharacterEncoding("utf-8");
            OutputStream out=response.getOutputStream();
            out.write(fileByte);
            out.close();
        }else{
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("下载文件不存在<a href='"+request.getContextPath()+"/data/laws/list.do'><i class='icon iconfont icon-fanhui'></i>返回</a>");
        }
    }

    /**
     * 把文件url转换为流的形式返回（解决跨域预览pdf文件问题）
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void getStreamCrossDomain(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String destUrl = request.getParameter("url");// 远程文件途径（请确保该路径可直接访问）
        response.setContentType("application/pdf");
        response.setHeader("Access-Control-Allow-Origin", "*"); // 解决请求头跨域问题
        ServletOutputStream sos = response.getOutputStream();
        URL url = new URL(destUrl);
        HttpURLConnection httpUrl = (HttpURLConnection) url.openConnection();
        // 连接指定的网络资源
        httpUrl.connect();
        // 获取网络输入流
        BufferedInputStream bis = new BufferedInputStream(httpUrl.getInputStream());
        int b;
        while ((b = bis.read()) != -1) {
            sos.write(b);
        }
        sos.close(); // 这里有点和c语言里的读取文件有点像
        bis.close();
    }


    /**
     * 获取本地文件的流（传递的路径不是完整路径 如：files/resoult/bb.pdf）
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void getStreamLocal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filePath = request.getParameter("filePath");           //传递的路径不是完整路径 如：files/resoult/bb.pdf
        //filePath = "files/resoult/4028933b6b3eed25016b3eed25b80000.pdf";
        response.setHeader("Access-Control-Allow-Origin", "*"); // 解决请求头跨域问题
        response.setContentType("application/pdf");
        File f1 = new File(resources + filePath);
        FileInputStream reader = new FileInputStream(f1);
        BufferedInputStream BufferReader = new BufferedInputStream(reader);
        // 创建servlet 输出流对象
        ServletOutputStream sos = response.getOutputStream();
        int b;
        while ((b = BufferReader.read()) != -1) {
            sos.write(b);
        }
        sos.close(); // 这里有点和c语言里的读取文件有点像
        reader.close();
    }


    @RequestMapping("/GetFile")
    public void getFile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //读取路径下面的文件
        File file = new File("D:aa.txt");
        File picFile = null;
        FileInputStream in = new FileInputStream(file);
        OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
        //创建存放文件内容的数组
        byte[] buff = new byte[1024];
        //所读取的内容使用n来接收
        int n;
        //当没有读取完时,继续读取,循环
        while ((n = in.read(buff)) != -1) {
            //将字节数组的数据全部写入到输出流中
            outputStream.write(buff, 0, n);
        }
        //强制将缓存区的数据进行输出
        outputStream.flush();
        //关流
        outputStream.close();
        in.close();
    }

}
