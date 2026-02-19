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
<script type="text/javascript" src="/resources/js/common.js"></script>
<script type="text/javascript">
	$(function(){
		$(".start-btn").hover(function(){
			$(this).addClass("over");
		},function(){
			$(this).removeClass("over");
		});
	});
	
	function goLogin(){
		location.href="/survey/${box.id}/login.do";
	}
</script>
</head>
<body>

	<div class="intro-bg">
		<div class="box-wrap">
			<h1 class="logo"><img src="/survey/images/logo-on.png"></h1>
			<div class="intro-text">
				<h2><span>Hello,</span> there!</h2>
				<p><span>[한국알콜그룹 채용 인성진단검사]</span>를 위해<br>방문해 주신 여러분 환영합니다.</p>
				<button type="button" class="start-btn" onclick="goLogin()">Start here</button>
			</div>
		</div>
	</div>
	
<jsp:include page="/WEB-INF/view/front/include/footer.jsp" />
</body>
</html>