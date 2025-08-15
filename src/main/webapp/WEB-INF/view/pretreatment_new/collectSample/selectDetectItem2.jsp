<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
    .select2-container .select2-selection--single,.select2-selection__rendered{
        height:36px !important;
        line-height:36px !important;
    }
    .select2-container--default.select2-container--focus .select2-selection--multiple{
        border: 1px solid #468ad5;
    }
    .select2-dropdown {
        overflow: hidden;
    }
    /*
    .cs-select-search{
        position:relative;
    }
    .cs-down-box{
        position:absolute;
        top:30px;
        left:0;
        background:#fff;
        border:1px solid #468ad5;
        width:200px;
        !* height:180px; *!
        max-height:260px;
        overflow:auto;
        z-index:999;
        background:#f1f1f1;
        box-shadow:0px 2px 2px #ddd;

    }
    .cs-down-box li{
        padding:0 0 0 10px;
        line-height: 28px;
    }

    .cs-down-box li:hover,.cs-down-box li.active{
        background-color: #1e90ff;
        color: #fff;
    }*/
    .modal-header{
        background-color:#13adff;
        color: #fff;
    }
    .cancelBtn{
        border: 1px solid #5f5353;
    }
</style>
<div id="_edit_Item_modal" class="modal fade intro2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-mid-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="position: fixed;right: 20px;"><span aria-hidden="true">&times;</span></button>
                <h5 class="modal-title">选择复检项目</h5>
            </div>
            <div class="modal-body cs-mid-height cs-dis-tab">
                <input type="hidden" id="samplingDetailId" />
                <ul class="cs-ul-form clearfix">
                    <li class="cs-name col-xs-4 col-md-4" width="20% ">复检样品：</li>
                    <li class="cs-in-style cs-modal-input" width="210px">
                        <input id="foodName" type="text" style="width:200px;height:36px; " readonly  disabled>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix col-sm-12 col-md-12">
                    <li class="cs-name col-sm-4 col-md-4"><i class="cs-mred">*</i>检测项目：</li>
                    <li class="cs-in-style cs-modal-input" style="width: 200px;height:36px;">
                        <input type="hidden" name="itemId" />
                        <input type="hidden" name="itemName" />
                        <!-- 选择下拉框 -->
                        <select id="item_select2" class="js-data-example-ajax"></select>
                    </li>
                </ul>
            </div>
            <div class="modal-footer" style="justify-content: center;text-align:center; padding:10px; height: auto">
                <button type="button" id="_save_item" class="btn btn-primary btn-ok">确定</button>
                <button type="button" class="btn btn-default cancelBtn" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${webRoot}/js/jquery.cookie.js"></script>
<script type="text/javascript">

    $(function(){
        myInitSelect();
    });

    function myInitSelect(){
        $("#item_select2").select2({
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
                    return "没有搜索到结果!";
                }
            },
            width: "100%",
            ajax: {
                url: "${webRoot}/data/detectItem/select2ItemDataForOrder",
                dataType: 'json',
                delay: 250,
                data: function(params) {//发送到服务器的数据
                    //params.term 是输入框中内容。
                    //此对象的key就是发送到服务器的参数名。
                    //所以这里你可以添加自定义参数，如：page: params.page
                    params.page = params.page || 1; // 这个page会记录下来，且向下滚动翻页时会自增
                    return {
                        itemName: (!params.term ? '' : params.term), //后端取 key 它就是搜索关键字
                        page: params.page || 1, //分页：当前页码
                        row: 50	//每页数量
                    };
                },
                processResults: function(data, params) {// 后端返数据的根是 data，params就是上面的查寻参数
                        return {
                            results: data.items,
                            pagination: { //分页
                                //more: data.more // 是否还有后面页：true|false
                                more: (params.page * 50) < data.total // 后端返回总数量 total 算出还有没
                            }
                        };
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
    }

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
     * 清除选择项
     */
    function cleanItemSelected() {
        $("#item_select2").select2('val', "");
        $("#item_select2").select2('data', null);
        $("#item_select2").empty();
    }

</script>
