// pazu 技术文档：https://www.4fang.net/bbs/note_48314.jsp
//检查PAZU云打印组件是否成功加载到你的应用页面
if (!window.PAZU_Config) {
	window.PAZU_Config = {
		prot : "http",
		server : 'localhost',
		port : 6894,
		license : 'EC260628EE3ECA09935907A262A2DAA6|肖裕玲' // PAZU授权许可码，非商业应用或者测试可以免费申请
	}
}
//打印参数设置
function doPagesetup() {
	PAZU.TPrinter.orientation = 1; // 属性纸张方向 数据类型：整数1或者2 ， 1=纵向 2=横向
	PAZU.TPrinter.paperName = "A5"; // 属性 纸张大小名称 数据类型：字符串
	PAZU.TPrinter.marginTop=8;//属性 上边距
	PAZU.TPrinter.marginBottom=1;//下边距
	PAZU.TPrinter.printerName = "HP LaserJet Pro M402-M403 PCL 6"; // 属性 打印机名称
	PAZU.TPrinter.isZoomOutToFit = true; //属性   是否缩放以适应大小打印 数据类型：Boolean true / false
	PAZU.TPrinter.isPrintBackground=true;//属性 是否打印背景 true / false   
	PAZU.TPrinter.copies = parseInt(1); // 属性 打印份数 数据类型：整数，默认为1
}
//检查打印控件是否加载
function chkPAZU() {
	if (!window.PAZU) {
		$("#div_PAZU_Tips").removeClass("cs-hide");
		// 也可以你自己在页面里面构建一个链接提示用户下载
		return false;
	}
	$("#div_PAZU_Tips").addClass("cs-hide");
	return true;
}
