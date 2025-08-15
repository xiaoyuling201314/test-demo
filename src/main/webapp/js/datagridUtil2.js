//获取主机地址之后的路径
var pathName = window.document.location.pathname;
//获取带"/"的项目名
var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
document.write("<script language=javascript src='" + projectName + "/js/dateUtil.js'></script>");
document.write("<script language=javascript src='" + projectName + "/js/selectRow.js'></script>");

/**
 * 数据列表工具
 * @author Dz
 *
 */
datagridObjs = {};
datagridUtil = (function(){
    return {
        /**
         * 初始化
         * @param d
         * @returns
         */
        initOption: function (d) {
            var dgObj = new datagridObj();
            return dgObj.initOption(d);
        },

        /**
         * 获取对象
         * @param hashcode
         * @returns
         */
        getDatagridObj: function(hashcode){
            if (hashcode) {
                return datagridObjs[hashcode];
            } else {
                return datagridObjs;
            }
        }
    }
})();

function datagridObj(){
    /**
     初始化参数 *必填
     var option = {
     tableId: "dataList", 		//* div_ID
     tableAction: "${webRoot}/pPersonnel/datagrid.do", 		//* 加载数据地址
     tableBar: {               //导航栏
        title: [name1,name2,......],    //名称
        hlSearchOff: 1,               //高级搜索开关，默认：开，0_关，1_开
        init: function(){}          //初始化导航栏时执行
        switchSearch: function(queryType){}        //切换高级搜索执行，0:高级搜索查询,1:关键词查询
        ele: [{                     //查询条件
            eleShow: 1, 			//是否显示，默认：是，0_否，1_是
            eleTitle: "",           //控件名称
            eleName: "",            //控件name
            eleClass: "",           //输入控件样式
            eleStyle: "",           //输入控件样式
            eleType: ,				//数据类型，默认:输入框;0:输入框、1:日期，默认格式[yyyy-MM-dd]、2:下拉输入框，与customVal一起使用、3:时间范围，默认格式[yyyy-MM-dd]，可以使用eleDateFormat格式）、4:html
            elePlaceholder: "",     //input输入框提示，数据类型0有效
            eleDateFormat: "",      //时间格式，数据类型1、3有效
            eleDefaultDate: "",     //默认时间，数据类型1有效
            eleDefaultDateMin: "",     //默认时间，数据类型3有效
            eleDefaultDateMax: "",     //默认时间，数据类型3有效
            eleOption: [{text,val,selected}],          //选项数据，数据类型2有效，selected非必填
            eleHtml: "",            //html，数据类型4有效
        }],
        topBtns: [{		        //头部按钮
         show: 1, 				//是否显示，默认：是，0_否，1_是
         style: {operationCode,functionIcon,operationName},		//操作权限对象
         action: function(ids, rows){}                          //执行函数，ids: 勾选rowId
        }],
        topInfo: html代码  //头部汇总信息
     },
     parameter: [ 			//* 表格列
     {
         columnCode: "name",	//* 字段
         columnName: "名称",		//* 列名
         columnWidth: "80px"		//列宽度
         show: 1,						//是否显示，默认：是，0_否，1_是，2_隐藏列
         query: 1,					//是否支持高级搜索，默认：否，0_否，1_是
         queryType: ,				//数据类型，默认:文字;0:文字、1:日期，默认格式[yyyy-MM-dd]、2:下拉输入框，与customVal一起使用、3:时间范围，默认格式[yyyy-MM-dd]，可以使用dateFormat格式）
         queryCode: ,				//查询条件参数名称 请求时替代 columnCode
         queryName: "",		        //控件名称，默认使用列名
         queryDateFormat: "",		//查询时间格式
         queryVal: ,					//查询条件参数值
         customVal: ,				//自定义值  格式:{"0":"是","1":"否","default":"是","is-null":"空值","non-null":"非空"}(无匹配值，默认为default)，自定义样式：{"0":"<span style='color:#009900;'>启用</span>","1":"<span style='color:#E53333;'>停用</span>"}
         customElement: ,			//包含 ? 或 #属性名# 的文本,queryCode对应的value自动替换文本中?       //对象属性名(例:id)替换html中#id#
         customStyle: ,				//自定义样式(css class)
         dateFormat: ,				//自定义时间格式
         sort: ,                     //是否排序，默认：是，0_否，1_是
         sortDataType: ,			    //排序数据类型（string, int, float, date, rate[比率格式：num1/num2 或 num1:num2]）
         rowSpan: ,      			//合并行 （1,2,3,4....）合并多行后请给第一列设置合并行数 onload: function () {$("#dataList_mainCheckBox").closest("th").attr("rowspan", "2");} 参考web_attendance_daily_statistics.jsp
         colsSpan: ,     			//合并列 （1,2,3,4....）
         columnSonName:  , 			    //合并列后设置所合并列的子列，前提是需要合并两行 格式: columnSonName: "子列1,子列2,子列3"
         onClickFunName:            //点击执行函数，传入参数(id, obj) （未完成）
         hideOverText:              //隐藏超出边框文字，0，显示，1隐藏，默认显示    (示例：用户管理-显示备注)
         tdTitle:                   //title信息,value自动替换文本中?    (示例：用户管理-显示备注)
     }],
     pageOff: 0,						//分页开关，默认：开，0_开，1_关
     rowIdCode: "rid", 				//使用指定字段设置为rowId，默认为id,
     advancedSearch: 0,             //高级搜索，默认：开，0_开，1_关
     defaultCondition: [{			//附加请求参数
         queryCode: "", 				//参数名
         queryVal: ""						//参数值
     }],
     funColumnWidth: "150px", 		//操作列宽度，默认100px
     funColumnStyle: "text-align: center;", 		//操作栏对齐方式，默认居中显示
     funBtns: [{							//操作按钮
         show: 1, 							//是否显示，默认：是，0_否，1_是
         style: {operationCode,functionIcon,operationName},		//操作权限对象
         action: function(id, row){}												//执行函数，id: rowId, row: 数据
     }],
     showFunBtns: 1,		//是否显示操作列，默认：是，0_否,1_是
     pageNo: 1,				//页码
     pageSize: 20,			//默认每页数据最大数量
     showQuery: 0, 		//是否打开搜索区域，默认：否，0_否，1_是
     bottomBtns: [{		//底部操作按钮
         show: 1, 				//是否显示，默认：是，0_否，1_是
         style: {operationCode,functionIcon,operationName},		//操作权限对象
         action: function(ids, rows){}												//执行函数，ids: 勾选rowId
     }],
     summary: {    //汇总
        summary1: "",   //例：金额合计688.40元
        summary2: [{    //例：金额合计：3688.40（元） |  已选订单合计：0（元）
            title: "",
            text: ""
        }]
     },
     before: function(queryType){},		//请求数据前执行函数，queryType(查询类型): 0_高级搜索,1:关键词查询
     loading: function(rows, pageData){},		//请求数据后加载数据前执行函数，rows: 表格数据；pageData：分页参数
     onload: function(rows, pageData){},					//加载数据后执行函数 rows: 表格数据；pageData：分页参数
     obj: {}	//返回数据
     };
     */
    this.initOption = function (option) {
        var datagridObj0 = this;

        //初始化状态，0：刷新整个页面，1：只刷新表格
        option["init"] = 0;

        //默认记录总数为0
        if (!option["rowTotal"]) {
            option["rowTotal"] = 0;
        }
        //默认每页数量为20
        if (!option["pageSize"]) {
            option["pageSize"] = window.localStorage.pageSize == null ? 20 : window.localStorage.pageSize;
        }
        //默认当前页序号为1
        if (!option["pageNo"]) {
            option["pageNo"] = 1;
        }
        //默认总页数为1
        if (!option["pageCount"]) {
            option["pageCount"] = 1;
        }
        //每页选择项ID
        if (!option["pageSizeSel"]) {
            //设置默认选择项ID,防止多列表页面ID重复
            option["pageSizeSel"] = option["tableId"] + "pageSizeSel";
        }
        //分页开关，默认：开，0_开，1_关
        if (!option["pageOff"]) {
            option["pageOff"] = 0;
        }
        //高级搜索，默认：开，0_开，1_关
        if (!option["advancedSearch"]) {
            option["advancedSearch"] = 0;
        }
        //页面跳转ID
        if (!option["toPageNo"]) {
            //设置默认页面跳转ID,防止多列表页面ID重复
            option["toPageNo"] = option["tableId"] + "toPageNo";
        }

        var datagridOption = option;
        //设置查询类型,默认关键词查询，0:高级搜索查询,1:关键词查询
        datagridOption['queryType'] = 1;

        //初始化时间范围，用于高级搜索
        for (var i = 0; i < datagridOption["parameter"].length; i++) {
            if (datagridOption["parameter"][i].queryType && datagridOption["parameter"][i].queryType == 3) {
                datagridOption["parameter"][i].queryVal = ["", ""];	//开始时间，结束时间
            }

            //默认开启排序功能
            if (!datagridOption["parameter"][i].sort && datagridOption["parameter"][i].sort != 0) {
                datagridOption["parameter"][i].sort = 1;
            }
            //默认排序数据类型
            if (!datagridOption["parameter"][i].sortDataType) {
                datagridOption["parameter"][i].sortDataType = 'string';
            }
        }
        datagridObj0.datagridOption = datagridOption;
        datagridObj0.hashcode = getHashCode(JSON.stringify(datagridObj0));
        datagridObjs[datagridObj0.hashcode] = datagridObj0;

        this.spliceHtml();

        return datagridObj0;
    };

    /**
     * 获取表格数据
     * @returns {*}
     */
    this.getData = function () {
        var datagridOption = this.datagridOption;
        return datagridOption["obj"];
    };

    /**
     * 拼接列表
     */
    this.spliceHtml = function () {
        var datagridOption = this.datagridOption;

        //加载数据前执行函数
        if (datagridOption["loading"]) {
            datagridOption["loading"](datagridOption["obj"], datagridOption["pageData"]);
        }

        //获取当前配置参数
        //初始化状态，0：刷新整个页面，1：只刷新表格
        var init = datagridOption["init"];
        var tableId = datagridOption["tableId"];
        var tableBar = datagridOption["tableBar"];
        var mTableContent = "m" + tableId + "Content";
        var mTableId = "m" + tableId;
        var parameter = datagridOption["parameter"];
        var funBtns = datagridOption["funBtns"];
        var showFunBtns = datagridOption["showFunBtns"];
        var rowTotal = datagridOption["rowTotal"];
        var pageSize = datagridOption["pageSize"];
        var pageNo = datagridOption["pageNo"];
        var pageOff = datagridOption["pageOff"];
        var pageCount = datagridOption["pageCount"];
        var obj = datagridOption["obj"];
        var pageData = datagridOption["pageData"];
        var showQuery = datagridOption["showQuery"];
        var onload = datagridOption["onload"];
        var funColumnWidth = datagridOption["funColumnWidth"];
        var funColumnStyle = datagridOption["funColumnStyle"];
        var bottomBtns = datagridOption["bottomBtns"];
        var summary = datagridOption["summary"];
        var pageSizeSel = datagridOption["pageSizeSel"];
        var toPageNo = datagridOption["toPageNo"];
        var rowIdCode = !datagridOption["rowIdCode"] ? "id" : datagridOption["rowIdCode"];

        var html = "";

        //清空列表
        if (init == 0) {
            $("#" + tableId).html("");
        }

        //拼接导航栏html
        if (init == 0 && tableBar) {
            var barTitle = tableBar.title;
            var barEle = tableBar.ele;
            var topBtns = tableBar.topBtns;
            var topInfo = tableBar.topInfo;

            html += "<div class=\"cs-col-lg clearfix\">";

            //导航栏名称
            if (barTitle) {
                html += "<ol class=\"cs-breadcrumb\">";
                for (var i = 0; i < barTitle.length; i++) {
                    if (i == 0) {
                        html += "<li class=\"cs-fl\"><img src='" + projectName + "/img/set.png'>"+barTitle[i]+"</li>";
                    } else if (i != barTitle.length-1) {
                        html += "<li class=\"cs-fl\"><i class=\"cs-sorrow\">&gt;</i></li>";
                        html += "<li class=\"cs-fl\">"+barTitle[i]+"</li>";
                    } else {
                        html += "<li class=\"cs-fl\"><i class=\"cs-sorrow\">&gt;</i></li>";
                        html += "<li class=\"cs-b-active cs-fl\">"+barTitle[i]+"</li>";
                    }
                }
                html += "</ol>";
            }

            //按钮
            html += "<div class=\"clearfix cs-search-box cs-fr\">";
            if (topBtns) {
                for (var i = 0; i < topBtns.length; i++) {
                    if (topBtns[i].show != 0) {
                        html += "<a class=\"cs-menu-btn\" href=\"javascript:;\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').topBtnFun('"+i+"')\">";
                        html += "<i class=\""+topBtns[i].style.functionIcon+"\"></i>"+topBtns[i].style.operationName;
                        html += "</a>";
                    }
                }
            }
            html += "</div>";

            //查询控件
            html += "<div class=\"cs-search-box cs-in-style  cs-fr\">";
            if (barEle) {
                for (var i = 0; i < barEle.length; i++) {
                    if (i == 0) {
                        html += "<form class=\"search-form pull-left\">";
                    }

                    if (barEle[i].eleShow != 0) {
                        if (barEle[i].eleTitle) {
                            html += "<span style=\"margin-left: 5px; float: left; line-height: 30px;\">"+barEle[i].eleTitle+"：</span>";
                        }
                        switch (barEle[i].eleType) {
                            case 1: //时间
                                // onchange=\"datagridUtil.getDatagridObj('"+this.hashcode+"').queryByFocus();\"
                                html += "<input type=\"text\" name=\""+barEle[i].eleName+"\" autocomplete=\"off\" ";
                                if (barEle[i].eleClass) {
                                    html += " class=\"cs-time focusInput "+barEle[i].eleClass+"\"";
                                } else {
                                    html += " class=\"cs-time focusInput\"";
                                }
                                if (barEle[i].eleStyle) {
                                    html += " style=\""+barEle[i].eleStyle+"\"";
                                }
                                if (barEle[i].eleDateFormat) {
                                    html += " onclick=\"WdatePicker({maxDate:'#F{\\'%y-%M-%d\\'}',dateFmt:'"+barEle[i].eleDateFormat+"'})\"";
                                } else {
                                    html += " onclick=\"WdatePicker({maxDate:'#F{\\'%y-%M-%d\\'}',dateFmt:'yyyy-MM-dd'})\"";
                                }
                                if (barEle[i].eleDefaultDate) {
                                    html += " value=\""+barEle[i].eleDefaultDate+"\"";
                                }
                                html += " >";
                                break;

                            case 2: //下拉框
                                html += "<select name=\""+barEle[i].eleName+"\" onchange=\"datagridUtil.getDatagridObj('"+this.hashcode+"').queryByFocus();\" ";
                                if (barEle[i].eleClass) {
                                    html += " class=\"cs-selcet-style focusInput "+barEle[i].eleClass+"\"";
                                } else {
                                    html += " class=\"cs-selcet-style focusInput\"";
                                }
                                if (barEle[i].eleStyle) {
                                    html += " style=\""+barEle[i].eleStyle+"\">";
                                } else {
                                    html += " >";
                                }
                                for(var ii=0;ii<barEle[i].eleOption.length;ii++){
                                    if (!barEle[i].eleOption[ii].selected) {
                                        html += "<option value=\""+barEle[i].eleOption[ii].val+"\">"+barEle[i].eleOption[ii].text+"</option>";
                                    } else {
                                        html += "<option value=\""+barEle[i].eleOption[ii].val+"\" selected=\""+barEle[i].eleOption[ii].selected+"\">"+barEle[i].eleOption[ii].text+"</option>";
                                    }
                                }
                                html += "</select>";
                                break;

                            case 3: //时间范围
                                //开始
                                html += "<div class=\"cs-time-se pull-left\"><input type=\"text\" id=\""+tableId+barEle[i].eleName+"Start\" name=\""+barEle[i].eleName+"StartDate\" autocomplete=\"off\" ";
                                if (barEle[i].eleClass) {
                                    html += " class=\"cs-time focusInput "+barEle[i].eleClass+"\"";
                                } else {
                                    html += " class=\"cs-time focusInput\"";
                                }
                                if (barEle[i].eleStyle) {
                                    html += " style=\""+barEle[i].eleStyle+"\"";
                                }
                                if (barEle[i].eleDateFormat) {
                                    html += " onclick=\"WdatePicker({maxDate:'#F{$dp.$D(\\'"+tableId+barEle[i].eleName+"End\\')||\\'%y-%M-%d\\'}',dateFmt:'"+barEle[i].eleDateFormat+"'})\" ";
                                } else {
                                    html += " onclick=\"WdatePicker({maxDate:'#F{$dp.$D(\\'"+tableId+barEle[i].eleName+"End\\')||\\'%y-%M-%d\\'}',dateFmt:'yyyy-MM-dd'})\" ";
                                }

                                if (barEle[i].eleDefaultDateMin) {
                                    html += " value=\""+barEle[i].eleDefaultDateMin+"\"";
                                }
                                html += ">&nbsp;至&nbsp;";

                                //结束
                                html += "<input type=\"text\" id=\""+tableId+barEle[i].eleName+"End\" name=\""+barEle[i].eleName+"EndDate\" autocomplete=\"off\" ";
                                if (barEle[i].eleClass) {
                                    html += " class=\"cs-time focusInput "+barEle[i].eleClass+"\"";
                                } else {
                                    html += " class=\"cs-time focusInput\"";
                                }
                                if (barEle[i].eleStyle) {
                                    html += " style=\""+barEle[i].eleStyle+"\"";
                                }
                                if (barEle[i].eleDateFormat) {
                                    html += " onclick=\"WdatePicker({minDate:'#F{$dp.$D(\\'"+tableId+barEle[i].eleName+"Start\\')}',maxDate:'#F{\\'%y-%M-%d\\'}',dateFmt:'"+barEle[i].eleDateFormat+"'})\" ";
                                } else {
                                    html += " onclick=\"WdatePicker({minDate:'#F{$dp.$D(\\'"+tableId+barEle[i].eleName+"Start\\')}',maxDate:'#F{\\'%y-%M-%d\\'}',dateFmt:'yyyy-MM-dd'})\" ";
                                }

                                if (barEle[i].eleDefaultDateMax) {
                                    html += " value=\""+barEle[i].eleDefaultDateMax+"\"";
                                }
                                html += "></div>";
                                break;
                            case 4: //html
                                html += barEle[i].eleHtml;
                                break;
                            default:    //文本
                                html += "<div class=\"cs-search-filter clearfix cs-fl\"><input type=\"text\" name=\""+barEle[i].eleName+"\" autocomplete=\"off\" ";
                                if (barEle[i].eleClass) {
                                    html += " class=\"cs-input-cont cs-fl focusInput keyWordsInput "+barEle[i].eleClass+"\"";
                                } else {
                                    html += " class=\"cs-input-cont cs-fl focusInput keyWordsInput\"";
                                }
                                if (barEle[i].eleStyle) {
                                    html += " style=\""+barEle[i].eleStyle+"\">";
                                }
                                if (barEle[i].elePlaceholder) {
                                    html += " placeholder=\""+barEle[i].elePlaceholder+"\">";
                                } else {
                                    html += " placeholder=\"请输入关键词\">";
                                }

                                html += "<input type=\"button\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').queryByFocus();\" class=\"cs-search-btn cs-fl\" href=\"javascript:;\" value=\"搜索\"></div>";
                                break;
                        }
                    }

                    if (tableBar.hlSearchOff != 0 && i == barEle.length-1) {
                        html += "</form><span class=\"cs-s-search cs-fl\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').hlSearch();\">高级<i class='searchBtn icon iconfont icon-xia2' style='font-size:14px;'></i></span>";
                    }
                }
            }
            html += "</div>";

            /* //汇总信息
             if (topInfo) {
                 html += topInfo;
             }
 */
            html += "</div>";
        }

        //拼接搜索栏html
        if (init == 0) {
            var queryNum = 0;	//查询条件数量
            var lineNum = 3;	//每行显示查询条件数量(可修改)
            for (var i = 0; i < parameter.length; i++) {
                if (parameter[i].query == 1) {
                    queryNum++;
                    //拼接搜索开始区域
                    if (queryNum == 1) {
                        if (showQuery && showQuery == 1) {
                            html += "<div class=\"cs-search-inform\">";
                        } else {
                            html += "<div class=\"cs-search-inform cs-add-pad cs-hide\"><form class=\"cs-add-new cs-search-all\">";
                        }
                    }

                    var queryNo = queryNum % lineNum;
                    //拼接换行开始符
                    if (queryNo == 1) {
                        html += "<div class=\"cs-row clearfix\">";
                    }

                    //拼接搜索框
                    html += "<div class=\"col-md-1 col-sm-1 cs-name\">" + (parameter[i].queryName ? parameter[i].queryName : parameter[i].columnName) + "：</div>";
                    //判断查询条件类型
                    if (!parameter[i].queryType || parameter[i].queryType == 0) {
                        //文本类型
                        html += "<div class=\"cs-in-style col-md-2 col-sm-2 cs-search-input\">";
                        html += "<input autocomplete=\"off\" class=\"" + tableId + "-qpinput\" name=\"";

                        //设置查询输入框 name属性
                        if (!parameter[i].queryCode) {
                            //默认input name
                            html += parameter[i].columnCode;
                        } else {
                            //自定义input name
                            html += parameter[i].queryCode;
                        }
                        html += "\" type=\"text\" ";

                        //设置查询值
                        if (parameter[i].queryVal) {
                            html += "value=\"" + parameter[i].queryVal + "\"";
                        }
                        html += "></div>";
                    } else if (parameter[i].queryType == 1) {
                        //日期类型
                        html += "<div class=\"cs-in-style col-md-2 col-sm-2 cs-search-input\">";
                        html += "<input class=\"cs-time " + tableId + "-qpinput\" name=\"";

                        //设置查询输入框 name属性
                        if (!parameter[i].queryCode) {
                            //默认input name
                            html += parameter[i].columnCode;
                        } else {
                            //自定义input name
                            html += parameter[i].queryCode;
                        }

                        //固定日期格式
                        html += "\" type=\"text\" onClick=\"WdatePicker({maxDate:'#F{\\'%y-%M-%d\\'}',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})\" autocomplete=\"off\" ";
                        //设置查询值
                        if (parameter[i].queryVal) {
                            html += "value=\"" + newDate(parameter[i].queryVal).format("yyyy-MM-dd") + "\"";
                        }
                        html += "></div>";

                    } else if (parameter[i].queryType == 2) {
                        //下拉框
                        html += "<div class=\"cs-in-style col-md-2 col-sm-2 cs-search-input\">";
                        html += "<select class=\"cs-selcet-style " + tableId + "-qpinput\" name=\"";

                        //设置查询输入框 name属性
                        if (!parameter[i].queryCode) {
                            //默认input name
                            html += parameter[i].columnCode;
                        } else {
                            //自定义input name
                            html += parameter[i].queryCode;
                        }
                        html += "\">";

                        //设置选项
                        if (parameter[i].customVal) {
                            html += "<option value=\"\">--请选择--</option>";
                            for (var key in parameter[i].customVal) {
                                if (parameter[i].queryVal && parameter[i].queryVal == key) {
                                    //设置查询值
                                    html += "<option value=\"" + key + "\" selected=\"selected\">" + parameter[i].customVal[key] + "</option>";
                                } else {
                                    html += "<option value=\"" + key + "\">" + parameter[i].customVal[key] + "</option>";
                                }
                            }
                        }
                        html += "</select></div>";
                    } else if (parameter[i].queryType == 3) {
                        //时间范围
                        html += "<div class=\"cs-in-style cs-time-se col-md-2 col-sm-2\" style='white-space: nowrap'>";

                        var sdName = "";	//开始时间	input name
                        var edName = "";	//结束时间	input name
                        //设置查询输入框 name属性
                        if (!parameter[i].queryCode) {
                            //默认input name
                            sdName = parameter[i].columnCode + "StartDate";
                            edName = parameter[i].columnCode + "EndDate";
                        } else {
                            //自定义input name
                            sdName = parameter[i].queryCode + "StartDate";
                            edName = parameter[i].queryCode + "EndDate";
                        }

                        var sdInput = tableId+"_"+sdName+"Input";   //开始时间输入框ID
                        var edInput = tableId+"_"+edName+"Input";   //结束时间输入框ID

                        //日期格式
                        if (!parameter[i].dateFormat) {
                            //默认日期格式
                            //开始时间
                            html += "<input id='"+sdInput+"' name=\"" + sdName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:105px;\" type=\"text\" onClick=\"WdatePicker({maxDate:'#F{$dp.$D("+edInput+")}',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})\" placeholder=\"开始时间\" autocomplete=\"off\" ";
                            //设置查询值
                            if (parameter[i].queryVal && parameter[i].queryVal[0]) {
                                html += "value=\"" + newDate(parameter[i].queryVal[0]).format("yyyy-MM-dd") + "\"";
                            }
                            html += "> - ";
                            //结束时间
                            html += "<input id='"+edInput+"' name=\"" + edName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:105px;\" type=\"text\" onClick=\"WdatePicker({minDate:'#F{$dp.$D("+sdInput+")}',maxDate:'%y-%M-%d 23:59:59',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})\" placeholder=\"结束时间\" autocomplete=\"off\" ";
                            //设置查询值
                            if (parameter[i].queryVal && parameter[i].queryVal[1]) {
                                html += "value=\"" + newDate(parameter[i].queryVal[1]).format("yyyy-MM-dd") + "\"";
                            }
                            html += "></div>";
                        } else {
                            //自定义日期格式
                            //开始时间
                            html += "<input id='"+sdInput+"' name=\"" + sdName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:105px;\" type=\"text\" onClick=\"WdatePicker({maxDate:'#F{$dp.$D("+edInput+")}',startDate:'%y-%M-%d 00:00:00',dateFmt:'" + (parameter[i].queryDateFormat ? parameter[i].queryDateFormat : parameter[i].dateFormat) + "',alwaysUseStartDate:true})\" placeholder=\"开始时间\" autocomplete=\"off\" ";
                            //设置查询值
                            if (parameter[i].queryVal && parameter[i].queryVal[0]) {
                                html += "value=\"" + newDate(parameter[i].queryVal[0]).format((parameter[i].queryDateFormat ? parameter[i].queryDateFormat : parameter[i].dateFormat)) + "\"";
                            }
                            html += "> - ";
                            //结束时间
                            html += "<input id='"+edInput+"' name=\"" + edName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:105px;\" type=\"text\" onClick=\"WdatePicker({minDate:'#F{$dp.$D("+sdInput+")}',maxDate:'%y-%M-%d 23:59:59',startDate:'%y-%M-%d %H:%m:%s',dateFmt:'" + (parameter[i].queryDateFormat ? parameter[i].queryDateFormat : parameter[i].dateFormat) + "',alwaysUseStartDate:true})\" placeholder=\"结束时间\" autocomplete=\"off\" ";
                            //设置查询值
                            if (parameter[i].queryVal && parameter[i].queryVal[1]) {
                                html += "value=\"" + newDate(parameter[i].queryVal[1]).format((parameter[i].queryDateFormat ? parameter[i].queryDateFormat : parameter[i].dateFormat)) + "\"";
                            }
                            html += "></div>";
                        }
                    } else if (parameter[i].queryType == 4) {
                        //日期类型
                        html += "<div class=\"cs-in-style col-md-2 col-sm-2 cs-search-input\">";
                        html += "<input class=\"cs-time " + tableId + "-qpinput\" name=\"";

                        //设置查询输入框 name属性
                        if (!parameter[i].queryCode) {
                            //默认input name
                            html += parameter[i].columnCode;
                        } else {
                            //自定义input name
                            html += parameter[i].queryCode;
                        }

                        //固定日期格式
                        html += "\" type=\"text\" onClick=\"WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM',alwaysUseStartDate:true})\" autocomplete=\"off\" ";
                        //设置查询值
                        if (parameter[i].queryVal) {
                            html += "value=\"" + newDate(parameter[i].queryVal).format("yyyy-MM") + "\"";
                        }
                        html += "></div>";
                    }

                    //拼接换行结束符
                    if (queryNo == 0) {
                        if (queryNum == lineNum) {
                            //首行，拼接搜索按钮
                            html += "<div><a href=\"javascript:;\" class=\"cs-avd-search-btn\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').query(1,0)\">搜索</a></div></div>"
                        } else {
                            //非首行
                            html += "</div>";
                        }
                    }
                }

                //拼接搜索结束区域
                if (i == parameter.length - 1 && queryNum > 0) {
                    //查询条件数量小于3拼接换行结束符
                    if (queryNo != 0) {
                        if (queryNum < lineNum) {
                            //首行，拼接搜索按钮
                            html += "<div><a href=\"javascript:;\" class=\"cs-avd-search-btn\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').query(1,0)\">搜索</a></div></div>";
                        } else {
                            //非首行
                            html += "</div>";
                        }
                    }
                    html += "<form></div>";
                }

            }
        }
        //汇总信息
        if (topInfo) {
            html += topInfo;
        }

        //拼接表格数据html
        if (init == 0) {
            html += "<div id=\""+mTableContent+"\"></div>";
        } else {

            //列名最大行数
            var maxRowSpan = 1;
            for (var i = 0; i < parameter.length; i++) {
                if (parameter[i].show != 0) {	//是否显示列
                    maxRowSpan = (parameter[i].columnSonName ? 2 : maxRowSpan);
                }
            }

            if (!summary) {
                html += "<div class=\"cs-col-lg-table\">";
            } else {
                html += "<div class=\"cs-col-lg-table\" style=\"padding-bottom: 36px;\">";
            }
            html += "<div class=\"cs-table-responsive\">";
            html += "<table id=\"" + mTableId + "\" class=\"cs-table cs-table-hover table-striped cs-tablesorter\" >";
            html += "<thead><tr>";
            html += "<th class=\"columnHeading\" style=\"width:60px;\" rowspan=\""+maxRowSpan+"\"><div class=\"cs-num-cod\"><input id=\"" + tableId + "_mainCheckBox" + "\" type=\"checkbox\" onchange=\"datagridUtil.getDatagridObj('"+this.hashcode+"').checkedAll()\"/></div></th>";
            //遍历列名
            var columnSonNameArr = [];
            var thI=0;

            //列名
            for (var i = 0; i < parameter.length; i++) {
                if (parameter[i].show != 0) {	//是否显示列
                    html += "<th class=\"cs-header columnHeading datagrid_"+parameter[i].columnCode+"\" ";

                    if (parameter[i].show == 2 || !parameter[i].columnName) {    //隐藏列
                        html += "style=\"display:none;\"";
                    } else if (parameter[i].columnWidth) {	//设置列宽度
                        html += "style=\"width:" + parameter[i].columnWidth + ";\"";
                    }
                    if (parameter[i].rowSpan) {	//设置合并行
                        html += "rowspan=\"" + parameter[i].rowSpan + "\"";
                    } else if (parameter[i].columnSonName) {
                        html += "rowspan=\"1\"";
                    } else {
                        html += "rowspan=\"" + maxRowSpan + "\"";
                    }
                    if (parameter[i].colsSpan) {	//设置合并列
                        html += "colspan=\"" + parameter[i].colsSpan + "\"";
                        var columnSonNameStr = parameter[i].columnSonName;
                        //不为空就把该字符串截取依次放入数组中
                        if (columnSonNameStr) {
                            var arr = columnSonNameStr.split(",");
                            for (var d = 0; d < arr.length; d++) {
                                columnSonNameArr.push(arr[d]);
                            }
                        }
                        i += parameter[i].colsSpan - 1;//跳过合并列数-1个列的标题的拼接（该列只需要一个标题，所合并列多余的标题不拼接）
                    }
                    if (parameter[i].columnSonName) {	//设置合并列
                        html += "colspan=\"" + parameter[i].columnSonName.split(",").length + "\"";
                        var columnSonNameStr = parameter[i].columnSonName;
                        //不为空就把该字符串截取依次放入数组中
                        if (columnSonNameStr) {
                            var arr = columnSonNameStr.split(",");
                            for (var d = 0; d < arr.length; d++) {
                                columnSonNameArr.push(arr[d]);
                            }
                        }
                    }

                    //排序
                    if (parameter[i].sort == 1 && parameter[i].sortDataType && maxRowSpan == 1) {
                        html += " onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').orderBy('" + mTableId + "'," + (thI + 1) + ",'" + parameter[i].sortDataType + "')\" >" + parameter[i].columnName + "<span class=\"sortIcon icon iconfont icon-sort\"></span></th>";
                    } else {
                        html += ">" + parameter[i].columnName + "</th>";
                    }
                    thI++;
                }
            }

            //拼接操作列
            if (funBtns && funBtns.length > 0 && showFunBtns != 0) {
                html += "<th class=\"cs-header columnHeading\" rowspan=\""+maxRowSpan+"\" style=\"width:";
                if (!funColumnWidth) {
                    html += "100px";
                } else {
                    html += funColumnWidth;
                }
                html += "\">操作</th>";
            }
            //遍历合并列下子列的内容
            if (columnSonNameArr.length > 0) {
                html += "</tr><tr >";//shit class="cs-budget-height" style="background: #05af50;"
                for (var c = 0; c < columnSonNameArr.length; c++) {
                    html += "<td>" + columnSonNameArr[c] + "</td>"
                }
            }
            html += "</tr></thead><tbody>";
            if (obj) {
                for (var i = 0; i < obj.length; i++) {

                    html += "<tr class=\"rowTr\" data-rowId=\"" + eval("obj[" + i + "]." + rowIdCode) + "\"><td style=\"width:50px;\"><div class=\"cs-num-cod\"><input name=\"rowCheckBox\" type=\"checkbox\" value=\"" + eval("obj[" + i + "]." + rowIdCode) + "\" onchange=\"datagridUtil.getDatagridObj('"+this.hashcode+"').changeBox()\"/><span class=\"rowNo\">" + (i + 1) + "</span></div></td>";
                    //拼接数据
                    for (var ii = 0; ii < parameter.length; ii++) {

                        var codeArr = parameter[ii].columnCode.split(".");
                        var codeKey = "obj[" + i + "]";
                        var codeKey0 = codeKey;	//当前行数据对象str
                        if (codeArr.length > 0) {
                            for (var j = 0; j < codeArr.length; j++) {
                                if (eval(codeKey) == undefined) {
                                    break;
                                }
                                codeKey += "." + codeArr[j];
                            }
                        }
                        var codeVal = eval(codeKey);	//当前空格数据

                        if (parameter[ii].show != 0) {
                            if (parameter[ii].customElement) {
                                //替换字符串中的属性
                                var customElementHtml = parameter[ii].customElement.replace(/\?/g, codeVal);    //替换columnCode对应属性
                                var attributes = customElementHtml.match(/#[^#]*#/g);              //替换#属性名#
                                if (attributes) {
                                    for (var iii=0; iii<attributes.length; iii++) {
                                        var re = new RegExp(attributes[iii]);
                                        customElementHtml = customElementHtml.replace(re, eval(codeKey0+"."+attributes[iii].replace(/#*/g, '')));
                                    }
                                }

                                //自定义html
                                html += "<td";
                                //自定义样式
                                if (parameter[ii].customStyle) {
                                    html += " class=\"" + parameter[ii].customStyle + " datagrid_" + parameter[ii].columnCode + "\"";
                                } else {
                                    html += " class=\"datagrid_" + parameter[ii].columnCode + "\"";
                                }
                                if (parameter[ii].show == 2) {
                                    html += " style=\"display:none;\"";
                                } else if (parameter[ii].hideOverText == 1) {
                                    html += " style=\"overflow: hidden; text-overflow: ellipsis; white-space:nowrap;\"";
                                }

                                if (parameter[ii].tdTitle && codeVal) {
                                    html += " title='"+parameter[ii].tdTitle.replace(/\?/g, codeVal)+"'";
                                }

                                //点击
                                if (parameter[ii].onClickFunName) {
                                    html += "><a class=\"under-line text-primary\" href=\"javascript:;\" onclick=\"" + parameter[ii].onClickFunName + "('" + eval("obj[" + i + "]." + rowIdCode) + "','" + eval("obj[" + i + "]") + "');\">" + customElementHtml + "</a></td>";
                                } else {
                                    html += ">" + customElementHtml + "</td>"
                                }
                            } else if (parameter[ii].customVal) {
                                //使用自定义值
                                var customVal = '';
                                var usedDefault = 0;	//是否使用特殊值(is-null、non-null、default),0否,1是
                                for (var key1 in parameter[ii].customVal) {
                                    //使用匹配值
                                    if (key1 == codeVal) {
                                        customVal = parameter[ii].customVal[key1].replace(/\?/g, codeVal);
                                        usedDefault = 0;
                                        break;
                                    }
                                }

                                //无匹配值
                                if (!customVal) {
                                    //空值
                                    if (parameter[ii].customVal["is-null"] && !codeVal) {
                                        customVal = parameter[ii].customVal["is-null"].replace(/\?/g, codeVal);
                                    }
                                    //非空
                                    if (parameter[ii].customVal["non-null"] && codeVal) {
                                        customVal = parameter[ii].customVal["non-null"].replace(/\?/g, codeVal);
                                    }
                                    //使用default值
                                    if (parameter[ii].customVal["default"]) {
                                        customVal = parameter[ii].customVal["default"].replace(/\?/g, codeVal);
                                    }
                                }

                                //替换字符串中的#属性名#
                                var attributes = customVal.match(/#[^#]*#/g);
                                if (attributes) {
                                    for (var iii=0; iii<attributes.length; iii++) {
                                        var re = new RegExp(attributes[iii]);
                                        customVal = customVal.replace(re, eval(codeKey0+"."+attributes[iii].replace(/#*/g, '')));
                                    }
                                }

                                html += "<td";
                                //自定义样式
                                if (parameter[ii].customStyle) {
                                    html += " class=\"" + parameter[ii].customStyle + " datagrid_" + parameter[ii].columnCode + "\"";
                                } else {
                                    html += " class=\"datagrid_" + parameter[ii].columnCode + "\"";
                                }
                                if (parameter[ii].show == 2) {
                                    html += " style=\"display:none;\"";
                                } else if (parameter[ii].hideOverText == 1) {
                                    html += " style=\"overflow: hidden; text-overflow: ellipsis; white-space:nowrap;\"";
                                }

                                if (parameter[ii].tdTitle && codeVal) {
                                    html += " title='"+parameter[ii].tdTitle.replace(/\?/g, codeVal)+"'";
                                }
                                //点击
                                if (parameter[ii].onClickFunName) {
                                    html += "><a class=\"under-line text-primary\" href=\"javascript:;\" onclick=\"" + parameter[ii].onClickFunName + "('" + eval("obj[" + i + "]." + rowIdCode) + "','" + eval("obj[" + i + "]") + "');\">" + customVal + "</a></td>";
                                } else {
                                    html += ">" + customVal + "</td>";
                                }
                            } else {
                                //使用对象属性值
                                if (!parameter[ii].queryType || parameter[ii].queryType == 0) {
                                    //文字类型
                                    if (obj[i].functionLevel == 1 && parameter[ii].columnCode == "functionName") {
                                        //菜单管理专用- 一级菜单
                                        html += "<td style='text-align:left;'><strong>" + (codeVal == null ? "" : codeVal) + "</strong></td>";

                                    } else if (obj[i].functionLevel == 2 && parameter[ii].columnCode == "functionName") {
                                        //菜单管理专用- 二级菜单
                                        html += "<td style='text-align:left;padding-left:50px;'>" + (codeVal == null ? "" : codeVal) + "</td>";

                                    } else if (obj[i].functionLevel == 3 && parameter[ii].columnCode == "functionName") {
                                        //菜单管理专用- 三级菜单
                                        html += "<td style='text-align:left;padding-left:80px;'>" + (codeVal == null ? "" : codeVal) + "</td>";

                                    } else {
                                        html += "<td";
                                        //自定义样式
                                        if (parameter[ii].customStyle) {
                                            html += " class=\"" + parameter[ii].customStyle + " datagrid_" + parameter[ii].columnCode + "\"";
                                        } else {
                                            html += " class=\"datagrid_" + parameter[ii].columnCode + "\"";
                                        }
                                        if (parameter[ii].show == 2) {
                                            html += " style=\"display:none;\"";
                                        } else if (parameter[ii].hideOverText == 1) {
                                            html += " style=\"overflow: hidden; text-overflow: ellipsis; white-space:nowrap;\"";
                                        }

                                        if (parameter[ii].tdTitle && codeVal) {
                                            html += " title='"+parameter[ii].tdTitle.replace(/\?/g, codeVal)+"'";
                                        }
                                        //点击
                                        if (parameter[ii].onClickFunName) {
                                            html += "><a class=\"under-line text-primary\" href=\"javascript:;\" onclick=\"" + parameter[ii].onClickFunName + "('" + eval("obj[" + i + "]." + rowIdCode) + "','" + eval("obj[" + i + "]") + "');\">" + (codeVal == null ? "" : codeVal) + "</a></td>";
                                        } else {
                                            html += ">" + (codeVal == null ? "" : codeVal) + "</td>";
                                        }
                                    }

                                } else {
                                    //日期类型
                                    if (!codeVal) {
                                        html += "<td";
                                        //自定义样式
                                        if (parameter[ii].customStyle) {
                                            html += " class=\"" + parameter[ii].customStyle + " datagrid_" + parameter[ii].columnCode + "\"";
                                        } else {
                                            html += " class=\"datagrid_" + parameter[ii].columnCode + "\"";
                                        }
                                        if (parameter[ii].show == 2) {
                                            html += " style=\"display:none;\"";
                                        } else if (parameter[ii].hideOverText == 1) {
                                            html += " style=\"overflow: hidden; text-overflow: ellipsis; white-space:nowrap;\"";
                                        }

                                        if (parameter[ii].tdTitle && codeVal) {
                                            html += " title='"+parameter[ii].tdTitle.replace(/\?/g, codeVal)+"'";
                                        }
                                        html += "></td>";
                                    } else {
                                        if (!parameter[ii].dateFormat) {
                                            html += "<td";
                                            //自定义样式
                                            if (parameter[ii].customStyle) {
                                                html += " class=\"" + parameter[ii].customStyle + " datagrid_" + parameter[ii].columnCode + "\"";
                                            } else {
                                                html += " class=\"datagrid_" + parameter[ii].columnCode + "\"";
                                            }
                                            if (parameter[ii].show == 2) {
                                                html += " style=\"display:none;\"";
                                            } else if (parameter[ii].hideOverText == 1) {
                                                html += " style=\"overflow: hidden; text-overflow: ellipsis; white-space:nowrap;\"";
                                            }

                                            if (parameter[ii].tdTitle && codeVal) {
                                                html += " title='"+parameter[ii].tdTitle.replace(/\?/g, codeVal)+"'";
                                            }
                                            //点击
                                            if (parameter[ii].onClickFunName) {
                                                html += "><a class=\"under-line text-primary\" href=\"javascript:;\" onclick=\"" + parameter[ii].onClickFunName + "('" + eval("obj[" + i + "]." + rowIdCode) + "','" + eval("obj[" + i + "]") + "');\">" + newDate(codeVal).format("yyyy-MM-dd") + "</a></td>";
                                            } else {
                                                html += ">" + newDate(codeVal).format("yyyy-MM-dd") + "</td>";
                                            }
                                        } else {
                                            html += "<td";
                                            //自定义样式
                                            if (parameter[ii].customStyle) {
                                                html += " class=\"" + parameter[ii].customStyle + " datagrid_" + parameter[ii].columnCode + "\"";
                                            } else {
                                                html += " class=\"datagrid_" + parameter[ii].columnCode + "\"";
                                            }
                                            if (parameter[ii].show == 2) {
                                                html += " style=\"display:none;\"";
                                            } else if (parameter[ii].hideOverText == 1) {
                                                html += " style=\"overflow: hidden; text-overflow: ellipsis; white-space:nowrap;\"";
                                            }

                                            if (parameter[ii].tdTitle && codeVal) {
                                                html += " title='"+parameter[ii].tdTitle.replace(/\?/g, codeVal)+"'";
                                            }
                                            //点击
                                            if (parameter[ii].onClickFunName) {
                                                html += "><a class=\"under-line text-primary\" href=\"javascript:;\" onclick=\"" + parameter[ii].onClickFunName + "('" + eval("obj[" + i + "]." + rowIdCode) + "','" + eval("obj[" + i + "]") + "');\">" + newDate(codeVal).format(parameter[ii].dateFormat) + "</a></td>";
                                            } else {
                                                html += ">" + newDate(codeVal).format(parameter[ii].dateFormat) + "</td>";
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    //拼接操作按钮
                    if (funBtns && funBtns.length > 0 && showFunBtns != 0) {
                        if (!funColumnStyle) {//操作栏样式设置：默认为居中对齐，特殊情况下可自定义样式
                            html += "<td>";
                        }else{
                            html += "<td style='"+funColumnStyle+"'>";
                        }
                        for (var iii = 0; iii < funBtns.length; iii++) {
                            //设置按钮样式
                            if (funBtns[iii].show == undefined || funBtns[iii].show == 1) {
                                if (funBtns[iii] && funBtns[iii].style) {
                                    html += "<span class=\"operationButton cs-icon-span " + funBtns[iii].style.operationCode + "\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').customizeFun('" + eval("obj[" + i + "]." + rowIdCode) + "','" + i + "','" + iii + "')\"><i class=\"" + funBtns[iii].style.functionIcon + "\" title=\"" + funBtns[iii].style.operationName + "\"></i></span>";
                                } else {
                                    html += "<span class=\"operationButton\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').customizeFun('" + eval("obj[" + i + "]." + rowIdCode) + "','" + i + "','" + iii + "')\">" + funBtns[iii].text + "</span>";
                                }
                            } else if (funBtns[iii].show == 0) {
                                if (funBtns[iii] && funBtns[iii].style) {
                                    html += "<span class=\"operationButton cs-icon-span " + funBtns[iii].style.operationCode + "\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').customizeFun('" + eval("obj[" + i + "]." + rowIdCode) + "','" + i + "','" + iii + "')\" style=\"display:none;\"><i class=\"" + funBtns[iii].style.functionIcon + "\" title=\"" + funBtns[iii].style.operationName + "\"></i></span>";
                                } else {
                                    html += "<span class=\"operationButton\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').customizeFun('" + eval("obj[" + i + "]." + rowIdCode) + "','" + i + "','" + iii + "')\" style=\"display:none;\">" + funBtns[iii].text + "</span>";
                                }
                            }
                        }
                        html += "</td>";
                    }
                    html += "</tr>";
                }
            }
            html += "</tbody></table></div></div>";

            //汇总
            html += "<div id=\"summaryContainer\">";
            if (summary) {
                html += "<div id=\"summary\" class=\"cs-bottom-tools cs-btm-ts2\" style=\"bottom: 50px;border-bottom: 1px solid #ddd;height: 36px;padding: 7px 22px;text-align:right;\">";
                if (summary.summary1){
                    html += "<span>"+summary.summary1+"</span>";
                    if (summary.summary2 && summary.summary2.length > 0) {
                        html += "<i>&nbsp;|&nbsp;</i>";
                    }
                }
                if (summary.summary2 && summary.summary2.length > 0) {
                    for (var j=0;j<summary.summary2.length; j++) {
                        html += "<span>"+summary.summary2[j].title+"：<i>"+summary.summary2[j].text+"</i></span>";
                        if (j < summary.summary2.length-1) {
                            html += "<i>&nbsp;|&nbsp;</i>";
                        }
                    }
                }
                html += "</div>";
            }
            html += "</div>";

            //分页开关，默认：开，0_开，1_关
            if(1 != pageOff) {
                //拼接底部导航
                var navBtnNum = 5;	//导航页面序号按钮数量
                var halfBtnNum = parseInt(navBtnNum / 2);
                html += "<div class=\"cs-bottom-tools\">";

                //拼接底部按钮
                if (bottomBtns && bottomBtns.length > 0) {
                    for (var i = 0; i < bottomBtns.length; i++) {
                        html += "<a href=\"javascript:;\" class=\"cs-menu-btn\"";
                        if (bottomBtns[i] && bottomBtns[i].show == 0) {
                            //隐藏操作按钮
                            html += " style=\"display: none;\"";
                        }
                        //设置按钮样式
                        if (bottomBtns[i] && bottomBtns[i].style) {
                            html += " onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').bottomBtnFun('" + i + "')\"><i class=\"" + bottomBtns[i].style.functionIcon + "\"></i>" + bottomBtns[i].style.operationName + "</a>";
                        } else {
                            html += " onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').bottomBtnFun('" + i + "')\"><i>" + bottomBtns[i].text + "</i></a>";
                        }
                    }
                }

                html += "<ul class=\"cs-pagination cs-fr\">";
                html += "<li class=\"cs-distan\">共" + pageCount + "页/" + rowTotal + "条记录</li>";
                html += "<li class=\"cs-b-nav-btn cs-distan cs-selcet\">";
                html += "<select id=\"" + pageSizeSel + "\" onchange=\"datagridUtil.getDatagridObj('"+this.hashcode+"').resetPageSize();\">";
                html += "<option value=\"10\" ";
                if (pageSize == 10) {
                    html += "selected=\"selected\"";
                }
                html += ">10行/页</option>";
                html += "<option value=\"20\" ";
                if (pageSize == 20) {
                    html += "selected=\"selected\"";
                }
                html += ">20行/页</option>";
                html += "<option value=\"30\" ";
                if (pageSize == 30) {
                    html += "selected=\"selected\"";
                }
                html += ">30行/页</option>";
                html += "<option value=\"40\" ";
                if (pageSize == 40) {
                    html += "selected=\"selected\"";
                }
                html += ">40行/页</option>";
                html += "<option value=\"50\" ";
                if (pageSize == 50) {
                    html += "selected=\"selected\"";
                }
                html += ">50行/页</option>";
                html += "<option value=\"100\" ";
                if (pageSize == 100) {
                    html += "selected=\"selected\"";
                }
                html += ">100行/页</option>";
                html += "</select></li>";

                html += "<li class=\"cs-disabled cs-distan\"><a class=\"cs-b-nav-btn\" " +
                    "onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').toPage('" + 1 + "');\">«</a></li>";
                pageNo = parseInt(pageNo);
                //导航页面序号居中
                if ((pageCount < navBtnNum) || (pageNo - halfBtnNum <= 0)) {
                    //总页数少于5或最前几页显示
                    for (var i = 1; i <= (pageCount > navBtnNum ? navBtnNum : pageCount); i++) {
                        html += "<li><a class=\"cs-b-nav-btn";
                        if (pageNo == i) {
                            html += " cs-n-active";
                        }
                        html += "\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').toPage('" + i + "');\">" + i + "</a></li>";
                    }
                } else {
                    if (pageNo + halfBtnNum >= pageCount) {
                        //最后几页
                        var i = pageNo - halfBtnNum;
                        if (i == pageCount) {
                            for (i; i <= pageCount; i++) {
                                html += "<li><a class=\"cs-b-nav-btn";
                                if (pageNo == i) {
                                    html += " cs-n-active";
                                }
                                html += "\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').toPage('" + i + "');\">" + i + "</a></li>";
                            }
                        } else if (i < pageCount) {
                            for (var ii = pageCount - navBtnNum + 1; ii <= pageCount; ii++) {
                                html += "<li><a class=\"cs-b-nav-btn";
                                if (pageNo == ii) {
                                    html += " cs-n-active";
                                }
                                html += "\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').toPage('" + ii + "');\">" + ii + "</a></li>";
                            }
                        }
                    } else {
                        //中间几页
                        if (navBtnNum % 2 == 0) {
                            //偶数按钮数量
                            for (var i = pageNo - halfBtnNum + 1; i <= pageNo + halfBtnNum; i++) {
                                html += "<li><a class=\"cs-b-nav-btn";
                                if (pageNo == i) {
                                    html += " cs-n-active";
                                }
                                html += "\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').toPage('" + i + "');\">" + i + "</a></li>";
                            }
                        } else {
                            //奇数按钮数量
                            for (var i = pageNo - halfBtnNum; i <= pageNo + halfBtnNum; i++) {
                                html += "<li><a class=\"cs-b-nav-btn";
                                if (pageNo == i) {
                                    html += " cs-n-active";
                                }
                                html += "\" onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').toPage('" + i + "');\">" + i + "</a></li>";
                            }
                        }
                    }
                }
                html += "<li class=\"cs-next \"><a class=\"cs-b-nav-btn\" " +
                    "onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').toPage('" + pageCount + "');\">»</a></li>";
                html += "<li class=\"cs-skip cs-distan\">跳转<input id=\"" + toPageNo + "\" type=\"text\" />页</li>";
                html += "<li><a class=\"cs-b-nav-btn cs-enter cs-distan\" " +
                    "onclick=\"datagridUtil.getDatagridObj('"+this.hashcode+"').toPage();\">确定</a></li>";
                html += "</ul>";
            }

            html += "</div>";
        }

        if(init == 0) {
            //初始化页面
            $("#" + tableId).append(html);

            //初始化导航栏时执行
            if (tableBar && tableBar.init){
                tableBar.init();
            }

            //初始化状态，0：初始化页面，1：加载表格数据
            this.datagridOption.init = 1;
            datagridObjs[this.hashcode] = this;

            //禁用回车键自动提交form
            $(".cs-search-filter").parent("form").attr("onsubmit","return false;");

        } else {
            //加载表格数据
            $("#" + mTableContent).html(html);

            //加载完成后,执行自定义函数
            if (onload) {
                onload(obj, pageData);
            }
        }

    };

    /**
     * 设置每页显示记录数量
     */
    this.resetPageSize = function () {
        var datagridOption = this.datagridOption;

        datagridOption['pageSize'] = document.getElementById("" + datagridOption['pageSizeSel'] + "").value;
        window.localStorage.pageSize = datagridOption['pageSize'];
        this.query();
    };

    /**
     * 跳转到第*页
     */
    this.toPage = function (pageNo) {
        var datagridOption = this.datagridOption;

        var len = arguments.length;	//获取函数参数数量
        //没有参数时，获取跳转页面序号输入框值
        if (len == 0) {
            pageNo = document.getElementById("" + datagridOption['toPageNo'] + "").value;
        }
        //判断跳转页面是否有效
        if (pageNo > datagridOption['pageCount']) {
            alert("没有此页记录");
            return;
        }
        //记录当前页面
        datagridOption['pageNo'] = pageNo;
        this.query(pageNo);
    };

    /**
     * 查询
     * queryType 查询类型 默认高级搜索查询 0:高级搜索查询,1:关键词查询
     */
    this.query = function (pageNo, queryType) {
        var datagridObj0 = this;
        var datagridOption = this.datagridOption;

        //查询前执行自定义函数
        if (datagridOption["before"]) {
            var isContinue = datagridOption["before"](queryType);
            if (isContinue == false) {
                return;
            }
        }

        //设置页面序号
        if (!pageNo) {
            //刷新列表默认为第一页
            // datagridOption['pageNo'] = 1;
        } else {
            datagridOption['pageNo'] = parseInt(pageNo);
        }

        //ajax参数
        var dataJson = this.getQueryParam();


        $.ajax({
            type: "POST",
            url: datagridOption['tableAction'],
            data: dataJson,
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    var pageModel = data.obj;
                    if (pageModel) {
                        //设置总记录数量
                        datagridOption['rowTotal'] = pageModel.rowTotal;
                        //设置总页数、当前页数
                        if (pageModel.pageCount <= 0) {
                            datagridOption['pageCount'] = 1;
                        } else if (pageModel.pageCount > datagridOption['pageNo']) {
                            datagridOption['pageNo'] = datagridOption['pageNo'];
                            datagridOption['pageCount'] = pageModel.pageCount;
                        } else {
                            datagridOption['pageCount'] = pageModel.pageCount;
                        }
                        //记录数据
                        datagridOption['obj'] = pageModel.results;
                    }
                    datagridOption['pageData'] = data;
                    datagridObj0.spliceHtml();
                } else {
                    console.log("查询失败");
                }
            },
            error: function () {
                console.log("查询失败");
            }
        });
    };

    /**
     * 获取查询参数
     */
    this.getQueryParam = function() {
        var datagridObj0 = this;
        var datagridOption = this.datagridOption;
        //ajax参数
        var dataJson = {};
        dataJson["pageSize"] = datagridOption['pageSize'];
        dataJson["pageNo"] = datagridOption['pageNo'];
        dataJson["rowTotal"] = datagridOption['rowTotal'];
        dataJson["pageCount"] = datagridOption['pageCount'];

        //拼接默认查询条件
        if (datagridOption['defaultCondition']) {
            for (var j = 0; j < datagridOption["defaultCondition"].length; j++) {
                dataJson[datagridOption["defaultCondition"][j].queryCode] = datagridOption["defaultCondition"][j].queryVal;
            }
        }

        //时间范围变量
        var dateMap = "";

        //搜索类型
        if (datagridOption['queryType'] == 0) {
            //高级搜索查询
            var qps = document.getElementsByClassName(datagridOption["tableId"] + "-qpinput");
            //查询条件
            for (var i = 0; i < qps.length; i++) {

                //记录、拼接查询条件
                if (datagridOption["parameter"]) {
                    for (var ii = 0; ii < datagridOption["parameter"].length; ii++) {

                        if (datagridOption["parameter"][ii].queryType == 3) {//时间范围

                            //创建变量
                            if (!datagridOption["parameter"][ii].queryVal) {
                                datagridOption["parameter"][ii].queryVal = ["", ""];	//开始时间，结束时间
                            }

                            if (datagridOption["parameter"][ii].columnCode + "StartDate" == qps[i].name || datagridOption["parameter"][ii].queryCode + "StartDate" == qps[i].name) {
                                //开始时间
                                if (qps[i].value) {
                                    datagridOption["parameter"][ii].queryVal[0] = qps[i].value;
                                    //拼接开始时间查询条件
                                    dateMap += "\"" + qps[i].name + "\":\"" + datagridOption["parameter"][ii].queryVal[0] + "\",";
                                } else {
                                    datagridOption["parameter"][ii].queryVal[0] = "";
                                }

                                break;
                            } else if (datagridOption["parameter"][ii].columnCode + "EndDate" == qps[i].name || datagridOption["parameter"][ii].queryCode + "EndDate" == qps[i].name) {
                                //结束时间
                                if (qps[i].value) {
                                    datagridOption["parameter"][ii].queryVal[1] = qps[i].value;
                                    //拼接结束时间查询条件
                                    dateMap += "\"" + qps[i].name + "\":\"" + datagridOption["parameter"][ii].queryVal[1] + "\",";
                                } else {
                                    datagridOption["parameter"][ii].queryVal[1] = "";
                                }

                                break;
                            }

                        } else {	//其他
                            if (datagridOption["parameter"][ii].columnCode == qps[i].name || datagridOption["parameter"][ii].queryCode == qps[i].name) {
                                if (qps[i].value) {
                                    datagridOption["parameter"][ii].queryVal = qps[i].value;

                                    //拼接搜索框查询条件
                                    dataJson[qps[i].name] = qps[i].value;
                                } else {
                                    datagridOption["parameter"][ii].queryVal = "";
                                }
                                break;
                            }
                        }

                    }
                }
            }

        } else {
            //关键词查询
            //拼接搜索框查询条件
            $.each($("#"+datagridOption["tableId"]+" .focusInput"), function (i, e) {
                if (e.value) {
                    dataJson[e.name] = e.value;
                }
            });
        }

        //拼接时间范围查询条件
        if (dateMap) {
            dateMap = dateMap.substring(0, dateMap.length - 1);
            dataJson["dateMap"] = JSON.parse("{" + dateMap + "}");
        }

        //初始化时间范围
        if (datagridOption.init==0 && datagridOption.tableBar && datagridOption.tableBar.ele) {
            $.each(datagridOption.tableBar.ele, function (i, e) {
                if (e.eleShow != 0) {
                    switch (e.eleType) {
                        case 1:
                            if (e.eleDefaultDate) {
                                dataJson[e.eleName] = e.eleDefaultDate;
                            }
                            break;
                        case 3:
                            if (e.eleDefaultDateMin) {
                                dataJson[e.eleName+"StartDate"] = e.eleDefaultDateMin;
                            }
                            if (e.eleDefaultDateMax) {
                                dataJson[e.eleName+"EndDate"] = e.eleDefaultDateMax;
                            }
                            break;
                    }
                }
            });
        }

        // console.log("======================================== 查询条件 ========================================");
        // console.log(dataStr);
        // console.log(dataJson);

        return dataJson;
    };

    /**
     * 刷新
     * pn    页码
     */
    this.refresh = function (pn) {
        var datagridOption = this.datagridOption;
        if (pn) {
            this.query(pn, datagridOption['queryType']);
        } else {
            this.query(datagridOption['pageNo'], datagridOption['queryType']);
        }
    };

    /**
     * 关键词查询
     */
    this.queryByFocus = function (hashcode0) {
        var datagridOption = this.datagridOption;
        if (!hashcode0) {
            this.query(1, datagridOption['queryType']);
        } else {
            datagridObjs[hashcode0].query(1, datagridOption['queryType']);
        }
    };

    /**
     * 执行按钮自定义函数
     * rowId    数据ID
     * rowNo    第N条数据
     * btnNo    第N个按钮
     */
    this.customizeFun = function (rowId, rowNo, btnNo) {
        var datagridOption = this.datagridOption;

        var funbtn = datagridOption['funBtns'][btnNo];
        funbtn.action(rowId, datagridOption['obj'][rowNo]);
    };

    /**
     * 头部按钮函数
     * btnNo    第N个按钮
     */
    this.topBtnFun = function (btnNo) {
        var datagridOption = this.datagridOption;

        var topBtn = datagridOption.tableBar.topBtns[btnNo];
        var ids = [];
        var rows = [];

        $.each($("#"+datagridOption["tableId"]+" input[name='rowCheckBox']"), function(i, e){
            if (e.checked == true) {
                ids.push(e.value);

                for (var ii = 0; ii < datagridOption["obj"].length; ii++) {
                    if (e.value == datagridOption["obj"][ii].id){
                        rows.push(datagridOption["obj"][ii]);
                        break;
                    }
                }
            }
        });

        topBtn.action(ids, rows);
    };

    /**
     * 底部按钮函数
     * btnNo    第N个按钮
     */
    this.bottomBtnFun = function (btnNo) {
        var datagridOption = this.datagridOption;

        var bottomBtn = datagridOption['bottomBtns'][btnNo];
        var cbs = document.getElementsByName("rowCheckBox");
        var ids = [];
        var rows = [];

        for (var i = 0; i < cbs.length; i++) {
            if (cbs[i].checked == true) {
                ids.push(cbs[i].value);

                for (var ii = 0; ii < datagridOption["obj"].length; ii++) {
                    if (cbs[i].value == datagridOption["obj"][ii].id){
                        rows.push(datagridOption["obj"][ii]);
                        break;
                    }
                }
            }
        }
        bottomBtn.action(ids, rows);
    };

    /**
     * 全选列表复选框
     */
    this.checkedAll = function () {
        var datagridOption = this.datagridOption;

        var tableId = datagridOption["tableId"];
        // var cbs = document.getElementsByName("rowCheckBox");
        if (document.getElementById(tableId + "_mainCheckBox").checked) {
            //全选
            $("#"+tableId+" input[name='rowCheckBox']").prop("checked", true);
        } else {
            //全不选
            $("#"+tableId+" input[name='rowCheckBox']").prop("checked", false);
        }
    };

    /**
     * 选择、取消单个记录复选框
     */
    this.changeBox = function () {
        var datagridOption = this.datagridOption;

        if ($("#"+datagridOption["tableId"]+" input[name='rowCheckBox']:checked").length == $("#"+datagridOption["tableId"]+" input[name='rowCheckBox']").length) {
            //选中全选复选框
            $("#"+datagridOption["tableId"]+"_mainCheckBox").prop("checked", true);
        } else {
            $("#"+datagridOption["tableId"]+"_mainCheckBox").prop("checked", false);
        }
    };

    /**
     * 排序
     */
    this.orderBy = function (mTableId, colNo, dataType) {
        var datagridOption = this.datagridOption;

        orderByName(mTableId, colNo, dataType);

        var oTable = document.getElementById(mTableId);
        var columnHeading = oTable.getElementsByClassName("columnHeading");//列标题

        for (var i = 0; i < columnHeading.length; i++) {
            if (colNo == i) {
                //生成排序图标
                var sortIconEle = columnHeading[i].getElementsByClassName("sortIcon")[0];

                sortIconEle.classList.remove("icon-sort");
                if (sortIconEle.className == 'sortIcon icon iconfont icon-xia1') {	//重新排序-升序
                    sortIconEle.classList.remove("icon-xia1");
                    sortIconEle.classList.add("icon-shang1");
                } else if (sortIconEle.className == 'sortIcon icon iconfont icon-shang1') {	//重新排序-降序
                    sortIconEle.classList.remove("icon-shang1");
                    sortIconEle.classList.add("icon-xia1");
                } else {	//首次排序-降序
                    sortIconEle.classList.add("icon-xia1");
                }


                /* else {
                    //首次排序
                    if("string" != dataType) {
                        //非字符型 降序
                        orderByName2(mTableId, colNo, dataType);
                        sortIconEle.classList.add("icon-xia1");
                    } else {
                        //字符型 升序
                        sortIconEle.classList.add("icon-shang1");
                    }
                }*/

            } else {
                //清空其他列排序图标
                var sortIconEle = columnHeading[i].getElementsByClassName("sortIcon")[0];
                if (sortIconEle) {
                    sortIconEle.classList.remove("icon-shang1");
                    sortIconEle.classList.remove("icon-xia1");
                    sortIconEle.classList.add("icon-sort");
                }
            }
        }

        //重置行序号
        var rows = document.getElementById(datagridOption["tableId"]).getElementsByClassName("rowNo");
        for (var i = 0; i < rows.length; i++) {
            rows[i].innerHTML = i + 1;
        }
    };

    /**
     * 排序
     * 数据统计专用
     */
    this.orderBy2 = function (mTableId, colNo, dataType) {
        var datagridOption = this.datagridOption;

        orderByName2(mTableId, colNo, dataType);

        var oTable = document.getElementById(mTableId);
        var columnHeading = oTable.getElementsByClassName("columnHeading");//列标题

        for (var i = 0; i < columnHeading.length; i++) {
            if (colNo == i) {
                //生成排序图标
                var sortIconEle = columnHeading[i].getElementsByClassName("sortIcon")[0];

                sortIconEle.classList.remove("icon-sort");
                if (sortIconEle.className == 'sortIcon icon iconfont icon-xia1') {	//重新排序-升序
                    sortIconEle.classList.remove("icon-xia1");
                    sortIconEle.classList.add("icon-shang1");
                } else if (sortIconEle.className == 'sortIcon icon iconfont icon-shang1') {	//重新排序-降序
                    sortIconEle.classList.remove("icon-shang1");
                    sortIconEle.classList.add("icon-xia1");
                } else {
                    //首次排序-降序
                    sortIconEle.classList.add("icon-xia1");
                }

            } else {
                //清空其他列排序图标
                var sortIconEle = columnHeading[i].getElementsByClassName("sortIcon")[0];
                if (sortIconEle) {
                    sortIconEle.classList.remove("icon-shang1");
                    sortIconEle.classList.remove("icon-xia1");
                    sortIconEle.classList.add("icon-sort");
                }
            }
        }

        //重置行序号
        var rows = document.getElementById(datagridOption["tableId"]).getElementsByClassName("rowNo");
        for (var i = 0; i < rows.length; i++) {
            rows[i].innerHTML = i + 1;
        }
    };

    /**
     * 清空高级搜索条件(不会自动刷新列表)
     */
    this.cleanQueryVal = function () {
        var datagridOption = this.datagridOption;

        //清空高级搜索输入框
        var qps = document.getElementsByClassName(datagridOption["tableId"] + "-qpinput");
        for (var j = 0; j < qps.length; j++) {
            if (qps[j].type == "checkbox" || qps[j].type == "radio") {	//单选框和复选框取消选中
                qps[j].checked = false;
            } else {	//其他清空value
                qps[j].value = "";
            }
        }
    };

    /**
     * 清空关键词搜索条件(不会自动刷新列表)
     */
    this.cleanKeyword = function () {
        var datagridOption = this.datagridOption;

        //清空关键词输入框
        var fi = document.getElementsByClassName("focusInput");
        for (var j = 0; j < fi.length; j++) {
            if (fi[j].type == "checkbox" || fi[j].type == "radio") {	//单选框和复选框取消选中
                fi[j].checked = false;
            } else {	//其他清空value
                fi[j].value = "";
            }
        }
    };

    /**
     * 添加/覆盖加载条件
     */
    this.addDefaultCondition = function (mQueryCode, mQueryVal) {
        var datagridOption = this.datagridOption;

        if (!datagridOption.defaultCondition || datagridOption.defaultCondition.length == 0) {
            //添加
            datagridOption.defaultCondition = [];
            var query = {
                queryCode: mQueryCode,
                queryVal: mQueryVal
            };
            datagridOption.defaultCondition[0] = query;
        } else {
            for (var i = 0; i < datagridOption.defaultCondition.length; i++) {
                //覆盖
                if (datagridOption.defaultCondition[i].queryCode == mQueryCode) {
                    datagridOption.defaultCondition[i].queryVal = mQueryVal;
                    break;
                }
                //添加
                if (i + 1 == datagridOption.defaultCondition.length) {
                    datagridOption.defaultCondition.push({
                        "queryCode" : mQueryCode,
                        "queryVal" : mQueryVal
                    });
                }
            }

        }
    };

    /**
     * 删除加载条件
     */
    this.delDefaultCondition = function (mQueryCode) {
        var datagridOption = this.datagridOption;

        if (!mQueryCode) {
            //删除所有加载条件
            datagridOption.defaultCondition = [];
        } else if (datagridOption.defaultCondition && datagridOption.defaultCondition.length > 0) {
            for (var i = 0; i < datagridOption.defaultCondition.length; i++) {
                //删除指定加载条件
                if (datagridOption.defaultCondition[i].queryCode == mQueryCode) {
                    datagridOption.defaultCondition.splice(i, 1);
                    break;
                }
            }
        }
    };

    /**
     * 获取加载条件值
     */
    this.getDefaultCondition = function (mQueryCode) {
        var datagridOption = this.datagridOption;

        if (!mQueryCode) {
            return '';
        } else if (datagridOption.defaultCondition && datagridOption.defaultCondition.length > 0) {
            for (var i = 0; i < datagridOption.defaultCondition.length; i++) {
                //返回加载条件值
                if (datagridOption.defaultCondition[i].queryCode == mQueryCode) {
                    return datagridOption.defaultCondition[i].queryVal;
                }
            }
        }
        return '';
    };

    /**
     * 重新设置汇总
     */
    this.setSummary = function (summary) {
        var datagridOption = this.datagridOption;

        datagridOption.summary = summary;
        var html = "";
        if (summary) {
            html += "<div id=\"summary\" class=\"cs-bottom-tools cs-btm-ts2\" style=\"bottom: 50px;border-bottom: 1px solid #ddd;height: 36px;padding: 7px 22px;text-align:right;\">";
            if (summary.summary1){
                html += "<span>"+summary.summary1+"</span>";
                if (summary.summary2 && summary.summary2.length > 0) {
                    html += "<i>&nbsp;|&nbsp;</i>";
                }
            }
            if (summary.summary2 && summary.summary2.length > 0) {
                for (var j=0;j<summary.summary2.length; j++) {
                    html += "<span>"+summary.summary2[j].title+"：<i>"+summary.summary2[j].text+"</i></span>";
                    if (j < summary.summary2.length-1) {
                        html += "<i>&nbsp;|&nbsp;</i>";
                    }
                }
            }
            html += "</div>";
        }
        document.getElementById( "summaryContainer").innerHTML = html;
    };

    /**
     * 显示、隐藏高级搜索
     */
    this.hlSearch = function () {
        var datagridObj0 = this;
        if (datagridObj0.datagridOption && datagridObj0.datagridOption.queryType == 1) {
            datagridObj0.datagridOption.queryType = 0;
        } else {
            datagridObj0.datagridOption.queryType = 1;
        }
        datagridObjs[datagridObj0.hashcode] = datagridObj0;

        var datagridOption = datagridObj0.datagridOption;

        if (datagridOption.tableBar && datagridOption.tableBar.switchSearch) {
            datagridOption.tableBar.switchSearch(datagridOption['queryType']);
        }

        var tableId = datagridOption["tableId"];
        if ($("#"+tableId+" .cs-search-inform").hasClass("cs-hide")) {
            $("#"+tableId+" .cs-search-inform").removeClass("cs-hide");
            $("#"+tableId+" .search-form").hide();
        } else {
            $("#"+tableId+" .cs-search-inform").addClass("cs-hide");
            $("#"+tableId+" .search-form").show();
        }

        //高级搜索图标
        if ($("#"+tableId+" .searchBtn").hasClass("icon-xia2")) {
            $("#"+tableId+" .searchBtn").removeClass("icon-xia2");
            $("#"+tableId+" .searchBtn").addClass("icon-shang2");
        } else {
            $("#"+tableId+" .searchBtn").removeClass("icon-shang2");
            $("#"+tableId+" .searchBtn").addClass("icon-xia2");
        }
    };

};

$(document).on("keydown",".keyWordsInput",function(e){
    //回车键事件-关键词查询
    if (e.keyCode == 13) {
        $(this).siblings(".cs-search-btn").click();
    }
});

function getHashCode(str) {
    var hash = 0, i, chr, len;
    if (str.length === 0) return hash;
    for (i = 0, len = str.length; i < len; i++) {
        chr   = str.charCodeAt(i);
        hash  = ((hash << 5) - hash) + chr;
        hash |= 0; // Convert to 32bit integer
    }
    return hash;
}
