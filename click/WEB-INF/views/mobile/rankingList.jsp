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
	
	function fn_goRanker(){
		location.href="${pageContext.request.contextPath}/mobile/rankerList.do";
	}
</script>
</head>

<body class="comBg"><!--   -->

<div class="wrap" style="background:#F6F6F6;">

	<div class="areas" style="background:white;">
		<header class="header_top h260" style="background:white;">
			<p class="title" style="color:#000;">랭킹</p>
			<a href="${pageContext.request.contextPath}/mobile/mobileMain.do" class="btn_left btn_back" style="z-index:1000;font-size:26px;line-height:80px;padding-left:15px;"><i class="feather icon-arrow-left"></i><em>이전 페이지로 돌아가기</em></a>
		</header>
		<div class="container">
			<form:form id="parameterVO" name="parameterVO">
				<input type="hidden" id="ranking_id" name="ranking_id" value=""/>
				<input type="hidden" id="parent_id" name="parent_id" value=""/>
				<input type="hidden" id="like_type" name="like_type" value="N"/>
				<input type="hidden" id="scrap_type" name="scrap_type" value="N"/>
			</form:form>
			<div class="rankerArea" style="justify-content:flex-end;">
				<span class="btn-ranker" onclick="javascript:fn_goRanker();return false;">명예의 전당</span><div class="icon-ranker"><img src="${pageContext.request.contextPath}/resources/mobile/images/ranker.png" alt="명예의 전당"/></div>
			</div>
			<div class="rankingList">
				<c:forEach var="rankingList" items="${rankingList}" varStatus="status">
					<c:if test="${memberSessionVO.member_email == rankingList.member_email}">
						<div class="rankingListItem atMe">
							<div class="rankingLeftArea">
								<div class="rankingNo">${status.count}</div>
								<div class="rankingProfile">
									<span class="photo">
										<c:if test="${rankingList.member_profile == null || rankingList.member_profile == ''}">
											<img src="${pageContext.request.contextPath}/resources/mobile/images/profile.png" alt="프로필 이미지">
										</c:if>
										<c:if test="${rankingList.member_profile != null && rankingList.member_profile != ''}">
											<img src="http://ptest.co.kr/click/file/down/${rankingList.member_profile}" alt="프로필 이미지">
										</c:if>
									</span>
								</div>
								<div class="rankingName">${rankingList.member_name}</div>
							</div>
							<div class="rankingPoint">${rankingList.member_point}P</div>
						</div>
					</c:if>
				</c:forEach>
				<c:forEach var="rankingList" items="${rankingList}" varStatus="status">
					<div class="rankingListItem">
						<div class="rankingLeftArea">
							<div class="rankingNo">
								<c:if test="${status.count == '1'}">
									<img src="${pageContext.request.contextPath}/resources/mobile/images/rank1.png" alt="프로필 이미지">
								</c:if>
								<c:if test="${status.count == '2'}">
									<img src="${pageContext.request.contextPath}/resources/mobile/images/rank2.png" alt="프로필 이미지">
								</c:if>
								<c:if test="${status.count == '3'}">
									<img src="${pageContext.request.contextPath}/resources/mobile/images/rank3.png" alt="프로필 이미지">
								</c:if>
								<c:if test="${status.count != '1' && status.count != '2' && status.count != '3'}">
									${status.count}
								</c:if>
							</div>
							<div class="rankingProfile">
								<span class="photo">
									<c:if test="${rankingList.member_profile == null || rankingList.member_profile == ''}">
										<img src="${pageContext.request.contextPath}/resources/mobile/images/profile.png" alt="프로필 이미지">
									</c:if>
									<c:if test="${rankingList.member_profile != null && rankingList.member_profile != ''}">
										<img src="http://ptest.co.kr/click/file/down/${rankingList.member_profile}" alt="프로필 이미지">
									</c:if>
								</span>
							</div>
							<div class="rankingName">${rankingList.member_name}</div>
						</div>
						<div class="rankingPoint">${rankingList.member_point}P</div>
					</div>
				</c:forEach>
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




