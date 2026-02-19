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
    <!-- END: Custom CSS-->
    <script type="text/javascript">

	$(document).ready(function(){
		
	});
	
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
		<div class="sidebar-left">
            <div class="sidebar">
                <div class="todo-sidebar d-flex">
                    <span class="sidebar-close-icon">
                        <i class="feather icon-x"></i>
                    </span>
                    <!-- todo app menu -->
                    <div class="todo-app-menu">
                        
                        <!-- sidebar list start -->
                        <div class="sidebar-menu-list">
                            <label class="filter-label mt-2 mb-1 pt-25">상태</label>
                            <div class="list-group">
                                <a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between active" id="total">
                                    <span>전체</span>
                                </a>
                                <a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between" id="request">
                                    <span>픽업요청</span>
                                </a>
                                <a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between" id="arrive">
                                    <span>상품도착</span>
                                </a>
                                <a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between" id="wear">
                                    <span>입고</span>
                                </a>
                                <a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between" id="confirm">
                                    <span>상품확인</span>
                                </a>
								<a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between" id="wait">
                                    <span>판매대기</span>
                                </a>
								<a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between" id="sale">
                                    <span>판매중</span>
                                </a>
								<a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between" id="sold">
                                    <span>판매완료</span>
                                </a>
                            </div>
                        </div>
                        <!-- sidebar list end -->
                    </div>
                </div>
                <!-- todo new task sidebar -->
                <div class="todo-new-task-sidebar">
                    <div class="card shadow-none p-0 m-0">
                        
                        <!-- form start -->
                        <form id="compose-form" class="mt-1">
                            <div class="card-content">
                                <div class="card-body py-0 border-bottom">
                                    <div class="form-group">
                                        <!-- text area for task title -->
                                        <textarea name="title" class="form-control task-title" cols="1" rows="2" placeholder="Write a Task Name" required>
			  </textarea>
                                    </div>
                                    <div class="assigned d-flex justify-content-between">
                                        <div class="form-group d-flex align-items-center mr-1">
                                            <!-- users avatar -->
                                            <div class="avatar">
                                                <img src="#" class="avatar-user-image d-none" alt="#" width="38" height="38">
                                                <div class="avatar-content">
                                                    <i class='feather icon-user font-medium-4'></i>
                                                </div>
                                            </div>
                                            <!-- select2  for user name  -->
                                            <div class="select-box mr-1">
                                                <select class="select2-users-name form-control" id="select2-users-name">
                                                    <optgroup label="Backend">
                                                        <option value="David Smith">David Smith</option>
                                                        <option value="John Doe">John Doe</option>
                                                        <option value="James Smith">James Smith</option>
                                                        <option value="Maria Garcia">Maria Garcia</option>
                                                    </optgroup>
                                                    <optgroup label="Frontend">
                                                        <option value="Maria Rodrigu">Maria Rodrigu</option>
                                                        <option value="Marry Smith">Marry Smith</option>
                                                        <option value="Maria Hern">Maria Hern</option>
                                                        <option value="Jamesh J">Jamesh Jackson</option>
                                                    </optgroup>
                                                </select>
                                            </div>
                                        </div>
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
                                <div class="card-body border-bottom task-description">
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
                                    <div class="tag d-flex justify-content-between align-items-center pt-1">
                                        <div class="flex-grow-1 d-flex align-items-center">
                                            <i class="feather icon-tag align-middle mr-25"></i>
                                            <select class="select2-assign-label form-control" multiple="multiple" id="select2-assign-label" disabled>
                                                <optgroup label="Tags">
                                                    <option value="Frontend">Frontend</option>
                                                    <option value="Backend">Backend</option>
                                                    <option value="Issue">Issue</option>
                                                    <option value="Design">Design</option>
                                                    <option value="Wireframe">Wireframe</option>
                                                </optgroup>
                                            </select>
                                        </div>
                                        <div class="ml-25">
                                            <i class="feather icon-plus-circle cursor-pointer add-tags"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body pb-1">
                                    <div class="d-flex align-items-center mb-1">
                                        <div class="avatar mr-75">
                                            <img src="${pageContext.request.contextPath}/resources/app-assets/images/portrait/small/avatar-s-3.png" alt="charlie" width="38" height="38">
                                        </div>
                                        <div class="avatar-content">
                                            Charlie created this task
                                        </div>
                                        <small class="ml-75 text-muted">13 days ago</small>
                                    </div>
                                    <!-- quill editor for comment -->
                                    <div class="snow-container border rounded p-50 ">
                                        <div class="comment-editor mx-75"></div>
                                        <div class="d-flex justify-content-end">
                                            <div class="comment-quill-toolbar pb-0">
                                                <span class="ql-formats mr-0">
                                                    <button class="ql-bold"></button>
                                                    <button class="ql-link"></button>
                                                    <button class="ql-image"></button>
                                                </span>
                                            </div>
                                            <button type="button" class="btn btn-sm btn-primary comment-btn">
                                                <span>Comment</span>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="mt-1 d-flex justify-content-end">
                                        <button type="button" class="btn btn-danger add-todo">Add Task</button>
                                        <button type="button" class="btn btn-danger update-todo">Save Changes</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!-- form start end-->
                    </div>
                </div>
            </div>
        </div>
        <div class="content-right">
            <div class="content-overlay"></div>
            <div class="content-wrapper">
                <div class="content-header row">
                </div>
                <div class="content-body">
                    <div class="app-content-overlay"></div>
					<h3 class="content-header-title mb-0 mt-1 pl-1">부메랑 관리</h3>
					<div class="row breadcrumbs-top mb-1 pl-1">
						<div class="breadcrumb-wrapper col-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Home</a>
								</li>
								<li class="breadcrumb-item"><a href="#">부메랑 관리</a>
								</li>
							</ol>
						</div>
					</div>
                    <section class="row all-contacts">
                        <div class="col-12">
                            <div class="card contentsArea">
                                <div class="card-head">
                                    <div class="card-header">
                                        <h4 class="card-title">All Contacts</h4>
                                        <div class="heading-elements mt-0">
                                            <button class="btn btn-primary btn-md" data-toggle="modal" data-target="#AddContactModal"><i class="d-md-none d-block feather icon-plus white"></i>
                                                <span class="d-md-block d-none">상품등록</span></button>
                                            <div class="modal fade" id="AddContactModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel1" aria-hidden="true">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <section class="contact-form">
                                                            <form id="form-add-contact" class="contact-input">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel1">상품등록</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">
																	<div class="preview" style="width:50%;min-height:200px;border:1px solid black;margin:10px auto;" id="fileupload1Image">
																	</div>
																	<fieldset class="form-group col-12">
                                                                        <input type="file" class="form-control-file insert-item fileupload" id="fileupload1">
                                                                    </fieldset>
																	<div class="preview" style="width:50%;min-height:200px;border:1px solid black;margin:10px auto;" id="fileupload2Image">
																	</div>
																	<fieldset class="form-group col-12">
                                                                        <input type="file" class="form-control-file fileupload" id="fileupload2">
                                                                    </fieldset>
																	<div class="preview" style="width:50%;min-height:200px;border:1px solid black;margin:10px auto;" id="fileupload3Image">
																	</div>
																	<fieldset class="form-group col-12">
                                                                        <input type="file" class="form-control-file fileupload" id="fileupload3">
                                                                    </fieldset>
																	<fieldset class="form-group col-12">
                                                                        <input type="text" id="orderNo" class="contact-aa form-control insert-item" name="orderNo" placeholder="판매번호" readonly="readonly">
                                                                    </fieldset>
                                                                    <fieldset class="form-group col-12">
                                                                        <input type="text" id="shopName" class="contact-aa form-control insert-item" name="shopName" placeholder="쇼핑몰 이름">
                                                                    </fieldset>
                                                                    <fieldset class="form-group col-12">
                                                                        <input type="text" id="shopUrl" class="contact-bb form-control insert-item" name="shopUrl" placeholder="최초 판매 쇼핑몰 URL">
                                                                    </fieldset>
                                                                    <fieldset class="form-group col-12">
                                                                        <input type="text" id="itemCategory" class="contact-cc form-control w-48 list-inline-item insert-item" name="itemCategory" placeholder="상품 카테고리">
																		<input type="text" id="itemName" class="contact-cc form-control w-48 list-inline-item insert-item" name="itemName" placeholder="물품명">
                                                                    </fieldset>
																	<fieldset class="form-group col-12">
																		<input type="text" id="itemReason" class="contact-cc form-control insert-item" name="itemReason" placeholder="반품사유">
                                                                    </fieldset>
																	<fieldset class="form-group col-12">
																		<input type="text" id="itemPrice" class="contact-cc form-control insert-item" name="itemPrice" placeholder="판매가격">
                                                                    </fieldset>
																	<fieldset class="form-group col-12">
																		<input type="text" id="waybillNumber" class="contact-cc form-control insert-item" name="waybillNumber" placeholder="최초 운송장 번호">
                                                                    </fieldset>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <fieldset class="form-group position-relative has-icon-left mb-0">
                                                                        <button type="button" id="add-item" class="btn btn-info add-contact-item" data-dismiss="modal"><i class="fa fa-paper-plane-o d-block d-lg-none"></i> <span class="d-none d-lg-block">등록</span></button>
                                                                    </fieldset>
                                                                </div>
                                                            </form>
                                                        </section>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal fade" id="EditContactModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <section class="contact-form">
                                                            <form id="form-edit-contact" class="contact-input">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel">Edit Contact</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <fieldset class="form-group col-12">
                                                                        <input type="text" id="name" class="name form-control" placeholder="Name">
                                                                    </fieldset>
                                                                    <fieldset class="form-group col-12">
                                                                        <input type="text" id="email" class="email form-control" placeholder="Email">
                                                                    </fieldset>
                                                                    <fieldset class="form-group col-12">
                                                                        <input type="text" id="phone" class="phone form-control" placeholder="Phone Number">
                                                                    </fieldset>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <fieldset class="form-group position-relative has-icon-left mb-0">
                                                                        <button type="button" id="edit-contact-item" class="btn btn-info edit-contact-item" data-dismiss="modal"><i class="fa fa-paper-plane-o d-lg-none"></i> <span class="d-none d-lg-block">Edit</span></button>
                                                                    </fieldset>
                                                                </div>
                                                            </form>
                                                        </section>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <!-- Task List table -->
                                        <button type="button" class="btn btn-danger btn-sm delete-all mb-1">삭제</button>
                                        <div class="table-responsive">
                                            <table id="data-list" class="table table-white-space table-bordered row-grouping display no-wrap icheck table-middle text-center">
                                                <thead>
                                                    <tr>
                                                        <th>상품사진</th>
                                                        <th>요청날짜</th>
                                                        <th>판매번호</th>
                                                        <th>상품 카테고리</th>
                                                        <th>상품명</th>
														<th>수량</th>
														<th>반품사유</th>
														<th>판매가격</th>
														<th>최초 운송장번호</th>
														<th>상품등급</th>
														<th>상태</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <div>
                                                                <div><span class="avatar avatar-sm avatar-online"><img src="${pageContext.request.contextPath}/resources/app-assets/images/backgrounds/bg-2.jpg" alt="avatar"></span></div>
                                                            </div>
                                                        </td>
                                                        <td class="text-center aa">
                                                            2022-04-15
                                                        </td>
                                                        <td class="double-line bb">123456789<br>네이버</td>
                                                        <td class="text-center cc">
                                                            의류
                                                        </td>
                                                        <td class="text-center dd">
                                                            나이키 신발
                                                        </td>
														<td class="text-center">
                                                            1개
                                                        </td>
														<td class="text-center">
                                                            주문 실수
                                                        </td>
														<td class="text-center double-line">
                                                            -<br>100,000원
                                                        </td>
														<td class="text-center">
                                                            3829491758
                                                        </td>
														<td class="text-center">
                                                            검수전
                                                        </td>
														<td class="text-center">
                                                            픽업요청
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
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