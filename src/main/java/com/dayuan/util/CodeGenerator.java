package com.dayuan.util;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.TemplateType;
import com.baomidou.mybatisplus.generator.config.rules.DateType;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.baomidou.mybatisplus.generator.fill.Column;

import java.util.Collections;

public class CodeGenerator {
    public static void main(String[] args) {
        String modelName="admin";//父包模块名
        // 数据源配置
        FastAutoGenerator.create("jdbc:mysql://47.107.44.204:3306/dykjfw_2025", "dyfda", "dyroot")
                .globalConfig(builder -> {
                    builder.author("xiaoyl")        // 设置作者
//                            .enableSwagger()        // 开启 swagger 模式 默认值:false
                            .disableOpenDir()       // 禁止打开输出目录 默认值:true
                            .commentDate("yyyy-MM-dd") // 注释日期
                            .dateType(DateType.ONLY_DATE)   //定义生成的实体类中日期类型 DateType.ONLY_DATE 默认值: DateType.TIME_PACK
                            .outputDir(System.getProperty("user.dir") + "/src/main/java"); // 指定输出目录
                })

                .packageConfig(builder -> {
                    builder.parent("com.dayuan4."+modelName) // 父包模块名
//                            .moduleName("")                   // 设置父包模块名 默认值:无
                            .controller("controller")   //Controller 包名 默认值:controller
                            .entity("bean")           //Entity 包名 默认值:entity
                            .service("service")         //Service 包名 默认值:service
                            .mapper("mapper")           //Mapper 包名 默认值:mapper
//                            .other("model")
                            .pathInfo(Collections.singletonMap(OutputFile.xml, System.getProperty("user.dir") + "/src/main/java/com/dayuan4/"+modelName+"/mybatis")); // 设置mapperXml生成路径
                    //默认存放在mapper的xml下
                })

                .strategyConfig(builder -> {
                    builder.addInclude("t_s_depart") // 设置需要生成的表名 可变参数“user”, “user1”
                            .addTablePrefix("sys_", "tb_", "gms_") // 设置过滤表前缀
                            .serviceBuilder()//service策略配置
                            .formatServiceFileName("%sService")
                            .formatServiceImplFileName("%sServiceImpl")
                            .entityBuilder()// 实体类策略配置
//                            .idType(IdType.ASSIGN_ID)//主键策略  雪花算法自动生成的id
                            .idType(IdType.AUTO)//主键策略  雪花算法自动生成的id
                            .addTableFills(new Column("create_date", FieldFill.INSERT)) // 自动填充配置
                            .addTableFills(new Column("update_date", FieldFill.INSERT_UPDATE))
                            .enableLombok() //开启lombok
                            .logicDeleteColumnName("deleted")// 说明逻辑删除是哪个字段
//                            .enableTableFieldAnnotation()// 属性加上注解说明
                            .controllerBuilder() //controller 策略配置
                            .formatFileName("%sController")
                            .enableRestStyle() // 开启RestController注解
                            .mapperBuilder()// mapper策略配置
                            .enableBaseResultMap()  // 关键：生成 <resultMap>
                            .enableBaseColumnList() // 关键：生成 <sql id="Base_Column_List">
                            .formatMapperFileName("%sMapper")
                            .enableMapperAnnotation()//@mapper注解开启
                            .formatXmlFileName("%sMapper");
                })

                // 使用Freemarker引擎模板，默认的是Velocity引擎模板
                .templateEngine(new FreemarkerTemplateEngine())
//                .templateEngine(new EnhanceFreemarkerTemplateEngine())

                .execute();

    }
}