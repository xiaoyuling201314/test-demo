<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
        <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:;">检测点管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">快检机构
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form action="">
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl" type="text" placeholder="请输入内容" />
                <input type="submit" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                </div>
                <div class="cs-menu-btn cs-fr cs-ac">
                <a class="cs-add-btn runcode" href="javascript:;" name="content_frm">新增</a>
              </div>
              </form>
            </div>
          </div>

           <div class="clearfix">  
              <ul class="cs-point-list">
                <c:forEach items="${departs}" var="depart">
	                <li class="cs-ovow cs-list-table">
	                  <div class="cs-li-title">
	                  <img src="${webRoot}/img/jigou.png" alt="" width="36px"/>
	                    <span><a href="srtc.html">${depart.name}</a></span>
	                    <div class="cs-control cs-fr">
	                      <i class="icon iconfont icon-rewrite editDepart"></i><i class="icon iconfont icon-close"></i>
	                      <input class="departId" type="hidden" value="${depart.id}">
	                    </div>
	                  </div>
	                  <div class="cs-li-cell">                 
	                      <span class="cs-name">直管检测点：5个</span>
	                      <div class="cs-icon-in">
	                         <a href="javascript:;"><img src="${webRoot}/img/she.png" alt="" /><span class="cs-link-text">12台</span></a>
	                         <a href="javascript:;"><img src="${webRoot}/img/ren.png" alt="" /><span class="cs-link-text">30人</span></a>
	                      </div>
	                  </div>
	                  <div class="cs-li-cell">                 
	                      <span class="cs-name">下级检测点：5个</span>
	                      <div class="cs-icon-in">
	                         <a href="javascript:;"><img src="${webRoot}/img/she.png" alt="" /><span class="cs-link-text">12台</span></a>
	                         <a href="javascript:;"><img src="${webRoot}/img/ren.png" alt="" /><span class="cs-link-text">30人</span></a>
	                      </div>
	                  </div>
	                  <div class="cs-li-btm"><a href="javascript:;" >检测点：<i >17</i>个</a></div>
	                </li>
                </c:forEach>
              </ul>  
            </div>	
  
    <!-- JavaScript -->
    <script type="text/javascript">
    $(function(){
		//新增、编辑机构
		$(document).on("click", ".editDepart", function(){
			var departId = $(this).siblings(".departId").val();
			var url = 'url:${webRoot}/depart/goAddDepart.do';
			if(departId){
				url += '?id=1';
			}
			$.dialog({
				id: 'editDepart',
			    title: '编辑机构',
			    content: url,
			    width: '650px',
			    height: '300px',
			    ok: function(){
			    	
			    },
			    cancel: function(){}
			});
	    });
    });
    </script>
  </body>
</html>
 --%>