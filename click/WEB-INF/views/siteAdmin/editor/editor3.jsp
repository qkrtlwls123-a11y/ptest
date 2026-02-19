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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/katex.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/monokai-sublime.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/quill.snow.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/quill.bubble.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/ui/plyr.min.css">
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/editor2.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/jquery.minicolors.css">
    <!-- END: Custom CSS-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  
  <style>
  	

  </style>

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu content-left-sidebar todo-application  fixed-navbar" data-open="click" data-menu="vertical-menu-modern" data-col="content-left-sidebar">
	<div id="areaBoxList" style="width:100%;margin:0 auto;">
		<div class="areaTotalBox" id="1">
									<div class="areaBox" id="areaBox-1" data-line="1">
										<div class="areaContents"><div class="areaLine areaLine1" style="width:100%;"><div id="1_areaBox-1_1_0" class="areaItem dataline1" style="display: flex; width: 33.3333%; min-height: 100px; min-width: 50px; justify-content: center;" data="line"><div class="eline" style="width: 100%; height: 100px; background-color: rgb(62, 67, 135); margin: 0px; display: flex;"></div></div><div id="1_areaBox-1_1_1" class="areaItem dataline1" style="display: flex; width: 33.3333%; min-height: 100px; min-width: 50px; justify-content: center;" data="image"><img class="eImage" style="width: 50px; height: 50px; margin: 0px;" src="/click/file/down/131"></div><div id="1_areaBox-1_1_2" class="areaItem dataline1" style="display: flex; width: 33.3333%; min-height: 100px; min-width: 50px; justify-content: center;" data="line"><div class="eline" style="width: 100%; height: 500px; background-color: rgb(51, 63, 125); margin: 0px; display: flex;"></div></div></div></div>
										
										
										
									</div>
									
								</div>
							<div class="areaTotalBox" id="2" style="background-color: rgb(51, 28, 28);"><div class="areaBox areaBorder" id="areaBox-1" data-line="1"><div class="areaContents"><div class="areaLine areaLine1" style="width:100%;"><div id="2_areaBox-1_1_0" class="areaItem dataline1" style="display: flex; width: 100%; min-height: 100px; min-width: 50px; justify-content: center;" data="image"><img class="eImage" style="width: 500px; height: 200px; margin: 0px;" src="/click/file/down/130"></div></div></div></div></div><div class="areaTotalBox" id="3"><div class="areaBox" id="areaBox-1" data-line="1"><div class="areaContents"><div class="areaLine areaLine1" style="width:100%;"><div id="3_areaBox-1_1_0" class="areaItem dataline1" style="display:inline-block;width:50%;min-height:100px;min-width:50px;" data="text"><div class="eEditor ql-editor" data-gramm="false"><p>fffffffffffffffff</p></div></div><div id="3_areaBox-1_1_1" class="areaItem dataline1" style="display: flex; width: 50%; min-height: 100px; min-width: 50px; justify-content: center;" data="line"><div class="eline" style="width: 50%; height: 200px; background-color: rgb(199, 16, 16); margin: 10px 0px 0px; display: flex;"></div></div></div></div></div></div>
</div>
</body>
<!-- END: Body-->

</html>