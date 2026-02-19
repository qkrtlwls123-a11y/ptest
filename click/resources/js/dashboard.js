		var scene = '';
		var mapTimer = 0;
		var mapStatus = false;
		var docV = document.documentElement;
		var callDash = 0;
		var objData;
		var dashResult;
		var elevationTotal = 0;
		var gasIndex = 0;
		
		// 대시보드 설정 리스트
		$(function(){
			
			fn_dashStart();
			clearInterval(dashTimer);
			dashTimer = setInterval("fn_dashStart()", 5000);
			// Closure
			(function() {
			  /**
			   * Decimal adjustment of a number.
			   *
			   * @param {String}  type  The type of adjustment.
			   * @param {Number}  value The number.
			   * @param {Integer} exp   The exponent (the 10 logarithm of the adjustment base).
			   * @returns {Number} The adjusted value.
			   */
			  function decimalAdjust(type, value, exp) {
			    // If the exp is undefined or zero...
			    if (typeof exp === 'undefined' || +exp === 0) {
			      return Math[type](value);
			    }
			    value = +value;
			    exp = +exp;
			    // If the value is not a number or the exp is not an integer...
			    if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0)) {
			      return NaN;
			    }
			    // Shift
			    value = value.toString().split('e');
			    value = Math[type](+(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp)));
			    // Shift back
			    value = value.toString().split('e');
			    return +(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp));
			  }

			  // Decimal round
			  if (!Math.round10) {
			    Math.round10 = function(value, exp) {
			      return decimalAdjust('round', value, exp);
			    };
			  }
			  // Decimal floor
			  if (!Math.floor10) {
			    Math.floor10 = function(value, exp) {
			      return decimalAdjust('floor', value, exp);
			    };
			  }
			  // Decimal ceil
			  if (!Math.ceil10) {
			    Math.ceil10 = function(value, exp) {
			      return decimalAdjust('ceil', value, exp);
			    };
			  }
			})();
			
		})
		
		// 대시보드 설정 및 데이터 가져오기
		function fn_dashStart(){
			var dashTypeId = "";	// 대시보드 타입 ID
			var objName = "";
			if(callDash == 0){
				var params = $("form[name=dashParameterVO]").serialize();
				$.ajax({
					url : "/click/selectDashContent.json",
					type : "POST",
					data: params,
					success : function(result) {
						
						dashResult = result;
						dashTypeId = result.dashList.type_id;
						// 데이터 체크
						
						for(var i=0;i<result.dashList.frame_count;i++){
							objName = "dashSiteList"+(i+1);
							objData = result[objName];
							if( null != objData ){
								// console.log( " 프레임 번호 " + objData.frame_id + " 에 담겨있는 컨텐츠 번호 : " + objData.ctnts_id );
								// 
								fn_getContentData(objData.frame_id, objData.ctnts_id, objData.ctnts_refrash, callDash, objData.ctnts_menu_id , objData.menu_id , objData.ctnts_rolling_type , objData.ctnts_fix_type_1 , objData.ctnts_fix_type_2 , objData.ctnts_fix_type_3 , objData.ctnts_fix_type_4 );
								
								if(!isEmpty(objData.zone_id)){
									$("#zone_id").val(objData.zone_id);
									$("#building_id").val(objData.building_id);
									if(!isEmpty(objData.cell_id)){
										$("#cell_id").val(objData.cell_id);
										$("#poi_id").val(result.poiVO.poi_id);
									}
									scene = result.sceneVO.scene_id;
								}else if(undefined != objData.building_id && null != objData.building_id && '' != objData.building_id){
									//$("#building_id").val(objData.building_id);
									//$("#zone_id").val(result.sceneVO.zone_id);

									scene = result.sceneVO.scene_id;
								}else if(!isEmpty(result.sceneVO)){
									scene = result.sceneVO.scene_id;
								}
								
								$("#scene_id").val(scene);							
							}
						}
						
						callDash++;
					}
				});
			}else{
				if(!isEmpty(dashResult)){
					dashTypeId = dashResult.dashList.type_id;
					// 데이터 체크
					for(var i=0;i<dashResult.dashList.frame_count;i++){
						objName = "dashSiteList"+(i+1);
						objData = dashResult[objName];
						if( null != objData ){
							// console.log( " 프레임 번호 " + objData.frame_id + " 에 담겨있는 컨텐츠 번호 : " + objData.ctnts_id );
							// 
							fn_getContentData(objData.frame_id, objData.ctnts_id, objData.ctnts_refrash, callDash, objData.ctnts_menu_id , objData.menu_id , objData.ctnts_rolling_type , objData.ctnts_fix_type_1 , objData.ctnts_fix_type_2 , objData.ctnts_fix_type_3 , objData.ctnts_fix_type_4 );
							if(!isEmpty(objData.zone_id)){
								$("#zone_id").val(objData.zone_id);
								$("#building_id").val(objData.building_id);
								scene = dashResult.sceneVO.scene_id;
							}else if(undefined != objData.building_id && null != objData.building_id && '' != objData.building_id){
								$("#building_id").val(objData.building_id);
								scene = dashResult.sceneVO.scene_id;
							}
							$("#scene_id").val(scene);							
						}
					}
					
					callDash++;
				}
			}
		}

		// 각 컨테츠별 데이터 가져오기
		// parameter : ctntsId(컨텐츠 ID)
		function fn_getContentData(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId,menuId , ctntsRollingType , ctntsFixType1 , ctntsFixType2 , ctntsFixType3 , ctntsFixType4 ){
			// 타입별 총 56개 항목
			// 각 항목 함수로 정의할 것
			switch(ctntsId) {
				case "1" :
					// 근로자현황(Text)1*1
					fn_workerProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "2" :
					// 근로자현황(Graph)1*1
					fn_workerProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "3" :
					// 가스현황1*1
					fn_GasProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "4" :
					// 장비현황1*1
					fn_workerProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "5" :
					// 공정율현황1*1
					fn_tunnelProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "6" :
					// 굴진율현황1*1
					fn_tunnelProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "7" :
					// T/C현황1*1
					fn_towerCraneProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "8" :
					// 가상센서(AWS)1*1
					fn_enviProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "9" :
					// 미세먼지센서1*1
					fn_enviProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "10" :
					// 소음센서1*1
					fn_enviProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "11" :
					// 진동센서1*1
					fn_enviProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "12" :
					// 흙막이현황1*1
					fn_retainProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "13" :
					// 장비협착현황1*1
					fn_equipProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "14" :
					// CCTV현황1*1
					fn_cctvProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId,menuId, ctntsRollingType , ctntsFixType1 , ctntsFixType2 , ctntsFixType3 , ctntsFixType4);
					break;
				case "15" :
					// 당일 이벤트 현황(Text)1*1
					fn_eventProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "16" :
					// 당일 이벤트 현황(Graph)1*1
					fn_eventProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "17" :
					// 근로자/가스/장비 현황3*1
					fn_workerProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "18" :
					// 공정율/굴진율현황3*1
					fn_tunnelProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "19" :
					fn_towerCraneProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					// T/C현황3*1
					break;
				case "20" :
					// 환경센서현황3*1
					fn_enviProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "21" :
					// 흙막이현황3*1
					fn_retainProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "22" :
					// 장비협착현황3*1
					fn_equipProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "23" :
					// CCTV현황3*1
					fn_cctvProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId,menuId, ctntsRollingType , ctntsFixType1 , ctntsFixType2 , ctntsFixType3 , ctntsFixType4);
					break;
				case "24" :
					// 위치관제현황(Map)3*2
					fn_locationMapProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "25" :
					// 근로자현황(Graph)3*2
					fn_workerProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "26" :
					// 가스관제현황3*2
					fn_GasProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "27" :
					fn_tunnelProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					// 굴진율현황(입면도)3*2
					break;
				case "28" :
					fn_towerCraneProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					// T/C현황(MAP)3*2
					break;
				case "29" :
					// 환경센서현황3*2
					fn_enviProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "30" :
					// CCTV현황3*2
					fn_cctvProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId,menuId , ctntsRollingType , ctntsFixType1 , ctntsFixType2 , ctntsFixType3 , ctntsFixType4);
					break;
				case "31" :
					// 근로자/가스/장비 현황4*1
					fn_workerProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "32" :
					// 가스관제현황4*1
					fn_GasProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "33" :
					// 공정율/굴진율현황4*1
					fn_tunnelProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "34" :
					// T/C현황4*1
					fn_towerCraneProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "35" :
					// 환경센서현황4*1
					fn_enviProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "36" :
					// CCTV현황4*1
					fn_cctvProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId,menuId , ctntsRollingType , ctntsFixType1 , ctntsFixType2 , ctntsFixType3 , ctntsFixType4);
					break;
				case "37" :
					// 위치관제현황(Map)4*2
					fn_locationMapProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "38" :
					// 근로자현황(Graph)4*2
					fn_workerProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "39" :
					// 가스관제현황4*2
					fn_GasProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "40" :
					fn_tunnelProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					// 공정율/굴진율현황(입면도)4*2
					break;
				case "41" :
					fn_towerCraneProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					// T/C현황(MAP)4*2
					break;
				case "42" :
					// CCTV현황4*2
					fn_cctvProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId,menuId , ctntsRollingType , ctntsFixType1 , ctntsFixType2 , ctntsFixType3 , ctntsFixType4);
					break;
				case "43" :
					// 위치관제현황(Map)4*3
					fn_locationMapProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "44" :
					// 근로자현황(Graph)4*3
					fn_workerProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "45" :
					// 가스관제현황4*3
					fn_GasProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "46" :
					fn_tunnelProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					// 공정율/굴진율현황(입면도)4*3
					break;
				case "47" :
					// T/C현황(MAP)4*3
					fn_towerCraneProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "48" :
					// CCTV현황4*3
					fn_cctvProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId,menuId , ctntsRollingType , ctntsFixType1 , ctntsFixType2 , ctntsFixType3 , ctntsFixType4);
					break;
				case "49" :
					// 위치관제현황(Map)2.5*3
					fn_locationMapProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "50" :
					// 가스관제현황2.5*3
					fn_GasProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "51" :
					fn_tunnelProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					// 공정율/굴진율현황2.5*3
					break;
				case "52" :
					// T/C현황(MAP)2.5*3
					fn_towerCraneProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "53" :
					// 환경센서현황2.5*3
					fn_enviProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "54" :
					// 흙막이현황2.5*3
					fn_retainProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "55" :
					// 장비협착현황2.5*3
					fn_equipProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId);
					break;
				case "56" :
					// CCTV현황2.5*3
					fn_cctvProcess(frameId,ctntsId,ctntsRefresh,ctntsCall,ctntsMenuId,menuId, ctntsRollingType , ctntsFixType1 , ctntsFixType2 , ctntsFixType3 , ctntsFixType4);
					break;
			}
		}
		// 대시보드 설정
		$('.dashboardSetup-btn').click(function(){
			fn_cctvLiveHide();
			fn_dashboardSettingPopup("dashboardSettingPopup", "");
		});
		// 공지사항 설정
		$('.noticeSetup-btn').click(function(){
			fn_cctvLiveHide(); 
			fn_noticePopup("dashboardNoticePopup", "");
		});
		// 현황판 모드
		$('.dashboardMode-btn').click(function(){
			
			// Full Mode 해제
			var doc = window.document;
			var cancelFullScreen = doc.exitFullscreen || doc.mozCancelFullScreen || doc.webkitExitFullscreen || doc.msExitFullscreen;
			cancelFullScreen.call(doc);
			
			$('.menu-toggle-close').click();
			var agent = navigator.userAgent.toLowerCase();

			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
				fn_fullScreen();
			}
			
			openToastPopup();
			
			$.ajax({
				url : "/click/selectNotice.json",
				type : "POST",
				success : function(result) {
					if(result.noticeVO.site_notice_yn == 'Y'){
						openFullScreenMode();
						$('#fullSceenMode').val("Y");
						$("#wrap").removeClass("fullMode");
						$("#wrap").addClass("fullMode");
						$('.con-wrap').css('width','100%');
						$('.con-wrap').css('marginLeft','0px');
						var htmlString = '<p class="pArea">'+result.noticeVO.site_notice+'</p>';
						
						// 대시보드
						$("#menuId").val("900");
						var params = $("form[name=dashParameterVO]").serialize();
						$.ajax({
							url : "/click/dashboard.do",
							type : "POST",
							data: params,
							success : function(result2) {
								sessionStorage.setItem("nowUrl", "/click/dashboard.do");
								$(".con-wrap").html(result2);
								$(".page-navigation").css("width", "97%");
								$(".page-navigation").append(htmlString);
								fn_bindEnterAntion();
							}
						});
					}else{
						openFullScreenMode();
						$('#fullSceenMode').val("Y");
						$("#wrap").removeClass("fullMode");
						$("#wrap").addClass("fullMode");
						$("#wrap").removeClass("no-notice");
						$("#wrap").addClass("no-notice");
						$('.con-wrap').css('width','100%');
						$('.con-wrap').css('marginLeft','0px');
						
						// 대시보드
						$("#menuId").val("900");
						var params = $("form[name=dashParameterVO]").serialize();
						$.ajax({
							url : "/click/dashboard.do",
							type : "POST",
							data: params,
							success : function(result2) {
								sessionStorage.setItem("nowUrl", "/click/dashboard.do");
								$(".con-wrap").html(result2);
								$(".page-navigation").css("width", "40%");
								$(".pArea").remove();
								fn_bindEnterAntion();
							}
						});
					}
				}
			});
		});
		// 근로자 데이터
		// Paramter : frameId ( 각 프레임의 아이디 ) , process_gubun ( 크기별 구분값 )
		// 1 : 근로자현황(Text)1*1
		// 2 : 근로자현황(Graph)1*1
		function fn_workerProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId){
			console.log("fn_workerProcessfn_workerProcessfn_workerProcessfn_workerProcessfn_workerProcess");
			if(fn_checkRefresh(ctntsRefresh,ctntsMenuId,ctntsCall)){
				var sUrl = "dashLocationProcess.json";
				var sFrameId = "";
				$('#process_gubun').val(process_gubun);

				if( "1" == process_gubun || "2" == process_gubun || "4" == process_gubun || "17" == process_gubun || "25" == process_gubun || "31" == process_gubun || "38" == process_gubun || "44" == process_gubun || "49" == process_gubun){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// ajax 호출
				var params = $("form[name=dashParameterVO]").serialize();
				$.ajax({
					url : "/click/" + sUrl ,
					type : "POST",
					data: params,
					success : function(result) {
						// 1x1 근로자현황 데이터 세팅
						if( "1" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-1-1-workerState').clone(true).show());
							$('#'+sFrameId).find('.worker_count').text(result.workerVO.worker_count);					// 실시간 근로자 수
							$('#'+sFrameId).find('.worker_newCount').text(result.workerVO.new_count);					// 신규 근로자 수
							$('#'+sFrameId).find('.worker_seniorCount').text(result.workerVO.senior_count);				// 고령 근로자 수
							$('#'+sFrameId).find('.worker_nationalityCount').text(result.workerVO.nationality_count);	// 외국인 근로자 수
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						// 1x1 근로자현황(그래프) 데이터 세팅
						if( "2" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-1-1-workerStateGraph').clone(true).show());
							$('#'+sFrameId).find('.worker_count').text(result.workerVO.worker_count);					// 실시간 근로자 수
							$('#'+sFrameId).find('.a-1-1-workerStateGraph').find('.worker-chart-wrap').html('<iframe width="100%" height="120" src="/click/highcharts/type08?chartHeight=100&call_count='+ctntsCall+'"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						// 1x1 장비현황 데이터 세팅
						if( "4" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-1-1-location').clone(true).show());
							$('#'+sFrameId).find('.a-1-1-location').find('.eq-chart-wrap2').html('<iframe width="100%" height="160" src="/click/highcharts/type10?chartHeight=160"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if( "17" == process_gubun ){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.a-3-1-location').attr("id"));
							$('#'+sFrameId).html($('#typeElement').find('.a-3-1-location').clone(true).show());
							$('#'+sFrameId).find('.worker_count').text(result.workerVO.worker_count);					// 실시간 근로자 수
							$('#'+sFrameId).find('.worker_newCount').text(result.workerVO.new_count);					// 신규 근로자 수
							$('#'+sFrameId).find('.worker_seniorCount').text(result.workerVO.senior_count);				// 고령 근로자 수
							$('#'+sFrameId).find('.worker_nationalityCount').text(result.workerVO.nationality_count);	// 외국인 근로자 수
							if( result.gasTotal > 0 ){
								var gasTotal = parseInt(result.gasTotal);
								var nowPage = ctntsCall%gasTotal+1;
								if(parseFloat(result.gasStatusList[(nowPage-1)].oxygen_value) <= parseFloat(result.gasStatusList[(nowPage-1)].oxygen_from) || parseFloat(result.gasStatusList[(nowPage-1)].oxygen_value) >= parseFloat(result.gasStatusList[(nowPage-1)].oxygen_to)){
									$('#'+sFrameId).find(".checkButtonOxygen").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasOxygenValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasOxygenValue').addClass('redTxt');
								}else{
									$('#'+sFrameId).find(".checkButtonOxygen").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasOxygenValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasOxygenValue').addClass('greenTxt');
								}
								
								if(parseFloat(result.gasStatusList[(nowPage-1)].hydrogen_sulfide_value) >= parseFloat(result.gasStatusList[(nowPage-1)].hydrogen)){
									$('#'+sFrameId).find(".checkButtonHydrogen").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').addClass('redTxt');
								}else{
									$('#'+sFrameId).find(".checkButtonHydrogen").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').addClass('greenTxt');
								}
								
								if(parseFloat(result.gasStatusList[(nowPage-1)].carbon_monoxide_value) >= parseFloat(result.gasStatusList[(nowPage-1)].carbon)){
									$('#'+sFrameId).find(".checkButtonCarbon").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').addClass('redTxt');
								}else{
									$('#'+sFrameId).find(".checkButtonCarbon").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').addClass('greenTxt');
								}
								
								if(parseFloat(result.gasStatusList[(nowPage-1)].methan_value) >= parseFloat(result.gasStatusList[(nowPage-1)].methan)){
									$('#'+sFrameId).find(".checkButtonMethan").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasMethanValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasMethanValue').addClass('redTxt');
								}else{
									$('#'+sFrameId).find(".checkButtonMethan").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasMethanValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasMethanValue').addClass('greenTxt');
								}
								
								$('#'+sFrameId).find('.gasPage').html("("+nowPage+"/"+gasTotal+")");
								$('#'+sFrameId).find('.gasStateDeviceNo').text(result.gasStatusList[(nowPage-1)].device_no);						// 가스센서 번호
								if(nowLocale == 'en'){
									$('#'+sFrameId).find('.gasStateBuildingName').text(result.gasStatusList[(nowPage-1)].building_name_eng);				// 구역정보 ( building )
									$('#'+sFrameId).find('.gasStateZoneName').text(result.gasStatusList[(nowPage-1)].floor_eng);						// 구역정보 ( zone )
									$('#'+sFrameId).find('.gasStateCellName').text(result.gasStatusList[(nowPage-1)].cell_name_eng);						// 구역정보 ( cell )
								}else{
									$('#'+sFrameId).find('.gasStateBuildingName').text(result.gasStatusList[(nowPage-1)].building_name);				// 구역정보 ( building )
									$('#'+sFrameId).find('.gasStateZoneName').text(result.gasStatusList[(nowPage-1)].zone_name);						// 구역정보 ( zone )
									$('#'+sFrameId).find('.gasStateCellName').text(result.gasStatusList[(nowPage-1)].cell_name);						// 구역정보 ( cell )
								}
								$('#'+sFrameId).find('.gasOxygenValue').text(result.gasStatusList[(nowPage-1)].oxygen_value);						// O2
								$('#'+sFrameId).find('.gasHydrogenSulfideValue').text(result.gasStatusList[(nowPage-1)].hydrogen_sulfide_value);	// H2S
								$('#'+sFrameId).find('.gasCarbonMonoxideValue').text(result.gasStatusList[(nowPage-1)].carbon_monoxide_value);	// CO
								$('#'+sFrameId).find('.gasMethanValue').text(result.gasStatusList[(nowPage-1)].methan_value);						// CH
							}
							$('#'+sFrameId).find('.a-3-1-location').find('.eq-chart-wrap').html('<iframe width="100%" height="160" src="/click/highcharts/type10?chartHeight=160"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if( "25" == process_gubun ){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.a-3-2-location').attr("id"));
							$('#'+sFrameId).html($('#typeElement').find('.a-3-2-location').clone(true).show());
							$('#'+sFrameId).find('.a-3-2-location').find('.work-chart-wrap2').html('<iframe width="100%" height="300" src="/click/highcharts/type08?chartHeight=260&call_count='+ctntsCall+'"></iframe>');
							$('#'+sFrameId).find('.a-3-2-location').find('.work-chart-wrap').html('<iframe width="100%" height="350" src="/click/highcharts/type14?chartHeight=330&call_count='+ctntsCall+'"></iframe>');
							$('#'+sFrameId).find('.worker_count').text(result.workerVO.worker_count);
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if( "31" == process_gubun ){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.b-4-1-location').attr("id"));
							$('#'+sFrameId).html($('#typeElement').find('.b-4-1-location').clone(true).show());
							$('#'+sFrameId).find('.worker_count').text(result.workerVO.worker_count);					// 실시간 근로자 수
							$('#'+sFrameId).find('.worker_newCount').text(result.workerVO.new_count);					// 신규 근로자 수
							$('#'+sFrameId).find('.worker_seniorCount').text(result.workerVO.senior_count);				// 고령 근로자 수
							$('#'+sFrameId).find('.worker_nationalityCount').text(result.workerVO.nationality_count);	// 외국인 근로자 수
							if( result.gasTotal > 0 ){
								var gasTotal = parseInt(result.gasTotal);
								var nowPage = ctntsCall%gasTotal+1;
								if(parseFloat(result.gasStatusList[(nowPage-1)].oxygen_value) <= parseFloat(result.gasStatusList[(nowPage-1)].oxygen_from)
										|| parseFloat(result.gasStatusList[(nowPage-1)].oxygen_value) >= parseFloat(result.gasStatusList[(nowPage-1)].oxygen_to)){
									$('#'+sFrameId).find(".checkButtonOxygen").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasOxygenValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasOxygenValue').addClass('redTxt');
								}else{
									$('#'+sFrameId).find(".checkButtonOxygen").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasOxygenValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasOxygenValue').addClass('greenTxt');
								}
								
								if(parseFloat(result.gasStatusList[(nowPage-1)].hydrogen_sulfide_value) >= parseFloat(result.gasStatusList[(nowPage-1)].hydrogen)){
									$('#'+sFrameId).find(".checkButtonHydrogen").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').addClass('redTxt');
								}else{
									$('#'+sFrameId).find(".checkButtonHydrogen").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').addClass('greenTxt');
								}
								
								if(parseFloat(result.gasStatusList[(nowPage-1)].carbon_monoxide_value) >= parseFloat(result.gasStatusList[(nowPage-1)].carbon)){
									$('#'+sFrameId).find(".checkButtonCarbon").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').addClass('redTxt');
								}else{
									$('#'+sFrameId).find(".checkButtonCarbon").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').addClass('greenTxt');
								}
								
								if(parseFloat(result.gasStatusList[(nowPage-1)].methan_value) >= parseFloat(result.gasStatusList[(nowPage-1)].methan)){
									$('#'+sFrameId).find(".checkButtonMethan").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasMethanValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasMethanValue').addClass('redTxt');
								}else{
									$('#'+sFrameId).find(".checkButtonMethan").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasMethanValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasMethanValue').addClass('greenTxt');
								}
								
								$('#'+sFrameId).find('.gasPage').html("("+nowPage+"/"+gasTotal+")");
								$('#'+sFrameId).find('.gasStateDeviceNo').text(result.gasStatusList[(nowPage-1)].device_no);						// 가스센서 번호
								if(nowLocale == 'en'){
									$('#'+sFrameId).find('.gasStateBuildingName').text(result.gasStatusList[(nowPage-1)].building_name_eng);				// 구역정보 ( building )
									$('#'+sFrameId).find('.gasStateZoneName').text(result.gasStatusList[(nowPage-1)].floor_eng);						// 구역정보 ( zone )
									$('#'+sFrameId).find('.gasStateCellName').text(result.gasStatusList[(nowPage-1)].cell_name_eng);						// 구역정보 ( cell )
								}else{
									$('#'+sFrameId).find('.gasStateBuildingName').text(result.gasStatusList[(nowPage-1)].building_name);				// 구역정보 ( building )
									$('#'+sFrameId).find('.gasStateZoneName').text(result.gasStatusList[(nowPage-1)].zone_name);						// 구역정보 ( zone )
									$('#'+sFrameId).find('.gasStateCellName').text(result.gasStatusList[(nowPage-1)].cell_name);						// 구역정보 ( cell )
								}
								
								$('#'+sFrameId).find('.gasOxygenValue').text(result.gasStatusList[(nowPage-1)].oxygen_value);						// O2
								$('#'+sFrameId).find('.gasHydrogenSulfideValue').text(result.gasStatusList[(nowPage-1)].hydrogen_sulfide_value);	// H2S
								$('#'+sFrameId).find('.gasCarbonMonoxideValue').text(result.gasStatusList[(nowPage-1)].carbon_monoxide_value);	// CO
								$('#'+sFrameId).find('.gasMethanValue').text(result.gasStatusList[(nowPage-1)].methan_value);						// CH
							}
							
							$('#'+sFrameId).find('.b-4-1-location').find('.locationEventCount').html(result.eventVO.event_total);
							$('#'+sFrameId).find('.b-4-1-location').find('.worker-chart-wrap').html('<iframe width="100%" height="160" src="/click/highcharts/type08?chartHeight=140&call_count='+ctntsCall+'"></iframe>');
							$('#'+sFrameId).find('.b-4-1-location').find('.eq-chart-area').html('<iframe width="100%" height="160" src="/click/highcharts/type10?chartHeight=160"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if( "38" == process_gubun ){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.b-4-2-location').attr("id"));
							$('#'+sFrameId).html($('#typeElement').find('.b-4-2-location').clone(true).show());
							$('#'+sFrameId).find('.b-4-2-location').find('.work-chart-wrap3').html('<iframe width="100%" height="380" src="/click/highcharts/type08?chartHeight=360&call_count='+ctntsCall+'"></iframe>');
							$('#'+sFrameId).find('.worker_count').text(result.workerVO.worker_count);
							$('#'+sFrameId).find('.b-4-2-location').find('.locationEventCount').html(result.eventVO.event_total);
							$('#'+sFrameId).find('.b-4-2-location').find('.work-chart-wrap4').html('<iframe width="100%" height="380" src="/click/highcharts/type14?chartHeight=360&call_count='+ctntsCall+'"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if( "44" == process_gubun ){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.c-4-3-location').attr("id"));
							$('#'+sFrameId).html($('#typeElement').find('.c-4-3-location').clone(true).show());
							$('#'+sFrameId).find('.c-4-3-location').find('.work-chart-wrap3').html('<iframe width="100%" height="280" src="/click/highcharts/type08?chartHeight=260&call_count='+ctntsCall+'"></iframe>');
							$('#'+sFrameId).find('.worker_count').text(result.workerVO.worker_count);
							$('#'+sFrameId).find('.c-4-3-location').find('.work-chart-wrap').html('<iframe width="100%" height="320" src="/click/highcharts/type14?chartHeight=300&call_count='+ctntsCall+'"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if( "49" == process_gubun ){
							$('#'+sFrameId).find('.d-2-3-locationMap').find('.work-chart-wrap').html('<iframe width="100%" height="200" src="/click/highcharts/type08?chartHeight=180&call_count='+ctntsCall+'"></iframe>');
							$('#'+sFrameId).find('.worker_count').text(result.workerVO.worker_count);
							$('#'+sFrameId).find('.d-2-3-locationMap').find('.locationEventCount').html(result.eventVO.event_total);
							fn_goMenu(sFrameId, ctntsMenuId);
						}
					}
				});
			}
		}
		// 가스 데이터 00
		// Paramter : frameId ( 각 프레임의 아이디 ) , process_gubun ( 크기별 구분값 )
		// 3 : 가스현황1*1
		// 26 : 가스관제현황3*2
		function fn_GasProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId){
			if(fn_checkRefresh(ctntsRefresh,ctntsMenuId,ctntsCall)){
				var sUrl = "dashLocationProcess.json";
				var sFrameId = "";
				$('#process_gubun').val(process_gubun);
				
				if( "3" == process_gubun || "17" == process_gubun || "26" == process_gubun || "32" == process_gubun || "39" == process_gubun || "45" == process_gubun || "50" == process_gubun){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}

				// ajax 호출
				var params = $("form[name=dashParameterVO]").serialize();
				$.ajax({
					url : "/click/" + sUrl ,
					type : "POST",
					data: params,
					success : function(result) {
						// 1x1 가스현황 데이터 세팅
						if( "3" == process_gubun ){
							$('#'+sFrameId).addClass('atype-layout');
							$('#'+sFrameId).html($('#typeElement').find('.a-1-1-gasState').clone(true).show());
							if( result.gasTotal > 0 ){
								var gasTotal = parseInt(result.gasTotal);
								var nowPage = ctntsCall%gasTotal+1;
								var statusO = 'S';
								var statusH = 'S';
								var statusC = 'S';
								var statusM = 'S';
								if(parseFloat(result.gasStatusList[(nowPage-1)].oxygen_value) <= parseFloat(result.gasStatusList[(nowPage-1)].oxygen_from)
										|| parseFloat(result.gasStatusList[(nowPage-1)].oxygen_value) >= parseFloat(result.gasStatusList[(nowPage-1)].oxygen_to)){
									$('#'+sFrameId).find(".checkButtonOxygen").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasOxygenValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasOxygenValue').addClass('redTxt');
									statusO = 'C';
								}else{
									$('#'+sFrameId).find(".checkButtonOxygen").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasOxygenValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasOxygenValue').addClass('greenTxt');
								}
								
								if(parseFloat(result.gasStatusList[(nowPage-1)].hydrogen_sulfide_value) >= parseFloat(result.gasStatusList[(nowPage-1)].hydrogen)){
									$('#'+sFrameId).find(".checkButtonHydrogen").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').addClass('redTxt');
									statusH = 'C';
								}else{
									$('#'+sFrameId).find(".checkButtonHydrogen").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasHydrogenSulfideValue').addClass('greenTxt');
								}
								
								if(parseFloat(result.gasStatusList[(nowPage-1)].carbon_monoxide_value) >= parseFloat(result.gasStatusList[(nowPage-1)].carbon)){
									$('#'+sFrameId).find(".checkButtonCarbon").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').addClass('redTxt');
									statusC = 'C';
								}else{
									$('#'+sFrameId).find(".checkButtonCarbon").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasCarbonMonoxideValue').addClass('greenTxt');
								}
								
								if(parseFloat(result.gasStatusList[(nowPage-1)].methan_value) >= parseFloat(result.gasStatusList[(nowPage-1)].methan)){
									$('#'+sFrameId).find(".checkButtonMethan").html('<em class="danger">'+txtDanger+'</em>')
									$('#'+sFrameId).find('.gasMethanValue').removeClass('greenTxt');
									$('#'+sFrameId).find('.gasMethanValue').addClass('redTxt');
									statusM = 'C';
								}else{
									$('#'+sFrameId).find(".checkButtonMethan").html('<em class="safe">'+txtSafe+'</em>')
									$('#'+sFrameId).find('.gasMethanValue').removeClass('redTxt');
									$('#'+sFrameId).find('.gasMethanValue').addClass('greenTxt');
								}
								
								$('#'+sFrameId).find('.gasPage').html("("+nowPage+"/"+gasTotal+")");
								$('#'+sFrameId).find('.gasStateDeviceNo').text(result.gasStatusList[(nowPage-1)].device_no);						// 가스센서 번호
								if(nowLocale == 'en'){
									$('#'+sFrameId).find('.gasStateBuildingName').text(result.gasStatusList[(nowPage-1)].building_name_eng);				// 구역정보 ( building )
									$('#'+sFrameId).find('.gasStateZoneName').text(result.gasStatusList[(nowPage-1)].floor_eng);						// 구역정보 ( zone )
									$('#'+sFrameId).find('.gasStateCellName').text(result.gasStatusList[(nowPage-1)].cell_name_eng);						// 구역정보 ( cell )
								}else{
									$('#'+sFrameId).find('.gasStateBuildingName').text(result.gasStatusList[(nowPage-1)].building_name);				// 구역정보 ( building )
									$('#'+sFrameId).find('.gasStateZoneName').text(result.gasStatusList[(nowPage-1)].zone_name);						// 구역정보 ( zone )
									$('#'+sFrameId).find('.gasStateCellName').text(result.gasStatusList[(nowPage-1)].cell_name);						// 구역정보 ( cell )
								}
								$('#'+sFrameId).find('.gasOxygenValue').text(result.gasStatusList[(nowPage-1)].oxygen_value);						// O2
								$('#'+sFrameId).find('.gasHydrogenSulfideValue').text(result.gasStatusList[(nowPage-1)].hydrogen_sulfide_value);	// H2S
								$('#'+sFrameId).find('.gasCarbonMonoxideValue').text(result.gasStatusList[(nowPage-1)].carbon_monoxide_value);	// CO
								$('#'+sFrameId).find('.gasMethanValue').text(result.gasStatusList[(nowPage-1)].methan_value);						// CH
							}
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						// 3x2 가스관제현황 데이터 세팅
						if( "26" == process_gubun ){
							if( result.gasTotal > 0 ){
								
								var gasTotal = parseInt(result.gasTotal);
								var nowPage = ctntsCall%gasTotal+1;
								gasIndex = nowPage-1;
								$('#'+sFrameId).addClass('atype-layout');
								$('#'+sFrameId).html($('#typeElement').find('.a-3-2-gasMonitoring').clone(true).show());
								$('#'+sFrameId).find('.gasDeviceCount').text(result.gasTotal);	
								var statusO = 'S';
								var statusH = 'S';
								var statusC = 'S';
								var statusM = 'S';
								if(result.gasStatusList[gasIndex].oxygen_value <= result.gasStatusList[gasIndex].oxygen_from || result.gasStatusList[gasIndex].oxygen_value >= result.gasStatusList[gasIndex].oxygen_to){
									$('#'+sFrameId).find(".gasStatusArea1").html('<span class="redBg">'+txtDanger+'</span>');
									statusO = 'C';
								}else{
									$('#'+sFrameId).find(".gasStatusArea1").html('<span class="greenBg">'+txtSafe+'</span>');
									
								}
								
								if(result.gasStatusList[gasIndex].hydrogen_sulfide_value >= result.gasStatusList[gasIndex].hydrogen){
									statusH = 'C';
									$('#'+sFrameId).find(".gasStatusArea2").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea2").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].carbon_monoxide_value >= result.gasStatusList[gasIndex].carbon){
									statusC = 'C';
									$('#'+sFrameId).find(".gasStatusArea3").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea3").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].methan_value >= result.gasStatusList[gasIndex].methan){
									statusM = 'C';
									$('#'+sFrameId).find(".gasStatusArea4").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea4").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								$('#'+sFrameId).find('.gasRange1').html(result.gasStatusList[gasIndex].oxygen_from+"~"+result.gasStatusList[gasIndex].oxygen_to);
								$('#'+sFrameId).find('.gasRange2').html(result.gasStatusList[gasIndex].hydrogen);
								$('#'+sFrameId).find('.gasRange3').html(result.gasStatusList[gasIndex].carbon);
								$('#'+sFrameId).find('.gasRange4').html(result.gasStatusList[gasIndex].methan);
								var nowDate = result.gasStatusList[gasIndex].reg_dt;
								nowDate = nowDate.substring(0, 19);
								$('#'+sFrameId).find(".gasStatusDate1").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate2").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate3").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate4").html(nowDate);
								
								$('#'+sFrameId).find('.a-3-2-gasMonitoring').find('.gas-graph-wrap1').html('<iframe width="100%" height="147" src="/click/highcharts/type15?chartHeight=130&status='+statusO+'&gas_value='+result.gasStatusList[gasIndex].oxygen_value+'&gas_type=1"></iframe>');
								$('#'+sFrameId).find('.a-3-2-gasMonitoring').find('.gas-graph-wrap2').html('<iframe width="100%" height="147" src="/click/highcharts/type15?chartHeight=130&status='+statusH+'&gas_value='+result.gasStatusList[gasIndex].carbon_monoxide_value+'&gas_type=2"></iframe>');
								$('#'+sFrameId).find('.a-3-2-gasMonitoring').find('.gas-graph-wrap3').html('<iframe width="100%" height="147" src="/click/highcharts/type15?chartHeight=130&status='+statusC+'&gas_value='+result.gasStatusList[gasIndex].hydrogen_sulfide_value+'&gas_type=3"></iframe>');
								$('#'+sFrameId).find('.a-3-2-gasMonitoring').find('.gas-graph-wrap4').html('<iframe width="100%" height="147" src="/click/highcharts/type15?chartHeight=130&status='+statusM+'&gas_value='+result.gasStatusList[gasIndex].methan_value+'&gas_type=4"></iframe>');
								var htmlString = '';
								for(var j=0;j<result.gasStatusList.length;j++){
									var classString = "";
									if(j == gasIndex){
										classString = "on";
									}
									
									if('en' == nowLocale){
										htmlString += '<li class="'+classString+'"><span>'+txtNo+' '+result.gasStatusList[j].device_no+'</span></li>';
									}else{
										htmlString += '<li class="'+classString+'"><span>'+result.gasStatusList[j].device_no+txtNo+'</span></li>';
									}
								}
								$('#'+sFrameId).find('.gasButtonArea').html(htmlString);
								fn_goMenu(sFrameId, ctntsMenuId);
							}
						}
						
						if( "32" == process_gubun ){
							if( result.gasTotal > 0 ){
								var gasTotal = parseInt(result.gasTotal);
								var nowPage = ctntsCall%gasTotal+1;
								gasIndex = nowPage-1;
								$('#'+sFrameId).attr("class", $("#typeElement").find('.b-4-1-gasMonitoring').attr("id"));
								$('#'+sFrameId).html($('#typeElement').find('.b-4-1-gasMonitoring').clone(true).show());
								$('#'+sFrameId).find('.gasDeviceCount').text(result.gasTotal);	
								var statusO = 'S';
								var statusH = 'S';
								var statusC = 'S';
								var statusM = 'S';
								if(result.gasStatusList[gasIndex].oxygen_value <= result.gasStatusList[gasIndex].oxygen_from || result.gasStatusList[gasIndex].oxygen_value >= result.gasStatusList[gasIndex].oxygen_to){
									statusO = 'C';
									$('#'+sFrameId).find(".gasStatusArea1").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea1").html('<span class="greenBg">'+txtSafe+'</span>');
									
								}
								
								if(result.gasStatusList[gasIndex].hydrogen_sulfide_value >= result.gasStatusList[gasIndex].hydrogen){
									statusH = 'C';
									$('#'+sFrameId).find(".gasStatusArea2").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea2").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].carbon_monoxide_value >= result.gasStatusList[gasIndex].carbon){
									statusC = 'C';
									$('#'+sFrameId).find(".gasStatusArea3").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea3").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].methan_value >= result.gasStatusList[gasIndex].methan){
									statusM = 'C';
									$('#'+sFrameId).find(".gasStatusArea4").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea4").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								$('#'+sFrameId).find('.gasRange1').html(result.gasStatusList[gasIndex].oxygen_from+"~"+result.gasStatusList[gasIndex].oxygen_to);
								$('#'+sFrameId).find('.gasRange2').html(result.gasStatusList[gasIndex].hydrogen);
								$('#'+sFrameId).find('.gasRange3').html(result.gasStatusList[gasIndex].carbon);
								$('#'+sFrameId).find('.gasRange4').html(result.gasStatusList[gasIndex].methan);
								var nowDate = result.gasStatusList[gasIndex].reg_dt;
								nowDate = nowDate.substring(0, 19);
								$('#'+sFrameId).find(".gasStatusDate1").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate2").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate3").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate4").html(nowDate);
								
								$('#'+sFrameId).find('.b-4-1-gasMonitoring').find('.gas-graph-wrap1').html('<iframe width="100%" height="177" src="/click/highcharts/type16?chartHeight=160&status='+statusO+'&gas_value='+result.gasStatusList[gasIndex].oxygen_value+'&gas_type=1"></iframe>');
								$('#'+sFrameId).find('.b-4-1-gasMonitoring').find('.gas-graph-wrap2').html('<iframe width="100%" height="177" src="/click/highcharts/type16?chartHeight=160&status='+statusH+'&gas_value='+result.gasStatusList[gasIndex].carbon_monoxide_value+'&gas_type=2"></iframe>');
								$('#'+sFrameId).find('.b-4-1-gasMonitoring').find('.gas-graph-wrap3').html('<iframe width="100%" height="177" src="/click/highcharts/type16?chartHeight=160&status='+statusC+'&gas_value='+result.gasStatusList[gasIndex].hydrogen_sulfide_value+'&gas_type=3"></iframe>');
								$('#'+sFrameId).find('.b-4-1-gasMonitoring').find('.gas-graph-wrap4').html('<iframe width="100%" height="177" src="/click/highcharts/type16?chartHeight=160&status='+statusM+'&gas_value='+result.gasStatusList[gasIndex].methan_value+'&gas_type=4"></iframe>');
								var htmlString = '';
								for(var j=0;j<result.gasStatusList.length;j++){
									var classString = "";
									if(j == gasIndex){
										classString = "on";
									}
									if('en' == nowLocale){
										htmlString += '<li class="'+classString+'"><span>'+txtNo+' '+result.gasStatusList[j].device_no+'</span></li>';
									}else{
										htmlString += '<li class="'+classString+'"><span>'+result.gasStatusList[j].device_no+txtNo+'</span></li>';
									}
								}
								$('#'+sFrameId).find('.gasButtonArea').html(htmlString);
								fn_goMenu(sFrameId, ctntsMenuId);
							}
						}
						
						if( "39" == process_gubun ){
							if( result.gasTotal > 0 ){
								
								var gasTotal = parseInt(result.gasTotal);
								var nowPage = ctntsCall%gasTotal+1;
								gasIndex = nowPage-1;
								$('#'+sFrameId).attr("class", $("#typeElement").find('.b-4-2-gasMonitoring').attr("id"));
								$('#'+sFrameId).html($('#typeElement').find('.b-4-2-gasMonitoring').clone(true).show());
								$('#'+sFrameId).find('.gasDeviceCount').text(result.gasTotal);	
								var statusO = 'S';
								var statusH = 'S';
								var statusC = 'S';
								var statusM = 'S';
								if(result.gasStatusList[gasIndex].oxygen_value <= result.gasStatusList[gasIndex].oxygen_from || result.gasStatusList[gasIndex].oxygen_value >= result.gasStatusList[gasIndex].oxygen_to){
									statusO = 'C';
									$('#'+sFrameId).find(".gasStatusArea1").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea1").html('<span class="greenBg">'+txtSafe+'</span>');
									
								}
								
								if(result.gasStatusList[gasIndex].hydrogen_sulfide_value >= result.gasStatusList[gasIndex].hydrogen){
									statusH = 'C';
									$('#'+sFrameId).find(".gasStatusArea2").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea2").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].carbon_monoxide_value >= result.gasStatusList[gasIndex].carbon){
									statusC = 'C';
									$('#'+sFrameId).find(".gasStatusArea3").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea3").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].methan_value >= result.gasStatusList[gasIndex].methan){
									statusM = 'C';
									$('#'+sFrameId).find(".gasStatusArea4").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea4").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								$('#'+sFrameId).find('.gasRange1').html(result.gasStatusList[gasIndex].oxygen_from+"~"+result.gasStatusList[gasIndex].oxygen_to);
								$('#'+sFrameId).find('.gasRange2').html(result.gasStatusList[gasIndex].hydrogen);
								$('#'+sFrameId).find('.gasRange3').html(result.gasStatusList[gasIndex].carbon);
								$('#'+sFrameId).find('.gasRange4').html(result.gasStatusList[gasIndex].methan);
								var nowDate = result.gasStatusList[gasIndex].reg_dt;
								nowDate = nowDate.substring(0, 19);
								$('#'+sFrameId).find(".gasStatusDate1").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate2").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate3").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate4").html(nowDate);
								
								$('#'+sFrameId).find('.b-4-2-gasMonitoring').find('.gas-graph-wrap1').html('<iframe width="100%" height="177" src="/click/highcharts/type16?chartHeight=160&status='+statusO+'&gas_value='+result.gasStatusList[gasIndex].oxygen_value+'&gas_type=1"></iframe>');
								$('#'+sFrameId).find('.b-4-2-gasMonitoring').find('.gas-graph-wrap2').html('<iframe width="100%" height="177" src="/click/highcharts/type16?chartHeight=160&status='+statusH+'&gas_value='+result.gasStatusList[gasIndex].carbon_monoxide_value+'&gas_type=2"></iframe>');
								$('#'+sFrameId).find('.b-4-2-gasMonitoring').find('.gas-graph-wrap3').html('<iframe width="100%" height="177" src="/click/highcharts/type16?chartHeight=160&status='+statusC+'&gas_value='+result.gasStatusList[gasIndex].hydrogen_sulfide_value+'&gas_type=3"></iframe>');
								$('#'+sFrameId).find('.b-4-2-gasMonitoring').find('.gas-graph-wrap4').html('<iframe width="100%" height="177" src="/click/highcharts/type16?chartHeight=160&status='+statusM+'&gas_value='+result.gasStatusList[gasIndex].methan_value+'&gas_type=4"></iframe>');
								var htmlString = '';
								for(var j=0;j<result.gasStatusList.length;j++){
									var classString = "";
									if(j == gasIndex){
										classString = "on";
									}
									if('en' == nowLocale){
										htmlString += '<li class="'+classString+'"><span>'+txtNo+' '+result.gasStatusList[j].device_no+'</span></li>';
									}else{
										htmlString += '<li class="'+classString+'"><span>'+result.gasStatusList[j].device_no+txtNo+'</span></li>';
									}
								}
								$('#'+sFrameId).find('.gasButtonArea').html(htmlString);
								fn_goMenu(sFrameId, ctntsMenuId);
							}
						}
						
						if( "45" == process_gubun ){
							if( result.gasTotal > 0 ){
								
								var gasTotal = parseInt(result.gasTotal);
								var nowPage = ctntsCall%gasTotal+1;
								gasIndex = nowPage-1;
								$('#'+sFrameId).addClass('atype-layout');
								$('#'+sFrameId).html($('#typeElement').find('.c-4-3-gasMonitoring').clone(true).show());
								$('#'+sFrameId).find('.gasDeviceCount').text(result.gasTotal);	
								var statusO = 'S';
								var statusH = 'S';
								var statusC = 'S';
								var statusM = 'S';
								if(result.gasStatusList[gasIndex].oxygen_value <= result.gasStatusList[gasIndex].oxygen_from || result.gasStatusList[gasIndex].oxygen_value >= result.gasStatusList[gasIndex].oxygen_to){
									statusO = 'C';
									$('#'+sFrameId).find(".gasStatusArea1").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea1").html('<span class="greenBg">'+txtSafe+'</span>');
									
								}
								
								if(result.gasStatusList[gasIndex].hydrogen_sulfide_value >= result.gasStatusList[gasIndex].hydrogen){
									statusH = 'C';
									$('#'+sFrameId).find(".gasStatusArea2").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea2").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].carbon_monoxide_value >= result.gasStatusList[gasIndex].carbon){
									statusC = 'C';
									$('#'+sFrameId).find(".gasStatusArea3").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea3").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].methan_value >= result.gasStatusList[gasIndex].methan){
									statusM = 'C';
									$('#'+sFrameId).find(".gasStatusArea4").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea4").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								$('#'+sFrameId).find('.gasRange1').html(result.gasStatusList[gasIndex].oxygen_from+"~"+result.gasStatusList[gasIndex].oxygen_to);
								$('#'+sFrameId).find('.gasRange2').html(result.gasStatusList[gasIndex].hydrogen);
								$('#'+sFrameId).find('.gasRange3').html(result.gasStatusList[gasIndex].carbon);
								$('#'+sFrameId).find('.gasRange4').html(result.gasStatusList[gasIndex].methan);
								var nowDate = result.gasStatusList[gasIndex].reg_dt;
								nowDate = nowDate.substring(0, 19);
								$('#'+sFrameId).find(".gasStatusDate1").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate2").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate3").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate4").html(nowDate);
								
								$('#'+sFrameId).find('.c-4-3-gasMonitoring').find('.gas-graph-wrap1').html('<iframe width="100%" height="300" src="/click/highcharts/type16?chartHeight=280&status='+statusO+'&gas_value='+result.gasStatusList[gasIndex].oxygen_value+'&gas_type=1"></iframe>');
								$('#'+sFrameId).find('.c-4-3-gasMonitoring').find('.gas-graph-wrap2').html('<iframe width="100%" height="300" src="/click/highcharts/type16?chartHeight=280&status='+statusH+'&gas_value='+result.gasStatusList[gasIndex].carbon_monoxide_value+'&gas_type=2"></iframe>');
								$('#'+sFrameId).find('.c-4-3-gasMonitoring').find('.gas-graph-wrap3').html('<iframe width="100%" height="300" src="/click/highcharts/type16?chartHeight=280&status='+statusC+'&gas_value='+result.gasStatusList[gasIndex].hydrogen_sulfide_value+'&gas_type=3"></iframe>');
								$('#'+sFrameId).find('.c-4-3-gasMonitoring').find('.gas-graph-wrap4').html('<iframe width="100%" height="300" src="/click/highcharts/type16?chartHeight=280&status='+statusM+'&gas_value='+result.gasStatusList[gasIndex].methan_value+'&gas_type=4"></iframe>');
								var htmlString = '';
								for(var j=0;j<result.gasStatusList.length;j++){
									var classString = "";
									if(j == gasIndex){
										classString = "on";
									}
									if('en' == nowLocale){
										htmlString += '<li class="'+classString+'"><span>'+txtNo+' '+result.gasStatusList[j].device_no+'</span></li>';
									}else{
										htmlString += '<li class="'+classString+'"><span>'+result.gasStatusList[j].device_no+txtNo+'</span></li>';
									}
								}
								$('#'+sFrameId).find('.gasButtonArea').html(htmlString);
								fn_goMenu(sFrameId, ctntsMenuId);
							}
						}
						
						if( "50" == process_gubun ){
							if( result.gasTotal > 0 ){
								var gasTotal = parseInt(result.gasTotal);
								var nowPage = ctntsCall%gasTotal+1;
								gasIndex = nowPage-1;
								$('#'+sFrameId).attr("class", $("#typeElement").find('.d-2-3-gasMonitoring').attr("id"));
								$('#'+sFrameId).html($('#typeElement').find('.d-2-3-gasMonitoring').clone(true).show());
								$('#'+sFrameId).find('.d-2-3-gasMonitoring').css("display", "none");
								$('#'+sFrameId).find('.gasDeviceCount').text(result.gasTotal);	
								var statusO = 'S';
								var statusH = 'S';
								var statusC = 'S';
								var statusM = 'S';
								if(result.gasStatusList[gasIndex].oxygen_value <= result.gasStatusList[gasIndex].oxygen_from || result.gasStatusList[gasIndex].oxygen_value >= result.gasStatusList[gasIndex].oxygen_to){
									statusO = 'C';
									$('#'+sFrameId).find(".gasStatusArea1").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea1").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].hydrogen_sulfide_value >= result.gasStatusList[gasIndex].hydrogen){
									statusH = 'C';
									$('#'+sFrameId).find(".gasStatusArea2").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea2").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].carbon_monoxide_value >= result.gasStatusList[gasIndex].carbon){
									statusC = 'C';
									$('#'+sFrameId).find(".gasStatusArea3").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea3").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								
								if(result.gasStatusList[gasIndex].methan_value >= result.gasStatusList[gasIndex].methan){
									statusM = 'C';
									$('#'+sFrameId).find(".gasStatusArea4").html('<span class="redBg">'+txtDanger+'</span>');
								}else{
									$('#'+sFrameId).find(".gasStatusArea4").html('<span class="greenBg">'+txtSafe+'</span>');
								}
								$('#'+sFrameId).find('.gasRange1').html(result.gasStatusList[gasIndex].oxygen_from+"~"+result.gasStatusList[gasIndex].oxygen_to);
								$('#'+sFrameId).find('.gasRange2').html(result.gasStatusList[gasIndex].hydrogen);
								$('#'+sFrameId).find('.gasRange3').html(result.gasStatusList[gasIndex].carbon);
								$('#'+sFrameId).find('.gasRange4').html(result.gasStatusList[gasIndex].methan);
								var nowDate = result.gasStatusList[gasIndex].reg_dt;
								nowDate = nowDate.substring(0, 19);
								$('#'+sFrameId).find(".gasStatusDate1").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate2").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate3").html(nowDate);
								$('#'+sFrameId).find(".gasStatusDate4").html(nowDate);
								
								$('#'+sFrameId).find('.d-2-3-gasMonitoring').find('.gas-graph-wrap1').html('<iframe width="100%" height="208" src="/click/highcharts/type16?chartHeight=192&status='+statusO+'&gas_value='+result.gasStatusList[gasIndex].oxygen_value+'&gas_type=1"></iframe>');
								$('#'+sFrameId).find('.d-2-3-gasMonitoring').find('.gas-graph-wrap2').html('<iframe width="100%" height="208" src="/click/highcharts/type16?chartHeight=192&status='+statusH+'&gas_value='+result.gasStatusList[gasIndex].carbon_monoxide_value+'&gas_type=2"></iframe>');
								$('#'+sFrameId).find('.d-2-3-gasMonitoring').find('.gas-graph-wrap3').html('<iframe width="100%" height="208" src="/click/highcharts/type16?chartHeight=192&status='+statusC+'&gas_value='+result.gasStatusList[gasIndex].hydrogen_sulfide_value+'&gas_type=3"></iframe>');
								$('#'+sFrameId).find('.d-2-3-gasMonitoring').find('.gas-graph-wrap4').html('<iframe width="100%" height="208" src="/click/highcharts/type16?chartHeight=192&status='+statusM+'&gas_value='+result.gasStatusList[gasIndex].methan_value+'&gas_type=4"></iframe>');
								var htmlString = '';
								for(var j=0;j<result.gasStatusList.length;j++){
									var classString = "";
									if(j == gasIndex){
										classString = "on";
									}
									if('en' == nowLocale){
										htmlString += '<li class="'+classString+'"><span>'+txtNo+' '+result.gasStatusList[j].device_no+'</span></li>';
									}else{
										htmlString += '<li class="'+classString+'"><span>'+result.gasStatusList[j].device_no+txtNo+'</span></li>';
									}
								}
								
								$('#'+sFrameId).find('.gasButtonArea').html(htmlString);
								$('#'+sFrameId).find('.d-2-3-gasMonitoring').fadeIn(2000);
								fn_goMenu(sFrameId, ctntsMenuId);
							}
						}
					}
				});
			}
		}
		
		function fn_gasData(idx, sFrameId, process_gubun){
		}
		
		// 터널 데이터
		// Paramter : frameId ( 각 프레임의 아이디 ) , process_gubun ( 크기별 구분값 )
		// 1 : 1x1 터널 공정율 현황
		// 2 : 
		function fn_tunnelProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId){
			if(fn_checkRefresh(ctntsRefresh,ctntsMenuId,ctntsCall)){
				var sUrl = "dashTunnelProcess.json";
				var sFrameId = "";
				var pageIdx = 1;
				var elevationPageIndex = 1;
				$("form[id=tunnelElevationParameterVO]").find('.process_gubun').val(process_gubun);
				$("form[id=tunnelParameterVO]").find('.process_gubun').val(process_gubun);
				// 1x1 터널 공정율현황 조회
				if( "5" == process_gubun ){
					sUrl = "dashTunnelProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 1x1 터널 굴진율현황 조회
				if( "6" == process_gubun ){
					sUrl = "dashTunnelProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				if( "18" == process_gubun || "33" == process_gubun || "51" == process_gubun){
					sUrl = "dashTunnelProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				if( "27" == process_gubun ){
					if(elevationTotal == 0){
						var params = $("form[id=tunnelElevationParameterVO]").serialize();
						$.ajax({
							url : "/click/selectElevationTotal.json",
							type : "POST",
							data: params,
							success : function(result) {
								elevationTotal = parseInt(result.elevationTotal);
								fn_graph("frame_" + frameId, "A", ctntsCall, elevationTotal, process_gubun, ctntsMenuId);
							}
						});
					}else{
						fn_graph("frame_" + frameId, "A", ctntsCall, elevationTotal, process_gubun, ctntsMenuId);
					}
					
				}else if( "40" == process_gubun ){
					if(elevationTotal == 0){
						var params = $("form[id=tunnelElevationParameterVO]").serialize();
						$.ajax({
							url : "/click/selectElevationTotal.json",
							type : "POST",
							data: params,
							success : function(result) {
								elevationTotal = parseInt(result.elevationTotal);
								fn_graph("frame_" + frameId, "B", ctntsCall, elevationTotal, process_gubun, ctntsMenuId);
							}
						});
					}else{
						fn_graph("frame_" + frameId, "B", ctntsCall, elevationTotal, process_gubun, ctntsMenuId);
					}
				}else if( "46" == process_gubun ){
					if(elevationTotal == 0){
						var params = $("form[id=tunnelElevationParameterVO]").serialize();
						$.ajax({
							url : "/click/selectElevationTotal.json",
							type : "POST",
							data: params,
							success : function(result) {
								elevationTotal = parseInt(result.elevationTotal);
								fn_graph("frame_" + frameId, "C", ctntsCall, elevationTotal, process_gubun, ctntsMenuId);
							}
						});
					}else{
						fn_graph("frame_" + frameId, "C", ctntsCall, elevationTotal, process_gubun, ctntsMenuId);
					}
				}else{
					// ajax 호출
					$("form[id=tunnelParameterVO]").find('#pageIndex').val(pageIdx);
					var params = $("form[id=tunnelParameterVO]").serialize();
					$.ajax({
						url : "/click/" + sUrl,
						type : "POST",
						data: params,
						success : function(result) {
							// 1x1 터널 공정율 데이터 세팅
							if( "5" == process_gubun ){
								if(undefined != result.processList){
									var tunnelDiff = result.processList[0].digthrough_process_ing - result.processList[0].digthrough_process_target;
									var processString = "";
									if(tunnelDiff > 0){
										processString = "+";
									}
									$('#'+sFrameId).html($("#typeElement").find('.a-1-1-tunnel').clone(true).show());
									$('#'+sFrameId).find('.digthrough_process_target').text(parseFloat(result.processList[0].digthrough_process_target).toFixed(1));	// 목표 공정율
									$('#'+sFrameId).find('.digthrough_process_ing').text(parseFloat(result.processList[0].digthrough_process_ing).toFixed(1));			// 현재 공정율
									$('#'+sFrameId).find('.digthrough_process_diff').text(processString+parseFloat(tunnelDiff).toFixed(1));							// 목표 현재 차이
									fn_goMenu(sFrameId, ctntsMenuId);
								}
							}

							// 1x1 터널 굴진율 현황 데이터 세팅 
							if( "6" == process_gubun ){
								var tunnelTotal = parseInt(result.tunnelTotalTotal);
								var nowPage = ctntsCall%tunnelTotal+1;
								pageIdx = nowPage;
								var diggingProgress = 0;
								var tunnelName = "";
								if(!isEmpty(result.tunnelTotalList)){
									if(!isEmpty(result.tunnelTotalList[pageIdx-1].sectionList)){
										for(var j=0;j<result.tunnelTotalList[pageIdx-1].sectionList.length;j++){
											if(!isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].digging_aggregate) && !isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].end_pos) && !isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].start_pos)){
												diggingProgress += (parseInt(result.tunnelTotalList[pageIdx-1].sectionList[j].digging_aggregate)/parseInt(result.tunnelTotalList[pageIdx-1].end_pos - result.tunnelTotalList[pageIdx-1].start_pos)*100);
											}
										}
									}
									if('en' == nowLocale){
										tunnelName = result.tunnelTotalList[pageIdx-1].dig_name_eng;
									}else{
										tunnelName = result.tunnelTotalList[pageIdx-1].dig_name;
									}
									
								}
								$('#'+sFrameId).html($("#typeElement").find('.a-1-1-tunnelDigging').clone(true).show());
								$('#'+sFrameId).find('.diggingPage').html("("+nowPage+"/"+tunnelTotal+")");
								$('#'+sFrameId).find('.diggingPercent').html(diggingProgress.toFixed(1));
								$('#'+sFrameId).find('.tunnelName').html(tunnelName);
								$('#'+sFrameId).find('.a-1-1-tunnelDigging').find('.worker-chart-wrap').html('<iframe width="100%" height="120" src="/click/highcharts/type07?chartHeight=100&pageIndex='+nowPage+'"></iframe>');
								fn_goMenu(sFrameId, ctntsMenuId);
							}
							
							if( "18" == process_gubun ){
								$('#'+sFrameId).html($("#typeElement").find('.a-3-1-tunnel').clone(true).show());
								if(undefined != result.processList){
									var tunnelDiff = result.processList[0].digthrough_process_ing - result.processList[0].digthrough_process_target;
									var processString = "";
									if(tunnelDiff > 0){
										processString = "+";
									}
									$('#'+sFrameId).find('.digthrough_process_target').text(parseFloat(result.processList[0].digthrough_process_target).toFixed(1));	// 목표 공정율
									$('#'+sFrameId).find('.digthrough_process_ing').text(parseFloat(result.processList[0].digthrough_process_ing).toFixed(1));			// 현재 공정율
									$('#'+sFrameId).find('.digthrough_process_diff').text(processString+parseFloat(tunnelDiff).toFixed(1));							// 목표 현재 차이
								}
								
								var tunnelTotal = parseInt(result.tunnelTotalTotal);
								var nowPage = ctntsCall%tunnelTotal+1;
								pageIdx = nowPage;
								var diggingProgress = 0;
								var tunnelName = "";
								if(!isEmpty(result.tunnelTotalList)){
									if(!isEmpty(result.tunnelTotalList[pageIdx-1].sectionList)){
										for(var j=0;j<result.tunnelTotalList[pageIdx-1].sectionList.length;j++){
											if(!isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].digging_aggregate) && !isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].end_pos) && !isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].start_pos)){
												diggingProgress += (parseInt(result.tunnelTotalList[pageIdx-1].sectionList[j].digging_aggregate)/parseInt(result.tunnelTotalList[pageIdx-1].end_pos - result.tunnelTotalList[pageIdx-1].start_pos)*100);
											}
										}
									}
									if(nowLocale == 'en'){
										tunnelName = result.tunnelTotalList[pageIdx-1].dig_name_eng;
									}else{
										tunnelName = result.tunnelTotalList[pageIdx-1].dig_name;
									}
									
								}
								$('#'+sFrameId).find('.diggingPage').html("("+nowPage+"/"+tunnelTotal+")");
								$('#'+sFrameId).find('.diggingPercent').html(diggingProgress.toFixed(1));
								$('#'+sFrameId).find('.tunnelName').html(tunnelName);
								$('#'+sFrameId).find('.a-3-1-tunnel').find('.eq-chart-wrap4').html('<iframe width="100%" height="120" src="/click/highcharts/type07?chartHeight=100&pageIndex='+nowPage+'"></iframe>');
								fn_goMenu(sFrameId, ctntsMenuId);
							}
							
							if( "33" == process_gubun ){
								$('#'+sFrameId).attr("class", $("#typeElement").find('.c-4-1-tunnel').attr("id"));
								$('#'+sFrameId).html($("#typeElement").find('.c-4-1-tunnel').clone(true).show());
								if(undefined != result.processList){
									var tunnelDiff = result.processList[0].digthrough_process_ing - result.processList[0].digthrough_process_target;
									var processString = "";
									if(tunnelDiff > 0){
										processString = "+";
									}
									$('#'+sFrameId).find('.digthrough_process_target').text(parseFloat(result.processList[0].digthrough_process_target).toFixed(1));	// 목표 공정율
									$('#'+sFrameId).find('.digthrough_process_ing').text(parseFloat(result.processList[0].digthrough_process_ing).toFixed(1));			// 현재 공정율
									$('#'+sFrameId).find('.digthrough_process_diff').text(processString+parseFloat(tunnelDiff).toFixed(1));							// 목표 현재 차이
								}
								
								var tunnelTotal = parseInt(result.tunnelTotalTotal);
								var nowPage = ctntsCall%tunnelTotal+1;
								pageIdx = nowPage;
								var diggingProgress = 0;
								var tunnelName = "";
								if(!isEmpty(result.tunnelTotalList)){
									if(!isEmpty(result.tunnelTotalList[pageIdx-1].sectionList)){
										for(var j=0;j<result.tunnelTotalList[pageIdx-1].sectionList.length;j++){
											if(!isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].digging_aggregate) && !isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].end_pos) && !isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].start_pos)){
												diggingProgress += (parseInt(result.tunnelTotalList[pageIdx-1].sectionList[j].digging_aggregate)/parseInt(result.tunnelTotalList[pageIdx-1].end_pos - result.tunnelTotalList[pageIdx-1].start_pos)*100);
											}
										}
									}
									if(nowLocale == 'en'){
										tunnelName = result.tunnelTotalList[pageIdx-1].dig_name_eng;
									}else{
										tunnelName = result.tunnelTotalList[pageIdx-1].dig_name;
									}
								}
								$('#'+sFrameId).find('.diggingPage').html("("+nowPage+"/"+tunnelTotal+")");
								$('#'+sFrameId).find('.diggingPercent').html(diggingProgress.toFixed(1));
								$('#'+sFrameId).find('.tunnelName').html(tunnelName);
								$('#'+sFrameId).find('.c-4-1-tunnel').find('.work-graph-wrap2').html('<iframe width="100%" height="140" src="/click/highcharts/type07?chartHeight=120&pageIndex='+nowPage+'"></iframe>');
								$('#'+sFrameId).find('.c-4-1-tunnel').find('.work-graph-wrap1').html('<iframe width="100%" height="140" src="/click/highcharts/type13?chartHeight=110&pageIndex='+nowPage+'"></iframe>');
								fn_goMenu(sFrameId, ctntsMenuId);
							}
							
							if( "51" == process_gubun ){
								$('#'+sFrameId).attr("class", $("#typeElement").find('.d-2-3-tunnel').attr("id"));
								$('#'+sFrameId).html($("#typeElement").find('.d-2-3-tunnel').clone(true).show());
								if(undefined != result.processList){
									var tunnelDiff = result.processList[0].digthrough_process_ing - result.processList[0].digthrough_process_target;
									var processString = "";
									if(tunnelDiff > 0){
										processString = "+";
									}
									$('#'+sFrameId).find('.digthrough_process_target').text(parseFloat(result.processList[0].digthrough_process_target).toFixed(1));	// 목표 공정율
									$('#'+sFrameId).find('.digthrough_process_ing').text(parseFloat(result.processList[0].digthrough_process_ing).toFixed(1));			// 현재 공정율
									$('#'+sFrameId).find('.digthrough_process_diff').text(processString+parseFloat(tunnelDiff).toFixed(1));							// 목표 현재 차이
								}
								
								var tunnelTotal = parseInt(result.tunnelTotalTotal);
								var nowPage = ctntsCall%tunnelTotal+1;
								pageIdx = nowPage;
								var diggingProgress = 0;
								var tunnelName = "";
								if(!isEmpty(result.tunnelTotalList)){
									if(!isEmpty(result.tunnelTotalList[pageIdx-1].sectionList)){
										for(var j=0;j<result.tunnelTotalList[pageIdx-1].sectionList.length;j++){
											if(!isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].digging_aggregate) && !isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].end_pos) && !isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].start_pos)){
												diggingProgress += (parseInt(result.tunnelTotalList[pageIdx-1].sectionList[j].digging_aggregate)/parseInt(result.tunnelTotalList[pageIdx-1].end_pos - result.tunnelTotalList[pageIdx-1].start_pos)*100);
											}
										}
									}
									if(nowLocale == 'en'){
										tunnelName = result.tunnelTotalList[pageIdx-1].dig_name_eng;
									}else{
										tunnelName = result.tunnelTotalList[pageIdx-1].dig_name;
									}
									
								}
								$('#'+sFrameId).find('.diggingPage').html("("+nowPage+"/"+tunnelTotal+")");
								$('#'+sFrameId).find('.diggingPercent').html(diggingProgress.toFixed(1));
								$('#'+sFrameId).find('.tunnelName').html(tunnelName);
								$('#'+sFrameId).find('.d-2-3-tunnel').find('.work-graph-wrap1').html('<iframe width="100%" height="320" src="/click/highcharts/type07?chartHeight=300&pageIndex='+nowPage+'"></iframe>');
								fn_goMenu(sFrameId, ctntsMenuId);
							}
						}
					});
				}
			}
		}
		
		function fn_graph(sFrameId, areaType, ctntsCall, elevationTotal, process_gubun, ctntsMenuId){
			var nowPage = ctntsCall%elevationTotal+1;
			$("form[id=tunnelElevationParameterVO]").find('.pageIndex').val(nowPage);
			var params = $("form[id=tunnelElevationParameterVO]").serialize();
			$.ajax({
				url : "/click/selectDashElevation.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						var title = '';
						var htmlString = '';
						var arrowString1 = '';
						var arrowString2 = '';
						var arrowString3 = '';
						var graphHtml = '';
						var totalHtml = '';
						var aggregateString1 = '';
						var aggregateString2 = '';
						var aggregateString3 = '';
						
						
						if(undefined != result.tunnelVO.total_length){
							$(".lastPoint").text(result.tunnelVO.total_length+"m");
						}
						
						if(!isEmpty(result.sectionList1)){
							for(var i=0;i<result.sectionList1.length;i++){
								if(i==0 && parseInt(result.sectionList1[i].start_pos) > 0){
									var startPoint = parseInt(result.sectionList1[i].start_pos);
									var totalElevation = parseInt(result.tunnelVO.total_length);
									var firstWidth = ((startPoint/totalElevation)*100)+"%";
									aggregateString1 += '<div style="width:'+firstWidth+';float:left;text-align:center;">&nbsp;</div>';
									arrowString1 += '<div style="float:left;width:'+firstWidth+';text-align:right;">'+
													'&nbsp;</div>';
								}
								
								var totalAggregate = 0;
								var totalLength = result.sectionList1[i].end_pos - result.sectionList1[i].start_pos;
								if(!isEmpty(result.sectionList1[i].sectionDetailList)){
									for(var j=0;j<result.sectionList1[i].sectionDetailList.length;j++){
										if(!isEmpty(result.sectionList1[i].sectionDetailList[j].digging_aggregate)){
											totalAggregate += parseInt(result.sectionList1[i].sectionDetailList[j].digging_aggregate);
										}
									}
								}
								var widthString = parseFloat((totalLength/result.tunnelVO.total_length)*100).toFixed(2);
								var aggregate = parseFloat((totalAggregate/totalLength)*100).toFixed(2);
								aggregateString1 += '<div style="width:'+widthString+'%;float:left;text-align:center;">'+aggregate+'%</div>';
								
								if((i+1) != result.sectionList1.length){
									arrowString1 += '<div style="float:left;width:'+widthString+'%;text-align:right;">'+
														'<img src="/click/resources/img/sub/tunnel-div-arrow.png" style="margin-right:-5px;"/>'+
													'</div>';
								}
							}
						}
						
						if(!isEmpty(result.sectionList2)){
							for(var i=0;i<result.sectionList2.length;i++){
								if(i==0 && parseInt(result.sectionList2[i].start_pos) > 0){
									var startPoint = parseInt(result.sectionList2[i].start_pos);
									var totalElevation = parseInt(result.tunnelVO.total_length);
									var firstWidth = ((startPoint/totalElevation)*100)+"%";
									aggregateString2 += '<div style="width:'+firstWidth+';float:left;text-align:center;">&nbsp;</div>';
									arrowString2 += '<div style="float:left;width:'+firstWidth+';text-align:right;">'+
													'&nbsp;</div>';
								}
								
								var totalAggregate = 0;
								var totalLength = result.sectionList2[i].end_pos - result.sectionList2[i].start_pos;
								if(!isEmpty(result.sectionList2[i].sectionDetailList)){
									for(var j=0;j<result.sectionList2[i].sectionDetailList.length;j++){
										if(!isEmpty(result.sectionList2[i].sectionDetailList[j].digging_aggregate)){
											totalAggregate += parseInt(result.sectionList2[i].sectionDetailList[j].digging_aggregate);
										}
									}
								}
								var widthString = parseFloat((totalLength/result.tunnelVO.total_length)*100).toFixed(2);
								var aggregate = parseFloat((totalAggregate/totalLength)*100).toFixed(2);
								aggregateString2 += '<div style="width:'+widthString+'%;float:left;text-align:center;">'+aggregate+'%</div>';
								
								if((i+1) != result.sectionList2.length){
									arrowString2 += '<div style="float:left;width:'+widthString+'%;text-align:right;">'+
														'<img src="/click/resources/img/sub/tunnel-div-arrow.png" style="margin-right:-5px;"/>'+
													'</div>';
								}
							}
						}
						
						if(!isEmpty(result.sectionList3)){
							for(var i=0;i<result.sectionList3.length;i++){
								if(i==0 && parseInt(result.sectionList3[i].start_pos) > 0){
									var startPoint = parseInt(result.sectionList3[i].start_pos);
									var totalElevation = parseInt(result.tunnelVO.total_length);
									var firstWidth = ((startPoint/totalElevation)*100)+"%";
									aggregateString3 += '<div style="width:'+firstWidth+';float:left;text-align:center;">&nbsp;</div>';
									arrowString3 += '<div style="float:left;width:'+firstWidth+';text-align:right;">'+
													'&nbsp;</div>';
								}
								var totalAggregate = 0;
								var totalLength = result.sectionList3[i].end_pos - result.sectionList3[i].start_pos;
								if(!isEmpty(result.sectionList3[i].sectionDetailList)){
									for(var j=0;j<result.sectionList3[i].sectionDetailList.length;j++){
										if(!isEmpty(result.sectionList3[i].sectionDetailList[j].digging_aggregate)){
											totalAggregate += parseInt(result.sectionList3[i].sectionDetailList[j].digging_aggregate);
										}
									}
								}
								var widthString = parseFloat((totalLength/result.tunnelVO.total_length)*100).toFixed(2);
								var aggregate = parseFloat((totalAggregate/totalLength)*100).toFixed(2);
								aggregateString3 += '<div style="width:'+widthString+'%;float:left;text-align:center;">'+aggregate+'%</div>';
								
								if((i+1) != result.sectionList3.length){
									arrowString3 += '<div style="float:left;width:'+widthString+'%;text-align:right;">'+
														'<img src="/click/resources/img/sub/tunnel-div-arrow.png" style="margin-right:-5px;"/>'+
													'</div>';
								}
							}
						}
						
						if(!isEmpty(result.progressList1) && result.progressList1.length >0){
							var checkBase = 'tunnel-graphA-1';
							
							if('en' == nowLocale){
								title = result.progressList1[0].dig_name_eng;
								var titleStyle = "tunnel-progress-title";
								if(result.progressList1[0].dig_name_eng.length > 8){
									title = result.progressList1[0].dig_name_eng.substring(0, 8) + "<br/>" + result.progressList1[0].dig_name_eng.substring(8);
									titleStyle = "tunnel-progress-title2";
								}
							}else{
								title = result.progressList1[0].dig_name;
								var titleStyle = "tunnel-progress-title";
								if(result.progressList1[0].dig_name.length > 5){
									title = result.progressList1[0].dig_name.substring(0, 5) + "<br/>" + result.progressList1[0].dig_name.substring(5);
									titleStyle = "tunnel-progress-title2";
								}
							}
							
							
							for(var i=0;i<result.progressList1.length;i++){
								if(i==0 && parseInt(result.progressList1[i].start_pos) > 0){
									var startPoint = parseInt(result.progressList1[i].start_pos);
									var totalElevation = parseInt(result.tunnelVO.total_length);
									var firstWidth = ((startPoint/totalElevation)*100)+"%";
									htmlString += '<div class="tunnel-progress-wrap1" style="width:'+firstWidth+';">'+
												'&nbsp;</div>';
								}
								var className = '';
								var directionString = '';
								if(i==0){
									if((i+1) == result.progressList1.length){
										checkBase = 'tunnel-graphA-4';
									}else{
										checkBase = 'tunnel-graphA-1';
									}
								}else if((i+1) == result.progressList1.length){
									checkBase = 'tunnel-graphA-3';
								}else{
									checkBase = 'tunnel-graphA-2';
								}
								for(var j=0;j<result.progressList1[i].directionList.length;j++){
									if('F' == result.progressList1[i].directionList[j]){
										className = 'progress-forward';
										if(i ==0 && j == 0){
											className = 'progress-start';
										}
									}else{
										className = 'progress-backward';
										if((i+1) == result.progressList1.length && (j+1) == result.progressList1[i].directionList.length){
											className = 'progress-end';
										}
									}
									var detailWith = 0;
									
									directionString += '<div class="'+className+'" style="width:'+result.progressList1[i].aggregateList[j]+'"></div>';
								}
								htmlString += '<div class="tunnel-progress-wrap1" style="width:'+result.progressList1[i].widthString+';">'+
												'<div class="'+checkBase+'">'+
													directionString+
												'</div>'+
											'</div>';
							}
						}
						graphHtml += '<div style="width:100%;">'+
										'<div class="'+titleStyle+'">'+title+'</div>'+
										'<div class="tunnel-progress-graph-area">'+
											'<div style="width:100%;margin-top:10px;">'+aggregateString1+'</div>'+
											'<div class="tunnel-progress-graph-area2">'+
												htmlString+
											'</div>'+
										'</div>'+
									'</div>'+
									'<div class="tunnel-progress-graph-area" style="position:absolute;left:90px;top:46px;">'+
										arrowString1+
									'</div>';
					
						var title2 = '';
						var htmlString2 = '';
						var graphHtml2 = '';
						if(undefined != result.progressList2){
							if(result.progressList2.length >0){
								var checkBase = 'tunnel-graphA-1';
								
								if('en' == nowLocale){
									title2 = result.progressList2[0].dig_name_eng;
									var titleStyle = "tunnel-progress-title";
									if(result.progressList2[0].dig_name_eng.length > 8){
										title2 = result.progressList2[0].dig_name_eng.substring(0, 8) + "<br/>" + result.progressList2[0].dig_name_eng.substring(8);
										titleStyle = "tunnel-progress-title2";
									}
								}else{
									title2 = result.progressList2[0].dig_name;
									var titleStyle = "tunnel-progress-title";
									if(result.progressList2[0].dig_name.length > 5){
										title2 = result.progressList2[0].dig_name.substring(0, 5) + "<br/>" + result.progressList2[0].dig_name.substring(5);
										titleStyle = "tunnel-progress-title2";
									}
								}
								
								for(var i=0;i<result.progressList2.length;i++){
									if(i==0 && parseInt(result.progressList2[i].start_pos) > 0){
										var startPoint = parseInt(result.progressList2[i].start_pos);
										var totalElevation = parseInt(result.tunnelVO.total_length);
										var firstWidth = ((startPoint/totalElevation)*100)+"%";
										htmlString2 += '<div class="tunnel-progress-wrap1" style="width:'+firstWidth+';">'+
													'&nbsp;</div>';
									}
									var className = '';
									var directionString = '';
									if(i==0){
										if((i+1) == result.progressList2.length){
											checkBase = 'tunnel-graphA-4';
										}else{
											checkBase = 'tunnel-graphA-1';
										}
									}else if((i+1) == result.progressList2.length){
										checkBase = 'tunnel-graphA-3';
									}else{
										checkBase = 'tunnel-graphA-2';
									}
									for(var j=0;j<result.progressList2[i].directionList.length;j++){
										for(var j=0;j<result.progressList2[i].directionList.length;j++){
											if('F' == result.progressList2[i].directionList[j]){
												className = 'progress-forward';
												if(i ==0 && j == 0){
													className = 'progress-start';
												}
											}else{
												className = 'progress-backward';
												if((i+1) == result.progressList2.length && (j+1) == result.progressList2[i].directionList.length){
													className = 'progress-end';
												}
											}
											var detailWith = 0;
											
											directionString += '<div class="'+className+'" style="width:'+result.progressList2[i].aggregateList[j]+'"></div>';
										}
									}
									htmlString2 += '<div class="tunnel-progress-wrap1" style="width:'+result.progressList2[i].widthString+';">'+
													'<div class="'+checkBase+'">'+
														directionString+
													'</div>'+
												'</div>';
								}
							}
							graphHtml2 += '<div style="width:100%;">'+
											'<div class="'+titleStyle+'">'+title2+'</div>'+
											'<div class="tunnel-progress-graph-area">'+
												'<div style="width:100%;margin-top:10px;">'+aggregateString2+'</div>'+
												'<div class="tunnel-progress-graph-area2">'+
													htmlString2+
												'</div>'+
											'</div>'+
										'</div>'+
										'<div class="tunnel-progress-graph-area" style="position:absolute;left:90px;top:100px;">'+
											arrowString2+
										'</div>';
						}
						
						var title3 = '';
						var htmlString3 = '';
						var graphHtml3 = '';
						if(undefined != result.progressList3){
							if(result.progressList3.length >0){
								var checkBase = 'tunnel-graphA-1';
								
								if('en' == nowLocale){
									title3 = result.progressList3[0].dig_name_eng;
									var titleStyle = "tunnel-progress-title";
									if(result.progressList3[0].dig_name_eng.length > 8){
										title3 = result.progressList3[0].dig_name_engv.substring(0, 8) + "<br/>" + result.progressList3[0].dig_name_eng.substring(8);
										titleStyle = "tunnel-progress-title2";
									}
								}else{
									title3 = result.progressList3[0].dig_name;
									var titleStyle = "tunnel-progress-title";
									if(result.progressList3[0].dig_name.length > 5){
										title3 = result.progressList3[0].dig_name.substring(0, 5) + "<br/>" + result.progressList3[0].dig_name.substring(5);
										titleStyle = "tunnel-progress-title2";
									}
								}
								
								for(var i=0;i<result.progressList3.length;i++){
									if(i==0 && parseInt(result.progressList3[i].start_pos) > 0){
										var startPoint = parseInt(result.progressList3[i].start_pos);
										var totalElevation = parseInt(result.tunnelVO.total_length);
										var firstWidth = ((startPoint/totalElevation)*100)+"%";
										htmlString3 += '<div class="tunnel-progress-wrap1" style="width:'+firstWidth+';">'+
													'&nbsp;</div>';
									}
									var className = '';
									var directionString = '';
									if(i==0){
										if((i+1) == result.progressList3.length){
											checkBase = 'tunnel-graphA-4';
										}else{
											checkBase = 'tunnel-graphA-1';
										}
									}else if((i+1) == result.progressList3.length){
										checkBase = 'tunnel-graphA-3';
									}else{
										checkBase = 'tunnel-graphA-2';
									}
									for(var j=0;j<result.progressList3[i].directionList.length;j++){
										for(var j=0;j<result.progressList3[i].directionList.length;j++){
											if('F' == result.progressList3[i].directionList[j]){
												className = 'progress-forward';
												if(i ==0 && j == 0){
													className = 'progress-start';
												}
											}else{
												className = 'progress-backward';
												if((i+1) == result.progressList3.length && (j+1) == result.progressList3[i].directionList.length){
													className = 'progress-end';
												}
											}
											var detailWith = 0;
											
											directionString += '<div class="'+className+'" style="width:'+result.progressList3[i].aggregateList[j]+'"></div>';
										}
									}
									htmlString3 += '<div class="tunnel-progress-wrap1" style="width:'+result.progressList3[i].widthString+';">'+
													'<div class="'+checkBase+'">'+
														directionString+
													'</div>'+
												'</div>';
								}
							}
							graphHtml3 += '<div style="width:100%;">'+
											'<div class="'+titleStyle+'">'+title3+'</div>'+
											'<div class="tunnel-progress-graph-area">'+
												'<div style="width:100%;margin-top:10px;">'+aggregateString3+'</div>'+
												'<div class="tunnel-progress-graph-area2">'+
													htmlString3+
												'</div>'+
											'</div>'+
										'</div>'+
										'<div class="tunnel-progress-graph-area" style="position:absolute;left:90px;top:154px;">'+
											arrowString3+
										'</div>';
						}
						
						var total = result.tunnelVO.total_length;
						var xSpace = result.tunnelVO.x_space;
						var lastGap = total%xSpace;
						var totalSize = total - lastGap;
						var space = parseFloat(totalSize / xSpace);
						var xEndWidth = ((lastGap / total)*100);
						var xWidth = parseFloat((100.00-((lastGap/total)*100))/space); 
						
						var markingHtml = '';
						var markingValueHtml = '';
						
						for(var k=0;k<parseInt(space);k++){
							if(total%xSpace == 0 && (k+1) == parseInt(space)){
								markingHtml += '<div class="marking-end" id="'+k+'" style="width:'+xWidth+'%;">&nbsp;</div>';
							}else{
								markingHtml += '<div class="marking" id="'+k+'" style="width:'+xWidth+'%;">&nbsp;</div>';
							}
						}
						if(total%xSpace != 0){
							markingHtml += '<div class="marking-end" style="width:'+xEndWidth+'%;">&nbsp;</div>';
						}
						
						for(var k=0;k<parseInt(space);k++){
							markingValueHtml += '<div class="graphUnit" style="width:'+xWidth+'%;">'+((k+1)*parseInt(xSpace))+'</div>';
						}
						
						$("#graphArea"+areaType).html(graphHtml+graphHtml2+graphHtml3);
						
						if(!isEmpty(result.tunnelVO)) {
						
							var total = result.tunnelVO.total_length;
							var xSpace = result.tunnelVO.x_space;
							var lastGap = total%xSpace;
							var totalSize = total - lastGap;
							var space = parseFloat(totalSize / xSpace);
							var xEndWidth = ((lastGap / total)*100);
							var xWidth = parseFloat((100.00-((lastGap/total)*100))/space); 
							
							var markingHtml = '';
							var markingValueHtml = '';
							
							for(var k=0;k<parseInt(space);k++){
								if(total%xSpace == 0 && (k+1) == parseInt(space)){
									markingHtml += '<div class="marking-end" id="'+k+'" style="width:'+xWidth+'%;">&nbsp;</div>';
								}else{
									markingHtml += '<div class="marking" id="'+k+'" style="width:'+xWidth+'%;">&nbsp;</div>';
								}
							}
							if(total%xSpace != 0){
								markingHtml += '<div class="marking-end" style="width:'+xEndWidth+'%;">&nbsp;</div>';
							}
							
							for(var k=0;k<parseInt(space);k++){
								markingValueHtml += '<div class="graphUnit" style="width:'+xWidth+'%;">'+((k+1)*parseInt(xSpace))+'</div>';
							}
							$("#graphMarking"+areaType).html(markingHtml);
							$("#graphMarkingValue"+areaType).html(markingValueHtml);
							
							if("A" == areaType){
								$('#'+sFrameId).addClass("full-tunnel");
								$('#'+sFrameId).addClass("atype-layout");
								if(callDash > 1){
									$('#'+sFrameId).html($('#'+sFrameId).find('.a-3-2-tunnel').clone(true).show());
								}else{
									$('#'+sFrameId).html($('.a-3-2-tunnel').clone(true).show());
								}
								$('#'+sFrameId).find('.tunnel-wrap').css("background", "url(http://10.254.200.30/click/file/down/"+result.tunnelVO.file_id+") 0 0 no-repeat");
								$('#'+sFrameId).find('.tunnel-wrap').css("background-size", "calc(100% - 193px)");
								$('#'+sFrameId).find('.tunnel-wrap').css("background-position-x", "129px");
								$('#'+sFrameId).find('.tunnel-wrap').css("background-position-y", "bottom");
								var pageString = "("+nowPage+"/"+elevationTotal+")";
								$('#'+sFrameId).find('.diggingPage').html(pageString);
								fn_goMenu(sFrameId, ctntsMenuId);
							}else if("B" == areaType){
								if(callDash > 1){
									$('#'+sFrameId).html($('#'+sFrameId).find('.b-4-2-tunnel').clone(true).show());
								}else{
									$('#'+sFrameId).html($('.b-4-2-tunnel').clone(true).show());
								}
								$('#'+sFrameId).find('.tunnel-wrap').css("background", "url(http://10.254.200.30/click/file/down/"+result.tunnelVO.file_id+") 0 0 no-repeat");
								$('#'+sFrameId).find('.tunnel-wrap').css("background-size", "calc(100% - 193px)");
								$('#'+sFrameId).find('.tunnel-wrap').css("background-position-x", "129px");
								$('#'+sFrameId).find('.tunnel-wrap').css("background-position-y", "bottom");
								var pageString = "("+nowPage+"/"+elevationTotal+")";
								$('#'+sFrameId).find('.diggingPage').html(pageString);
								fn_goMenu(sFrameId, ctntsMenuId);
							}else if("C" == areaType){
								$('#'+sFrameId).attr("class", "atype-section03 atype-3-2-01 btype_4_2 ctype_4_3");
								if(callDash > 1){
									$('#'+sFrameId).html($('#'+sFrameId).find('.c-4-3-tunnel').clone(true).show());
								}else{
									$('#'+sFrameId).html($('.c-4-3-tunnel').clone(true).show());
								}
								$('#'+sFrameId).find('.tunnel-wrap').css("background", "url(http://10.254.200.30/click/file/down/"+result.tunnelVO.file_id+") 0 0 no-repeat");
								$('#'+sFrameId).find('.tunnel-wrap').css("background-size", "calc(100% - 193px)");
								$('#'+sFrameId).find('.tunnel-wrap').css("background-position-x", "129px");
								var pageString = "("+nowPage+"/"+elevationTotal+")";
								$('#'+sFrameId).find('.diggingPage').html(pageString);
								fn_goMenu(sFrameId, ctntsMenuId);
							}
						}
						
						sUrl = "dashTunnelProcess.json";
						var params = $("form[id=tunnelParameterVO]").serialize();
						$.ajax({
							url : "/click/" + sUrl,
							type : "POST",
							data: params,
							success : function(result) {
								// 4x2 터널 공정율 데이터 세팅
								if(undefined != result.processList){
									var tunnelDiff = result.processList[0].digthrough_process_ing - result.processList[0].digthrough_process_target;
									var processString = "";
									if(tunnelDiff > 0){
										processString = "+";
									}
									$('#'+sFrameId).find('.digthrough_process_target').text(parseFloat(result.processList[0].digthrough_process_target).toFixed(1));	// 목표 공정율
									$('#'+sFrameId).find('.digthrough_process_ing').text(parseFloat(result.processList[0].digthrough_process_ing).toFixed(1));			// 현재 공정율
									$('#'+sFrameId).find('.digthrough_process_diff').text(processString+parseFloat(tunnelDiff).toFixed(1));							// 목표 현재 차이
									fn_goMenu(sFrameId, ctntsMenuId);
								}
								
								if( "46" == process_gubun ){
									var tunnelTotal = parseInt(result.tunnelTotalTotal);
									var nowPage = ctntsCall%tunnelTotal+1;
									pageIdx = nowPage;
									var diggingProgress = 0;
									var tunnelName = "";
									if(!isEmpty(result.tunnelTotalList)){
										if(!isEmpty(result.tunnelTotalList[pageIdx-1].sectionList)){
											for(var j=0;j<result.tunnelTotalList[pageIdx-1].sectionList.length;j++){
												if(!isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].digging_aggregate) && !isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].end_pos) && !isEmpty(result.tunnelTotalList[pageIdx-1].sectionList[j].start_pos)){
													diggingProgress += (parseInt(result.tunnelTotalList[pageIdx-1].sectionList[j].digging_aggregate)/parseInt(result.tunnelTotalList[pageIdx-1].end_pos - result.tunnelTotalList[pageIdx-1].start_pos)*100);
												}
											}
										}
										if(nowLocale == 'en'){
											tunnelName = result.tunnelTotalList[pageIdx-1].dig_name_eng;
										}else{
											tunnelName = result.tunnelTotalList[pageIdx-1].dig_name;
										}
									}
									$('#'+sFrameId).find('.diggingPage2').html("("+nowPage+"/"+tunnelTotal+")");
									$('#'+sFrameId).find('.diggingPercent').html(diggingProgress.toFixed(1));
									$('#'+sFrameId).find('.tunnelName').html(tunnelName);
									$('#'+sFrameId).find('.c-4-3-tunnel').find('.work-graph-wrap2').html('<iframe width="100%" height="150" src="/click/highcharts/type07?chartHeight=130&pageIndex='+nowPage+'"></iframe>');
									$('#'+sFrameId).find('.c-4-3-tunnel').find('.work-graph-wrap1').html('<iframe width="100%" height="150" src="/click/highcharts/type13?chartHeight=130&pageIndex='+nowPage+'"></iframe>');
									fn_goMenu(sFrameId, ctntsMenuId);
								}
							}
						});
					}else if(result.resultCode == "fail"){
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
		}
		
		function fn_towerCraneProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId){
			console.log("fn_towerCraneProcessfn_towerCraneProcessfn_towerCraneProcessfn_towerCraneProcess1");
			if(fn_checkRefresh(ctntsRefresh,ctntsMenuId,ctntsCall)){
				var sUrl = "dashTowerCraneProcess.json";
				var sFrameId = "";
				$('#process_gubun').val(process_gubun);

				// 1x1 T/C현황 조회
				if( "7" == process_gubun ){
					sUrl = "dashTowerCraneProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				if( "19" == process_gubun ){
					sUrl = "dashTowerCraneProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				if( "28" == process_gubun ){
					sUrl = "dashTowerCraneProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				if( "34" == process_gubun ){
					sUrl = "dashTowerCraneProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				if( "41" == process_gubun ){
					sUrl = "dashTowerCraneProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				if( "47" == process_gubun ){
					sUrl = "dashTowerCraneProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				if( "52" == process_gubun ){
					sUrl = "dashTowerCraneProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				var params = $("form[name=dashParameterVO]").serialize();
				$.ajax({
					url : "/click/" + sUrl,
					type : "POST",
					data: params,
					success : function(result) {
						// 1x1 T/C 데이터 세팅
						if( "7" == process_gubun ){
							$('#'+sFrameId).html($("#typeElement").find('.a-1-1-towerCraneProcess').clone(true).show());
							$('#'+sFrameId).find('.towerCraneCount').text(result.craneList.length);	// 타워크레인댓수
							$('#'+sFrameId).find('.anemometerCount').text(result.lastAnemometerList.length);	// 크레인 풍속 AP 댓수
							
							var cautionCount = 0;
							var dangerCount = 0;
							var errorCount = 0;
							
							if(!isEmpty(result.eventVO)){
								if("EVT000005" == result.eventVO.event_type){
									$('#'+sFrameId).find(".craneColor").addClass("cautionTxt");
									$('#'+sFrameId).find(".craneColor").html(txtCaution);
								}else if("EVT000006" == result.eventVO.event_type){
									$('#'+sFrameId).find(".craneColor").addClass("redTxt");
									$('#'+sFrameId).find(".craneColor").html(txtDanger);
								}else if("EVT000009" == result.eventVO.event_type){
									$('#'+sFrameId).find(".craneColor").addClass("redTxt");
									$('#'+sFrameId).find(".craneColor").html(txtDanger);
								}else if("EVT000010" == result.eventVO.event_type){
									$('#'+sFrameId).find(".craneColor").addClass("errorTxt");
									$('#'+sFrameId).find(".craneColor").html("txtError");
								}else if("EVT000011" == result.eventVO.event_type){
									$('#'+sFrameId).find(".craneColor").addClass("errorTxt");
									$('#'+sFrameId).find(".craneColor").html(txtError);
								}
							}else{
								$('#'+sFrameId).find(".craneColor").addClass("greenTxt");
								$('#'+sFrameId).find(".craneColor").html(txtSafe);
							}
							
							fn_searchAnemometer1(sFrameId);
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						if( "19" == process_gubun ){
							$('#'+sFrameId).html($("#typeElement").find('.a-3-1-towerCraneProcess').clone(true).show());
							$('#'+sFrameId).find('.towerCraneCount').text(result.craneList.length);	// 타워크레인댓수
							$('#'+sFrameId).find('.anemometerCount').text(result.lastAnemometerList.length);	// 크레인 풍속 AP 댓수
							var craneHtmlString = '';
							var totalTC = result.craneList.length;
							var tcWidth = 22;
							var tcHeight = 110;
							var styleString = '';
							var fontStyleString = '';
							
							$("#towerCraneArea3_1").css("line-height", "1rem");
							
							if(totalTC > 4 && totalTC < 9){
								tcWidth = 10;
								tcHeight = 50;
								$("#towerCraneArea3_1").css("line-height", "120px");
								styleString = 'padding-top:10px;line-height:1em;';
								fontStyleString = 'style="font-size:0.9rem;padding-top:0px;"';
							}else if(totalTC > 8){
								tcWidth = 10;
								tcHeight = 50;
								$("#towerCraneArea3_1").css("line-height", "1rem");
								styleString = 'padding-top:10px;';
								fontStyleString = 'style="font-size:0.9rem;padding-top:0px;"';
							}
							
							for(var i=0;i<totalTC;i++){
								var statusString = "greenBg";
								if(result.craneList[i].status == "D") {
									statusString = "redBg";
								} else if(result.craneList[i].status == "W") {
									statusString = "orangeBg";
								} else if(result.craneList[i].status == "E") {
									statusString = "errorBg";
								}
								if('en' == nowLocale){
									craneHtmlString += '<div class="tower-div '+statusString+'" style="width:'+tcWidth+'%;height:'+tcHeight+'px;'+styleString+'">'+
										'<strong '+fontStyleString+'>'+result.craneList[i].crane_type+'</strong>'+
										'<p '+fontStyleString+'>'+txtUnit+''+result.craneList[i].device_no+'</p>'+
									'</div>';
								}else{
									craneHtmlString += '<div class="tower-div '+statusString+'" style="width:'+tcWidth+'%;height:'+tcHeight+'px;'+styleString+'">'+
										'<strong '+fontStyleString+'>'+result.craneList[i].crane_type+'</strong>'+
										'<p '+fontStyleString+'>'+result.craneList[i].device_no+''+txtUnit+'</p>'+
									'</div>';
								}
								
							}
							$("#towerCraneArea3_1").html(craneHtmlString);
							console.log("fn_towerCraneProcessfn_towerCraneProcessfn_towerCraneProcessfn_towerCraneProcess2");
							fn_searchAnemometer2(sFrameId);
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if( "28" == process_gubun ){
							if(ctntsCall == 0){
								$('#'+sFrameId).html($('#typeElement').find('.a-3-2-towerCraneProcess').clone(true).show());
								$('#'+sFrameId).find("#mycanvas2").attr("width", $(".rocation-map-area2").width()+"px");
								$('#'+sFrameId).find("#mycanvas2").attr("height", $(".rocation-map-area2").height()+"px");
								//fn_setWebSize($(".rocation-map-area2").width(), $(".rocation-map-area2").height());
								fn_initCrane('mycanvas2', process_gubun, sFrameId, ctntsCall);
							}else{
								fn_craneList(process_gubun, sFrameId, ctntsCall);
							}
						}
						
						if( "34" == process_gubun ){
							$('#'+sFrameId).html($("#typeElement").find('.b-4-1-towerCraneProcess').clone(true).show());
							$('#'+sFrameId).find('.towerCraneCount').text(result.craneList.length);	// 타워크레인댓수
							$('#'+sFrameId).find('.anemometerCount').text(result.lastAnemometerList.length);	// 크레인 풍속 AP 댓수
							var craneHtmlString = '';
							var totalTC = result.craneList.length;
							var tcWidth = 22;
							var tcHeight = 110;
							var styleString = '';
							var fontStyleString = '';
							
							//$("#towerCraneArea3_1").css("line-height", "1rem");
							
							/*if(totalTC > 4 && totalTC < 9){
								tcWidth = 10;
								tcHeight = 50;
								$("#towerCraneArea3_1").css("line-height", "120px");
								styleString = 'padding-top:10px;line-height:1em;';
								fontStyleString = 'style="font-size:0.9rem;padding-top:0px;"';
							}else if(totalTC > 8){
								tcWidth = 10;
								tcHeight = 50;
								$("#towerCraneArea3_1").css("line-height", "1rem");
								styleString = 'padding-top:10px;';
								fontStyleString = 'style="font-size:0.9rem;padding-top:0px;"';
							}*/
							for(var i=0;i<totalTC;i++){
								var statusString = "greenBg";
								if(result.craneList[i].status == "D") {
									statusString = "redBg";
								} else if(result.craneList[i].status == "W") {
									statusString = "orangeBg";
								} else if(result.craneList[i].status == "E") {
									statusString = "errorBg";
								}
								
								var nearCraneList = "";
								if(!isEmpty(result.craneList[i].nearest_crane_list) && 
								   !isEmpty(result.craneList[i].nearest_distance_list)) {
									
									var nearest_crane_list = result.craneList[i].nearest_crane_list.split(",");
									var nearest_distance_list = result.craneList[i].nearest_distance_list.split(",");
									
									for(var k = 0; k < nearest_crane_list.length; k++) {
										if(!isEmpty(nearest_crane_list[k])){
											if('en' == nowLocale){
												nearCraneList += '<li>'+
													'<span>'+txtUnit+'' + nearest_crane_list[k] + ' '+txtDistance+' : </span>'+
													'<span>' + nearest_distance_list[k] + 'm</span>'+
												'</li>';
											}else{
												nearCraneList += '<li>'+
													'<span>' + nearest_crane_list[k] + ''+txtUnit+' '+txtDistance+' : </span>'+
													'<span>' + nearest_distance_list[k] + 'm</span>'+
												'</li>';
											}
										}
									}
								}
								
								if('en' == nowLocale){
									craneHtmlString += '<div class="tower-data-wrap">'+
										'<div class="tower-div2 '+statusString+'">'+
											'<strong>'+result.craneList[i].crane_type+'</strong>'+
											'<p>'+txtUnit+''+result.craneList[i].device_no+'</p>'+
										'</div>'+
										'<ul>'+
											nearCraneList+
										'</ul>'+
									'</div>';
								}else{
									craneHtmlString += '<div class="tower-data-wrap">'+
										'<div class="tower-div2 '+statusString+'">'+
											'<strong>'+result.craneList[i].crane_type+'</strong>'+
											'<p>'+result.craneList[i].device_no+''+txtUnit+'</p>'+
										'</div>'+
										'<ul>'+
											nearCraneList+
										'</ul>'+
									'</div>';
								}
							}
							$('#'+sFrameId).find(".towerCraneArea4_1").html(craneHtmlString);
							
							fn_searchAnemometer3();
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if( "41" == process_gubun ){
							if(ctntsCall == 0){
								$('#'+sFrameId).html($('#typeElement').find('.b-4-2-towerCraneProcess').clone(true).show());
								$('#'+sFrameId).find("#mycanvas4").attr("width", $(".rocation-map-area2").width()+"px");
								$('#'+sFrameId).find("#mycanvas4").attr("height", $(".rocation-map-area2").height()+"px");
								//fn_setWebSize($(".rocation-map-area2").width(), $(".rocation-map-area2").height());
								fn_initCrane('mycanvas4', process_gubun, sFrameId, ctntsCall);
								fn_goMenu(sFrameId, ctntsMenuId);
							}else{
								fn_craneList(process_gubun, sFrameId, ctntsCall);
								fn_goMenu(sFrameId, ctntsMenuId);
							}
						}
						
						if( "47" == process_gubun ){
							if(ctntsCall == 0){
								$('#'+sFrameId).html($('#typeElement').find('.c-4-3-towerCraneProcess').clone(true).show());
								$('#'+sFrameId).attr("class", $("#typeElement").find('.c-4-3-towerCraneProcess').attr("id"));
								$('#'+sFrameId).find("#mycanvas7").attr("width", $(".rocation-map-area2").width()+"px");
								$('#'+sFrameId).find("#mycanvas7").attr("height", $(".rocation-map-area2").height()+"px");
								//fn_setWebSize($(".rocation-map-area2").width(), $(".rocation-map-area2").height());
								fn_initCrane('mycanvas7', process_gubun, sFrameId, ctntsCall);
								fn_goMenu(sFrameId, ctntsMenuId);
							}else{
								fn_craneList(process_gubun, sFrameId, ctntsCall);
								fn_goMenu(sFrameId, ctntsMenuId);
							}
						}
						
						if( "52" == process_gubun ){
							if(ctntsCall == 0){
								$('#'+sFrameId).html($('#typeElement').find('.d-2-3-towerCraneProcess').clone(true).show());
								$('#'+sFrameId).attr("class", $("#typeElement").find('.d-2-3-towerCraneProcess').attr("id"));
								$('#'+sFrameId).find("#mycanvas8").attr("width", $(".rocation-map-area2").width()+"px");
								$('#'+sFrameId).find("#mycanvas8").attr("height", $(".rocation-map-area2").height()+"px");
								$('#'+sFrameId).find('.towerCraneCount').text(result.craneList.length);	// 타워크레인댓수
								//fn_setWebSize($(".rocation-map-area2").width(), $(".rocation-map-area2").height());
								canvasResize();
								$(window).resize(canvasResize);
								fn_initCrane('mycanvas8', process_gubun, sFrameId, ctntsCall);
								if(!isEmpty(result.eventVO)){
									$('#'+sFrameId).find(".event0").html(result.eventVO.event0);
									$('#'+sFrameId).find(".event1").html(result.eventVO.event1);
									$('#'+sFrameId).find(".event2").html(result.eventVO.event2);
									$('#'+sFrameId).find(".event3").html(result.eventVO.event3);
								}
								fn_goMenu(sFrameId, ctntsMenuId);
							}else{
								fn_craneList(process_gubun, sFrameId, ctntsCall);
								if(!isEmpty(result.eventVO)){
									$('#'+sFrameId).find(".event0").html(result.eventVO.event0);
									$('#'+sFrameId).find(".event1").html(result.eventVO.event1);
									$('#'+sFrameId).find(".event2").html(result.eventVO.event2);
									$('#'+sFrameId).find(".event3").html(result.eventVO.event3);
								}
								fn_goMenu(sFrameId, ctntsMenuId);
							}
						}
					}
				});
			}
		}
		
		// 환경 데이터
		// Paramter : frameId ( 각 프레임의 아이디 ) , process_gubun ( 크기별 구분값 )
		// 8 : 1x1 기상센서(AWS)
		// 9 : 1x1 미세먼지센서
		// 20 : 3X1 환경센서현황
		function fn_enviProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId){
			if(fn_checkRefresh(ctntsRefresh,ctntsMenuId,ctntsCall)){
				var sUrl = "dashLocationProcess.json";
				var sFrameId = "";
				$('#process_gubun').val(process_gubun);
	
				// 1x1 기상센서(AWS)
				if( "8" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
	
				// 1x1 미세먼지센서
				if( "9" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 1x1 소음센서
				if( "10" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 1x1 진동센서
				if( "11" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
	
				// 3X1 환경센서현황
				if( "20" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 3X2 환경센서현황
				if( "29" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 4X1 환경센서현황
				if( "35" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 2.5X3 환경센서현황
				if( "53" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// ajax 호출
				var params = $("form[name=dashParameterVO]").serialize();
				$.ajax({
					url : "/click/" + sUrl ,
					type : "POST",
					data: params,
					success : function(result) {
						// 1x1 기상센서(AWS) 데이터 세팅
						if( "8" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-1-1-weatherSensor').clone(true).show());
							$('#'+sFrameId).find('.weatherTemperature').text(result.environmentVO.temperature_tc);				// 온도
							$('#'+sFrameId).find('.weatherHumidity').text(result.environmentVO.humidity);						// 습도
							$('#'+sFrameId).find('.weatherRainsinceonetime').text(result.environmentVO.last1hour);	// 강우량 last1hour
							$('#'+sFrameId).find('.weatherWindwspd').text(result.environmentVO.wind_wspd);						// 풍속
							if('en' == nowLocale){
								var checkWind = result.environmentVO.wind_wdir_name;
								if("북" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("N");
								}else if ("동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("E");
								}else if ("남" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("S");
								}else if ("서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("W");
								}else if ("북동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("NE");
								}else if ("남동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("SE");
								}else if ("남서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("SW");
								}else if ("북서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("NW");
								}
							}else{
								$('#'+sFrameId).find('.weatherWindwdirname').text(result.environmentVO.wind_wdir_name);	
							}
							// 풍향
							
							// 위험경보 Text 색상변경
							// 온/습도
							if( result.environmentVO.heat_index_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherTemperature').removeClass('redTxt').addClass('greenTxt');
								$('#'+sFrameId).find('.weatherHumidity').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherTemperature').removeClass('greenTxt').addClass('redTxt');
								$('#'+sFrameId).find('.weatherHumidity').removeClass('greenTxt').addClass('redTxt');
							}
							
							//강우량
							if( result.environmentVO.rain_since_one_time_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherRainsinceonetime').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherRainsinceonetime').removeClass('greenTxt').addClass('redTxt');
							}
							
							// 풍속/풍향
							if( result.environmentVO.wind_wspd_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherWindwspd').removeClass('redTxt').addClass('greenTxt');
								//$('#'+sFrameId).find('.weatherWindwdirname').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherWindwspd').removeClass('greenTxt').addClass('redTxt');
								//$('#'+sFrameId).find('.weatherWindwdirname').removeClass('greenTxt').addClass('redTxt');
							}
							
							// 위험경보 
							if( result.environmentVO.threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherAlaram').removeClass('redBg');
								$('#'+sFrameId).find('.weatherAlaram').addClass('greenBg');
								$('#'+sFrameId).find('.weatherAlaram').text(txtSafe);
							}else{
								$('#'+sFrameId).find('.weatherAlaram').removeClass('greenBg');
								$('#'+sFrameId).find('.weatherAlaram').addClass('redBg');
								$('#'+sFrameId).find('.weatherAlaram').text(txtDanger);
							}
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						// 1x1 미세먼지센서 데이터 세팅
						if( "9" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-1-1-iotPMSensor').clone(true).show());
							$('#'+sFrameId).find('.a-1-1-iotPMSensor').find('.eq-chart-wrap2').html('<iframe width="100%" height="180" src="/click/highcharts/type09?chartHeight=140"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						// 1x1 소음센서 데이터 세팅
						if( "10" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-1-1-NoiseSensor').clone(true).show());
							$('#'+sFrameId).find('.a-1-1-NoiseSensor').find('.eq-chart-wrap2').html('<iframe width="100%" height="160" src="/click/highcharts/type17?chartHeight=144"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						// 1x1 진동센서 데이터 세팅
						if( "11" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-1-1-VibrationSensor').clone(true).show());
							$('#'+sFrameId).find('.a-1-1-VibrationSensor').find('.eq-chart-wrap2').html('<iframe width="100%" height="160" src="/click/highcharts/type17?chartHeight=144"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						// 3X1 환경센서현황
						if( "20" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-3-1-iotSensor').clone(true).show());
							$('#'+sFrameId).addClass('atype-layout');
							$('#'+sFrameId).find('.weatherTemperature').text(result.environmentVO.temperature_tc);				// 온도
							$('#'+sFrameId).find('.weatherHumidity').text(result.environmentVO.humidity);						// 습도
							$('#'+sFrameId).find('.weatherRainsinceonetime').text(result.environmentVO.last1hour);	// 강우량
							$('#'+sFrameId).find('.weatherWindwspd').text(result.environmentVO.wind_wspd);						// 풍속
							if('en' == nowLocale){
								var checkWind = result.environmentVO.wind_wdir_name;
								if("북" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("N");
								}else if ("동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("E");
								}else if ("남" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("S");
								}else if ("서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("W");
								}else if ("북동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("NE");
								}else if ("남동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("SE");
								}else if ("남서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("SW");
								}else if ("북서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("NW");
								}
							}else{
								$('#'+sFrameId).find('.weatherWindwdirname').text(result.environmentVO.wind_wdir_name);	
							}			// 풍향
							$('#'+sFrameId).find('.weatherAlaram').text(result.environmentVO.alarm);							// 위험경보
							// 위험경보 Text 색상변경
							// 온/습도
							if( result.environmentVO.heat_index_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherTemperature').removeClass('redTxt').addClass('greenTxt');
								$('#'+sFrameId).find('.weatherHumidity').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherTemperature').removeClass('greenTxt').addClass('redTxt');
								$('#'+sFrameId).find('.weatherHumidity').removeClass('greenTxt').addClass('redTxt');
							}
							
							//강우량
							if( result.environmentVO.rain_since_one_time_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherRainsinceonetime').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherRainsinceonetime').removeClass('greenTxt').addClass('redTxt');
							}
							
							// 풍속/풍향
							if( result.environmentVO.wind_wspd_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherWindwspd').removeClass('redTxt').addClass('greenTxt');
								//$('#'+sFrameId).find('.weatherWindwdirname').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherWindwspd').removeClass('greenTxt').addClass('redTxt');
								//$('#'+sFrameId).find('.weatherWindwdirname').removeClass('greenTxt').addClass('redTxt');
							}
							// 위험경보 
							if( result.environmentVO.threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherAlaram').removeClass('redBg');
								$('#'+sFrameId).find('.weatherAlaram').addClass('greenBg');
								$('#'+sFrameId).find('.weatherAlaram').text(txtSafe);
							}else{
								$('#'+sFrameId).find('.weatherAlaram').removeClass('greenBg');
								$('#'+sFrameId).find('.weatherAlaram').addClass('redBg');
								$('#'+sFrameId).find('.weatherAlaram').text(txtDanger);
							}
							
							//$('#'+sFrameId).find('.a-3-1-iotSensor').find('.eq-chart-wrap').html('<iframe width="100%" height="180" src="/click/highcharts/type09?chartHeight=120"></iframe>');
							$('#'+sFrameId).find('.a-3-1-iotSensor').find('.envi-chart-wrap2').html('<iframe width="100%" height="160" src="/click/highcharts/type09?chartHeight=144"></iframe>');
							$('#'+sFrameId).find('.a-3-1-iotSensor').find('.envi-chart-wrap1').html('<iframe width="100%" height="160" src="/click/highcharts/type17?chartHeight=144"></iframe>');
							$('#'+sFrameId).find('.a-3-1-iotSensor').find('.envi-chart-wrap3').html('<iframe width="100%" height="160" src="/click/highcharts/type17?chartHeight=144"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						// 3X2 환경센서현황
						if( "29" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-3-2-iotSensor').clone(true).show());
							$('#'+sFrameId).attr("class", $("#typeElement").find('.a-3-2-iotSensor').attr("id"));
							$('#'+sFrameId).addClass('atype-layout');
							$('#'+sFrameId).find('.weatherTemperature').text(result.environmentVO.temperature_tc);				// 온도
							$('#'+sFrameId).find('.weatherHumidity').text(result.environmentVO.humidity);						// 습도
							$('#'+sFrameId).find('.weatherRainsinceonetime').text(result.environmentVO.last1hour);	// 강우량
							$('#'+sFrameId).find('.weatherWindwspd').text(result.environmentVO.wind_wspd);						// 풍속
							if('en' == nowLocale){
								var checkWind = result.environmentVO.wind_wdir_name;
								if("북" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("N");
								}else if ("동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("E");
								}else if ("남" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("S");
								}else if ("서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("W");
								}else if ("북동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("NE");
								}else if ("남동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("SE");
								}else if ("남서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("SW");
								}else if ("북서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("NW");
								}
							}else{
								$('#'+sFrameId).find('.weatherWindwdirname').text(result.environmentVO.wind_wdir_name);	
							}			// 풍향
							$('#'+sFrameId).find('.weatherAlaram').text(result.environmentVO.alarm);							// 위험경보
							// 위험경보 Text 색상변경
							// 온/습도
							if( result.environmentVO.heat_index_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherTemperature').removeClass('redTxt').addClass('greenTxt');
								$('#'+sFrameId).find('.weatherHumidity').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherTemperature').removeClass('greenTxt').addClass('redTxt');
								$('#'+sFrameId).find('.weatherHumidity').removeClass('greenTxt').addClass('redTxt');
							}
							
							//강우량
							if( result.environmentVO.rain_since_one_time_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherRainsinceonetime').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherRainsinceonetime').removeClass('greenTxt').addClass('redTxt');
							}
							
							// 풍속/풍향
							if( result.environmentVO.wind_wspd_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherWindwspd').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherWindwspd').removeClass('greenTxt').addClass('redTxt');
							}
							// 위험경보 
							if( result.environmentVO.threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherAlaram').removeClass('redBg');
								$('#'+sFrameId).find('.weatherAlaram').addClass('greenBg');
								$('#'+sFrameId).find('.weatherAlaram').text(txtSafe);
							}else{
								$('#'+sFrameId).find('.weatherAlaram').removeClass('greenBg');
								$('#'+sFrameId).find('.weatherAlaram').addClass('redBg');
								$('#'+sFrameId).find('.weatherAlaram').text(txtDanger);
							}
							$('#'+sFrameId).find('.a-3-2-iotSensor').find('.envi-chart-wrap2').html('<iframe width="100%" height="160" src="/click/highcharts/type09?chartHeight=144"></iframe>');
							$('#'+sFrameId).find('.a-3-2-iotSensor').find('.envi-chart-wrap1').html('<iframe width="100%" height="160" src="/click/highcharts/type17?chartHeight=144"></iframe>');
							$('#'+sFrameId).find('.a-3-2-iotSensor').find('.envi-chart-wrap3').html('<iframe width="100%" height="160" src="/click/highcharts/type17?chartHeight=144"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						// 4X1 환경센서현황
						if( "35" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-4-1-iotSensor').clone(true).show());
							$('#'+sFrameId).attr("class", $("#typeElement").find('.a-4-1-iotSensor').attr("id"));
							$('#'+sFrameId).addClass('atype-layout');
							$('#'+sFrameId).find('.weatherTemperature').text(result.environmentVO.temperature_tc);				// 온도
							$('#'+sFrameId).find('.weatherHumidity').text(result.environmentVO.humidity);						// 습도
							$('#'+sFrameId).find('.weatherRainsinceonetime').text(result.environmentVO.last1hour);	// 강우량
							$('#'+sFrameId).find('.weatherWindwspd').text(result.environmentVO.wind_wspd);						// 풍속
							if('en' == nowLocale){
								var checkWind = result.environmentVO.wind_wdir_name;
								if("북" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("N");
								}else if ("동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("E");
								}else if ("남" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("S");
								}else if ("서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("W");
								}else if ("북동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("NE");
								}else if ("남동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("SE");
								}else if ("남서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("SW");
								}else if ("북서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("NW");
								}
							}else{
								$('#'+sFrameId).find('.weatherWindwdirname').text(result.environmentVO.wind_wdir_name);	
							}				// 풍향
							$('#'+sFrameId).find('.weatherAlaram').text(result.environmentVO.alarm);							// 위험경보
							// 위험경보 Text 색상변경
							// 온/습도
							if( result.environmentVO.heat_index_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherTemperature').removeClass('redTxt').addClass('greenTxt');
								$('#'+sFrameId).find('.weatherHumidity').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherTemperature').removeClass('greenTxt').addClass('redTxt');
								$('#'+sFrameId).find('.weatherHumidity').removeClass('greenTxt').addClass('redTxt');
							}
							
							//강우량
							if( result.environmentVO.rain_since_one_time_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherRainsinceonetime').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherRainsinceonetime').removeClass('greenTxt').addClass('redTxt');
							}
							
							// 풍속/풍향
							if( result.environmentVO.wind_wspd_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherWindwspd').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherWindwspd').removeClass('greenTxt').addClass('redTxt');
							}
							// 위험경보 
							if( result.environmentVO.threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherAlaram').removeClass('redBg');
								$('#'+sFrameId).find('.weatherAlaram').addClass('greenBg');
								$('#'+sFrameId).find('.weatherAlaram').text(txtSafe);
							}else{
								$('#'+sFrameId).find('.weatherAlaram').removeClass('greenBg');
								$('#'+sFrameId).find('.weatherAlaram').addClass('redBg');
								$('#'+sFrameId).find('.weatherAlaram').text(txtDanger);
							}
							$('#'+sFrameId).find('.a-4-1-iotSensor').find('.envi-chart-wrap2').html('<iframe width="100%" height="160" src="/click/highcharts/type09?chartHeight=144"></iframe>');
							$('#'+sFrameId).find('.a-4-1-iotSensor').find('.envi-chart-wrap1').html('<iframe width="100%" height="160" src="/click/highcharts/type17?chartHeight=144"></iframe>');
							$('#'+sFrameId).find('.a-4-1-iotSensor').find('.envi-chart-wrap3').html('<iframe width="100%" height="160" src="/click/highcharts/type17?chartHeight=144"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						// 2.5X3 환경센서현황
						if( "53" == process_gubun ){
							$('#'+sFrameId).html($('#typeElement').find('.a-2-5-3-iotSensor').clone(true).show());
							$('#'+sFrameId).attr("class", $("#typeElement").find('.a-2-5-3-iotSensor').attr("id"));
							$('#'+sFrameId).addClass('atype-layout');
							$('#'+sFrameId).find('.weatherTemperature').text(result.environmentVO.temperature_tc);				// 온도
							$('#'+sFrameId).find('.weatherHumidity').text(result.environmentVO.humidity);						// 습도
							$('#'+sFrameId).find('.weatherRainsinceonetime').text(result.environmentVO.last1hour);	// 강우량
							$('#'+sFrameId).find('.weatherWindwspd').text(result.environmentVO.wind_wspd);						// 풍속
							if('en' == nowLocale){
								var checkWind = result.environmentVO.wind_wdir_name;
								if("북" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("N");
								}else if ("동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("E");
								}else if ("남" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("S");
								}else if ("서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("W");
								}else if ("북동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("NE");
								}else if ("남동" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("SE");
								}else if ("남서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("SW");
								}else if ("북서" == checkWind){
									$('#'+sFrameId).find('.weatherWindwdirname').text("NW");
								}
							}else{
								$('#'+sFrameId).find('.weatherWindwdirname').text(result.environmentVO.wind_wdir_name);	
							}				// 풍향
							$('#'+sFrameId).find('.weatherAlaram').text(result.environmentVO.alarm);							// 위험경보
							// 위험경보 Text 색상변경
							// 온/습도
							if( result.environmentVO.heat_index_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherTemperature').removeClass('redTxt').addClass('greenTxt');
								$('#'+sFrameId).find('.weatherHumidity').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherTemperature').removeClass('greenTxt').addClass('redTxt');
								$('#'+sFrameId).find('.weatherHumidity').removeClass('greenTxt').addClass('redTxt');
							}
							
							//강우량
							if( result.environmentVO.rain_since_one_time_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherRainsinceonetime').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherRainsinceonetime').removeClass('greenTxt').addClass('redTxt');
							}
							
							// 풍속/풍향
							if( result.environmentVO.wind_wspd_threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherWindwspd').removeClass('redTxt').addClass('greenTxt');
							}else{
								$('#'+sFrameId).find('.weatherWindwspd').removeClass('greenTxt').addClass('redTxt');
							}
							// 위험경보 
							if( result.environmentVO.threshold_yn == 'N' ){
								$('#'+sFrameId).find('.weatherAlaram').removeClass('redBg');
								$('#'+sFrameId).find('.weatherAlaram').addClass('greenBg');
								$('#'+sFrameId).find('.weatherAlaram').text(txtSafe);
							}else{
								$('#'+sFrameId).find('.weatherAlaram').removeClass('greenBg');
								$('#'+sFrameId).find('.weatherAlaram').addClass('redBg');
								$('#'+sFrameId).find('.weatherAlaram').text(txtDanger);
							}
							$('#'+sFrameId).find('.a-2-5-3-iotSensor').find('.envi-chart-wrap2').html('<iframe width="100%" height="160" src="/click/highcharts/type09?chartHeight=144"></iframe>');
							$('#'+sFrameId).find('.a-2-5-3-iotSensor').find('.envi-chart-wrap1').html('<iframe width="100%" height="160" src="/click/highcharts/type17?chartHeight=144"></iframe>');
							$('#'+sFrameId).find('.a-2-5-3-iotSensor').find('.envi-chart-wrap3').html('<iframe width="100%" height="160" src="/click/highcharts/type17?chartHeight=144"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
					}
				});
			}
		}
		
		function fn_locationMapProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId){
			var sUrl = "";
			var sFrameId = "";
			$('#process_gubun').val(process_gubun);

			if( "24" == process_gubun || "37" == process_gubun || "43" == process_gubun || "49" == process_gubun){
				sUrl = "dashLocationProcess.json";
				sFrameId = "frame_" + frameId;
			}
			
			var params = $("form[name=dashParameterVO]").serialize();
			$.ajax({
				url : "/click/" + sUrl ,
				type : "POST",
				data: params,
				success : function(result) {
					// 3x2 위치관제 맵
					if( "24" == process_gubun ){
						if(ctntsCall == 0){
							$('#'+sFrameId).html($('#typeElement').find('.a-3-2-locationMap').clone(true).show());
							$('#'+sFrameId).find("#mycanvas1").attr("width", $(".rocation-map-area").width()+"px");
							$('#'+sFrameId).find("#mycanvas1").attr("height", $(".rocation-map-area").height()+"px");
							//fn_setWebSize($(".rocation-map-area").width(), $(".rocation-map-area").height());
							fnInit('mycanvas1');
							fn_goMenu(sFrameId, ctntsMenuId);
						}else{
							fn_checkcellList2()
							fn_goMenu(sFrameId, ctntsMenuId);
						}
					}
					
					if( "37" == process_gubun ){
						if(ctntsCall == 0){
							$('#'+sFrameId).html($('#typeElement').find('.b-4-2-locationMap').clone(true).show());
							$('#'+sFrameId).html($('#typeElement').find('.b-4-2-locationMap').clone(true).show());
							$('#'+sFrameId).find("#mycanvas3").attr("width", $(".rocation-map-area").width()+"px");
							$('#'+sFrameId).find("#mycanvas3").attr("height", $(".rocation-map-area").height()+"px");
							//fn_setWebSize($(".rocation-map-area").width(), $(".rocation-map-area").height());
							fnInit('mycanvas3');
							fn_goMenu(sFrameId, ctntsMenuId);
						}else{
							fn_checkcellList2()
							fn_goMenu(sFrameId, ctntsMenuId);
						}
					}
					
					if( "43" == process_gubun ){
						if(ctntsCall == 0){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.c-4-3-locationMap').attr("id"));
							$('#'+sFrameId).html($('#typeElement').find('.c-4-3-locationMap').clone(true).show());
							$('#'+sFrameId).find("#mycanvas5").attr("width", $(".rocation-map-area").width()+"px");
							if($('#fullSceenMode').val() == "Y")
							{
								$(".rocation-map-area").css("height", "810px");
							}
							else
							{
								$(".rocation-map-area").css("height", "625px");
							}
							$('#'+sFrameId).find("#mycanvas5").attr("height", $(".rocation-map-area").height()+"px");
							//fn_setWebSize($(".rocation-map-area").width(), $(".rocation-map-area").height());
							fnInit('mycanvas5');
							fn_goMenu(sFrameId, ctntsMenuId);
						}else{
							fn_checkcellList2()
							fn_goMenu(sFrameId, ctntsMenuId);
						}
					}
					
					if( "49" == process_gubun ){
						if(ctntsCall == 0){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.d-2-3-locationMap').attr("id"));
							$('#'+sFrameId).html($('#typeElement').find('.d-2-3-locationMap').clone(true).show());
							$('#'+sFrameId).find("#mycanvas6").attr("width", $(".rocation-map-area").width()+"px");
							$('#'+sFrameId).find("#mycanvas6").attr("height", $(".rocation-map-area").height()+"px");
							//fn_setWebSize($(".rocation-map-area").width(), $(".rocation-map-area").height());
							fnInit('mycanvas6');
							fn_workerProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId);
							fn_goMenu(sFrameId, ctntsMenuId);
						}else{
							fn_workerProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId);
							fn_checkcellList2()
							fn_goMenu(sFrameId, ctntsMenuId);
						}
					}
				}
			});
		}
		
		function fnInit(canvasId) {
			var params = $("form[name=parameterVO]").serialize(); 
			$.ajax({
				url : "/click/selectSiteDetail.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						
						openDefaultPopup("loadingPopup", "");
						
						set_site_info(result.siteInfo.company_id, result.siteInfo.project_id, result.siteInfo.map_url, scene);
						bootstrap2(MENU_TYPE.DASHBOARD, fn_onResultInitMap, canvasId);
						
					}else if(result.resultCode == "fail"){
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
	   	}
		
		function fn_onResultInitMap() {
	   		fn_closeLoadingPopup();
	   		fn_movePoiToCenter();
	   	}
		
		var zoomIn = false;
		
		function fn_movePoiToCenter() {
			var buildingId = $("#building_id").val();
			var zoneId = $("#zone_id").val();
			var cellId = $("#cell_id").val();
			var poiId = $("#poi_id").val();

			fn_checkcellList2();
	   	}
		
		function fn_checkcellList2() {
			
			
			var params = $("form[id=mapParameterVO]").serialize(); 
			$.ajax({
				url : "/click/checkCellAreaList.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						fn_refreshAirTag(MENU_TYPE.DASHBOARD, result.svrTagList, result.svrPoiList);
						fn_refreshGateWorkerCount( result.gateWorkerCount, true);
						var cellId = $("#cell_id").val();
						if(!isEmpty(cellId)){
							if(!zoomIn){
								var poiId = $("#poi_id").val();
								moveMapbyPoi(poiId);
								setTimeout(function() {
									setZoomInOut('true');
						   			setZoomInOut('true');
									zoomIn = true;
								}, 3000);
							}
						}
					}else{
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
		}
		
		$(".left-menu").hover(
				function(e){
					$(".live_img").hide();
					$(".live_blank_img").show();
				}, 
				function(e){
					if($(window).width()>1600){
						$(".live_blank_img").hide();
						$(".live_img").show();
					}else{
						if( $('.left-menu-open').css("display") == "none" ){
							$(".live_blank_img").hide();
							$(".live_img").show();
						}
					}
				}
		);
		
		// cctv 감추기
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
		
		function fn_initCrane(canvasId, process_gubun, sFrameId, ctntsCall) {
			var params = $("form[name=parameterVO]").serialize(); 
			$.ajax({
				url : "/click/selectSiteDetail.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						openDefaultPopup("loadingPopup", "");
						set_site_info(result.siteInfo.company_id, result.siteInfo.project_id, result.siteInfo.map_url, result.craneVO.scene_id);
						bootstrap2(MENU_TYPE.CRANE, fn_onResultInitMapCrane(process_gubun, sFrameId, ctntsCall), canvasId);
					}else if(result.resultCode == "fail"){
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
	   	}
		function fn_onResultInitMapCrane(process_gubun, sFrameId, ctntsCall) {
			fn_closeLoadingPopup();
			fn_checkScene2();
			fn_craneList(process_gubun, sFrameId, ctntsCall);
	   	}
	   	
		function fn_checkScene2() {
			var baseHeight = 2;
			var params = $("form[id=mapParameterVO]").serialize(); 
			$.ajax({
				url : "/click/selectCraneList.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						var htmlString = '';
						if(undefined != result.craneList){
							for(var i=0;i<result.craneList.length;i++){
	                            fn_makeTowerCrane(result.craneList[i], baseHeight, i+1);
							}
						}
					}else{
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
		}
		
		function fn_craneList(process_gubun, sFrameId, ctntsCall){
			fn_searchAnemometer();
			var params = $("form[name=parameterVO]").serialize(); 
			$.ajax({
				url : "/click/selectCraneList.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						
						fn_refreshAirTag(MENU_TYPE.CRANE, result.svrTagList, result.svrPoiList);

						var htmlString = '';
						for(var i=0;i<result.craneList.length;i++){
							var statusString = "safe-led";
							var statusText = txtSafe;
							if(result.craneList[i].status == "D") {
								statusString = "danger-led";
								statusText = "경고";
							} else if(result.craneList[i].status == "W") {
								statusString = "caution-led";
								statusText = txtDanger;
							} else if(result.craneList[i].status == "E") {
								statusString = "error-led";
								statusText = "점검";
							} 
							
							if('en' == nowLocale){
								htmlString += '<tr onclick="javascript:fn_callBackTouch(\''+result.craneList[i].poi_id+'\');return false;">'+
									'<td class="center">' + result.craneList[i].crane_type + '-'+txtUnit+''+ result.craneList[i].device_no+'</td>'+
									'<td class="center">'+
										'<div class="'+statusString+'">'+statusText+'</div>'+
									'</td>'+
								'</tr>';
							}else{
								htmlString += '<tr onclick="javascript:fn_callBackTouch(\''+result.craneList[i].poi_id+'\');return false;">'+
									'<td class="center">' + result.craneList[i].crane_type + "-" + result.craneList[i].device_no+''+txtUnit+'</td>'+
									'<td class="center">'+
										'<div class="'+statusString+'">'+statusText+'</div>'+
									'</td>'+
								'</tr>';
							}
							
							fn_updateTowerCrane(result.craneList[i], result.craneList[i].poi_id, result.craneList[i].yaw, result.craneList[i].pitch, i+1);
						}
						//console.log('htmlString = ' + htmlString);
						$('#'+sFrameId).find(".craneList").html(htmlString);
						
						if("52" == process_gubun){
							var craneTotal = result.craneList.length;
							var totalPage = 0;
							totalPage = parseInt(craneTotal/2);
							if(craneTotal%2 > 0){
								totalPage++;
							}
							var nowPage = ctntsCall%totalPage+1;
							$('#'+sFrameId).find(".cranePaging").html("("+nowPage+"/"+totalPage+")");
							$('#'+sFrameId).find(".tcArea").html("");
							for(var j=((nowPage-1)*2);j<(2*nowPage);j++){
								var poiId = result.craneList[j].poi_id;
								$.ajax({
									url : "/click/selectCraneByPoiId.json?poi_id="+poiId,
									type : "POST",
									success : function(result2) {
										if( result2.resultCode == "success"){
											if(!isEmpty(result2.craneResultVO)){
												var tcColor = "greenBg";
												var craneStatus = txtSafe;
												
												if(!isEmpty(result2.craneResultVO.event_type)){
													if(result2.craneResultVO.event_type == "EVT000005"
															|| result2.craneResultVO.event_type == "EVT000007") {
														tcColor = "orangeBg";
														craneStatus = txtCaution;
													} else if(result2.craneResultVO.event_type == "EVT000006" 
															|| result2.craneResultVO.event_type == "EVT000008"
															|| result2.craneResultVO.event_type == "EVT000009"){
														tcColor = "redBg";
														craneStatus = txtDanger;
													} else if(result2.craneResultVO.event_type == "EVT000011" 
															|| result2.craneResultVO.event_type == "EVT000010"){
														tcColor = "errorBg";
														craneStatus = "점검";
													} else {
														tcColor = "greenBg";
														craneStatus = txtSafe;
													}					
												}
												
												var nearCraneList = "";
												if(!isEmpty(result2.craneResultVO.nearest_crane_list) && 
												   !isEmpty(result2.craneResultVO.nearest_distance_list)) {
													
													var nearest_crane_list = result2.craneResultVO.nearest_crane_list.split(",");
													var nearest_distance_list = result2.craneResultVO.nearest_distance_list.split(",");
													
													for(var k = 0; k < nearest_crane_list.length; k++) {
														if(!isEmpty(nearest_crane_list[k])){
															if('en' == nowLocale){
																nearCraneList += '<li>'+
																	'<span>'+txtUnit+'' + nearest_crane_list[k] + ' '+txtDistance+' : </span>'+
																	'<span>' + nearest_distance_list[k] + 'm</span>'+
																'</li>';
															}else{
																nearCraneList += '<li>'+
																	'<span>' + nearest_crane_list[k] + ''+txtUnit+' '+txtDistance+' : </span>'+
																	'<span>' + nearest_distance_list[k] + 'm</span>'+
																'</li>';
															}
														}
													}
												}
												
												var totalHtmlString = '';
												if('en' == nowLocale){
													totalHtmlString = '<div class="tower-data-wrap">'+
														'<div class="tower-div2 '+tcColor+'">'+
															'<strong>'+result2.craneResultVO.crane_type+'</strong>'+
															'<p>'+txtUnit+''+result2.craneResultVO.device_no+'</p>'+
														'</div>'+
														'<ul>'+
														nearCraneList+
														'</ul>'+
													'</div>';
												}else{
													totalHtmlString = '<div class="tower-data-wrap">'+
														'<div class="tower-div2 '+tcColor+'">'+
															'<strong>'+result2.craneResultVO.crane_type+'</strong>'+
															'<p>'+result2.craneResultVO.device_no+''+txtUnit+'</p>'+
														'</div>'+
														'<ul>'+
														nearCraneList+
														'</ul>'+
													'</div>';
												}
												
												$('#'+sFrameId).find(".tcArea").append(totalHtmlString);
											}else{
												var totalHtmlString = '';
												if('en' == nowLocale){
													totalHtmlString = '<div class="tower-data-wrap">'+
														'<div class="tower-div2 errorBg">'+
															'<strong>'+result.craneList[i].crane_type+'</strong>'+
															'<p>'+txtUnit+''+result.craneList[i].device_no+'</p>'+
														'</div>'+
														'<ul>'+
														nearCraneList+
														'</ul>'+
													'</div>';
												}else{
													totalHtmlString = '<div class="tower-data-wrap">'+
														'<div class="tower-div2 errorBg">'+
															'<strong>'+result.craneList[i].crane_type+'</strong>'+
															'<p>'+result.craneList[i].device_no+''+txtUnit+'</p>'+
														'</div>'+
														'<ul>'+
														nearCraneList+
														'</ul>'+
													'</div>';
												}
												
												$('#'+sFrameId).find(".tcArea").append(totalHtmlString);
											}
										}
									}
								});
							}
						}
					}else{
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
		}
		
		function fn_searchAnemometer(){
			var params = $("form[name=parameterVO]").serialize(); 
			$.ajax({
				url : "/click/selectLastAnemometerList.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						var htmlString = '';
						for(var i=0;i<result.lastAnemometerList.length;i++){
							$("#device_no").val(result.lastAnemometerList[i].device_no);
							
							var wind_warning_threshold = result.lastAnemometerList[i].wind_warning_threshold;
							var wind_danger_threshold = result.lastAnemometerList[i].wind_danger_threshold;
							
							var wind_speed_current = '-';
							if(!isEmpty(result.lastAnemometerList[i].wind_speed_current)){
								wind_speed_current = parseFloat(result.lastAnemometerList[i].wind_speed_current);	
							}
							var wind_speed_average = '-';
							if(!isEmpty(result.lastAnemometerList[i].wind_speed_average)){
								wind_speed_average = parseFloat(result.lastAnemometerList[i].wind_speed_average);
							}

							var statusString = 'safe';
							if(result.lastAnemometerList[i].status == "D") {
								statusString = 'danger';
							} else if(result.lastAnemometerList[i].status == "W") {
								statusString = 'caution';
							}
							
							var windCurrentHtmlClass = '';
							var windAverageHtmlClass = '';
							var windBrHtml = '';
							var windShameClass= '';
							if('en' == nowLocale){
								windCurrentHtmlClass = 'wind-current-eng';
								windAverageHtmlClass = 'wind-average-eng';
								windBrHtml = '<br>';
								windShameClass = 'shame2';
							}

							htmlString += '<li class="flag-wrap">'+
												'<i class="flag-icon flag-'+statusString+'">'+txtWindSpeedIcon+'</i>'+
												'<span> No.'+ result.lastAnemometerList[i].device_no +'</span>'+
												'<span  class="'+windCurrentHtmlClass+'">'+
													'<strong>'+txtInstantaneous+'</strong>'+windBrHtml+''+txtWindSpeed+''+
												'</span>'+
												'<span class="shame '+windShameClass+'">'+
													'<em class="ds-'+statusString+'">'+wind_speed_current+'</em>m/s'+
												'</span>'+
												'<div class="div-line"></div>'+
												'<span class="'+windAverageHtmlClass+'">'+
													'<strong>'+txtAverage+'</strong>'+windBrHtml+''+txtWindSpeed+''+
												'</span>'+
												'<span class="shame '+windShameClass+'">'+
													'<em class="ds-'+statusString+'">'+wind_speed_average+'</em>m/s'+
												'</span>'+
											'</li>';
						}
						$(".tc-flag-area").html(htmlString);
					}else{
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
			
		}
		
		function fn_searchAnemometer1(sFrameId){
			var params = $("form[name=parameterVO]").serialize(); 
			$.ajax({
				url : "/click/selectCheckAnemometerList.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						var warningCount = 0;
						var dangerCount = 0;
						var htmlString = '';
						var statusString = 'S';
						var deviceNo = '';
						var checkArray = new Array();
						var eventId = '';
						var wind_speed_current = '-';
						var firstString = '';
						for(var i=0;i<result.lastAnemometerList.length;i++){
							if(!isEmpty(result.eventVO)){
								eventId = result.eventVO.event_id;
								if(eventId == result.lastAnemometerList[i].error_code){
									deviceNo = result.lastAnemometerList[i].device_no;
									if("EVT000007" == result.eventVO.event_type){
										statusString = 'W';
									}else{
										statusString = 'D';
									}
									
									if(!isEmpty(result.lastAnemometerList[i].wind_speed_current)){
										wind_speed_current = parseFloat(result.lastAnemometerList[i].wind_speed_current);	
									}
									
									if('en' == nowLocale){
										firstString = txtNo+deviceNo;
									}else{
										firstString = deviceNo+txtNo;
									}
								}
							}
						}
						
						if('D' != statusString && 'W' != statusString){
							if(!isEmpty(result.lastAnemometerList[0].wind_speed_current)){
								wind_speed_current = parseFloat(result.lastAnemometerList[0].wind_speed_current);	
							}
						}
						
						if('D' == statusString){
							$("#"+sFrameId).find(".windSpeedColor").addClass("redTxt");
							$("#"+sFrameId).find(".windTxt").html(firstString+" "+txtDanger);
							$("#"+sFrameId).find(".windSpeed").html("("+wind_speed_current+"m/s)");
						}else if('W' == statusString){
							$("#"+sFrameId).find(".windSpeedColor").addClass("orangeTxt");
							$("#"+sFrameId).find(".windTxt").html(firstString+" "+txtCaution);
							$("#"+sFrameId).find(".windSpeed").html("("+wind_speed_current+"m/s)");
						}else if('S' == statusString){
							$("#"+sFrameId).find(".windSpeedColor").addClass("greenTxt");
							$("#"+sFrameId).find(".windTxt").html(txtSafe+" ");
							$("#"+sFrameId).find(".windSpeed").html("("+wind_speed_current+"m/s)");
						}
					}else{
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
			
		}
		
		function fn_searchAnemometer2(sFrameId){
			var params = $("form[name=parameterVO]").serialize(); 
			$.ajax({
				url : "/click/selectLastAnemometerList.json",
				type : "POST",
				data: params,
				success : function(result) {
					console.log("fn_towerCraneProcessfn_towerCraneProcessfn_towerCraneProcessfn_towerCraneProcess3");
					if(result.resultCode == "success"){
						var htmlString = '';
						for(var i=0;i<result.lastAnemometerList.length;i++){
							$("#device_no").val(result.lastAnemometerList[i].device_no);
							
							var wind_warning_threshold = result.lastAnemometerList[i].wind_warning_threshold;
							var wind_danger_threshold = result.lastAnemometerList[i].wind_danger_threshold;
							
							var wind_speed_current = '-';
							if(!isEmpty(result.lastAnemometerList[i].wind_speed_current)){
								wind_speed_current = parseFloat(result.lastAnemometerList[i].wind_speed_current);	
							}
							var wind_speed_average = '-';
							if(!isEmpty(result.lastAnemometerList[i].wind_speed_average)){
								wind_speed_average = parseFloat(result.lastAnemometerList[i].wind_speed_average);
							}

							var statusString = 'safe';
							if(result.lastAnemometerList[i].status == "D") {
								statusString = 'danger';
							} else if(result.lastAnemometerList[i].status == "W") {
								statusString = 'caution';
							}
							
							var marginSize = '';
							if(i!=0){
								marginSize = 'mt10';
							}
							
							var windCurrentHtmlClass = '';
							var windAverageHtmlClass = '';
							var windBrHtml = '';
							var windShameClass= '';
							if('en' == nowLocale){
								windCurrentHtmlClass = 'wind-current-eng';
								windAverageHtmlClass = 'wind-average-eng';
								windBrHtml = '<br>';
								windShameClass = 'shame2';
							}

							htmlString += '<li class="flag-wrap '+marginSize+'">'+
														'<i class="flag-icon flag-'+statusString+'">'+txtWindSpeedIcon+'</i>'+
														'<span>'+
															'NO.'+result.lastAnemometerList[i].device_no+
														'</span>'+
														'<span class="'+windCurrentHtmlClass+'">'+
															'<strong>'+txtInstantaneous+'</strong>'+windBrHtml+''+txtWindSpeed+''+
														'</span>'+
														'<span class="shame '+windShameClass+'">'+
															'<em class="ds-'+statusString+'">'+wind_speed_current+'</em>m/s'+
														'</span>'+
														'<div class="div-line"></div>'+
														'<span class="'+windAverageHtmlClass+'">'+
															'<strong>'+txtAverage+'</strong>'+windBrHtml+''+txtWindSpeed+''+
														'</span>'+
														'<span class="shame '+windShameClass+'">'+
															'<em class="ds-'+statusString+'">'+wind_speed_average+'</em>m/s'+
														'</span>'+
													'</li>';
						}
						$("#"+sFrameId).find(".anemometerArea3_1").html(htmlString);
					}else{
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
			
		}
		
		function fn_searchAnemometer3(){
			var params = $("form[name=parameterVO]").serialize(); 
			$.ajax({
				url : "/click/selectLastAnemometerList.json",
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						var htmlString = '';
						for(var i=0;i<result.lastAnemometerList.length;i++){
							$("#device_no").val(result.lastAnemometerList[i].device_no);
							
							var wind_warning_threshold = result.lastAnemometerList[i].wind_warning_threshold;
							var wind_danger_threshold = result.lastAnemometerList[i].wind_danger_threshold;
							
							var wind_speed_current = '-';
							if(!isEmpty(result.lastAnemometerList[i].wind_speed_current)){
								wind_speed_current = parseFloat(result.lastAnemometerList[i].wind_speed_current);	
							}
							var wind_speed_average = '-';
							if(!isEmpty(result.lastAnemometerList[i].wind_speed_average)){
								wind_speed_average = parseFloat(result.lastAnemometerList[i].wind_speed_average);
							}

							var statusString = 'safe';
							if(result.lastAnemometerList[i].status == "D") {
								statusString = 'danger';
							} else if(result.lastAnemometerList[i].status == "W") {
								statusString = 'caution';
							}
							
							var marginSize = '';
							if(i!=0){
								marginSize = 'mt10';
							}
							var windCurrentHtmlClass = '';
							var windAverageHtmlClass = '';
							var windBrHtml = '';
							var windShameClass= '';
							if('en' == nowLocale){
								windCurrentHtmlClass = 'wind-current-eng';
								windAverageHtmlClass = 'wind-average-eng';
								windBrHtml = '<br>';
								windShameClass = 'shame2';
							}

							htmlString += '<li class="flag-wrap '+marginSize+'">'+
														'<i class="flag-icon flag-'+statusString+'">'+txtWindSpeedIcon+'</i>'+
														'<span>'+
															'NO.'+result.lastAnemometerList[i].device_no+
														'</span>'+
														'<span class="'+windCurrentHtmlClass+'">'+
															'<strong>'+txtInstantaneous+'</strong>'+windBrHtml+''+txtWindSpeed+''+
														'</span>'+
														'<span class="shame '+windShameClass+'">'+
															'<em class="ds-'+statusString+'">'+wind_speed_current+'</em>m/s'+
														'</span>'+
														'<div class="div-line"></div>'+
														'<span class="'+windAverageHtmlClass+'">'+
															'<strong>'+txtAverage+'</strong>'+windBrHtml+''+txtWindSpeed+''+
														'</span>'+
														'<span class="shame '+windShameClass+'">'+
															'<em class="ds-'+statusString+'">'+wind_speed_average+'</em>m/s'+
														'</span>'+
													'</li>';
						}
						$(".anemometerArea4_1").html(htmlString);
					}else{
						openDefaultPopup("loginPopup", result.message);
					}
				}
			});
		}
		
		function fn_retainProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId){
			if(fn_checkRefresh(ctntsRefresh,ctntsMenuId,ctntsCall)){
				var sUrl = "";
				var sFrameId = "";
				$('#process_gubun').val(process_gubun);
				if( "12" == process_gubun || "21" == process_gubun || "54" == process_gubun){
					sUrl = "dashRetainProcess.json";
					sFrameId = "frame_" + frameId;
				}
				var params = $("form[name=dashParameterVO]").serialize();
				$.ajax({
					url : "/click/" + sUrl ,
					type : "POST",
					data: params,
					success : function(result) {
						if("12" == process_gubun){
							//$('#'+sFrameId).attr("class", $("#typeElement").find('.a-1-1-retain').attr("id"));
							$('#'+sFrameId).html($("#typeElement").find('.a-1-1-retain').clone(true).show());
							$('#'+sFrameId).find(".retainCount").html(result.retainVO.retain_count);
							$('#'+sFrameId).find(".countU").html(result.retainVO.countU+txtPiece);
							$('#'+sFrameId).find(".countB").html(result.retainVO.countB+txtPiece);
							$('#'+sFrameId).find(".countG").html(result.retainVO.countG+txtPiece);
							$('#'+sFrameId).find(".countM").html(result.retainVO.countM+txtPiece);
							$('#'+sFrameId).find(".countE").html(result.retainVO.countE+txtPiece);
							if(!isEmpty(result.eventList)){
								for(var i=0;i<result.eventList.length;i++){
									var sensorType = result.eventList[i].sensor_type;
									if("U" == sensorType){
										var htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										if(result.eventList[i].retain_event_1>0){
											htmlString = '<em class="redBg">'+txtDanger+'</em>';
										}else if(result.eventList[i].retain_event_2>0){
											htmlString = '<em class="errorBg">'+txtError+'</em>';
										}else{
											htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										}
										$('#'+sFrameId).find(".retainStatusU").html(htmlString);
									}else if("B" == sensorType){
										var htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										if(result.eventList[i].retain_event_1>0){
											htmlString = '<em class="redBg">'+txtDanger+'</em>';
										}else if(result.eventList[i].retain_event_2>0){
											htmlString = '<em class="errorBg">'+txtError+'</em>';
										}else{
											htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										}
										$('#'+sFrameId).find(".retainStatusB").html(htmlString);
									}else if("G" == sensorType){
										var htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										if(result.eventList[i].retain_event_1>0){
											htmlString = '<em class="redBg">'+txtDanger+'</em>';
										}else if(result.eventList[i].retain_event_2>0){
											htmlString = '<em class="errorBg">'+txtError+'</em>';
										}else{
											htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										}
										$('#'+sFrameId).find(".retainStatusG").html(htmlString);
									}else if("M" == sensorType){
										var htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										if(result.eventList[i].retain_event_1>0){
											htmlString = '<em class="redBg">'+txtDanger+'</em>';
										}else if(result.eventList[i].retain_event_2>0){
											htmlString = '<em class="errorBg">'+txtError+'</em>';
										}else{
											htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										}
										$('#'+sFrameId).find(".retainStatusM").html(htmlString);
									}else if("E" == sensorType){
										var htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										if(result.eventList[i].retain_event_1>0){
											htmlString = '<em class="redBg">'+txtDanger+'</em>';
										}else if(result.eventList[i].retain_event_2>0){
											htmlString = '<em class="errorBg">'+txtError+'</em>';
										}else{
											htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										}
										$('#'+sFrameId).find(".retainStatusE").html(htmlString);
									}
								}
								
							}
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if("21" == process_gubun){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.a-3-1-retain').attr("id"));
							$('#'+sFrameId).html($("#typeElement").find('.a-3-1-retain').clone(true).show());
							
							$('#'+sFrameId).find(".retainText").each(function(){
								$(this).removeClass("greenTxt");
								$(this).removeClass("redTxt");
								$(this).removeClass("errorTxt");
								$(this).addClass("greenTxt");
							})
							$('#'+sFrameId).find(".countU").html(result.retainVO.countU);
							$('#'+sFrameId).find(".countB").html(result.retainVO.countB);
							$('#'+sFrameId).find(".countG").html(result.retainVO.countG);
							$('#'+sFrameId).find(".countM").html(result.retainVO.countM);
							$('#'+sFrameId).find(".countE").html(result.retainVO.countE);
							
							if(!isEmpty(result.eventList)){
								for(var i=0;i<result.eventList.length;i++){
									var sensorType = result.eventList[i].sensor_type;
									if("U" == sensorType){
										var htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										var classString = 'greenTxt';
										if(result.eventList[i].retain_event_1>0){
											htmlString = '<em class="redBg">'+txtDanger+'</em>';
											classString = 'redTxt';
										}else if(result.eventList[i].retain_event_2>0){
											htmlString = '<em class="errorBg">'+txtError+'</em>';
											classString = 'errorTxt';
										}else{
											htmlString = '<em class="greenBg">'+txtSafe+'</em>';
											classString = 'greenTxt';
										}
										$('#'+sFrameId).find(".countU").addClass(classString);
										$('#'+sFrameId).find(".retainStatusU").html(htmlString);
									}else if("B" == sensorType){
										var htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										var classString = 'greenTxt';
										if(result.eventList[i].retain_event_1>0){
											htmlString = '<em class="redBg">'+txtDanger+'</em>';
											classString = 'redTxt';
										}else if(result.eventList[i].retain_event_2>0){
											htmlString = '<em class="errorBg">'+txtError+'</em>';
											classString = 'errorTxt';
										}else{
											htmlString = '<em class="greenBg">'+txtSafe+'</em>';
											classString = 'greenTxt';
										}
										$('#'+sFrameId).find(".countB").addClass(classString);
										$('#'+sFrameId).find(".retainStatusB").html(htmlString);
									}else if("G" == sensorType){
										var htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										var classString = 'greenTxt';
										if(result.eventList[i].retain_event_1>0){
											htmlString = '<em class="redBg">'+txtDanger+'</em>';
											classString = 'redTxt';
										}else if(result.eventList[i].retain_event_2>0){
											htmlString = '<em class="errorBg">'+txtError+'</em>';
											classString = 'errorTxt';
										}else{
											htmlString = '<em class="greenBg">'+txtSafe+'</em>';
											classString = 'greenTxt';
										}
										$('#'+sFrameId).find(".countG").addClass(classString);
										$('#'+sFrameId).find(".retainStatusG").html(htmlString);
									}else if("M" == sensorType){
										var htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										var classString = 'greenTxt';
										if(result.eventList[i].retain_event_1>0){
											htmlString = '<em class="redBg">'+txtDanger+'</em>';
											classString = 'redTxt';
										}else if(result.eventList[i].retain_event_2>0){
											htmlString = '<em class="errorBg">'+txtError+'</em>';
											classString = 'errorTxt';
										}else{
											htmlString = '<em class="greenBg">'+txtSafe+'</em>';
											classString = 'greenTxt';
										}
										$('#'+sFrameId).find(".countM").addClass(classString);
										$('#'+sFrameId).find(".retainStatusM").html(htmlString);
									}else if("E" == sensorType){
										var htmlString = '<em class="greenBg">'+txtSafe+'</em>';
										var classString = 'greenTxt';
										if(result.eventList[i].retain_event_1>0){
											htmlString = '<em class="redBg">'+txtDanger+'</em>';
											classString = 'redTxt';
										}else if(result.eventList[i].retain_event_2>0){
											htmlString = '<em class="errorBg">'+txtError+'</em>';
											classString = 'errorTxt';
										}else{
											htmlString = '<em class="greenBg">'+txtSafe+'</em>';
											classString = 'greenTxt';
										}
										$('#'+sFrameId).find(".countE").addClass(classString);
										$('#'+sFrameId).find(".retainStatusE").html(htmlString);
									}
								}
								
							}
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if("54" == process_gubun){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.d-2-3-retain').attr("id"));
							
							var htmlString = '<dt class="title clickTitle">'+txtEarth+'</dt>';
							var countU = parseInt(result.retainVO.countU);
							var countB = parseInt(result.retainVO.countB);
							var countG = parseInt(result.retainVO.countG);
							var countM = parseInt(result.retainVO.countM);
							var countE = parseInt(result.retainVO.countE);
							var typeCount = 0;
							
							if(countU > 0){
								typeCount++;
								var event1 = 0;
								var event2 = 0;
								for(var e=0;e<result.eventList.length;e++){
									if("U" == result.eventList[e].sensor_type){
										event1 = result.eventList[e].retain_event_1;
										event2 = result.eventList[e].retain_event_2;
									}
								}
								
								var totalPageU = 0;
								totalPageU = parseInt(countU/8);
								if(countU%8 > 0){
									totalPageU++;
								}
								var nowPage = ctntsCall%totalPageU+1;
								var subHtmlString = '';
								for(var i=((nowPage-1)*8);i<(8*nowPage);i++){
									if(i<countU){
										var lightString1 = 'normal';
										var lightString2 = 'normal';
										var lightString3 = 'normal';
										console.log("Uevent1 : "+result.retainListU[i].retain_event_1);
										console.log("Uevent2 : "+result.retainListU[i].retain_event_2);
										if('0' == result.retainListU[i].retain_event_1 && '0' == result.retainListU[i].retain_event_2){
											lightString1 = 'safe';
										}
										if(!isEmpty(result.retainListU[i].retain_event_1) && '0' != result.retainListU[i].retain_event_1){
											lightString2 = 'danger';
										}
										if(!isEmpty(result.retainListU[i].retain_event_2) && '0' != result.retainListU[i].retain_event_2){
											lightString3 = 'error';
										}
										if('en' == nowLocale){
											subHtmlString += '<dd class="lightWrap">'+
												'<span>'+txtNo+''+result.retainListU[i].device_no+'</span>'+
												'<div class="'+lightString1+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString2+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString3+'">'+
													txtSignal+
												'</div>'+
											'</dd>';
										}else{
											subHtmlString += '<dd class="lightWrap">'+
												'<span>'+result.retainListU[i].device_no+''+txtNo+'</span>'+
												'<div class="'+lightString1+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString2+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString3+'">'+
													txtSignal+
												'</div>'+
											'</dd>';
										}
									}
								}
								
								if('en'==nowLocale){
									htmlString += '<dd class="dust-section-area ea5 ml20" style="padding:8px!important;">'+
													'<ul class="title-wrap" style="margin-bottom:0px;">'+
														'<li class="title" style="width:100%;font-size:0.8rem;line-height:15px;">Underground Inclinometer</li><br>'+
														'<li style="font-size:0.8rem;line-height:15px;">'+txtPiece+'</li>'+
														'<li class="blue" style="font-size:0.8rem;line-height:15px;">'+countU+'</li>'+
														'<li style="font-size:0.8rem;line-height:15px;">'+txtTotal+'</li>'+
													'</ul>';
								}else{
									htmlString += '<dd class="dust-section-area ea5 ml20">'+
													'<ul class="title-wrap">'+
														'<li class="title">지중경사계</li>'+
														'<li>'+txtPiece+'</li>'+
														'<li class="blue">'+countU+'</li>'+
														'<li>'+txtTotal+'</li>'+
													'</ul>'
								}
								
								htmlString += 	'<dl class="today-event-wrap">'+
													'<dt>'+txtEvent+'</dt>'+
													'<dd>'+
														'<span class="order-t" style="font-size:0.6rem!important;">'+txtCriteria+' : </span>'+
														'<div>'+
															'<em class="blue">'+event1+'</em>'+
															'<span>'+txtCount+'</span>'+
														'</div>'+
													'</dd>'+
													'<dd>'+
														'<span class="order-t" style="font-size:0.6rem!important;">'+txtComunicationFail+' : </span>'+
														'<div>'+
															'<em class="blue">'+event2+'</em>'+
															'<span>'+txtCount+'</span>'+
														'</div>'+
													'</dd>'+
												'</dl>'+
												'<dl class="state-light-wrap">'+
													subHtmlString+
												'</dl>'+
											'</dd>';
							}
							
							if(countB > 0){
								typeCount++;
								var event1 = 0;
								var event2 = 0;
								for(var e=0;e<result.eventList.length;e++){
									if("B" == result.eventList[e].sensor_type){
										event1 = result.eventList[e].retain_event_1;
										event2 = result.eventList[e].retain_event_2;
									}
								}
								
								var totalPageB = 0;
								totalPageB = parseInt(countB/8);
								if(countB%8 > 0){
									totalPageB++;
								}
								var nowPage = ctntsCall%totalPageB+1;
								var subHtmlString = '';
								for(var i=((nowPage-1)*8);i<(8*nowPage);i++){
									if(i<countB){
										var lightString1 = 'normal';
										var lightString2 = 'normal';
										var lightString3 = 'normal';
										console.log("Bevent1 : "+result.retainListB[i].retain_event_1);
										console.log("Bevent2 : "+result.retainListB[i].retain_event_2);
										if('0' == result.retainListB[i].retain_event_1 && '0' == result.retainListB[i].retain_event_2){
											lightString1 = 'safe';
										}
										if(!isEmpty(result.retainListB[i].retain_event_1) && '0' != result.retainListB[i].retain_event_1){
											lightString2 = 'danger';
										}
										if(!isEmpty(result.retainListB[i].retain_event_2) && '0' != result.retainListB[i].retain_event_2){
											lightString3 = 'error';
										}
										if('en' == nowLocale){
											subHtmlString += '<dd class="lightWrap">'+
												'<span>'+txtNo+''+result.retainListB[i].device_no+'</span>'+
												'<div class="'+lightString1+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString2+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString3+'">'+
													txtSignal+
												'</div>'+
											'</dd>';
										}else{
											subHtmlString += '<dd class="lightWrap">'+
												'<span>'+result.retainListB[i].device_no+''+txtNo+'</span>'+
												'<div class="'+lightString1+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString2+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString3+'">'+
													txtSignal+
												'</div>'+
											'</dd>';
										}
									}
								}
								
								if('en'==nowLocale){
									htmlString += '<dd class="dust-section-area ea5 ml20" style="padding:8px!important;">'+
													'<ul class="title-wrap" style="margin-bottom:0px;">'+
														'<li class="title" style="width:100%;font-size:0.8rem;line-height:15px;">Groundwater Level Gauge</li><br>'+
														'<li style="font-size:0.8rem;line-height:15px;">'+txtPiece+'</li>'+
														'<li class="blue" style="font-size:0.8rem;line-height:15px;">'+countB+'</li>'+
														'<li style="font-size:0.8rem;line-height:15px;">'+txtTotal+'</li>'+
													'</ul>';
								}else{
									htmlString += '<dd class="dust-section-area ea5 ml20">'+
														'<ul class="title-wrap">'+
														'<li class="title">지하수위계</li>'+
														'<li>'+txtPiece+'</li>'+
														'<li class="blue">'+countB+'</li>'+
														'<li>'+txtTotal+'</li>'+
													'</ul>';
								}
								
								htmlString += '<dl class="today-event-wrap">'+
													'<dt>'+txtEvent+'</dt>'+
													'<dd>'+
														'<span class="order-t" style="font-size:0.6rem!important;">'+txtCriteria+' : </span>'+
														'<div>'+
															'<em class="blue">'+event1+'</em>'+
															'<span>'+txtCount+'</span>'+
														'</div>'+
													'</dd>'+
													'<dd>'+
														'<span class="order-t" style="font-size:0.6rem!important;">'+txtComunicationFail+' : </span>'+
														'<div>'+
															'<em class="blue">'+event2+'</em>'+
															'<span>'+txtCount+'</span>'+
														'</div>'+
													'</dd>'+
												'</dl>'+
												'<dl class="state-light-wrap">'+
													subHtmlString+
												'</dl>'+
											'</dd>';
							}
							
							if(countG > 0){
								typeCount++;
								var event1 = 0;
								var event2 = 0;
								for(var e=0;e<result.eventList.length;e++){
									if("G" == result.eventList[e].sensor_type){
										event1 = result.eventList[e].retain_event_1;
										event2 = result.eventList[e].retain_event_2;
									}
								}
								
								var totalPageG = 0;
								totalPageG = parseInt(countG/8);
								if(countG%8 > 0){
									totalPageG++;
								}
								var nowPage = ctntsCall%totalPageG+1;
								var subHtmlString = '';
								for(var i=((nowPage-1)*8);i<(8*nowPage);i++){
									if(i<countG){
										var lightString1 = 'normal';
										var lightString2 = 'normal';
										var lightString3 = 'normal';
										console.log("Gevent1 : "+result.retainListG[i].retain_event_1);
										console.log("Gevent2 : "+result.retainListG[i].retain_event_2);
										if('0' == result.retainListG[i].retain_event_1 && '0' == result.retainListG[i].retain_event_2){
											lightString1 = 'safe';
										}
										if(!isEmpty(result.retainListG[i].retain_event_1) && '0' != result.retainListG[i].retain_event_1){
											lightString2 = 'danger';
										}
										if(!isEmpty(result.retainListG[i].retain_event_2) && '0' != result.retainListG[i].retain_event_2){
											lightString3 = 'error';
										}
										if('en' == nowLocale){
											subHtmlString += '<dd class="lightWrap">'+
												'<span>'+txtNo+''+result.retainListG[i].device_no+'</span>'+
												'<div class="'+lightString1+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString2+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString3+'">'+
													txtSignal+
												'</div>'+
											'</dd>';
										}else{
											subHtmlString += '<dd class="lightWrap">'+
												'<span>'+result.retainListG[i].device_no+''+txtNo+'</span>'+
												'<div class="'+lightString1+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString2+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString3+'">'+
													txtSignal+
												'</div>'+
											'</dd>';
										}
									}
								}
								
								if('en'==nowLocale){
									htmlString += '<dd class="dust-section-area ea5 ml20" style="padding:8px!important;">'+
													'<ul class="title-wrap" style="margin-bottom:0px;">'+
														'<li class="title" style="width:100%;font-size:0.8rem;line-height:15px;">Ground Surface Settlement Gauge</li><br>'+
														'<li style="font-size:0.8rem;line-height:15px;">'+txtPiece+'</li>'+
														'<li class="blue" style="font-size:0.8rem;line-height:15px;">'+countG+'</li>'+
														'<li style="font-size:0.8rem;line-height:15px;">'+txtTotal+'</li>'+
													'</ul>';
								}else{
									htmlString += '<dd class="dust-section-area ea5 ml20">'+
														'<ul class="title-wrap">'+
														'<li class="title">지표침하계</li>'+
														'<li>'+txtPiece+'</li>'+
														'<li class="blue">'+countG+'</li>'+
														'<li>'+txtTotal+'</li>'+
													'</ul>';
								}
								
								htmlString += '<dl class="today-event-wrap">'+
													'<dt>'+txtEvent+'</dt>'+
													'<dd>'+
														'<span class="order-t" style="font-size:0.6rem!important;">'+txtCriteria+' : </span>'+
														'<div>'+
															'<em class="blue">'+event1+'</em>'+
															'<span>'+txtCount+'</span>'+
														'</div>'+
													'</dd>'+
													'<dd>'+
														'<span class="order-t" style="font-size:0.6rem!important;">'+txtComunicationFail+' : </span>'+
														'<div>'+
															'<em class="blue">'+event2+'</em>'+
															'<span>'+txtCount+'</span>'+
														'</div>'+
													'</dd>'+
												'</dl>'+
												'<dl class="state-light-wrap">'+
													subHtmlString+
												'</dl>'+
											'</dd>';
							}
							
							if(countM > 0){
								typeCount++;
								var event1 = 0;
								var event2 = 0;
								for(var e=0;e<result.eventList.length;e++){
									if("M" == result.eventList[e].sensor_type){
										event1 = result.eventList[e].retain_event_1;
										event2 = result.eventList[e].retain_event_2;
									}
								}
								
								var totalPageM = 0;
								totalPageM = parseInt(countM/8);
								if(countM%8 > 0){
									totalPageM++;
								}
								var nowPage = ctntsCall%totalPageM+1;
								var subHtmlString = '';
								for(var i=((nowPage-1)*8);i<(8*nowPage);i++){
									if(i<countM){
										var lightString1 = 'normal';
										var lightString2 = 'normal';
										var lightString3 = 'normal';
										console.log("Mevent1 : "+result.retainListM[i].retain_event_1);
										console.log("Mevent2 : "+result.retainListM[i].retain_event_2);
										if('0' == result.retainListM[i].retain_event_1 && '0' == result.retainListM[i].retain_event_2){
											lightString1 = 'safe';
										}
										if(!isEmpty(result.retainListM[i].retain_event_1) && '0' != result.retainListM[i].retain_event_1){
											lightString2 = 'danger';
										}
										if(!isEmpty(result.retainListM[i].retain_event_2) && '0' != result.retainListM[i].retain_event_2){
											lightString3 = 'error';
										}
										if('en' == nowLocale){
											subHtmlString += '<dd class="lightWrap">'+
												'<span>'+txtNo+''+result.retainListM[i].device_no+'</span>'+
												'<div class="'+lightString1+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString2+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString3+'">'+
													txtSignal+
												'</div>'+
											'</dd>';
										}else{
											subHtmlString += '<dd class="lightWrap">'+
												'<span>'+result.retainListM[i].device_no+''+txtNo+'</span>'+
												'<div class="'+lightString1+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString2+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString3+'">'+
													txtSignal+
												'</div>'+
											'</dd>';
										}
									}
								}
								
								if('en'==nowLocale){
									htmlString += '<dd class="dust-section-area ea5 ml20" style="padding:8px!important;">'+
													'<ul class="title-wrap" style="margin-bottom:0px;">'+
														'<li class="title" style="width:100%;font-size:0.8rem;line-height:15px;">Strain Gauge</li><br>'+
														'<li style="font-size:0.8rem;line-height:15px;">'+txtPiece+'</li>'+
														'<li class="blue" style="font-size:0.8rem;line-height:15px;">'+countM+'</li>'+
														'<li style="font-size:0.8rem;line-height:15px;">'+txtTotal+'</li>'+
													'</ul>';
								}else{
									htmlString += '<dd class="dust-section-area ea5 ml20">'+
														'<ul class="title-wrap">'+
														'<li class="title">변형률계</li>'+
														'<li>'+txtPiece+'</li>'+
														'<li class="blue">'+countM+'</li>'+
														'<li>'+txtTotal+'</li>'+
													'</ul>';
								}
								
								htmlString += '<dl class="today-event-wrap">'+
													'<dt>'+txtEvent+'</dt>'+
													'<dd>'+
														'<span class="order-t" style="font-size:0.6rem!important;">'+txtCriteria+' : </span>'+
														'<div>'+
															'<em class="blue">'+event1+'</em>'+
															'<span>'+txtCount+'</span>'+
														'</div>'+
													'</dd>'+
													'<dd>'+
														'<span class="order-t" style="font-size:0.6rem!important;">'+txtComunicationFail+' : </span>'+
														'<div>'+
															'<em class="blue">'+event2+'</em>'+
															'<span>'+txtCount+'</span>'+
														'</div>'+
													'</dd>'+
												'</dl>'+
												'<dl class="state-light-wrap">'+
													subHtmlString+
												'</dl>'+
											'</dd>';
							}
							
							if(countE > 0){
								typeCount++;
								var event1 = 0;
								var event2 = 0;
								for(var e=0;e<result.eventList.length;e++){
									if("E" == result.eventList[e].sensor_type){
										event1 = result.eventList[e].retain_event_1;
										event2 = result.eventList[e].retain_event_2;
									}
								}
								
								var totalPageE = 0;
								totalPageE = parseInt(countE/8);
								if(countE%8 > 0){
									totalPageE++;
								}
								var nowPage = ctntsCall%totalPageE+1;
								var subHtmlString = '';
								for(var i=((nowPage-1)*8);i<(8*nowPage);i++){
									if(i<countE){
										var lightString1 = 'normal';
										var lightString2 = 'normal';
										var lightString3 = 'normal';
										console.log("Eevent1 : "+result.retainListE[i].retain_event_1);
										console.log("Eevent2 : "+result.retainListE[i].retain_event_2);
										if('0' == result.retainListE[i].retain_event_1 && '0' == result.retainListE[i].retain_event_2){
											lightString1 = 'safe';
										}
										if(!isEmpty(result.retainListE[i].retain_event_1) && '0' != result.retainListE[i].retain_event_1){
											lightString2 = 'danger';
										}
										if(!isEmpty(result.retainListE[i].retain_event_2) && '0' != result.retainListE[i].retain_event_2){
											lightString3 = 'error';
										}
										if('en' == nowLocale){
											subHtmlString += '<dd class="lightWrap">'+
												'<span>'+txtNo+''+result.retainListE[i].device_no+'</span>'+
												'<div class="'+lightString1+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString2+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString3+'">'+
													txtSignal+
												'</div>'+
											'</dd>';
										}else{
											subHtmlString += '<dd class="lightWrap">'+
												'<span>'+result.retainListE[i].device_no+''+txtNo+'</span>'+
												'<div class="'+lightString1+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString2+'">'+
													txtSignal+
												'</div>'+
												'<div class="'+lightString3+'">'+
													txtSignal+
												'</div>'+
											'</dd>';
										}
									}
								}
								
								if('en'==nowLocale){
									htmlString += '<dd class="dust-section-area ea5 ml20" style="padding:8px!important;">'+
													'<ul class="title-wrap" style="margin-bottom:0px;">'+
														'<li class="title" style="width:100%;font-size:0.8rem;line-height:15px;">E/A Road Cell</li><br>'+
														'<li style="font-size:0.8rem;line-height:15px;">'+txtPiece+'</li>'+
														'<li class="blue" style="font-size:0.8rem;line-height:15px;">'+countE+'</li>'+
														'<li style="font-size:0.8rem;line-height:15px;">'+txtTotal+'</li>'+
													'</ul>';
								}else{
									htmlString += '<dd class="dust-section-area ea5 ml20">'+
														'<ul class="title-wrap">'+
														'<li class="title">E/A하중계</li>'+
														'<li>'+txtPiece+'</li>'+
														'<li class="blue">'+countE+'</li>'+
														'<li>'+txtTotal+'</li>'+
													'</ul>';
								}
								
								htmlString += '<dl class="today-event-wrap">'+
													'<dt>'+txtEvent+'</dt>'+
													'<dd>'+
														'<span class="order-t" style="font-size:0.6rem!important;">'+txtCriteria+' : </span>'+
														'<div>'+
															'<em class="blue">'+event1+'</em>'+
															'<span>'+txtCount+'</span>'+
														'</div>'+
													'</dd>'+
													'<dd>'+
														'<span class="order-t" style="font-size:0.6rem!important;">'+txtComunicationFail+' : </span>'+
														'<div>'+
															'<em class="blue">'+event2+'</em>'+
															'<span>'+txtCount+'</span>'+
														'</div>'+
													'</dd>'+
												'</dl>'+
												'<dl class="state-light-wrap">'+
													subHtmlString+
												'</dl>'+
											'</dd>';
							}
						
						/**/
							if(typeCount == 1){
								$(".dust-section-area").css("margin-top", "250px");
							}else if(typeCount == 2){
								$(".dust-section-area").css("margin-top", "145px");
							}else if(typeCount == 3){
								$(".dust-section-area").css("margin-top", "80px");
							}else if(typeCount == 4){
								$(".dust-section-area").css("margin-top", "40px");
							}else if(typeCount == 5){
								$(".dust-section-area").css("margin-top", "15px");
							}
							$('#'+sFrameId).html($("#typeElement").find('.d-2-3-retain').clone(true).show());
							$('#'+sFrameId).find('.d-2-3-retain').html(htmlString);
							fn_goMenu(sFrameId, ctntsMenuId);
						}
					}
				});
			}
		}
		
		function fn_equipProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId){
			if(fn_checkRefresh(ctntsRefresh,ctntsMenuId,ctntsCall)){
				var sUrl = "";
				var sFrameId = "";
				$('#process_gubun').val(process_gubun);
		
				if( "13" == process_gubun || "22" == process_gubun || "55" == process_gubun){
					sUrl = "dashEquipProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				var params = $("form[name=dashParameterVO]").serialize();
				$.ajax({
					url : "/click/" + sUrl ,
					type : "POST",
					data: params,
					success : function(result) {
						var equipTotal = 0;
						if(!isEmpty(result.equipTotal)){
							equipTotal = result.equipTotal;
						}
						
						if("13" == process_gubun){
							//$('#'+sFrameId).attr("class", $("#typeElement").find('.a-1-1-equip').attr("id"));
							$('#'+sFrameId).html($("#typeElement").find('.a-1-1-equip').clone(true).show());
							var totalPage = 0;
							totalPage = parseInt(equipTotal/4);
							if(equipTotal%4 > 0){
								totalPage++;
							}
							var nowPage = ctntsCall%totalPage+1;
							var htmlString = '';
							for(var i=((nowPage-1)*4);i<(4*nowPage);i++){
								if(i<equipTotal){
									var status = result.equipList[i].status;
									var textString = txtSafe;
									if("safe" == status){
										textString = txtSafe;
									}else if("danger" == status){
										textString = txtZoneInvasion;
									}else if("error" == status){
										textString = txtError;
									}
									if(isEmpty(status)){
										status = 'safe'
									}
									
									if('en' == nowLocale){
										htmlString = '<dl class="data-table-wrap4">'+
											'<dt>'+txtNo+''+result.equipList[i].device_no+'</dt>'+
											'<dd class="'+status+'">'+
												textString+
											'</dd>'+
										'</dl>';
									}else{
										htmlString = '<dl class="data-table-wrap4">'+
											'<dt>'+result.equipList[i].device_no+''+txtNo+'</dt>'+
											'<dd class="'+status+'">'+
												textString+
											'</dd>'+
										'</dl>';
									}
								}
							}
							
							$('#'+sFrameId).find(".equipPaging").html("("+nowPage+"/"+totalPage+")");
							$('#'+sFrameId).find(".equipTotal").html(equipTotal);
							$('#'+sFrameId).find(".equipArea").html(htmlString);
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if("22" == process_gubun){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.a-3-1-equip').attr("id"));
							$('#'+sFrameId).html($("#typeElement").find('.a-3-1-equip').clone(true).show());
							var totalPage = 0;
							totalPage = parseInt(equipTotal/1);
							if(equipTotal%1 > 0){
								totalPage++;
							}
							var nowPage = ctntsCall%totalPage+1;
							var htmlString = '';
							for(var i=((nowPage-1)*1);i<(1*nowPage);i++){
								if(i<equipTotal){
									var status = result.equipList[i].status;
									var textString = txtSafe;
									if("safe" == status){
										textString = txtSafe;
									}else if("danger" == status){
										textString = txtZoneInvasion;
									}else if("error" == status){
										textString = txtError;
									}
									if(isEmpty(status)){
										status = 'safe'
									}
									var htmlString = '<em class="greenBg" style="line-height:120px;height:120px;">'+txtSafe+'</em>';
									if("safe" == status){
										htmlString = '<em class="greenBg" style="line-height:120px;height:120px;">'+txtSafe+'</em>';
									}else if("danger" == status){
										htmlString = '<em class="redBg" style="line-height:120px;height:120px;">'+txtZoneInvasion+'</em>';
									}else if("error" == status){
										htmlString = '<em class="errorBg" style="line-height:120px;height:120px;">'+txtError+'</em>';
									}
									$('#'+sFrameId).find(".equipStatus").html(htmlString);
									if('en' == nowLocale){
										$('#'+sFrameId).find(".equipDeviceNo").html(txtNo+''+result.equipList[i].device_no);
									}else{
										$('#'+sFrameId).find(".equipDeviceNo").html(result.equipList[i].device_no+''+txtNo);
									}
									$('#'+sFrameId).find(".equipMacAddr").html(result.equipList[i].mac_addr);
									if(nowLocale == 'en'){
										$('#'+sFrameId).find(".equipBuildingName").html(result.equipList[i].building_name_eng);
										$('#'+sFrameId).find(".equipZoneName").html(result.equipList[i].floor_eng);
										$('#'+sFrameId).find(".equipCellName").html(result.equipList[i].cell_name_eng);
									}else{
										$('#'+sFrameId).find(".equipBuildingName").html(result.equipList[i].building_name);
										$('#'+sFrameId).find(".equipZoneName").html(result.equipList[i].floor);
										$('#'+sFrameId).find(".equipCellName").html(result.equipList[i].cell_name);
									}
									
									if(!isEmpty(result.equipList[i].worker_name)){
										$('#'+sFrameId).find(".equipWorkerName").html(result.equipList[i].worker_name);
									}
									if(!isEmpty(result.equipList[i].worker_name2)){
										$('#'+sFrameId).find(".equipWorkerName2").html(result.equipList[i].worker_name2);
									}
									if(!isEmpty(result.equipList[i].event_worker_name)){
										$('#'+sFrameId).find(".eventWorkerName").html(result.equipList[i].event_worker_name);
										$('#'+sFrameId).find(".eventWorkerArea").css("display", "block");
									}
								}
							}
							var totalString = '<em>'+txtTotal+'</em>'+equipTotal+'<em>'+txtEquipUnit+'</em>';
							$('#'+sFrameId).find(".equipPaging").html("("+nowPage+"/"+totalPage+")");
							$('#'+sFrameId).find(".equipTotal").html(totalString);
							$('#'+sFrameId).find(".equipArea").html(htmlString);
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if("55" == process_gubun){
							$('#'+sFrameId).attr("class", $("#typeElement").find('.d-2-3-equip').attr("id"));
							$('#'+sFrameId).html($("#typeElement").find('.d-2-3-equip').clone(true).show());
							var totalPage = 0;
							totalPage = parseInt(equipTotal/4);
							if(equipTotal%4 > 0){
								totalPage++;
							}
							var nowPage = ctntsCall%totalPage+1;
							var htmlString = '';
							var totalHtmlString = '';
							
							for(var i=((nowPage-1)*4);i<(4*nowPage);i++){
								if(i<equipTotal){
									var workerNameString = '';
									var workerNameString2 = '';
									var eventNameString = '';
									if(!isEmpty(result.equipList[i].worker_name)){
										workerNameString = result.equipList[i].worker_name;
									}
									if(!isEmpty(result.equipList[i].worker_name2)){
										workerNameString2 = result.equipList[i].worker_name2;
									}
									if(!isEmpty(result.equipList[i].event_worker_name)){
										eventNameString = '<li class="red font-normal eventWorkerArea">'+
															'<span>'+txtUnauthorized+' : </span>'+
															'<span class="eventWorkerName">'+result.equipList[i].event_worker_name+'</span>'+
														'</li>';
									}
									var status = result.equipList[i].status;
									var htmlString = '<em class="greenBg" style="line-height:100px;height:100px;">'+txtSafe+'</em>';
									if("safe" == status){
										htmlString = '<em class="greenBg" style="line-height:100px;height:100px;">'+txtSafe+'</em>';
									}else if("danger" == status){
										htmlString = '<em class="redBg" style="line-height:100px;height:100px;">'+txtZoneInvasion+'</em>';
									}else if("error" == status){
										htmlString = '<em class="errorBg" style="line-height:100px;height:100px;">'+txtError+'</em>';
									}
									if(isEmpty(status)){
										status = 'safe'
									}
									if('en' == nowLocale){
										totalHtmlString += '<div class="ap-status-wrap" style="width:calc(100% - 60px)!important;">'+
												'<div class="worker-status" style="height:110px;padding:5px 0;">'+
												'<i style="margin:0 20px;"><img src="/click/resources/img/sub/eq-icon.png" alt="" style="width:100px;"></i>'+
												'<ul class="ap-status" style="padding-top:0px;">'+
													'<li>'+
														'<span style="max-width:160px!important;">'+txtEquipmentNumber+' : </span>'+
														'<span class="equipDeviceNo">'+txtNo+''+result.equipList[i].device_no+'</span>'+
													'</li>'+
													'<li>'+
														'<span>MAC : </span>'+
														'<span class="equipMacAddr">'+result.equipList[i].mac_addr+'</span>'+
													'</li>'+
													'<li>'+
														'<span class="equipBuildingName">'+result.equipList[i].building_name_eng+'</span>'+
														'<span> / </span>'+
														'<span class="equipZoneName">'+result.equipList[i].floor_eng+'</span>'+
														'<span> / </span>'+
														'<span class="equipCellName">'+result.equipList[i].cell_name_eng+'</span>'+
													'</li>'+
												'</ul>'+
												'<ul class="ap-status" style="padding-top:0px;">'+
													'<li>'+
														'<span>'+txtApprover+'1 : </span>'+
														'<span class="equipWorkerName">'+workerNameString+'</span>'+
													'</li>'+
													'<li>'+
														'<span>'+txtApprover+'2 : </span>'+
														'<span class="equipWorkerName2">'+workerNameString2+'</span>'+
													'</li>'+
													eventNameString+
												'</ul>'+
												'<dl class="state-bg-wrap4 equipStatus">'+
													htmlString+
												'</dl>'+
											'</div>'+
										'</div>';
									}else{
										totalHtmlString += '<div class="ap-status-wrap" style="width:calc(100% - 60px)!important;">'+
												'<div class="worker-status" style="height:110px;padding:5px 0;">'+
												'<i style="margin:0 20px;"><img src="/click/resources/img/sub/eq-icon.png" alt="" style="width:100px;"></i>'+
												'<ul class="ap-status" style="padding-top:0px;">'+
													'<li>'+
														'<span style="max-width:160px!important;">'+txtEquipmentNumber+' : </span>'+
														'<span class="equipDeviceNo">'+result.equipList[i].device_no+''+txtNo+'</span>'+
													'</li>'+
													'<li>'+
														'<span>MAC : </span>'+
														'<span class="equipMacAddr">'+result.equipList[i].mac_addr+'</span>'+
													'</li>'+
													'<li>'+
														'<span class="equipBuildingName">'+result.equipList[i].building_name+'</span>'+
														'<span> / </span>'+
														'<span class="equipZoneName">'+result.equipList[i].floor+'</span>'+
														'<span> / </span>'+
														'<span class="equipCellName">'+result.equipList[i].cell_name+'</span>'+
													'</li>'+
												'</ul>'+
												'<ul class="ap-status" style="padding-top:0px;">'+
													'<li>'+
														'<span>'+txtApprover+'1 : </span>'+
														'<span class="equipWorkerName">'+workerNameString+'</span>'+
													'</li>'+
													'<li>'+
														'<span>'+txtApprover+'2 : </span>'+
														'<span class="equipWorkerName2">'+workerNameString2+'</span>'+
													'</li>'+
													eventNameString+
												'</ul>'+
												'<dl class="state-bg-wrap4 equipStatus">'+
													htmlString+
												'</dl>'+
											'</div>'+
										'</div>';
									}
								}
							}
							$('#'+sFrameId).find('.d-2-3-equipList').html(totalHtmlString);
							var totalString = equipTotal;
							$('#'+sFrameId).find(".equipPaging").html("("+nowPage+"/"+totalPage+")");
							if(!isEmpty(result.eventVO)){
								if(!isEmpty(result.eventVO.equip_event_1)){
									$('#'+sFrameId).find(".equipEvent1").html(parseInt(result.eventVO.equip_event_1));
								}
								if(!isEmpty(result.eventVO.equip_event_2)){
									$('#'+sFrameId).find(".equipEvent2").html(parseInt(result.eventVO.equip_event_2));
								}
							}
							
							$('#'+sFrameId).find(".equipTotal").html(totalString);
							$('#'+sFrameId).find(".equipArea").html(htmlString);
							fn_goMenu(sFrameId, ctntsMenuId);
						}
					}
				});
			}
		}

		function fn_eventProcess(frameId,process_gubun,ctntsRefresh,ctntsCall,ctntsMenuId){
			if(fn_checkRefresh(ctntsRefresh,ctntsMenuId,ctntsCall)){
				var sUrl = "";
				var sFrameId = "";
				$('#process_gubun').val(process_gubun);
		
				if( "15" == process_gubun || "16" == process_gubun){
					sUrl = "dashEventProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				var params = $("form[name=dashParameterVO]").serialize();
				$.ajax({
					url : "/click/" + sUrl ,
					type : "POST",
					data: params,
					success : function(result) {
						if("15" == process_gubun){
							//$('#'+sFrameId).attr("class", $("#typeElement").find('.a-1-1-event').attr("id"));
							$('#'+sFrameId).html($("#typeElement").find('.a-1-1-event').clone(true).show());
							$('#'+sFrameId).find('.totalEvent').html(result.eventVO.event_total);
							$('#'+sFrameId).find('.event0').html(result.eventVO.event0);
							$('#'+sFrameId).find('.event1').html(result.eventVO.event1);
							$('#'+sFrameId).find('.event2').html(result.eventVO.event2);
							fn_goMenu(sFrameId, ctntsMenuId);
						}
						
						if("16" == process_gubun){
							//$('#'+sFrameId).attr("class", $("#typeElement").find('.a-1-1-event2').attr("id"));
							$('#'+sFrameId).html($("#typeElement").find('.a-1-1-event2').clone(true).show());
							$('#'+sFrameId).find('.totalEvent').html(result.eventVO.event_total);
							$('#'+sFrameId).find('.a-1-1-event2').find('.eq-chart-wrap3').html('<iframe width="100%" height="140" src="/click/highcharts/type18?chartHeight=80"></iframe>');
							fn_goMenu(sFrameId, ctntsMenuId);
						}
					}
				});
			}
		}
		
		$(document).keydown(function(e){
			var keyCode = e.keyCode;
			
			if("13" == keyCode){
				if("Y" == $("#fullSceenMode").val()){
					var agent = navigator.userAgent.toLowerCase();

					if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
						fn_fullScreen();
					}
					location.reload();
					$(".page-navigation").css("width", "40%");
					$(".con-wrap").css("width", "calc(100% - 70px)");
					$(".con-wrap").css("margin-left", "70px");
				}
			}
		});
		
		// 전체화면 설정
		function openFullScreenMode() {
		    if (docV.webkitRequestFullscreen){ // Chrome, Safari (webkit)
		        docV.webkitRequestFullscreen();
		    } else if (docV.mozRequestFullScreen){ // Firefox
		        docV.mozRequestFullScreen();
		    } else if (docV.msRequestFullscreen) { // IE or Edge
		        docV.msRequestFullscreen();
		    }
		}
		
		function fn_checkRefresh(ctntsRefresh,menuId,ctntsCall){
			
			if( menuId != "7" ){
				if(0 == ctntsRefresh && 0 == ctntsCall){
					return true;
				}else if(0 == ctntsRefresh){
					return false;
				}else if(0 == ctntsCall%(ctntsRefresh/5)){
					return true;
				}else{
					return false;
				}
			}else{
				// Rolling
				// CCTV
				if( menuId == "7" && ctntsCall == 0 ){
					return "1";
				}else if(0 == ctntsCall%(ctntsRefresh/5)){
					return "2";
				}else{
					return "3";
				}
			}
		}
		