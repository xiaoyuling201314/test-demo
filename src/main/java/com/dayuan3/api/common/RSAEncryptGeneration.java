package com.dayuan3.api.common;
import com.trhui.mallbook.common.rsa.Base64;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;

/**
 * mallbook 汇付公私钥代码生成
 * @Author xiaogc
 * @Date 2021/12/21 14:22
 */
public class RSAEncryptGeneration {

    public static void main(String[] args) {
        // 生成一对公私钥到指定路径下  .pfx私钥 .cer公钥
        RSAEncryptGeneration.genKeyPair("D:\\tools\\mallBook2\\");
    }
    /**
     * 随机生成密钥对
     */
    public static void genKeyPair(String filePath) {
        // KeyPairGenerator类用于生成公钥和私钥对，基于RSA算法生成对象
        File myFilePath = new File(filePath);
        if (!myFilePath.exists()) {
            myFilePath.mkdirs();
        }
        KeyPairGenerator keyPairGen = null;
        try {
            keyPairGen = KeyPairGenerator.getInstance("RSA");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        // 初始化密钥对生成器，密钥大小为96-1024位
        keyPairGen.initialize(1024, new SecureRandom());
        // 生成一个密钥对，保存在keyPair中
        KeyPair keyPair = keyPairGen.generateKeyPair();
        // 得到私钥
        RSAPrivateKey privateKey = (RSAPrivateKey) keyPair.getPrivate();
        // 得到公钥
        RSAPublicKey publicKey = (RSAPublicKey) keyPair.getPublic();
        try {
            // 得到公钥字符串
            String publicKeyString = Base64.encode(publicKey.getEncoded());
            System.out.println("公钥字符串:"+publicKeyString);
            // 得到私钥字符串
            String privateKeyString = Base64.encode(privateKey.getEncoded());
            System.out.println("私钥字符串:"+privateKeyString);
            // 将密钥对写入到文件  .pfx私钥 .cer公钥
            FileWriter pubfw = new FileWriter(filePath + "/merchant_no.cer");
            FileWriter prifw = new FileWriter(filePath + "/merchant_no.pfx");
            BufferedWriter pubbw = new BufferedWriter(pubfw);
            BufferedWriter pribw = new BufferedWriter(prifw);
            pubbw.write(publicKeyString);
            pribw.write(privateKeyString);
            pubbw.flush();
            pubbw.close();
            pubfw.close();
            pribw.flush();
            pribw.close();
            prifw.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
