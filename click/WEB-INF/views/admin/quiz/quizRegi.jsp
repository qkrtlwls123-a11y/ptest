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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/quiz.css">
    <style>
  	
  </style>
  
  <script type="text/javascript">
  
  	var docType = "P";
	var areaTotalId = 1;
	var areaBoxContentsId="1_1-areaBox-1_contents"

	$(document).ready(function() {
		$("#game").addClass("active open");
		fn_quizSetting();
		todoNewTasksidebar.addClass('show');
		/*areaBox*/
		function fn_quizSetting(){
				var htmlString = '<div class="quizArea" style="padding:20px;">'+
				'<input type="hidden" class="quiz_count" value="5"/>'+
				'<input type="hidden" class="quizAnswer1" value=""/>'+
				'<input type="hidden" class="quizAnswer2" value=""/>'+
				'<input type="hidden" class="quizAnswer3" value=""/>'+
				'<input type="hidden" class="quizAnswer4" value=""/>'+
				'<input type="hidden" class="quizAnswer5" value=""/>'+
				'<input type="hidden" class="quizText1" value=""/>'+
				'<input type="hidden" class="quizText2" value=""/>'+
				'<input type="hidden" class="quizText3" value=""/>'+
				'<input type="hidden" class="quizText4" value=""/>'+
				'<input type="hidden" class="quizText5" value=""/>'+
				'<div style="border-radius:20px;width:90%;color:white;background-color:var(--main-bg-color);margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;">Q. 퀴즈 질문</div>'+
				'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:20px;border:1px solid #00dfc4;"><i class="fa fa-check"></i>&nbsp;문항1</div>'+
				'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="feather fa-check"></i>&nbsp;문항2</div>'+
				'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="feather fa-check"></i>&nbsp;문항3</div>'+
				'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="feather fa-check"></i>&nbsp;문항4</div>'+
				'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="feather fa-check"></i>&nbsp;문항5</div>'+
	        '</div>';
	        
			$("#"+areaBoxContentsId).html(htmlString);
			
			$(".rightArea").each(function(){
			if(!$(this).hasClass("hiddenObj")){
			$(this).addClass("hiddenObj")
			}
			})
			$("#quizSettingArea").removeClass("hiddenObj");
			
			todoNewTasksidebar.addClass('show');
		}
		
		function fn_quizSetting2(){
			var htmlString = '<div class="quizArea" style="padding:20px;">'+
			'<input type="hidden" class="quiz_count" value="5"/>'+
			'<input type="hidden" class="quizAnswer1" value=""/>'+
			'<input type="hidden" class="quizAnswer2" value=""/>'+
			'<input type="hidden" class="quizAnswer3" value=""/>'+
			'<input type="hidden" class="quizAnswer4" value=""/>'+
			'<input type="hidden" class="quizAnswer5" value=""/>'+
			'<input type="hidden" class="quizText1" value=""/>'+
			'<input type="hidden" class="quizText2" value=""/>'+
			'<input type="hidden" class="quizText3" value=""/>'+
			'<input type="hidden" class="quizText4" value=""/>'+
			'<input type="hidden" class="quizText5" value=""/>'+
			'<div style="border-radius:20px;width:90%;color:white;background-color:var(--main-bg-color);margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;">Q. 퀴즈 질문</div>'+
			'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:20px;border:1px solid #00dfc4;"><i class="feather fa-check"></i>&nbsp;정답1</div>'+
			'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="feather fa-check"></i>&nbsp;정답2</div>'+
			'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="feather fa-check"></i>&nbsp;정답3</div>'+
			'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="feather fa-check"></i>&nbsp;정답4</div>'+
			'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="feather fa-check"></i>&nbsp;정답5</div>'+
        '</div>';
        
		$("#"+areaBoxContentsId).html(htmlString);
		
		$(".rightArea").each(function(){
		if(!$(this).hasClass("hiddenObj")){
		$(this).addClass("hiddenObj")
		}
		})
		$("#quizSettingArea2").removeClass("hiddenObj");
		
		todoNewTasksidebar.addClass('show');
	}
		
		$(document).on("click", ".settingQuiz", function(){
			fn_settingQuiz();
		});
		
		$(document).on("click", ".settingQuiz2", function(){
			fn_settingQuiz2();
		});
		
		function fn_settingQuiz(){
			$("#"+areaBoxContentsId).find(".quiz_count").val($("#quiz_count").val());
			var wheelNumber = parseInt($("#"+areaBoxContentsId).find(".quiz_count").val());
			var quizAnswerCount = parseInt($("#quiz_answer_count").val());
			
			if(quizAnswerCount > wheelNumber){
				$("#quiz_answer_1").val("1");
				$("#quiz_answer_2").val("0");
				$("#quiz_answer_3").val("0");
				$("#quiz_answer_4").val("0");
				$("#quiz_answer_5").val("0");
			}else{
				$("#quiz_answer_1").val("0");
				$("#quiz_answer_1").val("0");
				$("#quiz_answer_1").val("0");
				$("#quiz_answer_1").val("0");
				$("#quiz_answer_1").val("0");
				$(".onNumber").each(function(index, item){
					if("1" == $(this).text()){
						$("#quiz_answer_1").val("1");
					}
					if("2" == $(this).text() && wheelNumber > 1){
						$("#quiz_answer_2").val("1");
					}
					if("3" == $(this).text() && wheelNumber > 2){
						$("#quiz_answer_3").val("1");
					}
					if("4" == $(this).text() && wheelNumber > 3){
						$("#quiz_answer_4").val("1");
					}
					if("5" == $(this).text() && wheelNumber > 4){
						$("#quiz_answer_5").val("1");
					}
				})
			}
			
			if(undefined == $("#quizText1").val()){
				$("#"+areaBoxContentsId).find(".quizText1").val("");
				$("#"+areaBoxContentsId).find(".quizAnswer1").val("");
			}else{
				$("#"+areaBoxContentsId).find(".quizText1").val($("#quizText1").val());
				$("#"+areaBoxContentsId).find(".quizAnswer1").val($("#quiz_answer_1").val());
			}
			if(undefined == $("#quizText2").val()){
				$("#"+areaBoxContentsId).find(".quizText2").val("");
				$("#"+areaBoxContentsId).find(".quizAnswer2").val("");
			}else{
				$("#"+areaBoxContentsId).find(".quizText2").val($("#quizText2").val());
				$("#"+areaBoxContentsId).find(".quizAnswer2").val($("#quiz_answer_2").val());
			}
			if(undefined == $("#quizText3").val()){
				$("#"+areaBoxContentsId).find(".quizText3").val("");
				$("#"+areaBoxContentsId).find(".quizAnswer3").val("");
			}else{
				$("#"+areaBoxContentsId).find(".quizText3").val($("#quizText3").val());
				$("#"+areaBoxContentsId).find(".quizAnswer3").val($("#quiz_answer_3").val());
			}
			if(undefined == $("#quizText4").val()){
				$("#"+areaBoxContentsId).find(".quizText4").val("");
				$("#"+areaBoxContentsId).find(".quizAnswer4").val("");
			}else{
				$("#"+areaBoxContentsId).find(".quizText4").val($("#quizText4").val());
				$("#"+areaBoxContentsId).find(".quizAnswer4").val($("#quiz_answer_4").val());
			}
			if(undefined == $("#quizText5").val()){
				$("#"+areaBoxContentsId).find(".quizText5").val("");
				$("#"+areaBoxContentsId).find(".quizAnswer5").val("");
			}else{
				$("#"+areaBoxContentsId).find(".quizText5").val($("#quizText5").val());
				$("#"+areaBoxContentsId).find(".quizAnswer5").val($("#quiz_answer_5").val());
			}
			
			fn_settingQuizDetail(areaBoxContentsId);
		}
		
		function fn_settingQuiz2(){
			if(undefined == $("#quizTextS1").val()){
				$("#"+areaBoxContentsId).find(".quizText1").val("");
			}else{
				$("#"+areaBoxContentsId).find(".quizText1").val($("#quizTextS1").val());
			}
			if(undefined == $("#quizTextS2").val()){
				$("#"+areaBoxContentsId).find(".quizText2").val("");
			}else{
				$("#"+areaBoxContentsId).find(".quizText2").val($("#quizTextS2").val());
			}
			if(undefined == $("#quizTextS3").val()){
				$("#"+areaBoxContentsId).find(".quizText3").val("");
			}else{
				$("#"+areaBoxContentsId).find(".quizText3").val($("#quizTextS3").val());
			}
			if(undefined == $("#quizTextS4").val()){
				$("#"+areaBoxContentsId).find(".quizText4").val("");
			}else{
				$("#"+areaBoxContentsId).find(".quizText4").val($("#quizTextS4").val());
			}
			if(undefined == $("#quizTextS5").val()){
				$("#"+areaBoxContentsId).find(".quizText5").val("");
			}else{
				$("#"+areaBoxContentsId).find(".quizText5").val($("#quizTextS5").val());
			}
			
			fn_settingQuizDetail2(areaBoxContentsId);
		}
		
		$(document).on("click", ".typeM", function(){
			$(".rightArea").each(function(){
				if(!$(this).hasClass("hiddenObj")){
					$(this).addClass("hiddenObj")
				}
			})
			
			$("#quizSettingArea").removeClass("hiddenObj");
			
			todoNewTasksidebar.addClass('show');
			fn_quizSetting();
			fn_settingQuiz();
		});
		
		$(document).on("click", ".typeS", function(){
			$(".rightArea").each(function(){
				if(!$(this).hasClass("hiddenObj")){
					$(this).addClass("hiddenObj")
				}
			})
			
			$("#quizSettingArea2").removeClass("hiddenObj");
			
			todoNewTasksidebar.addClass('show');
			fn_quizSetting2();
			fn_settingQuiz2();
		});
		
		function fn_settingQuizDetail(areaBoxContentsId){
			var wheelNumber = parseInt($("#"+areaBoxContentsId).find(".quiz_count").val());
			$("#quiz_count").val(wheelNumber);
			
			var quizText1 = $("#"+areaBoxContentsId).find(".quizText1").val();
			var quizText2 = $("#"+areaBoxContentsId).find(".quizText2").val();
			var quizText3 = $("#"+areaBoxContentsId).find(".quizText3").val();
			var quizText4 = $("#"+areaBoxContentsId).find(".quizText4").val();
			var quizText5 = $("#"+areaBoxContentsId).find(".quizText5").val();
			
			var quizAnswerCount = parseInt($("#quiz_answer_count").val())
			
			var htmlString = "";
			
			for(var i=1; i<wheelNumber+1; i++){
				if(i==1){
					htmlString += '<div class="d-ib"><div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText'+i+'" name="quiz_text_'+i+'"  class="required" value="'+quizText1+'"/><span class="place-span">문항 '+i+'</span></div>';
				}else if(i==2){
					htmlString += '<div class="d-ib"><div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText'+i+'" name="quiz_text_'+i+'"  class="required" value="'+quizText2+'"/><span class="place-span">문항 '+i+'</span></div>';
				}else if(i==3){
					htmlString += '<div class="d-ib"><div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText'+i+'" name="quiz_text_'+i+'"  class="required" value="'+quizText3+'"/><span class="place-span">문항 '+i+'</span></div>';
				}else if(i==4){
					htmlString += '<div class="d-ib"><div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText'+i+'" name="quiz_text_'+i+'"  class="required" value="'+quizText4+'"/><span class="place-span">문항 '+i+'</span></div>';
				}else if(i==5){
					htmlString += '<div class="d-ib"><div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText'+i+'" name="quiz_text_'+i+'"  class="required" value="'+quizText5+'"/><span class="place-span">문항 '+i+'</span></div>';
				}
				
			}
			
			$("#quizColorArea").html(htmlString);
			
			var htmlString2 = "";
			if(quizAnswerCount > wheelNumber){
				quizAnswerCount = 1;
				htmlString2 += '<p><div class="inputBox"><input type="text" required="required" id="quiz_answer_count" name="quiz_answer_count" class="w-50 required numberformat" value="'+quizAnswerCount+'"  maxlength="1"/><span class="place-span">개수</span></div>';
				
				if(wheelNumber==1){
					htmlString2 +=  '<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber onNumber">1</div></div>';
				}else if(wheelNumber==2){
					htmlString2 += '<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber onNumber">1</div><div class="quizNumber">2</div></div>';
				}else if(wheelNumber==3){
					htmlString2 += '<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber onNumber">1</div><div class="quizNumber">2</div><div class="quizNumber">3</div></div>';
				}else if(wheelNumber==4){
					htmlString2 += '<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber onNumber">1</div><div class="quizNumber">2</div><div class="quizNumber">3</div><div class="quizNumber">4</div></div>';
				}else if(wheelNumber==5){
					htmlString2 += '<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber onNumber">1</div><div class="quizNumber">2</div><div class="quizNumber">3</div><div class="quizNumber">4</div><div class="quizNumber">5</div></div>';
				}
				$("#quizAnswerArea").html(htmlString2);
			}else{
				var onNumber1 = "";
				var onNumber2 = "";
				var onNumber3 = "";
				var onNumber4 = "";
				var onNumber5 = "";
				var checkAnswerPoint1 = "feather fa-check";
				var checkAnswerPoint2 = "feather fa-check";
				var checkAnswerPoint3 = "feather fa-check";
				var checkAnswerPoint4 = "feather fa-check";
				var checkAnswerPoint5 = "feather fa-check";
				if($("#quiz_answer_1").val() == "1"){
					onNumber1 = "onNumber";
					checkAnswerPoint1 = "fa fa-check";
				}
				if($("#quiz_answer_2").val() == "1"){
					onNumber2 = "onNumber";
					checkAnswerPoint2 = "fa fa-check";
				}
				if($("#quiz_answer_3").val() == "1"){
					onNumber3 = "onNumber";
					checkAnswerPoint3 = "fa fa-check";
				}
				if($("#quiz_answer_4").val() == "1"){
					onNumber4 = "onNumber";
					checkAnswerPoint4 = "fa fa-check";
				}
				if($("#quiz_answer_5").val() == "1"){
					onNumber5 = "onNumber";
					checkAnswerPoint5 = "fa fa-check";
				}
				
				htmlString2 += '<p><div class="inputBox"><input type="text" required="required" id="quiz_answer_count" name="quiz_answer_count" class="w-50 required numberformat" value="'+quizAnswerCount+'"  maxlength="1"/><span class="place-span">개수</span></div>';
				
				if(wheelNumber==1){
					htmlString2 +=  '<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber '+onNumber1+'">1</div></div>';
				}else if(wheelNumber==2){
					htmlString2 += '<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber '+onNumber1+'">1</div><div class="quizNumber '+onNumber2+'">2</div></div>';
				}else if(wheelNumber==3){
					htmlString2 += '<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber '+onNumber1+'">1</div><div class="quizNumber '+onNumber2+'">2</div><div class="quizNumber '+onNumber3+'">3</div></div>';
				}else if(wheelNumber==4){
					htmlString2 += '<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber '+onNumber1+'">1</div><div class="quizNumber '+onNumber2+'">2</div><div class="quizNumber '+onNumber3+'">3</div><div class="quizNumber '+onNumber4+'">4</div></div>';
				}else if(wheelNumber==5){
					htmlString2 += '<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber '+onNumber1+'">1</div><div class="quizNumber '+onNumber2+'">2</div><div class="quizNumber '+onNumber3+'">3</div><div class="quizNumber '+onNumber4+'">4</div><div class="quizNumber '+onNumber5+'">5</div></div>';
				}
				$("#quizAnswerArea").html(htmlString2);
				
	        	let htmlString4 = '';
	        	for(let i=0;i<wheelNumber;i++){
	        		if(i==0){
	        			htmlString4 += '<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:20px;border:1px solid #00dfc4;"><i class="'+checkAnswerPoint1+'"></i>&nbsp;'+quizText1+'</div>';
	        		}else if(i==1){
	        			htmlString4 += '<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="'+checkAnswerPoint2+'"></i>&nbsp;'+quizText2+'</div>';
	        		}else if(i==2){
	        			htmlString4 += '<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="'+checkAnswerPoint3+'"></i>&nbsp;'+quizText3+'</div>';
	        		}else if(i==3){
	        			htmlString4 += '<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="'+checkAnswerPoint4+'"></i>&nbsp;'+quizText4+'</div>';
	        		}else if(i==4){
	        			htmlString4 += '<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="'+checkAnswerPoint5+'"></i>&nbsp;'+quizText5+'</div>';
	        		}
	        	}
	        	
	        	var htmlString3 = '<div class="quizArea" style="padding:20px;">'+
				'<input type="hidden" class="quiz_count" value="'+wheelNumber+'"/>'+
				'<input type="hidden" class="quiz_answer_count" value="'+quizAnswerCount+'"/>'+
				'<input type="hidden" class="quizAnswer1" value="'+$("#quiz_answer_1").val()+'"/>'+
				'<input type="hidden" class="quizAnswer2" value="'+$("#quiz_answer_2").val()+'"/>'+
				'<input type="hidden" class="quizAnswer3" value="'+$("#quiz_answer_3").val()+'"/>'+
				'<input type="hidden" class="quizAnswer4" value="'+$("#quiz_answer_4").val()+'"/>'+
				'<input type="hidden" class="quizAnswer5" value="'+$("#quiz_answer_5").val()+'"/>'+
				'<input type="hidden" class="quizText1" value="'+quizText1+'"/>'+
				'<input type="hidden" class="quizText2" value="'+quizText2+'"/>'+
				'<input type="hidden" class="quizText3" value="'+quizText3+'"/>'+
				'<input type="hidden" class="quizText4" value="'+quizText4+'"/>'+
				'<input type="hidden" class="quizText5" value="'+quizText5+'"/>'+
				'<div style="border-radius:20px;width:90%;color:white;background-color:var(--main-bg-color);margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;">Q. '+$("#quiz_name").val()+'</div>'+
				htmlString4+'</div>';
	        	
	        
				$("#"+areaBoxContentsId).html(htmlString3);
			}
		}
		
		function fn_settingQuizDetail2(areaBoxContentsId){
			var quizText1 = $("#"+areaBoxContentsId).find(".quizText1").val();
			var quizText2 = $("#"+areaBoxContentsId).find(".quizText2").val();
			var quizText3 = $("#"+areaBoxContentsId).find(".quizText3").val();
			var quizText4 = $("#"+areaBoxContentsId).find(".quizText4").val();
			var quizText5 = $("#"+areaBoxContentsId).find(".quizText5").val();
			
			var quizAnswerCount = parseInt($("#quiz_answer_count").val())
			
			var htmlString = "";
			
			for(var i=1; i<6; i++){
				if(i==1){
					htmlString += '<div class="d-ib"><div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText'+i+'" name="quiz_text_'+i+'"  class="required" value="'+quizText1+'"/><span class="place-span">정답 '+i+'</span></div>';
				}else if(i==2){
					htmlString += '<div class="d-ib"><div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText'+i+'" name="quiz_text_'+i+'"  class="required" value="'+quizText2+'"/><span class="place-span">정답 '+i+'</span></div>';
				}else if(i==3){
					htmlString += '<div class="d-ib"><div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText'+i+'" name="quiz_text_'+i+'"  class="required" value="'+quizText3+'"/><span class="place-span">정답 '+i+'</span></div>';
				}else if(i==4){
					htmlString += '<div class="d-ib"><div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText'+i+'" name="quiz_text_'+i+'"  class="required" value="'+quizText4+'"/><span class="place-span">정답 '+i+'</span></div>';
				}else if(i==5){
					htmlString += '<div class="d-ib"><div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText'+i+'" name="quiz_text_'+i+'"  class="required" value="'+quizText5+'"/><span class="place-span">정답 '+i+'</span></div>';
				}
				
			}
			
			$("#quizColorArea").html(htmlString);
			
			var htmlString2 = "";
			var onNumber1 = "";
			var onNumber2 = "";
			var onNumber3 = "";
			var onNumber4 = "";
			var onNumber5 = "";
			
			var htmlString3 = '<div class="quizArea" style="padding:20px;">'+
			'<input type="hidden" class="quiz_count" value="0"/>'+
			'<input type="hidden" class="quiz_answer_count" value="0"/>'+
			'<input type="hidden" class="quizAnswer1" value="'+$("#quiz_answer_1").val()+'"/>'+
			'<input type="hidden" class="quizAnswer2" value="'+$("#quiz_answer_2").val()+'"/>'+
			'<input type="hidden" class="quizAnswer3" value="'+$("#quiz_answer_3").val()+'"/>'+
			'<input type="hidden" class="quizAnswer4" value="'+$("#quiz_answer_4").val()+'"/>'+
			'<input type="hidden" class="quizAnswer5" value="'+$("#quiz_answer_5").val()+'"/>'+
			'<input type="hidden" class="quizText1" value="'+quizText1+'"/>'+
			'<input type="hidden" class="quizText2" value="'+quizText2+'"/>'+
			'<input type="hidden" class="quizText3" value="'+quizText3+'"/>'+
			'<input type="hidden" class="quizText4" value="'+quizText4+'"/>'+
			'<input type="hidden" class="quizText5" value="'+quizText5+'"/>'+
			'<div style="border-radius:20px;width:90%;color:white;background-color:var(--main-bg-color);margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;">Q. '+$("#quiz_nameS").val()+'</div>'+
			'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:20px;border:1px solid #00dfc4;"><i class="fa fa-check"></i>&nbsp;'+quizText1+'</div>'+
			'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="fa fa-check"></i>&nbsp;'+quizText2+'</div>'+
			'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="fa fa-check"></i>&nbsp;'+quizText3+'</div>'+
			'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="fa fa-check"></i>&nbsp;'+quizText4+'</div>'+
			'<div style="border-radius:20px;width:90%;color:var(--main-bg-color);background-color:white;margin:0 auto;height:30px;line-height:30px;text-align:left;padding-left:20px;margin-top:10px;border:1px solid #00dfc4;"><i class="fa fa-check"></i>&nbsp;'+quizText5+'</div>'+
        	'</div>';
			$("#"+areaBoxContentsId).html(htmlString3);
		}
		
		$(document).on("keyup", ".numberformat", function(e){
           	var str = $(this).val();
           	var regex = /[^0-9]/g;				// 숫자가 아닌 문자열을 선택하는 정규식
           	var result = str.replace(regex, "");
           	$(this).val(result);
         });
		
		$(document).on("click", ".insertQuiz", function(){
			var onNumberCount = 0;
			$(".onNumber").each(function(index, item){
				if("1" == $(this).text()){
					$("#quiz_answer_1").val("1");
				}else if("2" == $(this).text()){
					$("#quiz_answer_2").val("1");
				}else if("3" == $(this).text()){
					$("#quiz_answer_3").val("1");
				}else if("4" == $(this).text()){
					$("#quiz_answer_4").val("1");
				}else if("5" == $(this).text()){
					$("#quiz_answer_5").val("1");
				}
				onNumberCount++;
			})
			
			$("#quiz_answer_count").val(onNumberCount);
			
			var params = $("form[id=parameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/insertQuiz.json",
				type : "POST",
				data : params,
				success : function(result) {
					if (result.resultCode == "success") {
						
						alert("등록되었습니다.");
						location.href = "${pageContext.request.contextPath}/quizList.do";
					} else {
						
					}
				}
			});
		});
		
		$(document).on("click", ".insertQuiz2", function(){
			var onNumberCount = 0;
			$(".onNumber").each(function(index, item){
				if("1" == $(this).text()){
					$("#quiz_answer_1").val("1");
				}else if("2" == $(this).text()){
					$("#quiz_answer_2").val("1");
				}else if("3" == $(this).text()){
					$("#quiz_answer_3").val("1");
				}else if("4" == $(this).text()){
					$("#quiz_answer_4").val("1");
				}else if("5" == $(this).text()){
					$("#quiz_answer_5").val("1");
				}
				onNumberCount++;
			})
			
			$("#quiz_answer_count").val(onNumberCount);
			
			var params = $("form[id=parameterVO2]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/insertQuiz.json",
				type : "POST",
				data : params,
				success : function(result) {
					if (result.resultCode == "success") {
						
						alert("등록되었습니다.");
						location.href = "${pageContext.request.contextPath}/quizList.do";
					} else {
						
					}
				}
			});
		});
		
		$(document).on("click", ".quizNumber", function(){
			var quizAnswerCount = parseInt($("#quiz_answer_count").val());
			var onNumberCount = 0;
			
			$(".onNumber").each(function(){
				onNumberCount++;
			})
			
			if($(this).hasClass("onNumber")){
				$(this).removeClass("onNumber");
			}else{
				if(onNumberCount < quizAnswerCount){
					$(this).addClass("onNumber");
				}
			}
		});
		
		$(document).on("keyup", "#quiz_answer_count", function(){
			var quizAnswerCount = parseInt($(this).val());
			var onNumberCount = 0;
			
			$(".onNumber").each(function(){
				onNumberCount++;
			})
			
			if(quizAnswerCount < onNumberCount){
				$(".onNumber").each(function(){
					$(this).removeClass("onNumber");
				})
			}
		});
		
		$(document).on("keyup", ".numberformat", function(e){
           	var str = $(this).val();
           	var regex = /[^0-9]/g;				// 숫자가 아닌 문자열을 선택하는 정규식
           	var result = str.replace(regex, "");
           	$(this).val(result);
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

<body class="vertical-layout vertical-menu content-left-sidebar todo-application  fixed-navbar" data-open="click" data-menu="vertical-menu-modern" data-col="content-left-sidebar">

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
    	<div class="todo-new-task-sidebar" style="width:400px;z-index:1200;background:var(--main-bg-color);">
			<div class="card shadow-none p-0 m-0">
				<div class="card-header border-bottom py-75">
					<div class="task-header d-flex justify-content-between align-items-center">
					</div>
					<button type="button" class="close close-icon">
						<i class="feather icon-x align-middle"></i>
					</button>
				</div>
				<!-- form start -->
				<div class="rightArea card-content" id="quizSettingArea">
					<form name="parameterVO" id="parameterVO">
						<input type="hidden" name="company_id" value="${parameterVO.company_id}"/>
						<input type="hidden" name="quiz_answer_1" id="quiz_answer_1" value="0"/>
						<input type="hidden" name="quiz_answer_2" id="quiz_answer_2" value="0"/>
						<input type="hidden" name="quiz_answer_3" id="quiz_answer_3" value="0"/>
						<input type="hidden" name="quiz_answer_4" id="quiz_answer_4" value="0"/>
						<input type="hidden" name="quiz_answer_5" id="quiz_answer_5" value="0"/>
						<input type="hidden" name="quiz_type" id="quiz_type" value="M"/>
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
									퀴즈 타입
								</div>
							</div>
							<button type="button" class="btn btn-primary">객관식</button>
							<button type="button" class="btn typeS" style="border:1px solid rgba(255,255,255,0.35);color:rgba(255,255,255,0.35)">주관식</button>
							<p></p>
						</div>
						<div class="card-body py-0 border-bottom">
							<div class="assigned d-flex justify-content-between">
								<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
									퀴즈 게임 명 설정
								</div>
							</div>
							<p><div class="inputBox quizInput2"><input type="text" required="required" id="quiz_name" name="quiz_name" class="required" value=""/><span class="place-span">퀴즈 질문</span></div>
						</div>
						<div class="card-body py-0 border-bottom">
							<div class="assigned d-flex justify-content-between">
								<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
									문항 개수 설정
								</div>
							</div>
							<p><div class="inputBox"><input type="text" required="required" id="quiz_count" name="quiz_count" class="w-50 required numberformat" value="5" maxlength="1"/><span class="place-span">개수</span></div>
						</div>
						<div class="card-body py-0 border-bottom">
							<div class="assigned d-flex justify-content-between">
								<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
									문항 설정
								</div>
							</div>
							<div id="quizColorArea" style="display:inline-block;">
								<div class="d-ib">
									<div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText1" name="quiz_text_1" class="required" value=""/><span class="place-span">문항 1</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText2" name="quiz_text_2" class="required" value=""/><span class="place-span">문항 2</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText3" name="quiz_text_3" class="required" value=""/><span class="place-span">문항 3</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText4" name="quiz_text_4" class="required" value=""/><span class="place-span">문항 4</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizText5" name="quiz_text_5" class="required" value=""/><span class="place-span">문항 5</span></div>
								</div>
							</div>
						</div>
						<div class="card-body py-0 border-bottom">
							<div class="assigned d-flex justify-content-between">
								<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
									정답 개수 설정
								</div>
							</div>
							<div id="quizAnswerArea" style="display:inline-block;">
								<p><div class="inputBox"><input type="text" required="required" id="quiz_answer_count" name="quiz_answer_count" class="w-50 required numberformat" value="1"  maxlength="1"/><span class="place-span">개수</span></div>
								<p><div class="inputBox" style="height:40px;width:300px;"><div class="quizNumber onNumber">1</div><div class="quizNumber">2</div><div class="quizNumber">3</div><div class="quizNumber">4</div><div class="quizNumber">5</div></div>
							</div>
						</div>
						<div class="card-body task-description">
							<div class="mt-1 d-flex justify-content-end">
								<button type="button" class="btn btn-primary settingQuiz">확인</button>
								<button type="button" class="btn btn-success insertQuiz ml-1">저장</button>
							</div>
						</div>
					</form>
				</div>
				<div class="rightArea card-content" id="quizSettingArea2">
					<form name="parameterVO" id="parameterVO2">
						<input type="hidden" name="company_id" value="${parameterVO.company_id}"/>
						<input type="hidden" name="quiz_answer_1" id="quiz_answer_1" value="0"/>
						<input type="hidden" name="quiz_answer_2" id="quiz_answer_2" value="0"/>
						<input type="hidden" name="quiz_answer_3" id="quiz_answer_3" value="0"/>
						<input type="hidden" name="quiz_answer_4" id="quiz_answer_4" value="0"/>
						<input type="hidden" name="quiz_answer_5" id="quiz_answer_5" value="0"/>
						<input type="hidden" name="quiz_type" id="quiz_type" value="S"/>
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
									퀴즈 타입
								</div>
							</div>
							<button type="button" class="btn typeM" style="border:1px solid rgba(255,255,255,0.35);color:rgba(255,255,255,0.35)">객관식</button>
							<button type="button" class="btn btn-primary">주관식</button>
							<p></p>
						</div>
						<div class="card-body py-0 border-bottom">
							<div class="assigned d-flex justify-content-between">
								<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
									퀴즈 게임 명 설정
								</div>
							</div>
							<p><div class="inputBox quizInput2"><input type="text" required="required" id="quiz_nameS" name="quiz_name" class="required" value=""/><span class="place-span">퀴즈 질문</span></div>
						</div>
						<div class="card-body py-0 border-bottom">
							<div class="assigned d-flex justify-content-between">
								<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
									정답 설정
								</div>
							</div>
							<div id="quizColorArea" style="display:inline-block;">
								<div class="d-ib">
									<div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizTextS1" name="quiz_text_1" class="required" value=""/><span class="place-span">정답 1</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizTextS2" name="quiz_text_2" class="required" value=""/><span class="place-span">정답 2</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizTextS3" name="quiz_text_3" class="required" value=""/><span class="place-span">정답 3</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizTextS4" name="quiz_text_4" class="required" value=""/><span class="place-span">정답 4</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l quizInput2"><input type="text" required="required" id="quizTextS5" name="quiz_text_5" class="required" value=""/><span class="place-span">정답 5</span></div>
								</div>
							</div>
						</div>
						<div class="card-body task-description">
							<div class="mt-1 d-flex justify-content-end">
								<button type="button" class="btn btn-primary settingQuiz2">확인</button>
								<button type="button" class="btn btn-success insertQuiz2 ml-1">저장</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
        <div class="content-overlay"></div>
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body">
            	<h3 class="content-header-title mb-0 mt-1 pl-1">퀴즈 관리</h3>
					<div class="row breadcrumbs-top mb-1 pl-1">
						<div class="breadcrumb-wrapper col-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/siteList.do">HOME</a>
								</li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/quizList.do">게임 관리</a>
								</li>
								<li class="breadcrumb-item active">퀴즈 등록
								</li>
							</ol>
						</div>
					</div>
                <!-- users edit start -->
                <section id="bg-variants">
                    <div class="row p-1" id="propertyList">
                    	<div class="col-md-2 col-sm-12" style="min-width:240px;">
                        </div>
                        <div class="col-sm-7 emt-30" style="background-color:white;min-width:850px;">
						 	<div id="areaBoxList" style="width:800px;margin:0 auto;">
								<div class="areaTotalBox" id="1">
									<div class="areaBox" id="1-areaBox-1" data-line="1">
										<div class="areaContents" id="1_1-areaBox-1_contents" data="quiz">
										</div>
									</div>
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
    <!-- END: Content-->

    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

    <!-- BEGIN: Footer-->
    <footer class="footer footer-static footer-light navbar-border">
        <p class="clearfix blue-grey lighten-2 text-sm-center mb-0 px-2"><span class="float-md-left d-block d-md-inline-block">Copyright &copy; 2023 <a class="text-bold-800 grey darken-2" href="#" >클릭컨설팅 </a></span></p>
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
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>