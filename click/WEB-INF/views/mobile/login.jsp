<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="ko" class="ko">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="apple-mobile-web-app-capable" content="yes"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
<meta name="format-detection" content="telephone=no" />


<title>ONION BOX</title>


<!-- <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/mobile/images/favicon.ico" type="image/x-icon"/> -->
<link rel="apple-touch-icon-precomposed"  href="${pageContext.request.contextPath}/resources/mobile/images/114x114.png" />
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/resources/mobile/images/114x114.png" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/mobile/css/jquery-ui-1.10.4.min.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/mobile/css/m_common.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/mobile/css/m_contents.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/vendors.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/vendor/jquery/jquery-1.12.4.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/vendor/jquery/jquery.easing.1.3.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/vendor/jquery/jquery-bpopup/jquery.bpopup.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/vendor/slick/slick.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/vendor/iscroll/iscroll.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/js/location.js"></script>
<script type="text/javascript">
function fn_actionLogin() {
	if(fn_checkRequired() && fn_checkEmail() && fn_checkPassword){
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "/click/mobile/login/checkLogin.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					location.href = "/click/mobile/mobileMain.do"
				} else {
					alert(result.resultMessage);
				}
			}
		});
	}
}

function fn_checkRequired(){
	var checkValue = true;
	
	$(".required").each(function(e){
		if($(this).val() == ""){
			alert($(this).attr("placeholder")+"은(는) 필수입력 항목 입니다.");
			checkValue = false;
			return false;
		}
	});
	
	return checkValue;
}

function fn_checkEmail(){
	var checkValue = true;
	var patternEmail = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
	
	$(".email").each(function(e){
		var targetValue = $(this).val(); 
		if(!patternEmail.test(targetValue)){
			alert("이메일 형식이 맞지 않습니다.");
			checkValue = false;
			return false;
		}
	});
	
	return checkValue;
	
}

function fn_checkPassword(){
	var checkValue = true;
	var patternPassword = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;

	$(".password").each(function(e){
		var targetValue = $(this).val(); 
		if(!patternPassword.test(targetValue)){
			alert("비밀번호는 8자리 이상의 숫자, 문자 조합입니다.");
			checkValue = false;
			return false;
		}
	});

	return checkValue;
}
</script>
</head>

<body class="comBg"><!--   -->

<div class="wrap">

	<div class="areas">
		<div class="container">
			<div style="margin:0 auto;text-align:center;padding:150px 0 70px;"><img src="${pageContext.request.contextPath}/resources/img/onion_logo.png" style="width:60%;max-width:60%;min-width:60%;"></div>
			<form name="parameterVO" action="${pageContext.request.contextPath}/login" novalidate>
                 <fieldset style="text-align:center;">
                     <input type="text" class="required email" style="line-height:4rem;border-radius:5px;background:#F6F6F6;font-size:16px;border-color:#F6F6F6;font-weight:200;padding-left:20px;border:0px solid gray;width:80%;margin-bottom:15px;" id="member_email" name="member_email" placeholder="이메일 입력" required>
                 </fieldset>
                 <fieldset style="text-align:center;">
                     <input type="password" class="required" style="line-height:4rem;border-radius:5px;background:#F6F6F6;font-size:16px;border-color:#F6F6F6;font-weight:200;padding-left:20px;border:0px solid gray;width:80%;margin-bottom:15px;" id="user-password" name="member_password" placeholder="비밀번호 입력" required>
                 </fieldset>
                 <fieldset style="text-align:center;">
                 	<button type="submit" style="line-height:4rem;border-radius:5px;background:#FC77A0;font-size:16px;border-color:#F6F6F6;font-weight:400;color:white;padding:0px 10px;border:0px solid gray;width:84%;" onclick="javascript:fn_actionLogin();return false;">로그인</button>
                 </fieldset>
             </form>
		</div><!-- container -->
	</div><!-- areas -->
</div><!-- wrap -->
<script type="text/javascript">
	$(document).ready(function(e) {

	});
</script>
</body>
</html>




