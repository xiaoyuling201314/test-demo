<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style type="text/css">
        #content {
            width: 500px;
            height: 170px;
            margin: 100px auto;
        }

        #imgbox-loading {
            position: absolute;
            top: 0;
            left: 0;
            cursor: pointer;
            display: none;
            z-index: 0;
        }

        #imgbox-loading div {
            background: #FFF;
            width: 100%;
            height: 100%;
        }

        #imgbox-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: #000;
            display: none;
            z-index: 80;
        }

        .imgbox-wrap {
            position: absolute;
            top: 0;
            left: 0;
            display: none;
            z-index: 90;
        }

        .imgbox-img {
            padding: 0;
            margin: 0;
            border: none;
            width: 100%;
            height: 100%;
            vertical-align: top;
            border: 10px solid #fff;
        }

        .imgbox-title {
            padding-top: 10px;
            font-size: 11px;
            text-align: center;
            font-family: Arial;
            color: #333;
            display: none;
        }

        .imgbox-bg-wrap {
            position: absolute;
            padding: 0;
            margin: 0;
            display: none;
        }

        .imgbox-bg {
            position: absolute;
            width: 20px;
            height: 20px;
        }

        input[type="file"] {
            color: #666;
        }

        .code-form {
            position: relative;
        }

        .code-detail {
            position: absolute;
            left: 0;
            top: 4px;
            background-color: #fff;
            border: 1px solid #333;
            padding: 2px 5px;
            line-height: 20px;
            width: 200px;
        }
        .blue-btn{
            background: #478ad5;
            color: #fff;
        }
        .warning-btn{
            color: #fff;
            background-color: #f0ad4e;
            border-color: #eea236;
        }
        .danger-btn{
            color: #fff;
            background-color: #d9534f;
            border-color: #d43f3a;
        }
        .cs-fun-btn>.iconfont{
            color: #fff;
        }
    </style>
</head>

<body>
<div class="cs-maintab">
    <div class="cs-col-lg clearfix">
        <c:choose>
            <c:when test="${source eq 'monitor'}">
                <!-- 面包屑导航栏 开始-->
                <ol class="cs-breadcrumb">
                    <li class="cs-fl">
                        <img src="${webRoot}/img/set.png" alt="">
                        检测结果详情
                    </li>
                </ol>
            </c:when>
            <c:otherwise>
                <!-- 面包屑导航栏 开始-->
                <ol class="cs-breadcrumb">
                    <li class="cs-fl">
                        <img src="${webRoot}/img/set.png" alt="">
                        <a href="javascript:;">快检服务</a></li>
                    <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
                    <li class="cs-fl"><a href="javascript:;">检测数据</a></li>
                    <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
                    <li class="cs-fl"><a href="javascript:;">检测结果</a></li>
                    <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
                    <li class="cs-b-active cs-fl">检测结果详情
                    </li>
                </ol>
                <!-- 面包屑导航栏 结束-->
                <div class="cs-search-box cs-fr">
                    <div class="cs-fr cs-ac ">
                        <a id="yxsj" href="javascript:;" onclick="abnormalData(1);"
                           class="cs-menu-btn cs-fun-btn blue-btn" style="display: none;"><i class="icon iconfont icon-duigou"></i>有效数据</a>
                        <a id="wxsj" href="javascript:;" onclick="abnormalData(2);"
                           class="cs-menu-btn cs-fun-btn warning-btn" style="display: none;"><i class="icon iconfont icon-wuxiao text-warning"></i>无效数据</a>
                        <a id="zjsj" href="javascript:;" onclick="abnormalData(3);"
                           class="cs-menu-btn cs-fun-btn danger-btn" style="display: none;"><i class="icon iconfont icon-jia1 text-danger"></i>造假数据</a>
                        <a href="javascript:;" onclick="parent.closeMbIframe();"
                           class="cs-menu-btn "><i class="icon iconfont icon-fanhui"></i>返回</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="cs-tb-box">
        <div class="cs-base-detail">

            <div class="cs-content2 clearfix">
                <form class="registerform" action="">
                    <div class="cs-add-new cs-add-pad cs-input-bg">
                        <%--订单--%>

                        <h3>单位信息</h3>
                        <ul class="cs-ul-style clearfix">
                            <li class="cs-name cs-sm-w">送检单位：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.inspectionCompany}"
                                                                   name="inspectionCompany"/></li>

                            <li class="cs-name cs-sm-w">送检人名称：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.samplingUsername}"
                                                                   name="samplingUsername"/></li>

                            <li class="cs-name cs-sm-w">送检人联系方式：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.samplingUserPhone}"
                                                                   name="samplingUserPhone"/></li>

                            <c:if test="${!empty reqUnits}">
                                <c:forEach items="${reqUnits}" var="reqUnit">
                                    <li class="cs-name cs-sm-w">委托单位：</li>
                                    <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                           value="${reqUnit.requestName}"
                                                                           name="regName"/></li>

                                    <li class="cs-name cs-sm-w">委托单位联系方式：</li>
                                    <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                           value="${reqUnit.param1}"
                                                                           name="regLinkPhone"/></li>

                                    <li class="cs-name cs-sm-w"></li>
                                    <li class="cs-in-style cs-md-w"></li>
                                </c:forEach>
                            </c:if>
                        </ul>

                        <h3>检测信息</h3>
                        <ul class="cs-ul-style clearfix">
                                <%--<li class="cs-name cs-sm-w">检测编号：</li>
                                <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="${checkResult.checkCode}" name="checkCode" /></li>--%>

                            <li class="cs-name cs-sm-w">编号：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.id}" name="id"/></li>

                          <%--  <li class="cs-name cs-sm-w">检测编号：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.id2}" name="id"/></li>--%>

                                <%--				<li class="cs-name cs-sm-w">抽样单号：</li>--%>
                                <%--				<li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="${checkResult.samplingNo}" name="samplingNo" /></li>--%>

                            <li class="cs-name cs-sm-w">抽样编号：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.sampleCode}"
                                                                   name="sampleCode"/></li>

                            <li class="cs-name cs-sm-w">样品名称：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.foodName}"
                                                                   name="foodName"/></li>
                            <c:if test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
                                <li class="cs-name cs-sm-w">进货数量（kg）：</li>
                                <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                       value="${checkResult.purchaseAmount}"
                                                                       name="purchaseAmount"/></li>
                            </c:if>
                                <%--<li class="cs-name cs-sm-w">任务名称：</li>
                                <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="${checkResult.taskName}" name="taskName" /></li>--%>

                            <li class="cs-name cs-sm-w">检测项目：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.itemName}"
                                                                   name="itemName"/></li>

                            <li class="cs-name cs-sm-w">检测结果值：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.checkResult}"
                                                                   name="checkResult"/></li>

                            <li class="cs-name cs-sm-w">检测结果单位：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.checkUnit}"
                                                                   name="checkUnit"/></li>

                            <li class="cs-name cs-sm-w">检测标准：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.checkAccord}"
                                                                   name="checkAccord"/></li>

                            <li class="cs-name cs-sm-w">限定值：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.limitValue}"
                                                                   name="limitValue"/></li>

                            <li class="cs-name cs-sm-w">检测结论：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.conclusion}"
                                                                   name="conclusion"/></li>

                                <%--<li class="cs-name cs-sm-w">抽样数量（kg）：</li>
                                <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="${checkResult.sampleNumber}" name="sample_number" /></li>

                                <li class="cs-name cs-sm-w">进货数量（kg）：</li>
                                <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="${checkResult.purchaseAmount}" name="purchase_amount" /></li>--%>

                            <li class="cs-name cs-sm-w">检测机构：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.departName}"
                                                                   name="departName"/></li>

                            <li class="cs-name cs-sm-w">检测点：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.pointName}"
                                                                   name="pointName"/></li>

                            <li class="cs-name cs-sm-w">检测点地址：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.address}"
                                                                   name="address"/></li>

                            <li class="cs-name cs-sm-w">检测人员：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.checkUsername}"
                                                                   name="checkUsername"/></li>

                            <li class="cs-name cs-sm-w">检测时间：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="<fmt:formatDate type="both" value="${checkResult.checkDate}"/>"
                                                                   name="checkDate"/></li>

                            <li class="cs-name cs-sm-w show-codes">数据来源：</li>
                            <li class="cs-in-style cs-md-w code-form"><input type="text" disabled="disabled"
                                                                             value="${checkResult.dataSource}"
                                                                             name="sampleNumber"/></li>

                            <li class="cs-name cs-sm-w">备注：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.remark2}"/></li>

                                <%--<li class="cs-name cs-sm-w">上报人员：</li>
                                <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="${checkResult.uploadName}" name="uploadName" /></li>

                                <li class="cs-name cs-sm-w">上报时间：</li>
                                <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="<fmt:formatDate type="both" value="${checkResult.uploadDate}"/>" name="uploadDate" /></li>--%>
                        </ul>

                        <h3 class="device_info cs-hide">检测设备</h3>
                        <ul class="cs-ul-style clearfix device_info cs-hide">

                            <li class="cs-name cs-sm-w">仪器名称：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.deviceName}" name="deviceName"/>
                            </li>

                            <%-- <li class="cs-name cs-sm-w">仪器编号：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="${checkResult.deviceCode}" name="deviceCode" /></li> --%>

                            <li class="cs-name cs-sm-w">检测模块：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.deviceModel}"
                                                                   name="deviceModel"/></li>

                            <li class="cs-name cs-sm-w">检测方法：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.deviceMethod}"
                                                                   name="deviceMethod"/></li>

                            <li class="cs-name cs-sm-w">仪器厂家：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.deviceCompany}"
                                                                   name="sampleNumber"/></li>

                            <li class="cs-name cs-sm-w">检测地址：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="" name="checkAddress"/></li>

                        </ul>
                    </div>


                    <div id="paramDiv" class="cs-add-new cs-hide">
                        <h3>预留字段</h3>
                        <ul class="cs-ul-style clearfix">
                            <li class="cs-name cs-sm-w">预留字段1：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.param1}"/></li>

                            <li class="cs-name cs-sm-w">预留字段2：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.param2}"/></li>

                            <li class="cs-name cs-sm-w">预留字段3：</li>
                            <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled"
                                                                   value="${checkResult.param3}"/></li>
                        </ul>
                    </div>

                </form>
            </div>

        </div>
    </div>
    <!-- 底部导航 结束 -->
    <div class="cs-hd"></div>
    <c:choose>
    <c:when test="${source ne 'monitor'}">
    <div class="cs-alert-form-btn">
        <a href="javascript:;" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i
                class="icon iconfont icon-fanhui"></i>返回</a>
    </div>
    </c:when>
    </c:choose>

    <%-- 查看检测凭证  --%>
    <div id="seeimg" class="hide show-media" onclick="$('#seeimg').addClass('hide');">
        <img style="height: 80%" src="">
    </div>

    <!-- 无效数据或造假数据 -->
    <div class="modal fade intro2" id="abnormalDataModal" tabindex="-1" role="dialog" aria-labelledby="abnormalDataModalLabel" data-backdrop="static">
        <div class="modal-dialog cs-sm-width" role="document">
            <div class="modal-content ">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="abnormalDataModalLabel">判定数据</h4>
                </div>
                <div class="modal-body cs-sm-height">
                    <div class="cs-tabcontent">
                        <div class="cs-content2">
                            <form id="abnormalDataForm" method="post" action="${webRoot}/dataCheck/recording/judge">
                                <input type="hidden" name="rid" value="${checkResult.id}">
                                <table class="cs-add-new">
                                    <tr>
                                        <td class="cs-name">数据判定：</td>
                                        <td class="cs-in-style" colspan="2">
                                            <input type="text" class="disabled-style sjpd" disabled="disabled"/>
                                            <input type="hidden" class="disabled-style" name="param6"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="cs-name"><i class="cs-mred">*</i>备注：</td>
                                        <td class="cs-in-style">
                                            <textarea class="cs-remark" name="remark" cols="30" rows="10"
                                                      datatype="*" nullmsg="请输入备注" errormsg="请输入备注"></textarea>
                                        </td>
                                        <td><span class="Validform_checktip"></span></td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" id="abnormalDataSubmit">确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <%-- 提示窗 --%>
    <div class="modal fade intro2" id="confirm-warnning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog cs-alert-width">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">提示</h4>
                </div>
                <div class="modal-body cs-alert-height cs-dis-tab">
                    <div class="cs-text-algin" id="waringMsg">
                        <img src="${webRoot}/img/warn.png" width="40px" alt="" />
                        <span class="tips">操作失败</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success btn-ok" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

<%--    <script src="${webRoot}/js/jquery.min.js"></script>--%>
<%--    <script src="${webRoot}/js/jquery.imgbox.pack.js"></script>--%>
    <script>
        $(function () {
            //检测地址
            var param8 = '${checkResult.param8}';
            if (param8) {
                var param8a = param8.split(",");
                if (param8a.length>2) {
                    $("input[name=checkAddress]").val(param8a[2]);
                }
            }

            //数据源提示
            var sourceTips = '<div class="code-detail">';
            switch ('${checkResult.dataSource}') {
                case '0':
                    sourceTips += '检测工作站</div>';
                    break;
                case '1':
                    sourceTips += '达元仪器上传</div>';
                    break;
                case '2':
                    sourceTips += '监管通APP</div>';
                    break;
                case '3':
                    sourceTips += '平台上传</div>';
                    break;
                case '4':
                    sourceTips += '导入</div>';
                    break;
                default:
                    sourceTips += '其他仪器上传</div>';
                    break;
            }
            $('.show-codes').dblclick(function () {
                $(this).next().append(sourceTips);
            });
            $('.show-codes').mouseout(function () {
                $('.code-detail').remove();
            });

            if (Permission.exist("311-18") || Permission.exist("22229-18")) {
                //隐藏溯源
                $("#traceability").remove();
            } else if ((Permission.exist("311-7") || Permission.exist("22229-7")) && $("#tzsy").length > 0) {
                //台账溯源
                $("#tzsy").show();
            } else {
                //抽样溯源
                $("#cysy").show();
            }

            //查看预留字段权限
            if (Permission.exist("311-9") || Permission.exist("22229-9")) {
                $("#paramDiv").show();
            } else {
                $("#paramDiv").remove();
            }

            //隐藏仪器信息
            if (Permission.exist("311-14") || Permission.exist("22229-14")) {
                $(".device_info").remove();
            } else {
                $(".device_info").show();
            }
            if("${source}"==""){//检测数据页面查看才能看到相应的权限
                //数据审核_有效
                if (Permission.exist("22229-20")) {
                    $("#yxsj").show();
                } else {
                    $("#yxsj").remove();
                }

                //数据审核_无效
                if (Permission.exist("22229-21")) {
                    $("#wxsj").show();
                } else {
                    $("#wxsj").remove();
                }

                //数据审核_造假
                if (Permission.exist("22229-22")) {
                    $("#zjsj").show();
                } else {
                    $("#zjsj").remove();
                }
            }
            // $(".cs-img-link").imgbox({
            //     'speedIn': 0,
            //     'speedOut': 0,
            //     'alignment': 'center',
            //     'overlayShow': true,
            //     'allowMultiple': false
            // });

            //无效数据、造假数据必填校验
            var adf = $("#abnormalDataForm").Validform({
                tiptype:2,
                ajaxPost:true,
                callback:function(data){
                    $.Hidemsg();
                    $("#abnormalDataSubmit").removeAttr("disabled");
                    if(data && data.success){
                        $("#abnormalDataModal").modal("hide");
                        location.reload();
                        window.parent.refreshDgu();
                    }else{
                        $("#confirm-warnning .tips").text(data.msg);
                        $("#confirm-warnning").modal('show');
                    }
                }
            });
            //提交无效数据、造假数据
            $(document).on("click","#abnormalDataSubmit",function(){
                $(this).attr("disabled","disabled");
                adf.ajaxPost();
            });

            //关闭编辑模态框前重置表单，清空隐藏域
            $('#abnormalDataModal').on('hidden.bs.modal', function(e) {
                adf.resetForm();
            });

        });

        //查看检测凭证
        function openFile(url) {
            $("#seeimg").find("img").attr("src", url);
            $("#seeimg").removeClass("hide");
        }

        //无效数据、造假数据
        function abnormalData(t) {
            //正常数据
            if (t==1) {
                $("#abnormalDataForm .sjpd").val("有效数据");
                $("#abnormalDataForm input[name=param6]").val("0");

            //无效数据
            } else if (t==2) {
                $("#abnormalDataForm .sjpd").val("无效数据");
                $("#abnormalDataForm input[name=param6]").val("4");

            //造假数据
            } else if (t == 3) {
                $("#abnormalDataForm .sjpd").val("造假数据");
                $("#abnormalDataForm input[name=param6]").val("9");
            } else {
                return;
            }
            $("#abnormalDataForm textarea[name=remark]").val("");
            $("#abnormalDataModal").modal("show");
        }

    </script>
</body>
</html>
