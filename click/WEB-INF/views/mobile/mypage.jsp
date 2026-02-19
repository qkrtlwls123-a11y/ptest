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
<script type="text/javascript">
	$(document).ready(function(e) {	
		$(".memberComment").focusout(function(){
			
			$("#member_comment").val($(this).val());
			var params = $("form[name=parameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/mobile/updateMemberComment.json",
				type : "POST",
				data : params,
				success : function(result) {
					
				}
			});
		});
		
	});
	
	function fn_profilePopup(){
		var memberId = '${memberVO.member_id}';
		$("#popup_profile").bPopup({
			amsl : 0
			, modal : true
			, opacity : 0.6
			, modalClose : true
			, follow : [true, false]
			, followSpeed: 1000
			, onOpen : function() {
			}
			, onClose : function() {

			}
		}, function() {

		});
	}
	
	
</script>
</head>

<body class="comBg"><!--   -->

<div class="wrap">

	<div class="areas">
		<header class="header_top h260">
			<p class="title" style="color:#000;">마이 페이지</p>
			<a href="${pageContext.request.contextPath}/mobile/mobileMain.do" class="btn_left btn_back" style="z-index:1000;font-size:26px;line-height:80px;padding-left:15px;"><i class="feather icon-arrow-left"></i><em>이전 페이지로 돌아가기</em></a>
		</header>

		<div class="container">
			<div class="content" id="content">

				<section class="my_section">
					<form:form  name="parameterVO" commandName="parameterVO" id="parameterVO" method="post">
						<input type="hidden" id="petstory_id" name="petstory_id" value="">
						<input type="hidden" id="pet_no" name="pet_no" value="">
						<input type="hidden" id="member_comment" name="member_comment" value="${resultVO.member_comment}"/>
					</form:form>
					<article class="top_area">
						<div class="photo_area">
							<span class="photo">
								<c:if test="${resultVO.member_profile == null || resultVO.member_profile == ''}">
									<img src="${pageContext.request.contextPath}/resources/mobile/images/profile.png" alt="프로필 이미지">
								</c:if>
								<c:if test="${resultVO.member_profile != null && resultVO.member_profile != ''}">
									<img src="http://ptest.co.kr/click/file/down/${resultVO.member_profile}" alt="프로필 이미지">
								</c:if>
							</span>
						</div>
						<button class="btn_edit" onclick="javascript:fn_profilePopup();return false;">편집</button>
						<p class="name">${memberSessionVO.member_name} 님</p>
					</article>

					<article class="counting_area">
						<div class="count_box clearfix">
							<input type="text" class="form-control form-control-sm memberComment" placeholder="나의 한마디를 입력해 주세요." value="${resultVO.member_comment}" aria-controls="users-list-datatable" style="border:0;color:#999;text-align:center;width:100%;line-height:2.5rem;background-color:#F6F6F6;ime-mode:active;">
						</div>
						<p class="name" style="text-align:center;color:#666;padding:10px 0;">${memberSessionVO.member_email}</p>
						<p class="name" style="text-align:center;color:#999;">${siteSessionVO.company_name}</p>
					</article>

					<article class="info_box">
						<div style="width:80%;margin:0 auto;">
							<div style="width:25%;float:left;text-align:center;line-height:2rem;">
								<p style="color:#FC739E;font-size:16px;">
									<c:if test="${resultVO.member_ranking == 'rank'}">
										<div style="width:19px;margin:0 auto;">
											<img src="${pageContext.request.contextPath}/resources/mobile/images/rank.png" alt="명예의 전당">
										</div>
									</c:if>
									<c:if test="${resultVO.member_ranking == ''}">
										-
									</c:if>
									<c:if test="${resultVO.member_ranking != 'rank' && resultVO.member_ranking != ''}">
										${resultVO.member_ranking}
									</c:if>
								</p>
								<p style="color:#999;font-size:12px;">랭킹</p>
							</div>
							<div style="width:25%;float:left;text-align:center;line-height:2rem;">
								<p style="color:#FFA63D;font-size:16px;">${resultVO.member_point}P</p>
								<p style="color:#999;font-size:12px;">마일리지</p>
							</div>
							<div style="width:25%;float:left;text-align:center;line-height:2rem;">
								<p style="color:#789BFF;font-size:16px;">10</p>
								<p style="color:#999;font-size:12px;">스티커</p>
							</div>
							<div style="width:25%;float:left;text-align:center;line-height:2rem;">
								<p style="color:#B08EFF;font-size:16px;">4</p>
								<p style="color:#999;font-size:12px;">스탬프</p>
							</div>
						</div>
					</article>
					<div style="position:fixed;bottom:0;width:100%;">
						<div style="width:80%;float:right;">
							<img src="${pageContext.request.contextPath}/resources/mobile/images/mypageBack.png" alt="">
						</div>
					</div>
				</section>

			</div><!-- content -->
		</div><!-- container -->

		<footer>
			<c:import url="/mobile/contentsFooter.do"/>
		</footer>

	</div><!-- areas -->
</div><!-- wrap -->
<div class="popup2 popup_profile" id="popup_profile">
	<div style="width:100%;height:60px;line-height:60px;font-size:18px;background-color:white;color:black;border-bottom:1px solid gray;border-top-left-radius: 17px; border-top-right-radius: 17px; ">촬영</div>
	<div style="width:100%;height:60px;line-height:60px;font-size:18px;background-color:white;color:black;border-bottom:1px solid gray;">앨범</div>
	<div style="width:100%;height:60px;line-height:60px;font-size:18px;background-color:white;color:black;border-bottom:1px solid gray;">이미지</div>
	<div style="width:100%;height:60px;line-height:60px;font-size:18px;background-color:white;color:black;border-bottom:1px solid gray;border-bottom-left-radius: 17px; border-bottom-right-radius: 17px;">캐릭터</div>
	<div style="width:100%;height:60px;line-height:60px;font-size:18px;background-color:white;color:black;border-radius:17px;margin-top:10px;" class="b-close">취소</div>
</div>
</body>
</html>




