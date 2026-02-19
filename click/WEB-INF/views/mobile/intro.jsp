<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/extensions/swiper.min.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/intro.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/components.css">
    <!-- END: Theme CSS-->

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/plugins/extensions/ex-component-swiper.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">
    <!-- END: Custom CSS-->
    <style>
    	.swiper-slide {
    		width:350px!important;
    	}
    	.swiper-container{
    		width:350px!important;
    		left:45%!important;
    	}
    </style>
    <script type="text/javascript">
    	function fn_goMain(){
    		location.href="${pageContext.request.contextPath}/mobile/login.do";
    	}
    </script>

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu 2-columns" data-open="click" data-menu="vertical-menu-modern" data-col="2-columns" style="background-color:white;">

    <!-- BEGIN: Header-->
    
    <!-- END: Header-->


    <!-- BEGIN: Main Menu-->
    
    <!-- END: Main Menu-->

    <!-- BEGIN: Content-->
    <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="content-wrapper" style="padding:0px!important;">
            <div class="content-body">
                <!-- default swiper start -->
                <section id="component-swiper-default">
                    <div class="card" style="box-shadow:0 0 0 0!important;margin-top:25vh;">
                        <div class="card-content">
                            <div class="card-body" style="padding:0px!important;">
                                <div class="swiper-cube-effect swiper-container">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" style="width:300px!important;"> <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/click/click1.png" alt="banner">
                                        </div>
                                        <div class="swiper-slide"> <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/click/click2.png" alt="banner">
                                        </div>
                                        <div class="swiper-slide"> <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/click/click3.png" alt="banner">
                                        </div>
                                        <div class="swiper-slide"> <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/click/click4.png" alt="banner">
                                        </div>
                                    </div>
                                    <div class="swiper-pagination"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- default swiper ends -->
                <!-- virtual slides swiper ends -->
                <div>
                	<div class="introBtn" onclick="javascript:fn_goMain();return false;">건너뛰기</div>
                </div>
            </div>
        </div>
    </div>
    <!-- END: Content-->

    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>
    <!-- BEGIN: Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/extensions/swiper.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/extensions/ex-component-swiper.js"></script>
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>