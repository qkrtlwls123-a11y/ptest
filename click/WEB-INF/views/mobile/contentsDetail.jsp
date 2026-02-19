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
	let touch = false;
	var nowTime = 0;
	
	let timerId = setInterval(fn_addTime, 1000);
	
	function fn_addTime(){
		nowTime++;
		console.log(nowTime);
	}
	
	$(window).scroll(function(){
	   if($(window).scrollTop() == $(document).height() - $(window).height()){
		   $("#nextIcon").removeClass("hiddenObj");
		   if(parseInt($("#contents_detail_id").val()) != 1){
			   $("#prevIcon").removeClass("hiddenObj");
		   }
	   }
	}); 
	
	$(document).ready(function(e) {	
		
		$(document).on("click", ".pageContainer", function(e){
			if(!touch){
				touch = true;
				$("#footer1").show();
				$("#header").show();
				$("#nextIcon").removeClass("hiddenObj");
				$("#prevIcon").removeClass("hiddenObj");
			}else{
				touch = false;
				$("#footer1").hide();
				$("#header").hide();
				$("#footer2").hide();
				$("#nextIcon").addClass("hiddenObj");
				$("#prevIcon").addClass("hiddenObj");
			}
		});
		
		$(document).on("click", "#pageCount", function(e){
			touch = true;
			$("#footer1").hide();
			$("#footer2").show();
		});
		
	});
	
	function nextMove() {
		
		var nextPage = parseInt($("#contents_detail_id").val())+1;
		var totalPage = parseInt('${totalCnt}');
		var contentsId = $("#contents_id").val();
		
		if(nextPage > totalPage){
			
		}else{
			clearTimeout(timerId);
			location.href="${pageContext.request.contextPath}/mobile/contentsDetail.do?contents_id="+contentsId+"&contents_detail_id="+nextPage;
		}
		
	}
	
	function prevMove() {
		var nowPage = parseInt($("#contents_detail_id").val());
		var totalPage = parseInt('${totalCnt}');
		var contentsId = $("#contents_id").val();
		
		if(nowPage == 1){
			
		}else{
			clearTimeout(timerId);
			var prePage = nowPage-1;
			location.href="${pageContext.request.contextPath}/mobile/contentsDetail.do?contents_id="+contentsId+"&contents_detail_id="+prePage;
			
		}
	}
		
	function goPage(idx) {
		var courseId = $("#course_id").val();
		var contentsId = $("#contents_id").val();
		var checkTime = nowTime;
		
		$("#history_time").val(checkTime);
		
		var params = $("form[name=memberVO]").serialize();
		$.ajax({
			url : "/click/mobile/updateContentsTime.json",
			data: params,
			type : "POST",
			success : function(result) {
				clearTimeout(timerId);
				location.href="${pageContext.request.contextPath}/mobile/contentsDetail.do?course_id="+courseId+"&contents_id="+contentsId+"&contents_detail_id="+idx;
			}
		});
	}
	
	function fn_course(idx, idx2){
		var courseId = $("#course_id").val();
		var contentsId = $("#contents_id").val();
		var checkTime = nowTime;
		
		$("#history_time").val(checkTime);
		
		var params = $("form[name=memberVO]").serialize();
		$.ajax({
			url : "/click/mobile/updateContentsTime.json",
			data: params,
			type : "POST",
			success : function(result) {
				clearTimeout(timerId);
				location.href="${pageContext.request.contextPath}/mobile/course.do?course_id="+courseId+"&contents_id="+idx+"&contents_detail_id="+idx2;
			}
		});
	}
	
	function fn_bookmark(){
		if($("#bookmark").hasClass("white")){
			$("#bookmark").removeClass("white");
			$("#bookmark").addClass("pink");
		}else{
			$("#bookmark").removeClass("pink");
			$("#bookmark").addClass("white");
		}
	}
</script>
</head>

<body class="comBg" style="height:100%;"><!--   -->

<div class="wrap">

	<div class="areas" style="">
		<form name="memberVO" id="memberVO">
			<input type="hidden" id="course_id" name="course_id" value="${parameterVO.course_id}">
			<input type="hidden" id="contents_id" name="contents_id" value="${parameterVO.contents_id}">
			<input type="hidden" id="contents_detail_id" name="contents_detail_id" value="${parameterVO.contents_detail_id}">
			<input type="hidden" id="history_time" name="history_time" value="${memberTimeVO.history_time}">
			<input type="hidden" name="member_email" id="member_email" value="${memberSessionVO.member_email}"/>
		</form>
		
		<header class="header_top h260" id="header" style="background:#000!important;opacity:0.7;display:none;">
			<p class="title" style="color:#fff;text-align:left;font-size:14px;">${parameterVO.contents_name}</p>
			<a href="#" onclick="javascript:fn_course('${parameterVO.contents_id}', '${parameterVO.contents_detail_id}');return false;" class="btn_left btn_back" style="z-index:1000;font-size:26px;line-height:80px;padding-left:15px;color:#fff;"><i class="fa fa-times"></i><em>닫기</em></a>
			<a href="#" onclick="javascript:fn_bookmark();return false;" id="bookmark" class="btn_right btn_back white" style="z-index:1000;font-size:26px;line-height:80px;padding-left:15px;"><i class="feather icon-bookmark"></i><em>북마크</em></a>
		</header>
		<div class="pageContainer slide" style="min-height:100vh;user-select:none;max-width:100%;">
			<c:import url="/editorPage.do?contents_id=${parameterVO.contents_id}&contents_detail_id=${parameterVO.contents_detail_id}"/>
		</div><!-- container -->
		<div>
			<div id="nextIcon" class="hiddenObj" onclick="javascript:nextMove();return false;" style="position: fixed;width: 35px;height: 40px;background: black;top: 45%;right: 0;color: white;text-align: center;font-size: 28px;opacity:0.6;">></div>
			<div id="prevIcon" class="hiddenObj" onclick="javascript:prevMove();return false;" style="position: fixed;width: 35px;height: 40px;background: black;top: 45%;left: 0;color: white;text-align: center;font-size: 28px;opacity:0.6;"><</div>
		</div>
		<footer>
			<div class="page_footer" id="footer1" style="background:black;border-top:1px solid #eeeeee;">
				<div style="left:20px;position:absolute;font-size:20px;bottom:14px;color:#fff;"><i class="fa fa-commenting-o"></i>&nbsp;&nbsp;<span style="font-size:12px;">의견</span>&nbsp;<span style="font-size:12px;color:#fff;font-weight:bold;">2</span></div>
				<div style="right:20px;position:absolute;font-size:12px;bottom:14px;color:#fff;" id="pageCount">${parameterVO.contents_detail_id}/${totalCnt}</div>
			</div>
			<div class="page_footer" id="footer2" >
				<div>
					<ul style="display: flex;align-content: normal;overflow: scroll;">
						<c:forEach var="resultList" items="${resultList}">
							<c:if test="${parameterVO.contents_detail_id == resultList.contents_detail_id}">
								<li><div class="courseContentsCircle on" onclick="javascript:goPage('${resultList.contents_detail_id}');return false;">${resultList.contents_detail_id}</div></li>
							</c:if>
							<c:if test="${parameterVO.contents_detail_id != resultList.contents_detail_id}">
								<li><div class="courseContentsCircle" onclick="javascript:goPage('${resultList.contents_detail_id}');return false;">${resultList.contents_detail_id}</div></li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
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
<!-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/checkSlide.js"></script> -->

</body>
</html>




