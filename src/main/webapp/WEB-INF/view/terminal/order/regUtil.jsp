<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>快检服务云平台</title>
  </head>
  
<body>
<div class="cs-maintab">
    <div class="cs-col-lg clearfix">
        <ol class="cs-breadcrumb">
            <li class="cs-fl">
                <img src="${webRoot}/img/set.png" alt="" />
                <a href="javascript:">订单管理</a></li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">订单管理</li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">订单委托单位列表</li>
        </ol>
            <!-- 面包屑导航栏 结束-->
    <div class="cs-search-box clearfix cs-fr">
    
                
                <input class="cs-input-cont cs-fl focusInput" type="text" name="requesterName" placeholder="请输入委托单位" οnkeyup="this.value=this.value.toUpperCase();" style="text-transform: uppercase;"/>
<!--            <input class="cs-input-cont cs-fl focusInput" type="hidden" name="requesterName" />
                <input class="cs-input-cont cs-fl focusInput" type="hidden" name="tubeCode" />
 -->            <input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
        

				<a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
	</div>
     
    </div>


</div>

<div id="dataList"></div>
<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<script src="${webRoot}/js/datagridUtil2.js"></script>
</body>


<script type="text/javascript">



rootPath = '${webRoot}/regData/';

var datagrid1 = datagridUtil.initOption({
        tableId: "dataList",	//列表ID
        tableAction: '${webRoot}' + "/order/regData?id="+"${id}", //加载数据地址
        
        parameter: [		//列表拼接参数

 		 {
              columnCode: "requesterName",
              columnWidth: "800",
              columnName: "委托单位",
              customStyle:"requesterName",
              columnWidth: "20%",
              query: 1/* ,
              customElement: "<a class='text-primary cs-link samplingNoI'>?<a>"    */               
          },
  		 {
              columnCode: "linkPhone",
              columnName: "单位电话",
              columnWidth: "15%"
          }
          ,
   		 {
               columnCode: "companyAddress",
               columnName: "单位地址",
               columnWidth: "20%"
           }
 /*          ,
   		 {
               columnCode: "samplingUsername",
               columnName: "送检用户"
           }
          ,
    		 {
                columnCode: "param3",
                columnName: "送检电话"
            }
          ,
 		 {
             columnCode: "inspectionFee",
             columnName: "检测费用"
         }
          ,
  		 {
              columnCode: "inspectionFee",
              columnName: "检测费用"
          }  */

        ]



    });
     datagrid1.queryByFocus();

</script>
</html>
