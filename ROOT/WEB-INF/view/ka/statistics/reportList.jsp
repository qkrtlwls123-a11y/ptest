<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://www.springframework.org/tags/form" prefix="form"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge; charset=UTF-8" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<title>인성진단시스템</title>
	<jsp:include page="/WEB-INF/view/ka/include/head.jsp" />
		
	<script type='text/javascript' src="/resources/bootstrap/js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="/resources/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
	var Survey = {
			surveyParams : {},
			getStatisticsList : function(pageNo){ //리스트 데이터 로딩
				 if($("#s_survey_nm").val() != "" && $("#s_survey_nm").val() != null) {
					Survey.surveyParams["s_survey_nm"] = $("#s_survey_nm").val();
				}else{
					Survey.surveyParams["s_survey_nm"] = "";
				}
				if($("#s_company_code").val() != "" && $("#s_company_code").val() != null) {
					Survey.surveyParams["s_company_code"] = $("#s_company_code").val();
				}else{
					Survey.surveyParams["s_company_code"] = "";
				}
				if($("#s_recruit_survey_id").val() != "" && $("#s_recruit_survey_id").val() != null) {
					Survey.surveyParams["s_recruit_survey_id"] = $("#s_recruit_survey_id").val();
				}else{
					Survey.surveyParams["s_recruit_survey_id"] = "";
				}
				if($("#s_user_nm").val() != "" && $("#s_user_nm").val() != null) {
					Survey.surveyParams["s_user_nm"] = $("#s_user_nm").val();
				}else{
					Survey.surveyParams["s_user_nm"] = "";
				}
				if(pageNo != undefined && pageNo != null && pageNo != "") {
					Survey.surveyParams["pageNo"] = pageNo;
				}else{
					Survey.surveyParams["pageNo"] = 1;
				}

				if(pageNo != undefined && pageNo != null && pageNo != "") {
					Survey.surveyParams["pageNo"] = pageNo;
				}else{
					Survey.surveyParams["pageNo"] = 1;
				}
				var url = "/ka/statistics/getStatisticsList.do";

				$.ajax({
					url			: url,
					type		: "post",
					data		: $.param(Survey.surveyParams),
					success		: function(data){
						Survey.setStatisticsList(data);
						CODE.createPaging(data,'Survey.getStatisticsList','pagingArea');
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			setStatisticsList : function(localdata){ //로딩된 데이터를 받아서 그리드 생성
				$("#survey_list").html("");
				var tag = "";
				$.each(localdata.list, function(idx, item){
		            tag += 	"<tr class=\"listAll\">";
		            tag +=  "<td>"+(localdata.totalCount - (localdata.numPerPage*(localdata.pageNo-1))-idx)+"</td>";
		            if(item.company_nm != undefined && item.company_nm != null){
			            tag += 	"<td>"+item.company_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.recruit_survey_nm != undefined && item.recruit_survey_nm != null){
		            	tag += 	"<td>"+item.recruit_survey_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.user_nm != undefined && item.user_nm != null){
		            tag += 	"<td>"+item.user_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.year_birth != undefined && item.year_birth != null){
			            tag += 	"<td>"+item.year_birth+"</td>";
			            }else{
			            	tag += 	"<td></td>";
			            }
		            if(item.hp != undefined && item.hp != null){
			            tag += 	"<td>"+item.hp+"</td>";
			            }else{
			            	tag += 	"<td></td>";
			            }
		            if(item.summary_step != undefined && item.summary_step != null){
		            	if(item.summary_step == 7){
		            		tag += 	"<td>설문완료</td>";
		            	}else{
		            		tag += 	"<td>설문중</td>";
		            	}
		            }else{
		            	tag += 	"<td>시작전</td>";
		            }
		/*             
		            if(item.area != undefined && item.area != null){
		            tag += 	"<td>"+ item.area +"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.belong_nm != undefined && item.belong_nm != null){
		            tag += 	"<td>"+ item.belong_nm +"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.position_nm != undefined && item.position_nm != null){
		            tag += 	"<td>"+ item.position_nm +"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.job_nm != undefined && item.job_nm != null){
		            tag += 	"<td>"+ item.job_nm +"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.duty_nm != undefined && item.duty_nm != null){
		            tag += 	"<td>"+ item.duty_nm +"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.gender_nm != undefined && item.gender_nm != null){
		            tag += 	"<td>"+ item.gender_nm +"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.survey_id != undefined && item.survey_id != null && item.survey_id != "" && item.responder_id != undefined && item.responder_id != null && item.responder_id != "" && item.summary_step == 7){
	            	tag += 	"<td><div class=\"ingrid\"><a href=\"javascript:Survey.reportPop3('" + item.survey_id + "','" + item.responder_id + "');\">일반리포트</a> <a href=\"javascript:Survey.reportPop2('" + item.survey_id + "','" + item.responder_id + "');\">유사구성원리포트</a> <a href=\"javascript:Survey.reportPop1('" + item.survey_id + "','" + item.responder_id + "');\">대표&유사리포트</a></div></td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            tag += 	'</tr>';
					}
	 */	        if(item.complete_dt != undefined && item.complete_dt != null){
		            	tag += 	"<td>"+item.complete_dt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
	 
		            if(item.recruit_survey_id != undefined && item.recruit_survey_id != null && item.recruit_survey_id != "" && item.responder_id != undefined && item.responder_id != null && item.responder_id != "" && item.summary_step == 7){
		            	tag += 	"<td><div class=\"ingrid\"><a href=\"javascript:Survey.reportPop1('" + item.recruit_survey_id + "','" + item.responder_id + "');\">대표&유사리포트</a> <a href=\"javascript:Survey.reportPop2('" + item.recruit_survey_id + "','" + item.responder_id + "');\">유사구성원리포트</a> <a href=\"javascript:Survey.reportPop3('" + item.recruit_survey_id + "','" + item.responder_id + "');\">일반리포트</a></div></td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            tag += 	'</tr>';
				});
				$("#survey_list").append(tag);
			},
			statisticsAction : function(){ //대표구성원유사도처리
				let s_survey_id = $("#s_survey_id").val();
				if(s_survey_id == undefined || s_survey_id == null || s_survey_id == "" ){
					alert("먼저 인적성 검사를 선택하여 주시기 바랍니다.");
					return;
				}
				let params = {};
				params.s_survey_id = s_survey_id;
				
				var url = "/ka/statistics/goStatisticsAction.do";
				$.ajax({
					url			: url,
					type		: "post",
					data		: $.param(params),
					success		: function(data){
						if(data.rcode == 200){
							alert("정상적으로 진단결과가 생성 되었습니다.");
							Survey.getStatisticsList(1);
						}else{
							alert("진단결과 생성 문제가 있었습니다.\n확인 후 다시 실행하여 주시기바랍니다.");
						}
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			reportPop1:function (survey_id,user_id){
				if(confirm("대표&유사리포트를 확인 하시겠습니까?")){
					//let s_survey_id = $("#s_survey_id").val();
					//if(s_survey_id == undefined || s_survey_id == null || s_survey_id == "" ){
					//	alert("먼저 인적성 검사를 선택하여 주시기 바랍니다.");
					//	return;
					//}
					$("#survey_id").val(survey_id);
					$("#user_id").val(user_id);
					var form = document.getElementById("SurveyListForm");
					form.action="http://15.165.221.173/oz80/html5_canvas1.jsp";
					form.submit();
				}
			},
			reportPop2:function (survey_id,user_id){
				if(confirm("유사구성원리포트를 확인 하시겠습니까?")){
					//let s_survey_id = $("#s_survey_id").val();
					//if(s_survey_id == undefined || s_survey_id == null || s_survey_id == "" ){
					//	alert("먼저 인성 검사를 선택하여 주시기 바랍니다.");
					//	return;
					//}
					$("#survey_id").val(survey_id);
					$("#user_id").val(user_id);
					var form = document.getElementById("SurveyListForm");
					form.action="http://15.165.221.173/oz80/html5_canvas2.jsp";
					form.submit();
				}
			},
			reportPop3:function (survey_id,user_id){
				if(confirm("일반리포트를 확인 하시겠습니까?")){
					//let s_survey_id = $("#s_survey_id").val();
					//if(s_survey_id == undefined || s_survey_id == null || s_survey_id == "" ){
					//	alert("먼저 인성 검사를 선택하여 주시기 바랍니다.");
					//	return;
					//}
					$("#survey_id").val(survey_id);
					$("#user_id").val(user_id);
					var form = document.getElementById("SurveyListForm");
					form.action="http://15.165.221.173/oz80/html5_canvas3.jsp";
					form.submit();
				}
			}
	}
		$(document).ready(function(){
			Survey.getStatisticsList(1);
		});
	</script>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/view/ka/include/topMenu.jsp" />
	<div id="container">	

		<div id="content" class="admin_con">
			<h2>인성진단 리포트</h2>
			<form id="SurveyListForm" action="http://15.165.221.173/oz80/html5_canvas1.html" target="_blank" method="get">
				<input type="hidden" name="survey_id" id="survey_id" value="">
				<input type="hidden" name="user_id" id="user_id" value="">
				<div class="mem_search">
					<table>
						<tbody>
							<%-- <tr>
								<th>진단검사선택</th>
								<td>
									<select id="s_survey_id" name="s_survey_id" onchange="Survey.getStatisticsList(1)">
									<option value="">전체</option>
									<c:forEach var="item" items="${surveyList}">
										<option value="${item.id}">${item.survey_nm}</option>
									</c:forEach>
									</select>
								</td>
								<th>소속회사</th>
								<td>
									<select id="s_company_code" name="s_company_code" onchange="Survey.getStatisticsList(1)">
									<option value="">전체</option>
									<c:forEach var="item" items="${companyGroup}">
										<option value="${item.code}">${item.code_nm}</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							 --%><tr>
								<th>채용공고선택</th>
								<td>
									<select id="s_recruit_survey_id" name="s_recruit_survey_id" onchange="Survey.getStatisticsList(1)">
									<option value="">전체</option>
									<c:forEach var="item" items="${recruitSurveyList}">
										<option value="${item.id}">${item.recruit_nm}</option>
									</c:forEach>
									</select>
								</td>
								<th>이름</th>
								<td>
									<input type="text" id="s_user_nm" name="s_user_nm"  class="w300" maxlength="20" onkeypress="if(event.keyCode == 13) { Survey.getStatisticsList(1); return false;}"/>
								</td>
							</tr>
						</tbody>
					</table>
					<div>
						<input type="button" value="조회" onclick="Survey.getStatisticsList(1)"/>
					</div>
				</div>
			</form>
			<h3>진단결과 리스트</h3>
			<!-- <div class="btn_space_listT">
				<input type="button" value="진단결과생성" onclick="Survey.statisticsAction()"/>
				<input type="button" value="엑셀다운로드" onclick="Survey.downloadExcel()"/>
			</div> -->
		
			<div>
				<table class="table table-striped thcss">
			          <thead>
			            <tr>
			              <th>No</th>
			              <th>소속회사</th>
			              <th>채용공고</th>
			              <th>이름</th>
			              <th>생년월일</th>
			              <th>연락처</th>
			              <th>검사상태</th>
			              <th>검사완료일</th>
			              <th>진단리포트보기</th>
			       <!-- <th>회사명</th>
			              <th>지역</th>
			              <th>소속</th>
			              <th>직위</th>
			              <th>직군</th>
			              <th>직무</th>
			              <th>성별</th>
			              <th>설문작성일</th>
			              <th>ACTION</th>
 -->			            </tr>
			          </thead>
			          <tbody id="survey_list"></tbody>
				 </table>
				 <div id="pagingArea" style="position:relative;text-align:center; height: 40px;"></div>
			</div>
			
			<p class="mtop10"></p>

		</div>
		
	</div>
	<jsp:include page="/WEB-INF/view/ka/include/foot.jsp" />
</div>
</body>
</html>