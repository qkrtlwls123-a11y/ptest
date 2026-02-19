<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
<div id="header" class="topbg">
	<img src="/resources/images/admin/admin_top_logo.png" alt="logo">
	<p class="logout"><a href="javascript:;" onclick="logout()" style="color:white;font-weight:bold;text-decoration:none;">로그아웃</a></p>
	<p class="user"><a href="/" style="color:white;font-weight:bold;text-decoration:none;" target="_blank">검사자페이지</a></p>
	
	<ul id="main-menu">
	<c:choose>
	<c:when test="${fn:contains(adminSession.adminAuth,'S')}">
		<li class="parent">
			<a href="/ka/survey/recruitSurveyList.do">채용공고관리</a>
		</li>
		<li class="parent">
			<a href="/ka/statistics/reportList.do">인성진단 Report</a>
		</li>
		<li class="parent">
			<a href="/ka/statistics/statisticsList.do">진단결과 데이터</a>
		</li>
		<!-- <li class="parent">
			<a href="/ka/statistics/representativeList.do">유사도측정관리</a>
			<ul class="sub-menu">
				<li><a href="/ka/statistics/representativeList.do">대표구성원관리</a></li>
				<li><a href="/ka/statistics/similarList.do">유사구성원관리</a></li>
			</ul>
		</li> -->
		<li class="parent">
			<a href="/ka/survey/surveyList.do">인성진단 문항관리</a>			
		</li>
		<li class="parent">
			<a href="/ka/definition/definitionList.do">정의관리</a>
		</li>
		<!-- <li class="parent last">
			<a href="/ka/code/codeList.do">코드 생성,관리</a>
		</li> -->
		<li class="parent">
			<a href="/ka/user/userList.do">관리자 메뉴</a>
			<ul class="sub-menu">
				<li><a href="/ka/user2/userList.do">재직자 관리</a></li>
				<li><a href="/ka/user/userList.do">담당자 관리</a></li>
			     <li><a href="/ka/code/codeList.do">코드 생성,관리</a></li>
			</ul>
		</li>		
	</c:when>
	<c:when test="${fn:contains(adminSession.adminAuth,'A')}">
		<li class="parent">
			<a href="/ka/survey/recruitSurveyList.do">채용공고관리</a>
		</li>
		<li class="parent">
			<a href="/ka/statistics/reportList.do">인성진단 Report</a>
		</li>
		<li class="parent">
			<a href="/ka/statistics/statisticsList.do">진단결과 데이터</a>
		</li>
		<li class="parent">
			<a href="/ka/user/userList.do">관리자 메뉴</a>
			<ul class="sub-menu">
				<li><a href="/ka/user2/userList.do">재직자 관리</a></li>
				<li><a href="/ka/user/userList.do">담당자 관리</a></li>
				<li><a href="/ka/code/codeList.do">코드 생성,관리</a></li>
			</ul>
		</li>	
	</c:when>
	</c:choose>
	</ul>
</div>