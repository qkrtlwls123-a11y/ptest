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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/pages/app-todo2.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">
    <!-- END: Custom CSS-->
    <script type="text/javascript">

		
	
	</script>	

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu content-left-sidebar todo-application  fixed-navbar" data-open="click" data-menu="vertical-menu" data-col="content-left-sidebar">

    <!-- BEGIN: Header-->
    <c:import url="/systemTopMenu.do"/>
    <!-- END: Header-->


    <!-- BEGIN: Main Menu-->
    <div class="main-menu menu-fixed menu-light menu-accordion menu-shadow" data-scroll-to-active="true">
        <c:import url="/leftMenu.do"/>
    </div>
    <!-- END: Main Menu-->

    <!-- BEGIN: Content-->
    <div class="app-content content content-radius">
        <div class="todo-new-task-sidebar">
			<div class="card shadow-none p-0 m-0">
				<div class="card-header border-bottom py-75">
					<div class="task-header d-flex justify-content-between align-items-center">
					</div>
					<button type="button" class="close close-icon">
						<i class="feather icon-x align-middle"></i>
					</button>
				</div>
				<!-- form start -->
				<form id="compose-form" class="mt-1">
					<div class="card-content">
						<div class="card-body py-0 border-bottom">
							<div class="form-group">
								<!-- text area for task title -->
								<textarea name="title" class="form-control task-title" cols="1" rows="2" placeholder="Write a Task Name" required readonly="readonly">
	  </textarea>
							</div>
							<div class="assigned d-flex justify-content-between">
								<div class="form-group d-flex align-items-center position-relative">
									<!-- date picker -->
									<div class="date-icon mr-50 font-medium-3">

										<i class='feather icon-calendar'></i>

									</div>
									<div class="date-picker">
										<input type="text" class="pickadate form-control pl-1" placeholder="Due Date">
									</div>
								</div>
							</div>
						</div>
						<div class="card-body task-description">
							<!--  Quill editor for task description -->
							<div class="snow-container border rounded p-50">
								<div class="compose-editor mx-75"></div>
								<div class="d-flex justify-content-end">
									<div class="compose-quill-toolbar pb-0">
										<span class="ql-formats mr-0">
											<button class="ql-bold"></button>
											<button class="ql-link"></button>
											<button class="ql-image"></button>
										</span>
									</div>
								</div>
							</div>
							<div class="mt-1 d-flex justify-content-end">
								<button type="button" class="btn btn-primary update-todo">확인</button>
							</div>
						</div>
					</div>
				</form>
				<!-- form start end-->
			</div>
		</div>


        <div class="content-right">
            <div class="content-overlay"></div>
            <div class="content-wrapper">
                <div class="content-header row">
                </div>
                <div class="content-body">
                    <div class="app-content-overlay"></div>
                    <div class="todo-app-area">
                        <div class="todo-app-list-wrapper">
                            <div class="todo-app-list">
								<h3 class="content-header-title mb-0 mt-1 pl-1">공지사항</h3>
								<div class="row breadcrumbs-top mb-1 pl-1">
									<div class="breadcrumb-wrapper col-12">
										<ol class="breadcrumb">
											<li class="breadcrumb-item"><a href="index.html">Home</a>
											</li>
											<li class="breadcrumb-item"><a href="#">나의계정</a>
											</li>
											<li class="breadcrumb-item active">공지사항
											</li>
										</ol>
									</div>
								</div>
                                <div class="todo-fixed-search d-flex justify-content-between align-items-center">
                                    
                                    <fieldset class="form-group position-relative has-icon-left m-0 flex-grow-1 pl-2">
                                        <input type="text" class="form-control todo-search" id="todo-search" placeholder="검색">
                                        <div class="form-control-position">
                                            <i class="feather icon-search"></i>
                                        </div>
                                    </fieldset>
                                    <div class="todo-sort dropdown mr-1">
                                        <button class="btn dropdown-toggle sorting" type="button" id="sortDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="feather icon-filter"></i>
                                            <span>Sort</span>
                                        </button>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="sortDropdown">
                                            <a class="dropdown-item ascending" href="#">Ascending</a>
                                            <a class="dropdown-item descending" href="#">Descending</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="todo-task-list list-group">
                                    <!-- task list start -->
                                    <ul class="todo-task-list-wrapper list-unstyled" id="todo-task-list-drag">
                                        <li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 1</p>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-danger badge-pill ml-50" style="line-height:1rem;">중요</span>
                                                    </div>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 2</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 3</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 4</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 5</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 6</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 7</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 8</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 9</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 10</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 11</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 12</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 13</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 2</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 2</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 2</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 2</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
										<li class="todo-item" data-name="David Smith">
                                            <div class="todo-title-wrapper d-flex justify-content-sm-between justify-content-end align-items-center">
                                                <div class="todo-title-area d-flex todo-badge-wrapper">
                                                    <p class="todo-title mx-50 m-0 truncate">공지사항 TEST 2</p>
                                                </div>
                                                <div class="todo-item-action d-flex align-items-center">
                                                    <div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">관리자</span>
                                                    </div>
													<div class="todo-badge-wrapper d-flex">
                                                        <span class="badge badge-secondary ml-50">2022-04-15</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                    <!-- task list end -->
                                    <div class="no-results">
                                        <h5>No Items Found</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

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


    <!-- BEGIN: Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
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
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/notice.js"></script>
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>