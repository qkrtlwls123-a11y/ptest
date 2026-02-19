<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

	$(document).ready(function(){
		if("1" == "${sessionVO.grade_id}"){
			fn_changePage('3');
		}
		
		//$(document).tooltip();
	});
	
</script>	
	
	<div class="left-menu">
			<button class="menu-toggle"><spring:message code="click.left.menu.exit"/></button>
			<c:if test="${sessionVO.grade_id == '1'}">
				<h1 class="logo-small2"></h1>
			</c:if>
			<c:if test="${sessionVO.grade_id != '1'}">
				<c:if test="${sessionVO.site_logo_1 != '' && sessionVO.site_logo_1 != null}">
					<img src="${pageContext.request.contextPath}/file/down/${sessionVO.site_logo_1}" alt="site logo"/>
				</c:if>
				<c:if test="${sessionVO.site_logo_1 == '' || sessionVO.site_logo_1 == null}">
					<!-- <h1 class="logo-small"></h1> -->
					<h1></h1>
				</c:if>
			</c:if>
			<ul>
				<c:if test="${sessionVO.grade_id != '1'}">
				<li class="navi nav01">
					<a href="#" title="<spring:message code='click.dashboard'/>"  onclick="javascript:fn_changePage('900');return false;"><spring:message code="click.dashboard"/></a>
					<dl class="nav_sub01">
						<dt><a href="#" title="<spring:message code='click.dashboard'/>"  onclick="javascript:fn_changePage('900');return false;"><spring:message code="click.dashboard"/></a></dt>
					</dl>
				</li>
				<c:forEach items="${leftWebList}" var="leftWebList">
					<c:if test="${leftWebList.menu_id == '1'}">
						<li class="navi nav02">
							<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
								<a href="#" title="${leftWebList.menu_name}" >${leftWebList.menu_name}</a>
							</c:if>
							<c:if test="${ locale == 'en' }">
								<a href="#" title="${leftWebList.menu_name_eng}" >${leftWebList.menu_name_eng}</a>
							</c:if>
							<dl class="nav_sub02">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<dt><a href="#" title="${leftWebList.menu_name}"  onclick="javascript:fn_changePage('21');return false;">${leftWebList.menu_name}</a></dt>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<dt><a href="#" title="${leftWebList.menu_name_eng}"  onclick="javascript:fn_changePage('21');return false;">${leftWebList.menu_name_eng}</a></dt>
								</c:if>
								<dd><a href="#" title="<spring:message code='click.location.status'/>"  class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('21');return false;"><spring:message code="click.location.status"/></a></dd>
								<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
								<dd>
									<a href="#" title="<spring:message code='click.monitering'/>"  onclick="javascript:fn_changePage('211')" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.working.status'/>"  onclick="javascript:fn_changePage('211');return false;">ㄴ <spring:message code="click.working.status"/></a></li>
										<li><a href="#" title="<spring:message code='click.access.status'/>"  onclick="javascript:fn_changePage('212');return false;">ㄴ <spring:message code="click.access.status"/></a></li>
										<li><a href="#" title="<spring:message code='click.worker.movement.status'/>"  onclick="javascript:fn_changePage('213');return false;">ㄴ <spring:message code="click.worker.movement.status"/></a></li>
										<li><a href="#" title="<spring:message code='click.gas.status'/>"  onclick="javascript:fn_changePage('214');return false;">ㄴ <spring:message code="click.gas.status"/></a></li>
										<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_LOCATION');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
								</c:if>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '2'}">
						<li class="navi nav03">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<a href="#" title="${leftWebList.menu_name}"  onclick="javascript:fn_changePage('220');return false;">${leftWebList.menu_name}</a>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<a href="#" title="${leftWebList.menu_name_eng}"  onclick="javascript:fn_changePage('220');return false;">${leftWebList.menu_name_eng}</a>
								</c:if>
							<dl class="nav_sub03">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<dt><a href="#" title="${leftWebList.menu_name}"  onclick="javascript:fn_changePage('220');return false;">${leftWebList.menu_name}</a></dt>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<dt><a href="#" title="${leftWebList.menu_name_eng}"  onclick="javascript:fn_changePage('220');return false;">${leftWebList.menu_name_eng}</a></dt>
								</c:if>
								<dd><a href="#" title="<spring:message code='click.process.rate'/>/<spring:message code='click.excavation.status'/>"  class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('220');return false;"><spring:message code="click.process.rate"/>/<spring:message code="click.excavation.status"/></a></dd>
								
								<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
								<dd>
									<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('221');return false;"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.process.rate.history.inquiry'/>"  onclick="javascript:fn_changePage('221');return false;">ㄴ <spring:message code="click.process.rate.history.inquiry"/></a></li>
										<li><a href="#" title="<spring:message code='click.excavation.rate.history.inquiry'/>"  onclick="javascript:fn_changePage('222');return false;">ㄴ <spring:message code="click.excavation.rate.history.inquiry"/></a></li>
									</ul>
								</dd>
								<dd>
									<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('223');return false;"><spring:message code="click.setting"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.elevation.registration.management'/>"  onclick="javascript:fn_changePage('223');return false;">ㄴ <spring:message code="click.elevation.registration.management"/></a></li>
										<li><a href="#" title="<spring:message code='click.tunnel.section.setting'/>"  onclick="javascript:fn_changePage('224');return false;">ㄴ <spring:message code="click.tunnel.section.setting"/></a></li>
									</ul>
								</dd>
								</c:if>
								
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '3'}">
						<li class="navi nav04">
							<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
							<a href="#" title="${leftWebList.menu_name}" >${leftWebList.menu_name}</a>
							</c:if>
							<c:if test="${ locale == 'en' }">
							<a href="#" title="${leftWebList.menu_name_eng}" >${leftWebList.menu_name_eng}</a>
							</c:if>
							<dl class="nav_sub04">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<dt><a href="#" title="${leftWebList.menu_name}" onclick="javascript:fn_changePage('230')">${leftWebList.menu_name}</a></dt>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<dt><a href="#" title="${leftWebList.menu_name_eng}" onclick="javascript:fn_changePage('230')">${leftWebList.menu_name_eng}</a></dt>
								</c:if>
								<dd><a href="#" title="<spring:message code='click.tc.status'/>"  class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('230');return false;"><spring:message code="click.tc.status"/></a></dd>
								
								<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
								<dd>
									<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('231');return false;"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.wind.speed.history.inquiry'/>"  onclick="javascript:fn_changePage('231');return false;">ㄴ <spring:message code="click.wind.speed.history.inquiry"/></a></li>
										<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_TC');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
								<dd>
									<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('233');return false;"><spring:message code="click.setting"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.sensor.critical.value.settinf'/>"  onclick="javascript:fn_changePage('233');return false;">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
									</ul>
								</dd>
								</c:if>
								
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '4'}">
						<li class="navi nav05">
							<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
								<a href="#" title="${leftWebList.menu_name}" >${leftWebList.menu_name}</a>
							</c:if>
							<c:if test="${ locale == 'en' }">
								<a href="#" title="${leftWebList.menu_name_eng}" >${leftWebList.menu_name_eng}</a>
							</c:if>
							<dl class="nav_sub05">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<dt><a href="#" title="${leftWebList.menu_name}"  onclick="javascript:fn_changePage('400');return false;">${leftWebList.menu_name}</a></dt>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<dt><a href="#" title="${leftWebList.menu_name_eng}"  onclick="javascript:fn_changePage('400');return false;">${leftWebList.menu_name_eng}</a></dt>
								</c:if>
								<dd><a href="#" title="<spring:message code='click.environmental.sensor.status'/>"  class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('400');return false;"><spring:message code="click.environmental.sensor.status"/></a></dd>
								
								<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
								<dd>
									<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('411');return false;"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.sensor.history.inquiry'/>"  onclick="javascript:fn_changePage('411');return false;">ㄴ <spring:message code="click.sensor.history.inquiry"/></a></li>
									</ul>
								</dd>
								<dd>
									<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('421');return false;"><spring:message code="click.setting"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.sensor.critical.value.settinf'/>"  onclick="javascript:fn_changePage('421');return false;">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
										<li><a href="#" title="<spring:message code='click.sensor.image.registration'/>"  onclick="javascript:fn_changePage('422');return false;">ㄴ <spring:message code="click.sensor.image.registration"/></a></li>
									</ul>
								</dd>
								</c:if>
								
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '5'}">
						<li class="navi nav06">
							<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
								<a href="#" title="${leftWebList.menu_name}" >${leftWebList.menu_name}</a>
							</c:if>
							<c:if test="${ locale == 'en' }">
								<a href="#" title="${leftWebList.menu_name_eng}" >${leftWebList.menu_name_eng}</a>
							</c:if>
							<dl class="nav_sub06">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<dt><a href="#" title="${leftWebList.menu_name}"  onclick="javascript:fn_changePage('511');return false;">${leftWebList.menu_name}</a></dt>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<dt><a href="#" title="${leftWebList.menu_name_eng}"  onclick="javascript:fn_changePage('511');return false;">${leftWebList.menu_name_eng}</a></dt>
								</c:if>
								<dd><a href="#" title="<spring:message code='click.retaining.earth.status'/>"  class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('511');return false;"><spring:message code="click.retaining.earth.status"/></a></dd>
								<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
								<dd>
									<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('521');return false;"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.sensor.history.inquiry'/>"  onclick="javascript:fn_changePage('521');return false;">ㄴ <spring:message code="click.sensor.history.inquiry"/></a></li>
										<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_RETAIN');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
								<dd>
									<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('531');return false;"><spring:message code="click.setting"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.sensor.critical.value.settinf'/>"  onclick="javascript:fn_changePage('531');return false;">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
									</ul>
								</dd>
								</c:if>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '6'}">
						<li class="navi nav07">
							<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
								<a href="#" title="${leftWebList.menu_name}" >${leftWebList.menu_name}</a>
							</c:if>
							<c:if test="${ locale == 'en' }">
								<a href="#" title="${leftWebList.menu_name_eng}" >${leftWebList.menu_name_eng}</a>
							</c:if>
							<dl class="nav_sub07">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<dt><a href="#" title="${leftWebList.menu_name}"  onclick="javascript:fn_changePage('301');return false;">${leftWebList.menu_name}</a></dt>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<dt><a href="#" title="${leftWebList.menu_name_eng}"  onclick="javascript:fn_changePage('301');return false;">${leftWebList.menu_name_eng}</a></dt>
								</c:if>
								<dd><a href="#" title="<spring:message code='click.crush.status'/>"  class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('301');return false;"><spring:message code="click.crush.status"/></a></dd>
								<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
								<dd>
									<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_STRICTURE');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
								<dd>
									<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('331');return false;"><spring:message code="click.setting"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.approver.settings'/>"  onclick="javascript:fn_changePage('331');return false;">ㄴ <spring:message code="click.approver.settings"/></a></li>
									</ul>
								</dd>
								</c:if>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '7'}">
						<li class="navi nav08">
							<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
								<a href="#" title="${leftWebList.menu_name}" >${leftWebList.menu_name}</a>
							</c:if>
							<c:if test="${ locale == 'en' }">
								<a href="#" title="${leftWebList.menu_name_eng}" >${leftWebList.menu_name_eng}</a>
							</c:if>
							<dl class="nav_sub08">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<dt><a href="#" title="${leftWebList.menu_name}"  onclick="javascript:fn_changePage('810');return false;">${leftWebList.menu_name}</a></dt>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<dt><a href="#" title="${leftWebList.menu_name_eng}"  onclick="javascript:fn_changePage('810');return false;">${leftWebList.menu_name_eng}</a></dt>
								</c:if>
								<dd><a href="#" title="<spring:message code='click.cctv.status'/>"  class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('810');return false;"><spring:message code="click.cctv.status"/></a></dd>
								
								<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
								<dd>
									<!-- <a href="#" title="" onclick="javascript:fn_changePage('821')" class="nav_sub_font">모니터링</a> -->
									<a title="<spring:message code='click.monitering'/>" href="javascript:fn_changeAlarmPage('215', 'MENU_CCTV')" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_CCTV');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
								</c:if>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '13'}">
						<li class="navi nav11">
							<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
								<a href="#" title="${leftWebList.menu_name}" >${leftWebList.menu_name}</a>
							</c:if>
							<c:if test="${ locale == 'en' }">
								<a href="#" title="${leftWebList.menu_name_eng}" >${leftWebList.menu_name_eng}</a>
							</c:if>
							<dl class="nav_sub11">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<dt><a href="#" title="${leftWebList.menu_name}"  onclick="javascript:fn_changePage('2000');return false;">${leftWebList.menu_name}</a></dt>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<dt><a href="#" title="${leftWebList.menu_name_eng}"  onclick="javascript:fn_changePage('2000');return false;">${leftWebList.menu_name_eng}</a></dt>
								</c:if>
								<dd><a href="#" title=<spring:message code='click.infection.control'/>  class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('2000');return false;"><spring:message code='click.finfection.status'/></a></dd>
								<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
								<dd>
									<a href="#" title="<spring:message code='click.monitering'/>"  onclick="javascript:fn_changePage('2002')" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.select.worker.detail'/>"  onclick="javascript:fn_changePage('2002');return false;">ㄴ <spring:message code='click.select.worker.detail'/></a></li>
										<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_FEVER');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
								<dd>
									<a href="#" title="<spring:message code='click.setting'/>"  onclick="javascript:fn_changePage('2003')" class="nav_sub_font"><spring:message code='click.setting'/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.sensor.critical.value.settinf'/>"  onclick="javascript:fn_changePage('2003');return false;">ㄴ <spring:message code='click.sensor.critical.value.settinf'/></a></li>
									</ul>
								</dd>
								</c:if>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '14'}">
						<li class="navi nav12">
							<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
								<a href="#" title="${leftWebList.menu_name}" >${leftWebList.menu_name}</a>
							</c:if>
							<c:if test="${ locale == 'en' }">
								<a href="#" title="${leftWebList.menu_name_eng}" >${leftWebList.menu_name_eng}</a>
							</c:if>
							<dl class="nav_sub12">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<dt><a href="#" title="${leftWebList.menu_name}"  onclick="javascript:fn_changePage('3000');return false;">${leftWebList.menu_name}</a></dt>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<dt><a href="#" title="${leftWebList.menu_name_eng}"  onclick="javascript:fn_changePage('3000');return false;">${leftWebList.menu_name_eng}</a></dt>
								</c:if>
								<dd><a href="#" title="<spring:message code='click.flooding.status'/>"  class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('3000');return false;"><spring:message code='click.flooding.status'/></a></dd>
								<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
								<dd>
									<a href="#" title="<spring:message code='click.monitering'/>"  onclick="javascript:fn_changePage('3001')" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.sensor.history.inquiry'/>"  onclick="javascript:fn_changePage('3001');return false;">ㄴ <spring:message code='click.sensor.history.inquiry'/></a></li>
										<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_WATER');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
								<dd>
									<a href="#" title="<spring:message code='click.setting'/>"  onclick="javascript:fn_changePage('3002')" class="nav_sub_font"><spring:message code='click.setting'/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.sensor.critical.value.settinf'/>"  onclick="javascript:fn_changePage('3002');return false;">ㄴ <spring:message code='click.sensor.critical.value.settinf'/></a></li>
									</ul>
								</dd>
								</c:if>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '15'}">
						<li class="navi nav13">
							<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
								<a href="#" title="${leftWebList.menu_name}" >${leftWebList.menu_name}</a>
							</c:if>
							<c:if test="${ locale == 'en' }">
								<a href="#" title="${leftWebList.menu_name_eng}" >${leftWebList.menu_name_eng}</a>
							</c:if>
							<dl class="nav_sub13">
								<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
									<dt><a href="#" title="${leftWebList.menu_name}"  onclick="javascript:fn_changePage('4000');return false;">${leftWebList.menu_name}</a></dt>
								</c:if>
								<c:if test="${ locale == 'en' }">
									<dt><a href="#" title="${leftWebList.menu_name_eng}"  onclick="javascript:fn_changePage('4000');return false;">${leftWebList.menu_name_eng}</a></dt>
								</c:if>
								<dd><a href="#" title="<spring:message code='click.fire.status'/>"  class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('4000');return false;"><spring:message code='click.fire.status'/></a></dd>
								<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
								<dd>
									<a href="#" title="<spring:message code='click.monitering'/>"  onclick="javascript:fn_changePage('4001')" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a href="#" title="<spring:message code='click.sensor.history.inquiry'/>"  onclick="javascript:fn_changePage('4001');return false;">ㄴ <spring:message code='click.sensor.history.inquiry'/></a></li>
										<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_OILMIST');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
								</c:if>
							</dl>
						</li>
					</c:if>
				</c:forEach>
				</c:if>
				<c:if test="${sessionVO.grade_id != '1'}">
				<c:if test="${sessionVO.grade_id != '5'}">
				<li class="navi nav09">
					<a href="#" title="<spring:message code='click.setting'/>" ><spring:message code="click.setting"/></a>
					<dl class="nav_sub09">
						<dt><a href="#" title="<spring:message code='click.setting'/>"  onclick="javascript:fn_changePage('11');return false;"><spring:message code="click.setting"/></a></dt>
						<dd>
							<a href="#" title="<spring:message code='click.default.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('11');return false;"><spring:message code="click.default.setting"/></a>
							<ul class="nav_sub_dept">
								<li><a href="#" title="<spring:message code='click.administrator.settings'/>"  onclick="javascript:fn_changePage('11');return false;">ㄴ <spring:message code="click.administrator.settings"/></a></li>
								<li><a href="#" title="<spring:message code='click.worker.setting'/>"  onclick="javascript:fn_changePage('10');return false;">ㄴ <spring:message code="click.worker.setting"/></a></li>
								<c:if test="${sessionVO.grade_id != '4'}">
								<li><a href="#" title="<spring:message code='click.status.request.reissuance'/>"  onclick="javascript:fn_changePage('8');return false;">ㄴ <spring:message code="click.status.request.reissuance"/></a></li>
								<li><a href="#" title="<spring:message code='click.code.management'/>"  onclick="javascript:fn_changePage('6');return false;">ㄴ <spring:message code="click.code.management"/></a></li>
								</c:if>
							</ul>
						</dd>
						<c:if test="${sessionVO.grade_id != '4'}">
						<dd>
							<a href="#" title="<spring:message code='click.site.management'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('3');return false;"><spring:message code="click.site.management"/></a>
							<ul class="nav_sub_dept">
								<li><a href="#" title="<spring:message code='click.site.registration.information'/>"  onclick="javascript:fn_changePage('3');return false;">ㄴ <spring:message code="click.site.registration.information"/></a></li>
								<li><a href="#" title="<spring:message code='click.zone.type.designation'/>"  onclick="javascript:fn_changePage('9');return false;">ㄴ <spring:message code="click.zone.type.designation"/></a></li>
								<li><a href="#" title="<spring:message code='click.site.zone.information'/>"  onclick="javascript:fn_changePage('19');return false;">ㄴ <spring:message code="click.site.zone.information"/></a></li>
								<li><a href="#" title="<spring:message code='click.equipment.type.designation'/>"  onclick="javascript:fn_changePage('20');return false;">ㄴ <spring:message code="click.equipment.type.designation"/></a></li>
							</ul>
						</dd>
						</c:if>
						
						<dd>
							<a href="#" title="<spring:message code='click.device.management'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('7');return false;"><spring:message code="click.device.management"/></a>
							<ul class="nav_sub_dept">
								<c:if test="${sessionVO.grade_id != '4'}">
								<li><a href="#" title="<spring:message code='click.product.registration.management'/>"  onclick="javascript:fn_changePage('7');return false;">ㄴ <spring:message code="click.product.registration.management"/></a></li>
								</c:if>
								
								<li><a href="#" title="<spring:message code='click.device.registration.management'/>"  onclick="javascript:fn_changePage('5');return false;">ㄴ <spring:message code="click.device.registration.management"/></a></li>
								<li><a href="#" title="<spring:message code='click.device.installation.uninstallation'/>"  onclick="javascript:fn_changePage('14');return false;">ㄴ <spring:message code="click.device.installation.uninstallation"/></a></li>
								
								<c:if test="${sessionVO.grade_id != '4'}">
								<li><a href="#" title="<spring:message code='click.gas.alarm.setting'/>"  onclick="javascript:fn_changePage('15');return false;">ㄴ <spring:message code="click.gas.alarm.setting"/></a></li>
								</c:if>
							</ul>
						</dd>
						
						<c:if test="${sessionVO.grade_id != '4'}">
						<dd>
							<a href="#" title="<spring:message code='click.app.managemnt'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('17');return false;"><spring:message code="click.app.managemnt"/></a>
							<ul class="nav_sub_dept">
								<li><a href="#" title="<spring:message code='click.app.terminal.management'/>"  onclick="javascript:fn_changePage('17');return false;">ㄴ <spring:message code="click.app.terminal.management"/></a></li>
								<li><a href="#" title="<spring:message code='click.app.download.management'/>"  onclick="javascript:fn_changePage('18');return false;">ㄴ <spring:message code="click.app.download.management"/></a></li>
								<li><a href="#" title="<spring:message code='click.app.menu.authority.management'/>"  onclick="javascript:fn_changePage('22');return false;">ㄴ <spring:message code="click.app.menu.authority.management"/></a></li>
							</ul>
						</dd>
						</c:if>

					</dl>
				</li>
				</c:if>
				</c:if>
				<c:if test="${sessionVO.grade_id == '1'}">
				<li class="navi nav10">
					<a href="#" title="<spring:message code='click.system.management'/>" ><spring:message code="click.system.management"/></a>
					<dl class="nav_sub10">
						<dt><a href="#" title="<spring:message code='click.system.management'/>" onclick="javascript:fn_changePage('16');return false;"><spring:message code="click.system.management"/></a></dt>
						<dd>
							<a href="#" title="<spring:message code='click.customer.management'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('16');return false;"><spring:message code="click.customer.management"/></a>
							<a href="#" title="<spring:message code='click.administrator.settings'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('11');return false;"><spring:message code="click.administrator.settings"/></a>
							<a href="#" title="<spring:message code='click.site.management'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('3');return false;"><spring:message code="click.site.management"/></a>
							<!-- <a href="#" title=""  class="nav_sub_font" onclick="javascript:fn_changePage('12');return false;"><spring:message code="click.billing.management"/></a> -->
							<a href="#" title="<spring:message code='click.basic.data.management'/>" class="nav_sub_font" onclick="javascript:fn_changePage('13');return false;"><spring:message code="click.basic.data.management"/></a>
						</dd>
					</dl>
				</li>
				</c:if>
			</ul>
		</div>
		<!--좌측 네비게이션 - 펼침상태(가로 250px)-->
		<div class="left-menu-open">
			<button class="menu-toggle-close"><spring:message code="click.left.menu.close"/></button>
			<h1 class="logo-full">
				<c:if test="${sessionVO.grade_id == '1'}">
					<img src="${pageContext.request.contextPath}/resources/img/hd_auto.png" alt="">
				</c:if>
				<c:if test="${sessionVO.grade_id != '1'}">
					<c:if test="${sessionVO.site_logo_2 != '' && sessionVO.site_logo_2 != null}">
						<img src="${pageContext.request.contextPath}/file/down/${sessionVO.site_logo_2}" alt="site logo"/>
					</c:if>
					<c:if test="${sessionVO.site_logo_2 == '' || sessionVO.site_logo_2 == null}">
						<%-- <img src="${pageContext.request.contextPath}/resources/img/nav_logo_full.png" alt="site logo"> --%>
					</c:if>
				</c:if>
				
				<span><spring:message code="click.iot.site.safety"/></span>
			</h1>
			<dl id="scroll-style01" class="side_wrapper">
			
				<!--네비01- 대시보드-->
				<c:if test="${sessionVO.grade_id != '1'}">
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
				
				<!--네비02- 위치관제-->
				<c:forEach items="${leftWebList}" var="leftWebList">
				<c:if test="${leftWebList.menu_id == '1'}">
				<dt class="navi nav02">
					<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
						<a href="#" title="${leftWebList.menu_name}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name}
							<em></em>
						</a>
					</c:if>
					<c:if test="${ locale == 'en' }">
						<a href="#" title="${leftWebList.menu_name_eng}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name_eng}
							<em></em>
						</a>
					</c:if>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.location.status' />"  class="nav_sub_font" onclick="javascript:fn_changePage('21');return false;"><spring:message code="click.location.status" /></a>
					
					<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
					<a href="#" title="<spring:message code='click.monitering' />" onclick="javascript:fn_changePage('211')" class="nav_sub_font"><spring:message code="click.monitering" /></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.working.status' />"  onclick="javascript:fn_changePage('211');return false;">ㄴ <spring:message code="click.working.status" /></a></li>
						<li><a href="#" title="<spring:message code='click.access.status' />"  onclick="javascript:fn_changePage('212');return false;">ㄴ <spring:message code="click.access.status" /></a></li>
						<li><a href="#" title="<spring:message code='click.worker.movement.status' />"  onclick="javascript:fn_changePage('213');return false;">ㄴ <spring:message code="click.worker.movement.status" /></a></li>
						<li><a href="#" title="<spring:message code='click.gas.status' />"  onclick="javascript:fn_changePage('214');return false;">ㄴ <spring:message code="click.gas.status" /></a></li>
						<li><a href="#" title="<spring:message code='click.warning.notification.status' />"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_LOCATION');return false;">ㄴ <spring:message code="click.warning.notification.status" /></a></li>
					</ul>
					</c:if>
				</dd>
				</c:if> 
				<c:if test="${leftWebList.menu_id == '2'}">
				<!--네비03- 터널관제-->
				<dt class="navi nav03">
					<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
						<a href="#" title="${leftWebList.menu_name}" >
						<div class="icon-wrap">
							<i></i>
						</div>
							${leftWebList.menu_name}
						<em></em>
					</a>
					</c:if>
					<c:if test="${ locale == 'en' }">
						<a href="#" title="${leftWebList.menu_name_eng}" >
						<div class="icon-wrap">
							<i></i>
						</div>
							${leftWebList.menu_name_eng}
						<em></em>
					</a>
					</c:if>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.process.rate'/>/<spring:message code='click.excavation.status'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('220');return false;"><spring:message code="click.process.rate"/>/<spring:message code="click.excavation.status"/></a>
					
					<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
					<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('221');return false;"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.process.rate.history.inquiry'/>"  onclick="javascript:fn_changePage('221');return false;">ㄴ <spring:message code="click.process.rate.history.inquiry"/></a></li>
						<li><a href="#" title="<spring:message code='click.excavation.rate.history.inquiry'/>"  onclick="javascript:fn_changePage('222');return false;">ㄴ <spring:message code="click.excavation.rate.history.inquiry"/></a></li>
					</ul>
					<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('223');return false;"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.elevation.registration.management'/>"  onclick="javascript:fn_changePage('223');return false;">ㄴ <spring:message code="click.elevation.registration.management"/></a></li>
						<li><a href="#" title="<spring:message code='click.tunnel.section.setting'/>"  onclick="javascript:fn_changePage('224');return false;">ㄴ <spring:message code="click.tunnel.section.setting"/></a></li>
					</ul>
					</c:if>
					
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '3'}">
				<!--네비04- T/C 안전관리-->
				<dt class="navi nav04">
					<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
						<a href="#" title="${leftWebList.menu_name}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name}
							<em></em>
						</a>
					</c:if>
					<c:if test="${ locale == 'en' }">
						<a href="#" title="${leftWebList.menu_name_eng}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name_eng}
							<em></em>
						</a>
					</c:if>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.tc.status'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('230');return false;"><spring:message code="click.tc.status"/></a>
					
					<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
					<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('231');return false;"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.wind.speed.history.inquiry'/>"  onclick="javascript:fn_changePage('231');return false;">ㄴ <spring:message code="click.wind.speed.history.inquiry"/></a></li>
						<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_TC');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
					</ul>
					<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('233');return false;"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.sensor.critical.value.settinf'/>"  onclick="javascript:fn_changePage('233');return false;">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
					</ul>
					</c:if>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '4'}">
				<!--네비05- 환경정보-->
				<dt class="navi nav05">
					<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
						<a href="#" title="${leftWebList.menu_name}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name}
							<em></em>
						</a>
					</c:if>
					<c:if test="${ locale == 'en' }">
						<a href="#" title="${leftWebList.menu_name_eng}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name_eng}
							<em></em>
						</a>
					</c:if>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.environmental.sensor.status'/>"  onclick="javascript:fn_changePage('400');return false;" class="nav_sub_font"><spring:message code="click.environmental.sensor.status"/></a>
					
					<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
					<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('411');return false;"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.sensor.history.inquiry'/>"  onclick="javascript:fn_changePage('411');return false;">ㄴ <spring:message code="click.sensor.history.inquiry"/></a></li>
					</ul>
					<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('421');return false;"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.sensor.critical.value.settinf'/>"  onclick="javascript:fn_changePage('421');return false;">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
						<li><a href="#" title="<spring:message code='click.sensor.image.registration'/>"  onclick="javascript:fn_changePage('422');return false;">ㄴ <spring:message code="click.sensor.image.registration"/></a></li>
					</ul>
					</c:if>
					
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '5'}">
				<!--네비06- 흙막이붕괴방지-->
				<dt class="navi nav06">
					<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
						<a href="#" title="${leftWebList.menu_name}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name}
							<em></em>
						</a>
					</c:if>
					<c:if test="${ locale == 'en' }">
						<a href="#" title="${leftWebList.menu_name_eng}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name_eng}
							<em></em>
						</a>
					</c:if>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.retaining.earth.status'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('511');return false;"><spring:message code="click.retaining.earth.status"/></a>
					
					<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
					<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('521');return false;"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.sensor.history.inquiry'/>"  onclick="javascript:fn_changePage('521');return false;">ㄴ <spring:message code="click.sensor.history.inquiry"/></a></li>
						<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_RETAIN');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
						
					</ul>
					<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('531');return false;"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.sensor.critical.value.settinf'/>"  onclick="javascript:fn_changePage('531');return false;">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
					</ul>
					</c:if>
					
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '6'}">
				<!--네비07- 장비협착-->
				<dt class="navi nav07">
					<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
						<a href="#" title="${leftWebList.menu_name}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name}
							<em></em>
						</a>
					</c:if>
					<c:if test="${ locale == 'en' }">
						<a href="#" title="${leftWebList.menu_name_eng}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name_eng}
							<em></em>
						</a>
					</c:if>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.crush.status'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('301');return false;"><spring:message code="click.crush.status"/></a>
					<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
					<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
					<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_STRICTURE');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
					</ul>
					<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('331');return false;"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.approver.settings'/>"  onclick="javascript:fn_changePage('331');return false;">ㄴ <spring:message code="click.approver.settings"/></a></li>
					</ul>
					</c:if>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '7'}">
				<!--네비08- CCTV-->
				<dt class="navi nav08">
					<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
						<a href="#" title="${leftWebList.menu_name}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name}
							<em></em>
						</a>
					</c:if>
					<c:if test="${ locale == 'en' }">
						<a href="#" title="${leftWebList.menu_name_eng}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name_eng}
							<em></em>
						</a>
					</c:if>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.cctv.status'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('810');return false;"><spring:message code="click.cctv.status"/></a>
					
					<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
					<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changeAlarmPage('215', 'MENU_CCTV');return false;"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_CCTV');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
					</ul>
					</c:if>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '13'}">
				<!--네비08- CCTV-->
				<dt class="navi nav11">
					<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
						<a href="#" title="${leftWebList.menu_name}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name}
							<em></em>
						</a>
					</c:if>
					<c:if test="${ locale == 'en' }">
						<a href="#" title="${leftWebList.menu_name_eng}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name_eng}
							<em></em>
						</a>
					</c:if>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.finfection.status'/>" class="nav_sub_font" onclick="javascript:fn_changePage('2000');return false;"><spring:message code='click.finfection.status'/></a>
					
					<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
					<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('2002');return false;"><spring:message code='click.monitering'/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.monitering'/>"  onclick="javascript:fn_changePage('2002');return false;">ㄴ 작업자상세조회</a></li>
						<li><a href="#" title="<spring:message code='click.monitering'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_FEVER');return false;">ㄴ <spring:message code='click.warning.notification.status'/></a></li>
					</ul>
					<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('2003');return false;"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title=""  onclick="javascript:fn_changePage('2003');return false;">ㄴ <spring:message code='click.sensor.critical.value.settinf'/></a></li>
					</ul>
					</c:if>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '14'}">
				<!--네비08- CCTV-->
				<dt class="navi nav12">
					<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
						<a href="#" title="${leftWebList.menu_name}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name}
							<em></em>
						</a>
					</c:if>
					<c:if test="${ locale == 'en' }">
						<a href="#" title="${leftWebList.menu_name_eng}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name_eng}
							<em></em>
						</a>
					</c:if>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.flooding.status'/>" class="nav_sub_font" onclick="javascript:fn_changePage('3000');return false;"><spring:message code='click.flooding.status'/></a>
					
					<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
					<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('3001');return false;"><spring:message code='click.monitering'/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.sensor.history.inquiry'/>"  onclick="javascript:fn_changePage('3001');return false;">ㄴ <spring:message code='click.sensor.history.inquiry'/></a></li>
						<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_WATER');return false;">ㄴ <spring:message code='click.warning.notification.status'/></a></li>
					</ul>
					<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('3002');return false;"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title=""  onclick="javascript:fn_changePage('3002');return false;">ㄴ <spring:message code='click.sensor.critical.value.settinf'/></a></li>
					</ul>
					</c:if>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '15'}">
				<!--네비08- CCTV-->
				<dt class="navi nav13">
					<c:if test="${ locale == 'ko_kr' || locale == 'ko_KR' }">
						<a href="#" title="${leftWebList.menu_name}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name}
							<em></em>
						</a>
					</c:if>
					<c:if test="${ locale == 'en' }">
						<a href="#" title="${leftWebList.menu_name_eng}" >
							<div class="icon-wrap">
								<i></i>
							</div>
								${leftWebList.menu_name_eng}
							<em></em>
						</a>
					</c:if>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.fire.control'/>" class="nav_sub_font" onclick="javascript:fn_changePage('4000');return false;"><spring:message code='click.fire.control'/></a>
					
					<c:if test="${not (sessionVO.grade_id == '4' or sessionVO.grade_id == '5')}">
					<a href="#" title="<spring:message code='click.monitering'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('4001');return false;"><spring:message code='click.monitering'/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.sensor.history.inquiry'/>"  onclick="javascript:fn_changePage('4001');return false;">ㄴ <spring:message code='click.sensor.history.inquiry'/></a></li>
						<li><a href="#" title="<spring:message code='click.warning.notification.status'/>"  onclick="javascript:fn_changeAlarmPage('215', 'MENU_OILMIST');return false;">ㄴ <spring:message code='click.warning.notification.status'/></a></li>
					</ul>
					<a href="#" title="<spring:message code='click.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('4003');return false;"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title=""  onclick="javascript:fn_changePage('4003');return false;">ㄴ <spring:message code='click.sensor.critical.value.settinf'/></a></li>
					</ul>
					</c:if>
				</dd>
				</c:if>
				</c:forEach>
				<!--네비09- 설정-->
				</c:if>
				
				<c:if test="${sessionVO.grade_id != '1'}">
				<c:if test="${sessionVO.grade_id != '5'}">
				<dt class="navi nav09">		
					<a href="#" title="<spring:message code='click.setting'/>" >
						<div class="icon-wrap">
							<i></i>
						</div>
						<spring:message code="click.setting"/>
						<em></em>
					</a>
				</dt>
				
				<dd>
					<a href="#" title="<spring:message code='click.default.setting'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('11');return false;"><spring:message code="click.default.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.administrator.settings'/>"  onclick="javascript:fn_changePage('11');return false;">ㄴ <spring:message code="click.administrator.settings"/></a></li>
						<li><a href="#" title="<spring:message code='click.worker.setting'/>"  onclick="javascript:fn_changePage('10');return false;">ㄴ <spring:message code="click.worker.setting"/></a></li>
						
						<c:if test="${sessionVO.grade_id != '4'}">
						<li><a href="#" title="<spring:message code='click.status.request.reissuance'/>"  onclick="javascript:fn_changePage('8');return false;">ㄴ <spring:message code="click.status.request.reissuance"/></a></li>
						<li><a href="#" title="<spring:message code='click.code.management'/>"  onclick="javascript:fn_changePage('6');return false;">ㄴ <spring:message code="click.code.management"/></a></li>
						</c:if>
						
					</ul>
					
					<c:if test="${sessionVO.grade_id != '4'}">
					<a href="#" title="<spring:message code='click.site.management'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('3');return false;"><spring:message code="click.site.management"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.site.registration.information'/>"  onclick="javascript:fn_changePage('3');return false;">ㄴ <spring:message code="click.site.registration.information"/></a></li>
						<li><a href="#" title="<spring:message code='click.zone.type.designation'/>"  onclick="javascript:fn_changePage('9');return false;">ㄴ <spring:message code="click.zone.type.designation"/></a></li>
						<li><a href="#" title="<spring:message code='click.site.zone.information'/>"  onclick="javascript:fn_changePage('19');return false;">ㄴ <spring:message code="click.site.zone.information"/></a></li>
						<li><a href="#" title="<spring:message code='click.equipment.type.designation'/>"  onclick="javascript:fn_changePage('20');return false;">ㄴ <spring:message code="click.equipment.type.designation"/></a></li>
					</ul>
					</c:if>
					<c:if test="${ sessionVO.grade_id != '4' }">
					<a href="#" title="<spring:message code='click.device.management'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('7');return false;"><spring:message code="click.device.management"/></a>
					</c:if>
					<c:if test="${sessionVO.grade_id == '4'}">
					<a href="#" title="<spring:message code='click.device.management'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('5');return false;"><spring:message code="click.device.management"/></a>
					</c:if>
					<ul class="nav_sub_dept">
						<c:if test="${sessionVO.grade_id != '4'}">
						<li><a href="#" title="<spring:message code='click.product.registration.management'/>"  onclick="javascript:fn_changePage('7');return false;">ㄴ <spring:message code="click.product.registration.management"/></a></li>
						</c:if>
						
						<li><a href="#" title="<spring:message code='click.device.registration.management'/>"  onclick="javascript:fn_changePage('5');return false;">ㄴ <spring:message code="click.device.registration.management"/></a></li>
						<li><a href="#" title="<spring:message code='click.device.installation.uninstallation'/>"  onclick="javascript:fn_changePage('14');return false;">ㄴ <spring:message code="click.device.installation.uninstallation"/></a></li>
						
						<c:if test="${sessionVO.grade_id != '4'}">
						<li><a href="#" title="<spring:message code='click.gas.alarm.setting'/>"  onclick="javascript:fn_changePage('15');return false;">ㄴ <spring:message code="click.gas.alarm.setting"/></a></li>
						</c:if>
					</ul>
					
					<c:if test="${sessionVO.grade_id != '4'}">
					<a href="#" title="<spring:message code='click.app.managemnt'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('17');return false;"><spring:message code="click.app.managemnt"/></a>
					<ul class="nav_sub_dept">
						<li><a href="#" title="<spring:message code='click.app.terminal.management'/>"  onclick="javascript:fn_changePage('17');return false;">ㄴ <spring:message code="click.app.terminal.management"/></a></li>
						<li><a href="#" title="<spring:message code='click.app.download.management'/>"  onclick="javascript:fn_changePage('18');return false;">ㄴ <spring:message code="click.app.download.management"/></a></li>
						<li><a href="#" title="<spring:message code='click.app.menu.authority.management'/>"  onclick="javascript:fn_changePage('22');return false;">ㄴ <spring:message code="click.app.menu.authority.management"/></a></li>
					</ul>
					</c:if>
					
				</dd>
				</c:if>
				</c:if>
				<c:if test="${sessionVO.grade_id == '1'}">
				<dt class="nav10">		
					<a href="#" title="<spring:message code='click.system.management'/>" >
						<div class="icon-wrap">
							<i></i>
						</div>
						<spring:message code="click.system.management"/>
						<em></em>
					</a>
				</dt>
				<dd>
					<a href="#" title="<spring:message code='click.customer.management'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('16');return false;"><spring:message code="click.customer.management"/></a>
					<a href="#" title="<spring:message code='click.administrator.settings'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('11');return false;"><spring:message code="click.administrator.settings"/></a>
					<a href="#" title="<spring:message code='click.site.management'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('3');return false;"><spring:message code="click.site.management"/></a>
					<!-- <a href="#" title=""  class="nav_sub_font" onclick="javascript:fn_changePage('12');return false;">과금관리</a> -->
					<a href="#" title="<spring:message code='click.basic.data.management'/>"  class="nav_sub_font" onclick="javascript:fn_changePage('13');return false;"><spring:message code="click.basic.data.management"/></a>
				</dd>
				</c:if>
			</dl>
		</div>
