<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<!--
Author: Keenthemes
Product Name: Metronic - Bootstrap 5 HTML, VueJS, React, Angular & Laravel Admin Dashboard Theme 
Purchase: https://1.envato.market/EA4JP
Website: http://www.keenthemes.com
Contact: support@keenthemes.com
Follow: www.twitter.com/keenthemes
Dribbble: www.dribbble.com/keenthemes
Like: www.facebook.com/keenthemes
License: For each use you must have a valid license purchased only from above link in order to legally use the theme for your project.
-->
<html lang="en">
	<!--begin::Head-->
	<head>
		<title>ONION BOX - 시스템관리자</title>
		<meta name="description" content="The most advanced Bootstrap Admin Theme on Themeforest trusted by 94,000 beginners and professionals. Multi-demo, Dark Mode, RTL support and complete React, Angular, Vue &amp; Laravel versions. Grab your copy now and get life-time updates for free." />
		<meta name="keywords" content="Metronic, bootstrap, bootstrap 5, Angular, VueJs, React, Laravel, admin themes, web design, figma, web development, free templates, free admin themes, bootstrap theme, bootstrap template, bootstrap dashboard, bootstrap dak mode, bootstrap button, bootstrap datepicker, bootstrap timepicker, fullcalendar, datatables, flaticon" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta charset="utf-8" />
		<meta property="og:locale" content="en_US" />
		<meta property="og:type" content="article" />
		<meta property="og:title" content="Metronic - Bootstrap 5 HTML, VueJS, React, Angular &amp; Laravel Admin Dashboard Theme" />
		<meta property="og:url" content="https://keenthemes.com/metronic" />
		<meta property="og:site_name" content="Keenthemes | Metronic" />
		<link rel="canonical" href="Https://preview.keenthemes.com/metronic8" />
		<link rel="shortcut icon" href="/metronic8/demo1/assets/media/logos/favicon.ico" />
		<!--begin::Fonts-->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" />
		<!--end::Fonts-->
		<!--begin::Page Vendor Stylesheets(used by this page)-->
		<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
		<!--end::Page Vendor Stylesheets-->
		<!--begin::Global Stylesheets Bundle(used by all pages)-->
		<link href="${pageContext.request.contextPath}/resources/css/plugins.bundle.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/resources/css/style.bundle.css" rel="stylesheet" type="text/css" />
		<!--end::Global Stylesheets Bundle-->
		<!--Begin::Google Tag Manager -->
		<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start': new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0], j=d.createElement(s),dl=l!='dataLayer'?'&amp;l='+l:'';j.async=true;j.src= 'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f); })(window,document,'script','dataLayer','GTM-5FS8GGP');</script>
		<!--End::Google Tag Manager -->
		<script>
		function fn_loadPage(type){
			if("site" == type){
				location.href = "${pageContext.request.contextPath}/siteList.do";
			}else if("siteRegi" == type){
				location.href = "${pageContext.request.contextPath}/siteRegi.do";
			}else if("admin" == type){
				location.href = "${pageContext.request.contextPath}/adminList.do";
			}else if("stamp" == type){
				location.href = "${pageContext.request.contextPath}/stampList.do";
			}else if("sticker" == type){
				location.href = "${pageContext.request.contextPath}/stickerList.do";
			}
		}
		</script>
	</head>
	<!--end::Head-->
	<!--begin::Body-->
	<body id="kt_body" class="header-fixed header-tablet-and-mobile-fixed toolbar-enabled toolbar-fixed aside-enabled aside-fixed" style="--kt-toolbar-height:55px;--kt-toolbar-height-tablet-and-mobile:55px">
		<!--begin::Main-->
		<!--begin::Root-->
		<div class="d-flex flex-column flex-root">
			<!--begin::Page-->
			<div class="page d-flex flex-row flex-column-fluid">
				<!--begin::Aside-->
				<div id="kt_aside" class="aside aside-dark aside-hoverable" data-kt-drawer="true" data-kt-drawer-name="aside" data-kt-drawer-activate="{default: true, lg: false}" data-kt-drawer-overlay="true" data-kt-drawer-width="{default:'200px', '300px': '250px'}" data-kt-drawer-direction="start" data-kt-drawer-toggle="#kt_aside_mobile_toggle">
					<!--begin::Brand-->
					<div class="aside-logo flex-column-auto" id="kt_aside_logo">
						<!--begin::Logo-->
						<a href="${pageContext.request.contextPath}/main.do">
							<img alt="Logo" src="${pageContext.request.contextPath}/resources/img/click/onionbox_logo.png" class="h-25px logo" />
						</a>
						<!--end::Logo-->
						<!--begin::Aside toggler-->
						<div id="kt_aside_toggle" class="btn btn-icon w-auto px-0 btn-active-color-primary aside-toggle" data-kt-toggle="true" data-kt-toggle-state="active" data-kt-toggle-target="body" data-kt-toggle-name="aside-minimize">
							<!--begin::Svg Icon | path: icons/duotune/arrows/arr079.svg-->
							<span class="svg-icon svg-icon-1 rotate-180">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
									<path opacity="0.5" d="M14.2657 11.4343L18.45 7.25C18.8642 6.83579 18.8642 6.16421 18.45 5.75C18.0358 5.33579 17.3642 5.33579 16.95 5.75L11.4071 11.2929C11.0166 11.6834 11.0166 12.3166 11.4071 12.7071L16.95 18.25C17.3642 18.6642 18.0358 18.6642 18.45 18.25C18.8642 17.8358 18.8642 17.1642 18.45 16.75L14.2657 12.5657C13.9533 12.2533 13.9533 11.7467 14.2657 11.4343Z" fill="black" />
									<path d="M8.2657 11.4343L12.45 7.25C12.8642 6.83579 12.8642 6.16421 12.45 5.75C12.0358 5.33579 11.3642 5.33579 10.95 5.75L5.40712 11.2929C5.01659 11.6834 5.01659 12.3166 5.40712 12.7071L10.95 18.25C11.3642 18.6642 12.0358 18.6642 12.45 18.25C12.8642 17.8358 12.8642 17.1642 12.45 16.75L8.2657 12.5657C7.95328 12.2533 7.95328 11.7467 8.2657 11.4343Z" fill="black" />
								</svg>
							</span>
							<!--end::Svg Icon-->
						</div>
						<!--end::Aside toggler-->
					</div>
					<!--end::Brand-->
					<!--begin::Aside menu-->
					<div class="aside-menu flex-column-fluid">
						<!--begin::Aside Menu-->
						<div class="hover-scroll-overlay-y my-5 my-lg-5" id="kt_aside_menu_wrapper" data-kt-scroll="true" data-kt-scroll-activate="{default: false, lg: true}" data-kt-scroll-height="auto" data-kt-scroll-dependencies="#kt_aside_logo, #kt_aside_footer" data-kt-scroll-wrappers="#kt_aside_menu" data-kt-scroll-offset="0">
							<!--begin::Menu-->
							<div class="menu menu-column menu-title-gray-800 menu-state-title-primary menu-state-icon-primary menu-state-bullet-primary menu-arrow-gray-500" id="#kt_aside_menu" data-kt-menu="true">
								<div class="menu-item">
									<div class="menu-content pt-8 pb-2">
										<span class="menu-section text-muted text-uppercase fs-8 ls-1" style="font-size:15px!important;">대쉬보드</span>
									</div>
								</div>
								<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
									<span class="menu-link" onclick="javascript:location.href='${pageContext.request.contextPath}/main.do';return false;">
										<span class="menu-icon">
											<!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm007.svg-->
											<span class="svg-icon svg-icon-2">
												<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
													<rect x="8" y="9" width="3" height="10" rx="1.5" fill="black"></rect>
													<rect opacity="0.5" x="13" y="5" width="3" height="14" rx="1.5" fill="black"></rect>
													<rect x="18" y="11" width="3" height="8" rx="1.5" fill="black"></rect>
													<rect x="3" y="13" width="3" height="6" rx="1.5" fill="black"></rect>
												</svg>
											</span>
											<!--end::Svg Icon-->
										</span>
										<span class="menu-title">대쉬보드</span>
									</span>
								</div>
								<div class="menu-item">
									<div class="menu-content pt-8 pb-2">
										<span class="menu-section text-muted text-uppercase fs-8 ls-1" style="font-size:15px!important;">시스템</span>
									</div>
								</div>
								<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
									<span class="menu-link" onclick="javascript:fn_loadPage('site');return false;">
										<span class="menu-icon">
											<!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm007.svg-->
											<span class="svg-icon svg-icon-2">
												<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
													<path opacity="0.3" d="M21 18.3V4H20H5C4.4 4 4 4.4 4 5V20C10.9 20 16.7 15.6 19 9.5V18.3C18.4 18.6 18 19.3 18 20C18 21.1 18.9 22 20 22C21.1 22 22 21.1 22 20C22 19.3 21.6 18.6 21 18.3Z" fill="black" />
													<path d="M22 4C22 2.9 21.1 2 20 2C18.9 2 18 2.9 18 4C18 4.7 18.4 5.29995 18.9 5.69995C18.1 12.6 12.6 18.2 5.70001 18.9C5.30001 18.4 4.7 18 4 18C2.9 18 2 18.9 2 20C2 21.1 2.9 22 4 22C4.8 22 5.39999 21.6 5.79999 20.9C13.8 20.1 20.1 13.7 20.9 5.80005C21.6 5.40005 22 4.8 22 4Z" fill="black" />
												</svg>
											</span>
											<!--end::Svg Icon-->
										</span>
										<span class="menu-title">사이트 개설 / 관리</span>
									</span>
								</div>
								<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
									<span class="menu-link" onclick="javascript:fn_loadPage('admin');return false;">
										<span class="menu-icon">
											<!--begin::Svg Icon | path: icons/duotune/communication/com013.svg-->
											<span class="svg-icon svg-icon-2">
												<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
													<path d="M6.28548 15.0861C7.34369 13.1814 9.35142 12 11.5304 12H12.4696C14.6486 12 16.6563 13.1814 17.7145 15.0861L19.3493 18.0287C20.0899 19.3618 19.1259 21 17.601 21H6.39903C4.87406 21 3.91012 19.3618 4.65071 18.0287L6.28548 15.0861Z" fill="black" />
													<rect opacity="0.3" x="8" y="3" width="8" height="8" rx="4" fill="black" />
												</svg>
											</span>
											<!--end::Svg Icon-->
										</span>
										<span class="menu-title">관리자 설정</span>
									</span>
								</div>
								<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
									<span class="menu-link">
										<span class="menu-icon">
											<!--begin::Svg Icon | path: icons/duotune/technology/teh004.svg-->
											<span class="svg-icon svg-icon-2">
												<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
													<path d="M21 9V11C21 11.6 20.6 12 20 12H14V8H20C20.6 8 21 8.4 21 9ZM10 8H4C3.4 8 3 8.4 3 9V11C3 11.6 3.4 12 4 12H10V8Z" fill="black" />
													<path d="M15 2C13.3 2 12 3.3 12 5V8H15C16.7 8 18 6.7 18 5C18 3.3 16.7 2 15 2Z" fill="black" />
													<path opacity="0.3" d="M9 2C10.7 2 12 3.3 12 5V8H9C7.3 8 6 6.7 6 5C6 3.3 7.3 2 9 2ZM4 12V21C4 21.6 4.4 22 5 22H10V12H4ZM20 12V21C20 21.6 19.6 22 19 22H14V12H20Z" fill="black" />
												</svg>
											</span>
											<!--end::Svg Icon-->
										</span>
										<span class="menu-title">콘텐츠 관리</span>
										<span class="menu-arrow"></span>
									</span>
									<div class="menu-sub menu-sub-accordion menu-active-bg">
										<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
											<span class="menu-link">
												<span class="menu-bullet">
													<span class="bullet bullet-dot"></span>
												</span>
												<span class="menu-title">관리자용 콘텐츠</span>
											</span>
										</div>
										<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
											<span class="menu-link">
												<span class="menu-bullet">
													<span class="bullet bullet-dot"></span>
												</span>
												<span class="menu-title">고객사용 콘텐츠</span>
											</span>
										</div>
										<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
											<span class="menu-link">
												<span class="menu-bullet">
													<span class="bullet bullet-dot"></span>
												</span>
												<span class="menu-title">분류 관리</span>
											</span>
										</div>
										<div class="menu-item">
											<a class="menu-link" href="/metronic8/demo1/../demo1/authentication/extended/multi-steps-sign-up.html">
												<span class="menu-bullet">
													<span class="bullet bullet-dot"></span>
												</span>
												<span class="menu-title">퀴즈 관리</span>
											</a>
										</div>
									</div>
								</div>
								<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
									<span class="menu-link">
										<span class="menu-icon">
											<!--begin::Svg Icon | path: icons/duotune/general/gen022.svg-->
											<span class="svg-icon svg-icon-2">
												<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
													<path d="M11.2929 2.70711C11.6834 2.31658 12.3166 2.31658 12.7071 2.70711L15.2929 5.29289C15.6834 5.68342 15.6834 6.31658 15.2929 6.70711L12.7071 9.29289C12.3166 9.68342 11.6834 9.68342 11.2929 9.29289L8.70711 6.70711C8.31658 6.31658 8.31658 5.68342 8.70711 5.29289L11.2929 2.70711Z" fill="black" />
													<path d="M11.2929 14.7071C11.6834 14.3166 12.3166 14.3166 12.7071 14.7071L15.2929 17.2929C15.6834 17.6834 15.6834 18.3166 15.2929 18.7071L12.7071 21.2929C12.3166 21.6834 11.6834 21.6834 11.2929 21.2929L8.70711 18.7071C8.31658 18.3166 8.31658 17.6834 8.70711 17.2929L11.2929 14.7071Z" fill="black" />
													<path opacity="0.3" d="M5.29289 8.70711C5.68342 8.31658 6.31658 8.31658 6.70711 8.70711L9.29289 11.2929C9.68342 11.6834 9.68342 12.3166 9.29289 12.7071L6.70711 15.2929C6.31658 15.6834 5.68342 15.6834 5.29289 15.2929L2.70711 12.7071C2.31658 12.3166 2.31658 11.6834 2.70711 11.2929L5.29289 8.70711Z" fill="black" />
													<path opacity="0.3" d="M17.2929 8.70711C17.6834 8.31658 18.3166 8.31658 18.7071 8.70711L21.2929 11.2929C21.6834 11.6834 21.6834 12.3166 21.2929 12.7071L18.7071 15.2929C18.3166 15.6834 17.6834 15.6834 17.2929 15.2929L14.7071 12.7071C14.3166 12.3166 14.3166 11.6834 14.7071 11.2929L17.2929 8.70711Z" fill="black" />
												</svg>
											</span>
											<!--end::Svg Icon-->
										</span>
										<span class="menu-title">스탬프/스티커 관리</span>
										<span class="menu-arrow"></span>
									</span>
									<div class="menu-sub menu-sub-accordion menu-active-bg">
										<div class="menu-item">
											<a class="menu-link" onclick="javascript:fn_loadPage('stamp');return false;">
												<span class="menu-bullet">
													<span class="bullet bullet-dot"></span>
												</span>
												<span class="menu-title">스탬프 관리</span>
											</a>
										</div>
										<div class="menu-item">
											<a class="menu-link" onclick="javascript:fn_loadPage('sticker');return false;">
												<span class="menu-bullet">
													<span class="bullet bullet-dot"></span>
												</span>
												<span class="menu-title">스티커 관리</span>
											</a>
										</div>
									</div>
									<div class="menu-item">
									<div class="menu-content pt-8 pb-2">
										<span class="menu-section text-muted text-uppercase fs-8 ls-1" style="font-size:15px!important;">진단관리</span>
									</div>
								</div>
								<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
									<span class="menu-link" onclick="javascript:fn_loadPage('site');return false;">
										<span class="menu-icon">
											<!--begin::Svg Icon | path: icons/duotune/ecommerce/ecm007.svg-->
											<span class="svg-icon svg-icon-2">
												<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
													<path opacity="0.3" d="M21 18.3V4H20H5C4.4 4 4 4.4 4 5V20C10.9 20 16.7 15.6 19 9.5V18.3C18.4 18.6 18 19.3 18 20C18 21.1 18.9 22 20 22C21.1 22 22 21.1 22 20C22 19.3 21.6 18.6 21 18.3Z" fill="black" />
													<path d="M22 4C22 2.9 21.1 2 20 2C18.9 2 18 2.9 18 4C18 4.7 18.4 5.29995 18.9 5.69995C18.1 12.6 12.6 18.2 5.70001 18.9C5.30001 18.4 4.7 18 4 18C2.9 18 2 18.9 2 20C2 21.1 2.9 22 4 22C4.8 22 5.39999 21.6 5.79999 20.9C13.8 20.1 20.1 13.7 20.9 5.80005C21.6 5.40005 22 4.8 22 4Z" fill="black" />
												</svg>
											</span>
											<!--end::Svg Icon-->
										</span>
										<span class="menu-title">진단/설문 관리</span>
									</span>
								</div>
								</div>
							</div>
							<!--end::Menu-->
						</div>
						<!--end::Aside Menu-->
					</div>
					<!--end::Aside menu-->
					<!--begin::Footer-->
					<div class="aside-footer flex-column-auto pt-5 pb-7 px-5" id="kt_aside_footer">
						
					</div>
					<!--end::Footer-->
				</div>
				<!--end::Aside-->
				<!--begin::Wrapper-->
				<div class="wrapper d-flex flex-column flex-row-fluid" id="kt_wrapper">
					<!--begin::Header-->
					<div id="kt_header" style="" class="header align-items-stretch">
						<!--begin::Container-->
						<div class="container-fluid d-flex align-items-stretch justify-content-between">
							<!--begin::Aside mobile toggle-->
							<div class="d-flex align-items-center d-lg-none ms-n3 me-1" title="Show aside menu">
								<div class="btn btn-icon btn-active-light-primary w-30px h-30px w-md-40px h-md-40px" id="kt_aside_mobile_toggle">
									<!--begin::Svg Icon | path: icons/duotune/abstract/abs015.svg-->
									<span class="svg-icon svg-icon-2x mt-1">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
											<path d="M21 7H3C2.4 7 2 6.6 2 6V4C2 3.4 2.4 3 3 3H21C21.6 3 22 3.4 22 4V6C22 6.6 21.6 7 21 7Z" fill="black" />
											<path opacity="0.3" d="M21 14H3C2.4 14 2 13.6 2 13V11C2 10.4 2.4 10 3 10H21C21.6 10 22 10.4 22 11V13C22 13.6 21.6 14 21 14ZM22 20V18C22 17.4 21.6 17 21 17H3C2.4 17 2 17.4 2 18V20C2 20.6 2.4 21 3 21H21C21.6 21 22 20.6 22 20Z" fill="black" />
										</svg>
									</span>
									<!--end::Svg Icon-->
								</div>
							</div>
							<!--end::Aside mobile toggle-->
							<!--begin::Mobile logo-->
							<div class="d-flex align-items-center flex-grow-1 flex-lg-grow-0">
								<a href="/metronic8/demo1/../demo1/index.html" class="d-lg-none">
									<img alt="Logo" src="${pageContext.request.contextPath}/resources/img/click/onionbox_logo.png" class="h-30px" />
								</a>
							</div>
							<!--end::Mobile logo-->
							<!--begin::Wrapper-->
							<div class="d-flex align-items-stretch justify-content-between flex-lg-grow-1">
								<!--begin::Navbar-->
								<div class="d-flex align-items-stretch" id="kt_header_nav">
									<!--begin::Menu wrapper-->
									<div class="header-menu align-items-stretch" data-kt-drawer="true" data-kt-drawer-name="header-menu" data-kt-drawer-activate="{default: true, lg: false}" data-kt-drawer-overlay="true" data-kt-drawer-width="{default:'200px', '300px': '250px'}" data-kt-drawer-direction="end" data-kt-drawer-toggle="#kt_header_menu_mobile_toggle" data-kt-swapper="true" data-kt-swapper-mode="prepend" data-kt-swapper-parent="{default: '#kt_body', lg: '#kt_header_nav'}">
										<!--begin::Menu-->
										<!--end::Menu-->
									</div>
									<!--end::Menu wrapper-->
								</div>
								<!--end::Navbar-->
								<!--begin::Topbar-->
								<div class="d-flex align-items-stretch flex-shrink-0">
									<!--begin::Toolbar wrapper-->
									<div class="d-flex align-items-stretch flex-shrink-0">
										<!--begin::Search-->
										<div class="d-flex align-items-stretch ms-1 ms-lg-3">
											<!--begin::Search-->
											<div id="kt_header_search" class="d-flex align-items-stretch" data-kt-search-keypress="true" data-kt-search-min-length="2" data-kt-search-enter="enter" data-kt-search-layout="menu" data-kt-menu-trigger="auto" data-kt-menu-overflow="false" data-kt-menu-permanent="true" data-kt-menu-placement="bottom-end">
												<!--begin::Search toggle-->
												<div class="d-flex align-items-center" data-kt-search-element="toggle" id="kt_header_search_toggle">
													<div class="btn btn-icon btn-active-light-primary w-30px h-30px w-md-40px h-md-40px">
														<!--begin::Svg Icon | path: icons/duotune/general/gen021.svg-->
														<span class="svg-icon svg-icon-1">
															<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																<rect opacity="0.5" x="17.0365" y="15.1223" width="8.15546" height="2" rx="1" transform="rotate(45 17.0365 15.1223)" fill="black" />
																<path d="M11 19C6.55556 19 3 15.4444 3 11C3 6.55556 6.55556 3 11 3C15.4444 3 19 6.55556 19 11C19 15.4444 15.4444 19 11 19ZM11 5C7.53333 5 5 7.53333 5 11C5 14.4667 7.53333 17 11 17C14.4667 17 17 14.4667 17 11C17 7.53333 14.4667 5 11 5Z" fill="black" />
															</svg>
														</span>
														<!--end::Svg Icon-->
													</div>
												</div>
												<!--end::Search toggle-->
												<!--begin::Menu-->
												<div data-kt-search-element="content" class="menu menu-sub menu-sub-dropdown p-7 w-325px w-md-375px">
													<!--begin::Wrapper-->
													<div data-kt-search-element="wrapper">
														<!--begin::Form-->
														<form data-kt-search-element="form" class="w-100 position-relative mb-3" autocomplete="off">
															<!--begin::Icon-->
															<!--begin::Svg Icon | path: icons/duotune/general/gen021.svg-->
															<span class="svg-icon svg-icon-2 svg-icon-lg-1 svg-icon-gray-500 position-absolute top-50 translate-middle-y ms-0">
																<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																	<rect opacity="0.5" x="17.0365" y="15.1223" width="8.15546" height="2" rx="1" transform="rotate(45 17.0365 15.1223)" fill="black" />
																	<path d="M11 19C6.55556 19 3 15.4444 3 11C3 6.55556 6.55556 3 11 3C15.4444 3 19 6.55556 19 11C19 15.4444 15.4444 19 11 19ZM11 5C7.53333 5 5 7.53333 5 11C5 14.4667 7.53333 17 11 17C14.4667 17 17 14.4667 17 11C17 7.53333 14.4667 5 11 5Z" fill="black" />
																</svg>
															</span>
															<!--end::Svg Icon-->
															<!--end::Icon-->
															<!--begin::Input-->
															<input type="text" class="form-control form-control-flush ps-10" name="search" value="" placeholder="Search..." data-kt-search-element="input" />
															<!--end::Input-->
															<!--begin::Spinner-->
															<span class="position-absolute top-50 end-0 translate-middle-y lh-0 d-none me-1" data-kt-search-element="spinner">
																<span class="spinner-border h-15px w-15px align-middle text-gray-400"></span>
															</span>
															<!--end::Spinner-->
															<!--begin::Reset-->
															<span class="btn btn-flush btn-active-color-primary position-absolute top-50 end-0 translate-middle-y lh-0 d-none" data-kt-search-element="clear">
																<!--begin::Svg Icon | path: icons/duotune/arrows/arr061.svg-->
																<span class="svg-icon svg-icon-2 svg-icon-lg-1 me-0">
																	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																		<rect opacity="0.5" x="6" y="17.3137" width="16" height="2" rx="1" transform="rotate(-45 6 17.3137)" fill="black" />
																		<rect x="7.41422" y="6" width="16" height="2" rx="1" transform="rotate(45 7.41422 6)" fill="black" />
																	</svg>
																</span>
																<!--end::Svg Icon-->
															</span>
															<!--end::Reset-->
															<!--begin::Toolbar-->
															<div class="position-absolute top-50 end-0 translate-middle-y" data-kt-search-element="toolbar">
																<!--begin::Preferences toggle-->
																<div data-kt-search-element="preferences-show" class="btn btn-icon w-20px btn-sm btn-active-color-primary me-1" data-bs-toggle="tooltip" title="Show search preferences">
																	<!--begin::Svg Icon | path: icons/duotune/coding/cod001.svg-->
																	<span class="svg-icon svg-icon-1">
																		<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																			<path opacity="0.3" d="M22.1 11.5V12.6C22.1 13.2 21.7 13.6 21.2 13.7L19.9 13.9C19.7 14.7 19.4 15.5 18.9 16.2L19.7 17.2999C20 17.6999 20 18.3999 19.6 18.7999L18.8 19.6C18.4 20 17.8 20 17.3 19.7L16.2 18.9C15.5 19.3 14.7 19.7 13.9 19.9L13.7 21.2C13.6 21.7 13.1 22.1 12.6 22.1H11.5C10.9 22.1 10.5 21.7 10.4 21.2L10.2 19.9C9.4 19.7 8.6 19.4 7.9 18.9L6.8 19.7C6.4 20 5.7 20 5.3 19.6L4.5 18.7999C4.1 18.3999 4.1 17.7999 4.4 17.2999L5.2 16.2C4.8 15.5 4.4 14.7 4.2 13.9L2.9 13.7C2.4 13.6 2 13.1 2 12.6V11.5C2 10.9 2.4 10.5 2.9 10.4L4.2 10.2C4.4 9.39995 4.7 8.60002 5.2 7.90002L4.4 6.79993C4.1 6.39993 4.1 5.69993 4.5 5.29993L5.3 4.5C5.7 4.1 6.3 4.10002 6.8 4.40002L7.9 5.19995C8.6 4.79995 9.4 4.39995 10.2 4.19995L10.4 2.90002C10.5 2.40002 11 2 11.5 2H12.6C13.2 2 13.6 2.40002 13.7 2.90002L13.9 4.19995C14.7 4.39995 15.5 4.69995 16.2 5.19995L17.3 4.40002C17.7 4.10002 18.4 4.1 18.8 4.5L19.6 5.29993C20 5.69993 20 6.29993 19.7 6.79993L18.9 7.90002C19.3 8.60002 19.7 9.39995 19.9 10.2L21.2 10.4C21.7 10.5 22.1 11 22.1 11.5ZM12.1 8.59998C10.2 8.59998 8.6 10.2 8.6 12.1C8.6 14 10.2 15.6 12.1 15.6C14 15.6 15.6 14 15.6 12.1C15.6 10.2 14 8.59998 12.1 8.59998Z" fill="black" />
																			<path d="M17.1 12.1C17.1 14.9 14.9 17.1 12.1 17.1C9.30001 17.1 7.10001 14.9 7.10001 12.1C7.10001 9.29998 9.30001 7.09998 12.1 7.09998C14.9 7.09998 17.1 9.29998 17.1 12.1ZM12.1 10.1C11 10.1 10.1 11 10.1 12.1C10.1 13.2 11 14.1 12.1 14.1C13.2 14.1 14.1 13.2 14.1 12.1C14.1 11 13.2 10.1 12.1 10.1Z" fill="black" />
																		</svg>
																	</span>
																	<!--end::Svg Icon-->
																</div>
																<!--end::Preferences toggle-->
																<!--begin::Advanced search toggle-->
																<div data-kt-search-element="advanced-options-form-show" class="btn btn-icon w-20px btn-sm btn-active-color-primary" data-bs-toggle="tooltip" title="Show more search options">
																	<!--begin::Svg Icon | path: icons/duotune/arrows/arr072.svg-->
																	<span class="svg-icon svg-icon-2">
																		<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																			<path d="M11.4343 12.7344L7.25 8.55005C6.83579 8.13583 6.16421 8.13584 5.75 8.55005C5.33579 8.96426 5.33579 9.63583 5.75 10.05L11.2929 15.5929C11.6834 15.9835 12.3166 15.9835 12.7071 15.5929L18.25 10.05C18.6642 9.63584 18.6642 8.96426 18.25 8.55005C17.8358 8.13584 17.1642 8.13584 16.75 8.55005L12.5657 12.7344C12.2533 13.0468 11.7467 13.0468 11.4343 12.7344Z" fill="black" />
																		</svg>
																	</span>
																	<!--end::Svg Icon-->
																</div>
																<!--end::Advanced search toggle-->
															</div>
															<!--end::Toolbar-->
														</form>
														<!--end::Form-->
														<!--begin::Separator-->
														<div class="separator border-gray-200 mb-6"></div>
														<!--end::Separator-->
														<!--begin::Recently viewed-->
														<div data-kt-search-element="results" class="d-none">
															<!--begin::Items-->
															<div class="scroll-y mh-200px mh-lg-350px">
																<!--begin::Category title-->
																<h3 class="fs-5 text-muted m-0 pb-5" data-kt-search-element="category-title">Users</h3>
																<!--end::Category title-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<img src="/metronic8/demo1/assets/media/avatars/150-1.jpg" alt="" />
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column justify-content-start fw-bold">
																		<span class="fs-6 fw-bold">Karina Clark</span>
																		<span class="fs-7 fw-bold text-muted">Marketing Manager</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<img src="/metronic8/demo1/assets/media/avatars/150-3.jpg" alt="" />
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column justify-content-start fw-bold">
																		<span class="fs-6 fw-bold">Olivia Bold</span>
																		<span class="fs-7 fw-bold text-muted">Software Engineer</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<img src="/metronic8/demo1/assets/media/avatars/150-8.jpg" alt="" />
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column justify-content-start fw-bold">
																		<span class="fs-6 fw-bold">Ana Clark</span>
																		<span class="fs-7 fw-bold text-muted">UI/UX Designer</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<img src="/metronic8/demo1/assets/media/avatars/150-11.jpg" alt="" />
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column justify-content-start fw-bold">
																		<span class="fs-6 fw-bold">Nick Pitola</span>
																		<span class="fs-7 fw-bold text-muted">Art Director</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<img src="/metronic8/demo1/assets/media/avatars/150-12.jpg" alt="" />
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column justify-content-start fw-bold">
																		<span class="fs-6 fw-bold">Edward Kulnic</span>
																		<span class="fs-7 fw-bold text-muted">System Administrator</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Category title-->
																<h3 class="fs-5 text-muted m-0 pt-5 pb-5" data-kt-search-element="category-title">Customers</h3>
																<!--end::Category title-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<img class="w-20px h-20px" src="/metronic8/demo1/assets/media/svg/brand-logos/volicity-9.svg" alt="" />
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column justify-content-start fw-bold">
																		<span class="fs-6 fw-bold">Company Rbranding</span>
																		<span class="fs-7 fw-bold text-muted">UI Design</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<img class="w-20px h-20px" src="/metronic8/demo1/assets/media/svg/brand-logos/tvit.svg" alt="" />
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column justify-content-start fw-bold">
																		<span class="fs-6 fw-bold">Company Re-branding</span>
																		<span class="fs-7 fw-bold text-muted">Web Development</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<img class="w-20px h-20px" src="/metronic8/demo1/assets/media/svg/misc/infography.svg" alt="" />
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column justify-content-start fw-bold">
																		<span class="fs-6 fw-bold">Business Analytics App</span>
																		<span class="fs-7 fw-bold text-muted">Administration</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<img class="w-20px h-20px" src="/metronic8/demo1/assets/media/svg/brand-logos/leaf.svg" alt="" />
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column justify-content-start fw-bold">
																		<span class="fs-6 fw-bold">EcoLeaf App Launch</span>
																		<span class="fs-7 fw-bold text-muted">Marketing</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<img class="w-20px h-20px" src="/metronic8/demo1/assets/media/svg/brand-logos/tower.svg" alt="" />
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column justify-content-start fw-bold">
																		<span class="fs-6 fw-bold">Tower Group Website</span>
																		<span class="fs-7 fw-bold text-muted">Google Adwords</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Category title-->
																<h3 class="fs-5 text-muted m-0 pt-5 pb-5" data-kt-search-element="category-title">Projects</h3>
																<!--end::Category title-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--begin::Svg Icon | path: icons/duotune/general/gen005.svg-->
																			<span class="svg-icon svg-icon-2 svg-icon-primary">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path opacity="0.3" d="M19 22H5C4.4 22 4 21.6 4 21V3C4 2.4 4.4 2 5 2H14L20 8V21C20 21.6 19.6 22 19 22ZM15 17C15 16.4 14.6 16 14 16H8C7.4 16 7 16.4 7 17C7 17.6 7.4 18 8 18H14C14.6 18 15 17.6 15 17ZM17 12C17 11.4 16.6 11 16 11H8C7.4 11 7 11.4 7 12C7 12.6 7.4 13 8 13H16C16.6 13 17 12.6 17 12ZM17 7C17 6.4 16.6 6 16 6H8C7.4 6 7 6.4 7 7C7 7.6 7.4 8 8 8H16C16.6 8 17 7.6 17 7Z" fill="black" />
																					<path d="M15 8H20L14 2V7C14 7.6 14.4 8 15 8Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<span class="fs-6 fw-bold">Si-Fi Project by AU Themes</span>
																		<span class="fs-7 fw-bold text-muted">#45670</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--begin::Svg Icon | path: icons/duotune/general/gen032.svg-->
																			<span class="svg-icon svg-icon-2 svg-icon-primary">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<rect x="8" y="9" width="3" height="10" rx="1.5" fill="black" />
																					<rect opacity="0.5" x="13" y="5" width="3" height="14" rx="1.5" fill="black" />
																					<rect x="18" y="11" width="3" height="8" rx="1.5" fill="black" />
																					<rect x="3" y="13" width="3" height="6" rx="1.5" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<span class="fs-6 fw-bold">Shopix Mobile App Planning</span>
																		<span class="fs-7 fw-bold text-muted">#45690</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
																			<span class="svg-icon svg-icon-2 svg-icon-primary">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path opacity="0.3" d="M20 3H4C2.89543 3 2 3.89543 2 5V16C2 17.1046 2.89543 18 4 18H4.5C5.05228 18 5.5 18.4477 5.5 19V21.5052C5.5 22.1441 6.21212 22.5253 6.74376 22.1708L11.4885 19.0077C12.4741 18.3506 13.6321 18 14.8167 18H20C21.1046 18 22 17.1046 22 16V5C22 3.89543 21.1046 3 20 3Z" fill="black" />
																					<rect x="6" y="12" width="7" height="2" rx="1" fill="black" />
																					<rect x="6" y="7" width="12" height="2" rx="1" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<span class="fs-6 fw-bold">Finance Monitoring SAAS Discussion</span>
																		<span class="fs-7 fw-bold text-muted">#21090</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
																<!--begin::Item-->
																<a href="#" class="d-flex text-dark text-hover-primary align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--begin::Svg Icon | path: icons/duotune/communication/com006.svg-->
																			<span class="svg-icon svg-icon-2 svg-icon-primary">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path opacity="0.3" d="M22 12C22 17.5 17.5 22 12 22C6.5 22 2 17.5 2 12C2 6.5 6.5 2 12 2C17.5 2 22 6.5 22 12ZM12 7C10.3 7 9 8.3 9 10C9 11.7 10.3 13 12 13C13.7 13 15 11.7 15 10C15 8.3 13.7 7 12 7Z" fill="black" />
																					<path d="M12 22C14.6 22 17 21 18.7 19.4C17.9 16.9 15.2 15 12 15C8.8 15 6.09999 16.9 5.29999 19.4C6.99999 21 9.4 22 12 22Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<span class="fs-6 fw-bold">Dashboard Analitics Launch</span>
																		<span class="fs-7 fw-bold text-muted">#34560</span>
																	</div>
																	<!--end::Title-->
																</a>
																<!--end::Item-->
															</div>
															<!--end::Items-->
														</div>
														<!--end::Recently viewed-->
														<!--begin::Recently viewed-->
														<div class="mb-4" data-kt-search-element="main">
															<!--begin::Heading-->
															<div class="d-flex flex-stack fw-bold mb-4">
																<!--begin::Label-->
																<span class="text-muted fs-6 me-2">Recently Searched:</span>
																<!--end::Label-->
															</div>
															<!--end::Heading-->
															<!--begin::Items-->
															<div class="scroll-y mh-200px mh-lg-325px">
																<!--begin::Item-->
																<div class="d-flex align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--begin::Svg Icon | path: icons/duotune/electronics/elc004.svg-->
																			<span class="svg-icon svg-icon-2 svg-icon-primary">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path d="M2 16C2 16.6 2.4 17 3 17H21C21.6 17 22 16.6 22 16V15H2V16Z" fill="black" />
																					<path opacity="0.3" d="M21 3H3C2.4 3 2 3.4 2 4V15H22V4C22 3.4 21.6 3 21 3Z" fill="black" />
																					<path opacity="0.3" d="M15 17H9V20H15V17Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">BoomApp by Keenthemes</a>
																		<span class="fs-7 text-muted fw-bold">#45789</span>
																	</div>
																	<!--end::Title-->
																</div>
																<!--end::Item-->
																<!--begin::Item-->
																<div class="d-flex align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--begin::Svg Icon | path: icons/duotune/graphs/gra001.svg-->
																			<span class="svg-icon svg-icon-2 svg-icon-primary">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path opacity="0.3" d="M14 3V21H10V3C10 2.4 10.4 2 11 2H13C13.6 2 14 2.4 14 3ZM7 14H5C4.4 14 4 14.4 4 15V21H8V15C8 14.4 7.6 14 7 14Z" fill="black" />
																					<path d="M21 20H20V8C20 7.4 19.6 7 19 7H17C16.4 7 16 7.4 16 8V20H3C2.4 20 2 20.4 2 21C2 21.6 2.4 22 3 22H21C21.6 22 22 21.6 22 21C22 20.4 21.6 20 21 20Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">"Kept API Project Meeting</a>
																		<span class="fs-7 text-muted fw-bold">#84050</span>
																	</div>
																	<!--end::Title-->
																</div>
																<!--end::Item-->
																<!--begin::Item-->
																<div class="d-flex align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--begin::Svg Icon | path: icons/duotune/graphs/gra006.svg-->
																			<span class="svg-icon svg-icon-2 svg-icon-primary">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path d="M13 5.91517C15.8 6.41517 18 8.81519 18 11.8152C18 12.5152 17.9 13.2152 17.6 13.9152L20.1 15.3152C20.6 15.6152 21.4 15.4152 21.6 14.8152C21.9 13.9152 22.1 12.9152 22.1 11.8152C22.1 7.01519 18.8 3.11521 14.3 2.01521C13.7 1.91521 13.1 2.31521 13.1 3.01521V5.91517H13Z" fill="black" />
																					<path opacity="0.3" d="M19.1 17.0152C19.7 17.3152 19.8 18.1152 19.3 18.5152C17.5 20.5152 14.9 21.7152 12 21.7152C9.1 21.7152 6.50001 20.5152 4.70001 18.5152C4.30001 18.0152 4.39999 17.3152 4.89999 17.0152L7.39999 15.6152C8.49999 16.9152 10.2 17.8152 12 17.8152C13.8 17.8152 15.5 17.0152 16.6 15.6152L19.1 17.0152ZM6.39999 13.9151C6.19999 13.2151 6 12.5152 6 11.8152C6 8.81517 8.2 6.41515 11 5.91515V3.01519C11 2.41519 10.4 1.91519 9.79999 2.01519C5.29999 3.01519 2 7.01517 2 11.8152C2 12.8152 2.2 13.8152 2.5 14.8152C2.7 15.4152 3.4 15.7152 4 15.3152L6.39999 13.9151Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">"KPI Monitoring App Launch</a>
																		<span class="fs-7 text-muted fw-bold">#84250</span>
																	</div>
																	<!--end::Title-->
																</div>
																<!--end::Item-->
																<!--begin::Item-->
																<div class="d-flex align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--begin::Svg Icon | path: icons/duotune/graphs/gra002.svg-->
																			<span class="svg-icon svg-icon-2 svg-icon-primary">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path opacity="0.3" d="M20 8L12.5 5L5 14V19H20V8Z" fill="black" />
																					<path d="M21 18H6V3C6 2.4 5.6 2 5 2C4.4 2 4 2.4 4 3V18H3C2.4 18 2 18.4 2 19C2 19.6 2.4 20 3 20H4V21C4 21.6 4.4 22 5 22C5.6 22 6 21.6 6 21V20H21C21.6 20 22 19.6 22 19C22 18.4 21.6 18 21 18Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Project Reference FAQ</a>
																		<span class="fs-7 text-muted fw-bold">#67945</span>
																	</div>
																	<!--end::Title-->
																</div>
																<!--end::Item-->
																<!--begin::Item-->
																<div class="d-flex align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--begin::Svg Icon | path: icons/duotune/communication/com010.svg-->
																			<span class="svg-icon svg-icon-2 svg-icon-primary">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path d="M6 8.725C6 8.125 6.4 7.725 7 7.725H14L18 11.725V12.925L22 9.725L12.6 2.225C12.2 1.925 11.7 1.925 11.4 2.225L2 9.725L6 12.925V8.725Z" fill="black" />
																					<path opacity="0.3" d="M22 9.72498V20.725C22 21.325 21.6 21.725 21 21.725H3C2.4 21.725 2 21.325 2 20.725V9.72498L11.4 17.225C11.8 17.525 12.3 17.525 12.6 17.225L22 9.72498ZM15 11.725H18L14 7.72498V10.725C14 11.325 14.4 11.725 15 11.725Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">"FitPro App Development</a>
																		<span class="fs-7 text-muted fw-bold">#84250</span>
																	</div>
																	<!--end::Title-->
																</div>
																<!--end::Item-->
																<!--begin::Item-->
																<div class="d-flex align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--begin::Svg Icon | path: icons/duotune/finance/fin001.svg-->
																			<span class="svg-icon svg-icon-2 svg-icon-primary">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path d="M20 19.725V18.725C20 18.125 19.6 17.725 19 17.725H5C4.4 17.725 4 18.125 4 18.725V19.725H3C2.4 19.725 2 20.125 2 20.725V21.725H22V20.725C22 20.125 21.6 19.725 21 19.725H20Z" fill="black" />
																					<path opacity="0.3" d="M22 6.725V7.725C22 8.325 21.6 8.725 21 8.725H18C18.6 8.725 19 9.125 19 9.725C19 10.325 18.6 10.725 18 10.725V15.725C18.6 15.725 19 16.125 19 16.725V17.725H15V16.725C15 16.125 15.4 15.725 16 15.725V10.725C15.4 10.725 15 10.325 15 9.725C15 9.125 15.4 8.725 16 8.725H13C13.6 8.725 14 9.125 14 9.725C14 10.325 13.6 10.725 13 10.725V15.725C13.6 15.725 14 16.125 14 16.725V17.725H10V16.725C10 16.125 10.4 15.725 11 15.725V10.725C10.4 10.725 10 10.325 10 9.725C10 9.125 10.4 8.725 11 8.725H8C8.6 8.725 9 9.125 9 9.725C9 10.325 8.6 10.725 8 10.725V15.725C8.6 15.725 9 16.125 9 16.725V17.725H5V16.725C5 16.125 5.4 15.725 6 15.725V10.725C5.4 10.725 5 10.325 5 9.725C5 9.125 5.4 8.725 6 8.725H3C2.4 8.725 2 8.325 2 7.725V6.725L11 2.225C11.6 1.925 12.4 1.925 13.1 2.225L22 6.725ZM12 3.725C11.2 3.725 10.5 4.425 10.5 5.225C10.5 6.025 11.2 6.725 12 6.725C12.8 6.725 13.5 6.025 13.5 5.225C13.5 4.425 12.8 3.725 12 3.725Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">Shopix Mobile App</a>
																		<span class="fs-7 text-muted fw-bold">#45690</span>
																	</div>
																	<!--end::Title-->
																</div>
																<!--end::Item-->
																<!--begin::Item-->
																<div class="d-flex align-items-center mb-5">
																	<!--begin::Symbol-->
																	<div class="symbol symbol-40px me-4">
																		<span class="symbol-label bg-light">
																			<!--SVG file not found: icons/duotune/graphs/gra002.svg
-->
																		</span>
																	</div>
																	<!--end::Symbol-->
																	<!--begin::Title-->
																	<div class="d-flex flex-column">
																		<a href="#" class="fs-6 text-gray-800 text-hover-primary fw-bold">"Landing UI Design" Launch</a>
																		<span class="fs-7 text-muted fw-bold">#24005</span>
																	</div>
																	<!--end::Title-->
																</div>
																<!--end::Item-->
															</div>
															<!--end::Items-->
														</div>
														<!--end::Recently viewed-->
														<!--begin::Empty-->
														<div data-kt-search-element="empty" class="text-center d-none">
															<!--begin::Icon-->
															<div class="pt-10 pb-10">
																<!--begin::Svg Icon | path: icons/duotune/files/fil024.svg-->
																<span class="svg-icon svg-icon-4x opacity-50">
																	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																		<path opacity="0.3" d="M14 2H6C4.89543 2 4 2.89543 4 4V20C4 21.1046 4.89543 22 6 22H18C19.1046 22 20 21.1046 20 20V8L14 2Z" fill="black" />
																		<path d="M20 8L14 2V6C14 7.10457 14.8954 8 16 8H20Z" fill="black" />
																		<rect x="13.6993" y="13.6656" width="4.42828" height="1.73089" rx="0.865447" transform="rotate(45 13.6993 13.6656)" fill="black" />
																		<path d="M15 12C15 14.2 13.2 16 11 16C8.8 16 7 14.2 7 12C7 9.8 8.8 8 11 8C13.2 8 15 9.8 15 12ZM11 9.6C9.68 9.6 8.6 10.68 8.6 12C8.6 13.32 9.68 14.4 11 14.4C12.32 14.4 13.4 13.32 13.4 12C13.4 10.68 12.32 9.6 11 9.6Z" fill="black" />
																	</svg>
																</span>
																<!--end::Svg Icon-->
															</div>
															<!--end::Icon-->
															<!--begin::Message-->
															<div class="pb-15 fw-bold">
																<h3 class="text-gray-600 fs-5 mb-2">No result found</h3>
																<div class="text-muted fs-7">Please try again with a different query</div>
															</div>
															<!--end::Message-->
														</div>
														<!--end::Empty-->
													</div>
													<!--end::Wrapper-->
													<!--begin::Preferences-->
													<form data-kt-search-element="advanced-options-form" class="pt-1 d-none">
														<!--begin::Heading-->
														<h3 class="fw-bold text-dark mb-7">Advanced Search</h3>
														<!--end::Heading-->
														<!--begin::Input group-->
														<div class="mb-5">
															<input type="text" class="form-control form-control-sm form-control-solid" placeholder="Contains the word" name="query" />
														</div>
														<!--end::Input group-->
														<!--begin::Input group-->
														<div class="mb-5">
															<!--begin::Radio group-->
															<div class="nav-group nav-group-fluid">
																<!--begin::Option-->
																<label>
																	<input type="radio" class="btn-check" name="type" value="has" checked="checked" />
																	<span class="btn btn-sm btn-color-muted btn-active btn-active-primary">All</span>
																</label>
																<!--end::Option-->
																<!--begin::Option-->
																<label>
																	<input type="radio" class="btn-check" name="type" value="users" />
																	<span class="btn btn-sm btn-color-muted btn-active btn-active-primary px-4">Users</span>
																</label>
																<!--end::Option-->
																<!--begin::Option-->
																<label>
																	<input type="radio" class="btn-check" name="type" value="orders" />
																	<span class="btn btn-sm btn-color-muted btn-active btn-active-primary px-4">Orders</span>
																</label>
																<!--end::Option-->
																<!--begin::Option-->
																<label>
																	<input type="radio" class="btn-check" name="type" value="projects" />
																	<span class="btn btn-sm btn-color-muted btn-active btn-active-primary px-4">Projects</span>
																</label>
																<!--end::Option-->
															</div>
															<!--end::Radio group-->
														</div>
														<!--end::Input group-->
														<!--begin::Input group-->
														<div class="mb-5">
															<input type="text" name="assignedto" class="form-control form-control-sm form-control-solid" placeholder="Assigned to" value="" />
														</div>
														<!--end::Input group-->
														<!--begin::Input group-->
														<div class="mb-5">
															<input type="text" name="collaborators" class="form-control form-control-sm form-control-solid" placeholder="Collaborators" value="" />
														</div>
														<!--end::Input group-->
														<!--begin::Input group-->
														<div class="mb-5">
															<!--begin::Radio group-->
															<div class="nav-group nav-group-fluid">
																<!--begin::Option-->
																<label>
																	<input type="radio" class="btn-check" name="attachment" value="has" checked="checked" />
																	<span class="btn btn-sm btn-color-muted btn-active btn-active-primary">Has attachment</span>
																</label>
																<!--end::Option-->
																<!--begin::Option-->
																<label>
																	<input type="radio" class="btn-check" name="attachment" value="any" />
																	<span class="btn btn-sm btn-color-muted btn-active btn-active-primary px-4">Any</span>
																</label>
																<!--end::Option-->
															</div>
															<!--end::Radio group-->
														</div>
														<!--end::Input group-->
														<!--begin::Input group-->
														<div class="mb-5">
															<select name="timezone" aria-label="Select a Timezone" data-control="select2" data-placeholder="date_period" class="form-select form-select-sm form-select-solid">
																<option value="next">Within the next</option>
																<option value="last">Within the last</option>
																<option value="between">Between</option>
																<option value="on">On</option>
															</select>
														</div>
														<!--end::Input group-->
														<!--begin::Input group-->
														<div class="row mb-8">
															<!--begin::Col-->
															<div class="col-6">
																<input type="number" name="date_number" class="form-control form-control-sm form-control-solid" placeholder="Lenght" value="" />
															</div>
															<!--end::Col-->
															<!--begin::Col-->
															<div class="col-6">
																<select name="date_typer" aria-label="Select a Timezone" data-control="select2" data-placeholder="Period" class="form-select form-select-sm form-select-solid">
																	<option value="days">Days</option>
																	<option value="weeks">Weeks</option>
																	<option value="months">Months</option>
																	<option value="years">Years</option>
																</select>
															</div>
															<!--end::Col-->
														</div>
														<!--end::Input group-->
														<!--begin::Actions-->
														<div class="d-flex justify-content-end">
															<button type="reset" class="btn btn-sm btn-light fw-bolder btn-active-light-primary me-2" data-kt-search-element="advanced-options-form-cancel">Cancel</button>
															<a href="/metronic8/demo1/../demo1/pages/search/horizontal.html" class="btn btn-sm fw-bolder btn-primary" data-kt-search-element="advanced-options-form-search">Search</a>
														</div>
														<!--end::Actions-->
													</form>
													<!--end::Preferences-->
													<!--begin::Preferences-->
													<form data-kt-search-element="preferences" class="pt-1 d-none">
														<!--begin::Heading-->
														<h3 class="fw-bold text-dark mb-7">Search Preferences</h3>
														<!--end::Heading-->
														<!--begin::Input group-->
														<div class="pb-4 border-bottom">
															<label class="form-check form-switch form-switch-sm form-check-custom form-check-solid flex-stack">
																<span class="form-check-label text-gray-700 fs-6 fw-bold ms-0 me-2">Projects</span>
																<input class="form-check-input" type="checkbox" value="1" checked="checked" />
															</label>
														</div>
														<!--end::Input group-->
														<!--begin::Input group-->
														<div class="py-4 border-bottom">
															<label class="form-check form-switch form-switch-sm form-check-custom form-check-solid flex-stack">
																<span class="form-check-label text-gray-700 fs-6 fw-bold ms-0 me-2">Targets</span>
																<input class="form-check-input" type="checkbox" value="1" checked="checked" />
															</label>
														</div>
														<!--end::Input group-->
														<!--begin::Input group-->
														<div class="py-4 border-bottom">
															<label class="form-check form-switch form-switch-sm form-check-custom form-check-solid flex-stack">
																<span class="form-check-label text-gray-700 fs-6 fw-bold ms-0 me-2">Affiliate Programs</span>
																<input class="form-check-input" type="checkbox" value="1" />
															</label>
														</div>
														<!--end::Input group-->
														<!--begin::Input group-->
														<div class="py-4 border-bottom">
															<label class="form-check form-switch form-switch-sm form-check-custom form-check-solid flex-stack">
																<span class="form-check-label text-gray-700 fs-6 fw-bold ms-0 me-2">Referrals</span>
																<input class="form-check-input" type="checkbox" value="1" checked="checked" />
															</label>
														</div>
														<!--end::Input group-->
														<!--begin::Input group-->
														<div class="py-4 border-bottom">
															<label class="form-check form-switch form-switch-sm form-check-custom form-check-solid flex-stack">
																<span class="form-check-label text-gray-700 fs-6 fw-bold ms-0 me-2">Users</span>
																<input class="form-check-input" type="checkbox" value="1" />
															</label>
														</div>
														<!--end::Input group-->
														<!--begin::Actions-->
														<div class="d-flex justify-content-end pt-7">
															<button type="reset" class="btn btn-sm btn-light fw-bolder btn-active-light-primary me-2" data-kt-search-element="preferences-dismiss">Cancel</button>
															<button type="submit" class="btn btn-sm fw-bolder btn-primary">Save Changes</button>
														</div>
														<!--end::Actions-->
													</form>
													<!--end::Preferences-->
												</div>
												<!--end::Menu-->
											</div>
											<!--end::Search-->
										</div>
										<div class="d-flex align-items-center ms-1 ms-lg-3" id="kt_header_user_menu_toggle">
											<!--begin::Menu wrapper-->
											<div class="cursor-pointer symbol symbol-30px symbol-md-40px" data-kt-menu-trigger="click" data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
												<a href="${pageContext.request.contextPath}/logOut.do" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#kt_modal_create_app" id="kt_toolbar_primary_button">로그아웃</a>
											</div>
										</div>
										<!--end::User -->
										<!--begin::Heaeder menu toggle-->
										<div class="d-flex align-items-center d-lg-none ms-2 me-n3" title="Show header menu">
											<div class="btn btn-icon btn-active-light-primary w-30px h-30px w-md-40px h-md-40px" id="kt_header_menu_mobile_toggle">
												<!--begin::Svg Icon | path: icons/duotune/text/txt001.svg-->
												<span class="svg-icon svg-icon-1">
													<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
														<path d="M13 11H3C2.4 11 2 10.6 2 10V9C2 8.4 2.4 8 3 8H13C13.6 8 14 8.4 14 9V10C14 10.6 13.6 11 13 11ZM22 5V4C22 3.4 21.6 3 21 3H3C2.4 3 2 3.4 2 4V5C2 5.6 2.4 6 3 6H21C21.6 6 22 5.6 22 5Z" fill="black" />
														<path opacity="0.3" d="M21 16H3C2.4 16 2 15.6 2 15V14C2 13.4 2.4 13 3 13H21C21.6 13 22 13.4 22 14V15C22 15.6 21.6 16 21 16ZM14 20V19C14 18.4 13.6 18 13 18H3C2.4 18 2 18.4 2 19V20C2 20.6 2.4 21 3 21H13C13.6 21 14 20.6 14 20Z" fill="black" />
													</svg>
												</span>
												<!--end::Svg Icon-->
											</div>
										</div>
										<!--end::Heaeder menu toggle-->
									</div>
									<!--end::Toolbar wrapper-->
								</div>
								<!--end::Topbar-->
							</div>
							<!--end::Wrapper-->
						</div>
						<!--end::Container-->
					</div>
					<!--end::Header-->
					<!--begin::Content-->
					<div class="content d-flex flex-column flex-column-fluid" id="kt_content">
						<!--begin::Toolbar-->
						<div class="toolbar" id="kt_toolbar">
							<!--begin::Container-->
							<div id="kt_toolbar_container" class="container-fluid d-flex flex-stack">
								<!--begin::Page title-->
								<div data-kt-swapper="true" data-kt-swapper-mode="prepend" data-kt-swapper-parent="{default: '#kt_content_container', 'lg': '#kt_toolbar_container'}" class="page-title d-flex align-items-center flex-wrap me-3 mb-5 mb-lg-0">
									<!--begin::Title-->
									<h1 class="d-flex align-items-center text-dark fw-bolder fs-3 my-1">  
									관리자 목록
									<span class="h-20px border-gray-200 border-start ms-3 mx-2"></span>
									<small class="text-muted fs-7 fw-bold my-1 ms-1">Home > 관리자 설정 > 관리자 목록</small>
									</h1>
								</div>
								<!--end::Page title-->
								<!--begin::Actions-->
								<div class="d-flex align-items-center py-1">
									<!--begin::Wrapper-->
									<div class="me-4">
									</div>
									<!--end::Wrapper-->
									<!--begin::Button-->
									
									<!--end::Button-->
								</div>
								<!--end::Actions-->
							</div>
							<!--end::Container-->
						</div>
						<div id="kt_content_container" class="container-xxl">
							<div class="row gy-5 g-xl-8">
							<div class="col-xl-8" style="width:100%;">
										<!--begin::Tables Widget 9-->
										<div class="card card-xl-stretch mb-5 mb-xl-8">
											<!--begin::Header-->
											<div class="card-header border-0 pt-5">
												<h3 class="card-title align-items-start flex-column">
													<span class="card-label fw-bolder fs-3 mb-1">관리자 목록</span>
													<span class="text-muted mt-1 fw-bold fs-7">전체 2건이 검색되었습니다.</span>
												</h3>
												<div class="card-toolbar" data-select2-id="select2-data-82-wm57">
											<!--begin::Toolbar-->
													<div class="d-flex justify-content-end" data-kt-user-table-toolbar="base" data-select2-id="select2-data-81-qwl0">
														<!--begin::Filter-->
														<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#kt_modal_export_users">
														<!--begin::Svg Icon | path: icons/duotune/arrows/arr078.svg-->
														<span class="svg-icon svg-icon-2">
															<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																<rect opacity="0.3" x="12.75" y="4.25" width="12" height="2" rx="1" transform="rotate(90 12.75 4.25)" fill="black"></rect>
																<path d="M12.0573 6.11875L13.5203 7.87435C13.9121 8.34457 14.6232 8.37683 15.056 7.94401C15.4457 7.5543 15.4641 6.92836 15.0979 6.51643L12.4974 3.59084C12.0996 3.14332 11.4004 3.14332 11.0026 3.59084L8.40206 6.51643C8.0359 6.92836 8.0543 7.5543 8.44401 7.94401C8.87683 8.37683 9.58785 8.34458 9.9797 7.87435L11.4427 6.11875C11.6026 5.92684 11.8974 5.92684 12.0573 6.11875Z" fill="black"></path>
																<path d="M18.75 8.25H17.75C17.1977 8.25 16.75 8.69772 16.75 9.25C16.75 9.80228 17.1977 10.25 17.75 10.25C18.3023 10.25 18.75 10.6977 18.75 11.25V18.25C18.75 18.8023 18.3023 19.25 17.75 19.25H5.75C5.19772 19.25 4.75 18.8023 4.75 18.25V11.25C4.75 10.6977 5.19771 10.25 5.75 10.25C6.30229 10.25 6.75 9.80228 6.75 9.25C6.75 8.69772 6.30229 8.25 5.75 8.25H4.75C3.64543 8.25 2.75 9.14543 2.75 10.25V19.25C2.75 20.3546 3.64543 21.25 4.75 21.25H18.75C19.8546 21.25 20.75 20.3546 20.75 19.25V10.25C20.75 9.14543 19.8546 8.25 18.75 8.25Z" fill="#C4C4C4"></path>
															</svg>
														</span>
														<!--end::Svg Icon-->Export</button>
														<!--end::Export-->
														<!--begin::Add user-->
														<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#kt_modal_add_user" onclick="javascript:fn_loadPage('siteRegi');return false;">
														<!--begin::Svg Icon | path: icons/duotune/arrows/arr075.svg-->
														<span class="svg-icon svg-icon-2">
															<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																<rect opacity="0.5" x="11.364" y="20.364" width="16" height="2" rx="1" transform="rotate(-90 11.364 20.364)" fill="black"></rect>
																<rect x="4.36396" y="11.364" width="16" height="2" rx="1" fill="black"></rect>
															</svg>
														</span>
														<!--end::Svg Icon-->관리자 등록</button>
														<!--end::Add user-->
													</div>
													<!--begin::Modal - Add task-->
												</div>
											</div>
											<div class="card-body py-3">
												<div class="card-title" style="width:100%;">
													<div class="d-flex align-items-center position-relative my-1" style="float:left;">
														<!--begin::Svg Icon | path: icons/duotune/general/gen021.svg-->
														<span class="svg-icon svg-icon-1 position-absolute ms-6">
															<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																<rect opacity="0.5" x="17.0365" y="15.1223" width="8.15546" height="2" rx="1" transform="rotate(45 17.0365 15.1223)" fill="black"></rect>
																<path d="M11 19C6.55556 19 3 15.4444 3 11C3 6.55556 6.55556 3 11 3C15.4444 3 19 6.55556 19 11C19 15.4444 15.4444 19 11 19ZM11 5C7.53333 5 5 7.53333 5 11C5 14.4667 7.53333 17 11 17C14.4667 17 17 14.4667 17 11C17 7.53333 14.4667 5 11 5Z" fill="black"></path>
															</svg>
														</span>
														<!--end::Svg Icon-->
														<input type="text" data-kt-user-table-filter="search" class="form-control form-control-solid w-250px ps-14" placeholder="관리자 검색">
													</div>
													<!--end::Search-->
												</div>
											</div>
											<!--end::Header-->
											<!--begin::Body-->
											<div class="card-body py-3">
												<!--begin::Table container-->
												<div class="table-responsive">
													<!--begin::Table-->
													<table class="table table-row-dashed table-row-gray-300 align-middle gs-0 gy-4">
														<!--begin::Table head-->
														<thead>
															<tr class="fw-bolder text-muted">
																<th class="w-25px">
																	<div class="form-check form-check-sm form-check-custom form-check-solid">
																		<input class="form-check-input" type="checkbox" value="1" data-kt-check="true" data-kt-check-target=".widget-9-check" />
																	</div>
																</th>
																<th class="min-w-150px">고객사명</th>
																<th class="min-w-140px">성명</th>
																<th class="min-w-140px">아이디</th>
																<th class="min-w-140px">연락처</th>
																<th class="min-w-150px">이메일</th>
																<th class="min-w-150px">사이트 명</th>
																<th class="min-w-100px">등록일</th>
																<th class="min-w-80px text-end">관리</th>
															</tr>
														</thead>
														<!--end::Table head-->
														<!--begin::Table body-->
														<tbody>
															<tr>
																<td>
																	<div class="form-check form-check-sm form-check-custom form-check-solid">
																		<input class="form-check-input widget-9-check" type="checkbox" value="1" />
																	</div>
																</td>
																<td>
																	<div class="d-flex align-items-center">
																		<div class="d-flex justify-content-start flex-column">
																			<a href="#" class="text-dark fw-bolder text-hover-primary fs-6">고객사 1</a>
																		</div>
																	</div>
																</td>
																<td>
																	<a href="#" class="text-dark fw-bolder text-hover-primary d-block fs-6">홍길동</a>
																</td>
																<td>
																	<a href="#" class="text-dark fw-bolder text-hover-primary d-block fs-6">test_admin</a>
																</td>
																<td>
																	<a href="#" class="text-dark text-hover-primary d-block fs-6">010-0000-0000</a>
																</td>
																<td>
																	<a href="#" class="text-dark text-hover-primary d-block fs-6">test@naver.com</a>
																</td>
																<td>
																	<a href="#" class="text-dark text-hover-primary d-block fs-6">고객사사이트1</a>
																</td>
																<td>
																	<a href="#" class="text-dark text-hover-primary d-block fs-6">2021-09-01</a>
																</td>
																<td>
																	<div class="d-flex justify-content-end flex-shrink-0">
																		<a href="#" class="btn btn-icon btn-bg-light btn-active-color-primary btn-sm me-1">
																			<!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
																			<span class="svg-icon svg-icon-3">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path opacity="0.3" d="M21.4 8.35303L19.241 10.511L13.485 4.755L15.643 2.59595C16.0248 2.21423 16.5426 1.99988 17.0825 1.99988C17.6224 1.99988 18.1402 2.21423 18.522 2.59595L21.4 5.474C21.7817 5.85581 21.9962 6.37355 21.9962 6.91345C21.9962 7.45335 21.7817 7.97122 21.4 8.35303ZM3.68699 21.932L9.88699 19.865L4.13099 14.109L2.06399 20.309C1.98815 20.5354 1.97703 20.7787 2.03189 21.0111C2.08674 21.2436 2.2054 21.4561 2.37449 21.6248C2.54359 21.7934 2.75641 21.9115 2.989 21.9658C3.22158 22.0201 3.4647 22.0084 3.69099 21.932H3.68699Z" fill="black" />
																					<path d="M5.574 21.3L3.692 21.928C3.46591 22.0032 3.22334 22.0141 2.99144 21.9594C2.75954 21.9046 2.54744 21.7864 2.3789 21.6179C2.21036 21.4495 2.09202 21.2375 2.03711 21.0056C1.9822 20.7737 1.99289 20.5312 2.06799 20.3051L2.696 18.422L5.574 21.3ZM4.13499 14.105L9.891 19.861L19.245 10.507L13.489 4.75098L4.13499 14.105Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</a>
																		<a href="#" class="btn btn-icon btn-bg-light btn-active-color-primary btn-sm">
																			<!--begin::Svg Icon | path: icons/duotune/general/gen027.svg-->
																			<span class="svg-icon svg-icon-3">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path d="M5 9C5 8.44772 5.44772 8 6 8H18C18.5523 8 19 8.44772 19 9V18C19 19.6569 17.6569 21 16 21H8C6.34315 21 5 19.6569 5 18V9Z" fill="black" />
																					<path opacity="0.5" d="M5 5C5 4.44772 5.44772 4 6 4H18C18.5523 4 19 4.44772 19 5V5C19 5.55228 18.5523 6 18 6H6C5.44772 6 5 5.55228 5 5V5Z" fill="black" />
																					<path opacity="0.5" d="M9 4C9 3.44772 9.44772 3 10 3H14C14.5523 3 15 3.44772 15 4V4H9V4Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</a>
																	</div>
																</td>
															</tr>
															<tr>
																<td>
																	<div class="form-check form-check-sm form-check-custom form-check-solid">
																		<input class="form-check-input widget-9-check" type="checkbox" value="1" />
																	</div>
																</td>
																<td>
																	<div class="d-flex align-items-center">
																		<div class="d-flex justify-content-start flex-column">
																			<a href="#" class="text-dark fw-bolder text-hover-primary fs-6">고객사 2</a>
																		</div>
																	</div>
																</td>
																<td>
																	<a href="#" class="text-dark fw-bolder text-hover-primary d-block fs-6">홍길동2</a>
																</td>
																<td>
																	<a href="#" class="text-dark fw-bolder text-hover-primary d-block fs-6">test_admin2</a>
																</td>
																<td>
																	<a href="#" class="text-dark text-hover-primary d-block fs-6">010-0000-0000</a>
																</td>
																<td>
																	<a href="#" class="text-dark text-hover-primary d-block fs-6">test2@naver.com</a>
																</td>
																<td>
																	<a href="#" class="text-dark text-hover-primary d-block fs-6">고객사사이트2</a>
																</td>
																<td>
																	<a href="#" class="text-dark text-hover-primary d-block fs-6">2021-09-01</a>
																</td>
																<td>
																	<div class="d-flex justify-content-end flex-shrink-0">
																		<a href="#" class="btn btn-icon btn-bg-light btn-active-color-primary btn-sm me-1">
																			<!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
																			<span class="svg-icon svg-icon-3">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path opacity="0.3" d="M21.4 8.35303L19.241 10.511L13.485 4.755L15.643 2.59595C16.0248 2.21423 16.5426 1.99988 17.0825 1.99988C17.6224 1.99988 18.1402 2.21423 18.522 2.59595L21.4 5.474C21.7817 5.85581 21.9962 6.37355 21.9962 6.91345C21.9962 7.45335 21.7817 7.97122 21.4 8.35303ZM3.68699 21.932L9.88699 19.865L4.13099 14.109L2.06399 20.309C1.98815 20.5354 1.97703 20.7787 2.03189 21.0111C2.08674 21.2436 2.2054 21.4561 2.37449 21.6248C2.54359 21.7934 2.75641 21.9115 2.989 21.9658C3.22158 22.0201 3.4647 22.0084 3.69099 21.932H3.68699Z" fill="black" />
																					<path d="M5.574 21.3L3.692 21.928C3.46591 22.0032 3.22334 22.0141 2.99144 21.9594C2.75954 21.9046 2.54744 21.7864 2.3789 21.6179C2.21036 21.4495 2.09202 21.2375 2.03711 21.0056C1.9822 20.7737 1.99289 20.5312 2.06799 20.3051L2.696 18.422L5.574 21.3ZM4.13499 14.105L9.891 19.861L19.245 10.507L13.489 4.75098L4.13499 14.105Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</a>
																		<a href="#" class="btn btn-icon btn-bg-light btn-active-color-primary btn-sm">
																			<!--begin::Svg Icon | path: icons/duotune/general/gen027.svg-->
																			<span class="svg-icon svg-icon-3">
																				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
																					<path d="M5 9C5 8.44772 5.44772 8 6 8H18C18.5523 8 19 8.44772 19 9V18C19 19.6569 17.6569 21 16 21H8C6.34315 21 5 19.6569 5 18V9Z" fill="black" />
																					<path opacity="0.5" d="M5 5C5 4.44772 5.44772 4 6 4H18C18.5523 4 19 4.44772 19 5V5C19 5.55228 18.5523 6 18 6H6C5.44772 6 5 5.55228 5 5V5Z" fill="black" />
																					<path opacity="0.5" d="M9 4C9 3.44772 9.44772 3 10 3H14C14.5523 3 15 3.44772 15 4V4H9V4Z" fill="black" />
																				</svg>
																			</span>
																			<!--end::Svg Icon-->
																		</a>
																	</div>
																</td>
															</tr>
															
															
															
														</tbody>
														<!--end::Table body-->
													</table>
													<!--end::Table-->
												</div>
												<div class="row">
													<div class="col-sm-12 col-md-5 d-flex align-items-center justify-content-center justify-content-md-start">
													</div>
													<div class="col-sm-12 col-md-7 d-flex align-items-center justify-content-center justify-content-md-end">
														<div class="dataTables_paginate paging_simple_numbers" id="kt_table_users_paginate">
															<ul class="pagination">
																<li class="paginate_button page-item previous disabled" id="kt_table_users_previous">
																	<a href="#" aria-controls="kt_table_users" data-dt-idx="0" tabindex="0" class="page-link">
																		<i class="previous"></i>
																	</a>
																</li>
																<li class="paginate_button page-item active">
																	<a href="#" aria-controls="kt_table_users" data-dt-idx="1" tabindex="0" class="page-link">
																	1
																	</a>
																</li>
																<li class="paginate_button page-item next" id="kt_table_users_next"><a href="#" aria-controls="kt_table_users" data-dt-idx="4" tabindex="0" class="page-link"><i class="next"></i></a>
																</li>
															</ul>
														</div>
													</div>
												</div>
												<!--end::Table container-->
											</div>
											<!--begin::Body-->
										</div>
										<!--end::Tables Widget 9-->
									</div>
						</div>
						</div>
					</div>
					<!--end::Content-->
					<!--begin::Footer-->
					<div class="footer py-4 d-flex flex-lg-column" id="kt_footer">
						<!--begin::Container-->
						<div class="container-fluid d-flex flex-column flex-md-row align-items-center justify-content-between">
							<!--begin::Copyright-->
							<div class="text-dark order-2 order-md-1">
								<span class="text-muted fw-bold me-1">2021©</span>
								<a href="#" target="_blank" class="text-gray-800 text-hover-primary">클릭 컨설팅</a>
							</div>
							<!--end::Copyright-->
							<!--begin::Menu-->
							<!-- <ul class="menu menu-gray-600 menu-hover-primary fw-bold order-1">
								<li class="menu-item">
									<a href="https://keenthemes.com" target="_blank" class="menu-link px-2">About</a>
								</li>
								<li class="menu-item">
									<a href="https://keenthemes.com/support" target="_blank" class="menu-link px-2">Support</a>
								</li>
								<li class="menu-item">
									<a href="https://1.envato.market/EA4JP" target="_blank" class="menu-link px-2">Purchase</a>
								</li>
							</ul> -->
							<!--end::Menu-->
						</div>
						<!--end::Container-->
					</div>
					<!--end::Footer-->
				</div>
				<!--end::Wrapper-->
			</div>
			<!--end::Page-->
		</div>
		<!--begin::Scrolltop-->
		<div id="kt_scrolltop" class="scrolltop" data-kt-scrolltop="true">
			<!--begin::Svg Icon | path: icons/duotune/arrows/arr066.svg-->
			<span class="svg-icon">
				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
					<rect opacity="0.5" x="13" y="6" width="13" height="2" rx="1" transform="rotate(90 13 6)" fill="black" />
					<path d="M12.5657 8.56569L16.75 12.75C17.1642 13.1642 17.8358 13.1642 18.25 12.75C18.6642 12.3358 18.6642 11.6642 18.25 11.25L12.7071 5.70711C12.3166 5.31658 11.6834 5.31658 11.2929 5.70711L5.75 11.25C5.33579 11.6642 5.33579 12.3358 5.75 12.75C6.16421 13.1642 6.83579 13.1642 7.25 12.75L11.4343 8.56569C11.7467 8.25327 12.2533 8.25327 12.5657 8.56569Z" fill="black" />
				</svg>
			</span>
			<!--end::Svg Icon-->
		</div>
		<!--end::Scrolltop-->
		<!--end::Main-->
		<!--begin::Javascript-->
		<!--begin::Global Javascript Bundle(used by all pages)-->
		<script src="${pageContext.request.contextPath}/resources/js/plugins.bundle.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/scripts.bundle.js"></script>
		<!--end::Global Javascript Bundle-->
		<!--begin::Page Vendors Javascript(used by this page)-->
		<!--end::Page Vendors Javascript-->
		<!--begin::Page Custom Javascript(used by this page)-->
		<script src="${pageContext.request.contextPath}/resources/js/widgets.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/intro.js"></script>
		<!--end::Page Custom Javascript-->
		<!--end::Javascript-->
		<!--Begin::Google Tag Manager (noscript) -->
		<!--End::Google Tag Manager (noscript) -->
	</body>
	<!--end::Body-->
</html>