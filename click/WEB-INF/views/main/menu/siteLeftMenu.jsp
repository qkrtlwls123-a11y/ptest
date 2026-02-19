<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

	$(document).ready(function(){
		
	});
	
</script>	
	
	<div class="left-menu">
			<button class="menu-toggle"><spring:message code="click.left.menu.exit"/></button>
			<h1 class="logo-small2" style="background-color:white;"></h1>
			<ul>
				<li class="navi nav01" onclick="javascript:alert('aaaaaaaaaaaa');return false;">
				</li>
				<li class="navi nav02">
					<a href="#" title="회원 관리" >회원 관리</a>
				</li>
				<li class="navi nav09">
					<a href="#" title="학습 관리" >그룹 관리</a>
				</li>
				<li class="navi nav09">
					<a href="#" title="콘텐츠 DB" >콘텐츠 DB</a>
				</li>
				<li class="navi nav09">
					<a href="#" title="콘텐츠 DB" >콘텐츠 DB</a>
				</li>
				<li class="navi nav09">
					<a href="#" title="콘텐츠 DB" >콘텐츠 DB</a>
				</li>
				<li class="navi nav09">
					<a href="#" title="콘텐츠 DB" >콘텐츠 DB</a>
				</li>
				<li class="navi nav09">
					<a href="#" title="콘텐츠 DB" >콘텐츠 DB</a>
				</li>
				<li class="navi nav09">
					<a href="#" title="콘텐츠 DB" >콘텐츠 DB</a>
				</li>
				<li class="navi nav09">
					<a href="#" title="콘텐츠 DB" >콘텐츠 DB</a>
				</li>
				<li class="navi nav09">
					<a href="#" title="콘텐츠 DB" >콘텐츠 DB</a>
				</li>
			</ul>
		</div>
		<!--좌측 네비게이션 - 펼침상태(가로 250px)-->
		<div class="left-menu-open">
			<button class="menu-toggle-close"><spring:message code="click.left.menu.close"/></button>
			<h1 class="logo-full" style="background-color:white;">
				<img src="${pageContext.request.contextPath}/resources/img/click/onionbox_logo.png" alt="site logo"/>
			</h1>
			<dl id="scroll-style01" class="side_wrapper">
				<dt class="navi nav01">		
					<a href="#" title="<spring:message code='click.dashboard'/>"  target="_self" onclick="javascript:fn_changePage('900');return false;">
						<div class="icon-wrap">
							<i></i>
						</div>
						<spring:message code="click.dashboard"/>
					</a>
				</dt>
				<dd style="display:none">
					<a href="#" title="<spring:message code='click.dashboard'/>"  class="nav_sub_font"><spring:message code="click.dashboard"/></a>
				</dd>
				<dt class="navi nav10">
					<a href="#" title="시스템 관리" >
						<div class="icon-wrap">
							<i></i>
						</div>
							회원 관리
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="회원 목록" onclick="javascript:fn_changePage('2')" class="nav_sub_font">· 회원 목록</a>
					<a href="#" title="관리자 설정" onclick="javascript:fn_changePage('4')" class="nav_sub_font">· 탈퇴 요청</a>
				</dd>
				<dt class="navi nav09">		
					<a href="#" title="그룹 관리" >
						<div class="icon-wrap">
							<i></i>
						</div>
						그룹 관리
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="그룹 목록" onclick="javascript:fn_changePage('5')" class="nav_sub_font">· 그룹 목록</a>
					<a href="#" title="속성 목록" onclick="javascript:fn_changePage('6')" class="nav_sub_font">· 속성 목록</a>
				</dd>
				<dt class="navi nav09">		
					<a href="#" title="콘텐츠 DB" >
						<div class="icon-wrap">
							<i></i>
						</div>
						콘텐츠 DB
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="그룹 목록" onclick="javascript:fn_changePage('211')" class="nav_sub_font">· 콘텐츠 목록</a>
					<a href="#" title="스탬프/스티커 관리" onclick="javascript:fn_changePage('10')" class="nav_sub_font">· 퀴즈 목록</a>
				</dd>
				<dt class="navi nav09">		
					<a href="#" title="학습 DB" >
						<div class="icon-wrap">
							<i></i>
						</div>
						학습 DB
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="학습 과정 목록" onclick="javascript:fn_changePage('10')" class="nav_sub_font">· 학습 과정 목록</a>
					<a href="#" title="모듈 목록" onclick="javascript:fn_changePage('13')" class="nav_sub_font">· 모듈 목록</a>
					<a href="#" title="콘텐츠별 의견 목록" onclick="javascript:fn_changePage('15')" class="nav_sub_font">· 콘텐츠별 의견 목록</a>
				</dd>
				<dt class="navi nav09">		
					<a href="#" title="게임" >
						<div class="icon-wrap">
							<i></i>
						</div>
						게임
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="게임 목록" onclick="javascript:fn_changePage('211')" class="nav_sub_font">· 게임 목록</a>
					<a href="#" title="응모권 관리" onclick="javascript:fn_changePage('10')" class="nav_sub_font">· 응모권 관리</a>
				</dd>
				<dt class="navi nav09">
					<a href="#" title="랭킹" >
						<div class="icon-wrap">
							<i></i>
						</div>
						랭킹
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="과정별 랭킹 목록" onclick="javascript:fn_changePage('18')" class="nav_sub_font">· 과정별 랭킹</a>
				</dd>
				<dt class="navi nav09">
					<a href="#" title="메시지" >
						<div class="icon-wrap">
							<i></i>
						</div>
						메시지
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="과정별 랭킹 목록" onclick="javascript:fn_changePage('211')" class="nav_sub_font">· PUSH 발송</a>
					<a href="#" title="과정별 랭킹 목록" onclick="javascript:fn_changePage('211')" class="nav_sub_font">· 이메일 발송</a>
				</dd>
				<dt class="navi nav09">
					<a href="#" title="메시지" >
						<div class="icon-wrap">
							<i></i>
						</div>
						게시판
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="공지사항" onclick="javascript:fn_changePage('21')" class="nav_sub_font">· 공지사항</a>
					<a href="#" title="1:1문의" onclick="javascript:fn_changePage('22')" class="nav_sub_font">· 1:1문의</a>
					<a href="#" title="커뮤니티" onclick="javascript:fn_changePage('23')" class="nav_sub_font">· 커뮤니티</a>
				</dd>
				<dt class="navi nav09">
					<a href="#" title="진단관리" >
						<div class="icon-wrap">
							<i></i>
						</div>
						진단관리
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="공지사항" onclick="javascript:fn_changePage('211')" class="nav_sub_font">· 진단관리</a>
				</dd>
				<dt class="navi nav09">
					<a href="#" title="메시지" >
						<div class="icon-wrap">
							<i></i>
						</div>
						사이트 설정
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="공지사항" onclick="javascript:fn_changePage('25')" class="nav_sub_font">· 관리자 설정</a>
					<a href="#" title="1:1문의" onclick="javascript:fn_changePage('211')" class="nav_sub_font">· PUSH 설정</a>
					<a href="#" title="1:1문의" onclick="javascript:fn_changePage('211')" class="nav_sub_font">· 팝업 설정</a>
					<a href="#" title="1:1문의" onclick="javascript:fn_changePage('26')" class="nav_sub_font">· 이미지 관리</a>
					<a href="#" title="1:1문의" onclick="javascript:fn_changePage('27')" class="nav_sub_font">· 캐릭터 관리</a>
					<a href="#" title="1:1문의" onclick="javascript:fn_changePage('211')" class="nav_sub_font">· 정책 관리</a>
					<a href="#" title="1:1문의" onclick="javascript:fn_changePage('211')" class="nav_sub_font">· 시스템 설정</a>
				</dd>
			</dl>
		</div>
