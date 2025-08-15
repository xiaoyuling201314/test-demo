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
<%--<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:;">不合格处理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">已处理
        </li>
    </ol>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form action="datagrid.do">
            <select class="cs-selcet-style cs-fl" style="display: none;" id="regType" onchange="changeRegType();">
            </select>
            <span class="check-date cs-fl" style="display: inline;">
					<span class="cs-name">时间范围:</span> 
					<span class="cs-in-style cs-time-se cs-time-se">
						<input name="checkDateStartDateStr" id="start" style="width: 110px;" class="cs-time Validform_error focusInput" type="text"
                               onclick="WdatePicker()" datatype="date" value="${start}" onchange="changeVAL1()">
						<span style="padding: 0 5px;">至</span> 
						<input name="checkDateEndDateStr" id="end" style="width: 110px;" class="cs-time Validform_error focusInput" type="text"
                               onclick="WdatePicker()" datatype="date" value="${end}" onchange="changeVAL2()">
						&nbsp;
					</span>
				</span>
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="regName" placeholder="请输入内容"/>
                <input type="hidden" class="cs-input-cont cs-fl focusInput" name="dealMethod" value="1"/>

                <input type="button" onclick="datagridUtil.queryByFocus()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
        </form>
    </div>
</div>--%>
<div class="icon iconfont" id="hidevideo"></div>

<!-- 列表 -->
<div class="cs-col-lg-table" id="totalId">
    <div id="dataList"></div>
   <%-- <div id="myVideos" class="show-media hide" onclick="videoHide(2)">
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
    </div>--%>
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
        tableAction: "${webRoot}/dataCheck/unqualified/datagrid.do",
        funColumnWidth:'80px',
        tableBar: {
            title: ["不合格处理", "已处理归档"],
            hlSearchOff: 0,
            ele: [{
                eleShow: Permission.exist("1503-6"),
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
            /*{
             columnCode: "pointName",
             columnName: "检测机构"
             },*/
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
            },{
                columnCode: "checkResult",
                columnName: "复检值",
                customStyle: "checkResult",
                columnWidth: "80px"
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
                customVal: {
                    "1": "<div class=\"text-primary\">无异议</div>",
                    "2": "<div class=\"text-danger\">有异议</div>",
                    "3": "<div class=\"text-danger\">有异议</div>"
                }
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
            }, {
                columnCode: "sampleCode",
                columnName: "样品编号",
                columnWidth: "90px",
                customStyle: 'sampleCode',
                show:2
            },
            {
                columnCode: "reloadFlag",
                columnName: "复检",
                columnWidth: "60px",
                customStyle: "reloadFlag",
                show: Permission.exist("1503-4"),
                sortDataType: "int",
                customVal: {"0":"<a class='text-primary reload-zero'>0</a>", "default":"<a class='text-primary cs-link reloadCount'>?</a>"}
            }
        ],
        funBtns: [
            {
                show: Permission.exist("1503-1"),
                style: Permission.getPermission("1503-1"),
                action: function (id, row) {
                    showMbIframe("${webRoot}/dataCheck/unqualified/handled.do?id=" + id);
                    <%--window.location = '${webRoot}' + "/dataCheck/unqualified/handled.do?id=" + id;--%>
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

    //delete by xiaoyl 2022/03/14 采用轮播图方式查看取证材料
   /* //播放视频方法 add by huangwb 2020/12/11
   function openFile(type, url) {
       if (type == 1) {
           $("#seeimg").find("img").attr("src", '${webRoot}/resources/' + url);
			$("#seeimg").removeClass("hide");
			// $("#dataList").addClass("hide");
			/!*var html = '<a onclick="videoHide(1)" class="cs-menu-btn"><i class=" icon iconfont icon-fanhui"></i>返回</ a>';*!/
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
				this.on('loadeddata', function() {
						setTimeout(function () {
							getVideoInfo ();
						},100)
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

        } else if(type == 2){
            $('.media-position').on('click',function(e){
                e.stopPropagation();
            });
            $('.show-media').on('click',function(){
                if($(this).attr('id')=='myVideos'){
                    $("#myVideos").addClass("hide");
                    $('#video_html5_api')[0].pause();
					oneTime = true;
                }
            })
        }
        $("#hidevideo").html("");
    }


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
    }*/

</script>
</body>
</html>
