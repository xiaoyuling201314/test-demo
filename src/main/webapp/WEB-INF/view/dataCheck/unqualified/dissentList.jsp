<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
  <%--
          <div class="cs-col-lg clearfix">
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:;">不合格处理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">处理中
              </li>
            </ol>
            <div class="cs-search-box cs-fr">
              <form action="datagrid.do">
              	<select class="cs-selcet-style cs-fl" style="display: none;" id="regType" onchange="changeRegType();">
				</select>
              	<span class="check-date cs-fl" style="display: inline;"> 
					<span class="cs-name">时间范围:</span> 
					<span class="cs-in-style cs-time-se cs-time-se">
						<input name="checkDateStartDateStr" id="start"style="width: 110px;" class="cs-time Validform_error focusInput" type="text" onclick="WdatePicker()" datatype="date" value="${start}" onchange="changeVAL1()"> 
						<span style="padding: 0 5px;">至</span> 
						<input name="checkDateEndDateStr" id="end" style="width: 110px;" class="cs-time Validform_error focusInput" type="text" onclick="WdatePicker()" datatype="date" value="${end}" onchange="changeVAL2()">
						&nbsp;
					</span>
				</span>
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="regName" placeholder="请输入样品编号、被检单位、档口编号、样品名称或检测项目" />
                <input type="hidden" class="cs-input-cont cs-fl focusInput" name="dealMethod" value="0"/>
                <input type="button" onclick="datagridUtil.queryByFocus()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                </div>
              </form>
            </div>
          </div>
     --%>

	<div id="dataList"></div>

  <%-- 删除数据 --%>
  <div class="modal modal2 fade intro2" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel">
      <div class="modal-dialog cs-mid-width" role="document">
          <div class="modal-content ">
              <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" id="deleteModalLabel">删除</h4>
              </div>
              <div class="modal-body cs-mid-height">
                  <div class="cs-tabcontent" >
                      <div class="cs-content2">
                          <form id="deleteForm" method="post" action="${webRoot}/dataCheck/unqualified/delete">
                              <input type="hidden" name="id">
                              <table class="cs-add-new">
                                  <tr  >
                                      <td class="cs-name" style="width: 150px;">样品编号：</td>
                                      <td class="cs-in-style" style="width: 210px;">
                                          <input  type="text" class="disabled-style" name="samplingDetailCode" disabled="disabled"/>
                                      </td>
                                      <td></td>
                                  </tr>
                                  <tr>
                                      <td class="cs-name">样品名称：</td>
                                      <td class="cs-in-style">
                                          <input  type="text" class="disabled-style"  name="foodName" disabled="disabled"/>
                                      </td>
                                      <td></td>
                                  </tr>
                                  <tr>
                                      <td class="cs-name">检测项目：</td>
                                      <td class="cs-in-style">
                                          <input  type="text" class="disabled-style" name="itemName" disabled="disabled"/>
                                      </td>
                                      <td></td>
                                  </tr>
                                  <tr>
                                      <td class="cs-name"><i class="cs-mred">*</i>备注：</td>
                                      <td class="cs-in-style">
                                          <textarea class="cs-remark" name="remark" cols="30" rows="10" datatype="*" nullmsg="请输入备注" errormsg="请输入备注" maxlength="180"></textarea>
                                      </td>
                                      <td></td>
                                  </tr>
                              </table>
                          </form>
                      </div>
                  </div>
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-success" id="submit2">确定</button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
              </div>
          </div>
      </div>
  </div>

    <%@include file="/WEB-INF/view/common/modalBox.jsp" %>
    <%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp"%>
	
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/unqualified.js" ></script>
<script type="text/javascript">
    var rootPath="${webRoot}";
    var datagrid1 = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: '${webRoot}'+"/dataCheck/unqualified/datagrid.do",
        funColumnWidth:'80px',
        tableBar: {
            title: ["不合格处理","处理中"],
            hlSearchOff: 0,
            ele: [{
                eleShow: Permission.exist("382-9"),
                eleType: 4,
                eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">"+ Permission.getPermission("321-19").operationName +"：</span>" +
                    "<div class=\"cs-all-ps\">\n" +
                    "            <div class=\"cs-input-box\">\n" +
                    "                <input type=\"text\" name=\"departNames\" autocomplete=\"off\">\n" +
                    "                <div class=\"cs-down-arrow\"></div>\n" +
                    "            </div>\n" +
                    "            <div class=\"cs-check-down cs-hide\" style=\"display: none;\">\n" +
                    "                <ul id=\"tree\" class=\"easyui-tree\"></ul>\n" +
                    "            </div>\n" +
                    "        </div>" +
                    "</span>"
            },{
                eleShow: Permission.exist("382-5"),
                eleType: 4,
                eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">监管类型：</span>" +
                    "<span class=\"cs-input-style \" style=\"margin-left: 0px;\">" +
                    "<input type=\"hidden\" name=\"regTypeId\" value=\"\" id=\"regTypeIds\" class=\"focusInput\"/>" +
                    "<input type=\"text\" name=\"regTypeName\" class=\"choseRegType\" value=\"--全部--\" autocomplete=\"off\" style=\"width: 110px\" readonly/>" +
                    "</span>" +
                    "</span>"
            },{
                eleShow: 1,
                eleTitle: "范围",
                eleName: "treatmentDate",
                eleType: 3,
                eleStyle: "width:110px;",
                eleDefaultDateMin: newDate().DateAdd("m",-1).format("yyyy-MM-dd"),
                eleDefaultDateMax: newDate().format("yyyy-MM-dd")
            },{
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "编号、样品编号、被检单位、档口编号、样品名称、检测项目"
            }], init: function () {
                //选择行政区
                $('#tree').tree({
                    checkbox: false,
                    url: "${webRoot}/detect/depart/getDepartTree.do",
                    animate: true,
                    onLoadSuccess: function (node, data) {
                        if (data.length > 0) {
                            $("input[name='departNames']").val(data[0].text);
                        }
                    },
                    onClick: function (node) {
                        var did = node.id;
                        $("input[name='departNames']").val(node.text);
                        $(".cs-check-down").hide();

                        datagrid1.addDefaultCondition("departId", did);
                        datagrid1.queryByFocus();
                    }
                });
            }
        },
		parameter: [
            {
                columnCode: "id",
                columnName: "编号",
                columnWidth: "90px",
                customElement: (Permission.getPermission("382-8") ? "<a class='text-primary cs-link check_reding_id'>?<a>" : "?" ),
            },

			{
				columnCode: "regName",
				columnName: "被检单位",
				query: 1
			},
			{
				columnCode: "ope_shop_code",
				columnName: "${systemFlag}"=="1" ? "摊位编号" : "档口编号",
                columnWidth: "7%",
				query: 1
			},
			{
				columnCode: "foodName",
				columnName: "样品名称",
				query: 1
			},
			{
				columnCode: "itemName",
				columnName: "检测项目",
				query: 1
			},
			{
				columnCode: "checkResult",
				columnName: "复检值",
                customStyle: "checkResult",
                columnWidth: "80px"
			},
			/* {
				//columnCode: "dealUser",
				columnCode: "supervisor",
				columnName: "处理人员"
			}, */
			{
				columnCode: "dealMethod",
				columnName: "处理状态",
				customVal: {"0":"<div class=\"text-info\">检测中</div>","1":"<div class=\"text-info\">已检测</div>"},
                columnWidth: "90px"
			},
			{
				columnCode: "recheckDepart",
				columnName: "复检机构"
			},
			{
				columnCode: "updateDate",
				columnName: "处理时间",
                columnWidth: "90px"
			}, {
                columnCode: "sampleCode",
                columnName: "抽样编号",
                columnWidth: "90px",
                customStyle: 'sampleCode',
            },
            {
                columnCode: "reloadFlag",
                columnName: "复检",
                columnWidth: "60px",
                customStyle: "reloadFlag",
                show: Permission.exist("382-7"),
                sortDataType: "int",
                customVal: {"0":"<a class='text-primary reload-zero'>0</a>", "default":"<a class='text-primary cs-link reloadCount'>?</a>"}
            }
		],
		funBtns: [
	    	{
                show: Permission.exist("382-1"),
                style: Permission.getPermission("382-1"),
	    		action: function(id){
	    			window.location = '${webRoot}'+"/dataCheck/unqualified/goHanding.do?id="+id;
	    		}
	    	},
            {
                //溯源
                show: Permission.exist("383-6"),
                style: Permission.getPermission("383-6"),
                action: function (id, row) {
                    showMbIframe("${webRoot}/dataCheck/recording/checkDetail.do?id=" + id);
                }
            },
            {
                //删除
                show: Permission.exist("382-6"),
                style: Permission.getPermission("382-6"),
                action: function (id, row) {
                    $("#deleteModal input[name='id']").val(row.dutId);
                    $("#deleteModal input[name='samplingDetailCode']").val(row.sampleCode);
                    $("#deleteModal input[name='foodName']").val(row.foodName);
                    $("#deleteModal input[name='itemName']").val(row.itemName);
                    $("#deleteModal textarea[name='remark']").val("");
                    $("#deleteModal").modal('toggle');
                }
            }
	    ],
	    defaultCondition: [
   	    	{
   				queryCode: "dealMethod",
   				queryVal: "0"
   			},
			{
				queryCode : "dataType",
				queryVal : 0
			}, {
				queryCode : "checkDateStartDateStr",
				queryVal : '${start}'
			} , {
				queryCode : "checkDateEndDateStr",
				queryVal : '${end}'
			} 
   	    ], onload: function (obj, pageData) {//加载成功之后才执行的方法
            if (obj) {
                for (var i = 0; i < obj.length; i++) {
                    /*if (obj[i].reloadFlag == 0) {//如果复检次数为0，取消复检次数的点击事件
                        $("tr[data-rowid=" + obj[i].id + "]").find(".reloadFlag").html(obj[i].reloadFlag);
                    }*/
                    if (!isNaN(parseFloat(obj[i].checkResult)) && isFinite(obj[i].checkResult)){//判断检测值是否为数字
                        $("tr[data-rowid=" + obj[i].id + "]").find(".checkResult").html(obj[i].checkResult+obj[i].checkUnit);
                    }
                }
            }
        }
	});
    datagrid1.queryByFocus();

    //删除数据
    var df = $("#deleteForm").Validform({
        tiptype:2,
        ajaxPost:true,
        callback:function(data){
            $.Hidemsg();
            $("#deleteModal").modal("toggle");
            if(data && data.success){
                datagrid1.queryByFocus();
            }else{
                $("#confirm-warnning .tips").text(data.msg);
                $("#confirm-warnning").modal('toggle');
            }
        }
    });
    $(document).on("click","#submit2",function(){
        df.ajaxPost();
    });
    </script>
  </body>
</html>
