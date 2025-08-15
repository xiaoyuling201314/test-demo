<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<script type="text/javascript" src="${webRoot}/js/distinctFoodName.js"></script>
<html>
<head>
    <title>快检服务云平台</title>
    <style type="text/css">
        .firstContextStyle{
            width:12%;
        }
        .contextStyle{
            /*   width:28%;*/
        }
        .contextNumber{
            width:8%;
        }
        .contextUnqual{
            width:10%;
        }
        .select2-container--default .select2-selection--single, .select2-container--default .select2-selection--single:focus{
            height: 30px;
        }
        .cs-check-down, .cs-check-down2,.cs-input-box,.select2-container{
            max-width: 150px;
        }
    </style>
</head>
<body>

<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb clearfix cs-fl" >
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt="" />
            <a href="javascript:">数据统计</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">食品名称统计
        </li>
    </ol>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-fl">
    <c:if test="${ empty session_user.pointId }">
        <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;">
            <div class="cs-all-ps">
                <div class="cs-input-box">
                    <input type="hidden" id="did" value="${session_user.departId}"/>
                    <input type="text" name="departName" readonly="readonly" style="width: 100%;">
                    <div class="cs-down-arrow"></div>
                </div>
                <div class="cs-check-down cs-hide" style="display: none;">
                    <ul id="tree" class="easyui-tree"></ul>
                </div>
            </div>
            <!-- <select id="projectName">
               <option value="">全部</option>
            </select> -->
        </div>
        </c:if>
        <div class="cs-input-style cs-fl cs-hide" style="margin:3px 0 0 15px;" id="pointDiv">
            <div class="cs-all-ps">
                <div class="cs-in-style" >
               <%--检测室：--%><select class="js-select2-tags" name="pointId" id="point_select">
                    <c:choose>
                        <c:when test="${ ! empty session_user.pointId }">
                            <option value="${session_user.pointId}">${session_user.pointName}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="">--请选择检测室--</option>
                        </c:otherwise>
                    </c:choose>

                </select>
                </div>
            </div>
        </div>
        <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;" id="foodTreeDiv">
            <div class="cs-all-ps">
                <div class="cs-input-box">
                    <input type="hidden" id="fid"/>
                    <input type="text" name="foodName" readonly="readonly" style="width: 100%;">
                    <div class="cs-down-arrow"></div>
                </div>
                <div class="cs-check-down cs-hide" style="display: none;">
                    <ul id="trees" class="easyui-tree"></ul>
                </div>
            </div>
        </div>

        <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;" id="typeDiv">

        </div>
        <!--检测点类型条件-->
        <%@include file="/WEB-INF/view/statistics/selectPointType.jsp"  %>
        <!-- 顶部筛选 -->
        <%@include file="/WEB-INF/view/common/selectDate.jsp"%>
    </div>

</div>
</div>
</div>
<div class="cs-tb-box">

    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <div style="border:1px solid #ddd; padding:10px 0; margin-bottom:10px; border-left:0; border-right:0;">
        <div id="third" class="cs-echart" style="width: 63%;height:380px; display:inline-block;"></div>
        <div id="second" class="cs-echart" style="width: 35%;height:380px;display:inline-block; margin-left:1%;"></div>
    </div>

    <div style="padding-bottom:50px;">
        <table class="cs-table cs-table-hover table-striped cs-tablesorter" id="table">
            <thead>
            <tr>
                <th class="cs-header columnHeading" style='width:50px;'>序号</th>
                <th class="cs-header columnHeading firstContextStyle" onclick="datagridUtil.orderBy2('table',1,'string')">食品名称<span class="sortIcon icon iconfont icon-sort"></span></th>
                <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',2,'int')">抽检总数<span class="sortIcon icon iconfont icon-sort"></span></th>
                <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',3,'int')">合格数<span class="sortIcon icon iconfont icon-sort"></span></th>
                <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',4,'int')">不合格数<span class="sortIcon icon iconfont icon-sort"></span></th>
                <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',5,'float')">合格率<span class="sortIcon icon iconfont icon-sort"></span></th>
<%--                <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',6,'float')">不合格率<span class="sortIcon icon iconfont icon-sort"></span></th>--%>

                <th class="cs-header columnHeading contextUnqual" onclick="datagridUtil.orderBy2('table',6,'float')">抽样基数(KG)<span class="sortIcon icon iconfont icon-sort"></span></th>
                <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',7,'float')">销毁数(KG)<span class="sortIcon icon iconfont icon-sort"></span></th>
                <th class="cs-header columnHeading contextStyle" onclick="datagridUtil.orderBy2('table',8,'float')">阳性样品<span class="sortIcon icon iconfont icon-sort"></span></th>

            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <!-- Button to trigger modal -->

</div>

<!-- 内容主体 结束 -->


<!-- JavaScript -->
<script src="${webRoot}/js/datagridUtil.js"></script>
<script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
<script src="${webRoot}/plug-in/echarts/shine.js"></script>
<script src="${webRoot}/js/selectRow.js"></script>
<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<script type="text/javascript">
    var echartMaxLength1 = 20;
    var echartMaxLength2 = 10;
    $('.js-select2-tags').select2();
    if(Permission.exist("1310-1")){
        var html='<select id="type" class="cs-selcet-style" style="width: 100px;"></select>';
        $("#typeDiv").append(html);
    }
    if(Permission.exist("1310-2")){
        $("#pointType").removeClass("cs-hide");
    }
    if("${session_user.pointId}"=="" && Permission.exist("1310-3")){
        $("#pointDiv").removeClass("cs-hide");
        queryPoint(${session_user.departId});//查询当前机构下的检测点信息
    }
    //武陵系统：特殊项目分类，不再需要类别条件
    if("${systemFlag}"=="1"){
        $("#foodTreeDiv").addClass("cs-hide");
    }
    $(function () {
        var foodId = [];
        var foodName = [];
        var foodNames = [];
        var num = [];
        var qualified=[];
        var unqualified=[];
        var arr=[];
        var nums=0;
        var qualifieds=0;
        var unqualifieds=0;

        var treeLevel = 1;	//控制机构树加载二级数据
        $('#tree').tree({
            checkbox : false,
            url : "${webRoot}/detect/depart/getDepartTree.do",
            animate : true,
            onClick : function(node) {
                var did=node.id;
                $("#did").val(node.id);
                $("input[name='departName']").val(node.text);
                $(".cs-check-down").hide();
                $("#point_select").val("");
                // loadQuery();
                selectDate.query();
                queryPoint(node.id);//查询当前机构下的检测点信息
            },
            onSelect:function(node) {
                var did=node.id;
                $("#did").val(node.id);
            },onLoadSuccess: function (node, data) {
                //延迟执行自动加载二级数据，避免与异步加载冲突
                setTimeout(function(){
                    if (data && treeLevel == 1) {
                        treeLevel++;
                        $(data).each(function (index, d) {
                            if (this.state == 'closed') {
                                var children = $('#tree').tree('getChildren');
                                for (var i = 0; i < children.length; i++) {
                                    $('#tree').tree('expand', children[i].target);
                                }
                            }
                        });
                    }
                }, 100);
            }
        });
        var treeLevels = 1;	//控制机构树加载二级数据
        $("#trees").tree({
            checkbox:false,
            url:"${webRoot}/data/foodType/foodTree.do",
            animate:true,
            onClick : function(node){
                var fid=node.id;
                $("#fid").val(node.id);
                $("input[name='foodName']").val(node.text);
                $(".cs-check-down").hide();
                // loadQuery();
                selectDate.query();
                //alert(node.id+"===="+node.parentId);
            },
            onSelect:function(node) {
                var fid=node.id;
                $("#fid").val(node.id);
            },
            onLoadSuccess: function (node, data) {
                if (data[0].parentId!=null&& treeLevels == 2) {
                    //调用选中事件
                    var n = $('#trees').tree('find', data[0].id);
                    $('#trees').tree('select', n.target);//设置选中该节点
                    $("input[name='foodName']").val(data[0].text);
                    // loadData();
                    selectDate.query();
                }
                //延迟执行自动加载二级数据，避免与异步加载冲突
                setTimeout(function(){
                    if (data && treeLevels == 1) {
                        treeLevels++;
                        $(data).each(function (index, d) {
                            if (this.state == 'closed') {
                                var children = $('#trees').tree('getChildren');
                                for (var i = 0; i < children.length; i++) {
                                    $('#trees').tree('expand', children[i].target);
                                }
                            }
                        });
                    }
                }, 100);
            }
        });


        project();
        loadType();
        //selectDate修改时间后执行函数
        selectDate.init(loadData);
    });
    //选择检测点或监管对象类型
    $(document).on("change","#point_select,#type",function(){
        selectDate.query();
    });
    function project() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/statistics/querydepart.do",
            dataType: "json",
            success: function(data){
                if(data && data.success){
                    $("input[name='departName']").val(data.obj.departName);
                    var node = $('#tree').tree('find', data.obj.id);
                    $('#tree').tree('select', node.target);//设置选中该节点
                }else{
                    $("#confirm-warnning .tips").text(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }

    function loadType() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/regulatory/regulatoryType/queryAll.do",
            dataType: "json",
            success: function(data){
                if(data && data.success){
                    var list=data.obj;
                    $("#type").empty();
                    $("#type").append('<option value="">-全部对象-</option>');
                    for (var i in list) {
                        $("#type").append('<option value="' + list[i].id+ '">'+list[i].regType+ '</option>');
                    }
                }else{
                    $("#confirm-warnning .tips").text(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }

    function loadData(d) {
        $.ajax({
            type: "POST",
            url: '${webRoot}'+"/statistics/loadFood.do",
            data:{
                type:d.type,
                year:d.year,
                month:d.month,
                season:d.season,
                start:d.start,
                end:d.end,
                typeObj:$("#type option:selected").val(),
                did:$("#did").val(),
                fid:$("#fid").val(),
                pointType:$("select[name=pointType]").val(),
                pointId:$("#point_select").val(),
                systemFlag:1 //systemFlag：系统标志，默认为0;0 为通用系统，1 武陵定制系统
            },
            dataType: "json",
            success: function(data){
                if(data && data.success){
                    $("#table thead .sortIcon").addClass("icon-sort");
                    $("#table thead .sortIcon").removeClass("icon-xia1");
                    $("#table thead .sortIcon").removeClass("icon-shang1");
                    document.getElementById("table").sortCol = -1;

                    foodId = [];
                    foodName = [];
                    foodNames = [];
                    num = [];
                    qualified=[];
                    unqualified=[];
                    arr=[];
                    nums=0;
                    qualifieds=0;
                    unqualifieds=0;
                    purchaseAmounts=0;
                    destoryNumbers=0;
                    unqualifiedFoods="";
                    $("#table tbody tr").remove();
                    $.each(data.obj, function(k, v) {
                        foodId.push(v.foodId);
                        foodName.push(v.foodName);
                        qualified.push(v.qualified);
                        num.push(v.num);
                        unqualified.push(v.unqualified);

                        if (v.unqualified>0) {
                            foodNames.push(v.foodName);
                            arr.push({
                                name :v.foodName,
                                value :v.unqualified
                            });
                        }

                        nums=nums+v.num;
                        qualifieds=qualifieds+v.qualified;
                        unqualifieds=unqualifieds+v.unqualified;
                        purchaseAmounts=purchaseAmounts+v.purchaseAmount;
                        destoryNumbers=destoryNumbers+v.destoryNumber;
                        if(v.unqualifiedFood){
                            unqualifiedFoods=unqualifiedFoods+v.unqualifiedFood+",";
                        }
                        var bigbang="<tr>"
                            +"<td class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
                            +"<td class='firstContextStyle' >"+v.foodName+"</td>"
                            +"<td class='contextNumber'><a class='cs-link text-primary num' data-rowid="+v.foodId+">"+v.num+"</a></td>"
                            +"<td class='contextNumber'><a class='cs-link text-primary qualified' data-rowid="+v.foodId+">"+v.qualified+"</a></td>"
                            +"<td class='contextNumber'><a class='cs-link text-primary unqualified' data-rowid="+v.foodId+">"+v.unqualified+"</a></td>"
                            +"<td class='contextNumber'>"+((v.qualified/v.num)*100).toFixed(2)+"%</td>"
                           /* +"<td class='contextNumber'>"+((v.unqualified/v.num)*100).toFixed(2)+"%</td>"*/
                            +"<td class='contextUnqual'>"+v.purchaseAmount.toFixed(2)+"</td>"
                            +"<td class='contextNumber'>"+v.destoryNumber.toFixed(2)+"</td>"
                            +"<td class='contextStyle'>"+v.unqualifiedFood+"</td>"
                            +"</tr>"
                        $("#table tbody").append(bigbang);
                        //汇总合计
                        if((data.obj.length-1)==k){
                            unqualifiedFoods=unqualifiedFoods.substring(0,unqualifiedFoods.lastIndexOf(','))
                            let foodStr=removeRepeatStr(unqualifiedFoods);
                            bigbang="<tr><td style='width:50px;'>"+(data.obj.length+1)+"</td>" +
                                "<td>合计</td>" +
                                "<td>"+nums+"</td>" +
                                "<td>"+qualifieds+"</td>" +
                                "<td>"+unqualifieds+"</td>" +
                                "<td>"+(nums==0?0:((qualifieds/nums)*100).toFixed(2))+"%</td>" +
                                /*"<td>"+(nums==0?0:((unqualifieds/nums)*100).toFixed(2))+"%</td>" +*/
                                "<td>"+purchaseAmounts.toFixed(2)+"</td>" +
                                "<td>"+destoryNumbers.toFixed(2)+"</td>" +
                                "<td>"+foodStr+"</td></tr>";
                            $("#table tbody").append(bigbang);
                        }
                    });
                    // $("#table tbody").append("<tr><td style='width:50px;'>"+(data.obj.length+1)+"</td><td>合计</td><td>"+nums+"</td><td>"+qualifieds+"</td><td>"+(nums==0?0:((qualifieds/nums)*100).toFixed(2))+"%</td><td>"+unqualifieds+"</td><td>"+(nums==0?0:((unqualifieds/nums)*100).toFixed(2))+"%</td></tr>");

                    arr.splice(echartMaxLength2);
                    foodId.splice(echartMaxLength1);
                    foodNames.splice(echartMaxLength2);
                    foodName.splice(echartMaxLength1);
                    qualified.splice(echartMaxLength1);
                    num.splice(echartMaxLength1);
                    unqualified.splice(echartMaxLength1);
                    bigbang();
                }else{
                    console.log("查询失败");
                }
            },
            error: function(){
                console.log("查询失败");
            }
        });
    }

    //查看抽检总数
    $(document).on("click",".num",function(){
        var type=$("#province option:selected").val();
        var month=$("#month option:selected").val();
        var season=$("#season option:selected").val();
        var year=$("#year"+($("#province option:selected").index()+1)).val();
        var start=$("#start").val();
        var end=$("#end").val();
        var did=$("#did").val();
        var dname=$("input[name='departName']").val();
        var typeObj=$("#type option:selected").val();
        var pointId=$("#point_select").val();
        if (typeObj!=undefined) {
            showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&typeObj="+typeObj+"&pointId="+pointId));
        }else {
            showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&pointId="+pointId));
        }
    });

    //查看合格数
    $(document).on("click",".qualified",function(){
        var type=$("#province option:selected").val();
        var month=$("#month option:selected").val();
        var season=$("#season option:selected").val();
        var year=$("#year"+($("#province option:selected").index()+1)).val();
        var start=$("#start").val();
        var end=$("#end").val();
        var did=$("#did").val();
        var dname=$("input[name='departName']").val();
        var typeObj=$("#type option:selected").val();
        var pointId=$("#point_select").val();
        if (typeObj!=undefined) {
            showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=0"+"&typeObj="+typeObj+"&pointId="+pointId));
        }else {
            showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=0"+"&pointId="+pointId));
        }
    });

    //查看不合格数
    $(document).on("click",".unqualified",function(){
        var type=$("#province option:selected").val();
        var month=$("#month option:selected").val();
        var season=$("#season option:selected").val();
        var year=$("#year"+($("#province option:selected").index()+1)).val();
        var start=$("#start").val();
        var end=$("#end").val();
        var did=$("#did").val();
        var dname=$("input[name='departName']").val();
        var typeObj=$("#type option:selected").val();
        var pointId=$("#point_select").val();
        if (typeObj!=undefined) {
            showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=1"+"&typeObj="+typeObj+"&pointId="+pointId));
        }else {
            showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=1"+"&pointId="+pointId));
        }
    });

    function bigbang() {
        var myChart = echarts.init(document.getElementById('second'),"shine");

        second = {
            title: {
                text: '不合格比例',
                // subtext: 'Monthly pass rate'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'right',
                itemGap:7 ,
                data:foodNames
            },
            series : [
                {
                    name: '食品种类',
                    type: 'pie',
                    radius : '45%',
                    center: ['50%', '60%'],
                    data:arr,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]

        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(second);

        var myChart1 = echarts.init(document.getElementById('third'),"shine");

        third = {
            title: {
                text: '抽检数量',
                // subtext: 'Monthly pass rate'
            },
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data:['合格','不合格']
            },
            grid: {
                left: '4%',
                right: '4%',
                bottom: '6%',
                containLabel: true
            },
            xAxis : [
                {
                    type : 'category',
                    data : foodName,
                    axisLabel: {
                        show:true,
                        interval: 0, //强制所有标签显示
                        align:'right',
                        rotate:30,
                        textStyle: {
                            color: "#000",
                            lineHeight:16,
                        },
                        formatter: function (params){
                            var index = 8;
                            var newstr = '';
                            for(var i=0;i<params.length;i+=index){
                                var tmp=params.substring(i, i+index);
                                newstr+=tmp;
                            }
                            if( newstr.length > 8)
                                return newstr.substring(0,8) + '...';
                            else
                                return newstr;
                        },
                    },

                }
            ],
            /* xAxis : [
                {
                    type : 'category',
                    data : foodName,
                    axisLabel: {
                         interval: 0,
                          rotate: 20,
                          show: true,
                          splitNumber: 15,
                          textStyle: {
                              fontSize: 12
                          }
                      }
                }
            ], */
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    name:'合格',
                    type:'bar',
                    stack: '食品种类',
                    data:qualified
                },
                {
                    name:'不合格',
                    type:'bar',
                    stack: '食品种类',
                    data:unqualified
                },
                {
                    name: '合计总量',
                    type: 'bar',
                    stack: '食品种类',
                    label: {
                        normal: {
                            show: true,
                            position: 'insideBottom',
                            formatter:'{c}',
                            textStyle:{ color:'#000' }
                        }
                    },
                    itemStyle:{
                        normal:{
                            color:'rgba(128, 128, 128, 0)'
                        }
                    },
                    data: num
                }

            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart1.setOption(third);
    }
    /**
     *根据机构ID查询直属检测点信息
     * @param departId 机构ID
     */
    function queryPoint(departId) {
        var id = departId;
        $("#point_select").empty();
        $.ajax({
            url: "${webRoot}/system/user/getPoint.do",
            type: "POST",
            data: {"id": id},
            dataType: "json",
            async: false,
            success: function (data) {
                var list = data.obj;
                $("#point_select").append('<option value="">-全部检测室-</option>');
                for (var i in list) {
                    $("#point_select").append('<option value="' + list[i].id + '">' + list[i].pointName + '</option>');
                }
            },
            error: function () {
                $.Showmsg("操作失败");
            }
        });
    }
</script>
</body>
</html>
