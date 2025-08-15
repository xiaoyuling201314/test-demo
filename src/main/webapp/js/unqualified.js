/**
 * 不合格处理公共方法
 */
//查看复检记录
$(document).on("click", ".reloadCount", function () {
    let id = $(this).parents(".rowTr").attr("data-rowid");
    let sampleCode = $(this).parents(".rowTr").find(".sampleCode").html();
    let returnURL = encodeURI(rootPath+"/dataCheck/unqualified/history?id=" + id + "&sampleCode=" + sampleCode);
    showMbIframe(returnURL);
});
//查看检测详情
$(document).on("click", ".check_reding_id", function () {
    let id = $(this).parents(".rowTr").attr("data-rowid");
    //增加source参数，从不合格处理相关页面进入检测详情页面时，隐藏甘肃项目数据有效性判断相关功能按钮。
    showMbIframe(rootPath+"/dataCheck/recording/checkDetail.do?id=" + id+"&source=unqualified");
});