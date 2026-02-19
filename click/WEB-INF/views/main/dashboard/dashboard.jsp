<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/detect-zoom-min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dashboard.js"></script>
	<script type="text/javascript">
		// CCTV 데이터
		// Paramter : frameId ( 각 프레임의 아이디 ) , process_gubun ( 크기별 구분값 )
		// 14 : 1x1 CCTV 현황
		var nowLocale = '${locale}';
		
		
		var txtDanger = '<spring:message code="click.danger"/>';
		var txtSafe = '<spring:message code="click.safety"/>';
		var txtError = '<spring:message code="click.error"/>';
		var txtCaution = '<spring:message code="click.caution"/>';
		var txtComunicationFail = '<spring:message code="click.communication.failure"/>';
		var txtCount = '<spring:message code="click.counts"/>';
		var txtCriteria = '<spring:message code="click.criteria.exceed"/>';
		var txtSignal = '<spring:message code="click.signal.light"/>';
		var txtZoneInvasion = '<spring:message code="click.zone.invasion"/>';
		var txtNo = '<spring:message code="click.no" arguments="1"/>';		
		var txtUnit = '<spring:message code="click.unit"/>';
		var txtDistance = '<spring:message code="click.distance"/>';
		var txtWindSpeedIcon = '<spring:message code="click.wind.speed.safety.icon"/>';
		var txtInstantaneous = '<spring:message code="click.instantaneous"/>';
		var txtWindSpeed = '<spring:message code="click.wind.speed"/>';
		var txtAverage = '<spring:message code="click.average"/>';
		var txtEquipment = '<spring:message code="click.equipment.stricture"/>';
		var txtEquipmentNumber = '<spring:message code="click.equipment.number"/>';
		var txtApprover = '<spring:message code="click.approver"/>';
		var txtUnauthorized = '<spring:message code="click.unauthorized.worker"/>';
		var txtTotal = '<spring:message code="click.total"/>';
		var txtEquipUnit = '<spring:message code="click.equip.units"/>';
		var txtPiece = '<spring:message code="click.pieces"/>';
		var txtEarth = '<spring:message code="click.retaining.earth.equipment.status"/>';
		var txtEvent = '<spring:message code="click.day.event"/>';
		
		var cctvUrl 	= "";
		var cctvPw 		= "";
		var cctvRtmp 	= "";
		var cctvBox 	= 1;
		var cctv_1_1_page = 0;
		var cctv_3_1_page = 0;
		var cctv_3_2_page = 0;
		var cctv_4_1_page = 0;
		var cctv_4_2_page = 0;
		var cctv_4_3_page = 0;
		var cctv_2_5_3_page = 0;
		function fn_cctvProcess(frameId,process_gubun,ctntsRefrash,ctntsCall,ctntsMenuId,menuId, ctntsRollingType , ctntsFixType1 , ctntsFixType2 , ctntsFixType3 , ctntsFixType4){
			if(fn_checkRefresh(ctntsRefrash,menuId,ctntsCall) == "1" ){
				var sUrl = "dashLocationProcess.json";
				var sFrameId = "";
				$('#process_gubun').val(process_gubun);
	
				// 1x1 CCTV 현황
				if( "14" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 3x1 CCTV 현황
				if( "23" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 3x2 CCTV 현황
				if( "30" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 4x1 CCTV 현황
				if( "36" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 4x2 CCTV 현황
				if( "42" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 4x3 CCTV 현황
				if( "48" == process_gubun ){
					sUrl = "dashLocationProcess.json";
					sFrameId = "frame_" + frameId;
				}
				
				// 2.5x3 CCTV 현황
				if( "56" == process_gubun ){
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
						// 1x1 CCTV 현황
						if( "14" == process_gubun ){
							if( result.cctvVO != null ){
								if ("1" == "${parameterVO.os_version}" ){
									if( result.cctvList != null ){
										// explorer
										$('#'+sFrameId).html($('#typeElement').find('.a-1-1-cctvState').clone(true).show());
										$('#'+sFrameId).find('.a-1-1-cctvState').find('OBJECT').attr('id','');
										$('#'+sFrameId).find('.a-1-1-cctvState').find('OBJECT').attr('id','WebMon1');
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-1-1-cctvState').ready(function(){
												$('#'+sFrameId).find('#WebMon1')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon1')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon1')[0].ScreenMode( parseInt(1), parseInt(ctntsFixType1)-1 );
											});
										}else{
											if( parseInt(result.cctvList[0].channel_cnt) > 1 ){
												cctv_1_1_page = 1;
												$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + (result.cctvList[0].channel_cnt)*2 + "</span>)" );	// paging 건수
												$('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealCurPage').val(1);
												$('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealLastPage').val(result.cctvList[0].channel_cnt);
											}
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-1-1-cctvState').ready(function(){
												$('#'+sFrameId).find('#WebMon1')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon1')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon1')[0].ScreenMode( parseInt(1), -1 );
											});
										}
									}
							    }else{
									if( result.cctvList != null ){
										cctv_1_1_page = 1;
										cctvPw = result.cctvList[0].loginEncode;
										cctvUrl = result.cctvList[0].cctv_url;
										cctvRtmp =  result.cctvList[0].rtmp_port;
										$('#'+sFrameId).html($('#typeElement').find('.a-1-1-cctvState').clone(true).show());
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											$('#'+sFrameId).find('.a-1-1-cctvState').find('param[name="flashvars"]').val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}else{
											if( parseInt(result.cctvList[0].channel_cnt) > 1 ){
												$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + parseInt(result.cctvList[0].channel_cnt)*2 + "</span>)" );	// paging 건수
												$('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealCurPage').val(1);
												$('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealLastPage').val(result.cctvList[0].channel_cnt);
											}
											$('#'+sFrameId).find('.a-1-1-cctvState').find('param[name="flashvars"]').val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}
										
									}
							    }
							}
						}
						
						// 3x1 CCTV 현황
						if( "23" == process_gubun ){
							
							if( result.cctvVO != null ){
								if ("1" == "${parameterVO.os_version}" ){
									if( result.cctvList != null ){
										// explorer
										$('#'+sFrameId).html($('#typeElement').find('.a-3-1-cctvState').clone(true).show());
										$('#'+sFrameId).find('.a-3-1-cctvState').find('OBJECT').attr('id','');
										$('#'+sFrameId).find('.a-3-1-cctvState').find('OBJECT').eq(0).attr('id','WebMon2');
										$('#'+sFrameId).find('.a-3-1-cctvState').find('OBJECT').eq(1).attr('id','WebMon3');
										$('#'+sFrameId).find('.a-3-1-cctvState').find('OBJECT').eq(2).attr('id','WebMon4');
										
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-3-1-cctvState').ready(function(){
												$('#'+sFrameId).find('#WebMon2')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon2')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon2')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType1) - 1 ) );
										   		
												$('#'+sFrameId).find('#WebMon3')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon3')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon3')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType2) - 1 ) );
										   		
												$('#'+sFrameId).find('#WebMon4')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon4')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon4')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType3) - 1 ) );
											});
											// CCTV 연결 ////////
										}else{
											// Paging
											var pageNum = Math.ceil( result.cctvList[0].channel_cnt / 3 );
											if(pageNum>1){
												$('#'+sFrameId).find('.a-3-1-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + pageNum + "</span>)" );	// paging 건수
											}
											
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-3-1-cctvState').ready(function(){
												$('#'+sFrameId).find('#WebMon2')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon2')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon2')[0].ScreenMode( parseInt(1), -1 );
										   		
												$('#'+sFrameId).find('#WebMon3')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon3')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon3')[0].ScreenMode( parseInt(1), 1 );
										   		
												$('#'+sFrameId).find('#WebMon4')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon4')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon4')[0].ScreenMode( parseInt(1), 2 );
											});
											// CCTV 연결 ////////
										}
										
										
									}
							    }else{
							    	if( result.cctvList != null ){
										cctv_3_1_page = 1;
										cctvPw = result.cctvList[0].loginEncode;
										cctvUrl = result.cctvList[0].cctv_url;
										cctvRtmp =  result.cctvList[0].rtmp_port;
										
								    	$('#'+sFrameId).html($('#typeElement').find('.a-3-1-cctvState').clone(true).show());
								    	
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											$('#'+sFrameId).find('.a-3-1-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-3-1-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType2+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType2+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-3-1-cctvState').find('param[name="flashvars"]').eq(2).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType3+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType3+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}else{
											// Paging
											var pageNum = Math.ceil( result.cctvList[0].channel_cnt / 3 );
											if(pageNum>1){
												$('#'+sFrameId).find('.a-3-1-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + pageNum + "</span>)" );	// paging 건수
											}
											$('#'+sFrameId).find('.a-3-1-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-3-1-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'2?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'2?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-3-1-cctvState').find('param[name="flashvars"]').eq(2).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'3?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'3?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}
										
									}
							    }
							}
							
						}
						
						// 3x2 CCTV 현황
						if( "30" == process_gubun ){
							
							if( result.cctvVO != null ){
								if ("1" == "${parameterVO.os_version}" ){
									if( result.cctvList != null ){
										// explorer
										$('#'+sFrameId).html($('#typeElement').find('.a-3-2-cctvState').clone(true).show());
										$('#'+sFrameId).find('.a-3-2-cctvState').find('OBJECT').attr('id','');
										$('#'+sFrameId).find('.a-3-2-cctvState').find('OBJECT').attr('id','WebMon5');
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-3-2-cctvState').ready(function(){
												$('#'+sFrameId).find('#WebMon5')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon5')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon5')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType1) - 1 ) );
											});
											// CCTV 연결 ////////
										}else{
											if( parseInt(result.cctvList[0].channel_cnt) > 1 ){
												$('#'+sFrameId).find('.a-3-2-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + result.cctvList[0].channel_cnt + "</span>)" );	// paging 건수
											}
											
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-3-2-cctvState').ready(function(){
												$('#'+sFrameId).find('#WebMon5')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon5')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon5')[0].ScreenMode( parseInt(1), -1 );
											});
											// CCTV 연결 ////////
										}
									}
							    }else{
									if( result.cctvList != null ){
										cctv_3_2_page = 1;
										cctvPw = result.cctvList[0].loginEncode;
										cctvUrl = result.cctvList[0].cctv_url;
										cctvRtmp =  result.cctvList[0].rtmp_port;
										
										$('#'+sFrameId).html($('#typeElement').find('.a-3-2-cctvState').clone(true).show());
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											$('#'+sFrameId).find('.a-3-2-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}else{
											if( parseInt(result.cctvList[0].channel_cnt) > 1 ){
												// $('#'+sFrameId).find('.a-3-2-cctvState').find('.cctv_paging').text(  "(1/" + result.cctvList[0].channel_cnt + ")" );	// paging 건수
												$('#'+sFrameId).find('.a-3-2-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + result.cctvList[0].channel_cnt + "</span>)" );	// paging 건수
											}
											$('#'+sFrameId).find('.a-3-2-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}
										
									}
							    }
							}
						}
						
						// 4x1 CCTV 현황
						if( "36" == process_gubun ){
							
							if( result.cctvVO != null ){
								if ("1" == "${parameterVO.os_version}" ){
									if( result.cctvList != null ){
										
										$('#'+sFrameId).html($('#typeElement').find('.a-4-1-cctvState').clone(true).show());
										$('#'+sFrameId).find('.a-4-1-cctvState').find('OBJECT').attr('id','');
										$('#'+sFrameId).find('.a-4-1-cctvState').find('OBJECT').eq(0).attr('id','WebMon13');
										$('#'+sFrameId).find('.a-4-1-cctvState').find('OBJECT').eq(1).attr('id','WebMon14');
										$('#'+sFrameId).find('.a-4-1-cctvState').find('OBJECT').eq(2).attr('id','WebMon15');
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-4-1-cctvState').ready(function(){
												$('#'+sFrameId).find('#WebMon13')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon13')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon13')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType1) - 1 ) );
										   		
												$('#'+sFrameId).find('#WebMon14')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon14')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon14')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType2) - 1 ) );
										   		
												$('#'+sFrameId).find('#WebMon15')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon15')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon15')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType3) - 1 ) );
											});
											// CCTV 연결 ////////
										}else{
											var pageNum = Math.ceil( result.cctvList[0].channel_cnt / 3 );
											if(pageNum>1){
												$('#'+sFrameId).find('.a-4-1-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + pageNum + "</span>)" );	// paging 건수
											}
											
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-4-1-cctvState').ready(function(){
												$('#'+sFrameId).find('#WebMon13')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon13')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon13')[0].ScreenMode( parseInt(1), -1 );
										   		
												$('#'+sFrameId).find('#WebMon14')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon14')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon14')[0].ScreenMode( parseInt(1), 1 );
										   		
												$('#'+sFrameId).find('#WebMon15')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon15')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon15')[0].ScreenMode( parseInt(1), 2 );
											});
											// CCTV 연결 ////////
										}
									}
							    }else{
							    	// chrome
									if( result.cctvList != null ){
										cctv_4_1_page = 1;
										cctvPw = result.cctvList[0].loginEncode;
										cctvUrl = result.cctvList[0].cctv_url;
										cctvRtmp =  result.cctvList[0].rtmp_port;
										
										$('#'+sFrameId).html($('#typeElement').find('.a-4-1-cctvState').clone(true).show());
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											$('#'+sFrameId).find('.a-4-1-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-1-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType2+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType2+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-1-cctvState').find('param[name="flashvars"]').eq(2).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType3+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType3+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}else{
											var pageNum = Math.ceil( result.cctvList[0].channel_cnt / 3 );
											if(pageNum>1){
												$('#'+sFrameId).find('.a-4-1-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + pageNum + "</span>)" );	// paging 건수
											}
											$('#'+sFrameId).find('.a-4-1-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-1-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'2?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'2?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-1-cctvState').find('param[name="flashvars"]').eq(2).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'3?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'3?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}
									}
							    }
							}
						}
						
						// 4x2 CCTV 현황
						if( "42" == process_gubun ){
							
							if( result.cctvVO != null ){
								if ("1" == "${parameterVO.os_version}" ){
									if( result.cctvList != null ){
										// explorer
										$('#'+sFrameId).html($('#typeElement').find('.a-4-2-cctvState').clone(true).show());
										$('#'+sFrameId).find('.a-4-2-cctvState').find('OBJECT').attr('id','');
										$('#'+sFrameId).find('.a-4-2-cctvState').find('OBJECT').eq(0).attr('id','WebMon6');
										$('#'+sFrameId).find('.a-4-2-cctvState').find('OBJECT').eq(1).attr('id','WebMon7');
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-4-2-cctvState').ready(function(){
												$('#'+sFrameId).find('#WebMon6')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon6')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon6')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType1) - 1 ) );
										   		
												$('#'+sFrameId).find('#WebMon7')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon7')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon7')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType2) - 1 ) );
											});
											// CCTV 연결 ////////
										}else{
											var pageNum = Math.ceil( result.cctvList[0].channel_cnt / 2 );
											if(pageNum>1){
												$('#'+sFrameId).find('.a-4-2-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + pageNum + "</span>)" );	// paging 건수
											}
											
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-4-2-cctvState').ready(function(){
												$('#'+sFrameId).find('#WebMon6')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon6')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon6')[0].ScreenMode( parseInt(1), -1 );
										   		
												$('#'+sFrameId).find('#WebMon7')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon7')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon7')[0].ScreenMode( parseInt(1), 1 );
											});
											// CCTV 연결 ////////
										}
										
									}
							    }else{
							    	// chrome
									if( result.cctvList != null ){
										cctv_4_2_page = 1;
										cctvPw = result.cctvList[0].loginEncode;
										cctvUrl = result.cctvList[0].cctv_url;
										cctvRtmp =  result.cctvList[0].rtmp_port;
										
										$('#'+sFrameId).html($('#typeElement').find('.a-4-2-cctvState').clone(true).show());
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											$('#'+sFrameId).find('.a-4-2-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'admin','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-2-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType2+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'admin','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType2+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}else{
											var pageNum = Math.ceil( result.cctvList[0].channel_cnt / 2 );
											if(pageNum>1){
												$('#'+sFrameId).find('.a-4-2-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + pageNum + "</span>)" );	// paging 건수
											}
											$('#'+sFrameId).find('.a-4-2-cctvState').find('.cctv_paging').text(  "(1/" + pageNum + ")" );	// paging 건수
											$('#'+sFrameId).find('.a-4-2-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'admin','playlist':[{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-2-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'2?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'admin','playlist':[{'provider':'rtmp','autoPlay':true,'url':'2?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}
										
									}
							    }
							}
						}
						
						// 4x3 CCTV 현황
						if( "48" == process_gubun ){
							
							if( result.cctvVO != null ){
								if ("1" == "${parameterVO.os_version}" ){
									if( result.cctvList != null ){
										// explorer
										$('#'+sFrameId).attr("class", $("#typeElement").find('.a-4-3-cctvState').attr("id"));
										$("#typeElement").find('.a-4-3-cctvState').attr("id",'');
										$('#'+sFrameId).html($('#typeElement').find('.a-4-3-cctvState').clone(true).show());
										// $('.a-4-3-cctvState').find('OBJECT').attr('id','');
										$('#typeElement').find('.a-4-3-cctvState').find('OBJECT').attr('id','');
										$('#typeElement').find('.a-4-3-cctvState').attr('id','');
										$('#'+sFrameId).find('.a-4-3-cctvState').find('OBJECT').eq(0).attr("id","WebMon8");
										$('#'+sFrameId).find('.a-4-3-cctvState').find('OBJECT').eq(1).attr('id','WebMon9');
										$('#'+sFrameId).find('.a-4-3-cctvState').find('OBJECT').eq(2).attr('id','WebMon10');
										$('#'+sFrameId).find('.a-4-3-cctvState').find('OBJECT').eq(3).attr('id','WebMon11');
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-4-3-cctvState').eq(0).ready(function(){
												$('#'+sFrameId).find('#WebMon8')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon8')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon8')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType1) - 1 ) );
												
												$('#'+sFrameId).find('#WebMon9')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon9')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon9')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType2) - 1 ) );
												
												$('#'+sFrameId).find('#WebMon10')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon10')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon10')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType3) - 1 ) );
												
												$('#'+sFrameId).find('#WebMon11')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon11')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon11')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType4) - 1 ) );
											});
											// CCTV 연결 ////////
										}else{
											var pageNum = Math.ceil( result.cctvList[0].channel_cnt / 4 );
											if(pageNum>1){
												$('#'+sFrameId).find('.a-4-3-cctvState').find('.cctv_paging').html(  "(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + pageNum + "</span>)" );	// paging 건수
											}
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.a-4-3-cctvState').eq(0).ready(function(){
												$('#'+sFrameId).find('#WebMon8')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon8')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon8')[0].ScreenMode( parseInt(1), -1 );
												
												$('#'+sFrameId).find('#WebMon9')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon9')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon9')[0].ScreenMode( parseInt(1), 1 );
												
												$('#'+sFrameId).find('#WebMon10')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon10')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon10')[0].ScreenMode( parseInt(1), 2 );
												
												$('#'+sFrameId).find('#WebMon11')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('#WebMon11')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('#WebMon11')[0].ScreenMode( parseInt(1), 3 );
											});
											// CCTV 연결 ////////
										}
									}
								}else{
									if( result.cctvList != null ){
										cctv_4_3_page = 1;
										cctvPw = result.cctvList[0].loginEncode;
										cctvUrl = result.cctvList[0].cctv_url;
										cctvRtmp =  result.cctvList[0].rtmp_port;
										
										$('#'+sFrameId).html($('#typeElement').find('.a-4-3-cctvState').clone(true).show());
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType2+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType2+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(2).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType3+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType3+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(3).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType4+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType4+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}else{
											var pageNum = Math.ceil( result.cctvList[0].channel_cnt / 4 );
											if(pageNum>1){
												$('#'+sFrameId).find('.a-4-3-cctvState').find('.cctv_paging').html("(<span class='cctvPageNum'>1</span>/<span class='cctvLastPageNum'>" + pageNum + "</span>)");	// paging 건수
											}
											$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'2?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'2?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(2).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'3?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'3?auth_64="+result.cctvList[0].loginEncode+"'}]}");
											$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(3).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'4?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'4?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}
										
									}
								}
							}
						}
						
						// 2.5x3 CCTV 현황
						if( "56" == process_gubun ){
							
							if( result.cctvVO != null ){
								
								if ("1" == "${parameterVO.os_version}" ){
									if( result.cctvList != null ){
										// explorer
										$('#'+sFrameId).removeClass('atype-1-1-01');
										$('#'+sFrameId).html($('#typeElement').find('.d-2-3-cctvState').clone(true).show());
										$('#'+sFrameId).find('.d-2-3-cctvState').find('OBJECT').attr('id','');
										$('#'+sFrameId).find('.d-2-3-cctvState').find('OBJECT').eq(0).attr('name','WebMon12');
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											// CCTV 순번
											var sHtml = "";
											sHtml += '<li class="greenBg"><span class="greenBg"><spring:message code="click.no" arguments="' + (ctntsFixType1) + '"/></span></li>';
											$('#'+sFrameId).find('.cctbBoxList').html(sHtml);
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.d-2-3-cctvState').ready(function(){
												$('#'+sFrameId).find('OBJECT[name="WebMon12"]')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('OBJECT[name="WebMon12"]')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('OBJECT[name="WebMon12"]')[0].ScreenMode( parseInt(1), (parseInt(ctntsFixType1) - 1 ) );
											});
											// CCTV 연결 ////////
										}else{
											// CCTV 순번
											var sHtml = "";
											for(var tmpCount=0;tmpCount<parseInt(result.cctvVO.channel_cnt);tmpCount++){
												// cctbBoxList
												if(tmpCount==0){
													sHtml += '<li class="greenBg"><span class="greenBg"><spring:message code="click.no" arguments="' + (tmpCount+1) + '"/></span></li>';
												}else{
													sHtml += '<li><span><spring:message code="click.no" arguments="' + (tmpCount+1) + '"/></span></li>';
												}
											}
											$('#'+sFrameId).find('.cctbBoxList').html(sHtml);
											// CCTV 연결 ////////
											$('#'+sFrameId).find('.d-2-3-cctvState').ready(function(){
												$('#'+sFrameId).find('OBJECT[name="WebMon12"]')[0].LiveConnect("localhost", result.cctvList[0].cctv_url, result.cctvList[0].cctv_id, result.cctvList[0].cctv_pwd , parseInt(result.cctvList[0].rtsp_port) );
												$('#'+sFrameId).find('OBJECT[name="WebMon12"]')[0].CreateSiteWnd( parseInt(result.cctvList[0].channel_cnt), parseInt(16) );
												$('#'+sFrameId).find('OBJECT[name="WebMon12"]')[0].ScreenMode( parseInt(1), -1 );
											});
											// CCTV 연결 ////////
										}
									}
								}else{
									if( result.cctvList != null ){
										cctv_2_5_3_page = 1;
										cctvPw = result.cctvList[0].loginEncode;
										cctvUrl = result.cctvList[0].cctv_url;
										cctvRtmp =  result.cctvList[0].rtmp_port;
										
										$('#'+sFrameId).removeClass('atype-1-1-01');
										$('#'+sFrameId).html($('#typeElement').find('.d-2-3-cctvState').clone(true).show());
										
										if( ctntsFixType1 != null && ctntsFixType1 != "" ){
											// CCTV 순번
											var sHtml = "";
											sHtml += '<li class="greenBg"><span class="greenBg"><spring:message code="click.no" arguments="' + (ctntsFixType1) + '"/></span></li>';
											$('#'+sFrameId).find('.cctbBoxList').html(sHtml);
											$('#'+sFrameId).find('.d-2-3-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+ctntsFixType1+"?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}else{
											// CCTV 순번
											var sHtml = "";
											for(var tmpCount=0;tmpCount<parseInt(result.cctvVO.channel_cnt);tmpCount++){
												// cctbBoxList
												if(tmpCount==0){
													sHtml += '<li class="greenBg"><span class="greenBg"><spring:message code="click.no" arguments="' + (tmpCount+1) + '"/></span></li>';
												}else{
													sHtml += '<li><span><spring:message code="click.no" arguments="' + (tmpCount+1) + '"/></span></li>';
												}
											}
											$('#'+sFrameId).find('.cctbBoxList').html(sHtml);
											
											var pageNum = parseInt( result.cctvList[0].channel_cnt / 4 );
											if( pageNum > 1 ){
												$('#'+sFrameId).find('.d-2-3-cctvState').find('.cctv_paging').text(  "(1/" + pageNum + ")" );	// paging 건수
											}
											$('#'+sFrameId).find('.d-2-3-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+result.cctvList[0].cctv_url+":"+result.cctvList[0].rtmp_port+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'1?auth_64="+result.cctvList[0].loginEncode+"'}]}");
										}
									}
								}
								
							}
							
							// 당일 CCTV 이벤트 현황
							if( result.evnetList != null ){
								if(result.evnetList.length > 0){
									for(var i=0;i<result.evnetList.length;i++){
										// 안전모 미착용 감지
										if( result.evnetList[i].event_type == "EVT000019" ){
											$('#'+sFrameId).find('#EVT000019').text(result.evnetList[i].event_count);
										}
										// 안전조끼 미착용 감지
										if( result.evnetList[i].event_type == "EVT000020" ){
											$('#'+sFrameId).find('#EVT000020').text(result.evnetList[i].event_count);
										}
									}
								}
							}
						}
						fn_goMenu(sFrameId, ctntsMenuId);
					}
				});
			}else if(fn_checkRefresh(ctntsRefrash,menuId,ctntsCall) == "2" ){
				// cctv rolling
				// cctv 고정 시 제외
				if( ctntsRollingType == "R" ){
					var sFrameId = "frame_" + frameId;
					// 1x1 CCTV 현황 Rolling
					if( "14" == process_gubun ){
						if ("1" == "${parameterVO.os_version}" ){
							var curPageNum = $('#'+sFrameId).find('.a-1-1-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-1-1-cctvState').find('.cctvLastPageNum').text();
							var curRealCctvCurNum = parseInt($('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealCurPage').val());
							var curRealCctvLasNum = $('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealLastPage').val();
							
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctvPageNum').html('1');
									cctv_1_1_page = 1;
									curRealCctvCurNum = 0;
									$('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealCurPage').val(curRealCctvCurNum);
								}else{
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_1_1_page = cctv_1_1_page + 1;
								}
								
								
								if( parseInt( cctv_1_1_page%2 ) == 1 ){
									// explorer
									curRealCctvCurNum = curRealCctvCurNum + 1;
									$('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealCurPage').val(curRealCctvCurNum);
									
									// CCTV 정보 숨기기
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.a-1-1-cctvInfo').hide();
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.a-1-1-cctv').show();
									
									// CCTV
									$('#'+sFrameId).find('#WebMon1')[0].ScreenMode( parseInt(1), (curRealCctvCurNum-1) );
									
								}else{
									
									// ajax 호출
									$('#cctv_channel_no').val( curRealCctvCurNum );
									$('#process_gubun').val(process_gubun);
									var params2 = $("form[name=dashParameterVO]").serialize();
									$.ajax({
										url : "/click/dashLocationProcess.json" ,
										type : "POST",
										data: params2,
										success : function(result) {
											// CH 이름
											if( result.cctvInfo != null ){
												// CCTV 번호
												$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-chNum').text(curRealCctvCurNum);
												// CCTV 이름
												$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-chName').text(result.cctvInfo.cctv_area);
											}
											
											// 당일 CCTV 이벤트 현황
											if( result.evnetList != null ){
												if(result.evnetList.length > 0){
													for(var i=0;i<result.evnetList.length;i++){
														// 안전모 미착용 감지
														if( result.evnetList[i].event_type == "EVT000019" ){
															$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-capEvent').text(txtError).removeClass('greenBg').addClass('danger');
														}
														// 안전조끼 미착용 감지
														if( result.evnetList[i].event_type == "EVT000020" ){
															$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-safevestEvent').text(txtError).removeClass('greenBg').addClass('danger');
														}
													}
												}else{
													// 안전모 미착용 감지
													$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-capEvent').text(txtSafe).removeClass('danger').addClass('greenBg');
													// 안전조끼 미착용 감지
													$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-safevestEvent').text(txtSafe).removeClass('danger').addClass('greenBg');
												}
											}else{
												// 안전모 미착용 감지
												$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-capEvent').text(txtSafe).removeClass('danger').addClass('greenBg');
												// 안전조끼 미착용 감지
												$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-safevestEvent').text(txtSafe).removeClass('danger').addClass('greenBg');
											}
											
											$('#'+sFrameId).find('.a-1-1-cctvState').find('.a-1-1-cctv').hide();
											$('#'+sFrameId).find('.a-1-1-cctvState').find('.a-1-1-cctvInfo').show();
											
										}
									});
									
									
								}
								
							}
							
						}else{
							var curPageNum = $('#'+sFrameId).find('.a-1-1-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-1-1-cctvState').find('.cctvLastPageNum').text();
							var curRealCctvCurNum = parseInt($('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealCurPage').val());
							var curRealCctvLasNum = $('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealLastPage').val();
							
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctvPageNum').html('1');
									cctv_1_1_page = 1;
									curRealCctvCurNum = 0;
									$('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealCurPage').val(curRealCctvCurNum);
								}else{
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_1_1_page = cctv_1_1_page + 1;
								}
								
								
								if( parseInt( cctv_1_1_page%2 ) == 1 ){
									// chrome
									curRealCctvCurNum = curRealCctvCurNum + 1;
									$('#'+sFrameId).find('.a-1-1-cctvState').find('#cctvRealCurPage').val(curRealCctvCurNum);
									
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.a-1-1-cctvInfo').hide();
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.a-1-1-cctv').show();
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.live_img').hide();
									$('#'+sFrameId).find('.a-1-1-cctvState').find('param[name="flashvars"]').val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+curRealCctvCurNum+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+curRealCctvCurNum+"?auth_64="+cctvPw+"'}]}");
									
									$('#'+sFrameId).find('.a-1-1-cctvState').find('param[name="flashvars"]').ready(function(){
										$('#'+sFrameId).find('.a-1-1-cctvState').find('.live_img').show();
									});
								}else{
									// ajax 호출
									$('#cctv_channel_no').val( curRealCctvCurNum );
									$('#process_gubun').val(process_gubun);
									var params2 = $("form[name=dashParameterVO]").serialize();
									$.ajax({
										url : "/click/dashLocationProcess.json" ,
										type : "POST",
										data: params2,
										success : function(result) {
											// CH 이름
											if( result.cctvInfo != null ){
												// CCTV 번호
												$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-chNum').text(curRealCctvCurNum);
												console.log( " cctv_area : " + result.cctvInfo.cctv_area );
												// CCTV 이름
												$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-chName').text(result.cctvInfo.cctv_area);
											}
											
											// 당일 CCTV 이벤트 현황
											if( result.evnetList != null ){
												if(result.evnetList.length > 0){
													for(var i=0;i<result.evnetList.length;i++){
														// 안전모 미착용 감지
														if( result.evnetList[i].event_type == "EVT000019" ){
															$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-capEvent').text(txtError).removeClass('greenBg').addClass('danger');
														}
														// 안전조끼 미착용 감지
														if( result.evnetList[i].event_type == "EVT000020" ){
															$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-safevestEvent').text(txtError).removeClass('greenBg').addClass('danger');
														}
													}
												}else{
													// 안전모 미착용 감지
													$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-capEvent').text(txtSafe).removeClass('danger').addClass('greenBg');
													// 안전조끼 미착용 감지
													$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-safevestEvent').text(txtSafe).removeClass('danger').addClass('greenBg');
												}
											}else{
												// 안전모 미착용 감지
												$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-capEvent').text(txtSafe).removeClass('danger').addClass('greenBg');
												// 안전조끼 미착용 감지
												$('#'+sFrameId).find('.a-1-1-cctvState').find('.cctv-safevestEvent').text(txtSafe).removeClass('danger').addClass('greenBg');
											}
											
										}
									});
									
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.a-1-1-cctv').hide();
									$('#'+sFrameId).find('.a-1-1-cctvState').find('.a-1-1-cctvInfo').show();
								}
								
							}
						}
					}
					// 1x1 CCTV 현황 Rolling
					
					// 3x1 CCTV 현황 Rolling
					if( "23" == process_gubun ){
						if ("1" == "${parameterVO.os_version}" ){
							
							var curPageNum = $('#'+sFrameId).find('.a-3-1-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-3-1-cctvState').find('.cctvLastPageNum').text();
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-3-1-cctvState').find('.cctvPageNum').html('1');
									cctv_3_1_page = 0;
								}else{
									$('#'+sFrameId).find('.a-3-1-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_3_1_page = cctv_3_1_page + 3;
								}
								
								// explorer
								$('#'+sFrameId).find('#WebMon2')[0].ScreenMode( parseInt(1), cctv_3_1_page );
								$('#'+sFrameId).find('#WebMon3')[0].ScreenMode( parseInt(1), (cctv_3_1_page+1) );
								$('#'+sFrameId).find('#WebMon4')[0].ScreenMode( parseInt(1), (cctv_3_1_page+2) );
							}
							
						}else{
							var curPageNum = $('#'+sFrameId).find('.a-3-1-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-3-1-cctvState').find('.cctvLastPageNum').text();
							
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-3-1-cctvState').find('.cctvPageNum').html('1');
									cctv_3_1_page = 1;
								}else{
									$('#'+sFrameId).find('.a-3-1-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_3_1_page = cctv_3_1_page + 3;
								}
								
								// chrome
								$('#'+sFrameId).find('.a-3-1-cctvState').eq(0).find('.live_img').hide();
								$('#'+sFrameId).find('.a-3-1-cctvState').eq(1).find('.live_img').hide();
								$('#'+sFrameId).find('.a-3-1-cctvState').eq(2).find('.live_img').hide();
								
								$('#'+sFrameId).find('.a-3-1-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+cctv_3_1_page+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+cctv_3_1_page+"?auth_64="+cctvPw+"'}]}");
								$('#'+sFrameId).find('.a-3-1-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_3_1_page+1)+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_3_1_page+1)+"?auth_64="+cctvPw+"'}]}");
								$('#'+sFrameId).find('.a-3-1-cctvState').find('param[name="flashvars"]').eq(2).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_3_1_page+2)+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_3_1_page+2)+"?auth_64="+cctvPw+"'}]}");
								
								$('#'+sFrameId).find('.a-3-1-cctvState').eq(0).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-3-1-cctvState').eq(0).find('.live_img').show();
								});
								$('#'+sFrameId).find('.a-3-1-cctvState').eq(1).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-3-1-cctvState').eq(1).find('.live_img').show();
								});
								$('#'+sFrameId).find('.a-3-1-cctvState').eq(2).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-3-1-cctvState').eq(2).find('.live_img').show();
								});
							}
							
						}
					}
					// 3x1 CCTV 현황 Rolling
					
					// 3x2 CCTV 현황 Rolling
					if( "30" == process_gubun ){
						if ("1" == "${parameterVO.os_version}" ){
							
							var curPageNum = $('#'+sFrameId).find('.a-3-2-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-3-2-cctvState').find('.cctvLastPageNum').text();
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-3-2-cctvState').find('.cctvPageNum').html('1');
									cctv_3_2_page = 0;
								}else{
									$('#'+sFrameId).find('.a-3-2-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_3_2_page = cctv_3_2_page + 1;
								}
								
								// explorer
								$('#'+sFrameId).find('#WebMon5')[0].ScreenMode( parseInt(1), cctv_3_2_page );
							}
						}else{
							var curPageNum = $('#'+sFrameId).find('.a-3-2-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-3-2-cctvState').find('.cctvLastPageNum').text();
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-3-2-cctvState').find('.cctvPageNum').html('1');
									cctv_3_2_page = 1;
								}else{
									$('#'+sFrameId).find('.a-3-2-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_3_2_page = cctv_3_2_page + 1;
								}
								
								// chrome
								$('#'+sFrameId).find('.a-3-2-cctvState').find('.live_img').hide();
								
								$('#'+sFrameId).find('.a-3-2-cctvState').find('param[name="flashvars"]').val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+cctv_3_2_page+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+cctv_3_2_page+"?auth_64="+cctvPw+"'}]}");
								
								$('#'+sFrameId).find('.a-3-2-cctvState').find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-3-2-cctvState').find('.live_img').show();
								});
							}
						}
					} 
					// 3x2 CCTV 현황 Rolling
					
					// 4x1 CCTV 현황 Rolling
					if( "36" == process_gubun ){
						if ("1" == "${parameterVO.os_version}" ){
							
							var curPageNum = $('#'+sFrameId).find('.a-4-1-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-4-1-cctvState').find('.cctvLastPageNum').text();
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-4-1-cctvState').find('.cctvPageNum').html('1');
									cctv_4_1_page = 0;
								}else{
									$('#'+sFrameId).find('.a-4-1-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_4_1_page = cctv_4_1_page + 3;
								}
								
								// explorer
								$('#'+sFrameId).find('#WebMon13')[0].ScreenMode( parseInt(1), cctv_4_1_page );
								$('#'+sFrameId).find('#WebMon14')[0].ScreenMode( parseInt(1), (cctv_4_1_page+1) );
								$('#'+sFrameId).find('#WebMon15')[0].ScreenMode( parseInt(1), (cctv_4_1_page+2) );
							}
						}else{
							var curPageNum = $('#'+sFrameId).find('.a-4-1-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-4-1-cctvState').find('.cctvLastPageNum').text();
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-4-1-cctvState').find('.cctvPageNum').html('1');
									cctv_4_1_page = 1;
								}else{
									$('#'+sFrameId).find('.a-4-1-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_4_1_page = cctv_4_1_page + 3;
								}
								
								// chrome
								$('#'+sFrameId).find('.a-4-1-cctvState').eq(0).find('.live_img').hide();
								$('#'+sFrameId).find('.a-4-1-cctvState').eq(1).find('.live_img').hide();
								$('#'+sFrameId).find('.a-4-1-cctvState').eq(2).find('.live_img').hide();
								
								$('#'+sFrameId).find('.a-4-1-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+cctv_4_1_page+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+cctv_4_1_page+"?auth_64="+cctvPw+"'}]}");
								$('#'+sFrameId).find('.a-4-1-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_1_page+1)+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_1_page+1)+"?auth_64="+cctvPw+"'}]}");
								$('#'+sFrameId).find('.a-4-1-cctvState').find('param[name="flashvars"]').eq(2).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_1_page+2)+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_1_page+2)+"?auth_64="+cctvPw+"'}]}");
								
								$('#'+sFrameId).find('.a-4-1-cctvState').eq(0).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-4-1-cctvState').eq(0).find('.live_img').show();
								});
								$('#'+sFrameId).find('.a-4-1-cctvState').eq(1).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-4-1-cctvState').eq(1).find('.live_img').show();
								});
								$('#'+sFrameId).find('.a-4-1-cctvState').eq(2).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-4-1-cctvState').eq(2).find('.live_img').show();
								});
							}
						}
					}
					// 4x1 CCTV 현황 Rolling
					
					// 4x2 CCTV 현황 Rolling
					if( "42" == process_gubun ){
						if ("1" == "${parameterVO.os_version}" ){
							
							var curPageNum = $('#'+sFrameId).find('.a-4-2-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-4-2-cctvState').find('.cctvLastPageNum').text();
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-4-2-cctvState').find('.cctvPageNum').html('1');
									cctv_4_2_page = 0;
								}else{
									$('#'+sFrameId).find('.a-4-2-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_4_2_page = cctv_4_2_page + 2;
								}
								
								// explorer
								$('#'+sFrameId).find('#WebMon6')[0].ScreenMode( parseInt(1), cctv_4_2_page );
								$('#'+sFrameId).find('#WebMon7')[0].ScreenMode( parseInt(1), (cctv_4_2_page+1) );
							}
						}else{
							var curPageNum = $('#'+sFrameId).find('.a-4-2-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-4-2-cctvState').find('.cctvLastPageNum').text();
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-4-2-cctvState').find('.cctvPageNum').html('1');
									cctv_4_2_page = 1;
								}else{
									$('#'+sFrameId).find('.a-4-2-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_4_2_page = cctv_4_2_page + 2;
								}
								
								// chrome
								$('#'+sFrameId).find('.a-4-2-cctvState').eq(0).find('.live_img').hide();
								$('#'+sFrameId).find('.a-4-2-cctvState').eq(1).find('.live_img').hide();
								
								$('#'+sFrameId).find('.a-4-2-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+cctv_4_2_page+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+cctv_4_2_page+"?auth_64="+cctvPw+"'}]}");
								$('#'+sFrameId).find('.a-4-2-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_2_page+1)+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_2_page+1)+"?auth_64="+cctvPw+"'}]}");
								
								$('#'+sFrameId).find('.a-4-2-cctvState').eq(0).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-4-2-cctvState').eq(0).find('.live_img').show();
								});
								$('#'+sFrameId).find('.a-4-2-cctvState').eq(1).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-4-2-cctvState').eq(1).find('.live_img').show();
								});
							}
						}
					}
					// 4x2 CCTV 현황 Rolling
					
					// 4x3 CCTV 현황 Rolling
					if( "48" == process_gubun ){
						if ("1" == "${parameterVO.os_version}" ){
							
							var curPageNum = $('#'+sFrameId).find('.a-4-3-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-4-3-cctvState').find('.cctvLastPageNum').text();
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-4-3-cctvState').find('.cctvPageNum').html('1');
									cctv_4_3_page = 0;
								}else{
									$('#'+sFrameId).find('.a-4-3-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_4_3_page = cctv_4_3_page + 4;
								}
								
								// explorer
								$('#'+sFrameId).find('#WebMon8')[0].ScreenMode( parseInt(1), cctv_4_3_page );
								$('#'+sFrameId).find('#WebMon9')[0].ScreenMode( parseInt(1), (cctv_4_3_page+1) );
								$('#'+sFrameId).find('#WebMon10')[0].ScreenMode( parseInt(1), (cctv_4_3_page+2) );
								$('#'+sFrameId).find('#WebMon11')[0].ScreenMode( parseInt(1), (cctv_4_3_page+3) );
							}
						}else{
							var curPageNum = $('#'+sFrameId).find('.a-4-3-cctvState').find('.cctvPageNum').text();
							var lastPageNum =  $('#'+sFrameId).find('.a-4-3-cctvState').find('.cctvLastPageNum').text();
							if( (curPageNum != null && curPageNum != "") && (lastPageNum != null && lastPageNum != "") ){
								if( curPageNum == lastPageNum ){
									$('#'+sFrameId).find('.a-4-3-cctvState').find('.cctvPageNum').html('1');
									cctv_4_3_page = 1;
								}else{
									$('#'+sFrameId).find('.a-4-3-cctvState').find('.cctvPageNum').html( parseInt(curPageNum)+1 );
									cctv_4_3_page = cctv_4_3_page + 4;
								}
								
								// chrome
								$('#'+sFrameId).find('.a-4-3-cctvState').eq(0).find('.live_img').hide();
								$('#'+sFrameId).find('.a-4-3-cctvState').eq(1).find('.live_img').hide();
								$('#'+sFrameId).find('.a-4-3-cctvState').eq(2).find('.live_img').hide();
								$('#'+sFrameId).find('.a-4-3-cctvState').eq(3).find('.live_img').hide();
								
								$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(0).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+cctv_4_3_page+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+cctv_4_3_page+"?auth_64="+cctvPw+"'}]}");
								$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(1).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_3_page+1)+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_3_page+1)+"?auth_64="+cctvPw+"'}]}");
								$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(2).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_3_page+2)+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_3_page+2)+"?auth_64="+cctvPw+"'}]}");
								$('#'+sFrameId).find('.a-4-3-cctvState').find('param[name="flashvars"]').eq(3).val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_3_page+3)+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+(cctv_4_3_page+3)+"?auth_64="+cctvPw+"'}]}");
								
								$('#'+sFrameId).find('.a-4-3-cctvState').eq(0).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-4-3-cctvState').eq(0).find('.live_img').show();
								});
								$('#'+sFrameId).find('.a-4-3-cctvState').eq(1).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-4-3-cctvState').eq(1).find('.live_img').show();
								});
								$('#'+sFrameId).find('.a-4-3-cctvState').eq(2).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-4-3-cctvState').eq(2).find('.live_img').show();
								});
								$('#'+sFrameId).find('.a-4-3-cctvState').eq(3).find('param[name="flashvars"]').ready(function(){
									$('#'+sFrameId).find('.a-4-3-cctvState').eq(3).find('.live_img').show();
								});
							}
						}
					}
					// 4x3 CCTV 현황 Rolling
					
					// 2.5x3 CCTV 현황 Rolling
					if( "56" == process_gubun ){
						
						// ajax 호출
						$('#process_gubun').val(process_gubun);
						var params2 = $("form[name=dashParameterVO]").serialize();
						$.ajax({
							url : "/click/dashLocationProcess.json" ,
							type : "POST",
							data: params2,
							success : function(result) {
								// 당일 CCTV 이벤트 현황
								if( result.evnetList != null ){
									if(result.evnetList.length > 0){
										for(var i=0;i<result.evnetList.length;i++){
											// 안전모 미착용 감지
											if( result.evnetList[i].event_type == "EVT000019" ){
												$('#'+sFrameId).find('#EVT000019').text(result.evnetList[i].event_count);
											}
											// 안전조끼 미착용 감지
											if( result.evnetList[i].event_type == "EVT000020" ){
												$('#'+sFrameId).find('#EVT000020').text(result.evnetList[i].event_count);
											}
										}
									}
								}
							}
						});
						
						
						if ("1" == "${parameterVO.os_version}" ){
							
							// explorer
							$('#'+sFrameId).find('OBJECT[name="WebMon12"]')[0].ScreenMode( parseInt(1), -1 );
							var lastPageNum = $('#'+sFrameId).find('.cctbBoxList').find('li').length;
							
							if( cctvBox == lastPageNum ){
								cctvBox = 1;
							}else{
								cctvBox = cctvBox + 1;
							}
							
							// CCTV 번호
							$('#'+sFrameId).find('.cctbBoxList').find('.greenBg').removeClass('greenBg');
							$('#'+sFrameId).find('.cctbBoxList').find('li').eq((cctvBox-1)).addClass('greenBg');
							
						}else{
							
							var curPageNum = curPageNum;
							var lastPageNum = $('#'+sFrameId).find('.cctbBoxList').find('li').length;
							
							if( cctv_2_5_3_page == lastPageNum ){
								cctv_2_5_3_page = 1;
							}else{
								cctv_2_5_3_page = cctv_2_5_3_page + 1;
							}
							
							$('#'+"frame_" + frameId).find('.cctbBoxList').find('.greenBg').removeClass('greenBg');
							$('#'+"frame_" + frameId).find('.cctbBoxList').find('li').eq((cctv_2_5_3_page-1)).addClass('greenBg');
							
							// chrome
							$('#'+"frame_" + frameId).find('.d-2-3-cctvState').find('.live_img').hide();
							
							$('#'+"frame_" + frameId).find('.d-2-3-cctvState').find('param[name="flashvars"]').val("config={'clip':{'provider':'rtmp','autoPlay':true,'url':'"+cctv_2_5_3_page+"?auth_64="+cctvPw+"'},'canvas':{'background':'#000000','backgroundGradient':'none'},'plugins':{'controls':{'url':'/click/resources/swf/flowplayer.controls-3.2.16.swf','all':false,'play':true,'time':true,'mute':true,'volume':true,'fullscreen':true,'tooltips':{'buttons':true,'fullscreen':'Enter fullscreen mode'}},'rtmp':{'url':'/click/resources/swf/flowplayer.rtmp-3.2.13.swf','netConnectionUrl':'rtmp://"+cctvUrl+":"+cctvRtmp+"/flvplayer'}},'playerId':'fp_1','playlist':[{'provider':'rtmp','autoPlay':true,'url':'"+cctv_2_5_3_page+"?auth_64="+cctvPw+"'}]}");
							
							$('#'+"frame_" + frameId).find('.d-2-3-cctvState').find('param[name="flashvars"]').ready(function(){
								$('#'+sFrameId).find('.d-2-3-cctvState').eq(0).find('.live_img').show();
							});
						}
					}
					// 2.5x3 CCTV 현황 Rolling
			}else{
				var sFrameId = "frame_" + frameId;
				// 2.5x3 CCTV 현황 Rolling
				if( "56" == process_gubun ){
					// ajax 호출
					$('#process_gubun').val(process_gubun);
					var params2 = $("form[name=dashParameterVO]").serialize();
					$.ajax({
						url : "/click/dashLocationProcess.json" ,
						type : "POST",
						data: params2,
						success : function(result) {
							// 당일 CCTV 이벤트 현황
							console.log(  " ajax 호출 !! ");
							if( result.evnetList != null ){
								if(result.evnetList.length > 0){
									for(var i=0;i<result.evnetList.length;i++){
										// 안전모 미착용 감지
										if( result.evnetList[i].event_type == "EVT000019" ){
											$('#'+sFrameId).find('#EVT000019').text(result.evnetList[i].event_count);
										}
										// 안전조끼 미착용 감지
										if( result.evnetList[i].event_type == "EVT000020" ){
											$('#'+sFrameId).find('#EVT000020').text(result.evnetList[i].event_count);
										}
									}
								}
							}
						}
					});
				}
				// 2.5x3 CCTV 현황 Rolling
			} 
			// Rolling
			
			}
		} // if
		
		function fn_goMenu(frameId, menuId){
			$("#"+frameId).find(".clickTitle").on("click", function(){
				if("Y" != $("#fullSceenMode").val()){
					if('999' == menuId){
						fn_alarmPopup();
					}else{
						fn_changePage(menuId);
					}
				}
			})
		}
	</script>
	<!-- 네비게이션 -->
	<div class="page-navigation">
		<ul>
			<li><a href="#">Home</a></li>
			<li class="gray">></li>
			<li><a href="#"><spring:message code="click.dashboard"/></a></li>
		</ul>
	</div>
	<div class="page-info-wrap mr20">
		<c:if test="${ sessionVO.grade_id eq '2' || sessionVO.grade_id eq '3' }">
		<button type="button" class="dashboardSetup-btn"><spring:message code="click.dashboard.setup"/>  ></button>
		<button type="button" class="noticeSetup-btn"><spring:message code="click.notice.settings"/> ></button>
		</c:if>
		<button type="button" class="dashboardMode-btn"><spring:message code="click.status.board.mode"/> ></button>
	</div>
	<!-- 네비게이션 -->
			<!--본문 영역 시작-->
			<form:form id="mapParameterVO" commandName="mapParameterVO" name="mapParameterVO" action="" method="post">
				<input type="hidden" id="building_id" name="building_id" value=""/>
				<input type="hidden" id="zone_id" name="zone_id" value=""/>
				<input type="hidden" id="scene_id" name="scene_id" value=""/>
				<input type="hidden" id="cell_id" name="cell_id" value=""/>
				<input type="hidden" id="poi_id" name="poi_id" value=""/>
				<input type="hidden" id="os_version" name="os_version" value="${parameterVO.os_version}" />
			</form:form>
			<form:form id="tunnelParameterVO" commandName="tunnelParameterVO" name="tunnelParameterVO" action="" method="post">
				<input type="hidden" class="pageIndex" name="pageIndex" value="1"/>
				<input type="hidden" class="process_gubun" name="process_gubun" value="">
			</form:form>
			<form:form id="tunnelElevationParameterVO" commandName="tunnelElevationParameterVO" name="tunnelElevationParameterVO" action="" method="post">
				<input type="hidden" class="pageIndex" name="pageIndex" value="1"/>
				<input type="hidden" class="process_gubun" name="process_gubun" value="">
			</form:form>
			<form:form id="dashParameterVO" commandName="dashParameterVO" name="dashParameterVO" action="" method="post">
			<input type="hidden" id="type_id" name="type_id" value="${dashList.type_id}">
			<input type="hidden" id="dash_id" name="dash_id" value="${dashList.dash_id}">
			<input type="hidden" id="sel_frame_id" name="sel_frame_id" value="">
			<input type="hidden" id="dash_yn" name="dash_yn" value="Y">
			<input type="hidden" id="process_gubun" name="process_gubun" value="">
			<input type="hidden" id="fullSceenMode" name="fullSceenMode" value="${parameterVO.fullSceenMode}">
			<input type="hidden" id="cctv_channel_no" name="cctv_channel_no" value="">
			</form:form>
			<div class="con-area" style="border: 0; background-color: #f6f6f6;">
				<c:if test="${dashList.type_id eq '1'}">
				<ul class="dash-Atype-layout">
					<li>
						<div>
							<!-- A Type Frame 1번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01 atype-1-1-01" id="frame_1">
							</div>
							<!-- A Type Frame 1번 영역 끝 ( 1x1 ) -->

							<!-- A Type Frame 2번 영역 시작 ( 3x1 ) -->
							<div class="atype-section02 atype-3-1-01" id="frame_2">
							</div>
							<!-- A Type Frame 2번 영역 끝 ( 3x1 ) -->
							
							<!-- A Type Frame 3번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01 atype-1-1-01" id="frame_3">
							</div>
							<!-- A Type Frame 3번 영역 끝 ( 1x1 ) -->
							
							<!-- A Type Frame 4번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01_1 atype-1-1-01" id="frame_4">
							</div>
							<!-- A Type Frame 4번 영역 끝 ( 1x1 ) -->
							
							<!-- A Type Frame 5번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01_1 cb atype-1-1-01" id="frame_5">
							</div>
							<!-- A Type Frame 5번 영역 끝 ( 1x1 ) -->
							
							<!-- A Type Frame 6번 영역 시작 ( 3x2 ) -->
							<div class="atype-section03 atype-3-2-01" id="frame_6">
							</div>
							<!-- A Type Frame 6번 영역 끝 ( 3x2 ) -->
							
							<!-- A Type Frame 7번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01_2 atype-1-1-01" id="frame_7">
							</div>
							<!-- A Type Frame 7번 영역 끝 ( 1x1 ) -->
							
							<!-- A Type Frame 8번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01_3 atype-1-1-01" id="frame_8">
							</div>
							<!-- A Type Frame 8번 영역 끝 ( 1x1 ) -->
						</div>
					</li>
				</ul>
				</c:if>
				<c:if test="${dashList.type_id eq '2'}">
				<ul class="dash-Atype-layout btype-layout">
					<li>
						<div>
							<!-- B Type Frame 2번 영역 시작 ( 4x1 ) -->
							<div class="atype-section02 atype-3-1-01 btype_4_1" id="frame_10">
							</div>
							<!-- B Type Frame 2번 영역 끝 ( 4x1 ) -->
							
							<!-- B Type Frame 1번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01 atype-1-1-01" id="frame_9">
							</div>
							<!-- B Type Frame 1번 영역 끝 ( 1x1 ) -->
							
							<!-- B Type Frame 3번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01_1 atype-1-1-01" id="frame_11">
							</div>
							<!-- B Type Frame 3번 영역 끝 ( 1x1 ) -->
							
							<!-- B Type Frame 4번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01_1 cb atype-1-1-01" id="frame_12">
							</div>
							<!-- B Type Frame 4번 영역 끝 ( 1x1 ) -->
							
							<!-- B Type Frame 5번 영역 시작 ( 4x2 ) -->
							<div class="atype-section03 atype-3-2-01 btype_4_2" id="frame_13">
							</div>
							<!-- B Type Frame 5번 영역 끝 ( 4x2 ) -->
						</div>
					</li>
				</ul>
				</c:if>
				<c:if test="${dashList.type_id eq '3'}">
				<ul class="dash-Atype-layout ctype-layout">
					<li>
						<div>
							<!-- C Type Frame 2번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01 atype-1-1-01 cb ctype-layout" id="frame_14">
							</div>
							<!-- C Type Frame 2번 영역 끝 ( 1x1 ) -->
							
							<!-- C Type Frame 1번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01_1 atype-1-1-01 cb ctype-layout" id="frame_15">
							</div>
							<!-- C Type Frame 1번 영역 끝 ( 1x1 ) -->
							
							<!-- C Type Frame 3번 영역 시작 ( 1x1 ) -->
							<div class="atype-section01_1 cb atype-1-1-01 cb ctype-layout" id="frame_16">
							</div>
							<!-- C Type Frame 3번 영역 끝 ( 1x1 ) -->
							
							<!-- C Type Frame 4번 영역 시작 ( 4x3 ) -->
							<div class="" id="frame_17">
							</div>
							<!-- C Type Frame 4번 영역 끝 ( 4x3 ) -->
						</div>
					</li>
				</ul>
				</c:if>
				<c:if test="${dashList.type_id eq '4'}">
				<ul class="dash-Atype-layout">
					<li>
						<div>
							<!-- D Type Frame 2번 영역 시작 ( 5x3 ) -->
							<div class="atype-1-1-01 dtype-a mr10" id="frame_18">
							</div>
							<!-- D Type Frame 2번 영역 끝 ( 5x3 ) -->
							
							<!-- D Type Frame 1번 영역 시작 ( 5x3 ) -->
							<div class="dtype-a ml10" id="frame_19">
							</div>
							<!-- D Type Frame 1번 영역 끝 ( 5x3 ) -->
						</div>
					</li>
				</ul>
				</c:if>
			</div>
			<div style="display:none;" id="typeElement">
					<!--1X1-01 근로자현황 섹션-->
					<dl class="a-1-1-workerState" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.worker.status"/></dt>
						<dd>
							<span class="worker-state"><spring:message code="click.real.time.number.workers"/> :</span>
							<div class="float-r">
								<strong class="blue worker_count"></strong>
								<strong class="unit"><spring:message code='click.workers'/></strong>
							</div>
							<ul class="state-wrap">
								<li>
									<span><spring:message code="click.new"/> :</span>
									<div class="float-r">
										<strong class="blue worker_newCount"></strong>
										<strong class="unit"><spring:message code='click.workers'/></strong>
									</div>
								</li>
								<li>
									<span><spring:message code="click.the.elderly"/> :</span>
									<div class="float-r">
										<strong class="blue worker_seniorCount"></strong>
										<strong class="unit"><spring:message code='click.workers'/></strong>
									</div>
								</li>
								<li>
									<span><spring:message code="click.foreigner"/> :</span>
									<div class="float-r">
										<strong class="blue worker_nationalityCount"></strong>
										<strong class="unit"><spring:message code='click.workers'/></strong>
									</div>
								</li>
							</ul>
						</dd>
					</dl>
					<!--1X1-02 근로자현황 (Graph) 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-workerStateGraph" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.worker.status"/></dt>
						<dd>
							<span class="worker-state"><spring:message code="click.real.time.number.workers"/> :</span>
							<div class="float-r">
								<strong class="blue worker_count"></strong>
								<strong class="unit"><spring:message code='click.workers'/></strong>
							</div>
							<div class="worker-chart-wrap">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--1X1-03 가스 현황 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-gasState" style="display: none;">
						<dt class="clickTitle">
							<spring:message code="click.gas.status"/>
							<em class="paging gasPage">(-/-)</em>
						</dt>
						<dd>
							<div class="gas-board-wrap" style="padding-bottom:0px;">
								<span class="gas-num">
									<c:if test="${locale == 'ko_kr'}">
										<em class="gasStateDeviceNo">0</em> 번 가스센서
									</c:if>
									<c:if test="${locale == 'en'}">
										Gas Sensor No.<em class="gasStateDeviceNo">0</em>
									</c:if>
								</span>
								<span class="div-line"> | </span>
								<span class="location">
								<em class="gasStateBuildingName" style="display: none;"><spring:message code="click.the.up.line"/></em>
								<!-- / -->
								<em class="gasStateZoneName" style="display: none;"><spring:message code="click.all"/></em>
								<!-- / -->
								<em class="gasStateCellName"><spring:message code="click.starting.part"/></em>
								</span>
							</div>
							<dl class="data-table-wrap5">
								<dt><em class="chemical-font">O₂</em></dt>
								<dd>
									<span style="display:inline-block; width:58px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">18%이상</span>
									<span class="greenTxt gasOxygenValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span style="display:inline-block; margin-left: 2px;">%</span>
									<em class="checkButtonOxygen"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
							<dl class="data-table-wrap5">
								<dt><em class="chemical-font">H₂S</em></dt>
								<dd>
									<span style="display:inline-block; width:60px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">10ppm미만</span>
									<span class="greenTxt gasHydrogenSulfideValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>ppm</span>
									<em class="checkButtonHydrogen"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
							<dl class="data-table-wrap5">
								<dt><em class="chemical-font">CO</em></dt>
								<dd>
									<span style="display:inline-block; width:60px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">30ppm미만</span>
									<span class="greenTxt gasCarbonMonoxideValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>ppm</span>
									<em class="checkButtonCarbon"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
							<dl class="data-table-wrap5">
								<dt><em class="chemical-font">CH₄</em></dt>
								<dd>
									<span style="display:inline-block; width:60px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">10%미만</span>
									<span class="greenTxt gasMethanValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>%</span>
									<em class="checkButtonMethan"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
						</dd>
					</dl>
					<!--1X1-04 장비현황 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-location" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.equipment.status"/></dt>
						<dd>
							<div class="eq-chart-wrap2 w100per">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--1X1-05 공정율 현황 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-tunnel" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.process.rate.status"/></dt>
						<dd>
							<div class="work-plan-div">
								<strong><spring:message code="click.plan"/></strong>
								<p class="digthrough_process_target"></p>
							</div>
							<div class="work-gap-div">
								<span><spring:message code="click.gap"/></span>
								<span class="digthrough_process_diff"></span>
							</div>
							<div class="work-finish-div">
								<strong <c:if test="${locale == 'en'}">style="font-size:0.9rem;"</c:if>><spring:message code="click.performance"/></strong>
								<p class="digthrough_process_ing"></p>
							</div>
						</dd>
					</dl>
					<!--1X1-06 굴진율 현황 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-tunnelDigging" style="display: none;">
						<dt class="clickTitle">
							<spring:message code="click.excavation.reate.status"/>
							<em class="paging diggingPage"></em>
						</dt>
						<dd>
							<div class="gas-board-wrap">
								<span class="gas-num tunnelName"><spring:message code="click.the.up.line"/></span>
								<div class="float-r">
									<strong class="unit-title"><spring:message code="click.excavation.rate"/></strong>
									<strong class="blue diggingPercent" id="">30</strong>
									<strong class="unit">%</strong>
								</div>
							</div>
							<div class="worker-chart-wrap">
								<!--차트 들어오는곳-->
								<%-- <iframe width="100%" height="120" src="${pageContext.request.contextPath}/highcharts/type07?chartHeight=150"></iframe> --%>
							</div>
						</dd>
					</dl>
					<!--1X1-07 T/C 현황 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-towerCraneProcess" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.tc.status"/></dt>
						<dd>
							<span class="tower-state"><spring:message code="click.tower.crane"/> :</span>
							<div class="float-r">
								<strong class="unit-title"><spring:message code="click.total"/></strong>
								<strong class="blue towerCraneCount">-</strong>
								<strong class="unit"><spring:message code='click.equip.units'/></strong>
							</div>
						</dd>
						<dd class="mt10">
							<span class="wind-state"><spring:message code="click.anemometer"/> :</span>
							<div class="float-r">
								<strong class="unit-title"><spring:message code="click.total"/></strong>
								<strong class="blue anemometerCount">-</strong>
								<strong class="unit"><spring:message code='click.equip.units'/></strong>
							</div>
						</dd>
						<dd class="data-table-area3">
							<dl class="data-table-wrap3" style="width:35%!important;">
								<dt><spring:message code="click.crashes"/></dt>
								<dd class="towerCraneEmergency" style="padding:4px 0 0 0;">
									<span class="craneColor"></span>
								</dd>
							</dl>
						</dd>
						<dd class="data-table-area3">
							<dl class="data-table-wrap3" style="width:65%!important;">
								<dt><spring:message code="click.wind.speed"/></dt>
								<dd class="anemometerEmergency" style="padding:4px 0 0 0;">
									<span class="windSpeedColor"><em class="windTxt"></em><em class="windSpeed"></em></span>
								</dd>
							</dl>
						</dd>
					</dl>
					<!--1X1-08 기상 센서 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-weatherSensor" style="display: none;">
						<dt class="clickTitle">
							<spring:message code="click.weather.sensor"/>(AWS)
						</dt>
						<dd>
							<dl class="data-table-wrap2">
								<c:if test="${locale == 'en'}">
									<dt style="line-height:15px;"><spring:message code="click.temperature.humidity"/></dt>
								</c:if>
								<c:if test="${locale == 'ko_kr'}">
									<dt><spring:message code="click.temperature.humidity"/></dt>
								</c:if>
								<dd>
									<span class="greenTxt weatherTemperature" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span style="display:inline-block; width:15px;">℃</span>
									<span class="slash-padding" style="display:inline-block; width:2px;"> / </span>
									<span class="greenTxt weatherHumidity" style="display:inline-block; width:60px; text-align:right;">0</span>
									<span>%</span>
								</dd>
							</dl>
							<dl class="data-table-wrap2">
								<dt><spring:message code="click.rainfall"/></dt>
								<dd>
									<span class="greenTxt weatherRainsinceonetime" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span>mm</span>
								</dd>
							</dl>
							<dl class="data-table-wrap2">
								<c:if test="${locale == 'en'}">
									<dt style="line-height:15px;"><spring:message code="click.wind.speed.wind.direction"/></dt>
								</c:if>
								<c:if test="${locale == 'ko_kr'}">
									<dt><spring:message code="click.wind.speed.wind.direction"/></dt>
								</c:if>
								<dd>
									<span class="greenTxt weatherWindwspd" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span>m/s (<em class="weatherWindwdirname"></em>)</span>
								</dd>
							</dl>
							<dl class="state-bg-wrap">
								<em class="greenBg weatherAlaram"><spring:message code="click.safety"/></em>
							</dl>
						</dd>
					</dl>
					<!--1X1-09 미세먼지센서 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-iotPMSensor" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.fine.dust.sensor"/></dt>
						<dd>
							<div class="eq-chart-wrap2 w100per">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--1X1-10 소음센서 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-NoiseSensor" style="display: none;">
						<dt class="clickTitle">
							<spring:message code="click.noise.sensor"/>
							<em class="paging noisePage"></em>
							
						</dt>
						<dd>
							<div class="eq-chart-wrap2 w100per">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--1X1-11 진동센서 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-VibrationSensor" style="display: none;">
						<dt class="clickTitle">
							<spring:message code="click.vibration.sensor"/>
							<em class="paging vibrationPage"></em>
							
						</dt>
						<dd>
							<div class="eq-chart-wrap2 w100per">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--1X1-12 흙막이 현황 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-retain" style="display: none;" id="atype-section01 atype-1-1-01">
						<dt class="clickTitle">
							<spring:message code="click.retaining.earth.status"/>
							<em class="paging"></em>
						</dt>
						<dd>
							<span class="noIcon-state" style="width:210px;"><spring:message code="click.retaining.earth.equipment.quantity2"/> :</span>
							<div class="float-r">
								<strong class="unit-title"><spring:message code="click.total"/></strong>
								<strong class="blue retainCount" id=""></strong>
								<strong class="unit"><spring:message code='click.pieces'/></strong>
							</div>
							<ul class="state-wrap-noBg">
								<li>
									<span <c:if test="${locale == 'en'}">style="font-size:12px;width:65%;"</c:if>>ㄴ <spring:message code="click.underground.inclinometer"/></span>
									<span class="countU" <c:if test="${locale == 'en'}">style="width:16%;font-size:12px;"</c:if>>-</span>
									<div class="float-r state-bg-wrap-small retainStatusU" <c:if test="${locale == 'en'}">style="width:15%;font-size:12px;"</c:if>>
										<em class="greenBg" <c:if test="${locale == 'en'}">style="font-size:0.8rem;"</c:if>><spring:message code="click.safety"/></em>
									</div>
								</li>
								<li>
									<span <c:if test="${locale == 'en'}">style="font-size:12px;width:65%;"</c:if>>ㄴ <spring:message code="click.groundwater.level.gauge"/></span>
									<span class="countB" <c:if test="${locale == 'en'}">style="width:16%;font-size:12px;"</c:if>>-</span>
									<div class="float-r state-bg-wrap-small retainStatusB" <c:if test="${locale == 'en'}">style="width:15%;font-size:12px;"</c:if>>
										<em class="greenBg" <c:if test="${locale == 'en'}">style="font-size:0.8rem;"</c:if>><spring:message code="click.safety"/></em>
									</div>
								</li>
								<li>
									<span <c:if test="${locale == 'en'}">style="font-size:12px;width:65%;"</c:if>>ㄴ <spring:message code="click.ground.surface.settlement.gauge"/></span>
									<span class="countG" <c:if test="${locale == 'en'}">style="width:16%;font-size:12px;"</c:if>>-</span>
									<div class="float-r state-bg-wrap-small retainStatusG" <c:if test="${locale == 'en'}">style="width:15%;font-size:12px;"</c:if>>
										<em class="greenBg" <c:if test="${locale == 'en'}">style="font-size:0.8rem;"</c:if>><spring:message code="click.safety"/></em>
									</div>
								</li>
								<li>
									<span <c:if test="${locale == 'en'}">style="font-size:12px;width:65%;"</c:if>>ㄴ <spring:message code="click.strain.gauge"/></span>
									<span class="countM" <c:if test="${locale == 'en'}">style="width:16%;font-size:12px;"</c:if>>-</span>
									<div class="float-r state-bg-wrap-small retainStatusM" <c:if test="${locale == 'en'}">style="width:15%;font-size:12px;"</c:if>>
										<em class="greenBg" <c:if test="${locale == 'en'}">style="font-size:0.8rem;"</c:if>><spring:message code="click.safety"/></em>
									</div>
								</li>
								<li>
									<span <c:if test="${locale == 'en'}">style="font-size:12px;width:65%;"</c:if>>ㄴ E/A <spring:message code="click.load.cell"/></span>
									<span class="countE" <c:if test="${locale == 'en'}">style="width:16%;font-size:12px;"</c:if>>-</span>
									<div class="float-r state-bg-wrap-small retainStatusE" <c:if test="${locale == 'en'}">style="width:15%;font-size:12px;"</c:if>>
										<em class="greenBg" <c:if test="${locale == 'en'}">style="font-size:0.8rem;"</c:if>><spring:message code="click.safety"/></em>
									</div>
								</li>
							</ul>
						</dd>
					</dl>
					<!--1X1-13 장비협착 현황 섹션 ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-equip" style="display: none;" id="a-1-1-equip atype-section01 atype-1-1-01">
						<dt class="clickTitle">
							<spring:message code="click.equipment.crush.status"/>
							<em class="paging equipPaging">(1/4)</em>
						</dt>
						<dd>
							<span class="noIcon-state"><spring:message code="click.equipment.stricture"/> :</span>
							<div class="float-r">
								<strong class="unit-title"><spring:message code="click.total"/></strong>
								<strong class="blue equipTotal" id=""></strong>
								<strong class="unit"><spring:message code='click.pieces'/></strong>
							</div>
							<div class="equipArea">
							</div>
						</dd>
					</dl>
					<!--1X1-14 CCTV 현황 섹션 1  ((((((((((((숨김처리중))))))))))))-->
					<dl class="a-1-1-cctvState" style="display: none;">
						<dt class="clickTitle">
							<spring:message code='click.cctv.status'/>
							<em class="paging cctv_paging"></em>
							<input type="hidden" id="cctvRealCurPage" value="">
							<input type="hidden" id="cctvRealLastPage" value="">
						</dt>
						<dd class="a-1-1-cctv">
							<div class="eq-chart-wrap2 w100per">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger1 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger1 atype-1-1-cctv-h live_img">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon1" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger1 atype-1-1-cctv-h">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
						</dd>
						<div class="a-1-1-cctvInfo" style="display: none;">
							<dd class="mb30">
								<div class="gas-board-wrap">
									<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
										<span class="cctv-chNum"><spring:message code="click.no" arguments="1"/></span><span class="gas-num"> CCTV</span>
									</c:if>
									<c:if test="${ locale eq 'en' }">
										<span class="gas-num" style="width:10%!important">No.</span><span class="cctv-chNum">1</span><span class="gas-num">&nbsp;&nbsp;CCTV</span>
									</c:if>
									<span class="div-line"> | </span>
									<span class="location cctv-chName"></span>
								</div>
							</dd>
							<dd class="cctv-state-wrap" <c:if test="${ locale eq 'en' }">style="padding-top:0px;"</c:if>>
								<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
									<span class="helmet-state"><spring:message code="click.not.wearing.safety.helmet"/> :</span>
								</c:if>
								<c:if test="${ locale eq 'en' }">
									<span class="helmet-state float-l">
										<spring:message code="click.not.wearing.safety.helmet1"/>
										<br>
										<spring:message code="click.not.wearing.safety.helmet2"/>
									</span>
								</c:if>
								<div class="float-r">
									<div class="float-r state-bg-wrap-medium">
										<em class="cctv-capEvent greenBg"><spring:message code="click.safety"/></em>
									</div>
								</div>
							</dd>
							<dd class="cctv-state-wrap">
								<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
									<span class="padding-state"><spring:message code="click.not.wearing.safety.vest"/> :</span>
								</c:if>
								<c:if test="${ locale eq 'en' }">
									<br><br>
									<span class="padding-state float-l">
										<spring:message code="click.not.wearing.safety.vest1"/>
										<br>
										<spring:message code="click.not.wearing.safety.vest2"/>
									</span>
								</c:if>
								<div class="float-r">
									<div class="float-r state-bg-wrap-medium">
										<em class="cctv-safevestEvent greenBg"><spring:message code="click.safety"/></em>
									</div>
								</div>
							</dd>
						</div>
					</dl>
					<!--1X1-15 CCTV 현황 섹션 2 /////// dl 이하 퍼가서 사용 ///////-->
					<dl class="atype-section01 atype-1-1-01" style="display: none;">
						<dt class="clickTitle">
							<spring:message code='click.cctv.status'/>
							<em class="paging">(2/2)</em>
						</dt>
						<dd class="mb20">
							<div class="gas-board-wrap">
								<span class="gas-num"><spring:message code="click.no" arguments="1"/> CCTV</span>
								<span class="div-line"> | </span>
								<span class="location"><spring:message code="click.launching.shaft"/></span>
							</div>
						</dd>
						<dd class="cctv-state-wrap">
							<span class="helmet-state"><spring:message code="click.not.wearing.safety.helmet"/> :</span>
							<div class="float-r">
								<div class="float-r state-bg-wrap-medium">
									<em class="greenBg"><spring:message code="click.safety"/></em>
								</div>
							</div>
						</dd>
						<dd class="cctv-state-wrap">
							<span class="padding-state"><spring:message code="click.not.wearing.safety.vest"/> :</span>
							<div class="float-r">
								<div class="float-r state-bg-wrap-medium">
									<em class="danger"><spring:message code="click.danger"/></em>
								</div>
							</div>
						</dd>
					</dl>
					<!--1X1-16 당일 이벤트 현황 (TEXT) 섹션/////// dl 이하 퍼가서 사용 ///////-->
					<dl class="a-1-1-event" style="display: none;" id="a-1-1-event atype-section01 atype-1-1-01">
						<dt class="clickTitle"><spring:message code="click.day.event.status"/></dt>
						<dd class="event-fullMode-1x1">
							<span class="noIcon-state"><spring:message code="click.total.number.cases"/> :</span>
							<div class="float-r">
								<strong class="blue totalEvent" id="">0</strong>
								<strong class="unit"><spring:message code='click.counts'/></strong>
							</div>
							<ul class="state-wrap mt20">
								<li>
									<span><spring:message code='click.action.completed'/> :</span>
									<div class="float-r">
										<strong class="blue event2" id="">0</strong>
										<strong class="unit"><spring:message code='click.counts'/></strong>
									</div>
								</li>
								<li>
									<span><spring:message code="click.no.action"/> :</span>
									<div class="float-r">
										<strong class="blue event0" id="">0</strong>
										<strong class="unit"><spring:message code='click.counts'/></strong>
									</div>
								</li>
								<li>
									<span><spring:message code="click.action.required"/> :</span>
									<div class="float-r">
										<strong class="blue event1" id="">0</strong>
										<strong class="unit"><spring:message code='click.counts'/></strong>
									</div>
								</li>
							</ul>
						</dd>
					</dl>
					<!--1X1-17 당일 이벤트 현황 (Graph) 섹션/////// dl 이하 퍼가서 사용 ///////-->
					<dl class="a-1-1-event2" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.day.event.status"/></dt>
						<dd class="event2-fullMode-1x1">
							<span class="noIcon-state"><spring:message code="click.total.number.cases"/> :</span>
							<div class="float-r">
								<strong class="blue totalEvent" id="">-</strong>
								<strong class="unit"><spring:message code='click.counts'/></strong>
							</div>
							<div class="eq-chart-wrap3">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>

					<!--3X1-01 근로자/가스/장비 현황 섹션-->
					<dl class="a-3-1-location atype-3-1-01" style="display: none;box-shadow: none;" id="a-3-1-location atype-section02 atype-3-1-01 atype-layout">
						<dt class="clickTitle"><spring:message code="click.worker.gas.equipment.status"/></dt>
						<dd class="worker">
							<h4><spring:message code="click.worker"/></h4>
							<div class="board-wrap">
								<span class="worker-state"><spring:message code="click.real.time.number.workers"/> :</span>
								<div class="float-r">
									<strong class="blue worker_count">3</strong>
									<strong class="unit"><spring:message code='click.workers'/></strong>
								</div>
							</div>
							<ul class="state-wrap">
								<li>
									<span><spring:message code="click.new"/> :</span>
									<div class="float-r">
										<strong class="blue worker_newCount">-</strong>
										<strong class="unit"><spring:message code='click.workers'/></strong>
									</div>
								</li>
								<li>
									<span><spring:message code="click.the.elderly"/> :</span>
									<div class="float-r">
										<strong class="blue worker_seniorCount">-</strong>
										<strong class="unit"><spring:message code='click.workers'/></strong>
									</div>
								</li>
								<li>
									<span><spring:message code="click.foreigner"/> :</span>
									<div class="float-r">
										<strong class="blue worker_nationalityCount">-</strong>
										<strong class="unit"><spring:message code='click.workers'/></strong>
									</div>
								</li>
							</ul>
						</dd>
						<dd class="gas">
							<h4><spring:message code="click.gas"/></h4>
							<em class="paging gasPage">(-/-)</em>
							<div class="gas-board-wrap">
								<span class="gas-num">
									<c:if test="${locale == 'ko_kr'}">
										<em class="gasStateDeviceNo">0</em> 번 가스센서
									</c:if>
									<c:if test="${locale == 'en'}">
										Gas Sensor No.<em class="gasStateDeviceNo">0</em>
									</c:if>
								</span>
								<span class="div-line"> | </span>
								<span class="location"><em class="gasStateBuildingName">-</em>/<em class="gasStateZoneName">-</em>/<em class="gasStateCellName">-</em></span>
							</div>
							<dl class="data-table-wrap mr10">
								<dt><em class="chemical-font">O₂</em></dt>
								<dd>
									<span style="display:inline-block; width:58px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">18%이상</span>
									<span class="greenTxt gasOxygenValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>%</span>
									<em class="checkButtonOxygen"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
							<dl class="data-table-wrap">
								<dt><em class="chemical-font">H₂S</em></dt>
								<dd>
									<span style="display:inline-block; width:60px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">10ppm미만</span>
									<span class="greenTxt gasHydrogenSulfideValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>ppm</span>
									<em class="checkButtonHydrogen"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
							<dl class="data-table-wrap mr10">
								<dt><em class="chemical-font">CO</em></dt>
								<dd>
									<span style="display:inline-block; width:60px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">30ppm미만</span>
									<span class="greenTxt gasCarbonMonoxideValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>ppm</span>
									<em class="checkButtonCarbon"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
							<dl class="data-table-wrap">
								<dt><em class="chemical-font">CH₄</em></dt>
								<dd>
									<span style="display:inline-block; width:60px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">10%미만</span>
									<span class="greenTxt gasMethanValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>%</span>
									<em class="checkButtonMethan"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
						</dd>
						<dd class="eq" style="width:30%;">
							<h4><spring:message code="click.equipment"/></h4>
							<div class="eq-chart-wrap">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--3X1-02 공정율/굴진율 현황 섹션 ((((((((((((숨김처리중))))))))-->
					<dl class="a-3-1-tunnel" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.process.excavation.rate.status"/></dt>
						<dd class="w50per pl20 pr20">
							<div class="work-plan-div">
								<strong><spring:message code="click.plan"/></strong>
								<p class="digthrough_process_target"></p>
							</div>
							<div class="work-gap-div">
								<span><spring:message code="click.gap"/></span>
								<span class="digthrough_process_diff"></span>
							</div>
							<div class="work-finish-div">
								<strong <c:if test="${locale == 'en'}">style="font-size:0.9rem;"</c:if>><spring:message code="click.performance"/></strong>
								<p class="digthrough_process_ing"></p>
							</div>
						</dd>
						<dd class="w50per pr20">
							<em class="paging diggingPage"></em>
							<div class="gas-board-wrap">
								<span class="gas-num tunnelName"><spring:message code="click.the.up.line"/></span>
								<div class="float-r">
									<strong class="unit-title align01"><spring:message code="click.excavation.rate"/></strong>
									<strong class="blue diggingPercent" id="">30</strong>
									<strong class="unit">%</strong>
								</div>
							</div>
							<div class="eq-chart-wrap4">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--3X1-03 T/C 현황 섹션 ((((((((((((숨김처리중))))))))-->
					<dl class="a-3-1-towerCraneProcess" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.tc.status"/></dt>
						<dd class="w50per pl20 pr20">
							<div class="gas-board-wrap pl20 pr20">
								<span class="gas-num"><spring:message code="click.tower.crane"/> :</span>
								<div class="float-r">
									<strong class="unit-title align01"><spring:message code="click.total"/></strong>
									<strong class="blue towerCraneCount">-</strong>
									<strong class="unit"><spring:message code='click.equip.units'/></strong>
								</div>
							</div>
							<div id="towerCraneArea3_1">
								<div class="tower-div greenBg">
									<strong>L</strong>
									<p>1<spring:message code="click.unit"/></p>
								</div>
								<div class="tower-div orangeBg">
									<strong>T</strong>
									<p>2<spring:message code="click.unit"/></p>
								</div>
								<div class="tower-div redBg">
									<strong>T</strong>
									<p>3<spring:message code="click.unit"/></p>
								</div>
							</div>
						</dd>
						
						<dd class="w50per pr20">
							<div class="gas-board-wrap pl20 pr20">
								<span class="gas-num"><spring:message code="click.anemometer"/> :</span>
								
								<div class="float-r">
									<strong class="unit-title align01"><spring:message code="click.total"/></strong>
									<strong class="blue anemometerCount">-</strong>
									<strong class="unit"><spring:message code='click.equip.units'/></strong>
								</div>
							</div>
							<!-- 풍속계는 2대가 최대 -->
							<ul class="flag-area anemometerArea3_1">
							</ul>
						</dd>
					</dl>
					<!--3X1-04 환경센서 현황 섹션 ((((((((((((숨김처리중))))))))-->
					<dl class="a-3-1-iotSensor" style="display: none;">
						<dt class="clickTitle"><spring:message code='click.environmental.sensor.status'/></dt>
						<dd class="worker">
							<h4><spring:message code="click.weather.sensor"/></h4>
							<dl class="data-table-wrap2">
								<c:if test="${locale == 'en'}">
									<dt style="line-height:15px;"><spring:message code="click.temperature.humidity"/></dt>
								</c:if>
								<c:if test="${locale == 'ko_kr'}">
									<dt><spring:message code="click.temperature.humidity"/></dt>
								</c:if>
								<dd class="w70per">
									<span class="greenTxt weatherTemperature" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span style="display:inline-block; width:15px;">℃</span>
									<span class="slash-padding" style="display:inline-block; width:2px;"> / </span>
									<span class="greenTxt weatherHumidity" style="display:inline-block; width:60px; text-align:right;">0</span>
									<span>%</span>
								</dd>
							</dl>
							<dl class="data-table-wrap2">
								<dt><spring:message code="click.rainfall"/></dt>
								<dd class="w70per">
									<span class="greenTxt weatherRainsinceonetime" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span>mm</span>
								</dd>
							</dl>
							<dl class="data-table-wrap2">
								<c:if test="${locale == 'en'}">
									<dt style="line-height:15px;"><spring:message code="click.wind.speed.wind.direction"/></dt>
								</c:if>
								<c:if test="${locale == 'ko_kr'}">
									<dt><spring:message code="click.wind.speed.wind.direction"/></dt>
								</c:if>
								<dd class="w70per">
									<span class="redTxt weatherWindwspd" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span>m/s (<em class="weatherWindwdirname"></em>)</span>
								</dd>
							</dl>
							<dl class="state-bg-wrap">
								<em class="greenBg weatherAlaram"><spring:message code="click.safety"/></em>
							</dl>
						</dd>
						<dd class="eq ml20">
							<h4><spring:message code="click.fine.dust.sensor"/></h4>
							<div class="envi-chart-wrap2">
								<!--차트 들어오는곳-->
							</div>
						</dd>
						<dd class="decibel">
							<h4><spring:message code="click.noise.sensor"/></h4>
							<!-- 
							<div class="gas-board-wrap">
								<span class="gas-num"><spring:message code='click.number.installations'/> :</span>
								
								<div class="float-r">
									<strong class="unit-title align01"><spring:message code="click.total"/></strong>
									<strong class="blue" id="">0</strong>
									<strong class="unit"><spring:message code='click.pieces'/></strong>
								</div>
							</div>
							<div class="center sensor-db-txt">
								<strong class="blue" id="">0</strong>
								<strong class="">db</strong>
							</div>
							<dl class="state-bg-wrap2">
								<em class="greenBg"><spring:message code="click.safety"/></em>
							</dl>
							 -->
							<div class="envi-chart-wrap1">
								<!--차트 들어오는곳-->
							</div>
						</dd>
						<dd class="decibel">
							<h4><spring:message code="click.vibration.sensor"/></h4>
							<!-- 
							<div class="gas-board-wrap pl20 pr20">
								<span class="gas-num"><spring:message code='click.number.installations'/> :</span>
								
								<div class="float-r">
									<strong class="unit-title align01"><spring:message code="click.total"/></strong>
									<strong class="blue" id="">0</strong>
									<strong class="unit"><spring:message code='click.pieces'/></strong>
								</div>
							</div>
							<div class="center sensor-db-txt">
								
								// 위험인경우 red 
								<strong class="red" id="">0</strong> 
								
								<strong class="blue" id="">0</strong>
								<strong class="">db</strong>
							</div>
							<dl class="state-bg-wrap2">
								<em class="greenBg"><spring:message code="click.safety"/></em>
							</dl>
							 -->
							<div class="envi-chart-wrap1 envi-chart-wrap3">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--3X1-05 흙막이 현황 섹션 ((((((((((((숨김처리중))))))))-->
					<dl class="a-3-1-retain atype-3-1-01" style="display: none;" id="a-3-1-retain atype-section02 atype-3-1-01">
						<dt class="clickTitle">
							<spring:message code="click.retaining.earth.status"/>
							<em class="paging"></em>
						</dt>
						<dd class="crust ml20">
							<h4 <c:if test="${locale == 'en'}">class="h50"</c:if>><spring:message code="click.underground.inclinometer"/></h4>
							<div class="cb center state-box01 <c:if test="${locale == 'en'}">state-box01-eng</c:if>">
								<strong class=""><spring:message code="click.total"/></strong>
								<strong class="retainText countU" id="">-</strong>
								<strong class=""><spring:message code='click.pieces'/></strong>
								<dl class="state-bg-wrap3 <c:if test="${locale == 'en'}">state-bg-wrap3-eng</c:if> retainStatusU">
									<em class="greenBg"><spring:message code="click.safety"/></em>
								</dl>
							</div>
						</dd>
						<dd class="crust">
							<h4 <c:if test="${locale == 'en'}">class="h50"</c:if>><spring:message code="click.groundwater.level.gauge"/></h4>
							<div class="cb center state-box01 <c:if test="${locale == 'en'}">state-box01-eng</c:if>">
								<strong class=""><spring:message code="click.total"/></strong>
								<strong class="retainText countB" id="">-</strong>
								<strong class=""><spring:message code='click.pieces'/></strong>
								<dl class="state-bg-wrap3 <c:if test="${locale == 'en'}">state-bg-wrap3-eng</c:if> retainStatusB">
									<em class="greenBg"><spring:message code="click.safety"/></em>
								</dl>
							</div>
						</dd>
						<dd class="crust">
							<h4 <c:if test="${locale == 'en'}">class="h50"</c:if>><spring:message code="click.ground.surface.settlement.gauge"/></h4>
							<div class="cb center state-box01 <c:if test="${locale == 'en'}">state-box01-eng</c:if>">
								<strong class=""><spring:message code="click.total"/></strong>
								<strong class="retainText countG" id="">-</strong>
								<strong class=""><spring:message code='click.pieces'/></strong>
								<dl class="state-bg-wrap3 <c:if test="${locale == 'en'}">state-bg-wrap3-eng</c:if> retainStatusG">
									<em class="greenBg"><spring:message code="click.safety"/></em>
								</dl>
							</div>
						</dd>
						<dd class="crust">
							<h4 <c:if test="${locale == 'en'}">class="h50"</c:if>><spring:message code="click.strain.gauge"/></h4>
							<div class="cb center state-box01 <c:if test="${locale == 'en'}">state-box01-eng</c:if>">
								<strong class=""><spring:message code="click.total"/></strong>
								<strong class="retainText countM" id="">-</strong>
								<strong class=""><spring:message code='click.pieces'/></strong>
								<dl class="state-bg-wrap3 <c:if test="${locale == 'en'}">state-bg-wrap3-eng</c:if> retainStatusM">
									<em class="greenBg"><spring:message code="click.safety"/></em>
								</dl>
							</div>
						</dd>
						<dd class="crust">
							<h4 <c:if test="${locale == 'en'}">class="h50"</c:if>>E/A <spring:message code="click.load.cell"/></h4>
							<div class="cb center state-box01 <c:if test="${locale == 'en'}">state-box01-eng</c:if>">
								<strong class=""><spring:message code="click.total"/></strong>
								<strong class="retainText countE" id="">-</strong>
								<strong class=""><spring:message code='click.pieces'/></strong>
								<dl class="state-bg-wrap3 <c:if test="${locale == 'en'}">state-bg-wrap3-eng</c:if> retainStatusE">
									<em class="greenBg"><spring:message code="click.safety"/></em>
								</dl>
							</div>
						</dd>
					</dl>
					<!--3X1-06 장비협착 현황 섹션 ((((((((((((숨김처리중))))))))-->
					<dl class="a-3-1-equip" style="display: none;" id="a-3-1-equip atype-section02 atype-3-1-01">
						<dt class="clickTitle">
							<spring:message code="click.equipment.crush.status"/>
							<em class="paging equipPaging"></em>
						</dt>
						<dd class="worker-status-wrap">
							<div class="worker-status">
								<strong><spring:message code="click.crush.ap"/></strong>
								<p class="equipTotal">
									-
								</p>
							</div>
						</dd>
						<dd class="ap-status-wrap">
							<div class="worker-status">
								<i><img src="${pageContext.request.contextPath}/resources/img/sub/eq-icon.png" alt=""></i>
								<ul class="ap-status">
									<li>
										<span><spring:message code="click.device.number"/> : </span>
										<span class="equipDeviceNo"></span>
									</li>
									<li>
										<span>MAC : </span>
										<span class="equipMacAddr"></span>
									</li>
									<li>
										<span class="equipBuildingName"></span>
										<span> / </span>
										<span class="equipZoneName"></span>
										<span> / </span>
										<span class="equipCellName"></span>
									</li>
								</ul>
								<ul class="ap-status">
									<li>
										<span><spring:message code="click.approver"/>1 : </span>
										<span class="equipWorkerName"></span>
									</li>
									<li>
										<span><spring:message code="click.approver"/>2 : </span>
										<span class="equipWorkerName2"></span>
									</li>
									<li class="red font-normal eventWorkerArea" style="display:none;">
										<span><spring:message code="click.unauthorized.worker"/> : </span>
										<span class="eventWorkerName"></span>
									</li>
								</ul>
								<dl class="state-bg-wrap4 equipStatus">
									<em class="greenBg"><spring:message code="click.safety"/></em>
								</dl>
							</div>
						</dd>
					</dl>
					<!--3X1-07 CCTV 현황 섹션 ((((((숨김처리중))))))-->
					<dl class="atype-3-1-01 a-3-1-cctvState" style="display: none;">
						<dt class="clickTitle">
							<spring:message code='click.cctv.status'/>
							<em class="paging cctv_paging"></em>
						</dt>
						<dd class="cctv">
							<div class="eq-chart-wrap2">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger2 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger2 atype-1-1-cctv-h live_img">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon2" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger2 atype-1-1-cctv-h">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
							<div class="eq-chart-wrap2">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger2 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger2 atype-1-1-cctv-h live_img">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon3" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger2 atype-1-1-cctv-h">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
							<div class="eq-chart-wrap2">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger2 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger2 atype-1-1-cctv-h live_img">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon4" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger2 atype-1-1-cctv-h">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
						</dd>
					</dl>
					<!--3X2-01 위치 관제 현황 섹션-->
					<dl class="a-3-2-locationMap" style="display: none;">
						<dt class="clickTitle"><spring:message code='click.location.control.status'/></dt>
						<dd>
							<div class="content-box rocation-map-area dtype-map">
								<ul class="controll-kind-wrap" style="position:fixed;">
								</ul>
								<canvas id="mycanvas1" style="background-color:#F0F0F0;">
								</canvas>
							</div>
						</dd>
					</dl>
					<!--3X2-02 근로자 근무 현황 섹션-->
					<dl class="a-3-2-location" id="a-3-2-location atype-section03 full-worker atype-3-2-01" style="display: none;">
						<dt class="clickTitle"><spring:message code='click.worker.work.status'/></dt>
						<dd class="float-l w50per">
							<h4><spring:message code="click.worker.status"/></h4>
							<span class="worker-state"><spring:message code="click.real.time.number.workers"/> :</span>
							<div class="float-r mb20">
								<strong class="blue worker_count" id="">0</strong>
								<strong class="unit"><spring:message code='click.workers'/></strong>
							</div>
							<div class="work-chart-wrap2">
								<!--차트 들어오는곳-->
							</div>
						</dd>
						<dd class="cctv float-l w50per">
							<h4><spring:message code="click.status.by.company"/></h4>
							<div class="work-chart-wrap">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--3X2-03 가스관제현황 섹션-->
					<dl class="a-3-2-gasMonitoring" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.gas.control.status"/></dt>
						<dd class="gas-state-wrap pt23">
							<span class="worker-state"><spring:message code="click.gas.detector"/> :</span>
							<div class="float-r mb20">
								<strong class="unit-title align01"><spring:message code="click.total"/></strong>
								<strong class="blue gasDeviceCount">0</strong>
								<strong class="unit"><spring:message code='click.equip.units'/></strong>
							</div>
						</dd>
						<dd class="navigation-wrap">
							<ul class="box-distribution gasButtonArea">
                              
                           </ul>
						</dd>
						<dd>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.oxygen"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange1">0</em>%)</span>
								</li>
								<li class="graph-wrap gas-graph-wrap1">
									<!--그래프영역 입니다-->
								</li>
								<li class="state-bg-wrap gasStatusArea1">
									<span class="redBg"><spring:message code="click.danger"/></span>
									<!--<span class="greenBg">안전</span>-->
									<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
								</li>
								<li class="date gasStatusDate1">-</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.carbon.monoxide"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange2">0</em>ppm <spring:message code="click.less.than"/>)</span>
								</li>
								<li class="graph-wrap gas-graph-wrap2">
									<!--그래프영역 입니다-->
								</li>
								<li class="state-bg-wrap gasStatusArea2">
									<span class="redBg"><spring:message code="click.danger"/></span>
									<!--<span class="greenBg">안전</span>-->
									<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
								</li>
								<li class="date gasStatusDate2">-</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.hydrogen"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange3">0</em>ppm <spring:message code="click.less.than"/>)</span>
								</li>
								<li class="graph-wrap gas-graph-wrap3">
									<!--그래프영역 입니다-->
								</li>
								<li class="state-bg-wrap gasStatusArea3">
									<span class="redBg"><spring:message code="click.danger"/></span>
									<!--<span class="greenBg">안전</span>-->
									<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
								</li>
								<li class="date gasStatusDate3">-</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.methane"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange4">0</em>% <spring:message code="click.less.than"/>)</span>
								</li>
								<li class="graph-wrap gas-graph-wrap4">
									<!--그래프영역 입니다-->
								</li>
								<li class="state-bg-wrap gasStatusArea4">
									<span class="redBg"><spring:message code="click.danger"/></span>
									<!--<span class="greenBg">안전</span>-->
									<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
								</li>
								<li class="date gasStatusDate4">-</li>
							</ul>
						</dd>
					</dl>
					<!--3X2-04 굴진현황 섹션-->
					<dl class="a-3-2-tunnel" style="display: none;">
						<dt class="clickTitle">
							<spring:message code='click.excavation.status'/>
							<em class="paging diggingPage"></em>
						</dt>
						<dd class="tunnel-wrap tunnel-bg">
							<div class="tunnel-position-wrap1">
								<ul class="pos01">
									<li style="text-align:center;"><spring:message code="click.starting.part"/><br/>0m</li>
									<li class="line dashboard"></li>
								</ul>
							</div>
							<div class="tunnel-position-wrap5">
								<ul class="pos05">
									<li style="text-align:center;"><spring:message code="click.end.point"/><br/><em class="lastPoint"></em></li>
									<li class="line dashboard"></li>
								</ul>
							</div>
							<div class="tunnel-progress-area" id="graphAreaA">
								<!--굴진률 그래프 끝-->
							</div>	
							<div class="markingArea2">
								<div style="width:100%;color:#999;" id="graphMarkingA">
									
								</div>
							</div>
							<div class="markingValueArea2">
								<div style="width:100%;color:#999;margin-left:0.8%;font-size:10px;" id="graphMarkingValueA">
									
								</div>
							</div>
							<ul class="section-paging-rolling2">
							</ul>
						</dd>
					</dl>
					<!--3X2-05 T/C 현황 섹션-->
					<dl class="a-3-2-towerCraneProcess" style="display: none;" id="a-3-2-towerCraneProcess atype-section03 atype-1-1-01">
						<dt class="clickTitle"><spring:message code="click.tc.status"/></dt>
						<dd>
							<div class="content-box rocation-map-area2 dtype-map">
								<!--tc 테이블-->
								<div class="table-small mb20 font14" style="position:fixed;">
									<table>
									<caption><span class="blind">TC안전 신호등 테이블</span></caption>
									<colgroup class="">
										<col width="60%">
										<col width="40%">
									</colgroup>
									<thead class="">
										<tr>
											<th scope="col" class="center">T/C</th>
											<th scope="col" class="center"><spring:message code="click.safety"/></th>
										</tr>
									</thead>
									<tbody class="craneList">
									</tbody>
									</table>
								</div>
								<ul class="tc-flag-area" style="margin-left:200px;position:fixed;">
								</ul>
								<canvas id="mycanvas2" style="background-color:#F0F0F0;">
								</canvas>
							</div>
						</dd>
					</dl>
					<!--3X2-06 환경센서 현황 섹션-->
					<dl class="a-3-2-iotSensor" style="display: none;" id="a-3-2-iotSensor atype-section03 atype-3-2-01">
						<dt class="clickTitle"><spring:message code='click.environmental.sensor.status'/></dt>
						<dd class="envi-chart-area">
							<ul class="envi-chart-left">
								<li>
									<h4><spring:message code="click.weather.sensor"/></h4>
									<dl class="data-table-wrap2">
										<c:if test="${locale == 'en'}">
											<dt style="line-height:15px;"><spring:message code="click.temperature.humidity"/></dt>
										</c:if>
										<c:if test="${locale == 'ko_kr'}">
											<dt><spring:message code="click.temperature.humidity"/></dt>
										</c:if>
										<dd class="w70per">
											<span class="greenTxt weatherTemperature" style="display:inline-block; width:70px; text-align:right;">0</span>
											<span style="display:inline-block; width:15px;">℃</span>
											<span class="slash-padding" style="display:inline-block; width:2px;"> / </span>
											<span class="greenTxt weatherHumidity" style="display:inline-block; width:60px; text-align:right;">0</span>
											<span>%</span>
										</dd>
									</dl>
									<dl class="data-table-wrap2">
										<dt><spring:message code="click.rainfall"/></dt>
										<dd class="w70per">
											<span class="greenTxt weatherRainsinceonetime" style="display:inline-block; width:70px; text-align:right;">0</span>
											<span>mm</span>
										</dd>
									</dl>
									<dl class="data-table-wrap2">
										<c:if test="${locale == 'en'}">
											<dt style="line-height:15px;"><spring:message code="click.wind.speed.wind.direction"/></dt>
										</c:if>
										<c:if test="${locale == 'ko_kr'}">
											<dt><spring:message code="click.wind.speed.wind.direction"/></dt>
										</c:if>
										<dd class="w70per">
											<span class="redTxt weatherWindwspd" style="display:inline-block; width:70px; text-align:right;">0</span>
											<span>m/s (<em class="weatherWindwdirname"></em>)</span>
										</dd>
									</dl>
									<dl class="state-bg-wrap">
										<em class="greenBg weatherAlaram"><spring:message code="click.safety"/></em>
										<!-- <em class="redBg">위험</em> -->
									</dl>
								</li>
								<li class="mt20">
									<h4><spring:message code="click.noise.sensor"/></h4>
									<div class="envi-chart-wrap1">
										<!--차트 들어오는곳-->
									</div>
								</li>
							</ul>
							<ul class="envi-chart-right">
								<li class="">
									<h4><spring:message code="click.fine.dust.sensor"/></h4>
									<div class="envi-chart-wrap2">
										<!--차트 들어오는곳-->
									</div>
								</li>
								<li class="mt20">
									<h4><spring:message code="click.vibration.sensor"/></h4>
									<div class="envi-chart-wrap1 envi-chart-wrap3">
										<!--차트 들어오는곳-->
									</div>
								</li>
							</ul>
						</dd>
					</dl>
					
					<!--3X2-07 CCTV 현황 섹션-->
					<!-- <dl class="atype-section03 atype-3-2-01 a-3-2-cctvState" style="display: none;"> -->
					<dl class="a-3-2-cctvState" style="display:none;">
						<dt class="clickTitle">
							<spring:message code='click.cctv.status'/>
							<em class="paging cctv_paging"></em>
						</dt>
						<dd class="cctv">
							<div class="eq-chart-wrap3">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger3 live_blank_img" style="display:none;width:100%;height:400px;" >
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger3 atype-1-1-cctv-h live_img" style="width:100%;height:400px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon5" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger3 atype-1-1-cctv-h" style="width:100%;height:400px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
						</dd>
					</dl>

					<!--4X1-01 근로자/가스/장비 현황 섹션-->
					<dl class="b-4-1-location atype-section02 atype-3-1-01 btype_4_1" style="display: none;" id="b-4-1-location">
						<dt class="clickTitle"><spring:message code="click.worker.gas.equipment.status"/></dt>
						<dd class="worker">
							<h4><spring:message code="click.worker"/></h4>
							<div class="board-wrap">
								<span class="worker-state"><spring:message code="click.real.time.number.workers"/> :</span>
								<div class="float-r">
									<strong class="blue worker_count" id="">3</strong>
									<strong class="unit"><spring:message code='click.workers'/></strong>
								</div>
							</div>
							
							<ul class="state-wrap">
								<h5><spring:message code="click.day.event.status"/></h5>
								<li>
									<span><spring:message code='click.emergency.call'/> :</span>
									<div class="float-r">
										<strong class="blue locationEventCount" id="">-</strong>
										<strong class="unit"><spring:message code='click.counts'/></strong>
									</div>
								</li>
							</ul>
						</dd>
						<dd class="eq ml20 mr0">
							<h4><spring:message code="click.worker"/>(Graph)</h4>
							<div class="worker-chart-wrap" style="height:140px;">
								<!--차트 들어오는곳-->
							</div>
						</dd>
						<dd class="gas">
							<h4><spring:message code="click.gas"/></h4>
							<em class="paging gasPage">(-/-)</em>
							<div class="gas-board-wrap" style="padding-bottom:0px;">
								<span class="gas-num">
									<c:if test="${locale == 'ko_kr'}">
										<em class="gasStateDeviceNo">0</em> 번 가스센서
									</c:if>
									<c:if test="${locale == 'en'}">
										Gas Sensor No.<em class="gasStateDeviceNo">0</em>
									</c:if>
								</span>
								<span class="div-line"> | </span>
								<span class="location">
								<em class="gasStateBuildingName"><spring:message code="click.the.up.line"/></em>
								/
								<em class="gasStateZoneName"><spring:message code='click.all'/></em>
								/
								<em class="gasStateCellName"><spring:message code="click.starting.part"/></em>
								</span>
							</div>
							<dl class="data-table-wrap mr10">
								<dt><em class="chemical-font">O₂</em></dt>
								<dd>
									<span style="display:inline-block; width:58px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">18%이상</span>
									<span class="greenTxt gasOxygenValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>%</span>
									<em class="checkButtonOxygen"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
							<dl class="data-table-wrap">
								<dt><em class="chemical-font">H₂S</em></dt>
								<dd>
									<span style="display:inline-block; width:60px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">10ppm미만</span>
									<span class="greenTxt gasHydrogenSulfideValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>ppm</span>
									<em class="checkButtonHydrogen"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
							<dl class="data-table-wrap mr10">
								<dt><em class="chemical-font">CO</em></dt>
								<dd>
									<span style="display:inline-block; width:60px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">30ppm미만</span>
									<span class="greenTxt gasCarbonMonoxideValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>ppm</span>
									<em class="checkButtonCarbon"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
							<dl class="data-table-wrap">
								<dt><em class="chemical-font">CH₄</em></dt>
								<dd>
									<span style="display:inline-block; width:60px;color:#6e6e6e;font-size:0.7rem;margin-left: 2px;">10%미만</span>
									<span class="greenTxt gasMethanValue" style="display:inline-block; width:35px; text-align:right;">0</span>
									<span>%</span>
									<em class="checkButtonMethan"><em class="safe"><spring:message code="click.safety"/></em></em>
								</dd>
							</dl>
						</dd>
						<dd class="eq">
							<h4><spring:message code="click.equipment"/></h4>
							<div class="eq-chart-wrap eq-chart-area">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--4X1-02 가스관제 현황 섹션 ((((((((((((숨김처리중))))))))-->
					<dl class="b-4-1-gasMonitoring" style="display: none;" id="b-4-1-gasMonitoring atype-section02 atype-3-1-01 btype_4_1">
						<dt class="clickTitle"><spring:message code="click.gas.status"/></dt>
						<dd class="navigation-wrap box-distribution">
							<ul class="box-distribution gasButtonArea">
								<li><spring:message code="click.no" arguments="1"/></li>
								<li><spring:message code="click.no" arguments="2"/></li>
								<li><spring:message code="click.no" arguments="3"/></li>
								<li><spring:message code="click.no" arguments="4"/></li>
								<li><spring:message code="click.no" arguments="5"/></li>
								<li><spring:message code="click.no" arguments="6"/></li>
								<li><spring:message code="click.no" arguments="7"/></li>
								<li><spring:message code="click.no" arguments="8"/></li>
							</ul>
						</dd>
						<dd class="gas-graph-area-width">
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.oxygen"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange1">0</em>%)</span>
									<div class="state-bg-wrap gasStatusArea1">
										<span class="redBg"><spring:message code="click.danger"/></span>
										<!--<span class="greenBg">안전</span>-->
										<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
									</div>
									<span class="date gasStatusDate1">-</span>
								</li>
								<li class="graph-wrap gas-graph-wrap1">
									<!--그래프영역 입니다-->
								</li>
								
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.carbon.monoxide"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange2">0</em>ppm <spring:message code="click.less.than"/>)</span>
									<div class="state-bg-wrap gasStatusArea2">
										<span class="redBg"><spring:message code="click.danger"/></span>
										<!--<span class="greenBg">안전</span>-->
										<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
									</div>
									<span class="date gasStatusDate2">-</span>
								</li>
								<li class="graph-wrap gas-graph-wrap2">
									<!--그래프영역 입니다-->
								</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.hydrogen"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange3">0</em>ppm <spring:message code="click.less.than"/>)</span>
									<div class="state-bg-wrap gasStatusArea3">
										<!-- <span class="redBg">위험</span> -->
										<span class="greenBg"><spring:message code="click.safety"/></span>
										<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
									</div>
									<span class="date gasStatusDate3">-</span>
								</li>
								<li class="graph-wrap gas-graph-wrap3">
									<!--그래프영역 입니다-->
								</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.methane"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange4">0</em>% <spring:message code="click.less.than"/>)</span>
									<div class="state-bg-wrap gasStatusArea4">
										<!-- <span class="redBg">위험</span> -->
										<!--<span class="greenBg">안전</span>-->
										<span class="errorBg"><spring:message code="click.error"/></span>
									</div>
									<span class="date gasStatusDate4">-</span>
								</li>
								<li class="graph-wrap gas-graph-wrap4">
									<!--그래프영역 입니다-->
								</li>
							</ul>
						</dd>
					</dl>
					<!--4X1-03 공정율/굴진율 현황 섹션 ((((((((((((숨김처리중))))))))-->
					<dl class="c-4-1-tunnel" style="display: none;" id="c-4-1-tunnel atype-section02 atype-3-1-01 btype_4_1">
						<dt class="clickTitle"><spring:message code="click.process.excavation.rate.status"/></dt>
						<dd class="work-chart-area">
							<div class="work-plan-div">
								<strong><spring:message code="click.plan"/></strong>
								<p class="digthrough_process_target"></p>
							</div>
							<div class="work-gap-div">
								<span><spring:message code="click.gap"/></span>
								<span class="digthrough_process_diff"></span>
							</div>
							<div class="work-finish-div">
								<strong <c:if test="${locale == 'en'}">style="font-size:0.9rem;"</c:if>><spring:message code="click.performance"/></strong>
								<p class="digthrough_process_ing"></p>
							</div>
						</dd>
						<dd class="work-graph-area">
							<em class="paging diggingPage"></em>
							<div class="gas-board-wrap" style="padding-bottom:0px;">
								<span class="gas-num tunnelName"><spring:message code="click.the.up.line"/></span>
								
								<div class="float-r">
									<strong class="unit-title align01"><spring:message code="click.excavation.rate"/></strong>
									<strong class="blue diggingPercent" id="">30</strong>
									<strong class="unit">%</strong>
								</div>
							</div>
							<div class="work-graph-wrap1">
								<!--차트 들어오는곳-->
							</div>
							<div class="work-graph-wrap2">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--4X1-04 T/C 현황 섹션 ((((((((((((숨김처리중))))))))-->
					<dl class="b-4-1-towerCraneProcess" style="display: none;" id="atype-section02 atype-3-1-01 btype_4_1">
						<dt class="clickTitle"><spring:message code="click.tc.status"/></dt>
						<dd class="tc-board-wrap">
							<div class="gas-board-wrap pl20 pr20">
								<span class="gas-num"><spring:message code="click.tower.crane"/> :</span>
								
								<div class="float-r">
									<strong class="unit-title align01"><spring:message code="click.total"/></strong>
									<strong class="blue towerCraneCount" id="">0</strong>
									<strong class="unit"><spring:message code='click.equip.units'/></strong>
								</div>
							</div>
							
						</dd>
						<dd class="tc-flag-wrap">
							<ul class="flag-area anemometerArea4_1">
								
							</ul>
						</dd>
						<dd class="tower-div-wrap towerCraneArea4_1">
							
						</dd>
					</dl>
					<!--4X1-05 환경센서 현황 섹션 ((((((((((((숨김처리중))))))))-->
					<!-- <dl class="atype-section02 atype-3-1-01 btype_4_1 a-4-1-iotSensor" style="display: none;"> -->
					<dl class="a-4-1-iotSensor" style="display: none;">
						<dt class="clickTitle"><spring:message code='click.environmental.sensor.status'/></dt>
						<dd class="worker" style="padding-left:20px">
							<h4><spring:message code="click.weather.sensor"/></h4>
							<dl class="data-table-wrap2">
								<c:if test="${locale == 'en'}">
									<dt style="line-height:15px;"><spring:message code="click.temperature.humidity"/></dt>
								</c:if>
								<c:if test="${locale == 'ko_kr'}">
									<dt><spring:message code="click.temperature.humidity"/></dt>
								</c:if>
								<dd class="w70per">
									<span class="greenTxt weatherTemperature" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span style="display:inline-block; width:15px;">℃</span>
									<span class="slash-padding" style="display:inline-block; width:2px;"> / </span>
									<span class="greenTxt weatherHumidity" style="display:inline-block; width:60px; text-align:right;">0</span>
									<span>%</span>
								</dd>
							</dl>
							<dl class="data-table-wrap2">
								<dt><spring:message code="click.rainfall"/></dt>
								<dd class="w70per">
									<span class="greenTxt weatherRainsinceonetime" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span>mm</span>
								</dd>
							</dl>
							<dl class="data-table-wrap2">
								<c:if test="${locale == 'en'}">
									<dt style="line-height:15px;"><spring:message code="click.wind.speed.wind.direction"/></dt>
								</c:if>
								<c:if test="${locale == 'ko_kr'}">
									<dt><spring:message code="click.wind.speed.wind.direction"/></dt>
								</c:if>
								<dd class="w70per">
									<span class="greenTxt weatherWindwspd" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span>m/s (<em class="weatherWindwdirname"></em>)</span>
								</dd>
							</dl>
							<dl class="state-bg-wrap">
								<em class="greenBg weatherAlaram"><spring:message code="click.safety"/></em>
							</dl>
						</dd>
						<dd class="eq ml20">
							<h4><spring:message code="click.fine.dust.sensor"/></h4>
							<div class="envi-chart-wrap2">
								<!--차트 들어오는곳-->
							</div>
						</dd>
						<dd class="eq ml20">
							<h4><spring:message code="click.noise.sensor"/></h4>
							<div class="envi-chart-wrap1">
								<!--차트 들어오는곳-->
							</div>
						</dd>
						<dd class="eq ml20">
							<h4><spring:message code="click.vibration.sensor"/></h4>
							<div class="envi-chart-wrap1 envi-chart-wrap3">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--4X1-06 CCTV 현황 섹션 ((((((숨김처리중))))))-->
					<dl class="a-4-1-cctvState" style="display: none;">
						<dt class="clickTitle">
							<spring:message code='click.cctv.status'/>
							<em class="paging cctv_paging"></em>
						</dt>
						<dd class="cctv">
							<div class="eq-chart-wrap2">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area1" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger4 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger4 atype-1-1-cctv-h live_img" style="width:450px;height:160px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon13" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger4 atype-1-1-cctv-h" style="width:450px;height:160px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
							<div class="eq-chart-wrap2">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger4 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger4 atype-1-1-cctv-h live_img" style="width:450px;height:160px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon14" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger4 atype-1-1-cctv-h" style="width:450px;height:160px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
							<div class="eq-chart-wrap2">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger4 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger4 atype-1-1-cctv-h live_img" style="width:450px;height:160px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon15" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger4 atype-1-1-cctv-h" style="width:450px;height:160px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
						</dd>
					</dl>
					<!--4X2-01 위치 관제 현황 섹션-->
					<dl class="b-4-2-locationMap" style="display: none;" id="b-4-2-locationMap atype-section03 atype-3-2-01 btype_4_2">
						<dt class="clickTitle"><spring:message code="click.location.control.status"/></dt>
						<dd>
							<div class="content-box rocation-map-area dtype-map">
								<ul class="controll-kind-wrap" style="position:fixed;">
								</ul>
								<canvas id="mycanvas3" style="background-color:#F0F0F0;">
								</canvas>
							</div>
						</dd>
					</dl>
					<!--4X2-02 근로자 근무 현황 섹션-->
					<dl class="b-4-2-location" style="display: none;" id="b-4-2-location atype-section03 atype-3-2-01 btype_4_2">
						<dt class="clickTitle"><spring:message code='click.worker.work.status'/></dt>
						<dd class="float-l w50per pr0">
							<h4><spring:message code="click.real.time.control.status"/></h4>
							<span class="worker-state">
								<spring:message code="click.real.time.number.workers"/>
								<div class="state-num">
									<strong class="blue worker_count" id="">-</strong>
									<strong class="unit"><spring:message code='click.workers'/></strong>
								</div>
								<ul class="state-wrap">
									<h5><spring:message code="click.day.event.status"/></h5>
									<li>
										<span><spring:message code='click.emergency.call'/></span>
										<div class="mt10">
											<strong class="blue locationEventCount" id="">-</strong>
											<strong class="unit"><spring:message code='click.counts'/></strong>
										</div>
									</li>
								</ul>
							</span>
							
							<div class="work-chart-wrap3">
								<!--차트 들어오는곳-->
							</div>
						</dd>
						<dd class="cctv float-l w50per">
							<h4><spring:message code="click.status.by.company"/></h4>
							<div class="work-chart-wrap work-chart-wrap4">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--4X2-03 가스관제현황 섹션-->
					<dl class="b-4-2-gasMonitoring" style="display: none;" id="b-4-2-gasMonitoring atype-section03 atype-3-2-01 btype_4_2">
						<dt class="clickTitle"><spring:message code="click.gas.control.status"/></dt>
						<dd class="gas-graph-area-width">
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.oxygen"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange1">0</em>%)</span>
									<div class="state-bg-wrap gasStatusArea1">
										<span class="redBg"><spring:message code="click.danger"/></span>
										<!--<span class="greenBg">안전</span>-->
										<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
									</div>
									<span class="date gasStatusDate1"></span>
								</li>
								<li class="graph-wrap gas-graph-wrap1">
									<!--그래프영역 입니다-->
								</li>
								
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.carbon.monoxide"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange2">0</em>ppm <spring:message code="click.less.than"/>)</span>
									<div class="state-bg-wrap gasStatusArea2">
										<span class="redBg"><spring:message code="click.danger"/></span>
										<!--<span class="greenBg">안전</span>-->
										<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
									</div>
									<span class="date gasStatusDate2"></span>
								</li>
								<li class="graph-wrap gas-graph-wrap2">
									<!--그래프영역 입니다-->
								</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.hydrogen"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange3">0</em>ppm <spring:message code="click.less.than"/>)</span>
									<div class="state-bg-wrap gasStatusArea3">
										<!-- <span class="redBg">위험</span> -->
										<span class="greenBg"><spring:message code="click.safety"/></span>
										<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
									</div>
									<span class="date gasStatusDate3"></span>
								</li>
								<li class="graph-wrap gas-graph-wrap3">
									<!--그래프영역 입니다-->
								</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.methane"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange4">0</em>% <spring:message code="click.less.than"/>)</span>
									<div class="state-bg-wrap gasStatusArea4">
										<!-- <span class="redBg">위험</span> -->
										<!--<span class="greenBg">안전</span>-->
										<span class="errorBg"><spring:message code="click.error"/></span>
									</div>
									<span class="date gasStatusDate4"></span>
								</li>
								<li class="graph-wrap gas-graph-wrap4">
									<!--그래프영역 입니다-->
								</li>
							</ul>
						</dd>
						<dd class="gas-state-wrap pt30">
							<span class="gas-state"><spring:message code="click.gas.detector"/></span>
							<div class="state-num">
								<strong class="unit-title align01"><spring:message code="click.total"/></strong>
								<strong class="blue gasDeviceCount" id="">0</strong>
								<strong class="unit"><spring:message code='click.equip.units'/></strong>
							</div>
							<div class="navigation-wrap">
								<ul class="gasButtonArea box-distribution3">
									
								</ul>
							</div>
						</dd>
					</dl>
					<!--4X2-04 굴진현황 섹션-->
					<dl class="b-4-2-tunnel" style="display: none;">
						<dt class="clickTitle">
							<spring:message code="click.process.excavation.rate.status"/>
							<em class="paging diggingPage"></em>
						</dt>
						<dd class="work-chart-area">
							<h4><spring:message code="click.process.rate"/></h4>
							<div class="work-plan-div">
								<strong><spring:message code="click.plan"/></strong>
								<p class="digthrough_process_target"></p>
							</div>
							<div class="work-gap-div-vertical">
								<span><spring:message code="click.gap"/></span>
								<span class="digthrough_process_diff"></span>
							</div>
							<div class="work-finish-div">
								<strong <c:if test="${locale == 'en'}">style="font-size:0.9rem;"</c:if>><spring:message code="click.performance"/></strong>
								<p class="digthrough_process_ing"></p>
							</div>
						</dd>
						<dd class="tunnel-wrap tunnel-bg">
							<div class="tunnel-position-wrap1">
								<ul class="pos01">
									<li style="text-align:center;"><spring:message code="click.starting.part"/><br/>0m</li>
									<li class="line dashboard"></li>
								</ul>
							</div>
							<div class="tunnel-position-wrap5">
								<ul class="pos05">
									<li style="text-align:center;"><spring:message code="click.end.point"/><br/><em class="lastPoint">0m</em></li>
									<li class="line dashboard"></li>
								</ul>
							</div>
							<div class="tunnel-progress-area" id="graphAreaB">
								<!--굴진률 그래프 끝-->
							</div>	
							<div class="markingArea2">
								<div style="width:100%;color:#999;" id="graphMarkingB">
									
								</div>
							</div>
							<div class="markingValueArea2">
								<div style="width:100%;color:#999;margin-left:0.8%;font-size:10px;" id="graphMarkingValueB">
									
								</div>
							</div>
							<ul class="section-paging-rolling2">
							</ul>
						</dd>
					</dl>
					<!--4X2-05 T/C 현황 섹션-->
					<dl class="b-4-2-towerCraneProcess" style="display: none;" id="atype-section03 atype-1-1-01 btype_4_2">
						<dt class="clickTitle"><spring:message code="click.tc.status"/></dt>
						<dd>
							<div class="content-box rocation-map-area2 dtype-map">
								<!--tc 테이블-->
								<div class="table-small mb20 font14" style="position:fixed;">
									<table>
									<caption><span class="blind">TC안전 신호등 테이블</span></caption>
									<colgroup class="">
										<col width="60%">
										<col width="40%">
									</colgroup>
									<thead class="">
										<tr>
											<th scope="col" class="center">T/C</th>
											<th scope="col" class="center"><spring:message code="click.safety"/></th>
										</tr>
									</thead>
									<tbody class="craneList">                                
										
									</tbody>
									</table>
								</div>
								<!--tc 테이블 끝-->
								<!--순간풍속 판넬 시작-->
								<ul class="tc-flag-area" style="position:fixed;margin-left:200px;">
								</ul>
								<!--순간풍속 판넬 끝-->
								<canvas id="mycanvas4" style="background-color:#F0F0F0;">
								</canvas>
							</div>
						</dd>
					</dl>
					<!--4X2-06 CCTV 현황 섹션-->
					<!-- <dl class="atype-section03 atype-3-2-01 btype_4_2 a-4-2-cctvState" style="display: none;"> -->
					<dl class="a-4-2-cctvState" style="display: none;">
						<dt class="clickTitle">
							<spring:message code='click.cctv.status'/>
							<em class="paging cctv_paging"></em>
						</dt>
						<dd class="envi-chart-area">
							<div class="cctv-wrap ml20">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger5 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger5 atype-1-1-cctv-h live_img" style="height:400px;padding-right:0px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon6" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger5 atype-1-1-cctv-h" style="height:400px;padding-right:0px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
							<div class="cctv-wrap">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger5 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger5 atype-1-1-cctv-h live_img" style="height:400px;padding-right:0px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon7" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger5 atype-1-1-cctv-h" style="height:400px;padding-right:0px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
						</dd>
					</dl>
					
					<!--4X3-01 위치 관제 현황 섹션-->
					<dl class="c-4-3-locationMap" style="display: none;" id="c-4-3-locationMap atype-section03 atype-1-1-01 btype_4_2 ctype_4_3">
						<dt class="clickTitle"><spring:message code='click.location.control.status'/></dt>
						<dd>
							<div class="content-box rocation-map-area ctype-map">
								<ul class="controll-kind-wrap" style="position:fixed;">
								</ul>
								<canvas id="mycanvas5" style="background-color:#F0F0F0;">
								</canvas>
							</div>
						</dd>
					</dl>
					<!--4X3-02 근로자 근무 현황 섹션-->
					<dl class="c-4-3-location" style="display: none;" id="c-4-3-location atype-section03 atype-3-2-01 btype_4_2 ctype_4_3">
						<dt class="clickTitle"><spring:message code="click.worker.status"/></dt>
						<dd class="float-l pr0 w-full">
							<h4><spring:message code="click.real.time.control.status"/></h4>
							<span class="worker-state">
								<spring:message code="click.real.time.number.workers"/>
								<div class="state-num">
									<strong class="blue worker_count" id="">3</strong>
									<strong class="unit"><spring:message code='click.workers'/></strong>
								</div>
							</span>
							
							<div class="work-chart-wrap3">
								<!--차트 들어오는곳-->
							</div>
						</dd>
						<dd class="cctv">
							<h4><spring:message code="click.status.by.company"/></h4>
							<div class="work-chart-wrap">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--4X3-03 가스관제현황 섹션-->
					<dl class="c-4-3-gasMonitoring atype-section03 atype-3-2-01 ctype_4_3" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.gas.control.status"/></dt>
						<dd class="gas-state-wrap pt30">
							<div class="ctype-gas-state-wrap">
								<span class="gas-state"><spring:message code="click.gas.detector"/></span>
								<div class="state-num">
									<strong class="unit-title align01"><spring:message code="click.total"/></strong>
									<strong class="blue gasDeviceCount" id="">-</strong>
									<strong class="unit"><spring:message code='click.equip.units'/></strong>
								</div>
							</div>
							
							<div class="navigation-wrap">
								<ul class="box-distribution gasButtonArea">
								</ul>
							</div>
						</dd>
						<dd class="gas-graph-area-width cb">
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.oxygen"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange1">0</em>%)</span>
								</li>
								<li class="graph-wrap gas-graph-wrap1">
									<!--그래프영역 입니다-->
								</li>
								<li class="state-bg-wrap gasStatusArea1">
									<span class="redBg"><spring:message code="click.danger"/></span>
									<!--<span class="greenBg">안전</span>-->
									<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
								</li>
								<li class="date gasStatusDate1">-</li>
								
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.carbon.monoxide"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange2">0</em>ppm <spring:message code="click.less.than"/>)</span>
								</li>
								<li class="graph-wrap gas-graph-wrap2">
									<!--그래프영역 입니다-->
								</li>
								<li class="state-bg-wrap gasStatusArea2">
									<span class="redBg"><spring:message code="click.danger"/></span>
									<!--<span class="greenBg">안전</span>-->
									<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
								</li>
								<li class="date gasStatusDate2">-</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.hydrogen"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange3">0</em>ppm <spring:message code="click.less.than"/>)</span>
								</li>
								<li class="graph-wrap gas-graph-wrap3">
									<!--그래프영역 입니다-->
								</li>
								<li class="state-bg-wrap gasStatusArea3">
									<!--<span class="redBg">위험</span>-->
									<span class="greenBg"><spring:message code="click.safety"/></span>
									<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
								</li>
								<li class="date gasStatusDate3">-</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.methane"/></span>
									<span class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange4">0</em>% <spring:message code="click.less.than"/>)</span>
								</li>
								<li class="graph-wrap gas-graph-wrap4">
									<!--그래프영역 입니다-->
								</li>
								<li class="state-bg-wrap gasStatusArea4">
									<!--<span class="redBg">위험</span>-->
									<!--<span class="greenBg">안전</span>-->
									<span class="errorBg"><spring:message code="click.error"/></span>
								</li>
								<li class="date gasStatusDate4">-</li>
							</ul>
						</dd>
					</dl>
					<!--4X3-04 굴진현황 섹션-->
					<dl class="c-4-3-tunnel" style="display: none;">
						<dt class="clickTitle">
							<spring:message code="click.process.excavation.rate.status"/>
							<em class="paging diggingPage2"></em>
						</dt>
						<dd class="work-chart-area">
							<h4><spring:message code="click.process.rate"/></h4>
							<div class="work-plan-div">
								<strong><spring:message code="click.plan"/></strong>
								<p class="digthrough_process_target"></p>
							</div>
							<div class="work-gap-div">
								<span><spring:message code="click.gap"/></span>
								<span class="digthrough_process_diff"></span>
							</div>
							<div class="work-finish-div">
								<strong <c:if test="${locale == 'en'}">style="font-size:0.9rem;"</c:if>><spring:message code="click.performance"/></strong>
								<p class="digthrough_process_ing"></p>
							</div>
						</dd>
						<dd class="ctype-gas-graph-wrap">
							<div class="gas-board-wrap">
								<span class="gas-num tunnelName"></span>
								
								<div class="float-r">
									<strong class="unit-title"><spring:message code="click.excavation.rate"/></strong>
									<strong class="blue diggingPercent" id="">30</strong>
									<strong class="unit">%</strong>
								</div>
							</div>
							<div class="work-graph-wrap1" style="width:calc(30% - 30px);float:left;">
								<!--차트 들어오는곳-->
							</div>
							<div class="work-graph-wrap2" style="width:69%;float:left;">
								<!--차트 들어오는곳-->
							</div>
						</dd>
						<dd class="tunnel-wrap">
							<em class="paging diggingPage"></em>
							<div class="tunnel-position-wrap1">
								<ul class="pos01">
									<li><spring:message code="click.starting.part"/></li>
									<li class="line dashboard"></li>
								</ul>
							</div>
							<div class="tunnel-position-wrap6">
								<ul class="pos05">
									<li><spring:message code="click.end.point"/></li>
									<li class="line dashboard"></li>
								</ul>
							</div>
							<div class="tunnel-progress-area" id="graphAreaC">
								<!--굴진률 그래프 끝-->
							</div>	
							<div class="markingArea">
								<div style="width:100%;color:#999;" id="graphMarkingC">
									
								</div>
							</div>
							<div class="markingValueArea">
								<div style="width:100%;color:#999;margin-left:0.8%;font-size:10px;" id="graphMarkingValueC">
									
								</div>
							</div>
							<!--  
							<ul class="section-paging-rolling2">
							</ul>
							-->
						</dd>
					</dl>
					<!--4X3-05 T/C 현황 섹션-->
					<dl class="c-4-3-towerCraneProcess" style="display: none;" id="atype-section03 atype-1-1-01 btype_4_2 ctype_4_3">
						<dt class="clickTitle"><spring:message code="click.tc.status"/></dt>
						<dd>
							<div class="content-box rocation-map-area2 ctype-map">
								<!--tc 테이블-->
								<div class="table-small mb20 font14" style="position:fixed;">
									<table>
									<caption><span class="blind">TC안전 신호등 테이블</span></caption>
									<colgroup class="">
										<col width="<spring:message code="click.signal.light"/>">
										<col width="40%">
									</colgroup>
									<thead class="">
										<tr>
											<th scope="col" class="center">T/C</th>
											<th scope="col" class="center"><spring:message code="click.safety"/></th>
										</tr>
									</thead>
									<tbody class="craneList">                                
										
									</tbody>
									</table>
								</div>
								<!--tc 테이블 끝-->
								<!--순간풍속 판넬 시작-->
								<ul class="tc-flag-area" style="position:fixed;margin-left:200px;">
								</ul>
								<!--순간풍속 판넬 끝-->
								<canvas id="mycanvas7" style="background-color:#F0F0F0;">
								</canvas>
							</div>
						</dd>
					</dl>
					<!--4X3-06 CCTV 현황 섹션-->
					<dl class="atype-section03 atype-3-2-01 btype_4_2 ctype_4_3 a-4-3-cctvState" style="display: none;">
					<!-- <dl class="a-4-3-cctvState" style="display: none;" id="atype-section03 atype-3-2-01 btype_4_2 ctype_4_3"> -->
						<dt class="clickTitle">
							<spring:message code='click.cctv.status'/>
							<em class="paging cctv_paging"></em>
						</dt>
						<dd class="envi-chart-area">
							<div class="cctv-wrap">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area1" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger6 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger6 atype-1-1-cctv-h live_img" style="height:300px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon8" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger6 atype-1-1-cctv-h" style="height:300px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
						</dd>
						<dd class="envi-chart-area">
							<div class="cctv-wrap ml20">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area2" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger6 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger6 atype-1-1-cctv-h live_img" style="height:300px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon9" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger6 atype-1-1-cctv-h" style="height:300px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
						</dd>
						<dd class="envi-chart-area">
							<div class="cctv-wrap">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area3" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger6 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger6 atype-1-1-cctv-h live_img" style="height:300px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon10" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger6 atype-1-1-cctv-h" style="height:300px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
						</dd>
						<dd class="envi-chart-area">
							<div class="cctv-wrap ml20">
								<!--차트 들어오는곳-->
								<section id="slc_cctv_area4" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger6 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger6 atype-1-1-cctv-h live_img" style="height:300px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" id="WebMon11" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger6 atype-1-1-cctv-h" style="height:300px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
						</dd>
					</dl>
					
					<!--2.5X3 좌측섹션-01 위치 관제 현황 섹션-->
					<dl class="d-2-3-locationMap" style="display: none;" id="d-2-3-locationMap atype-1-1-01 dtype-a mr10">
						<dt class="clickTitle"><spring:message code="click.location.control.status"/></dt>
						<dd class="worker">
							<div class="board-wrap">
								<span class="worker-state"><spring:message code="click.real.time.number.workers"/> :</span>
								<div class="float-r">
									<strong class="blue worker_count" id="">-</strong>
									<strong class="unit"><spring:message code='click.workers'/></strong>
								</div>
							</div>
							
							<ul class="state-wrap">
								<h5><spring:message code="click.day.event.status"/></h5>
								<li>
									<span><spring:message code="click.emergency.call"/> :</span>
									<div class="float-r">
										<strong class="blue locationEventCount" id="">-</strong>
										<strong class="unit"><spring:message code='click.counts'/></strong>
									</div>
								</li>
							</ul>
						</dd>
						<dd class="work-chart">
							<div class="work-chart-wrap">
								<!--차트 들어오는곳-->
							</div>
						</dd>

						<dd class="cb">
							<div class="content-box rocation-map-area" style="height:440px;">
								<ul class="controll-kind-wrap" style="position:fixed;">
								</ul>
								<canvas id="mycanvas6" style="background-color:#F0F0F0;">
								</canvas>
							</div>
						</dd>
					</dl>
					<!--2.5X3 좌측섹션-02 공정율 현황-->
					<dl class="d-2-3-tunnel" id="dtype-a mr10" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.process.rate.status"/></dt>
						<dd class="ml21per">
							<div class="work-plan-div">
								<strong><spring:message code="click.plan"/></strong>
								<p class="digthrough_process_target"></p>
							</div>
							<div class="work-gap-div">
								<span><spring:message code="click.gap"/></span>
								<span class="digthrough_process_diff"></span>
							</div>
							<div class="work-finish-div">
								<strong <c:if test="${locale == 'en'}">style="font-size:0.9rem;"</c:if>><spring:message code="click.performance"/></strong>
								<p class="digthrough_process_ing"></p>
							</div>
						</dd>

						<dt class="cb" style="padding-top: 48px;">
							<spring:message code="click.tunnel.drilling.status"/>
							<em class="paging diggingPage"></em>
						</dt>
						<dd class="work-graph-area">
							<div class="gas-board-wrap">
								<span class="gas-num tunnelName"><spring:message code="click.the.up.line"/></span>
								
								<div class="float-r">
									<strong class="unit-title align01"><spring:message code="click.excavation.rate"/></strong>
									<strong class="blue diggingPercent" id="">30</strong>
									<strong class="unit">%</strong>
								</div>
							</div>
							<div class="work-graph-wrap1">
								<!--차트 들어오는곳-->
							</div>
						</dd>
					</dl>
					<!--2.5X3 CCTV 현황-->
					<dl class="d-2-3-cctvState" id="dtype-a mr10" style="display: none;">
						<dt class="clickTitle"><spring:message code="click.cctv.status"/></dt>
						<dd class="cctv-state-wrap" style="height:130px;">
							<strong><spring:message code="click.day.event.status"/></strong>
							<table class="cctv-state-table ml20">
								<thead>
									<tr>
										<th class="helmet-state"><spring:message code="click.not.wearing.safety.helmet"/></th>
									</tr>
								</thead>
								<tbody>
									<tr class="">
										<td>
											<i class="helmet-state">안전모이미지</i>
											<strong class="blue" id="EVT000019">0</strong>
											<span><spring:message code='click.counts'/></span>
										</td>
									</tr>
								</tbody>
							</table>
							<table class="cctv-state-table ml10">
								<thead>
									<tr>
										<th class="helmet-state"><spring:message code="click.not.wearing.safety.vest"/></th>
									</tr>
								</thead>
								<tbody>
									<tr class="">
										<td>
											<i class="padding-state">안전조끼이미지</i>
											<strong class="blue" id="EVT000020">0</strong>
											<span><spring:message code='click.counts'/></span>
										</td>
									</tr>
								</tbody>
							</table>
						</dd>
						<dd class="cctv-navigation-wrap">
							<ul class="box-distribution cctbBoxList">
								<!-- <li><span>1번</span></li> -->
							</ul>
						</dd>
						<dd class="cctv-view-area">
							<div>
								<!-- CCTV 들어오는곳 -->
								<section id="slc_cctv_area" class="cctv-area" style="display: block;">
									<ul class="cctv-wrap05">
										<li>
											<div class="cctv-view-biger7 live_blank_img" style="display:none">
			                           			<img src="${pageContext.request.contextPath}/resources/img/no-cctv.jpg" alt="">
			                        		</div>
											<div class="cctv-view-biger7 atype-1-1-cctv-h live_img" style="height:420px;width:100%;margin-left:0px;">
												<c:if test="${parameterVO.os_version == '1'}">
													<OBJECT width="100%" height="100%" name="WebMon12" classid="CLSID:96D9AC2E-D8ED-4AE1-ABFD-7D7B2EB462E3" codebase="${pageContext.request.contextPath}/resources/exe/setup.exe#version=1,0,0,83" onerror="webmon_ctrl=false;">
														<PARAM NAME="_Version" VALUE="65536">
														<PARAM NAME="_ExtentX" VALUE="0">
														<PARAM NAME="_ExtentY" VALUE="0">
														<PARAM NAME="_StockProps" VALUE="0">
													</OBJECT>
												</c:if>
												<c:if test="${parameterVO.os_version != '1'}">
												<section id="slcFlow01">
													<ul>
														<li>
															<div class="cctv-view-biger7 atype-1-1-cctv-h" style="height:420px;width:100%;margin-left:0px;">
																<object width="100%" height="100%" data="${pageContext.request.contextPath}/resources/swf/flowplayer-3.2.18.swf" type="application/x-shockwave-flash">
																	<param name="allowfullscreen" value="true">
																	<param name="allowscriptaccess" value="always">
																	<param name="quality" value="high">
																	<param name="bgcolor" value="#000000">
																	<param name="flashvars" value="">
																</object> 
															</div>
														</li>
													</ul>
												</section>
												</c:if>
											</div>
										</li>
									</ul>
								</section>
							</div>
						</dd>
					</dl>
					<!--2.5X3 좌측섹션-03 T/C 현황-->
					<dl class="d-2-3-towerCraneProcess" style="display: none;" id="dtype-a mr10">
						<dt class="clickTitle">
							<spring:message code="click.tc.status"/>
							<em class="paging cranePaging"></em>
						</dt>
						<dd class="tc-board-wrap">
							<div class="tc-wrap">
								<div class="state-num">
									<span class="gas-state"><spring:message code="click.tower.crane"/></span>
									<strong class="unit-title align02"><spring:message code="click.total"/></strong>
									<strong class="blue towerCraneCount" id="">0</strong>
									<strong class="unit"><spring:message code='click.equip.units'/></strong>
								</div>
								<div class="tcArea">
									
								</div>
							</div>
							<c:if test="${locale == 'en'}">
								<div class="today-tc-event-wrap" style="margin-bottom:20px;">
									<ul>
										<li style="line-height:22px;">
											<strong><spring:message code="click.day.event.status"/></strong>
										</li>
										<li style="line-height:22px;">
											<span class="mr5"><spring:message code="click.tc.collision.risk"/> : </span>
											<span class="num-blue event0">0</span>
											<span><spring:message code='click.counts'/></span>
										</li>
										<li style="line-height:22px;">
											<span class="mr5"><spring:message code="click.tc.out.of.range"/> : </span>
											<span class="num-blue event1">0</span>
											<span><spring:message code='click.counts'/></span>
										</li>
										<li style="line-height:22px;">
											<span class="mr5"><spring:message code="click.tc.sensorconnection.failure"/> : </span>
											<span class="num-blue event2">0</span>
											<span><spring:message code='click.counts'/></span>
										</li>
										<li style="line-height:22px;">
											<span class="mr5"><spring:message code="click.tc.wind.speed.attention.danger"/> : </span>
											<span class="num-blue event3">0</span>
											<span><spring:message code='click.counts'/></span>
										</li>
									</ul>
								</div>
							</c:if>
							<c:if test="${locale == 'ko_kr'}">
								<div class="today-tc-event-wrap" style="margin-bottom:20px;">
									<ul>
										<li>
											<strong><spring:message code="click.day.event.status"/></strong>
										</li>
										<li>
											<span class="mr5"><spring:message code="click.tc.collision.risk"/> : </span>
											<span class="num-blue event0">0</span>
											<span><spring:message code='click.counts'/></span>
										</li>
										<li>
											<span class="mr5"><spring:message code="click.tc.out.of.range"/> : </span>
											<span class="num-blue event1">0</span>
											<span><spring:message code='click.counts'/></span>
										</li>
										<li>
											<span class="mr5"><spring:message code="click.tc.sensorconnection.failure"/> : </span>
											<span class="num-blue event2">0</span>
											<span><spring:message code='click.counts'/></span>
										</li>
										<li>
											<span class="mr5"><spring:message code="click.tc.wind.speed.attention.danger"/> : </span>
											<span class="num-blue event3">0</span>
											<span><spring:message code='click.counts'/></span>
										</li>
									</ul>
								</div>
							</c:if>
							<div class="content-box rocation-map-area2 dtype-map">
								<!--tc 테이블-->
								<div class="table-small mb20 font14" style="position:fixed;top:450px;">
									<table>
									<caption><span class="blind">TC안전 신호등 테이블</span></caption>
									<colgroup class="">
										<col width="60%">
										<col width="40%">
									</colgroup>
									<thead class="">
										<tr>
											<th scope="col" class="center">T/C</th>
											<th scope="col" class="center"><spring:message code="click.safety"/></th>
										</tr>
									</thead>
									<tbody class="craneList">                                
										
									</tbody>
									</table>
								</div>
								<!--tc 테이블 끝-->
								<!--순간풍속 판넬 시작-->
								<ul class="tc-flag-area" style="position:fixed;margin-left:200px;line-height:40px;top:450px;">
								</ul>
								<!--순간풍속 판넬 끝-->
								<canvas id="mycanvas8" style="background-color:#F0F0F0;">
								</canvas>
							</div>
						</dd>
					</dl>
					<!--2.5X3 좌측섹션-04 환경센서 현황-->
					<!-- <dl class="dtype-a mr10 a-2-5-3-iotSensor" style="display: none;"> -->
					<dl class="a-2-5-3-iotSensor" style="display: none;">
						<dt class="clickTitle"><spring:message code='click.environmental.sensor.status'/></dt>
						<dd class="eq eq-dtype ml20">
							<h4><spring:message code="click.weather.sensor"/></h4>
							<dl class="data-table-wrap2">
								<c:if test="${locale == 'en'}">
									<dt style="line-height:25px;"><spring:message code="click.temperature.humidity"/></dt>
								</c:if>
								<c:if test="${locale == 'ko_kr'}">
									<dt><spring:message code="click.temperature.humidity"/></dt>
								</c:if>
								<dd class="">
									<span class="greenTxt weatherTemperature" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span style="display:inline-block; width:15px;">℃</span>
									<span class="slash-padding" style="display:inline-block; width:2px;"> / </span>
									<span class="greenTxt weatherHumidity" style="display:inline-block; width:60px; text-align:right;">0</span>
									<span>%</span>
								</dd>
							</dl>
							<dl class="data-table-wrap2">
								<dt><spring:message code="click.rainfall"/></dt>
								<dd class="">
									<span class="greenTxt weatherRainsinceonetime" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span>mm</span>
								</dd>
							</dl>
							<dl class="data-table-wrap2">
								<c:if test="${locale == 'en'}">
									<dt style="line-height:25px;"><spring:message code="click.wind.speed.wind.direction"/></dt>
								</c:if>
								<c:if test="${locale == 'ko_kr'}">
									<dt><spring:message code="click.wind.speed.wind.direction"/></dt>
								</c:if>
								<dd class="">
									<span class="greenTxt weatherWindwspd" style="display:inline-block; width:70px; text-align:right;">0</span>
									<span>m/s (<em class="weatherWindwdirname"></em>)</span>
								</dd>
							</dl>
							<dl class="state-bg-wrap">
								<em class="weatherAlaram greenBg"><spring:message code="click.safety"/></em>
								<!-- <em class="redBg">위험</em> -->
								<!-- <em class="errorBg"><spring:message code="click.error"/></em> -->
							</dl>
						</dd>
						<dd class="eq ml20">
							<h4><spring:message code="click.fine.dust.sensor"/></h4>
							<!-- <div class="eq-chart-wrap"> -->
							<div class="envi-chart-wrap2">
								<!--차트 들어오는곳-->
							</div>
							<dl class="state-bg-wrap">
								<em class="greenBg"><spring:message code="click.safety"/></em>
								<!-- <em class="redBg">위험</em> -->
								<!-- <em class="errorBg"><spring:message code="click.error"/></em> -->
							</dl>
						</dd>
						<dd class="eq ml20 cb">
							<h4><spring:message code="click.noise.sensor"/></h4>
							<!-- <div class="eq-chart-wrap"> -->
							<div class="envi-chart-wrap1">
								<!--차트 들어오는곳-->
							</div>
							<dl class="state-bg-wrap">
								<em class="greenBg"><spring:message code="click.danger"/></em>
								<!-- <em class="redBg">위험</em> -->
								<!-- <em class="errorBg"><spring:message code="click.error"/></em> -->
							</dl>
						</dd>
						<dd class="eq ml20">
							<h4><spring:message code="click.vibration.sensor"/></h4>
							<!-- <div class="eq-chart-wrap"> -->
							<div class="envi-chart-wrap1">
								<!--차트 들어오는곳-->
							</div>
							<dl class="state-bg-wrap">
								<em class="greenBg"><spring:message code="click.safety"/></em>
								<!-- <em class="redBg">위험</em> -->
								<!-- <em class="errorBg"><spring:message code="click.error"/></em> -->
							</dl>
						</dd>
					</dl>					
					<!--2.5X3 좌측섹션-05 흙막이 장치 현황 5개일때-->
					<dl class="d-2-3-retain" style="display: none;" id="d-2-3-retain dtype-a mr10">
						
					</dl>
					<!--2.5X3 우측섹션-01 가스관제 현황 섹션-->
					<dl class="d-2-3-gasMonitoring" style="display: none;" id="d-2-3-gasMonitoring dtype-a ml10">
						<dt class="clickTitle"><spring:message code="click.gas.status"/></dt>
						<dd class="gas-state-wrap">
							<div class="ctype-gas-state-wrap">
								<span class="gas-state"><spring:message code="click.gas.detector"/></span>
								<div class="state-num">
									<strong class="unit-title align01"><spring:message code="click.total"/></strong>
									<strong class="blue gasDeviceCount" id="">-</strong>
									<strong class="unit"><spring:message code='click.equip.units'/></strong>
								</div>
							</div>
							<div class="navigation-wrap" style="width:calc(50% - 20px);">
								<ul class="box-distribution gasButtonArea">
									<li><spring:message code="click.no" arguments="1"/></li>
									<li><spring:message code="click.no" arguments="2"/></li>
									<li><spring:message code="click.no" arguments="3"/></li>
									<li><spring:message code="click.no" arguments="4"/></li>
									<li><spring:message code="click.no" arguments="5"/></li>
									<li><spring:message code="click.no" arguments="6"/></li>
									<li><spring:message code="click.no" arguments="7"/></li>
									<li><spring:message code="click.no" arguments="8"/></li>
								</ul>
							</div>
						</dd>
						<dd class="gas-graph-area-width cb">
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.oxygen"/></span>
									<p class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange1">0</em>%)</p>
									<div class="state-bg-wrap gasStatusArea1">
										<span class="redBg"><spring:message code="click.danger"/></span>
										<!--<span class="greenBg">안전</span>-->
										<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
									</div>
									<span class="date gasStatusDate1">-</span>
								</li>
								<li class="graph-wrap gas-graph-wrap1">
									<!--그래프영역 입니다-->
								</li>
								
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.carbon.monoxide"/></span>
									<p class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange2">0</em>ppm <spring:message code="click.less.than"/>)</p>
									<div class="state-bg-wrap gasStatusArea2">
										<span class="redBg"><spring:message code="click.danger"/></span>
										<!--<span class="greenBg">안전</span>-->
										<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
									</div>
									<span class="date gasStatusDate2">-</span>
								</li>
								<li class="graph-wrap gas-graph-wrap2">
									<!--그래프영역 입니다-->
								</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.hydrogen"/></span>
									<p class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange3">0</em>ppm <spring:message code="click.less.than"/>)</p>
									<div class="state-bg-wrap gasStatusArea3">
										<!-- <span class="redBg">위험</span> -->
										<span class="greenBg"><spring:message code="click.safety"/></span>
										<!--<span class="errorBg"><spring:message code="click.error"/></span>-->
									</div>
									<span class="date gasStatusDate3">-</span>
								</li>
								<li class="graph-wrap gas-graph-wrap3">
									<!--그래프영역 입니다-->
								</li>
							</ul>
							<ul class="gas-graph-area">
								<li>
									<span class="clickTitle"><spring:message code="click.methane"/></span>
									<p class="state">(<spring:message code="click.safety.range"/>:<em class="gasRange4">0</em>% <spring:message code="click.less.than"/>)</p>
									<div class="state-bg-wrap gasStatusArea4">
										<!-- <span class="redBg">위험</span> -->
										<!--<span class="greenBg">안전</span>-->
										<span class="errorBg"><spring:message code="click.error"/></span>
									</div>
									<span class="date gasStatusDate4">-</span>
								</li>
								<li class="graph-wrap gas-graph-wrap4">
									<!--그래프영역 입니다-->
								</li>
							</ul>
						</dd>
					</dl>
					<dl class="d-2-3-equip" style="display: none;" id="d-2-3-equip dtype-a ml10">
						<dt class="clickTitle"><spring:message code="click.equipment.crush.status"/></dt>
						<dd class="gas-state-wrap">
							<div class="ctype-gas-state-wrap">
								<span style="text-align: center;font-size: 1.5rem;font-weight: 800;color: #999;"><spring:message code="click.crush.ap"/></span>
								<div class="state-num">
									<strong class="unit-title align01"><spring:message code="click.total"/></strong>
									<strong class="blue equipTotal" id="">-</strong>
									<strong class="unit"><spring:message code='click.equip.units'/></strong>
								</div>
							</div>
							<div class="navigation-wrap" style="width:calc(50% - 20px);">
								<ul class="state-wrap">
									<h5><spring:message code="click.day.event.status"/></h5>
									<li style="height:14px!important;">
										<span><spring:message code="click.zone.invasion"/> :</span>
										<div class="float-r">
											<strong class="blue equipEvent1" id="">0</strong>
											<strong class="unit"><spring:message code='click.counts'/></strong>
										</div>
									</li>
									<li>&nbsp;</li>
									<li style="height:14px!important;">
										<span><spring:message code="click.communication.failure"/> :</span>
										<div class="float-r">
											<strong class="blue equipEvent2" id="">0</strong>
											<strong class="unit"><spring:message code='click.counts'/></strong>
										</div>
									</li>
								</ul>
							</div>
						</dd>
						<dd class="gas-graph-area-width cb">
							<div class="atype-3-1-01 d-2-3-equipList">
							</div>
						</dd>
					</dl>

			</div>
			<!-- 본문 영역 끝 -->