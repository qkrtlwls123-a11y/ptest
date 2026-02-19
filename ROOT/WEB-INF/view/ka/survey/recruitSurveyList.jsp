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
	<script type="text/javascript" src="/resources/js/jquery.base64.js"></script>
	<script type="text/javascript" src="/resources/js/common.js"></script>
	<script type="text/javascript">
	var Survey = {
			surveyParams : {},
			getSurveyList : function(pageNo){ //리스트 데이터 로딩
				if($('#SurveyListForm [name="s_recruit_nm"]').val() != "" && $('#SurveyListForm [name="s_recruit_nm"]').val() != null) {
					Survey.surveyParams["s_recruit_nm"] = $('#SurveyListForm [name="s_recruit_nm"]').val();
				}else{
					Survey.surveyParams["s_recruit_nm"] = "";
				}
				if($('#SurveyListForm [name="s_company_code"]').val() != "" && $('#SurveyListForm [name="s_company_code"]').val() != null) {
					Survey.surveyParams["s_company_code"] = $('#SurveyListForm [name="s_company_code"]').val();
				}else{
					Survey.surveyParams["s_company_code"] = "";
				}
				if( $("#period").val() != "" && $("#period").val() != null) {
					Survey.surveyParams["period"] = $("#period").val();
				}else{
					Survey.surveyParams["period"] = "";
				}
				var s_start_dt = $("#requestSch_start_dt").val();
				var s_end_dt = $("#requestSch_end_dt").val();
				if((s_start_dt == "" && s_end_dt != "") || (s_start_dt != "" && s_end_dt == "")){
					alert("등록시작일과 등록종료일을 모두 입력하여 주시기 바랍니다.");
					return;
				}
				
				if( $("#requestSch_start_dt").val() != undefined && $("#requestSch_start_dt").val() != "" && $("#requestSch_start_dt").val() != null && $("#requestSch_end_dt").val() != undefined && $("#requestSch_end_dt").val() != "" && $("#requestSch_end_dt").val() != null) {
					Survey.surveyParams["s_start_dt"] = $("#requestSch_start_dt").val();
					Survey.surveyParams["s_end_dt"] = $("#requestSch_end_dt").val();
				}else{
					Survey.surveyParams["s_start_dt"] = "";
					Survey.surveyParams["s_end_dt"] = "";
				}

				if(pageNo != undefined && pageNo != null && pageNo != "") {
					Survey.surveyParams["pageNo"] = pageNo;
				}else{
					Survey.surveyParams["pageNo"] = 1;
				}
				var url = "/ka/survey/getRecruitSurveyList.do";

				$.ajax({
					url			: url,
					type		: "post",
					data		: $.param(Survey.surveyParams),
					success		: function(data){
						Survey.setSurveyList(data);
						CODE.createPaging(data,'Survey.getSurveyList','pagingArea');
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			setSurveyList : function(localdata){ //로딩된 데이터를 받아서 그리드 생성
				$("#survey_list").html("");
				var tag = "";
				$.each(localdata.list, function(idx, item){
		            tag += 	"<tr class=\"listAll\">";
		            tag += 	"<td><input type=\"checkbox\" name=\"dchk\" value=\""+item.id+"\" onclick=\"Survey.dchkClick()\"/></td>";
		            tag +=  "<td>"+(localdata.totalCount - (localdata.numPerPage*(localdata.pageNo-1))-idx)+"</td>";
		            if(item.survey_nm != undefined && item.survey_nm != null){
		            	tag += 	"<td>"+item.survey_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.company_nm != undefined && item.company_nm != null){
			            tag += 	"<td>"+item.company_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.recruit_nm != undefined && item.recruit_nm != null){
		            	tag += 	"<td>"+item.recruit_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.start_day != undefined && item.start_day != null && item.end_day != undefined && item.end_day != null){
		            tag += 	"<td>"+ item.start_day + "~" + item.end_day +"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.survey_cnt != undefined && item.survey_cnt != null){
		            tag += 	"<td>"+item.survey_cnt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.complete_cnt != undefined && item.complete_cnt != null){
		            	tag += 	"<td>"+item.complete_cnt+"</td>";
		            }else{
		            	tag += 	"<td>0</td>";
		            }
		            if(item.save_cnt != undefined && item.save_cnt != null){
		            	tag += 	"<td>"+item.save_cnt+"</td>";
		            }else{
		            	tag += 	"<td>0</td>";
		            }
		            if(item.not_cnt != undefined && item.not_cnt != null){
		            	tag += 	"<td>"+item.not_cnt+"</td>";
		            }else{
		            	tag += 	"<td>0</td>";
		            }
		           /*  if(item.use_yn != undefined && item.use_yn != null){
		            	tag += 	"<td>"+item.use_yn+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            } */
		            if(item.reg_dt != undefined && item.reg_dt != null){
		            	tag += 	"<td>"+item.reg_dt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.reg_nm != undefined && item.reg_nm != null){
		            	tag += 	"<td>"+item.reg_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		           
		            tag += 	"<td class=\"recruit_survey_id"+item.id+"\"><div class=\"ingrid\"><a href=\"javascript:User.getUserList(1,'"+item.id+"');\">검사자리스트</a></div></td>";
		            tag += 	"<td class=\"recruit_survey_id"+item.id+"\"><div class=\"ingrid\"><a href=\"javascript:Holder.getUserList(1,'"+item.id+"');\">구성원선택</a></div></td>";
		            tag += 	"<td><div class=\"ingrid\"><a href=\"javascript:Survey.surveyInfoPop('modify','" + item.id + "');\">수정</a></div></td>";
		            tag += 	"<td><div class=\"ingrid\"><a href=\"javascript:copy_to_clipboard('" + item.id + "');\">링크복사</a></div></td>";
		            tag += 	'</tr>';
				});
				$("#survey_list").append(tag);
				if(User.userParams["s_survey_id"] != undefined && User.userParams["s_survey_id"] != null && User.userParams["s_survey_id"] != ""){
					$(".listAll").each(function(index,item){
						$(item).children().each(function(index2,item2){
							$(item2).css("border-top","1px solid #ddd");
							$(item2).css("border-bottom","1px solid #ddd");
						});
					});
					if($(".survey_id"+User.userParams["s_survey_id"]) != undefined){
						$(".survey_id"+User.userParams["s_survey_id"]).parent().children().each(function(index,item){
							$(item).css("border-top","3px solid #ef2121");
							$(item).css("border-bottom","3px solid #ef2121");
						});
					}
				}
			},
			surveyInfoPop : function(action_mode,id){ //수정 화면
				var url = "/ka/survey/goRecruitInfoPop.do";
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
			surveyAction : function(action_mode){ //추가/수정/삭제 액션
				$('#SurveyForm [name="action_mode"]').val(action_mode);
				var isAllow = false;
				if(action_mode == "modify" || action_mode == "regist"){
					isAllow = true;
				}else if(action_mode == "delete"){
					isAllow = confirm("진단을 삭제하시겠습니까?");
				}
						
				if(isAllow == true){
					
					if($('#SurveyForm [name="survey_id"]').val() == ''){
						alert("진단검사종류를 선택해 주세요.");
						$('#SurveyForm [name="survey_id"]').focus();
						return false;
					}
					if($('#SurveyForm [name="survey_nm"]').val() == ''){
						alert("진단명을 입력해 주세요.");
						$('#SurveyForm [name="survey_nm"]').focus();
						return false;
					}
					if($('#SurveyForm [name="company_code"]').val() == ''){
						alert("소속회사를 선택해 주세요.");
						$('#SurveyForm [name="company_code"]').focus();
						return false;
					}
					if($('#SurveyForm [name="survey_cnt"]').val() == ''){
						alert("대상인원을 입력해 주세요.");
						$('#SurveyForm [name="survey_cnt"]').focus();
						return false;
					}
					
					if(action_mode == "modify" || action_mode == "regist" || action_mode == "delete"){//일반 가입정보
						$("#SurveyForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									if(data.rcode == 100){
										alert("하위질의 가 존재합니다.\n하위질의부터 삭제하셔야 합니다.");
									}else{
										alert("정상적으로 처리 되었습니다.");
										Survey.getSurveyList(Survey.surveyParams["pageNo"]);
									}
								}else{
									alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
								}
								COMM_POPUP.close("comm_popup");
					        }
					    });
					}
				}
			},
			 downloadExcel:function (){
				if(confirm("엑셀로 다운로드 하시겠습니까?")){
					var form = document.getElementById("SurveyListForm");
					form.action = "/ka/survey/recruitSurveyListExcel.do";
					form.submit();
				}
			},
			delteteCheckRaws:function (){
				if(!confirm("선택한 항목을 삭제 처리 하시겠습니까?")){
					return;
				}
				
				if (SurveyListForm.dchk.length){ //2개이상일때 
					cnt = $("#SurveyListForm input:checkbox[name=dchk]:checked").length;
					if(cnt > 0){
						$('#SurveyListForm [name="action_mode"]').val("raws_delete");
						$("#SurveyListForm").attr("action","/ka/survey/goRecruitSurveyAction.do");
						$("#SurveyListForm").attr("method","post");
						$("#SurveyListForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									alert("정상적으로 처리 되었습니다.");
									Survey.getSurveyList(Survey.surveyParams["pageNo"]);
									SurveyListForm.AllCheck.checked = false;
								}else{
									alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
								}
					        }
					    });
					}else{
						alert("삭제 처리할 채용공고를 선택하여 주시기바랍니다.");
					}
				}else{
					if($("#SurveyListForm input:checkbox[name=dchk]").is(":checked") == true){
						$('#SurveyListForm [name="action_mode"]').val("raws_delete");
						$("#SurveyListForm").attr("action","/ka/survey/goRecruitSurveyAction.do");
						$("#SurveyListForm").attr("method","post");
						$("#SurveyListForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									alert("정상적으로 처리 되었습니다.");
									Survey.getSurveyList(Survey.surveyParams["pageNo"]);
									SurveyListForm.AllCheck.checked = false;
								}else{
									alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
								}
					        }
					    });
					}else{
						alert("삭제 처리할 채용공고를 선택하여 주시기바랍니다.");
					}
				}
			},
			dchkClick:function (){
				if (SurveyListForm.dchk.length){ //2개이상일때 
					var totalCnt = $("#SurveyListForm input:checkbox[name=dchk]").length;
					var checkedCnt = $("#SurveyListForm input:checkbox[name=dchk]:checked").length;
					if(totalCnt > 0){
						if(totalCnt != checkedCnt){
							SurveyListForm.AllCheck.checked = false;
						}else{
							SurveyListForm.AllCheck.checked = true;
						}
					}
				}else{
					if($("#SurveyListForm input:checkbox[name=dchk]").is(":checked") == true){
						SurveyListForm.AllCheck.checked = true;
					}else{
						SurveyListForm.AllCheck.checked = false;
					}
				}
			},
			deleteCheckAll:function(){
				if (SurveyListForm.dchk.length){ //2개이상일때
					var checkedCnt = $("#SurveyListForm input:checkbox[name=dchk]:checked").length;
					if(SurveyListForm.AllCheck.checked == true){
						$("#SurveyListForm input:checkbox[name=dchk]").each(function(index,item){
							item.checked = true;	
						});
					}else{
						$("#SurveyListForm input:checkbox[name=dchk]").each(function(index,item){
							item.checked = false;
						});
					}
				}else{
					if(SurveyListForm.AllCheck.checked == true){
						$("#SurveyListForm input:checkbox[name=dchk]").attr("checked",true);
					}else{
						$("#SurveyListForm input:checkbox[name=dchk]").attr("checked",false);
					}
				}
			}
	}
	
	var User = {
			userParams : {},
			getUserList : function(pageNo,recruit_survey_id){ //리스트 데이터 로딩
				if(recruit_survey_id != undefined && recruit_survey_id != null && recruit_survey_id != ""){
					User.userParams["s_recruit_survey_id"]=recruit_survey_id;
				}
				if(User.userParams["s_recruit_survey_id"] == undefined || User.userParams["s_recruit_survey_id"] == null || User.userParams["s_recruit_survey_id"] == ""){
					alert("채용공고리스트에서 검사자보기를 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				
				$("#UserListArea").show();
				$("#HolderListArea").hide();
				
				$(".listAll").each(function(index,item){
					$(item).children().each(function(index2,item2){
						$(item2).css("border-top","1px solid #ddd");
						$(item2).css("border-bottom","1px solid #ddd");
					});
				});
				$(".recruit_survey_id"+User.userParams["s_recruit_survey_id"]).parent().children().each(function(index,item){
					$(item).css("border-top","3px solid #ef2121");
					$(item).css("border-bottom","3px solid #ef2121");
				});
				
				if($('#UserListForm [name="s_user_nm"]').val() != "" && $('#UserListForm [name="s_user_nm"]').val() != null) {
					User.userParams["s_user_nm"] = $('#UserListForm [name="s_user_nm"]').val();
				}else{
					User.userParams["s_user_nm"] = "";
				}
				if($('#UserListForm [name="s_summary_step"]').val() != "" && $('#UserListForm [name="s_summary_step"]').val() != null) {
					User.userParams["s_summary_step"] = $('#UserListForm [name="s_summary_step"]').val();
				}else{
					User.userParams["s_summary_step"] = "";
				}
/* 				
				if($("#s_position_code").val() != "" && $("#s_position_code").val() != null) {
					User.userParams["s_position_code"] = $("#s_position_code").val();
				}else{
					User.userParams["s_position_code"] = "";
				}
				if($("#s_job_code").val() != "" && $("#s_job_code").val() != null) {
					User.userParams["s_job_code"] = $("#s_job_code").val();
				}else{
					User.userParams["s_job_code"] = "";
				}
				if($("#s_duty_code").val() != "" && $("#s_duty_code").val() != null) {
					User.userParams["s_duty_code"] = $("#s_duty_code").val();
				}else{
					User.userParams["s_duty_code"] = "";
				}
				
				if($("#s_company_code").val() != "" && $("#s_company_code").val() != null) {
					User.userParams["s_company_code"] = $("#s_company_code").val();
				}else{
					User.userParams["s_company_code"] = "";
				}
				if($("#s_user_type").val() != "" && $("#s_user_type").val() != null) {
					User.userParams["s_user_type"] = $("#s_user_type").val();
				}else{
					User.userParams["s_user_type"] = "";
				}
				if($("#s_use_yn").val() != "" && $("#s_use_yn").val() != null) {
					User.userParams["s_use_yn"] = $("#s_use_yn").val();
				}else{
					User.userParams["s_use_yn"] = "";
				} */

				if(pageNo != undefined && pageNo != null && pageNo != "") {
					User.userParams["pageNo"] = pageNo;
				}else{
					User.userParams["pageNo"] = 1;
				}
				var url = "/ka/user/getUserList.do";

				$.ajax({
					url			: url,
					type		: "post",
					data		: $.param(User.userParams),
					success		: function(data){
						User.setUserList(data);
						CODE.createPaging(data,'User.getUserList','pagingArea2');
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			setUserList : function(localdata){ //로딩된 데이터를 받아서 그리드 생성
				$("#user_list").html("");
				var tag = "";
				$.each(localdata.list, function(idx, item){
		            tag += 	"<tr class=\"listAll2\">";
		            tag += 	"<td><input type=\"checkbox\" name=\"dchk\" value=\""+item.id+"\" onclick=\"User.dchkClick()\"/></td>";
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
		            /* if(item.company_nm != undefined && item.company_nm != null){
		            tag += 	"<td>"+item.company_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            } */      
		            /* if(item.recruit_nm != undefined && item.recruit_nm != null){
			            tag += 	"<td>"+item.recruit_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            } */
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
		            if(item.email != undefined && item.email != null){
		            	tag += 	"<td>"+item.email+"</td>";
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
		            if(item.complete_dt != undefined && item.complete_dt != null){
		            	tag += 	"<td>"+item.complete_dt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            tag += 	"<td>"+"<div class=\"ingrid\"><a href=\"javascript:User.userInfoPop('modify','" + item.id + "');\">보기</a></div>"+"</td>";		  
		            tag += 	"<td>"+"<div class=\"ingrid\"><a href=\"javascript:User.userAction3('deleteData','" + item.id + "');\">리셋</a></div>"+"</td>";
		            tag += 	'</tr>';
				}); 
				$("#user_list").append(tag);
			},
			userInfoPop : function(action_mode,id){ //수정 화면
				if(User.userParams["s_recruit_survey_id"] == undefined || User.userParams["s_recruit_survey_id"] == null || User.userParams["s_recruit_survey_id"] == ""){
					alert("채용공고리스트에서 검사자보기를 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				var url = "/ka/user/goUserInfoPop2.do";
				var title = "등록";
				if(action_mode != undefined && action_mode == 'modify'){
					url = url + "?action_mode="+action_mode+"&id="+id;
					title = "수정";
				}else if(action_mode != undefined && action_mode == 'regist'){
					url = url + "?action_mode="+action_mode;
					title = "등록";  
				}
				COMM_POPUP.openPopOfCustom(null, url, title, 1000, 400);
			},
			userMailPop : function(){ //수정 화면
				if(!confirm("선택한 항목을 메일 발송 하시겠습니까?")){
					return;
				}
			
				if (UserListForm.dchk.length){ //2개이상일때 
					cnt = $("#UserListForm input:checkbox[name=dchk]:checked").length;
					if(cnt > 0){
						var title = "메일 발송";
						var targetId = "";
						$("#UserListForm input:checkbox[name=dchk]:checked").each(function(){
							targetId += $(this).val() + "/";
							
						})
						COMM_POPUP.set(1000, 400, "comm_popup");
						COMM_POPUP.callback = "";
						$("#pageId").val(User.userParams["s_recruit_survey_id"]);
						var params = $("form[name=UserListForm]").serialize();
						$("#comm_popup").find(".modal-title").text(title);
						$.ajax({
							url : "/ka/user/goUserMailPop.do",
							type : "POST",
							data: params,
							beforeSend : function(){
								$("#loading").show();
							},
							complete : function(){
								$("#loading").hide();
							},
							success : function(html){
								//if(html.indexOf("/admin/login/goLoginView.do") > -1) {
								//	alert("로그인이 필요합니다.");
								//	document.location.href="/admin/login/goLoginView.do?retUrl="+document.location.href;
								//}
								$("#comm_popup").find(".modal-body").html(html);
							},
							error : function(request,status,error){
								alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
							}
						});
						$("#comm_popup").modal({
							fadeDuration: 2000,
			  				fadeDelay: 0.50
						});
			
						/* var params2 = $("form[name=UserListForm]").serialize(); 
						$.ajax({
							url : "/ka/user/goUserMailPop.do",
							type : "POST",
							data: params2,
							success : function(result) {
								$(".con-wrap").html(result);
							}
						}); */
						
					}else{
						alert("메일 발송 처리할 검사자를 선택하여 주시기바랍니다.");
					}
				}
				
			},
			userAction : function(action_mode){ //추가/수정/삭제 액션
				if(User.userParams["s_recruit_survey_id"] == undefined || User.userParams["s_recruit_survey_id"] == null || User.userParams["s_recruit_survey_id"] == ""){
					alert("채용공고리스트에서 검사자보기를 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				$("#action_mode").val(action_mode);
				var isAllow = false;
				if(action_mode == "modify" || action_mode == "regist"){
					isAllow = true;
				}else if(action_mode == "delete"){
					isAllow = confirm("검사자 정보를 삭제하시겠습니까?");
				}
				
				if(isAllow == true){
					if(action_mode == "regist"){
						if($('#UserForm [name="email"]').val() == ''){
							alert("이메일을 입력해 주세요.");
							$('#UserForm [name="email"]').focus();
							return false;
						}
						if(isValidEmail($('#UserForm [name="email"]')) == false){
							alert("이메일이 형식에 맞지 않습니다.");
							$('#UserForm [name="email"]').focus();
							return false;
						}
					}
					
					if($('#UserForm [name="user_nm"]') == ""){
						alert("이름을 입력해 주세요.");
						$('#UserForm [name="user_nm"]').focus();
						return false;
					}
					
					if($('#UserForm [name="year_birth"]').val() != ''){
						/* if($("#user_passwd").val() != $("#user_passwd_confirm").val()){
							alert("비밀번호를 정확히 입력하여 주시기 바랍니다.");
							$("#user_passwd").focus();
							return false;
						}else{
							$("#user_passwd").val($.base64.btoa($("#user_passwd_confirm").val()));
						} */
						$('#UserForm [name="passwd"]').val($.base64.btoa($('#UserForm [name="year_birth"]').val()));
					}else{
						alert("생년월일을 입력해 주세요.");
						$('#UserForm [name="year_birth"]').focus();
						return false;
					}
				}
				
				if(isAllow == true){
					if(action_mode == "modify" || action_mode == "regist" || action_mode == "delete"){//일반 가입정보
						$('#UserForm [name="recruit_survey_id"]').val(User.userParams["s_recruit_survey_id"]);
						$('#UserForm [name="action_mode"]').val(action_mode);
						$("#UserForm").attr("action","/ka/user/goUserAction2.do");
						$("#UserForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									if(data.rcode == 100){
										$('#UserForm [name="recruit_survey_id"]').val(User.userParams["s_recruit_survey_id"]);
										$("#UserForm").attr("action","/ka/user/goUserAction3.do");
										$("#UserForm").ajaxSubmit({
											success:function(data2){
												if($('#UserForm [name="recruit_survey_id"]').val() == data2.recruit_survey_id){
													alert("해당 공고에 이미 등록된 이메일 입니다.");
												}else{
													alert("이미 등록된 이메일 입니다.\n소속회사 : "+data2.company_nm+"\n채용공고 : "+data2.recruit_survey_nm);
													if(confirm("추가로 등록하시겠습니까?")){
														$("#UserForm").attr("action","/ka/user/goUserAction4.do");
														$("#UserForm").ajaxSubmit({
															success:function(data2){
																alert("등록되었습니다.");
													        }
													    });
													}
												}
									        }
									    });
									}else{ 
										alert("정상적으로 처리 되었습니다.");
										User.getUserList(User.userParams["pageNo"]);
									}
								}else{
									alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
								}
					        }
					    });
					}
				}
				COMM_POPUP.close("comm_popup");
			},
			userAction3 : function(action_mode,id){ //추가/수정/삭제 액션
				if(User.userParams["s_recruit_survey_id"] == undefined || User.userParams["s_recruit_survey_id"] == null || User.userParams["s_recruit_survey_id"] == ""){
					alert("채용공고리스트에서 검사자보기를 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				var isAllow = false;
				if(action_mode == "deleteData"){
					isAllow = confirm("검사자 설문정보를 삭제하시겠습니까?");
				}
				
				if(isAllow == true){
					if(action_mode == "deleteData"){//일반 가입정보
						User.userParams["action_mode"] = action_mode;
						User.userParams["recruit_survey_id"] = User.userParams["s_recruit_survey_id"];
						User.userParams["id"] = id;
						var url = "/ka/user/goUserAction2.do";

						$.ajax({
							url			: url,
							type		: "post",
							data		: $.param(User.userParams),
							success		: function(data){
								alert("정상적으로 처리 되었습니다.");
								User.getUserList(User.userParams["pageNo"]);
							},
							error	: function(request,status,error){
								alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
							}
						});
					}
				}
			},
			downloadExcel:function (){
				if(User.userParams["s_recruit_survey_id"] == undefined || User.userParams["s_recruit_survey_id"] == null || User.userParams["s_recruit_survey_id"] == ""){
					alert("채용공고리스트에서 검사자보기를 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				$('#UserListForm [name="s_recruit_survey_id"]').val(User.userParams["s_recruit_survey_id"]);
				if(confirm("엑셀로 다운로드 하시겠습니까?")){
					var form = document.getElementById("UserListForm");
					form.action = "/ka/user/adminUserListExcel2.do";
					form.submit();
				}
			},
			fileUploadForm : function(action_mode){ //Request 추가 화면
				var url = "/ka/user/rawUploadForm.do";
				var title = "파일등록";
				if(action_mode != undefined && action_mode == 'raw_regist'){
					url = url + "?action_mode="+action_mode;
				}
				COMM_POPUP.openPopOfCustom(null, url, title, 900, 400);
			},
			deleteCheckRaws:function (){
				if(!confirm("선택한 항목을 삭제 처리 하시겠습니까?")){
					return;
				}
				
				if (UserListForm.dchk.length){ //2개이상일때 
					cnt = $("#UserListForm input:checkbox[name=dchk]:checked").length;
					if(cnt > 0){
						$('#UserListForm [name="action_mode"]').val("raws_delete");
						$("#UserListForm").attr("action","/ka/user/goUserAction2.do");
						$("#UserListForm").attr("method","post");
						$("#UserListForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									alert("정상적으로 처리 되었습니다."); 
									User.getUserList(User.userParams["pageNo"]);
									UserListForm.AllCheck.checked = false;
								}else{
									alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
								}
					        }
					    });
					}else{
						alert("삭제 처리할 검사자를 선택하여 주시기바랍니다.");
					}
				}else{
					if($("#UserListForm input:checkbox[name=dchk]").is(":checked") == true){
						$('#UserListForm [name="action_mode"]').val("raws_delete");
						$("#UserListForm").attr("action","/ka/user/goUserAction2.do");
						$("#UserListForm").attr("method","post");
						$("#UserListForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									alert("정상적으로 처리 되었습니다.");
									User.getUserList(User.userParams["pageNo"]);
									UserListForm.AllCheck.checked = false;
								}else{
									alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
								}
					        }
					    });
					}else{
						alert("삭제 처리할 채용공고를 선택하여 주시기바랍니다.");
					}
				}
			},
			dchkClick:function (){
				if (UserListForm.dchk.length){ //2개이상일때 
					var totalCnt = $("#UserListForm input:checkbox[name=dchk]").length;
					var checkedCnt = $("#UserListForm input:checkbox[name=dchk]:checked").length;
					if(totalCnt > 0){
						if(totalCnt != checkedCnt){
							UserListForm.AllCheck.checked = false;
						}else{
							UserListForm.AllCheck.checked = true;
						}
					}
				}else{
					if($("#UserListForm input:checkbox[name=dchk]").is(":checked") == true){
						UserListForm.AllCheck.checked = true;
					}else{
						UserListForm.AllCheck.checked = false;
					}
				}
			},
			deleteCheckAll:function(){
				if (UserListForm.dchk.length){ //2개이상일때
					var checkedCnt = $("#UserListForm input:checkbox[name=dchk]:checked").length;
					if(UserListForm.AllCheck.checked == true){
						$("#UserListForm input:checkbox[name=dchk]").each(function(index,item){
							item.checked = true;	
						});
					}else{
						$("#UserListForm input:checkbox[name=dchk]").each(function(index,item){
							item.checked = false;
						});
					}
				}else{
					if(UserListForm.AllCheck.checked == true){
						$("#UserListForm input:checkbox[name=dchk]").attr("checked",true);
					}else{
						$("#UserListForm input:checkbox[name=dchk]").attr("checked",false);
					}
				}
			},
			sampleDownload:function(){
			    location.href="/ka/user/getRawFile2.do";
			},
			rowRegAction:function(){
				if($('#UserForm [name="action_mode"]').val() == ''){
					alert("파일을 선택해 주세요.");
					$('#UserForm [name="action_mode"]').focus();
					return false;
				}
				$("#prog1").show();
				$('#UserForm [name="recruit_survey_id"]').val(User.userParams["s_recruit_survey_id"]);
				$("#UserForm").attr("action","/ka/user/goRequestAction.do");
				$('#UserForm [name="action_mode"]').val("raw_regist2");
				$("#UserForm").ajaxSubmit({
					async:false,
					success:function(data){
						if(data.rcode > 0){
							alert("업로드 완료.\n총 "+data.total+"건\n중복삭제 "+data.delcnt+"건");
							setTimeout(function() {
								$("#prog1").hide();
								COMM_POPUP.close();
								User.getUserList(User.userParams["pageNo"]);
							}, 300);
						}else{
							alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
							setTimeout(function() {
								$("#prog1").hide();
								COMM_POPUP.close();
							}, 300);
						}
			        },
					error	: function(request,status,error){
						$("#prog1").hide();
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
			    });
			},
			rowRegView:function(type){
				if(type == "each1"){
					$("#each1View").show();
					$("#each2View").hide();
				}else{
					$("#each2View").show();
					$("#each1View").hide();
				}
			}
	}
	
	var Holder = {
			userParams : {},
			getUserList : function(pageNo,recruit_survey_id){ //리스트 데이터 로딩
				if(recruit_survey_id != undefined && recruit_survey_id != null && recruit_survey_id != ""){
					Holder.userParams["s_recruit_survey_id"]=recruit_survey_id;
				}
				if(Holder.userParams["s_recruit_survey_id"] == undefined || Holder.userParams["s_recruit_survey_id"] == null || Holder.userParams["s_recruit_survey_id"] == ""){
					alert("채용공고리스트에서 구성원선택을 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				
				$("#UserListArea").hide();
				$("#HolderListArea").show();
				
				$(".listAll").each(function(index,item){
					$(item).children().each(function(index2,item2){
						$(item2).css("border-top","1px solid #ddd");
						$(item2).css("border-bottom","1px solid #ddd");
					});
				});
				$(".recruit_survey_id"+Holder.userParams["s_recruit_survey_id"]).parent().children().each(function(index,item){
					$(item).css("border-top","3px solid #ef2121");
					$(item).css("border-bottom","3px solid #ef2121");
				});
				
				if($('#HolderListForm [name="s_company_code"]').val() != "" && $('#HolderListForm [name="s_company_code"]').val() != null) {
					Holder.userParams["s_company_code"] = $('#HolderListForm [name="s_company_code"]').val();
				}else{
					Holder.userParams["s_company_code"] = "";
				}
				
				if($('#HolderListForm [name="s_belong_code"]').val() != "" && $('#HolderListForm [name="s_belong_code"]').val() != null) {
					Holder.userParams["s_belong_code"] = $('#HolderListForm [name="s_belong_code"]').val();
				}else{
					Holder.userParams["s_belong_code"] = "";
				}
				if($('#HolderListForm [name="s_user_nm"]').val() != "" && $('#HolderListForm [name="s_user_nm"]').val() != null) {
					Holder.userParams["s_user_nm"] = $('#HolderListForm [name="s_user_nm"]').val();
				}else{
					Holder.userParams["s_user_nm"] = "";
				}
				if($('#HolderListForm [name="s_holder_type"]').val() != "" && $('#HolderListForm [name="s_holder_type"]').val() != null) {
					Holder.userParams["s_holder_type"] = $('#HolderListForm [name="s_holder_type"]').val();
				}else{
					Holder.userParams["s_holder_type"] = "";
				}

				if(pageNo != undefined && pageNo != null && pageNo != "") {
					Holder.userParams["pageNo"] = pageNo;
				}else{
					Holder.userParams["pageNo"] = 1;
				}
				var url = "/ka/holder/getHolderSummaryList.do";

				$.ajax({
					url			: url,
					type		: "post",
					data		: $.param(Holder.userParams),
					success		: function(data){
						Holder.setUserList(data);
						CODE.createPaging(data,'Holder.getUserList','pagingArea3');
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			setUserList : function(localdata){ //로딩된 데이터를 받아서 그리드 생성
				$("#holder_list").html("");
				var tag = "";
				$.each(localdata.list, function(idx, item){
		            tag += 	"<tr class=\"listAll2\">";
		            tag +=  "<td>"+(localdata.totalCount - (localdata.numPerPage*(localdata.pageNo-1))-idx)+"</td>";
		            if(item.representative_yn != undefined && item.representative_yn != null){
		            	tag += 	"<td><input name=\"radio_representative\" type=\"radio\" checked=\"checked\" onclick=\"Holder.checkAction('"+item.responder_id+"','representative',this)\"/></td>";
		            }else{
		            	tag += 	"<td><input name=\"radio_representative\" type=\"radio\" onclick=\"Holder.checkAction('"+item.responder_id+"','representative',this)\"/></td>";
		            }
		            if(item.similar_yn != undefined && item.similar_yn != null){
		            	tag += 	"<td><input type=\"checkbox\" name=\"dchk\" value=\""+item.responder_id+"\" checked=\"checked\" onclick=\"Holder.checkAction('"+item.responder_id+"','similar',this)\"/></td>";
		            }else{
		            	tag += 	"<td><input type=\"checkbox\" name=\"dchk\" value=\""+item.responder_id+"\" onclick=\"Holder.checkAction('"+item.responder_id+"','similar',this)\"/></td>";
		            }
		            if(item.user_nm != undefined && item.user_nm != null){
		            	tag += 	"<td>"+item.user_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.company_nm != undefined && item.company_nm != null){
		            tag += 	"<td>"+item.company_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.area != undefined && item.area != null){
		            tag += 	"<td>"+item.area+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.belong_nm != undefined && item.belong_nm != null){
		            	tag += 	"<td>"+item.belong_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.position_nm != undefined && item.position_nm != null){
		            	tag += 	"<td>"+item.position_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.job_nm != undefined && item.job_nm != null){
		            	tag += 	"<td>"+item.job_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.duty_nm != undefined && item.duty_nm != null){
		            	tag += 	"<td>"+item.duty_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.gender_nm != undefined && item.gender_nm != null){
		            	tag += 	"<td>"+item.gender_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            //tag += 	"<td>"+"<div class=\"ingrid\"><a href=\"javascript:Holder.userInfoPop('modify','" + item.id + "');\">보기</a></div>"+"</td>";
		            tag += 	'</tr>';
				}); 
				$("#holder_list").append(tag);
			},
			holderAction : function(action_mode){ //조회조건으로 유사구성원 추가/삭제 액션
				if(Holder.userParams["s_recruit_survey_id"] == undefined || Holder.userParams["s_recruit_survey_id"] == null || Holder.userParams["s_recruit_survey_id"] == ""){
					alert("채용공고리스트에서 구성원선택을 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
			
				$('#HolderListForm [name="action_mode"]').val(action_mode);
				$('#HolderListForm [name="s_recruit_survey_id"]').val(Holder.userParams["s_recruit_survey_id"]);
				var isAllow = false;
				if(action_mode == "raws_set"){
					isAllow = confirm("유사구성원 조회내역을 선택하시겠습니까?");
				}else if(action_mode == "raws_unset"){
					isAllow = confirm("유사구성원 조회내역을 선택에서 해제하시겠습니까?");
				}
				
				if(isAllow == true){
					$("#HolderListForm").attr("action","/ka/holder/goHolderSummaryAction.do");
					$("#HolderListForm").ajaxSubmit({
						success:function(data){
							if(data.rcode > -1){
									alert("정상적으로 처리 되었습니다.");
									Holder.getUserList(Holder.userParams["pageNo"]);
							}else{
								alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
							}
				        }
				    });
				}
			},
			checkAction : function(user_id,action_mode,obj){ //유사구성원,대표구성원처리
				if(Holder.userParams["s_recruit_survey_id"] == undefined || Holder.userParams["s_recruit_survey_id"] == null || Holder.userParams["s_recruit_survey_id"] == ""){
					alert("채용공고리스트에서 구성원선택을 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				let params = {};
				params.recruit_survey_id = Holder.userParams["s_recruit_survey_id"];
				params.user_id = user_id;
				params.action_mode = action_mode;
				
				if($(obj).is(":checked") == true){
					params.inout = "I";
				}else{
					params.inout = "O";
				}
				
				if(action_mode == "representative" || action_mode == "similar"){//대표구성원 유사구성원
					var url = "/ka/holder/goHolderSummaryAction.do";
					$.ajax({
						url			: url,
						type		: "post",
						data		: $.param(params),
						success		: function(data){
							if(data.rcode == 200){
								//alert("정상적으로 변경 되었습니다.");
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
			Survey.getSurveyList(1);
			$( "#requestSch_start_dt" ).datepicker({
				calendarWeeks: false,
	            todayHighlight: true,
	            autoclose: true,
	            format: "yyyy-mm-dd",
	            language: "kr"
			});
			$( "#requestSch_end_dt" ).datepicker({
				calendarWeeks: false,
	            todayHighlight: true,
	            autoclose: true,
	            format: "yyyy-mm-dd",
	            language: "kr"
			});
		});
		
		
		//날짜 검색      
		function fn_display(data){
			var temp = data.value;
			$("#period").val(temp);
			
			$("#yesterday").removeClass("btn-info");
			$("#yesterday").addClass("btn-default");
			$("#today").removeClass("btn-info");
			$("#today").addClass("btn-default");
			$("#date_all").removeClass("btn-info");
			$("#date_all").addClass("btn-default");
			$("#custom_date").removeClass("btn-info");
			$("#custom_date").addClass("btn-default");
			document.getElementById("set_date").style.display = "none";
			
			if(data.value=='custom_date'){
				document.getElementById("set_date").style.display = "table-row";
				$("#custom_date").removeClass("btn-default");
				$("#custom_date").addClass("btn-info");
			}else if($("#period").val() == "yesterday"){
				$("#yesterday").removeClass("btn-default");
				$("#yesterday").addClass("btn-info");
			}else if($("#period").val() == "today"){
				$("#today").removeClass("btn-default");
				$("#today").addClass("btn-info");
			}else if($("#period").val() == "date_all"){
				$("#date_all").removeClass("btn-default");
				$("#date_all").addClass("btn-info");
				$("#requestSch_start_dt").val("");
				$("#requestSch_end_dt").val("");
			}
			Survey.getSurveyList(1);
		}
		
		function copy_to_clipboard(id) {
			const t = document.createElement("textarea");
			document.body.appendChild(t);
			t.value = "http://www.ptest.co.kr/survey/" + id + "/login.do";
			t.select();
			document.execCommand('copy');
			document.body.removeChild(t);
		}
	</script>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/view/ka/include/topMenu.jsp" />
	<div id="container">	
		<div id="content" class="admin_con">
			<h2>채용공고관리</h2>
			<form id="SurveyListForm" name="SurveyListForm"  action="">
				<input type="hidden" id="period" name="period" value="">
				<input type="hidden" name="action_mode" value="">
				<div class="mem_search">
					<table>
						<tbody>
							<tr>
								<th>채용공고명</th>
								<td>
									<input type="text" name="s_recruit_nm" class="w300" maxlength="20" onkeypress="if(event.keyCode == 13) { Survey.getSurveyList(1); return false;}"/>
								</td>
								<th>소속회사</th>
								<td>
									<select name="s_company_code" class="w300" onchange="Survey.getSurveyList(1)">
									<option value="" >전체</option>
									<c:forEach var="item" items="${companyGroup}">
										<option value="${item.code}">${item.code_nm}</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>등록일</th>
								<td colspan="3">
									<button type="button" id="date_all" value="date_all" onclick="fn_display(this);" class="btn btn-info" style="margin-right:10px;padding:4px 12px;">전체</button>
									<button type="button" id="yesterday" value="yesterday" onclick="fn_display(this);" class="btn btn-default">어제</button>
									<button type="button" id="today" value="today" onclick="fn_display(this);" class="btn btn-default">오늘</button>
									<button type="button" id="custom_date" value="custom_date" onclick="fn_display(this);" class="btn btn-default" style="padding:4px 12px;">기간 설정</button>
								</td>
							</tr>
							<tr id="set_date" style="display:none">
								<th>시작일</th>
								<td>
									<input type="text" id="requestSch_start_dt" name="s_start_dt" class="yellow" value=""/>
								</td>
								<th>종료일</th>
								<td>
									<input type="text" id="requestSch_end_dt" name="s_end_dt" class="yellow" value=""/>
								</td>
							</tr>
						</tbody>
					</table>
					<div>
						<input type="button" value="조회" onclick="Survey.getSurveyList(1)"/>
					</div>
				</div>
			
			<h3>채용 공고 리스트</h3>
			<div class="btn_space_listT">
				<input type="button" value="리스트다운로드" onclick="Survey.downloadExcel()"/>
				<input type="button" value="선택삭제" onclick="Survey.delteteCheckRaws()"/>
				<input type="button" value="등록" onclick="Survey.surveyInfoPop('regist','')"/>
			</div>
		
			<div>
				<table class="table table-striped thcss">
			          <thead>
			            <tr>
			              <th><input type="checkbox" name="AllCheck" onclick="Survey.deleteCheckAll()"/></th>
			              <th>순번</th>
			              <th>진단명</th>
			              <th>소속회사</th>
			              <th>채용공고</th>
			              <th>실시기간</th>
			              <th>대상인원</th>
			              <th>완료</th>
			              <th>진행중</th>
			              <th>미실시</th>
			              <!-- <th>사용여부</th> -->
			              <th>등록일</th>
			              <th>등록자</th>
			              <th>검사자</th>
			              <th>대표/유사구성원</th>
			              <th>공고수정</th>
			              <th>설문링크</th>
			            </tr>
			          </thead>
			          <tbody id="survey_list"></tbody>
				 </table>
				 <div id="pagingArea" style="position:relative;text-align:center; height: 40px;"></div>
			</div>
			</form>
			<p class="mtop10"></p>
		  	<div id="UserListArea">
			<form id="UserListForm" name="UserListForm" action="" method="post">
				<input type="hidden" name="action_mode" value=""/>
				<input type="hidden" name="s_recruit_survey_id" value=""/>
				<input type="hidden" id="pageId" name="pageId" value=""/>
				<div class="mem_search" style="top: 30px; margin-bottom: 40px;">
					<table>
						<tbody>
							<tr>
								<th>이름</th>
								<td>
									<input type="text" name="s_user_nm" maxlength="20" onkeypress="if(event.keyCode == 13) { User.getUserList(1); return false;}"/>
								</td>
								<th>검사상태</th>
								<td>
									<select name="s_summary_step" onchange="User.getUserList(1)">
									<option value="">전체</option>
										<option value="7">완료</option>
										<option value="1">저장</option>
										<option value="0">미실시</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
					<div>
						<input type="button" value="조회" onclick="User.getUserList(1)"/>
					</div>
				</div>
			<h3>검사자 리스트</h3>
			<div class="btn_space_listT">
				<input type="button" value="리스트다운로드" onclick="User.downloadExcel()"/>
				<input type="button" value="선택삭제" onclick="User.deleteCheckRaws()"/>
				<input type="button" value="검사자등록" onclick="User.userInfoPop('regist','')"/>
				<input type="button" value="메일발송" onclick="User.userMailPop()"/>
			</div>
			<div>
		       	<table class="table table-striped thcss">
			          <thead>
			            <tr>
			              <th><input type="checkbox" name="AllCheck" onclick="User.deleteCheckAll()"/></th>
			              <th>순번</th>
			              <th>채용공고</th>
			              <th>이름</th>
			              <th>생년월일</th>
			              <th>연락처</th>
			              <th>이메일</th>
			              <th>검사상태</th>
			              <th>검사완료일</th>
			              <th>정보수정</th>
			              <th>데이터삭제</th>
			            </tr>
			          </thead>
			          <tbody id="user_list"></tbody>
				 </table>
				 <div id="pagingArea2" style="position:relative;text-align:center; height: 40px;"></div>
		  	</div>
		  	</form>
			</div>
			<p class="mtop10"></p>
		  	<div id="HolderListArea" style="display: none;">
			<form id="HolderListForm" name="HolderListForm" action="" method="post">
				<input type="hidden" name="action_mode" value=""/>
				<input type="hidden" name="s_recruit_survey_id" value=""/>
				<div class="mem_search" style="top: 30px; margin-bottom: 40px;">
					<table>
						<tbody>
							<tr>
								<th>소속회사</th>
								<td>
									<select name="s_company_code" onchange="Holder.getUserList(1)">
									<option value="">전체</option>
									<c:forEach var="item" items="${companyGroup}">
										<option value="${item.code}">${item.code_nm}</option>
									</c:forEach>
									</select>
								</td>
								<th>부서</th>
								<td>
									<select name="s_belong_code" onchange="Holder.getUserList(1)">
									<option value="">전체</option>
									<c:forEach var="item" items="${belongGroup}">
										<option value="${item.code}">${item.code_nm}</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>회원명</th>
								<td>
									<input type="text" name="s_user_nm" maxlength="20" onkeypress="if(event.keyCode == 13) { Holder.getUserList(1); return false;}"/>
								</td>
								<th>대표/유사구성원</th>
								<td>
									<select name="s_holder_type" onchange="Holder.getUserList(1)">
										<option value="">전체</option>
										<option value="representative">대표구성원</option>
										<option value="similar">유사구성원</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
					<div>
						<input type="button" value="조회" onclick="Holder.getUserList(1)"/>
					</div>
				</div>
			<h3>대표/유사구성원 선택</h3>
			<div class="btn_space_listT">
				<input type="button" value="전체선택" onclick="Holder.holderAction('raws_set')"/>
				<input type="button" value="선택해제" onclick="Holder.holderAction('raws_unset')"/>
			</div>
			<div>
		       	<table class="table table-striped thcss">
			          <thead>
			            <tr>
			              <th>순번</th>
			              <th>대표구성원</th>
			              <th>유사구성원</th>
			              <th>이름</th>
			              <th>소속회사</th>
			              <th>지역</th>
			              <th>부서</th>
			              <th>직위</th>
			              <th>직군</th>
			              <th>직무</th>
			              <th>성별</th>
			            </tr>
			          </thead>
			          <tbody id="holder_list"></tbody>
				 </table>
				 <div id="pagingArea3" style="position:relative;text-align:center; height: 40px;"></div>
		  	</div>
		  	</form>
		  	<div class="btn_space_listU"></div>
		  	</div>
		</div>
		
	</div>
	<jsp:include page="/WEB-INF/view/ka/include/foot.jsp" />
</div>
</body>
</html>