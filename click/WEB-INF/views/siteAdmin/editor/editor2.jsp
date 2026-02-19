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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/editor3.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/jquery.minicolors.css">
    <!-- END: Custom CSS-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script type="text/javascript">

  	var docType = "P";
	var areaTotalId = 1;


	$(document).ready(function() {
		$("#editor2").addClass("active");
		
		$(".fileupload").on("change", fn_addFiles);
		$(".fileuploadMovie").on("change", fn_addFiles2);
		
		function fn_addFiles(e) {
			filesTempArr = [];
		    var files = e.target.files;
		    var filesArr = Array.prototype.slice.call(files);
		    var filesArrLen = filesArr.length;
		    var filesTempArrLen = filesTempArr.length;
		    for( var i=0; i<filesArrLen; i++ ) {
		        filesTempArr.push(filesArr[i]);
		        fileName = filesArr[i].name;
		        fn_insertFile();
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
		        fn_insertFile2();
		    }
		}
		
		function fn_insertFile(){
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
			        		
			        		var areaTotalId = $("#areaTotalId").val();
			    			var areaId = $("#areaId").val();
			    			var htmlString = '<img class="eImage" style="width:100px;" src="${pageContext.request.contextPath}/file/down/'+fileId+'"/>';
			    			
			    			$("#"+areaTotalId).find("#"+areaId).find(".areaContents").html(htmlString)
							
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
		
		function fn_insertFile2(){
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
			    			var areaId = $("#areaId").val();
			    			
							var movieArea = $("#"+areaTotalId).find("#"+areaId).find(".areaContents").find(".eMovie");
							
							$.ajax({
								url : "${pageContext.request.contextPath}/videoPlayer.do?areaId="+areaId+"&totalAreaId="+areaTotalId+"&fileId="+fileId,
								type : "POST",
								success : function(result) {
									movieArea.html(result);
								}
							});
							
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
		
		$(document).on("mouseover", ".areaBox", function(){
			$(this).addClass("borderOn");
		});

		$(document).on("mouseleave", ".areaBox", function(){
			$(this).removeClass("borderOn");
		});

		$(document).on("click", ".areaBox", function(){
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
			
			if($(this).parent().find(".areaBoxCaption").hasClass("hiddenObj")){
				$(this).parent().find(".areaBoxCaption").removeClass("hiddenObj");
			}
			
			var areaTotalId = $(this).parent().attr("id");
			var areaId = $(this).attr("id");
				
			$("#areaTotalId").val(areaTotalId);
			$("#areaId").val(areaId);
			
			if("" == $(this).find(".areaContents").html() || undefined == $(this).find(".areaContents").html()){
				todoNewTasksidebar.removeClass('show');
			}else{
				$(".rightArea").each(function(){
					if(!$(this).hasClass("hiddenObj")){
						$(this).addClass("hiddenObj")
					}
				})
				
				if(undefined != $(this).find(".areaContents").find(".eline").html()){
					$("#lineSettingArea").removeClass("hiddenObj");
					if(!todoNewTasksidebar.hasClass('show')){
						todoNewTasksidebar.addClass('show');
					}
					
					fn_settingLine(areaId, areaTotalId);
					
				}else if(undefined != $(this).find(".areaContents").find(".eImage").html()){
					$("#imageSettingArea").removeClass("hiddenObj");
					if(!todoNewTasksidebar.hasClass('show')){
						todoNewTasksidebar.addClass('show');
					}
				}else if(undefined != $(this).find(".areaContents").find(".eMovie").html()){
					$("#movieSettingArea").removeClass("hiddenObj");
					if(!todoNewTasksidebar.hasClass('show')){
						todoNewTasksidebar.addClass('show');
					}
				}
			}
		});

		$(document).on("click", ".areaItem", function(){
			
			var type = $(this).attr("data");
			if(type == "text"){
				var areaId = $(this).parent().attr("id");
				var totalAreaId = $(this).parent().parent().attr("id");
				var textArea = $(this).parent().find(".areaContents");
				$(this).parent().find(".areaTitle").remove();
				$.ajax({
					url : "${pageContext.request.contextPath}/textEditor.do?areaId="+areaId+"&totalAreaId="+totalAreaId,
					type : "POST",
					success : function(result) {
						
						textArea.html(result);
						fn_editorSetting(areaId, totalAreaId);
						
					}
				});
				$(this).parent().find(".areaItem").remove();


			}else if(type == "image"){
				var areaId = $(this).parent().attr("id");
				var totalAreaId = $(this).parent().parent().attr("id");
				
				$(this).parent().find(".areaTitle").remove();
				var htmlString = '<div class="eImage"></div>';
				$(this).parent().find(".areaContents").html(htmlString);
				
				$(this).parent().find(".areaItem").remove();
				
				$("#imageSettingArea").removeClass("hiddenObj");
				
				todoNewTasksidebar.addClass('show');
				
				//fn_settingLine(areaId, totalAreaId);
				
				

			}else if(type == "movie"){
				var areaId = $(this).parent().attr("id");
				var totalAreaId = $(this).parent().parent().attr("id");
				$("#areaTotalId").val(totalAreaId);
				$("#areaId").val(areaId);
				
				var videoArea = $(this).parent().find(".areaContents");
				$(this).parent().find(".areaTitle").remove();
				var htmlString = '<div class="eMovie"></div>';
				$(this).parent().find(".areaContents").html(htmlString);
				
				$(this).parent().find(".areaItem").remove();
				
			}else if(type == "line"){
				var areaId = $(this).parent().attr("id");
				var totalAreaId = $(this).parent().parent().attr("id");
				
				$(this).parent().find(".areaTitle").remove();
				var htmlString = '<div class="eline" style="width:100%;height:1px;background-color:black;margin-top:0px;margin-left:0px;margin-right:0px;margin-bottom:0px;"></div>';
				$(this).parent().find(".areaContents").html(htmlString);
				
				$(this).parent().find(".areaItem").remove();
				
				$("#lineSettingArea").removeClass("hiddenObj");
				
				todoNewTasksidebar.addClass('show');
				
				fn_settingLine(areaId, totalAreaId);
				
			}else if(type == "html"){
				var areaId = $(this).parent().attr("id");
				var totalAreaId = $(this).parent().parent().attr("id");
				
				$(this).parent().find(".areaTitle").remove();
				var htmlString = '<input type="text" class="ehtml w-100"/><button type="button" class="htmlAccept btn btn-primary emt-15 emb-15" style="color:white;">적용</button>';
				$(this).parent().find(".areaContents").html(htmlString);
				$(this).parent().find(".areaItem").remove();
				
			}


		});
		
		$(document).on("click", ".htmlAccept", function(){
			
			var htmlString = $(this).parent().find(".ehtml").val();
			
			$(this).parent().parent().find(".areaContents").html(htmlString);
		});
		
		$(document).on("click", ".editorAccept", function(){
			
			var htmlString = '<div class="eEditor ql-editor" data-gramm="false">'+$(this).parent().find(".ql-editor").html()+'</div>';
			
			$(this).parent().parent().parent().find(".areaContents").html(htmlString);
		});
		
		
		function fn_editorSetting(areaId, totalAreaId){
			(function (window, document, $) {
				  "use strict";

				  var Font = Quill.import("formats/font");
				  Font.whitelist = ["sofia", "slabo", "roboto", "inconsolata", "ubuntu"];
				  Quill.register(Font, true);
				  // bubble editor
				  var fullEditor = new Quill("#container_"+totalAreaId+"_"+areaId+" .editor", {
				    bounds: "#container_"+totalAreaId+"_"+areaId+" .editor",
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
		}
		
		function fn_settingLine(areaId, totalAreaId){
			$("#areaTotalId").val(totalAreaId);
			$("#areaId").val(areaId);
			
			var lineWidth = $("#"+totalAreaId).find("#"+areaId).find(".eline").css("width");
			var lineHeight = parseFloat($("#"+totalAreaId).find("#"+areaId).find(".eline").css("height"));
			var lineColor = fn_rgb2hex($("#"+totalAreaId).find("#"+areaId).find(".eline").css("background-color"));
			
			var areaWidth = parseFloat($("#"+areaId).find(".areaContents").css("width"));
			var thisWidth = parseFloat(lineWidth);
			
			var linePositionT = parseFloat($("#"+totalAreaId).find("#"+areaId).find(".eline").css("margin-top"));
			var linePositionL = parseFloat($("#"+totalAreaId).find("#"+areaId).find(".eline").css("margin-left"));
			var linePositionR = parseFloat($("#"+totalAreaId).find("#"+areaId).find(".eline").css("margin-right"));
			var linePositionB = parseFloat($("#"+totalAreaId).find("#"+areaId).find(".eline").css("margin-bottom"));
			
			$("#lineWidth").val(thisWidth/areaWidth*100);
			$("#lineHeight").val(lineHeight);
			$("#linePositionT").val(linePositionT);
			$("#linePositionL").val(linePositionL);
			$("#linePositionR").val(linePositionR);
			$("#linePositionB").val(linePositionB);
			
			
			
			var htmlString = '색상 : <input type="text" id="lineColor" class="form-control dp-inline required demo minicolors-input" data-control="hue" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+lineColor+'"/>';
			
			$("#lineColorArea").html(htmlString);
			
			$('.demo').each(function() {
			    $(this).minicolors({
			      control: $(this).attr('data-control') || 'hue',
			      defaultValue: $(this).attr('data-defaultValue') || '',
			      format: $(this).attr('data-format') || 'hex',
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
		
		
		$(document).on("click", ".alignButton", function(){
			$(".alignButton").removeClass("btn-warning");
			
			$(this).addClass("btn-warning");
			
		});
		
		function fn_rgb2hex(rgb) {
		     if (  rgb.search("rgb") == -1 ) {
		          return rgb;
		     } else {
		          rgb = rgb.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+))?\)$/);
		          function hex(x) {
		               return ("0" + parseInt(x).toString(16)).slice(-2);
		          }
		          return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
		     }
		}


		$(document).on("click", ".settingLine", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaId = $("#areaId").val();
			
			
			$("#"+areaTotalId).find("#"+areaId).find(".eline").css("width", $("#lineWidth").val()+"%");
			$("#"+areaTotalId).find("#"+areaId).find(".eline").css("height", $("#lineHeight").val()+"px");
			$("#"+areaTotalId).find("#"+areaId).find(".eline").css("background-color", $("#lineColor").val());
			$("#"+areaTotalId).find("#"+areaId).find(".eline").css("margin-top", $("#linePositionT").val()+"px");
			$("#"+areaTotalId).find("#"+areaId).find(".eline").css("margin-left", $("#linePositionL").val()+"px");
			$("#"+areaTotalId).find("#"+areaId).find(".eline").css("margin-right", $("#linePositionR").val()+"px");
			$("#"+areaTotalId).find("#"+areaId).find(".eline").css("margin-bottom", $("#linePositionB").val()+"px");
			
			if("lineSettingLeft" == $(".btn-warning").attr("id")){
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("display", "flex");
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("justify-content", "left");
			}else if("lineSettingRight" == $(".btn-warning").attr("id")){
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("display", "flex");
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("justify-content", "right");
			}else{
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("display", "flex");
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("justify-content", "center");
			}
			
		});
		
		$(document).on("click", ".settingImage", function(){
			var areaTotalId = $("#areaTotalId").val();
			var areaId = $("#areaId").val();
			
			
			$("#"+areaTotalId).find("#"+areaId).find(".eImage").css("width", $("#imageWidth").val()+"px");
			if("" != $("#imageHeight").val()){
				$("#"+areaTotalId).find("#"+areaId).find(".eImage").css("height", $("#imageHeight").val()+"px");
			}else{
				$("#"+areaTotalId).find("#"+areaId).find(".eImage").css("height", "");
			}
			$("#"+areaTotalId).find("#"+areaId).find(".eImage").css("margin-top", $("#imagePositionT").val()+"px");
			$("#"+areaTotalId).find("#"+areaId).find(".eImage").css("margin-left", $("#imagePositionL").val()+"px");
			$("#"+areaTotalId).find("#"+areaId).find(".eImage").css("margin-right", $("#imagePositionR").val()+"px");
			$("#"+areaTotalId).find("#"+areaId).find(".eImage").css("margin-bottom", $("#imagePositionB").val()+"px");
			
			if("imageSettingLeft" == $(".btn-warning").attr("id")){
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("display", "flex");
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("justify-content", "left");
			}else if("imageSettingRight" == $(".btn-warning").attr("id")){
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("display", "flex");
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("justify-content", "right");
			}else{
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("display", "flex");
				$("#"+areaTotalId).find("#"+areaId).find(".areaContents").css("justify-content", "center");
			}
			
		});
		
		$(document).on("click", ".settingTotal", function(){
			var areaTotalId = $("#areaTotalId").val();
			
			$("#"+areaTotalId).css("background-color", $("#totalColor").val());
			
			$("#"+areaTotalId).css("margin-top", $("#totalPositionT").val()+"px");
			$("#"+areaTotalId).css("margin-left", $("#totalPositionL").val()+"px");
			$("#"+areaTotalId).css("margin-right", $("#totalPositionR").val()+"px");
			$("#"+areaTotalId).css("margin-bottom", $("#totalPositionB").val()+"px");
		});
		
		$(document).on("click", ".areaAddButton", function(){
			areaTotalId++;
			var htmlAreaString = '<div class="areaTotalBox" id="'+areaTotalId+'">'+
									'<div class="areaBox" id="areaBox-1">'+
										'<div class="areaContents"></div>'+
										'<div class="areaTitle">'+
											'추가하실 항목을 선택하세요.'+
										'</div>'+
										'<div class="areaItem" data="text">'+
											'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/text.png" width="20px;" height="20px;"/></div>'+
											'<div>텍스트</div>'+
										'</div>'+
										'<div class="areaItem" data="image">'+
											'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/image.png" width="20px;" height="20px;"/></div>'+
											'<div>이미지</div>'+
										'</div>'+
										'<div class="areaItem" data="movie">'+
											'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/movie.png" width="20px;" height="20px;"/></div>'+
											'<div>동영상</div>'+
										'</div>'+
										'<div class="areaItem" data="sound">'+
											'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/sound.png" width="20px;" height="20px;"/></div>'+
											'<div>오디오</div>'+
										'</div>'+
										'<div class="areaItem" data="line">'+
											'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/line.png" width="20px;" height="20px;"/></div>'+
											'<div>선</div>'+
										'</div>'+
										'<div class="areaItem" data="file">'+
											'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/file.png" width="20px;" height="20px;"/></div>'+
											'<div>파일</div>'+
										'</div>'+
										'<div class="areaItem" data="html">'+
											'<div class="iconArea">HTML</div>'+
											'<div>HTML</div>'+
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
			})
			areaCount++;
			var htmlAreaString = '<div class="areaBox" id="areaBox-'+areaCount+'">'+
									'<div class="areaContents"></div>'+
									'<div class="areaTitle">'+
										'추가하실 항목을 선택하세요.'+
									'</div>'+
									'<div class="areaItem" data="text">'+
										'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/text.png" width="20px;" height="20px;"/></div>'+
										'<div>텍스트</div>'+
									'</div>'+
									'<div class="areaItem" data="image">'+
										'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/image.png" width="20px;" height="20px;"/></div>'+
										'<div>이미지</div>'+
									'</div>'+
									'<div class="areaItem" data="movie">'+
										'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/movie.png" width="20px;" height="20px;"/></div>'+
										'<div>동영상</div>'+
									'</div>'+
									'<div class="areaItem" data="sound">'+
										'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/sound.png" width="20px;" height="20px;"/></div>'+
										'<div>오디오</div>'+
									'</div>'+
									'<div class="areaItem" data="line">'+
										'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/line.png" width="20px;" height="20px;"/></div>'+
										'<div>선</div>'+
									'</div>'+
									'<div class="areaItem" data="file">'+
										'<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/file.png" width="20px;" height="20px;"/></div>'+
										'<div>파일</div>'+
									'</div>'+
									'<div class="areaItem" data="html">'+
										'<div class="iconArea">HTML</div>'+
										'<div>HTML</div>'+
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
				totalColor = fn_rgb2hex("rgba(255, 255, 255)");
			}else{
				totalColor = fn_rgb2hex($("#"+areaTotalId).css("background-color"));
			}
			
			var htmlString = '색상 : <input type="text" id="totalColor" class="form-control dp-inline required demo minicolors-input" data-control="hue" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="'+totalColor+'"/>';
			
			$("#totalColorArea").html(htmlString);
			
			$('.demo').each(function() {
			    $(this).minicolors({
			      control: $(this).attr('data-control') || 'hue',
			      defaultValue: $(this).attr('data-defaultValue') || '',
			      format: $(this).attr('data-format') || 'hex',
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

				$("#areaBoxList").animate( {width: '800px'}, 500, 'swing' );
				$(".areaItem").css("margin", "9px 11px");
				docType = "P";
			}else if($(this).hasClass("selectType2")){
				if(!$(this).hasClass("on")){
					$(this).addClass("on");
				}
				$(".areaItem").css("margin", "9px 18px");

				$("#areaBoxList").animate( {width: '650px'}, 500, 'swing' );
				docType = "T";
			}else if($(this).hasClass("selectType3")){
				if(!$(this).hasClass("on")){
					$(this).addClass("on");
				}
				$(".areaItem").css("margin", "9px 24px");

				$("#areaBoxList").animate( {width: '425px'}, 500, 'swing' );
				docType = "M";
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
    	<div class="todo-new-task-sidebar" style="width:500px;">
    		<input type="hidden" id="areaTotalId" value="">
    		<input type="hidden" id="areaId" value="">
			<div class="card shadow-none p-0 m-0">
				<div class="card-header border-bottom py-75">
					<div class="task-header d-flex justify-content-between align-items-center">
					</div>
					<button type="button" class="close close-icon">
						<i class="feather icon-x align-middle"></i>
					</button>
				</div>
				<!-- form start -->
				
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
						<p>넓이 : <input type="text" id="lineWidth" class="form-control w-50 dp-inline required" placeholder="넓이"/> % </p>
						<p>두께 : <input type="text" id="lineHeight" class="form-control w-50 dp-inline required" placeholder="두께"/> px </p>
						<p id="lineColorArea"></p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								여백
							</div>
						</div>
						<p style="text-align:center;"><input type="text" id="linePositionT" class="form-control w-25 dp-inline required" placeholder="상단"/> px </p>
						<div style="float:left;text-align:left;margin-bottom:1rem;"><input type="text" id="linePositionL" class="form-control w-50 dp-inline required" placeholder="왼쪽"/> px </div>
						<div style="float:right;text-align:right;margin-bottom:1rem;"><input type="text" id="linePositionR" class="form-control w-50 dp-inline required" placeholder="오른쪽"/> px</div>
						<p style="text-align:center;"><input type="text" id="linePositionB" class="form-control w-25 dp-inline required" placeholder="하단"/> px </p>
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
						<p><input type="file" class="form-control-file fileupload"/></p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								사이즈
							</div>
						</div>
						<p>넓이 : <input type="text" id="imageWidth" class="form-control w-50 dp-inline required" placeholder="넓이"/> px </p>
						<p>높이 : <input type="text" id="imageHeight" class="form-control w-50 dp-inline required" placeholder="자동"/> px </p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								여백
							</div>
						</div>
						<p style="text-align:center;"><input type="text" id="imagePositionT" class="form-control w-25 dp-inline required" placeholder="상단"/> px </p>
						<div style="float:left;text-align:left;margin-bottom:1rem;"><input type="text" id="imagePositionL" class="form-control w-50 dp-inline required" placeholder="왼쪽"/> px </div>
						<div style="float:right;text-align:right;margin-bottom:1rem;"><input type="text" id="imagePositionR" class="form-control w-50 dp-inline required" placeholder="오른쪽"/> px</div>
						<p style="text-align:center;"><input type="text" id="imagePositionB" class="form-control w-25 dp-inline required" placeholder="하단"/> px </p>
					</div>
					<div class="card-body py-0 border-bottom epb-30">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								정렬
							</div>
						</div>
						<button type="button" id="imageSettingLeft" class="alignButton btn settingLeft btn-primary" style="color:white;">왼  쪽</button>
						<button type="button" id="imageSettingCenter" class="alignButton btn eml-10 settingCenter btn-primary" style="color:white;">가운데</button>
						<button type="button" id="imageSettingRight" class="alignButton btn eml-10 settingRight btn-primary" style="color:white;">오른쪽</button>
					</div>
					<div class="card-body task-description">
						<div class="mt-1 d-flex justify-content-end">
							<button type="button" class="btn btn-primary settingImage">확인</button>
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
						<p><input type="file" class="form-control-file fileuploadMovie"/></p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								사이즈
							</div>
						</div>
						<p>넓이 : <input type="text" id="movieWidth" class="form-control w-50 dp-inline required" placeholder="넓이"/> px </p>
						<p>높이 : <input type="text" id="movieHeight" class="form-control w-50 dp-inline required" placeholder="자동"/> px </p>
					</div>
					<div class="card-body py-0 border-bottom">
						<div class="assigned d-flex justify-content-between">
							<div class="form-group d-flex align-items-center position-relative font-medium-1 fw-500 ept-20">
								여백
							</div>
						</div>
						<p style="text-align:center;"><input type="text" id="moviePositionT" class="form-control w-25 dp-inline required" placeholder="상단"/> px </p>
						<div style="float:left;text-align:left;margin-bottom:1rem;"><input type="text" id="moviePositionL" class="form-control w-50 dp-inline required" placeholder="왼쪽"/> px </div>
						<div style="float:right;text-align:right;margin-bottom:1rem;"><input type="text" id="moviePositionR" class="form-control w-50 dp-inline required" placeholder="오른쪽"/> px</div>
						<p style="text-align:center;"><input type="text" id="moviePositionB" class="form-control w-25 dp-inline required" placeholder="하단"/> px </p>
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
								여백
							</div>
						</div>
						<p style="text-align:center;"><input type="text" id="totalPositionT" class="form-control w-25 dp-inline required" placeholder="상단"/> px </p>
						<div style="float:left;text-align:left;margin-bottom:1rem;"><input type="text" id="totalPositionL" class="form-control w-50 dp-inline required" placeholder="왼쪽"/> px </div>
						<div style="float:right;text-align:right;margin-bottom:1rem;"><input type="text" id="totalPositionR" class="form-control w-50 dp-inline required" placeholder="오른쪽"/> px</div>
						<p style="text-align:center;"><input type="text" id="totalPositionB" class="form-control w-25 dp-inline required" placeholder="하단"/> px </p>
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
            	<div class="media mb-1">
                    <div class="media-body">
                        <h5 class="media-heading fw-1000">콘텐츠 관리</h5>
                    </div>
                </div>
                <!-- users edit start -->
                <section id="bg-variants">
                	<div class="row">
                		<div class="col-md-4 col-sm-12">
                			<form name="parameterVO" id="parameterVO">
                				<input type="hidden" name="company_id" id="company_id" value="0"/>
                				<input type="hidden" name="group_id" id="group_id" value=""/>
                				<input type="hidden" name="property_id_group" id="property_id_group" value=""/>
		                		<div class="form-group">
		                        </div>
	                        </form>
                        </div>
                	</div>
                    <div class="row p-1" id="propertyList">
                    	<div class="col-md-2 col-sm-12">
                    		<label class="filter-label mb-1 pt-25 fw-1000">콘텐츠 목록</label>
                    		<div style="background-color:white;border-radius:0.25rem;">
                    			<div class="list-group" id="groupList">
                    			<c:forEach var="groupList" items="${groupList}" varStatus="status">
									<a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between">
										<input type="hidden" id="group_id_${groupList.group_id}" name="group_name_${groupList.group_id}" value="${groupList.group_id}"/>
									    <span>${groupList.group_name}</span>
									    <span class="bullet bullet-sm bullet-warning"></span>
									</a>
	                           </c:forEach>
	                           </div>
                           </div>
                        </div>
                        <div class="col-sm-7 emt-30" style="background-color:white;">
                    		<div style="width:100%;">
								<div style="width:150px;margin:0 auto;height:50px;">
									<div class="selector selectType1 on"></div>
									<div class="selector selectType2"></div>
									<div class="selector selectType3"></div>
								</div>
							</div>
						 	<div id="areaBoxList" style="width:800px;margin:0 auto;">
								<div class="areaTotalBox" id="1">
									<div class="areaBox" id="areaBox-1">
										<div class="areaContents"></div>
										<div class="areaTitle">
											추가하실 항목을 선택하세요.
										</div>
										<div class="areaItem" data="text">
											<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/text.png" width="20px;" height="20px;"/></div>
											<div>텍스트</div>
										</div>
										<div class="areaItem" data="image">
											<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/image.png" width="20px;" height="20px;"/></div>
											<div>이미지</div>
										</div>
										<div class="areaItem" data="movie">
											<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/movie.png" width="20px;" height="20px;"/></div>
											<div>동영상</div>
										</div>
										<div class="areaItem" data="sound">
											<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/sound.png" width="20px;" height="20px;"/></div>
											<div>오디오</div>
										</div>
										<div class="areaItem" data="line">
											<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/line.png" width="20px;" height="20px;"/></div>
											<div>선</div>
										</div>
										<div class="areaItem" data="file">
											<div class="iconArea"><img src="${pageContext.request.contextPath}/resources/editor/images/file.png" width="20px;" height="20px;"/></div>
											<div>파일</div>
										</div>
										<div class="areaItem" data="html">
											<div class="iconArea">HTML</div>
											<div>HTML</div>
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
							<div class="btnArea">
								<div class="btn btn-primary areaAddButton" data-tooltip="문단을 추가합니다.">
									문단 추가
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