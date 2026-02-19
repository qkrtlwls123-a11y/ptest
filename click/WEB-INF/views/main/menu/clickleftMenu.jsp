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
					<a href="#" title="시스템 관리" >시스템 관리</a>
					<dl class="nav_sub02">
						<dt><a href="#" title="시스템 관리" style="color:white;" class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('2');return false;">시스템 관리</a></dt>
						<dd>
							<a href="#" title="사이트 개설/관리"  onclick="javascript:fn_changePage('2')" class="nav_sub_font">사이트 개설/관리</a>
						</dd>
						<dd>
							<a href="#" title="관리자 설정"  onclick="javascript:fn_changePage('4')" class="nav_sub_font">관리자 설정</a>
						</dd>
					</dl>
				</li>
				<li class="navi nav09">
					<a href="#" title="학습 관리" >학습 관리</a>
					<dl class="nav_sub09">
						<dt><a href="#" title="학습 관리"  onclick="javascript:fn_changePage('11');return false;">학습 관리</a></dt>
						<dd>
							<a href="#" title="콘텐츠 관리"  class="nav_sub_font" onclick="javascript:fn_changePage('10');return false;">콘텐츠 DB</a>
							<ul class="nav_sub_dept">
								<li><a href="#" title="관리자용 콘텐츠"  onclick="javascript:fn_changePage('11');return false;">· 관리자용 콘텐츠</a></li>
								<li><a href="#" title="고객사용 콘텐츠"  onclick="javascript:fn_changePage('10');return false;">· 고객사용 콘텐츠</a></li>
								<li><a href="#" title="분류 관리"  onclick="javascript:fn_changePage('10');return false;">· 분류 관리</a></li>
								<li><a href="#" title="퀴즈 관리"  onclick="javascript:fn_changePage('10');return false;">· 퀴즈 관리</a></li>
							</ul>
						</dd>
						<dd>
							<a href="#" title="스탬프/스티커 관리"  class="nav_sub_font" onclick="javascript:fn_changePage('7');return false;">스탬프/스티커 관리</a>
							<ul class="nav_sub_dept">
								<li><a href="#" title="스탬프 관리"  onclick="javascript:fn_changePage('10');return false;">· 스탬프 관리</a></li>
								<li><a href="#" title="스티커 관리"  onclick="javascript:fn_changePage('12');return false;">· 스티커 관리</a></li>
							</ul>
						</dd>
					</dl>
				</li>
				<li class="navi nav09">
					<a href="#" title="학습 관리" >학습 관리</a>
					<dl class="nav_sub09">
						<dt><a href="#" title="학습 관리"  onclick="javascript:fn_changePage('11');return false;">학습 관리</a></dt>
						<dd>
							<a href="#" title="콘텐츠 관리"  class="nav_sub_font" onclick="javascript:fn_changePage('10');return false;">콘텐츠 DB</a>
							<ul class="nav_sub_dept">
								<li><a href="#" title="관리자용 콘텐츠"  onclick="javascript:fn_changePage('11');return false;">· 관리자용 콘텐츠</a></li>
								<li><a href="#" title="고객사용 콘텐츠"  onclick="javascript:fn_changePage('10');return false;">· 고객사용 콘텐츠</a></li>
								<li><a href="#" title="분류 관리"  onclick="javascript:fn_changePage('10');return false;">· 분류 관리</a></li>
								<li><a href="#" title="퀴즈 관리"  onclick="javascript:fn_changePage('10');return false;">· 퀴즈 관리</a></li>
							</ul>
						</dd>
						<dd>
							<a href="#" title="스탬프/스티커 관리"  class="nav_sub_font" onclick="javascript:fn_changePage('7');return false;">스탬프/스티커 관리</a>
							<ul class="nav_sub_dept">
								<li><a href="#" title="스탬프 관리"  onclick="javascript:fn_changePage('10');return false;">· 스탬프 관리</a></li>
								<li><a href="#" title="스티커 관리"  onclick="javascript:fn_changePage('12');return false;">· 스티커 관리</a></li>
							</ul>
						</dd>
					</dl>
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
							시스템 관리
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="시스템 관리" onclick="javascript:fn_changePage('2')" class="nav_sub_font">사이트 개설 / 관리</a>
					<a href="#" title="관리자 설정" onclick="javascript:fn_changePage('4')" class="nav_sub_font">관리자 설정</a>
				</dd>
				<dt class="navi nav09">		
					<a href="#" title="학습 관리" >
						<div class="icon-wrap">
							<i></i>
						</div>
						학습 관리
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="콘텐츠 관리" onclick="javascript:fn_changePage('211')" class="nav_sub_font">콘텐츠 관리</a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="관리자용 콘텐츠"  onclick="javascript:fn_changePage('211');return false;">· 관리자용 콘텐츠</a></li>
						<li><a href="#" title="고객사용 콘텐츠"  onclick="javascript:fn_changePage('212');return false;">· 고객사용 콘텐츠</a></li>
						<li><a href="#" title="분류 관리"  onclick="javascript:fn_changePage('213');return false;">· 분류 관리</a></li>
						<li><a href="#" title="퀴즈 관리"  onclick="javascript:fn_changePage('214');return false;">· 퀴즈 관리</a></li>
					</ul>
					<a href="#" title="스탬프/스티커 관리" onclick="javascript:fn_changePage('10')" class="nav_sub_font">스탬프/스티커 관리</a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="스탬프 관리"  onclick="javascript:fn_changePage('10');return false;">· 스탬프 관리</a></li>
						<li><a href="#" title="스티커 관리"  onclick="javascript:fn_changePage('12');return false;">· 스티커 관리</a></li>
					</ul>
				</dd>
				<dt class="navi nav09">		
					<a href="#" title="기초 데이터 관리" >
						<div class="icon-wrap">
							<i></i>
						</div>
						기초 데이터 관리
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="이미지 관리" onclick="javascript:fn_changePage('20')" class="nav_sub_font">이미지 관리</a>
					<a href="#" title="캐릭터 관리" onclick="javascript:fn_changePage('21')" class="nav_sub_font">캐릭터 관리</a>
				</dd>
			</dl>
		</div>
