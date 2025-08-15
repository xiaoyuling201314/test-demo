<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
  <div class="cs-content">
    <table class="cs-add-new">
      <tr>
        <td class="cs-name"> 名称：</td>
        <td class="cs-in-style"><input type="text" value='<c:if test="${!empty depart}">${depart.departName}</c:if>'/></td>
        <td class="cs-name">所属机构：</td>
        <td class="cs-in-style"><input type="text" readonly="readonly" value='<c:if test="${!empty depart}">${depart.departName}</c:if>'/></td>
      </tr>
      <tr>
        <td class="cs-name">负责人：</td>
        <td class="cs-in-style"><input type="text" value=''/></td>
        <td class="cs-name">联系电话：</td>
        <td class="cs-in-style"><input type="text" value=''/></td>
      </tr>
      <tr>
      	<td class="cs-name">固话：</td>
        <td class="cs-in-style"><input type="text" value='<c:if test="${!empty depart}">${depart.mobilePhone}</c:if>'/></td>
        <td class="cs-name">地址：</td>
        <td class="cs-in-style"><input type="text" value='<c:if test="${!empty depart}">${depart.address}</c:if>'/></td>
      </tr>
      <tr>
        <td class="cs-name">备注：</td>
        <td class="cs-in-style" rowspan="2">
        	<!-- <input type="text" value=''/> -->
        	<textarea rows="2" cols=""><c:if test="${!empty depart}">${depart.description}</c:if></textarea>
        </td>
      </tr>
    </table>
  </div>
  
    <!-- JavaScript -->
    <script type="text/javascript">
    
    </script>
  </body>
</html>
