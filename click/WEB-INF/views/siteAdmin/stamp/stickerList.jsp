<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- - var menuBorder = true-->
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
<!--<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/favicon.ico">-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i%7COpen+Sans:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/pickers/daterange/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/selects/select2.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/quill.snow.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/extensions/dragula.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/tables/datatable/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/tables/extensions/rowReorder.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/tables/extensions/responsive.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/icheck/icheck.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/icheck/custom.css">
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/pages/app-todo.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/pages/app-contacts.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/stickerlist.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- END: Custom CSS-->

</head>
<!-- END: Head-->
<script type="text/javascript">

	$(document).ready(function(){
		$("#stamp").addClass("active open");
		
		$(document).on("change",".fileupload", fn_addFiles);
		
		function fn_addFiles(e) {
			filesTempArr = [];
		    var files = e.target.files;
		    var filesArr = Array.prototype.slice.call(files);
		    var filesArrLen = filesArr.length;
		    var filesTempArrLen = filesTempArr.length;
		    for( var i=0; i<filesArrLen; i++ ) {
		        filesTempArr.push(filesArr[i]);
		        fileName = filesArr[i].name;
		        fn_insertFile(fileName);
		    }
		}
		
		function fn_insertFile(fileName){
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
			        		
			        		var htmlString = '<img class="card-img img-fluid mb-1" src="${pageContext.request.contextPath}/file/down/'+fileId+'.png" alt="Card image cap">';
			        		//var htmlString = '<img class="card-img img-fluid mb-1" src="${pageContext.request.contextPath}/resources/img/stamp.png" alt="Card image cap">';
			        		$("#stamp_image").val(fileId);
							$(".imageArea").html(htmlString);
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
		
		$(document).on("click", ".insertBtn", function(){
			var sticker_name = $(this).parent().parent().find(".sticker_name").val();
			var sticker_condition = $(this).parent().parent().find(".sticker_condition").val();
			var sticker_mileage = $(this).parent().parent().find(".sticker_mileage").val();
			
			$("#sticker_name").val(sticker_name);
			$("#sticker_condition").val(sticker_condition);
			$("#sticker_mileage").val(sticker_mileage);
			
			var params = $("form[name=parameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/site/${siteVO.site_name}/insertSticker.json",
				type : "POST",
				data : params,
				success : function(result) {
					if (result.resultCode == "success") {
						location.reload();
					} else {
						
					}
				}
			});
		})
		
		$(document).on("click", ".updateBtn", function(){
			var sticker_name = $(this).parent().parent().find(".sticker_name").val();
			var sticker_condition = $(this).parent().parent().find(".sticker_condition").val();
			var sticker_mileage = $(this).parent().parent().find(".sticker_mileage").val();
			
			$("#sticker_name").val(sticker_name);
			$("#sticker_condition").val(sticker_condition);
			$("#sticker_mileage").val(sticker_mileage);
			
			var params = $("form[name=parameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/site/${siteVO.site_name}/updateSticker.json",
				type : "POST",
				data : params,
				success : function(result) {
					if (result.resultCode == "success") {
						location.reload();
					} else {
						
					}
				}
			});
		})
		
		$(document).on("click", ".stmapTitle", function(e){
			if($(this).parent().find(".contentsArrow").hasClass("icon-chevron-down")){
				$(this).parent().find(".contentsArrow").removeClass("icon-chevron-down");
				$(this).parent().find(".contentsArrow").addClass("icon-chevron-up");
				$(this).parent().parent().find(".contentsList").show();
			}else{
				$(this).parent().find(".contentsArrow").removeClass("icon-chevron-up");
				$(this).parent().find(".contentsArrow").addClass("icon-chevron-down");
				$(this).parent().parent().find(".contentsList").hide();
			}
		});
		
		$(document).on("click", ".contentsArrow", function(e){
			if($(this).hasClass("icon-chevron-down")){
				$(this).removeClass("icon-chevron-down");
				$(this).addClass("icon-chevron-up");
				$(this).parent().parent().find(".contentsList").show();
			}else{
				$(this).removeClass("icon-chevron-up");
				$(this).addClass("icon-chevron-down");
				$(this).parent().parent().find(".contentsList").hide();
			}
		});
	});
	
	function fn_siteRegi(){
		location.href="${pageContext.request.contextPath}/site/${siteVO.site_name}/siteRegi.do";
	}
	function fn_stickerDetail(idx){
		$("#sticker_group_id").val(idx);
		document.parameterVO.action = "${pageContext.request.contextPath}/site/${siteVO.site_name}/stickerDetail.do";
		document.parameterVO.submit();
	}
	
	function fn_stickerRegi(idx){
		var insertCount = 0;
		$(".imageArea").each(function(){
			insertCount++;
		})
		
		if($("#body"+idx).find(".contentsArrow").hasClass("icon-chevron-down")){
			$("#body"+idx).find(".contentsArrow").removeClass("icon-chevron-down");
			$("#body"+idx).find(".contentsArrow").addClass("icon-chevron-up");
			$("#body"+idx).find(".contentsList").show();
		}
		
		if(insertCount > 0){
			alert("등록 중인 스티커가 있습니다.");
		}else{
			$("#sticker_group_id").val(idx);
			var htmlString = '<div class="box" style="--clr:var(--main-bg-color);">'+
								'<div class="contents">'+
									'<div class="icon imageArea">'+
									'<input type="file" id="imageFileField'+insertCount+'" class="form-control-file fileupload" style="display:none;"/><label for="imageFileField'+insertCount+'" class="btn btn-primary">업로드</label>'+
									'</div>'+
									'<div class="text">'+
										'<div class="text-contents-row insert"><span class="title">스티커명</span> <br> <span class="text-contents"><input class="sticker_name" type="text" style="width:70px;border-radius:3px;border:none;"></span></div>'+
										'<div class="text-contents-row insert"><span class="title">획득조건</span> <br> <span class="text-contents"><input class="sticker_condition" type="text" style="width:70px;border-radius:3px;border:none;"> 회</span></div>'+
										'<div class="text-contents-row insert"><span class="title">마일리지</span> <br> <span class="text-contents"><input class="sticker_mileage" type="text" style="width:70px;border-radius:3px;border:none;"> P</span></div>'+
									'</div>'+
									'<div class="button">'+
										'<a href="#" class="btn btn-primary rounded-circle insertBtn"><i class="feather icon-edit"></i></a>'+
										'<a href="#" class="btn btn-danger rounded-circle"><i class="feather icon-x-circle"></i></a>'+
									'</div>'+
								'</div>'+
							'</div>';
			$("#contentsList"+idx).append(htmlString);
		}
	}
	
	function fn_updateSticker(idx, groupName, stickerName, stickerCondition, stickerMileage, stickerImage){
		var insertCount = 0;
		$(".imageArea").each(function(){
			insertCount++;
		})
		
		if(insertCount > 0){
			alert("등록 중인 스티커가 있습니다.");
		}else{
			$("#sticker_id").val(idx);
			$("#sticker_image").val(stickerImage);
			var htmlString = '<div class="contents">'+
									'<div class="icon imageArea">'+
									'<img src="http://ptest.co.kr/click/file/down/'+stickerImage+'" alt="img02" class="updateImage"/>'+
									'</div>'+
									'<div class="text">'+
										'<div class="text-contents-first insert"><span class="title">스티커명</span> <br> <span class="text-contents"><input class="sticker_name" type="text" style="width:70px;border-radius:3px;border:none;" value="'+stickerName+'"></span></div>'+
										'<div class="text-contents-row insert"><span class="title">획득조건</span> <br> <span class="text-contents"><input class="sticker_condition" type="text" style="width:70px;border-radius:3px;border:none;" value="'+stickerCondition+'"> 회</span></div>'+
										'<div class="text-contents-row insert"><span class="title">마일리지</span> <br> <span class="text-contents"><input class="sticker_mileage" type="text" style="width:70px;border-radius:3px;border:none;" value="'+stickerMileage+'"> P</span></div>'+
									'</div>'+
									'<div class="button">'+
										'<a href="#" class="btn btn-primary rounded-circle updateBtn"><i class="feather icon-edit"></i></a>'+
										'<a href="#" class="btn btn-danger rounded-circle"><i class="feather icon-x-circle"></i></a>'+
									'</div>'+
								'</div>';
			$("#sticker_"+idx).html(htmlString);
			$("#sticker_"+idx).attr("style", "--clr:var(--main-bg-color);");
		}
	}
	
	$(document).on("click", ".icon-x-circle", function(){
		location.reload();
	})
	
	function fn_deleteSticker(idx){
		$("#sticker_id").val(idx);
		
		if(confirm("삭제하시겠습니까?")){
			var params = $("form[name=parameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/site/${siteVO.site_name}/deleteSticker.json",
				type : "POST",
				data : params,
				success : function(result) {
					if (result.resultCode == "success") {
						location.reload();
					} else {
						
					}
				}
			});
		}
	}
	
</script>	

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu content-left-sidebar todo-application  fixed-navbar" data-open="click" data-menu="vertical-menu" data-col="content-left-sidebar">

    <!-- BEGIN: Header-->
    <c:import url="/siteTopMenu.do"/>
    <!-- END: Header-->


    <!-- BEGIN: Main Menu-->
    <div class="main-menu menu-fixed menu-dark menu-accordion menu-shadow" data-scroll-to-active="true">
        <c:import url="/siteLeftMenu.do"/>
    </div>
    <!-- END: Main Menu-->

    <!-- BEGIN: Content-->
    <div class="app-content content content-radius">
        <div class="content-right" style="width: calc(100% - 15px) !important;">
            <div class="content-overlay"></div>
            <div class="content-wrapper">
                <div class="content-header row">
                </div>
                <div class="content-body">
                    <div class="app-content-overlay"></div>
					<h3 class="content-header-title mb-0 mt-1 pl-1">스티커 관리</h3>
					<div class="row breadcrumbs-top mb-1 pl-1">
						<div class="breadcrumb-wrapper col-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/siteInfo.do">HOME</a>
								</li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/stickerList.do">스탬프/스티커 관리</a>
								</li>
								<li class="breadcrumb-item active">스티커 관리
								</li>
							</ol>
						</div>
					</div>
                    <section class="row all-contacts">
                        <div class="col-12">
                            <div class="card contentsArea">
                                <div class="card-head">
                                    <div class="card-header">
                                        <h4 class="card-title"></h4>
                                        <div class="heading-elements mt-0">
                                        </div>
                                    </div>
                                </div>
                                <div class="card-content">
                                	<form:form id="parameterVO" name="parameterVO">
                                		<input type="hidden" id="sticker_id" name="sticker_id" value=""/>
			                      		<input type="hidden" id="sticker_image" name="sticker_image" value=""/>
			                      		<input type="hidden" id="sticker_mileage" name="sticker_mileage" value=""/>
			                      		<input type="hidden" id="sticker_condition" name="sticker_condition" value=""/>
			                      		<input type="hidden" id="sticker_name" name="sticker_name" value=""/>
			                      		<input type="hidden" id="sticker_group_id" name="sticker_group_id" value=""/>
			                      		<input type="hidden" id="imageName" value=""/>
                                	</form:form>
                                    <div class="card-body">
                                    	<div id="body1">
	                                        <div class="stickerListItem"><span class="stmapTitle">의견 등록하기</span> <span class="btn btn-primary btn-sm btn-sticker-regi" onclick="javascript:fn_stickerRegi('1');return false;">등록</span><i class="contentsArrow feather icon-chevron-up"></i></div>
	                                        <div class="contentsList" id="contentsList1">
												<c:forEach var="detailList" items="${detailList}" varStatus="status">
													<c:if test="${detailList.sticker_group_id == '1'}">
														<div class="box" style="--clr:white" id="sticker_${detailList.sticker_id}">
															<div class="contents">
																	<div class="icon">
																		<img src="http://ptest.co.kr/click/file/down/${detailList.sticker_image}" alt="img02" />
																	</div>
																<div class="text">
																	<div class="text-contents-first"><span class="title">스티커명</span> <br> <span class="text-contents">${detailList.sticker_name}</span></div>
																	<div class="text-contents-row"><span class="title">획득조건</span> <br> <span class="text-contents">${detailList.sticker_condition}회</span></div>
																	<div class="text-contents-row"><span class="title">마일리지</span> <br> <span class="text-contents">${detailList.sticker_mileage}P</span></div>
																</div>
																<div class="button">
																	<a href="#" class="btn btn-primary rounded-circle edit-button" onclick="javascript:fn_updateSticker('${detailList.sticker_id}', '${parameterVO.sticker_group_name}', '${detailList.sticker_name}', '${detailList.sticker_condition}', '${detailList.sticker_mileage}', '${detailList.sticker_image}');return false;"><i class="feather icon-edit"></i></a>
																	<a href="#" class="btn btn-danger rounded-circle" onclick="javascript:fn_deleteSticker('${detailList.sticker_id}');return false;"><i class="feather icon-trash-2"></i></a>
																</div>
															</div>
														</div>
													</c:if>
												</c:forEach>
											</div>
										</div>
										<div id="body2">
											<div class="stickerListItem"><span class="stmapTitle">댓글 등록하기</span> <span class="btn btn-primary btn-sm btn-sticker-regi" onclick="javascript:fn_stickerRegi('2');return false;">등록</span><i class="contentsArrow feather icon-chevron-up"></i></div>
	                                        <div class="contentsList" id="contentsList2">
												<c:forEach var="detailList" items="${detailList}" varStatus="status">
													<c:if test="${detailList.sticker_group_id == '2'}">
														<div class="box" style="--clr:white" id="sticker_${detailList.sticker_id}">
															<div class="contents">
																	<div class="icon">
																		<img src="http://ptest.co.kr/click/file/down/${detailList.sticker_image}" alt="img02" />
																	</div>
																<div class="text">
																	<div class="text-contents-first"><span class="title">스티커명</span> <br> <span class="text-contents">${detailList.sticker_name}</span></div>
																	<div class="text-contents-row"><span class="title">획득조건</span> <br> <span class="text-contents">${detailList.sticker_condition}회</span></div>
																	<div class="text-contents-row"><span class="title">마일리지</span> <br> <span class="text-contents">${detailList.sticker_mileage}P</span></div>
																</div>
																<div class="button">
																	<a href="#" class="btn btn-primary rounded-circle edit-button" onclick="javascript:fn_updateSticker('${detailList.sticker_id}', '${parameterVO.sticker_group_name}', '${detailList.sticker_name}', '${detailList.sticker_condition}', '${detailList.sticker_mileage}', '${detailList.sticker_image}');return false;"><i class="feather icon-edit"></i></a>
																	<a href="#" class="btn btn-danger rounded-circle" onclick="javascript:fn_deleteSticker('${detailList.sticker_id}');return false;"><i class="feather icon-trash-2"></i></a>
																</div>
															</div>
														</div>
													</c:if>
												</c:forEach>
											</div>
										</div>
										<div id="body3">
											<div class="stickerListItem"><span class="stmapTitle">좋아요</span> <span class="btn btn-primary btn-sm btn-sticker-regi" onclick="javascript:fn_stickerRegi('3');return false;">등록</span><i class="contentsArrow feather icon-chevron-up"></i></div>
	                                        <div class="contentsList" id="contentsList3">
												<c:forEach var="detailList" items="${detailList}" varStatus="status">
													<c:if test="${detailList.sticker_group_id == '3'}">
														<div class="box" style="--clr:white" id="sticker_${detailList.sticker_id}">
															<div class="contents">
																	<div class="icon">
																		<img src="http://ptest.co.kr/click/file/down/${detailList.sticker_image}" alt="img02" />
																	</div>
																<div class="text">
																	<div class="text-contents-first"><span class="title">스티커명</span> <br> <span class="text-contents">${detailList.sticker_name}</span></div>
																	<div class="text-contents-row"><span class="title">획득조건</span> <br> <span class="text-contents">${detailList.sticker_condition}회</span></div>
																	<div class="text-contents-row"><span class="title">마일리지</span> <br> <span class="text-contents">${detailList.sticker_mileage}P</span></div>
																</div>
																<div class="button">
																	<a href="#" class="btn btn-primary rounded-circle edit-button" onclick="javascript:fn_updateSticker('${detailList.sticker_id}', '${parameterVO.sticker_group_name}', '${detailList.sticker_name}', '${detailList.sticker_condition}', '${detailList.sticker_mileage}', '${detailList.sticker_image}');return false;"><i class="feather icon-edit"></i></a>
																	<a href="#" class="btn btn-danger rounded-circle" onclick="javascript:fn_deleteSticker('${detailList.sticker_id}');return false;"><i class="feather icon-trash-2"></i></a>
																</div>
															</div>
														</div>
													</c:if>
												</c:forEach>
											</div>
										</div>
										<div id="body4">
											<div class="stickerListItem"><span class="stmapTitle">스크랩</span> <span class="btn btn-primary btn-sm btn-sticker-regi" onclick="javascript:fn_stickerRegi('4');return false;">등록</span><i class="contentsArrow feather icon-chevron-up"></i></div>
	                                        <div class="contentsList" id="contentsList4">
												<c:forEach var="detailList" items="${detailList}" varStatus="status">
													<c:if test="${detailList.sticker_group_id == '4'}">
														<div class="box" style="--clr:white" id="sticker_${detailList.sticker_id}">
															<div class="contents">
																	<div class="icon">
																		<img src="http://ptest.co.kr/click/file/down/${detailList.sticker_image}" alt="img02" />
																	</div>
																<div class="text">
																	<div class="text-contents-first"><span class="title">스티커명</span> <br> <span class="text-contents">${detailList.sticker_name}</span></div>
																	<div class="text-contents-row"><span class="title">획득조건</span> <br> <span class="text-contents">${detailList.sticker_condition}회</span></div>
																	<div class="text-contents-row"><span class="title">마일리지</span> <br> <span class="text-contents">${detailList.sticker_mileage}P</span></div>
																</div>
																<div class="button">
																	<a href="#" class="btn btn-primary rounded-circle edit-button" onclick="javascript:fn_updateSticker('${detailList.sticker_id}', '${parameterVO.sticker_group_name}', '${detailList.sticker_name}', '${detailList.sticker_condition}', '${detailList.sticker_mileage}', '${detailList.sticker_image}');return false;"><i class="feather icon-edit"></i></a>
																	<a href="#" class="btn btn-danger rounded-circle" onclick="javascript:fn_deleteSticker('${detailList.sticker_id}');return false;"><i class="feather icon-trash-2"></i></a>
																</div>
															</div>
														</div>
													</c:if>
												</c:forEach>
											</div>
										</div>
										<div id="body5">
											<div class="stickerListItem"><span class="stmapTitle">학습 시작</span> <span class="btn btn-primary btn-sm btn-sticker-regi" onclick="javascript:fn_stickerRegi('5');return false;">등록</span><i class="contentsArrow feather icon-chevron-up"></i></div>
	                                        <div class="contentsList" id="contentsList5">
												<c:forEach var="detailList" items="${detailList}" varStatus="status">
													<c:if test="${detailList.sticker_group_id == '5'}">
														<div class="box" style="--clr:white" id="sticker_${detailList.sticker_id}">
															<div class="contents">
																	<div class="icon">
																		<img src="http://ptest.co.kr/click/file/down/${detailList.sticker_image}" alt="img02" />
																	</div>
																<div class="text">
																	<div class="text-contents-first"><span class="title">스티커명</span> <br> <span class="text-contents">${detailList.sticker_name}</span></div>
																	<div class="text-contents-row"><span class="title">획득조건</span> <br> <span class="text-contents">${detailList.sticker_condition}회</span></div>
																	<div class="text-contents-row"><span class="title">마일리지</span> <br> <span class="text-contents">${detailList.sticker_mileage}P</span></div>
																</div>
																<div class="button">
																	<a href="#" class="btn btn-primary rounded-circle edit-button" onclick="javascript:fn_updateSticker('${detailList.sticker_id}', '${parameterVO.sticker_group_name}', '${detailList.sticker_name}', '${detailList.sticker_condition}', '${detailList.sticker_mileage}', '${detailList.sticker_image}');return false;"><i class="feather icon-edit"></i></a>
																	<a href="#" class="btn btn-danger rounded-circle" onclick="javascript:fn_deleteSticker('${detailList.sticker_id}');return false;"><i class="feather icon-trash-2"></i></a>
																</div>
															</div>
														</div>
													</c:if>
												</c:forEach>
											</div>
										</div>
										<div id="body6">
											<div class="stickerListItem"><span class="stmapTitle">프로필 등록</span><i class="contentsArrow feather icon-chevron-up"></i> <span class="btn btn-primary btn-sm btn-sticker-regi" onclick="javascript:fn_stickerRegi('6');return false;">등록</span><i class="contentsArrow feather icon-chevron-up"></i></div>
	                                        <div class="contentsList" id="contentsList6">
												<c:forEach var="detailList" items="${detailList}" varStatus="status">
													<c:if test="${detailList.sticker_group_id == '6'}">
														<div class="box" style="--clr:white" id="sticker_${detailList.sticker_id}">
															<div class="contents">
																	<div class="icon">
																		<img src="http://ptest.co.kr/click/file/down/${detailList.sticker_image}" alt="img02" />
																	</div>
																<div class="text">
																	<div class="text-contents-first"><span class="title">스티커명</span> <br> <span class="text-contents">${detailList.sticker_name}</span></div>
																	<div class="text-contents-row"><span class="title">획득조건</span> <br> <span class="text-contents">${detailList.sticker_condition}회</span></div>
																	<div class="text-contents-row"><span class="title">마일리지</span> <br> <span class="text-contents">${detailList.sticker_mileage}P</span></div>
																</div>
																<div class="button">
																	<a href="#" class="btn btn-primary rounded-circle edit-button" onclick="javascript:fn_updateSticker('${detailList.sticker_id}', '${parameterVO.sticker_group_name}', '${detailList.sticker_name}', '${detailList.sticker_condition}', '${detailList.sticker_mileage}', '${detailList.sticker_image}');return false;"><i class="feather icon-edit"></i></a>
																	<a href="#" class="btn btn-danger rounded-circle" onclick="javascript:fn_deleteSticker('${detailList.sticker_id}');return false;"><i class="feather icon-trash-2"></i></a>
																</div>
															</div>
														</div>
													</c:if>
												</c:forEach>
											</div>
										</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                </div>
            </div>
        </div>
    </div>
    <!-- END: Content-->

    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

    <!-- BEGIN: Footer-->
    <footer class="footer footer-static footer-light navbar-border">
        <p class="clearfix blue-grey lighten-2 text-sm-center mb-0 px-2"><span class="float-md-left d-block d-md-inline-block">Copyright &copy; 2023 <a class="text-bold-800 grey darken-2" href="#">ONION BOX </a></span></p>
    </footer>
    <!-- END: Footer-->


	<script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/extensions/jquery.raty.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/datatable/dataTables.bootstrap4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/datatable/dataTables.responsive.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/datatable/dataTables.rowReorder.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/icheck/icheck.min.js"></script>

	<script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/daterange/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/daterange/daterangepicker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/quill/quill.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/extensions/dragula.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/app-contacts.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/app-todo.js"></script>
    <!-- END: Page JS-->
    

</body>
<!-- END: Body-->

</html>