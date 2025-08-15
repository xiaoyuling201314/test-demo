package com.dayuan.util;

import java.io.File;
import java.util.Date;

import org.apache.log4j.Logger;

import com.alipay.api.internal.util.codec.EncoderException;
import com.dayuan.controller.dataCheck.DataCheckRecordingController;

import java.io.File;
import ws.schild.jave.AudioAttributes;
import ws.schild.jave.Encoder;
import ws.schild.jave.VideoAttributes;
import ws.schild.jave.EncodingAttributes;
import ws.schild.jave.InputFormatException;
import ws.schild.jave.MultimediaObject;

 
public class aviToMp4 {
    private final Logger logger = Logger.getLogger(aviToMp4.class);


   public static void main(String[] args) {
	
	   String oldPath="D:/resources/fst_dykjfw/lawinstrument/20200310/1.avi";
	   String newPath="D:/resources/fst_dykjfw/lawinstrument/20200310/1.mp4";
	   try {
		AviToMp4(oldPath,newPath,"");
	} catch (IllegalArgumentException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (InputFormatException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ws.schild.jave.EncoderException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	   
}
    /**
     * 转换视频格式：将avi转换成MP4格式
     * @description
     * @param oldPath
     * @param newPath
     * @param type
     * @throws IllegalArgumentException
     * @throws InputFormatException
     * @throws ws.schild.jave.EncoderException
     * @author huht
     * @date   2020年4月17日
     */
	public static  void AviToMp4(String oldPath,String newPath,String type) throws IllegalArgumentException, InputFormatException, ws.schild.jave.EncoderException {
//			File source = new File("C:\\shiping\\1.avi");
//		    File target = new File("C:\\shiping\\2019-06-27333333测试.mp4");
			File source = new File(oldPath);
		    File target = new File(newPath);
		    System.out.println("转换前的路径:"+oldPath);
		    System.out.println("转换后的路径:"+newPath);
		    AudioAttributes audio = new AudioAttributes(); 
			audio.setCodec("libmp3lame"); //音频编码格式
			audio.setBitRate(new Integer(800000));
			audio.setChannels(new Integer(1)); 
			//audio.setSamplingRate(new Integer(22050)); 
			VideoAttributes video = new VideoAttributes(); 
			video.setCodec("libx264");//视频编码格式
			video.setBitRate(new Integer(3200000));
			video.setFrameRate(new Integer(15));//数字设置小了，视频会卡顿
			EncodingAttributes attrs = new EncodingAttributes(); 
			attrs.setFormat("mp4");
			attrs.setAudioAttributes(audio); 
			attrs.setVideoAttributes(video); 
			Encoder encoder = new Encoder();  
			MultimediaObject multimediaObject = new MultimediaObject(source);
			System.out.println("avi转MP4 --- 转换开始:"+new Date());
			encoder.encode(multimediaObject, target, attrs);
			
			System.out.println("avi转MP4 --- 转换结束:"+new Date());
		 
		}
	 
}
