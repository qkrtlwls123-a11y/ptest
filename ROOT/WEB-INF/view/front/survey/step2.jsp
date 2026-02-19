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
var Survey = {
	surveyParams : {},
	nextStep : function(){ 
		//if (!fn_validation()) return;
		/* <c:if test="${surveyInfo.job_yn eq 'Y'}">
			Survey.surveyParams["job_code"] = $(':radio[name=job_code]:checked').val();
		</c:if>
		<c:if test="${surveyInfo.duty_yn eq 'Y'}">
			Survey.surveyParams["duty_code"] = $(':radio[name=duty_code]:checked').val();
		</c:if>
		<c:if test="${surveyInfo.gender_yn eq 'Y'}">
			Survey.surveyParams["gender_code"] = $(':radio[name=gender_code]:checked').val();
		</c:if>
		<c:if test="${surveyInfo.age_group_yn eq 'Y'}">
			Survey.surveyParams["age_group_code"] = $(':radio[name=age_group_code]:checked').val();
		</c:if> */

		var url = "/survey/${box.id}/step2Ajax.do";
		$.ajax({
			url			: url,
			type		: "post",
			data		: $.param(Survey.surveyParams),
			success		: function(data){
				if(data.rcode == 200){
					location.href="/survey/${box.id}/step3.do?currentPage=${currentPage+1}";
				}else if(data.rcode == 400 || data.rcode == 401){
					alert("설문 URL이 정확한지 확인해주세요.");
					location.href="/survey/alert.do";
				}else if(data.rcode == 402){
					alert("로그인이 되어 있지 않습니다.\n로그인 후 이용해 주세요.");
					location.href="/survey/${box.id}/login.do";
				}else if(data.rcode == 100){
					location.href="/survey/${box.id}/step3.do?currentPage=${currentPage+1}";
				}else{
					alert("설문 URL이 정확한지 확인해주세요.");
					location.href="/survey/alert.do";
				}
			},
			error	: function(request,status,error){
				alert("입력 정보를 확인해주세요.");
			}
		});
	},
	backStep : function(){ 
		location.href="/survey/${box.id}/step1.do";
	}
}

function fn_validation() {
	<c:if test="${surveyInfo.job_yn eq 'Y'}">
		if (!$('input:radio[name=job_code]').is(':checked')){
			alert("직군 정보를 첵크해주세요.");
			location.href="#job_code";
			return false;
		}
	</c:if>
	<c:if test="${surveyInfo.duty_yn eq 'Y'}">
		if (!$('input:radio[name=duty_code]').is(':checked')){
			alert("직무 정보를 첵크해주세요.");
			location.href="#duty_code";
			return false;
		}
	</c:if>
	<c:if test="${surveyInfo.gender_yn eq 'Y'}">
		if (!$('input:radio[name=gender_code]').is(':checked')){
			alert("성별 정보를 첵크해주세요.");
			location.href="#gender_code";
			return false;
		}
	</c:if>
	<c:if test="${surveyInfo.age_group_yn eq 'Y'}">
		if (!$('input:radio[name=age_group_code]').is(':checked')){
			alert("연령대 정보를 첵크해주세요.");
			location.href="#age_group_code";
			return false;
		}
	</c:if>
	return true;
}
</script>
</head>
<body>
<div class="sub-bg">

	<div class="research-wrap">
		<div class="orientation-wrap">
			<div class="sub-title">
				<h3>Let's start!</h3>
			</div>
			<div class="text-box">
				<div>
					<p class="content pink">[주의사항]</p>
					<div class="content">
						<p class="before"><span>1.</span><span class="second">본 인성진단검사는 능력을 평가하는 검사가 아니며, 좋은 or 나쁜 성격을 구분하는 검사도 아닙니다. 따라서 ‘정답’ 과 ‘오답’ 이 없습니다.  지나치게 고민하지 마시고, 평소 자신의 모습과 가깝다고 생각하는 것을 선택해 주시기 바랍니다.</span></p>
						<p class="before"><span>2.</span><span class="second">본 인성진단검사는 수검자의 응답 태도를 측정하는 다양한 방법을 적용하고 있습니다. 본인의 이미지를 의식적으로 과장하거나 왜곡하여 검사결과를 신뢰하기 어려울 경우, 오히려 채용과정에서 불이익이 있을 수 있습니다.<br>최대한 솔직하고 편안한 태도로 응답해 주시기 바랍니다.</span></p>
						<p class="pink">※ 각 항목 진단 완료 후, 다음 버튼을 누르시면 선택 내용 수정이 불가합니다.</p>
					</div>
				</div>
			</div>
			<p class="start-btn"><button type="button" onclick="Survey.nextStep()">진단 시작</button></p>
		</div>
	</div>
</div>
<form action="" id="Step2Form" style="display: none;">
<input name="currentPage" value="">
</form>
<jsp:include page="/WEB-INF/view/front/include/footer.jsp" />
</body>
</html>