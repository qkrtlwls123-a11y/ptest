<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>ONION BOX - 사이트 관리자</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
	<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/cctv.css">
	<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/setting.css">
	<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/tc-safe.css">
	<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/location.css">
	<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/tunnel.css">
	<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/dashboard.css">
	<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/envi-info.css">
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ui.js"></script>
	<script type="text/javascript">
		var docEle = document.documentElement;
		var checkNowUrl = sessionStorage.getItem("nowUrl");
		var checkDanger = "";
		
		function fn_danger(){
			openDefaultPopup("loginPopup", '<spring:message code="click.download.fever.contaclist"/>');
			
			
			//worker_id가 존재하는지 체크한다. 
			if($( "#worker_name" ).length) {
				workerName = $("#worker_name").val();
			}

			var params = $("form[id=workerParameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/selectDangerList.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						checkDanger = result.checkDanger;
					}
				}
			});
		}
		
		function fn_checkDangerList(){
			if(checkDanger == "T"){
				fn_closePopupThis();
				openConfirmPopup('<spring:message code="click.completed.fever.contaclist"/>', '<spring:message code="click.download"/>', "fn_downloadDanger");
				checkDanger = "";
			}
		}
		
		function fn_downloadDanger(){
			
			//worker_id가 존재하는지 체크한다. 
			workerName = encodeURI(encodeURIComponent(workerName));
			
			window.open("${pageContext.request.contextPath}/download/downloadDagerList.excel?worker_name=" + workerName , "EXCEL Download");
			fn_closePopup();
		}
		
		$(document).ready(function(){
			
			window.onbeforeunload = CleanPage;
		    window.unload         = CleanPage;
		    
		    if(checkNowUrl != ""){
		    	$.ajax({
					url : checkNowUrl,
					type : "POST",
					success : function(result) {
						sessionStorage.setItem("nowUrl", checkNowUrl);
						$(".con-wrap").html(result);
						fn_bindEnterAntion();
					}
				});
		    }else{
		    	$.ajax({
					url : "${pageContext.request.contextPath}/main3.do",
					type : "POST",
					success : function(result) {
						sessionStorage.setItem("nowUrl", "${pageContext.request.contextPath}/main3.do");
						$(".con-wrap").html(result);
						fn_bindEnterAntion();
					}
				});
		    }
		});
		
		function fn_logout(){
			sessionStorage.setItem("nowUrl", "");
			location.href = '${pageContext.request.contextPath}/logOut.do';
		}
		
		/* Onload 시 Byte 체크*/
		function fn_byteCheck(){
			$('.byteCheck').each(function(){
				var byteTxt = $(this).val();
				var byteNum=0;
				var index = $('.byteCheck').index(this);
				var resultObj = $('.byteResult').eq(index);
				for(i=0;i<byteTxt.length;i++){
					byteNum+=(byteTxt.charCodeAt(i)>127)?2:1;
				};
				var byteLength = Math.round(byteNum);
				$(resultObj).text(byteLength);
			});
			
			$('.byteCheck_pop').each(function(){
				var byteTxt = $(this).val();
				var byteNum=0;
				var index = $('.byteCheck_pop').index(this);
				var resultObj = $('.byteResult').eq(index);
				for(i=0;i<byteTxt.length;i++){
					byteNum+=(byteTxt.charCodeAt(i)>127)?2:1;
				};
				var byteLength = Math.round(byteNum);
				$(resultObj).text(byteLength);
			});
		}
		
		var nowPageUrl = "";
		
		$(document).keydown(function (e) {
			
			
			/* Byte 체크*/
			$('.byteCheck').on("propertychange change keyup paste",function(){
				var byteTxt = "";
				var byteMax = $(this).data('maxbyte');
				var index = $('.byteCheck').index(this);
				var resultObj = $('.byteResult').eq(index);
				var checkbyte = function(str){
					var byteNum=0;
					for(i=0;i<str.length;i++){
						byteNum+=(str.charCodeAt(i)>127)?2:1;
						if(byteNum<byteMax){
							byteTxt+=str.charAt(i);
						};
					};
					return Math.round( byteNum );
				};
				if(checkbyte($(this).val())>byteMax){
					if("${locale}" == "en"){
						openDefaultPopup("loginPopup" , ' <spring:message code="click.cannot.max.byte.msg"/> ' + byteMax);
					}else{
						openDefaultPopup("loginPopup" , byteMax + '<spring:message code="click.cannot.max.byte.msg"/>');
					}
					$(this).val("");
					$(this).val(byteTxt);
				}else{
					$(resultObj).text(checkbyte($(this).val()));
				}
			});
			
			/* Byte 체크 (popup용) */
			$('.byteCheck_pop').on("propertychange change keyup paste",function(){
				var byteTxt = "";
				var byteMax = $(this).data('maxbyte');
				var index = $('.byteCheck_pop').index(this);
				var resultObj = $('.byteResult').eq(index);
				var checkbyte = function(str){
					var byteNum=0;
					for(i=0;i<str.length;i++){
						byteNum+=(str.charCodeAt(i)>127)?2:1;
						if(byteNum<byteMax){
							byteTxt+=str.charAt(i);
						};
					};
					return Math.round( byteNum );
				};
				if(checkbyte($(this).val())>byteMax){
					var val_name = $(this).parents('td').prev('th').text().replace("*","");
					if("${locale}" == "en"){
						$('.byteResult_pop').text( val_name + ' <spring:message code="click.cannot.max.byte.msg"/> ' + byteMax );
					}else{
						$('.byteResult_pop').text( val_name + '<spring:message code="click.is"/> ' + byteMax + '<spring:message code="click.cannot.max.byte.msg"/>');
					}
					$('.byteResult_pop').show();
					$(this).val("");
					$(this).val(byteTxt);
				}else{
					$(resultObj).text(checkbyte($(this).val()));
				}
			});
		});
		
		//알람페이지를 공통으로 사용하기 위해 사용함.
		// fn_changePage를 호출하기전 호출하여 현재 진입하고자 하는 페이지를 명시한다.
		var menu_type = "";
		function fn_changeAlarmPage(idx, _menu_type) {
			menu_type = _menu_type;
					
			fn_changePage(idx);
		}
		
		//알람페이지에서 위치 정보를 클릭했을 경우 호출되는 Function
		var event_location = "";
		function fn_movePageForAlarm(idx, _event_location) {
			event_location = _event_location;

			$("#parameterVO").append('<input type="hidden" id="event_location" name="event_location" value="' + event_location + '""/>');

			fn_changePage(idx);
		}
		
		function fn_orderChangePage(idx){
			
			if(idx == 1){
				$("#menuId").val(idx);
				$.ajax({
					url : "${pageContext.request.contextPath}/tunnelMap.do",
					type : "POST",
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 2){
				$("#menuId").val(idx);
				$.ajax({
					url : "${pageContext.request.contextPath}/tc2.do",
					type : "POST",
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 3){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/siteList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 4){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/menu.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 5){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/deviceList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 6){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/codeList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 7){
				fn_clear();
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/siteList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 8){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/reissueList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 9){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/areaTypeList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 10){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/workerList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 11){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/adminList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 12){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/fareList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 13){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/baseCodeList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 14){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/mappingDeviceList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 15){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/gasList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 16){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/cooperatorList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 17){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/appDeviceList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 18){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/appDownloadList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 19){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/siteAreaList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 20){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/equip.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 21){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/locationMap.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 22){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/appMenuGradeSetting.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 211){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/locationWorkList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 212){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/locationEnterList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 213){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/locationMoveList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 214){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/locationGasList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 215){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/locationEmergencyList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 220){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/tunnelMap.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 221){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/processHistoryList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 222){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/tunnelHistoryList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 223){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/elevationRegi.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 224){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/sectionRegi.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 230){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/towerCraneMap.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 231){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/anemometerHistory.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 233){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/anemometerList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 99){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/mypage1.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 100){
				$("#menuId").val(idx);
				var params = $("form[name=siteVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/siteRegi1.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 101){
				$("#menuId").val(idx);
				var params = $("form[name=siteVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/siteRegi2.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 102){
				$("#menuId").val(idx);
				var params = $("form[name=siteVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/siteRegi3.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 103){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/siteRegi4.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 104){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/siteRegi5.do",
					type : "POST",
					data: params,
					success : function(result) {
						sessionStorage.setItem("nowUrl", "${pageContext.request.contextPath}/siteRegi5.do");$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 400 ){
				// 환경정보
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/sensorList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 411 ){
				// 환경정보
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/sensorHistoryList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 421 ){
				// 환경정보
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/sensorThresholdList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 422 ){
				// 환경정보
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/sensorImage.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 511 ){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/retainMap.do",
					type : "POST",
					data: params,
					success : function(result) {
						sessionStorage.setItem("nowUrl", "${pageContext.request.contextPath}/retainMap.do");
						$(".con-wrap").html(result);
						fn_bindEnterAntion();
					}
				});
			}else if(idx == 521 ){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/retainList.do",
					type : "POST",
					data: params,
					success : function(result) {
						sessionStorage.setItem("nowUrl", "${pageContext.request.contextPath}/retainList.do");
						$(".con-wrap").html(result);
						fn_bindEnterAntion();
					}
				});
			}else if(idx == 531 ){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/retainSettingList.do",
					type : "POST",
					data: params,
					success : function(result) {
						sessionStorage.setItem("nowUrl", "${pageContext.request.contextPath}/retainSettingList.do");
						$(".con-wrap").html(result);
						fn_bindEnterAntion();
					}
				});
			}else if(idx == 810){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/cctvList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}else if(idx == 821){
				$("#menuId").val(idx);
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/monitoringList.do",
					type : "POST",
					data: params,
					success : function(result) {
						$(".con-wrap").html(result);fn_bindEnterAntion();
					}
				});
			}
		}
		
		function fn_getTime(){
			var now = new Date();
			var month = now.getMonth()+1;
			var date = now.getDate();
			var hour = now.getHours();
			var minute = now.getMinutes();
			var second = now.getSeconds();
			
			fn_getEventAlarm();

			if(month < 10){
				month = "0"+month;
			}
			if(date < 10){
				date = "0"+date;
			}
			if(hour < 10){
				hour = "0"+hour;
			}
			if(minute < 10){
				minute = "0"+minute;
			}
			if(second < 10){
				second = "0"+second;
			}
			
			//var week = ['일', '월', '화', '수', '목', '금', '토'];
			var week;
			if( "${locale}" == "en" ){
				week = ['Son', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
			}else{
				week = ['일', '월', '화', '수', '목', '금', '토'];
			}
			
			var dayOfWeek = week[now.getDay()];

			var currentDate = now.getFullYear() + "." + month + "." + date + "("+dayOfWeek+") " + hour + ":" + minute;
			$("#timeArea").html(currentDate);
			$("#timeArea2").html(currentDate);
			
			$.ajax({
				url : "${pageContext.request.contextPath}/login/checkSession.json",
				type : "POST",
				success : function(result) {
					if(result.checkSession == "success"){
						//console.log("success");
					}else if(result.checkSession == "fail"){
						openDefaultPopup("sessionPopup", result.message);
						//location.href="${pageContext.request.contextPath}/logOut.do";
					}
				}
			});
		}
		
		function fn_searchList(idx){
			$("#pageIndex").val(idx);
			if(isEmpty($("#record").val())){
				$("#recordCountPerPage").val("10");
			}else{
				$("#recordCountPerPage").val($("#record").val());
			}
			var nowUrl = sessionStorage.getItem("nowUrl");
			var params = $("form[name=parameterVO]").serialize();
			$.ajax({
				url : nowUrl,
				type : "POST",
				data: params,
				success : function(result) {
					$(".con-wrap").html(result);fn_bindEnterAntion();
				}
			});
		}

		function fn_checkSite(){
			var checkLogin = '${sessionVO.account_id}';
			var siteId = '${sessionVO.company_id}';
			var siteName = '${sessionVO.site_name}';
			
			var directMainYn = "${sessionVO.directMainYn}";
			if(siteId == "" || siteId == null){
				$("#txtSiteName").html("");
				openSiteChangePopup("siteChangePopup");
				if("Y" == directMainYn){
					$("#slcSitePopupCreate").hide();
					$("#slcSitePopupClose").show();
				}else{
					$("#slcSitePopupCreate").show();
					$("#slcSitePopupClose").hide();
				}
				
			}else{
				$("#txtSiteName").html(siteName);
				fn_closePopup();
			}
			var params2 = $("form[name=parameterVO]").serialize();

		}
		
		function fn_systemAdminCheckSite(){
			openAdminGradePopup("systemAdminGradeChangePopup");
		}
		
		function fn_selectSite(siteId, siteName, systemAdminYn){
			
		}
		
		function fn_checkAll(){
			if($("#checkall").is(":checked")){
				$('input:checkbox[name="checkList"]').prop("checked", true);
			}else{
				$('input:checkbox[name="checkList"]').prop("checked", false);
			}
		}
		
		/*
		*	테이블 List 의 체크박스 클릭 이벤트
		*/
		$(document).on('click', "input:checkbox[name='checkList']" ,function(){
			var returnVal = false;
			var tmpChk = 0;
			$('input:checkbox[name="checkList"]').each(function(i,v){
				if($(v).is(":checked")) tmpChk++;
				if( tmpChk == $('input:checkbox[name="checkList"]').length ){
					returnVal = true;
				}
			})
			$("#checkall").prop("checked", returnVal);
		})
		
		function fn_windWay(wayValue){
			// 16방위 계산
			// 산식 : (( 풍향값 + 22.5 * 0.5 ) / 22.5) = 변환값 ( 소수점 이하 버림 )
			var wind = Math.floor(((parseInt(wayValue)+22.5*0.5)/22.5));
			var windWay;
		
			switch(String(wind)){
				case "0" :
					windWay = '<spring:message code="click.north"/>';
				break;
				case "1" :
					windWay = '<spring:message code="click.north.northeast"/>';
				break;
				case "2" :
					windWay = '<spring:message code="click.northeast"/>';
				break;
				case "3" :
					windWay = '<spring:message code="click.east.northeast"/>';
				break;
				case "4" :
					windWay = '<spring:message code="click.east"/>';
				break;
				case "5" :
					windWay = '<spring:message code="click.east.southeast"/>';
				break;
				case "6" :
					windWay = '<spring:message code="click.southeast"/>';
				break;
				case "7" :
					windWay = '<spring:message code="click.south.southeast"/>';
				break;
				case "8" :
					windWay = '<spring:message code="click.south"/>';
				break;
				case "9" :
					windWay = '<spring:message code="click.south.southwest"/>';
				break;
				case "10" :
					windWay = '<spring:message code="click.southwest"/>';
				break;
				case "11" :
					windWay = '<spring:message code="click.west.southwest"/>';
				break;
				case "12" :
					windWay = '<spring:message code="click.west"/>';
				break;
				case "13" :
					windWay = '<spring:message code="click.west.northwest"/>';
				break;
				case "14" :
					windWay = '<spring:message code="click.northwest"/>';
				break;
				case "15" :
					windWay = '<spring:message code="click.north.northwest"/>';
				break;
				case "16" :
					windWay = '<spring:message code="click.north"/>';
				break;
			}
			return windWay;
		}
		
		//var userURL = location.href;
		
		function fn_numPadding(date, num) {
			 var zero = '';
			 date = date.toString();
			
			 if (date.length < num) {
			  for (i = 0; i < num - date.length; i++)
			   zero += '0';
			 }
			 return zero + date;
		}
		
		function fn_siteWeather(){
			
			var today = new Date();
			var dd = today.getDate();
			var mm = today.getMonth()+1;
			var yyyy = today.getFullYear();
			var todayFormat = yyyy+""+fn_numPadding(mm,2)+""+fn_numPadding(dd,2);

			var url = "${pageContext.request.contextPath}/AjaxRequest.jsp?getUrl=";
			var subURL = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst?serviceKey="+$('#serviceKey').val();
			subURL += "&numOfRows=" + $('#numOfRows').val();
			subURL += "&pageNo=1";
			subURL += "&base_date=" + $('#base_date').val();
			subURL += "&base_time=" + $('#base_time').val();
			subURL += "&nx=" + $('#nx').val();
			subURL += "&ny=" + $('#ny').val();
			url += encodeURIComponent(subURL);
			
			$.ajax({
				url : url,
				type : "GET",
				async : "false",
				dataType : 'text',
				success : function(data){
					$(data).each(function(i,v){
						$(v).find('item').each(function(i,v){
							var fcstDate = $(this).find('fcstDate').text();
							var category = $(this).find('category').text();
							
							// 기온
							if(fcstDate==todayFormat && category=="T3H"){
								$('#temperature').text($(this).find('fcstValue').text() + "℃" );
							}
							// 습도
							if(fcstDate==todayFormat && category=="REH"){
								$('#humidity').text($(this).find('fcstValue').text() + "%" );
							}
							// 풍속
							if(fcstDate==todayFormat && category=="WSD"){
								$('#windspeed').text( $(this).find('fcstValue').text() + "m/s" );
								}
							// 풍향
							if(fcstDate==todayFormat && category=="VEC"){
								$('#circinus').text(fn_windWay($(this).find('fcstValue').text()));
							}
						})
						
					});
				},
				error : function(x,o,e){
					console.log( x.status + " : " + o + " : " + e );
				}
			});
		}
		function fn_goSystemAdmin(){
			location.href= "${pageContext.request.contextPath}/systemAdminMain.do";
		}
		function fn_siteNewRegi(){
			fn_closePopup();
			$("#is_create").val("Y");
			var params = $("form[id=parameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/siteRegi1.do",
				type : "POST",
				data: params,
				success : function(result) {
					$("#is_create").val("N");
					$(".con-wrap").html(result);
					fn_bindEnterAntion();
				}
			});
		}
		
		// 팝업이 닫힌 후 동작
		function fn_mainClosePopup(){
			var histSiteId = "${sessionVO.hist_company_id}";
			var histSiteName = "${sessionVO.hist_site_name}";
			fn_selectSite(histSiteId,histSiteName);
		}
		
		function fn_searchLocalList(idx) {
			$("#pageIndex").val(idx);
			$("#recordCountPerPage").val($("#record").val());
			$("#code_type_id").val($("#code_type_id_modify").val());
			$("#search_word").val($("#search_word_modify").val())
			var params = $("form[name=siteVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/siteRegi4.do",
				type : "POST",
				data: params,
				success : function(result) {
					//$(".con-wrap").html(result);fn_bindEnterAntion();
					$(".con-wrap").html(result);
				}
			});
		}
		
		function fn_searchLocalList2(idx) {
			$("#pageIndex").val(idx);
			$("#recordCountPerPage").val($("#record").val());
			var params = $("form[name=siteVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/siteRegi5.do",
				type : "POST",
				data: params,
				success : function(result) {
					$(".con-wrap").html(result);fn_bindEnterAntion();
				}
			});
		}
		
		function fn_siteMove3(){
			var params2 = $("form[id=siteVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/siteRegi3.do",
				type : "POST",
				data: params2,
				success : function(result) {
					$(".con-wrap").html(result);fn_bindEnterAntion();
				}
			});
		}
		
		function fn_alarmPopup(){
			//
			// CCTV 이슈로 인해 추가
			// ActiveX 때문에 CCTV 영상이 팝업 위로 올라오는 현상을 해결하기 위해 해당 펑션 사용
			$(".live_img").hide();
			$(".live_blank_img").show();
			/////
			//$("#parameterVO").append('<input type="hidden" id="reset_status" name="reset_status" value="Y"/>');
			//var params = $("form[id=parameterVO]").serialize();
			
			var params = "reset_status=Y";

			$.ajax({
				url : "${pageContext.request.contextPath}/alarmPopup/alarmListPopup",
				type : "POST",
				data: params,
				success : function(result) {
					$("#popupWrap").html(result);
					$("#popupWrap").css("display", "block");
				}
			});
		}
		
		function fn_searchAlarmPopup(page){
			$("#pageIndex2").val(page);
			var params = $("form[id=alarmPopupVO]").serialize();
			params += "&pageIndex=" + page;
						
			$.ajax({
				url : "${pageContext.request.contextPath}/alarmPopup/alarmListPopup",
				type : "POST",
				data: params,
				success : function(result) {
					$("#popupWrap").html(result);
					$("#popupWrap").css("display", "block");
				}
			});
		}
		
		function fn_searchAlarmPerPopup(page){
			$("#pageIndex2").val(page);
			var params = $("form[id=alarmPopupVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/alarmPopup/alarmListPerPopup",
				type : "POST",
				data: params,
				success : function(result) {
					$("#popupWrap").html(result);
					$("#popupWrap").css("display", "block");
				}
			});
		}

		
		function fn_alarmDetailPopup(event_id){
			var params = "event_id=" + event_id;
			$.ajax({
				url : "${pageContext.request.contextPath}/alarmDetailPopup/alarmPopup",
				type : "POST",
				data: params,
				success : function(result) {
					$("#alarmPopupWrap").html(result);
					$("#alarmPopupWrap").css("display", "block");
				}
			});
		}

		
		function fn_getEventAlarm(){
			  $.ajax({
				url : "${pageContext.request.contextPath}/checkEventAlarm.json",
				type : "POST",
				success : function(result) {
					if(result.resultCode == "success"){
						
						var nowSite = sessionStorage.getItem("nowSite");
						//Check Last알람. 
						if(!isEmpty(nowSite) && !isEmpty(result.eventAlarm) &&  result.eventAlarm.event_id > 0 && 
						    result.eventAlarm.read_yn != 'Y' && (isEmpty(result.eventAlarm.noti_yn) || result.eventAlarm.noti_yn == 'Y')) {
							fn_alarmDetailPopup();
						}
						if(result.eventCount > 0) {
							$("#idEventAlarmCount").text(result.eventCount);
							$("#idEventAlarmCount").removeClass("dis-none");
						} else {
							$("#idEventAlarmCount").addClass("dis-none");
						}
					}else {
						$("#idEventAlarmCount").addClass("dis-none");
					}
				}
			});
		}
		
		function changeLocale(localLang){
			$('#locale').val(localLang);
			
			setLocalStorage("locale", localLang);
			location.href="/click/main.do?lang="+localLang;
		}
		
		function fn_home(){
			var nowSite = sessionStorage.getItem("nowSite");
			if(isEmpty(nowSite)){
				
			}else{
				sessionStorage.setItem("nowUrl", "${pageContext.request.contextPath}/dashboard.do");
				fn_changePage('900');
			}
		}
	</script>
</head>
<body>
	<div id="wrap" class="contents">
		<div class="alert-pop-wrap" id="alertPopupWrap" style="display:none;">
			<!--태그현황 팝업-->
			
		</div>
		<div class="alarm-pop-wrap" id="alarmPopupWrap" style="display:none;">
		</div>
		
		<div class="loading-pop-wrap" id="loadingPopupWrap" style="display:none;">
		</div>
		
		<div class="toast-pop-wrap" id="toastPopWrap" style="display:none;">
		</div>
		
		<div class="pop-wrap" id="popupWrap" style="display:none;">
			<!--태그현황 팝업-->
			<!--현장 리스트 팝업-->
			<dl class="pop-style01" id="clientSitePopup" style="display: none">
				<dt><spring:message code="click.site.list"/></dt>
				<dd class="table font14 pb0">
					<h3 class="mb10"><spring:message code="click.manage.moving.site"/></h3>
					<table>
						<colgroup class="">
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tbody>
							<tr>
								<th scope="col">* <spring:message code="click.customer.selection"/></th>
								<td colspan="3"><select name="" id="" class="float-l"
									style="width: 230px;">
										<option value='<spring:message code="click.all"/>'><spring:message code="click.all"/></option>
										<option value="1">1</option>
								</select>
									<button class="td-button01 dis-block float-l ml10"
										style="width: 80px;"><spring:message code="click.search"/></button>
									<button class="td-button01 dis-block float-l ml10"
										style="width: 150px;"><spring:message code="click.go.system.management"/></button></td>
							</tr>
						</tbody>
					</table>
				</dd>
				<dd>
					<div class="table mt10 mb20 font14">
						<table>
							<caption>
								<span class="blind"><spring:message code="click.list.table"/></span>
							</caption>
							<colgroup class="">
								<col width="5%">
								<col width="25%">
								<col width="40%">
								<col width="30%">
							</colgroup>
							<thead class="">
								<tr>
									<th scope="col">No</th>
									<th scope="col"><spring:message code="click.customer"/></th>
									<th scope="col"><spring:message code="click.site.name"/></th>
									<th scope="col"><spring:message code="click.creation.date"/></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${accountSiteList}" var="accountSiteList">
									<fmt:parseDate var="reg_dt" value="${accountSiteList.reg_dt}"
										pattern="yyyy-MM-dd" />
									<%-- <tr onclick="javascript:fn_selectSite('${accountSiteList.company_id}', '${accountSiteList.site_name}', 'Y');return false;"> --%>
									<tr>
										<td class="center">${accountSiteListTotalCnt-status.index}</td>
										<td class="center"
											onclick="javascript:fn_selectSite('${accountSiteList.company_id}', '${accountSiteList.site_name}', 'Y');return false;">${accountSiteList.cooperator_name}</td>
										<td class="center"
											onclick="javascript:fn_selectSite('${accountSiteList.company_id}', '${accountSiteList.site_name}', 'Y');return false;">${accountSiteList.site_name}</td>
										<%-- <td class="center"><fmt:parseDate var="reg_dt" value="${accountSiteList.reg_dt}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
										<td class="center"><fmt:formatDate value="${reg_dt}"
												pattern="yyyy-MM-dd" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</dd>
				<button class="closeBtn" onclick="javascript:fn_closePopup();"><spring:message code="click.close"/></button>
			</dl>
		</div>

		<!--좌측 네비게이션-->
		<!--좌측 네비게이션 - 디폴트(접힘상태)-->
		<div id="leftMenuArea">
			<c:import url="/siteLeftMenu.do"/>
		</div>
		<!--좌측네비게이션 끝-->

		<div class="top-wrap">
			<div class="rt-con-wrap" style="color:#181c32!important;">
				<div style="float:right;line-height:70px;">
					<dl class="alram-icon">
						<dt class="dis-none" id="idEventAlarmCount"></dt>
						<dd>
							<img src="${pageContext.request.contextPath}/resources/img/alram_icon.png" alt="" style="width:20px;">
						</dd>
					</dl>
				</div>
				<div style="float:right;line-height:70px;margin-right:20px;"><button type="button" id="btnSearch" class="btn btn-blue btn-type2 mr10" onclick="javascript:fn_logout();return false;">로그아웃</button></div>
				<div style="float:right;line-height:70px;margin-right:20px;"><span>관리자(test)</span>님</div>
				<div style="float:right;line-height:70px;margin-right:20px;">
					<div onclick="javascript:fn_fullScreen();return false;"><img src="${pageContext.request.contextPath}/resources/img/fullscreen_btn.png" alt="전체화면" style="width:22.5px;"/></div>
				</div>
				<div style="float:right;line-height:70px;margin-right:20px;">
					<div onclick="javascript:fn_home();return false;"><img src="${pageContext.request.contextPath}/resources/img/home_btn.png" alt="홈" style="width:22.5px;"/></div>
				</div>
			</div>
		</div>
		<div class="con-wrap">
			<!-- <div class="con-wrap"> -->
			<form:form id="parameterVO" commandName="parameterVO" name="parameterVO" action="" method="post">
				<input type="hidden" id="company_id" name="company_id" value="" />
				<input type="hidden" id="hist_company_id" name="hist_company_id" value="" />
				<input type="hidden" id="site_name" name="site_name" value="" />
				<c:set var="menuId" value="1" />
				<c:if test="${parameterVO.menuId != null && parameterVO.menuId != ''}">
					<c:set var="menuId" value="parameterVO.menuId" />
				</c:if>
				<input type="hidden" id="menuId" name="menuId" value="${menuId}" />
				<input type="hidden" id="recordCountPerPage"
					name="recordCountPerPage" value="10" />
				<input type="hidden" id="message" name="message" value="" />
				<input type="hidden" id="os_version" name="os_version" value="" />
				<input type="hidden" id="is_create" name="is_create" value="" />
			</form:form>

			<form:form id="weatherVO" commandName="weatherVO" name="weatherVO" action="" method="post">
				<!-- 날씨데이터조회 -->
				<input type="hidden" id="serviceKey" name="serviceKey"
					value="RAsHi%2BadYfqpEaneuDwzqZqDMb7DQy6eRSCT%2BdylVOaZRGPjPo2w8kGj6K0t0mMNaNZboe4zb6tduOxSgBLSNA%3D%3D" />
				<input type="hidden" id="numOfRows" name="numOfRows" value="30" />
				<input type="hidden" id="pageNo" name="pageNo" value="1" />
				<input type="hidden" id="base_date" name="base_date" value="" />
				<input type="hidden" id="base_time" name="base_time" value="" />
				<input type="hidden" id="nx" name="nx" value="" />
				<input type="hidden" id="ny" name="ny" value="" />
			</form:form>
		</div>
		<footer id="footer">
			<div class="container">
				<div class="copyright">
					Copyright 2021 <span style="color:white!important;">클릭 컨설팅</span>
				</div>
			</div>
		</footer>
	</div>
	<form:form id="popupVO" commandName="popupVO" name="popupVO" method="post">
		<input type="hidden" id="popupType" name="popupType" value="" />
		<input type="hidden" id="pop_cooperator_id" name="pop_cooperator_id" value="" />
		<input type="hidden" id="pop_cooperator_name" name="pop_cooperator_name" value="" />
		<input type="hidden" id="pop_code_id" name="pop_code_id" value="" />
		<input type="hidden" id="pop_code_type_id" name="pop_code_type_id" value="" />
		<input type="hidden" id="pop_code_name" name="pop_code_name" value="" />
		<input type="hidden" id="pop_code_name_eng" name="pop_code_name_eng" value="" />
		<input type="hidden" id="pop_action_type" name="pop_action_type" value="" />
		<input type="hidden" id="pop_reserved1" name="pop_reserved1" value="" />
		<input type="hidden" id="pop_reserved2" name="pop_reserved2" value="" />
		<input type="hidden" id="pop_reserved3" name="pop_reserved3" value="" />
		<input type="hidden" id="pop_company_id" name="company_id" value="" />
		<input type="hidden" id="pop_msg" name="pop_msg" value="" />
		<input type="hidden" id="pop_callback_txt" name="pop_callback_txt" value="" />
		<input type="hidden" id="pop_callback" name="pop_callback" value="" />
		<input type="hidden" id="pop_callback2" name="pop_callback2" value="" />
	</form:form>
</body>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/storageUtil.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/util.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/mapviewer/clientController.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/doWorker.js"></script>
</html>