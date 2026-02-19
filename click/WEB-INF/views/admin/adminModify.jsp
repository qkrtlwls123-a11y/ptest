<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<script type="text/javascript">
	
		$(function(){
			
			fn_init();
			fn_gradeComboControl();
			
			if( "${parameterVO.account_hpms_yn}" == "Y" ){
				fn_sgsoneEmployee();
			}
			
		    $("input:radio[name=grade_id]").click(function(){
		    	console.log( "radio val : " + $(this).val() );
	    		// 현장관리자
		    	if( $(this).val() == '3' ){
		    		$('#siteGrade1').hide();
		    		$('#siteGrade2').show();
		    		$('#siteGrade3').hide();
		    		$('.commonCodeSiteList1').show();
		    		$('.commonCodeSiteList2').hide();
		    		fn_init();
					$('#siteGrade2 .insertSite > span > input[type=hidden]').each(function(i,e){
						$(e).attr('disabled',false);
					});
					$('#siteGrade3 > span > input[type=hidden]').each(function(i,e){
						$(e).attr('disabled',true);
					});
					$('.businessType').text("-");
		    	}else if( $(this).val() == '2' ){
		    		$('#siteGrade1').show();
		    		$('#siteGrade2').hide();
		    		$('#siteGrade3').hide();
		    		$('.commonCodeSiteList1').show();
		    		$('.commonCodeSiteList2').hide();
		    		$('#code').val('');
		    		$('.businessType').text("-");
		    	}else{
		    		$('#siteGrade1').hide();
		    		$('#siteGrade2').hide();
		    		$('#siteGrade3').show();
		    		$('.commonCodeSiteList1').hide();
		    		$('.commonCodeSiteList2').show();
		    		
					$('#siteGrade2 .insertSite > span > input[type=hidden]').each(function(i,e){
						$(e).attr('disabled',true);
					});
					
		    		// 권한 하락 현재 접속한 현장으로 변경
				    if( "${locale}" == "ko_kr" || "${locale}" == "ko_KR" ){
						$('#siteGrade3').html('<span class="mt5 mt5 mr10">'
								 + '<input type="hidden" name="company_id" value="${loginVO.company_id}">'
									 + '${loginVO.site_name}'
								 +'</span>');
					}else{
						$('#siteGrade3').html('<span class="mt5 mt5 mr10">'
								 + '<input type="hidden" name="company_id" value="${loginVO.company_id}">'
									 + '${loginVO.site_name_eng}'
								 +'</span>');
					}
					fn_getCodeOfBusiness();
		    	}
	    		
		    });
		    
			$('select[name="sch_code"]').change(function(){
				$('#code').val($(this).val());
				// 업종조회
				if($('#code').val()){
					fn_getCodeOfBusiness();
				}
			});
		    
		});
		
		// 업체의 업종 조히
		function fn_getCodeOfBusiness(){
			var params = $("form[name=accountVO]").serialize(); 
			$.ajax({
				url : "${pageContext.request.contextPath}/selectCodeOfBusiness.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						$('.businessType').text(result.codeParam.code_name);
					}else if(result.resultCode == "fail"){
						//openDefaultPopup("loginPopup", result.message);
						$('.businessType').text("-");
					}
				}
			});
		}
		
	    function fn_init(){
	    	$('#code').val( $('.commonCodeSiteList2 select[name="sch_code"] option:selected').val() );
	    }
	
		var checkId = true;
		
		function fn_gradeComboControl(){
			if('${parameterVO.grade_id}' == "3"){
	    		$('#siteGrade1').hide();
	    		$('#siteGrade2').show();
	    		$('#siteGrade3').hide();
	    		$('.commonCodeSiteList1').show();
	    		$('.commonCodeSiteList2').hide();
			}else if('${parameterVO.grade_id}' == "2"){
	    		$('#siteGrade1').show();
	    		$('#siteGrade2').hide();
	    		$('#siteGrade3').hide();
	    		$('.commonCodeSiteList1').show();
	    		$('.commonCodeSiteList2').hide();
			}else{
	    		$('#siteGrade1').hide();
	    		$('#siteGrade2').hide();
	    		$('#siteGrade3').show();
	    		$('.commonCodeSiteList1').hide();
	    		$('.commonCodeSiteList2').show();
			}
		}
		
		// 관리자 수정
		var sFocus = ""; // return Focus 값
		function fn_accountModiy(){
			/*
			if(!fn_validate()){
				return false;
			}
			*/
			
			$('#sch_code').attr('disabled','');

			// 성명 체크
			if(!$('#account_name').val()){
				openDefaultPopup("systemAdminPopup",'<spring:message code="click.mandatory.required.fields.apply"/>');
				sFocus = "account_name";
				return false;
			}
			// 연락처1 체크
			if(!$('#account_phone1').val()){
				openDefaultPopup("systemAdminPopup",'<spring:message code="click.mandatory.required.fields.apply"/>');
				sFocus = "account_phone1";
				return false;
			}
			// 연락처2 체크
			if(!$('#account_phone2').val()){
				openDefaultPopup("systemAdminPopup",'<spring:message code="click.mandatory.required.fields.apply"/>');
				sFocus = "account_phone2";
				return false;
			}
			// 연락처3 체크
			if(!$('#account_phone3').val()){
				openDefaultPopup("systemAdminPopup",'<spring:message code="click.mandatory.required.fields.apply"/>');
				sFocus = "account_phone3";
				return false;
			}
			
			if( $("input:radio[name=grade_id]:checked").val() == 3 ){
				if( $('#siteGrade2 .insertSite > span > input[type=hidden]').length < 1 ){
					openDefaultPopup("loginPopup",'<spring:message code="click.must.one.site"/>');
					return false;
				}
				$('#siteGrade3 > span > input[type=hidden]').each(function(i,e){
					$(e).attr('disabled',true);
				})
			}else if( $("input:radio[name=grade_id]:checked").val() == 4 || $("input:radio[name=grade_id]:checked").val() == 5 ){
				if( $('#siteGrade3 > span > input[type=hidden]').length < 1 ){
					openDefaultPopup("loginPopup",'<spring:message code="click.must.one.site"/>');
					return false;
				}
				$('#siteGrade2 .insertSite > span > input[type=hidden]').each(function(i,e){
					$(e).attr('disabled',true);
				})
			}
			if(checkId){
				var phone1 = $("#account_phone1").val();
				var phone2 = $("#account_phone2").val();
				var phone3 = $("#account_phone3").val();
				$("#account_phone").val(phone1+phone2+phone3);
				var params = $("form[name=accountVO]").serialize(); 
				$.ajax({
					url : "${pageContext.request.contextPath}/updateAccount.json",
					type : "POST",
					data: params,
					success : function(result) {
						if(result.resultCode == "success"){
							openDefaultPopup("loginPopup", '<spring:message code="click.been.edited"/>');
							var params2 = $("form[name=parameterVO]").serialize(); 
							$.ajax({
								url : "${pageContext.request.contextPath}/adminList.do",
								type : "POST",
								data: params2,
								success : function(result) {
									$(".con-wrap").html(result)
								}
							});
						}else if(result.resultCode == "fail"){
							openDefaultPopup("loginPopup", result.message);
						}
					}
				});
			}else{
				openDefaultPopup("loginPopup", '');
			}
		}
		
		// 팝업닫힌 후 동작
		function fn_closePopupSystemAdmin(){
			fn_closePopup();
			$('#'+sFocus).focus();
		}
		
		function fn_accountList(){
			var params = $("form[name=parameterVO]").serialize(); 
			$.ajax({
				url : "${pageContext.request.contextPath}/adminList.do",
				type : "POST",
				data : params,
				success : function(result) {
					$(".con-wrap").html(result);
				}
			});
		}
		
		function fn_checkAccountId(){
			if($("#account_id").val() != '' && $("#account_id").val() != null){
				var params = $("form[name=accountVO]").serialize(); 
				$.ajax({
					url : "${pageContext.request.contextPath}/checkAccountId.json",
					type : "POST",
					data: params,
					success : function(result) {
						if(result.resultCode == "success"){
							if(result.checkAccountId > 0){
								openDefaultPopup("loginPopup", '<spring:message code="click.id.currently.use"/>');
								checkId = false;
							}else{
								openDefaultPopup("loginPopup", '<spring:message code="click.id.available"/>');
								checkId = true;
							}
						}else{
							
						}
					}
				});
			}else{
				openDefaultPopup("loginPopup", '<spring:message code="click.no.id.entered"/>');
				checkId = false;
			}
		}
		
		
		/*
		* 성명 체크
		*/
		function fn_checkNameReturn(obj){
			checkId = false;
			obj.value = obj.value.trim();
			obj.value = obj.value.replace(/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/g, '');
		}
		
		function fn_delete(){
			openConfirmPopup('<spring:message code="click.delete.selected.account.ok"/>', '<spring:message code="click.confirm"/>', "fn_delete_admin");
		}
		
		function fn_delete_admin(){
			$("#searchId").val($('#account_id').val());
			var params = $("form[name=parameterVO]").serialize(); 
			$.ajax({
				url : "${pageContext.request.contextPath}/deleteAccount.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						var params2 = $("form[name=parameterVO]").serialize(); 
						$.ajax({
							url : "${pageContext.request.contextPath}/adminList.do",
							type : "POST",
							data: params2,
							success : function(result) {
								$(".con-wrap").html(result)
								fn_closePopup();
							}
						});
					}else if(result.resultCode == "fail"){
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
		}
		
		function fn_tmpPasswd(){
			var phone1 = $("#account_phone1").val();
			var phone2 = $("#account_phone2").val();
			var phone3 = $("#account_phone3").val();
			$("#account_phone").val(phone1+phone2+phone3);
			$('#first_login').val("Y");
			var params = $("form[name=accountVO]").serialize(); 
			$.ajax({
				url : "${pageContext.request.contextPath}/tmpPwdAccount.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						openDefaultPopup("loginPopup", '<spring:message code="click.temporary.password.phone"/>');
					}else if(result.resultCode == "fail"){
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
		}
		
		/* 현장권한추가 */
		function fn_siteGradeAdd(){
			var params = $("form[name=accountVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/siteGradeList.do",
				type : "POST",
				data: params,
				success : function(result) {
					$("#popupWrap").html(result);
					$("#popupWrap").css("display", "block");
				}
			});
		}
		
		function fn_siteAdd(){
			$('input:checkbox[name=checkSite]:checked').each(function(i,e){
				var siteId = $(e).parent().next('td').find('input[type=hidden]').val();
				var siteName = $(e).parent().next('td').text().trim();
					if( $('.insertSite > span > input[type=hidden]:input[value="'+siteId+'"]').length == 0 ){
						var sHtml = '<span class="mt5 mt5 mr10">';
						sHtml += '<input type="hidden" name="company_id" value="'+siteId+'">';
						sHtml += siteName;
						if( $('.insertSite > span > input[type=hidden]').length > 0 ){
							sHtml += '<a href="#" onclick="javscript:fn_deleteSite(this);return false;"><i class="fa fa-times-circle font18 ml5 v-top red"></i></a>';
						}
						sHtml += '</span>';
						$('.insertSite').append(sHtml);
					}
					
					// 2개인 경우 첫번째 span에 X 버튼 추가
					if( $('.insertSite > span').length > 1 ){
						if( $('.insertSite > span').eq(0).find('a').length == 0 ){
							$('.insertSite > span').eq(0).append('<a href="#" onclick="javscript:fn_deleteSite(this);return false;"><i class="fa fa-times-circle font18 ml5 v-top red"></i></a>');
						}
					}
			});
			fn_closePopup();
		}
		
		function fn_deleteSite(obj){
			var selectSiteId = $(obj).parent().find('input[type=hidden]').val();
			var siteLength = $(obj).parent().parent().find('span').length;
			if( siteLength <= 1 ){
				openDefaultPopup("loginPopup",'<spring:message code="click.must.one.site"/>');
				return false;
			}
			$(obj).parent().remove();
			
			// 2개이하인 경우 첫번째 span에 X 버튼 추가
			if( $('.insertSite > span > input[type=hidden]').length == 1 ){
				$('.insertSite > span > a').eq(0).remove();
			}
		}
		
		function fn_gradeViwerPopup(){
			var params = $("form[name=accountVO]").serialize(); 
			$.ajax({
				url : "${pageContext.request.contextPath}/gradeViewerPopup.do",
				type : "POST",
				data : params ,
				success : function(result) {
					$("#popupWrap").html(result);
					$("#popupWrap").css("display", "block");
				}
			});
		}
		
		// 현대건설 직원 데이터 조회
		function fn_sgsoneEmployee(){
			$('#site_code').val("ANJU");
			var params = $("form[name=accountVO]").serialize(); 
			$.ajax({
				url : "${pageContext.request.contextPath}/selectsgsoneEmployee.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						$('.hdecyn').text(result.userInfoVO.hdecyn);
					}else{
						openDefaultPopup("defaultPopup", result.message);
						checkId = false;
					}
				}
			});
		}
	</script>
			<div class="page-navigation">
				<c:choose>
					<c:when test="${loginVO.grade_id eq '1'}">
						<ul>
							<li><a href="#"><spring:message code="click.system.management"/></a></li>
							<li class="gray">></li>
							<li>
								<select name="" id="" onchange="javascript:fn_changePage(value);return false;">
									<option value="16"><spring:message code="click.customer.management"/></option>
									<option value="11" selected><spring:message code="click.administrator.settings"/></option>
									<option value="3"><spring:message code="click.site.management"/></option>
									<option value="13"><spring:message code="click.basic.data.management"/></option>
								</select>
							</li>
						</ul>
					</c:when>
					<c:when test="${loginVO.grade_id ne '1'}">
						<ul>
							<li><a href="#">Home</a></li>
							<li class="gray">></li>
							<li><a href="#"><spring:message code="click.setting"/></a></li>
							<li class="gray">></li>
							<li><a href="#"><spring:message code="click.default.setting"/></a></li>
							<li class="gray">></li>
							<li>
								<select name="" id="" onchange="javascript:fn_changePage(value);return false;">
									<option value="11" selected><spring:message code="click.administrator.settings"/></option>
									<option value="10"><spring:message code="click.worker.setting"/></option>
									<option value="8"><spring:message code="click.status.request.reissuance"/></option>
									<option value="6"><spring:message code="click.code.management"/></option>
								</select>
							</li>
						</ul>
					</c:when>
				</c:choose>
			</div>
			<div class="con-area">
				<div class="content-box">
					<form:form id="parameterVO" commandName="parameterVO" name="parameterVO" action="" method="post">
						<input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
						<%-- <input type="hidden" id="menuId" name="menuId" value="${parameterVO.menuId}"/> --%>
						<input type="hidden" id="menuId" name="menuId" value="11"/>
						<input type="hidden" id="searchId" name="searchId" value=""/>
					</form:form>
					<form:form id="accountVO" commandName="accountVO" name="accountVO" action="" method="post">
						<!-- <input type="hidden" id="company_id" name="company_id" value=""/> -->
						<input type="hidden" id="first_login" name="first_login" value="N"/>
						<input type="hidden" id="account_phone" name="account_phone"/>
						<input type="hidden" id="account_hpms_yn" name="account_hpms_yn" value="N"/>
						<%-- <input type="hidden" id="cooperator_id" name="cooperator_id" value="${parameterVO.cooperator_id}"/> --%>
						<input type="hidden" id="code" name="code" value="${parameterVO.code}"/>
						<input type="hidden" id="site_code" name="site_code" value=""/>
						<div class="table mt10 mb20 font14 no-hover">
							<table>
							<colgroup>
								<col width="15%">
								<col width="35%">
								<col width="15%">
								<col width="35%">
							</colgroup>
							<tbody>
								<tr>
									<th class="center"><spring:message code="click.permission"/></th>
									<td colspan="3">
										<c:if test="${loginVO.grade_id eq '1'}">
											<input type="radio" name="grade_id" value="2" checked><spring:message code="click.head.office.manager"/>
										</c:if>
										<c:if test="${loginVO.grade_id ne '1'}">
											<c:forEach var="gradeList" items="${gradeList}">
												<label>
													<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
														<input type="radio" name="grade_id" id="grade_id" value="${gradeList.grade_id}" <c:if test="${parameterVO.grade_id eq gradeList.grade_id}">checked</c:if>> ${gradeList.grade_name}&nbsp;
													</c:if>
													<c:if test="${ locale eq 'en' }">
														<input type="radio" name="grade_id" id="grade_id" value="${gradeList.grade_id}" <c:if test="${parameterVO.grade_id eq gradeList.grade_id}">checked</c:if>> ${gradeList.grade_desc}&nbsp;
													</c:if>
												</label>
											</c:forEach>
										</c:if>
										<c:if test="${loginVO.grade_id == '2' || loginVO.grade_id == '3'}">
										<button type="button" class="td-button01 ml20" onclick="javascript:fn_gradeViwerPopup();return false;"><spring:message code="click.permission.view"/></button>
										</c:if>
									</td>
								</tr>
								<tr>
									<c:if test="${loginVO.grade_id eq '1'}">
										<input type="hidden" name="account_use_yn" id="account_use_yn" value="Y">
									</c:if>
									<c:if test="${loginVO.grade_id ne '1'}">
									<th class="center">* <spring:message code="click.use.or.not"/></th>
									<td>
										<label for="account_use_yn"><input type="radio" name="account_use_yn" id="account_use_yn" value="Y" <c:if test="${parameterVO.account_use_yn eq 'Y' }">checked="checked"</c:if>> <spring:message code="click.available"/></label>&nbsp;
										<label for="account_use_yn"><input type="radio" name="account_use_yn" id="account_use_yn" value="N" <c:if test="${parameterVO.account_use_yn eq 'N' }">checked="checked"</c:if>> <spring:message code="click.can.not.used"/></label>&nbsp;
									</td>
									</c:if>
									<th class="center">* <spring:message code="click.account.status"/></th>
									<td colspan="3">
										<label for="account_status1"><input type="radio" name="account_status" id="account_status1" value="N" <c:if test="${parameterVO.account_status eq 'N' }">checked="checked"</c:if>> <spring:message code="click.normal"/></label>&nbsp;
										<label for="account_status2"><input type="radio" name="account_status" id="account_status2" value="S" <c:if test="${parameterVO.account_status eq 'S' }">checked="checked"</c:if>> <spring:message code="click.block"/></label>&nbsp;
										<label for="account_status3"><input type="radio" name="account_status" id="account_status3" value="Q" disabled="disabled" <c:if test="${parameterVO.account_status eq 'Q' }">checked="checked"</c:if>> <spring:message code="click.dormancy"/></label>&nbsp;
									</td>
								</tr>
								<c:if test="${loginVO.grade_id ne '1'}">
								<tr>
									<th class="center"><spring:message code="click.site.authority"/></th>
									<td colspan="3">
										<!-- 본사관리자 -->
										<div id="siteGrade1" class="disabled" style="display:none">
											<span class="blue font14 ml10">※ <spring:message code="click.manager.all.site.rights"/></span>
										</div>
										<!-- 현장관리자 -->
										<div id="siteGrade2" class="disabled" style="display:none">
											<button type="button" class="td-button01 mt10 mb10" onclick="javascript:fn_siteGradeAdd(); return false;"><spring:message code="click.add.site.authority"/></button>
											<table style="border-top: 1px solid #DEE2E6;">
												<tbody>
												<tr>
													<td class="insertSite">
														<c:if test="${ fn:length(accountSiteList) == 1 }">
															<c:forEach var="accountSiteList" items="${accountSiteList}">
																<span class="mt5 mt5 mr10">
																	<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
																		<input type="hidden" name="company_id" value="${accountSiteList.company_id}"/>${accountSiteList.site_name}
																	</c:if>
																	<c:if test="${ locale eq 'en' }">
																		<input type="hidden" name="company_id" value="${accountSiteList.company_id}"/>${accountSiteList.site_name_eng}
																	</c:if>
																	<a href="#" onclick="javscript:fn_deleteSite(this);return false;"></a>
																</span>
															</c:forEach>
														</c:if>
														<c:if test="${fn:length(accountSiteList) > 1 }">
															<c:forEach var="accountSiteList" items="${accountSiteList}">
																<span class="mt5 mt5 mr10">
																	<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
																		<input type="hidden" name="company_id" value="${accountSiteList.company_id}"/>${accountSiteList.site_name}
																	</c:if>
																	<c:if test="${ locale eq 'en' }">
																		<input type="hidden" name="company_id" value="${accountSiteList.company_id}"/>${accountSiteList.site_name_eng}
																	</c:if>
																	<a href="#" onclick="javscript:fn_deleteSite(this);return false;"><i class="fa fa-times-circle font18 ml5 v-top red"></i></a>
																</span>
															</c:forEach>
														</c:if>
													</td>
												</tr>
												</tbody>
											</table>
										</div>
										<!-- 그 외 -->
										<div id="siteGrade3" class="disabled" style="display:none">
											<c:forEach var="accountSiteList" items="${accountSiteList}">
												<span class="mt5 mt5 mr10">
													<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
														<input type="hidden" name="company_id" value="${accountSiteList.company_id}"/>${accountSiteList.site_name}
													</c:if>
													<c:if test="${ locale eq 'en' }">
														<input type="hidden" name="company_id" value="${accountSiteList.company_id}"/>${accountSiteList.site_name_eng}
													</c:if>
												</span>
											</c:forEach>
										</div>
									</td>
								</tr>
								</c:if>
								<tr>
									<th class="center">*  <spring:message code="click.id"/></th>
									<td colspan="3">
										<c:if test="${parameterVO.account_hpms_yn == 'N'}">
											<input type="text" class="readonly" id="account_id" name="account_id" value="${parameterVO.account_id}" readonly/>
										</c:if>
										<c:if test="${parameterVO.account_hpms_yn == 'Y'}">
											<input type="hidden" class="readonly" id="account_id" name="account_id" value="${parameterVO.account_id}" readonly/>
											${parameterVO.account_id}
										</c:if>
									</td>
								</tr>
								<tr>
									<th class="center">*  <spring:message code="click.name"/></th>
									<td colspan="3">
										<c:if test="${parameterVO.account_hpms_yn == 'N'}">
											<input type="text" class="required" id="account_name" name="account_name" value="${parameterVO.account_name}" onkeyup="javascript:fn_checkNameReturn(this);"/>
										</c:if>
										<c:if test="${parameterVO.account_hpms_yn == 'Y'}">
											<input type="hidden" class="required" id="account_name" name="account_name" value="${parameterVO.account_name}"/>
											${parameterVO.account_name}
											<i class="connect"><spring:message code="click.interlocking"/></i>
										</c:if>
									</td>
								</tr>
								<tr>
									<c:if test="${loginVO.grade_id eq '1'}">
										<th class="center">* <spring:message code="click.customer"/></th>
										<td>
											<input type="hidden" id="cooperator_id" name="cooperator_id" value="${parameterVO.cooperator_id}"/>
											<select class="readonly" disabled="disabled">
												<c:forEach var="cooperatorList" items="${cooperatorList}">
													<option value="${cooperatorList.cooperator_id}" <c:if test="${parameterVO.cooperator_id eq cooperatorList.cooperator_id}">selected</c:if>>${cooperatorList.cooperator_name}</option>
												</c:forEach>
											</select>
										</td>
									</c:if>
									<c:if test="${loginVO.grade_id ne '1'}">
										<th class="center">* <spring:message code="click.company.name"/></th>
										<td class="commonCodeSiteList1">
											<c:if test="${ sessionVO.cooperator_name == '현대건설' }">
												<select name="sch_code" id="sch_code" class="readonly" disabled>
													<option value=""><spring:message code="click.selection"/></option>
													<c:if test="${sessionVO.grade_id == '2' || sessionVO.grade_id == '3'}">
														<option value="${sessionVO.cooperator_id}" selected>${sessionVO.cooperator_name}</option>
													</c:if>
												</select>
											</c:if>
											<c:if test="${ sessionVO.cooperator_name != '현대건설' }">
												<select name="sch_code" id="sch_code">
													<option value=""><spring:message code="click.selection"/></option>
													<c:if test="${sessionVO.grade_id == '2' || sessionVO.grade_id == '3'}">
														<option value="${sessionVO.cooperator_id}" selected>${sessionVO.cooperator_name}</option>
													</c:if>
													<c:if test="${sessionVO.grade_id == '3'}">
													<c:forEach var="commonCodeSiteList" items="${commonCodeSiteList}">
														<option value="${commonCodeSiteList.code}">${commonCodeSiteList.code_name}</option>
													</c:forEach>
													</c:if>
												</select>
											</c:if>
										<td class="commonCodeSiteList2" style="display:none">
											<select name="sch_code" id="sch_code">
												<option value=""><spring:message code="click.selection"/></option>
												<c:forEach var="commonCodeSiteList" items="${commonCodeSiteList}">
													<option value="${commonCodeSiteList.code}"<c:if test="${parameterVO.code == commonCodeSiteList.code}">selected</c:if> >${commonCodeSiteList.code_name}</option>
												</c:forEach>
											</select>
										</td>
									</c:if>
									<th class="center"><spring:message code="click.business.item"/></th>
									<td>
										<span class="businessType">
											<c:if test="${empty parameterVO.business_type}">-</c:if>
											<c:if test="${!empty parameterVO.business_type}">${parameterVO.business_type}</c:if>
										</span>
									</td>
								</tr>
								<tr>
									<th class="center">* <spring:message code="click.contact.information"/></th>
									<td>
										<c:set var="account_phone" value="${fn:trim(parameterVO.account_phone)}"/>
										<c:if test="${parameterVO.account_hpms_yn == 'N'}">
											<input type="text" class="required required_num required_min required_max" data-minlen="2" data-maxlen="4" value="${fn:substring(account_phone,0,3)}" style="width: 150px;" id="account_phone1" maxlength="4">
											<input type="text" class="required required_num required_min required_max" data-minlen="2" data-maxlen="4" value="${fn:substring(account_phone,3,7)}" style="width: 150px;" id="account_phone2" maxlength="4">
											<input type="text" class="required required_num required_min required_max" data-minlen="4" data-maxlen="4" value="${fn:substring(account_phone,7,11)}" style="width: 150px;" id="account_phone3" maxlength="4">
										</c:if>
										<c:if test="${parameterVO.account_hpms_yn == 'Y'}">
											<input type="hidden" class="required required_num required_min required_max" data-minlen="2" data-maxlen="4" value="${fn:substring(account_phone,0,3)}" style="width: 150px;" id="account_phone1" maxlength="4">
											<input type="hidden" class="required required_num required_min required_max" data-minlen="2" data-maxlen="4" value="${fn:substring(account_phone,3,7)}" style="width: 150px;" id="account_phone2" maxlength="4">
											<input type="hidden" class="required required_num required_min required_max" data-minlen="4" data-maxlen="4" value="${fn:substring(account_phone,7,11)}" style="width: 150px;" id="account_phone3" maxlength="4">
											<span>${fn:substring(account_phone,0,3)}</span>
											<span>-</span>
											<span>${fn:substring(account_phone,3,7)}</span>
											<span>-</span>
											<span>${fn:substring(account_phone,7,11)}</span>
										</c:if>
									</td>
									<th class="center"><spring:message code="click.whether.employed"/></th>
									<td>
										<span class="hdecyn">-</span>
									</td>
								</tr>
								<tr>
									<th class="center">* <spring:message code="click.password"/></th>
									<td colspan="3">
										<button type="button" class="btn btn-green btn-type3" onclick="javascript:fn_tmpPasswd();return false;"><spring:message code="click.tmeporary.password.issuance"/></button>
										<p><input type="checkbox" id="appDownChk" name="appDownChk" value="Y"> <spring:message code="click.send.app.download.url"/></p>
									</td>
								</tr>
							</tbody>
							</table>
						</div>
					</form:form>
					<div class="center mt10">
						<button type="button" class="btn btn-blue btn-type2 mr10" onclick="javascript:fn_accountModiy();return false;"><spring:message code="click.edit"/></button>
						<c:if test="${ sessionVO.grade_id != '4' && sessionVO.grade_id != '5' }">
							<c:if test="${parameterVO.account_hpms_yn != 'Y'}">
							<button type="button" class="btn btn-red btn-type2 mr10" onclick="javascript:fn_delete();return false;"><spring:message code="click.delete.button"/></button>
							</c:if>
						</c:if>
						<button type="button" class="btn btn-main btn-gray-main btn-type2" onclick="javascript:fn_accountList();return false;"><spring:message code="click.cancel"/></button>
					</div>

				</div>
			</div><!--본문 영역 끝-->

