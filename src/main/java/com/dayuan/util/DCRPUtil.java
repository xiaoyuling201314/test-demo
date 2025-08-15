package com.dayuan.util;

import com.alibaba.fastjson.JSONObject;

import java.io.*;
import java.nio.charset.StandardCharsets;

/**
 * Author: shit
 * Date: 2018/11/23 11:04
 * Content:
 */
public class DCRPUtil {

    public static void writeToJSON(Object object, String path, String jsonName) {
        path = path + jsonName;
        try {
            File f = new File(path);
            if (!f.exists()) {
                f.getParentFile().mkdirs();
            }
            PrintWriter out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path), StandardCharsets.UTF_8)));
            out.write(JSONObject.toJSONString(object));
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
