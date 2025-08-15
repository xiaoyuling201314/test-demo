<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择被检单位 - 下拉框 -->
<select id="reg_select2" class="js-data-example-ajax"></select>
<script type="text/javascript" src="${webRoot}/js/jquery.cookie.js"></script>
<script type="text/javascript">
	$("#reg_select2").select2({
		placeholder: '--请选择--',
		language: {
			errorLoading: function() {
				return "无法载入结果";
			},
			inputTooLong: function(e) {
				var t = e.input.length - e.maximum,
						n = "请删除" + t + "个字符";
				return n;
			},
			inputTooShort: function(e) {
				var t = e.minimum - e.input.length,
						n = "请输入至少" + t + "个字符";
				return n;
			},
			loadingMore: function() {
				return "载入更多结果…";
			},
			maximumSelected: function(e) {
				var t = "最多只能选择" + e.maximum + "个项目";
				return t;
			},
			searching: function() {
				return "搜索中...";
			},
			noResults: function() {
				return "没有历史记录或没有搜索到结果!";
			}
		},
		width: "100%",
		ajax: {
			url: "${webRoot}/regulatory/regulatoryObject/select2RegData",
			dataType: 'json',
			delay: 250,
			data: function(params) {//发送到服务器的数据
				//params.term 是输入框中内容。
				//此对象的key就是发送到服务器的参数名。
				//所以这里你可以添加自定义参数，如：page: params.page
				params.page = params.page || 1; // 这个page会记录下来，且向下滚动翻页时会自增
				return {
                    regName: (!params.term ? '本地历史数据' : params.term), //后端取 key 它就是搜索关键字
					page: params.page || 1, //分页：当前页码
					row: 50	//每页数量
				};
			},
			processResults: function(data, params) {// 后端返数据的根是 data，params就是上面的查寻参数
                //查询历史数据
                if (!params.term) {
                    if ($.cookie("REG_SEL")) {
                        return {
                            results: JSON.parse($.cookie("REG_SEL")),
                            pagination: { //分页
                                //more: data.more // 是否还有后面页：true|false
                                more: false // 后端返回总数量 total 算出还有没
                            }
                        };
                    } else {
                        return {
                            results: [],
                            pagination: { //分页
                                //more: data.more // 是否还有后面页：true|false
                                more: false // 后端返回总数量 total 算出还有没
                            }
                        };
                    }

                //查询结果
                } else {

                    //甘肃平台数据录入功能禁止直接输入被检单位名称  --Dz 20220629
                    if(data.regs && data.regs.length == 1 && data.regs[0].name.indexOf("[录]") != -1) {
                    	data.regs = [];
                    	data.total = 0;
                    }

                    return {
                        results: data.regs,
                        pagination: { //分页
                            //more: data.more // 是否还有后面页：true|false
                            more: (params.page * 50) < data.total // 后端返回总数量 total 算出还有没
                        }
                    };
                }
			},
			cache: true
		},
		minimumInputLength: 0,// 输入几个字时开始搜索
		templateResult: formatRepo,// 定制搜索结果列表的外面
		// templateResult 返回的数据要从 escapeMarkup 过，默认会被转成text，要想返回html如下覆写
		escapeMarkup: function(markup) {
			return markup;
		},
		templateSelection: formatRepoSelection // 定制所选结果的外观
	});

	/**
	 * 搜索结果返回，列表中每个结果都调用此方法。repo 参数对应后端的一个 jsonObject。
	 * 此函数可以返回一个html元素字符串，或者一个对象(例如jQuery对象)，其中包含要显示的数据。
	 * 还可以返回null，这将阻止在结果列表中显示该选项(可以实现过滤某些值)
	 */
	function formatRepo(repo) {
		if (repo.loading) return repo.text;//如果loading中，直接返回提示信息
		var markup = "<div class='select2-result-repository clearfix'>" +
			"<div class='select2-result-repository__title'>" + repo.name + "</div>" +
			"</div>";
		return markup;
	}
	/**
	 * 将选择数据对象转换为字符串表示或jQuery对象（可以显示带图片的结果那种）
	 */
	function formatRepoSelection(repo) {
		return repo.name?repo.name:repo.text;//如果没有name返回提示信息
	}

    /**
     * 获取已选数据数组
     */
	function getRegSelect2Data() {
        var selData = $('#reg_select2').select2('data');
        // //录入数据不保存到历史
        // if (selData[0].id > 0) {
            var REG_SEL;
            if (!$.cookie("REG_SEL")) {
                REG_SEL = [];
                REG_SEL.push({"id": selData[0].id, "name": selData[0].name, "number": 1});
            } else {
                REG_SEL = JSON.parse($.cookie("REG_SEL"));
                for (var i=0; i<REG_SEL.length; i++) {
                    if (REG_SEL[i].id == selData[0].id) {
                        REG_SEL[i].number = REG_SEL[i].number + 1;
                        break;
                    } else if (i == REG_SEL.length-1) {
                        REG_SEL.push({"id": selData[0].id, "name": selData[0].name, "number": 1});
                        break;
                    }
                }
            }
            REG_SEL.sort(function (a, b) {
                if (a.number < b.number) {
                    return 1;
                } else {
                    return -1;
                }

            });
            $.cookie("REG_SEL", JSON.stringify(REG_SEL));
        // }

        return $('#reg_select2').select2('data');
    }

    /**
     * 清除选择项
     */
    function cleanRegSelected() {
        // $("#reg_select2").val(null).trigger("change");

        $("#reg_select2").select2('val', "");
        $("#reg_select2").select2('data', null);
        $("#reg_select2").empty();
    }
</script>
