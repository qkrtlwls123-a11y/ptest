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
			<div style="padding:15px;">
				<c:forEach var="totalList" items="${totalList}" varStatus="status">
					<div class="sortItem_2" style="width:46%;float:left;padding:2%;" onclick="javascript:fn_goCourse('${totalList.course_id}');return false;">
						<img class="itemImage" src="http://ptest.co.kr/click/file/down/${totalList.course_image1}" alt="" style="border-radius:12px;">
						<div>
							<div class="bannerTitle">${totalList.course_name}</div>
							<div>
								<div class="bannerProgress">
									<div class="progress progress-sm mt-1 mb-0">
	                                	<div class="progress-bar bg-success" role="progressbar" style="width: 40%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
	                                </div>
	                            </div>
	                            <div class="bannerPercent" style="color:#16d39a;">
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
		
	});
</script>




