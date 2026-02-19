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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/pages/group.css">
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
		$("#courseList").addClass("active open");
	});
	
	function fn_updateCourse() {
		var checkCourseId = $("#course_id").val();
		var companyId = $("#company_id").val();
		location.href = "${pageContext.request.contextPath}/courseContentsDetail.do?course_id="+checkCourseId+"&company_id="+companyId;
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
        <div class="content-overlay"></div>
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body">
            	<div class="media mb-1">
                    <div class="media-body">
                        <h5 class="media-heading fw-1000">코스 관리</h5>
                    </div>
                </div>
                <!-- users edit start -->
                <section id="bg-variants">
                	<div class="row match-height">
                		<div class="col-md-4 col-sm-12">
                			<form name="parameterVO" id="parameterVO">
                				<input type="hidden" name="company_id" id="company_id" value="0"/>
                				<input type="hidden" name="course_id" id="course_id" value="${parameterVO.course_id}"/>
                				<input type="hidden" name="course_group" id="course_group" value=""/>
	                        </form>
                        </div>
                	</div>
                    <div class="row p-1" id="groupList">
                    	<div class="col-md-2 col-sm-12">
                    		<label class="filter-label mb-1 pt-25 fw-1000">코스</label>
                    		<div style="background-color:white;border-radius:0.25rem;">
                    			<div class="list-course" id="courseList" style="height: calc(100vh - 23rem);overflow:auto;">
                    			<a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between active" >
										<input type="hidden" id="group_id_${parameterVO.course_id}" name="group_name_${parameterVO.course_id}" value="${parameterVO.course_id}"/>
									    <span>${parameterVO.course_name}</span>
									</a>
	                           </div>
                           </div>
                        </div>
                        <div class="col-md-2 col-sm-12 card-area">
                    		<label class="filter-label mb-1 pt-25 fw-1000">추가 그룹 목록</label>
                    		<div style="background-color:white;border-radius:0.25rem;">
	                            <div class="list-group" id="courseGroupList" style="height: calc(100vh - 23rem);overflow:auto;">
	                            	<c:forEach var="courseGroupList" items="${courseGroupList}" varStatus="status">
		                               <div class="card text-center m-05 group-card3" id="group_object_id_${courseGroupList.group_id}">
											<input type="hidden" name="group_object" value="${courseGroupList.group_id}">
								         	<div class="card-content">
									     		<div class="card-body2">
									                <span class="card-text bt-card">${courseGroupList.group_name}<button class="btn btn-primary btn-darken-3 ml-05 pd-05" onclick="javascript:fn_delete('${courseGroupList.group_id}');return false;"><i class="feather icon-x align-middle"></i></button></span>
									            </div>
									        </div>
									     </div>
								    </c:forEach>
	                           </div>
                           </div>
                        </div>
                        <div class="col-md-8 dp-inline">
                    		<label class="filter-label mb-1 pt-25 w-100 fw-1000">전체 그룹 (*더블클릭하여 그룹을 추가해보세요.)</label>
                    		<div style="background-color:white;border-radius:0.25rem;height:calc(100vh - 23rem);">
                    			<c:forEach var="groupList" items="${groupList}" varStatus="status">
		                            <div class="card text-center m-05 group-card dp-inline">
		                            	<input type="hidden" id="group_id_${groupList.group_id}" name="group_name_${groupList.group_id}" value="${groupList.group_id}"/>
			                            <div class="card-content">
			                                <div class="card-body2">
			                                    <h5 class="card-text bt-card">${groupList.group_name}</h5>
			                                </div>
			                            </div>
			                        </div>
                    			</c:forEach>
	                        </div>
                        </div>
                    </div>
                    <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                                            <button type="button" onclick="javascript:fn_updateCourse();return false;" class="btn btn-primary glow mb-1 mb-sm-0 mr-0 mr-sm-1">다음</button>
                                            <button type="reset" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/site/${siteVO.site_name}/courseList.do'">취소</button>
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
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/course.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/navs/navs.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/group-sub.js"></script>
    
    
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>