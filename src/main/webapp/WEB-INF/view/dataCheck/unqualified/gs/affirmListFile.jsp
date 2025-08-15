<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<link href="${webRoot}/plug-in/video/css/video-js.css" rel="stylesheet">
<html>
<head>
    <title>快检服务云平台</title>
    <style>
     /*   #myVideos {
            width: 800px;
            margin: 0 auto;
        }*/
    </style>
</head>
<body>

<div class="icon iconfont" id="hidevideo"></div>

<!-- 列表 -->
<div class="cs-col-lg-table" id="totalId">
    <div id="dataList"></div>

</div>

<%--轮播图查看取证材料--%>
<%@include file="/WEB-INF/view/dataCheck/unqualified/affirmSwiperImage.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp" %>
<script src="${webRoot}/plug-in/video/js/video.js"></script>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/unqualified.js" ></script>
<script type="text/javascript">
    var rootPath="${webRoot}";
    $(function(){
        //注册加载失败事件,再次加载时先重新设置url,在清空原先的注册加载失败事件
        $("img").attr("onerror","this.src='${webRoot}/img/default.png;this.onerror=null;'");
    })
    //已处理数据列表加载
    var datagrid1 = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/dataCheck/unqualified/gs/datagrid.do",
        funColumnWidth:'70px',
        tableBar: {
            title: ["不合格处理", "已处理归档"],
            hlSearchOff: 0,
            ele: [{
                eleShow: Permission.exist("1503-3"),
                eleType: 4,
                eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">监管类型：</span>" +
                    "<span class=\"cs-input-style \" style=\"margin-left: 0px;\">" +
                    "<input type=\"hidden\" name=\"regTypeId\" value=\"\" id=\"regTypeIds\" class=\"focusInput\"/>" +
                    "<input type=\"text\" name=\"regTypeName\" class=\"choseRegType\" value=\"--全部--\" autocomplete=\"off\" style=\"width: 110px\" readonly/>" +
                    "</span>" +
                    "</span>"
            }, {
                eleShow: 1,
                eleTitle: "范围",
                eleName: "treatmentDate",
                eleType: 3,
                eleStyle: "width:110px;",
                eleDefaultDateMin: newDate().DateAdd("m", -1).format("yyyy-MM-dd"),
                eleDefaultDateMax: newDate().format("yyyy-MM-dd")
            }, {
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "编号、样品编号、被检单位、档口编号、样品名称、检测项目"
            }]
        },
        parameter: [
            {
                columnCode: "id",
                columnName: "编号",
                columnWidth: "90px",
                customElement: (Permission.getPermission("1503-5") ? "<a class='text-primary cs-link check_reding_id'>?<a>" : "?" ),
            },

            {
                columnCode: "regName",
                columnName: "被检单位",
                query: 1
            },
            {
                columnCode: "ope_shop_code",
                columnName: "${systemFlag}"=="1" ? "摊位编号" : "档口编号",
                columnWidth: "8%",
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
            },{
                columnCode: "checkResult",
                columnName: "检测值",
                customStyle: "checkResult",
                columnWidth: "80px",
                show:0
            },
            /*{
             columnCode: "recheckValue",
             columnName: "复检值"
             },
            {
                columnCode: "recheckResult",
                columnName: "复检结果"
            },*/
            {
                columnCode: "udealType",
                columnName: "处理结果",
                show:2,
                customVal: {
                    "1": "<div class=\"text-primary\">无异议</div>",
                    "2": "<div class=\"text-danger\">有异议</div>",
                    "3": "<div class=\"text-danger\">有异议</div>"
                },
                columnWidth: "85px"
            },
            {
                columnCode: "handName",
                columnName: "处理方式",
                columnWidth: "12%"
            },
            {
                columnCode: "updateDate",
                columnName: "处理时间",
                columnWidth: "90px"
            }, {
                columnCode: "evidenceFiles",
                columnName: "取证材料",
                customStyle: 'evidence_file',
                customElement: '<div></div>',
                columnWidth: '120px'
            },{
                columnCode: "sampleCode",
                columnName: "样品编号",
                columnWidth: "90px",
                customStyle: 'sampleCode',
                show: 2
            },
            {
                columnCode: "reloadFlag",
                columnName: "复检",
                columnWidth: "60px",
                customStyle: "reloadFlag",
                show:2, //Permission.exist("1503-4"),
                sortDataType: "int",
                customVal: {"0":"<a class='text-primary reload-zero'>0</a>", "default":"<a class='text-primary cs-link reloadCount'>?</a>"}
            }, {
                columnCode: "param6",
                columnName: "有效性",
                columnWidth: "60px",
                customVal: {"0":"<i title='正常数据'>有效</i>","1":"<i title='上传超时' class='text-danger'>无效</i>","2":"<i title='无附件' class='text-danger'>无效</i>","3":"<i title='超时且无附件' class='cs-danger'>无效</i>","4":"<i title='人工审核无效数据' class='text-danger'>无效</i>","5":"<i title='其他' class='text-danger'>无效</i>","9":"<i title='造假数据' class='text-danger'>无效</i>"},
                query: 1,
                show: 2,
            }, {
                columnCode: "handledAssessment",
                columnName: "考核状态",
                columnWidth: "90px",
                query: 1,
                sortDataType: "int",
                customVal: {
                    "0":"<i title='正常' class='text-success'>正常</i>",
                    "1":"<i title='#handledRemark#' class='text-danger'>超时未处理</i>",
                    "2":"<i title='#handledRemark#' class='text-danger'>超时处理</i>",
                    "3":"<i title='#handledRemark#' class='text-danger'>处理不规范</i>",
                    "4":"<i title='#handledRemark#' class='text-danger'>超时不规范</i>",
                    "5":"<i title='#handledRemark#' class='text-danger'>造假</i>",
                    "":"<i title=''></i>"
                },
            }
        ],
        funBtns: [
            {
                show: Permission.exist("1503-1"),
                style: Permission.getPermission("1503-1"),
                action: function (id, row) {
                    showMbIframe("${webRoot}/dataCheck/unqualified/gs/handled.do?id=" + id);
                }
            },
            {
                //溯源
                show: Permission.exist("1503-2"),
                style: Permission.getPermission("1503-2"),
                action: function (id, row) {
                    showMbIframe("${webRoot}/dataCheck/recording/checkDetail.do?id=" + id);
                }
            }
        ],

        defaultCondition: [
            {
                queryCode: "dealMethod",
                queryVal: "1"
            }, {//查询所有的已处理数据
                queryCode: "isQueryAllData",
                queryVal: "1"
            },
            {
                queryCode: "dataType",
                queryVal: 0
            }, {
                queryCode: "treatmentDateStartDate",
                queryVal: '${start}'
            }, {
                queryCode: "treatmentDateEndDate",
                queryVal: '${end}'
            }, {
                queryCode: "queryNoneFile",
                queryVal: '${queryNoneFile}'
            }
        ], onload: function (rows, pageData) {
            if (rows) {
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].id && rows[i].fFilePaths!='') {//迭代出所有不为空的id
                        var files = (rows[i].fFilePaths).split(",");//拿到该文件对象集合
                        var currentTd = $("tr[data-rowid=" + rows[i].id + "]").find(".evidence_file");//获取当前对应行的TD
                        currentTd.html('');
                        for (var b = 0; b < files.length; b++) {
                            var html;
                            var url = files[b];
                            let thumbnailPath = url.replace("Enforce/", "Enforce/thumbnail/");
                            if (url.indexOf(".png") >= 0 || url.indexOf(".jpg") >= 0 || url.indexOf(".jpeg") >= 0) {//图片
                                html = '<div class="cs-obtain cs-obtain2 cs-fl"><a ' + "onclick='openFile2(" + '"' + rows[i].fFilePaths + '","' + url + '"' + ")'" + 'class="cs-img-link"><img src="${webRoot}/resources/' + thumbnailPath + '" title="取证材料" class="img-thumbnail" style="height:100%;" onerror="this.src=\'${webRoot}/img/default.png\'"></a></div>';
                            } else if (url.indexOf(".mp4") >= 0) {//视频
                                html = '<div class="cs-obtain cs-obtain2 cs-fl img-thumbnail"><a ' + "onclick='openFile2(" + '"' + rows[i].fFilePaths + '","' + url + '"' + ")'" + ' style="width:100%; height:100%; display:inline-block;" target="_blank"><i class="icon iconfont icon-shipin" style="height:100%;font-size:16px;"></i> </a></div>';
                            } else {
                                html = '<div class="cs-obtain cs-obtain2 cs-fl"><a href="${webRoot}/resources/' + url + '" class="cs-img-link" target="_blank"><i title="取证材料" class="img-thumbnail icon iconfont icon-baogao" style="height:100%;"></i></a></div>';
                            }
                            currentTd.append(html);
                        }
                    }
                    //add by xiaoyl 2022-02-28 如果复检次数为0，取消复检次数的点击事件
                   /* if (rows[i].reloadFlag == 0) {
                        $("tr[data-rowid=" + rows[i].id + "]").find(".reloadFlag").html(rows[i].reloadFlag);
                    }*/
                    if (parseFloat(rows[i].checkResult).toString() != "NaN"){//判断检测值是否为数字
                        $("tr[data-rowid=" + rows[i].id + "]").find(".checkResult").html(rows[i].checkResult+rows[i].checkUnit);
                    }
                }
            }
        }
    });
    datagrid1.queryByFocus();
</script>
</body>
</html>
