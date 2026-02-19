<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript">
	$(function(){
		$('.closeBtn').focus();
		// CCTV
	})
	</script>
	<dl id="alertPopupArea" class="pop-main-style01">
				<dt style="background-color:var(--main-bg-color);">선택</dt>
				<dd>
					<div type="button" class="btn" style="width:100px;height:100px;border:2px solid var(--main-bg-color);background:white;" onclick="javascript:fn_selectRoulette();">
						<img src="${pageContext.request.contextPath}/resources/editor/images/roulette.png" style="width:40px;height:40px;">
						<br>
						<br>
						룰렛게임
					</div>
					<div type="button" class="btn" style="width:100px;height:100px;border:2px solid var(--main-bg-color);background:white;"  onclick="javascript:fn_selectQuiz();">
						<img src="${pageContext.request.contextPath}/resources/editor/images/quiz.png" style="width:40px;height:40px;">
						<br>
						<br>
						퀴즈
					</div>
				</dd>
			</dl>
