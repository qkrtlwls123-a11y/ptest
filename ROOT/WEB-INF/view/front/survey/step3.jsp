<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/view/front/include/header.jsp" />
<script type="text/javascript">
var Survey = {
	surveyParams : {},
	makeItemNoSelect : function(id,item_no,item_max_no,inquiry_id,confirm_yn){
		let returnStr = null;
		if(confirm_yn != undefined && confirm_yn != null && confirm_yn == "Y"){
			returnStr = "<select>";
			for(var i=1;i<=item_max_no;i++){
				var selected = "";
				if(item_no != undefined && item_no != null && item_no != "" && item_no == i){
					returnStr += "<option value=\"" + i + "\" selected=\"selected\">" + i + "</option>";
				}
			}
			returnStr += "</select>";
		}else{
			returnStr = "<select style=\"border:1px solid #ff7bac;color: #ff7bac\" onfocus=\"Survey.focusItemNo(this.value)\" onchange=\"Survey.changeItemNo('"+id+"',this,'"+inquiry_id+"')\">";
			for(var i=1;i<=item_max_no;i++){
				var selected = "";
				if(item_no != undefined && item_no != null && item_no != "" && item_no == i){
					selected = " selected=\"selected\" ";
				}
				returnStr += "<option value=\"" + i + "\"" + selected + ">" + i + "</option>";
			}
			returnStr += "</select>";
		}
		return returnStr;
	},
	changeItemNo : function(id,obj,inquiry_id){
		let ItemSortData = {};
		ItemSortData.item_id = id;
		ItemSortData.item_no = obj.value;
		ItemSortData.inquiry_id = inquiry_id;
		ItemSortData.original_no = Survey.surveyParams["focusValue"];
		$.ajax({
			url			: "/survey/${box.id}/step3ItemAjax.do",
			type		: "post",
			data		: $.param(ItemSortData),
			success		: function(data){
				if(data.rcode == 200){
					Survey.setItemList(data,ItemSortData.inquiry_id);
					$(".sortable").sortable({
				    	start: function(event, ui) {

				        },
				        stop: function(event, ui) {
				        	
				            Survey.changeItemNo2();
				        }
				    });
				}else if(data.rcode == 400 || data.rcode == 401){
					alert("설문 URL이 정확한지 확인해주세요.");
					location.href="/survey/alert.do";
				}else if(data.rcode == 402){
					alert("로그인이 되어 있지 않습니다.\n로그인 후 이용해 주세요.");
					location.href="/survey/${box.id}/login.do";
				}else{
					alert("설문 URL이 정확한지 확인해주세요.");
					location.href="/survey/alert.do";
				}
			},
			error	: function(request,status,error){
				alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
			}
		});
	},
	changeItemNo2 : function(original_no,id,change_value,inquiry_id){
		let ItemSortData = {};
		ItemSortData.original_no = original_no;
		ItemSortData.item_id = id;
		ItemSortData.item_no = change_value;
		ItemSortData.inquiry_id = inquiry_id;
		$.ajax({
			url			: "/survey/${box.id}/step3ItemAjax.do",
			type		: "post",
			data		: $.param(ItemSortData),
			success		: function(data){
				if(data.rcode == 200){
					Survey.setItemList(data,ItemSortData.inquiry_id);
					$(".sortable").sortable({
				    	start: function(event, ui) {

				        },
				        stop: function(event, ui) {
				        	console.log("########## SCRIPT START");
				        	console.log($(ui.item.context).attr("id"));
				            console.log($(ui.item.context).attr("original_no"));
				            console.log($(ui.item.context).attr("inquiry_id"));
				            $(ui.item.context).parent().find("div").each(function(index, item){ 
				            	if($(ui.item.context).attr("id") == $(item).attr("id")){
				            		console.log(index+1);
				            		Survey.changeItemNo2($(ui.item.context).attr("original_no"),$(ui.item.context).attr("id").substring(4),index+1,$(ui.item.context).attr("inquiry_id"));
				            	}
				            });
				            console.log("########## SCRIPT END");
				        }
				    });
				}else if(data.rcode == 400 || data.rcode == 401){
					alert("설문 URL이 정확한지 확인해주세요.");
					location.href="/survey/alert.do";
				}else if(data.rcode == 402){
					alert("로그인이 되어 있지 않습니다.\n로그인 후 이용해 주세요.");
					location.href="/survey/${box.id}/login.do";
				}else{
					alert("설문 URL이 정확한지 확인해주세요.");
					location.href="/survey/alert.do";
				}
			},
			error	: function(request,status,error){
				alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
			}
		});
	},
	focusItemNo : function(select_focus_value){
		Survey.surveyParams["focusValue"] = select_focus_value;
	},
	setItemList : function(localdata,inquiry_id){ //로딩된 데이터를 받아서 그리드 생성
		$("#inquiry"+inquiry_id).html("");
		var tag = "";
		tag += 	"<div class=\"sortable\">";
		$.each(localdata.list, function(idx, item){
            tag += 	"<div class=\"question-ranking\" id=\"item"+item.item_id+"\" original_no=\""+item.item_no+"\" inquiry_id=\""+inquiry_id+"\">";
            if(item.item_max_no != undefined && item.item_max_no != null){
	            tag += 	Survey.makeItemNoSelect(item.item_id,item.item_no,item.item_max_no,item.inquiry_id,item.confirm_yn);
	        }
            if(item.item_sentence != undefined && item.item_sentence != null){
            	tag += 	"<span class=\"rank-text\">"+item.item_sentence+"</span>";
            }
            tag += 	"</div>";
		});
		tag += 	"</div>";
		$("#inquiry"+inquiry_id).append(tag);
	},
	nextStep : function(){ 
		if (!fn_validation()) return;
		let items = "";
		$(".question-ranking").each(function(index, item){ 
			if(items == ""){
				items = $(item).attr("id").substring(4);
			}else{
				items += (","+$(item).attr("id").substring(4));
			}
		});
		Survey.surveyParams["items"] = items;
		var url = "/survey/${box.id}/step3456Ajax.do";
		$.ajax({
			url			: url,
			type		: "post",
			data		: $.param(Survey.surveyParams),
			success		: function(data){
				if(data.rcode == 200){
					<c:choose>
						<c:when test="${currentPage lt stepMaxPage}">
							location.href="/survey/${box.id}/step3.do?currentPage=${currentPage+1}";
						</c:when>
						<c:otherwise>
							location.href="/survey/${box.id}/step4.do?currentPage=${currentPage+1}";
						</c:otherwise>
					</c:choose>
				}else if(data.rcode == 400 || data.rcode == 401){
					alert("설문 URL이 정확한지 확인해주세요.");
					location.href="/survey/alert.do";
				}else if(data.rcode == 402){
					alert("로그인이 되어 있지 않습니다.\n로그인 후 이용해 주세요.");
					location.href="/survey/${box.id}/login.do";
				}else{
					alert("설문 URL이 정확한지 확인해주세요.");
					location.href="/survey/alert.do";
				}
			},
			error	: function(request,status,error){
				alert("입력 정보를 확인해주세요.");
			}
		});
	},
	backStep : function(){
		<c:choose>
			<c:when test="${currentPage eq 3}">
				location.href="/survey/${box.id}/step2.do";
			</c:when>
			<c:otherwise>
				location.href="/survey/${box.id}/step3.do?currentPage=${currentPage-1}";
			</c:otherwise>
		</c:choose>
	}
}

function fn_validation() {
	let result = true;
	$("select").each(function(index, item){ 
		if($(item).val() == "0"){
			result = false;
			$(item).focus();
			alert("우선 순위를 모두 선택하여 주시기 바랍니다.");
			return false;
		}
	});
	
	return result;
}

$(function() {
	if($(".question-ranking select").val()){
		$(this).addClass("selected");
		$(this).parent(".question-ranking").css("background","#fef4ea");
	}
	
	$(".sortable").sortable({
    	start: function(event, ui) {
    	    
        },
        stop: function(event, ui) {
        	console.log("########## JSTL START");
        	console.log($(ui.item.context).attr("id"));
            console.log($(ui.item.context).attr("original_no"));
            console.log($(ui.item.context).attr("inquiry_id"));
            $(ui.item.context).parent().find("div").each(function(index, item){ 
            	if($(ui.item.context).attr("id") == $(item).attr("id")){
            		console.log(index+1);
            		Survey.changeItemNo2($(ui.item.context).attr("original_no"),$(ui.item.context).attr("id").substring(4),index+1,$(ui.item.context).attr("inquiry_id"));
            	}
            });
            console.log("########## JSTL END");
        }
    });
    $(".sortable").disableSelection();
});

</script>
</head>
<body>

	<div class="research-wrap">
		<div class="orientation-wrap infor-wrap">
			<div class="sub-title">
				<h4>한국알콜그룹 채용 <span>인성진단검사</span></h4>
				
				<!-- 상단 진행바 -->
				<!-- 막대 바 컬러 넓이는 class="bar-on 에 적용" -->
				<!-- part 텍스트는 class="on" 으로 스위칭 -->
				<div class="progress">
					<div class="bar">
						<div class="bar-on" style="width:${executeRate}%"></div>
					</div>
					<div class="part part1 on"></div>
					<div class="part part2"></div>
					<div class="part part3"></div>
					<div class="part part4"></div>
				</div>
			</div>
			<div class="sub-text">
				<c:if test="${currentPage eq 3}">
				<p class="pink">아래에 제시된 문장을 읽고 자신의 모습과 가장 가까운 순서대로 우선 순위(1~4위)를 선택하십시오.</p>
				<p>항목 별로 순위를 직접 선택하거나 문장을 끌어다 놓을 수 있습니다.</p>
				</c:if>
			</div>
			
			<div class="research-content step3">
			<c:forEach var="item" items="${inquiryList}" varStatus="status">
				<div class="content-inner">
					<p><c:if test="${((pageNo-1)*6 + status.count) lt 10}">0</c:if>${(pageNo-1)*6 + status.count}. </p>
					<div class="question-box" id="inquiry${item.id}">
						<div class="sortable">
						<c:forEach var="item2" items="${item.itemList}" varStatus="status2">
							<div class="question-ranking ui-state-default" id="item${item2.item_id}" original_no="${item2.item_no}" inquiry_id="${item2.inquiry_id}">
								<c:choose>
									<c:when test="${item2.confirm_yn eq 'Y'}">
										<select style="border:1px solid #ff7bac;color: #ff7bac">
										<c:forEach begin="1" end="${item2.item_max_no}" var="item3" step="1">
											<c:if test="${item2.item_no eq item3}">
												<option value="${item3}" selected="selected">${item3}</option>
											</c:if>
										</c:forEach>
										</select>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${empty item2.answer_no}">
												<c:set var="beginValue1" value="0"/>
												<select onfocus="Survey.focusItemNo(this.value)" onchange="Survey.changeItemNo('${item2.item_id}',this,'${item2.inquiry_id}')">
											</c:when>
											<c:otherwise>
												<c:set var="beginValue1" value="1"/>	
												<select style="border:1px solid #ff7bac;color: #ff7bac" onfocus="Survey.focusItemNo(this.value)" onchange="Survey.changeItemNo('${item2.item_id}',this,'${item2.inquiry_id}')">
											</c:otherwise>
										</c:choose>
										
										<c:forEach begin="${beginValue1}" end="${item2.item_max_no}" var="item3" step="1">
											<c:choose>
												<c:when test="${item3 eq 0}">
													<option value="0"></option>
												</c:when>
												<c:otherwise>
													<option value="${item3}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq item3}">selected="selected"</c:when></c:choose>>${item3}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</select>
									</c:otherwise>
								</c:choose>
								<span class="rank-text">${item2.item_sentence}</span>
							</div>
						</c:forEach>
						</div>
					</div>
				</div>
				</c:forEach>
				
				<!-- 이전, 다음 버튼 -->
				<div class="btn-wrap">
					<div>
				<!-- 		<button type="button" class="prev-btn" onclick="Survey.backStep()">이전</button>
				-->		<button type="button" class="prev-btn">이전</button>
						<button type="button" class="next-btn" onclick="Survey.nextStep()">다음</button>
					</div>
				</div>
			</div>
			
			<div class="bottom-bar">
				<div class="display-inbl">
					<div class="bar">
						<c:forEach begin="1" step="1" end="${totalPage}" var="item">
						<c:choose>
							<c:when test="${item lt currentPage or item eq currentPage}">
								<p class="on"></p>
							</c:when>
							<c:otherwise>
								<p></p>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					</div>
					<div class="count">${currentPage}/${totalPage}</div>
				</div>
			</div>
			
		</div>
	</div>
<jsp:include page="/WEB-INF/view/front/include/footer.jsp" />
</body>
</html>