<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<script type="text/javascript">
	
	$(function(){
	})
	
	// 탭변경 이벤트
	function fn_changeTab(index){
		var params = $("form[id=parameterVO]").serialize(); 
		$.ajax({
			url : "${pageContext.request.contextPath}/mypage" + index + ".do",
			type : "POST",
			data: params,
			success : function(result) {
				$(".con-wrap").html(result)
			}
		});
	}
	
	/*
	*	Name : fn_validPwd
	*	Desc : 비밀번호 정책 체크
	*	return : boolean
	*/
	var pwdChk1 = false;
	function fn_validPwd1(obj){
		
        var numPattern1 = /[0-9]/;
        var EngPattern2 = /[a-zA-Z]/;
        var spPattern3 = (/[!@#$%^&*()_+\-=\[\]{};"':""\\|,.<>\/?]/g);
        var pwdVal = obj.value;
		
		if(!pwdVal ){
			$('.usedPwd1').hide();
			$('.pwdDuplicate').hide();
			$('.notUsedPwd1').show();
			pwdChk1 = false;
		}else if( pwdVal.length < 8 ){
			$('.usedPwd1').hide();
			$('.pwdDuplicate').hide();
			$('.notUsedPwd1').show();
			pwdChk1 = false;
		} else if(!numPattern1.test(pwdVal)||!EngPattern2.test(pwdVal)|| !spPattern3.test(pwdVal) ){
			$('.usedPwd1').hide();
			$('.pwdDuplicate').hide();
			$('.notUsedPwd1').show();
			pwdChk1 = false;
		}else{
			fn_oldPasswdChk();
		}
	}
	
	/*
	*	기존 비밀번호 체크
	*/
	function fn_oldPasswdChk(){
		$('#account_newPwd').val($('#newPassword').val());
		var params = $("form[id=parameterVO]").serialize(); 
		$.ajax({
			url : "${pageContext.request.contextPath}/mypagePasswdChk.json",
			type : "POST",
			data: params,
			success : function(result) {
				if( result.resultCode == "success"){
					$('.notUsedPwd1').hide();
					$('.pwdDuplicate').hide();
					$('.usedPwd1').show();
					pwdChk1 = true;
				}else{
					$('.usedPwd1').hide();
					$('.notUsedPwd1').hide();
					$('.pwdDuplicate').show();
					pwdChk1 = false;
				}
			}
		});
	}
	
	/*
	*	Name : fn_validPwd
	*	Desc : 비밀번호 정책 체크
	*	return : boolean
	*/
	var pwdChk2 = false;
	function fn_validPwd2(obj){
		
        var numPattern1 = /[0-9]/;
        var EngPattern2 = /[a-zA-Z]/;
        var spPattern3 = (/[!@#$%^&*()_+\-=\[\]{};"':""\\|,.<>\/?]/g);
        var pwdVal = obj.value;
		
		if(!pwdVal ){
			$('.usedPwd2').hide();
			$('.notUsedPwd2').show();
			$('.inconsistencyPwd').hide();
			pwdChk2 = false;
		}else if( pwdVal.length < 8 ){
			$('.usedPwd2').hide();
			$('.notUsedPwd2').show();
			$('.inconsistencyPwd').hide();
			pwdChk2 = false;
		} else if(!numPattern1.test(pwdVal)||!EngPattern2.test(pwdVal)|| !spPattern3.test(pwdVal) ){
			$('.usedPwd2').hide();
			$('.notUsedPwd2').show();
			$('.inconsistencyPwd').hide();
			pwdChk2 = false;
		} else if( pwdVal != $('#newPassword').val() ){
			$('.usedPwd2').hide();
			$('.notUsedPwd2').hide();
			$('.inconsistencyPwd').show();
			pwdChk2 = false;
		} else{
			$('.inconsistencyPwd').hide();
			$('.notUsedPwd2').hide();
			$('.usedPwd2').show();
			pwdChk2 = true;
		}
	}
	
	// 마이페이지 정보 업데이트
	function fn_accountInfoUpdate(){
		
		$('#account_newPwd').val($('#newPassword').val());
		
		// 성명
		if(!$('#account_name').val()){
			openDefaultPopup("loginPopup",'<spring:message code="click.please.required.fields"/>');
			return false;
		}
		
		var testId = "";
		if("${sessionVO.grade_id}" == "1"){
			// 시스템관리자
			testId = $("#cooperator_id option:selected").val();
		}else{
			// 그외
			testId = $("#sch_code option:selected").val();
		}
		
		if(!testId){
			openDefaultPopup("loginPopup",'<spring:message code="click.please.required.fields"/>');
			return false;
		}

		// 비밀번호
		if( !$('#newPassword').val() && !$('#newChkPassword').val() ){
			pwdChk1 = true;
			pwdChk2 = true;
		}
		
		// 전화번호
		if( !$('#account_phone1').val() && !$('#account_phone1').val() ){
			openDefaultPopup("loginPopup",'<spring:message code="click.please.required.fields"/>');
			return false;
		}
		if( !$('#account_phone2').val() && !$('#account_phone2').val() ){
			openDefaultPopup("loginPopup",'<spring:message code="click.please.required.fields"/>');
			return false;
		}
		if( !$('#account_phone3').val() && !$('#account_phone3').val() ){
			openDefaultPopup("loginPopup",'<spring:message code="click.please.required.fields"/>');
			return false;
		}
		
		if( !pwdChk1 || !pwdChk2 ){
			openDefaultPopup("loginPopup",'<spring:message code="click.please.required.fields"/>');
			return false;
		}else{
			$('#code').val(testId);
			var phone1 = $("#account_phone1").val();
			var phone2 = $("#account_phone2").val();
			var phone3 = $("#account_phone3").val();
			$("#account_phone").val(phone1+phone2+phone3);
			var params = $("form[name=parameterVO]").serialize(); 
			$.ajax({
				url : "${pageContext.request.contextPath}/updateMypage1.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						openDefaultPopup("loginPopup", '<spring:message code="click.been.edited"/>');
					}else if(result.resultCode == "fail"){
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
		}
	}
	
	</script>


	<form:form id="parameterVO" commandName="parameterVO" name="parameterVO" action="" method="post">
		<input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
		<input type="hidden" id="menuId" name="menuId" value="${parameterVO.menuId}"/>
		<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="${parameterVO.recordCountPerPage}"/>
		<input type="hidden" id="account_phone" name="account_phone" value=""/>
		<input type="hidden" id="code" name="code" value=""/>
		<input type="hidden" id="account_newPwd" name="account_newPwd" value=""/>
			<div class="page-navigation">
				<ul>
					<li><a href="#">Home</a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.my.page"/></a></li>
				</ul>
			</div>
			<div class="con-area">
				<ul class="sub-tab-style01">
					<li><a href="#" class="active"><spring:message code="click.personal.information.modification"/></a></li>
					<c:if test="${parameterVO.company_id != null && parameterVO.company_id != ''}">
						<li><a href="#" onClick="javascript:fn_changeTab('2');"><spring:message code="click.notification.settings"/></a></li>
					</c:if>
				</ul>
				<div class="content-box">
					<div class="table mt10 mb20 font14 no-hover">
						<table>
						<colgroup>
							<col width="15%">
							<col width="45%">
							<col width="15%">
							<col width="25%">
						</colgroup>
						<tbody>
							<tr>
								<th class="center">* <spring:message code="click.id"/></th>
								<td colspan="3">
									<span>
										<input id="sch_account_id" name="sch_account_id" type="text" class="graytBg" style="width: 300px;" placeholder="" disabled value="${sessionVO.account_id}">
										<input id="account_id" name="account_id" type="hidden" value="${sessionVO.account_id}">
									</span>
								</td>
							</tr>
							<tr>
								<th class="center">* <spring:message code="click.name"/></th>
								<td colspan="3">
									<%-- <span>${sessionVO.account_name}</span> --%>
									<c:if test="${ sessionVO.account_hpms_yn == 'Y' }">
										<input type="text" id="account_name" name="account_name" class="<c:if test="${sessionVO.account_hpms_yn == 'Y'}">graytBg</c:if>" style="width: 300px;" placeholder="" value="${sessionVO.account_name}" <c:if test="${sessionVO.account_hpms_yn == 'Y'}">disabled</c:if>>
										<input id="account_name" name="account_name" type="hidden" value="${sessionVO.account_name}">
									</c:if>
									<c:if test="${ sessionVO.account_hpms_yn != 'Y' }">
										<input type="text" id="account_name" name="account_name" style="width: 300px;" placeholder="" value="${sessionVO.account_name}">
									</c:if>
									
									<c:if test="${sessionVO.account_hpms_yn == 'Y'}">
										<i class="connect"><spring:message code="click.interlocking"/></i>
									</c:if>
								</td>
							</tr>
							<tr>
								<th class="center">* <spring:message code="click.company.name"/></th>
								<td>
									<%-- <span>${sessionVO.cooperator_name}</span> --%>
									<%-- <input type="text" class="<c:if test="${sessionVO.account_hpms_yn == 'Y'}">graytBg</c:if>" style="width: 300px;" placeholder="" value="${sessionVO.cooperator_name}" <c:if test="${sessionVO.account_hpms_yn == 'Y'}">disabled</c:if>> --%>
									<c:if test="${sessionVO.grade_id == '1'}">
										<select style="width: 300px;" name="cooperator_id" id="cooperator_id">
											<c:forEach var="cooperatorList" items="${cooperatorList}">
												<option <c:if test="${sessionVO.cooperator_id eq cooperatorList.cooperator_id}">selected</c:if> value="${cooperatorList.cooperator_id}">${cooperatorList.cooperator_name}</option>
											</c:forEach>
										</select>
									</c:if>
									<c:if test="${sessionVO.grade_id != '1'}">
										<c:if test="${sessionVO.grade_id == '2' || sessionVO.grade_id == '3'}">
											<c:if test="${ sessionVO.cooperator_name == '현대건설' }">
												<select style="width: 300px;" name="sch_code" id="sch_code" class="readonly" disabled>
													<option value=""><spring:message code="click.selection"/></option>
													<c:if test="${sessionVO.grade_id == '2' || sessionVO.grade_id == '3'}">
														<option value="${sessionVO.cooperator_id}" selected>${sessionVO.cooperator_name}</option>
													</c:if>
												</select>
											</c:if>
											<c:if test="${ sessionVO.cooperator_name != '현대건설' }">
												<select style="width: 300px;" name="sch_code" id="sch_code" <c:if test="${sessionVO.account_hpms_yn == 'Y'}">disabled class="readonly"</c:if>>
													<option value=""><spring:message code="click.selection"/></option>
													<c:forEach var="cooperatorList" items="${cooperatorList}">
														<option <c:if test="${sessionVO.cooperator_id eq cooperatorList.cooperator_id}">selected</c:if> value="${cooperatorList.cooperator_id}">${cooperatorList.cooperator_name}</option>
													</c:forEach>
												</select>
											</c:if>
										</c:if>
										<c:if test="${sessionVO.grade_id == '4' || sessionVO.grade_id == '5'}">
											<select style="width: 300px;" name="sch_code" id="sch_code" <c:if test="${sessionVO.account_hpms_yn == 'Y'}">disabled class="readonly"</c:if>>
												<option value=""><spring:message code="click.selection"/></option>
												<c:forEach var="commonCodeSiteList" items="${commonCodeSiteList}">
													<option value="${commonCodeSiteList.code}"<c:if test="${sessionVO.code == commonCodeSiteList.code}">selected</c:if> >${commonCodeSiteList.code_name}</option>
												</c:forEach>
											</select>
										</c:if>
									</c:if>
								</td>
								<th class="center"><spring:message code="click.business.item"/></th>
								<td>
									<c:if test="${empty sessionVO.business_type}">-</c:if>
									<c:if test="${!empty sessionVO.business_type}">${sessionVO.business_type}</c:if>
								</td>
							</tr>
							<tr>
								<th class="center">* <spring:message code="click.contact.information"/></th>
								<td>
									<%-- <c:set var="account_phone" value="${sessionVO.account_phone}"/> --%>
									<input type="text" id="account_phone1" name="account_phone1"  class="<c:if test="${sessionVO.account_hpms_yn == 'Y'}">graytBg</c:if>" style="width: 150px;" value="${fn:substring(sessionVO.account_phone,0,3)}" <c:if test="${sessionVO.account_hpms_yn == 'Y'}">disabled</c:if>>
									<input type="text" id="account_phone2" name="account_phone2"  class="<c:if test="${sessionVO.account_hpms_yn == 'Y'}">graytBg</c:if>" style="width: 150px;" value="${fn:substring(sessionVO.account_phone,3,7)}" <c:if test="${sessionVO.account_hpms_yn == 'Y'}">disabled</c:if>> 
									<input type="text" id="account_phone3" name="account_phone3"  class="<c:if test="${sessionVO.account_hpms_yn == 'Y'}">graytBg</c:if>" style="width: 150px;" value="${fn:substring(sessionVO.account_phone,7,11)}" <c:if test="${sessionVO.account_hpms_yn == 'Y'}">disabled</c:if>>
								</td>
								<th class="center"><spring:message code="click.whether.employed"/></th>
								<td>
									<c:if test="${sessionVO.hdecyn == null}">N</c:if>
									<c:if test="${sessionVO.hdecyn != null}">${sessionVO.hdecyn}</c:if>
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="click.change.password"/></th>
								<td colspan="3">
									<input id="newPassword" name="newPassword" type="password" style="width: 300px;" placeholder="<spring:message code='click.password.8digits.3mixed.placeholder'/>" onkeyup="javascript:fn_validPwd1(this);">
									<!--결과값 출력 선택해서 뿌려주세요-->
									<span class="red font14 ml10 notUsedPwd1" style="display:none;">※ <spring:message code="click.not.possible.delete.it"/></span>
									<span class="red font14 ml10 pwdDuplicate" style="display:none;">※ <spring:message code="click.password.same.again"/></span>
									<span class="blue font14 ml10 usedPwd1" style="display:none;">※ <spring:message code="click.can.be.used"/></span>
									<!--결과값 출력 끝-->
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="click.password.reenter"/></th>
								<td colspan="3">
									<input id="newChkPassword" name="newChkPassword" type="password" style="width: 300px;" placeholder='<spring:message code="click.password.reenter"/>' onkeyup="javascript:fn_validPwd2(this);">
									<!--결과값 출력 선택해서 뿌려주세요-->
									<span class="red font14 ml10 notUsedPwd2" style="display:none;">※ <spring:message code="click.not.possible.delete.it"/></span>
									<span class="blue font14 ml10 usedPwd2" style="display:none;">※ <spring:message code="click.can.be.used"/></span>
									<span class="red font14 ml10 inconsistencyPwd" style="display:none;">※ <spring:message code="click.not.match"/></span>
									<!--결과값 출력 끝-->
								</td>
							</tr>
							<c:if test="${parameterVO.company_id != null && parameterVO.company_id != ''}">
							<tr>
								<th class="center">* <spring:message code="click.event.sms.notification"/></th>
								<td colspan="3">
									<label for="sms_event_send_yn1"><input type="radio" name="sms_event_send_yn" id="sms_event_send_yn1" value="Y" <c:if test="${sessionVO.sms_event_send_yn == 'Y' }">checked</c:if>> <spring:message code="click.send"/></label>&nbsp;
									<label for="sms_event_send_yn2"><input type="radio" name="sms_event_send_yn" id="sms_event_send_yn2" value="N" <c:if test="${sessionVO.sms_event_send_yn == 'N' }">checked</c:if>> <spring:message code="click.not.sent"/></label>&nbsp;
									<span class="red font14 ml10">※ <spring:message code="click.receive.sms.event"/></span>
								</td>
							</tr>
							</c:if>
						</tbody>
						</table>
						<span class="mt10 font14 ml10" style="display: block;">※<spring:message code="click.id.register.again"/></span>
						<c:if test="${sessionVO.account_hpms_yn == 'Y'}">
							<span class="mt10 font14 ml10 hpmsMsg" style="display:block;">※ <spring:message code="click.modified.customer.system"/></span>
						</c:if>
					</div>
					<div class="center mt10 mb10">
						<button type="button" class="btn btn-blue btn-type2 mr10" onClick="javascript:fn_accountInfoUpdate();"><spring:message code="click.edit"/></button>
					</div>
				</div>
			</div><!--본문 영역 끝-->
		</form:form>	