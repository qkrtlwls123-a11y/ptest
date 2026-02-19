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
	var timeListTotal = 0;
	var resultListTotal = 0;
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
		
		if('' == '${timeListTotal}'){
			timeListTotal = 0;
		}else{
			timeListTotal = parseInt('${timeListTotal}');	
		}
		
		if('' == '${resultListTotal}'){
			resultListTotal = 0;
		}else{
			resultListTotal = parseInt('${resultListTotal}');	
		}
		
		var checkPercent = 0;
		if(resultListTotal != 0){
			checkPercent = timeListTotal/resultListTotal*100;
		}
		
		if(checkPercent == "NaN"){
			checkPercent = 0;
		}
		
		$("#percentArea").html(checkPercent+"%");
		
		$("#percentBar").css("width", checkPercent+"%");
	});
	
	function fn_tab(idx){
		if(idx == 1){
			
		}else if(idx == 2){
			
		}else if(idx == 3){
			
		}else if(idx == 4){
			
		}else if(idx == 5){
		}
	}
	
	function fn_start(idx, idx2, idx3){
		var memberEmail = '${memberSessionVO.member_email}';
		$("#course_id").val(idx);
		$("#contents_id").val(idx2);
		$("#contents_detail_id").val(idx3);
		if(null == $("#contents_id").val() || "" == $("#contents_id").val()){
			$(".courseContentsCircle").each(function(i){
				if(i==0){
					idx2 = $(this).attr("data");
				}
			})
			
			var params = $("form[name=memberVO]").serialize();
			$.ajax({
				url : "/click/mobile/updateContentsTime.json",
				data: params,
				type : "POST",
				success : function(result) {
					location.href="${pageContext.request.contextPath}/mobile/contentsDetail.do?course_id="+idx+"&contents_id="+idx2+"&contents_detail_id="+idx3;
				}
			});
		}else{
			var params = $("form[name=memberVO]").serialize();
			$.ajax({
				url : "/click/mobile/updateContentsTime.json",
				data: params,
				type : "POST",
				success : function(result) {
					location.href="${pageContext.request.contextPath}/mobile/contentsDetail.do?course_id="+idx+"&contents_id="+idx2+"&contents_detail_id="+idx3;
				}
			});
		}
		
	}
</script>
</head>

<body class="comBg" style="height:100%;"><!--   -->

<div class="wrap" style="background:#F6F6F6;">
	<form name="memberVO" id="memberVO">
		<input type="hidden" name="course_id" id="course_id" value="${memberTimeVO.course_id}"/>
		<input type="hidden" name="contents_id" id="contents_id" value="${memberTimeVO.contents_id}"/>
		<input type="hidden" name="contents_detail_id" id="contents_detail_id" value="${memberTimeVO.contents_detail_id}"/>
		<input type="hidden" name="member_email" id="member_email" value="${memberSessionVO.member_email}"/>
     </form>

	<div class="areas">
		<header class="header_top h260">
			<a href="${pageContext.request.contextPath}/mobile/mobileMain.do" class="btn_left btn_back" style="z-index:1000;font-size:26px;line-height:80px;padding-left:15px;"><i class="feather icon-arrow-left"></i><em>이전 페이지로 돌아가기</em></a>
		</header>
		<div class="container">
			<div class="item" style="position:relative;">
				<img class="itemImage" src="http://ptest.co.kr/click/file/down/${parameterVO.course_image2}" alt="">
				<div class="courseContents" style="width:100%;">
					<div class="courseTitle">${parameterVO.course_text}</div>
					<div class="courseProgressArea">
						<div class="bannerProgress">
							<div class="progress progress-sm mt-1 mb-0">
                            	<div class="progress-bar bg-success" id="percentBar" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                        <div class="bannerPercent" id="percentArea">
							
                        </div>
                    </div>
                    <div style="padding-left:10px;clear:both;">
						<p style="min-height:25px;"><i class="fa fa-commenting-o"></i><span style="padding-left:10px;font-size:12px;">0</span>&nbsp;&nbsp;&nbsp;<span style="padding-left:10px;font-size:12px;color:#999;">학습인원 : </span><span style="padding-left:10px;font-size:12px;">1</span>&nbsp;&nbsp;&nbsp;<span style="padding-left:10px;font-size:12px;color:#999;">완료인원 : </span><span style="padding-left:10px;font-size:12px;">0</span></p>
                    </div>
                    <div style="padding-left:10px;font-size:12px;">
						<p style="color:#999;">학습 기간</p>
                    </div>
                    <div style="padding-left:10px;font-size:12px;">
						<p style="color:#999;"><fmt:parseDate var="start_date" value="${parameterVO.start_date}" pattern="yyyy-MM-dd HH:mm:ss"/><fmt:formatDate value="${start_date}" pattern="yyyy-MM-dd" /> 12:00 ~ <fmt:parseDate var="end_date" value="${parameterVO.end_date}" pattern="yyyy-MM-dd HH:mm:ss"/><fmt:formatDate value="${end_date}" pattern="yyyy-MM-dd" /> 10:00</p>
                    </div>
				</div>
			</div>
			<div style="width:100%;padding-top:20px;background:white;">
				<div class="courseTab on">목차</div>
				<div class="courseTab">의견</div>
				<div class="courseTab">개인활동</div>
				<div class="courseTab">동료추천</div>
			</div>
			<div class="courseContentsList">
				<c:forEach var="courseList" items="${courseList}">
					<div class="courseContentsListItem">
						<span style="padding-left:10px;">${courseList.contents.contents_name}</span><div class="courseContentsListArrow"><i class="contentsArrow feather icon-chevron-down"></i></div>
						<div class="contentsList">
							<div style="width:90%;margin:0 auto;border-top:1.5px solid #c5c5c5;"></div>
							<ul>
								<c:forEach var="contentsList" items="${courseList.contents_list}">
									<c:if test="${memberTimeVO.contents_detail_id == contentsList.contents_detail_id && memberTimeVO.contents_id == contentsList.contents_id}">
										<li><div class="courseContentsCircle on" data="${contentsList.contents_id}" onclick="javascript:fn_start('${parameterVO.course_id}', '${contentsList.contents_id}', '${contentsList.contents_detail_id}');return false;">${contentsList.contents_detail_id}</div></li>
									</c:if>
									<c:if test="${memberTimeVO.contents_detail_id != contentsList.contents_detail_id && memberTimeVO.contents_id != contentsList.contents_id}">
										<c:if test="${contentsList.contents_people == 'Y'}">
											<li><div class="courseContentsCircle check" data="${contentsList.contents_id}" onclick="javascript:fn_start('${parameterVO.course_id}', '${contentsList.contents_id}', '${contentsList.contents_detail_id}');return false;">${contentsList.contents_detail_id}</div></li>
										</c:if>
										<c:if test="${contentsList.contents_people != 'Y'}">
											<li><div class="courseContentsCircle" data="${contentsList.contents_id}" onclick="javascript:fn_start('${parameterVO.course_id}', '${contentsList.contents_id}', '${contentsList.contents_detail_id}');return false;">${contentsList.contents_detail_id}</div></li>
										</c:if>
									</c:if>
									<c:if test="${memberTimeVO.contents_detail_id != contentsList.contents_detail_id && memberTimeVO.contents_id == contentsList.contents_id}">
										<c:if test="${contentsList.contents_people == 'Y'}">
											<li><div class="courseContentsCircle check" onclick="javascript:fn_start('${parameterVO.course_id}', '${contentsList.contents_id}', '${contentsList.contents_detail_id}');return false;">${contentsList.contents_detail_id}</div></li>
										</c:if>
										<c:if test="${contentsList.contents_people != 'Y'}">
											<li><div class="courseContentsCircle" data="${contentsList.contents_id}" onclick="javascript:fn_start('${parameterVO.course_id}', '${contentsList.contents_id}', '${contentsList.contents_detail_id}');return false;">${contentsList.contents_detail_id}</div></li>
										</c:if>
									</c:if>
									<c:if test="${memberTimeVO.contents_detail_id == contentsList.contents_detail_id && memberTimeVO.contents_id != contentsList.contents_id}">
										<c:if test="${contentsList.contents_people == 'Y'}">
											<li><div class="courseContentsCircle check" data="${contentsList.contents_id}" onclick="javascript:fn_start('${parameterVO.course_id}', '${contentsList.contents_id}', '${contentsList.contents_detail_id}');return false;">${contentsList.contents_detail_id}</div></li>
										</c:if>
										<c:if test="${contentsList.contents_people != 'Y'}">
											<li><div class="courseContentsCircle" data="${contentsList.contents_id}" onclick="javascript:fn_start('${parameterVO.course_id}', '${contentsList.contents_id}', '${contentsList.contents_detail_id}');return false;">${contentsList.contents_detail_id}</div></li>
										</c:if>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</div>
				</c:forEach>
			</div>
		</div><!-- container -->
		<footer>
			<div class="foot_area">
				<ul class="foot_menu">
					<li><a href="#" class="footerMenu" onclick="javascript:fn_start('${parameterVO.course_id}', '${memberTimeVO.contents_id}', '${memberTimeVO.contents_detail_id}');return false;"><em>학습하기</em></a></li>
				</ul>
			</div>
		</footer>
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




