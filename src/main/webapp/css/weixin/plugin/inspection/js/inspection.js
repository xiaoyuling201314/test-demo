//获取前三个月份的时间的方法
function get3MonthBefor() {
    var resultDate, year, month, date, hms;
    var currDate = new Date();
    year = currDate.getFullYear();
    month = currDate.getMonth() + 1;
    date = currDate.getDate();
    hms = currDate.getHours() + ':' + currDate.getMinutes() + ':' + (currDate.getSeconds() < 10 ? '0' + currDate.getSeconds() : currDate.getSeconds());
    switch (month) {
        case 1:
        case 2:
        case 3:
            month += 9;
            year--;
            break;
        default:
            month -= 3;
            break;
    }
    month = (month < 10) ? ('0' + month) : month;
    //resultDate = year + '-'+month+'-'+date+' ' + hms;
    resultDate = year + '-' + month + '-01';
    return resultDate;
}

//近三个月的选中和隐藏
/*$(".ui-data-ul li").click(function () {
    $(this).addClass('ui-data-on').siblings().removeClass('ui-data-on');
    $('.ui-select-name').html(($(this).html()));
});

$("#over-btn").click(function (e) {
    $("#over-btn2").toggle();
    e.stopPropagation();
});

$(window).click(function () {
    $("#over-btn2").hide();
});*/

$('html').on('click','#over-btn',function(){
    $("#over-btn2").toggle();
    e.stopPropagation();
})
$('html').click(function(){
    $("#over-btn2").hide();
});

$('html').on('click', '.ui-data-ul li', function(event) {
    $(this).addClass('ui-data-on').siblings().removeClass('ui-data-on');
    $('.ui-select-name').html(($(this).html()));
});

//二维码的隐藏和展示
/*
 $(function () {
 $('.ui-back').click(function (event) {
 $('.ui-back').hide()
 });
 });
 function djcode(obj) {
 var src = "${webRoot}" + $(obj).data("src");
 $("#imgcode").attr("src", src);
 $('.ui-back').show()
 }*/


//经纬度转换成三角函数中度分表形式。
/*function rad(d) {
 return d * Math.PI / 180.0;
 }
 //计算两地之间距离
 function geoDistance(lat1, lng1, lat2, lng2) {
 var radLat1 = rad(lat1);
 var radLat2 = rad(lat2);
 var a = radLat1 - radLat2;
 var b = rad(lng1) - rad(lng2);
 var s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)));
 s = s * 6378.137;// EARTH_RADIUS;
 s = Math.round(s * 10000) / 10000; //输出为公里
 return s;
 }*/
//alert(geoDistance(22.9934070463,113.2768617555,23.1011312277,113.3053731105));//测试广州南站到中山大学