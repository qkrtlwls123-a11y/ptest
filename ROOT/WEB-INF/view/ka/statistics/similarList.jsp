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
				if($("#s_survey_id").val() != "" && $("#s_survey_id").val() != null) {
					Survey.surveyParams["s_survey_id"] = $("#s_survey_id").val();
				}else{
					Survey.surveyParams["s_survey_id"] = "";
				}
				if($("#s_user_nm").val() != "" && $("#s_user_nm").val() != null) {
					Survey.surveyParams["s_user_nm"] = $("#s_user_nm").val();
				}else{
					Survey.surveyParams["s_user_nm"] = "";
				}
				if($("#s_representative_yn").val() != "" && $("#s_representative_yn").val() != null) {
					Survey.surveyParams["s_representative_yn"] = $("#s_representative_yn").val();
				}else{
					Survey.surveyParams["s_representative_yn"] = "";
				}
				if($("#s_similar_yn").val() != "" && $("#s_similar_yn").val() != null) {
					Survey.surveyParams["s_similar_yn"] = $("#s_similar_yn").val();
				}else{
					Survey.surveyParams["s_similar_yn"] = "";
				}

				if(pageNo != undefined && pageNo != null && pageNo != "") {
					Survey.surveyParams["pageNo"] = pageNo;
				}else{
					Survey.surveyParams["pageNo"] = 1;
				}
				var url = "/ka/statistics/getHolderStatisticsList.do";

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
		            if(item.similar_yn == "Y"){
		            	tag += 	"<td><input type=\"checkbox\" checked=\"checked\" onclick=\"Survey.surveyAction('"+item.survey_id+"','"+item.responder_id+"','similar',this)\"/></td>";
		            }else{
		            	tag += 	"<td><input type=\"checkbox\" onclick=\"Survey.surveyAction('"+item.survey_id+"','"+item.responder_id+"','similar',this)\"/></td>";
		            }
		            if(item.survey_nm != undefined && item.survey_nm != null){
		            	tag += 	"<td>"+item.survey_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.user_nm != undefined && item.user_nm != null){
		            tag += 	"<td>"+item.user_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.company_nm != undefined && item.company_nm != null){
		            tag += 	"<td>"+ item.company_nm +"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
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
		            if(item.va1 != undefined && item.va1 != null){
		            tag += 	"<td>"+item.va1+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.va2 != undefined && item.va2 != null){
		            tag += 	"<td>"+item.va2+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.va3 != undefined && item.va3 != null){
		            tag += 	"<td>"+item.va3+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.va4 != undefined && item.va4 != null){
		            tag += 	"<td>"+item.va4+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.iso != undefined && item.iso != null){
		            	tag += 	"<td>"+item.iso+"</td>";
		            }else{
		            	tag += 	"<td>0</td>";
		            }
		            if(item.pas != undefined && item.pas != null){
		            	tag += 	"<td>"+item.pas+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.rkt != undefined && item.rkt != null){
		            	tag += 	"<td>"+item.rkt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.ect != undefined && item.ect != null){
		            	tag += 	"<td>"+item.pas+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.nar != undefined && item.nar != null){
		            	tag += 	"<td>"+item.nar+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.pow != undefined && item.pow != null){
		            	tag += 	"<td>"+item.pow+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.sst != undefined && item.sst != null){
		            	tag += 	"<td>"+item.sst+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.ats != undefined && item.ats != null){
		            	tag += 	"<td>"+item.ats+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            //if(item.edit_dt != undefined && item.edit_dt != null){
		            //	tag += 	"<td>"+item.edit_dt+"</td>";
		            //}else{
		            //	tag += 	"<td></td>";
		            //}
		            //tag += 	"<td class=\"survey_id"+item.id+"\"><div class=\"ingrid\"><a href=\"javascript:Inquiry.getInquiryList(1,'"+item.id+"');\">질의보기</a> <a href=\"javascript:Survey.surveyInfoPop('modify','" + item.id + "');\">수정</a></div></td>";
		            tag += 	'</tr>';
				});
				$("#survey_list").append(tag);
			},
			surveyAction : function(survey_id,responder_id,action_mode,obj){ //유사구성원처리
				let params = {};
				params.survey_id = survey_id;
				params.responder_id = responder_id;
				params.action_mode = action_mode;
				
				if(action_mode == "similar"){
					if($(obj).is(":checked") == true){
						params.similar_yn = "Y";
					}else{
						params.similar_yn = "N";
					}
				}
				
				if(action_mode == "representative" || action_mode == "similar"){//대표구성원 유사구성원
					var url = "/ka/statistics/goMemberAction.do";
					$.ajax({
						url			: url,
						type		: "post",
						data		: $.param(params),
						success		: function(data){
							if(data.rcode == 200){
								alert("정상적으로 변경 되었습니다.");
							}
						},
						error	: function(request,status,error){
							alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
						}
					});
				
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
			<h2>유사구성원관리</h2>
			<form id="SurveyListForm" action="">
				<input type="hidden" id="period" value="">
				<div class="mem_search">
					<table>
						<tbody>
							<tr>
								<th>진다검사선택</th>
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
								<th>회원명</th>
								<td>
									<input type="text" id="s_user_nm" name="s_user_nm" maxlength="20" onkeypress="if(event.keyCode == 13) { Survey.getStatisticsList(1); return false;}"/>
								</td>
							</tr>
							<tr>
								<th>진단검사명</th>
								<td>
									<input type="text" id="s_servey_nm" name="s_servey_nm" maxlength="20" onkeypress="if(event.keyCode == 13) { Survey.getStatisticsList(1); return false;}"/>
								</td>
								<th>대표구성원여부</th>
								<td>
									<select id="s_representative_yn" name="s_representative_yn" onchange="Survey.getStatisticsList(1)">
										<option value="">전체</option>
										<option value="Y">대표구성원선택</option>
									</select>
								</td>
								<th>유사구성원여부</th>
								<td>
									<select id="s_similar_yn" name="s_similar_yn" onchange="Survey.getStatisticsList(1)">
										<option value="">전체</option>
										<option value="Y">유사구성원선택</option>
									</select>
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
				<input type="button" value="통계실행" onclick="Survey.surveyInfoPop('regist','')"/>
				<input type="button" value="엑셀다운로드" onclick="Survey.downExcel()"/>
			</div> -->
		
			<div>
				<table class="table table-striped thcss">
			          <thead>
			            <tr>
			              <th>순번</th>
			              <th>선택</th>
			              <th>진단명</th>
			              <th>이름</th>
			              <th>회사명</th>
			              <th>지역</th>
			              <th>소속</th>
			              <th>직위</th>
			              <th>직군</th>
			              <th>직무</th>
			              <th>성별</th>
			              <th>(S)신뢰기반</th>
			              <th>(S)독보적전문성</th>
			              <th>(S)진취적도전</th>
			              <th>(S)창의적용합</th>
			              <th>(S)사교</th>
			              <th>(S)외향</th>
			              <th>(S)적극</th>
			              <th>(S)융화</th>
			              <th>(S)존중</th>
			              <th>(S)민주</th>
			              <th>(S)평등</th>
			              <th>(S)우호</th>
			              <!-- <th>ACTION</th> -->
			            </tr>
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