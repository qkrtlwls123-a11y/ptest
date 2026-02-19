<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<script type="text/javascript">
	var device_type = "";
	var device_product_id = "";
	
	$(document).ready(function(){
		if("" != device_type){
			fn_changeDeviceCode();
		}
		
		$("input").keydown(function(key) {
			if (key.keyCode == 13) {
				fn_searchList('1');
				return false;
			}
		});
	});
	
	function fn_delete(){
		var checkCount = $('input:checkbox[name="checkList"]:checked').length;
		if(checkCount > 0){
			if( "${locale}" == "ko_kr" || "${locale}" == "ko_KR" ){
				openConfirmPopup("<spring:message code='click.delete.deviceList.msg'/> " + checkCount + "<spring:message code='click.counts'/>", '<spring:message code="click.confirm"/>', "fn_delete_device");
			}else{
				openConfirmPopup("<spring:message code='click.delete.deviceList.msg'/> " + checkCount + " <spring:message code='click.counts'/>", '<spring:message code="click.confirm"/>', "fn_delete_device");
			}
			
		}else{
			openDefaultPopup("loginPopup", '<spring:message code="click.no.data.selected"/>');
		}	
	}
	
	function fn_delete_device(){
		var searchId = "";
		var searchText = "";
		var checkLength = 0;
		$('input:checkbox[name="checkList"]').each(function(i){
			if($(this).is(":checked")){
				searchId += $(this).val();
				searchText += $(this).attr("devicetype");
				
				checkLength++;
				if($("input:checkbox[name='checkList']:checked").length != checkLength){
					searchId += "/";
					searchText += "/";
				}
			}
		});
		$("#searchId").val(searchId);
		$("#searchText").val(searchText);
						
		var params = $("form[name=parameterVO]").serialize();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/deleteDevice.json",
			type : "POST",
			data: params,
			success : function(result) {
				if(result.resultCode == "success"){
					var params2 = $("form[name=parameterVO]").serialize(); 
					$.ajax({
						url : "${pageContext.request.contextPath}/deviceList.do",
						type : "POST",
						data: params2,
						success : function(result) {
							fn_closePopup();
							$(".con-wrap").html(result);
						}
					});
				}else if(result.resultCode == "fail"){
					openDefaultPopup("loginPopup", result.message);
				}else if(result.resultCode == "mapping_fail"){
					fn_closePopup();
					openDefaultPopup("loginPopup","<spring:message code='click.delete.existing.device'/>" );
				}
			}
		});
	}
	
	function fn_deviceRegi(){
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/deviceRegi.do",
			type : "POST",
			data: params,
			success : function(result) {
				$(".con-wrap").html(result)
			}
		});
	}
	
	function fn_detail(idx){
		var params = $("form[name=parameterVO]").serialize(); 
		$.ajax({
			url : "${pageContext.request.contextPath}/deviceDetail.do",
			type : "POST",
			data: params,
			success : function(result) {
				$(".con-wrap").html(result)
			}
		});
	}

	function fn_changeDeviceCode(){
		$("#device_code").val($("#device_type").val());
		var params = $("form[name=parameterVO]").serialize(); 
		$.ajax({
			url : "${pageContext.request.contextPath}/selectSiteDeviceName.json",
			type : "POST",
			data: params,
			success : function(result) {
				if(result.resultCode == "success"){
					var htmlString ='<option value=""><spring:message code="click.product.name.selection"/></option>';
					for(var i=0;i<result.deviceNameList.length;i++){
						if(device_product_id == result.deviceNameList[i].device_product_id){
							htmlString += '<option value="'+result.deviceNameList[i].device_product_id+'" selected>'+result.deviceNameList[i].product_name+'</option>';
						}else{
							htmlString += '<option value="'+result.deviceNameList[i].device_product_id+'">'+result.deviceNameList[i].product_name+'</option>';
						}
					}
					$("#device_product_id").html(htmlString);
				}else{
					openDefaultPopup("loginPopup", result.message);
				}
			}
		});
	}

	function fn_changeProductName(){
		$("#product_name").val($("#device_name option:selected").text());
	}
	
	function fn_checkAllDevice(){
		if($("#checkAllDevice").is(":checked")){
			$('input:checkbox[name="checkList"]').prop("checked", true);
		}else{
			$('input:checkbox[name="checkList"]').prop("checked", false);
		}
	}
	
	function fn_downloadExcel(){
		var prams = $("form[name=parameterVO]").serialize(); 
		window.open("${pageContext.request.contextPath}/download/downloadDevice.excel?"+prams, "EXCEL Download");
	}
	
	function fn_deviceDetail(idx, deviceType, deviceProductId){
		$("#device_id").val(idx);
		$("#device_code").val(deviceType);
		$("#detail_device_product_id").val(deviceProductId);
		
		var params = $("form[name=parameterVO]").serialize(); 
		$.ajax({
			url : "${pageContext.request.contextPath}/deviceDetail.do",
			type : "POST",
			data: params,
			success : function(result) {
				$(".con-wrap").html(result)
			}
		});
	}
	
	function fn_deviceHistoryList(idx){
		$('#pageIndex2').val(idx);
		var params = $("form[name=deviceHistoryVO]").serialize();
		openDeviceHistoryPopup("deviceHistoryPopup", params);
	}
	
	function fn_order(orderColumn, orderType){
		$("#order_column").val(orderColumn);
		$("#order_type").val(orderType);
		fn_searchList('1');
	}
	</script>

		<div class="page-navigation">
			<ul>
				<li><h3 style="color:black;">관리자 목록</h3></li>
				<li><a href="#">Home</a></li>
				<li class="gray">></li>
				<li><a href="#">시스템 관리</a></li>
				<li class="gray">></li>
				<li><a href="#">관리자 설정</a></li>
				<li class="gray">></li>
				<li><a href="#">관리자 목록</a></li>
			</ul>
		</div>
		<div class="con-area">
			<div class="content-box">
				<div class="table table-detail m-form-table mt10 mb10 font14">
					<form:form id="parameterVO" commandName="parameterVO" name="parameterVO" action="" method="post">
					<table>
					<caption><span class="blind">form</span></caption>
					<colgroup >
						<col width="12%">
						<col width="">
						<col width="12%">
						<col width="">
					</colgroup>
					<tbody>	
						<tr>
							<th>고객사 명</th>
							<td >
								<div class="inline-block w-full" style="width:99%;">
									<select name="device_type" id="device_type" class="w-full" onchange="javascript:fn_changeDeviceCode();return false;">
										<option value=""><spring:message code="click.all"/></option>
									</select>
								</div>
							</td>
							<th>사이트 명</th>
							<td >
								<div class="inline-block w-full" style="width:99%;">
									<select id="device_product_id" name="device_product_id" class="w-full mr10">
										<option value=""><spring:message code="click.all"/></option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<th>관리자 구분</th>
							<td>
								<div class="inline-block w-full" style="width:99%;">
									<select id="device_use_yn" name="device_use_yn" class="w-full">
										<option value=""><spring:message code="click.all"/></option>
										<option value="">사이트 관리자</option>
										<option value="">부 관리자</option>
									</select>
								</div>
							</td>
							<th><spring:message code="click.search.word"/></th>
							<td >
								<input type="text" id="search_word" name="search_word" value="" placeholder="" class="w-full" style="width:99%;">
							</td>
						</tr>
						
					</tbody>
					</table>
					
					</form:form>
						
					<div class="center mt10">
					<button type="button" class="btn btn-blue btn-type2 mr10" onclick="javascript:fn_searchList('1');return false;"><spring:message code="click.search"/></button>
					<button type="button" class="btn btn-main btn-gray-main btn-type2" onclick="javascript:fn_clear();return false;"><spring:message code="click.initialization"/></button>
					</div>
				</div>

				<ol class="table-top-con">
					<li>전체 3건이 검색되었습니다.</li>
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
								<col width="5%">
								<col width="5%">
								<col width="15%">
								<col width="10%">
								<col width="15%">
								<col width="10%">
								<col width="15%">
							</colgroup>
							<thead >
								<tr>
									<th scope="col"><input type="checkbox" id="checkAllDevice" onchange="javascript:fn_checkAllDevice();return false;"></th>
									<th scope="col">관리자 구분</th>
									<th scope="col">성명</th>
									<th scope="col">아이디</th>
									<th scope="col">연락처</th>
									<th scope="col">이메일</th>
									<th scope="col">등록일</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="center">
										<input type="checkbox" name="checkList" deviceType="1" value="1">
									</td>
									<td class="center">사이트 관리자</td>
									<td class="center"><a href="#" class="txtblue" onclick="">사이트 관리자1</a></td>
									<td class="center"><a href="#" class="txtblue" onclick="">siteadmin</a></td>
									<td class="center">010-1111-2222
									</td>
									<td class="center">siteAdmin@test.com</td>
									<td class="center">2021-09-01</td>
								</tr>
								<tr>
									<td class="center">
										<input type="checkbox" name="checkList" deviceType="1" value="1">
									</td>
									<td class="center">부 관리자</td>
									<td class="center"><a href="#" class="txtblue" onclick="">부 관리자1</a></td>
									<td class="center"><a href="#" class="txtblue" onclick="">sitesubadmin1</a></td>
									<td class="center">010-1111-2222
									</td>
									<td class="center">sitesubadmin1@test.com</td>
									<td class="center">2021-09-20</td>
								</tr>
								<tr>
									<td class="center">
										<input type="checkbox" name="checkList" deviceType="1" value="1">
									</td>
									<td class="center">부 관리자</td>
									<td class="center"><a href="#" class="txtblue" onclick="">부 관리자2</a></td>
									<td class="center"><a href="#" class="txtblue" onclick="">sitesubadmin2</a></td>
									<td class="center">010-3333-3333
									</td>
									<td class="center">sitesubadmin2@test.com</td>
									<td class="center">2021-09-20</td>
								</tr>
							</tbody>
						</table>
					</div>
				<!--테이블하단 버튼 모음-->
				<div class="float-r mr10">
					<button type="button" class="btn btn-blue btn-type3 mr80" onclick="javascript:fn_changePage('5');return false;">+ 관리자 등록</button>
				</div>
				<!--테이블 하단 버튼 모음 끝-->
				<!--페이징 시작-->
				<div class="page-nav-wrap cb" style="margin-top: 50px;">
					<div class="pageNaviList">
						${pagingList}
					</div>                            
				</div><!--페이징 끝-->
			</div>
		</div><!--본문 영역 끝-->
