<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Stack admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities.">
    <meta name="keywords" content="admin template, stack admin template, dashboard template, flat admin template, responsive admin template, web app">
    <meta name="author" content="PIXINVENT">
    <title>ONION BOX</title>
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/apple-icon-120.png">
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i%7COpen+Sans:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/plugins/forms/validation/form-validation.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/selects/select2.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/pickers/pickadate/pickadate.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/katex.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/monokai-sublime.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/quill.snow.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/quill.bubble.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/ui/plyr.min.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/components.css">
    <!-- END: Theme CSS-->

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/pages/property.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/editor.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/jquery.minicolors.css">
    
    <!-- END: Custom CSS-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/Winwheel.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/roulette.css">
    <style>
  	
  </style>
  
  <script type="text/javascript">
  
  	var docType = "P";
	var areaTotalId = 1;
	
	function fn_openPopup(){
		openDefaultPopup("gamePopup", 'dddd');
	}
	
	function openDefaultPopup(popupName, popupText){
		$.ajax({
			url : "/click/popup/"+popupName,
			type : "POST",
			success : function(result) {
				$("#alertPopupWrap").html(result);
				$("#alertPopupWrap").css("display", "block");
			}
		});
	}
	
	function fn_closePopupThis(){
		$("#alertPopupWrap").html("");
		$("#alertPopupWrap").css("display", "none");
	}
	
	function fn_selectRoulette(){
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "/click/roulettePopup",
			data: params,
			type : "POST",
			success : function(result) {
				$("#alertPopupWrap").html(result);
			}
		});
	}
	
	function fn_selectQuiz(){
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "/click/quizPopup",
			data: params,
			type : "POST",
			success : function(result) {
				$("#alertPopupWrap").html(result);
			}
		});
	}
	
	function fn_selectRouletteDetail(gameId){
		$.ajax({
			url : "/click/selectGameDetail.json?game_id="+gameId,
			type : "POST",
			success : function(result) {
				console.log("gameID : "+result.gameVO.game_id);
				
				var areaBoxContentsId = $("#areaBoxContentsId").val();
				var areaBoxId = $("#areaBoxId").val();
				
				var htmlString = '<div class="rouletteArea">'+
									'<input type="hidden" class="gameNumber" value="'+result.gameVO.game_count+'"/>'+
									'<input type="hidden" class="rouletteColor1" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor2" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor3" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor4" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor5" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor6" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor7" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor8" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="roulettePercent1" value="'+result.gameVO.game_percent_1+'"/>'+
									'<input type="hidden" class="roulettePercent2" value="'+result.gameVO.game_percent_2+'"/>'+
									'<input type="hidden" class="roulettePercent3" value="'+result.gameVO.game_percent_3+'"/>'+
									'<input type="hidden" class="roulettePercent4" value="'+result.gameVO.game_percent_4+'"/>'+
									'<input type="hidden" class="roulettePercent5" value="'+result.gameVO.game_percent_5+'"/>'+
									'<input type="hidden" class="roulettePercent6" value="'+result.gameVO.game_percent_6+'"/>'+
									'<input type="hidden" class="roulettePercent7" value="'+result.gameVO.game_percent_7+'"/>'+
									'<input type="hidden" class="roulettePercent8" value="'+result.gameVO.game_percent_8+'"/>'+
									'<input type="hidden" class="rouletteValue1" value="'+result.gameVO.game_text_1+'"/>'+
									'<input type="hidden" class="rouletteValue2" value="'+result.gameVO.game_text_2+'"/>'+
									'<input type="hidden" class="rouletteValue3" value="'+result.gameVO.game_text_3+'"/>'+
									'<input type="hidden" class="rouletteValue4" value="'+result.gameVO.game_text_4+'"/>'+
									'<input type="hidden" class="rouletteValue5" value="'+result.gameVO.game_text_5+'"/>'+
									'<input type="hidden" class="rouletteValue6" value="'+result.gameVO.game_text_6+'"/>'+
									'<input type="hidden" class="rouletteValue7" value="'+result.gameVO.game_text_7+'"/>'+
									'<input type="hidden" class="rouletteValue8" value="'+result.gameVO.game_text_8+'"/>'+
									'<div class="spinBtn" data="'+areaBoxContentsId+'">GO</div>'+
									'<table cellpadding="0" cellspacing="0" border="0" class="rouletteTable">'+
						                '<tr>'+
						                    '<td width="438" height="438" class="the_wheel" align="center" valign="center">'+
						                        '<canvas id="canvas'+areaBoxContentsId+'" width="434" height="434">'+
						                            '<p style="{color: white}" align="center">Sorry, your browser does not support canvas. Please try another.</p>'+
						                        '</canvas>'+
						                    '</td>'+
						                '</tr>'+
						            '</table>'+
						        '</div>';
					            
					$("#"+areaBoxContentsId).html(htmlString);
					
					$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
					})
					$("#gameSettingArea").removeClass("hiddenObj");
					
					todoNewTasksidebar.addClass('show');
					$("#"+areaBoxContentsId).attr("data", "game");
					
					$("#"+areaBoxId).find(".areaTitle").remove();
					fn_set(areaBoxContentsId);
					fn_closePopupThis();
					fn_settingGame(areaBoxContentsId);
			}
		});
	}
	
	function fn_selectQuizDetail(quizId){
		$.ajax({
			url : "/click/selectQuizDetail.json?quiz_id="+quizId,
			type : "POST",
			success : function(result) {
				
				var areaBoxContentsId = $("#areaBoxContentsId").val();
				var areaBoxId = $("#areaBoxId").val();
				
				if("M" == result.quizVO.quiz_type){
					var checkAnswerPoint1 = "feather fa-check";
					var checkAnswerPoint2 = "feather fa-check";
					var checkAnswerPoint3 = "feather fa-check";
					var checkAnswerPoint4 = "feather fa-check";
					var checkAnswerPoint5 = "feather fa-check";
					if(result.quizVO.quiz_answer_1 == "1"){
						checkAnswerPoint1 = "fa fa-check";
					}
					if(result.quizVO.quiz_answer_2 == "1"){
						checkAnswerPoint2 = "fa fa-check";
					}
					if(result.quizVO.quiz_answer_3 == "1"){
						checkAnswerPoint3 = "fa fa-check";
					}
					if(result.quizVO.quiz_answer_4 == "1"){
						checkAnswerPoint4 = "fa fa-check";
					}
					if(result.quizVO.quiz_answer_5 == "1"){
						checkAnswerPoint5 = "fa fa-check";
					}
					
					let wheelNumber = parseInt(result.quizVO.quiz_count);
					
					let htmlString4 = '';
		        	for(let i=0;i<wheelNumber;i++){
		        		if(i==0){
		        			htmlString4 += '<div class="quizAnswerArea" style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:20px;border:1px solid #00dfc4;"><i class="'+checkAnswerPoint1+'"></i>&nbsp;'+result.quizVO.quiz_text_1+'</div>';
		        		}else if(i==1){
		        			htmlString4 += '<div class="quizAnswerArea" style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="'+checkAnswerPoint2+'"></i>&nbsp;'+result.quizVO.quiz_text_2+'</div>';
		        		}else if(i==2){
		        			htmlString4 += '<div class="quizAnswerArea" style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="'+checkAnswerPoint3+'"></i>&nbsp;'+result.quizVO.quiz_text_3+'</div>';
		        		}else if(i==3){
		        			htmlString4 += '<div class="quizAnswerArea" style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="'+checkAnswerPoint4+'"></i>&nbsp;'+result.quizVO.quiz_text_4+'</div>';
		        		}else if(i==4){
		        			htmlString4 += '<div class="quizAnswerArea" style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="'+checkAnswerPoint5+'"></i>&nbsp;'+result.quizVO.quiz_text_5+'</div>';
		        		}
		        	}
					
					var htmlString3 = '<div class="quizArea" style="padding:20px;">'+
										'<input type="hidden" class="quizType" value="'+result.quizVO.quiz_type+'"/>'+
										'<input type="hidden" class="quiz_count" value="'+result.quizVO.quiz_count+'"/>'+
										'<input type="hidden" class="quiz_answer_count" value="'+result.quizVO.quiz_answer_count+'"/>'+
										'<input type="hidden" class="quizAnswer1" value="'+result.quizVO.quiz_answer_1+'"/>'+
										'<input type="hidden" class="quizAnswer2" value="'+result.quizVO.quiz_answer_2+'"/>'+
										'<input type="hidden" class="quizAnswer3" value="'+result.quizVO.quiz_answer_3+'"/>'+
										'<input type="hidden" class="quizAnswer4" value="'+result.quizVO.quiz_answer_4+'"/>'+
										'<input type="hidden" class="quizAnswer5" value="'+result.quizVO.quiz_answer_5+'"/>'+
										'<input type="hidden" class="quizText1" value="'+result.quizVO.quiz_text_1+'"/>'+
										'<input type="hidden" class="quizText2" value="'+result.quizVO.quiz_text_2+'"/>'+
										'<input type="hidden" class="quizText3" value="'+result.quizVO.quiz_text_3+'"/>'+
										'<input type="hidden" class="quizText4" value="'+result.quizVO.quiz_text_4+'"/>'+
										'<input type="hidden" class="quizText5" value="'+result.quizVO.quiz_text_5+'"/>'+
										'<input type="hidden" class="quizColor1" value="rgba(29, 43, 58, 1)"/>'+
										'<input type="hidden" class="quizFontColor1" value="rgba(255, 255, 255, 1)"/>'+
										'<input type="hidden" class="quizColor2" value="rgba(255, 255, 255, 1)"/>'+
										'<input type="hidden" class="quizFontColor2" value="rgba(29, 43, 58, 1)"/>'+
										'<div class="quizNameArea" style="border-radius:20px;width:90%;color:white;background-color:var(--main-bg-color);margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;">Q. '+result.quizVO.quiz_name+'</div>'+
										htmlString4+
							        '</div>';
						            
						$("#"+areaBoxContentsId).html(htmlString3);
						
						$("#"+areaBoxContentsId).attr("data", "quiz");
						
						$("#"+areaBoxId).find(".areaTitle").remove();
						fn_closePopupThis();
				}else{
					var htmlString3 = '<div class="quizArea" style="padding:20px;">'+
										'<input type="hidden" class="quizType" value="'+result.quizVO.quiz_type+'"/>'+
										'<input type="hidden" class="quizText1" value="'+result.quizVO.quiz_text_1+'"/>'+
										'<input type="hidden" class="quizText2" value="'+result.quizVO.quiz_text_2+'"/>'+
										'<input type="hidden" class="quizText3" value="'+result.quizVO.quiz_text_3+'"/>'+
										'<input type="hidden" class="quizText4" value="'+result.quizVO.quiz_text_4+'"/>'+
										'<input type="hidden" class="quizText5" value="'+result.quizVO.quiz_text_5+'"/>'+
										'<input type="hidden" class="quizColor1" value="rgba(29, 43, 58, 1)"/>'+
										'<input type="hidden" class="quizFontColor1" value="rgba(255, 255, 255, 1)"/>'+
										'<input type="hidden" class="quizColor2" value="rgba(255, 255, 255, 1)"/>'+
										'<input type="hidden" class="quizFontColor2" value="rgba(29, 43, 58, 1)"/>'+
										'<div class="quizNameArea" style="border-radius:20px;width:90%;color:white;background-color:var(--main-bg-color);margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;">Q. '+result.quizVO.quiz_name+'</div>'+
							        '</div>';
						            
						$("#"+areaBoxContentsId).html(htmlString3);
						
						$("#"+areaBoxContentsId).attr("data", "quiz");
						
						$("#"+areaBoxId).find(".areaTitle").remove();
						fn_closePopupThis();
				}
				
				
			}
		});
	}
	
	
	function fn_settingGame(areaBoxContentsId){
		var wheelNumber = parseInt($("#"+areaBoxContentsId).find(".gameNumber").val());
		$("#gameNumber").val(wheelNumber);
		
		var rouletteColor1 = $("#"+areaBoxContentsId).find(".rouletteColor1").val();
		var rouletteColor2 = $("#"+areaBoxContentsId).find(".rouletteColor2").val();
		var rouletteColor3 = $("#"+areaBoxContentsId).find(".rouletteColor3").val();
		var rouletteColor4 = $("#"+areaBoxContentsId).find(".rouletteColor4").val();
		var rouletteColor5 = $("#"+areaBoxContentsId).find(".rouletteColor5").val();
		var rouletteColor6 = $("#"+areaBoxContentsId).find(".rouletteColor6").val();
		var rouletteColor7 = $("#"+areaBoxContentsId).find(".rouletteColor7").val();
		var rouletteColor8 = $("#"+areaBoxContentsId).find(".rouletteColor8").val();
		
		var rouletteValue1 = $("#"+areaBoxContentsId).find(".rouletteValue1").val();
		var rouletteValue2 = $("#"+areaBoxContentsId).find(".rouletteValue2").val();
		var rouletteValue3 = $("#"+areaBoxContentsId).find(".rouletteValue3").val();
		var rouletteValue4 = $("#"+areaBoxContentsId).find(".rouletteValue4").val();
		var rouletteValue5 = $("#"+areaBoxContentsId).find(".rouletteValue5").val();
		var rouletteValue6 = $("#"+areaBoxContentsId).find(".rouletteValue6").val();
		var rouletteValue7 = $("#"+areaBoxContentsId).find(".rouletteValue7").val();
		var rouletteValue8 = $("#"+areaBoxContentsId).find(".rouletteValue8").val();
		
		var htmlString = "";
		
		for(var i=1; i<wheelNumber+1; i++){
			if(i==1){
				htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput"><input type="text" required="required" id="rouletteValue'+i+'" class="required" value="'+rouletteValue1+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="rouletteColor'+i+'" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor1+'"/></div></div>';
			}else if(i==2){
				htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput"><input type="text" required="required" id="rouletteValue'+i+'" class="required" value="'+rouletteValue2+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="rouletteColor'+i+'" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor2+'"/></div></div>';
			}else if(i==3){
				htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput"><input type="text" required="required" id="rouletteValue'+i+'" class="required" value="'+rouletteValue3+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="rouletteColor'+i+'" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor3+'"/></div></div>';
			}else if(i==4){
				htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput"><input type="text" required="required" id="rouletteValue'+i+'" class="required" value="'+rouletteValue4+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="rouletteColor'+i+'" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor4+'"/></div></div>';
			}else if(i==5){
				htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput"><input type="text" required="required" id="rouletteValue'+i+'" class="required" value="'+rouletteValue5+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="rouletteColor'+i+'" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor5+'"/></div></div>';
			}else if(i==6){
				htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput"><input type="text" required="required" id="rouletteValue'+i+'" class="required" value="'+rouletteValue6+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="rouletteColor'+i+'" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor6+'"/></div></div>';
			}else if(i==7){
				htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput"><input type="text" required="required" id="rouletteValue'+i+'" class="required" value="'+rouletteValue7+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="rouletteColor'+i+'" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor7+'"/></div></div>';
			}else if(i==8){
				htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput"><input type="text" required="required" id="rouletteValue'+i+'" class="required" value="'+rouletteValue8+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="rouletteColor'+i+'" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor8+'"/></div></div>';
			}
			
		}
		
		
		$("#rouletteColorArea").html(htmlString);
		
		$('.demo').each(function() {
		    $(this).minicolors({
		      control: $(this).attr('data-control') || 'hue',
		      defaultValue: $(this).attr('data-defaultValue') || '',
		      format: $(this).attr('data-format') || 'rgb',
		      keywords: $(this).attr('data-keywords') || '',
		      inline: $(this).attr('data-inline') === 'true',
		      letterCase: $(this).attr('data-letterCase') || 'lowercase',
		      opacity: $(this).attr('data-opacity'),
		      position: $(this).attr('data-position') || 'bottom',
		      swatches: $(this).attr('data-swatches') ? $(this).attr('data-swatches').split('|') : [],
		      change: function(hex, opacity) {
		        var log;
		        try {
		          log = hex ? hex : 'transparent';
		          if( opacity ) log += ', ' + opacity;
		          console.log(log);
		        } catch(e) {}
		      },
		      theme: 'default'
		        });
		 
		  });
	}
	
	function fn_settingQuiz(areaBoxContentsId){
		var htmlString = "";
		
		var quizColor1 = $("#"+areaBoxContentsId).find(".quizColor1").val();
		var quizFontColor1 = $("#"+areaBoxContentsId).find(".quizFontColor1").val();
		var quizColor2 = $("#"+areaBoxContentsId).find(".quizColor2").val();
		var quizFontColor2 = $("#"+areaBoxContentsId).find(".quizFontColor2").val();
		
		htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="quizColor1" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+quizColor1+'"/></div></div>';
		
		$("#quizColorArea").html(htmlString);
		
		var htmlString2 = "";
		
		htmlString2 += '<div class="d-ib"><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="quizFontColor1" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+quizFontColor1+'"/></div></div>';
		
		$("#quizFontColorArea").html(htmlString2);
		
		var htmlString3 = "";
		htmlString3 += '<div class="d-ib"><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="quizColor2" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+quizColor2+'"/></div></div>';
		
		$("#quizColorArea2").html(htmlString3);
		
		var htmlString4 = "";
		htmlString4 += '<div class="d-ib"><div class="inputBox f-l rouletteInputColor"><input type="text" required="required" id="quizFontColor2" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+quizFontColor2+'"/></div></div>';
		
		$("#quizFontColorArea2").html(htmlString4);
		
		$('.demo').each(function() {
		    $(this).minicolors({
		      control: $(this).attr('data-control') || 'hue',
		      defaultValue: $(this).attr('data-defaultValue') || '',
		      format: $(this).attr('data-format') || 'rgb',
		      keywords: $(this).attr('data-keywords') || '',
		      inline: $(this).attr('data-inline') === 'true',
		      letterCase: $(this).attr('data-letterCase') || 'lowercase',
		      opacity: $(this).attr('data-opacity'),
		      position: $(this).attr('data-position') || 'bottom',
		      swatches: $(this).attr('data-swatches') ? $(this).attr('data-swatches').split('|') : [],
		      change: function(hex, opacity) {
		        var log;
		        try {
		          log = hex ? hex : 'transparent';
		          if( opacity ) log += ', ' + opacity;
		          console.log(log);
		        } catch(e) {}
		      },
		      theme: 'default'
		        });
		 
		  });
	}

	$(document).ready(function() {
		var checkComapnyId = $("#company_id").val();
		
		if(checkComapnyId == "0"){
			$(".nav-item").removeClass("active");
			$("#contentsList").addClass("active open");
		}else{
			$(".nav-item").removeClass("active");
			$("#contentsList").addClass("active open");
		}
		
		
		fn_checkPage();
		function fn_checkPage(){
			let checkPageCount = parseInt('${totalCnt}');
			if(checkPageCount > 0){
				var params = $("form[id=parameterVO]").serialize(); 
				$.ajax({
					url : "${pageContext.request.contextPath}/contentsDetail.do",
					type : "POST",
					data: params,
					success : function(result) {
						$("#areaBoxList").html(result);
					}
				});
			}
		}
		
		$(document).on("mouseover", ".sectorlist", function(){
			$(this).parent().find(".sectorlist").removeClass("active");
			$(this).addClass("active");
		})
		
		/* $(document).on("click", ".sectorlist", function(){
		}) */
		
		$("#editor2").addClass("active");
		
		$(".fileupload").on("change", fn_addFiles);
		$(".fileuploadMovie").on("change", fn_addFiles2);
		$(".fileuploadFile").on("change", fn_addFiles3);
		$(".fileuploadBack").on("change", fn_addFiles4);
		
		
		function fn_addFiles(e) {
			filesTempArr = [];
		    var files = e.target.files;
		    var filesArr = Array.prototype.slice.call(files);
		    var filesArrLen = filesArr.length;
		    var filesTempArrLen = filesTempArr.length;
		    for( var i=0; i<filesArrLen; i++ ) {
		        filesTempArr.push(filesArr[i]);
		        fileName = filesArr[i].name;
		        console.log(fileName);
		        var img = new Image();
		        var _URL = window.URL || window.webkitURL;
		        
		        
		        img.src = _URL.createObjectURL(filesArr[i]);
		        
		        img.onload =function(){
		        	console.log("sizeWidth : "+img.width);
		        	console.log("sizeHeight : "+img.height);
		        	fn_insertFile(img.width, img.height, fileName);
		        }
		        
		    }
		}
		
		function fn_addFiles2(e) {
			filesTempArr = [];
		    var files = e.target.files;
		    var filesArr = Array.prototype.slice.call(files);
		    var filesArrLen = filesArr.length;
		    var filesTempArrLen = filesTempArr.length;
		    for( var i=0; i<filesArrLen; i++ ) {
		        filesTempArr.push(filesArr[i]);
		        fileName = filesArr[i].name;
		        fn_insertFile2(fileName);
		    }
		}
		
		function fn_addFiles3(e) {
			filesTempArr = [];
		    var files = e.target.files;
		    var filesArr = Array.prototype.slice.call(files);
		    var filesArrLen = filesArr.length;
		    var filesTempArrLen = filesTempArr.length;
		    for( var i=0; i<filesArrLen; i++ ) {
		        filesTempArr.push(filesArr[i]);
		        fileName = filesArr[i].name;
		        fn_insertFile3(fileName);
		    }
		}
		
		function fn_addFiles4(e) {
			filesTempArr = [];
		    var files = e.target.files;
		    var filesArr = Array.prototype.slice.call(files);
		    var filesArrLen = filesArr.length;
		    var filesTempArrLen = filesTempArr.length;
		    for( var i=0; i<filesArrLen; i++ ) {
		        filesTempArr.push(filesArr[i]);
		        fileName = filesArr[i].name;
		        console.log(fileName);
		        var img = new Image();
		        var _URL = window.URL || window.webkitURL;
		        
		        
		        img.src = _URL.createObjectURL(filesArr[i]);
		        
		        img.onload =function(){
		        	console.log("sizeWidth : "+img.width);
		        	console.log("sizeHeight : "+img.height);
		        	fn_insertFile4(fileName);
		        }
		        
		    }
		}
		
		function fn_insertFile(imageWidth, imageHeight, fileName){
			var formData = new FormData();
			 
			// 파일 데이터
			for(var i=0, filesTempArrLen = filesTempArr.length; i<filesTempArrLen; i++) {
			   formData.append("files", filesTempArr[i]);
			}
			 
			$.ajax({
			    type : "POST",
			    url : "${pageContext.request.contextPath}/file/upload.json",
			    data : formData,
			    processData: false,
			    contentType: false,
			    success : function(result) {
			        if(result.resultCode == "success"){
			        	var htmlString = "";
			        	for(var i=0; i<1; i++){
			        		var fileId = result.fileList[i].file_id;
			        		var imagePercent = 0;
			        		imageWidth = 100;
			        		
			    			var areaBoxContentsId = $("#areaBoxContentsId").val();
			    			var htmlString = '<img class="eImage" style="width:'+imageWidth+'%;" src="${pageContext.request.contextPath}/file/down/'+fileId+'" data="'+fileName+'" sort="5"/>';
			    			
			    			$("#"+areaBoxContentsId).html(htmlString);
							
			    			$("#imageWidth").val(imageWidth);
			    			
			    			
			    			/*var areaWidth = parseInt($("#imagePositionL").val())+parseInt($("#imagePositionR").val())+parseInt(imageWidth);
			    			var areaHeight = parseInt($("#imagePositionT").val())+parseInt($("#imagePositionB").val())+parseInt(imageHeight);
			    			
			    			 $("#"+areaBoxContentsId).parent().css("width", areaWidth);
			    			$("#"+areaBoxContentsId).parent().css("height", areaHeight); */
			    			
			    			$("#"+areaBoxContentsId).find(".eImage").css("margin-top", $("#imagePositionT").val()+"px");
			    			$("#"+areaBoxContentsId).find(".eImage").css("margin-left", $("#imagePositionL").val()+"px");
			    			$("#"+areaBoxContentsId).find(".eImage").css("margin-right", $("#imagePositionR").val()+"px");
			    			$("#"+areaBoxContentsId).find(".eImage").css("margin-bottom", $("#imagePositionB").val()+"px");
			    			
			    			$("#imageFileName").text(fileName);
			        	}
			        }else{
	        			fn_removeFiles();
			        	
			        	return false;
			        }
			    },
			    err : function(err) {
			    	
			    }
			});
		}
		
		function fn_insertFile2(fileName){
			var formData = new FormData();
			 
			// 파일 데이터
			for(var i=0, filesTempArrLen = filesTempArr.length; i<filesTempArrLen; i++) {
			   formData.append("files", filesTempArr[i]);
			}
			 
			$.ajax({
			    type : "POST",
			    url : "${pageContext.request.contextPath}/file/uploadMovie.json",
			    data : formData,
			    processData: false,
			    contentType: false,
			    success : function(result) {
			        if(result.resultCode == "success"){
			        	var htmlString = "";
			        	for(var i=0; i<1; i++){
							var fileId = result.fileList[i].file_id;
							
							var areaTotalId = $("#areaTotalId").val();
			    			var areaBoxId = $("#areaBoxId").val();
			    			var areaBoxContentsId = $("#areaBoxContentsId").val();
							
							$.ajax({
								url : "${pageContext.request.contextPath}/videoPlayer.do?areaBoxContentsId="+areaBoxContentsId+"&fileId="+fileId+"&fileName="+fileName,
								type : "POST",
								success : function(result) {
									$("#"+areaBoxContentsId).html(result);
								}
							});
							
							$("#movieFileName").text(fileName);
			        	}
			        }else{
	        			fn_removeFiles();
			        	
			        	return false;
			        }
			    },
			    err : function(err) {
			    	
			    }
			});
		}
		
		function fn_insertFile3(fileName){
			var formData = new FormData();
			// 파일 데이터
			for(var i=0, filesTempArrLen = filesTempArr.length; i<filesTempArrLen; i++) {
			   formData.append("files", filesTempArr[i]);
			}
			 
			$.ajax({
			    type : "POST",
			    url : "${pageContext.request.contextPath}/file/uploadFile.json",
			    data : formData,
			    processData: false,
			    contentType: false,
			    success : function(result) {
			        if(result.resultCode == "success"){
			        	var htmlString = "";
			        	for(var i=0; i<1; i++){
			        		var fileId = result.fileList[i].file_id;
			        		var fileName = result.fileList[i].file_real_name;
			        		var areaBoxContentsId = $("#areaBoxContentsId").val();
			        		var htmlString = '<a href="${pageContext.request.contextPath}/file/down/'+fileId+'" class="btn btn-primary emt-5 emb-5" download="'+fileName+'"><i class="feather icon-paperclip eFile" style="width:15px;height:15px;font-size:15px;margin:0 auto;" data="'+fileName+'"></i>&nbsp;&nbsp;'+fileName+'</a>';
			        		$("#"+areaBoxContentsId).html(htmlString);
			        		
			    			$("#fileFileName").text(fileName);
			        	}
			        }else{
	        			fn_removeFiles();
			        	
			        	return false;
			        }
			    },
			    err : function(err) {
			    	
			    }
			});
		}
		
		function fn_insertFile4(fileName){
			var formData = new FormData();
			 
			// 파일 데이터
			for(var i=0, filesTempArrLen = filesTempArr.length; i<filesTempArrLen; i++) {
			   formData.append("files", filesTempArr[i]);
			}
			 
			$.ajax({
			    type : "POST",
			    url : "${pageContext.request.contextPath}/file/upload.json",
			    data : formData,
			    processData: false,
			    contentType: false,
			    success : function(result) {
			        if(result.resultCode == "success"){
			        	var htmlString = "";
			        	for(var i=0; i<1; i++){
			        		var fileId = result.fileList[i].file_id;
			        		var fileUrl = "${pageContext.request.contextPath}/file/down/"+fileId;
			        		
			    			var areaTotalId = $("#areaTotalId").val();
			    			
			    			$("#"+areaTotalId).css({"background":"url("+fileUrl+")", 'background-repeat' : 'no-repeat', 'background-position':'center center'});
			    			
			    			$("#backFileName").text(fileName);
			    			
			        	}
			        }else{
	        			fn_removeFiles();
			        	
			        	return false;
			        }
			    },
			    err : function(err) {
			    	
			    }
			});
		}
		
		function fn_removeFiles(e) {
			filesTempArr = [];
		}
		
		$(document).on("mouseover", ".areaTotalBox", function(){
			$(this).addClass("borderOn");
		});

		$(document).on("mouseleave", ".areaTotalBox", function(){
			$(this).removeClass("borderOn");
		});

		/*areaBox*/
		$(document).on("click", ".areaBox", function(e){
			$(".areaBox").removeClass("areaBorder");
			$(".areaBox").removeClass("borderOn");
			$(".btnItemAdd").addClass("hiddenObj");
			$(".btnItemDelete").addClass("hiddenObj");
			$(this).addClass("areaBorder");
			$(this).find(".btnItemAdd").removeClass("hiddenObj");
			$(this).find(".btnItemDelete").removeClass("hiddenObj");
			$(".areaBoxCaption").each(function(){
				if(!$(this).hasClass("hiddenObj")){
					$(this).addClass("hiddenObj");
				}
			});
			
			if(undefined != $(this).find(".eImage").attr("data")){
				$("#imageFileName").text($(this).find(".eImage").attr("data"));
			}else{
				$("#imageFileName").text("");
			}
			
			if(undefined != $(this).find(".eMovie").attr("data")){
				$("#movieFileName").text($(this).find(".eMovie").attr("data"));
			}else{
				$("#movieFileName").text("");
			}
			
			if(undefined != $(this).find(".eFile").attr("data")){
				$("#fileFileName").text($(this).find(".eFile").attr("data"));
			}else{
				$("#fileFileName").text("");
			}
			
			if($(this).parent().find(".areaBoxCaption").hasClass("hiddenObj")){
				$(this).parent().find(".areaBoxCaption").removeClass("hiddenObj");
			}
			
			var areaTotalId = $(this).parent().attr("id");
			var areaBoxId = $(this).attr("id");
			var areaBoxContentsId = $(this).find(".areaContents").attr("id");
			$("#areaTotalId").val(areaTotalId);
			$("#areaBoxId").val(areaBoxId);
			$("#areaBoxContentsId").val(areaBoxContentsId);
			
			console.log("areaTotalId : "+areaTotalId);
			console.log("areaBoxId : "+areaBoxId);
			console.log("areaBoxContentsId : "+areaBoxContentsId);
			
			$(".rightArea").each(function(){
				if(!$(this).hasClass("hiddenObj")){
					$(this).addClass("hiddenObj")
				}
			});
			
			var contentsType = $(this).find(".areaContents").attr("data");
			
			if(contentsType != undefined && contentsType != ""){
				if(contentsType == "text"){
					$("#textSettingArea").removeClass("hiddenObj");
					var areaBoxContentsId = $(this).find(".areaContents").attr("id");
					fn_settingText(areaBoxContentsId);
					
					todoNewTasksidebar.addClass('show');
				}else if(contentsType == "image"){
					$("#imageSettingArea").removeClass("hiddenObj");
					var areaBoxContentsId = $(this).find(".areaContents").attr("id");
					fn_settingImage(areaBoxContentsId);
					
					todoNewTasksidebar.addClass('show');
				}else if(contentsType == "movie"){
					$("#movieSettingArea").removeClass("hiddenObj");
					var areaBoxContentsId = $(this).find(".areaContents").attr("id");
					fn_settingMovie(areaBoxContentsId);
					
					todoNewTasksidebar.addClass('show');
				}else if(contentsType == "line"){
					$("#lineSettingArea").removeClass("hiddenObj");
					var areaBoxContentsId = $(this).find(".areaContents").attr("id");
					fn_settingLine(areaBoxContentsId);
					
					todoNewTasksidebar.addClass('show');
				}else if(contentsType == "sound"){
					$("#soundSettingArea").removeClass("hiddenObj");
					var areaBoxContentsId = $(this).find(".areaContents").attr("id");
					fn_settingSound(areaBoxContentsId);
					
					todoNewTasksidebar.addClass('show');
				}else if(contentsType == "file"){
					$("#fileSettingArea").removeClass("hiddenObj");
					var areaBoxContentsId = $(this).find(".areaContents").attr("id");
					fn_settingFile(areaBoxContentsId);
					
					todoNewTasksidebar.addClass('show');
				}else if(contentsType == "game"){
					$("#gameSettingArea").removeClass("hiddenObj");
					var areaBoxContentsId = $(this).find(".areaContents").attr("id");
					fn_settingGame(areaBoxContentsId);
					
					todoNewTasksidebar.addClass('show');
				}else if(contentsType == "quiz"){
					$("#quizSettingArea").removeClass("hiddenObj");
					var areaBoxContentsId = $(this).find(".areaContents").attr("id");
					fn_settingQuiz(areaBoxContentsId);
					
					todoNewTasksidebar.addClass('show');
				}
			}
			
		});
		
		
		
		$(document).on("click", ".settingArea", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			
			$("#"+areaTotalId).find("#"+areaBoxId).css("background-color", $("#areaColor").val());
			
			$("#"+areaTotalId).find("#"+areaBoxId).css("padding-top", $("#areaPositionT").val()+"px");
			$("#"+areaTotalId).find("#"+areaBoxId).css("padding-left", $("#areaPositionL").val()+"px");
			$("#"+areaTotalId).find("#"+areaBoxId).css("padding-right", $("#areaPositionR").val()+"px");
			$("#"+areaTotalId).find("#"+areaBoxId).css("padding-bottom", $("#areaPositionB").val()+"px");
		});
		
		$(document).on("click", ".areaCutting", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			var cuttingCount = $(this).parent().find(".areaCuttingCount").val();
			
			var areaTotalWidth = parseFloat($("#"+areaTotalId).find("#"+areaBoxId).css("width"));
			
			var totalPadding = parseFloat($("#areaPositionL").val()) + parseFloat($("#areaPositionR").val());
			
			var itemWidthPercent = 100 / cuttingCount;
			var itemWidthPadding = totalPadding / cuttingCount;
			
			var cuttingWidth = itemWidthPercent;
			
			var dataLine = $(this).attr("data-line");
			
			var htmlString = '';
			for(var i=0;i<cuttingCount;i++){
				htmlString += '<div id="'+areaTotalId+'_'+areaBoxId+'_'+dataLine+'_'+i+'" class="areaItem dataline'+dataLine+'" style="display:inline-block;width:'+cuttingWidth+'%;min-height:100px;min-width:50px;">'+dataLine+' LINE</div>';
			}
			fn_addLine(areaTotalId, areaBoxId, dataLine, htmlString);
			
			
			$("#"+areaTotalId).find("#"+areaBoxId).find(".areaTitle").remove();
			
		});
		
		$(document).on("click", "#areaLineAdd", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			
			var dataLine = $("#"+areaTotalId).find("#"+areaBoxId).attr("data-line");
			
			dataLine++;
			
			var controlHtml = '<div class="cut">'+
									'<div class="inputBox">'+
									'<input type="text" required="required" class="areaCuttingCount w-25 required" value="1"/> 개'+
									'<span>분할</span>'+
									'</div>'+
									'<button type="button" class="areaCutting btn btn-primary" data-line="'+dataLine+'" style="color:white;">분할하기</button>'+
								'</div>'; 
			
			$("#cutSettingArea").append(controlHtml);
			
			var areaLine = '<div class="areaLine areaLine'+dataLine+'" style="width:100%"></div>';
			$("#"+areaTotalId).find("#"+areaBoxId).find(".areaContents").append(areaLine);
			
			var areaItemHtml = '<div  id="'+areaTotalId+'_'+areaBoxId+'_'+dataLine+'_1" class="areaItem dataline'+dataLine+'" style="display:inline-block;width:100%;min-height:100px;min-width:50px;">'+dataLine+' LINE</div>';
			
			$("#"+areaTotalId).find("#"+areaBoxId).attr("data-line", dataLine);
			
			fn_addLine(areaTotalId, areaBoxId, dataLine, areaItemHtml);
			
		});
		
		function fn_addLine(areaTotalId, areaBoxId, dataLine, htmlString){
			$("#"+areaTotalId).find("#"+areaBoxId).find(".areaLine"+dataLine).html(htmlString);
		}
		

		$(document).on("click", ".areaItem", function(){
			var areaBoxContentsId = $(this).attr("id");
			$("#areaBoxContentsId").val(areaBoxContentsId);
			
			var type = $(this).attr("data");
			
			if(type == "text"){
				$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
				})
				
				$("#textSettingArea").removeClass("hiddenObj");
				
				//fn_editorSetting(areaBoxContentsId);
				fn_settingText(areaBoxContentsId);
				
				todoNewTasksidebar.addClass('show');


			}else if(type == "image"){
				$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
				})
				
				$("#imageSettingArea").removeClass("hiddenObj");
				
				fn_settingImage(areaBoxContentsId);
				
				todoNewTasksidebar.addClass('show');
				

			}else if(type == "movie"){
				$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
				})
				
				$("#movieSettingArea").removeClass("hiddenObj");
				
				fn_settingMovie(areaBoxContentsId);
				
				todoNewTasksidebar.addClass('show');
				
			}else if(type == "line"){
				$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
				})
				
				$("#lineSettingArea").removeClass("hiddenObj");
				
				fn_settingLine(areaBoxContentsId);
				
				todoNewTasksidebar.addClass('show');
				
				
			}else if(type == "game"){
				$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
				})
				
				$("#gameSettingArea").removeClass("hiddenObj");
				
				todoNewTasksidebar.addClass('show');
				
			}else{
			}


		});
		
		$(document).on("click", ".sectorItem", function(){
			
			var type = $(this).attr("data");
			var totalAreaId = $(this).parent().parent().parent().parent().parent().attr("id");
			var areaBoxId = $(this).parent().parent().parent().parent().attr("id");
			var areaBoxContentsId = totalAreaId+"_"+areaBoxId+"_contents";
			$(this).parent().parent().parent().parent().find(".areaContents").attr("id", areaBoxContentsId);
			
			$("#areaTotalId").val(totalAreaId);
			$("#areaBoxId").val(areaBoxId);
			$("#areaBoxContentsId").val(areaBoxContentsId);
			
			if(type == "text"){
				var textArea = $("#"+areaBoxContentsId);
				
				$.ajax({
					url : "${pageContext.request.contextPath}/textEditor.do?areaBoxContentsId="+areaBoxContentsId,
					type : "POST",
					success : function(result) {
						textArea.html(result);
						
						$(".rightArea").each(function(){
							if(!$(this).hasClass("hiddenObj")){
								$(this).addClass("hiddenObj")
							}
						})
						
						$("#textSettingArea").removeClass("hiddenObj");
						todoNewTasksidebar.addClass('show');
						
						$("#"+areaBoxContentsId).attr("data", "text");
						fn_editorSetting(areaBoxContentsId);
						fn_settingText(areaBoxContentsId);
						$("#"+areaBoxId).find(".areaTitle").remove();
						
					}
				});


			}else if(type == "image"){
				
				var htmlString = '<div class="eImage"><i class="feather icon-image" style="width:200px;height:200px;font-size:200px;margin:0 auto;"></i></div>';
				$("#"+areaBoxContentsId).html(htmlString);
				
				$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
				})
				
				$("#imageSettingArea").removeClass("hiddenObj");
				todoNewTasksidebar.addClass('show');
				
				$("#"+areaBoxContentsId).attr("data", "image");
				fn_settingImage(areaBoxContentsId);
				$("#"+areaBoxId).find(".areaTitle").remove();

			}else if(type == "movie"){
				
				var videoArea = $("#"+areaBoxContentsId);
				var htmlString = '<div class="eMovie"><i class="feather icon-film" style="width:200px;height:200px;font-size:200px;margin:0 auto;"></i></div>';
				videoArea.html(htmlString);
				
				$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
				})
				
				$("#movieSettingArea").removeClass("hiddenObj");
				
				todoNewTasksidebar.addClass('show');
				$("#"+areaBoxContentsId).attr("data", "movie");
				fn_settingMovie(areaBoxContentsId);
				$("#"+areaBoxId).find(".areaTitle").remove();
				
			}else if(type == "line"){
				var htmlString = '<div class="eline" style="width:100%;height:1px;background-color:black;margin-top:0px;margin-left:0px;margin-right:0px;margin-bottom:0px;display:flex;"></div>';
				$("#"+areaBoxContentsId).html(htmlString);
				
				$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
				})
				
				$("#lineSettingArea").removeClass("hiddenObj");
				todoNewTasksidebar.addClass('show');
				
				$("#"+areaBoxContentsId).attr("data", "line");
				
				fn_settingLine(areaBoxContentsId);
				
				$("#"+areaBoxContentsId).find(".eline").css("margin-top", "10px")
				$("#"+areaBoxContentsId).find(".eline").css("margin-bottom", "10px")
				$("#linePositionT").val(10);
				$("#linePositionB").val(10);
				
				$("#"+areaBoxId).find(".areaTitle").remove();
				
			}else if(type == "file"){
				
				var htmlString = '<div class="btn btn-primary emt-5 emb-5"><i class="feather icon-paperclip eFile" style="width:15px;height:15px;font-size:15px;margin:0 auto;"></i></div>';
				$("#"+areaBoxContentsId).html(htmlString);
				
				$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
				})
				
				$("#fileSettingArea").removeClass("hiddenObj");
				todoNewTasksidebar.addClass('show');
				
				$("#"+areaBoxContentsId).attr("data", "file");
				
				$("#"+areaBoxId).find(".areaTitle").remove();
				
			}else if(type == "game"){
				
				fn_openPopup();
				
			}else{
			}
		});
		
		
		
		$(document).on("click", ".htmlAccept", function(){
			
			var htmlString = $(this).parent().find(".ehtml").val();
			
			$(this).parent().parent().find(".areaContents").html(htmlString);
		});
		
		$(document).on("click", ".editorAccept", function(){
			var areaBoxContentsId = $("#areaBoxContentsId").val();
			var htmlString = '<div id="container_'+areaBoxContentsId+'" class="full-container"><div class="editor"><div class="eEditor ql-editor" data-gramm="false">'+$(this).parent().find(".ql-editor").html()+'</div></div></div>';
			
			$(this).parent().html(htmlString);
		});
		
		function fn_editorSetting7(areaBoxContentsId){
			var quill = new Quill('#container_'+areaBoxContentsId , {
			    theme: 'snow'
			  });
		}
		
		function fn_editorSetting(areaBoxContentsId){
			(function (window, document, $) {
				  "use strict";
				  var Font = Quill.import("formats/font");
				  Font.whitelist = ["sofia", "slabo", "roboto", "inconsolata", "ubuntu"];
				  Quill.register(Font, true);

				  var toolbarOptions = [
					  [{ 'font': ["sofia", "slabo", "roboto", "inconsolata", "ubuntu"] }],
					  [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
					  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
					  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
					  ['blockquote', 'code-block'],
					  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
					  [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
					  [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
					  [{ 'direction': 'rtl' }],                         // text direction
					  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
					  [{ 'align': [] }],

					  ['clean']                                         // remove formatting button
					];
				  
				  
				  // bubble editor
				  var fullEditor = new Quill("#container_"+areaBoxContentsId+" .editor", {
				    bounds: "#container_"+areaBoxContentsId+" .editor",
				    modules: {
				      formula: true,
				      syntax: true,
				      toolbar: toolbarOptions
				    },
				    theme: "snow"
				  });

				})(window, document, jQuery);
		}
		
		function fn_editorSetting2(areaBoxContentsId){
			/* (function (window, document, $) {
				  "use strict";

				  var Font = Quill.import("formats/font");
				  Font.whitelist = ["sofia", "slabo", "roboto", "inconsolata", "ubuntu"];
				  Quill.register(Font, true);
				  var toolbarOptions = [
					  [{ 'font': ["sofia", "slabo", "roboto", "inconsolata", "ubuntu"] }],
					  [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
					  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
					  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
					  ['blockquote', 'code-block'],
					  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
					  [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
					  [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
					  [{ 'direction': 'rtl' }],                         // text direction
					  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
					  [{ 'align': [] }],

					  ['clean']                                         // remove formatting button
					];
				  
				  // bubble editor
				  var fullEditor = new Quill("#container_"+areaBoxContentsId+" .editor", {
					    bounds: "#container_"+areaBoxContentsId+" .editor",
					    modules: {
					      formula: true,
					      syntax: true,
					      toolbar: toolbarOptions
					    },
					    theme: "snow"
					  });
				  
				})(window, document, jQuery);
			
			$("#"+areaBoxContentsId).append('<button type="button" class="editorAccept btn btn-primary emt-15 emb-15" style="color:white;">적용</button>');  */
			var textArea = $("#"+areaBoxContentsId);
			var checkHtml = $("#"+areaBoxContentsId).find(".eEditor").html();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/textEditor.do?areaBoxContentsId="+areaBoxContentsId,
				type : "POST",
				success : function(result) {
					console.log(result)
					textArea.html(result);
					
					fn_editorSetting(areaBoxContentsId);
					
					$("#"+areaBoxContentsId).find(".ql-editor").html(checkHtml);
				}
			});
		}
		
		function fn_settingLine(areaBoxContentsId){
			var lineWidth = $("#"+areaBoxContentsId).find(".eline").css("width");
			var lineHeight = parseFloat($("#"+areaBoxContentsId).find(".eline").css("height"));
			var lineColor = $("#"+areaBoxContentsId).find(".eline").css("background-color");
			
			var areaWidth = parseFloat($("#"+areaBoxContentsId).css("width"));
			var thisWidth = parseFloat(lineWidth);
			
			var linePositionT = parseFloat($("#"+areaBoxContentsId).find(".eline").css("margin-top"));
			var linePositionL = parseFloat($("#"+areaBoxContentsId).find(".eline").css("margin-left"));
			var linePositionR = parseFloat($("#"+areaBoxContentsId).find(".eline").css("margin-right"));
			var linePositionB = parseFloat($("#"+areaBoxContentsId).find(".eline").css("margin-bottom"));
			
			$("#lineWidth").val(thisWidth/areaWidth*100);
			$("#lineHeight").val(lineHeight);
			$("#linePositionT").val(linePositionT);
			$("#linePositionL").val(linePositionL);
			$("#linePositionR").val(linePositionR);
			$("#linePositionB").val(linePositionB);
			
			var htmlString = '<div class="inputBox">'+
			'<input type="text" required="required" id="lineColor" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+lineColor+'"/>'+
			'</div>';
			
			$("#lineColorArea").html(htmlString);
			
			$('.demo').each(function() {
			    $(this).minicolors({
			      control: $(this).attr('data-control') || 'hue',
			      defaultValue: $(this).attr('data-defaultValue') || '',
			      format: $(this).attr('data-format') || 'rgb',
			      keywords: $(this).attr('data-keywords') || '',
			      inline: $(this).attr('data-inline') === 'true',
			      letterCase: $(this).attr('data-letterCase') || 'lowercase',
			      opacity: $(this).attr('data-opacity'),
			      position: $(this).attr('data-position') || 'bottom',
			      swatches: $(this).attr('data-swatches') ? $(this).attr('data-swatches').split('|') : [],
			      change: function(hex, opacity) {
			        var log;
			        try {
			          log = hex ? hex : 'transparent';
			          if( opacity ) log += ', ' + opacity;
			          console.log(log);
			        } catch(e) {}
			      },
			      theme: 'default'
			        });
			 
			  });
			
			console.log(lineWidth);
			console.log(lineHeight);
			console.log(lineColor);
			
			
		}
		
		
		
		function fn_settingText(areaBoxContentsId){
			
			var checkEditor = $("#"+areaBoxContentsId).find(".editorAccept").text();
			if(checkEditor =="적용"){
				$(".resetText").addClass("hiddenObj");
			}else{
				$(".resetText").removeClass("hiddenObj");
			}
			
			var textWidth = parseFloat($("#"+areaBoxContentsId).css("width"));
			
			var textPositionT = parseFloat($("#"+areaBoxContentsId).css("margin-top"));
			var textPositionL = parseFloat($("#"+areaBoxContentsId).css("margin-left"));
			var textPositionR = parseFloat($("#"+areaBoxContentsId).css("margin-right"));
			var textPositionB = parseFloat($("#"+areaBoxContentsId).css("margin-bottom"));
			
			$("#textWidth").val(textWidth);
			
			$("#textPositionT").val(textPositionT);
			$("#textPositionL").val(textPositionL);
			$("#textPositionR").val(textPositionR);
			$("#textPositionB").val(textPositionB);
		}
		
		function fn_settingImage(areaBoxContentsId){
			
			var parentWidth = parseFloat($("#"+areaBoxContentsId).css("width"));
			
			var imageWidth = parseFloat($("#"+areaBoxContentsId).find(".eImage").css("width"));
			
			var areaWidth = parseFloat($("#"+areaBoxContentsId).css("width"));
			
			var thisWidth = parseFloat(imageWidth/parentWidth*100);
			
			var imagePositionT = parseFloat($("#"+areaBoxContentsId).find(".eImage").css("margin-top"));
			var imagePositionL = parseFloat($("#"+areaBoxContentsId).find(".eImage").css("margin-left"));
			var imagePositionR = parseFloat($("#"+areaBoxContentsId).find(".eImage").css("margin-right"));
			var imagePositionB = parseFloat($("#"+areaBoxContentsId).find(".eImage").css("margin-bottom"));
			
			$("#imageWidth").val(thisWidth);
			$("#imagePositionT").val(imagePositionT);
			$("#imagePositionL").val(imagePositionL);
			$("#imagePositionR").val(imagePositionR);
			$("#imagePositionB").val(imagePositionB);
		}
		
		function fn_settingMovie(areaBoxContentsId){
			var movieWidth = 100;
			var movieHeight = 100;
			
			var thisWidth = 100;
			
			if(undefined == $("#"+areaBoxContentsId).find(".eVideoPlayer").css("width")){
				
			}else{
				movieWidth = $("#"+areaBoxContentsId).find(".eVideoPlayer").css("width");
				movieHeight = parseFloat($("#"+areaBoxContentsId).find(".eVideoPlayer").css("height"));
				
				areaWidth = parseFloat($("#"+areaBoxContentsId).css("width"));
				thisWidth = parseFloat(movieWidth);
			}
			
			var moviePositionT = parseFloat($("#"+areaBoxContentsId).find(".eMovie").css("margin-top"));
			var moviePositionL = parseFloat($("#"+areaBoxContentsId).find(".eMovie").css("margin-left"));
			var moviePositionR = parseFloat($("#"+areaBoxContentsId).find(".eMovie").css("margin-right"));
			var moviePositionB = parseFloat($("#"+areaBoxContentsId).find(".eMovie").css("margin-bottom"));
			
			$("#movieWidth").val(thisWidth);
			$("#movieHeight").val(movieHeight);
			$("#moviePositionT").val(moviePositionT);
			$("#moviePositionL").val(moviePositionL);
			$("#moviePositionR").val(moviePositionR);
			$("#moviePositionB").val(moviePositionB);
		}
		
		function fn_settingFile(areaBoxContentsId){
			var fileName = $("#"+areaBoxContentsId).find(".eImage").css("width");
			var downloadColor = $("#"+areaBoxContentsId).find(".btn-primary").css("background-color");
			
			var htmlString = '<div class="inputBox">'+
			'<input type="text" required="required" id="downloadColor" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+downloadColor+'"/>'+
			'</div>';
			
			$("#downloadColorArea").html(htmlString);
			
			$('.demo').each(function() {
			    $(this).minicolors({
			      control: $(this).attr('data-control') || 'hue',
			      defaultValue: $(this).attr('data-defaultValue') || '',
			      format: $(this).attr('data-format') || 'rgb',
			      keywords: $(this).attr('data-keywords') || '',
			      inline: $(this).attr('data-inline') === 'true',
			      letterCase: $(this).attr('data-letterCase') || 'lowercase',
			      opacity: $(this).attr('data-opacity'),
			      position: $(this).attr('data-position') || 'bottom',
			      swatches: $(this).attr('data-swatches') ? $(this).attr('data-swatches').split('|') : [],
			      change: function(hex, opacity) {
			        var log;
			        try {
			          log = hex ? hex : 'transparent';
			          if( opacity ) log += ', ' + opacity;
			          console.log(log);
			        } catch(e) {}
			      },
			      theme: 'default'
			        });
			 
			  });
		}
		
		
		$(document).on("click", ".alignButton", function(){
			$(".alignButton").removeClass("btn-warning");
			
			$(this).addClass("btn-warning");
			
		});
		
		$(document).on("click", ".settingLine", function(){
			var totalAreaId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			var areaBoxContentsId = $("#areaBoxContentsId").val();
			
			
			$("#"+areaBoxContentsId).find(".eline").css("width", $("#lineWidth").val()+"%");
			$("#"+areaBoxContentsId).find(".eline").css("height", $("#lineHeight").val()+"px");
			$("#"+areaBoxContentsId).find(".eline").css("background-color", $("#lineColor").val());
			$("#"+areaBoxContentsId).find(".eline").css("margin-top", $("#linePositionT").val()+"px");
			$("#"+areaBoxContentsId).find(".eline").css("margin-left", $("#linePositionL").val()+"px");
			$("#"+areaBoxContentsId).find(".eline").css("margin-right", $("#linePositionR").val()+"px");
			$("#"+areaBoxContentsId).find(".eline").css("margin-bottom", $("#linePositionB").val()+"px");
			
			if("lineSettingLeft" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).css("display", "flex");
				$("#"+areaBoxContentsId).css("justify-content", "left");
			}else if("lineSettingRight" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).css("display", "flex");
				$("#"+areaBoxContentsId).css("justify-content", "right");
			}else{
				$("#"+areaBoxContentsId).css("display", "flex");
				$("#"+areaBoxContentsId).css("justify-content", "center");
			}
			
		});
		
		$(document).on("click", ".settingImage", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			var areaBoxContentsId = $("#areaBoxContentsId").val();
			
			$("#"+areaBoxContentsId).find(".eImage").css("width", $("#imageWidth").val()+"%");
			$("#"+areaBoxContentsId).find(".eImage").css("margin-top", $("#imagePositionT").val()+"px");
			$("#"+areaBoxContentsId).find(".eImage").css("margin-left", $("#imagePositionL").val()+"px");
			$("#"+areaBoxContentsId).find(".eImage").css("margin-right", $("#imagePositionR").val()+"px");
			$("#"+areaBoxContentsId).find(".eImage").css("margin-bottom", $("#imagePositionB").val()+"px");
			
			var imageWidth = parseInt($("#"+areaBoxContentsId).find(".eImage").css("width"));
			
			var areWidth = parseInt($("#imagePositionL").val())+parseInt($("#imagePositionR").val())+imageWidth;
			
			$("#"+areaBoxId).css("width", areWidth+"px");
			
			if("imageSettingLeftTop" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_1");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_2");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_3");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_4");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_5");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_6");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_7");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_8");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_9");
				
				$("#"+areaBoxContentsId).parent().parent().addClass("position_1");
			}else if("imageSettingLeftMiddle" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_1");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_2");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_3");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_4");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_5");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_6");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_7");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_8");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_9");
				
				$("#"+areaBoxContentsId).parent().parent().addClass("position_2");
			}else if("imageSettingLeftBottom" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_1");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_2");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_3");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_4");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_5");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_6");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_7");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_8");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_9");
				
				$("#"+areaBoxContentsId).parent().parent().addClass("position_3");
			}else if("imageSettingCenterTop" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_1");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_2");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_3");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_4");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_5");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_6");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_7");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_8");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_9");
				
				$("#"+areaBoxContentsId).parent().parent().addClass("position_4");
			}else if("imageSettingCenterMiddle" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_1");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_2");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_3");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_4");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_5");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_6");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_7");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_8");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_9");
				
				$("#"+areaBoxContentsId).parent().parent().addClass("position_5");
			}else if("imageSettingCenterBottom" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_1");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_2");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_3");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_4");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_5");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_6");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_7");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_8");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_9");
				
				$("#"+areaBoxContentsId).parent().parent().addClass("position_6");
			}else if("imageSettingRightTop" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_1");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_2");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_3");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_4");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_5");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_6");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_7");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_8");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_9");
				
				$("#"+areaBoxContentsId).parent().parent().addClass("position_7");
			}else if("imageSettingRightMiddle" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_1");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_2");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_3");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_4");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_5");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_6");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_7");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_8");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_9");
				
				$("#"+areaBoxContentsId).parent().parent().addClass("position_8");
			}else if("imageSettingRightBottom" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_1");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_2");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_3");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_4");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_5");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_6");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_7");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_8");
				$("#"+areaBoxContentsId).parent().parent().removeClass("position_9");
				
				$("#"+areaBoxContentsId).parent().parent().addClass("position_9");
			}
			
			
		});
		
		$(document).on("click", ".settingText", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			var areaBoxContentsId = $("#areaBoxContentsId").val();
			
			$("#"+areaBoxContentsId).css("width", $("#textWidth").val()+"px");
			
			var areWidth = parseInt($("#textPositionL").val())+parseInt($("#textPositionR").val())+parseInt($("#textWidth").val());
			
			$("#"+areaBoxId).css("width", areWidth+"px");
			
			$("#"+areaBoxContentsId).css("margin-top", $("#textPositionT").val()+"px");
			$("#"+areaBoxContentsId).css("margin-left", $("#textPositionL").val()+"px");
			$("#"+areaBoxContentsId).css("margin-right", $("#textPositionR").val()+"px");
			$("#"+areaBoxContentsId).css("margin-bottom", $("#textPositionB").val()+"px");
			
		});
		
		$(document).on("click", ".resetText", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			var areaBoxContentsId = $("#areaBoxContentsId").val();
			
			var textArea = $("#"+areaBoxContentsId);
			
			fn_editorSetting2(areaBoxContentsId);
			
			$("#textSettingArea").removeClass("hiddenObj");
			todoNewTasksidebar.addClass('show');
			
			$("#"+areaBoxContentsId).attr("data", "text");
			
			fn_settingText(areaBoxContentsId);
			
		});
		
		$(document).on("click", ".settingMovie", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			var areaBoxContentsId = $("#areaBoxContentsId").val();
			
			
			$("#"+areaBoxContentsId).find(".eVideoPlayer").css("width", $("#movieWidth").val()+"px");
			if("" != $("#movieHeight").val()){
				$("#"+areaBoxContentsId).find(".eVideoPlayer").css("height", $("#movieHeight").val()+"px");
			}else{
				$("#"+areaBoxContentsId).find(".eVideoPlayer").css("height", "");
			}
			
			
			$("#"+areaBoxContentsId).find(".eMovie").css("margin-top", $("#moviePositionT").val()+"px");
			$("#"+areaBoxContentsId).find(".eMovie").css("margin-left", $("#moviePositionL").val()+"px");
			$("#"+areaBoxContentsId).find(".eMovie").css("margin-right", $("#moviePositionR").val()+"px");
			$("#"+areaBoxContentsId).find(".eMovie").css("margin-bottom", $("#moviePositionB").val()+"px");
			
			if("movieSettingLeft" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).css("display", "flex");
				$("#"+areaBoxContentsId).css("justify-content", "left");
			}else if("movieSettingRight" == $(".btn-warning").attr("id")){
				$("#"+areaBoxContentsId).css("display", "flex");
				$("#"+areaBoxContentsId).css("justify-content", "right");
			}else{
				$("#"+areaBoxContentsId).css("display", "flex");
				$("#"+areaBoxContentsId).css("justify-content", "center");
			}
			
		});
		
		$(document).on("click", ".settingDownload", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			var areaBoxContentsId = $("#areaBoxContentsId").val();
			
			var downloadColor = $("#downloadColorArea").find("input").val();
			downloadColor = downloadColor;
			$("#"+areaBoxContentsId).find(".btn-primary").attr("style", "background-color : "+downloadColor+"!important");

			
		});
		
		$(document).on("click", ".settingGame", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			var areaBoxContentsId = $("#areaBoxContentsId").val();
			
			$("#"+areaBoxContentsId).find(".gameNumber").val($("#gameNumber").val());
			
			if(undefined == $("#rouletteValue1").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue1").val("1000");
				$("#"+areaBoxContentsId).find(".rouletteColor1").val("rgba(255, 255, 255, 1)");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue1").val($("#rouletteValue1").val());
				$("#"+areaBoxContentsId).find(".rouletteColor1").val($("#rouletteColor1").val());
			}
			if(undefined == $("#rouletteValue2").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue2").val("2000");
				$("#"+areaBoxContentsId).find(".rouletteColor2").val("rgba(255, 255, 255, 1)");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue2").val($("#rouletteValue2").val());
				$("#"+areaBoxContentsId).find(".rouletteColor2").val($("#rouletteColor2").val());
			}
			if(undefined == $("#rouletteValue3").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue3").val("3000");
				$("#"+areaBoxContentsId).find(".rouletteColor3").val("rgba(255, 255, 255, 1)");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue3").val($("#rouletteValue3").val());
				$("#"+areaBoxContentsId).find(".rouletteColor3").val($("#rouletteColor3").val());
			}
			if(undefined == $("#rouletteValue4").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue4").val("4000");
				$("#"+areaBoxContentsId).find(".rouletteColor4").val("rgba(255, 255, 255, 1)");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue4").val($("#rouletteValue4").val());
				$("#"+areaBoxContentsId).find(".rouletteColor4").val($("#rouletteColor4").val());
			}
			if(undefined == $("#rouletteValue5").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue5").val("5000");
				$("#"+areaBoxContentsId).find(".rouletteColor5").val("rgba(255, 255, 255, 1)");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue5").val($("#rouletteValue5").val());
				$("#"+areaBoxContentsId).find(".rouletteColor5").val($("#rouletteColor5").val());
			}
			if(undefined == $("#rouletteValue6").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue6").val("6000");
				$("#"+areaBoxContentsId).find(".rouletteColor6").val("rgba(255, 255, 255, 1)");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue6").val($("#rouletteValue6").val());
				$("#"+areaBoxContentsId).find(".rouletteColor6").val($("#rouletteColor6").val());
			}
			if(undefined == $("#rouletteValue7").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue7").val("7000");
				$("#"+areaBoxContentsId).find(".rouletteColor7").val("rgba(255, 255, 255, 1)");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue7").val($("#rouletteValue7").val());
				$("#"+areaBoxContentsId).find(".rouletteColor7").val($("#rouletteColor7").val());
			}
			if(undefined == $("#rouletteValue8").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue8").val("8000");
				$("#"+areaBoxContentsId).find(".rouletteColor8").val("rgba(255, 255, 255, 1)");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue8").val($("#rouletteValue8").val());
				$("#"+areaBoxContentsId).find(".rouletteColor8").val($("#rouletteColor8").val());
			}
			
			
			fn_settingGame(areaBoxContentsId);
			fn_set(areaBoxContentsId);
		});
		
		$(document).on("click", ".settingQuiz", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaBoxId = $("#areaBoxId").val();
			var areaBoxContentsId = $("#areaBoxContentsId").val();
			
			$("#"+areaBoxContentsId).find(".quizColor1").val($("#quizColor1").val());
			$("#"+areaBoxContentsId).find(".quizFontColor1").val($("#quizFontColor1").val());
			$("#"+areaBoxContentsId).find(".quizColor2").val($("#quizColor2").val());
			$("#"+areaBoxContentsId).find(".quizFontColor2").val($("#quizFontColor2").val());
			
			$("#"+areaBoxContentsId).find(".quizNameArea").css("background", $("#quizColor1").val());
			$("#"+areaBoxContentsId).find(".quizNameArea").css("color", $("#quizFontColor1").val());
			$("#"+areaBoxContentsId).find(".quizAnswerArea").css("background", $("#quizColor2").val());
			$("#"+areaBoxContentsId).find(".quizAnswerArea").css("color", $("#quizFontColor2").val());
			
			fn_settingQuiz(areaBoxContentsId);
		});
		
		
		$(document).on("click", ".settingTotal", function(){
			var areaTotalId = $("#areaTotalId").val();
			
			$("#"+areaTotalId).css("background-color", $("#totalColor").val());
			
			$("#"+areaTotalId).css("padding-top", $("#totalPositionT").val()+"px");
			$("#"+areaTotalId).css("padding-left", $("#totalPositionL").val()+"px");
			$("#"+areaTotalId).css("padding-right", $("#totalPositionR").val()+"px");
			$("#"+areaTotalId).css("padding-bottom", $("#totalPositionB").val()+"px");
		});
		
		$(document).on("click", ".pageAddButton", function(){
			var checkContentsCount = 1;
			$(".contentsboard").each(function(){
				checkContentsCount++;
				$(this).removeClass("onboard");
			})
			
			var total = $('.contentsboard').length;
			var checkDetailId = "1";
			$('.contentsboard').each(function(index) {
			    if (index === total - 1) {
			    	checkDetailId = $(this).find(".checkDetailId").val();
			    }
			});
			
			console.log(checkDetailId);
			console.log("next : "+(parseInt(checkDetailId)+1))
			
			var htmlString = '<a href="#" class="required d-flex align-items-center justify-content-between contentsboard onboard">'+
					'<input type="text" class="checkDetailName page-card-input" id="contents_detail_name_'+checkContentsCount+'" value="페이지 '+checkContentsCount+'"/>'+
					'<input type="hidden" class="checkDetailId" id="contents_detail_id_'+checkContentsCount+'" value="'+checkContentsCount+'"/>'+
				    '<span class="bullet bullet-sm bullet-warning" style="margin-right:5px;"></span>'+
				'</a>';

			$("#pageList").append(htmlString);
			$("#contents_detail_id").val(parseInt(checkDetailId)+1);
			$("#contents_detail_name").val("페이지 "+checkContentsCount);
			
			console.log("check : "+ $("#contents_detail_id").val());
			
			$.ajax({
				url : "${pageContext.request.contextPath}/newEditor.do",
				type : "POST",
				success : function(result) {
					$("#areaBoxList").html(result);
					$("#contents_detail_html").val(result);
					var params = $("form[name=parameterVO]").serialize();
					$.ajax({
						url : "${pageContext.request.contextPath}/insertContentsDetail.json",
						type : "POST",
						data : params,
						success : function(result) {
							
						}
					});
				}
			});
		});
		
		$(document).on("click", ".contentsboard", function(){
			var orgHtmlString = $("#areaBoxList").html();
			var changeDetailPage = $(this).find("input[type=hidden]").val();
			var changeDetailName = $(this).find("input[type=text]").val();
			
			$("#contents_detail_html").val(orgHtmlString);
			$(".contentsboard").each(function(){
				$(this).removeClass("onboard");
			})
			$(this).addClass("onboard");
			
			if("" == $("#contents_detail_id").val()){
				$("#contents_detail_id").val(changeDetailPage);
				$("#contents_detail_name").val(changeDetailName);
				
				var params = $("form[id=parameterVO]").serialize(); 
				$.ajax({
					url : "${pageContext.request.contextPath}/contentsDetail.do",
					type : "POST",
					data: params,
					success : function(result) {
						$("#areaBoxList").html(result);
						if(todoNewTasksidebar.hasClass('show')){
							todoNewTasksidebar.removeClass('show');
						}
						$("#areaBoxList").find(".spinBtn").each(function(){
							fn_set($(this).parent().parent().attr("id"));
						})
						
					}
				});
			}else{
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/insertContentsDetail.json",
					type : "POST",
					data : params,
					success : function(result) {
						$("#contents_detail_id").val(changeDetailPage);
						$("#contents_detail_name").val(changeDetailName);
						
						var params = $("form[id=parameterVO]").serialize(); 
						$.ajax({
							url : "${pageContext.request.contextPath}/contentsDetail.do",
							type : "POST",
							data: params,
							success : function(result) {
								$("#areaBoxList").html(result);
								if(todoNewTasksidebar.hasClass('show')){
									todoNewTasksidebar.removeClass('show');
								}
								$("#areaBoxList").find(".spinBtn").each(function(){
									fn_set($(this).parent().parent().attr("id"));
								})
								
							}
						});
					}
				});
			}
			
			
		});
		
		$(document).on("click", ".areaAddButton", function(){
			$(".areaBox").each(function(){
				$(this).removeClass("borderOn");
			})
			var sectorPosition = 0;
			if(docType == "M"){
				sectorPosition = 2;
			}else if(docType == "T"){
				sectorPosition = 115;
			}else{
				sectorPosition = 193;
			}
			areaTotalId++;
			var htmlAreaString = '<div class="areaTotalBox" id="'+areaTotalId+'">'+
										'<div class="areaBox" id="'+areaTotalId+'-areaBox-1" data-line="1">'+
										'<div class="areaContents"></div>'+
										'<div class="areaTitle">'+
											'<div class="sectorNavigation" style="left:'+sectorPosition+'px">'+
													'<ul>'+
														'<li class="sectorlist sectorItem active" style="--clr:#f44336" data="text">'+
															'<a href="#">'+
																'<span class="sectorIcon"><i class="feather icon-type"></i></span>'+
															'</a>'+
														'</li>'+
														'<li class="sectorlist sectorItem" style="--clr:#f44336" data="image">'+
															'<a href="#">'+
																'<span class="sectorIcon"><i class="feather icon-image"></i></span>'+
															'</a>'+
														'</li>'+
														'<li class="sectorlist sectorItem" style="--clr:#f44336" data="movie">'+
															'<a href="#">'+
																'<span class="sectorIcon"><i class="feather icon-film"></i></span>'+
															'</a>'+
														'</li>'+
														'<li class="sectorlist sectorItem" style="--clr:#f44336" data="sound">'+
															'<a href="#">'+
																'<span class="sectorIcon"><i class="feather icon-mic"></i></span>'+
															'</a>'+
														'</li>'+
														'<li class="sectorlist sectorItem" style="--clr:#f44336" data="line">'+
															'<a href="#">'+
																'<span class="sectorIcon"><i class="feather icon-minus"></i></span>'+
															'</a>'+
														'</li>'+
														'<li class="sectorlist sectorItem" style="--clr:#f44336" data="file">'+
															'<a href="#">'+
																'<span class="sectorIcon"><i class="feather icon-paperclip"></i></span>'+
															'</a>'+
														'</li>'+
														'<li class="sectorlist sectorItem" style="--clr:#f44336" data="game">'+
															'<a href="#">'+
																'<span class="sectorIconHtml">GAME</span>'+
															'</a>'+
														'</li>'+
														'<div class="indicator"></div>'+
													'</ul>'+
												'</div>'+
										'</div>'+
										'<div class="btnItemAdd hiddenObj">'+
											'+'+
										'</div>'+
										'<div class="btnItemDelete hiddenObj">'+
											'X'+
										'</div>'+
									'</div>'+
									'<div class="areaBoxCaption hiddenObj">'+
										'<div class="settingAreaBox emt-5">'+
											'<i style="font-size:20px;" class="feather icon-settings"></i>'+
										'</div>'+
										'<div class="deleteAreaBox emt-5">'+
											'<i style="font-size:20px;" class="feather icon-trash"></i>'+
										'</div>'+
										'<div class="upAreaTotalBox emt-5">'+
											'<i style="font-size:20px;" class="feather icon-chevron-up"></i>'+
										'</div>'+
										'<div class="downAreaTotalBox emt-5">'+
											'<i style="font-size:20px;" class="feather icon-chevron-down"></i>'+
										'</div>'+
									'</div>'+
								'</div>';

			$("#areaBoxList").append(htmlAreaString);

			var checkId = 1;
			$(".areaTotalBox").each(function(){
				$(this).attr("id", checkId);
				areaTotalId = checkId;
				checkId++;
			});
		});
		
		
		$(document).on("click", ".btnItemAdd", function(e){
			var areaCount = 0;
			$(this).parent().parent().find(".areaBox").each(function(){
				$(this).removeClass("borderOn");
				areaCount++;
				$(this).attr("id", "areaBox-"+areaCount);
			})
			areaCount++;
			var sectorPosition = 0;
			if(docType == "M"){
				sectorPosition = 2;
			}else if(docType == "T"){
				sectorPosition = 115;
			}else{
				sectorPosition = 193;
			}
			var htmlAreaString = '<div class="areaBox" id="areaBox-'+areaCount+'" data-line="1">'+
									'<div class="areaContents"></div>'+
									'<div class="areaTitle">'+
										'<div class="sectorNavigation" style="left:'+sectorPosition+'px">'+
												'<ul>'+
													'<li class="sectorlist sectorItem active" style="--clr:#f44336" data="text">'+
														'<a href="#">'+
															'<span class="sectorIcon"><i class="feather icon-type"></i></span>'+
														'</a>'+
													'</li>'+
													'<li class="sectorlist sectorItem" style="--clr:#f44336" data="image">'+
														'<a href="#">'+
															'<span class="sectorIcon"><i class="feather icon-image"></i></span>'+
														'</a>'+
													'</li>'+
													'<li class="sectorlist sectorItem" style="--clr:#f44336" data="movie">'+
														'<a href="#">'+
															'<span class="sectorIcon"><i class="feather icon-film"></i></span>'+
														'</a>'+
													'</li>'+
													'<li class="sectorlist sectorItem" style="--clr:#f44336" data="sound">'+
														'<a href="#">'+
															'<span class="sectorIcon"><i class="feather icon-mic"></i></span>'+
														'</a>'+
													'</li>'+
													'<li class="sectorlist sectorItem" style="--clr:#f44336" data="line">'+
														'<a href="#">'+
															'<span class="sectorIcon"><i class="feather icon-minus"></i></span>'+
														'</a>'+
													'</li>'+
													'<li class="sectorlist sectorItem" style="--clr:#f44336" data="file">'+
														'<a href="#">'+
															'<span class="sectorIcon"><i class="feather icon-paperclip"></i></span>'+
														'</a>'+
													'</li>'+
													'<li class="sectorlist sectorItem" style="--clr:#f44336" data="game">'+
														'<a href="#">'+
															'<span class="sectorIconHtml">GAME</span>'+
														'</a>'+
													'</li>'+
													'<div class="indicator"></div>'+
												'</ul>'+
											'</div>'+
									'</div>'+
									'<div class="btnItemAdd hiddenObj">'+
										'+'+
									'</div>'+
									'<div class="btnItemDelete hiddenObj">'+
										'X'+
									'</div>'+
								'</div>';
								
			$(this).parent().parent().append(htmlAreaString);
								
		});
		
		$(document).on("click", ".btnItemDelete", function(e){
			var areaCount = 0;
			$(this).parent().parent().find(".areaBox").each(function(){
				areaCount++;
			})
			if(1 == areaCount){
				$(this).parent().parent().remove();
				var checkId = 1;
				$(".areaTotalBox").each(function(){
					$(this).attr("id", checkId);
					areaTotalId = checkId;
					checkId++;
				});
			}else{
				$(this).parent().remove();
			}
			
			if(todoNewTasksidebar.hasClass('show')){
				todoNewTasksidebar.removeClass('show');
			}
			return false;
		});
		
		$(document).on("click", ".settingAreaBox", function(e){
			
			var areaTotalId = $(this).parent().parent().attr("id");
			
			$("#areaTotalId").val(areaTotalId);
			
			$(".rightArea").each(function(){
				if(!$(this).hasClass("hiddenObj")){
					$(this).addClass("hiddenObj")
				}
			})
			
			var totalColor = "";
			
			if("rgba(0, 0, 0, 0)" == $("#"+areaTotalId).css("background-color")){
				totalColor = "rgba(255, 255, 255)";
			}else{
				totalColor = $("#"+areaTotalId).css("background-color");
			}
			
			var htmlString = '<div class="inputBox"><input type="text" required="required" id="totalColor" class="required demo minicolors-input" data-format="rgb" data-opacity="1" style="height:calc(2.75rem + 2px)!important;" value="'+totalColor+'"/></div>';
			
			$("#totalColorArea").html(htmlString);
			
			$('.demo').each(function() {
			    $(this).minicolors({
			      control: $(this).attr('data-control') || 'hue',
			      defaultValue: $(this).attr('data-defaultValue') || '',
			      format: $(this).attr('data-format') || 'rgb',
			      keywords: $(this).attr('data-keywords') || '',
			      inline: $(this).attr('data-inline') === 'true',
			      letterCase: $(this).attr('data-letterCase') || 'lowercase',
			      opacity: $(this).attr('data-opacity'),
			      position: $(this).attr('data-position') || 'bottom',
			      swatches: $(this).attr('data-swatches') ? $(this).attr('data-swatches').split('|') : [],
			      change: function(hex, opacity) {
			        var log;
			        try {
			          log = hex ? hex : 'transparent';
			          if( opacity ) log += ', ' + opacity;
			          console.log(log);
			        } catch(e) {}
			      },
			      theme: 'default'
			        });
			 
			  });
			
			$("#totalSettingArea").removeClass("hiddenObj");
			if(!todoNewTasksidebar.hasClass('show')){
				todoNewTasksidebar.addClass('show');
			}
		})

		$(document).on("click", ".deleteAreaBox", function(e){
			if($(".areaTotalBox").length > 1){
				if(confirm("삭제 하시겠습니까?")){
					$(this).parent().parent().remove();
					var checkId = 1;
					$(".areaTotalBox").each(function(){
						$(this).attr("id", checkId);
						areaTotalId = checkId;
						checkId++;
					});
				}
			}else{
				alert("문단은 최소 1개이상 필요합니다.");
			}
		})

		$(document).on("change", ".backFile", function(){
		});

		$(document).on("click", ".backgroundAreaBox", function(){
			$(this).parent().parent().find(".backFile").click();
		});

		$(document).on("click", ".upAreaTotalBox", function(){
			var areaTotalId = parseInt($(this).parent().parent().attr("id"));
			areaTotalId--;			
			$(this).parent().parent().insertBefore($("#"+areaTotalId));
			var checkId = 1;
			$(".areaTotalBox").each(function(){
				$(this).attr("id", checkId);
				areaTotalId = checkId;
				checkId++;
			});
		});

		$(document).on("click", ".downAreaTotalBox", function(){
			var areaTotalId = parseInt($(this).parent().parent().attr("id"));
			areaTotalId++;			
			$(this).parent().parent().insertAfter($("#"+areaTotalId));
			var checkId = 1;
			$(".areaTotalBox").each(function(){
				$(this).attr("id", checkId);
				areaTotalId = checkId;
				checkId++;
			});
		});
		
		$(document).on("click", ".deletePage", function(){
			var contentsDetailId = $("#contents_detail_id").val();
			
			if(confirm("삭제 하시겠습니까?")){
				
				
				var params = $("form[name=parameterVO]").serialize();
				$.ajax({
					url : "${pageContext.request.contextPath}/deleteContentsDetail.json",
					type : "POST",
					data : params,
					success : function(result) {
						$("#contents_detail_id_"+contentsDetailId).parent().remove();
						$("#contents_detail_id").val("");
						$("#contents_detail_html").val("");
					}
				});
			}
			
			return false;
		});
		

		$(document).on("click", ".selector", function(){
			$(".selector").removeClass("on");
			if($(this).hasClass("selectType1")){
				if(!$(this).hasClass("on")){
					$(this).addClass("on");
				}
				$(".sectorNavigation").hide();

				$("#areaBoxList").stop().animate( {width: '800px' }, 500, 'swing', function(){
					$(".sectorNavigation").show();
				});
				docType = "P";
			}else if($(this).hasClass("selectType2")){
				if(!$(this).hasClass("on")){
					$(this).addClass("on");
				}

				$(".sectorNavigation").hide();

				$("#areaBoxList").stop().animate( {width: '650px'}, 500, 'swing', function(){
					$(".sectorNavigation").show();
				});
				docType = "T";
			}else if($(this).hasClass("selectType3")){
				if(!$(this).hasClass("on")){
					$(this).addClass("on");
				}
				
				$(".sectorNavigation").hide();

				$("#areaBoxList").stop().animate( {width: '425px'}, 500, 'swing', function(){
					$(".sectorNavigation").show();
				});
				docType = "M";
			}
		});
		
		
		$(document).on("click", ".makeHtml", function(){
			var orgHtmlString = $("#areaBoxList").html();
			var htmlString = "";
			$("#areaBoxList").each(function(){
				htmlString += $(this).html();
			})
			
			console.log(htmlString);
			$("#areaBoxList").html(orgHtmlString);
			
			$("#contents_detail_html").val(htmlString);
			
			var params = $("form[name=parameterVO]").serialize();
			
			console.log(params);
			$.ajax({
				url : "${pageContext.request.contextPath}/insertContentsDetail.json",
				type : "POST",
				data : params,
				success : function(result) {
					if (result.resultCode == "success") {
						
						alert("저장 되었습니다.");
					} else {
						
					}
				}
			});
		});
		
		$(document).on("click", ".spinBtn", function(e){
           	var areaBoxContentsId = $(this).attr("data");
           	fn_set(areaBoxContentsId);
           	
               if (wheelSpinning == false) {
                   if (wheelPower == 1) {
                       theWheel.animation.spins = 3;
                   } else if (wheelPower == 2) {
                       theWheel.animation.spins = 8;
                   } else if (wheelPower == 3) {
                       theWheel.animation.spins = 15;
                   }
                   
                   let pValue1 = parseFloat($("#"+areaBoxContentsId).find(".roulettePercent1").val());
                   let pValue2 = parseFloat($("#"+areaBoxContentsId).find(".roulettePercent2").val());
                   let pValue3 = parseFloat($("#"+areaBoxContentsId).find(".roulettePercent3").val());
                   let pValue4 = parseFloat($("#"+areaBoxContentsId).find(".roulettePercent4").val());
                   let pValue5 = parseFloat($("#"+areaBoxContentsId).find(".roulettePercent5").val());
                   let pValue6 = parseFloat($("#"+areaBoxContentsId).find(".roulettePercent6").val());
                   let pValue7 = parseFloat($("#"+areaBoxContentsId).find(".roulettePercent7").val());
                   let pValue8 = parseFloat($("#"+areaBoxContentsId).find(".roulettePercent8").val());
                   
                   let randomValue = Math.floor(Math.random() * 100);
                   
                   let stopAt = 0;
                   
                   let wheelCount = parseInt($("#gameNumber").val());
                   
                   let anglePoint = 360/wheelCount;
                   
                   if(randomValue < pValue1){
                	   console.log(":::::::::::"+pValue1);
                	   stopAt = (0 + Math.floor((Math.random() * anglePoint)));
                	   console.log("======================"+stopAt);
                   }else if(randomValue < pValue1+pValue2){
                	   console.log(":::::::::::"+pValue2);
                	   stopAt = (anglePoint + Math.floor((Math.random() * anglePoint)));
                	   console.log("======================"+stopAt);
                   }else if(randomValue < pValue1+pValue2+pValue3){
                	   console.log(":::::::::::"+pValue3);
                	   stopAt = (anglePoint*2 + Math.floor((Math.random() * anglePoint)));
                	   console.log("======================"+stopAt);
                   }else if(randomValue < pValue1+pValue2+pValue3+pValue4){
                	   console.log(":::::::::::"+pValue4);
                	   stopAt = (anglePoint*3 + Math.floor((Math.random() * anglePoint)));
                	   console.log("======================"+stopAt);
                   }else if(randomValue < pValue1+pValue2+pValue3+pValue4+pValue5){
                	   console.log(":::::::::::"+pValue5);
                	   stopAt = (anglePoint*4 + Math.floor((Math.random() * anglePoint)));
                	   console.log("======================"+stopAt);
                   }else if(randomValue < pValue1+pValue2+pValue3+pValue4+pValue5+pValue6){
                	   console.log(":::::::::::"+pValue6);
                	   stopAt = (anglePoint*5 + Math.floor((Math.random() * anglePoint)));
                	   console.log("======================"+stopAt);
                   }else if(randomValue < pValue1+pValue2+pValue3+pValue4+pValue5+pValue6+pValue7){
                	   console.log(":::::::::::"+pValue7);
                	   stopAt = (anglePoint*6 + Math.floor((Math.random() * anglePoint)));
                	   console.log("======================"+stopAt);
                   }else if(randomValue < pValue1+pValue2+pValue3+pValue4+pValue5+pValue6+pValue7+pValue8){
                	   console.log(":::::::::::"+pValue8);
                	   stopAt = (anglePoint*7 + Math.floor((Math.random() * anglePoint)));
                	   console.log("======================"+stopAt);
                   }
                   
                   
                   //console.log(stopAt);
                   // Important thing is to set the stopAngle of the animation before stating the spin.
                   theWheel.animation.stopAngle = stopAt;
            
                   // May as well start the spin from here.
                   theWheel.startAnimation();

                   wheelSpinning = true;
               }else{
               	theWheel.stopAnimation(false);  // Stop the animation, false as param so does not call callback function.
                   theWheel.rotationAngle = 0;     // Re-set the wheel angle to 0 degrees.
                   theWheel.draw();  
                   
                   wheelSpinning = false;
               }
         });
		
		$(document).on("keyup", ".numberformat", function(e){
           	var str = $(this).val();
           	var regex = /[^0-9]/g;				// 숫자가 아닌 문자열을 선택하는 정규식
           	var result = str.replace(regex, "");
           	$(this).val(result);
         });
		
		$(document).on("keyup", ".checkDetailName", function(e){
           	var str = $(this).val();
           	$("#contents_detail_name").val(str);
         });
		
	});
	
	function fn_check(){
		let check = /^[0-9]+$/; 
		if (!check.test(str)) {
		    console.log("숫자만 입력 가능합니다.");
		}
	}
	
	
	
  </script>
  <style>
  	

  </style>

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu content-left-sidebar todo-application  fixed-navbar" data-open="click" data-menu="vertical-menu" data-col="content-left-sidebar">
<div class="alert-pop-wrap" id="alertPopupWrap" style="display:none;">
			<!--태그현황 팝업-->
			
	</div>
    <!-- BEGIN: Header-->
    <!-- BEGIN: Header-->
    <c:import url="/systemTopMenu.do"/>
    <!-- END: Header-->
    <!-- BEGIN: Main Menu-->
    <div class="main-menu menu-fixed menu-dark menu-accordion menu-shadow" data-scroll-to-active="true">
        <c:import url="/systemLeftMenu.do"/>
    </div>
    <!-- END: Main Menu-->

    <!-- BEGIN: Content-->
    <div class="app-content content content-radius">
    	<div class="content-right" style="width: calc(100% - 15px) !important;">
    	<div class="todo-new-task-sidebar" style="width:400px;z-index:1200;background:var(--main-bg-color);">
    		<input type="hidden" id="areaTotalId" value="">
    		<input type="hidden" id="areaBoxId" value="">
    		<input type="hidden" id="areaBoxContentsId" value="">
			<div class="card shadow-none p-0 m-0">
				<div class="card-header border-bottom py-75">
					<div class="task-header d-flex justify-content-between align-items-center">
					</div>
					<button type="button" class="close close-icon">
						<i class="feather icon-x align-middle"></i>
					</button>
				</div>
				<!-- form start -->
				<div class="rightArea card-content hiddenObj" id="areaBoxSettingArea">
					<div class="card-body py-0 border-bottom">
						<div class="form-group">
							<!-- text area for task title -->
						</div>
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-3 fw-1000">
								문단 설정
							</div>
						</div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								여백
							</div>
						</div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="areaPositionT" class="required numberformat" /><span class="place-span">상단(px)</span></div>
						<div style="float:left;text-align:left;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="areaPositionL" class="required numberformat"/><span class="place-span">왼쪽(px)</span></div></div>
						<div style="float:right;text-align:right;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="areaPositionR" class="required numberformat"/><span class="place-span">오른쪽(px)</span></div></div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="areaPositionB" class="required numberformat"/><span class="place-span">하단(px)</span></div>
						<br/>
					</div>
					<div class="card-body py-0 border-bottom epb-30" id="cutSettingArea">
						
					</div>
					<div class="card-body py-0 border-bottom epb-30">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								정렬
							</div>
						</div>
						<button type="button" id="areaSettingLeft" class="alignButton btn settingLeft btn-primary" style="color:white;">왼  쪽</button>
						<button type="button" id="areaSettingCenter" class="alignButton btn eml-10 settingCenter btn-primary" style="color:white;">가운데</button>
						<button type="button" id="areaSettingRight" class="alignButton btn eml-10 settingRight btn-primary" style="color:white;">오른쪽</button>
					</div>
					<div class="card-body task-description">
						<div class="mt-1 d-flex justify-content-end">
							<button type="button" class="btn btn-primary settingArea">적용</button>
						</div>
					</div>
				</div>
				
				<div class="rightArea card-content hiddenObj" id="lineSettingArea">
					<div class="card-body py-0 border-bottom">
						<div class="form-group">
							<!-- text area for task title -->
						</div>
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-3 fw-1000">
								선 설정
							</div>
						</div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								사이즈
							</div>
						</div>
						<p><div class="inputBox"><input type="text" required="required" id="lineWidth" class="required numberformat"/><span class="place-span">넓이(%)</span></div>
						<p>두께 : <div class="inputBox"><input type="text" required="required" id="lineHeight" class="required numberformat"/><span class="place-span">두께(px)</span></div>
						<p id="lineColorArea"></p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								여백
							</div>
						</div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="linePositionT" class="required numberformat"/><span class="place-span">상단(px)</span></div>
						<div style="float:left;text-align:left;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="linePositionL" class="f-l required numberformat"/><span class="place-span">왼쪽(px)</span></div></div>
						<div style="float:right;text-align:right;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="linePositionR" class="f-l required numberformat"/><span class="place-span">오른쪽(px)</span></div></div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="linePositionB" class="required numberformat"/><span class="place-span">하단(px)</span></div>
						<br/>
					</div>
					<div class="card-body py-0 border-bottom epb-30">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								정렬
							</div>
						</div>
						<button type="button" id="lineSettingLeft" class="alignButton btn settingLeft btn-primary" style="color:white;">왼  쪽</button>
						<button type="button" id="lineSettingCenter" class="alignButton btn eml-10 settingCenter btn-primary" style="color:white;">가운데</button>
						<button type="button" id="lineSettingRight" class="alignButton btn eml-10 settingRight btn-primary" style="color:white;">오른쪽</button>
					</div>
					<div class="card-body task-description">
						<div class="mt-1 d-flex justify-content-end">
							<button type="button" class="btn btn-primary settingLine">확인</button>
						</div>
					</div>
				</div>
				
				<div class="rightArea card-content hiddenObj" id="textSettingArea">
					<div class="card-body py-0 border-bottom">
						<div class="form-group">
							<!-- text area for task title -->
						</div>
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-3 fw-1000">
								텍스트 설정
							</div>
						</div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								사이즈
							</div>
						</div>
						<p><div class="inputBox"><input type="text" required="required" id="textWidth" class="required numberformat"/><span class="place-span">넓이(px)</span></div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								여백
							</div>
						</div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="textPositionT" class="required numberformat"/><span class="place-span">상단(px)</span></div>
						<div style="float:left;text-align:left;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="textPositionL" class="required numberformat"/><span class="place-span">왼쪽(px)</span></div></div>
						<div style="float:right;text-align:right;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="textPositionR" class="required numberformat"/><span class="place-span">오른쪽(px)</span></div></div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="textPositionB" class="required numberformat"/><span class="place-span">하단(px)</span></div>
						<br/>
					</div>
					<div class="card-body task-description">
						<div class="mt-1 d-flex justify-content-end">
							<button type="button" class="btn btn-danger resetText emr-10 hiddenObj">수정</button>
							<button type="button" class="btn btn-primary settingText">확인</button>
						</div>
					</div>
				</div>
				
				<div class="rightArea card-content hiddenObj" id="imageSettingArea">
					<div class="card-body py-0 border-bottom">
						<div class="form-group">
							<!-- text area for task title -->
						</div>
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-3 fw-1000">
								이미지 설정
							</div>
						</div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								이미지 선택
							</div>
						</div>
						<p><input type="file" id="imageFileField" class="form-control-file fileupload"/><label for="imageFileField" class="btn btn-primary">업로드</label><label id="imageFileName" style="padding-left:20px;"></label></p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								사이즈
							</div>
						</div>
						<p><div class="inputBox"><input type="text" required="required" id="imageWidth" class="required numberformat"/><span class="place-span">넓이(%)</span></div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								여백
							</div>
						</div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="imagePositionT" class="required numberformat"/><span class="place-span">상단(px)</span></div>
						<div style="float:left;text-align:left;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="imagePositionL" class="f-l required numberformat"/><span class="place-span">왼쪽(px)</span></div></div>
						<div style="float:right;text-align:right;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="imagePositionR" class="f-l required numberformat"/><span class="place-span">오른쪽(px)</span></div></div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="imagePositionB" class="required numberformat"/><span class="place-span">하단(px)</span></div>
						<br/>
					</div>
					<div class="card-body py-0 border-bottom epb-30">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								정렬
							</div>
						</div>
						<button type="button" id="imageSettingLeftTop" class="alignButton btn settingLeft btn-primary" style="color:white;">o</button>
						<button type="button" id="imageSettingCenterTop" class="alignButton btn eml-10 settingLeft btn-primary" style="color:white;">o</button>
						<button type="button" id="imageSettingRightTop" class="alignButton btn eml-10 settingLeft btn-primary" style="color:white;">o</button>
						<br/>
						<button type="button" id="imageSettingLeftMiddle" class="alignButton btn emt-10 settingCenter btn-primary" style="color:white;">o</button>
						<button type="button" id="imageSettingCenterMiddle" class="alignButton btn emt-10 eml-10 settingCenter btn-primary" style="color:white;">o</button>
						<button type="button" id="imageSettingRightMiddle" class="alignButton btn emt-10 eml-10 settingCenter btn-primary" style="color:white;">o</button>
						<br/>
						<button type="button" id="imageSettingLeftBottom" class="alignButton btn emt-10 settingRight btn-primary" style="color:white;">o</button>
						<button type="button" id="imageSettingCenterBottom" class="alignButton btn emt-10 eml-10 settingRight btn-primary" style="color:white;">o</button>
						<button type="button" id="imageSettingRightBottom" class="alignButton btn emt-10 eml-10 settingRight btn-primary" style="color:white;">o</button>
						<!-- <button type="button" id="imageSettingLeftTop" class="alignButton btn settingLeft btn-primary" style="color:white;">o</button>
						<button type="button" id="imageSettingLeftMiddle" class="alignButton btn settingLeft btn-primary" style="color:white;">o</button>
						<button type="button" id="imageSettingLeftBottom" class="alignButton btn settingLeft btn-primary" style="color:white;">o</button>
						<button type="button" id="imageSettingCenter" class="alignButton btn eml-10 settingCenter btn-primary" style="color:white;">o</button>
						<button type="button" id="imageSettingRight" class="alignButton btn eml-10 settingRight btn-primary" style="color:white;">o</button> -->
					</div>
					<div class="card-body task-description">
						<div class="mt-1 d-flex justify-content-end">
							<button type="button" class="btn btn-primary settingImage">확인</button>
						</div>
					</div>
				</div>
				
				<div class="rightArea card-content hiddenObj" id="fileSettingArea">
					<div class="card-body py-0 border-bottom">
						<div class="form-group">
							<!-- text area for task title -->
						</div>
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-3 fw-1000">
								파일 설정
							</div>
						</div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								파일 선택
							</div>
						</div>
						<p><input type="file" id="fileFileField" class="form-control-file fileuploadFile"/><label for="fileFileField" class="btn btn-primary">업로드</label><label id="fileFileName" style="padding-left:20px;"></label></p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								다운로드 버튼 색상
							</div>
						</div>
						<p id="downloadColorArea"></p>
					</div>
					<div class="card-body task-description">
						<div class="mt-1 d-flex justify-content-end">
							<button type="button" class="btn btn-primary settingDownload">확인</button>
						</div>
					</div>
				</div>
				
				<div class="rightArea card-content hiddenObj" id="movieSettingArea">
					<div class="card-body py-0 border-bottom">
						<div class="form-group">
							<!-- text area for task title -->
						</div>
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-3 fw-1000">
								동영상 설정
							</div>
						</div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								동영상 선택
							</div>
						</div>
						<p><input type="file" id="movieFileField" class="form-control-file fileuploadMovie"/><label for="movieFileField" class="btn btn-primary">업로드</label><label id="movieFileName" style="padding-left:20px;"></label></p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								사이즈
							</div>
						</div>
						<p><div class="inputBox"><input type="text" required="required" id="movieWidth" class="required numberformat"/><span class="place-span">넓이(px)</span></div>
						<p><div class="inputBox"><input type="text" required="required" id="movieHeight" class="required numberformat"/><span class="place-span">높이(px)</span></div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								여백
							</div>
						</div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="moviePositionT" class="required numberformat"/><span class="place-span">상단(px)</span></div>
						<div style="float:left;text-align:left;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="moviePositionL" class="required numberformat"/><span class="place-span">왼쪽(px)</span></div></div>
						<div style="float:right;text-align:right;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="moviePositionR" class="required numberformat"/><span class="place-span">오른쪽(px)</span></div></div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="moviePositionB" class="required numberformat"/><span class="place-span">하단(px)</span></div>
						<br/>
					</div>
					<div class="card-body py-0 border-bottom epb-30">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								정렬
							</div>
						</div>
						<button type="button" id="movieSettingLeft" class="alignButton btn settingLeft btn-primary" style="color:white;">왼  쪽</button>
						<button type="button" id="movieSettingCenter" class="alignButton btn eml-10 settingCenter btn-primary" style="color:white;">가운데</button>
						<button type="button" id="movieSettingRight" class="alignButton btn eml-10 settingRight btn-primary" style="color:white;">오른쪽</button>
					</div>
					<div class="card-body task-description">
						<div class="mt-1 d-flex justify-content-end">
							<button type="button" class="btn btn-primary settingMovie">확인</button>
						</div>
					</div>
				</div>
				
				<div class="rightArea card-content hiddenObj" id="gameSettingArea">
					<div class="card-body py-0 border-bottom">
						<div class="form-group">
							<!-- text area for task title -->
						</div>
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-3 fw-1000">
								게임 설정
							</div>
						</div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								개수 설정
							</div>
						</div>
						<p>개수 : <div class="inputBox"><input type="text" required="required" id="gameNumber" class="w-50 required"/><span class="place-span">개수</span></div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								값 설정
							</div>
						</div>
						<div id="rouletteColorArea" style="display:inline-block;"></div>
					</div>
					<div class="card-body task-description">
						<div class="mt-1 d-flex justify-content-end">
							<button type="button" class="btn btn-primary settingGame">확인</button>
						</div>
					</div>
				</div>
				
				<div class="rightArea card-content hiddenObj" id="quizSettingArea">
					<div class="card-body py-0 border-bottom">
						<div class="form-group">
							<!-- text area for task title -->
						</div>
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-3 fw-1000">
								퀴즈 설정
							</div>
						</div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								질문 창 배경 색상
							</div>
						</div>
						<div id="quizColorArea" style="display:inline-block;"></div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								질문 폰트 색상
							</div>
						</div>
						<div id="quizFontColorArea" style="display:inline-block;"></div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								응답 창 배경 색상
							</div>
						</div>
						<div id="quizColorArea2" style="display:inline-block;"></div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								응답 폰트 색상
							</div>
						</div>
						<div id="quizFontColorArea2" style="display:inline-block;"></div>
					</div>
					<div class="card-body task-description">
						<div class="mt-1 d-flex justify-content-end">
							<button type="button" class="btn btn-primary settingQuiz">확인</button>
						</div>
					</div>
				</div>
				
				<div class="rightArea card-content hiddenObj" id="totalSettingArea">
					<div class="card-body py-0 border-bottom">
						<div class="form-group">
							<!-- text area for task title -->
						</div>
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-3 fw-1000">
								배경 설정
							</div>
						</div>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								배경 색상
							</div>
						</div>
						<p id="totalColorArea"></p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								배경 이미지 선택
							</div>
						</div>
						<p><input type="file" id="backFileField" class="form-control-file fileuploadBack"/><label for="backFileField" class="btn btn-primary">업로드</label><label id="backFileName" style="padding-left:20px;"></label></p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								여백
							</div>
						</div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="totalPositionT" class="required numberformat"/><span class="place-span">상단(px)</span></div>
						<div style="float:left;text-align:left;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="totalPositionL" class="required numberformat"/><span class="place-span">왼쪽(px)</span></div></div>
						<div style="float:right;text-align:right;margin-bottom:1rem;"><div class="inputBox"><input type="text" required="required" id="totalPositionR" class="required numberformat"/><span class="place-span">오른쪽(px)</span></div></div>
						<div class="inputBox m-auto-box"><input type="text" required="required" id="totalPositionB" class="required numberformat"/><span class="place-span">하단(px)</span></div>
						<br/>
					</div>
					<div class="card-body task-description">
						<div class="mt-1 d-flex justify-content-end">
							<button type="button" class="btn btn-primary settingTotal">확인</button>
						</div>
					</div>
				</div>
				<!-- form start end-->
			</div>
		</div>
        <div class="content-overlay"></div>
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body">
            	<h3 class="content-header-title mb-0 mt-1 pl-1">콘텐츠 관리</h3>
            	<div class="row breadcrumbs-top mb-1 pl-1">
						<div class="breadcrumb-wrapper col-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="/click/siteList.do">HOME</a>
								</li>
								<li class="breadcrumb-item"><a href="/click/contentsList.do">콘텐츠 DB</a>
								</li>
								<li class="breadcrumb-item active">공용 콘텐츠
								</li>
							</ol>
						</div>
					</div>
                <!-- users edit start -->
                <section id="bg-variants">
                	<div class="row">
                		<div class="col-md-4 col-sm-12">
                			<form name="parameterVO" id="parameterVO">
                				<input type="hidden" name="contents_id" id="contents_id" value="${parameterVO.contents_id}"/>
                				<input type="hidden" name="contents_detail_id" id="contents_detail_id" value="${parameterVO.contents_detail_id}"/>
                				<input type="hidden" name="contents_detail_name" id="contents_detail_name" value="${parameterVO.contents_detail_name}"/>
                				<input type="hidden" name="company_id" id="company_id" value="${parameterVO.company_id}"/>
                				<input type="hidden" name="contents_detail_html" id="contents_detail_html" value=""/>
		                		<div class="form-group">
		                        </div>
	                        </form>
                        </div>
                	</div>
                    <div class="row p-1" id="propertyList">
                    	<div class="col-md-2 col-sm-12" style="min-width:240px;max-width:260px;">
                    		<label class="filter-label fw-1000">페이지 목록</label>
                    		<div style="background-color:var(--main-bg-color);border-radius:10px;min-width:240px;padding:10px;">
                    			<div class="list-group" id="pageList">
                    			<c:if test="${fn:length(resultList) > 0}">
	                    			<c:forEach var="resultList" items="${resultList}" varStatus="status">
										<a href="#" class="required d-flex align-items-center justify-content-between contentsboard">
											<input type="text" class="checkDetailName page-card-input" id="contents_detail_name_${resultList.contents_detail_id}" value="${resultList.contents_detail_name}"/>
											<input type="hidden" class="checkDetailId" id="contents_detail_id_${resultList.contents_detail_id}" value="${resultList.contents_detail_id}"/>
										    <span class="bullet bullet-sm bullet-primary" style="margin-right:5px;"></span>
										</a>
		                           </c:forEach>
	                           </c:if>
	                           <c:if test="${fn:length(resultList) == 0}">
	                           		<a href="#" class="required d-flex align-items-center justify-content-between contentsboard onboard">
										<input type="text" class="checkDetailName page-card-input" id="contents_detail_name_1" value="페이지 1"/>
										<input type="hidden" class="checkDetailId" id="contents_detail_id_1" value="1"/>
									    <span class="bullet bullet-sm bullet-warning" style="margin-right:5px;"></span>
									</a>
	                           </c:if>
	                           </div>
	                           <div class="btn btn-primary pageAddButton" data-tooltip="페이지를 추가합니다.">
									페이지 추가
								</div>
                           </div>
                        </div>
                        <div class="col-sm-7 emt-30 eml-30" style="background-color:white;min-width:850px;border-radius:10px;">
                    		<div style="width:100%;">
								<div style="width:150px;margin:0 auto;height:50px;">
									<div class="selector selectType1 on"></div>
									<div class="selector selectType2"></div>
									<div class="selector selectType3"></div>
								</div>
							</div>
						 	<div id="areaBoxList" style="width:800px;margin:0 auto;">
								<div class="areaTotalBox" id="1">
									<div class="areaBox" id="1-areaBox-1" data-line="1">
										<div class="areaContents">
										</div>
										<div class="areaTitle">
											<div class="sectorNavigation">
												<ul>
													<li class="sectorlist sectorItem active" style="--clr:#f44336" data="text">
														<a href="#">
															<span class="sectorIcon"><i class="feather icon-type"></i></span>
														</a>
													</li>
													<li class="sectorlist sectorItem" style="--clr:#f44336" data="image">
														<a href="#">
															<span class="sectorIcon"><i class="feather icon-image"></i></span>
														</a>
													</li>
													<li class="sectorlist sectorItem" style="--clr:#f44336" data="movie">
														<a href="#">
															<span class="sectorIcon"><i class="feather icon-film"></i></span>
														</a>
													</li>
													<li class="sectorlist sectorItem" style="--clr:#f44336" data="sound">
														<a href="#">
															<span class="sectorIcon"><i class="feather icon-mic"></i></span>
														</a>
													</li>
													<li class="sectorlist sectorItem" style="--clr:#f44336" data="line">
														<a href="#">
															<span class="sectorIcon"><i class="feather icon-minus"></i></span>
														</a>
													</li>
													<li class="sectorlist sectorItem" style="--clr:#f44336" data="file">
														<a href="#">
															<span class="sectorIcon"><i class="feather icon-paperclip"></i></span>
														</a>
													</li>
													<li class="sectorlist sectorItem" style="--clr:#f44336" data="game">
														<a href="#">
															<span class="sectorIconHtml">GAME</span>
														</a>
													</li>
													<div class="indicator"></div>
												</ul>
											</div>
										</div>
										<div class="btnItemAdd hiddenObj">
											+
										</div>
										<div class="btnItemDelete hiddenObj">
											X
										</div>
									</div>
									<div class="areaBoxCaption hiddenObj">
										<div class="settingAreaBox emt-5">
											<i style="font-size:20px;" class="feather icon-settings"></i>
										</div>
										<div class="deleteAreaBox emt-5">
											<i style="font-size:20px;" class="feather icon-trash"></i>
										</div>
										<div class="upAreaTotalBox emt-5">
											<i style="font-size:20px;" class="feather icon-chevron-up"></i>
										</div>
										<div class="downAreaTotalBox emt-5">
											<i style="font-size:20px;" class="feather icon-chevron-down"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="btnArea" style="margin:10px auto;width:330px;">
								<div class="btn btn-primary areaAddButton" style="width:100px;float:left;" data-tooltip="문단을 추가합니다.">
									문단 추가
								</div>
								<div class="btn btn-secondary makeHtml" style="width:100px;float:left;margin:15px 0 15px 15px;" data-tooltip="저장">
									저장
								</div>
								<div class="btn btn-danger deletePage" style="width:100px;float:left;margin:15px 0 15px 15px;" data-tooltip="삭제">
									삭제
								</div>
							</div>
                        </div>
                        <div class="col-sm-3 emt-30">
                        	
                        </div>
                    </div>
                </section>
                <!-- users edit ends -->
            </div>
        </div>
        </div>
    </div>
    <!-- END: Content-->

    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

    <!-- BEGIN: Footer-->
    <footer class="footer footer-static footer-light navbar-border">
        <p class="clearfix blue-grey lighten-2 text-sm-center mb-0 px-2"><span class="float-md-left d-block d-md-inline-block">Copyright &copy; 2023 <a class="text-bold-800 grey darken-2" href="#" >클릭컨설팅 </a></span><span class="float-md-right d-none d-lg-block">Hand-crafted & Made with <i class="feather icon-heart pink"></i></span></p>
    </footer>
    <!-- END: Footer-->


    <!-- BEGIN: Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/daterange/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>
    
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/group.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/navs/navs.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/property-sub.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/editorPage.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/jquery.minicolors.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/jquery.minicolors.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/colorpicker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/quill/quill.js"></script>
    <script>
    let wheelPower    = 0;
    let wheelSpinning = false;
    let theWheel;
    function fn_set(areaBoxContentsId){
            // Create new wheel object specifying the parameters at creation time.
            theWheel = new Winwheel({
            	'canvasId'     : 'canvas'+areaBoxContentsId, 
                'numSegments'  : parseInt($("#"+areaBoxContentsId).find(".gameNumber").val()),     // Specify number of segments.
                'outerRadius'  : 180,   // Set outer radius so wheel fits inside the background.
                'textFontSize' : 26,    // Set font size as desired.
                'segments'     :        // Define segments including colour and text.
                [
                   {'fillStyle' : $("#"+areaBoxContentsId).find(".rouletteColor1").val(), 'text' : $("#"+areaBoxContentsId).find(".rouletteValue1").val()},
                   {'fillStyle' : $("#"+areaBoxContentsId).find(".rouletteColor2").val(), 'text' : $("#"+areaBoxContentsId).find(".rouletteValue2").val()},
                   {'fillStyle' : $("#"+areaBoxContentsId).find(".rouletteColor3").val(), 'text' : $("#"+areaBoxContentsId).find(".rouletteValue3").val()},
                   {'fillStyle' : $("#"+areaBoxContentsId).find(".rouletteColor4").val(), 'text' : $("#"+areaBoxContentsId).find(".rouletteValue4").val()},
                   {'fillStyle' : $("#"+areaBoxContentsId).find(".rouletteColor5").val(), 'text' : $("#"+areaBoxContentsId).find(".rouletteValue5").val()},
                   {'fillStyle' : $("#"+areaBoxContentsId).find(".rouletteColor6").val(), 'text' : $("#"+areaBoxContentsId).find(".rouletteValue6").val()},
                   {'fillStyle' : $("#"+areaBoxContentsId).find(".rouletteColor7").val(), 'text' : $("#"+areaBoxContentsId).find(".rouletteValue7").val()},
                   {'fillStyle' : $("#"+areaBoxContentsId).find(".rouletteColor8").val(), 'text' : $("#"+areaBoxContentsId).find(".rouletteValue8").val()}
                ],
                'animation' :           // Specify the animation to use.
                {
                    'type'     : 'spinToStop',
                    'duration' : 5,     // Duration in seconds.
                    'spins'    : 8,     // Number of complete spins.
                    'callbackFinished' : alertPrize
                }
            });

            // Vars used by the code in this page to do power controls.
            wheelPower    = 0;
            wheelSpinning = false;
    }

            // -------------------------------------------------------
            // Click handler for spin button.
            // -------------------------------------------------------
            // -------------------------------------------------------
            // Function for reset button.
            // -------------------------------------------------------
            function resetWheel()
            {
                theWheel.stopAnimation(false);  // Stop the animation, false as param so does not call callback function.
                theWheel.rotationAngle = 0;     // Re-set the wheel angle to 0 degrees.
                theWheel.draw();                // Call draw to render changes to the wheel.

                wheelSpinning = false;          // Reset to false to power buttons and spin can be clicked again.
            }

            // -------------------------------------------------------
            // Called when the spin animation has finished by the callback feature of the wheel because I specified callback in the parameters
            // note the indicated segment is passed in as a parmeter as 99% of the time you will want to know this to inform the user of their prize.
            // -------------------------------------------------------
            function alertPrize(indicatedSegment)
            {
                // Do basic alert of the segment text. You would probably want to do something more interesting with this information.
                alert(indicatedSegment.text);
            }
        </script>
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>