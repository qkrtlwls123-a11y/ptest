<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://www.springframework.org/tags/form" prefix="form"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/css/error.css">
<div class="error">
	<img src="resources/images/error/405.png">
	<p>죄송합니다.</p>	
	<p>요청하신 페이지의 권한이 없습니다.</p>	
	<p>궁금한 점이 있으시면 언제든 고객센터를 통해 문의해주시기 바랍니다.</p>
	<div>
		<a href="/">홈으로</a>
		<a href="javascript:history.back()">이전으로</a>
	</div>
</div>