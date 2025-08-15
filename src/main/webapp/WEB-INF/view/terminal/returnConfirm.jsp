<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 <!-- 询问是否返回 -->
<div class="modal fade intro2" id="confirm-returnBack" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="cs-alert-height zz-dis-tab2 " style="">
                <div class="zz-pay zz-ok zz-no-margin zz-title-bg">
                    <%-- <img src="${webRoot}/img/terminal/wen.png" alt="" style="width: 40px"> --%>
                    <p class="zz-ok-text" style="display: inline-block;">提示</p>
                </div>
                <div class="zz-notice" >
                  	<img src="${webRoot}/img/terminal/wen.png" alt="" style="width: 40px"> 您还有订单未提交，确认返回吗？
                </div>
                <div class="modal-footer">
                    <button type="" class="btn btn-danger" data-dismiss="modal">取消</button>
                	<button type="button" class="btn btn-primary _return_confirm_btn" data-dismiss="modal">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>     
 <script type="text/javascript">
 
</script>