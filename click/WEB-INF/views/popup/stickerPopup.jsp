<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
</script>
	<dl class="pop-style01" style="margin-top:300px;width:340px;color:white;">
				<dt style="background-color:var(--main-bg-color);">스티커 등록</dt>
				<dd style="height:440px;text-align:center;background-color:white;">
					<div style="width:300px;float:left;background-color:white;color:black;">
						<div style="width:100%;height:400px;border:1px solid #DEE2E6;border-radius:15px;font-size: 0.8rem">
							<div style="width:100%;height:200px;border-bottom:1px solid #DEE2E6;text-align:center;line-height:200px;">
								<img src="${pageContext.request.contextPath}/resources/img/click/sticker.png" alt="stampImage"/>
							</div>
							<div class="stamp-left">스티커 명</div>
							<div class="stamp-right"><input type="text" style="width: 100px;text-align:center;" placeholder="스티커 명 입력" id="" name=""></div>
							<div class="stamp-left">획득 조건</div>
							<div class="stamp-right"><input type="text" style="width: 100px;text-align:center;" placeholder="의견 수" id="" name="">개</div>
							<div class="stamp-left">마일리지 보상</div>
							<div class="stamp-right"><input type="text" style="width: 100px;text-align:center;" placeholder="마일리지 입력" id="" name="">포인트</div>
							<div class="stamp-left" style="border-bottom:0px;">메모</div>
							<div class="stamp-right" style="border-bottom:0px;"><input type="text" style="width: 100px;text-align:center;" placeholder="메모 입력" id="" name=""></div>
						</div>
					</div>
				</dd>
				<button type="button" class="re-applyBtn" onclick="javascript:fn_closePopup();return false;">등록</button>
				<button class="cancelBtn" onclick="javascript:fn_closePopup();return false;"><spring:message code="click.cancel"/></button>
			</dl>
