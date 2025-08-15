<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PDF预览</title>
</head>
<body style="text-align:center">
<div id="example"></div>
<input id="filePath" type="hidden" value="${file}">
<input id="fileName" type="hidden" value="${fileName}">
<input id="zoom" type="hidden" value="${zoom}">
<script>
    /**
     *
     * encodeURIComponent() 函数可把字符串作为 URI 组件进行编码
     *
     * @type {string}
     */
    var pdfUrl = "${webRoot}/plug-in/pdf/web/viewer.html?file=";        //pdf预览的路径，file:需要预览文件的路径（为了兼容ie并支持跨域此处使用流的方式，也可直接写路径）
    var localUrl = "${webRoot}/pdf/pdfStreamLocal?filePath=";           //预览当前项目访问路径，filePath:传递文件不完整路径 如：files/xxoo/bb.pdf
    var crossDomainUrl = "${webRoot}/pdf/pdfStreamCrossDomain?url=";    //预览跨域文件访问路径，url:传递文件完整路径 如：https://199.666.166.54:8888/xxoo/resources/files/resoult/bb.pdf
    var filepath = $("#filePath").val();//获取传递过来的文件路径
    var fileName = $("#fileName").val();
    var zoom = $("#zoom").val();
    if (filepath) {//如果文件路径不为空
        var lowerCase = filepath.toLowerCase();//拿到该路径的文件的小写后缀名
        if (lowerCase.lastIndexOf(".pdf") >= 0) {
            if (filepath.indexOf("http") >= 0) {//跨域
                filepath=filepath.replace("[","%5B").replace("]","%5D"); //转义特殊字符[]
                window.location.href = pdfUrl + encodeURIComponent(crossDomainUrl + filepath)+"#zoom="+zoom;
            } else {//本地
                    window.location.href = pdfUrl + "${webRoot}/resources/" + filepath + "&fileName=" + fileName+"#zoom="+zoom;//该方法访问本地文件更快，不要转换为文件流后再传递--%>
            }
        } else {
            alert("该文档类型不支持预览")
        }
        //如果不传递文件路径就查看默认的PDF文档
    } else {
        window.location.href = "${webRoot}/plug-in/pdf/web/viewer.html#zoom="+zoom;
    }
</script>
</body>
</html>

