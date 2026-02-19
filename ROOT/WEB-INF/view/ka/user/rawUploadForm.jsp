<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
<script type="text/javascript">
function rowRegAction(){
	if($("#file_upFile").val() == ''){
		alert("파일을 선택해 주세요.");
		$("#file_upFile").focus();
		return false;
	}
	$("#prog").show();
	$("#rowFileForm").attr("action","/ka/user/goRequestAction.do");
	$("#rowFileForm").ajaxSubmit({
		async:false,
		success:function(data){
			if(data.rcode > 0){
				alert("업로드 완료.\n총 "+data.total+"건\n중복삭제 "+data.delcnt+"건");
				setTimeout(function() {
					$("#prog").hide();
					COMM_POPUP.close();
					User.getUserList(User.params["pageNo"]);
				}, 500);
			}else{
				alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
				setTimeout(function() {
					$("#prog").hide();
					COMM_POPUP.close();
				}, 500);
			}
        },
		error	: function(request,status,error){
			$("#prog").hide();
			alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
		}
    });
}
</script>
	<div id="content" class="popup">
		<h2>row파일등록</h2>
		<div class="popup_table">
		<form method="post" action="/ka/user/goRequestAction.do" id="rowFileForm" enctype="multipart/form-data">
		<input type="hidden" name="action_mode" value="${view.action_mode}"/>
			<table>
				<colgroup>					
					<col width="130">
					<col>
					<col width="130">
					<col>
				</colgroup>
				<tbody>
				<tr>
					<th>row파일</th>
					<td colspan="3">
						<input type="file" id="file_upFile" name="upFile" size="32"/>
					</td>
				</tr>
<%-- 				<tr>
					<th>부제목</th>
					<td colspan="3">
						<input type="text" id="banner_sub_title" name="sub_title" value="${view.sub_title}" class="yellow w600" maxlength="100"/>
					</td>
				</tr> --%>
				</tbody>
			</table>
		</form>	
		</div>
		<div class="btn_space_formU">
			<input type="button" class="ok_btn" value="등록" onclick="rowRegAction()"/>
			<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
		</div>
	</div>
	<div id="prog" style="display:none;">
		<span><img src="/resources/images/common/loading.gif"/></span>
		<span>업로드 중 입니다. 완료까지 기다리세요.</span>
	</div>