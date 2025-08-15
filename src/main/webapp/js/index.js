/* 
 * @Author: Marte
 * @Date:   2017-07-07 10:57:41
 * @Last Modified by:   Marte
 * @Last Modified time: 2018-11-16 14:54:45
 */

$(document).ready(function () {

    $(document).on("click", ".cs-nav-style li,.cs-dropdown-menu li", function () {
        $('.cs-dropdown-menu').children('li').removeClass('cs-active');
        $(this).addClass('cs-active').siblings().removeClass('cs-active');

    });

// 接收人删除
    $(document).on('click', '.cs-x-this', function (e) {
        $(this).parents('.cs-mail-point').remove();
    });

    // 页面导航跳转
    //
    //
    //
    // $('.ui-app').click(function(){
    //     $('#iframe').attr({
    //         src: 'app/check-list.html'
    //     });
    // })


// 页面导航跳转


    // $('.cs-messages-dropdown').hover(function() {
    //     $('.cs-warn-menu').show();
    // }, function() {
    //     $('.cs-warn-menu').hide();
    // });

//点击下拉、非本元素隐藏
//


    $(".cs-user-show").click(function (e) {
        $(".cs-self-menu").toggle();
        e.stopPropagation();
    });
    // $(".cs-self-menu").click(function(e){
    //   e.stopPropagation();
    // });
    $(window).click(function () {
        $(".cs-self-menu").hide();
    });

    // $(".cs-mail").click(function(e){
    //   $('.cs-self-menu').hide();
    //    $(".cs-warn-menu").toggle();
    //     e.stopPropagation();
    // });
    $(".cs-warn-menu").click(function (e) {
        e.stopPropagation();
    });
    $(window).click(function () {
        $(".cs-warn-menu").hide();
    });


//弹窗下拉树状图

    $(document).on('click','.cs-down-arrow,#txtHandle',function (e) {
        $(this).parent('.cs-input-box').siblings('.cs-check-down').show();
        e.stopPropagation();
    });
    $(document).on('click','.cs-down-input',function (e) {
		$(this).parent('.cs-input-box').siblings('.cs-check-down').show();

	});
    $(".cs-check-down,.cs-down-input").click(function (e) {
        e.stopPropagation();
    });
    $(window).click(function (event) {
        if (!(event.target.id == "key" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            $(".cs-check-down").hide();
        }
    });

//窗口拖拽功能
    $(".cs-check-down").bg_move({
        move:'.title',
        closed:'.close',
        size : 6
    });
//点击隐藏下拉树
// $('.tree-title').click(function(){
//      $(".cs-check-down").hide();
//    });

// $(document).on("click", ".tree-title", function(){
//         $(".cs-check-down").hide();
//     });

//菜单下拉、父级的兄弟元素的子元素隐藏
    $(document).on("click", ".cs-dropdown-toggle", function () {
        $(this).siblings('ul').addClass('cs-toggle').parent('li').siblings().children('ul').removeClass('cs-toggle');
    });


    /*$('.cs-s-search').click(function (event) {
        $('.cs-search-inform').toggle();
    });*/


    $('.cs-check-del').click(function () {
        $(this).parents('li').remove();
    })

    //弹出弹出层
    $('.cs-del').click(function (event) {
        $('.cs-window-mask').show();
    });
    $('.rewrite').click(function (event) {
        $('.cs-window-mask2').show();
    });
    // 弹出层
    $('.cs-close,.cs-cencel,.cs-window-mask').click(function (event) {
        $(this).parents('.cs-window-mask').hide();
    });
    $('.cs-close,.cs-cencel,.cs-window-mask2').click(function (event) {
        $(this).parents('.cs-window-mask2').hide();
    });


    $('.cs-first-toggle').click(function () {
        $('.cs-toggle2').addClass('cs-show').removeClass('cs-hide');
    })


    $('.cs-show-selected ul li input').click(function () {
        var inPut = $('.cs-show-selected ul li input')
        if ($("input[type='checkbox']").is(':checked') == true) {
            $(this).parent('li').addClass('cs-list-active');
        } else {
            $(this).parent('li').removeClass('cs-list-active');
        }

    })

    $('.cs-show-selected ul li').click(function () {
        var inPut = $('.cs-show-selected ul li input')
        if ($("input[type='checkbox']").is(':checked') == true) {
            $(this).parent('li').addClass('cs-list-active');
        } else {
            $(this).parent('li').removeClass('cs-list-active');
        }

    })


// 检测点/机构切换

    // $('.cs-show-jigou').click(function(){
    //     $('.cs-deliver-jigou').css('display','block');
    //     $('.cs-deliver-dian').css('display','none');
    // })
    // $('.cs-show-dian').click(function(){
    //     $('.cs-deliver-dian').css('display','block');
    //     $('.cs-deliver-jigou').css('display','none');

    // })
    // 
    //添加autocomplete
    $('input[type=text]').attr('autocomplete','off');
});

// 检测点/机构切换
// 
// 
var checkBox = function () {
    if ($('.cs-piao1').prop('checked') == true ||
        $('.cs-piao2').prop('checked') == true) {
        /*$('.cs-deliver-jigou').css('display', 'block');
        $('.cs-deliver-dian').css('display', 'none');*/
    } else {
        /*$('.cs-deliver-dian').css('display', 'block');
        $('.cs-deliver-jigou').css('display', 'none');*/
    }
}

jQuery(document).ready(function ($) {
    checkBox();
});
$(document).on("click", '.cs-piao1,.cs-piao2,.cs-piao-no', function () {
    checkBox();
});


/*var checkBox1 = function () {
    if ($('.cs-show-jigou').prop('checked') == true) {
        $('.cs-deliver-jigou').css('display', 'block');
        $('.cs-deliver-dian').css('display', 'none');
    } else {
        $('.cs-deliver-dian').css('display', 'block');
        $('.cs-deliver-jigou').css('display', 'none');
    }
}*/


/*jQuery(document).ready(function ($) {
    checkBox1();
});*/

/*$('#myModal-mid').on('show.bs.modal',function(e){

 checkBox1();

 });*/


$(document).on("click", '.cs-show-jigou,.cs-show-dian', function () {
    checkBox1();
});


$(document).ready(function () {
    function resize() {
        $(".cs-list thead th").each(function (index) {
            var width = $(this).width();
            $(".cs-list .cs-outer td:nth-child(" + index + ")").css("width", width);
            $(".cs-list .cs-leaf td:nth-child(" + index + ")").css("width", width);
        });
    }

    resize();
    $(window).resize(resize());

    $(".cs-switch").click(function () {
        if ($(this).parents(".cs-outer").is(".cs-open")) {
            $(this).parents(".cs-outer").removeClass("cs-open").next(".cs-inner").removeClass("cs-open");
        } else {
            $(this).parents(".cs-outer").addClass("cs-open").next(".cs-inner").addClass("cs-open");
        }
    });

    $("tr.cs-outer, tr.cs-leaf").click(function () {
        $("tr.cs-focus").removeClass("cs-focus");
        $(this).addClass("cs-focus");
    });
});


// tab栏

$(document).ready(function () {
    $(".cs-tab li").click(function () {
        $(".cs-tab li").eq($(this).index()).addClass("cs-cur").siblings().removeClass('cs-cur');
        $(".cs-tab-box").hide().eq($(this).index()).show();
    });
});
$(document).ready(function () {
    $(".cs-tab2 li").click(function () {
        $(".cs-tab2 li").eq($(this).index()).addClass("btn btn-success").siblings().removeClass('btn btn-success');
        $(".cs-tab-box").hide().eq($(this).index()).show();
    });
});

$(document).ready(function () {
    $(".cs-tab2 li").click(function () {
        $(".cs-tab2 li").eq($(this).index()).addClass("active").siblings().removeClass('active');
        $(".cs-tab-box2 .tab-pane").hide().eq($(this).index()).show();
    });
});

// 弹窗检测点tab
$(document).ready(function () {
    $(".cs-mechanism-tab li").click(function () {
        $(".cs-mechanism-tab li").eq($(this).index()).addClass("cs-active-selected").siblings().removeClass('cs-active-selected');
    });
});


// 处理方式下拉
$(document).ready(function () {
    // $(document).on('mouseover','.cs-all-ps',function(e){
    //    $('.cs-check-down2,.cs-check-down').show();
    //  });
    // $(document).on('mouseout','.cs-all-ps',function(e){
    //    $('.cs-check-down2,.cs-check-down').hide();
    //  });
    // $("#txtHandle").onfocus(function(){
    //  $(".cs-check-down").show()

    // })
    $('.cs-checkCk').click(function () {
        var node = $(this).siblings('div');
        if (node.is(':hidden')) {
            node.show();
        } else {
            node.hide();
            $(this).siblings('div').children('input').attr("value", "");
        }
    })
    $(".cs-checkCk").change(function () {
        var result = "";
        $(this + ":checked").each(function () {
            result += $(this).val() + ',';
        });
        $("#txtHandle").val(result);
    });

})


//弹窗
var editBtn = function (editbtn, name, url) {
    $(document).on('click', editbtn, function (event) {
        $.dialog({
            maxBtn: false,
            top: '20%',
            title: name,
            width: 700,
            height: 400,
            content: 'url:alert/' + url,
            ok: function () {
                return false;
            },
            cancelVal: '关闭',
            cancel: true
        });
    });
};

// 人员管理


// 修改
editBtn('#editBtn', '修改', 'add-menber-re.html');

//新增
editBtn('#addBtn', '新增', 'add-member.html');


//  // 配置lhgdialog全局默认参数(可选)
// var model=(function(config){ 
//   config['drag'] = true;
//     config['extendDrag'] = true; // 注意，此配置参数只能在这里使用全局配置，在调用窗口的传参数使用无效 
//     config['lock'] = true;
//     config['fixed'] = true; 
//     config['okVal'] = "确认"; 
//     config['cancelVal'] = "取消"; 
//     config['min'] = false; 
//     config['max'] = false; 
//     config['esc'] = false; 
//     config['resize'] = false; 
//     // [more..] 
// })($.dialog.setting);


//tab栏
//
$(document).ready(function () {
    $('.cs-tabtitle li').click(function () {
        var index = $(this).index();
        $(this).attr('class', "cs-tabhover").siblings('li').attr('class', 'cs-taba');
        $('.cs-tabcontent').eq(index).show(200).siblings('.cs-tabcontent').hide();
    });

})


// $('body').bind('mouseover', function(event) {
//     // IE支持 event.srcElement ， FF支持 event.target    
//     var evt = event.srcElement ? event.srcElement : event.target;    
//     if(evt.id == 'divBtn' ) return; // 如果是元素本身，则返回
//     else {
//         $('.cs-check-down').hide(); // 如不是则隐藏元素
//     }   
// });


/* center modal */
function centerModals() {
    $('.intro2').each(function (i) {
        var $clone = $(this).clone().css('display', 'block').appendTo('body');
        var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2.4);
        top = top > 0 ? top : 0;
        $clone.remove();
        $(this).find('.modal-content').css("margin-top", top);
    });
}
$('.intro2').on('show.bs.modal', centerModals);
$(window).on('resize', centerModals);


/*下拉搜索窗控制 */
// $(function(){
//   $(".dropdown-toggle").click(function(e){
//        $(".dropdown-menu").toggle();
//         e.stopPropagation();
//     });
//    $(".dropdown-menu").click(function(e){
//      e.stopPropagation();
//    });
//    $(window).click(function(){
//      $(".dropdown-menu").hide();
//    });

//    $('.filter-item').click(function(){
//     $('.dropdown-menu').css('display','none');
//   })

// })


// $(document).on("click", ".easyui-tree li", function(){
//     $('.cs-check-down').css('display','none');
//  });


// 下拉选择传值
// 
$(".easyui-tree ul li").click(function () {
    var result = "";
    $(this).text(function () {
        result = $(this).text();
        alert(result)
    });
    $("#txtHand").val(result);
});


//有异议/无异议切换
$('.cs-nore').click(function (event) {
    $('.cs-con-one').show();
    $('.cs-con-two').hide();
});
$('.cs-you').click(function (event) {
    $('.cs-con-two').show();
    $('.cs-con-one').hide();
});


// 权限管理
// 


// 检测点选择

$('.cs-wid').click(function () {
    $(this).siblings('input')
})


// 树状图点击文字展开
// $(function () {
//     $('.easyui-tree').tree({
//         onSelect: function (node) {
//             if (node.state == "closed")
//                 $(this).tree('expand', node.target);
//             else
//                 $(this).tree('collapse', node.target);
//         }
//     });
// });


var currentShowDate = 0;
$(document).on('change', '#province', function (e) {
    $("#province option").each(function (i, o) {
        if ($(this).val() == $("#province").val()) {
            $(".check-date").hide().find('select').attr('disabled', 'disabled');
            $(".check-date").eq(i + 1).show().find('select').removeAttr('disabled');
            currentShowDate = i;
        }
    });
});

/*
$(document).on('change', '#year2', function (e) {
    $("#year2 option").each(function (i, o) {
        if ($(this).val() == $("#year2").val()) {
            $(".check-date").hide().find('select').attr('disabled', 'disabled');
            $(".check-date").eq(i + 1).show().find('select').removeAttr('disabled');
            currentShowCity = i;
        }
    });
});
*/

// 鼠标经过显示
var mouseOver = function (source2, showBlock) {
    $(source2).hover(function () {
        $(showBlock).show();
    }, function () {
        $(showBlock).hide();
    });
}
mouseOver('.cs-erwei,.cs-erwei-box', '.cs-erwei-box');


$(document).on('click', '.cs-text-normal', function () {
    $(this).removeClass('cs-tab-text');
    $('.cs-text-control').show()
})
$(document).on('click', '.cs-text-control', function () {
    $('.cs-text-normal').addClass('cs-tab-text');
    $('.cs-text-control').hide()
})


//显示隐藏
$('.cs-display-block').click(function () {
    $('.cs-height-box').css('height', 'auto')
    $(this).hide();
});

//图片查看关闭
$(document).on('click', '#imgbox-overlay', function () {
    $('#imgbox-overlay,#imgbox-loading').hide();
});

//modal窗口恢复默认
$(document).on('show.bs.modal', '.modal', function (e) {
    $(this).css({
        left: '0px',
        top: '0px',
    });
});
/*$(document).on('shown.bs.modal','.modal', function (e) {
 $(this).css('display', 'block');
 var thisCh= ($(this).children('.modal-dialog').height())/2;
 $(this).children('.modal-dialog').css({
 top: '50%',
 marginTop: -thisCh
 });
 });*/
$(document).on("show.bs.modal", ".modal", function () {
    $(this).draggable({
        handle: ".modal-header"
        // 只能点击头部拖动
    });
    $(this).css("overflow", "initial");
});






