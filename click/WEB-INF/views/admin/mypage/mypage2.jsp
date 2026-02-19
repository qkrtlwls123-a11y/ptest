<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


	<script type="text/javascript">
	
	$(function(){
		genRowspan();
	})
	
	// 탭변경 이벤트
	function fn_changeTab(index){
		var params = $("form[id=parameterVO]").serialize(); 
		$.ajax({
			url : "${pageContext.request.contextPath}/mypage" + index + ".do",
			type : "POST",
			data: params,
			success : function(result) {
				$(".con-wrap").html(result)
			}
		});
	}
	
	$('.on').click(function(){
		$(this).attr('checked', true );
		$(this).siblings('.off').attr("checked", false );
	});
	
	
	$('.off').click(function(){
		$(this).attr("checked", true );
		$(this).siblings('.on').attr("checked", false );
	});
	
	function genRowspan(){
	    $(".menuSpan").each(function(i,e) {
	    	var tmpTxt = $(this).text();
	        var rows = $('.menuSpan:contains('+tmpTxt+')');
	        //alert( " index : " + i +  "  /  rows : " + rows );
	        if ( rows.length > 1) {
	            rows.eq(0).attr("rowspan", rows.length);
	            rows.not(":eq(0)").remove();
	        }
		});
	}
	
	// 이벤트 알람 수정
	function fn_eventAlarmUpdate(){
		
		var sEventType = [];
		var sNotiYn = [];
		
		// radio
		$('input[id*="event"]:checked').each(function(){
			sEventType.push($(this).data('eventtype'));
			sNotiYn.push($(this).val());
		});
		
		$('#arrEventType').val(sEventType);
		$('#arrNotiYn').val(sNotiYn);
		
		var params = $("form[id=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/updateMypageEventAlarm.json",
			type : "POST",
			data: params,
			success : function(result) {
				if(result.resultCode == 'success'){
					openDefaultPopup("loginPopup", '<spring:message code="click.been.edited"/>');
				}
			}
		});
	}
	</script>


	<form:form id="parameterVO" commandName="parameterVO" name="parameterVO" action="" method="post">
		<input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
		<input type="hidden" id="menuId" name="menuId" value="${parameterVO.menuId}"/>
		<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="10"/>
		<input type="hidden" id="arrEventType" name="arrEventType" value=""/>
		<input type="hidden" id="arrNotiYn" name="arrNotiYn" value=""/>
	</form:form>
			<div class="page-navigation">
				<ul>
					<li><a href="#">Home</a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.my.page"/></a></li>
				</ul>
			</div>
			<div class="con-area">
				<ul class="sub-tab-style01">
					<li><a href="#" onClick="javascript:fn_changeTab('1');"><spring:message code="click.personal.information.modification"/></a></li>
					<li><a href="#" class="active"><spring:message code="click.notification.settings"/></a></li>
				</ul>
				<div class="content-box">
					<div class="table mt10 mb20 font14">
						<table>
							<colgroup class="">
								<col width="20%">
								<col width="45%">
								<col width="35%">
							</colgroup>
							<thead class="">
								<tr>
									<th scope="col"><spring:message code="click.notification.category"/></th>
									<th scope="col"><spring:message code="click.notification.details"/></th>
									<th scope="col"><spring:message code="click.whether.use.notifications"/></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="eventList" items="${eventList}" varStatus="status">
								<tr>
									<c:if test="${ locale eq 'ko_kr' || locale eq 'ko_KR' }">
										<td class="center menuSpan">${eventList.menu_name}</td>
		                                <td class="center">${eventList.event_name}</td>
									</c:if>
									<c:if test="${ locale eq 'en' }">
										<td class="center menuSpan">${eventList.menu_name_eng}</td>
		                                <td class="center">${eventList.event_name_eng}</td>
									</c:if>
								
	                                <td class="center">
	                                    <!--온오프 토글스위치-->
	                                    <div class="switch-field">
	                                        <input type="radio" class="on" id="event1_${status.index}" name="event${status.index}" data-menuId="${eventList.menu_id}" data-eventType="${eventList.event_type}" value="Y" <c:if test="${eventList.noti_yn == 'Y'}">checked</c:if>/>
	                                        <label for="event1_${status.index}">ON</label>
	                                        <input type="radio" class="off" id="event2_${status.index}" name="event${status.index}" data-menuId="${eventList.menu_id}" data-eventType="${eventList.event_type}" value="N" <c:if test="${eventList.noti_yn == 'N'}">checked</c:if>/>
	                                        <label for="event2_${status.index}">OFF</label>
	                                    </div>
	                                    <!--온오프 토글스위치 끝-->
	                                </td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="center mt10 mb30">
						<button type="button" class="btn btn-blue btn-type2 mr10" onClick="javascript:fn_eventAlarmUpdate()"><spring:message code="click.edit"/></button>
					</div>
				</div>
			</div><!--본문 영역 끝-->
