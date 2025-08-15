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
//数据列表全局变量
datagridOption = {};
datagridUtil = (function () {
    return {
        /*
         // 初始化参数 *必填
         var option = {
         tableId: "dataList", 		//* div_ID
         tableAction: "${webRoot}/pPersonnel/datagrid.do", 		//* 加载数据地址
         parameter: [ 			//* 表格列
         {
         columnCode: "name",	//* 字段
         columnName: "名称",		//* 列名
         columnWidth: "80px"		//列宽度
         show: 1,						//是否显示，默认：是，0_否，1_是，2_隐藏列
         query: 1,					//是否支持高级搜索，默认：否，0_icon iconfont icon-huifang1否，1_是
         queryType: ,				//数据类型，默认:文字;0:文字、1:日期，默认格式[yyyy-MM-dd]、2:下拉输入框，与customVal一起使用、3:时间范围，默认格式[yyyy-MM-dd]，可以使用dateFormat格式）
         queryCode: ,				//查询条件参数名称 请求时替代 columnCode
         queryVal: ,					//查询条件参数值
         customVal: ,				//自定义值  格式:{"0":"是","1":"否","default":"是","is-null":"空值","non-null":"非空"}(无匹配值，默认为default)，自定义样式：{"0":"<span style='color:#009900;'>启用</span>","1":"<span style='color:#E53333;'>停用</span>"}
         customElement: ,			//包含?的文本,queryCode对应的value自动替换文本中?       //对象属性id替换html中#id#(暂缓)
         customStyle: ,				//自定义样式(css class)
         dateFormat: ,				//自定义时间格式
         sort: ,                     //是否排序，默认：是，0_否，1_是
         sortDataType: ,			    //排序数据类型（string, int, float, date）
         rowSpan: ,      			//合并行 （1,2,3,4....）合并多行后请给第一列设置合并行数 onload: function () {$("#dataList_mainCheckBox").closest("th").attr("rowspan", "2");} 参考web_attendance_daily_statistics.jsp
         colsSpan: ,     			//合并列 （1,2,3,4....）
         columnSonName: 			    //合并列后设置所合并列的子列，前提是需要合并两行 格式: columnSonName: "子列1,子列2,子列3"
         }],
         pageOff: 1,						//分页开关，默认：开，0_开，1_关
         rowIdCode: "rid", 				//使用指定字段设置为rowId，默认为id
         defaultCondition: [{			//附加请求参数
         queryCode: "", 				//参数名
         queryVal: ""						//参数值
         }],
         funColumnWidth: "150px", 		//操作列宽度，默认100px
         funBtns: [{							//操作按钮
         show: 1, 							//是否显示，默认：是，0_否，1_是
         style: {operationCode,functionIcon,operationName},		//操作权限对象
         action: function(id){}												//执行函数，id: rowId
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
         before: function(queryType){},		//请求数据前执行函数，queryType(查询类型): 0_高级搜索,1:关键词查询
         onload: function(rows, pageData){},					//加载列表后执行函数

         obj: {}	//返回数据
         };
         */
        /**
         * 初始化
         */
        initOption: function (option) {
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
            //页面跳转ID
            if (!option["toPageNo"]) {
                //设置默认页面跳转ID,防止多列表页面ID重复
                option["toPageNo"] = option["tableId"] + "toPageNo";
            }

            datagridOption = option;
            //设置全局查询类型,默认高级搜索
            datagridOption['queryType'] = 0;
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
        },
        /**
         * 拼接列表
         */
        spliceHtml: function () {
            //获取当前配置参数
            var tableId = datagridOption["tableId"];
            var mTableId = "m" + tableId;
            var parameter = datagridOption["parameter"];
            var funBtns = datagridOption["funBtns"];
            var showFunBtns = datagridOption["showFunBtns"];
            var rowTotal = datagridOption["rowTotal"];
            var pageSize = datagridOption["pageSize"];
            var pageNo = datagridOption["pageNo"];
            var pageCount = datagridOption["pageCount"];
            var obj = datagridOption["obj"];
            var pageData = datagridOption["pageData"];
            var showQuery = datagridOption["showQuery"];
            var onload = datagridOption["onload"];
            var funColumnWidth = datagridOption["funColumnWidth"];
            var bottomBtns = datagridOption["bottomBtns"];
            var pageSizeSel = datagridOption["pageSizeSel"];
            var toPageNo = datagridOption["toPageNo"];
            var rowIdCode = !datagridOption["rowIdCode"] ? "id" : datagridOption["rowIdCode"];


            //清空列表
            $("#" + tableId).html("");

            //拼接搜索栏html
            var queryNum = 0;	//查询条件数量
            var html = "";	//拼接html
            var lineNum = 3;	//每行显示查询条件数量(可修改)
            for (var i = 0; i < parameter.length; i++) {
                if (parameter[i].query == 1) {
                    queryNum++;
                    //拼接搜索开始区域
                    if (queryNum == 1) {
                        if (showQuery && showQuery == 1) {
                            html += "<div class=\"cs-search-inform old-style\">";
                        } else {
                            html += "<div class=\"cs-search-inform old-style cs-hide\"><form id=\"queryForm\" class=\"cs-add-new\">";
                        }
                    }

                    var queryNo = queryNum % lineNum;
                    //拼接换行开始符
                    if (queryNo == 1) {
                        html += "<div class=\"cs-row clearfix\">";
                    }

                    //拼接搜索框
                    html += "<div class=\"col-md-1 col-sm-1 cs-name\">" + parameter[i].columnName + "：</div>";
                    //判断查询条件类型
                    if (!parameter[i].queryType || parameter[i].queryType == 0) {
                        //文本类型
                        html += "<div class=\"cs-in-style col-md-2 col-sm-2 cs-search-input\">";
                        html += "<input class=\"" + tableId + "-qpinput\" name=\"";

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
                        html += "\" type=\"text\" onClick=\"WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})\" autocomplete=\"off\" ";
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
                        html += "<div class=\"cs-in-style cs-time-se col-md-2 col-sm-2\">";

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

                        //日期格式
                        if (!parameter[i].dateFormat) {
                            //默认日期格式
                            //开始时间

                            //html += "<input id='beginDates' name=\"" + sdName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:110px;\" type=\"text\" onClick=\"WdatePicker({{maxDate:'#F{$dp.$D(\'endDates\'),startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})\" placeholder=\"开始时间\" autocomplete=\"off\" ";
                            html += "<input id='beginDates_"+sdName+"' name=\"" + sdName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:110px;\" type=\"text\" onClick=\"WdatePicker({maxDate:'#F{$dp.$D(endDates_"+edName+")}',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})\" placeholder=\"开始时间\" autocomplete=\"off\" ";
                            //设置查询值
                            if (parameter[i].queryVal && parameter[i].queryVal[0]) {
                                html += "value=\"" + newDate(parameter[i].queryVal[0]).format("yyyy-MM-dd") + "\"";
                            }
                            html += "> - ";
                            //结束时间
                           // html += "<input id='endDates' name=\"" + edName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:110px;\" type=\"text\" onClick=\"WdatePicker({minDate:'#F{$dp.$D(\'beginDates\'),startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})\" placeholder=\"结束时间\" autocomplete=\"off\" ";
                            html += "<input id='endDates_"+edName+"' name=\"" + edName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:110px;\" type=\"text\" onClick=\"WdatePicker({minDate:'#F{$dp.$D(beginDates_"+sdName+")}',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})\" placeholder=\"结束时间\" autocomplete=\"off\" ";
                            //设置查询值
                            if (parameter[i].queryVal && parameter[i].queryVal[1]) {
                                html += "value=\"" + newDate(parameter[i].queryVal[1]).format("yyyy-MM-dd") + "\"";
                            }
                            html += "></div>";
                        } else {
                            //自定义日期格式
                            //开始时间
                            //html += "<input id='beginDates' name=\"" + sdName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:110px;\" type=\"text\" onClick=\"WdatePicker({maxDate:'#F{$dp.$D(\'endDates\'),startDate:'%y-%M-%d 00:00:00',dateFmt:'" + parameter[i].dateFormat + "',alwaysUseStartDate:true})\" placeholder=\"开始时间\" autocomplete=\"off\" ";
                            html += "<input  id='beginDates_"+sdName+"' name=\"" + sdName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:110px;\" type=\"text\" onClick=\"WdatePicker({maxDate:'#F{$dp.$D(endDates_"+edName+")}',startDate:'%y-%M-%d 00:00:00',dateFmt:'" + parameter[i].dateFormat + "',alwaysUseStartDate:true})\" placeholder=\"开始时间\" autocomplete=\"off\" ";
                            //设置查询值
                            if (parameter[i].queryVal && parameter[i].queryVal[0]) {
                                html += "value=\"" + newDate(parameter[i].queryVal[0]).format(parameter[i].dateFormat) + "\"";
                            }
                            html += "> - ";
                            //结束时间
                           // html += "<input id='endDates'  name=\"" + edName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:110px;\" type=\"text\" onClick=\"WdatePicker({minDate:'#F{$dp.$D(\'beginDates\'),startDate:'%y-%M-%d %H:%m:%s',dateFmt:'" + parameter[i].dateFormat + "',alwaysUseStartDate:true})\" placeholder=\"结束时间\" autocomplete=\"off\" ";
                            html += "<input id='endDates_"+edName+"' name=\"" + edName + "\" class=\"cs-time " + tableId + "-qpinput\" style=\"width:110px;\" type=\"text\" onClick=\"WdatePicker({minDate:'#F{$dp.$D(beginDates_"+sdName+")}',startDate:'%y-%M-%d %H:%m:%s',dateFmt:'" + parameter[i].dateFormat + "',alwaysUseStartDate:true})\" placeholder=\"结束时间\" autocomplete=\"off\" ";
                            //设置查询值
                            if (parameter[i].queryVal && parameter[i].queryVal[1]) {
                                html += "value=\"" + newDate(parameter[i].queryVal[1]).format(parameter[i].dateFormat) + "\"";
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
                            html += "<div><a href=\"javascript:;\" class=\"cs-avd-search-btn\" onclick=\"datagridUtil.query(1,0)\">搜索</a></div></div>"
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
                            html += "<div><a href=\"javascript:;\" class=\"cs-avd-search-btn\" onclick=\"datagridUtil.query(1,0)\">搜索</a></div></div>";
                        } else {
                            //非首行
                            html += "</div>";
                        }
                    }
                    html += "<form></div>";
                }

            }

            //拼接列表html
            html += "<div class=\"cs-col-lg-table\">";
            html += "<div class=\"cs-table-responsive\">";
            html += "<table id=\"" + mTableId + "\" class=\"cs-table cs-table-hover table-striped cs-tablesorter\" >";
            html += "<thead><tr>";
            html += "<th class=\"columnHeading\" style=\"width:60px;\"><div class=\"cs-num-cod\"><input id=\"" + tableId + "_mainCheckBox" + "\" type=\"checkbox\" onchange=\"datagridUtil.checkedAll()\"/></div></th>";
            //遍历列名
            var columnSonNameArr = [];
            for (var i = 0; i < parameter.length; i++) {
                if (parameter[i].show != 0) {	//是否显示列
                    html += "<th class=\"cs-header columnHeading\" ";
                    if (parameter[i].show == 2) {    //隐藏列
                        html += "style=\"display:none;\"";
                    } else if (parameter[i].columnWidth) {	//设置列宽度
                        html += "style=\"width:" + parameter[i].columnWidth + ";\"";
                    }
                    if (parameter[i].rowSpan) {	//设置合并行
                        html += "rowspan=\"" + parameter[i].rowSpan + "\"";
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

                    //排序
                    if (parameter[i].sort == 1 && parameter[i].sortDataType) {
                        html += " onclick=\"datagridUtil.orderBy('" + mTableId + "'," + (i + 1) + ",'" + parameter[i].sortDataType + "')\" >" + parameter[i].columnName + "<span class=\"sortIcon icon iconfont icon-sort\"></span></th>";
                    } else {
                        html += ">" + parameter[i].columnName + "</th>";
                    }

                }
            }
            //拼接操作列
            if (funBtns && funBtns.length > 0 && showFunBtns != 0) {
                html += "<th class=\"cs-header columnHeading\" style=\"width:";
                if (!funColumnWidth) {
                    html += "100px";
                } else {
                    html += funColumnWidth;
                }
                html += "\">操作</th>";
            }
            //遍历合并列下子列的内容
            if (columnSonNameArr.length > 0) {
                html += "</tr><tr class=\"cs-budget-height\" style=\"background: #05af50;\">";
                for (var c = 0; c < columnSonNameArr.length; c++) {
                    html += "<td>" + columnSonNameArr[c] + "</td>"
                }
            }
            html += "</tr></thead><tbody>";
            if (obj) {
                for (var i = 0; i < obj.length; i++) {

                    html += "<tr class=\"rowTr\" data-rowId=\"" + eval("obj[" + i + "]." + rowIdCode) + "\"><td style=\"width:50px;\"><div class=\"cs-num-cod\"><input name=\"rowCheckBox\" type=\"checkbox\" value=\"" + eval("obj[" + i + "]." + rowIdCode) + "\" onchange=\"datagridUtil.changeBox()\"/><span class=\"rowNo\">" + (i + 1) + "</span></div></td>";
                    //拼接数据
                    for (var ii = 0; ii < parameter.length; ii++) {

                        var codeArr = parameter[ii].columnCode.split(".");
                        var codeKey = "obj[" + i + "]";
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
                                //自定义html
                                html += "<td";
                                //自定义样式
                                if (parameter[ii].customStyle) {
                                    html += " class=\"" + parameter[ii].customStyle + "\"";
                                }
                                if (parameter[ii].show == 2) {
                                    html += " style=\"display:none;\"";
                                }
                                html += ">" + parameter[ii].customElement.replace(/\?/g, codeVal) + "</td>"
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

                                html += "<td";
                                //自定义样式
                                if (parameter[ii].customStyle) {
                                    html += " class=\"" + parameter[ii].customStyle + "\"";
                                }
                                if (parameter[ii].show == 2) {
                                    html += " style=\"display:none;\"";
                                }
                                html += ">" + customVal + "</td>";
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
                                            html += " class=\"" + parameter[ii].customStyle + "\"";
                                        }
                                        if (parameter[ii].show == 2) {
                                            html += " style=\"display:none;\"";
                                        }
                                        html += ">" + (codeVal == null ? "" : codeVal) + "</td>";
                                    }

                                } else {
                                    //日期类型
                                    if (!codeVal) {
                                        html += "<td";
                                        //自定义样式
                                        if (parameter[ii].customStyle) {
                                            html += " class=\"" + parameter[ii].customStyle + "\"";
                                        }
                                        if (parameter[ii].show == 2) {
                                            html += " style=\"display:none;\"";
                                        }
                                        html += "></td>";
                                    } else {
//										var date=fmtDate(codeVal);
//										var data=date.replace(new RegExp(/-/gm) ,"/");//将所有的'-'转为'/'即可,不然IE低版本浏览器无法进行转换，出现NAN问题;update by xiaoyuling 2017-10-28

                                        if (!parameter[ii].dateFormat) {
                                            html += "<td";
                                            //自定义样式
                                            if (parameter[ii].customStyle) {
                                                html += " class=\"" + parameter[ii].customStyle + "\"";
                                            }
//	        								html += ">"+newDate(data).format("yyyy-MM-dd")+"</td>";
                                            if (parameter[ii].show == 2) {
                                                html += " style=\"display:none;\"";
                                            }
                                            html += ">" + newDate(codeVal).format("yyyy-MM-dd") + "</td>";
                                        } else {
                                            html += "<td";
                                            //自定义样式
                                            if (parameter[ii].customStyle) {
                                                html += " class=\"" + parameter[ii].customStyle + "\"";
                                            }
//	        								html += ">"+newDate(data).format(parameter[ii].dateFormat)+"</td>";
                                            if (parameter[ii].show == 2) {
                                                html += " style=\"display:none;\"";
                                            }
                                            html += ">" + newDate(codeVal).format(parameter[ii].dateFormat) + "</td>";
                                        }
                                    }
                                }
                            }
                        }
                    }
                    //拼接操作按钮
                    if (funBtns && funBtns.length > 0 && showFunBtns != 0) {
                        html += "<td>";
                        for (var iii = 0; iii < funBtns.length; iii++) {
                            //设置按钮样式
                            if (funBtns[iii].show == undefined || funBtns[iii].show == 1) {
                                if (funBtns[iii] && funBtns[iii].style) {
                                    html += "<span class=\"operationButton cs-icon-span " + funBtns[iii].style.operationCode + "\" onclick=\"datagridUtil.customizeFun('" + eval("obj[" + i + "]." + rowIdCode) + "','" + iii + "')\"><i class=\"" + funBtns[iii].style.functionIcon + "\" title=\"" + funBtns[iii].style.operationName + "\"></i></span>";
                                } else {
                                    html += "<span class=\"operationButton\" onclick=\"datagridUtil.customizeFun('" + eval("obj[" + i + "]." + rowIdCode) + "','" + iii + "')\">" + funBtns[iii].text + "</span>";
                                }
                            } else if (funBtns[iii].show == 0) {
                                if (funBtns[iii] && funBtns[iii].style) {
                                    html += "<span class=\"operationButton cs-icon-span " + funBtns[iii].style.operationCode + "\" onclick=\"datagridUtil.customizeFun('" + eval("obj[" + i + "]." + rowIdCode) + "','" + iii + "')\" style=\"display:none;\"><i class=\"" + funBtns[iii].style.functionIcon + "\" title=\"" + funBtns[iii].style.operationName + "\"></i></span>";
                                } else {
                                    html += "<span class=\"operationButton\" onclick=\"datagridUtil.customizeFun('" + eval("obj[" + i + "]." + rowIdCode) + "','" + iii + "')\" style=\"display:none;\">" + funBtns[iii].text + "</span>";
                                }
                            }
                        }
                        html += "</td>";
                    }
                    html += "</tr>";
                }
            }
            html += "</tbody></table></div></div>";

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
                        html += " onclick=\"datagridUtil.bottomBtnFun('" + i + "')\"><i class=\"" + bottomBtns[i].style.functionIcon + "\"></i>" + bottomBtns[i].style.operationName + "</a>";
                    } else {
                        html += " onclick=\"datagridUtil.bottomBtnFun('" + i + "')\"><i>" + bottomBtns[i].text + "</i></a>";
                    }
                }
            }

            html += "<ul class=\"cs-pagination cs-fr\">";
            html += "<li class=\"cs-distan\">共" + pageCount + "页/" + rowTotal + "条记录</li>";
            html += "<li class=\"cs-b-nav-btn cs-distan cs-selcet\">";
            html += "<select id=\"" + pageSizeSel + "\" onchange=\"datagridUtil.resetPageSize();\">";
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
                "onclick=\"datagridUtil.toPage('" + 1 + "');\">«</a></li>";
            pageNo = parseInt(pageNo);
            //导航页面序号居中
            if ((pageCount < navBtnNum) || (pageNo - halfBtnNum <= 0)) {
                //总页数少于5或最前几页显示
                for (var i = 1; i <= (pageCount > navBtnNum ? navBtnNum : pageCount); i++) {
                    html += "<li><a class=\"cs-b-nav-btn";
                    if (pageNo == i) {
                        html += " cs-n-active";
                    }
                    html += "\" onclick=\"datagridUtil.toPage('" + i + "');\">" + i + "</a></li>";
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
                            html += "\" onclick=\"datagridUtil.toPage('" + i + "');\">" + i + "</a></li>";
                        }
                    } else if (i < pageCount) {
                        for (var ii = pageCount - navBtnNum + 1; ii <= pageCount; ii++) {
                            html += "<li><a class=\"cs-b-nav-btn";
                            if (pageNo == ii) {
                                html += " cs-n-active";
                            }
                            html += "\" onclick=\"datagridUtil.toPage('" + ii + "');\">" + ii + "</a></li>";
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
                            html += "\" onclick=\"datagridUtil.toPage('" + i + "');\">" + i + "</a></li>";
                        }
                    } else {
                        //奇数按钮数量
                        for (var i = pageNo - halfBtnNum; i <= pageNo + halfBtnNum; i++) {
                            html += "<li><a class=\"cs-b-nav-btn";
                            if (pageNo == i) {
                                html += " cs-n-active";
                            }
                            html += "\" onclick=\"datagridUtil.toPage('" + i + "');\">" + i + "</a></li>";
                        }
                    }
                }
            }
            html += "<li class=\"cs-next \"><a class=\"cs-b-nav-btn\" " +
                "onclick=\"datagridUtil.toPage('" + pageCount + "');\">»</a></li>";
            html += "<li class=\"cs-skip cs-distan\">跳转<input id=\"" + toPageNo + "\" type=\"text\" />页</li>";
            html += "<li><a class=\"cs-b-nav-btn cs-enter cs-distan\" " +
                "onclick=\"datagridUtil.toPage();\">确定</a></li>";
            html += "</ul></div>";

            //刷新列表
            $("#" + tableId).append(html);

            //禁用回车键自动提交form
            $(".cs-search-filter").parent("form").attr("onsubmit","return false;");

            //加载完成后,执行自定义函数
            if (onload) {
                onload(obj, pageData);
            }

        },
        /**
         * 设置每页显示记录数量
         */
        resetPageSize: function () {
            datagridOption['pageSize'] = document.getElementById("" + datagridOption['pageSizeSel'] + "").value;
            window.localStorage.pageSize = datagridOption['pageSize'];
            datagridUtil.query();
        },
        /**
         * 跳转到第*页
         */
        toPage: function (pageNo) {
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
            datagridUtil.query(pageNo);
        },
        /**
         * 查询
         * queryType 查询类型 默认高级搜索查询 0:高级搜索查询,1:关键词查询
         */
        query: function (pageNo, queryType) {

            //查询前执行自定义函数
            if (datagridOption["before"]) {
                datagridOption["before"](queryType);
            }

            //设置页面序号
            if (!pageNo) {
                //刷新列表默认为第一页
                //datagridOption['pageNo'] = 1;
            } else {
                datagridOption['pageNo'] = parseInt(pageNo);
            }

            //设置全局查询类型  0:高级搜索查询,1:关键词查询
            if (queryType == 0 || queryType == 1) {
                datagridOption['queryType'] = queryType;
            }

            //拼接ajax参数
            var dataStr = "{\"pageSize\":" + datagridOption['pageSize'] + ",\"pageNo\":" + datagridOption['pageNo']
                + ",\"rowTotal\":" + datagridOption['rowTotal'] + ",\"pageCount\":" + datagridOption['pageCount'];

            //时间范围变量
            var dateMap = "";

            //搜索类型
            if (datagridOption['queryType'] == 0) {
                //高级搜索查询
                var qps = document.getElementsByClassName(datagridOption["tableId"] + "-qpinput");
                //清空关键词输入框
                var fi = document.getElementsByClassName("focusInput");
                for (var j = 0; j < fi.length; j++) {

                    if (fi[j].type == "checkbox" || fi[j].type == "radio") {	//单选框和复选框取消选中
                        fi[j].checked = false;
                    } else {	//其他清空value
                        fi[j].value = "";
                    }

                }
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
                                        dataStr += ",\"" + qps[i].name + "\":\"" + qps[i].value + "\"";
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
                var qps = document.getElementsByClassName("focusInput");
                //清空高级搜索输入框
                for (var ii = 0; ii < datagridOption["parameter"].length; ii++) {
                    datagridOption["parameter"][ii].queryVal = "";
                }
                //拼接搜索框查询条件
                for (var i = 0; i < qps.length; i++) {
                    if (qps[i].value) {
                        dataStr += ",\"" + qps[i].name + "\":\"" + qps[i].value + "\"";
                    }
                }
            }

            //拼接默认查询条件
            if (datagridOption['defaultCondition']) {
                for (var j = 0; j < datagridOption["defaultCondition"].length; j++) {
                    dataStr += ",\"" + datagridOption["defaultCondition"][j].queryCode + "\":\"" + datagridOption["defaultCondition"][j].queryVal + "\"";
                }
            }

            //拼接时间范围查询条件
            if (dateMap) {
                dateMap = dateMap.substring(0, dateMap.length - 1);
                dataStr += ",\"dateMap\":{" + dateMap + "}";
            }

            dataStr += "}";

            $.ajax({
                type: "POST",
                url: datagridOption['tableAction'],
                data: JSON.parse(dataStr),
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
                        datagridUtil.spliceHtml();
                    } else {
                        console.log("查询失败");
                    }
                },
                error: function () {
                    console.log("查询失败");
                }
            });
        },
        /**
         * 刷新
         */
        refresh: function () {
            document.getElementById(datagridOption["tableId"]).innerHTML = "";
            datagridUtil.query(1, datagridOption['queryType']);
        },
        /**
         * 关键词查询
         */
        queryByFocus: function () {
            datagridUtil.query(1, 1);
        },
        /**
         * 执行按钮自定义函数
         */
        customizeFun: function (rowId, btnNo) {
            var funbtn = datagridOption['funBtns'][btnNo];
            funbtn.action(rowId);
        },
        /**
         * 底部按钮函数
         */
        bottomBtnFun: function (btnNo) {
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
        },
        /**
         * 全选列表复选框
         */
        checkedAll: function () {
            var tableId = datagridOption["tableId"];
            var cbs = document.getElementsByName("rowCheckBox");
            if (document.getElementById(tableId + "_mainCheckBox").checked) {
                //全选
                for (var i = 0; i < cbs.length; i++) {
                    cbs[i].checked = true;
                }
            } else {
                //全不选
                for (var i = 0; i < cbs.length; i++) {
                    cbs[i].checked = false;
                }
            }
        },
        /**
         * 选择、取消单个记录复选框
         */
        changeBox: function () {
            var cbs = document.getElementsByName("rowCheckBox");
            var mbStatus = true;	//选中全选复选框
            for (var i = 0; i < cbs.length; i++) {
                if (!cbs[i].checked) {
                    mbStatus = false;
                    break;
                }
            }
            document.getElementById(datagridOption["tableId"] + "_mainCheckBox").checked = mbStatus;
        },
        /**
         * 排序
         */
        orderBy: function (mTableId, colNo, dataType) {
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
            var rows = document.getElementsByClassName("rowNo");
            for (var i = 0; i < rows.length; i++) {
                rows[i].innerHTML = i + 1;
            }
        },
        /**
         * 排序
         * 数据统计专用
         */
        orderBy2: function (mTableId, colNo, dataType) {
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
            var rows = document.getElementsByClassName("rowNo");
            for (var i = 0; i < rows.length; i++) {
                rows[i].innerHTML = i + 1;
            }
        },
        /**
         * 清空高级搜索条件(不会自动刷新列表)
         */
        cleanQueryVal: function () {
            //清空高级搜索输入框
            var qps = document.getElementsByClassName(datagridOption["tableId"] + "-qpinput");
            for (var j = 0; j < qps.length; j++) {
                if (qps[j].type == "checkbox" || qps[j].type == "radio") {	//单选框和复选框取消选中
                    qps[j].checked = false;
                } else {	//其他清空value
                    qps[j].value = "";
                }
            }
        },
        /**
         * 清空关键词搜索条件(不会自动刷新列表)
         */
        cleanKeyword: function () {
            //清空关键词输入框
            var fi = document.getElementsByClassName("focusInput");
            for (var j = 0; j < fi.length; j++) {
                if (fi[j].type == "checkbox" || fi[j].type == "radio") {	//单选框和复选框取消选中
                    fi[j].checked = false;
                } else {	//其他清空value
                    fi[j].value = "";
                }
            }
        },
        /**
         * 添加/覆盖加载条件
         */
        addDefaultCondition: function (mQueryCode, mQueryVal) {
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
                        datagridOption.defaultCondition[i + 1].queryCode = mQueryCode;
                        datagridOption.defaultCondition[i + 1].queryVal = mQueryVal;
                    }
                }

            }
        },
        /**
         * 删除加载条件
         */
        delDefaultCondition: function (mQueryCode) {
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
        },
        /**
         * 获取加载条件值
         */
        getDefaultCondition: function (mQueryCode) {
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
        }

    }

})();

$(document).on("keydown",".focusInput",function(e){
    //回车键事件-关键词查询
    if (e.keyCode == 13) {
        $(this).siblings(".cs-search-btn").click();
    }
});

//function fmtDate(obj){
//    var date =  newDate(obj);
//    var y = 1900+date.getYear();
//    var m = (date.getMonth()+1)<10?("0"+(date.getMonth()+1)):(date.getMonth()+1);
//    var d = date.getDate()<10?("0"+date.getDate()):date.getDate();
//    var h = date.getHours()<10?("0"+date.getHours()):date.getHours();
//    var mm = date.getMinutes()<10?("0"+date.getMinutes()):date.getMinutes();
//    var ss = date.getSeconds()<10?("0"+date.getSeconds()):date.getSeconds();
//    return y+"-"+m+"-"+d+" "+h+":"+mm+":"+ss;
//}
