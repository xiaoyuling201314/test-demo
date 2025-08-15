<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style>
        .error {
            background-color: #ffe7e7;
        }
    </style>
</head>
<body>
<div id="dataList"></div>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">

    var datagrid1 = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/dataCheck/unqualified/datagridForRecheck.do",
        defaultCondition: [{			//附加请求参数
            queryCode: "id", 				//参数名
            queryVal: "${id}"						//参数值
        }],
        tableBar: {
            title: ["检测数据", "复检记录(${id})"],
            hlSearchOff: 0,
            ele: [
              /*  {
                    eleShow: 1,
                    eleName: "keyWords",
                    eleType: 0,
                    elePlaceholder: "样品名称、检测项目"
                },*/
                {
                    eleShow: 1,
                    eleType: 4,
                    eleHtml: '<a href="javascript:;" onclick="window.parent.closeMbIframe();" class="cs-menu-btn "><i class="icon iconfont icon-fanhui"></i>返回</a>'
                }]
        },
        parameter: [
            {
                columnCode: "id",
                columnName: "编号",
                columnWidth: "80px",
                // customElement: (Permission.exist("311-1") ? "<a class='text-primary cs-link' onclick='viewDetail(?);'>?</a>" : "?")
            },
          /*  {
                columnCode: "sampleCode",
                columnName: "样品编号",
                customVal: {
                    "default": "${sampleCode}",
                },
                columnWidth: "12%"
            },*/
            {
                columnCode: "pointName",
                columnName: "检测点",
                columnWidth: "12%"
            },
            {
                columnCode: "regName",
                columnName: "被检单位",
                columnWidth: "12%"
            },
            {
                columnCode: "regUserName",
                columnName: "${systemFlag}" === "1" ? "摊位编号" : "档口编号",
                columnWidth: "8%"
            },
            {
                columnCode: "foodName",
                columnName: "样品名称",
                columnWidth: "9%"
            },
            {
                columnCode: "itemName",
                columnName: "检测项目",
                // columnWidth: "13%"
            },
            {
                columnCode: "checkResult",
                columnName: "检测值",
                columnWidth: "75px",
                customStyle: "checkResult",
            },
            {
                columnCode: "conclusion",
                columnName: "检测结果",
                customVal: {"不合格": "<div class=\"text-danger\">不合格</div>","合格": "<div class=\"text-success\">合格</div>"},
                columnWidth: "80px"
            },
            // {
            //     columnCode: "checkUsername",
            //     columnName: "检测人员",
            //     columnWidth: "7%"
            // },
            {
                columnCode: "checkDate",
                columnName: "检测时间",
                columnWidth: "100px"
            },
            {
                columnCode: "uploadDate",
                columnName: "上传时间",
                columnWidth: "100px"
            },{
                columnCode: "sampleCode",
                columnName: "抽样编号",
                columnWidth: "86px",
                customVal: {
                    "default": "${sampleCode}",
                },
                customStyle: 'sampleCode',
                //吉安平台隐藏此列，lz云服务隐藏此列
                show: ((window.location.hostname == 'ja.chinafst.cn'||window.location.hostname == 'lz.chinafst.cn')? 0 : 1)
            },
        ],onload: function(obj,data){
            //add by xiaoyl 2022/04/07 加载列表后执行函数,处理检测值和检测单位合并成一列展示
            if (obj) {
                for (var i = 0; i < obj.length; i++) {
                    if (!isNaN(parseFloat(obj[i].checkResult)) && isFinite(obj[i].checkResult)){//判断检测值是否为数字
                        $("tr[data-rowid=" + obj[i].id + "]").find(".checkResult").html(obj[i].checkResult+obj[i].checkUnit);
                    }
                }
            }
        }
    });
    datagrid1.queryByFocus();
    //查看详情
    function viewDetail(id){
        showMbIframe("${webRoot}/dataCheck/recording/checkDetail.do?id=" + id);
    }
</script>
</body>
</html>
