<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
<div class="cs-col-lg clearfix">
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt="" />
            <a href="javascript:">样品管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">条码信息</li>
    </ol>
    <div class="cs-search-box cs-fr">
        <form>
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入条码" οnkeyup="this.value=this.value.toUpperCase();" style="text-transform: uppercase;"/>
                <input class="cs-input-cont cs-fl focusInput" type="hidden" name="sampleCode" />
                <input class="cs-input-cont cs-fl focusInput" type="hidden" name="tubeCode" />
                <input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
            </div>
            <div class="clearfix cs-fr" id="showBtn"></div>
        </form>
    </div>
</div>

<div id="dataList"></div>


<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>

<script src="${webRoot}/js/datagridUtil2.js"></script>
<%--表单插件--%>
<script type="text/javascript" src="${webRoot}/js/jquery.form.js"></script>
<%--校验插件--%>
<script type="text/javascript" src="${webRoot}/plug-in/jquery.validation/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/jquery.validation/1.14.0/messages_zh.min.js"></script>
<script type="text/javascript">
    //样品码编码
    var sampleRegExp =  new RegExp("^("+"${sampleBarCode}"+")([0-9A-Z])*$");
    //试管码编码
    var tubeRegExp =  new RegExp("^("+"${tubeBarCode}"+")([0-9A-Z])*$");

    $("input[name='keyWords']").focus();
    $(document).on("blur","input[name='keyWords']",function(event) {
        $("input[name='keyWords']").focus();
    });

    var init = 0;
    var dgu = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/pretreatment/datagrid",
        // defaultCondition: [{
        //     queryCode: "sampleCode",
        //     queryVal: ""
        // },{
        //     queryCode: "tubeCode",
        //     queryVal: ""
        // }],
        parameter: [
            {
                columnCode: "sampleCode",
                columnName: "订单明细编号"
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
                columnCode: "collectTime",
                columnName: "收样时间",
                sortDataType:"date"
            },
            {
                columnCode: "bagCode",
                columnName: "样品码"
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
        // funBtns: [
        //     {	//查看
        //         show: Permission.exist("1439-2"),
        //         style: Permission.getPermission("1439-2"),
        //         action: function(id){
        //             addOrUpdateUnit(id);
        //         }
        //     }
        // ],
        before: function (queryType) {   //处理输入条码
            var thisCode = $("input[name='keyWords']").val().toUpperCase();

            //样品码
            if(sampleRegExp.test(thisCode)){
                $("input[name='sampleCode']").val(thisCode);
                $("input[name='tubeCode']").val("");

                //试管码
            }else if(tubeRegExp.test(thisCode)){
                $("input[name='sampleCode']").val("");
                $("input[name='tubeCode']").val(thisCode);

                //其他
            }else if (thisCode) {
                // $("#waringMsg>span").html("无效条码:"+thisCode);
                // $("#confirm-warnning").modal('show');
                tips("无效条码:"+thisCode);
                return false;
            }else if (init != 0) {
                return false;
            }

            init++;
        },
        onload: function (rows) {
            var keyWords = $("input[name='keyWords']").val();
            if (keyWords && (!rows || rows.length<=0)){
                // $("#waringMsg>span").html("无法找到条码信息");
                // $("#confirm-warnning").modal('show');
                tips("无法找到条码信息");
            }
            $("input[name='keyWords']").val("");
        }
    });
    dgu.query();

    //查看送检单位-用户
    $(document).on("click","._user_number",function(){
        showMbIframe("${webRoot}/inspUnitUser/list?inspUnitId="+$(this).parents(".rowTr").attr("data-rowId"));
    });
</script>
</body>
</html>
