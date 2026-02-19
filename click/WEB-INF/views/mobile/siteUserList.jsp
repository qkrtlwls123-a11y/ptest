<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>Users List - Stack Responsive Bootstrap 4 Admin Template</title>
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/apple-icon-120.png">
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i%7COpen+Sans:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/tables/datatable/datatables.min.css">
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/pages/page-users.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">
    <!-- END: Custom CSS-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- END: Custom CSS-->
    <script type="text/javascript">

    $(document).ready(function(){
    	$("#user").addClass("active");
    });
	</script>

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu 2-columns   fixed-navbar" data-open="click" data-menu="vertical-menu-modern" data-col="2-columns">

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
                <!-- users list start -->
                <section class="users-list-wrapper">
                    <div class="users-list-filter px-1">
                        <form>
                            <div class="row border border-light rounded py-2 mb-2">
                                <div class="col-12 col-sm-6 col-lg-3">
                                    <label for="users-list-status">상태</label>
                                    <fieldset class="form-group">
                                        <select class="form-control" id="users-list-status">
                                            <option value="활동 중">활동 중</option>
                                            <option value="차단">차단</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-12 col-sm-6 col-lg-3">
                                </div>
                                <div class="col-12 col-sm-6 col-lg-3">
                                </div>
                                <div class="col-12 col-sm-6 col-lg-3 d-flex align-items-center">
                                    <button class="btn btn-block btn-primary glow">Show</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="users-list-table">
                        <div class="card">
                            <div class="card-content">
                                <div class="card-body">
                                    <!-- datatable start -->
                                    <div class="table-responsive">
                                        <table id="users-list-datatable" class="table">
                                            <thead>
                                                <tr>
                                                    <th>No.</th>
                                                    <th>아이디</th>
                                                    <th>성명</th>
                                                    <th>마지막 활동일</th>
                                                    <th>진도율</th>
                                                    <th>상태</th>
                                                    <th>edit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                	<td>4</td>
                                                    <td><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/userUpdate.do">test4@test.com</a></td>
                                                    <td>TESTTEST4
                                                    </td>
                                                    <td>2022-03-09</td>
                                                    <td>
                                                    	<div class="progress">
				                                            <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="100" aria-valuemin="100" aria-valuemax="100" style="width:100%">100%</div>
				                                        </div> 
                                        			</td>
                                                    <td><span class="badge badge-success">활동 중</span></td>
                                                    <td><a href="${pageContext.request.contextPath}/resources/html/ltr/vertical-menu-template/page-users-edit.html"><i class="feather icon-edit-1"></i></a></td>
                                                </tr>
                                                <tr>
                                                	<td>3</td>
                                                    <td><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/userUpdate.do">test3@test.com</a></td>
                                                    <td>TESTTEST3
                                                    </td>
                                                    <td>2022-05-20</td>
                                                    <td>
                                                    	<div class="progress">
				                                            <div class="progress-bar" role="progressbar" aria-valuenow="20" aria-valuemin="20" aria-valuemax="100" style="width:20%">20%</div>
				                                        </div> 
                                        			</td>
                                                    <td><span class="badge badge-success">활동 중</span></td>
                                                    <td><a href="${pageContext.request.contextPath}/resources/html/ltr/vertical-menu-template/page-users-edit.html"><i class="feather icon-edit-1"></i></a></td>
                                                </tr>
                                                <tr>
                                                	<td>2</td>
                                                    <td><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/userUpdate.do">test2@test.com</a></td>
                                                    <td>TESTTEST2
                                                    </td>
                                                    <td>2022-05-20</td>
                                                    <td>
                                                    	<div class="progress">
                                                    		<div class="progress-bar bg-danger" role="progressbar" aria-valuenow="60" aria-valuemin="60" aria-valuemax="100" style="width:60%">60%</div>
                                                    	</div>
                                        			</td>
                                                    <td><span class="badge badge-success">활동 중</span></td>
                                                    <td><a href="${pageContext.request.contextPath}/resources/html/ltr/vertical-menu-template/page-users-edit.html"><i class="feather icon-edit-1"></i></a></td>
                                                </tr>
                                                <tr>
                                                	<td>1</td>
                                                    <td><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/userUpdate.do">test1@test.com</a></td>
                                                    <td>TESTTEST1
                                                    </td>
                                                    <td>2022-05-20</td>
                                                    <td>
                                                    	<div class="progress">
				                                            <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="45" aria-valuemax="100" style="width:45%">45%</div>
				                                        </div> 
                                        			</td>
                                                    <td><span class="badge badge-danger">차단</span></td>
                                                    <td><a href="${pageContext.request.contextPath}/resources/html/ltr/vertical-menu-template/page-users-edit.html"><i class="feather icon-edit-1"></i></a></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- datatable ends -->
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- users list ends -->
            </div>
        </div>
    </div>
    <!-- END: Content-->

    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

    <!-- BEGIN: Footer-->
    <footer class="footer footer-static footer-light navbar-border">
        <p class="clearfix blue-grey lighten-2 text-sm-center mb-0 px-2"><span class="float-md-left d-block d-md-inline-block">Copyright &copy; 2020 <a class="text-bold-800 grey darken-2" href="https://1.envato.market/pixinvent_portfolio" target="_blank">PIXINVENT </a></span></p>
    </footer>
    <!-- END: Footer-->


    <!-- BEGIN: Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/datatable/datatables.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/page-users.js"></script>
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>