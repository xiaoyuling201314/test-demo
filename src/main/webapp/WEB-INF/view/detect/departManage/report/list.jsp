<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style type="text/css">
        .cs-name {
            text-align: right;
        }

        .cs-warn-r .cs-add-new select, .cs-warn-r .cs-add-new2 select, .cs-warn-r input.cs-modal-input, .cs-warn-r .cs-in-style input[type=text], .cs-warn-r .cs-in-style input[type=date], .cs-warn-r .cs-in-style input[type=password], .cs-warn-r .cs-in-style textarea, .cs-warn-r .cs-selcet-style {
            width: 262px;
        }
        .icon-baogao1 {
            /*position: relative;*/
        }

        .tool-container {
            position: absolute;
            z-index: 120;
            display: none;
        }

        .tool-container.tool-top,
        .tool-container.tool-bottom {
            height: auto;
            padding: 2px;
        }

        .tool-items {
            white-space: nowrap;
        }

        .tool-items a {
            display: inline-block;
        }
        .showFile{
            margin:0 2px
        }
        .tool-container{
            border-radius: 4px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
<div class="cs-modal-box show-pdf cs-hide">

    <div class="cs-col-lg clearfix">
        <!-- 面包屑导航栏  开始-->
        <div class="cs-search-box cs-fr">

            <div class="cs-fr cs-ac">
                <%--                <a href="javascript:;" class="cs-menu-btn miss-btn"><i--%>
                <%--                        class="icon iconfont icon-xiazai"></i>下载</a>--%>
                <a class="cs-menu-btn miss-btn pwg"><i
                        class="icon iconfont icon-fanhui"></i>返回</a>
            </div>
        </div>
    </div>
    <div class="ui-pos-re ">
        <iframe src="" border="0" id="showPwt" value
                style="width: 100%;height: 100%; position: fixed;top: 40px;bottom: 0;"></iframe>
    </div>
</div>

<div class="cs-modal-box show-img cs-hide">

    <div class="cs-col-lg clearfix">
        <!-- 面包屑导航栏  开始-->
        <div class="cs-search-box cs-fr">

            <div class="cs-fr cs-ac">
                <%--                <a href="javascript:;" class="cs-menu-btn miss-btn"><i--%>
                <%--                        class="icon iconfont icon-xiazai"></i>下载</a>--%>
                <a class="cs-menu-btn miss-btn pwg"><i
                        class="icon iconfont icon-fanhui"></i>返回</a>
            </div>
        </div>
    </div>
    <div class="ui-pos-re" style="text-align: center;padding: 20px;overflow: auto;height: 100%;">
        <img src="" id="showImg" align="center" style="width: auto; max-height: 90%">
    </div>
</div>
<div id="dataList"></div>
<div id="my-container"></div>


<!-- 新增项目模态框_end   -->
<!-- 设置项目有效时间模态框_end   -->
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/jquery.form.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/Toolbar/js/jquery.toolbar.js"></script>
<script type="text/javascript">

    $("#regId").select2();
    rootPath = "${webRoot}/check/report/";
    <%--let aa = "${departArr}"--%>
    let departArr = eval('${departArr}')
    let jsonobj = {
        text:"全部",
        val:""
    }
    departArr.unshift(jsonobj)
    // xxoo2.push(jsonobj)
    <%--xxoo2.push(eval('${departArr}'))--%>
    console.log(departArr)
    <%--let departArr = eval("${departArr}")//eval('[{"text": "--全部--", "val": "1"}, { "text": "机构","val": "2"}]');--%>
    //进入界面加载数据
    $(function () {
        var dgu = datagridUtil.initOption({
            tableId: "dataList",
            tableAction: rootPath + "datagrid",
            funColumnWidth: "100px", 		//操作列宽度，默认100px
            tableBar: {
                title: ["检测报告管理", "检测报告查询"],
                hlSearchOff: 0,
                ele: [
                    {
                        eleTitle: "所属企业",
                        eleName: "departId",
                        eleType: 2,
                        eleOption: departArr,
                        eleStyle: "width:150px;"
                    },
                    {
                        eleShow: 1,
                        eleName: "keyWords",
                        eleType: 0,
                        elePlaceholder: "报告编号、被检单位"
                    }],
                topBtns: [{
                    show: Permission.exist("1524-1"),
                    style: Permission.getPermission("1524-1"),
                    action: function () {
                        // saveOrUpdate();
                        // saveOrUpdate2();
                    }
                }],
            },
            parameter: [
                {
                    columnCode: "reportNo",
                    columnName: "报告编号",
                    columnWidth: "15%",
                },
                {
                    columnCode: "regName",
                    columnName: "被检单位",
                },
                {
                    columnCode: "dataSize",
                    columnName: "检测数量",
                    columnWidth: "10%",
                },
                {
                    columnCode: "reportDate",
                    columnName: "生成日期",
                    columnWidth: "20%",
                    dateFormat: "yyyy-MM-dd"
                },
                {
                    columnCode: "createBy",
                    columnName: "创建人",
                    columnWidth: "10%",

                },
                {
                    columnCode: "state",
                    columnName: "生成状态",
                    customVal: {
                        0: "<span class=\"text-primary\">成功</span>",
                        1: "<span class=\"text-danger\">失败</span>"//
                    },
                    columnWidth: "8%",
                },
            ],

            funBtns: [

                {//检测报告
                    show: Permission.exist("1532-2"),
                    style: Permission.getPermission("1532-2"),
                    action: function (id, row) {
                        showLegalReport(row)
                    }
                }, {//下载
                    show: Permission.exist("1532-4"),
                    style: Permission.getPermission("1532-4"),
                    action: function (id, row) {
                        legalDownload(id);
                    }
                },
                {//编辑
                    show: Permission.exist("1524-2"),
                    style: Permission.getPermission("1524-2"),
                    action: function (id, row) {
                        saveOrUpdate2(id);
                    }
                },
                {//删除
                    show: Permission.exist("1524-3"),
                    style: Permission.getPermission("1524-3"),
                    action: function (id, row) {
                        idsStr = "{\"ids\":\"" + id.toString() + "\"}";
                        $("#confirm-delete").modal('toggle');
                    }
                }
            ],	//功能按钮
            bottomBtns: [
                {	//删除函数
                    show: Permission.exist("1524-3"),
                    style: Permission.getPermission("1524-3"),
                    action: function (ids) {

                        idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
                        idsStr2 = ids;
                        // idsStr= ids
                        console.log(idsStr);
                        if (!idsStr2.length) {
                            //$("#waringMsg>span").html("请选择要删除的行");
                            //$("#confirm-warnning").modal('toggle');
                            layer.msg("请选择要删除的行", {icon: 7});
                        } else {
                            $("#confirm-delete").modal('toggle');
                        }
                    }
                }
            ],
            before: function (rows, pageData) {
                var departId = $("#dataList select[name='usetType']").val();
                console.log("点击id2",departId)

            },
            onload: function (rows, pageData) {

                <%--if (rows) {--%>
                <%--    $('.toolbar-icons a').on('click', function(event) {--%>
                <%--        event.preventDefault();--%>
                <%--    });--%>

                <%--    $('.icon-baogao1').parents('td').addClass('samples');--%>


                <%--    $('.icon-baogao1').attr('data-id','1');--%>

                <%--    //监听鼠标悬停--%>
                <%--    $('.icon-baogao1').hover(function(e) {--%>
                <%--        //获取悬停的数据下标--%>
                <%--        let trIndex =  $(this).closest('tr').index();--%>
                <%--        //获取文件路径，多个逗号隔开--%>
                <%--        let filePathArr= rows[trIndex].filePath.split(",")--%>
                <%--        //多文件则展示相应图标，点击相应图标查看报告，否则不展示图标--%>
                <%--        if(filePathArr.length>1){--%>
                <%--            var cont =--%>
                <%--                '<div class="tool-container tool-bottom toolbar-default" data-id="1"><div class="tool-items"></div><div class="arrow" style="left: 50%; right: 50%;"></div></div>'--%>
                <%--            var html = '';--%>
                <%--            for (var j = 0; j<filePathArr.length; j++){--%>
                <%--                let filePath = filePathArr[j]--%>
                <%--                let img =""--%>
                <%--                if (filePath.indexOf(".doc") !== -1 || filePath.indexOf(".docx") !== -1) {--%>
                <%--                    img = "${webRoot}/plug-wechat/img/WORD.png"--%>
                <%--                } else if (filePath.indexOf(".pdf") !== -1) {//pdf预览--%>
                <%--                    img = "${webRoot}/plug-wechat/img/PDF.png"--%>
                <%--                } else if (filePath.indexOf(".jpg") !== -1 || filePath.indexOf(".png") !== -1 || filePath.indexOf(".GIF") !== -1 || filePath.indexOf(".bmp") !== -1 || filePath.indexOf(".tiff") !== -1) {//图片预览--%>
                <%--                    img = "${webRoot}/plug-wechat/img/PNG.png"--%>
                <%--                }--%>
                <%--                html += '<a  class="showFile" data-file='+filePathArr[j]+' data-id='+j+'><img src='+img+' alt=""  style="width: 16px;"></a>'--%>

                <%--            }--%>
                <%--        }--%>


                <%--        //清除--%>
                <%--        $('.tool-container').remove();--%>
                <%--        //插入tooltip--%>
                <%--        $(this).parents('.samples').append(cont)--%>
                <%--        $(this).parents('.samples').find('.tool-items').append(html)--%>

                <%--        var selfBar = $('.tool-container').width() / 2,--%>
                <%--            selfElem = $(this).outerWidth() / 2,--%>
                <%--            selfElemH = $(this).outerHeight(),--%>
                <%--            selfOffset = $(this).offset(),--%>
                <%--            arrowH = $('.arrow').outerHeight();--%>
                <%--        var x = selfOffset.left - selfBar + 5;--%>
                <%--        var y = selfOffset.top + selfElemH + arrowH / 2 + 5;--%>
                <%--        $('.tool-container').css({--%>
                <%--            display: 'block',--%>
                <%--            left: x,--%>
                <%--            top: y--%>
                <%--        });--%>
                <%--        $('.showFile').click(function(){--%>
                <%--            let file = $(this).attr("data-file");--%>
                <%--            if (file.indexOf(".doc") !== -1 || file.indexOf(".docx") !== -1) {//word预览--%>
                <%--                &lt;%&ndash;$(this).attr("href", "https://view.officeapps.live.com/op/view.aspx?src=" + "${webRoot}" + "/resources/" + file);&ndash;%&gt;--%>
                <%--                $("#showPwt").attr("src", "https://view.officeapps.live.com/op/view.aspx?src=" + "${webRoot}" + "/resources/" + file);--%>
                <%--                $('.show-pdf').show();--%>
                <%--            } else if (file.indexOf(".pdf") !== -1) {//pdf预览--%>
                <%--                $("#showPwt").attr("src", "${webRoot}/pdf/preview?file=" + "${webRoot}" + "/resources/" + file);--%>
                <%--                $('.show-pdf').show();--%>
                <%--                &lt;%&ndash;$(this).attr("href", "${webRoot}/pdf/preview?file=" + "${webRoot}" + "/resources/" + file);&ndash;%&gt;--%>
                <%--            } else if (file.indexOf(".jpg") !== -1 || file.indexOf(".png") !== -1 || file.indexOf(".GIF") !== -1 || file.indexOf(".bmp") !== -1 || file.indexOf(".tiff") !== -1) {//图片预览--%>
                <%--                $("#showPwt").attr("src", "${webRoot}" + "/resources/" + file);--%>
                <%--                $('.show-pdf').show();--%>
                <%--                &lt;%&ndash;$(this).attr("href", "${webRoot}" + "/resources/" + file);&ndash;%&gt;--%>
                <%--            }--%>
                <%--            $('.tool-container').remove();--%>
                <%--        })--%>

                <%--        // else {//下载--%>
                <%--        //     window.location.href = rootPath + "download" + $(this).data("id");--%>
                <%--        // }--%>

                <%--    }, function(e) {--%>
                <%--        if ($(this).data('id') != $('.tool-container').data('id')) {--%>
                <%--            $(this).parents('.samples').find('.tool-container').remove();--%>
                <%--        }--%>
                <%--    })--%>



                <%--    // $(document).on('click',function(e){--%>
                <%--    //     var _con = $('.tool-container')--%>
                <%--    //     //判断--%>
                <%--    //     if(!_con.is(e.target) && _con.has(e.target).length === 0){--%>
                <%--    //         $('.tool-container').remove();--%>
                <%--    //--%>
                <%--    //     }else{--%>
                <%--    //--%>
                <%--    //         return--%>
                <%--    //--%>
                <%--    //     }--%>
                <%--    // })--%>


                <%--}--%>
            }
        });
        dgu.queryByFocus();

    })

    // //跳转新增和修改页面
    function saveOrUpdate2(id) {

        showMbIframe(rootPath + "add" + (id ? id : ''));
    }

    //跳转新增和修改页面
    function saveOrUpdate(rid) {
        showMbIframe(rootPath + "add" + (rid ? rid : ''));
    }


    //查看检测报告
    function showLegalReport(row) {
        let fileUrl = row.filePath;//文件路径
        // let fileName = row.filePatnName//文件名
        let cc = fileUrl.split(",");//拆分文件路径为数组
        if (fileUrl) {

            if (cc[0].indexOf(".doc") !== -1 || cc[0].indexOf(".docx") !== -1) {//word预览
                $("#showPwt").attr("src", "https://view.officeapps.live.com/op/view.aspx?src=" + "${webRoot}" + "/resources/" + cc[0]);
                $('.show-pdf').show();
            } else if (cc[0].indexOf(".pdf") !== -1) {//pdf预览

                //$("#showPwt").attr("src", "${webRoot}" + "/resources/" + cc[0]);
                $("#showPwt").attr("src", "${webRoot}/pdf/preview?file=" + "${webRoot}" + "/resources/" + cc[0]);
                $('.show-pdf').show();
            } else if (cc[0].indexOf(".jpg") !== -1 || cc[0].indexOf(".png") !== -1 || cc[0].indexOf(".GIF") !== -1 || cc[0].indexOf(".bmp") !== -1 || cc[0].indexOf(".tiff") !== -1) {//图片预览
                $("#showImg").attr("src", "${webRoot}" + "/resources/" + cc[0]);
                $('.show-img').show();
            } else {//下载
                window.location.href = rootPath + "download" + $(this).data("id");
            }
        } else {
            //$("#confirm-warnning .tips").text("该数据未上传报告");
            //$("#confirm-warnning").modal('toggle');
            layer.msg("该数据未上传报告", {icon: 7});
        }
    }


    //提取报告附件
    function legalDownload(id) {
        //跳转后台进行文件下载
        window.location.href = rootPath + "download" + id;
    }

    /*$(document).on("click", ".quick_download", function () {
        //跳转后台进行文件下载
        window.location.href = rootPath + "download" + $(this).data("id");
    });*/
    $(".pwg").click(function () {
        $('.show-pdf').hide();
        $('.show-img').hide();

    })

</script>
<!-- 输入查询功能 -->

</body>
</html>
