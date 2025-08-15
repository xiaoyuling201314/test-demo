$('.selectData').datepicker({
    autoclose: true, //自动关闭
    beforeShowDay: $.noop,    //在显示日期之前调用的函数
    calendarWeeks: false,     //是否显示今年是第几周
    clearBtn: false,          //显示清除按钮
    daysOfWeekDisabled: [],   //星期几不可选
    endDate: Infinity,        //日历结束日期
    forceParse: true,         //是否强制转换不符合格式的字符串
    format: 'yyyy-mm-dd',     //日期格式
    keyboardNavigation: true, //是否显示箭头导航
    //language: 'cn',           //语言,插件已经默认为中文
    minViewMode: 0,
    orientation: "auto",      //方向
    rtl: false,
    startDate: -Infinity,     //日历开始日期
    startView: 0,             //开始显示
    todayBtn: 'linked',       //今天按钮 'linked'
    todayHighlight: true,     //今天高亮
    weekStart: 0             //星期几是开始
}).on('changeDate', function (e) {
    changeTime('');
});
$(".selectData").datepicker("disable").attr("readonly", "readonly");//设置为只读模式


//时间段查询的js,控制时间范围
//开始时间：
$('#qBeginTime').datepicker({
    autoclose: true,
    todayHighlight: false,
    todayBtn: false,       //今天按钮 'linked'
    endDate: new Date()
}).on('changeDate', function (e) {//改变事件
    var startTime = e.date;
    $('#qEndTime').datepicker('setStartDate', startTime);//设置时间
});
//结束时间：
$('#qEndTime').datepicker({
    autoclose: true,
    todayBtn: false,       //今天按钮 'linked'
    todayHighlight: false
    //endDate: new Date()
}).on('changeDate', function (e) {
    var endTime = e.date;
    $('#qBeginTime').datepicker('setEndDate', endTime);
});
//设置为只读模式
$("#qBeginTime").datepicker("disable").attr("readonly", "readonly");
$("#qEndTime").datepicker("disable").attr("readonly", "readonly");
/*.on('hide', function(event) {//关闭日期界面执行该方法
 console.log(event.timeStamp)
 //event.preventDefault();
 //event.stopPropagation();
 });*/
