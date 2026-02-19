<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="content" id="content2">
	<section class="main_section">
		<article class="slider_area">
			<div style="background-color:#F6F6F6;padding-left:15px;padding-top:20px;color:#000;">
				<p>ONION BOX</p>
			</div>
			<div class="mainSlider" id="slider">
				<c:forEach var="mainList" items="${mainList}" varStatus="status">
					<div class="item" onclick="javascript:fn_goCourse('${mainList.course_id}');return false;">
						<img class="itemImage" src="http://ptest.co.kr/click/file/down/${mainList.course_image2}" alt="">
						<div class="bannerContents">
							<div class="bannerTitle">${mainList.course_name}</div>
							<div class="bannerProgressArea">
								<div class="bannerProgress">
									<div class="progress progress-sm mt-1 mb-0">
	                                       <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
	                                   </div>
	                                  </div>
	                                  <div class="bannerPercent">
									100%
	                                  </div>
	                                 </div>
						</div>
					</div>
				</c:forEach>
			</div>
		</article>
		<article class="slider_area">
			<div style="background-color:#fff;padding-left:15px;padding-top:20px;color:#000;">
				<p>ONION BOX TEST</p>
			</div>
			<div class="mainSlider2" id="slider2">
				<c:forEach var="subList" items="${subList}" varStatus="status">
					<div class="item" onclick="javascript:fn_goCourse('${subList.course_id}');return false;">
						<img class="itemImage2" src="http://ptest.co.kr/click/file/down/${subList.course_image1}" alt="">
						<div class="bannerContents2">
							<div class="bannerTitle2">${subList.course_name}</div>
							<div class="bannerProgressArea2">
								<div class="bannerProgress2">
									<div class="progress progress-sm mt-1 mb-0">
	                                       <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
	                                   </div>
	                                  </div>
	                                  <div class="bannerPercent2">
									100%
	                                  </div>
	                                 </div>
						</div>
					</div>
				</c:forEach>
			</div>
		</article>
		<article class="slider_area">
			<div style="background-color:#fff;padding-left:15px;padding-top:20px;color:#000;">
				<p>ONION BOX CONTENTS</p>
			</div>
			<div class="mainSlider2" id="slider3">
				<c:forEach var="totalList" items="${totalList}" varStatus="status">
					<div class="item" onclick="javascript:fn_goCourse('${totalList.course_id}');return false;">
						<img class="itemImage2" src="http://ptest.co.kr/click/file/down/${totalList.course_image1}" alt="">
						<div class="bannerContents2">
							<div class="bannerTitle2">${totalList.course_name}</div>
							<div class="bannerProgressArea2">
								<div class="bannerProgress2">
									<div class="progress progress-sm mt-1 mb-0">
	                                       <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
	                                   </div>
	                                  </div>
	                                  <div class="bannerPercent2">
									100%
	                                  </div>
	                                 </div>
						</div>
					</div>
				</c:forEach>
			</div>
		</article>
	</section>

</div><!-- content -->
<script type="text/javascript">
	$(document).ready(function(e) {
		var bannerWidth = parseInt($(".item").find(".itemImage").css("width")) - 32;
		$(".bannerContents").css("width", bannerWidth+"px");
		
		var $target = $('#slider');
		$target.slick({
			infinite : true
			, centerMode : true
			, centerPadding: '16px'
			, arrows : false
			, dots : false
			, autoplay : false
			, autoplaySpeed : 7000
			, pauseOnHover : true
			, draggable : true
			, accessibility : false
			, speed : 500
			, cssEase : "ease-out"
			, touchThreshold : 10
		});
		
		var $target2 = $('#slider2');
		$target2.slick({
			infinite : true
			, centerMode : true
			, centerPadding: '16px'
			, slidesToShow : 3
			, arrows : false
			, dots : false
			, autoplay : false
			, autoplaySpeed : 7000
			, pauseOnHover : true
			, draggable : true
			, accessibility : false
			, speed : 500
			, cssEase : "ease-out"
			, touchThreshold : 10
		});
		
		var $target3 = $('#slider3');
		$target3.slick({
			infinite : true
			, centerMode : true
			, centerPadding: '16px'
			, slidesToShow : 3
			, arrows : false
			, dots : false
			, autoplay : false
			, autoplaySpeed : 7000
			, pauseOnHover : true
			, draggable : true
			, accessibility : false
			, speed : 500
			, cssEase : "ease-out"
			, touchThreshold : 10
		});
	});
</script>




