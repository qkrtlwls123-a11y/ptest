/**
@file screenHelper.js
@date 2021/01/09
@author sykim (johnnyf.kim@sgsone.com)
@version 1.0
@brief 스크린 제어 관련 
*/

	
	/**
	@fn function fn_openFullScreenMode(userDefFunc)
	@brief 현황판 모드 처리 함수 .
	@date 2021/01/09
	@author sykim (johnnyf.kim@sgsone.com)
	@param userDefFunc 호출 페이지에서 처리해야할 함수.
	@return None
	@exception None
	@remark 현황판 모드 처리 함수
	*/
	function fn_openFullScreenMode(fullMode, userDefFunc, isCctv){
						
		$('.menu-toggle-close').click();
		var agent = navigator.userAgent.toLowerCase();
		
		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
			fn_fullScreen();
		}
		$.ajax({
			url : "/click/selectNotice.json",
			type : "POST",
			success : function(result) {
				openFullScreenMode();
				$("#wrap").removeClass(fullMode);
				$("#wrap").removeClass("no-notice");
				$("#wrap").addClass(fullMode);
				$(".con-wrap").css("width", "100%");
				$(".con-wrap").css("margin-left", "0px");
				$("#full_screen_yn").val("Y");

				//$("#mycanvas").css("height", 900 +"px");
				
				var height = $(".con-area").height()-2;
				$("#mycanvas").attr("height", height+"px");

				if(userDefFunc != null) {
					userDefFunc(result.noticeVO.site_notice_yn);
				}
				
				if(isCctv == 'Y') {
					return ;
				}


				if(result.noticeVO.site_notice_yn == 'Y'){
					var htmlString = '<p class="pArea">'+result.noticeVO.site_notice+'</p>';
					$(".page-navigation").css("width", "97%");
					$(".page-navigation").append(htmlString);
				}else{
					$("#wrap").addClass("no-notice");
					$(".page-navigation").css("width", "40%");
					$(".pArea").remove();
				}
								
				fnInit();
				openToastPopup();
			}
		});
	}
	
	// 전체화면 설정
	function openFullScreenMode() {
	    if (docV.webkitRequestFullscreen) // Chrome, Safari (webkit)
	        docV.webkitRequestFullscreen();
	    else if (docV.mozRequestFullScreen) // Firefox
	        docV.mozRequestFullScreen();
	    else if (docV.msRequestFullscreen) // IE or Edge
	        docV.msRequestFullscreen();
	}
	
	function fn_closeFullScreenMode(isCctv, userDefFunc){
		
		var agent = navigator.userAgent.toLowerCase();
		if("Y" == $("#cctv_full_screen_yn").val()){
			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
				fn_fullScreen();
			}
			location.reload();
		}
		else if("Y" == $("#full_screen_yn").val()){

			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
				fn_fullScreen();
			}
		}
		
		
		closeFullScreenMode();
						
		if(isCctv == 'Y') {
			$("#cctv_full_screen_yn").val("N");
			$("#slcFlow02").removeClass("cctv-fullMode-n4");
			$("#slcFlow03").removeClass("cctv-fullMode-n9");
		} else {
			$("#full_screen_yn").val("N");
		}

		if($("#wrap").hasClass("fullMode")) {
			$("#wrap").removeClass("fullMode");
		}
		if($("#wrap").hasClass("fullMode2Area")) {
			$("#wrap").removeClass("fullMode2Area");
		}

		$("#wrap").removeClass("no-notice");
		
		$(".con-wrap").css("width", "calc(100% - 70px)");
		$(".con-wrap").css("margin-left", "70px");

		$(".page-navigation").css("width", "50%");
		$(".pArea").remove();
		
		
		if(isCctv != 'Y') {
			fnInit();
		}
		
		if(userDefFunc != null) {
			userDefFunc();
		}
	}
	
	// 전체화면 해제
	function closeFullScreenMode() {
	    if (document.webkitExitFullscreen)
    	{
	    	// Chrome, Safari (webkit)
	        document.webkitExitFullscreen();
    	}
	    else if (document.mozCancelFullScreen) 
	    {
	    	// Firefox
	        document.mozCancelFullScreen();
	    }
	    else if (document.msExitFullscreen) 
	    {
	    	// IE or Edge
	        document.msExitFullscreen();
	    }
	}