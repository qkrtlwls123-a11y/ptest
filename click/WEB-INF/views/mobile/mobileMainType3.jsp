<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="content" id="content2">
	<section class="main_section">
		<article class="slider_area">
			<div style="padding-left:15px;padding-top:20px;color:#000;">
				<p>직장내 성희롱 교육</p>
			</div>
			<c:forEach var="totalList" items="${totalList}" varStatus="status">
			<div style="padding:4%;width:90%;float:left;min-height:180px;">
				
					<div class="sortItem_2" style="width:25%;float:left;padding:2%;" onclick="javascript:fn_goCourse('${totalList.course_id}');return false;">
						<img class="itemImage" src="http://ptest.co.kr/click/file/down/${totalList.course_image1}" alt="" style="border-radius:12px;">
					</div>
					<div class="sortItem_2" style="width:65%;float:left;padding:2%;" onclick="javascript:fn_goCourse('${totalList.course_id}');return false;">
						<div>
							<div class="bannerTitle" style="min-height:3rem;color:#333;">${totalList.course_name}</div>
							<div style="min-height:50px;">
								<div class="bannerProgress">
									<div class="progress progress-sm mt-1 mb-0">
	                                	<div class="progress-bar bg-success" role="progressbar" style="width: 40%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
	                                </div>
	                            </div>
	                            <div class="bannerPercent" style="color:#16d39a;">
									100%
	                            </div>
	                        </div>
	                        <div>
								<p style="min-height:25px;"><i class="fa fa-commenting-o"></i><span style="padding-left:10px;">10</span></p>
	                        </div>
	                        <div>
								<p style="color:#999;">학습 종료일 : ${totalList.end_date}</p>
	                        </div>
						</div>
					</div>
				
			</div>
			</c:forEach>
		</article>
	</section>

</div><!-- content -->
<script type="text/javascript">
	$(document).ready(function(e) {
		
	});
</script>




