<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	$(document).ready(function(e) {	
		$(document).on("click", ".contentsArrow", function(e){
			if($(this).hasClass("icon-chevron-down")){
				$(this).removeClass("icon-chevron-down");
				$(this).addClass("icon-chevron-up");
				$(this).parent().parent().find(".contentsList").show();
			}else{
				$(this).removeClass("icon-chevron-up");
				$(this).addClass("icon-chevron-down");
				$(this).parent().parent().find(".contentsList").hide();
			}
		});
		
		$(document).on("click", ".checkheart", function(e){
			if($(this).hasClass("hearton")){
				$(this).removeClass("hearton");
				$(this).addClass("heart");
				$(this).attr("src", "${pageContext.request.contextPath}/resources/img/heart2.png");
				
				let noticeId = $(this).attr("data");
				
				$("#parent_id").val(noticeId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/deleteLike.json",
    				type : "POST",
    				data : params,
    				success : function(result) {
    					if(result.resultCode == "success"){
    						$(".likeCount"+noticeId).html(result.noticeVO.notice_like_count);
    					}
    				}
    			});
				
			}else{
				$(this).removeClass("heart");
				$(this).addClass("hearton");
				$(this).attr("src", "${pageContext.request.contextPath}/resources/img/heart.png");
				
				let noticeId = $(this).attr("data");
				
				$("#parent_id").val(noticeId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/insertLike.json",
    				type : "POST",
    				data : params,
    				success : function(result) {
    					if(result.resultCode == "success"){
    						$(".likeCount"+noticeId).html(result.noticeVO.notice_like_count);
    					}
    				}
    			});
			}
		});
		
		$(document).on("click", ".bookmark", function(){
			if($(this).hasClass("gray")){
				$(this).removeClass("gray");
				$(this).addClass("pink");
				
				let noticeId = $(this).attr("data");
				
				$("#parent_id").val(noticeId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/insertScrap.json",
    				type : "POST",
    				data : params,
    				success : function(result) {
    					if(result.resultCode == "success"){
    						$(".scrapCount"+noticeId).html(result.noticeVO.notice_scrap_count);
    					}
    				}
    			});
			}else{
				$(this).removeClass("pink");
				$(this).addClass("gray");
				
				let noticeId = $(this).attr("data");
				
				$("#parent_id").val(noticeId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/deleteScrap.json",
    				type : "POST",
    				data : params,
    				success : function(result) {
    					if(result.resultCode == "success"){
    						$(".scrapCount"+noticeId).html(result.noticeVO.notice_scrap_count);
    					}
    				}
    			});
			}
		})
	});
</script>
</head>

<body class="comBg"><!--   -->

<div class="wrap" style="background:#F6F6F6;">

	<div class="areas">
		<header class="header_top h260" style="background:white;">
			<p class="title" style="color:#000;">공지사항</p>
			<a href="${pageContext.request.contextPath}/mobile/mobileMain.do" class="btn_left btn_back" style="z-index:1000;font-size:26px;line-height:80px;padding-left:15px;"><i class="feather icon-arrow-left"></i><em>이전 페이지로 돌아가기</em></a>
		</header>
		<div class="container">
			<form:form id="parameterVO" name="parameterVO">
				<input type="hidden" id="notice_id" name="notice_id" value=""/>
				<input type="hidden" id="parent_id" name="parent_id" value=""/>
				<input type="hidden" id="like_type" name="like_type" value="N"/>
				<input type="hidden" id="scrap_type" name="scrap_type" value="N"/>
			</form:form>
			<div class="noticeList">
				<c:forEach var="noticeList" items="${noticeList}" varStatus="status">
					<fmt:parseDate var="reg_date" value="${noticeList.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    <fmt:parseDate var="updt_date" value="${noticeList.updt_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
					<div class="noticeListItem">
						<span style="padding-left:10px;">${noticeList.notice_title} <c:if test="${noticeList.notice_main == '1'}"><span class="checkNotice">중요</span></c:if></span><div class="noticeListArrow"><i class="contentsArrow feather icon-chevron-down"></i></div>
						<br><span style="padding:10px;line-height:1rem;color:gray;"><fmt:formatDate value="${updt_date}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
						<div class="contentsList">
							<div style="width:90%;margin:0 auto;border-top:1.5px solid #c5c5c5;"></div>
							<div style="padding:20px;">
								${noticeList.notice_contents}
							</div>
							<div style="width:90%;margin:0 auto;border-top:1.5px solid #c5c5c5;"></div>
							<div style="width:100%;height:30px;padding:5px 0px;">
								<div class="noticeListHeart" style="color:gray;font-size:23px;">
									<img src="${pageContext.request.contextPath}/resources/img/heart2.png" class="checkheart heart" data="${noticeList.notice_id}"> 
									<div class="count-class likeCount${noticeList.notice_id}">${noticeList.notice_like_count}</div>
									<div class="bookmark gray" data="${noticeList.notice_id}"><i class="feather icon-bookmark"></i></div> 
									<div class="count-class scrapCount${noticeList.notice_id}">${noticeList.notice_scrap_count}</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div><!-- container -->
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




