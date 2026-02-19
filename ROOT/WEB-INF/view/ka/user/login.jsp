<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://www.springframework.org/tags/form" prefix="form"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
page import="kr.co.vitaminsoft.commons.util.Constant" %><%@ 
page import="kr.co.vitaminsoft.commons.util.CookieUtil" %><%
	String ck_login_id = CookieUtil.getCookieValue(request, Constant.COOKIE_ADMIN_LOGIN_ID);
	if(ck_login_id == null){
		ck_login_id = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge; charset=UTF-8" />
	<title>인성진단시스템</title>
	<link rel="shortcut icon" href="/resources/images/common/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="/resources/css/admin_common.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/admin_login.css">
	<script type="text/javascript" src="/resources/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.form.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.base64.js"></script>
	<script type="text/javascript" src="/resources/js/common.js"></script>
	<script type="text/javascript">
		var ck_login_id="<%=ck_login_id%>";
		$(document).ready(function(){
			if(ck_login_id != undefined && ck_login_id != ""){
				$("#chk_saveLoginId").prop("checked", true);
				$("#nm").val(ck_login_id);
				$("#pwd").focus();
			}else{
				$("#nm").prop("checked", false);
				$("#nm").focus();
			}
			
			$("#nm").keyup(function(){
				$(this).val($(this).val().replace(/[^\a-zA-Z0-9\-_@.\b]/g,""));
			});
			$("#pwd").keyup(function(){
				$(this).val($(this).val().replace(/[^\a-zA-Z0-9\b]/g,""));
			});
		});
		function fn_login(){
			$("#actionForm").attr("action", "/ka/proc.do");
			if (!fn_validation()) return;
			
			$("#pw").val($.base64.btoa($("#pwd").val()));
			console.log($("#pw").val());
			$("#pwd").val("");
			if($("#nm").val() == ""){
				alert("아이디를 입력해주세요!");
				$("#nm").focus();
				return false;
			}
			if($("#pw").val() == ""){
				alert("패스워드를 입력해주세요!");
				$("#pwd").focus();
				return false;
			}
			$("#actionForm").ajaxSubmit({
				success: function(data){
					if(data.rcode == 200){
						location.href = '${view.retUrl}';
					}else{
						$("#login_msg_area").html(data.msg);
					}
				}
			});
		}
		
		function fn_validation() {
			var nm = $("#nm");
			var pw = $("#pwd");
			if (!isNullAndTrim(nm, "관리자아이디를 입력해주세요.")) {
				return false;
			}
			if (!isNullAndTrim(pw, "패스워드를 입력해주세요.")) {
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
	<div id="wrap">
		<form id="actionForm" method="POST">
		<input type="hidden" id = "pw" name ="pw">
		<input type="hidden" id="retUrl" name="retUrl" value="${view.retUrl}"/>
		<div id="login_msg_area"></div>
			<div class="login" >
				<div style="width: 28%;height: 88px;left: 36%;position:relative;text-align: center;">
    						<div style="position:relative;top:30px;font-weight: bold;font-size: 14px;color: white;">이곳은 [진단검사] 운영을 위한 관리자 사이트입니다.</div>
					</div>
				<div class="login_fluid" style="top:45px;">
					<p>허용된 관리자만 접근가능합니다 !</p>
					<div class="login_form">
						<input type="text" id="nm" name="nm" placeholder="아이디를 입력해주세요"/>
					</div>
					<div class="login_form">
						<input type="password" id="pwd" name="pwd" placeholder="비밀번호를 입력해주세요" onkeypress="if(event.keyCode == 13) { fn_login(); return false;}"/>
					</div>
					<div class="login_form">
						<input type="checkbox" id="chk_saveLoginId" name="saveyn" value="Y" class="checkbox"/> <span>아이디저장</span>
					</div>
					<div class="login_form">
						<input type="button" onclick="fn_login()" class="login_btn" value="로그인"/>
					</div>
				</div>
			</div>
			<!--<p class="login_foot">
		    	이용 중 문의사항 및 불편사항은 <a href="mailto:webmaster@test.com">고객센터[0000-0000]</a>로 문의해주세요.<br/>
		    </p>-->
		</form>
	</div>
</body>
</html>