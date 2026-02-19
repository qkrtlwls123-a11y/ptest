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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/roulette.css">
    <style>
  	
  </style>
  
  <script type="text/javascript">
  
  	var docType = "P";
	var areaTotalId = 1;
	var areaBoxContentsId="1_1-areaBox-1_contents"

	$(document).ready(function() {
		$("#game").addClass("active open");
		fn_gameSetting();
		todoNewTasksidebar.addClass('show');
		/*areaBox*/
		function fn_gameSetting(){
				var htmlString = '<div class="rouletteArea">'+
				'<input type="hidden" class="game_count" value="8"/>'+
				'<input type="hidden" class="rouletteColor1" value="rgba(255, 255, 255, 1)"/>'+
				'<input type="hidden" class="rouletteColor2" value="rgba(255, 255, 255, 1)"/>'+
				'<input type="hidden" class="rouletteColor3" value="rgba(255, 255, 255, 1)"/>'+
				'<input type="hidden" class="rouletteColor4" value="rgba(255, 255, 255, 1)"/>'+
				'<input type="hidden" class="rouletteColor5" value="rgba(255, 255, 255, 1)"/>'+
				'<input type="hidden" class="rouletteColor6" value="rgba(255, 255, 255, 1)"/>'+
				'<input type="hidden" class="rouletteColor7" value="rgba(255, 255, 255, 1)"/>'+
				'<input type="hidden" class="rouletteColor8" value="rgba(255, 255, 255, 1)"/>'+
				'<input type="hidden" class="roulettePercent1" value="12.5"/>'+
				'<input type="hidden" class="roulettePercent2" value="12.5"/>'+
				'<input type="hidden" class="roulettePercent3" value="12.5"/>'+
				'<input type="hidden" class="roulettePercent4" value="12.5"/>'+
				'<input type="hidden" class="roulettePercent5" value="12.5"/>'+
				'<input type="hidden" class="roulettePercent6" value="12.5"/>'+
				'<input type="hidden" class="roulettePercent7" value="12.5"/>'+
				'<input type="hidden" class="roulettePercent8" value="12.5"/>'+
				'<input type="hidden" class="rouletteValue1" value="1000"/>'+
				'<input type="hidden" class="rouletteValue2" value="2000"/>'+
				'<input type="hidden" class="rouletteValue3" value="3000"/>'+
				'<input type="hidden" class="rouletteValue4" value="4000"/>'+
				'<input type="hidden" class="rouletteValue5" value="5000"/>'+
				'<input type="hidden" class="rouletteValue6" value="6000"/>'+
				'<input type="hidden" class="rouletteValue7" value="7000"/>'+
				'<input type="hidden" class="rouletteValue8" value="8000"/>'+
				'<div class="spinBtn">GO</div>'+
				'<table cellpadding="0" cellspacing="0" border="0" class="rouletteTable">'+
	                '<tr>'+
	                    '<td width="438" height="438" class="the_wheel" align="center" valign="center">'+
	                        '<canvas id="canvas" width="434" height="434">'+
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
			
			fn_set(areaBoxContentsId);
			
		}
		
		$(document).on("click", ".settingGame", function(){
			$("#"+areaBoxContentsId).find(".game_count").val($("#game_count").val());
			
			if(undefined == $("#rouletteValue1").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue1").val("1000");
				$("#"+areaBoxContentsId).find(".rouletteColor1").val("rgba(255, 255, 255, 1)");
				$("#"+areaBoxContentsId).find(".roulettePercent1").val("12.5");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue1").val($("#rouletteValue1").val());
				$("#"+areaBoxContentsId).find(".roulettePercent1").val($("#roulettePercent1").val());
			}
			if(undefined == $("#rouletteValue2").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue2").val("2000");
				$("#"+areaBoxContentsId).find(".rouletteColor2").val("rgba(255, 255, 255, 1)");
				$("#"+areaBoxContentsId).find(".roulettePercent2").val("12.5");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue2").val($("#rouletteValue2").val());
				$("#"+areaBoxContentsId).find(".roulettePercent2").val($("#roulettePercent2").val());
			}
			if(undefined == $("#rouletteValue3").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue3").val("3000");
				$("#"+areaBoxContentsId).find(".rouletteColor3").val("rgba(255, 255, 255, 1)");
				$("#"+areaBoxContentsId).find(".roulettePercent3").val("12.5");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue3").val($("#rouletteValue3").val());
				$("#"+areaBoxContentsId).find(".roulettePercent3").val($("#roulettePercent3").val());
			}
			if(undefined == $("#rouletteValue4").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue4").val("4000");
				$("#"+areaBoxContentsId).find(".rouletteColor4").val("rgba(255, 255, 255, 1)");
				$("#"+areaBoxContentsId).find(".roulettePercent4").val("12.5");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue4").val($("#rouletteValue4").val());
				$("#"+areaBoxContentsId).find(".roulettePercent4").val($("#roulettePercent4").val());
			}
			if(undefined == $("#rouletteValue5").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue5").val("5000");
				$("#"+areaBoxContentsId).find(".rouletteColor5").val("rgba(255, 255, 255, 1)");
				$("#"+areaBoxContentsId).find(".roulettePercent5").val("12.5");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue5").val($("#rouletteValue5").val());
				$("#"+areaBoxContentsId).find(".roulettePercent5").val($("#roulettePercent5").val());
			}
			if(undefined == $("#rouletteValue6").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue6").val("6000");
				$("#"+areaBoxContentsId).find(".rouletteColor6").val("rgba(255, 255, 255, 1)");
				$("#"+areaBoxContentsId).find(".roulettePercent6").val("12.5");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue6").val($("#rouletteValue6").val());
				$("#"+areaBoxContentsId).find(".roulettePercent6").val($("#roulettePercent6").val());
			}
			if(undefined == $("#rouletteValue7").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue7").val("7000");
				$("#"+areaBoxContentsId).find(".rouletteColor7").val("rgba(255, 255, 255, 1)");
				$("#"+areaBoxContentsId).find(".roulettePercent7").val("12.5");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue7").val($("#rouletteValue7").val());
				$("#"+areaBoxContentsId).find(".roulettePercent7").val($("#roulettePercent7").val());
			}
			if(undefined == $("#rouletteValue8").val()){
				$("#"+areaBoxContentsId).find(".rouletteValue8").val("8000");
				$("#"+areaBoxContentsId).find(".rouletteColor8").val("rgba(255, 255, 255, 1)");
				$("#"+areaBoxContentsId).find(".roulettePercent8").val("12.5");
			}else{
				$("#"+areaBoxContentsId).find(".rouletteValue8").val($("#rouletteValue8").val());
				$("#"+areaBoxContentsId).find(".roulettePercent8").val($("#roulettePercent8").val());
			}
			fn_settingGame(areaBoxContentsId);
			fn_set(areaBoxContentsId);
		});
		
		function fn_settingGame(areaBoxContentsId){
			var wheelNumber = parseInt($("#"+areaBoxContentsId).find(".game_count").val());
			$("#game_count").val(wheelNumber);
			
			var roulettePercent1 = $("#"+areaBoxContentsId).find(".roulettePercent1").val();
			var roulettePercent2 = $("#"+areaBoxContentsId).find(".roulettePercent2").val();
			var roulettePercent3 = $("#"+areaBoxContentsId).find(".roulettePercent3").val();
			var roulettePercent4 = $("#"+areaBoxContentsId).find(".roulettePercent4").val();
			var roulettePercent5 = $("#"+areaBoxContentsId).find(".roulettePercent5").val();
			var roulettePercent6 = $("#"+areaBoxContentsId).find(".roulettePercent6").val();
			var roulettePercent7 = $("#"+areaBoxContentsId).find(".roulettePercent7").val();
			var roulettePercent8 = $("#"+areaBoxContentsId).find(".roulettePercent8").val();
			
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
					htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue'+i+'" name="game_text_'+i+'"  class="required" value="'+rouletteValue1+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent'+i+'" name="game_percent_'+i+'" class="required" value="'+roulettePercent1+'"/><span class="place-span">확률 '+i+'(%)</span></div></div>';
				}else if(i==2){
					htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue'+i+'" name="game_text_'+i+'"  class="required" value="'+rouletteValue2+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent'+i+'" name="game_percent_'+i+'" class="required" value="'+roulettePercent2+'"/><span class="place-span">확률 '+i+'(%)</span></div></div>';
				}else if(i==3){
					htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue'+i+'" name="game_text_'+i+'"  class="required" value="'+rouletteValue3+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent'+i+'" name="game_percent_'+i+'" class="required" value="'+roulettePercent3+'"/><span class="place-span">확률 '+i+'(%)</span></div></div>';
				}else if(i==4){
					htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue'+i+'" name="game_text_'+i+'"  class="required" value="'+rouletteValue4+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent'+i+'" name="game_percent_'+i+'" class="required" value="'+roulettePercent4+'"/><span class="place-span">확률 '+i+'(%)</span></div></div>';
				}else if(i==5){
					htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue'+i+'" name="game_text_'+i+'"  class="required" value="'+rouletteValue5+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent'+i+'" name="game_percent_'+i+'" class="required" value="'+roulettePercent5+'"/><span class="place-span">확률 '+i+'(%)</span></div></div>';
				}else if(i==6){
					htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue'+i+'" name="game_text_'+i+'"  class="required" value="'+rouletteValue6+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent'+i+'" name="game_percent_'+i+'" class="required" value="'+roulettePercent6+'"/><span class="place-span">확률 '+i+'(%)</span></div></div>';
				}else if(i==7){
					htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue'+i+'" name="game_text_'+i+'"  class="required" value="'+rouletteValue7+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent'+i+'" name="game_percent_'+i+'" class="required" value="'+roulettePercent7+'"/><span class="place-span">확률 '+i+'(%)</span></div></div>';
				}else if(i==8){
					htmlString += '<div class="d-ib"><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue'+i+'" name="game_text_'+i+'"  class="required" value="'+rouletteValue8+'"/><span class="place-span">값'+i+'</span></div><div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent'+i+'" name="game_percent_'+i+'" class="required" value="'+roulettePercent8+'"/><span class="place-span">확률 '+i+'(%)</span></div></div>';
				}
				
			}
			
			
			$("#rouletteColorArea").html(htmlString);
		}
		
		$(document).on("click", ".spinBtn", function(e){
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
                   
                   let wheelCount = parseInt($("#game_count").val());
                   
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
		
		$(document).on("click", ".insertGame", function(){
			var params = $("form[name=parameterVO]").serialize();
			console.log(params);
			$.ajax({
				url : "${pageContext.request.contextPath}/insertGame.json",
				type : "POST",
				data : params,
				success : function(result) {
					if (result.resultCode == "success") {
						
						alert("등록되었습니다.");
						location.href = "${pageContext.request.contextPath}/gameList.do";
					} else {
						
					}
				}
			});
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
				<div class="rightArea card-content" id="gameSettingArea">
					<form name="parameterVO" id="parameterVO">
						<input type="hidden" name="company_id" value="${parameterVO.company_id}"/>
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
									룰렛 게임 명 설정
								</div>
							</div>
							<p><div class="inputBox"><input type="text" required="required" id="game_name" name="game_name" class="required" value="룰렛 게임"/><span class="place-span">게임 명</span></div>
						</div>
						<div class="card-body py-0 border-bottom">
							<div class="assigned d-flex justify-content-between">
								<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
									개수 설정
								</div>
							</div>
							<p><div class="inputBox"><input type="text" required="required" id="game_count" name="game_count" class="w-50 required" value="8"/><span class="place-span">개수</span></div>
						</div>
						<div class="card-body py-0 border-bottom">
							<div class="assigned d-flex justify-content-between">
								<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
									값 설정
								</div>
							</div>
							<div id="rouletteColorArea" style="display:inline-block;">
								<div class="d-ib">
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue1" name="game_text_1" class="required" value="1000"/><span class="place-span">값 1</span></div>
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent1" name="game_percent_1" class="required" value="12.5"/><span class="place-span">확률 1(%)</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue2" name="game_text_2" class="required" value="2000"/><span class="place-span">값 2</span></div>
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent2" name="game_percent_2" class="required" value="12.5"/><span class="place-span">확률 2(%)</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue3" name="game_text_3" class="required" value="3000"/><span class="place-span">값 3</span></div>
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent3" name="game_percent_3" class="required" value="12.5"/><span class="place-span">확률 3(%)</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue4" name="game_text_4" class="required" value="4000"/><span class="place-span">값 4</span></div>
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent4" name="game_percent_4" class="required" value="12.5"/><span class="place-span">확률 4(%)</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue5" name="game_text_5" class="required" value="5000"/><span class="place-span">값 5</span></div>
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent5" name="game_percent_5" class="required" value="12.5"/><span class="place-span">확률 5(%)</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue6" name="game_text_6" class="required" value="6000"/><span class="place-span">값 6</span></div>
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent6" name="game_percent_6" class="required" value="12.5"/><span class="place-span">확률 6(%)</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue7" name="game_text_7" class="required" value="7000"/><span class="place-span">값 7</span></div>
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent7" name="game_percent_7" class="required" value="12.5"/><span class="place-span">확률 7(%)</span></div>
								</div>
								<div class="d-ib">
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="rouletteValue8" name="game_text_8" class="required" value="8000"/><span class="place-span">값 8</span></div>
									<div class="inputBox f-l rouletteInput2"><input type="text" required="required" id="roulettePercent8" name="game_percent_8" class="required" value="12.5"/><span class="place-span">확률 8(%)</span></div>
								</div>
							</div>
						</div>
						<div class="card-body task-description">
							<div class="mt-1 d-flex justify-content-end">
								<button type="button" class="btn btn-primary settingGame">확인</button>
								<button type="button" class="btn btn-success insertGame ml-1">저장</button>
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
            	<h3 class="content-header-title mb-0 mt-1 pl-1">룰렛 관리</h3>
					<div class="row breadcrumbs-top mb-1 pl-1">
						<div class="breadcrumb-wrapper col-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/siteList.do">HOME</a>
								</li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/gameList.do">게임 관리</a>
								</li>
								<li class="breadcrumb-item active">룰렛 등록
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
										<div class="areaContents" id="1_1-areaBox-1_contents" data="game">
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
    <script>
    let wheelPower    = 0;
    let wheelSpinning = false;
    let theWheel;
    function fn_set(areaBoxContentsId){
            // Create new wheel object specifying the parameters at creation time.
            theWheel = new Winwheel({
            	'canvasId'     : 'canvas', 
                'numSegments'  : parseInt($("#"+areaBoxContentsId).find(".game_count").val()),     // Specify number of segments.
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