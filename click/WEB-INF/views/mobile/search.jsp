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


<title>PetMe</title>


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
	$(document).ready(function(e) {	
		$(".footerMenu").removeClass("active");
		$(".footerMenu").each(function(i){
			if(i==3){
				$(this).addClass("active");
			}
		});
	});
	
	function fn_tab(idx){
		var memberId = '${memberVO.member_id}';
		if(idx == 1){
			location.href='${pageContext.request.contextPath}/mobile/main.do';
		}else if(idx == 2){
			if(memberId == "" || memberId == null){
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
			}else{
				location.href='${pageContext.request.contextPath}/mobile/alarmList.do';
			}
		}else if(idx == 3){
			location.href='${pageContext.request.contextPath}/mobile/checkShop.do?category_main_id=1';
		}else if(idx == 4){
			if(memberId == "" || memberId == null){
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
			}else{
				location.href='${pageContext.request.contextPath}/mobile/mypage.do';
			}
		}else if(idx == 5){
			location.href='${pageContext.request.contextPath}/mobile/etc.do';
		}
	}
	
	function fn_petStoryRegi(){
		location.href='${pageContext.request.contextPath}/mobile/petStoryRegi.do';
	}
	
	function fn_petstoryDetail(id){
		$("#petstory_id").val(id);
		document.parameterVO.action="${pageContext.request.contextPath}/mobile/petstoryDetail.do";
    	document.parameterVO.submit();
	}
	
	function fn_petRegi(){
		document.parameterVO.action="${pageContext.request.contextPath}/mobile/petRegi.do";
    	document.parameterVO.submit();
	}
	
	function fn_petDetail(pet){
		$("#pet_no").val(pet);
		document.parameterVO.action="${pageContext.request.contextPath}/mobile/petDetail.do";
    	document.parameterVO.submit();
	}
	
	function fn_followerPage(){
		location.href="${pageContext.request.contextPath}/mobile/myFollowerPage.do";
	}
</script>
</head>

<body class="comBg"><!--   -->

<div class="wrap">

	<div class="areas">
		<header class="header_top h260">
			<p class="title" style="color:#000;"><input type="search" class="form-control form-control-sm" placeholder="검색" aria-controls="users-list-datatable" style="border:0;color:#D5D5D5;text-align:center;width:100%;line-height:2.5rem;background-color:#F6F6F6;ime-mode:active;border-radius:4px;"></p>
			<a href="${pageContext.request.contextPath}/mobile/mobileMain.do" class="btn_left btn_back" style="z-index:1000;font-size:26px;line-height:80px;padding-left:15px;"><i class="feather icon-arrow-left"></i><em>이전 페이지로 돌아가기</em></a>
			<a href="${pageContext.request.contextPath}/mobile/search.do" class="btn_right btn_mobile_search" style="z-index:1000;"><em>검색</em></a>
		</header>
	</div><!-- areas -->
</div><!-- wrap -->
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
<script type="text/javascript">
	$(document).ready(function(e) {

	});
</script>
</body>
</html>




