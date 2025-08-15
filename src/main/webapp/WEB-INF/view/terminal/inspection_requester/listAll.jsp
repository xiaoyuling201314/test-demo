<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>委托单位</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <%--<button onclick="chakan()">查看</button>--%>
        <form action="datagrid.do">
            <div class="cs-search-filter clearfix cs-fl">
                <input type="hidden" name="reqIds"/>
                <input class="cs-input-cont cs-fl focusInput" type="text" name="requesterName" placeholder="请输入内容"/>
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
            <div class="clearfix cs-fr" id="showBtn">
            </div>
        </form>
    </div>
</div>
<div id="dataList"></div>
<script>
    //给数组添加一个去重函数
    Array.prototype.distinct = function () {
        let arr = this,
            i,
            j,
            len = arr.length;
        for (i = 0; i < len; i++) {
            for (j = i + 1; j < len; j++) {
                if (arr[i] == arr[j]) {
                    arr.splice(j, 1);
                    len--;
                    j--;
                }
            }
        }
        return arr;
    };

    // 两个数组的数据去重
    this.arrayWeightRemoval = function (array1, array2) {
        //临时数组存放
        let tempArray1 = [];//临时数组1
        let tempArray2 = [];//临时数组2

        for (let i = 0; i < array2.length; i++) {
            tempArray1[array2[i]] = true;//将数array2 中的元素值作为tempArray1 中的键，值为true；
        }

        for (let i = 0; i < array1.length; i++) {
            if (!tempArray1[array1[i]]) {
                tempArray2.push(array1[i]);//过滤array1 中与array2 相同的元素；
            }
        }
        return tempArray2;
    }
</script>
<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
    rootPath = "${webRoot}/requester/unit/";
    var reqIds;//父页面传递过来的委托单位ID字符串,用逗号分隔 格式如: 1,2,3
    var checkedReqIds;//子界面选中的所有委托单位ID的数组集
    $(function () {
        let reqIdsStr = $("input[name=reqIds]").val();
        reqIds = reqIdsStr ? reqIdsStr.split(",") : [];
        checkedReqIds = reqIdsStr ? reqIdsStr.split(",") : [];
        var op = {
            tableId: "dataList",	//列表ID
            tableAction: rootPath + "/datagrid.do",	//加载数据地址
            parameter: [		//列表拼接参数
                {
                    columnCode: "requesterName",
                    columnName: "单位名称",
                    customStyle: "my_name",
                    columnWidth: "20%"
                },
                {
                    columnCode: "requesterOtherName",
                    columnName: "单位别称",
                    columnWidth: "20%"
                },
                {
                    columnCode: "creditCode",
                    columnName: "社会信用代码",
                    columnWidth: "20%"
                }, {
                    columnCode: "state",
                    columnName: "单位状态",
                    customVal: {0: "营业", 1: "<span class='text-danger'>停业</span>"},
                    columnWidth: "12%"
                }
            ],
            rowTotal: 0,	//记录总数
            pageSize: pageSize,	//每页数量
            pageNo: 1,	//当前页序号
            pageCount: 1,	// 总页数
            onload: function () {
                //去除checkbox的冒泡事件
                $("input[type='checkbox']").click(function (e) {
                    e.stopPropagation();//去除checkbox的冒泡事件
                    //根据是否勾选去改变checkedReqIds的值
                    let currentId = $(this).closest("tr").attr("data-rowId");
                    if (currentId) addOrDel(currentId);
                });

                //传递需要保存的委托单位ID赛选原则:全选添加所有的ID,单独勾选中的ID,进行去重传递
                $(".rowTr").each(function () {
                    let currentTr = $(this);//获取每行的TR对象
                    //给tr绑定点击事件
                    currentTr.click(function () {
                        //点击的时候,不选中变为选中,选中的变为不选中
                        let cbo = currentTr.find("input[name=rowCheckBox]");
                        cbo.prop("checked") ? cbo.prop("checked", false) : cbo.prop("checked", true);
                        let currentId = currentTr.attr("data-rowId");
                        if (currentId) addOrDel(currentId);
                    });

                    //把已经选过的委托单位设置为选中状态
                    if (checkedReqIds) {
                        let rowId = $(this).attr("data-rowId");
                        if (checkedReqIds.indexOf(rowId) != -1) $(this).find("input[name=rowCheckBox]").prop("checked", "checked");
                    }
                });

                //全选与全不选时对checkedReqIds值的改变
                $("#dataList_mainCheckBox").change(function () {
                    if ($("#dataList_mainCheckBox").prop("checked")) {
                        $(".rowTr").each(function () {
                            checkedReqIds.push($(this).attr("data-rowId"));
                        });
                        checkedReqIds.distinct();//去重
                        //console.log(checkedReqIds)
                    } else {
                        if (checkedReqIds.length) {
                            for (let i = 0; i < checkedReqIds.length; i++) {
                                $(".rowTr").each(function () {
                                    if (checkedReqIds[i] == $(this).attr("data-rowId")) checkedReqIds.splice(i, 1);
                                });
                            }
                        }
                        //console.log(checkedReqIds)
                    }
                });
            }
        };
        datagridUtil.initOption(op);
        datagridUtil.query();
    });

    //用于返回父页面获取子界面的委托单位ID数组集
    function getReqIds() {
        checkedReqIds.distinct();//去重
        return reqIds ? this.arrayWeightRemoval(checkedReqIds, reqIds) : checkedReqIds;//再次去重
    }

    const addOrDel = currentId => {
        if (checkedReqIds.length) {
            if (checkedReqIds.indexOf(currentId) != -1) {
                checkedReqIds.splice(checkedReqIds.indexOf(currentId), 1);
            } else {
                checkedReqIds.push(currentId);
            }
        } else {
            checkedReqIds.push(currentId);
        }
    }

    /*function chakan() {
     console.log(checkedReqIds);
     checkedReqIds.distinct();//去重
     console.log(checkedReqIds);
     console.log("=============过滤已经存在的关系=================" + reqIds);
     console.log(this.arrayWeightRemoval(checkedReqIds, reqIds));
     }*/

</script>
</body>
</html>
