//34个省、市、自治区的名字拼音映射数组
var provinces = {
	// 23个省
	"台湾" : "taiwan",
	"河北" : "hebei",
	"山西" : "shanxi",
	"辽宁" : "liaoning",
	"吉林" : "jilin",
	"黑龙江" : "heilongjiang",
	"江苏" : "jiangsu",
	"浙江" : "zhejiang",
	"安徽" : "anhui",
	"福建" : "fujian",
	"江西" : "jiangxi",
	"山东" : "shandong",
	"河南" : "henan",
	"湖北" : "hubei",
	"湖南" : "hunan",
	"广东" : "guangdong",
	"海南" : "hainan",
	"四川" : "sichuan",
	"贵州" : "guizhou",
	"云南" : "yunnan",
	"陕西" : "shanxi1",
	"甘肃" : "gansu",
	"青海" : "qinghai",
	// 5个自治区
	"新疆" : "xinjiang",
	"广西" : "guangxi",
	"内蒙古" : "neimenggu",
	"宁夏" : "ningxia",
	"西藏" : "xizang",
	// 4个直辖市
	"北京" : "beijing",
	"天津" : "tianjin",
	"上海" : "shanghai",
	"重庆" : "chongqing",
	// 2个特别行政区
	"香港" : "xianggang",
	"澳门" : "aomen"
};
var counties = {
	"长安区" : "changan"
};
//直辖市和特别行政区-只有二级地图，没有三级地图
var special = [ "北京", "天津", "上海", "重庆", "香港", "澳门" ];
var mapdata = [];

//初始化绘制全国地图配置
var option = {
	backgroundColor : '#eee',
	title : {
		//text : '',
		subtext:'',
		left : 'center',
		/* textStyle : {
			color : '#000',
			fontSize : 16,
			fontWeight : 'normal',
			fontFamily : "Microsoft YaHei"
		}, */
		subtextStyle : {
			color : '#000',
			fontSize : 16,
			fontWeight : 'bold',
			fontFamily : "Microsoft YaHei"
		}
	},
	tooltip: {
		trigger: 'item',
		formatter: function(params){
			var str = params.name + '<br/>抽样数量：' + params.data.count+ '<br/>';
			str += '不合格数量：' + params.data.unqual+ '<br/>';
			if(params.data.count == 0){
				str += '不合格率：-';
			}else{
				str += '不合格率：' + params.data.value+'%';
			}
			return str;
		}
	},
	visualMap: {
		pieces: [
		],
		inRange: {
			color:['green','yellow','#FF3030']//蓝红
		}
	},
	toolbox : {
		show : true,
		orient : 'vertical',
		left : 'left',
		top : 'center',
		feature : {
			restore: {},
			saveAsImage : {}
		},
		iconStyle : {
			normal : {
				color : '#fff'
			}
		}
	}, 
	animationDuration : 1000,
	animationEasing : 'cubicOut',
	animationDurationUpdate : 1000
};
function renderMap(map,mapName, data) {
	//option.title.text = mapName;
	option.title.subtext = "【"+ mapName+"】检测分布情况";
	option.series = [ {
		name : map,
		type : 'map',
		//top:'260px',
		//bottom:'50%',
		mapType : map,
		zoom: 1,//这里是关键，一定要放在 series中
		//roam : true,
		nameMap : {
			'china' : '中国'
		},
		label : {
			normal : {
				show : true,
				textStyle : {
					color : 'black',
					fontSize : 13
				}
			},
			emphasis : {
				show : true,
				textStyle : {
					color : '#000',
					fontSize : 13
				}
			}
		},
		// 文本位置修正
		textFixed: {
			Alaska: [20, -20]
		},
		itemStyle:{
			normal:{label:{show:true}},
			emphasis:{
				label:{show:true},
				areaColor:'#0586CD'
			}
		},
		data : data
	} ];
	//渲染地图
	chart.setOption(option);
}