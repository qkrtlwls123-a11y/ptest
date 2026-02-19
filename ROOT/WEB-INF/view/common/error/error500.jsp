<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://www.springframework.org/tags/form" prefix="form"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/css/error.css">
<div class="error">
	<img src="/resources/images/error/500.png">
	<p>현재 서버에 오류가 생겨 요청을 처리하지 못하였습니다.</p>
	<p>새로고침 하여 다시 시도해 보거나 잠시 후 이용해 주십시오.</p>
	<p>궁금한 점이 있으시면 언제든 고객센터를 통해 문의해주시기 바랍니다.</p>
	<div>
		<a href="/">홈으로</a>
		<a href="javascript:history.back()">이전으로</a>
	</div>
</div>