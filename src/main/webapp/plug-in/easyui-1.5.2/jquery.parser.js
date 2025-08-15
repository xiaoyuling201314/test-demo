/**
 * EasyUI动态渲染解析解决方案
 */
(function($){
    $.parser = {
        auto: true,
        plugins:['linkbutton','menu','menubutton','splitbutton','layout',
                 'tree','window','dialog','datagrid',
                 'combobox','combotree','numberbox','validatebox',
                 'calendar','datebox','panel','tabs','accordion'
        ],
        parse: function(context){
            if ($.parser.auto) {
            //遍历页面，查找所有的插件
                for(var i=0; i<$.parser.plugins.length; i++){
                    (function(){
                        var name = $.parser.plugins[i];
                        var r = $('.easyui-' + name, context);
                        if (r.length){
                            if (r[name]){
                                r[name]();
                            } else if (window.easyloader){//如果是通过easyloader方式加载
                                easyloader.load(name, function(){
                                    r[name]();
                                })
                            }
                        }
                    })();
                }
            }
        }
    };
    $(function(){
        $.parser.parse();
    });
})(jQuery);

//用法:
//var targetObj = $("<input name='mydate' class='easyui-datebox'>").appendTo("#id");
//$.parser.parse(targetObj);