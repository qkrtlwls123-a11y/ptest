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
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- END: Custom CSS-->

</head>
<!-- END: Head-->
<script type="text/javascript">
	
	$(document).ready(function(){
		$("#property").addClass("active open");
	});


	function fn_insert(){
		if(fn_checkRequired()){
			var params = $("form[name=parameterVO]").serialize();
			var propertyName = $("form[name=parameterVO]").find("input[name=property_name]").val();
			
			$.ajax({
				url : "/click/insertProperty.json",
				type : "POST",
				data : params,
				success : function(result) {
					if (result.resultCode == "success") {
						var htmlString = '<div class="card text-center m-1 property-card">'+
											'<input type="hidden" id="property_id_'+result.propertyVO.property_id+'" name="property_name_'+result.propertyVO.property_id+'" value="'+result.propertyVO.property_id+'"/>'+
					                            '<div class="card-content">'+
					                                '<div class="card-body2">'+
					                                    '<span class="card-text bt-card">'+propertyName+'<button class="btn btn-primary btn-darken-3 ml-2 pd-05" onclick="javascript:fn_delete('+result.propertyVO.property_id+');return false;"><i class="feather icon-x align-middle"></i></button></span>'+
					                                '</div>'+
					                            '</div>'+
					                        '</div>';
										
						$("#propertyList").append(htmlString);
						$("form[name=parameterVO]").find("input[name=property_name]").val("");
						
						$('.property-card').on('click', function () {
							$("#updateVO").find("input[name='property_name']").val($(this).find(".card-text").text());
							$("#updateVO").find("input[name='property_id']").val($(this).find("input[type=hidden]").val());
						    //show class add on new task sidebar,overlay
						    todoNewTasksidebar.addClass('show');
						    appContentOverlay.addClass('show');
						    sideBarLeft.removeClass('show');
						    //d-none add on avatar and remove from avatar-content
						    //select2 value null assign
						    //update button has add class d-none remove from add TODO
						    //mark complete btn should hide & new task title will visible
						  });
					} else {
						alert("시스템 오류 입니다.");
					}
				}
			});
		}
	}

	function fn_delete(idx){
		if(confirm("삭제하시겠습니까?")){
			$("form[name=updateVO]").find("input[name=property_id]").val(idx);
			var params = $("form[name=updateVO]").serialize();
			
			$.ajax({
				url : "/click/deleteProperty.json",
				type : "POST",
				data : params,
				success : function(result) {
					if (result.resultCode == "success") {
						location.href="/click/propertyList.do";
					} else {
						alert("시스템 오류 입니다.");
					}
				}
			});
		}
	}

	function fn_update(){
		var params = $("form[name=updateVO]").serialize();
		
		$.ajax({
			url : "/click/updateProperty.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					location.href="/click/propertyList.do";
				} else {
					alert("시스템 오류 입니다.");
				}
			}
		});
	}

	</script>
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
    	<div class="sidebar-left">
            <div class="sidebar">
                <!-- todo new task sidebar -->
                <div class="todo-new-task-sidebar">
                    <div class="card shadow-none p-0 m-0">
                        <div class="card-header border-bottom py-75">
                            <div class="task-header d-flex justify-content-between align-items-center">
                                <h5 class="new-task-title mb-0">속성 수정</h5>
                            </div>
                            <button type="button" class="close close-icon">
                                <i class="feather icon-x align-middle"></i>
                            </button>
                        </div>
                        <!-- form start -->
                        <form id="updateVO" name="updateVO" class="mt-1">
                            <div class="card-content">
                                <div class="card-body py-0 border-bottom">
                                    <div class="form-group">
                                        <!-- text area for task title -->
                                        <input type="hidden" id="property_id" name="property_id" value=""/>
                                        <input type="text" id="property_name" class="form-control w-75 dp-inline required" name="property_name" placeholder="속성명"/>
                                    </div>
                                </div>
                                <div class="card-body pb-1">
                                    <!-- quill editor for comment -->
                                    <div class="mt-1 d-flex justify-content-end">
                                        <button type="button" class="btn btn-danger" onclick="javascript:fn_update();return false;">수정</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!-- form start end-->
                    </div>
                </div>
            </div>
        </div>
        <div class="content-overlay"></div>
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body">
            	<div class="app-content-overlay"></div>
					<h3 class="content-header-title mb-0 mt-1 pl-1">속성 관리</h3>
					<div class="row breadcrumbs-top mb-1 pl-1">
						<div class="breadcrumb-wrapper col-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/siteList.do">HOME</a>
								</li>
								<li class="breadcrumb-item active">속성 관리
								</li>
							</ol>
						</div>
					</div>
                <!-- users edit start -->
                <section id="bg-variants">
                	<div class="row match-height">
                		<div class="col-md-4 col-sm-12">
                			<form name="parameterVO" id="parameterVO">
                				<input type="hidden" name="company_id" id="company_id" value="0"/>
		                		<div class="form-group">
		                            <input type="text" class="form-control w-75 dp-inline required" placeholder="속성명" name="property_name">
		                            <button type="button" class="btn btn-primary glow dp-inline" onclick="javascript:fn_insert();return false;" style="margin-bottom:3px;">등록</button>
		                        </div>
	                        </form>
                        </div>
                	</div>
                    <div class="row p-1" id="propertyList">
                    	<c:forEach var="resultList" items="${resultList}" varStatus="status">
	                    	<div class="card text-center m-1 property-card">
								<input type="hidden" id="property_id_${resultList.property_id}" name="property_name_${resultList.property_id}" value="${resultList.property_id}"/>
	                            <div class="card-content">
	                                <div class="card-body2">
	                                    <span class="card-text bt-card">${resultList.property_name}<button class="btn btn-primary btn-darken-3 ml-2 pd-05" onclick="javascript:fn_delete('${resultList.property_id}');return false;"><i class="feather icon-x align-middle"></i></button></span>
	                                </div>
	                            </div>
	                        </div>
                        </c:forEach>
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
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/pickadate/picker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/pickadate/picker.date.js"></script>
    
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/property.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/navs/navs.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/property-sub.js"></script>
    
    
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>