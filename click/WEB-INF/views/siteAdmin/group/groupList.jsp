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
    <!-- END: Custom CSS-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- END: Custom CSS-->

</head>
<!-- END: Head-->
<script type="text/javascript">
	
	$(document).ready(function(){
		$("#property").addClass("active open");
		
		$('.list-group-item').on('click', function () {
			$("#updateVO").find("#group_modify_name").val($(this).find(".card-text").text());
			$("#updateVO").find("#group_modify_id").val($(this).find("input[type=hidden]").val());
		    todoNewTasksidebar.addClass('show');
		    appContentOverlay.addClass('show');
		  });
	});

	function fn_deleteGroup(idx){
		if(confirm("그룹을 삭제하시겠습니까?")){
			$("#group_id").val(idx);
			var params = $("form[name=parameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/site/${siteVO.site_name}/deleteGroup.json",
				type : "POST",
				data : params,
				success : function(result) {
					if (result.resultCode == "success") {
						alert("삭제 되었습니다.");
						location.reload();
					} else {
						
					}
				}
			});
		}
	}
	
	function fn_updateGroup(){
		var groupName = $("#updateVO").find("#group_modify_name").val();
		var groupId = $("#updateVO").find("#group_modify_id").val();
		
		$("#group_id").val(groupId);
		$("#group_name").val(groupName);
		
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/site/${siteVO.site_name}/updateGroupDetail.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					alert("수정 되었습니다.");
					location.reload();
				} else {
					
				}
			}
		});
		
	}
</script>
<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu content-left-sidebar todo-application  fixed-navbar" data-open="click" data-menu="vertical-menu-modern" data-col="content-left-sidebar">

    <!-- BEGIN: Header-->
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
    	<div class="sidebar-left">
            <div class="sidebar">
                <!-- todo new task sidebar -->
                <div class="todo-new-task-sidebar">
                    <div class="card shadow-none p-0 m-0">
                        <div class="card-header border-bottom py-75">
                            <div class="task-header d-flex justify-content-between align-items-center">
                                <h5 class="new-task-title mb-0">그룹 수정</h5>
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
                                        <input type="hidden" id="group_modify_id" value=""/>
                                        <input type="text" id="group_modify_name" class="form-control w-75 dp-inline required" name="group_modify_name" placeholder="그룹명"/>
                                    </div>
                                </div>
                                <div class="card-body pb-1">
                                    <!-- quill editor for comment -->
                                    <div class="mt-1 d-flex justify-content-end">
                                        <button type="button" class="btn btn-danger" onclick="javascript:fn_updateGroup();return false;">수정</button>
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
					<h3 class="content-header-title mb-0 mt-1 pl-1">그룹 관리</h3>
					<div class="row breadcrumbs-top mb-1 pl-1">
						<div class="breadcrumb-wrapper col-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/siteInfo.do">HOME</a>
								</li>
								<li class="breadcrumb-item active">그룹 관리
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
                				<input type="hidden" name="group_id" id="group_id" value=""/>
                				<input type="hidden" name="property_id_group" id="property_id_group" value=""/>
		                		<div class="form-group">
		                            <input type="text" class="form-control w-75 dp-inline required" id="group_name" placeholder="그룹명" name="group_name">
		                            <button type="button" class="btn btn-primary glow dp-inline" onclick="javascript:fn_insert();return false;" style="margin-bottom:3px;">등록</button>
		                        </div>
	                        </form>
                        </div>
                	</div>
                    <div class="row p-1" id="propertyList">
                    	<div class="col-md-2 col-sm-12">
                    		<label class="filter-label mb-1 pt-25 fw-1000">그룹 목록</label>
                    		<div style="background-color:white;border-radius:0.25rem;">
                    			<div class="list-group" id="groupList" style="height: calc(100vh - 25rem);overflow:auto;">
                    			<c:forEach var="groupList" items="${groupList}" varStatus="status">
									<a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between" >
										<input type="hidden" id="group_id_${groupList.group_id}" name="group_name_${groupList.group_id}" value="${groupList.group_id}"/>
									    <span class="card-text">${groupList.group_name}</span>
									    <button class="btn btn-primary btn-darken-3 ml-05 pd-05" onclick="javascript:fn_deleteGroup('${groupList.group_id}');return false;"><i class="feather icon-x align-middle"></i></button>
									</a>
	                           </c:forEach>
	                           </div>
                           </div>
                        </div>
                        <div class="col-md-2 col-sm-12 card-area">
                    		<label class="filter-label mb-1 pt-25 fw-1000">그룹 속성</label>
                    		<div style="background-color:white;border-radius:0.25rem;">
	                            <div class="list-group" id="groupPropertyList" style="height: calc(100vh - 25rem);overflow:auto;">
	                               
	                           </div>
                           </div>
                        </div>
                        <div class="col-md-8 dp-inline">
                    		<label class="filter-label mb-1 pt-25 w-100 fw-1000">전체 속성 <span class="info-text"><i class="feather icon-info"></i> *더블클릭하여 속성을 추가해보세요.</span></label>
                    		<div style="background-color:white;border-radius:0.25rem;height:95%;">
                    			<c:forEach var="sitePropertyList" items="${sitePropertyList}" varStatus="status">
		                            <div class="card text-center m-05 property-card dp-inline">
		                            	<input type="hidden" id="property_id_${sitePropertyList.property_id}" name="property_name_${sitePropertyList.property_id}" value="${sitePropertyList.property_id}"/>
			                            <div class="card-content">
			                                <div class="card-body2">
			                                    <h5 class="card-text bt-card">${sitePropertyList.property_name}</h5>
			                                </div>
			                            </div>
			                        </div>
                    			</c:forEach>
	                        </div>
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
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/pickadate/picker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/pickadate/picker.date.js"></script>
    
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/group.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/navs/navs.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/property-sub.js"></script>
    
    
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>