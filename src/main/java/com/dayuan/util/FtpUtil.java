package com.dayuan.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;

/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年9月29日
 */
public class FtpUtil {
	private FTPClient ftp;
	/**
	 * 
	 * @param url 			ftp服务器IP
	 * @param port 			端口号:默认为21
	 * @param username 		ftp用户名
	 * @param password 		ftp密码
	 * @param remotePath	切换到要操作的路径目录下
	 */
	public FtpUtil(String url,int port,String username,String password,String remotePath){
		ftp=new FTPClient();
		try {
			int reply;
			ftp.connect(url,port);
			ftp.login(username, password);
			//切换到要操作的路径目录下,进行编码处理，解决中文路径切换失败问题  new String(fileName.getBytes("UTF-8"),"ISO-8859-1")
			ftp.changeWorkingDirectory(new String(remotePath.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1));
			reply=ftp.getReplyCode();
			if(!FTPReply.isPositiveCompletion(reply)){
				ftp.disconnect();
				ftp=null;
			}
			  //转移到设置的目录下  
            if(remotePath!=null && !remotePath.equals("")){ 
            	ftp.changeWorkingDirectory(new String(remotePath.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1));
            }
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 关闭连接
	 */
	public void closeConnect(){
		if(ftp.isConnected()){
			try {
				ftp.disconnect();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 文件上传至FTP服务器
	 * @param url IP
	 * @param port 端口号:默认为21
	 * @param username ftp用户名
	 * @param password ftp密码
	 * @param path		上传路径
	 * @param fileName  文件名
	 * @param input		数据流
	 * @return
	 */
	public boolean uploadFile(String fileName,InputStream input){
		boolean success=false;
		if(ftp!=null){
			try {
				//ftp.enterLocalActiveMode();//使用主动模式
			 	// ftp.setRemoteVerificationEnabled(false);//  服务器会获取自身Ip地址和提交的host进行匹配，当不一致时报出以上异常。将此参数设置为false即可。默认为true。
				ftp.enterLocalPassiveMode();//使用被动模式
				ftp.storeFile(new String(fileName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1), input);
				input.close();
				ftp.logout();
				success=true;
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				closeConnect();
			}
		}
		return success;
	}
	/**
	* Description: 从FTP服务器下载文件
	* @param url FTP服务器hostname
	* @param port FTP服务器端口
	* @param username FTP登录账号
	* @param password FTP登录密码
	* @param remotePath FTP服务器上的相对路径
	* @param fileName 要下载的文件名
	* @param localPath 下载后保存到本地的路径
	* @return
	*/ 
	public boolean downFile(String fileName,String localPath){
		boolean success=false;
		if(ftp!=null){
			try { 
				FTPFile [] fs = ftp.listFiles(); 
				for(FTPFile ff:fs){ 
					if(ff.getName().equals(fileName)){ 
						File localFile = new File(localPath+"/"+ff.getName()); 
						OutputStream is = new FileOutputStream(localFile);  
						ftp.retrieveFile(ff.getName(), is); 
						is.close(); 
					} 
				} 
				
				ftp.logout(); 
				success = true; 
			} catch (IOException e) { 
				e.printStackTrace(); 
			} finally { 
				closeConnect();
			} 
		}
		return success;
	}
	/**
	* Description: 从FTP服务器下载文件
	* @param url FTP服务器hostname
	* @param port FTP服务器端口
	* @param username FTP登录账号
	* @param password FTP登录密码
	* @param remotePath FTP服务器上的相对路径
	* @param fileName 要下载的文件名
	* @return 返回数据流
	*/ 
	public InputStream downFile(String fileName){
		if(ftp!=null){
			 try { 
				 	if(StringUtil.isEmpty(fileName)) return null;
				 	 ftp.enterLocalPassiveMode();//使用被动模式
				 	// ftp.enterLocalActiveMode();//使用主动模式
				 	 //ftp.setRemoteVerificationEnabled(false);//  服务器会获取自身Ip地址和提交的host进行匹配，当不一致时报出以上异常。将此参数设置为false即可。默认为true。
				 	 InputStream input = ftp.retrieveFileStream(new String(fileName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1));
				 	 
				 	 //检查其返回值以验证成功
				 	 if(!ftp.completePendingCommand()){
				 		 //重新下载文件
				 		 input = ftp.retrieveFileStream(new String(fileName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1));
					 	 
				 		 if(!ftp.completePendingCommand()){
					 		 //下载失败
					 		 input = null;
					 	 }
				 	 }
		             return input; 
			    } catch (IOException e) { 
			        e.printStackTrace(); 
			    } finally { 
			       closeConnect();
			    } 
		}
		return null;
	}
	/*public byte[] downFileBytes(String fileName){
		byte[] bytes=null;
		if(ftp!=null){
			 try {
				FTPFile [] files = ftp.listFiles();
				for(FTPFile ff:files){ 
		            if(ff.getName().equals(fileName)){ 
		            	InputStream input = ftp.retrieveFileStream(fileName);
		            	ByteArrayOutputStream out=new ByteArrayOutputStream();
		            	byte[] buf = new byte[204800];  
		                int bufsize = 0;  
		                while ((bufsize = input.read(buf, 0, buf.length)) != -1) {  
		                    out.write(buf, 0, bufsize);  
		                }  
		                bytes = out.toByteArray();  
		                out.close();  
		                input.close();  
		                break;  
		            }
	            }
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				closeConnect();
			}
		}
		return bytes;
	}*/
}
