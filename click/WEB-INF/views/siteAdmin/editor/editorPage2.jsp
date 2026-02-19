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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/editorPage.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/jquery.minicolors.css">
    
    <!-- END: Custom CSS-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/Winwheel.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/roulette.css">
    <style>
  	.sectorlist {
		display: flex;
		juistify-content: center;
		align-items : center;
		min-height: 50px;
		background: var(--main-bg-color);
	}

	.sectorNavigation {
		position : absolute;
		width: 420px;
		height: 50px;
		background : var(--main-bg-color);
		display : flex;
		justify-content: center;
		align-items: center;
		border-radius : 10px;
		margin:0 auto;
		top:25%;
		left:193px;
	}

	.sectorNavigation ul {
		display:flex;
		width: 385px;
		margin:0px!important;
		padding-inline-start:0!important;
	}

	.sectorNavigation ul li{
		list-style: none;
		position : relative;
		width: 55px;
		height: 50px;
		z-index: 2;
	}

	.sectorNavigation ul li a{
		position : relative;
		display: flex;
		justify-content: center;
		align-items:center;
		height:100%;
		width:100%;
	}

	.sectorNavigation ul li a .sectorIcon{
		position: relative;
		display:block;
		width:35px;
		height:35px;
		text-align:center;
		line-height:35px;
		border-radius:50%;
		color: #fff;
		font-size: 1.5em;
		transition:0.3s;
	}
	
	.sectorNavigation ul li a .sectorIconHtml{
		position: relative;
		display:block;
		width:35px;
		height:35px;
		text-align:center;
		line-height:35px;
		border-radius:50%;
		color: #fff;
		font-size: 0.8em;
		transition:0.3s;
	}
	
	.sectorNavigation ul li.active a .sectorIcon{
		background-color: var(--clr);
		transform : translateY(-17px);
	}
	
	.sectorNavigation ul li a .sectorIcon::before{
		content: '';
		position: absolute;
		top:13px;
		left:0;
		width:100%;
		height:100%;
		background-color:var(--clr);
		border-radius: 50%;
		filter:blur(5px);
		opacity:0;
		z-index:1;
	}
	
	.sectorNavigation ul li.active a .sectorIcon::before{
		opacity:0;
	}
	
	.sectorNavigation ul li.active a .sectorIconHtml{
		background-color: var(--clr);
		transform : translateY(-17px);
	}
	
	.sectorNavigation ul li a .sectorIconHtml::before{
		content: '';
		position: absolute;
		top:13px;
		left:0;
		width:100%;
		height:100%;
		background-color:var(--clr);
		border-radius: 50%;
		filter:blur(5px);
		opacity:0;
		z-index:1;
	}
	
	.sectorNavigation ul li.active a .sectorIconHtml::before{
		opacity:0;
	}
	
	.indicator{
		position:absolute;
		top: -20px;
		width: 55px;
		height: 55px;
		background:var(--main-bg-color);
		border-radius:50%;
		z-index:1;
		trasition:0.3s;
	}
	
	.indicator::before{
		content:'';
		position:absolute;
		top:-5px;
		left:-25px;
		width:30px;
		height:27px;
		background:transparent;
		border-radius:50%;
		box-shadow:15px 18px var(--main-bg-color);
	}
	
	.indicator::after{
		content:'';
		position:absolute;
		top:-5px;
		right:-25px;
		width:30px;
		height:27px;
		background:transparent;
		border-radius:50%;
		box-shadow:-15px 18px var(--main-bg-color);
		
	}
	
	.sectorNavigation ul li:nth-child(1).active ~ .indicator{
		transform : translateX(calc(55px * 0));
	}
	
	.sectorNavigation ul li:nth-child(2).active ~ .indicator{
		transform : translateX(calc(55px * 1));
	}
	
	.sectorNavigation ul li:nth-child(3).active ~ .indicator{
		transform : translateX(calc(55px * 2));
	}
	
	.sectorNavigation ul li:nth-child(4).active ~ .indicator{
		transform : translateX(calc(55px * 3));
	}
	
	.sectorNavigation ul li:nth-child(5).active ~ .indicator{
		transform : translateX(calc(55px * 4));
	}
	
	.sectorNavigation ul li:nth-child(6).active ~ .indicator{
		transform : translateX(calc(55px * 5));
	}
	
	.sectorNavigation ul li:nth-child(7).active ~ .indicator{
		transform : translateX(calc(55px * 6));
	}
  </style>
  
  <script type="text/javascript">
  
  	var docType = "P";
	var areaTotalId = 1;

	$(document).ready(function() {
		
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
			        		
			    			var areaBoxContentsId = $("#areaBoxContentsId").val();
			    			var htmlString = '<img class="eImage" style="width:'+imageWidth+'px;height:'+imageHeight+'px" src="${pageContext.request.contextPath}/file/down/'+fileId+'" data="'+fileName+'" sort="5"/>';
			    			
			    			$("#"+areaBoxContentsId).html(htmlString);
							
			    			$("#imageWidth").val(imageWidth);
			    			$("#imageHeight").val(imageHeight);
			    			
			    			
			    			var areaWidth = parseInt($("#imagePositionL").val())+parseInt($("#imagePositionR").val())+parseInt(imageWidth);
			    			var areaHeight = parseInt($("#imagePositionT").val())+parseInt($("#imagePositionB").val())+parseInt(imageHeight);
			    			
			    			$("#"+areaBoxContentsId).parent().css("width", areaWidth);
			    			$("#"+areaBoxContentsId).parent().css("height", areaHeight);
			    			
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
									'<input type="text" class="areaCuttingCount form-control w-25 dp-inline required" placeholder="분할" value="1"/> 개'+
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
				alert("aaaa");
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
				var htmlString = '<div class="rouletteArea">'+
									'<input type="hidden" class="gameNumber" value="8"/>'+
									'<input type="hidden" class="rouletteColor1" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor2" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor3" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor4" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor5" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor6" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor7" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteColor8" value="rgba(255, 255, 255, 1)"/>'+
									'<input type="hidden" class="rouletteValue1" value="1000"/>'+
									'<input type="hidden" class="rouletteValue2" value="2000"/>'+
									'<input type="hidden" class="rouletteValue3" value="3000"/>'+
									'<input type="hidden" class="rouletteValue4" value="4000"/>'+
									'<input type="hidden" class="rouletteValue5" value="5000"/>'+
									'<input type="hidden" class="rouletteValue6" value="6000"/>'+
									'<input type="hidden" class="rouletteValue7" value="7000"/>'+
									'<input type="hidden" class="rouletteValue8" value="8000"/>'+
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
			(function (window, document, $) {
				  "use strict";

				  var Font = Quill.import("formats/font");
				  Font.whitelist = ["sofia", "slabo", "roboto", "inconsolata", "ubuntu"];
				  Quill.register(Font, true);
				  // bubble editor
				  var fullEditor = new Quill("#container_"+areaBoxContentsId+" .editor", {
				    bounds: "#container_"+areaBoxContentsId+" .editor",
				    modules: {
				      formula: true,
				      syntax: true,
				      toolbar: [
				        [{
				            font: []
				          },
				          {
				            size: ["10px", "20px", "30px", "40px"]
				          }
				        ],
				        ["bold", "italic", "underline", "strike"],
				        [{ 'align': [] }],

						['clean'],
				        [{
				            color: []
				          },
				          {
				            background: []
				          }
				        ],
				        [{
				            script: "super"
				          },
				          {
				            script: "sub"
				          }
				        ],
				        [{
				            header: "1"
				          },
				          {
				            header: "2"
				          },
				          "blockquote",
				          "code-block"
				        ],
				        [{
				            list: "ordered"
				          },
				          {
				            list: "bullet"
				          },
				          {
				            indent: "-1"
				          },
				          {
				            indent: "+1"
				          }
				        ]
				      ]
				    },
				    theme: "snow"
				  });
				  
				})(window, document, jQuery);
			
			$("#"+areaBoxContentsId).append('<button type="button" class="editorAccept btn btn-primary emt-15 emb-15" style="color:white;">적용</button>'); 
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
			
			var htmlString = '색상 : <input type="text" id="lineColor" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+lineColor+'"/>';
			
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
			
			var imageWidth = $("#"+areaBoxContentsId).find(".eImage").css("width");
			var imageHeight = parseFloat($("#"+areaBoxContentsId).find(".eImage").css("height"));
			
			var areaWidth = parseFloat($("#"+areaBoxContentsId).css("width"));
			var thisWidth = parseFloat(imageWidth);
			
			var imagePositionT = parseFloat($("#"+areaBoxContentsId).find(".eImage").css("margin-top"));
			var imagePositionL = parseFloat($("#"+areaBoxContentsId).find(".eImage").css("margin-left"));
			var imagePositionR = parseFloat($("#"+areaBoxContentsId).find(".eImage").css("margin-right"));
			var imagePositionB = parseFloat($("#"+areaBoxContentsId).find(".eImage").css("margin-bottom"));
			
			$("#imageWidth").val(thisWidth);
			$("#imageHeight").val(imageHeight);
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
					htmlString += '값'+i+' : <input type="text" id="rouletteValue'+i+'" class="form-control w-15 emr-10 dp-inline required" placeholder="값'+i+'" value="'+rouletteValue1+'"/> 색상 : <input type="text" id="rouletteColor'+i+'" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor1+'"/><br/><br/>';
				}else if(i==2){
					htmlString += '값'+i+' : <input type="text" id="rouletteValue'+i+'" class="form-control w-15 emr-10 dp-inline required" placeholder="값'+i+'" value="'+rouletteValue2+'"/> 색상 : <input type="text" id="rouletteColor'+i+'" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor2+'"/><br/><br/>';
				}else if(i==3){
					htmlString += '값'+i+' : <input type="text" id="rouletteValue'+i+'" class="form-control w-15 emr-10 dp-inline required" placeholder="값'+i+'" value="'+rouletteValue3+'"/> 색상 : <input type="text" id="rouletteColor'+i+'" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor3+'"/><br/><br/>';
				}else if(i==4){
					htmlString += '값'+i+' : <input type="text" id="rouletteValue'+i+'" class="form-control w-15 emr-10 dp-inline required" placeholder="값'+i+'" value="'+rouletteValue4+'"/> 색상 : <input type="text" id="rouletteColor'+i+'" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor4+'"/><br/><br/>';
				}else if(i==5){
					htmlString += '값'+i+' : <input type="text" id="rouletteValue'+i+'" class="form-control w-15 emr-10 dp-inline required" placeholder="값'+i+'" value="'+rouletteValue5+'"/> 색상 : <input type="text" id="rouletteColor'+i+'" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor5+'"/><br/><br/>';
				}else if(i==6){
					htmlString += '값'+i+' : <input type="text" id="rouletteValue'+i+'" class="form-control w-15 emr-10 dp-inline required" placeholder="값'+i+'" value="'+rouletteValue6+'"/> 색상 : <input type="text" id="rouletteColor'+i+'" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor6+'"/><br/><br/>';
				}else if(i==7){
					htmlString += '값'+i+' : <input type="text" id="rouletteValue'+i+'" class="form-control w-15 emr-10 dp-inline required" placeholder="값'+i+'" value="'+rouletteValue7+'"/> 색상 : <input type="text" id="rouletteColor'+i+'" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor7+'"/><br/><br/>';
				}else if(i==8){
					htmlString += '값'+i+' : <input type="text" id="rouletteValue'+i+'" class="form-control w-15 emr-10 dp-inline required" placeholder="값'+i+'" value="'+rouletteValue8+'"/> 색상 : <input type="text" id="rouletteColor'+i+'" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+rouletteColor8+'"/><br/><br/>';
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
			
			$("#"+areaBoxContentsId).find(".eImage").css("width", $("#imageWidth").val()+"px");
			if("" != $("#imageHeight").val()){
				$("#"+areaBoxContentsId).find(".eImage").css("height", $("#imageHeight").val()+"px");
			}else{
				$("#"+areaBoxContentsId).find(".eImage").css("height", "");
			}
			$("#"+areaBoxContentsId).find(".eImage").css("margin-top", $("#imagePositionT").val()+"px");
			$("#"+areaBoxContentsId).find(".eImage").css("margin-left", $("#imagePositionL").val()+"px");
			$("#"+areaBoxContentsId).find(".eImage").css("margin-right", $("#imagePositionR").val()+"px");
			$("#"+areaBoxContentsId).find(".eImage").css("margin-bottom", $("#imagePositionB").val()+"px");
			
			var areWidth = parseInt($("#imagePositionL").val())+parseInt($("#imagePositionR").val())+parseInt($("#imageWidth").val());
			var areHeight = parseInt($("#imagePositionT").val())+parseInt($("#imagePositionB").val())+parseInt($("#imageHeight").val());
			
			$("#"+areaBoxId).css("width", areWidth+"px");
			$("#"+areaBoxId).css("height", areHeight+"px");
			
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
		
		
		$(document).on("click", ".settingTotal", function(){
			var areaTotalId = $("#areaTotalId").val();
			
			$("#"+areaTotalId).css("background-color", $("#totalColor").val());
			
			$("#"+areaTotalId).css("padding-top", $("#totalPositionT").val()+"px");
			$("#"+areaTotalId).css("padding-left", $("#totalPositionL").val()+"px");
			$("#"+areaTotalId).css("padding-right", $("#totalPositionR").val()+"px");
			$("#"+areaTotalId).css("padding-bottom", $("#totalPositionB").val()+"px");
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
			
			var htmlString = '색상 : <input type="text" id="totalColor" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+totalColor+'"/>';
			
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

		$(document).on("click", ".selector", function(){
			$(".selector").removeClass("on");
			if($(this).hasClass("selectType1")){
				if(!$(this).hasClass("on")){
					$(this).addClass("on");
				}
				$(".sectorNavigation").hide();

				$("#areaBoxList").stop().animate( {width: '800px' }, 500, 'swing', function(){
					$(".sectorNavigation").css("left", "193px");
					$(".sectorNavigation").show();
				});
				docType = "P";
			}else if($(this).hasClass("selectType2")){
				if(!$(this).hasClass("on")){
					$(this).addClass("on");
				}

				$(".sectorNavigation").hide();

				$("#areaBoxList").stop().animate( {width: '650px'}, 500, 'swing', function(){
					$(".sectorNavigation").css("left", "115px");
					$(".sectorNavigation").show();
				});
				docType = "T";
			}else if($(this).hasClass("selectType3")){
				if(!$(this).hasClass("on")){
					$(this).addClass("on");
				}
				
				$(".sectorNavigation").hide();

				$("#areaBoxList").stop().animate( {width: '425px'}, 500, 'swing', function(){
					$(".sectorNavigation").css("left", "2px");
					$(".sectorNavigation").show();
				});
				docType = "M";
			}
		});
		
		
		$(document).on("click", ".makeHtml", function(){
			var orgHtmlString = $("#areaBoxList").html();
			var htmlString = "";
			$("#areaBoxList").each(function(){
				
				$(this).find(".btnItemAdd").remove();
				$(this).find(".btnItemDelete").remove();
				$(this).find(".areaBoxCaption").remove();
				$(this).find(".areaTitle").remove();
				htmlString += $(this).html();
			})
			
			console.log(htmlString);
			$("#areaBoxList").html(orgHtmlString);
			
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

                    theWheel.startAnimation();

                    wheelSpinning = true;
                }else{
                	theWheel.stopAnimation(false);  // Stop the animation, false as param so does not call callback function.
                    theWheel.rotationAngle = 0;     // Re-set the wheel angle to 0 degrees.
                    theWheel.draw();  
                    
                    wheelSpinning = false;
                }
            });
		
	});
	
	function fn_bind(){
		
	}
	
	
	
  </script>
  <style>
  	

  </style>

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu content-left-sidebar todo-application" data-open="click" data-menu="vertical-menu-modern" data-col="content-left-sidebar">

   	<div class="areaTotalBox" id="1">
									<div class="areaBox" id="areaBox-1" data-line="1">
										<div class="areaContents" id="1_1-areaBox-1_contents" data="text"><div id="container_1_1-areaBox-1_contents" class="full-container"><div class="editor"><div class="eEditor ql-editor" data-gramm="false"><p>222222222222222222222222222</p></div></div></div></div>
										
										
										
									</div>
									
								<div class="areaBox areaBorder" id="areaBox-2" data-line="1" style="width: 408px; height: 464px;"><div class="areaContents" id="1_areaBox-2_contents" data="image"><img class="eImage" style="width: 408px; height: 464px; margin: 0px;" src="/click/file/down/307" data="click1.png" sort="5"></div></div></div>

    <!-- BEGIN: Footer-->


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
            	'canvasId'     : 'canvas'+areaBoxContentsId, 
                'numSegments'  : parseInt($("#"+areaBoxContentsId).find(".gameNumber").val()),     // Specify number of segments.
                'outerRadius'  : 212,   // Set outer radius so wheel fits inside the background.
                'textFontSize' : 28,    // Set font size as desired.
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