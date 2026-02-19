<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<div class="left-menu">
			<button class="menu-toggle"><spring:message code="click.left.menu.exit"/></button>
			<h1 class="logo-small"></h1>
			<ul>
				<c:if test="${sessionVO.grade_id != '1'}">
				<li class="navi nav01">
					<a title="<spring:message code='click.dashboard'/>" href="#"><spring:message code="click.dashboard"/></a>
					<dl class="nav_sub01">
						<dt><a title="<spring:message code='click.dashboard'/>" href="#"><spring:message code="click.dashboard"/></a></dt>
					</dl>
				</li>
				<c:forEach items="${leftWebList}" var="leftWebList">
					<c:if test="${leftWebList.menu_id == '1'}">
						<li class="navi nav02">
							<a title="" href="#">${leftWebList.menu_name}</a>
							<dl class="nav_sub02">
								<dt><a title="" href="#">${leftWebList.menu_name}</a></dt>
								<dd><a title="" href="#" class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('21');return false;"><spring:message code="click.location.status"/></a></dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#" onclick="javascript:fn_changePage('211');return false;">ㄴ <spring:message code="click.working.status"/></a></li>
										<li><a title="" href="#" onclick="javascript:fn_changePage('212');return false;">ㄴ <spring:message code="click.access.status"/></a></li>
										<li><a title="" href="#" onclick="javascript:fn_changePage('213');return false;">ㄴ <spring:message code="click.worker.movement.status"/></a></li>
										<li><a title="" href="#" onclick="javascript:fn_changePage('214');return false;">ㄴ <spring:message code="click.gas.status"/></a></li>
										<li><a title="" href="#" onclick="javascript:fn_changeAlarmPage('215', 'MENU_LOCATION');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '2'}">
						<li class="navi nav03">
							<a title="" href="#">${leftWebList.menu_name}</a>
							<dl class="nav_sub03">
								<dt><a title="" href="#">${leftWebList.menu_name}</a></dt>
								<dd><a title="" href="#" class="nav_sub_height nav_sub_font"><spring:message code="click.process.rate"/>/<spring:message code="click.excavation.status"/></a></dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#">ㄴ <spring:message code="click.process.rate.history.inquiry"/></a></li>
										<li><a title="" href="#">ㄴ <spring:message code="click.excavation.rate.history.inquiry"/></a></li>
									</ul>
								</dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.setting"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#">ㄴ <spring:message code="click.elevation.registration.management"/></a></li>
										<li><a title="" href="#">ㄴ <spring:message code="click.tunnel.section.setting"/></a></li>
									</ul>
								</dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '3'}">
						<li class="navi nav04">
							<a title="" href="#">${leftWebList.menu_name}</a>
							<dl class="nav_sub04">
								<dt><a title="" href="#">${leftWebList.menu_name}</a></dt>
								<dd><a title="" href="#" class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('1');return false;"><spring:message code="click.tc.status"/></a></dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#">ㄴ <spring:message code="click.wind.speed.history.inquiry"/></a></li>
										<li><a title="" href="#" onclick="javascript:fn_changeAlarmPage('215', 'MENU_TC');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.setting"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
									</ul>
								</dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '4'}">
						<li class="navi nav05">
							<a title="" href="#">${leftWebList.menu_name}</a>
							<dl class="nav_sub05">
								<dt><a title="" href="#">${leftWebList.menu_name}</a></dt>
								<dd><a title="" href="#" class="nav_sub_height nav_sub_font"><spring:message code="click.environmental.sensor.status"/></a></dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#">ㄴ <spring:message code="click.sensor.history.inquiry"/></a></li>
									</ul>
								</dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.setting"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
										<li><a title="" href="#">ㄴ <spring:message code="click.sensor.image.registration"/></a></li>
									</ul>
								</dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '5'}">
						<li class="navi nav06">
							<a title="" href="#">${leftWebList.menu_name}</a>
							<dl class="nav_sub06">
								<dt><a title="" href="#">${leftWebList.menu_name}</a></dt>
								<dd><a title="" href="#" class="nav_sub_height nav_sub_font"><spring:message code="click.retaining.earth.status"/></a></dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#">ㄴ <spring:message code="click.sensor.history.inquiry"/></a></li>
										<li><a title="" href="#" onclick="javascript:fn_changeAlarmPage('215', 'MENU_RETAIN');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.setting"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
									</ul>
								</dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '6'}">
						<li class="navi nav07">
							<a title="" href="#">${leftWebList.menu_name}</a>
							<dl class="nav_sub07">
								<dt><a title="" href="#">${leftWebList.menu_name}</a></dt>
								<dd><a title="" href="#" class="nav_sub_height nav_sub_font"><spring:message code="click.crush.status"/></a></dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#" onclick="javascript:fn_changeAlarmPage('215', 'MENU_STRICTURE');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${leftWebList.menu_id == '7'}">
						<li class="navi nav08">
							<a title="" href="#">${leftWebList.menu_name}</a>
							<dl class="nav_sub08">
								<dt><a title="" href="#">${leftWebList.menu_name}</a></dt>
								<dd><a title="" href="#" class="nav_sub_height nav_sub_font" onclick="javascript:fn_changePage('810');return false;"><spring:message code="click.cctv.status"/></a></dd>
								<dd>
									<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
									<ul class="nav_sub_dept">
										<li><a title="" href="#" onclick="javascript:fn_changeAlarmPage('215', 'MENU_CCTV');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
									</ul>
								</dd>
							</dl>
						</li>
					</c:if>
				</c:forEach>
				</c:if>
				<li class="navi nav09 active">
					<a title="" href="#"><spring:message code="click.setting"/></a>
					<dl class="nav_sub09">
						<dt><a title="" href="#"><spring:message code="click.setting"/></a></dt>
						<c:if test="${sessionVO.grade_id != '1'}">
						<dd>
							<a title="" href="#" class="nav_sub_font"><spring:message code="click.default.setting"/></a>
							<ul class="nav_sub_dept">
								<li><a title="" href="#" onclick="javascript:fn_changePage('11');return false;">ㄴ <spring:message code="click.administrator.settings"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('10');return false;">ㄴ <spring:message code="click.worker.setting"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('8');return false;">ㄴ <spring:message code="click.status.request.reissuance"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('6');return false;">ㄴ <spring:message code="click.code.management"/></a></li>
							</ul>
						</dd>
						<dd>
							<a title="" href="#" class="nav_sub_font"><spring:message code="click.site.management"/></a>
							<ul class="nav_sub_dept">
								<li><a title="" href="#" onclick="javascript:fn_changePage('3');return false;">ㄴ <spring:message code="click.site.registration.information"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('9');return false;">ㄴ <spring:message code="click.zone.type.designation"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('19');return false;">ㄴ <spring:message code="click.site.zone.information"/></a></li>
							</ul>
						</dd>
						<dd>
							<a title="" href="#" class="nav_sub_font"><spring:message code="click.device.management"/></a>
							<ul class="nav_sub_dept">
								<li><a title="" href="#" onclick="javascript:fn_changePage('7');return false;">ㄴ <spring:message code="click.product.registration.management"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('5');return false;">ㄴ <spring:message code="click.device.registration.management"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('14');return false;">ㄴ <spring:message code="click.device.installation.uninstallation"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('15');return false;">ㄴ <spring:message code="click.gas.alarm.setting"/></a></li>
							</ul>
						</dd>
						<dd>
							<a title="" href="#" class="nav_sub_font"><spring:message code="click.app.managemnt"/></a>
							<ul class="nav_sub_dept">
								<li><a title="" href="#" onclick="javascript:fn_changePage('17');return false;">ㄴ <spring:message code="click.app.terminal.management"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('18');return false;">ㄴ <spring:message code="click.app.download.management"/></a></li>
							</ul>
						</dd>
						</c:if>
						<dd>
							<a title="" href="#" class="nav_sub_font"><spring:message code="click.system.management"/></a>
							<ul class="nav_sub_dept">
								<li><a title="" href="#" onclick="javascript:fn_changePage('16');return false;">ㄴ <spring:message code="click.customer.management"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('12');return false;">ㄴ <spring:message code="click.billing.management"/></a></li>
								<li><a title="" href="#" onclick="javascript:fn_changePage('13');return false;">ㄴ <spring:message code="click.basic.data.management"/></a></li>
							</ul>
						</dd>
					</dl>
					
				</li>
			</ul>
		</div>
		<!--좌측 네비게이션 - 펼침상태(가로 250px)-->
		<div class="left-menu-open">
			<button class="menu-toggle-close"><spring:message code="click.left.menu.close"/></button>
			<h1 class="logo-full">
				<img src="${pageContext.request.contextPath}/resources/img/nav_logo_full.png" alt="">
				<span><spring:message code="click.iot.site.safety"/></span>
			</h1>
			<dl id="scroll-style01" class="side_wrapper">
				<!--네비01- 대시보드-->
				<c:if test="${sessionVO.grade_id != '1'}">
				<dt class="navi nav01">		
					<a title="" href="#" target="_self">
						<div class="icon-wrap">
							<i></i>
						</div>
						<spring:message code="click.dashboard"/>
					</a>
				</dt>
				<dd>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.dashboard"/></a>
				</dd>
				<!--네비02- 위치관제-->
				<c:forEach items="${leftWebList}" var="leftWebList">
				<c:if test="${leftWebList.menu_id == '1'}">
				<dt class="navi nav02">		
					<a title="" href="#">
						<div class="icon-wrap">
							<i></i>
						</div>
						${leftWebList.menu_name}
						<em></em>
					</a>
				</dt>
				<dd>
					<a title="" href="#" class="nav_sub_font" onclick="javascript:fn_changePage('21');return false;"><spring:message code="click.location.status"/></a>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#" onclick="javascript:fn_changePage('211');return false;">ㄴ <spring:message code="click.working.status"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('212');return false;">ㄴ <spring:message code="click.access.status"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('213');return false;">ㄴ <spring:message code="click.worker.movement.status"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('214');return false;">ㄴ <spring:message code="click.gas.status"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changeAlarmPage('215', 'MENU_LOCATION');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
					</ul>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '2'}">
				<!--네비03- 터널관제-->
				<dt class="navi nav03">		
					<a title="" href="#">
						<div class="icon-wrap">
							<i></i>
						</div>
						${leftWebList.menu_name}
						<em></em>
					</a>
				</dt>
				<dd>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.process.rate"/>/<spring:message code="click.excavation.status"/></a>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#">ㄴ <spring:message code="click.process.rate.history.inquiry"/></a></li>
						<li><a title="" href="#">ㄴ <spring:message code="click.excavation.rate.history.inquiry"/></a></li>
					</ul>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#">ㄴ <spring:message code="click.elevation.registration.management"/></a></li>
						<li><a title="" href="#">ㄴ <spring:message code="click.tunnel.section.setting"/></a></li>
					</ul>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '3'}">
				<!--네비04- T/C 안전관리-->
				<dt class="navi nav04">		
					<a title="" href="#">
						<div class="icon-wrap">
							<i></i>
						</div>
						${leftWebList.menu_name}
						<em></em>
					</a>
				</dt>
				<dd>
					<a title="" href="#" class="nav_sub_font" onclick="javascript:fn_changePage('1');return false;"><spring:message code="click.tc.status"/></a>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#">ㄴ <spring:message code="click.wind.speed.history.inquiry"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changeAlarmPage('215', 'MENU_TC');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
					</ul>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
					</ul>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '4'}">
				<!--네비05- 환경정보-->
				<dt class="navi nav05">		
					<a title="" href="#">
						<div class="icon-wrap">
							<i></i>
						</div>
						${leftWebList.menu_name}
						<em></em>
					</a>
				</dt>
				<dd>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.environmental.sensor.status"/></a>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#">ㄴ <spring:message code="click.sensor.history.inquiry"/></a></li>
					</ul>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
						<li><a title="" href="#">ㄴ <spring:message code="click.sensor.image.registration"/></a></li>
					</ul>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '5'}">
				<!--네비06- 흙막이붕괴방지-->
				<dt class="navi nav06">		
					<a title="" href="#">
						<div class="icon-wrap">
							<i></i>
						</div>
						${leftWebList.menu_name}
						<em></em>
					</a>
				</dt>
				<dd>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.retaining.earth.status"/></a>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#">ㄴ <spring:message code="click.sensor.history.inquiry"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changeAlarmPage('215', 'MENU_RETAIN');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
					</ul>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#">ㄴ <spring:message code="click.sensor.critical.value.settinf"/></a></li>
					</ul>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '6'}">
				<!--네비07- 장비협착-->
				<dt class="navi nav07">		
					<a title="" href="#">
						<div class="icon-wrap">
							<i></i>
						</div>
						${leftWebList.menu_name}
						<em></em>
					</a>
				</dt>
				<dd>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.crush.status"/></a>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#" onclick="javascript:fn_changeAlarmPage('215', 'MENU_STRICTURE');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
					</ul>
				</dd>
				</c:if>
				<c:if test="${leftWebList.menu_id == '7'}">
				<!--네비08- CCTV-->
				<dt class="navi nav08">		
					<a title="" href="#">
						<div class="icon-wrap">
							<i></i>
						</div>
						${leftWebList.menu_name}
						<em></em>
					</a>
				</dt>
				<dd>
					<a title="" href="#" class="nav_sub_font" onclick="javascript:fn_changePage('810');return false;"><spring:message code="click.cctv.status"/></a>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.monitering"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#" onclick="javascript:fn_changeAlarmPage('215', 'MENU_CCTV');return false;">ㄴ <spring:message code="click.warning.notification.status"/></a></li>
					</ul>
				</dd>
				</c:if>
				</c:forEach>
				</c:if>
				<!--네비09- 설정-->
				<dt class="navi nav09 active">		
					<a title="" href="#">
						<div class="icon-wrap">
							<i></i>
						</div>
						<spring:message code="click.setting"/>
						<em></em>
					</a>
				</dt>
				<dd>
					<c:if test="${sessionVO.grade_id != '1'}">
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.default.setting"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#" onclick="javascript:fn_changePage('11');return false;">ㄴ <spring:message code="click.administrator.settings"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('10');return false;">ㄴ <spring:message code="click.worker.setting"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('8');return false;">ㄴ <spring:message code="click.status.request.reissuance"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('6');return false;">ㄴ <spring:message code="click.code.management"/></a></li>
					</ul>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.site.management"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#" onclick="javascript:fn_changePage('3');return false;">ㄴ <spring:message code="click.site.registration.information"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('9');return false;">ㄴ <spring:message code="click.zone.type.designation"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('19');return false;">ㄴ <spring:message code="click.site.zone.information"/></a></li>
					</ul>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.device.management"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#" onclick="javascript:fn_changePage('7');return false;">ㄴ <spring:message code="click.product.registration.management"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('5');return false;">ㄴ <spring:message code="click.device.registration.management"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('14');return false;">ㄴ <spring:message code="click.device.installation.uninstallation"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('15');return false;">ㄴ <spring:message code="click.gas.alarm.setting"/></a></li>
					</ul>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.app.managemnt"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#" onclick="javascript:fn_changePage('17');return false;">ㄴ <spring:message code="click.app.terminal.management"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('18');return false;">ㄴ <spring:message code="click.app.download.management"/></a></li>
					</ul>
					</c:if>
					<a title="" href="#" class="nav_sub_font"><spring:message code="click.system.management"/></a>
					<ul class="nav_sub_dept">
						<li><a title="" href="#" onclick="javascript:fn_changePage('16');return false;">ㄴ <spring:message code="click.customer.management"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('12');return false;">ㄴ <spring:message code="click.billing.management"/></a></li>
						<li><a title="" href="#" onclick="javascript:fn_changePage('13');return false;">ㄴ <spring:message code="click.basic.data.management"/></a></li>
					</ul>
				</dd>
			</dl>
		</div>
