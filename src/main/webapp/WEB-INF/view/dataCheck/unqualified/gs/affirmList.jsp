<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<link href="${webRoot}/plug-in/video/css/video-js.css" rel="stylesheet">

<html>
<head>
    <title>快检服务云平台</title>
    <style>

    </style>
</head>
<body>

<div class="icon iconfont" id="hidevideo"></div>

<!-- 列表 -->
<div class="cs-col-lg-table" id="totalId">
    <div id="dataList"></div>
</div>


<%-- 删除数据 --%>
<div class="modal modal2 fade intro2" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel">
    <div class="modal-dialog cs-mid-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="deleteModalLabel">删除</h4>
            </div>
            <div class="modal-body cs-mid-height">
                <div class="cs-tabcontent">
                    <div class="cs-content2">
                        <form id="deleteForm" method="post" action="${webRoot}/dataCheck/unqualified/gs/delete">
                            <input type="hidden" name="id">
                            <input type="hidden" name="delt">
                            <table class="cs-add-new">
                                <tr>
                                    <td class="cs-name" style="width: 150px;">编号：</td>
                                    <td class="cs-in-style" style="width: 210px;">
                                        <input type="text" class="disabled-style" name="check_recording_id" disabled="disabled"/>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="cs-name">样品名称：</td>
                                    <td class="cs-in-style">
                                        <input type="text" class="disabled-style" name="foodName" disabled="disabled"/>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="cs-name">检测项目：</td>
                                    <td class="cs-in-style">
                                        <input type="text" class="disabled-style" name="itemName" disabled="disabled"/>
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
<%--轮播图查看取证材料--%>
<%@include file="/WEB-INF/view/dataCheck/unqualified/affirmSwiperImage.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp" %>
<script src="${webRoot}/plug-in/video/js/video.js"></script>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/unqualified.js" ></script>
<script type="text/javascript">
    var rootPath="${webRoot}";
    //已处理数据列表加载
    var datagrid1 = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/dataCheck/unqualified/gs/datagrid.do",
        funColumnWidth: "70px",
        tableBar: {
            title: ["不合格处理", "已处理"],
            hlSearchOff: 0,
            ele: [{
                eleShow: Permission.exist("383-11"),
                eleType: 4,
                eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">"+ Permission.getPermission("383-11").operationName +"：</span>" +
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
            }, {
                eleShow: Permission.exist("383-5"),
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
            }],
            init: function () {
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
                customElement: (Permission.getPermission("383-9") ? "<a class='text-primary cs-link check_reding_id'>?<a>" : "?" ),
            },
            {
                columnCode: "regName",
                columnName: "被检单位",
                query: 1
            },
            {
                columnCode: "ope_shop_code",
                columnName: "${systemFlag}" == "1" ? "摊位编号" : "档口编号",
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
                columnName: "检测值",
                customStyle: "checkResult",
                show:2,
                columnWidth: "80px"
            },
            /*{
             columnCode: "recheckValue",
             columnName: "复检值"
             },*/
            {
                columnCode: "recheckResult",
                columnName: "复检结果",
                columnWidth: "85px",
                show: 2
            },
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
                show:2, //Permission.exist("383-8"),
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
                show: Permission.exist("383-1"),
                style: Permission.getPermission("383-1"),
                action: function (id, row) {
                    showMbIframe("${webRoot}/dataCheck/unqualified/gs/handled.do?id=" + id);
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
                show: Permission.exist("383-7"),
                style: Permission.getPermission("383-7"),
                action: function (id, row) {
                    //甘肃项目的已处理删除方法，根据检测数据ID进行删除
                    $("#deleteModal input[name='id']").val(row.id);
                    $("#deleteModal input[name='delt']").val(1);
                    $("#deleteModal input[name='check_recording_id']").val(row.id);
                    $("#deleteModal input[name='foodName']").val(row.foodName);
                    $("#deleteModal input[name='itemName']").val(row.itemName);
                    $("#deleteModal textarea[name='remark']").val("");
                    $("#deleteModal").modal('toggle');
                }
            }
        ],
        bottomBtns: [
            {
                //删除
                show: Permission.exist("383-13"),
                style: Permission.getPermission("383-13"),
                action: function (ids, rows) {
                    // var dutIds = "";
                    var rids0 = "";
                    var rids = "";
                    var foodNames = "";
                    var itemNames = "";
                    if (rows && rows.length>0) {
                        for (let i = 0; i < rows.length; i++) {
                            // dutIds += rows[i].dutId + ",";
                            rids0 += rows[i].id + ",";
                            rids += "[" + rows[i].id + "] ";
                            foodNames += "[" + rows[i].foodName + "] ";
                            itemNames += "[" + rows[i].itemName + "] ";
                        }

                        // dutIds = dutIds.substring(0, dutIds.length-1);
                        rids0 = rids0.substring(0, rids0.length-1);
                        rids = rids.substring(0, rids.length-1);
                        foodNames = foodNames.substring(0, foodNames.length-1);
                        itemNames = itemNames.substring(0, itemNames.length-1);
                    } else {
                        $("#confirm-warnning .tips").text("至少勾选一条数据");
                        $("#confirm-warnning").modal('toggle');
                        return false;
                    }

                    //旧的已处理删除方法，根据已处理删除主表的ID进行删除
                    $("#deleteModal input[name='id']").val(rids0);
                    $("#deleteModal input[name='delt']").val(2);
                    $("#deleteModal input[name='check_recording_id']").val(rids);
                    $("#deleteModal input[name='foodName']").val(foodNames);
                    $("#deleteModal input[name='itemName']").val(itemNames);
                    $("#deleteModal textarea[name='remark']").val("");
                    $("#deleteModal").modal('toggle');
                }
            },
            {
                //数据有效
                show: Permission.exist("383-12"),
                style: Permission.getPermission("383-12"),
                action: function (ids, rows) {
                    activationIds = "";
                    if (rows && rows.length>0) {
                        for (let i = 0; i < rows.length; i++) {
                            activationIds += rows[i].id + ",";
                        }
                        activationIds = activationIds.substring(0, activationIds.length-1);
                    } else {
                        $("#confirm-warnning .tips").text("至少勾选一条数据");
                        $("#confirm-warnning").modal('toggle');
                        return false;
                    }
                    $("#confirmModal .tips").text("仅支持超时处理数据，转换为正常数据，请确认转换？");
                    $("#confirmModal").modal('toggle');
                }
            }
        ],
        defaultCondition: [
            {
                queryCode: "dealMethod",
                queryVal: "1"
            },
            {
                queryCode: "dataType",
                queryVal: 0
            }, {
                queryCode: "checkDateStartDateStr",
                queryVal: '${start}'
            }, {
                queryCode: "checkDateEndDateStr",
                queryVal: '${end}'
            }, {
                queryCode: "queryNoneFile",
                queryVal: '${queryNoneFile}'
            }
        ],
        onload: function (rows, pageData) {
            if (rows) {
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].id && rows[i].fFilePaths != '') {//迭代出所有不为空的id
                        var files = (rows[i].fFilePaths).split(",");//拿到该文件对象集合
                        var currentTd = $("tr[data-rowid=" + rows[i].id + "]").find(".evidence_file");//获取当前对应行的TD
                        currentTd.html('');
                        for (var b = 0; b < files.length; b++) {
                            var html;
                            var url = files[b];
                            // update by xiaoyl 2022-03-14 加载图片的缩略图
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

    //删除数据
    var df = $("#deleteForm").Validform({
        tiptype: 2,
        ajaxPost: true,
        callback: function (data) {
            $.Hidemsg();
            $("#deleteModal").modal("toggle");
            if (data && data.success) {
                datagrid1.queryByFocus();
            } else {
                $("#confirm-warnning .tips").text(data.msg);
                $("#confirm-warnning").modal('toggle');
            }
        }
    });
    $(document).on("click", "#submit2", function () {
        df.ajaxPost();
    });


    //数据有效
    var activationIds = '';
    function confirmModal(){
        $.ajax({
            type: "POST",
            url: "${webRoot}/dataCheck/unqualified/gs/activation",
            data: {"rids":activationIds},
            dataType: "json",
            success: function(data) {
                if (data && data.success) {
                    datagrid1.queryByFocus();
                } else {
                    $("#confirm-warnning .tips").text("判定数据有效失败！");
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }

</script>
</body>
</html>
