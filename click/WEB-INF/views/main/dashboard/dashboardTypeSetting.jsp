<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<script type="text/javascript">
	
	$(function(){
		// 대시보드 미사용인 경우 화면 이동
		if( "N" == "${dashList.use_yn}" && null != "${dashList.intro_page_no}" ){
			//fn_change("${dashList.intro_page_no}");
			console.log("page 이동");
		}
	})
	
	// 대시보드 설정
	$('.dashboardSetup-btn').click(function(){
		fn_dashboardSettingPopup("dashboardSettingPopup", "");
	});
	
	$('.noticeSetup-btn').click(function(){
		fn_noticePopup("dashboardNoticePopup", "");
	});
	
	/*
	*	대시보드 타입 저장
	*/
	function fn_dashTypeSave(){
		if(!$('input[name="type_id"]:checked').val()){
			openDefaultPopup("loginPopup" , '<spring:message code="click.select.dashboard.type"/>');
			return false;
		}
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/dashTypeUpdate.json",
			type : "POST",
			data: params,
			success : function(result) {
				// 저장완료 시 컨텐츠 설정으로 이동
				fn_goDashContentSetting();
			}
		});
	}
	
	function fn_goDashContentSetting(){
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/dashContentSetting.do",
			type : "POST",
			data: params,
			success : function(result) {
				$(".con-wrap").html(result)
			}
		});
	}
	</script>

	<!-- 네비게이션 시작 -->
	<div class="page-navigation">
		<ul>
			<li><a href="#">Home</a></li>
			<li class="gray">></li>
			<li><a href="#"><spring:message code="click.dashboard"/></a></li>
		</ul>
	</div>
	<!-- 네비게이션 끝 -->
	<div class="page-info-wrap mr20">
		<c:if test="${ sessionVO.grade_id eq '2' || sessionVO.grade_id eq '3' }">
		<button type="button" class="dashboardSetup-btn"><spring:message code="click.dashboard.setup"/> ></button>
		<button type="button" class="noticeSetup-btn"><spring:message code="click.notice.settings"/> ></button>
		</c:if>
		<button type="button" class="dashboardMode-btn"><spring:message code="click.status.board.mode"/> ></button>
	</div>
	<!--본문 영역 시작-->
	<div class="con-area" style="border: 0;">
	
		<!-- 대시보드 미설정 -->
		<c:if test="${ dashList.use_yn eq 'N' || empty dashList || sessionVO.grade_id eq '4' || sessionVO.grade_id eq '5' }">
		<span class="no-dashboard"><spring:message code="click.dashboard.setup.not.complete"/></span>
		</c:if>
		<!-- 대시보드 미설정 -->
		
		<c:if test="${ dashList.use_yn eq 'Y' }">
		<form:form id="parameterVO" commandName="parameterVO" name="parameterVO" action="" method="post"> 
		<!-- 대시보드 설정 -->
			<ul class="sub-tab-style01">
				<li><a href="#" class="active">TYPE <spring:message code="click.setting"/></a></li>
				<li><a href="#" onclick="javascript:fn_goDashContentSetting();return false;"><spring:message code="click.content.settings"/></a></li>
			</ul>
			<span class="dashboard-select-t"><spring:message code="click.select.dashboard.type"/></span>
			<ul class="dash-type-wrap mb30">
				<li>
					<label for="dashtype1"><input type="radio" name="type_id" id="dashtype1" value="1" <c:if test="${dashList.type_id eq '1'}">checked</c:if>> A-TYPE
					<!--선택완료가 되면 보여집니다-->
					<div class="on" <c:if test="${dashList.type_id ne '1'}">style="display:none;"</c:if>>
						<em><spring:message code="click.selection.complete"/></em>
					</div>
					<!--선택완료가 되면 사라집니다-->
					<div>
						<em class="dash-section01"></em>
						<em class="dash-section02"></em>
						<em class="dash-section01"></em>
						<em class="dash-section01_1"></em>
						<em class="dash-section01_1 cb"></em>
						<em class="dash-section03"></em>
						<em class="dash-section01_2"></em>
						<em class="dash-section01_3"></em>
					</div>
					</label>
				</li>
				<li>
					<label for="dashtype2"><input type="radio" name="type_id" id="dashtype2" value="2" <c:if test="${dashList.type_id eq '2'}">checked</c:if>> B-TYPE
					<div class="on" <c:if test="${dashList.type_id ne '2'}">style="display:none;"</c:if>>
						<em><spring:message code="click.selection.complete"/></em>
					</div>
					<div>
						<em class="dash-section01"></em>
						<em class="dash-section02"></em>
						<em class="dash-section01_1"></em>
						<em class="dash-section01_1 cb"></em>
						<em class="dash-section03"></em>
					</div>
					</label>
				</li>
				<li>
					<label for="dashtype3"><input type="radio" name="type_id" id="dashtype3" value="3" <c:if test="${dashList.type_id eq '3'}">checked</c:if>> C-TYPE
					<div class="on" <c:if test="${dashList.type_id ne '3'}">style="display:none;"</c:if>>
						<em><spring:message code="click.selection.complete"/></em>
					</div>
					<div>
						<em class="dash-section01"></em>
						<em class="dash-section02"></em>
						<em class="dash-section01_1"></em>
						<em class="dash-section01_1 cb"></em>
						<em class="dash-section03"></em>
					</div>
					</label>
				</li>
				<li>
					<label for="dashtype4"><input type="radio" name="type_id" id="dashtype4" value="4" <c:if test="${dashList.type_id eq '4'}">checked</c:if>> D-TYPE
					<div class="on" <c:if test="${dashList.type_id ne '4'}">style="display:none;"</c:if>>
						<em><spring:message code="click.selection.complete"/></em>
					</div>
					<div>
						<em class="dash-section04"></em>
						<em class="dash-section05"></em>
					</div>
					</label>
				</li>
			</ul>
			</form:form>
			<div class="center cb">
				<c:if test="${empty dashList.type_id}">
					<button type="button" class="btn btn-blue btn-type2 mr10" onclick="javascript:fn_dashTypeSave();"><spring:message code="click.save"/></button>
				</c:if>
				<c:if test="${!empty dashList.type_id}">
					<button type="button" class="btn btn-blue btn-type2 mr10" onclick="javascript:fn_dashTypeSave();"><spring:message code="click.edit"/></button>
				</c:if>
				<button type="button" class="btn btn-main btn-gray-main btn-type2"><spring:message code="click.cancel"/></button>
			</div>
			<div class="center cb" style="display: none;">
				<button type="button" class="btn btn-main btn-gray-main btn-type2"><spring:message code="click.cancel"/></button>
			</div>
		</c:if>
		<!-- 대시보드 설정 -->
	</div>
	<!--본문 영역 끝-->