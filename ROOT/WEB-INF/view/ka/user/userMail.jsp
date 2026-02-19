<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://www.springframework.org/tags/form" prefix="form"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
<script type="text/javascript">	
	$(function(){
		$('#user_email').keyup(function () {
			$(this).val( $(this).val().replace(/[^a-z0-9@.]/g,""));
		});
		$('#user_hp').keyup(function () {
			$(this).val( $(this).val().replace(/[^0-9]/g,"") );
		});
		$('#year_birth').keyup(function () {
			$(this).val( $(this).val().replace(/[^0-9]/g,"") );
		});
		<c:if test="${view.use_yn eq 'N'}">
			//$('.allContent input').prop('readonly', true);
			//$('.allContent option').attr('disabled', true);
		</c:if>
	});
	
	function fn_sendMail(){
		var params = $("form[name=MailForm]").serialize();
		$.ajax({
			url			: "/ka/user/sendMail.do",
			type		: "post",
			data		: params,
			success		: function(data){
				alert("메일이 발송 되었습니다.");
			},
			error	: function(request,status,error){
				alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
			}
		});
	}

</script>
	<div id="content" class="popup">
		<h2>
		메일발송
		</h2>
		
		<div class="popup_table">
		<form id="MailForm" name="MailForm" method="post" action="/ka/user/goUserAction2.do">
		<input type="hidden" name="id" value="${mailList}"/>
		<input type="hidden" name="address" value="http://www.ptest.co.kr/survey/${pageId}/login.do"/>
			<table>
				<colgroup>
					<col width="100">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>메일 발송 대상</th>
						<td>
							${targetMailList}
						</td>
					</tr>
					<tr>
						<th>링크주소</th>
						<td>
							http://www.ptest.co.kr/survey/${pageId}/login.do
						</td>
					</tr>
					<tr>
						<th>메일제목</th>
						<td>
							<input type="text" name="mail_title" class="w500">
						</td>
					</tr>
					<tr>
						<th>메일내용</th>
						<td>
							<textarea name="mail_contents" rows="18" cols="130"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<div id="each1View">
				<div class="btn_space_formU">
					<input type="button" class="ok_btn" value="발송" onclick="javascript:fn_sendMail();return false;"/>
					<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
				</div>
			</div>
		</form>
		</div>

	</div>
