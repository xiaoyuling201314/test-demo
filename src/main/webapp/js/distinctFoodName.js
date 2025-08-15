//数据统计中：问题样品去重
function removeRepeatStr(str) {
    var foodArray = str.split(',');
    if(Array.from){
        return Array.from(new Set(foodArray));
    }else{
        return [].slice.call(new Uint8Array(foodArray));
    }
}
