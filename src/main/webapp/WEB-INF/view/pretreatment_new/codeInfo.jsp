<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
</head>
<body>

<div id="dataList"></div>

<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>

<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript" src="${webRoot}/js/scanner.js"></script>
<script type="text/javascript">
    //样品码编码
    var sampleRegExp = new RegExp("^(" + "${sampleBarCode}" + ")([0-9]){10}-[0-9]{2}$");
    //试管码编码
    var tubeRegExp = new RegExp("^(" + "${tubeBarCode}" + ")([0-9]){8}$");

   /* $(document).on("blur","input[name='keyWords']",function(event) {
        $("input[name='keyWords']").focus();
    });*/

    var init = 0;
    var dgu = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/newPretreatment/datagrid",
        tableBar: {
            title: ["订单管理","条码查询"],
            hlSearchOff: 0,
            ele: [
            {
                eleShow: 0,
                eleName: "sampleCode",
                eleType: 0,
                elePlaceholder: "样品码"
            },
          {
                eleShow: 0,
                eleName: "tubeCode",
                eleType: 0,
                elePlaceholder: "试管码"
            },{
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "请输入条码"
            }],
            topBtns: []
        },
        parameter: [
            {
                columnCode: "sampleCode",
                columnName: "样品码",
                columnWidth:" 126px;"
            },{
                columnCode: "orderNumber",
                columnName: "订单号",
                show:0
            }, {
                columnCode: "orderTime",
                columnName: "下单时间",
                sortDataType:"date"
            },{
                columnCode: "iuName",
                columnName: "送检单位"
            },

            {
                columnCode: "foodName",
                columnName: "样品名称"
            },
            {
                columnCode: "itemName",
                columnName: "检测项目"
            },
            {
                columnCode: "samplingTime",
                columnName: "收样时间",
                sortDataType:"date"
            }, {
                columnCode: "tubeCodeTime1",
                columnName: "前处理时间",
                sortDataType:"date"
            },
            {
                columnCode: "tubeCode1",
                columnName: "试管码Ⅰ"
            },
            {
                columnCode: "tubeCode2",
                columnName: "试管码Ⅱ"
            }
        ],
        before: function (queryType) {   //处理输入条码
            var thisCode = $("input[name='keyWords']").val().toUpperCase();
            //样品码
            if(sampleRegExp.test(thisCode)){
                dgu.addDefaultCondition("sampleCode", thisCode);
                dgu.addDefaultCondition("tubeCode", "");
                //试管码
            }else if(tubeRegExp.test(thisCode)){
                dgu.addDefaultCondition("sampleCode", "");
                dgu.addDefaultCondition("tubeCode", thisCode);
                //其他
            }else if (thisCode) {
                tips("无效条码:"+thisCode);
                $("input[name='keyWords']").val("");
                return false;
            }else if (init != 0) {
                return false;
            }
            init++;
        },
        onload: function (rows) {
            var keyWords = $("input[name='keyWords']").val();
            if (keyWords && (!rows || rows.length<=0)){
                tips("无法找到条码信息");
            }
            $("input[name='keyWords']").val("");
        }
    });
    $(function () {
        dgu.queryByFocus();
        $("input[name='keyWords']").focus();
        scanner.open({
            scanFunction: function (scanText) {
                $("input[name='keyWords']").val(scanText);
                dgu.queryByFocus();
            }
        });
    });
    /** 绑定回车键绑定事件，当用户按了回车键，就提交表单 */
    $(document).keydown(function(event){
        if (event.keyCode === 13){ // 等于13代表按了回车键
            dgu.queryByFocus();
        }
    });
</script>
</body>
</html>
