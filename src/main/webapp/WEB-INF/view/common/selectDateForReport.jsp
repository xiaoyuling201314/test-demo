<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="cs-input-style cs-fl" style="margin:3px 0 0 4px;">
    <select id="ymd" class="cs-selcet-style pull-left" style="width: 85px;margin-right:4px;">
        <option class="ymd-month" value="month" selected="selected">月汇总</option>
        <option class="ymd-season" value="season">季汇总</option>
        <option class="ymd-year" value="year">年汇总</option>
        <option class="ymd-diy" value="diy">自定义</option>
    </select>

    <div class="check-date cs-hide">
        <select class="cs-selcet-style"></select>
    </div>

    <div class="ymd-month check-date pull-left">
        <select class="theyear cs-selcet-style" id="year1" name="year1" style="width: 98px;"></select>
        <select class="cs-selcet-style" id="month" name="month" style="width: 85px;">
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

    <div class="ymd-season check-date pull-left cs-hide">
        <select class="theyear cs-selcet-style" id="year2" name="year2" style="width: 98px;"></select>
        <select class="cs-selcet-style" id="season" name="season" style="width: 85px;">
            <option value="1">第一季度</option>
            <option value="2">第二季度</option>
            <option value="3">第三季度</option>
            <option value="4">第四季度</option>
        </select>
    </div>

    <div class="ymd-year check-date pull-left cs-hide">
        <select class="theyear cs-selcet-style" id="year3" name="year3" style="width: 85px;"></select>
    </div>
</div>
    <span class="ymd-diy check-date cs-hide">
        <span class="cs-in-style cs-time-se cs-time-se">
            <input name="start" style="width: 110px;" class="cs-time Validform_error" id="start"
                   onclick="WdatePicker({maxDate:'#F{$dp.$D(end)}',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})"
                   type="text" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间"
                   autocomplete="off">
            -
            <input name="end" style="width: 110px;" class="cs-time Validform_error" id="end"
                   onclick="WdatePicker({minDate:'#F{$dp.$D(start)}',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})"
                   type="text" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间"
                   autocomplete="off">
        </span>
    </span>
    <span>
        <a href="javascript:;" class="cs-menu-btn" style="margin:4px 0 0 10px;" onclick="selectDate.query()"><i
                class="icon iconfont icon-chakan"></i>查询</a>
    </span>

    <div class="modal fade intro2" id="timeLimitTips" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog cs-alert-width">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">提示</h4>
                </div>
                <div class="modal-body cs-alert-height cs-dis-tab">
                    <div class="cs-text-algin" id="successMsg">
                        <img src="${webRoot}/img/warn.png" width="40px"/>
                        <span class="tips">超出时间限制！</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script type="text/javascript">
    $(function () {
        $(document).on("change", "#ymd", function () {
            // var date = new Date();
            // var monthsss = date.getMonth() + 1;
            // var year = date.getFullYear();
            // var season;
            //
            // if (monthsss < 4) {
            //     season = 1;
            // } else if (monthsss < 7) {
            //     season = 2;
            // } else if (monthsss < 10) {
            //     season = 3;
            // } else if (monthsss < 13) {
            //     season = 4;
            // }

            changeYmd();

            if (selectDate.getAutoQuery()) {
                selectDate.query();
            }
        });

        $(document).on("change", "#month,#season,#year1,#year2,#year3,#pointType", function () {
            if (selectDate.getAutoQuery()) {
                selectDate.query();
            }
        });
    });

    //修改时间类型
    function changeYmd() {
        $("#ymd option").each(function (i, o) {
            if ($(this).val() == $("#ymd").val()) {
                $(".check-date").hide().find('select').attr('disabled', 'disabled');
                $(".check-date").eq(i + 1).show().find('select').removeAttr('disabled');
            }
        });
    }

    selectDate = (function () {
        //修改时间自动查询
        let autoQuery = false;
        //时间限制（月）
        let timeLimit = 0;
        return {
            //aq:修改时间自动执行回调函数；f:回调函数(时间参数)
            init: function (aq, tl, f) {
                var selyear = $(".theyear");
                var startYear = 2017;
                var now = newDate();
                var year = now.getFullYear(); //获取当前年份
                var betYear = year - startYear + 1;
                for (var i = 0; i < betYear; i++) {
                    var option = $("<option>").val(startYear).text(startYear + "年"); //给option添加value值与文本值
                    selyear.append(option);  //添加到select下
                    startYear = startYear + 1;       //年份+1，再添加一次
                }
                ;
                switch (now.getMonth()) {
                    case 0, 1, 2:
                        $("#season").val("1");
                        break;
                    case 3, 4, 5:
                        $("#season").val("2");
                        break;
                    case 6, 7, 8:
                        $("#season").val("3");
                        break;
                    case 9, 10, 11:
                        $("#season").val("4");
                        break;
                }

                var monthsss = now.getMonth() + 1;
                $("#month").find("option[value='" + monthsss + "']").attr("selected", true);
                $(".theyear").find("option[value='" + year + "']").attr("selected", true);

                //时间段
                var month = (now.getMonth() + 1) < 10 ? "0" + (now.getMonth() + 1) : (now.getMonth() + 1);
                var date = now.getDate() < 10 ? "0" + now.getDate() : now.getDate();
                $("#start").val(now.getFullYear() + "-" + month + "-01");
                $("#end").val(now.getFullYear() + "-" + month + "-" + date);

                if (aq) {
                    autoQuery = aq;
                }
                if (tl) {
                    timeLimit = tl;
                }
                if (f) {
                    this.callback = f;
                }
            },
            query: function () {
                if (timeLimit != 0) {
                    var md = this.getSelectDate();
                    var ts = newDate().Timespan(newDate(md.start), newDate(md.end), 'M');
                    if (ts > timeLimit) {
                        $("#timeLimitTips .tips").text("时间跨度不能大于"+timeLimit+"个月！");
                        $("#timeLimitTips").modal("show");
                        return false;
                    }
                }
                this.callback(this.getSelectDate());
            },
            getSelectDate: function () {
                var myDate = {
                    type: $("#ymd").val(),
                    year: "",
                    month: "",
                    season: "",
                    start: "",
                    end: ""
                };
                switch ($("#ymd").val()) {
                    case "month":
                        myDate.year = $("#year1").val();
                        myDate.month = $("#month").val();
                        myDate.start = myDate.year + "-" + (myDate.month < 10 ? "0" + myDate.month : myDate.month) + "-01";
                        myDate.end = myDate.year + "-" + (myDate.month < 10 ? "0" + myDate.month : myDate.month) + "-" + (new Date(myDate.year, myDate.month, 0).getDate());
                        break;

                    case "season":
                        myDate.year = $("#year2").val();
                        myDate.season = $("#season").val();
                        switch (myDate.season) {
                            case "1":
                                myDate.start = myDate.year + "-01-01";
                                myDate.end = myDate.year + "-03-31";
                                break;
                            case "2":
                                myDate.start = myDate.year + "-04-01";
                                myDate.end = myDate.year + "-06-30";
                                break;
                            case "3":
                                myDate.start = myDate.year + "-07-01";
                                myDate.end = myDate.year + "-09-30";
                                break;
                            case "4":
                                myDate.start = myDate.year + "-10-01";
                                myDate.end = myDate.year + "-12-31";
                                break;
                        }
                        break;

                    case "year":
                        myDate.year = $("#year3").val();
                        myDate.start = myDate.year + "-01-01";
                        myDate.end = myDate.year + "-12-31";
                        break;

                    case "diy":
                        myDate.start = $("#start").val();
                        myDate.end = $("#end").val();
                        break;
                }
                return myDate;
            },
            getAutoQuery: function () {
                return autoQuery;
            },
            //禁用选项 参数：month season year diy 多个以,隔开
            disableOption: function (os) {
                if (os) {
                    let oa = os.split(",");
                    for (let i=0; i<oa.length; i++) {
                        switch (oa[i]){
                            case "month":
                                $(".ymd-month").remove();
                                break;
                            case "season":
                                $(".ymd-season").remove();
                                break;
                            case "year":
                                $(".ymd-year").remove();
                                break;
                            case "diy":
                                $(".ymd-diy").remove();
                                break;
                        }
                    }
                    $("#ymd option:eq(0)").prop("selected", "selected");
                    changeYmd();
                }
            },
            callback: function () {
            }
        }
    })();

</script>