<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ui.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("input").keydown(function(key) {
				if (key.keyCode == 13) {
					fn_searchList('1');
					return false;
				}
			});
			
			var deviceTypeCount = "${deviceTypeListCount}";
			if(deviceTypeCount <= 1) {
				$("#device_type").addClass("readonly dis-block");
				$("#device_type").attr("disabled", "disabled");
			}
			
			fn_ckeckDate("30", "d", "","${locale}");
		});
		
		function fn_clear_local(){
			console.log('-----------------------------------fn_clear_local');
			$(".m-form-table").find("select").each(function(i){
				var checkFormId = $(this).attr("id");
				console.log('checkFormId =' + checkFormId);
				$(this).val("");
			})
			
			$("#worker_name").val("");
			$("#start_date").val(new Date().format("yyyy-MM-dd"));
			$("#end_date").val(new Date().format("yyyy-MM-dd"));
			fn_searchList('1');
		}

		
		function fn_openAlarmAction(event_id, status) {
			
			var params = "event_id=" + event_id;

			if(status == '0' || status == '1')
				openEventAlarmPopup("alarmActionPopup","<spring:message code='click.action.create'/>", params);
			else
				openEventAlarmPopup("alarmActionResultPopup","<spring:message code='click.action.view'/>", params);
		}		
		         
		function fn_alarmCctvPlayPopup(event_id){
			var params = "event_id=" + event_id;
			$.ajax({
				url : "${pageContext.request.contextPath}/alarmCctvPlayPopup/cctvPlayPopup",
				type : "POST",
				data: params,
				success : function(result) {
					$("#popupWrap").html(result);
					$("#popupWrap").css("display", "block");
				}
			});
		}

		function fn_downloadExcel(){
			var prams = $("form[name=parameterVO]").serialize(); 
			window.open("${pageContext.request.contextPath}/download/downloadEventAlarm.excel?"+prams, "EXCEL Download");
		}

		$('#pageNavigation').change(function(){ 
		    var value = $(this).val();
		    if(value == "215"){
		    	fn_changeAlarmPage('215', 'MENU_LOCATION');
		    }else{
		    	fn_changePage(value);
		    }
		    	
		});
	</script>
			<div class="page-navigation">
				<ul>
					<li><a href="#">Home</a></li>
				<c:if test="${parameterVO.menu_type == 'MENU_LOCATION'}"> 					
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.location.control" /></a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.monitering" /></a></li>
					<li class="gray">></li>
					<li>
						<!-- <select name="" id="" onchange="javascript:fn_changePage(value);return false;"> -->
						<select name="" id="pageNavigation">
							<option value="211"><spring:message code="click.working.status"/></option>
							<option value="212"><spring:message code="click.access.status"/></option>
							<option value="213"><spring:message code="click.worker.movement.status"/></option>
							<option value="214"><spring:message code="click.gas.status"/></option>
							<option value="215" selected><spring:message code="click.warning.notification.status"/></option>
						</select>
					</li>
				</c:if>
				<c:if test="${parameterVO.menu_type == 'MENU_TC'}"> 					
					<li class="gray">></li>
					<li><a href="#">T/C <spring:message code="click.tc.safety.management"/></a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.monitering"/></a></li>
					<li class="gray">></li>
					<li>
						<select name="" onchange="javascript:fn_changePage(value);return false;">
							<option value="231"><spring:message code="click.wind.speed.history.inquiry"/></option>
							<option value="215" selected><spring:message code="click.warning.notification.status"/></option>
						</select>
					</li>
				</c:if>
				<c:if test="${parameterVO.menu_type == 'MENU_RETAIN'}"> 					
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.retaining.earth.collapse.prevention"/></a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.monitering"/></a></li>
					<li class="gray">></li>
					<li>
						<select name="" onchange="javascript:fn_changePage(value);return false;">
							<option value="521"><spring:message code="click.searching.history.each.sensor"/></option>
							<option value="215" selected><spring:message code="click.warning.notification.status"/></option>
						</select>
					</li>
				</c:if>
				<c:if test="${parameterVO.menu_type == 'MENU_STRICTURE'}"> 					
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.equipment.crush"/></a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.monitering"/></a></li>
					<li class="gray">></li>
					<li><spring:message code="click.warning.notification.status"/></li>
				</c:if>
				<c:if test="${parameterVO.menu_type == 'MENU_CCTV'}"> 					
					<li class="gray">></li>
					<li><a href="#">CCTV</a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.monitering"/></a></li>
					<li class="gray">></li>
					<li><spring:message code="click.warning.notification.status"/></li>
				</c:if>
				<c:if test="${parameterVO.menu_type == 'MENU_FEVER'}"> 					
					<li class="gray">></li>
					<li><a href="#">감염관제</a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.monitering"/></a></li>
					<li class="gray">></li>
					<li><spring:message code="click.warning.notification.status"/></li>
				</c:if>
				<c:if test="${parameterVO.menu_type == 'MENU_WATER'}"> 					
					<li class="gray">></li>
					<li><a href="#">침수관제</a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.monitering"/></a></li>
					<li class="gray">></li>
					<li><spring:message code="click.warning.notification.status"/></li>
				</c:if>
				<c:if test="${parameterVO.menu_type == 'MENU_OILMIST'}"> 					
					<li class="gray">></li>
					<li><a href="#">화재관제</a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.monitering"/></a></li>
					<li class="gray">></li>
					<li><spring:message code="click.warning.notification.status"/></li>
				</c:if>
				</ul>
			</div>
			<div class="con-area">
				<div class="content-box">
				<div class="table-detail m-form-table mt10 mb10 font14">
					<form:form id="parameterVO" commandName="parameterVO" name="parameterVO" action="" method="post">
						<input type="hidden" id="pageIndex" name="pageIndex" value="${parameterVO.pageIndex}"/>
						<input type="hidden" id="menuId" name="menuId" value="${parameterVO.menuId}"/>
						<input type="hidden" id="menu_type" name="menu_type" value="${parameterVO.menu_type}"/>
						<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="10"/>
						<div class="table mt10 mb20 font14 no-hover">
							<table>
							<colgroup >
								<col width="12%">
								<col width="20%">
								<col width="12%">
								<col width="20%">
								<col width="12%">
								<col width="*">
							</colgroup>
							<tbody>     
								<tr>
									<th class="center"><spring:message code="click.period"/></th>
									<td colspan="5" >
										<div class="inline-block date">
											<input class="txtDate w130" style="width:140px" type="text" name="start_date" placeholder="" title='<spring:message code="click.input.date"/>' id="start_date" size="10" value="${parameterVO.start_date}" readonly>										
											~
											<input class="txtDate w130" style="width:140px" type="text" name="end_date" placeholder="" title='<spring:message code="click.input.date"/>' id="end_date" size="10" value="${parameterVO.end_date}" readonly>
										</div>
									</td>
								</tr>
								<tr>
																
								<c:if test="${parameterVO.menu_type != 'MENU_RETAIN'}">
									<th scope="col"><spring:message code="click.device.type"/></th>
									<td>
										<select name="device_type" id="device_type" class="w-full">
										<c:if test="${fn:length(deviceTypeList) > 1}">
											<option value=""><spring:message code="click.all"/></option>
										</c:if>
											<c:forEach var="deviceTypeList" items="${deviceTypeList}">
												<option value="${deviceTypeList.device_code}"<c:if test="${parameterVO.device_type == deviceTypeList.device_code}"> selected="selected"</c:if>>
													<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
														${deviceTypeList.device_name}
													</c:if>
													<c:if test="${ locale eq 'en' }">
														${deviceTypeList.device_name_eng}
													</c:if>
												</option>
											</c:forEach>									
										</select>
									</td>
								
								</c:if>
								<c:if test="${parameterVO.menu_type == 'MENU_RETAIN'}"> 	
									<input type="hidden" id="device_type" name="device_type" value="DVTP0006"/>
									<th scope="col"><spring:message code="click.gauge.type"/></th>
									<td>
										<select name="sensor_type" id="sensor_type" class="w-full">
											<option value=""><spring:message code="click.all"/></option>
											<option value="U" <c:if test="${parameterVO.sensor_type == 'U'}">selected</c:if>><spring:message code="click.underground.inclinometer"/></option>
											<option value="B" <c:if test="${parameterVO.sensor_type == 'B'}">selected</c:if>><spring:message code="click.groundwater.level.gauge"/></option>
											<option value="G" <c:if test="${parameterVO.sensor_type == 'G'}">selected</c:if>><spring:message code="click.ground.surface.settlement.gauge"/></option>
											<option value="M" <c:if test="${parameterVO.sensor_type == 'M'}">selected</c:if>><spring:message code="click.strain.gauge"/></option>
											<option value="E" <c:if test="${parameterVO.sensor_type == 'E'}">selected</c:if>><spring:message code="click.ea.road.cell"/></option>
										</select>
									</td>
								</c:if>
								
									<th scope="col"><spring:message code="click.warning.notification.type"/></th>
									<td>
										<select name="event_type" id="event_type" class="w-full">
											<option value=""><spring:message code="click.all"/></option>
											<c:forEach var="alarmTemplateList" items="${alarmTemplateList}">
												<option value="${alarmTemplateList.event_type}"<c:if test="${parameterVO.event_type == alarmTemplateList.event_type}"> selected="selected"</c:if>>
													<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
														${alarmTemplateList.event_name}
													</c:if>
													<c:if test="${ locale eq 'en' }">
														${alarmTemplateList.event_name_eng}
													</c:if>
												</option>
											</c:forEach>
										</select>
									</td>
									<th scope="col"><spring:message code="click.action.status"/></th>
									<td>
										<select name="status" id="status" style="width: 80%;">
											<option value=""><spring:message code="click.all"/></option>
											<option value="0"<c:if test="${parameterVO.status == '0'}"> selected="selected"</c:if>><spring:message code="click.no.action"/></option>
											<option value="1"<c:if test="${parameterVO.status == '1'}"> selected="selected"</c:if>><spring:message code="click.action.required"/></option>
											<option value="2"<c:if test="${parameterVO.status == '2'}"> selected="selected"</c:if>><spring:message code="click.action.completed"/></option>
										</select>
									</td>
								</tr>
								<c:if test="${parameterVO.menu_type == 'MENU_LOCATION' || parameterVO.menu_type == 'MENU_STRICTURE' || parameterVO.menu_type == 'MENU_FEVER'}"> 					
								<tr>
								<th ><spring:message code="click.company.name"/></th>
								<td >
								   <select id="cooperator_id" name="cooperator_id" class="w-full">
									   <option value=""><spring:message code="click.all"/></option>
																	   
										<c:forEach var="companyList" items="${companyList}">
											<option value="${companyList.code}"<c:if test="${parameterVO.cooperator_id == companyList.code}"> selected="selected"</c:if>>
												<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
													${companyList.code_name}
												</c:if>
												<c:if test="${ locale eq 'en' }">
													${companyList.code_name_eng}
												</c:if>
											</option>
										</c:forEach>
								   </select>
								</td>
								<th ><spring:message code="click.job"/></th>
								<td >
								   <select id="job_id" name="job_id" class="w-full">
									   <option value=""><spring:message code="click.all"/></option>
									   <c:forEach var="jobList" items="${jobList}" varStatus="status">
									   <option value="${jobList.code}"<c:if test="${parameterVO.job_id == jobList.code}"> selected="selected"</c:if>>
											<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
									   			${jobList.code_name}
											</c:if>
											<c:if test="${ locale eq 'en' }">
									   			${jobList.code_name_eng}
											</c:if>
									   </option>
									   </c:forEach>
								   </select>
								</td>
									<th class="center"><spring:message code="click.name"/></th>
									<td>
										<input type="text" value="${parameterVO.worker_name}" placeholder="" id="worker_name" name="worker_name" class="w-full">
									</td>
								</tr>
								</c:if>
							</tbody>
							</table>
						</div>
					</form:form>
					<div class="center mt10">
						<button type="button" class="btn btn-blue btn-type2 mr10" onclick="javascript:fn_searchList('1');return false;"><spring:message code="click.search"/></button>
						<button type="button" class="btn btn-main btn-gray-main btn-type2" onclick="javascript:fn_clear_local();return false;"><spring:message code="click.initialization"/></button>
					</div>
				</div>

					<ol class="table-top-con">
						
						
						<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
							<li><spring:message code="click.total.number.cases"/> : <span class="red">${totalCnt}</span><spring:message code='click.counts'/> / <spring:message code="click.no.action.required"/> <spring:message code="click.count"/> : <span class="red" style="color:crimson!important;">${unSolvedCnt}</span><spring:message code='click.counts'/></li>
						</c:if>
						<c:if test="${ locale eq 'en' }">
							<li><spring:message code="click.total.number.cases"/> : <span class="red">${totalCnt}</span> <spring:message code='click.counts'/> / <spring:message code="click.no.action.required"/> <spring:message code="click.count"/> : <span class="red" style="color:crimson!important;">${unSolvedCnt}</span> <spring:message code='click.counts'/></li>
						</c:if>
						
						<li class="float-r">
							<span><spring:message code="click.number.lists"/></span>
							<select name="rd" id="record" class="select01 mb10" onchange="javascript:fn_searchList('1');return false;">
								<option value="10" <c:if test="${parameterVO.recordCountPerPage == 10}">selected="selected"</c:if>>10</option>
								<option value="20" <c:if test="${parameterVO.recordCountPerPage == 20}">selected="selected"</c:if>>20</option>
								<option value="50" <c:if test="${parameterVO.recordCountPerPage == 50}">selected="selected"</c:if>>50</option>
							</select>
						</li>
					</ol>
						<div class="table table-detail m-form-table mt10 mb10 font14">
							<table>
								<caption><span class="blind"><spring:message code="click.list.table"/></span></caption>
								<colgroup >
									<col width="3%">
									<col width="15%">
									<col width="5%">
									<col width="10%">
									<col width="7%">
									<col width="13%">
								<c:if test="${parameterVO.menu_type == 'MENU_LOCATION' || parameterVO.menu_type == 'MENU_STRICTURE' || parameterVO.menu_type == 'MENU_FEVER'}"> 					
									<col width="5%">
									<col width="5%">
									<col width="7%">
								</c:if>
									<col width="15%">
									<col width="15%">
								</colgroup>
								<thead >
									<tr>
										<th scope="col">No</th>
										<th scope="col"><spring:message code="click.date.time.occurrence"/></th>
									<c:if test="${parameterVO.menu_type == 'MENU_RETAIN'}"> 					
										<th scope="col"><spring:message code="click.gauge"/></th>
									</c:if>
									<c:if test="${parameterVO.menu_type != 'MENU_RETAIN'}"> 					
										<th scope="col"><spring:message code="click.device.type"/></th>
									</c:if>
										<th scope="col"><spring:message code="click.warning.notification.type"/></th>
										<th scope="col"><spring:message code="click.action"/></th>
										<th scope="col"><spring:message code="click.notification.content"/></th>
									<c:if test="${parameterVO.menu_type == 'MENU_LOCATION' || parameterVO.menu_type == 'MENU_STRICTURE' || parameterVO.menu_type == 'MENU_FEVER'}"> 					
										<th scope="col"><spring:message code="click.name"/></th>
										<th scope="col"><spring:message code="click.company.name"/></th>
										<th scope="col"><spring:message code="click.job"/></th>
									</c:if>
									
									<c:if test="${parameterVO.menu_type == 'MENU_CCTV'}"> 					
										<th scope="col"><spring:message code="click.channel.number"/></th>
									</c:if>
									<c:if test="${parameterVO.menu_type != 'MENU_CCTV'}"> 					
										<th scope="col"><spring:message code="click.device.number"/> / MAC</th>
									</c:if>
									
										<th scope="col"><spring:message code="click.occurrence.location"/></th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${totalCnt == 0}">
									<c:if test="${parameterVO.menu_type == 'MENU_LOCATION' || parameterVO.menu_type == 'MENU_STRICTURE' || parameterVO.menu_type == 'MENU_FEVER'}"> 					
										<tr>
											<td colspan="11" class="center">
												<spring:message code="click.no.data"/>
											</td>
										</tr>
									</c:if>
									<c:if test="${parameterVO.menu_type != 'MENU_LOCATION' && parameterVO.menu_type != 'MENU_STRICTURE' && parameterVO.menu_type != 'MENU_FEVER'}"> 					
										<tr>
											<td colspan="8" class="center">
												<spring:message code="click.no.data"/>
											</td>
										</tr>
									</c:if>
								</c:if>
								<c:if test="${totalCnt > 0}">
									<c:forEach var="alarmList" items="${alarmList}" varStatus="status">
										<fmt:parseDate var="occure_dt" value="${alarmList.reg_dt}" pattern="yyyy-MM-dd HH:mm:ss"/>
										
										<tr>
											<td class="center">${totalCnt-(parameterVO.recordCountPerPage*(parameterVO.pageIndex-1))-status.index}</td>
											<td class="center"><fmt:formatDate value="${occure_dt}" pattern="yyyy-MM-dd HH:mm" /></td>
											
										<c:if test="${parameterVO.menu_type == 'MENU_RETAIN'}">
											<td class="center">
											<c:if test="${alarmList.sensor_type == 'U'}"> <spring:message code="click.underground.inclinometer"/> </c:if>
											<c:if test="${alarmList.sensor_type == 'B'}"> <spring:message code="click.groundwater.level.gauge"/> </c:if>
											<c:if test="${alarmList.sensor_type == 'G'}"> <spring:message code="click.ground.surface.settlement.gauge"/> </c:if>
											<c:if test="${alarmList.sensor_type == 'M'}"> <spring:message code="click.strain.gauge"/> </c:if>
											<c:if test="${alarmList.sensor_type == 'E'}"> <spring:message code="click.ea.road.cell"/> </c:if>
										</c:if>
										<c:if test="${parameterVO.menu_type != 'MENU_RETAIN'}"> 
											<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
												<td class="center">${alarmList.device_name}</td>
											</c:if>
											<c:if test="${ locale eq 'en' }">
												<td class="center">${alarmList.device_name_eng}</td>
											</c:if>
										</c:if>
										
											<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
												<td class="center">${alarmList.event_name}</td>
											</c:if>
											<c:if test="${ locale eq 'en' }">
												<td class="center">${alarmList.event_name_eng}</td>
											</c:if>
																																										
											<c:if test="${alarmList.status == '0' || alarmList.status == '1'}"> 
												<td class="center red"> 
												<a href="#"  onclick="javascript:fn_openAlarmAction('${alarmList.event_id}', '${alarmList.status}');return false;">
													 <c:if test="${alarmList.status == '0'}"> <spring:message code="click.no.action"/> </c:if>
													 <c:if test="${alarmList.status == '1'}"> <spring:message code="click.action.required"/> </c:if>
												 </a>
												</td>
											</c:if>
											<c:if test="${alarmList.status != '0' && alarmList.status != '1'}"> 
												<td class="center blue">
												<a href="#"  onclick="javascript:fn_openAlarmAction('${alarmList.event_id}', '${alarmList.status}');return false;"><spring:message code="click.action.completed"/></a>
												</td>
											</c:if>
																				
											<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
												<td class="center">${alarmList.event_msg}</td>
											</c:if>
											<c:if test="${ locale eq 'en' }">
												<td class="center">${alarmList.event_msg_eng}</td>
											</c:if>
											
										<c:if test="${parameterVO.menu_type == 'MENU_LOCATION' || parameterVO.menu_type == 'MENU_STRICTURE' || parameterVO.menu_type == 'MENU_FEVER'}">
										
											<c:if test="${ empty alarmList.worker_name}">
												<td class="center">-</td>
											</c:if>
											<c:if test="${ !empty alarmList.worker_name}">
												<td class="center">${alarmList.worker_name}</td>
											</c:if>
																															
											<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
												<c:if test="${ empty alarmList.cooperator_name}">
													<td class="center">-</td>
												</c:if>
												<c:if test="${ !empty alarmList.cooperator_name}">
													<td class="center">${alarmList.cooperator_name}</td>
												</c:if>
												
												<c:if test="${ empty alarmList.job_name}">
													<td class="center">-</td>
												</c:if>
												<c:if test="${ !empty alarmList.job_name}">
													<td class="center">${alarmList.job_name}</td>
												</c:if>
											</c:if>
											<c:if test="${ locale eq 'en' }">												
												<c:if test="${ empty alarmList.cooperator_name_eng}">
													<td class="center">-</td>
												</c:if>
												<c:if test="${ !empty alarmList.cooperator_name_eng}">
													<td class="center">${alarmList.cooperator_name_eng}</td>
												</c:if>
												
												<c:if test="${ empty alarmList.job_name_eng}">
													<td class="center">-</td>
												</c:if>
												<c:if test="${ !empty alarmList.job_name_eng}">
													<td class="center">${alarmList.job_name_eng}</td>
												</c:if>
											</c:if>
										</c:if>
										
										<c:if test="${parameterVO.menu_type == 'MENU_CCTV'}"> 					
											<td class="center"> ${alarmList.mac_addr} </td>
										</c:if>
										<c:if test="${parameterVO.menu_type != 'MENU_CCTV'}"> 					
											<td class="center">${alarmList.device_no} / ${alarmList.mac_addr} </td>
										</c:if>
											<td class="center"> 
										<c:if test="${parameterVO.menu_type == 'MENU_CCTV'}">
											<c:if test="${!empty alarmList.building_id}">
												${alarmList.building_id}
											</c:if>	
											<c:if test="${alarmList.file_id > 0}">
												<a href="#" onclick="javascript:fn_alarmCctvPlayPopup('${alarmList.event_id}');return false;" class="cctv-play-btn"><spring:message code="click.cctv.play"/></a>
											</c:if>	
											<c:if test="${empty alarmList.building_id && alarmList.file_id <= 0}">
												-
											</c:if>	
											
										</c:if>	
										<c:if test="${parameterVO.menu_type != 'MENU_CCTV'}"> 					
											  <a href="#"  onclick="javascript:fn_goLocationMonitoring('${parameterVO.menu_type}', '${alarmList.building_id}', '${alarmList.zone_id}', '${alarmList.cell_id}');return false;">
											<c:if test="${!empty alarmList.building_name}">
												<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
													${alarmList.building_name} / ${alarmList.zone_name} / ${alarmList.cell_name} 
												</c:if>
												<c:if test="${ locale eq 'en' }">
													${alarmList.building_name_eng} / ${alarmList.zone_name_eng} / ${alarmList.cell_name_eng} 
												</c:if>
											</c:if>	
											<c:if test="${empty alarmList.building_name}">
												-
											</c:if>	
											</a>
										</c:if>
											
											</td>									
										</tr>
									</c:forEach>
									</c:if>
								</tbody>
							</table>
						</div>
					<!--테이블하단 버튼 모음-->
					<div class="float-r mr10">
						<button type="button" class="btn btn-green btn-type3 mr10" onclick="javascript:fn_downloadExcel();return false;"><spring:message code="click.excel.download"/></button>
					</div>
					<!--테이블 하단 버튼 모음 끝-->

				<!--페이징 시작-->
				<div class="page-nav-wrap cb" style="margin-top: 50px;">
					<div class="pageNaviList">
						${pagingList}
					</div>                            
				</div>
				<!--페이징 끝-->
				</div>
			</div><!--본문 영역 끝-->
