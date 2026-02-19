<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="ko" class="ko">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="apple-mobile-web-app-capable" content="yes"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
<meta name="format-detection" content="telephone=no" />


<title>ONION BOX</title>

<!-- <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/mobile/images/favicon.ico" type="image/x-icon"/> -->
<link rel="apple-touch-icon-precomposed"  href="${pageContext.request.contextPath}/resources/mobile/images/114x114.png" />
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/resources/mobile/images/114x114.png" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/mobile/css/jquery-ui-1.10.4.min.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/mobile/css/m_common.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/mobile/css/m_contents.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/vendors.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/vendor/jquery/jquery-1.12.4.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/vendor/jquery/jquery.easing.1.3.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/vendor/jquery/jquery-bpopup/jquery.bpopup.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/vendor/slick/slick.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/vendor/iscroll/iscroll.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mobile/js/location.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	fn_setSort();
	
	$(document).on("click", ".btn_sort", function(e){
		if($(this).hasClass("btn_sort_1")){
			$("#mobile_btn_sort").removeClass("btn_sort_1");
			$("#mobile_btn_sort").removeClass("btn_sort_2");
			$("#mobile_btn_sort").removeClass("btn_sort_3");
			$("#mobile_btn_sort").addClass("btn_sort_1");
			$(".sort_pop").hide();
			$.ajax({
				url : "${pageContext.request.contextPath}/mobile/mobileMainType1.do",
				type : "POST",
				success : function(result){
					$(".container").html(result);
				}
			})
			
		}else if($(this).hasClass("btn_sort_2")){
			$("#mobile_btn_sort").removeClass("btn_sort_1");
			$("#mobile_btn_sort").removeClass("btn_sort_2");
			$("#mobile_btn_sort").removeClass("btn_sort_3");
			$("#mobile_btn_sort").addClass("btn_sort_2");
			$(".sort_pop").hide();
			$.ajax({
				url : "${pageContext.request.contextPath}/mobile/mobileMainType2.do",
				type : "POST",
				success : function(result){
					$(".container").html(result);
				}
			})
		}else if($(this).hasClass("btn_sort_3")){
			$("#mobile_btn_sort").removeClass("btn_sort_1");
			$("#mobile_btn_sort").removeClass("btn_sort_2");
			$("#mobile_btn_sort").removeClass("btn_sort_3");
			$("#mobile_btn_sort").addClass("btn_sort_3");
			$(".sort_pop").hide();
			$.ajax({
				url : "${pageContext.request.contextPath}/mobile/mobileMainType3.do",
				type : "POST",
				success : function(result){
					$(".container").html(result);
				}
			})
		}
	});
});

function fn_setSort(){
	var type = $("#sortType").val();
	if(type == "btn_sort_1"){
		$("#mobile_btn_sort").removeClass("btn_sort_1");
		$("#mobile_btn_sort").removeClass("btn_sort_2");
		$("#mobile_btn_sort").removeClass("btn_sort_3");
		$("#mobile_btn_sort").addClass("btn_sort_1");
		$(".sort_pop").hide();
		$.ajax({
			url : "${pageContext.request.contextPath}/mobile/mobileMainType1.do",
			type : "POST",
			success : function(result){
				$(".container").html(result);
			}
		})
		
	}else if(type == "btn_sort_2"){
		$("#mobile_btn_sort").removeClass("btn_sort_1");
		$("#mobile_btn_sort").removeClass("btn_sort_2");
		$("#mobile_btn_sort").removeClass("btn_sort_3");
		$("#mobile_btn_sort").addClass("btn_sort_2");
		$(".sort_pop").hide();
		$.ajax({
			url : "${pageContext.request.contextPath}/mobile/mobileMainType2.do",
			type : "POST",
			success : function(result){
				$(".container").html(result);
			}
		})
	}else if(type == "btn_sort_3"){
		$("#mobile_btn_sort").removeClass("btn_sort_1");
		$("#mobile_btn_sort").removeClass("btn_sort_2");
		$("#mobile_btn_sort").removeClass("btn_sort_3");
		$("#mobile_btn_sort").addClass("btn_sort_3");
		$(".sort_pop").hide();
		$.ajax({
			url : "${pageContext.request.contextPath}/mobile/mobileMainType3.do",
			type : "POST",
			success : function(result){
				$(".container").html(result);
			}
		})
	}
}

function fn_leftMenuOpen(){
	$(".left_menu_back").css("display", "block");
	$("#leftMenuArea").animate({left:"0%"}, "normal");
}

function fn_leftMenuClose(){
	$(".left_menu_back").css("display", "none");
	$("#leftMenuArea").animate({left:"-200%"}, "fast");
}

function fn_mypage(){
	location.href="${pageContext.request.contextPath}/mobile/mypage.do";
}

function fn_noticeList(){
	location.href="${pageContext.request.contextPath}/mobile/noticeList.do";
}

function fn_rankingList(){
	location.href="${pageContext.request.contextPath}/mobile/rankingList.do";
}

function fn_pointList(){
	location.href="${pageContext.request.contextPath}/mobile/pointList.do";
}

function fn_setting(){
	location.href="${pageContext.request.contextPath}/mobile/setting.do";
}

function fn_study(){
	$("#popup_01").bPopup({
		amsl : 0
		, modal : true
		, opacity : 0.6
		, modalClose : true
		, follow : [true, false]
		, positionStyle: 'fixed'
		, onOpen : function() {

		}
		, onClose : function() {

		}
	}, function() {

	});
}

function fn_openSortMenu(){
	$(".sort_pop").show('fast');
}

function fn_goCourse(course_id){
	location.href="${pageContext.request.contextPath}/mobile/course.do?course_id="+course_id;
}
	
</script>
</head>

<body class="comBg mainPage" ontocuhstart><!--   -->

<div class="wrap">

	<div class="areas">
		<input type="hidden" id="sortType" value="btn_sort_1"/>
		<header class="header_w">
			<p></p>
			<a href="#" class="btn_left btn_menu" onclick="javascript:fn_leftMenuOpen();return false;" style="z-index:1000;"><em>메뉴</em></a>
			<a href="#" id="mobile_btn_sort" class="btn_right btn_sort_1" style="z-index:1000;right:50px;" onclick="javascript:fn_openSortMenu();return false;"><em>정렬</em></a>
			<a href="${pageContext.request.contextPath}/mobile/search.do" class="btn_right btn_mobile_search" style="z-index:1000;"><em>검색</em></a>
		</header>
		
		<div class="container">
			
		</div>

		<footer>
		</footer>

	</div><!-- areas -->
</div><!-- wrap -->
<div id="leftMenuArea" style="position:fixed;top:0;z-index:2000;left:-200%;width:100%;">
	<c:import url="/mobile/contentsLeft.do"/>
</div>
<div class="left_menu_back"  onclick="javascript:fn_leftMenuClose();return false;">
</div>
<div class="sort_pop" >
	<a href="#" style="width:50px;height:50px;float:left;" class="btn_sort btn_sort_1">
	</a>
	<a href="#" style="width:50px;height:50px;float:left;" class="btn_sort btn_sort_2">
	</a>
	<a href="#" style="width:50px;height:50px;float:left;" class="btn_sort btn_sort_3">
	</a>
</div>
<div class="popup popup_notice" id="popup_01">
	<div class="popup_body">
		<p class="st">해당 메뉴는 로그인 후 </p>
		<p class="title"><span class="c_red">사용 가능한</span> 메뉴 입니다.</p>
	</div>
	<div class="popup_foot">
		<div class="btns">
			<ul class="clearfix">
				<li class="wHalf"><a href="#" class="btn btn_line b-close">취소</a></li>
				<li class="wHalf"><a href="${pageContext.request.contextPath}/mobile/login.do" class="btn btn_box">로그인</a></li>
			</ul>
		</div>
	</div>
</div>
</body>
</html>




