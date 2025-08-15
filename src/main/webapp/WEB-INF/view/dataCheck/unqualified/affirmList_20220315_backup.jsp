<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<link href="${webRoot}/plug-in/video/css/video-js.css" rel="stylesheet">

<html>
<head>
    <title>快检服务云平台</title>
    <style>
        /*#myVideos {*/
        /*    width: 800px;*/
        /*    margin: 0 auto;*/
        /*}*/
    </style>
</head>
<body>
<%--

<div class="cs-col-lg clearfix">
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:;">不合格处理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">已处理
        </li>
    </ol>
    <div class="cs-search-box cs-fr">
        <form action="datagrid.do">
            <select class="cs-selcet-style cs-fl" style="display: none;" id="regType" onchange="changeRegType();">
            </select>
            <span class="check-date cs-fl" style="display: inline;">
					<span class="cs-name">时间范围:</span> 
					<span class="cs-in-style cs-time-se cs-time-se">
						<input name="checkDateStartDateStr" id="start" style="width: 110px;" class="cs-time  focusInput" type="text"
                               onclick="WdatePicker()" datatype="date" value="${start}" onchange="changeVAL1()">
						<span style="padding: 0 5px;">至</span> 
						<input name="checkDateEndDateStr" id="end" style="width: 110px;" class="cs-time  focusInput" type="text"
                               onclick="WdatePicker()" datatype="date" value="${end}" onchange="changeVAL2()">
					</span>
				</span>
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="regName" placeholder="请输入样品编号、被检单位、档口编号、样品名称或检测项目"/>
                <input type="hidden" class="cs-input-cont cs-fl focusInput" name="dealMethod" value="1"/>

                <input type="button" onclick="datagridUtil.queryByFocus()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
        </form>
    </div>
</div>
--%>


<div class="icon iconfont" id="hidevideo"></div>

<!-- 列表 -->
<div class="cs-col-lg-table" id="totalId">
    <div id="dataList"></div>
    <div id="myVideos" class="show-media hide" onclick="videoHide(2)">
        <div class="media-position">
            <video id="video" class="video-js vjs-default-skin vjs-fluid   vjs-big-play-centered" controls preload="none"
                   data-setup='{}'>
                <source src="http://vjs.zencdn.net/v/oceans.mp4" type="video/mp4">
                </source>
                <source src="http://vjs.zencdn.net/v/oceans.webm" type="video/webm">
                </source>
                <source src="http://vjs.zencdn.net/v/oceans.ogv" type="video/ogg">
                <p class="vjs-no-js">视频编码格式或MIME类型不支持<a
                        href="http://videojs.com/html5-video-support/"> target="_blank">supports HTML5 video</a></p>
                </source>
            </video>
        </div>
    </div>
    <div id="seeimg" class="hide show-media" onclick="videoHide(1)">
        <img style="height: 80%" src="">
    </div>
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
                        <form id="deleteForm" method="post" action="${webRoot}/dataCheck/unqualified/delete">
                            <input type="hidden" name="id">
                            <table class="cs-add-new">
                                <tr>
                                    <td class="cs-name" style="width: 150px;">样品编号：</td>
                                    <td class="cs-in-style" style="width: 210px;">
                                        <input type="text" class="disabled-style" name="samplingDetailCode" disabled="disabled"/>
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

<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp" %>

<script src="${webRoot}/plug-in/video/js/video.js"></script>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">
    function getVideoInfo() {
        var video = $('video');
        var videoH = video[0].videoHeight;
        var videoW = video[0].videoWidth;
        var frameH = $(window.parent.document).find("#main_iframe").height();
        var frameW = $(window.parent.document).find("#main_iframe").width();

        var videoRatio = videoH / videoW;
        var videoRatio2 = videoW / videoH;
        if (videoH != 0) {
            if (videoH > videoW) {
                $('#video').css({
                    'height': frameH,
                    'max-height': frameH
                });

                $('#video').width(frameH / videoRatio);
            } else {
                $('#video').css({
                    'height': frameH,
                });
                $('#video').width( frameH / videoRatio2);
            }
        }

        window.onresize = function () {
            $('#video').css({
                'height': frameH,
                'max-height': frameH
            });

        }
    }
    var datagrid1 = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/dataCheck/unqualified/datagrid.do",
        funColumnWidth:'80px',
        tableBar: {
            title: ["不合格处理", "已处理"],
            hlSearchOff: 0,
            ele: [{
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
                elePlaceholder: "样品编号、被检单位、档口编号、样品名称、检测项目"
            }]
        },
        parameter: [
            {
                columnCode: "sampleCode",
                columnName: "样品编号",
                columnWidth: "90px",
                customStyle: 'sampleCode',
            },
            {
                columnCode: "regName",
                columnName: "被检单位",
                query: 1
            },
            {
                columnCode: "ope_shop_code",
                columnName: "${systemFlag}" == "1" ? "摊位编号" : "档口编号",
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
            /*{
             columnCode: "recheckValue",
             columnName: "复检值"
             },*/
            {
                columnCode: "recheckResult",
                columnName: "复检结果",
                columnWidth: "85px"
            },
            {
                columnCode: "udealType",
                columnName: "处理结果",
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
                columnWidth: "15%"
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
                columnWidth: '85px'
            },
            {
                columnCode: "reloadFlag",
                columnName: "复检",
                columnWidth: "60px",
                customStyle: "reloadFlag",
                show: Permission.exist("383-8"),
                sortDataType: "int",
                customElement: "<a class='text-primary cs-link reloadCount'>?<a>",
            }
        ],
        funBtns: [
            {
                show: Permission.exist("383-1"),
                style: Permission.getPermission("383-1"),
                action: function (id, row) {
                    window.location = '${webRoot}' + "/dataCheck/unqualified/handled.do?id=" + id;
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
                            if (url.indexOf(".png") >= 0 || url.indexOf(".jpg") >= 0 || url.indexOf(".jpeg") >= 0) {//图片
                                html = '<div class="cs-obtain cs-obtain2 cs-fl"><a ' + "onclick='openFile(" + '"' + 1 + '","' + url + '"' + ")'" + 'class="cs-img-link"><img src="${webRoot}/resources/' + url + '" title="取证材料" class="img-thumbnail" style="height:100%;"></a></div>';
                            } else if (url.indexOf(".mp4") >= 0) {//视频
                                html = '<div class="cs-obtain cs-obtain2 cs-fl img-thumbnail"><a ' + "onclick='openFile(" + '"' + 2 + '","' + url + '"' + ")'" + ' style="width:100%; height:100%; display:inline-block;" target="_blank"><i class="icon iconfont icon-shipin" style="height:100%;font-size:16px;"></i> </a></div>';
                            } else {
                                html = '<div class="cs-obtain cs-obtain2 cs-fl"><a href="${webRoot}/resources/' + url + '" class="cs-img-link" target="_blank"><i title="取证材料" class="img-thumbnail icon iconfont icon-baogao" style="height:100%;"></i></a></div>';
                            }
                            currentTd.append(html);
                        }
                    }
                    //add by xiaoyl 2022-02-28 如果复检次数为0，取消复检次数的点击事件
                    if (rows[i].reloadFlag == 0) {
                        $("tr[data-rowid=" + rows[i].id + "]").find(".reloadFlag").html(rows[i].reloadFlag);
                    }
                  /*  if (rows[i].id || rows[i].tbFiles) {//迭代出所有不为空的id
                        var files = rows[i].tbFiles;//拿到该文件对象集合
                        var currentTd = $("tr[data-rowid=" + rows[i].id + "]").find(".evidence_file");//获取当前对应行的TD
                        currentTd.html('');
                        for (var b = 0; b < files.length; b++) {
                            var html;
                            var url = files[b].filePath;
                            if (url.indexOf(".png") >= 0 || url.indexOf(".jpg") >= 0 || url.indexOf(".jpeg") >= 0) {//图片
                                html = '<div class="cs-obtain cs-obtain2 cs-fl"><a ' + "onclick='openFile(" + '"' + 1 + '","' + url + '"' + ")'" + 'class="cs-img-link"><img src="${webRoot}/resources/' + url + '" title="取证材料" class="img-thumbnail" style="height:100%;"></a></div>';
                            } else if (url.indexOf(".mp4") >= 0) {//视频
                                html = '<div class="cs-obtain cs-obtain2 cs-fl img-thumbnail"><a ' + "onclick='openFile(" + '"' + 2 + '","' + url + '"' + ")'" + ' style="width:100%; height:100%; display:inline-block;" target="_blank"><i class="icon iconfont icon-shipin" style="height:100%;font-size:16px;"></i> </a></div>';
                            } else {
                                html = '<div class="cs-obtain cs-obtain2 cs-fl"><a href="${webRoot}/resources/' + url + '" class="cs-img-link" target="_blank"><i title="取证材料" class="img-thumbnail icon iconfont icon-baogao" style="height:100%;"></i></a></div>';
                            }
                            currentTd.append(html);
                        }
                    }*/
                }
            }
        }
    });
    datagrid1.queryByFocus();

    /* //播放视频方法 delete by xiaoyl 2020/12/11 播放视频有问题，视频加载不出来或者播放窗口尺寸混乱
     function openFile(type, url) {
         if (type == 1) {
             $("#seeimg").find("img").attr("src", '${webRoot}/resources/' + url);
            $("#seeimg").removeClass("hide");
            // $("#dataList").addClass("hide");
            // var html = '<a onclick="videoHide(1)" class="cs-menu-btn"><i class=" icon iconfont icon-fanhui"></i>返回</a>';
            // $("#hidevideo").append(html);
        } else if (type == 2) {

            $("#hidevideo").html("");
            // var html = '<a onclick="videoHide(2)" class="cs-menu-btn"><i class=" icon iconfont icon-fanhui"></i>返回</a>';
            // $("#hidevideo").append(html);
            url = '${webRoot}/resources/' + url;
            videojs.options.flash.swf = "__JS__/video/video-js.swf";
            $("#MyVideoRUL").attr("src", url);


            var myPlayer = videojs("video");  //初始化视频
            myPlayer.src(url);  //重置video的src
            myPlayer.load(url);  //使video重新加载
            //特别提醒：如果使用JQuery的Load方法是无法重新加载的  请使用video.js中内置的load   如何使用请注意自己的调用域
            //video_html5_api 自适应
            var player = videojs('video_html5_api', {fluid: true}, function () {   //id="video"
                this.play();
            });
            $("#myVideos").removeClass("hide");
            // $("#dataList").addClass("hide");
            setTimeout(function(){
                getVideoInfo();
            },100)

        }
    }*/
    //播放视频方法 add by huangwb 2020/12/11
    function openFile(type, url) {
        if (type == 1) {
            $("#seeimg").find("img").attr("src", '${webRoot}/resources/' + url);
            $("#seeimg").removeClass("hide");
            // $("#dataList").addClass("hide");
            /*var html = '<a onclick="videoHide(1)" class="cs-menu-btn"><i class=" icon iconfont icon-fanhui"></i>返回</ a>';*/
            $("#hidevideo").append(html);
        } else if (type == 2) {

            $("#myVideos").removeClass("hide");//打开窗口

            url = '${webRoot}/resources/' + url;
            videojs.options.flash.swf = "__JS__/video/video-js.swf";
            // $("#MyVideoRUL").attr("src", url);

            //特别提醒：如果使用JQuery的Load方法是无法重新加载的  请使用video.js中内置的load   如何使用请注意自己的调用域
            //video 自适应
            var myPlayer = videojs('video', {
                fluid: true
            }, function () {   //id="video"
                this.play();
                this.on('loadeddata', function () {
                    setTimeout(function () {
                        getVideoInfo();
                    }, 200)
                })
            });

            myPlayer.src(url);  //重置video的src
            myPlayer.load(url);  //使video重新加载

        }
    }

    //点击隐藏视频pause(),同时调用暂停方法
    function videoHide(type) {
        if (type == 1) {
            // $("#dataList").removeClass("hide");
            $("#seeimg").addClass("hide");

        } else if (type == 2) {
            $('.media-position').on('click', function (e) {
                e.stopPropagation();
            });
            $('.show-media').on('click', function () {
                if ($(this).attr('id') == 'myVideos') {
                    $("#myVideos").addClass("hide");
                    $('#video_html5_api')[0].pause();
                    $(".vjs-remaining-time-display").html('0:00');
                    oneTime = true;
                }
            })
        }
        $("#hidevideo").html("");
    }

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
    //查看复检记录
    $(document).on("click",".reloadCount",function(){
        let id=$(this).parents(".rowTr").attr("data-rowid");
        let sampleCode=$(this).parents(".rowTr").find(".sampleCode").html();
        let returnURL=encodeURI("${webRoot}/dataCheck/unqualified/history?id="+id+"&sampleCode="+sampleCode);
        showMbIframe(returnURL);
    });
</script>
</body>
</html>
