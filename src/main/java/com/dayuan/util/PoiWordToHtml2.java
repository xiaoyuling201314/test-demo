package com.dayuan.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.usermodel.Picture;
import org.apache.poi.hwpf.usermodel.PictureType;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFPictureData;
import org.w3c.dom.Document;

public class PoiWordToHtml2 {
	 /**
	  * word03版本(.doc)转html
	  * poi:word03在线预览
	  * */
	 public static void PoiWordToHtml() throws IOException, ParserConfigurationException, TransformerException{
		 final String path = "D:\\";
		  final String file = "D:\\A20170619001.doc";
		  InputStream input = new FileInputStream(file);
		  HWPFDocument wordDocument = new HWPFDocument(input);
		  WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(
		    DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument());
		  wordToHtmlConverter.setPicturesManager(new PicturesManager() {
		   public String savePicture(byte[] content, PictureType pictureType,
		     String suggestedName, float widthInches, float heightInches) {     //图片在html页面加载路径
		    return "image\\"+suggestedName;
		   }
		  });
		  wordToHtmlConverter.processDocument(wordDocument);
		  //获取文档中所有图片
		  List pics = wordDocument.getPicturesTable().getAllPictures();
		  if (pics != null) {
		   for (int i = 0; i < pics.size(); i++) {
		    Picture pic = (Picture) pics.get(i);
		    try {//图片保存在文件夹的路径
		     pic.writeImageContent(new FileOutputStream(path
		       + pic.suggestFullFileName()));
		    } catch (FileNotFoundException e) {
		     e.printStackTrace();
		    }
		   }
		  }
		  //创建html页面并将文档中内容写入页面
		  Document htmlDocument = wordToHtmlConverter.getDocument();
		  ByteArrayOutputStream outStream = new ByteArrayOutputStream();
		  DOMSource domSource = new DOMSource(htmlDocument);
		  StreamResult streamResult = new StreamResult(outStream);
		  TransformerFactory tf = TransformerFactory.newInstance();
		  Transformer serializer = tf.newTransformer();
		  serializer.setOutputProperty(OutputKeys.ENCODING, "utf-8");
		  serializer.setOutputProperty(OutputKeys.INDENT, "yes");
		  serializer.setOutputProperty(OutputKeys.METHOD, "html");
		  serializer.transform(domSource, streamResult);
		  outStream.close();
		  String content = outStream.toString("UTF-8");
		  FileUtils.writeStringToFile(new File(path, "word03.html"), content, "utf-8");
	 
	 }
}