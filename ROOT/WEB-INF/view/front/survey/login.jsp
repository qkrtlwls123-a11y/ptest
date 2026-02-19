<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <jsp:include page="/WEB-INF/view/front/include/header.jsp" />
 <script type="text/javascript" src="/resources/js/jquery.form.js"></script>
 <script type="text/javascript" src="/resources/js/jquery.base64.js"></script>
 <script type="text/javascript" src="/resources/js/common.js"></script>
 <script type="text/javascript">
	$(document).ready(function() {
		$("#nm").keyup(function(){
			$(this).val($(this).val().replace(/[^\a-zA-Z0-9\-_@.\b]/g,""));
		});
		$("#pwd").keyup(function(){
			$(this).val($(this).val().replace(/[^\a-zA-Z0-9\b]/g,""));
		});
	});
	var User = {
		userParams : {},
		loginUser : function(){ 
			if (!fn_validation()) return;
			
			$("#pw").val($.base64.btoa($("#pwd").val()));
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
			
			User.userParams["nm"] = $("#nm").val();
			User.userParams["pw"] = $("#pw").val();
			User.userParams["s_recruit_survey_id"] = "${box.id}";
			
			var url = "/checkIdAjax.do";
			$.ajax({
				url			: url,
				type		: "post",
				data		: $.param(User.userParams),
				datatype	: "json",
				success		: function(data){
					if(data == true){
						location.href="/survey/${box.id}/step1.do";
					}else{
						alert("아이디 비밀번호를 확인해주세요");						
					}
				},
				error	: function(request,status,error){
					alert("올바른 로그인 정보를 입력해주세요.");
				}
			});
		}
	}
	
	function fn_validation() {
		var nm = $("#nm");
		var pw = $("#pwd");
		
		if (!isNullAndTrim(nm, "이메일을 입력해주세요.")) {
			return false;
		}
		
		if (!isValidEmail(nm)) {
			alert("이메일 형식이 맞지 않습니다.\n다시 입력해주세요.");
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
	<div class="sub-bg">
		<div class="box-wrap">
			<h1 class="logo"><img src="/survey/images/logo-off.png"></h1>
			<div class="login-form">
				<h2>전달 받은 로그인 정보를 입력해주세요.</h2>
				<form action="" autocomplete="off">
					<input type="hidden" id="pw" vlaue="">
					<div class="input-wrap">
						<label for="nm">e-mail</label>
						<input type="email" id="nm" placeholder="이메일을 입력하세요" autocomplete="none">
					</div>
					<div class="input-wrap">
						<label for="pwd">password</label>
						<input type="password" id="pwd" placeholder="비밀번호를 입력하세요" autocomplete="none" onkeypress="if(event.keyCode == 13) { User.loginUser(); return false;}" />
					</div>
					<div style="text-align:center;"><button type="button" onclick="User.loginUser()">LOGIN</button></div>
				</form>
			</div>
		</div>
	</div>
<jsp:include page="/WEB-INF/view/front/include/footer.jsp" />
</body>
</html>