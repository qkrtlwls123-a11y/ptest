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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- END: Custom CSS-->
    <script type="text/javascript">

	$(document).ready(function(){
		$("#stamp").addClass("active");
		
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
		        fn_insertFile();
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
	});
	
	function fn_stampRegi(){
		var insertCount = 0;
		$(".imageArea").each(function(){
			insertCount++;
		})
		
		if(insertCount > 0){
			alert("등록 중인 스탬프가 있습니다.");
		}else{
			var htmlString = '<div class="col-xl-2 col-md-6 col-sm-12">'+
						        '<div class="card">'+
						            '<div class="card-content">'+
						                '<div class="card-body" style="text-align:center;">'+
						                    '<div class="imageArea card-img img-fluid mb-1"></div>'+
						                    '<input type="file" style="display:inline-block;" class="w-75 mb-1 form-control-file fileupload"/>'+
						                    '<div style="width:48%;float:left;" class="mb-1 blue">스탬프 유형</div><div style="width:48%;float:left;" class="mb-1">${parameterVO.stamp_group_name}</div>'+
						                    '<div style="width:48%;float:left;" class="mb-1 blue">스탬프명</div><div style="width:48%;float:left;" class="mb-1"><input class="w-75 stamp_name" type="text"></div>'+
						                    '<div style="width:48%;float:left;" class="mb-1 blue">획득조건</div><div style="width:48%;float:left;" class="mb-1"><input class="w-75 stamp_condition" type="text"></div>'+
						                    '<div style="width:48%;float:left;" class="mb-1 blue">마일리지</div><div style="width:48%;float:left;" class="mb-1"><input class="w-75 stamp_mileage" type="text"></div>'+
						                    '<p class="card-text"><a href="#" class="btn btn-outline-teal insertBtn">등록</a>&nbsp;&nbsp;<a href="#" class="btn btn-outline-danger">취소</a></p>'+
						                '</div>'+
						            '</div>'+
						        '</div>'+
						    '</div>';
			$("#stampListArea").append(htmlString);
		}
	}
	
	$(document).on("click", ".insertBtn", function(){
		var stamp_name = $(this).parent().parent().find(".stamp_name").val();
		var stamp_condition = $(this).parent().parent().find(".stamp_condition").val();
		var stamp_mileage = $(this).parent().parent().find(".stamp_mileage").val();
		
		$("#stamp_name").val(stamp_name);
		$("#stamp_condition").val(stamp_condition);
		$("#stamp_mileage").val(stamp_mileage);
		
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/site/${siteVO.site_name}/insertStamp.json",
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
	
	function fn_updateStamp(idx){
		$("#stamp_id").val(idx);
		document.parameterVO.action = "${pageContext.request.contextPath}/site/${siteVO.site_name}/stampDetail.do";
		document.parameterVO.submit();
	}
	
	function fn_deleteStamp(idx){
		$("#stamp_id").val(idx);
		
		if(confirm("삭제하시겠습니까?")){
			var params = $("form[name=parameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/site/${siteVO.site_name}/deleteStamp.json",
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

</head>
<!-- END: Head-->

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
        <div class="content-overlay"></div>
        <div class="content-wrapper">
            <div class="content-header row">
                <div class="content-header-left col-md-6 col-12 mb-2">
                    <h3 class="content-header-title mb-0 mt-1 pl-1">스탬프 상세 목록</h3>
                    <div class="row breadcrumbs-top mb-1 pl-1">
                        <div class="breadcrumb-wrapper col-12">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">스탬프 유형</a>
                                </li>
                                <li class="breadcrumb-item active">${parameterVO.stamp_group_name}
                                </li>
                            </ol>
                        </div>
                    </div>
                </div>
                <div class="content-header-right col-md-6 col-12 mb-md-0 mb-2" style="float:right;">
                         <h4 class="card-title"></h4>
                         <div class="heading-elements mt-0" style="float:right;">
                             <button class="btn btn-primary btn-md" ><i class="d-md-none d-block feather icon-plus white"></i>
                                 <span class="d-md-block d-none" onclick="javascript:fn_stampRegi();return false;">스탬프 등록</span></button>
                         </div>
                </div>
            </div>
            <div class="content-body">
                <!-- Basic example section start -->
                <section id="basic-examples">
                    <div class="row">
                        <div class="col-12 mt-3 mb-1">
                            <h4 class="text-uppercase fw-1000">스탬프 목록</h4>
                            <p></p>
                        </div>
                    </div>

                    <div class="row match-height" id="stampListArea">
                    	<form:form id="parameterVO" name="parameterVO">
                      		<input type="hidden" id="stamp_id" name="stamp_id" value=""/>
                      		<input type="hidden" id="stamp_image" name="stamp_image" value=""/>
                      		<input type="hidden" id="stamp_mileage" name="stamp_mileage" value=""/>
                      		<input type="hidden" id="stamp_condition" name="stamp_condition" value=""/>
                      		<input type="hidden" id="stamp_name" name="stamp_name" value=""/>
                      		<input type="hidden" id="stamp_group_id" name="stamp_group_id" value="${parameterVO.stamp_group_id}"/>
                      	</form:form>
                    	<c:forEach items="${resultList}" var="resultList">
	                        <div class="col-xl-2 col-md-6 col-sm-12">
	                            <div class="card">
	                                <div class="card-content">
	                                    <div class="card-body" style="text-align:center;">
	                                        <img class="card-img img-fluid mb-1" style="min-width:90%;" src="${pageContext.request.contextPath}/file/down/${resultList.stamp_image}.png" alt="stampImage">
	                                        <div style="width:48%;float:left;" class="mb-1 blue">스탬프 유형</div><div style="width:48%;float:left;" class="mb-1">${parameterVO.stamp_group_name}</div>
	                                        <div style="width:48%;float:left;" class="mb-1 blue">스탬프명</div><div style="width:48%;float:left;" class="mb-1">${resultList.stamp_name}</div>
	                                        <div style="width:48%;float:left;" class="mb-1 blue">획득조건</div><div style="width:48%;float:left;" class="mb-1">${resultList.stamp_condition}회</div>
	                                        <div style="width:48%;float:left;" class="mb-1 blue">마일리지</div><div style="width:48%;float:left;" class="mb-1">${resultList.stamp_mileage}p</div>
	                                        <p class="card-text"><a href="#" class="btn btn-outline-teal" onclick="javascript:fn_updateStamp('${resultList.stamp_id}');return false;">수정</a>&nbsp;&nbsp;<a href="#" class="btn btn-outline-danger" onclick="javascript:fn_deleteStamp('${resultList.stamp_id}');return false;">삭제</a></p>
	                                        
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
                        </c:forEach>
                    </div>
                </section>
                <!-- // Basic example section end -->
            </div>
        </div>
    </div>
    <!-- END: Content-->

    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

    <!-- BEGIN: Footer-->
    <footer class="footer footer-static footer-dark navbar-border">
        <p class="clearfix blue-grey lighten-2 text-sm-center mb-0 px-2"><span class="float-md-left d-block d-md-inline-block">Copyright &copy; 2023 <a class="text-bold-800 grey darken-2" href="#">ONION BOX </a></span></p>
    </footer>
    <!-- END: Footer-->


    <!-- BEGIN: Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>