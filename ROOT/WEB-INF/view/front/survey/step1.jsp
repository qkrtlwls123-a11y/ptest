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
var Survey = {
	nextStep : function(){ 
		location.href="/survey/${box.id}/step2.do";
	}
}
 </script>
</head>
<body>
<div class="sub-bg2">
	<%-- <div class="sub-header">
		<h2>${surveyInfo.survey_nm}</h2>
		<p class="percent">
			<span class="percent-on" style="width:${box.executeRate}%;"></span>
		</p>
		<p class="name">( 검사자 : <span>${userSession.userName}</span>님 )</p>
	</div> --%>

	<div class="research-wrap">
		<div class="orientation-wrap">
			<div class="sub-title">
				<h3>Hello!<span>${userSession.userName}님</span></h3>
			</div>
			<div class="text-box">
				<div>
					<p class="sub-logo"><img src="/survey/images/logo-off.png"></p>
					<p class="content pink">한국알콜그룹(KAI,ENF,KC&A) 채용 전형에 지원해 주셔서 감사합니다.</p>
					<div class="content">
						<p>본 인성진단검사는 지원자의 성격이나 평소 행동 특성이 한국알콜그룹 조직 및 직무에 얼마나 적합한지를 파악하기 위한 검사입니다.</p>
						<p>부득이한 사정으로 검사가 중단된 경우, 재접속하면 이전 접속시 중단 된  페이지에서부터 진행됩니다.</p>
						<p>진단은 아래와 같은 단계로 구성되어 있습니다. 모든 단계를 끝마쳐야 정상적으로 종료됩니다. (평균소요시간 : 약 30분)</p>
					</div>
					<div style="text-align:center;">
						<div class="num-wrap">
							<div>
								<p class="number">01</p>
								<p class="text">가치</p>
							</div>
							<div>
								<p class="number">02</p>
								<p class="text">정서</p>
							</div>
							<div>
								<p class="number">03</p>
								<p class="text">성향</p>
							</div>
							<div class="last">
								<p class="number">04</p>
								<p class="text">마음건강</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<p class="next-btn"><button type="button" onclick="Survey.nextStep()">확인했습니다</button></p>
		</div>
	</div>
</div>
	
<jsp:include page="/WEB-INF/view/front/include/footer.jsp" />
</body>
</html>