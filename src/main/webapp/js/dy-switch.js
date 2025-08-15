/**
 * 二维码页面权限控制
 */
DySwitch = (function () {
    var nonTraceableURL = ["http://fst.chinafst.cn:9002/dykjfw/", "http://fst.chinafst.cn:9003/anshan/"];	//不支持溯源URL
    var shopCode = {"http://fst.chinafst.cn:9003/anshan/":"档口/车号"};	//自定义档口编号
    return {
    	traceability: function () {	//扫描抽样单、监管对象、经营户二维码进入的页面溯源权限控制
        	for(var i=0;i<nonTraceableURL.length;i++){
        		if(window.document.location.href.indexOf(nonTraceableURL[i]) != -1){
        			return false;	//不支持溯源
        		}
        	}
        	return true;	//支持溯源
        },
        getShopCode: function () {	//自定义档口编号
        	if(shopCode[window.document.location.origin + '/' + window.document.location.pathname.split('/')[1] + '/']){
        		return shopCode[window.document.location.origin + '/' + window.document.location.pathname.split('/')[1] + '/'];	
        	}else{
        		if("${systemFlag==1}"){
					return "摊位编号";
				}else{
					return "档口编号";
				}

        	}
        }
    }
})();