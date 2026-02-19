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
<script type="text/javascript">
	setTimeout(function() {
	  location.href="/logOut.do";
	}, 3000);
</script>
</head>
<body>
	<div class="sub-bg3">
		<div class="box-wrap">
			<div class="success-box">
				<h1 class="logo"><img src="/survey/images/logo-on.png"></h1>
				<p>진단검사가 모두 완료되었습니다.</p>
				<span>긴 시간 수고 많으셨습니다.<br class="m-block"> 좋은 결과 있으시길 바랍니다.</span>
			</div>
		</div>
	</div>
<jsp:include page="/WEB-INF/view/front/include/footer.jsp" />
</body>
</html>