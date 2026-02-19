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
			getSurveyList : function(pageNo){ //리스트 데이터 로딩
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
				if($("#s_use_yn").val() != "" && $("#s_use_yn").val() != null) {
					Survey.surveyParams["s_use_yn"] = $("#s_use_yn").val();
				}else{
					Survey.surveyParams["s_use_yn"] = "";
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
				var url = "/ka/survey/getSurveyList.do";

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
		            if(item.use_yn != undefined && item.use_yn != null){
		            	tag += 	"<td>"+item.use_yn+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.reg_nm != undefined && item.reg_nm != null){
		            	tag += 	"<td>"+item.reg_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.reg_dt != undefined && item.reg_dt != null){
		            	tag += 	"<td>"+item.reg_dt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            tag += 	"<td class=\"survey_id"+item.id+"\"><div class=\"ingrid\"><a href=\"javascript:Inquiry.getInquiryList(1,'"+item.id+"');\">질의보기</a> <a href=\"javascript:Survey.surveyInfoPop('modify','" + item.id + "');\">수정</a></div></td>";
		            tag += 	'</tr>';
				});
				$("#survey_list").append(tag);
				if(Inquiry.inquiryParams["s_survey_id"] != undefined && Inquiry.inquiryParams["s_survey_id"] != null && Inquiry.inquiryParams["s_survey_id"] != ""){
					$(".listAll").each(function(index,item){
						$(item).children().each(function(index2,item2){
							$(item2).css("border-top","1px solid #ddd");
							$(item2).css("border-bottom","1px solid #ddd");
						});
					});
					if($(".survey_id"+Inquiry.inquiryParams["s_survey_id"]) != undefined){
						$(".survey_id"+Inquiry.inquiryParams["s_survey_id"]).parent().children().each(function(index,item){
							$(item).css("border-top","3px solid #ef2121");
							$(item).css("border-bottom","3px solid #ef2121");
						});
					}
				}
			},
			surveyInfoPop : function(action_mode,id){ //수정 화면
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
			surveyAction : function(action_mode){ //추가/수정/삭제 액션
				
				$('#SurveyForm [name="action_mode"]').val(action_mode);
				var isAllow = false;
				if(action_mode == "modify" || action_mode == "regist"){
					isAllow = true;
				}else if(action_mode == "delete"){
					isAllow = confirm("진단을 삭제하시겠습니까?");
				}
						
				if(isAllow == true){
					
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
					
					if( $("#board_content") != undefined && $("#board_content") != null && $("#board_content").val() != undefined){
						oEditors.getById["board_content"].exec("UPDATE_CONTENTS_FIELD", []);
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
					form.action = "/ka/survey/surveyListExcel.do";
					form.submit();
				}
			}
	}
	
	var Inquiry = {
			inquiryParams : {},
			getInquiryList : function(pageNo,survey_id){ //리스트 데이터 로딩
				if(survey_id != undefined && survey_id != null && survey_id != ""){
					Inquiry.inquiryParams["s_survey_id"]=survey_id;
					InquiryItem.ItemParams["s_inquiry_id"] = null;
				}
				if(Inquiry.inquiryParams["s_survey_id"] == undefined || Inquiry.inquiryParams["s_survey_id"] == null || Inquiry.inquiryParams["s_survey_id"] == ""){
					alert("진단리스트에서 질의보기를 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				
				$(".listAll").each(function(index,item){
					$(item).children().each(function(index2,item2){
						$(item2).css("border-top","1px solid #ddd");
						$(item2).css("border-bottom","1px solid #ddd");
					});
				});
				$(".survey_id"+Inquiry.inquiryParams["s_survey_id"]).parent().children().each(function(index,item){
					$(item).css("border-top","3px solid #ef2121");
					$(item).css("border-bottom","3px solid #ef2121");
				});

				if(pageNo != undefined && pageNo != null && pageNo != "") {
					Inquiry.inquiryParams["pageNo"] = pageNo;
				}else{
					Inquiry.inquiryParams["pageNo"] = 1;
				}
				var url = "/ka/inquiry/getInquiryList.do";

				$.ajax({
					url			: url,
					type		: "post",
					data		: $.param(Inquiry.inquiryParams),
					success		: function(data){
						Inquiry.setInquiryList(data);
						CODE.createPaging(data,'Inquiry.getInquiryList','pagingArea2');
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			setInquiryList : function(localdata){ //로딩된 데이터를 받아서 그리드 생성
				$("#inquiry_list").html("");
				var tag = "";
				$.each(localdata.list, function(idx, item){
		            tag += 	"<tr class=\"listAll2\">";
		            tag +=  "<td>"+(localdata.totalCount - (localdata.numPerPage*(localdata.pageNo-1))-idx)+"</td>";
		            if(item.inquiry_type != undefined && item.inquiry_type != null){
		            	tag += 	"<td>"+item.inquiry_type_nm+"("+item.inquiry_type+")</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.inquiry_max_no != undefined && item.inquiry_max_no != null){
			            tag += 	"<td>"+Inquiry.makeInquiryNoSelect(item.id,item.inquiry_no,item.inquiry_max_no,item.survey_id,item.inquiry_type) +"</td>";
			        }else{
			          	tag += 	"<td></td>";
			        }
		            if(item.inquiry_sentence != undefined && item.inquiry_sentence != null){
		            tag += 	"<td>"+item.inquiry_sentence+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.edit_nm != undefined && item.edit_nm != null){
		            	tag += 	"<td>"+item.edit_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.edit_dt != undefined && item.edit_dt != null){
		            	tag += 	"<td>"+item.edit_dt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            tag += 	"<td class=\"inquiry_id"+item.id+"\"><div class=\"ingrid\"><a href=\"javascript:InquiryItem.getItemList(1,'"+item.id+"');\">항목보기</a> <a href=\"javascript:Inquiry.inquiryInfoPop('modify','" + item.id + "');\">수정</a></div></td>";
		            tag += 	'</tr>';
				});
				$("#inquiry_list").append(tag);
				if(InquiryItem.ItemParams["s_inquiry_id"] != undefined && InquiryItem.ItemParams["s_inquiry_id"] != null && InquiryItem.ItemParams["s_inquiry_id"] != ""){
					$(".listAll2").each(function(index,item){
						$(item).children().each(function(index2,item2){
							$(item2).css("border-top","1px solid #ddd");
							$(item2).css("border-bottom","1px solid #ddd");
						});
					});
					if($(".inquiry_id"+InquiryItem.ItemParams["s_inquiry_id"]) != undefined){
						$(".inquiry_id"+InquiryItem.ItemParams["s_inquiry_id"]).parent().children().each(function(index,item){
							$(item).css("border-top","3px solid #ef2121");
							$(item).css("border-bottom","3px solid #ef2121");
						});
					}
				}
			},
			inquiryInfoPop : function(action_mode,id){ //수정 화면
				if(Inquiry.inquiryParams["s_survey_id"] == undefined || Inquiry.inquiryParams["s_survey_id"] == null || Inquiry.inquiryParams["s_survey_id"] == ""){
					alert("진단리스트에서 질의보기를 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				var url = "/ka/inquiry/goInfoPop.do";
				var title = "등록";
				if(action_mode != undefined && action_mode == 'modify'){
					url = url + "?action_mode="+action_mode+"&id="+id;
					title = "수정";
				}else if(action_mode != undefined && action_mode == 'regist'){
					url = url + "?action_mode="+action_mode+"&survey_id="+Inquiry.inquiryParams["s_survey_id"];
					title = "등록";
				}
				COMM_POPUP.openPopOfCustom(null, url, title, 1000, 500);
			},
			inquiryAction : function(action_mode){ //추가/수정/삭제 액션
				$('#InquiryForm [name="action_mode"]').val(action_mode);
				var isAllow = false;
				if(action_mode == "modify" || action_mode == "regist"){
					isAllow = true;
				}else if(action_mode == "delete"){
					isAllow = confirm("질의를 삭제하시겠습니까?");
				}
						
				if(isAllow == true){
					if($('#InquiryForm [name="inquiry_sentence"]').val() == ''){
						alert("질의내용을 입력해 주세요.");
						$('#InquiryForm [name="inquiry_sentence"]').focus();
						return false;
					}
					if($('#InquiryForm [name="inquiry_type"]').val() == ''){
						alert("질의유형을 선택해 주세요.");
						$('#InquiryForm [name="inquiry_type"]').focus();
						return false;
					}
					
					if(action_mode == "modify" || action_mode == "regist" || action_mode == "delete"){//일반 가입정보
						$("#InquiryForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									if(data.rcode == 100){
										alert("하위질의 가 존재합니다.\n하위질의부터 삭제하셔야 합니다.");
									}else{
										alert("정상적으로 처리 되었습니다.");
										Inquiry.getInquiryList(Inquiry.inquiryParams["pageNo"]);
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
			makeInquiryNoSelect : function(id,inquiry_no,inquiry_max_no,survey_id,inquiry_type){
				returnStr = "<select onfocus=\"Inquiry.focusInquiryNo(this.value)\" onchange=\"Inquiry.changeInquiryNo('"+id+"',this,'"+survey_id+"','"+inquiry_type+"')\">";
				for(var i=1;i<=inquiry_max_no;i++){
					var selected = "";
					if(inquiry_no != undefined && inquiry_no != null && inquiry_no != "" && inquiry_no == i){
						selected = " selected=\"selected\" ";
					}
					returnStr += "<option value=\"" + i + "\"" + selected + ">" + i + "</option>";
				}
				returnStr += "</select>";
				return returnStr;
			},
			changeInquiryNo : function(id,obj,survey_id,inquiry_type){
				let inquirySortData = {};
				inquirySortData.id = id;
				inquirySortData.inquiry_no = obj.value;
				inquirySortData.survey_id = survey_id;
				inquirySortData.inquiry_type = inquiry_type;
				inquirySortData.original_inquiry_no = Inquiry.inquiryParams["focusValue"];
				$.ajax({
					url			: "/ka/inquiry/goInquiryAction.do",
					type		: "post",
					data		: $.param(inquirySortData),
					success		: function(data){
						Inquiry.getInquiryList(Inquiry.inquiryParams["pageNo"]);
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			focusInquiryNo : function(select_focus_value){
				Inquiry.inquiryParams["focusValue"] = select_focus_value;
			}
	}
	
	var InquiryItem = {
			ItemParams : {},
			getItemList : function(pageNo,inquiry_id){ //리스트 데이터 로딩
				if(inquiry_id != undefined && inquiry_id != null && inquiry_id != ""){
					InquiryItem.ItemParams["s_inquiry_id"]=inquiry_id;
				}
				if(InquiryItem.ItemParams["s_inquiry_id"] == undefined || InquiryItem.ItemParams["s_inquiry_id"] == null || InquiryItem.ItemParams["s_inquiry_id"] == ""){
					alert("질의리스트에서 항목보기를 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				
				$(".listAll2").each(function(index,item){
					$(item).children().each(function(index2,item2){
						$(item2).css("border-top","1px solid #ddd");
						$(item2).css("border-bottom","1px solid #ddd");
					});
				});
				$(".inquiry_id"+InquiryItem.ItemParams["s_inquiry_id"]).parent().children().each(function(index,item){
					$(item).css("border-top","3px solid #ef2121");
					$(item).css("border-bottom","3px solid #ef2121");
				});
				
				if(pageNo != undefined && pageNo != null && pageNo != "") {
					InquiryItem.ItemParams["pageNo"] = pageNo;
				}else{
					InquiryItem.ItemParams["pageNo"] = 1;
				}
				var url = "/ka/item/getItemList.do";

				$.ajax({
					url			: url,
					type		: "post",
					data		: $.param(InquiryItem.ItemParams),
					success		: function(data){
						InquiryItem.setItemList(data);
						CODE.createPaging(data,'InquiryItem.getItemList','pagingArea3');
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			setItemList : function(localdata){ //로딩된 데이터를 받아서 그리드 생성
				$("#item_list").html("");
				var tag = "";
				$.each(localdata.list, function(idx, item){
		            tag += 	"<tr class=\"listAll3\">";
		            tag +=  "<td>"+(localdata.totalCount - (localdata.numPerPage*(localdata.pageNo-1))-idx)+"</td>";
		            if(item.item_type != undefined && item.item_type != null){
		            	tag += 	"<td>"+item.item_type_nm+"("+item.item_type+")</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.item_max_no != undefined && item.item_max_no != null){
			            tag += 	"<td>"+InquiryItem.makeItemNoSelect(item.id,item.item_no,item.item_max_no,item.inquiry_id) +"</td>";
			        }else{
			          	tag += 	"<td></td>";
			        }
		            if(localdata.max_col_no != undefined && localdata.max_col_no != null){
			            tag += 	"<td>"+InquiryItem.makeColNoSelect(item.id,item.col_no,localdata.max_col_no,item.survey_id) +"</td>";
			        }else{
			          	tag += 	"<td></td>";
			        }
		            if(item.item_sentence != undefined && item.item_sentence != null){
		            tag += 	"<td>"+item.item_sentence+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.estimation_yn != undefined && item.estimation_yn != null){
		            	tag += 	"<td>"+item.estimation_yn+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.reverse_score_yn != undefined && item.reverse_score_yn != null){
		            	tag += 	"<td>"+item.reverse_score_yn+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.edit_nm != undefined && item.edit_nm != null){
		            	tag += 	"<td>"+item.edit_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.edit_dt != undefined && item.edit_dt != null){
		            	tag += 	"<td>"+item.edit_dt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            tag += 	"<td class=\"item_id"+item.id+"\"><div class=\"ingrid\"><a href=\"javascript:InquiryItem.itemInfoPop('modify','" + item.id + "');\">수정</a></div></td>";
		            tag += 	'</tr>';
				});
				$("#item_list").append(tag);
				$(".listAll2").each(function(index,item){
					$(item).children().each(function(index2,item2){
						$(item2).css("border-top","1px solid #ddd");
						$(item2).css("border-bottom","1px solid #ddd");
					});
				});
				$(".inquiry_id"+InquiryItem.ItemParams["s_inquiry_id"]).parent().children().each(function(index,item){
					$(item).css("border-top","3px solid #ef2121");
					$(item).css("border-bottom","3px solid #ef2121");
				});
			},
			itemInfoPop : function(action_mode,id){ //수정 화면
				if(InquiryItem.ItemParams["s_inquiry_id"] == undefined || InquiryItem.ItemParams["s_inquiry_id"] == null || InquiryItem.ItemParams["s_inquiry_id"] == ""){
					alert("질의리스트에서 항목보기를 먼저 클릭하여 주시기 바랍니다.");
					return;
				}
				var url = "/ka/item/goInfoPop.do";
				var title = "등록";
				if(action_mode != undefined && action_mode == 'modify'){
					url = url + "?action_mode="+action_mode+"&id="+id;
					title = "수정";
				}else if(action_mode != undefined && action_mode == 'regist'){
					url = url + "?action_mode="+action_mode+"&inquiry_id="+InquiryItem.ItemParams["s_inquiry_id"];
					title = "등록";
				}
				COMM_POPUP.openPopOfCustom(null, url, title, 1000, 500);
			},
			itemAction : function(action_mode){ //추가/수정/삭제 액션
				$('#ItemForm [name="action_mode"]').val(action_mode);
				var isAllow = false;
				if(action_mode == "modify" || action_mode == "regist"){
					isAllow = true;
				}else if(action_mode == "delete"){
					isAllow = confirm("질의를 삭제하시겠습니까?");
				}
						
				if(isAllow == true){
					if($('#ItemForm [name="item_sentence"]').val() == ''){
						alert("항목명을 입력해 주세요.");
						$('#ItemForm [name="item_sentence"]').focus();
						return false;
					}
					if($('#ItemForm [name="item_type"]').val() == ''){
						alert("평가유형을 선택해 주세요.");
						$('#ItemForm [name="item_type"]').focus();
						return false;
					}
					
					if(action_mode == "modify" || action_mode == "regist" || action_mode == "delete"){//일반 가입정보
						$("#ItemForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									if(data.rcode == 100){
										alert("항목을 참조하는 답변이 존재합니다.\n참조하는 답변부터 삭제하셔야 합니다.");
									}else{
										alert("정상적으로 처리 되었습니다.");
										InquiryItem.getItemList(InquiryItem.ItemParams["pageNo"]);
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
			makeItemNoSelect : function(id,item_no,item_max_no,inquiry_id){
				returnStr = "<select onfocus=\"InquiryItem.focusItemNo(this.value)\" onchange=\"InquiryItem.changeItemNo('"+id+"',this,'"+inquiry_id+"')\">";
				for(var i=1;i<=item_max_no;i++){
					var selected = "";
					if(item_no != undefined && item_no != null && item_no != "" && item_no == i){
						selected = " selected=\"selected\" ";
					}
					returnStr += "<option value=\"" + i + "\"" + selected + ">" + i + "</option>";
				}
				returnStr += "</select>";
				return returnStr;
			},
			changeItemNo : function(id,obj,inquiry_id){
				let ItemSortData = {};
				ItemSortData.id = id;
				ItemSortData.item_no = obj.value;
				ItemSortData.inquiry_id = inquiry_id;
				ItemSortData.original_no = InquiryItem.ItemParams["focusValue"];
				$.ajax({
					url			: "/ka/item/goItemAction.do",
					type		: "post",
					data		: $.param(ItemSortData),
					success		: function(data){
						InquiryItem.getItemList(InquiryItem.ItemParams["pageNo"]);
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			focusItemNo : function(select_focus_value){
				InquiryItem.ItemParams["focusValue"] = select_focus_value;
			},
			makeColNoSelect : function(id,col_no,item_max_no,survey_id){
				returnStr = "<select onfocus=\"InquiryItem.focusColNo(this.value)\" onchange=\"InquiryItem.changeColNo('"+id+"',this,'"+survey_id+"')\">";
				for(var i=1;i<=item_max_no;i++){
					var selected = "";
					if(col_no != undefined && col_no != null && col_no != "" && col_no == i){
						selected = " selected=\"selected\" ";
					}
					returnStr += "<option value=\"" + i + "\"" + selected + ">" + i + "</option>";
				}
				returnStr += "</select>";
				return returnStr;
			},
			changeColNo : function(id,obj,survey_id){
				let ColSortData = {};
				ColSortData.id = id;
				ColSortData.col_no = obj.value;
				ColSortData.survey_id = survey_id;
				ColSortData.original_col_no = InquiryItem.ItemParams["focusColValue"];
				$.ajax({
					url			: "/ka/item/setColNumAction.do",
					type		: "post",
					data		: $.param(ColSortData),
					success		: function(data){
						InquiryItem.getItemList(InquiryItem.ItemParams["pageNo"]);
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			focusColNo : function(select_focus_value){
				InquiryItem.ItemParams["focusColValue"] = select_focus_value;
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
	</script>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/view/ka/include/topMenu.jsp" />
	<div id="container">	

		<div id="content" class="admin_con">
			<h2>인성진단 문항관리</h2>
			<form id="SurveyListForm" action="">
				<input type="hidden" id="period" value="">
				<div class="mem_search">
					<table>
						<tbody>
							<tr>
								<th>진단검사명</th>
								<td>
									<input type="text" id="s_servey_nm" name="s_servey_nm" maxlength="20" onkeypress="if(event.keyCode == 13) { Survey.getSurveyList(1); return false;}"/>
								</td>
								<th>소속회사</th>
								<td>
									<select id="s_company_code" name="s_company_code" onchange="Survey.getSurveyList(1)">
									<option value="">전체</option>
									<c:forEach var="item" items="${companyGroup}">
										<option value="${item.code}">${item.code_nm}</option>
									</c:forEach>
									</select>
								</td>
								<th>사용여부</th>
								<td>
									<select id="s_use_yn" name="s_use_yn" onchange="Survey.getSurveyList(1)">
										<option value="">전체</option>
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>등록일</th>
								<td colspan="5">
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
								<th></th>
								<td>	</td>
							</tr>
						</tbody>
					</table>
					<div>
						<input type="button" value="조회" onclick="Survey.getSurveyList(1)"/>
					</div>
				</div>
			</form>
			<h3>전체 진단 리스트</h3>
			<div class="btn_space_listT">
				<input type="button" value="추가" onclick="Survey.surveyInfoPop('regist','')"/>
				<!-- <input type="button" value="엑셀다운로드" onclick="Survey.downExcel()"/> -->
			</div>
		
			<div>
				<table class="table table-striped thcss">
			          <thead>
			            <tr>
			              <th>순번</th>
			              <th>진단명</th>
			              <th>고객사</th>
			              <th>검사기간</th>
			              <th>전체검사</th>
			              <th>완료</th>
			              <th>저장</th>
			              <th>미실시</th>
			              <th>사용여부</th>
			              <th>등록자</th>
			              <th>등록일</th>
			              <th>ACTION</th>
			            </tr>
			          </thead>
			          <tbody id="survey_list"></tbody>
				 </table>
				 <div id="pagingArea" style="position:relative;text-align:center; height: 40px;"></div>
			</div>
			
			<p class="mtop10"></p>
		  	
			<h3>설문에 속한 질의 리스트</h3>
			<div class="btn_space_listT">
				<input type="button" value="추가" onclick="Inquiry.inquiryInfoPop('regist','')"/>
			</div>
			<div>
		       	<table class="table table-striped thcss">
			          <thead>
			            <tr>
			              <th>순번</th>
			              <th>질의유형</th>
			              <th>질의순서</th>
			              <th>질의내용</th>
			              <th>수정자</th>
			              <th>수정일</th>
			              <th>ACTION</th>
			            </tr>
			          </thead>
			          <tbody id="inquiry_list"></tbody>
				 </table>
				 <div id="pagingArea2" style="position:relative;text-align:center; height: 40px;"></div>
		  	</div>
			
			<p class="mtop10"></p>
		  	
			<h3>질의에 속한 항목 리스트</h3>
			<div class="btn_space_listT">
				<input type="button" value="추가" onclick="InquiryItem.itemInfoPop('regist','')"/>
			</div>
			<div>
		       	<table class="table table-striped thcss">
			          <thead>
			            <tr>
			              <th>순번</th>
			              <th>평가유형</th>
			              <th>항목번호</th>
			              <th>진단번호</th>
			              <th>항목내용</th>
			              <th>채점포함여부</th>
			              <th>역문항여부</th>
			              <th>수정자</th>
			              <th>수정일</th>
			              <th>ACTION</th>
			            </tr>
			          </thead>
			          <tbody id="item_list"></tbody>
				 </table>
				 <div id="pagingArea3" style="position:relative;text-align:center; height: 40px;"></div>
		  	</div>
		  	<div class="btn_space_listU"></div>
		</div>
		
	</div>
	<jsp:include page="/WEB-INF/view/ka/include/foot.jsp" />
</div>
</body>
</html>