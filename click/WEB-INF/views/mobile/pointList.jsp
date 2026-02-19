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
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/mobile/css/ranking.css" />
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
				
				let rankingId = $(this).attr("data");
				
				$("#parent_id").val(rankingId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/deleteLike.json",
    				type : "POST",
    				data : params,
    				success : function(result) {
    					if(result.resultCode == "success"){
    						$(".likeCount"+rankingId).html(result.rankingVO.ranking_like_count);
    					}
    				}
    			});
				
			}else{
				$(this).removeClass("heart");
				$(this).addClass("hearton");
				$(this).attr("src", "${pageContext.request.contextPath}/resources/img/heart.png");
				
				let rankingId = $(this).attr("data");
				
				$("#parent_id").val(rankingId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/insertLike.json",
    				type : "POST",
    				data : params,
    				success : function(result) {
    					if(result.resultCode == "success"){
    						$(".likeCount"+rankingId).html(result.rankingVO.ranking_like_count);
    					}
    				}
    			});
			}
		});
		
		$(document).on("click", ".bookmark", function(){
			if($(this).hasClass("gray")){
				$(this).removeClass("gray");
				$(this).addClass("pink");
				
				let rankingId = $(this).attr("data");
				
				$("#parent_id").val(rankingId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/insertScrap.json",
    				type : "POST",
    				data : params,
    				success : function(result) {
    					if(result.resultCode == "success"){
    						$(".scrapCount"+rankingId).html(result.rankingVO.ranking_scrap_count);
    					}
    				}
    			});
			}else{
				$(this).removeClass("pink");
				$(this).addClass("gray");
				
				let rankingId = $(this).attr("data");
				
				$("#parent_id").val(rankingId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/deleteScrap.json",
    				type : "POST",
    				data : params,
    				success : function(result) {
    					if(result.resultCode == "success"){
    						$(".scrapCount"+rankingId).html(result.rankingVO.ranking_scrap_count);
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

	<div class="areas" style="background:white;">
		<header class="header_top h260" style="background:white;">
			<p class="title" style="color:#000;">게임</p>
			<a href="${pageContext.request.contextPath}/mobile/mobileMain.do" class="btn_left btn_back" style="z-index:1000;font-size:26px;line-height:80px;padding-left:15px;"><i class="feather icon-arrow-left"></i><em>이전 페이지로 돌아가기</em></a>
		</header>
		<div class="container" style="background:#F6F6F6;">
			<div class="rankingList ranker-area">
				<div style="width:100%;text-align:center;line-height:2rem;margin:0 auto;padding:20px 0;margin-bottom:10px;background:white;">
					<p style="color:#FFA63D;font-size:18px;">${pointVO.member_point} P</p>
					<p style="color:#999;font-size:14px;">마일리지</p>
				</div>
				<div class="rankingListItem" style="border-top:1px solid #F6F6F6;">
					<div style="padding-left:20px;font-size:16px;color:black;width:100%;">마일리지 내역</div>
				</div>
				<c:if test="${fn:length(pointList) > 0}">
					
					<c:forEach var="pointList" items="${pointList}" varStatus="status">
						<div class="rankingListItem">
							<c:if test="${pointList.get_point > 0}">
								<div class="rankingName" style="color:#789BFF;padding-left:20px;">${pointList.point_type}</div>
							</c:if>
							<c:if test="${pointList.get_point < 0}">
								<div class="rankingName" style="color:#FC739E;padding-left:20px;">${pointList.point_type}</div>
							</c:if>
							<div class="rankingPoint">${pointList.get_point}P</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(pointList) == 0}">
					<div class="no-ranker">마일리지 내역이 없습니다.</div>
				</c:if>
			</div>
		</div><!-- container -->
	</div><!-- areas -->
</div><!-- wrap -->
<div class="popup popup_ranking" id="popup_01">
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




