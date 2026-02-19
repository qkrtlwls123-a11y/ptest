<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<script type="text/javascript">
	// 대시보드 설정
	$('.dashboardSetup-btn').click(function(){
		fn_dashboardSettingPopup("dashboardSettingPopup", "");
	});
	
	$('.noticeSetup-btn').click(function(){
		fn_noticePopup("dashboardNoticePopup", "");
	});
	
	function fn_goDashTypeSetting(){
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/dashTypeSetting.do",
			type : "POST",
			data: params,
			success : function(result) {
				$(".con-wrap").html(result)
			}
		});
	}
	
	// A-Type 컨텐츠
	$('.dash-setup-Atype button').click(function(){
		$('#size_id').val($(this).attr('data-sizeId'));
		$('#frame_id').val($(this).attr('data-frameId'));
		$('#dash_company_id').val($(this).attr('data-dashSiteId'));
		$('#menu_id').val($(this).attr('data-menuId'));
		$('#ctnts_id').val($(this).attr('data-ctntsId'));
		$('#ctnts_rolling_type').val($(this).attr('data-ctntsRollingType'));
		$('#ctnts_fix_type_1').val($(this).attr('data-ctntsFixType1'));
		$('#ctnts_fix_type_2').val($(this).attr('data-ctntsFixType2'));
		$('#ctnts_fix_type_3').val($(this).attr('data-ctntsFixType3'));
		$('#ctnts_fix_type_4').val($(this).attr('data-ctntsFixType4'));
		openDefaultPopup("dashboardSettingDetailPopup", "");
	});
	
	// B-Type 컨텐츠
	$('.dash-setup-Btype button').click(function(){
		$('#size_id').val($(this).attr('data-sizeId'));
		$('#frame_id').val($(this).attr('data-frameId'));
		$('#dash_company_id').val($(this).attr('data-dashSiteId'));
		$('#menu_id').val($(this).attr('data-menuId'));
		$('#ctnts_id').val($(this).attr('data-ctntsId'));
		$('#ctnts_rolling_type').val($(this).attr('data-ctntsRollingType'));
		$('#ctnts_fix_type_1').val($(this).attr('data-ctntsFixType1'));
		$('#ctnts_fix_type_2').val($(this).attr('data-ctntsFixType2'));
		$('#ctnts_fix_type_3').val($(this).attr('data-ctntsFixType3'));
		$('#ctnts_fix_type_4').val($(this).attr('data-ctntsFixType4'));
		openDefaultPopup("dashboardSettingDetailPopup", "");
	});
	
	// C-Type 컨텐츠
	$('.dash-setup-Ctype button').click(function(){
		$('#size_id').val($(this).attr('data-sizeId'));
		$('#frame_id').val($(this).attr('data-frameId'));
		$('#dash_company_id').val($(this).attr('data-dashSiteId'));
		$('#menu_id').val($(this).attr('data-menuId'));
		$('#ctnts_id').val($(this).attr('data-ctntsId'));
		$('#ctnts_rolling_type').val($(this).attr('data-ctntsRollingType'));
		$('#ctnts_fix_type_1').val($(this).attr('data-ctntsFixType1'));
		$('#ctnts_fix_type_2').val($(this).attr('data-ctntsFixType2'));
		$('#ctnts_fix_type_3').val($(this).attr('data-ctntsFixType3'));
		$('#ctnts_fix_type_4').val($(this).attr('data-ctntsFixType4'));
		openDefaultPopup("dashboardSettingDetailPopup", "");
	});
	
	// B-Type 컨텐츠
	$('.dash-setup-Dtype button').click(function(){
		$('#size_id').val($(this).attr('data-sizeId'));
		$('#frame_id').val($(this).attr('data-frameId'));
		$('#dash_company_id').val($(this).attr('data-dashSiteId'));
		$('#menu_id').val($(this).attr('data-menuId'));
		$('#ctnts_id').val($(this).attr('data-ctntsId'));
		$('#ctnts_rolling_type').val($(this).attr('data-ctntsRollingType'));
		$('#ctnts_fix_type_1').val($(this).attr('data-ctntsFixType1'));
		$('#ctnts_fix_type_2').val($(this).attr('data-ctntsFixType2'));
		$('#ctnts_fix_type_3').val($(this).attr('data-ctntsFixType3'));
		$('#ctnts_fix_type_4').val($(this).attr('data-ctntsFixType4'));
		openDefaultPopup("dashboardSettingDetailPopup", "");
	});
	
	// 대시보드 설정 저장 완료
	function fn_dashContentSave(){
		var sSetCnt = 0;
		// A 타입
		if( "${dashList.type_id}" == "1" ){
			// 완료 여부 체크
			$('.dash-setup-Atype em').each(function(i,e){
				if(!$(e).find('button').attr('data-ctntsId')) sSetCnt ++;
			});
			if(sSetCnt>0){
				openDefaultPopup("dashContentCautionPopup", "");
			}
			fn_dashSetComplete();
		}
		// B 타입
		if( "${dashList.type_id}" == "2" ){
			// 완료 여부 체크
			$('.dash-setup-Btype em').each(function(i,e){
				if(!$(e).find('button').attr('data-ctntsId')) sSetCnt ++;
			});
			if(sSetCnt>0){
				openDefaultPopup("dashContentCautionPopup", "");
			}
			fn_dashSetComplete();
		}
		// C 타입
		if( "${dashList.type_id}" == "3" ){
			// 완료 여부 체크
			$('.dash-setup-Atype em').each(function(i,e){
				if(!$(e).find('button').attr('data-ctntsId')) sSetCnt ++;
			});
			if(sSetCnt>0){
				openDefaultPopup("dashContentCautionPopup", "");
			}
			fn_dashSetComplete();
		}
		// D 타입
		if( "${dashList.type_id}" == "4" ){
			// 완료 여부 체크
			$('.dash-setup-Atype em').each(function(i,e){
				if(!$(e).find('button').attr('data-ctntsId')) sSetCnt ++;
			});
			if(sSetCnt>0){
				openDefaultPopup("dashContentCautionPopup", "");
			}
			fn_dashSetComplete();
		}
	}
	
	// 대시보드 설정 완료
	function fn_dashSetComplete(){
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/updateSetComplete.json",
			type : "POST",
			data: params,
			success : function(result) {
				$.ajax({
					url : "${pageContext.request.contextPath}/dashboard.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result)
					}
				});
			}
		});
	}
	
	function fn_deleteDash(dashId){
		var params = $("form[id=dashParameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/deleteDashId.json",
			type : "POST",
			data: params,
			success : function(result) {
				$.ajax({
					url : "${pageContext.request.contextPath}/dashboard.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result)
					}
				});
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
	<form:form id="dashParameterVO" commandName="dashParameterVO" name="dashParameterVO" action="" method="post">
	<input type="hidden" id="size_id" name="size_id" value="">
	<input type="hidden" id="menu_id" name="menu_id" value="">
	<input type="hidden" id="frame_id" name="frame_id" value="">
	<input type="hidden" id="type_id" name="type_id" value="${dashList.type_id}">
	<input type="hidden" id="ctnts_id" name="ctnts_id" value="">
	<input type="hidden" id="ctnts_key" name="ctnts_key" value="">
	<input type="hidden" id="ctnts_val" name="ctnts_val" value="">
	<input type="hidden" id="dash_company_id" name="dash_company_id" value="">
	<input type="hidden" id="dash_id" name="dash_id" value="${dashList.dash_id}">
	<input type="hidden" id="building_id" name="building_id" value=""/>
	<input type="hidden" id="zone_id" name="zone_id" value=""/>
	<input type="hidden" id="cell_id" name="cell_id" value=""/>
	<input type="hidden" id="ctnts_rolling_type" name="ctnts_rolling_type" value=""/>
	<input type="hidden" id="ctnts_fix_type_1" name="ctnts_fix_type_1" value=""/>
	<input type="hidden" id="ctnts_fix_type_2" name="ctnts_fix_type_2" value=""/>
	<input type="hidden" id="ctnts_fix_type_3" name="ctnts_fix_type_3" value=""/>
	<input type="hidden" id="ctnts_fix_type_4" name="ctnts_fix_type_4" value=""/>
	<div class="con-area" style="border: 0;">
	
		<!-- 대시보드 미설정 -->
		<c:if test="${ sessionVO.grade_id eq '4' || sessionVO.grade_id eq '5' }">
			<span class="no-dashboard"><spring:message code="click.dashboard.setup.not.complete"/></span>
		</c:if>
		<!-- 대시보드 미설정 -->
		
		<c:if test="${ sessionVO.grade_id ne '4' && sessionVO.grade_id ne '5' }">
		<ul class="sub-tab-style01">
			<li><a href="#" onclick="javascript:fn_goDashTypeSetting();return false;">TYPE <spring:message code="click.setting"/></a></li>
			<li><a href="#" class="active"><spring:message code="click.content.settings"/></a></li>
		</ul>
		<!-- 컨텐츠 설정 -->
		<c:choose>
			<c:when test="${dashList.type_id eq '1'}">
				<span class="dashboard-c-setup-t"><spring:message code="click.select.content.area"/></span>
				<ul class="dash-setup-Atype">
					<li>
						<div>
							<c:if test="${locale == 'ko_kr'}">
								<em class="atype-section01">
									<c:if test="${empty dashSiteList1}">
										<button type="button" data-sizeId="1" data-frameId="1" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList1}">
										<p>${dashSiteList1.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="1" data-dashSiteId="${dashSiteList1.dash_company_id}" data-menuId="${dashSiteList1.menu_id}" data-ctntsId="${dashSiteList1.ctnts_id}" data-ctntsRollingType="${dashSiteList1.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList1.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList1.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList1.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList1.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section02">
									<c:if test="${empty dashSiteList2}">
										<button type="button" data-sizeId="2" data-frameId="2" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList2}">
										<p>${dashSiteList2.ctnts_name}</p>
										<button type="button" data-sizeId="2" data-frameId="2" data-dashSiteId="${dashSiteList2.dash_company_id}" data-menuId="${dashSiteList2.menu_id}" data-ctntsId="${dashSiteList2.ctnts_id}" data-ctntsRollingType="${dashSiteList2.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList2.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList2.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList2.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList2.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section01">
									<c:if test="${empty dashSiteList3}">
										<button type="button" data-sizeId="1" data-frameId="3" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList3}">
										<p>${dashSiteList3.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="3" data-dashSiteId="${dashSiteList3.dash_company_id}" data-menuId="${dashSiteList3.menu_id}" data-ctntsId="${dashSiteList3.ctnts_id}" data-ctntsRollingType="${dashSiteList3.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList3.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList3.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList3.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList3.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section01_1">
									<c:if test="${empty dashSiteList4}">
										<button type="button" data-sizeId="1" data-frameId="4" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList4}">
										<p>${dashSiteList4.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="4" data-dashSiteId="${dashSiteList4.dash_company_id}" data-menuId="${dashSiteList4.menu_id}" data-ctntsId="${dashSiteList4.ctnts_id}" data-ctntsRollingType="${dashSiteList4.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList4.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList4.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList4.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList4.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section01_1 cb">
									<c:if test="${empty dashSiteList5}">
										<button type="button" data-sizeId="1" data-frameId="5" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList5}">
										<p>${dashSiteList5.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="5" data-dashSiteId="${dashSiteList5.dash_company_id}" data-menuId="${dashSiteList5.menu_id}" data-ctntsId="${dashSiteList5.ctnts_id}" data-ctntsRollingType="${dashSiteList5.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList5.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList5.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList5.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList5.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section03">
									<c:if test="${empty dashSiteList6}">
										<button type="button" data-sizeId="3" data-frameId="6" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList6}">
										<p>${dashSiteList6.ctnts_name}</p>
										<button type="button" data-sizeId="3" data-frameId="6" data-dashSiteId="${dashSiteList6.dash_company_id}" data-menuId="${dashSiteList6.menu_id}" data-ctntsId="${dashSiteList6.ctnts_id}" data-ctntsRollingType="${dashSiteList6.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList6.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList6.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList6.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList6.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section01_2">
									<c:if test="${empty dashSiteList7}">
										<button type="button" data-sizeId="1" data-frameId="7" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList7}">
										<p>${dashSiteList7.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="7" data-dashSiteId="${dashSiteList7.dash_company_id}" data-menuId="${dashSiteList7.menu_id}" data-ctntsId="${dashSiteList7.ctnts_id}" data-ctntsRollingType="${dashSiteList7.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList7.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList7.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList7.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList7.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section01_3">
									<c:if test="${empty dashSiteList8}">
										<button type="button" data-sizeId="1" data-frameId="8" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList8}">
										<p>${dashSiteList8.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="8" data-dashSiteId="${dashSiteList8.dash_company_id}" data-menuId="${dashSiteList8.menu_id}" data-ctntsId="${dashSiteList8.ctnts_id}" data-ctntsRollingType="${dashSiteList8.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList8.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList8.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList8.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList8.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
							</c:if>
							<c:if test="${locale == 'en'}">
								<em class="atype-section01">
									<c:if test="${empty dashSiteList1}">
										<button type="button" data-sizeId="1" data-frameId="1" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList1}">
										<p class="en-p">${dashSiteList1.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="1" data-dashSiteId="${dashSiteList1.dash_company_id}" data-menuId="${dashSiteList1.menu_id}" data-ctntsId="${dashSiteList1.ctnts_id}" data-ctntsRollingType="${dashSiteList1.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList1.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList1.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList1.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList1.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section02">
									<c:if test="${empty dashSiteList2}">
										<button type="button" data-sizeId="2" data-frameId="2" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList2}">
										<p class="en-p">${dashSiteList2.ctnts_name_eng}</p>
										<button type="button" data-sizeId="2" data-frameId="2" data-dashSiteId="${dashSiteList2.dash_company_id}" data-menuId="${dashSiteList2.menu_id}" data-ctntsId="${dashSiteList2.ctnts_id}" data-ctntsRollingType="${dashSiteList2.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList2.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList2.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList2.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList2.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section01">
									<c:if test="${empty dashSiteList3}">
										<button type="button" data-sizeId="1" data-frameId="3" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList3}">
										<p class="en-p">${dashSiteList3.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="3" data-dashSiteId="${dashSiteList3.dash_company_id}" data-menuId="${dashSiteList3.menu_id}" data-ctntsId="${dashSiteList3.ctnts_id}" data-ctntsRollingType="${dashSiteList3.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList3.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList3.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList3.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList3.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section01_1">
									<c:if test="${empty dashSiteList4}">
										<button type="button" data-sizeId="1" data-frameId="4" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList4}">
										<p class="en-p">${dashSiteList4.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="4" data-dashSiteId="${dashSiteList4.dash_company_id}" data-menuId="${dashSiteList4.menu_id}" data-ctntsId="${dashSiteList4.ctnts_id}" data-ctntsRollingType="${dashSiteList4.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList4.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList4.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList4.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList4.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section01_1 cb">
									<c:if test="${empty dashSiteList5}">
										<button type="button" data-sizeId="1" data-frameId="5" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList5}">
										<p class="en-p">${dashSiteList5.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="5" data-dashSiteId="${dashSiteList5.dash_company_id}" data-menuId="${dashSiteList5.menu_id}" data-ctntsId="${dashSiteList5.ctnts_id}" data-ctntsRollingType="${dashSiteList5.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList5.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList5.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList5.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList5.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section03">
									<c:if test="${empty dashSiteList6}">
										<button type="button" data-sizeId="3" data-frameId="6" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList6}">
										<p class="en-p">${dashSiteList6.ctnts_name_eng}</p>
										<button type="button" data-sizeId="3" data-frameId="6" data-dashSiteId="${dashSiteList6.dash_company_id}" data-menuId="${dashSiteList6.menu_id}" data-ctntsId="${dashSiteList6.ctnts_id}" data-ctntsRollingType="${dashSiteList6.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList6.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList6.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList6.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList6.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section01_2">
									<c:if test="${empty dashSiteList7}">
										<button type="button" data-sizeId="1" data-frameId="7" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList7}">
										<p class="en-p">${dashSiteList7.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="7" data-dashSiteId="${dashSiteList7.dash_company_id}" data-menuId="${dashSiteList7.menu_id}" data-ctntsId="${dashSiteList7.ctnts_id}" data-ctntsRollingType="${dashSiteList7.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList7.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList7.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList7.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList7.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="atype-section01_3">
									<c:if test="${empty dashSiteList8}">
										<button type="button" data-sizeId="1" data-frameId="8" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType1="" data-ctntsFixType2="" data-ctntsFixType3="" data-ctntsFixType4=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList8}">
										<p class="en-p">${dashSiteList8.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="8" data-dashSiteId="${dashSiteList8.dash_company_id}" data-menuId="${dashSiteList8.menu_id}" data-ctntsId="${dashSiteList8.ctnts_id}" data-ctntsRollingType="${dashSiteList8.ctnts_rolling_type}" data-ctntsFixType1="${dashSiteList8.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList8.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList8.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList8.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
							</c:if>
						</div>
					</li>
				</ul>
			</c:when>
		
			<c:when test="${dashList.type_id eq '2'}">
				<span class="dashboard-c-setup-t"><spring:message code="click.select.content.area"/></span>
				<ul class="dash-setup-Btype">
					<li>
						<div>
							<c:if test="${locale == 'ko_kr'}">
								<em class="btype-section01">
									<c:if test="${empty dashSiteList1}">
										<button type="button" data-sizeId="1" data-frameId="9" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList1}">
										<p>${dashSiteList1.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="9" data-dashSiteId="${dashSiteList1.dash_company_id}" data-menuId="${dashSiteList1.menu_id}" data-ctntsId="${dashSiteList1.ctnts_id}" data-ctntsRollingType="${dashSiteList1.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList1.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList1.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList1.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList1.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="btype-section02">
									<c:if test="${empty dashSiteList2}">
										<button type="button" data-sizeId="4" data-frameId="10" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList2}">
										<p>${dashSiteList2.ctnts_name}</p>
										<button type="button" data-sizeId="4" data-frameId="10" data-dashSiteId="${dashSiteList2.dash_company_id}" data-menuId="${dashSiteList2.menu_id}" data-ctntsId="${dashSiteList2.ctnts_id}" data-ctntsRollingType="${dashSiteList2.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList2.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList2.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList2.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList2.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="btype-section01_1 cb">
									<c:if test="${empty dashSiteList3}">
										<button type="button" data-sizeId="1" data-frameId="11" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList3}">
										<p>${dashSiteList3.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="11" data-dashSiteId="${dashSiteList3.dash_company_id}" data-menuId="${dashSiteList3.menu_id}" data-ctntsId="${dashSiteList3.ctnts_id}" data-ctntsRollingType="${dashSiteList3.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList3.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList3.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList3.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList3.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="btype-section01_1 cb">
									<c:if test="${empty dashSiteList4}">
										<button type="button" data-sizeId="1" data-frameId="12" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList4}">
										<p>${dashSiteList4.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="12" data-dashSiteId="${dashSiteList4.dash_company_id}" data-menuId="${dashSiteList4.menu_id}" data-ctntsId="${dashSiteList4.ctnts_id}" data-ctntsRollingType="${dashSiteList4.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList4.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList4.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList4.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList4.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="btype-section03">
									<c:if test="${empty dashSiteList5}">
										<button type="button" data-sizeId="5" data-frameId="13" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList5}">
										<p>${dashSiteList5.ctnts_name}</p>
										<button type="button" data-sizeId="5" data-frameId="13" data-dashSiteId="${dashSiteList5.dash_company_id}" data-menuId="${dashSiteList5.menu_id}" data-ctntsId="${dashSiteList5.ctnts_id}" data-ctntsRollingType="${dashSiteList5.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList5.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList5.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList5.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList5.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
							</c:if>
							<c:if test="${locale == 'en'}">
								<em class="btype-section01">
									<c:if test="${empty dashSiteList1}">
										<button type="button" data-sizeId="1" data-frameId="9" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList1}">
										<p class="en-p">${dashSiteList1.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="9" data-dashSiteId="${dashSiteList1.dash_company_id}" data-menuId="${dashSiteList1.menu_id}" data-ctntsId="${dashSiteList1.ctnts_id}" data-ctntsRollingType="${dashSiteList1.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList1.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList1.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList1.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList1.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="btype-section02">
									<c:if test="${empty dashSiteList2}">
										<button type="button" data-sizeId="4" data-frameId="10" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList2}">
										<p class="en-p">${dashSiteList2.ctnts_name_eng}</p>
										<button type="button" data-sizeId="4" data-frameId="10" data-dashSiteId="${dashSiteList2.dash_company_id}" data-menuId="${dashSiteList2.menu_id}" data-ctntsId="${dashSiteList2.ctnts_id}" data-ctntsRollingType="${dashSiteList2.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList2.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList2.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList2.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList2.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="btype-section01_1 cb">
									<c:if test="${empty dashSiteList3}">
										<button type="button" data-sizeId="1" data-frameId="11" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList3}">
										<p class="en-p">${dashSiteList3.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="11" data-dashSiteId="${dashSiteList3.dash_company_id}" data-menuId="${dashSiteList3.menu_id}" data-ctntsId="${dashSiteList3.ctnts_id}" data-ctntsRollingType="${dashSiteList3.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList3.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList3.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList3.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList3.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="btype-section01_1 cb">
									<c:if test="${empty dashSiteList4}">
										<button type="button" data-sizeId="1" data-frameId="12" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList4}">
										<p class="en-p">${dashSiteList4.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="12" data-dashSiteId="${dashSiteList4.dash_company_id}" data-menuId="${dashSiteList4.menu_id}" data-ctntsId="${dashSiteList4.ctnts_id}" data-ctntsRollingType="${dashSiteList4.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList4.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList4.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList4.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList4.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="btype-section03">
									<c:if test="${empty dashSiteList5}">
										<button type="button" data-sizeId="5" data-frameId="13" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList5}">
										<p class="en-p">${dashSiteList5.ctnts_name_eng}</p>
										<button type="button" data-sizeId="5" data-frameId="13" data-dashSiteId="${dashSiteList5.dash_company_id}" data-menuId="${dashSiteList5.menu_id}" data-ctntsId="${dashSiteList5.ctnts_id}" data-ctntsRollingType="${dashSiteList5.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList5.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList5.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList5.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList5.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
							</c:if>
						</div>
					</li>
				</ul>
			</c:when>
			<c:when test="${dashList.type_id eq '3'}">
				<span class="dashboard-c-setup-t"><spring:message code="click.select.content.area"/></span>
				<ul class="dash-setup-Ctype">
					<li>
						<div>
							<c:if test="${locale == 'ko_kr'}">
								<em class="ctype-section01">
									<c:if test="${empty dashSiteList1}">
										<button type="button" data-sizeId="1" data-frameId="14" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList1}">
										<p>${dashSiteList1.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="14" data-dashSiteId="${dashSiteList1.dash_company_id}" data-menuId="${dashSiteList1.menu_id}" data-ctntsId="${dashSiteList1.ctnts_id}" data-ctntsRollingType="${dashSiteList1.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList1.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList1.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList1.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList1.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="ctype-section01_1 cb">
									<c:if test="${empty dashSiteList2}">
										<button type="button" data-sizeId="1" data-frameId="15" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList2}">
										<p>${dashSiteList2.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="15" data-dashSiteId="${dashSiteList2.dash_company_id}" data-menuId="${dashSiteList2.menu_id}" data-ctntsId="${dashSiteList2.ctnts_id}" data-ctntsRollingType="${dashSiteList2.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList2.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList2.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList2.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList2.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="ctype-section01_1 cb">
									<c:if test="${empty dashSiteList3}">
										<button type="button" data-sizeId="1" data-frameId="16" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList3}">
										<p>${dashSiteList3.ctnts_name}</p>
										<button type="button" data-sizeId="1" data-frameId="16" data-dashSiteId="${dashSiteList3.dash_company_id}" data-menuId="${dashSiteList3.menu_id}" data-ctntsId="${dashSiteList3.ctnts_id}" data-ctntsRollingType="${dashSiteList3.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList3.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList3.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList3.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList3.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="ctype-section03">
									<c:if test="${empty dashSiteList4}">
										<button type="button" data-sizeId="6" data-frameId="17" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList4}">
										<p>${dashSiteList4.ctnts_name}</p>
										<button type="button" data-sizeId="6" data-frameId="17" data-dashSiteId="${dashSiteList4.dash_company_id}" data-menuId="${dashSiteList4.menu_id}" data-ctntsId="${dashSiteList4.ctnts_id}" data-ctntsRollingType="${dashSiteList4.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList4.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList4.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList4.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList4.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
							</c:if>
							<c:if test="${locale == 'en'}">
								<em class="ctype-section01">
									<c:if test="${empty dashSiteList1}">
										<button type="button" data-sizeId="1" data-frameId="14" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList1}">
										<p class="en-p">${dashSiteList1.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="14" data-dashSiteId="${dashSiteList1.dash_company_id}" data-menuId="${dashSiteList1.menu_id}" data-ctntsId="${dashSiteList1.ctnts_id}" data-ctntsRollingType="${dashSiteList1.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList1.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList1.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList1.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList1.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="ctype-section01_1 cb">
									<c:if test="${empty dashSiteList2}">
										<button type="button" data-sizeId="1" data-frameId="15" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList2}">
										<p class="en-p">${dashSiteList2.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="15" data-dashSiteId="${dashSiteList2.dash_company_id}" data-menuId="${dashSiteList2.menu_id}" data-ctntsId="${dashSiteList2.ctnts_id}" data-ctntsRollingType="${dashSiteList2.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList2.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList2.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList2.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList2.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="ctype-section01_1 cb">
									<c:if test="${empty dashSiteList3}">
										<button type="button" data-sizeId="1" data-frameId="16" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList3}">
										<p class="en-p">${dashSiteList3.ctnts_name_eng}</p>
										<button type="button" data-sizeId="1" data-frameId="16" data-dashSiteId="${dashSiteList3.dash_company_id}" data-menuId="${dashSiteList3.menu_id}" data-ctntsId="${dashSiteList3.ctnts_id}" data-ctntsRollingType="${dashSiteList3.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList3.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList3.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList3.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList3.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="ctype-section03">
									<c:if test="${empty dashSiteList4}">
										<button type="button" data-sizeId="6" data-frameId="17" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList4}">
										<p class="en-p">${dashSiteList4.ctnts_name_eng}</p>
										<button type="button" data-sizeId="6" data-frameId="17" data-dashSiteId="${dashSiteList4.dash_company_id}" data-menuId="${dashSiteList4.menu_id}" data-ctntsId="${dashSiteList4.ctnts_id}" data-ctntsRollingType="${dashSiteList4.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList4.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList4.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList4.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList4.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
							</c:if>
						</div>
					</li>
				</ul>
			</c:when>
			<c:when test="${dashList.type_id eq '4'}">
				<span class="dashboard-c-setup-t"><spring:message code="click.select.content.area"/></span>
				<ul class="dash-setup-Dtype">
					<li>
						<div>
							<c:if test="${locale == 'ko_kr'}">
								<em class="dtype-section04">
									<c:if test="${empty dashSiteList1}">
										<button type="button" data-sizeId="7" data-frameId="18" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList1}">
										<p>${dashSiteList1.ctnts_name}</p>
										<button type="button" data-sizeId="7" data-frameId="18" data-dashSiteId="${dashSiteList1.dash_company_id}" data-menuId="${dashSiteList1.menu_id}" data-ctntsId="${dashSiteList1.ctnts_id}" data-ctntsRollingType="${dashSiteList1.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList1.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList1.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList1.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList1.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="dtype-section05">
									<c:if test="${empty dashSiteList2}">
										<button type="button" data-sizeId="7" data-frameId="19" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList2}">
										<p>${dashSiteList2.ctnts_name}</p>
										<button type="button" data-sizeId="7" data-frameId="19" data-dashSiteId="${dashSiteList2.dash_company_id}" data-menuId="${dashSiteList2.menu_id}" data-ctntsId="${dashSiteList2.ctnts_id}" data-ctntsRollingType="${dashSiteList2.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList2.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList2.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList2.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList2.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
							</c:if>
							<c:if test="${locale == 'en'}">
								<em class="dtype-section04">
									<c:if test="${empty dashSiteList1}">
										<button type="button" data-sizeId="7" data-frameId="18" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList1}">
										<p class="en-p">${dashSiteList1.ctnts_name_eng}</p>
										<button type="button" data-sizeId="7" data-frameId="18" data-dashSiteId="${dashSiteList1.dash_company_id}" data-menuId="${dashSiteList1.menu_id}" data-ctntsId="${dashSiteList1.ctnts_id}" data-ctntsRollingType="${dashSiteList1.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList1.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList1.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList1.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList1.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
								<em class="dtype-section05">
									<c:if test="${empty dashSiteList2}">
										<button type="button" data-sizeId="7" data-frameId="19" data-dashSiteId="" data-menuId="" data-ctntsId="" data-ctntsRollingType="" data-ctntsFixType=""><spring:message code="click.unselected"/></button>
									</c:if>
									<c:if test="${!empty dashSiteList2}">
										<p class="en-p">${dashSiteList2.ctnts_name_eng}</p>
										<button type="button" data-sizeId="7" data-frameId="19" data-dashSiteId="${dashSiteList2.dash_company_id}" data-menuId="${dashSiteList2.menu_id}" data-ctntsId="${dashSiteList2.ctnts_id}" data-ctntsRollingType="${dashSiteList2.ctnts_rolling_type}" data-ctntsFixType="${dashSiteList2.ctnts_fix_type_1}" data-ctntsFixType2="${dashSiteList2.ctnts_fix_type_2}" data-ctntsFixType3="${dashSiteList2.ctnts_fix_type_3}" data-ctntsFixType4="${dashSiteList2.ctnts_fix_type_4}"><spring:message code="click.do.edit"/></button>
									</c:if>
								</em>
							</c:if>
						</div>
					</li>
				</ul>
			</c:when>
			<c:otherwise>
				<span class="no-type-content"><spring:message code="click.use.after.setting.type"/></span>
			</c:otherwise>
		</c:choose>
		<div class="center cb mb30">
			<c:choose>
				<c:when test="${dashList.type_id eq '1'}">
					<button type="button" class="btn btn-blue btn-type2 mr10" onclick="javascript:fn_dashContentSave();return false;"><spring:message code="click.save"/></button>
					<button type="button" class="btn btn-main btn-gray-main btn-type2" onclick="javascript:fn_deleteDash('${dashList.dash_id}');return false;"><spring:message code="click.cancel"/></button>
				</c:when>
				<c:when test="${dashList.type_id eq '2'}">
					<button type="button" class="btn btn-blue btn-type2 mr10" onclick="javascript:fn_dashContentSave();return false;"><spring:message code="click.save"/></button>
					<button type="button" class="btn btn-main btn-gray-main btn-type2" onclick="javascript:fn_deleteDash('${dashList.dash_id}');return false;"><spring:message code="click.cancel"/></button>
				</c:when>
				<c:when test="${dashList.type_id eq '3'}">
					<button type="button" class="btn btn-blue btn-type2 mr10" onclick="javascript:fn_dashContentSave();return false;"><spring:message code="click.save"/></button>
					<button type="button" class="btn btn-main btn-gray-main btn-type2" onclick="javascript:fn_deleteDash('${dashList.dash_id}');return false;"><spring:message code="click.cancel"/></button>
				</c:when>
				<c:when test="${dashList.type_id eq '4'}">
					<button type="button" class="btn btn-blue btn-type2 mr10" onclick="javascript:fn_dashContentSave();return false;"><spring:message code="click.save"/></button>
					<button type="button" class="btn btn-main btn-gray-main btn-type2" onclick="javascript:fn_deleteDash('${dashList.dash_id}');return false;"><spring:message code="click.cancel"/></button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-main btn-gray-main btn-type2" onclick="javascript:fn_changePage('900');return false;"><spring:message code="click.cancel"/></button>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- 컨텐츠 설정 -->
		</c:if>
	</div>
	</form:form>
	<!--본문 영역 끝-->
	