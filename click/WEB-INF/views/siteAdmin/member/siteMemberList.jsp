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
    <title>ONION BOX</title>
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
    
    function fn_memberDetail(idx){
    	$("#member_email").val(idx);
		document.parameterVO.action = "${pageContext.request.contextPath}/site/${siteVO.site_name}/siteMemberDetail.do";
		document.parameterVO.submit();
    }
    
    function fn_memberRegi(idx){
    	$("#member_email").val(idx);
		document.parameterVO.action = "${pageContext.request.contextPath}/site/${siteVO.site_name}/siteMemberRegi.do";
		document.parameterVO.submit();
    }
    
    function fn_sendMail(idx){
    	$("#member_email").val(idx);
    	var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/sendMemberMail.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					alert("발송 되었습니다.");
				} else {
					alert("존재하지 않는 이메일 입니다.");
				}
			}
		});
    }
    
    function fn_changeMemberType(){
    	var checkValue = $("#member_type").val();
    	$("#use_yn").val(checkValue);
    	document.parameterVO.action = "${pageContext.request.contextPath}/site/${siteVO.site_name}/siteMemberList.do";
		document.parameterVO.submit();
    }
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
                <div class="app-content-overlay"></div>
					<h3 class="content-header-title mb-0 mt-1 pl-1">사용자 목록</h3>
					<div class="row breadcrumbs-top mb-1 pl-1">
						<div class="breadcrumb-wrapper col-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/siteInfo.do">HOME</a>
								</li>
								<li class="breadcrumb-item active">사용자 목록
								</li>
							</ol>
						</div>
					</div>
                <section class="users-list-wrapper">
                    <div class="users-list-filter px-1">
                        <form>
                            <div class="row border border-light rounded py-2 mb-2" style="background-color:white;">
                                <div class="col-12 col-sm-6 col-lg-3">
                                    <label for="users-list-status">상태</label>
                                    <fieldset class="form-group">
                                        <select class="form-control" id="member_type" onchange="javascript:fn_changeMemberType();return false;">
                                        	<option value="" <c:if test="${parameterVO.use_yn == ''}">selected="selected"</c:if> >전체</option>
                                            <option value="Y" <c:if test="${parameterVO.use_yn == 'Y'}">selected="selected"</c:if> >활동 중</option>
                                            <option value="N" <c:if test="${parameterVO.use_yn == 'N'}">selected="selected"</c:if> >미 활동</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-12 col-sm-6 col-lg-3">
                                </div>
                                <div class="col-12 col-sm-6 col-lg-3">
                                </div>
                                <div class="col-12 col-sm-6 col-lg-3 d-flex align-items-center" style="justify-content:right;">
                                    <button class="btn btn-primary btn-md" ><i class="d-md-none d-block feather icon-plus white"></i>
                                                <span class="d-md-block d-none" onclick="javascript:fn_memberRegi();return false;">사용자 등록</span></button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="users-list-table">
                        <div class="card">
                        	<form:form id="parameterVO" name="parameterVO">
                        		<input type="hidden" name="member_email" id="member_email" value=""/>
                        		<input type="hidden" name="use_yn" id="use_yn" value=""/>
                        	</form:form>
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
                                                    <th>진도율</th>
                                                    <th>마지막 활동일</th>
                                                    <th>상태</th>
                                                    <th>edit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<c:forEach var="resultList" items="${resultList}" varStatus="status">
                                            		<fmt:parseDate var="regi_date" value="${resultList.regi_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                            		<tr>
	                                                	<td>${status.count}</td>
	                                                    <td><a href="#" onclick="javascript:fn_memberDetail('${resultList.member_email}');return false;">${resultList.member_email}</a></td>
	                                                    <td>${resultList.member_name}
	                                                    </td>
	                                                    <td>
	                                                    	<div class="progress" style="margin-bottom:0rem;">
					                                            <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="100" aria-valuemin="100" aria-valuemax="100" style="width:${resultList.member_progress}%">${resultList.member_progress}%</div>
					                                        </div> 
	                                        			</td>
	                                                    <td><fmt:formatDate value="${regi_date}" pattern="yyyy-MM-dd" /></td>
	                                                    <td>
	                                                    	<c:if test="${resultList.use_yn == 'Y'}">
	                                                    		<span class="badge badge-success">활동 중</span></td>
	                                                    	</c:if>
	                                                    	<c:if test="${resultList.use_yn != 'Y'}">
	                                                    		<span class="badge badge-danger">미 활동</span></td>
	                                                    	</c:if>
	                                                    <td>
	                                                    	<a href="#" onclick="javascript:fn_memberDetail('${resultList.member_email}');return false;"><i class="feather icon-edit-1"></i></a>&nbsp;
	                                                    	<a href="#" onclick="javascript:fn_sendMail('${resultList.member_email}');return false;"><i class="feather icon-mail"></i></a>
	                                                    </td>
	                                                </tr>
                                            	</c:forEach>
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