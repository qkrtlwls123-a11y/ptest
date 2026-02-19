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
				/* if($("#s_representative_yn").val() != "" && $("#s_representative_yn").val() != null) {
					Survey.surveyParams["s_representative_yn"] = $("#s_representative_yn").val();
				}else{
					Survey.surveyParams["s_representative_yn"] = "";
				}
				if($("#s_similar_yn").val() != "" && $("#s_similar_yn").val() != null) {
					Survey.surveyParams["s_similar_yn"] = $("#s_similar_yn").val();
				}else{
					Survey.surveyParams["s_similar_yn"] = "";
				} */

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
		            tag += 	"<td>"+ item.hp +"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		/*            if(item.va1 != undefined && item.va1 != null){
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
		            if(item.pos != undefined && item.pos != null){
		            	tag += 	"<td>"+item.pos+"</td>";
		            }else{
		            	tag += 	"<td>0</td>";
		            }
		            if(item.neg != undefined && item.neg != null){
		            	tag += 	"<td>"+item.neg+"</td>";
		            }else{
		            	tag += 	"<td>0</td>";
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
		            	tag += 	"<td>"+item.ect+"</td>";
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
		            if(item.rul != undefined && item.rul != null){
		            	tag += 	"<td>"+item.rul+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.mor != undefined && item.mor != null){
		            	tag += 	"<td>"+item.mor+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.dpr != undefined && item.dpr != null){
		            	tag += 	"<td>"+item.dpr+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.anx != undefined && item.anx != null){
		            	tag += 	"<td>"+item.anx+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.ins != undefined && item.ins != null){
		            	tag += 	"<td>"+item.ins+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		*/          if(item.char_unity != undefined && item.char_unity != null){
			        	tag += 	"<td>"+item.char_unity+"</td>";
			        }else{
			        	tag += 	"<td></td>";
			        }
			        if(item.char_care != undefined && item.char_care != null){
			        	tag += 	"<td>"+item.char_care+"</td>";
			        }else{
			        	tag += 	"<td></td>";
			        }
			        if(item.char_truth != undefined && item.char_truth != null){
			        	tag += 	"<td>"+item.char_truth+"</td>";
			        }else{
			        	tag += 	"<td></td>";
			        }

		            if(item.sten_va1 != undefined && item.sten_va1 != null){
		            	tag += 	"<td>"+item.sten_va1+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.sten_va2 != undefined && item.sten_va2 != null){
		            	tag += 	"<td>"+item.sten_va2+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.sten_va3 != undefined && item.sten_va3 != null){
		            	tag += 	"<td>"+item.sten_va3+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }		           	
		            if(item.sten_va4 != undefined && item.sten_va4 != null){
		            	tag += 	"<td>"+item.sten_va4+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            
		            if(item.sten_pos != undefined && item.sten_pos != null){
		            	tag += 	"<td>"+Math.round(item.sten_pos*100)+"</td>";
		            }else{
		            	tag += 	"<td>0</td>";
		            }
		           
		            if(item.dpr_txt != undefined && item.dpr_txt != null){
		            	tag += 	"<td>"+item.dpr_txt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.anx_txt != undefined && item.anx_txt != null){
		            	tag += 	"<td>"+item.anx_txt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.ins_txt != undefined && item.ins_txt != null){
		            	tag += 	"<td>"+item.ins_txt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            //if(item.personality != undefined && item.personality != null){
		            //	tag += 	"<td>"+item.personality+"</td>";
		            //}else{
		            //	tag += 	"<td></td>";
		            //}
		            if(item.std_all_value != undefined && item.std_all_value != null){
		            	tag += 	"<td>"+item.std_all_value+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            //if(item.worth != undefined && item.worth != null){
		            //	tag += 	"<td>"+item.worth+"</td>";
		            //}else{
		            //	tag += 	"<td></td>";
		            //}
		            if(item.core_ave_value != undefined && item.core_ave_value != null){
		            	tag += 	"<td>"+item.core_ave_value+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            //if(item.personality != undefined && item.personality != null && item.worth != undefined && item.worth != null){
		            //	tag += 	"<td>"+(item.personality+item.worth)/2+"</td>";
		            //}else{
		            //	tag += 	"<td></td>";
		            //}
		            if(item.total_value != undefined && item.total_value != null){
		            	tag += 	"<td>"+item.total_value+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.recruit_survey_id != undefined && item.recruit_survey_id != null && item.recruit_survey_id != "" && item.responder_id != undefined && item.responder_id != null && item.responder_id != "" && item.summary_step == 7){
		          		tag += 	"<td><div class=\"ingrid\"><a href=\"javascript:Survey.sendHolderSummary('"+item.recruit_survey_id+"','" + item.responder_id + "');\">적용</a></div></td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		   /*         if(item.core_ave != undefined && item.core_ave != null){
		            	tag += 	"<td>"+item.core_ave+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.std_iso != undefined && item.std_iso != null){
		            	tag += 	"<td>"+item.std_iso+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.std_pas != undefined && item.std_pas != null){
		            	tag += 	"<td>"+item.std_pas+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.std_rkt != undefined && item.std_rkt != null){
		            	tag += 	"<td>"+item.std_rkt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.std_ect != undefined && item.std_ect != null){
		            	tag += 	"<td>"+item.std_ect+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.std_nar != undefined && item.std_nar != null){
		            	tag += 	"<td>"+item.std_nar+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.std_pow != undefined && item.std_pow != null){
		            	tag += 	"<td>"+item.std_pow+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.std_sst != undefined && item.std_sst != null){
		            	tag += 	"<td>"+item.std_sst+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.std_ats != undefined && item.std_ats != null){
		            	tag += 	"<td>"+item.std_ats+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.std_all != undefined && item.std_all != null){
		            	tag += 	"<td>"+item.std_all+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.sten_ans != undefined && item.sten_ans != null){
		            	tag += 	"<td>"+item.sten_ans+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		    */        //if(item.edit_dt != undefined && item.edit_dt != null){
		            //	tag += 	"<td>"+item.edit_dt+"</td>";
		            //}else{
		            //	tag += 	"<td></td>";
		            //}
		            tag += 	'</tr>';
				});
				$("#survey_list").append(tag);
			},
			surveyInfoPop : function(action_mode,id){ //수정 화면
				alert("준비중입니다.");
				return;
				var url = "/ka/survey/goInfoPop.do";
				var title = "등록";
				if(action_mode != undefined && action_mode == 'modify'){
					url = url + "?action_mode="+action_mode+"&id="+id;
					title = "수정";
				}else if(action_mode != undefined && action_mode == 'regist'){
					url = url + "?action_mode="+action_mode;
					title = "등록";
				}
				COMM_POPUP.openPopOfCustom(null, url, title, 1000, 800);
			},
			statisticsAction : function(){ //대표구성원유사도처리
				let s_recruit_survey_id = $("#s_recruit_survey_id").val();
				if(s_recruit_survey_id == undefined || s_recruit_survey_id == null || s_recruit_survey_id == "" ){
					alert("먼저 채용공고를 선택하여 주시기 바랍니다.");
					return;
				}
				let params = {};
				params.s_recruit_survey_id = s_recruit_survey_id;
				
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
			 downloadExcel:function (){
				if(confirm("엑셀로 다운로드 하시겠습니까?")){
					let s_survey_id = $("#s_recruit_survey_id").val();
					if(s_survey_id == undefined || s_survey_id == null || s_survey_id == "" ){
						alert("먼저 채용공고를 선택하여 주시기 바랍니다.");
						return;
					}
					var form = document.getElementById("SurveyListForm");
					form.action = "/ka/statistics/summaryExcel.do";
					form.submit();
				}
			},
			sendHolderSummary:function(recruit_survey_id,responder_id){
				if(recruit_survey_id == undefined || recruit_survey_id == null || recruit_survey_id == "" ){
					alert("필수 파라메터(recruit_survey_id)가 없습니다.");
					return;
				}
				if(responder_id == undefined || responder_id == null || responder_id == "" ){
					alert("필수 파라메터(responder_id)가 없습니다.");
					return;
				}
				let params = {};
				params.recruit_survey_id = recruit_survey_id;
				params.user_id = responder_id;
				params.action_mode = "regist";
				
				var url = "/ka/holder/goHolderSummaryAction.do";
				$.ajax({
					url			: url,
					type		: "post",
					data		: $.param(params),
					success		: function(data){
						if(data.rcode == 200){
							alert("정상적으로 재직자 요약정보가 생성 되었습니다.");
						}else{
							alert("재직자 요약정보가 생성에 문제가 있었습니다.\n확인 후 다시 실행하여 주시기바랍니다.");
						}
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
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
			<h2>진단결과 데이터</h2>
			<form id="SurveyListForm" action="">
				<input type="hidden" id="period" value="">
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
							</tr> --%>
							<tr>
								<th>채용공고</th>
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
									<input type="text" id="s_user_nm" name="s_user_nm"  class="w300"maxlength="120" onkeypress="if(event.keyCode == 13) { Survey.getStatisticsList(1); return false;}"/>
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
			<div class="btn_space_listT">
				<input type="button" value="진단결과값생성" onclick="Survey.statisticsAction()"/>
				<input type="button" value="리스트다운로드" onclick="Survey.downloadExcel()"/>
			</div>
		
			<div>
				<table class="table table-striped thcss">
			          <thead>
			            <tr>
			              <th rowspan="2">No.</th>
			              <th rowspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;채용공고&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
			              <th rowspan="2">이름</th>
			              <th rowspan="2">생년월일</th>
			              <th rowspan="2">연락처</th>
						  <th colspan="3">&nbsp;&nbsp;인성등급&nbsp;&nbsp;</th>
			              <th colspan="4">핵심가치 점수</th>
			              <th>&nbsp;&nbsp;정서 점수&nbsp;&nbsp;</th>
			              <th colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;마음건강 상태&nbsp;&nbsp;</th>
			              <th colspan="3">&nbsp;&nbsp;종합 등급</th>
			              <th rowspan="2">재직자<br>데이터 반영</th>
			            </tr>
			            <tr>
			              <th>인화</th>
						  <th>배려</th>
						  <th>정직&nbsp;&nbsp;&nbsp;</th>
						  <th>신뢰기반<br>소통</th>
			              <th>독보적<br>전문성</th>
						  <th>진취적<br>도전</th>
						  <th>창의적<br>융합</th>
			              <th>긍정(%)</th>
			              <th>&nbsp;&nbsp;우울</th>
						  <th>불안</th>
						  <th>불면</th>
			              <th>인성&nbsp;&nbsp;</th>
			              <th>핵심가치</th>
			              <th>전체</th>
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