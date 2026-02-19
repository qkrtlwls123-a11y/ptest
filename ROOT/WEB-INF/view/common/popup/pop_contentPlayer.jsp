<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://www.springframework.org/tags/form" prefix="form"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
page import="java.util.*,kr.co.vitaminsoft.commons.util.CommonUtil" %><%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>

<script type="text/javascript">

	$(document).ready(function(){
		
	});
	//팝업닫기
	function currPopClose(){
		COMM_POPUP.close();
	}
</script>

<c:set var='success' value='${success}'/>

<c:if test='${success == "success"}'>
	<iframe data-video-player-vars='{"wmode": "opaque", "modestbranding": 1, "controls": 1, "showinfo": 0, "autohide": 1, "rel": 0,"enablejsapi":1}' src="https://www.youtube.com/embed/${contentUrl}?modestbranding=1&controls=1&showinfo=0&autohide=1&rel=0&enablejsapi=1origin=https%3A%2F%2Fwww.youtube.com&widgetid=1" width="480" height="300" frameborder="0" style="position:absolute;width:100%;height:100%;left:0" allowfullscreen></iframe>
	<p class="tcenter"><input type="button" value="닫기" onclick="currPopClose()" class="btn_close"/></p>	
</c:if>
<c:if test='${success == "no_content"}'>
	<p>요청하신 콘텐츠는 존재하지 않습니다.</p>
	<p class="tcenter"><input type="button" value="닫기" onclick="currPopClose()" class="btn_close"/></p>
</c:if>
<c:if test='${success == "no_auth"}'>
	<div>
		<p>요청하신 콘텐츠를 볼 수 있는 권한이 없습니다.</p>
		<p class="tcenter"><input type="button" value="닫기" onclick="currPopClose()" class="btn_close"/></p>
	</div>
</c:if>