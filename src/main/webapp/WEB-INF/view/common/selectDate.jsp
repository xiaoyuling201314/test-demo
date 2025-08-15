<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <div class="cs-input-style cs-fl" style="margin:3px 0 0 4px;">
      <select id="province" class="cs-selcet-style pull-left" style="width: 85px;margin-right:4px;">

        <option value="month" selected="selected">月汇总</option>

        <option value="season">季汇总</option>

         <option value="year">年汇总</option>

         <option value="diy">自定义</option>
      </select>

      <div class="check-date cs-hide">
      <select class="cs-selcet-style"></select>
      </div>

      <div class="check-date pull-left">
        <select class="theyear cs-selcet-style" id="year1" name="year1" style="width: 98px;">
            <%--<option value="" >--请选择--</option>--%>
        </select>
       <select class="cs-selcet-style" id="month" name="month" style="width: 85px;">
         <%--<option value="">--请选择--</option>--%>
         <option value="1">1月</option>

         <option value="2">2月</option>

         <option value="3">3月</option>

         <option value="4">4月</option>

         <option value="5">5月</option>

         <option value="6">6月</option>

         <option value="7">7月</option>

         <option value="8">8月</option>

         <option value="9">9月</option>

         <option value="10">10月</option>

         <option value="11">11月</option>

         <option value="12">12月</option>

      </select>
      </div>

      <div class="check-date pull-left cs-hide">
      <select class="theyear cs-selcet-style" id="year2" name="year2" style="width: 98px;">
        <%--<option value="">--请选择--</option>--%>
      </select>
      <select class="cs-selcet-style" id="season" name="season" style="width: 85px;">
         <%--<option value="">--请选择--</option>--%>
         <option value="1">第一季度</option>

         <option value="2">第二季度</option>

         <option value="3">第三季度</option>

         <option value="4">第四季度</option>
      </select>
      </div>

      <div class="check-date pull-left cs-hide">
      <select class="theyear cs-selcet-style" id="year3" name="year3" style="width: 85px;">
         <%--<option value="">--请选择--</option>--%>
      </select>
      </div>
    </div>
    <span class="check-date cs-hide">
        <span class="cs-in-style cs-time-se cs-time-se">
            <input name="start"  style="width: 120px;" autocomplete="off" class="cs-time Validform_error" id="start" onclick="WdatePicker({maxDate:'#F{$dp.$D(end)}',startDate:'%y-%M-%d',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" autocomplete="off">
            -
            <input name="end"  style="width: 120px;" autocomplete="off" class="cs-time Validform_error" id="end" onclick="WdatePicker({minDate:'#F{$dp.$D(start)}',startDate:'%y-%M-%d',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" autocomplete="off">
        </span>
        <span>
            <a href="javascript:" class="cs-menu-btn" style="margin:4px 0 0 10px;" onclick="selectDate.query()"><i class="icon iconfont icon-chakan"></i>查询</a>
        </span>
    </span>

 <script type="text/javascript">
    $(function () {
        $(document).on("change","#province",function(){
             var date=new Date();
             var monthsss=date.getMonth()+1;
             var year=date.getFullYear();
             var season;

             if(monthsss < 4) {
                 season=1;
             }else if(monthsss< 7) {
                 season=2;
             }else if(monthsss<10) {
                 season=3;
             }else if(monthsss<13) {
                 season=4;
             }
            selectDate.query();

 		});
 		$(document).on("change","#month,#season,#year1,#year2,#year3,#pointType",function(){
            selectDate.query();
 		});
	});

	selectDate = (function () {
        return {
            init: function (f) {
                var selyear = $(".theyear");
                var startYear=2017;
                var now = new Date();
                var year = now.getFullYear(); //获取当前年份
                var betYear = year-startYear+1;
                for (var i = 0; i < betYear; i++) {
                    var option = $("<option>").val(startYear).text(startYear+"年"); //给option添加value值与文本值
                    selyear.append(option);  //添加到select下
                    startYear = startYear+1;       //年份+1，再添加一次
                }
                switch (now.getMonth()) {
                    case 0,1,2:
                        $("#season").val("1");
                        break;
                    case 3,4,5:
                        $("#season").val("2");
                        break;
                    case 6,7,8:
                        $("#season").val("3");
                        break;
                    case 9,10,11:
                        $("#season").val("4");
                        break;
                }

                var monthsss=now.getMonth()+1;
                $("#month").find("option[value='"+monthsss+"']").attr("selected",true);
                $(".theyear").find("option[value='"+year+"']").attr("selected",true);

                //时间段
                var month = (now.getMonth()+1) < 10 ? "0"+(now.getMonth()+1) : (now.getMonth()+1);
                var date = now.getDate() < 10 ? "0"+now.getDate() : now.getDate();
                $("#start").val(now.getFullYear()+"-"+month+"-01");
                $("#end").val(now.getFullYear()+"-"+month+"-"+date);

                selectDate.query = function (){f(selectDate.getSelectDate())};
                selectDate.query();
            },
            query: function () {

            },
            getSelectDate: function (){
                var myDate = {
                    type: $("#province").val(),
                    year: "",
                    month: "",
                    season: "",
                    start: "",
                    end: ""
                };
                switch ($("#province").val()) {
                    case "month":
                        myDate.year = $("#year1").val();
                        myDate.month = $("#month").val();
                        myDate.start = myDate.year+"-"+myDate.month+"-01";
                        myDate.end = myDate.year+"-"+myDate.month+"-"+(new Date(myDate.year,myDate.month,0).getDate());
                        break;

                    case "season":
                        myDate.year = $("#year2").val();
                        myDate.season = $("#season").val();
                        switch (myDate.season) {
                            case "1":
                                myDate.start = myDate.year+"-01-01";
                                myDate.end = myDate.year+"-03-31";
                                break;
                            case "2":
                                myDate.start = myDate.year+"-04-01";
                                myDate.end = myDate.year+"-06-30";
                                break;
                            case "3":
                                myDate.start = myDate.year+"-07-01";
                                myDate.end = myDate.year+"-09-30";
                                break;
                            case "4":
                                myDate.start = myDate.year+"-10-01";
                                myDate.end = myDate.year+"-12-31";
                                break;
                        }
                        break;

                    case "year":
                        myDate.year = $("#year3").val();
                        myDate.start = myDate.year+"-01-01";
                        myDate.end = myDate.year+"-12-31";
                        break;

                    case "diy":
                        myDate.start = $("#start").val();
                        myDate.end = $("#end").val();
                        break;
                }
                return myDate;
            }
        }
    })();

</script>