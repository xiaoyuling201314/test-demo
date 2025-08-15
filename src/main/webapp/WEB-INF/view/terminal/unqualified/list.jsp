<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>

<div id="dataList"></div>

<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript" src="${webRoot}/js/printTicket.js"></script>
<script type="text/javascript">
    var recordIdArrays=[];
    var csd = '${start}';
    var ced = '${end}';

    var dgu = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/unqualified/loadDatagrid.do",
        tableBar: {
            title: ["不合格管理","质量督导"],
            hlSearchOff: 0,
            ele: [{
                eleShow: Permission.exist("311-15"),
                eleTitle: "状态",
                eleName: "reloadFlag",
                eleType: 2,
                eleOption: [{"text":"待复检","val":"1"},{"text":"复检中","val":"2"},{"text":"已复检","val":"3"}],
                eleStyle: "width:85px;"
            },{
                eleShow: 1,
                eleTitle: "范围",
                eleName: "checkDate",
                eleType: 3,
                eleStyle: "width:110px;",
                eleDefaultDateMin: (!csd ? new newDate().DateAdd("m",-1).format("yyyy-MM-dd") : csd),
                eleDefaultDateMax: (!ced ? new newDate().format("yyyy-MM-dd") : ced)
            },{
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "订单编号、委托单位、样品名称、样品编号"
            }]
        },
        funColumnWidth:'70px',
        parameter: [{
                columnCode: "samplingNo",
                columnName: "订单编号",
                customStyle:"samplingNo",
                columnWidth: "15%",
                customElement: "<a class=\"cs-link text-primary pp\" href=\"javascript:;\">?</a>"
            }, {
                columnCode: "regName",
                columnName: "委托单位",
                customStyle:"regName",
                columnWidth: "12%",
            }, {
                columnCode: "foodName",
                columnName: "样品名称",
                customStyle:"foodName",
                columnWidth: "12%",
            },{
                columnCode: "sampleTubeCode",
                columnName: "样品编号",
                customStyle:"sampleTubeCode",
                columnWidth: "11%",
            }, {
                columnCode: "itemName",
                columnName: "检测项目",
                customStyle:"itemName",
                columnWidth: "12%",
            }, {
                columnCode: "checkResult",
                columnName: "检测结果值",
                customStyle:"checkResult",
                columnWidth: "10%",
            }, {
                columnCode: "conclusion",
                columnName: "检测结果",
                customStyle:"conclusion",
                customVal: {"不合格": "<div class=\"text-danger\">不合格</div>","合格": "<div class=\"text-success\">合格</div>"},
                columnWidth: "8%",
            }, {
                columnCode: "checkDate",
                columnName: "检测时间",
                queryType: "1",
                customStyle:"checkDate",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                columnWidth: "14%",
                sortDataType:"date"
            }, {
                columnCode: "checkUsername",
                columnName: "检测人员",
                customStyle:"checkUsername",
                columnWidth: "8%",
            }, {
                columnCode: "printCount",
                columnName: "打印次数",
                columnWidth: "8%",
                sortDataType:"int"
            }, {
                columnCode: "reloadFlag",
                columnName: "状态",
                columnWidth: "8%",
                customVal: {"1":"<span class='text-success'>待复检</span>","2":"<span class='text-success'>复检中</span>","3":"<span class='text-success'>已复检</span>"},
            }],
        funBtns: [
            {
                show: Permission.exist("1454-1"),
                style: Permission.getPermission("1454-1"),
                action: function (id) {
                    var printArray=[];
                    var samplingNo="";
                    recordIdArrays=[];
                    $("#dataList .rowTr").each(function () {
                        if(id==$(this).attr("data-rowid")){// $(this).find(".samplingNo").text()
                            samplingNo=$(this).find(".samplingNo").text();
                            var samplingDetail=new samplingObject($(this).attr("data-rowid"),$(this).find(".samplingNo").text(),$(this).find(".regName").text(),$(this).find(".foodName").text(),$(this).find(".itemName").text(),
                                $(this).find(".sampleTubeCode").text(),$(this).find(".checkResult").text(),$(this).find(".conclusion").text(),$(this).find(".checkUsername").text());
                            printArray.push(samplingDetail);
                        }else if ($(this).find(".samplingNo").text()==samplingNo && samplingNo!=""){
                            var samplingDetail=new samplingObject($(this).attr("data-rowid"),$(this).find(".samplingNo").text(),$(this).find(".regName").text(),$(this).find(".foodName").text(),$(this).find(".itemName").text(),
                                $(this).find(".sampleTubeCode").text(),$(this).find(".checkResult").text(),$(this).find(".conclusion").text(),$(this).find(".checkUsername").text());
                            printArray.push(samplingDetail);
                        }
                    });
                    sendMessage=printCertificate(printArray,0);//要打印的数据格式
                    sendCommand();
                    //打印完成，更新打印次数
                    idsStr = "{\"ids\":\""+recordIdArrays.toString()+"\"}";
                    updatePrintLog(idsStr);
                }
            }
        ],
        bottomBtns : [
            {
                show: Permission.exist("1454-1"),
                style: Permission.getPermission("1454-1"),
                action: function(ids){
                    var printArray=[];
                    var samplingNo="";
                    sendMessage="";//要打印的数据
                    recordIdArrays=[];
                    var printNumbers=0;
                    for(var i=0;i<ids.length;i++){

                        $("#dataList .rowTr").each(function () {
                            if($(this).attr("data-rowid")==ids[i]){
                                samplingNo=$(this).find(".samplingNo").text();
                                var samplingDetail=new samplingObject($(this).attr("data-rowid"),$(this).find(".samplingNo").text(),$(this).find(".regName").text(),$(this).find(".foodName").text(),$(this).find(".itemName").text(),
                                    $(this).find(".sampleTubeCode").text(),$(this).find(".checkResult").text(),$(this).find(".conclusion").text(),$(this).find(".checkUsername").text())
                                printArray.push(samplingDetail);
                            }else if($(this).find("input").prop("checked") && $(this).find(".samplingNo").text()==samplingNo && $(this).attr("data-rowid")!=ids[i]){
                                var samplingDetail=new samplingObject($(this).attr("data-rowid"),$(this).find(".samplingNo").text(),$(this).find(".regName").text(),$(this).find(".foodName").text(),$(this).find(".itemName").text(),
                                    $(this).find(".sampleTubeCode").text(),$(this).find(".checkResult").text(),$(this).find(".conclusion").text(),$(this).find(".checkUsername").text())
                                printArray.push(samplingDetail);
                            }
                        });
                        printNumbers+=printArray.length;
                        if(printArray.length>0)	{////若有数据先执行打印
                            if(i==ids.length-1 || printNumbers==ids.length){
                                sendMessage+= printCertificate(printArray,0);//拼接完所有数据进行打印
                                sendCommand();
                                //打印完成，更新打印次数
                                idsStr = "{\"ids\":\""+recordIdArrays.toString()+"\"}";
                                updatePrintLog(idsStr);
                                return;
                            }else{
                                sendMessage+= printCertificate(printArray,1);//凭借数据不立即打印
                                samplingNo="";
                                printArray=[];
                            }
                        }
                    }
                }
            }
        ],
        defaultCondition: [
            {
                queryCode: "conclusion",
                queryVal: "不合格"
            }, {
                queryCode: "reloadFlag",
                queryVal: "1"
            }
        ],
        onload: function(obj, pageData){
            if($("#dataList select[name='reloadFlag']").length>0 && $("#dataList select[name='reloadFlag']").val()<3){
                $(".cs-menu-btn").show();
                //计算合并行数
                var sampleTime = {};   //同一次送样，打印按钮合并行数(未打印)
                $.each(obj, function(index, value){
                    if (!sampleTime[value.samplingNo]){
                        sampleTime[value.samplingNo] = 1;
                    } else {
                        sampleTime[value.samplingNo] = sampleTime[value.samplingNo]+1;
                    }
                });

                //合并打印按钮
                $("#dataList tr").each(function () {
                    var cl = $(this).find("td:eq(1)").text();//检测结果
                    if (cl){
                        //首次打印
                        var st = $(this).find("td:eq(1)").text();//订单编号
                        var rcn = sampleTime[st];  //合并行数
                        delete sampleTime[st];
                        var dtr = $(this);

                        for(var j=0;j<rcn;j++){
                            if (j==0){
                                dtr.find("td:last").attr("rowSpan", rcn);
                                dtr.find(".1454-1").show();
                            } else {
                                dtr = dtr.next();
                                dtr.find("td:last").remove();
                            }
                        }
                    }
                });
            }else{
                $(".cs-menu-btn").hide();
                $(".rowTr").each(function(){
                    for(var i=0;i<obj.length;i++){
                        if($(this).attr("data-rowId") == obj[i].id){
                            $(this).find(".1454-1").hide();
                        }
                    }
                });
            }
        },
    });
    dgu.queryByFocus();

    var demo = $("#saveForm").Validform({
        callback: function (data) {
            $.Hidemsg();
            if (data.success) {
                $("#addModal").modal("hide");
                dgu.query();
            } else {
                $.Showmsg(data.msg);
            }
        }
    });
    // 新增或修改
    $("#btnSave").on("click", function () {
        demo.ajaxPost();
        return false;
    });
    //关闭编辑模态框前重置表单，清空隐藏域
    $('#addModal').on('hidden.bs.modal', function (e) {
        $.Hidemsg();
        var form = $("#saveForm");// 清空表单数据
        form.form("reset");
        $("input[name=id]").val("");
        $("input[name=detectItemCode]").val("");
    });

    // $("#dataList select[name='pointType']").change(function(){
    //     dgu.addDefaultCondition("reloadFlag", $(this).val());
    //     dgu.queryByFocus();
    // });

  	//查看检测详情
    $(document).on("click",".pp",function(){
    	showMbIframe('${webRoot}' + "/dataCheck/recording/checkDetail.do?id=" + $(this).parents(".rowTr").attr("data-rowId"));
    });
    /**
     * 查询检测标准信息
     */
    function getId(e) {
        var id = e;
        $.ajax({
            url: "${webRoot}/dataCheck/unqualified/queryById.do",
            type: "POST",
            data: {"id": id},
            dataType: "json",
            success: function (data) {
                var form = $('#saveForm');
                form.form('load', data.obj);
                $("[name=checked][value=" + data.obj.checked + "]").prop("checked", "checked");
            },
            error: function () {
                alert("操作失败");
            }
        })
    }

    //点击人员查看人员详细信息
    //查看人员考核
    $(document).on("click", ".dj", function () {
        if ($(this).html() > 0) self.location = "${webRoot}/dataCheck/unqualified/check_history?rid=" + $(this).parents(".rowTr").attr("data-rowId");
    });
    //******************************************* 打印凭证 start *******************************************
	function samplingObject(id,samplingNo,regName,foodName,itemName,sampleTubeCode,checkResult,conclusion,checkUsername){
                this.id=id;
    			this.samplingNo=samplingNo;
                this.regName=regName;
                this.foodName=foodName;
                this.itemName=itemName;
                this.sampleTubeCode=sampleTubeCode;
                this.checkResult=checkResult;
                this.conclusion=conclusion;
                this.checkUsername=checkUsername;
            }
    //打印收样凭证
    function printCertificate(samplingDetailArray,isPrintNow){
    	 var wtdw = samplingDetailArray[0].regName;    //委托单位名称
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
         var _text_left = 60;   //左边距(mm)
         sendMessage= "CODEPAGE UTF-8\r\n" +
             "DIRECTION 1\r\n" +
             "CLS\r\n" +
             "TEXT "+_text_left+",20,\"TSS24.BF2\",0,1.8,2,\"**********复检单**********\"\r\n" +
             "TEXT "+_text_left+",80,\"TSS24.BF2\",0,1,1,\"订单编号："+samplingDetailArray[0].samplingNo+"\"\r\n";

         _hight = 80;
         if (wtdwArr && wtdwArr.length>0){
             for (var j=0; j<wtdwArr.length; j++){
                 _hight = _hight + _line_hight;
                 if (j==0){
                     sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"委托单位："+wtdwArr[j]+"\"\r\n";
                 } else {
                     sendMessage+="TEXT "+(_text_left+120)+","+_hight+",\"TSS24.BF2\",0,1,1,\""+wtdwArr[j]+"\"\r\n";
                 }
                 
             }
         }
         var item_name;
         for(var i=0;i<samplingDetailArray.length;i++){
        	 recordIdArrays.push(samplingDetailArray[i].id);
        	 _hight = _hight + _line_hight;
        	 sendMessage+="BAR "+_text_left+","+(_hight-10)+",400,1\r\n";
        	 sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"样品名称："+samplingDetailArray[i].foodName+"\"\r\n";
        	 _hight = _hight + _line_hight;
        	 sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"样品条码："+samplingDetailArray[i].sampleTubeCode+"\"\r\n";
        	 
        	 item_name=samplingDetailArray[i].itemName;
        	 
        	 _hight = _hight + _line_hight;
        	 sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"检测项目："+item_name.substring(0,10)+"\"\r\n";
        	 _hight = _hight + _line_hight-20;
			    if(item_name.length>10){
			    	var j ;
			    	j=item_name.substring(10,item_name.length);
			    sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\""+"\"\r\n" +
			    "TEXT "+(_text_left+140)+","+_hight+",\"TSS24.BF2\",0,1,1,\""+j+"\"\r\n";
			  	}
        	 _hight = _hight + _line_hight;
        	 sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"检 测 值："+samplingDetailArray[i].checkResult+"\"\r\n";
        	 _hight = _hight + _line_hight;
        	 sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"检测结论："+samplingDetailArray[i].conclusion+"\"\r\n";
        	 _hight = _hight + _line_hight;
        	 sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"检测人员："+samplingDetailArray[i].checkUsername+"\"\r\n";
         }
         _hight = _hight + _line_hight;
    	 sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"督导签名：\"\r\n";
         _hight = _hight + _line_hight+50;
         sendMessage+="PRINT 1,1\r\n" +
         "SOUND 5,100\r\n" +
         "CUT\r\n"+
         "OUT \"ABCDE\"\r\n";

	     sendMessage = "SIZE "+_width+" mm, "+Math.floor(_hight/8)+" mm\r\n" + sendMessage;
	
	     console.log(sendMessage);
// 	     sendCommand();
// 	     //打印完成，更新打印次数
// 	     idsStr = "{\"ids\":\""+recordIdArrays.toString()+"\"}";
// 	     updatePrintLog(idsStr);
	     return sendMessage;
    }
    function updatePrintLog(idsStr) {
        $.ajax({
            type: "POST",
            url: '${webRoot}' + "/unqualified/updatePrintLog.do",
            data: JSON.parse(idsStr),
            dataType: "json",
            success: function (data) {
                console.log("更新成功");
                dgu.queryByFocus();
            },
            error: function (data) {
                $("#confirm-warnning").modal('toggle');
            }
        });
    }
    //******************************************* 打印凭证 end *******************************************
</script>
</body>
</html>
