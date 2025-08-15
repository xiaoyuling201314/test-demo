
/**
 * 日期转换兼容ios中safari
 * 使用：
 * var d = newDate('2014/5/22');
 * var d = newDate('2014-9-10 12:20:34');
 */
var newDate = function (o) {
	if(o && o.length>0){
		return new Date(o.replace(/-/g, "/"));
	}else{
		return new Date();
	}
};

/** 
 * 对Date的扩展，将 Date 转化为指定格式的String 
 * 月(M)、日(d)、12小时(h)、24小时(H)、分(m)、秒(s)、周(E)、季度(q) 可以用 1-2 个占位符 
 * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
 * eg: 
 * (new Date()).format("yyyy-MM-dd hh:mm:ss.S")==> 2006-07-02 08:09:04.423
 * (new Date()).format("yyyy-MM-dd E HH:mm:ss") ==> 2009-03-10 二 20:09:04
 * (new Date()).format("yyyy-MM-dd EE hh:mm:ss") ==> 2009-03-10 周二 08:09:04
 * (new Date()).format("yyyy-MM-dd EEE hh:mm:ss") ==> 2009-03-10 星期二 08:09:04
 * (new Date()).format("yyyy-M-d h:m:s.S") ==> 2006-7-2 8:9:4.18
 */
Date.prototype.format = function(fmt) {
	if(!fmt){
		//默认时间格式
		fmt = "yyyy-MM-dd HH:mm:ss";
	}
    var o = { 
        "M+" : this.getMonth()+1,                 //月份 
        "d+" : this.getDate(),                    //日 
        "H+" : this.getHours(),                   //小时 
        "m+" : this.getMinutes(),                 //分 
        "s+" : this.getSeconds(),                 //秒 
        "q+" : Math.floor((this.getMonth()+3)/3), //季度 
        "S"  : this.getMilliseconds()             //毫秒 
    };
    var week = {
    	"0" : "/u65e5",
    	"1" : "/u4e00",
    	"2" : "/u4e8c",
    	"3" : "/u4e09",
    	"4" : "/u56db",
    	"5" : "/u4e94",
    	"6" : "/u516d"
    };
    if(/(y+)/.test(fmt)){
    	fmt = fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    }
    if(/(E+)/.test(fmt)){
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);
    }
    for(var k in o) {
        if(new RegExp("("+ k +")").test(fmt)){
        	fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        }
    }
    return fmt; 
}

/**
 * 判断闰年
 * @returns true 闰年
 */
Date.prototype.isLeapYear = function()
{
    return (0==this.getYear()%4&&((this.getYear()%100!=0)||(this.getYear()%400==0)));
}

/**
 * 计算时间
 * @param strInterval
 * @param Number
 * @returns {Date}
 * @constructor
 */
Date.prototype.DateAdd = function(strInterval, Number) {
    var dtTmp = this;
    switch (strInterval) {
        case 's' :return new Date(Date.parse(dtTmp) + (1000 * Number));
        case 'n' :return new Date(Date.parse(dtTmp) + (60000 * Number));
        case 'h' :return new Date(Date.parse(dtTmp) + (3600000 * Number));
        case 'd' :return new Date(Date.parse(dtTmp) + (86400000 * Number));
        case 'w' :return new Date(Date.parse(dtTmp) + ((86400000 * 7) * Number));
        case 'q' :return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number*3, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
        case 'm' :return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
        case 'y' :return new Date((dtTmp.getFullYear() + Number), dtTmp.getMonth(), dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
    }
}

/**
 * 当前月第一天
 * @returns {string}
 */
Date.prototype.getFirstDay = function(){
    var y = this.getFullYear(); //获取年份
    var m = this.getMonth() + 1; //获取月份
    var d = '01';
    m = m < 10 ? '0' + m : m; //月份补 0

    return [y,m,d].join("-");
}
/**
 * 当前月最后一天
 * @returns {string}
 */
Date.prototype.getLastDay = function(){
    var y = this.getFullYear(); //获取年份
    var m = this.getMonth() + 1; //获取月份
    var d = new Date(y, m, 0).getDate(); //获取当月最后一日
    m = m < 10 ? '0' + m : m; //月份补 0
    d = d < 10 ? '0' + d : d; //日数补 0

    return [y,m,d].join("-")
}



/**
 * 计算时间跨度
 * @param start 开始时间
 * @param end 结束时间
 * @param type y:年 M:月 d:日
 */
Date.prototype.Timespan = function(start, end, type) {
    //时间跨度
    var timeSpan = 0;
    if (start && end && type) {
        switch (type) {
            case "y":
                if (start.getFullYear() == end.getFullYear()) {
                    timeSpan = 1;

                } else {
                    timeSpan += Math.abs(end.getFullYear() - start.getFullYear());
                    start.setFullYear(end.getFullYear());
                    timeSpan += ( (start.getTime() > end.getTime() ) ? 0 : 1);
                }
                break;

            case "M":
                if (start.getFullYear() == end.getFullYear()) {
                    timeSpan += (Math.abs(end.getFullYear() - start.getFullYear())+1) * 12;
                    timeSpan = timeSpan - start.getMonth() - (11 - end.getMonth());

                } else {
                    timeSpan += (Math.abs(end.getFullYear() - start.getFullYear())+1) * 12;
                    timeSpan = timeSpan - start.getMonth() - (11 - end.getMonth());
                    if (start.getMonth() == end.getMonth()){
                        if (start.getDate() > end.getDate()) {
                            timeSpan -= 1;
                        } else if (start.getDate() == end.getDate()){
                            if (start.getHours() > end.getHours()) {
                                timeSpan -= 1;
                            } else if (start.getHours() == end.getHours()){
                                if (start.getMinutes() > end.getMinutes()) {
                                    timeSpan -= 1;
                                } else if (start.getMinutes() == end.getMinutes()){
                                    if (start.getSeconds() > end.getSeconds()) {
                                        timeSpan -= 1;
                                    }
                                }
                            }
                        }
                    }
                }
                break;

            case "d":
                if (Math.abs((start.getTime() - end.getTime())) < 86400000) {
                    if (start.getDate() == end.getDate()) {
                        timeSpan = 1;
                    } else {
                        timeSpan = 2;
                    }
                } else {
                    timeSpan = Math.ceil(Math.abs((start.getTime() - end.getTime())) / 86400000);
                }
                break;
        }
    }
    return timeSpan;
}

/**
 * 判断日期跨度是否大于6个月
 * @param begintime
 * @param endtime
 */
function checkTimeSixMonths(begintime, endtime) {
    var time1 = new Date(begintime).getTime();
    var time2 = new Date(endtime).getTime();
    if(begintime==''){
        // alert("开始时间不能为空");
        // return false;
        return {"status":false,"msg":"开始时间不能为空"};
    }
    if(endtime==''){
        // alert("结束时间不能为空");
        // return false;
        return {"status":false,"msg":"结束时间不能为空"};
    }
    if(time1 > time2){
        // alert("开始时间不能大于结束时间");
        // return false;
        return {"status":false,"msg":"开始时间不能大于结束时间"};
    }

    //判断时间跨度是否大于6个月
    var arr1 = begintime.split('-');
    var arr2 = endtime.split('-');
    arr1[1] = parseInt(arr1[1]);
    arr1[2] = parseInt(arr1[2]);
    arr2[1] = parseInt(arr2[1]);
    arr2[2] = parseInt(arr2[2]);
    var flag = true;
    if(arr1[0] == arr2[0]){//同年
        if(arr2[1]-arr1[1] > 6){ //月间隔超过6个月
            flag = false;
        }else if(arr2[1]-arr1[1] == 6){ //月相隔6个月，比较日
            if(arr2[2] >= arr1[2]){ //结束日期的日大于等于开始日期的日
                flag = false;
            }
        }
    }else{ //不同年
        if(arr2[0] - arr1[0] > 1){
            flag = false;
        }else if(arr2[0] - arr1[0] == 1){
            if(arr1[1] <= 6){ //开始年的月份小于等于6时，不需要跨年
                flag = false;
            }else if(arr1[1]+6-arr2[1] < 12){ //月相隔大于6个月
                flag = false;
            }else if(arr1[1]+6-arr2[1] == 12){ //月相隔6个月，比较日
                if(arr2[2] >= arr1[2]){ //结束日期的日大于等于开始日期的日
                    flag = false;
                }
            }
        }
    }
    if(!flag){
        // alert("时间跨度不得超过6个月！");
        // return false;
        return {"status":false,"msg":"时间跨度不得超过6个月！"};
    }

    // return true;
    return {"status":true,"msg":""};
}
//计算两个时间相差的分钟数
function DateDifference(faultDate,completeTime){
    var stime =new Date(faultDate).getTime();
    var etime = new Date(completeTime).getTime();
    var usedTime = etime - stime;  //两个时间戳相差的毫秒数
    var days=Math.floor(usedTime/(24*3600*1000));
    //计算出小时数
    var leave1=usedTime%(24*3600*1000);    //计算天数后剩余的毫秒数
    var hours=Math.floor(leave1/(3600*1000));
    //计算相差分钟数
    var leave2=leave1%(3600*1000);        //计算小时数后剩余的毫秒数
    var minutes=Math.floor(leave2/(60*1000));
    // var time = days + "天"+hours+"时"+minutes+"分";
    return minutes;
}