var checkValidate = "";
// 2뎁스 메뉴 관련
// nav01 : 안쓰는 스크립트, 참고용
$(document).ready(function(){
	//hide 메뉴
	$('.left-menu > ul > li > dl').hide();
	$('.left-menu ul .nav01').hover(function(){
	  //hover
	  $('.nav_sub01').show();    
	},function(){
	  //mouse out
	  $('.left-menu > ul > li > dl').hide();
	})

	$('.nav_sub01').hover(function(){
		//hover
		$('.nav_sub01').show();  
	  },function(){
		//mouse out
		$('.left-menu > ul > li > dl').hide();
	  })
  })

$(window).resize(function(){
	console.log($(this).width());
	console.log($(".menu-toggle"));
	console.log($(".menu-toggle-close"));
	if($(this).width()>1600){
		if( $('#wrap').hasClass('fullMode') || $('#wrap').hasClass('fullMode2Area')){
			$('.con-wrap').css('width','100%');
			$('.con-wrap').css('marginLeft','0px');
		}else{
			$('.con-wrap').css('width','calc( 100% - 70px )');
			$('.con-wrap').css('marginLeft','70px');
		}
	}else{
		$('.con-wrap').css('width','100%');
		$('.con-wrap').css('marginLeft','0px');
	}
})
// 리팩토링 사용하는 스크립트 : 좌측 네비게이션 (디폴트시)
$(document).ready(function(){
	for(let i = 1; i<14;i++){
		var value = pad(i,2);
		let nav = '.left-menu ul .nav' + value;
		let sub = '.nav_sub'+value;
		let navGroup = '.left-menu > ul > li > dl';
		$(navGroup).hide();
			$(nav).hover(function(){
			//hover
				$('.left-menu').hide();
				$('.left-menu-open').show();
				$('.top-wrap h2').css('marginLeft','270px');
				if($(window).width()>1600){
					$('.con-wrap').css('width','calc( 100% - 250px )');
					$('.con-wrap').css('marginLeft','250px');
				}else{
					fn_cctvHide();
					$('.con-wrap').css('width','100%');
					$('.con-wrap').css('marginLeft','0px');
				}
				//$('.page-navigation').css('marginLeft','270px');
				$('.top-wrap > .info-pannel').css('marginLeft','270px');
				$('.top-wrap > .date-pick-solo').css('marginLeft','270px');
				$('.view-mode-pannel > dd > button').css('padding','0 2% 0 2%');
				$('.view-mode-pannel > dd > button').css('margin','0 2%');
				$('.tower-div').css('margin','0 2.3%');
				$('.tower-div').css('width','28%');
				$('.ea4 > .state-light-wrap > dd').css('width','31%');
				$('.ea4 > .state-light-wrap > dd > div').css('marginLeft','8px');
				$('.ea4 > .state-light-wrap > dd > div').css('marginRight','8px');
				$('.ea3 > .state-light-wrap > dd').css('width','31%');
				$('.ea3 > .state-light-wrap > dd > div').css('marginLeft','8px');
				$('.ea3 > .state-light-wrap > dd > div').css('marginRight','8px');
				$('.ea2 > .state-light-wrap > dd').css('width','31%');
				$('.ea2 > .state-light-wrap > dd > div').css('marginLeft','8px');
				$('.ea2 > .state-light-wrap > dd > div').css('marginRight','8px');
				$('.ea1 > .state-light-wrap > dd').css('width','31%');
				$('.ea1 > .state-light-wrap > dd > div').css('marginLeft','8px');
				$('.ea1 > .state-light-wrap > dd > div').css('marginRight','8px');
				$('.con-area .tunnel-wrap .right-section .section03 dl dd').css('paddingTop','5px');
			});
		
		/*$(sub).hover(function(){
		//hover
			$(sub).show();
			$(nav+':hover').show();
				},function(){
				//mouse out
				$(navGroup).hide();
		});*/
	} // for
  })

// 좌측네비게이션 펼침상태 아코디언메뉴 구현
	
	$('.left-menu-open > dl > dt').on('click', function (i) {
		function slideDown(target) {
			slideUp();
			$(target).addClass('on').next().slideDown();
			$(this).addClass('on');
			$('.left-menu-open > dl').css('overflow-y', 'scroll');
			$('.left-menu-open > dl').css('overflow-x', 'hidden');
			$('.left-menu-open > dl').css('height', '100%');
		}
	
		function slideUp() {
			$('.left-menu-open > dl > dt').removeClass('on').next().slideUp();
			$(this).removeClass('.on');
		};
		$(this).hasClass('on') ? slideUp() : slideDown($(this));
	
	})

//좌측네비게이션 펼치기 액션

	$(function(){
		$('.menu-toggle').click(function(){
			$('.left-menu').hide();
			$('.left-menu-open').show();
			$('.top-wrap h2').css('marginLeft','270px');
			if($(window).width()>1600){
				$('.con-wrap').css('width','calc( 100% - 250px )');
				$('.con-wrap').css('marginLeft','250px');
			}else{
				fn_cctvHide();
				$('.con-wrap').css('width','100%');
				$('.con-wrap').css('marginLeft','0px');
			}
			//$('.page-navigation').css('marginLeft','270px');
			$('.top-wrap > .info-pannel').css('marginLeft','270px');
			$('.top-wrap > .date-pick-solo').css('marginLeft','270px');
			$('.view-mode-pannel > dd > button').css('padding','0 2% 0 2%');
			$('.view-mode-pannel > dd > button').css('margin','0 2%');
			$('.tower-div').css('margin','0 2.3%');
			$('.tower-div').css('width','28%');
			$('.ea4 > .state-light-wrap > dd').css('width','31%');
			$('.ea4 > .state-light-wrap > dd > div').css('marginLeft','8px');
			$('.ea4 > .state-light-wrap > dd > div').css('marginRight','8px');
			$('.ea3 > .state-light-wrap > dd').css('width','31%');
			$('.ea3 > .state-light-wrap > dd > div').css('marginLeft','8px');
			$('.ea3 > .state-light-wrap > dd > div').css('marginRight','8px');
			$('.ea2 > .state-light-wrap > dd').css('width','31%');
			$('.ea2 > .state-light-wrap > dd > div').css('marginLeft','8px');
			$('.ea2 > .state-light-wrap > dd > div').css('marginRight','8px');
			$('.ea1 > .state-light-wrap > dd').css('width','31%');
			$('.ea1 > .state-light-wrap > dd > div').css('marginLeft','8px');
			$('.ea1 > .state-light-wrap > dd > div').css('marginRight','8px');
			$('.con-area .tunnel-wrap .right-section .section03 dl dd').css('paddingTop','5px');
		});
	});
	
//좌측네비게이션 닫기 액션
	$(function(){
		$('.menu-toggle-close').click(function(){
			$('.left-menu-open').hide();
			$('.left-menu').show();
			$('.top-wrap h2').css('marginLeft','20px');
			//$('.page-navigation').css('marginLeft','90px');
			if($(window).width()>1600){
				$('.con-wrap').css('width','calc( 100% - 70px )');
				$('.con-wrap').css('marginLeft','70px');
			}else{
				fn_cctvShow();
				$('.con-wrap').css('width','100%');
				$('.con-wrap').css('marginLeft','0px');
			}
			$('.top-wrap > .info-pannel').css('marginLeft','20px');
			$('.top-wrap > .date-pick-solo').css('marginLeft','90px');
			$('.view-mode-pannel > dd > button').css('padding','0 2% 0 2%');
			$('.view-mode-pannel > dd > button').css('margin','0 2%');
			$('.tower-div').css('margin','0 4.1666%');
			$('.tower-div').css('width','25%');
			$('.ea4 > .state-light-wrap > dd').css('width','23%');
			$('.ea4 > .state-light-wrap > dd > div').css('marginLeft','5px');
			$('.ea4 > .state-light-wrap > dd > div').css('marginRight','5px');
			$('.ea3 > .state-light-wrap > dd').css('width','23%');
			$('.ea3 > .state-light-wrap > dd > div').css('marginLeft','5px');
			$('.ea3 > .state-light-wrap > dd > div').css('marginRight','5px');
			$('.ea2 > .state-light-wrap > dd').css('width','23%');
			$('.ea2 > .state-light-wrap > dd > div').css('marginLeft','5px');
			$('.ea2 > .state-light-wrap > dd > div').css('marginRight','5px');
			$('.ea1 > .state-light-wrap > dd').css('width','23%');
			$('.ea1 > .state-light-wrap > dd > div').css('marginLeft','5px');
			$('.ea1 > .state-light-wrap > dd > div').css('marginRight','5px');
			$('.con-area .tunnel-wrap .right-section .section03 dl dd').css('paddingTop','15px');
		});
	});


//네비게이션 스크롤 ie 적용 스크립트 : 추후 적용 예정 (다른 작업 선진행)
    (function($){
        $(window).on("load",function(){
            //$(".side_wrapper").mCustomScrollbar();
        });
    })(jQuery);

//전체선택 체크박스
	$(function(){ //전체선택 체크박스 클릭 
		$("#checkall").click(function(){ //만약 전체 선택 체크박스가 체크된상태일경우 
			if($("#checkall").prop("checked")) { //해당화면에 전체 checkbox들을 체크해준다 
				$("input[type=checkbox]").prop("checked",true); 
			} else { 
				$("input[type=checkbox]").prop("checked",false); } 
			}); 
		});
	
	function openPopup(popupName, codeObj){
		$("#pop_cooperator_id").val(codeObj.cooperator_id);
		$("#pop_cooperator_name").val(codeObj.cooperator_name);
		$("#pop_code_id").val(codeObj.code_id);
		$("#pop_action_type").val(codeObj.action_type);
		$("#pop_code_type_id").val(codeObj.code_type_id);
		$("#pop_code_name").val(codeObj.code_name);
		$("#pop_code_name_eng").val(codeObj.code_name_eng);
		$("#pop_reserved1").val(codeObj.reserved1);
		$("#pop_reserved2").val(codeObj.reserved2);
		$("#pop_reserved3").val(codeObj.reserved3);
		$("#popupType").val(codeObj.popupType);
		$("#pop_company_id").val(codeObj.pop_company_id);
		var params = $("form[name=popupVO]").serialize();
		
		$.ajax({
			url : "/click/popup/"+popupName,
			type : "POST",
			data: params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
				fn_activeColor();
			}
		});
	}
	
	function openConfirmPopup(popMsg, popCallbackTxt, popCallback){
		$("#pop_msg").val(popMsg);
		$("#pop_callback_txt").val(popCallbackTxt);
		$("#pop_callback").val(popCallback);
		
		var params = $("form[name=popupVO]").serialize();

		$.ajax({
			url : "/click/popup/confirmPopup",
			type : "POST",
			data: params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
				fn_activeColor();
			}
		});
	}
	
	function openConfirmPopup2(popMsg, popCallbackTxt, popCallback, popCallback2){
		$("#pop_msg").val(popMsg);
		$("#pop_callback_txt").val(popCallbackTxt);
		$("#pop_callback").val(popCallback);
		$("#pop_callback2").val(popCallback2);
		
		var params = $("form[id=popupVO2]").serialize();

		$.ajax({
			url : "/click/popup/confirmPopup",
			type : "POST",
			data: params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
				fn_activeColor();
			}
		});
	}
	
	function openConfirmPopup3(popMsg, popCallbackTxt, popCallback, popCallback2){
		$("#pop_msg").val(popMsg);
		$("#pop_callback_txt").val(popCallbackTxt);
		$("#pop_callback").val(popCallback);
		$("#pop_callback2").val(popCallback2);
		
		var params = $("form[id=popupVO]").serialize();
		
		$.ajax({
			url : "/click/popup/confirmPopup",
			type : "POST",
			data: params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
				fn_activeColor();
			}
		});
	}
	
	function openLoginAgreementPopup(){
		
		$.ajax({
			url : "/click/agreementPopup/loginAgreementPopup",
			type : "POST",
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
				fn_activeColor();
			}
		});
	}
	
	function openFirmwarePopup(popupName){
		$.ajax({
			url : "/click/defaultPopup/"+popupName,
			type : "POST",
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
				$("#firmwareupload").on("change", fn_addFiles2);
				$("#firmwareupload").on("click", fn_removeFiles2);
			}
		});
	}
	
	function openAreaTypePopup(popupName){
		$.ajax({
			url : "/click/popup/"+popupName,
			type : "POST",
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}

	function openAdminGradePopup(popupName){
		$.ajax({
			url : "/click/adminGradePopup/"+popupName,
			type : "POST",
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	function openSiteChangePopup(popupName){
		$.ajax({
			url : "/click/openSiteChangePopup/"+popupName,
			type : "POST",
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	function fn_noticePopup(popupName){
		$.ajax({
			url : "/click/noticePopup/"+popupName,
			type : "POST",
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	function fn_dashboardSettingPopup(popupName){
		$.ajax({
			url : "/click/dashboardSettingPopup/"+popupName,
			type : "POST",
			success : function(result) {
				$("#alertPopupWrap").html(result);
				$("#alertPopupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	
	function openDefaultPopup(popupName, popupText){
		$.ajax({
			url : "/click/defaultPopup/"+popupName,
			type : "POST",
			success : function(result) {
				if("loginPopup" == popupName || "loginPopup2" == popupName || "dashboardSettingPopup" == popupName || "dashboardSettingDetailPopup" == popupName ||
				   "alarmActionPopup" == popupName || "alarmActionResultPopup" == popupName || "codeValidPopup" == popupName){
					$("#alertPopupWrap").html(result);
				}else if("loadingPopup" == popupName){
					fn_cctvHide();
					$("#loadingPopupWrap").html(result);
				}else{
					$("#popupWrap").html(result);
				}
				if(popupText != "" && popupText != null){
					$("#popupText").html(popupText);
				}
				if("loginPopup" == popupName || "loginPopup2" == popupName || "dashboardSettingPopup" == popupName || "dashboardSettingDetailPopup" == popupName ||
				   "alarmActionPopup" == popupName || "alarmActionResultPopup" == popupName  || "codeValidPopup" == popupName){			
					$("#alertPopupWrap").css("display", "block");
					$(".closeBtn").focus();
				}else if("loadingPopup" == popupName){
					$("#loadingPopupWrap").css("display", "block");
					$("#loadingPopupWrap").focus();
				}else{
					$("#popupWrap").css("display", "block");
					$(".closeBtn").focus();
				}
				
				if("loadingPopup" == popupName){
					setTimeout("fn_checkLoading()", 10000);
				}
			}
		});
	}
	
	function openToastPopup(){
		$.ajax({
			url : "/click/toastPopup/toastPopup",
			type : "POST",
			success : function(result) {
				$("#toastPopWrap").html(result);
				$("#toastPopWrap").css("display", "block");
				setTimeout(function() {
					$("#toastPopWrap").fadeOut('slow');
				}, 3000);
			}
		});
	}
	
	function fn_checkLoading(){
		if(undefined != $("#loadingPopupWrap").find(".loading-container")){
			$("#loadingPopupWrap").html("");
			$("#loadingPopupWrap").css("display", "none");
			fn_cctvShow();
		}
	}
	
	function openEventAlarmPopup(popupName, popupText, params){
		$.ajax({
			url : "/click/alarmPopup/"+popupName,
			type : "POST",
			data : params,
			success : function(result) {
				$("#alertPopupWrap").html(result);
				
				if(popupText != "" && popupText != null){
					$("#popupText").html(popupText);
				}
				
				$("#alertPopupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	function openRetainPopup(popupName, params){
		$.ajax({
			url : "/click/openRetainPopup/"+popupName,
			type : "POST",
			data : params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
			}
		});
	}
	
	function openRetainGraphPopup(popupName, params){
		$.ajax({
			url : "/click/openRetainGraphPopup/"+popupName,
			type : "POST",
			data : params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
			}
		});
	}
	
	function openRetainGraphPopup2(popupName, params){
		$.ajax({
			url : "/click/openRetainGraphPopup2/"+popupName,
			type : "POST",
			data : params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
			}
		});
	}
	
	function openRetainListPopup(popupName, params){
		$.ajax({
			url : "/click/openRetainListPopup/"+popupName,
			type : "POST",
			data : params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
			}
		});
	}
	
	function openGasGraphPopup(popupName, params){
		$.ajax({
			url : "/click/openGasGraphPopup/"+popupName,
			type : "POST",
			data : params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
			}
		});
	}
	
	function openDeviceHistoryPopup(popupName, params){
		$.ajax({
			url : "/click/deviceHistoryPopup/"+popupName,
			type : "POST",
			data : params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
			}
		});
	}
	
	function openReissueAllPopup(popupName, params){
		$.ajax({
			url : "/click/reissueAllPopup/"+popupName,
			type : "POST",
			data : params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
			}
		});
	}
	
	function openWorkerBundleDeviceRegiPopup(popupName, params){
		
		/*
		var keys = Object.keys(params);
		var values = Object.keys(params).map(value => {
			  return params[value]
		});
		*/
		
		/*
	    Object.entries = function( obj ){
		    var ownProps = Object.keys( obj ),
		        i = ownProps.length,
		        resArray = new Array(i); // preallocate the Array
		    while (i--)
		      resArray[i] = [ownProps[i], obj[ownProps[i]]];
		    
		    return resArray;
		}
		*/
		
		//const mapParam = new Map(Object.entries(params));
		//console.log( "mapParam : " + mapParam );
		
		
		$.ajax({
			url : "/click/openWorkerBundleDeviceRegiPopup/"+popupName,
			type : "POST",
			data : params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
			}
		});
	}
	
	function fn_activeColor(){
		$(".color-pannel-wrap > li > a").on("click", function(i){
			$(".color-pannel-wrap > li > a").removeClass("active");
			$(this).addClass("active");
		});
	}
	
	function pad(n, width) {

		n = n + '';

		return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;

  }
  
  function fn_bindLeftMenu(){
		$('.left-menu > ul > li > dl').hide();
		$('.left-menu ul .nav01').hover(function(){
		  //hover
		  $('.nav_sub01').show();    
		},function(){
		  //mouse out
		  $('.left-menu > ul > li > dl').hide();
		})

		$('.nav_sub01').hover(function(){
		$('.nav_sub01').show();  
		},function(){
			$('.left-menu > ul > li > dl').hide();
		});
		  
		for(let i = 1; i<14;i++){
			var value = pad(i,2);
			let nav = '.left-menu ul .nav' + value;
			let sub = '.nav_sub'+value;
			let navGroup = '.left-menu > ul > li > dl';
			$(navGroup).hide();
			$(nav).hover(function(){
				$(sub).show();
			},function(){
				$(navGroup).hide();
			})
					
			$(sub).hover(function(){
				$(sub).show();
				$(nav+':hover').show();
			},function(){
				$(navGroup).hide();
			})
		}
		
		$('.left-menu-open > dl > dt').on('click', function (i) {
			if("navi nav01" != $(this).attr('class')){
				function slideDown(target) {
					slideUp();
					$(target).addClass('on').next().slideDown();
					$(this).addClass('on');
					$('.left-menu-open > dl').css('overflow-y', 'scroll');
					$('.left-menu-open > dl').css('overflow-x', 'hidden');
					$('.left-menu-open > dl').css('height', '100%');				
				}
			
				function slideUp() {
					$('.left-menu-open > dl > dt').removeClass('on').next().slideUp();
					$(this).removeClass('.on');
					$('.left-menu-open > dl').css('overflow-y', 'hidden');
					$('.left-menu-open > dl').css('overflow-x', 'hidden');
					$('.left-menu-open > dl').css('height', '100%');
				};
				$(this).hasClass('on') ? slideUp() : slideDown($(this));
			}
		})
		
		$(function(){
			$('.menu-toggle').click(function(){
				$('.left-menu').hide();
				$('.left-menu-open').show();
				$('.top-wrap h2').css('marginLeft','270px');
				if($(window).width()>1600){
					$('.con-wrap').css('width','calc( 100% - 250px )');
					$('.con-wrap').css('marginLeft','250px');
				}else{
					$('.con-wrap').css('width','100%');
					$('.con-wrap').css('marginLeft','0px');
					fn_cctvHide();
				}
				//$('.page-navigation').css('marginLeft','270px');
				$('.top-wrap > .info-pannel').css('marginLeft','270px');
				$('.top-wrap > .date-pick-solo').css('marginLeft','270px');
				$('.view-mode-pannel > dd > button').css('padding','0 2% 0 2%');
				$('.view-mode-pannel > dd > button').css('margin','0 2%');
				$('.tower-div').css('margin','0 2.3%');
				$('.tower-div').css('width','28%');
				$('.ea4 > .state-light-wrap > dd').css('width','31%');
				$('.ea4 > .state-light-wrap > dd > div').css('marginLeft','8px');
				$('.ea4 > .state-light-wrap > dd > div').css('marginRight','8px');
				$('.ea3 > .state-light-wrap > dd').css('width','31%');
				$('.ea3 > .state-light-wrap > dd > div').css('marginLeft','8px');
				$('.ea3 > .state-light-wrap > dd > div').css('marginRight','8px');
				$('.ea2 > .state-light-wrap > dd').css('width','31%');
				$('.ea2 > .state-light-wrap > dd > div').css('marginLeft','8px');
				$('.ea2 > .state-light-wrap > dd > div').css('marginRight','8px');
				$('.ea1 > .state-light-wrap > dd').css('width','31%');
				$('.ea1 > .state-light-wrap > dd > div').css('marginLeft','8px');
				$('.ea1 > .state-light-wrap > dd > div').css('marginRight','8px');
				$('.con-area .tunnel-wrap .right-section .section03 dl dd').css('paddingTop','5px');
			});
		});
		
	//좌측네비게이션 닫기 액션
		$(function(){
			$('.menu-toggle-close').click(function(){
				$('.left-menu-open').hide();
				$('.left-menu').show();
				$('.top-wrap h2').css('marginLeft','90px');
				if($(window).width()>1600){
					$('.con-wrap').css('width','calc( 100% - 70px )');
					$('.con-wrap').css('marginLeft','70px');
				}else{
					fn_cctvShow();
					$('.con-wrap').css('width','100%');
					$('.con-wrap').css('marginLeft','0px');
				}
				//$('.page-navigation').css('marginLeft','90px');
				$('.top-wrap > .info-pannel').css('marginLeft','90px');
				$('.top-wrap > .date-pick-solo').css('marginLeft','90px');
				$('.view-mode-pannel > dd > button').css('padding','0 2% 0 2%');
				$('.view-mode-pannel > dd > button').css('margin','0 2%');
				$('.tower-div').css('margin','0 4.1666%');
				$('.tower-div').css('width','25%');
				$('.ea4 > .state-light-wrap > dd').css('width','23%');
				$('.ea4 > .state-light-wrap > dd > div').css('marginLeft','5px');
				$('.ea4 > .state-light-wrap > dd > div').css('marginRight','5px');
				$('.ea3 > .state-light-wrap > dd').css('width','23%');
				$('.ea3 > .state-light-wrap > dd > div').css('marginLeft','5px');
				$('.ea3 > .state-light-wrap > dd > div').css('marginRight','5px');
				$('.ea2 > .state-light-wrap > dd').css('width','23%');
				$('.ea2 > .state-light-wrap > dd > div').css('marginLeft','5px');
				$('.ea2 > .state-light-wrap > dd > div').css('marginRight','5px');
				$('.ea1 > .state-light-wrap > dd').css('width','23%');
				$('.ea1 > .state-light-wrap > dd > div').css('marginLeft','5px');
				$('.ea1 > .state-light-wrap > dd > div').css('marginRight','5px');
				$('.con-area .tunnel-wrap .right-section .section03 dl dd').css('paddingTop','15px');
			});
		});
	}
	
	function fn_clear(){
		$(".m-form-table").find("input:text").val("");
		$(".m-form-table").find("select").val("");
		$("#parameterVO").find("input:hidden").each(function(i){
			var checkFormId = $(this).attr("id");
			if(checkFormId != "pageIndex" && checkFormId != "menuId" && checkFormId != "company_id" && checkFormId != "recordCountPerPage"){
				$(this).val("");
			}
		})
	}
	
	function fn_clearForm(formName){
		$("#"+formName).find("input:text").each(function(i){
			$(this).val("");
		})
		$("#"+formName).find("select").each(function(i){
			$(this).val("");
		})
	}
	
	function openCooperatorPopup(popupName){
		$.ajax({
			url : "/click/cooperatorPopup/"+popupName,
			type : "POST",
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	function openCooperatorDetailPopup(popupName,objData){
		$.ajax({
			url : "/click/cooperatorDetailPopup/"+popupName,
			type : "POST",
			data: objData,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
				fn_activeColor();
			}
		});
	}
	
	function openProcessPopup(popupName,objData){
		$.ajax({
			url : "/click/processPopup/"+popupName,
			type : "POST",
			data: objData,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	function openAnemometerPopup(popupName, objData){
		$.ajax({
			url : "/click/anemometerPopup/"+popupName,
			type : "POST",
			data: objData,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	function openGateSettingPopup(popupName, objData){
		$.ajax({
			url : "/click/gateSettingPopup/"+popupName,
			type : "POST",
			data: objData,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	function openDigthroughPopup(popupName, objData){
		$.ajax({
			url : "/click/digthroughPopup/"+popupName,
			type : "POST",
			data: objData,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	function openCctvChangePopup(popupName){
		var params = $("form[name=cctvChangeVO]").serialize();
		
		$.ajax({
			url : "/click/popup/"+popupName,
			type : "POST",
			data: params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
				fn_activeColor();
			}
		});
	}
	
	function openEquipTouchPopup(popupName, params){
		
		$.ajax({
			url : "/click/equipMapPopup/"+popupName,
			type : "POST",
			data: params,
			success : function(result) {
				$("#popupWrap").html(result);
				$("#popupWrap").css("display", "block");
				$(".closeBtn").focus();
			}
		});
	}
	
	function fn_closePopup(){
		// 팝업 닫힌 후 focus 이동
		if(null != checkValidate && "" != checkValidate){
			$("#"+checkValidate).focus();
			checkValidate = "";
		}
		// 팝업 닫힌 후 동작할 Function
		if(typeof fn_returnPopup=='function'){
			fn_returnPopup();
		}
		$("#popupWrap").html("");
		$("#popupWrap").css("display", "none");
	}
	
	function fn_closeAlarmPopup(){
		// 팝업 닫힌 후 focus 이동
		if(null != checkValidate && "" != checkValidate){
			$("#"+checkValidate).focus();
			checkValidate = "";
		}
		// 팝업 닫힌 후 동작할 Function
		if(typeof fn_returnPopup=='function'){
			fn_returnPopup();
		}
		$("#alarmPopupWrap").html("");
		$("#alarmPopupWrap").css("display", "none");
	}
	
	function fn_closePopupThis(){
		$("#alertPopupWrap").html("");
		$("#alertPopupWrap").css("display", "none");
	}
	
	function fn_closeLoadingPopup(){
		$("#loadingPopupWrap").html("");
		$("#loadingPopupWrap").css("display", "none");
		fn_cctvShow();
	}
	
	function fn_closePopupFadeOut(duration){
		// CCTV
		fn_cctvShow();
		
		// 팝업 닫힌 후 focus 이동
		if(null != checkValidate && "" != checkValidate){
			$("#"+checkValidate).focus();
			checkValidate = "";
		}
		// 팝업 닫힌 후 동작할 Function
		if(typeof fn_returnPopup=='function'){
			fn_returnPopup();
		}
		$("#alarmPopupWrap").fadeOut(duration);
	}
	
	// cctv 감추기 (flag)
	function fn_cctvLiveHide(){
		var flag = $('.live_img').is(':visible');
		if(flag){
			$(".live_img").hide();
			$(".live_blank_img").show();
		}else{
			$(".live_blank_img").hide();
			$(".live_img").show();
		}
	}
	
	// cctv 감추기
	function fn_cctvHide(){
		$(".live_img").hide();
		$(".live_blank_img").show();
	}
	
	// cctv 보이기
	function fn_cctvShow(){
		if($(window).width()>1600){
			$(".live_img").show();
			$(".live_blank_img").hide();
		}else{
			if( $('.left-menu').css("display") != "none" ){
				$(".live_img").show();
				$(".live_blank_img").hide();
			}
		}
	}

	
	function fn_validate(){
		checkValidate = "";
		var result = true;
        var numPattern1 = /[0-9]/;
        var EngPattern2 = /[a-zA-Z]/;
        var spPattern3 = /[.~!@\#$%<>^&*]/;
        var korPattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
        var pointPattern = /[.]/;
        var pointPattern2 = /[~!@\#$%<>^&*]/;
        
		// 기본 String validate
        // 클래스에 required 선언
		$('.required').each(function(i){
			var val = $(this).val();
			var val_name = $(this).parent('td').prev('th').text().replace("*","");
			if("" == val_name || undefined == val_name){
				val_name = $(this).attr("data-validate-feild");
			}
			if(!val){
				openDefaultPopup("loginPopup" , val_name + "을(를) 입력해주시기 바랍니다.");
				result = false;
				console.log(i);
				checkValidate = $(this).attr("id");
				return false;
			}
		});
		// 기본 String validate ( Table 구조가 다른 등록화면 )
        // 클래스에 required 선언
		$('.required_regi').each(function(i){
			var val = $(this).val();
			var val_name = $(this).prev('.td-title01').text().replace("*","");
			if(!val){
				openDefaultPopup("loginPopup" , val_name + "을(를) 입력해주시기 바랍니다.");
				result = false;
				console.log(i);
				checkValidate = $(this).attr("id");
				return false;
			}
		});
		if(null == checkValidate || "" == checkValidate){
			$('.required_pop').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(!val){
					$('.required_resultPop').text(val_name+"을(를) 입력해주시기 바랍니다.");
					$('.required_resultPop').show();
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		// 기본 String validate
		// 클래스에 required 선언
		
		if(null == checkValidate || "" == checkValidate){
			// Number validate ( 숫자만 입력가능 )
			// 클래스에 required_num 선언
			$('.required_num').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if("" == val_name){
					val_name = $(this).attr("data-validate-feild");
				}
				if(EngPattern2.test(val)||spPattern3.test(val)||korPattern.test(val)){
					openDefaultPopup("loginPopup" , val_name+"은(는) 숫자만 입력가능합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		
		if(null == checkValidate || "" == checkValidate){
			// Number validate ( 숫자만 입력가능 )
			// 클래스에 required_num 선언
			$('.required_num_pop').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(EngPattern2.test(val)||spPattern3.test(val)||korPattern.test(val)){
					$('.required_resultPop').text(val_name+"은(는) 숫자만 입력가능합니다.");
					$('.required_resultPop').show();
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		if(null == checkValidate || "" == checkValidate){
			// char validate ( 숫자/문자만 입력가능 , 특수문자 불가 )
			// 클래스에 required_char 선언
			$('.required_char').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(spPattern3.test(val)){
					openDefaultPopup("loginPopup" , val_name+"은(는) 숫자/문자만 입력 가능합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		
		if(null == checkValidate || "" == checkValidate){
			// kor validate ( 한글만 입력가능 )
			// 클래스에 required_ko 선언
			$('.required_ko').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(EngPattern2.test(val)||spPattern3.test(val)){
					openDefaultPopup("loginPopup" , val_name+"은(는) 한글/숫자만 입력 가능합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		if(null == checkValidate || "" == checkValidate){
			// eng validate ( 영문만 입력가능 )
			// 클래스에 required_ko 선언
			$('.required_eng').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(spPattern3.test(val)||korPattern.test(val)){
					openDefaultPopup("loginPopup" , val_name+"은(는) 영문/숫자만 입력 가능합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		
		if(null == checkValidate || "" == checkValidate){
			// Min validate
			// 최소 입력값체크
			// 필수 Parameter : 해당 element에 data-minlen='최소값'
			// 클래스에 required_min 선언
			$('.required_min').each(function(){
				var val = $(this).val();
				var min_length = $(this).attr('data-minlen');
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(min_length>val.length){
					openDefaultPopup("loginPopup" , val_name+"은(는) 최소 " + min_length + "자 이상 입력해야 합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		
		if(null == checkValidate || "" == checkValidate){
			// Max validate
			// 최대 입력값체크
			// 필수 Parameter : 해당 element에 data-maxLen='최대값'
			// 클래스에 required_max 선언
			$('.required_max').each(function(){
				var val = $(this).val();
				var max_length = $(this).data('maxlen');
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(!val){
					openDefaultPopup("loginPopup" , val_name + "은(는) 필수입니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
				if(max_length<val.length){
					openDefaultPopup("loginPopup" , val_name + "은(는) 최대 " + max_length + "자 까지 입력 가능합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		
		if(null == checkValidate || "" == checkValidate){
			// char validate ( 숫자/문자만 입력가능 , 특수문자 불가 )
			// 클래스에 required_char 선언
			$('.required_point').each(function(){
				var val = $(this).val();
				var objEvent = event.srcElement;
		        if(pointPattern2.test(val)||EngPattern2.test(val) || korPattern.test(val)){
		        	openDefaultPopup("loginPopup" , "숫자/.(소수점)만 입력 가능합니다.");
		        	$(this).val(objEvent.value.replace(/[\{\}\[\]\/?,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, ''));
					$(this).val(objEvent.value.replace(/[a-zA-Z]/gi, ''));
					$(this).val(objEvent.value.replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi, ''));
					objEvent.focus();
					result = false;
		        	return false;
		        }
			});
		}
		return result;
	}
	
	function fn_validateTunnel(tunnelName){
		checkValidate = "";
		var result = true;
        var numPattern1 = /[0-9]/;
        var EngPattern2 = /[a-zA-Z]/;
        var spPattern3 = /[.~!@\#$%<>^&*]/;
        var korPattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
        var pointPattern = /[.]/;
        var pointPattern2 = /[~!@\#$%<>^&*]/;
        
		// 기본 String validate
        // 클래스에 required 선언
		$('#'+tunnelName).find('.required').each(function(i){
			var val = $(this).val();
			var val_name = $(this).parent('td').prev('th').text().replace("*","");
			if("" == val_name || undefined == val_name){
				val_name = $(this).attr("data-validate-feild");
			}
			if(!val){
				openDefaultPopup("loginPopup" , val_name + "을(를) 입력해주시기 바랍니다.");
				result = false;
				console.log(i);
				checkValidate = $(this).attr("id");
				return false;
			}
		});
		// 기본 String validate ( Table 구조가 다른 등록화면 )
        // 클래스에 required 선언
		$('#'+tunnelName).find('.required_regi').each(function(i){
			var val = $(this).val();
			var val_name = $(this).prev('.td-title01').text().replace("*","");
			if(!val){
				openDefaultPopup("loginPopup" , val_name + "을(를) 입력해주시기 바랍니다.");
				result = false;
				console.log(i);
				checkValidate = $(this).attr("id");
				return false;
			}
		});
		if(null == checkValidate || "" == checkValidate){
			$('#'+tunnelName).find('.required_pop').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(!val){
					$('.required_resultPop').text(val_name+"을(를) 입력해주시기 바랍니다.");
					$('.required_resultPop').show();
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		// 기본 String validate
		// 클래스에 required 선언
		
		if(null == checkValidate || "" == checkValidate){
			// Number validate ( 숫자만 입력가능 )
			// 클래스에 required_num 선언
			$('#'+tunnelName).find('.required_num').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if("" == val_name){
					val_name = $(this).attr("data-validate-feild");
				}
				if(EngPattern2.test(val)||spPattern3.test(val)||korPattern.test(val)){
					openDefaultPopup("loginPopup" , val_name+"은(는) 숫자만 입력가능합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		
		if(null == checkValidate || "" == checkValidate){
			// Number validate ( 숫자만 입력가능 )
			// 클래스에 required_num 선언
			$('#'+tunnelName).find('.required_num_pop').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(EngPattern2.test(val)||spPattern3.test(val)||korPattern.test(val)){
					$('.required_resultPop').text(val_name+"은(는) 숫자만 입력가능합니다.");
					$('.required_resultPop').show();
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		if(null == checkValidate || "" == checkValidate){
			// char validate ( 숫자/문자만 입력가능 , 특수문자 불가 )
			// 클래스에 required_char 선언
			$('#'+tunnelName).find('.required_char').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(spPattern3.test(val)){
					openDefaultPopup("loginPopup" , val_name+"은(는) 숫자/문자만 입력 가능합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		
		if(null == checkValidate || "" == checkValidate){
			// kor validate ( 한글만 입력가능 )
			// 클래스에 required_ko 선언
			$('#'+tunnelName).find('.required_ko').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(EngPattern2.test(val)||spPattern3.test(val)){
					openDefaultPopup("loginPopup" , val_name+"은(는) 한글/숫자만 입력 가능합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		if(null == checkValidate || "" == checkValidate){
			// eng validate ( 영문만 입력가능 )
			// 클래스에 required_ko 선언
			$('#'+tunnelName).find('.required_eng').each(function(){
				var val = $(this).val();
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(spPattern3.test(val)||korPattern.test(val)){
					openDefaultPopup("loginPopup" , val_name+"은(는) 영문/숫자만 입력 가능합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		
		if(null == checkValidate || "" == checkValidate){
			// Min validate
			// 최소 입력값체크
			// 필수 Parameter : 해당 element에 data-minlen='최소값'
			// 클래스에 required_min 선언
			$('#'+tunnelName).find('.required_min').each(function(){
				var val = $(this).val();
				var min_length = $(this).attr('data-minlen');
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(min_length>val.length){
					openDefaultPopup("loginPopup" , val_name+"은(는) 최소 " + min_length + "자 이상 입력해야 합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		
		if(null == checkValidate || "" == checkValidate){
			// Max validate
			// 최대 입력값체크
			// 필수 Parameter : 해당 element에 data-maxLen='최대값'
			// 클래스에 required_max 선언
			$('#'+tunnelName).find('.required_max').each(function(){
				var val = $(this).val();
				var max_length = $(this).data('maxlen');
				var val_name = $(this).parent('td').prev('th').text().replace("*","");
				if(!val){
					openDefaultPopup("loginPopup" , val_name + "은(는) 필수입니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
				if(max_length<val.length){
					openDefaultPopup("loginPopup" , val_name + "은(는) 최대 " + max_length + "자 까지 입력 가능합니다.");
					result = false;
					checkValidate = $(this).attr("id");
					return false;
				}
			});
		}
		
		if(null == checkValidate || "" == checkValidate){
			// char validate ( 숫자/문자만 입력가능 , 특수문자 불가 )
			// 클래스에 required_char 선언
			$('#'+tunnelName).find('.required_point').each(function(){
				var val = $(this).val();
				var objEvent = event.srcElement;
		        if(pointPattern2.test(val)||EngPattern2.test(val) || korPattern.test(val)){
		        	openDefaultPopup("loginPopup" , "숫자/.(소수점)만 입력 가능합니다.");
		        	$(this).val(objEvent.value.replace(/[\{\}\[\]\/?,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, ''));
					$(this).val(objEvent.value.replace(/[a-zA-Z]/gi, ''));
					$(this).val(objEvent.value.replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi, ''));
					objEvent.focus();
					result = false;
		        	return false;
		        }
			});
		}
		return result;
	}
	
	// Input IME 체크
	// 한글은 onkeyPress 로 해당 Function 적용
	// 영문 / 숫자 모드의 경우 onkeyup 이벤트로 적용 
	// popGubun : pupup 구분 ( Y - 팝업 , N - 일반 )
	// mode : input mode 구분 ( kor - 한글 , eng - 영문 , num - 숫자 ) 
	function fn_inputImeChk(popGubun,mode) {
		
        var numPattern1 = /[0-9]/;
        var EngPattern2 = /[a-zA-Z]/;
        var spPattern3 = /[.~!@\#$%<>^&*]/;
        var korPattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		
		// 한글체크
		if(mode=="kor"){
			// 예외 : space 허용
			if( (event.keyCode != 32) ){
				if( (event.keyCode < 12592) || (event.keyCode > 12687)){
					var objEvent = event.srcElement;
					if(popGubun=="Y"){
						$('.byteResult_pop').text("한글만 입력가능 합니다");
					}else if(popGubun=="N"){
						openDefaultPopup("loginPopup" , "한글만 입력 가능합니다.");
					}
					objEvent.value = objEvent.value.replace(/[(0-9)]/gi, '');
					objEvent.value = objEvent.value.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, '');
					objEvent.value = objEvent.value.replace(/[a-zA-Z]/gi, '');
					objEvent.focus();
					return false;
				}
			}
		}
		
		// 영문체크
		if(mode=="eng"){
			// 예외 : space , backspace 허용
			if( (event.keyCode != 32) && (event.keyCode != 8) ){
				var keyVal = event.srcElement.value;
				if( numPattern1.test(keyVal) || spPattern3.test(keyVal) || korPattern.test(keyVal) ){
					var objEvent = event.srcElement;
					if(popGubun=="Y"){
						$('.byteResult_pop').text("영문만 입력가능 합니다");
					}else if(popGubun=="N"){
						openDefaultPopup("loginPopup" , "영문만 입력 가능합니다.");
					}
					objEvent.value = objEvent.value.replace(/[(0-9)]/gi, '');
					objEvent.value = objEvent.value.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, '');
					objEvent.value = objEvent.value.replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi, '');
					objEvent.focus();
					return false;
				}
			}
		}
		
		// 숫자체크
		if(mode=="num"){
			// 예외 : space , backspace 허용
			if( (event.keyCode != 32) && (event.keyCode != 8) ){
				var keyVal = event.srcElement.value;
				if( EngPattern2.test(keyVal) || spPattern3.test(keyVal) || korPattern.test(keyVal) ){
					var objEvent = event.srcElement;
					if(popGubun=="Y"){
						$('.byteResult_pop').text("숫자만 입력가능 합니다");
					}else if(popGubun=="N"){
						openDefaultPopup("loginPopup" , "숫자만 입력 가능합니다.");
					}
					objEvent.value = objEvent.value.replace(/[^(0-9)]/gi, '');
					objEvent.focus();
					return false;
				}
			}
		}
		
		if(mode=="ke"){
			// 예외 : space 허용
			if( (event.keyCode != 32) && (event.keyCode != 8) ){
				var keyVal = event.srcElement.value;
				if( numPattern1.test(keyVal) || spPattern3.test(keyVal)){
					var objEvent = event.srcElement;
					if(popGubun=="Y"){
						$('.byteResult_pop').text("국문/영문만 입력가능 합니다");
					}else if(popGubun=="N"){
						openDefaultPopup("loginPopup" , "국문/영문만 입력 가능합니다.");
					}
					objEvent.value = objEvent.value.replace(/[(0-9)]/gi, '');
					objEvent.value = objEvent.value.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, '');
					objEvent.focus();
					return false;
				}
			}
		}
	}
	
	function fn_bindEnterAntion(){
		$('.m-form-table').find("input[type='text']").keydown(function(e){
			e.stopPropagation();
			// enter
			if(e.keyCode == '13'){
				fn_searchList('1');
				return false;
			}
		});
		
	}
	
	function fn_cctvLiveHide(){
		var flag = $('.live_img').is(':visible');
		console.log( " flag : " + flag );
		if(flag){
			$(".live_img").hide();
			$(".live_blank_img").show();
		}else{
			$(".live_blank_img").hide();
			$(".live_img").show();
		}
	}
	
	function fn_fullScreen(){
		var doc = window.document;
		  var docEl = doc.documentElement;

		  var requestFullScreen = docEl.requestFullscreen || docEl.mozRequestFullScreen || docEl.webkitRequestFullScreen || docEl.msRequestFullscreen;
		  var cancelFullScreen = doc.exitFullscreen || doc.mozCancelFullScreen || doc.webkitExitFullscreen || doc.msExitFullscreen;

		  if(!doc.fullscreenElement && !doc.mozFullScreenElement && !doc.webkitFullscreenElement && !doc.msFullscreenElement) {
		    requestFullScreen.call(docEl);
		  }
		  else {
		    cancelFullScreen.call(doc);
		  }
	}
	
	function fn_goLocationMonitoring(menu_id, building_id, zone_id, cell_id) {
		
		var event_location = building_id + "|" + zone_id + "|" + cell_id;
		
		if(menu_id == 'MENU_LOCATION') //위치관제 
			fn_movePageForAlarm('21', event_location);
		else if(menu_id == 'MENU_TC') //타워크레인 
			fn_movePageForAlarm('230', event_location);
		else if(menu_id == 'MENU_STRICTURE') //장비협착 
			fn_movePageForAlarm('301', event_location);
		else if(menu_id == 'MENU_RETAIN') // 흙막이 
			fn_movePageForAlarm('511', event_location);
		else if(menu_id == 'MENU_FEVER') // 감염관제 
			fn_movePageForAlarm('2000', event_location);
		else if(menu_id == 'MENU_WATER') // 침수/수위 
			fn_movePageForAlarm('3000', event_location);
		else if(menu_id == 'MENU_OILMIST') // 유증기 
			fn_movePageForAlarm('4000', event_location);

	}

	