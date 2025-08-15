<!DOCTYPE html>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>快检服务云平台</title>
  </head>
  <style>
      #dataListtoPageNo {
          width: 40px !important;
          max-width: 40px !important;
          min-width: 40px !important;
          text-align: center;
      }
  </style>
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
            <li class="cs-b-active cs-fl">订单详情</li>
        </ol>
        <div class="cs-search-box cs-fr">
            <a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
        </div>
    </div>

    <div class="cs-tb-box">
        <div class="cs-base-detail">
            <div class="cs-content2 clearfix">
                <div class="cs-add-pad cs-input-bg">
                    <h3>订单信息</h3>
                    <table class="cs-form-table cs-form-table-he" >
                        <tbody>
                        <tr>
                            <td id ="id" style="display: none;">${sampling.id}</td>
                            <td id ="orderNumber" style="display: none;">${sampling.orderNumber}</td>
                            <td id ="regName" style="display: none;">${sampling.iuName}</td>
                            <td id ="samplingUsername" style="display: none;">${sampling.samplingUsername}</td>
                            <td class="cs-name" style="width:160px;">订单编号：</td>
                            <td class="cs-in-style" style="width:34%; padding-left:10px;">
                                <c:if test="${!empty sampling}">
                                ${sampling.orderNumber}
                                
                                </c:if>
                            </td>
                            <td class="cs-name" style="width:160px;">下单时间：</td>
                            <td class="cs-in-style" style=" padding-left:10px;" colspan="3">
                                <c:if test="${!empty sampling && !empty sampling.createDate}">
                                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${sampling.createDate}" />
                                </c:if>
                            </td>
                           <%-- <td rowspan="3" style="text-align:center;width:110px;">
                                <img src="${webRoot}/resources/qrcode/${sampling.qrcode}" alt="" style="height:100px;" style="display:inline-block;" />
                            </td>--%>
                        </tr>

                        <tr>
                            <td class="cs-name" style="width:160px;">冷链单位：</td>
                            <td class="cs-in-style" style=" padding-left:10px;" >
                                <c:if test="${!empty sampling}">${sampling.ccuName}</c:if>
                            </td>
                            <c:choose>
                                <c:when test="${empty sampling}">
                                    <td class="cs-name" style="width:160px;">仓号名称：</td>
                                    <td class="cs-in-style" style=" padding-left:10px;"></td>
                                </c:when>
                                <c:when test="${!empty sampling.iuId}">
                                    <td class="cs-name" style="width:160px;">仓号名称：</td>
                                    <td class="cs-in-style" style=" padding-left:10px;">${sampling.iuName}</td>
                                </c:when>
                                <c:otherwise>
                                    <td class="cs-name" style="width:160px;">仓号名称：</td>
                                    <td class="cs-in-style" style=" padding-left:10px;">
                                        <a href="${webRoot}/order/regUtil?id=${sampling.id}">${sampling.iuName}</a>
                                    </td>
                                </c:otherwise>
                            </c:choose>
                            <%-- <td class="cs-name" style="width:160px;">单位电话：</td>
                            <td class="cs-in-style" style=" padding-left:10px;" colspan="2">
                                <c:if test="${!empty sampling}">${sampling.regLinkPhone}</c:if>
                            </td> --%>
<%--                            <td class="cs-name" style="width:160px;">冷链单位地址：</td>--%>
<%--                            <td class="cs-in-style" style=" padding-left:10px;" colspan="2">--%>
<%--                                <c:if test="${!empty sampling}">${sampling.takeSamplingAddress}</c:if>--%>
<%--                            </td>--%>
                        </tr>
                        

                        
                        <tr>
                            <td class="cs-name" style="width:160px;">送检用户：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                <c:if test="${!empty sampling}">${sampling.samplingUsername}</c:if>
                            </td>
                            <td class="cs-name" style="width:160px;">用户电话：</td>
                            <td class="cs-in-style" style=" padding-left:10px;" colspan="2">
                                <c:if test="${!empty sampling}">${sampling.orderUserPhone}</c:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="cs-name" style="width:160px;">订单类型：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                <c:choose>
                                    <c:when test="${sampling.orderType==1}">自助下单</c:when>
                                    <c:otherwise>电子抽样</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="cs-name" style="width:160px;">订单状态：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                <c:if test="${!empty sampling}">
                                    <c:choose>
                                        <c:when test="${sampling.orderStatus eq 0}">暂存</c:when>
                                        <c:when test="${sampling.orderStatus eq 1}">待支付</c:when>
                                        <c:when test="${sampling.orderStatus eq 2}">已支付</c:when>
                                        <c:when test="${sampling.orderStatus eq 3}"><span class="text-success">已完成</span></c:when>
                                        <c:when test="${sampling.orderStatus eq 4}">已取消
                                            <c:if test="${!empty income && !empty income.payNumber}">
                                                <i class="_ji_huo"></i>
                                            </c:if>
                                        </c:when>
                                        <c:when test="${sampling.orderStatus eq 5}">检测中</c:when>
                                        <c:when test="${sampling.orderStatus eq 6}"><span class="text-danger">复检中</span></c:when>
                                    </c:choose>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="cs-name" style="width:160px;">是否取样：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                <c:choose>
                                    <c:when test="${sampling.isSampling==0}">待接收</c:when>
                                    <c:when test="${sampling.isSampling==1}">待取样</c:when>
                                    <c:when test="${sampling.isSampling==2}">已取样</c:when>
                                    <c:otherwise></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="cs-name" style="width:160px;">取样时间：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                <c:if test="${!empty sampling && !empty sampling.samplingTime}">
                                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${sampling.samplingTime}" />
                                </c:if>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <h3>付款信息</h3>
                    <table class="cs-form-table cs-form-table-he" >
                        <tbody>
                        <tr>
                            <td class="cs-name" style="width:160px;">订单金额：</td>
                            <td class="cs-in-style" style="width:34%; padding-left:10px;">
                                <c:if test="${!empty sampling && !empty sampling.orderFees}">￥${sampling.orderFees/100}</c:if>
                            </td>
                            <td class="cs-name" style="width:160px;">付款方式：</td>
                            <td class="cs-in-style" style="padding-left:10px;">
                                <c:choose>
                                    <c:when test="${empty income}"></c:when>
                                    <c:when test="${income.payType eq '0'}">微信</c:when>
                                    <c:when test="${income.payType eq '1'}">支付宝</c:when>
                                    <c:when test="${income.payType eq '2'}">余额</c:when>
                                </c:choose>
                            </td>

                        </tr>
                        <tr>
                            <td class="cs-name" style="width:160px;">付款时间：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                <c:if test="${!empty income && !empty income.payDate}">
                                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${income.payDate}" />
                                </c:if>
                            </td>
                            <td class="cs-name" style="width:160px;">交易单号：</td>
                            <td class="cs-in-style">
                                <c:if test="${!empty income}">${income.payNumber}</c:if>
                            </td>

                        </tr>
<%--                        <tr>--%>
<%--                            <td class="cs-name" style="width:160px;">付款时间：</td>--%>
<%--                            <td class="cs-in-style" style=" padding-left:10px;">--%>
<%--                                <c:if test="${!empty sampling && !empty sampling.payDate}">--%>
<%--                                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${sampling.payDate}" />--%>
<%--                                </c:if>--%>
<%--                            </td>--%>
<%--                            <td class="cs-name" style="width:160px;">重打费用：</td>--%>
<%--                            <td class="cs-in-style" style=" padding-left:10px;">--%>
<%--                                <c:if test="${!empty sampling && !empty sampling.printingFee}">￥${sampling.printingFee}</c:if>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
                        </tbody>
                    </table>
				
                    <h3>样品明细</h3>
                    <div id="dataList" class="cs-fix-num" style="height: 250px; overflow-y: auto;"></div>

                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<script type="text/javascript" src="${webRoot}/js/printTicket.js"></script>
</body>
<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
$(function(){
    //控制进货数量列是否显示
    var showPurchaseNumber=${showPurchaseNumber}!=0 ? 1 : 0;
	var op1 = {
			tableId: "dataList",	//列表ID
			tableAction: "${webRoot}/order/detailsDatagrid?tbSampling.id=${sampling.id}",	//加载数据地址

			parameter: [		//列表拼接参数
                {
                    columnCode: "sampleCode",
                    columnName: "样品编号",
                    sort: 0
                },
                {
					columnCode: "foodName",
					columnName: "样品名称",
                    sort: 0
				}, {
                    columnCode: "purchaseAmount",
                    columnName: "进货数量(KG)",
                    sort: 0,
                    sortDataType:"float",
                    show:showPurchaseNumber,
                    columnWidth: "100px",
                    customStyle:"purchaseAmount",
                },
                {
					columnCode: "itemName",
					columnName: "检测项目",
                    columnWidth: "15%",
                    sort: 0
				},
				{
					columnCode: "tubeCode1",
					columnName: "试管编码Ⅰ",
                    sort: 0
				},
                {
                    columnCode: "tubeCode2",
                    columnName: "试管编码Ⅱ",
                    sort: 0
                },
				{
					columnCode: "printCodeTime",
					columnName: "分拣时间",
                    customStyle:"collectTime",
                    sort: 0
				},
				{
					columnCode: "inspectionFee",
					columnName: "检测费用",
                    customElement: "￥?",
                    customStyle:"inspectionFee",
                    sort: 0
				},
				{
					columnCode: "conclusion",
					columnName: "检测结果",
                    customStyle:"conclusion",
                    columnWidth: "100px",
                    sort: 0
				}//,
				// {
				// 	columnCode: "recevieDevice",
				// 	columnName: "仪器唯一标识",
                //     customStyle:"recevieDevice",
                //     columnWidth: "100px",
                //     sort: 0
				// },
				// {
				// 	columnCode: "reportNumber",
				// 	columnName: "报告码",
                //     customStyle:"reportNumber",
                //     sort: 0,
                //     show: 2
				// },
				// {
				// 	columnCode: "collectCode",
				// 	columnName: "收样编号",
				// 	customStyle:"collectCode",
                //     sort: 0,
                //     show: 2
				// }
			],
            funColumnWidth: "60px",
            funBtns: [{
                show: 0,    //打印按钮
                style: Permission.getPermission("1443-2"),
                action: function(id){
                	// delete by xiaoyl 2020/1/19 未获取到收样编码
//                 	var reportNum = $(this).find("td:eq(9)").text();//报告码
//                 	getRegName($("#id").text(),reportNum,$(this).find("td:eq(10)").text());
//                 	return;
                    $("#mdataList .rowTr").each(function (index, value) {
                        if (id == $(this).attr("data-rowid")) {
                        	 var reportNum = $(this).find(".reportNumber").text();//报告码
                            if (!reportNum) {
                                var samplingDetailIds = id+",";
                                var thisTr = $(this);
                                var rowspan = $(this).find("td:last").attr("rowspan");
                                for (var i=2;i<=rowspan;i++){
                                    thisTr = thisTr.next();
                                    samplingDetailIds = samplingDetailIds + thisTr.attr("data-rowid") + ",";
                                }
                                samplingDetailIds = samplingDetailIds.substring(0, samplingDetailIds.length-1);

                                //生成报告码
                                $.ajax({
                                    type: "POST",
                                    url: "${webRoot}/reportPrint/generateReportNumber",
                                    data: {"samplingDetailIds" : samplingDetailIds},
                                    dataType: "json",
                                    success: function(data) {
                                        if (data && data.success) {
                                            $(this).find(".reportNumber").text(data.obj);
                                            showMbIframe("${webRoot}/reportPrint/report?samplingId=${sampling.id}&print=1&rN="+data.obj);
                                        }
                                    }
                                });
                            } else {
                                showMbIframe("${webRoot}/reportPrint/report?samplingId=${sampling.id}&print=1&rN="+reportNum);
                            }
                        }
                    });
                }
            },
            {
                show: 0,    //打印按钮
                style: Permission.getPermission("1443-6"),
                action: function(id){
                var collectCode;
                 $("#mdataList .rowTr").each(function (index, value) {
               	   if (id == $(this).attr("data-rowid")) {
                       collectCode=$(this).find(".collectCode").text();

               	   }
                });
                 printProof(collectCode);
              }
            
            }            
            ],
            onload: function(rows,data){
                $(rows).each(function (index, value) {
                    $("#mdataList tbody tr:eq("+index+")").find(".inspectionFee").html("¥"+value.inspectionFee/100);
                });
            }
		};
		datagridUtil.initOption(op1);
	    datagridUtil.query();
	    
		//返回
		$('.returnBtn').click(function(){
			self.location = "${webRoot}/sampling/list.do";
		});

	//激活订单按钮
	if ($("._ji_huo").length>0){
	    if (Permission.exist("1443-3")==1){
            $("._ji_huo").addClass(Permission.getPermission("1443-3").functionIcon);
            $("._ji_huo").attr("title", Permission.getPermission("1443-3").operationName);
        }
    }

    //激活订单
	$(document).on("click","._ji_huo",function () {
        activationId = ${sampling.id};
        $("#confirmModal .tips").text("激活订单？");
        $("#confirmModal").modal('toggle');
    });

});

//激活订单
var activationId = '';
function confirmModal(){
    $.ajax({
        type: "POST",
        url: "${webRoot}/order/activateOrder",
        data: {"id":activationId},
        dataType: "json",
        success: function(data) {
            if (data && data.success) {
                location.reload();
            } else {
                $("#confirm-warnning .tips").text("激活失败");
                $("#confirm-warnning").modal('toggle');
            }
        }
    });
}



// /**
//  * 通过表头对表内多列进行排序
//  * @param sTableID 要处理的表ID<table id=''>
//  * @param iCols [{iCol, sDataType}]
//  *        iCol 字段列id eg: 0 1 2 3 ...
//  *        sDataType 该字段数据类型 int,float,date 缺省情况下当字符串处理
//  */
// function orderByName_0(sTableID, iCols) {
//     var oTable = document.getElementById(sTableID);
//     var oTBody = oTable.tBodies[0];
//     var r = oTBody.rows[oTBody.rows.length-1];
//     var colDataRows = oTBody.rows;
//     var aTRs = new Array;
//     for (var i = 0; i < colDataRows.length; i++) {
//         aTRs[i] = colDataRows[i];
//     }
//
//     aTRs.sort(generateCompareTRs_0(iCols, 0));
//     aTRs.push(r);
//     var oFragment = document.createDocumentFragment();
//     for (var j = 0; j < aTRs.length; j++) {
//         oFragment.appendChild(aTRs[j]);
//     }
//     oTBody.appendChild(oFragment);
// }
//
// /**
//  * 比较函数生成器
//  *
//  * @param iCol 数据行数
//  * @param sDataType 该行的数据类型
//  * @return
//  */
// function generateCompareTRs_0(arr, k) {
//     return function compareTRs(oTR1, oTR2) {
//         if (!k){
//             k = 0;
//         }
//         if (k >= arr.length){
//             return 0;
//         }
//         var iCol = arr[k].iCol;
//         var sDataType = arr[k].sDataType;
//
//         if (!oTR1.cells[iCol].firstChild && !oTR2.cells[iCol].firstChild) {
//             k++;
//             return compareTRs(oTR1, oTR2);
//         }else if (!oTR1.cells[iCol].firstChild) {
//             return -1;
//         }else if (!oTR2.cells[iCol].firstChild) {
//             return 1;
//         }
//
//         // if (!oTR1.cells[iCol].firstChild) { return -1; }
//         // if (!oTR2.cells[iCol].firstChild) { return 1; }
//
//         if (oTR1.cells[iCol].firstChild instanceof Element) {
//             vValue1 = convert(oTR1.cells[iCol].firstChild.innerHTML, sDataType);
//             vValue2 = convert(oTR2.cells[iCol].firstChild.innerHTML, sDataType);
//
//             console.log("vValue1:"+vValue1);
//             console.log("vValue2:"+vValue2);
//             console.log(vValue1 < vValue2);
//         } else {
//             vValue1 = convert(oTR1.cells[iCol].firstChild.nodeValue, sDataType);
//             vValue2 = convert(oTR2.cells[iCol].firstChild.nodeValue, sDataType);
//
//             console.log("vValue1:"+vValue1);
//             console.log("vValue2:"+vValue2);
//             console.log(vValue1 < vValue2);
//         }
//
//         if(sDataType=='string'){
//             return vValue1.localeCompare(vValue2,"zh");
//         }else{
//             if (vValue1 < vValue2) {
//                 return -1;
//             } else if (vValue1 > vValue2) {
//                 return 1;
//             } else {
//                 k++;
//                 return compareTRs(oTR1, oTR2);
//             }
//         }
//     };
// }
/**
 * 通过表头对表内多列进行排序
 * @param sTableID 要处理的表ID<table id=''>
 * @param iCols [{iCol, sDataType}]
 *        iCol 字段列id eg: 0 1 2 3 ...
 *        sDataType 该字段数据类型 int,float,date 缺省情况下当字符串处理
 */
function orderByName_0(sTableID, iCols) {
    var oTable = document.getElementById(sTableID);
    var oTBody = oTable.tBodies[0];
    var r = oTBody.rows[oTBody.rows.length-1];
    var colDataRows = oTBody.rows;
    var aTRs = [];
    for (var i = 0; i < colDataRows.length; i++) {
        aTRs[i] = colDataRows[i];
    }

    aTRs.sort(generateCompareTRs_0(iCols));
    aTRs.push(r);
    var oFragment = document.createDocumentFragment();
    for (var j = 0; j < aTRs.length; j++) {
        oFragment.appendChild(aTRs[j]);
    }
    oTBody.appendChild(oFragment);
}

/**
 * 比较函数生成器
 *
 * @param iCol 数据行数
 * @param sDataType 该行的数据类型
 * @return
 */
function generateCompareTRs_0(arr) {
    return function compareTRs(oTR1, oTR2) {
        var k = 0;
        if (k >= arr.length){
            return 0;
        }
        var iCol = arr[k].iCol;
        var sDataType = arr[k].sDataType;

        if (!oTR1.cells[iCol].firstChild && !oTR2.cells[iCol].firstChild) {
            return compareTRs_1(oTR1, oTR2, arr, k);
        }else if (!oTR1.cells[iCol].firstChild) {
            return -1;
        }else if (!oTR2.cells[iCol].firstChild) {
            return 1;
        }

        if (oTR1.cells[iCol].firstChild instanceof Element) {
            vValue1 = convert(oTR1.cells[iCol].firstChild.innerHTML, sDataType);
            vValue2 = convert(oTR2.cells[iCol].firstChild.innerHTML, sDataType);
        } else {
            vValue1 = convert(oTR1.cells[iCol].firstChild.nodeValue, sDataType);
            vValue2 = convert(oTR2.cells[iCol].firstChild.nodeValue, sDataType);
        }

        if(sDataType=='string'){
            return vValue1.localeCompare(vValue2,"zh");
        }else{
            if (vValue1 < vValue2) {
                return -1;
            } else if (vValue1 > vValue2) {
                return 1;
            } else {
                return compareTRs_1(oTR1, oTR2, arr, k);
            }
        }
    };
}

function compareTRs_1(oTR1, oTR2, arr, k) {
    k++;
    if (k >= arr.length){
        return 0;
    }
    var iCol = arr[k].iCol;
    var sDataType = arr[k].sDataType;

    if (!oTR1.cells[iCol].firstChild && !oTR2.cells[iCol].firstChild) {
        return compareTRs_1(oTR1, oTR2, arr, k);
    }else if (!oTR1.cells[iCol].firstChild) {
        return -1;
    }else if (!oTR2.cells[iCol].firstChild) {
        return 1;
    }

    if (oTR1.cells[iCol].firstChild instanceof Element) {
        vValue1 = convert(oTR1.cells[iCol].firstChild.innerHTML, sDataType);
        vValue2 = convert(oTR2.cells[iCol].firstChild.innerHTML, sDataType);
    } else {
        vValue1 = convert(oTR1.cells[iCol].firstChild.nodeValue, sDataType);
        vValue2 = convert(oTR2.cells[iCol].firstChild.nodeValue, sDataType);
    }

    if(sDataType=='string'){
        return vValue1.localeCompare(vValue2,"zh");
    }else{
        if (vValue1 < vValue2) {
            return -1;
        } else if (vValue1 > vValue2) {
            return 1;
        } else {
            return compareTRs_1(oTR1, oTR2, arr, k);
        }
    }
}

function getRegName(samplingId,reportNum,collectCode){
layer.open({
    type: 2,
    //offset: 't',
    title: '选择仓号名称',
    shadeClose: true,
    shade: 0.3,
    maxmin: true, //开启最大化最小化按钮
    btnAlign: 'c',
    area: ['670px', '410px'],
    content: '${webRoot}/requester/unit/listview?samplingId='+samplingId,
     btn: ['确定','关闭'],
   	    yes: function(index, layero){
 	    	 var iframeWin =layero.find('iframe')[0].contentWindow; 

	    	 var items = iframeWin.getSelections();

	    	 if(items == ""){
		    		
		    		jp.alert("至少选择一条数据", {icon: 0});
			    	return;
		    	 }
	    	 var ids = "";
	    	
	    	 $.each(items,function(i,item){
	    		 ids=item.id+","+ids;
	    	 }) 
	    	 ids = ids.substring(0,ids.length-1);
	    	 //console.log(ids);
             showMbIframe("${webRoot}/reportPrint/report?samplingId="+samplingId+"&print=1&rN="+reportNum+"&requestId="+ids+"&collectCode="+collectCode);
	    	 
	    	 layer.closeAll();
   		  },
   	   cancel: function(index){
   	      }
  });
}





function printProof(collectCode){
	console.log(collectCode);
    var orderNo = "${sampling.orderNumber}";  //订单号
    var samplingUsername = "${sampling.samplingUsername}"; //送检人员
    // var samplingDate = $("#_sample_info ._samplingDate").text();   //下单时间
    var collectTime;//new Date().format("yyyy-MM-dd HH:mm:ss");    //送样时间
    var wtdw ="${sampling.iuName}";  //委托单位名称
    //var sjdw = $("#_sample_info ._inspectionUnitName").text();    //送检单位名称
    var qrcode = "${webRoot}/collectSample/detail?samplingId="+"${sampling.id}"+"&collectCode="+collectCode;

    var n0 = 10;    //除标题外，每行文字最大长度

    var wtdwArr = [];
    if (wtdw.length <= n0){
        wtdwArr[0] = wtdw;
    } else {
        var n1 = Math.floor(wtdw.length/n0);
        var n2 = wtdw.length%n0;
        var n3 = n1 + (n2>0 ? 1:0); //行数

        for (var i=0; i<n3; i++){
            var n4 = (i+1)*n0;  //每行最后文字下标
            n4 = n4 >= wtdw.length ? wtdw.length : n4;
            wtdwArr[i] = wtdw.substring( i*n0, n4);
        }
    }



    var _width = 58; //纸张宽度(mm)
    var _hight = 0; //纸张高度(mm)
    var _line_hight = 50;   //行高(mm)
    var _text_left = 30;   //左边距(mm)

    sendMessage = "CODEPAGE UTF-8\r\n" +
        "DIRECTION 1\r\n" +
        "CLS\r\n" +
        "TEXT "+_text_left+",20,\"TSS24.BF2\",0,1.8,2,\"************送样凭证************\"\r\n" +
        "TEXT "+_text_left+",80,\"TSS24.BF2\",0,1,1,\"订单编号："+orderNo+"\"\r\n";

    _hight = 80;
/*     if (wtdwArr && wtdwArr.length>0){
        for (var j=0; j<wtdwArr.length; j++){
            _hight = _hight + _line_hight;
            if (j==0){
                sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"委托单位："+wtdwArr[j]+"\"\r\n";
            } else {
                sendMessage+="TEXT "+(_text_left+120)+","+_hight+",\"TSS24.BF2\",0,1,1,\""+wtdwArr[j]+"\"\r\n";
            }

        }
    } */


    _hight = _hight + _line_hight;
    sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"样品名称\"\r\n" +
        "TEXT "+(_text_left+140)+","+_hight+",\"TSS24.BF2\",0,1,1,\"检测项目\"\r\n";

    sendMessage+="BAR "+_text_left+","+(_hight + 40)+",380,1\r\n";

    //获取本次收样样品信息
    var reportNum;//取报告码
	 $("#mdataList .rowTr").each(function (index, value) {
		 if($(value).find(".collectCode").text()==collectCode){//同一收样批次
			 var item_name=$(value).find("td:eq(3)").text();//检测项目名称
// 			 reportNum = $(value).find("td:eq(9)").text();
			 collectTime=$(value).find("td:eq(5)").text();
			 _hight = _hight + _line_hight;
			    sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\""+$(value).find("td:eq(2)").text()+"\"\r\n" +
			        "TEXT "+(_text_left+140)+","+_hight+",\"TSS24.BF2\",0,1,1,\""+item_name.substring(0,10)+"\"\r\n";
			    _hight = _hight + _line_hight-20;
			    if(item_name.length>10){
			    	var i ;
			    	i=item_name.substring(10,item_name.length);
			    sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\""+"\"\r\n" +
			    "TEXT "+(_text_left+140)+","+_hight+",\"TSS24.BF2\",0,1,1,\""+i+"\"\r\n";
			  	}
		 }
	 });
    

    sendMessage+="BAR "+_text_left+","+(_hight + 40)+",380,1\r\n";

    _hight = _hight + _line_hight;
    sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"送检人员："+samplingUsername+"\"\r\n";

    _hight = _hight + _line_hight;
    sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"送样时间："+collectTime+"\"\r\n";

    _hight = _hight + _line_hight;
    // sendMessage+="TEXT 60,"+_hight+",\"TSS24.BF2\",0,1,1,\"取报告码："+_collectCode+"(三天有效)\"\r\n";
    sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"取报告码：\"\r\n";
    sendMessage+="TEXT "+(_text_left+118)+","+(_hight+5)+",\"3.EFT\",0,1,1,\""+collectCode+"\"\r\n";
    sendMessage+="TEXT "+(_text_left+210)+","+_hight+",\"TSS24.BF2\",0,1,1,\"(三天有效)\"\r\n";

    _hight = _hight + _line_hight;
    sendMessage+="QRCODE "+(_text_left+50)+","+_hight+",M,6,A,0,M2,\""+qrcode+"\"\r\n";

    _hight = _hight + 270;
    sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"(请在微信或终端机扫码查看报告)\"\r\n";

    _hight = _hight + _line_hight;
    sendMessage+="PRINT 1,1\r\n" +
        "SOUND 5,100\r\n" +
        "CUT\r\n"+
        "OUT \"ABCDE\"\r\n";


    sendMessage = "SIZE "+_width+" mm, "+Math.floor(_hight/8)+" mm\r\n" + sendMessage;

    console.log(sendMessage);

    sendCommand();
}
</script>
</html>
