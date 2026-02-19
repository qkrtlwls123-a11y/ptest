<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
	<link rel="shortcut icon" href="/resources/images/common/favicon.ico">
	<link rel="stylesheet" type="text/css" href="/resources/css/admin_common.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/css/admin_header.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/css/admin_popup.css"/>
	
	<!-- common js -->
	<script type="text/javascript" src="/resources/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.form.js"></script>
	
	<!-- bootstrap -->
	<link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css"/>
	<script type="text/javascript" src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/resources/js/common.popup.js"></script>
	<script type="text/javascript" src="/resources/js/common.code.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
	
		/* MAIN MENU */
		$('#main-menu > li:has(ul.sub-menu)').addClass('parent');
		$('ul.sub-menu > li:has(ul.sub-menu) > a').addClass('parent');
	
		$('#menu-toggle').click(function() {
			$('#main-menu').slideToggle(300);
			return false;
		});
	
		$(window).resize(function() {
			if ($(window).width() > 700) {
				$('#main-menu').removeAttr('style');
			}
		});
	
	});
	function logout(){
		location.href="/ka/logout.do";
	}
	</script>