<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
 <jsp:include page="/WEB-INF/view/front/include/header.jsp" />
	<div class="sub-header">
		<h2>ERROR</h2>
		<p class="percent">
			<span class="percent-on" style="width:100%;"></span>
		</p>
		<p class="name"></p>
	</div>

	<div class="research-wrap">
		<div class="orientation-wrap infor-wrap">
			<div class="success-box">
				<p><img src="/survey/images/research-img.png" alt=""></p>
				<h4>비정상적으로 접근 되었습니다.</h4>
				<span>시스템에서 비정상적 접근으로 인식하였습니다. <br class="m-block"> 다시 확인 후 시작하시기 바랍니다. </span>
			</div>
		</div>
	</div>
<jsp:include page="/WEB-INF/view/front/include/footer.jsp" />