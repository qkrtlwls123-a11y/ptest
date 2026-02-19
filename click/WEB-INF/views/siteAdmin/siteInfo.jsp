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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/ui/prism.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/file-uploaders/dropzone.min.css">
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/jquery.minicolors.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/plugins/file-uploaders/dropzone.css">
    <!-- END: Custom CSS-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){
		$("#site").addClass("active");
	});

	function fn_updateSite() {
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/site/${siteVO.site_name}/updateSiteInfo.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					alert("수정되었습니다.");
					location.href = "${pageContext.request.contextPath}/site/${siteVO.site_name}/siteInfo.do";
				} else {
					
				}
			}
		});
	}
	
	function fn_resetColor(){
		$("#site_color").val("rgba(64, 78, 103, 1)");
		$("#site_color2").val("rgba(241, 245, 249, 1)");
		$("#site_color3").val("rgba(241, 245, 249, 0.3)");
		$("#site_color4").val("rgba(56, 68, 90, 1)");
	}
	</script>

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu 2-columns   fixed-navbar" data-open="click" data-menu="vertical-menu-modern" data-col="2-columns">

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
                <!-- users edit start -->
                <section class="users-edit">
                    <div class="card">
                        <div class="card-content">
                            <div class="card-body">
                                <ul class="nav nav-tabs mb-2" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link d-flex align-items-center active" id="account-tab" data-toggle="tab" href="#account" aria-controls="account" role="tab" aria-selected="true">
                                            <i class="feather icon-airplay mr-25"></i><span class="d-none d-sm-block fw-1000 fs-1">사이트 등록</span>
                                        </a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="account" aria-labelledby="account-tab" role="tabpanel">
                                    	<form:form id="parameterVO" name="parameterVO">
                                    	<input type="hidden" id="company_id" name="company_id" value="${resultVO.company_id}"/>
                                    	<input type="hidden" id="site_logo" name="site_logo" value="${resultVO.site_logo}"/>
                                    	<input type="hidden" id="site_back" name="site_back" value="${resultVO.site_back}"/>
                                        <!-- users edit media object start -->
                                        <div class="media mb-1">
                                            <div class="media-body">
                                                <h5 class="media-heading fw-1000">- 고객사 정보</h5>
                                            </div>
                                        </div>
                                        <!-- users edit media object ends -->
                                        <!-- users edit account form start -->
                                        <div class="row mb-2">
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <div class="controls">
                                                        <label>고객사 명</label>
                                                        <input type="text" class="form-control" readonly placeholder="고객사명 " name="company_name" value="${resultVO.company_name}" required data-validation-required-message="고객사 명은 필수 입력 항목입니다.">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>홈페이지</label>
                                                    <input type="text" class="form-control" name="homepage_url" placeholder="홈페이지" value="${resultVO.homepage_url}">
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <div class="controls">
                                                        <label>사업자등록번호</label>
                                                        <input type="text" class="form-control" name="business_no" placeholder="사업자등록번호" value="${resultVO.business_no}" required data-validation-required-message="사업자등록번호는 필수 입력 항목입니다.">
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                        <div class="media mb-1">
                                            <div class="media-body">
                                                <h5 class="media-heading fw-1000">- 사이트 정보</h5>
                                            </div>
                                        </div>
                                        <div class="row mb-2">
                                        	<div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <div class="controls">
                                                        <label>사이트 명</label>
                                                        <input type="text" class="form-control" placeholder="사이트 명 " readonly name="site_name" value="${resultVO.site_name}" required data-validation-required-message="사이트 명은 필수 입력 항목입니다.">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="controls position-relative">
                                                        <label>운영기간</label>
                                                        <div class="col-xl-9 col-md-12 d-flex align-items-lg-start align-items-sm-start align-items-xs-start  align-items-center flex-wrap px-0 pt-xl-0 pt-1">
			                                                ${resultVO.start_date} ~ ${resultVO.end_date}
			                                            </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>접속가능 사용자 수</label>
                                                    <input type="text" class="form-control w-25" name="user_count" readonly placeholder="사용자 수" value="${resultVO.user_count}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" id="siteLogoArea">
					                        <div class="col-12 col-sm-2" style="min-width:270px;">
					                        	<div class="card">
				                                    <h5 class="media-heading fw-1000" style="min-height:23px;">- 사이트 색상 <span class="btn btn-primary btn-sm" onclick="javascript:fn_resetColor();return false;">색상 초기화</span></h5>
				                                    <div class="form-group">
		                                                <div class="controls">
		                                                    <label>메인 색상</label>
		                                                    <br/><input type="text" id="site_color" name="site_color" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="${resultVO.site_color}"/>
		                                                </div>
		                                            </div>
					                            </div>
					                        </div>
					                        <div class="col-12 col-sm-2" style="min-width:270px;">
					                        	<div class="card">
				                                    <div class="form-group">
				                                    	<h5 class="media-heading fw-1000" style="min-height:23px;">&nbsp;</h5>
		                                                <div class="controls">
		                                                    <label>서브 색상 1</label>
		                                                    <br/><input type="text" id="site_color2" name="site_color2" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="${resultVO.site_color2}"/>
		                                                </div>
		                                            </div>
					                            </div>
					                        </div>
					                        <div class="col-12 col-sm-2" style="min-width:270px;">
					                        	<div class="card">
				                                    <div class="form-group">
				                                    	<h5 class="media-heading fw-1000" style="min-height:23px;">&nbsp;</h5>
		                                                <div class="controls">
		                                                    <label>서브 색상 2</label>
		                                                    <br/><input type="text" id="site_color3" name="site_color3" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="${resultVO.site_color3}"/>
		                                                </div>
		                                            </div>
					                            </div>
					                        </div>
					                        <div class="col-12 col-sm-2" style="min-width:270px;">
					                        	<div class="card">
				                                    <div class="form-group">
				                                    	<h5 class="media-heading fw-1000" style="min-height:23px;">&nbsp;</h5>
		                                                <div class="controls">
		                                                    <label>서브 색상 3</label>
		                                                    <br/><input type="text" id="site_color4" name="site_color4" class="form-control dp-inline required demo minicolors-input" data-format="rgb" data-opacity="1" placeholder="색상" style="height:calc(2.75rem + 2px)!important;" value="${resultVO.site_color4}"/>
		                                                </div>
		                                            </div>
					                            </div>
					                        </div>
					                    </div>
                                        </form:form>
                                        
                                        <div class="row" id="siteLogoArea">
					                        <div class="col-12 col-sm-6">
					                            <div class="card">
				                                    <h5 class="media-heading fw-1000">- 사이트 로고</h5>
				                                    <c:if test="${'' != resultVO.site_logo && null != resultVO.site_logo}">
						                                <div class="card-content collapse show" id="siteLogoArea1">
						                                    <img src="http://ptest.co.kr/click/file/down/${resultVO.site_logo}" alt="사이트 로고"/>
						                                </div>
					                                </c:if>
					                                <div class="card-content collapse show hiddenObj" id="siteLogoArea2">
					                                    <div class="card-body">
					                                        <form action="${pageContext.request.contextPath}/file/uploadlogo.json" class="dropzone dropzone-area" id="logoZone"></form>
					                                    </div>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="col-12 col-sm-6">
					                            <div class="card">
				                                    <h5 class="media-heading fw-1000">- 사이트 배경</h5>
					                                <c:if test="${'' != resultVO.site_back && null != resultVO.site_back}">
						                                <div class="card-content collapse show" id="siteBackArea1">
						                                    <img src="http://ptest.co.kr/click/file/down/${resultVO.site_back}" alt="사이트 배경"/>
						                                </div>
					                                </c:if>
					                                <div class="card-content collapse show hiddenObj" id="siteBackArea2">
					                                    <div class="card-body">
					                                        <form action="${pageContext.request.contextPath}/file/uploadback.json" class="dropzone dropzone-area" id="backZone"></form>
					                                    </div>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                                            <button type="button" onclick="javascript:fn_updateSite('${resultVO.company_id}');return false;" class="btn btn-primary glow mb-1 mb-sm-0 mr-0 mr-sm-1">수정</button>
                                        </div>
                                        <!-- users edit account form ends -->
                                    </div>
                                </div>
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
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/pickadate/picker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/pickadate/picker.date.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/extensions/dropzone.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/ui/prism.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/page-users.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/app-invoice.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/navs/navs.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/jquery.minicolors.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/jquery.minicolors.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/colorpicker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/extensions/dropzone.js"></script>
    
    
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>