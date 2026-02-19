<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title><spring:message code="click.administrator.login" /></title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	var resultType = 0;
	var loginTmpPwdCnt = 1;
	$(document).ready(function() {
		sessionStorage.setItem("nowUrl", "");
		var message = '${alertMessage}';
		if (message != null && message != '') {
			openDefaultPopup("loginPopup", message);
		}
		$('#description').attr('maxlength', 32);
	});

	function fn_download32() {
		location.href = "${pageContext.request.contextPath}/resources/exe/Ioneuron_Setup_2020_0604_1st_v10_x86.exe";
	}

	function fn_download64() {
		location.href = "${pageContext.request.contextPath}/resources/exe/Ioneuron_Setup_2020_0604_1st_v10.exe";
	}

	function fn_actionLoginAgreementPopup() {
		openLoginAgreementPopup();
	}

	function fn_actionLogin(code) {
		if (loginTmpPwdCnt > 2) {
			openDefaultPopup("loginPopup",
					'<spring:message code="click.two.retries.reconnect" />');
			return false;
		}
		if (!$('input[name="account_id"]').val()
				|| !$('input[name="account_pwd"]').val()) {
			openDefaultPopup("loginPopup",
					'<spring:message code="click.check.id.password.again" />');
			return false;
		}
		if (code == "retry") {
			loginTmpPwdCnt = loginTmpPwdCnt + 1;
		}
		var params = $("form[name=parameterVO]").serialize();
		$
				.ajax({
					url : "${pageContext.request.contextPath}/login/checkLogin.json",
					type : "POST",
					data : params,
					success : function(result) {
						if (result.resultCode == "success") {

							// session 체크
							var params = $("form[name=parameterVO]")
									.serialize();
							$
									.ajax({
										url : "${pageContext.request.contextPath}/login/checkLoginSession.json",
										type : "POST",
										data : params,
										success : function(result) {
											if (result.checkSession == "success") {
												//MAP S/W설치 여부 및 버전 체크 
												start_version_localserver(fn_mapSwVerCheck);
											} else if (result.checkSession == "dup_login") {
												var msg = '<spring:message code="click.using.same.account1"/> <spring:message code="click.using.same.account2"/>';
												openConfirmPopup2(
														msg,
														'<spring:message code="click.confirm"/>',
														"fn_closeSession",
														"fn_loginCancel");
											}
										}
									});

							// 인증번호 메세지
							/*
							var phone1 = result.accountPhone.substring(0, (result.accountPhone.length-4)).substring(0,3);
							var phone2 = result.accountPhone.substring(0, (result.accountPhone.length-4)).substring(3,7);
							var msg = "해당 계정에 등록된 휴대폰번호(" + phone1 + "-" + phone2 + "-" + "XXXX)로<br/>SMS 인증번호를 발송 하였습니다.";
							openDefaultPopup("loginPopup", msg);
							$("#confirm_num").val(result.confirmNum);
							 */
						} else if (result.resultCode == "pwdMonthChk_fail") {
							// 패스워드 3개월 초과 안내메세지
							//openDefaultPopup("loginPopup", result.message);
							//openDefaultPopup("passwrdResetPopup","");
							openDefaultPopup("loginPasswdThreeMonth", "");
						} else if (result.resultCode == "fail") {
							openDefaultPopup("loginPopup", result.message);
						} else if (result.resultCode == "firstLoginFail") {
							$("#account_pwd").val("");
							openDefaultPopup("passwrdResetPopup", params);
						} else if (result.resultCode == "pwdFail") {
							// 비밀번호 입력 오류
							$('#pwdErrorCount').val(result.pwdErrorCount);
							$('#pwdErrorTotal').val(5 - result.pwdErrorCount);
							openDefaultPopup("passwrdErrorPopup", "");
						} else if (result.resultCode == "pwdFatalFail") {
							// 비밀번호 5회 오류 
							openDefaultPopup("loginPopup",
									'<spring:message code="click.password.error.5times.reissuance"/>');
						}
					}
				});
	}

	/*
	 *	인증번호 입력 후 엔터키 이벤트
	 */
	function fn_pressConfirmNum(obj) {
		if (event.keyCode == "13") {
			event.stopPropagation();
			event.preventDefault();
			fn_confirmNum();
		}
	}

	function fn_confirmNum() {
		var params = $("form[name=parameterVO]").serialize();
		$
				.ajax({
					url : "${pageContext.request.contextPath}/login/actionLogin.json",
					type : "POST",
					data : params,
					success : function(result) {
						if (result.resultCode == "success") {
							// 시스템관리자 & 협력업체관리 & 사용자의 경우 메인화면으로 이동						
							$('#cooperator_id').val(result.cooperatorId);
							if (result.gradeId == "2" || result.gradeId == "3") {
								openDefaultPopup("loginSitePopup", "");
							} else {
								location.href = "${pageContext.request.contextPath}/main.do?lang="
										+ $('#lang').val();
							}
						} else if (result.resultCode == "pwdMonthChk_success") {
							location.href = "${pageContext.request.contextPath}/main.do?lang="
									+ $('#lang').val();
						} else if (result.resultCode == "fail") {
							openDefaultPopup("loginPopup", result.message);
						}
					}
				});
	}

	function fn_checkDupSession() {

		// session 체크
		var params = $("form[name=parameterVO]").serialize();
		$
				.ajax({
					url : "${pageContext.request.contextPath}/login/checkLoginSession.json",
					type : "POST",
					data : params,
					success : function(result) {
						if (result.checkSession == "success") {
							// Login 처리
							fn_login();
						} else if (result.checkSession == "dup_login") {
							openConfirmPopup2(
									'<spring:message code="click.using.same.account1"/><br/><spring:message code="click.using.same.account2"/>',
									'<spring:message code="click.confirm"/>',
									"fn_login", "fn_loginCancel");
						}
					}
				});

	}

	function fn_verChkAndSendSMS(version) {
		fn_closePopup();
		var params = $("form[name=parameterVO]").serialize();
		if (isEmpty(params))
			params += "version=" + version;
		else
			params += "&version=" + version;

		$
				.ajax({
					url : "${pageContext.request.contextPath}/login/verChkAndSendSMS.json",
					type : "POST",
					data : params,
					success : function(result) {
						if (result.resultCode == "success") {

							//var phone1 = result.accountPhone.substring(0, (result.accountPhone.length-4)).substring(0,3);
							//var phone2 = result.accountPhone.substring(0, (result.accountPhone.length-4)).substring(3,7);
							var msg = '<spring:message code="click.sms.authentication.number.sent" arguments="' + result.accountPhone1 + ',' + result.accountPhone2 + '"/>';
							openDefaultPopup("loginPopup", msg);

							$('#confirm_num').attr('disabled', false);
							$('#confirm_num')
									.attr('placeholder',
											'<spring:message code="click.enter.certification.number"/>');
							$('#confirm_btn').attr('disabled', false);
							$('#confirm_num').removeClass('graytBg readonly');
							$('#confirm_btn').removeClass('graytBg dimBtn');
							//$("#confirm_num").val(result.confirmNum);

							$('#confirm_num').focus();

						} else if (result.resultCode == "fail") {
							openDefaultPopup("loginPopup", result.message);
						} else if (result.resultCode == 'failVer') {
							openConfirmPopup2(
									'<spring:message code="click.sw.want.install"/>',
									'<spring:message code="click.confirm"/>',
									"fn_sw_install", "fn_sw_install_cancel");
						}
					}
				});
	}

	function fn_idfind() {
		openDefaultPopup("idfindPopup", "");
	}

	function fn_reissue() {
		openDefaultPopup("reissuePopup", "");
		//openDefaultPopup("passwrdResetPopup", "");
	}

	function fn_passwdReset() {
		openDefaultPopup("passwrdResetPopup", "");
	}

	//소프트웨어 설치 관련 Functions 
	function fn_mapSwVerCheck(version) {
		// console.log(version);
		fn_verChkAndSendSMS(version);
	}

	function fn_sw_install() {
		location.href = "${pageContext.request.contextPath}/resources/exe/Ioneuron_Setup_2020_0604_1st_v10.exe";
		fn_closePopup();
	}

	function fn_sw_install_cancel() {
		location.href = "${pageContext.request.contextPath}/login";
		fn_closePopup();
	}

	/*
	 * name : fn_insertReissue
	 * DESC : 비밀번호 재발급 팝업의 재발급 신청
	 */
	function fn_insertReissue() {
		if (!$('#chack_account_id').val()) {
			$('.err_message').html(
					'<spring:message code="click.enter.id.correctly"/>');
			$('.err_message').show();
			return false;
		}
		if (!$('#description').val()) {
			$('.err_message')
					.html(
							'<spring:message code="click.mandatory.required.fields.apply"/>');
			$('.err_message').show();
			return false;
		}
		if (!$('#check_account_confirmNum').val()) {
			$('.err_message').html(
					'<spring:message code="click.no.certification.number"/>');
			$('.err_message').show();
			return false;
		}
		var params = $("form[name=popupVO]").serialize();
		$
				.ajax({
					url : "${pageContext.request.contextPath}/login/insertReissue.json",
					type : "POST",
					data : params,
					success : function(result) {
						if (result.resultCode == "success") {
							fn_closePopup();
							openDefaultPopup("loginPopup", result.message);
						} else if (result.resultCode == "confirm_fail") {
							$('.err_message')
									.html(
											'<spring:message code="click.authentication.number.wrong"/>');
							$('.err_message').show();
							return false;
						} else if (result.resultCode == "fail") {
							openDefaultPopup("loginPopup", result.message);
						}
					}
				});
	}

	/*
	 * name : fn_tmpNum
	 * DESC : 비밀번호 재발급 팝업의 인증번호 요청
	 */
	var confirmCnt = 0;
	function fn_tmpPwdReissueNum(retry) {
		if (retry == "Y") {
			confirmCnt++;
		}
		if (!$('#chack_account_id').val()) {
			$('.err_message').html(
					'<spring:message code="click.enter.id.correctly"/>');
			$('.err_message').show();
			return false;
		}
		if ($('#chack_account_test').val() == "Y" && retry == "N") {
			$('.err_message').html(
					'<spring:message code="click.click.retry.receive"/>');
			$('.err_message').show();
			return false;
		}
		if (confirmCnt > 2 && retry == "Y") {
			$('.err_message').html(
					'<spring:message code="click.two.retries.reconnect"/>');
			$('.err_message').show();
			return false;
		}
		var params = $("form[name=popupVO]").serialize();
		$
				.ajax({
					url : "${pageContext.request.contextPath}/login/reissueTmpNum.json",
					type : "POST",
					data : params,
					success : function(result) {
						if (result.resultCode == "success") {
							$('#chack_account_test').val('Y');
							var phone1 = result.resultVO.account_phone
									.substring(
											0,
											(result.resultVO.account_phone.length - 4))
									.substring(0, 3);
							var phone2 = result.resultVO.account_phone
									.substring(
											0,
											(result.resultVO.account_phone.length - 4))
									.substring(3, 7);
							var msg = '<spring:message code="click.sms.authentication.number.sent" arguments="' + phone1 + ',' + phone2 + '"/>';

							$('.err_message').html(msg);
							$('.err_message').show();
						} else if (result.resultCode == "id_fail") {
							$('.err_message')
									.html(
											'<spring:message code="click.id.not.administrator.unavailable"/>');
							$('.err_message').show();
						}
					}
				});
	}

	/*
	 *	Name : fn_validPwd
	 *	Desc : 비밀번호 정책 체크
	 *	return : boolean
	 */
	function fn_validPwd(curPwd, newPwd, chkPwd) {

		var bResult = true;
		var errorMsg = "";
		var numPattern1 = /[0-9]/;
		var EngPattern2 = /[a-zA-Z]/;
		//var spPattern3 = /[.~!@\#$%<>^&*]/;
		var spPattern3 = (/[!@#$%^&*()_+\-=\[\]{};"':""\\|,.<>\/?]/g);

		if (!curPwd) {
			errorMsg = '<spring:message code="click.enter.current.password"/>';
			$('.id-key').html(errorMsg);
			bResult = false;
			return false;
		}
		if (!newPwd || !chkPwd) {
			errorMsg = '<spring:message code="click.enter.new.password"/>';
			bResult = false;
			$('.id-key').html(errorMsg);
			return false;
		}
		if (newPwd.length<8 || newPwd.length>255) {
			errorMsg = '<spring:message code="click.new.password.not.8digits"/>';
			$('.id-key').html(errorMsg);
			bResult = false;
			return false;
		}
		if (curPwd == newPwd || curPwd == chkPwd) {
			errorMsg = '<spring:message code="click.enter.different.password"/>';
			$('.id-key').html(errorMsg);
			bResult = false;
			return false;
		}
		if (newPwd != chkPwd) {
			errorMsg = '<spring:message code="click.new.password.try.again"/>';
			$('.id-key').html(errorMsg);
			bResult = false;
			return false;
		}

		/* if(!numPattern1.test(newPwd)||!EngPattern2.test(newPwd)|| !spPattern3.test(newPwd) || !fn_checkSpecialChar(newdPwd, 3)){ */
		if (!numPattern1.test(newPwd) || !EngPattern2.test(newPwd)
				|| !spPattern3.test(newPwd)) {
			errorMsg = '<spring:message code="click.password.8digits.3mixed"/>';
			$('.id-key').html(errorMsg);
			bResult = false;
			return false;
		}
		$('.id-key').html(errorMsg);
		return bResult;
	}

	/*
	 *	name : fn_checkPasswd
	 *	desc : 최초 로그인 / 임시비밀번호 발급 팝업에서 확인버튼 클릭
	 */
	function fn_checkPasswd() {
		if (fn_validPwd($('#tmp_pwd').val(), $('#new_pwd').val(), $(
				'#newChk_pwd').val())) {
			$('#account_newPwd').val($('#new_pwd').val());
			var params = $("form[name=parameterVO]").serialize();
			$
					.ajax({
						url : "${pageContext.request.contextPath}/login/updatePwd.json",
						type : "POST",
						data : params,
						success : function(result) {
							if (result.resultCode == "success") {
								openDefaultPopup("loginPopup",
										'<spring:message code="click.password.changed"/>');
								//location.href = "${pageContext.request.contextPath}/main.do";
								//location.href = "${pageContext.request.contextPath}/login";

								fn_closePopup();
							} else if (result.resultCode == "fail") {
								$('.id-key')
										.html(
												'<spring:message code="click.entered.wrong.password"/>');
							}
						}
					});
		}
	}

	function fn_login() {
		// Login 처리
		var params = $("form[name=parameterVO]").serialize();
		$
				.ajax({
					url : "${pageContext.request.contextPath}/login/actionLogin.json",
					type : "POST",
					data : params,
					success : function(result) {
						if (result.resultCode == "success") {
							location.href = "${pageContext.request.contextPath}/main.do?lang="
									+ $('#lang').val();
						} else if (result.resultCode == "pwdMonthChk_success") {
							location.href = "${pageContext.request.contextPath}/main.do?lang="
									+ $('#lang').val();
						} else if (result.resultCode == "fail") {
							openDefaultPopup("loginPopup", result.message);
						}
					}
				});
	}

	function fn_loginCancel() {
		fn_closePopup();
	}

	function fn_closeSession() {
		var params = $("form[name=parameterVO]").serialize();
		$
				.ajax({
					url : "${pageContext.request.contextPath}/login/closeSession.json",
					type : "POST",
					data : params,
					success : function(result) {
						fn_closePopup();
						if (result.resultCode == "success") {
							//MAP S/W설치 여부 및 버전 체크 
							start_version_localserver(fn_mapSwVerCheck);
						} else {
							openDefaultPopup("loginPopup",
									'<spring:message code="click.system.error.contact.administrator"/>');
						}
					}
				});
	}

	function changeLocale(localLang) {
		$('#locale').val(localLang);
		$('#lang').val(localLang);

		setLocalStorage("locale", localLang);

		location.href = "/click/login?lang=" + localLang;
	}
</script>
</head>
<body>
	<div id="wrap" class="page-login">
		<div class="alert-pop-wrap" id="alertPopupWrap" style="display: none;">
			<!--태그현황 팝업-->

		</div>
		<div class="pop-wrap" id="popupWrap" style="display: none;">
			<!--아이디/패스워드 입력란 공백 상태 로그인 시 -->

			<!--계정정보가 존재하지 않거나 틀릴 시 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<span><spring:message code="click.id.password.not.match" /></span>
				</dd>
				<button type="button" class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--재발급신청 상태의 계정 로그인시  -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<span><spring:message code="click.account.waiting.approval" /></span>
				</dd>
				<button type="button" class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--사용가능한 계정이나, 사업장이 없는 경우
			<dl class="pop-style01" style="display: none;">
				<dt><spring:message code='click.message'/></dt>
				<dd>
					<span><spring:message code="click.use.registering.business.site"/></span>
				</dd>
				<button class="closeBtn"><spring:message code="click.confirm"/></button>
			</dl>
			-->
			<!--패스워드 오류횟수 안내 문구
			<dl class="pop-style01" style="display: none;">
				<dt><spring:message code='click.message'/></dt>
				<dd>
					<span><spring:message code="click.confirm.password.again"/></span>
					<p><spring:message code='click.password.error.x.times1'/> <span class="num">3</span><spring:message code='click.password.error.x.times2'/></p>
					<p><spring:message code='click.remaining.times'/> <span class="num">3</span>회</p>
				</dd>
				<button class="closeBtn"><spring:message code="click.confirm"/></button>
			</dl>
			-->
			<!--패스워드 오류 5회 발생시-->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<p>
						<spring:message code="click.password.error.occurred.5times" />
					</p>
					<p>
						<spring:message code="click.contact.administrator" />
					</p>
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--패스워드 3개월 초과시 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<p>
						<spring:message code="click.password.change.setting.3months" />
					</p>
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--인증번호가 틀릴 경우  -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<p>
						<spring:message code="click.authentication.number.wrong" />
					</p>
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--SMS 인증번호를 발송 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<spring:message code='click.sent.sms.authentication.1111' />
					</p>
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--다 현장 계정 보유자 현장선택 팝업 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code='click.site.selection' />
				</dt>
				<dd class="listBtn">
					<ul>
						<li><spring:message code="click.site.name01" /></li>
						<li><spring:message code="click.site.name02" /></li>
						<li><spring:message code="click.site.name03" /></li>
					</ul>
				</dd>
			</dl>
			<!--아이디찾기 팝업 -->
			<!--패스워드 재발급 신청 팝업 -->
			<!--SMS 인증번호를 발송하였습니다 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<spring:message code='click.sent.sms.authentication.9172' />
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--재발급신청이 완료되었습니다 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<p>
						<spring:message
							code="click.temporary.password.approval.administrator" />
					</p>
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--아이디를 정상적으로 입력하지 않을 시 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<p>
						<spring:message code="click.enter.id.correctly" />
					</p>
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--인증번호 전송 시  -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<spring:message code="click.id.not.administrator.unavailable" />
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--인증번호 입력 오류 시  -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<spring:message code="click.authentication.number.wrong" />
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--인증번호 전송 후 버튼 재클릭시   -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<spring:message code="click.must.click.retry.receive" />
				</dd>
				<button class="closeBtn">
					<spring:message code="click.retry" />
				</button>
			</dl>
			<!--다른 PC에서 동일 계정으로 사용중입니다 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<p>
						<spring:message code="click.using.same.account1" />
					</p>
					<p>
						<spring:message code="click.using.same.account2" />
					</p>
				</dd>
				<button class="re-applyBtn">
					<spring:message code="click.confirm" />
				</button>
				<button class="cancelBtn">
					<spring:message code="click.cancel" />
				</button>
			</dl>
			<!--로그인 중인 PC의 팝업 Alert 문구 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<p>
						<spring:message code="click.using.same.account1" />
					</p>
					<p>
						<spring:message code="click.logged.in" />
					</p>
					<p>
						<spring:message code="click.forcibly.logged.out2" />
					</p>
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
			<!--비밀번호 재설정 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.password.reset" />
				</dt>
				<dd class="pw-reWrite">
					<spring:message code="click.change.your.password.first.access" />
					<input type="text"
						placeholder='<spring:message code="click.current.password"/>'>
					<input type="text"
						placeholder='<spring:message code="click.new.password"/>'>
					<input type="text"
						placeholder='<spring:message code="click.new.password.check"/>'>
					<p class="id-key">
						<spring:message code="click.input.error.notation.area" />
					</p>
				</dd>
				<button class="re-applyBtn">
					<spring:message code="click.confirm" />
				</button>
				<button class="cancelBtn">
					<spring:message code="click.cancel" />
				</button>
			</dl>
			<!--네트워크 환경 Alert 문구 -->
			<dl class="pop-style01" style="display: none;">
				<dt>
					<spring:message code="click.message" />
				</dt>
				<dd>
					<spring:message code="click.network.environment.bad" />
				</dd>
				<button class="closeBtn">
					<spring:message code="click.confirm" />
				</button>
			</dl>
		</div>
		<!--팝업 끝-->
		<div class="container">
			<div class="inner-wrap" style="height: 920px;">
				<h1 class="logo">click</h1>
				<h2>
					<spring:message code="click.sgsone.safety.control.system" />
				</h2>
				<!--한글 영문 토글스위치-->
				<div class="switch-field-big">
					<input type="radio"
						<c:if test="${locale eq 'ko_kr' || locale eq 'ko_KR'}">class="on"</c:if>
						<c:if test="${locale ne 'ko_kr'}">class="off"</c:if>
						id="radio-one" name="switch-one" value="ON"
						onclick="changeLocale('ko_kr')"
						<c:if test="${locale eq 'ko_kr' || locale eq 'ko_KR'}">checked="checked"</c:if>>

					<label for="radio-one">KOR</label> <input type="radio"
						<c:if test="${locale eq 'en'}">class="on"</c:if>
						<c:if test="${locale ne 'en'}">class="off"</c:if> id="radio-two"
						name="switch-one" value="OFF" onclick="changeLocale('en')"
						<c:if test="${locale eq 'en'}">checked="checked"</c:if>> <label
						for="radio-two">EN</label>

				</div>
				<!--한글 영문 토글스위치 끝-->
				<!--로그인 박스영역 시작-->
				<div class="login-box">
					<form:form id="parameterVO" name="parameterVO" commandName="parameterVO" method="post">
						<input type="hidden" id="pwdErrorCount" name="pwdErrorCount"
							value="">
						<input type="hidden" id="pwdErrorTotal" name="pwdErrorTotal"
							value="">
						<input type="hidden" id="company_id" name="company_id" value="">
						<input type="hidden" id="site_name" name="site_name" value="">
						<input type="hidden" id="systemAdminYn" name="systemAdminYn"
							value="">
						<input type="hidden" id="loginPageYn" name="loginPageYn" value="N">
						<input type="hidden" id="cooperator_id" name="cooperator_id"
							value="">
						<input type="hidden" id="locale" name="locale" value="${locale}">
						<input type="hidden" id="lang" name="lang" value="${locale}">
						<input type="hidden" id="menu_type" name="menu_type" value="">

						<!-- <input type="hidden" id="menuId" name="menuId" value=""> -->
						<fieldset class="login-form">
							<legend class="hidden">
								<spring:message code="click.administrator.login" />
							</legend>
							<input type="hidden" id="account_newPwd" name="account_newPwd"
								value="">
							<div class="id-wrap">
								<div class="icon">
									<img
										src="${pageContext.request.contextPath}/resources/img/login_id_icon.png"
										alt="<spring:message code="click.id.input.image"/>">
								</div>
								<input type="text" class="input"
									placeholder='<spring:message code="click.id"/>'
									name="account_id">
							</div>
							<div class="pw-wrap">
								<div class="icon">
									<img
										src="${pageContext.request.contextPath}/resources/img/login_pw_icon.png"
										alt="<spring:message code="click.password.input.image"/>">
								</div>
								<input type="password" class="input"
									placeholder='<spring:message code="click.password"/>'
									id="account_pwd" name="account_pwd">
							</div>
							<button class="login-btn"
								onclick="javascript:fn_actionLoginAgreementPopup();return false;">
								<spring:message code="click.log.in" />
							</button>
							<div class="login-util">
								<a href="#" id="find_id"
									onclick="javascript:fn_idfind();return false;"><spring:message
										code="click.find.id" /></a> <i class="div_line01"></i> <a href="#"
									id="apply_pw" onclick="javascript:fn_reissue();return false;"><spring:message
										code="click.apply.password.reissuance" /></a>
							</div>
							<div class="find-pw-input">
								<!-- <input id="confirm_num" type="text" name="confirm_num" value="" placeholder='<spring:message code="click.enter.certification.number"/>' disabled> -->
								<input id="confirm_num" class="graytBg readonly" type="text"
									name="confirm_num" value=""
									onkeydown="javascript:fn_pressConfirmNum(this);"
									placeholder="<spring:message code='click.After.loggingin.authenticate'/>" disabled>
								<button id="confirm_btn" class="graytBg dimBtn"
									onclick="javascript:fn_confirmNum();return false;">
									<spring:message code="click.certification.request" />
								</button>
							</div>
							<!--휴대폰 인증번호 입력항목  기본값 : 비활성화-->
							<div class="find-pw-input-dim" style="display: none;">
								<input type="text"
									placeholder="<spring:message code='click.After.loggingin.authenticate'/>">
								<button>
									<spring:message code="click.certification.request" />
								</button>
							</div>
						</fieldset>
					</form:form>

					<%-- <p class="desc-info">* <a href="javascript:fn_actionLogin('retry');"><spring:message code='click.not.receive.1minute.try.again'/></a> </p> --%>
					<p class="desc-info">
						*
						<spring:message code='click.not.receive.1minute.try.again' />
					</p>

					<ul class="login-info-box">
						<li><spring:message code="click.use.system.after.logging" /></li>
						<li><spring:message
								code="click.id.password.must.case.sensitive" /></li>
						<li><spring:message code="click.optimized.ie11.chrome" /></li>
						<li><spring:message
								code="click.map.viewer.installed.automatically" /></li>
						<li class="system-download-wrap">
							<%-- <button><a href="${pageContext.request.contextPath}/resources/exe/Ioneuron_Setup_2020_0604_1st_v10_x86.exe"><spring:message code='click.for.32bit'/></a><i class="fa fa-download"></i></button>
							<button><a href="${pageContext.request.contextPath}/resources/exe/Ioneuron_Setup_2020_0604_1st_v10.exe"><spring:message code='click.for.64bit'/></a><i class="fa fa-download"></i></button> --%>
							<button onclick="javascript:fn_download32();return false;">
								<a href="#" onclick="javascript:fn_download32();return false;"><spring:message
										code='click.for.32bit' /></a><i class="fa fa-download"></i>
							</button>
							<button onclick="javascript:fn_download64();return false;">
								<a href="#" onclick="javascript:fn_download64();return false;"><spring:message
										code='click.for.64bit' /></a><i class="fa fa-download"></i>
							</button>
						</li>
					</ul>
				</div>
				<!--로그인 박스영역 끝-->
			</div>
		</div>
		<footer id="footer" style="position: fixed; bottom: 0;">
			<div class="container">
				<div class="copyright">
					Copyright 2020 <span>sgsone AUTOEVER CORP.</span> All Rights
					Reserved.
				</div>
			</div>
		</footer>

	</div>

	<form:form id="popupVO2" commandName="popupVO" name="popupVO"
		method="post">
		<input type="hidden" id="popupType" name="popupType" value="" />
		<input type="hidden" id="pop_cooperator_id" name="pop_cooperator_id"
			value="" />
		<input type="hidden" id="pop_code_id" name="pop_code_id" value="" />
		<input type="hidden" id="pop_code_type_id" name="pop_code_type_id"
			value="" />
		<input type="hidden" id="pop_code_name" name="pop_code_name" value="" />
		<input type="hidden" id="pop_code_name_eng" name="pop_code_name_eng"
			value="" />
		<input type="hidden" id="pop_action_type" name="pop_action_type"
			value="" />
		<input type="hidden" id="pop_reserved1" name="pop_reserved1" value="" />
		<input type="hidden" id="pop_reserved2" name="pop_reserved2" value="" />
		<input type="hidden" id="pop_reserved3" name="pop_reserved3" value="" />
		<input type="hidden" id="pop_company_id" name="company_id" value="" />
		<input type="hidden" id="pop_msg" name="pop_msg" value="" />
		<input type="hidden" id="pop_callback_txt" name="pop_callback_txt"
			value="" />
		<input type="hidden" id="pop_callback" name="pop_callback" value="" />
		<input type="hidden" id="pop_callback2" name="pop_callback2" value="" />
	</form:form>

</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/storageUtil.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/localserverController.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/util.js"></script>

</html>
