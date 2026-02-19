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
$( function() {
	$(".content-inner").each(function(index, item){
		$("#slider"+$(item).attr("id").substring(4)).slider({
			min: 1,
			max: 9,
			value: $("#select"+$(item).attr("id").substring(4)).val(),
			slide: function( event, ui ) {
				if($(item).attr("confirm") != "Y"){
					$("#select"+$(item).attr("id").substring(4)).val(ui.value);
					if(ui.value != 0){
						Survey.changeItemNo($(item).attr("id").substring(4),ui.value);
					}
				}
			}
		});
		if($(item).attr("confirm") == "Y"){
			$("#slider"+$(item).attr("id").substring(4)).slider( "disable" );
		}
		$("#select"+$(item).attr("id").substring(4)).on( "change", function() {
			$("#slider"+$(item).attr("id").substring(4)).slider( "value", $(this).val());
			if($(item).attr("confirm") != "Y"){
				if($(this).val() != 0){
					Survey.changeItemNo($(item).attr("id").substring(4),$(this).val());
				}
			}
		});
	});
} );
var Survey = {
	surveyParams : {},
	changeItemNo : function(id,value){
		let ItemSortData = {};
		ItemSortData.item_id = id;
		ItemSortData.item_no = value;
		$.ajax({
			url			: "/survey/${box.id}/step456ItemAjax.do",
			type		: "post",
			data		: $.param(ItemSortData),
			success		: function(data){
				if(data.rcode == 200){
					
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
	nextStep : function(){ 
		if (!fn_validation()) return;
		let items = "";
		$(".content-inner").each(function(index, item){ 
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
							location.href="/survey/${box.id}/step4.do?currentPage=${currentPage+1}";
						</c:when>
						<c:otherwise>
						location.href="/survey/${box.id}/step5.do?currentPage=${currentPage+1}";
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
			<c:when test="${currentPage eq stepMinPage}">
				location.href="/survey/${box.id}/step3.do?currentPage=${currentPage-1}";
			</c:when>
			<c:otherwise>
				location.href="/survey/${box.id}/step4.do?currentPage=${currentPage-1}";
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
			alert("모든 항목에 대하여 슬라이드를 이동하거나 선택하여 주시기 바랍니다.");
			return false;
		}
	});
	
	return result;
}

$(function(){
	if($(".question-ranking select").val()){
		$(this).addClass("selected");
		$(this).parent(".question-ranking").css("background","#fef4ea");
	}
})
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
					<div class="part part1"></div>
					<div class="part part2 on"></div>
					<div class="part part3"></div>
					<div class="part part4"></div>
				</div>
			</div>
			
			<div class="sub-text">
				<c:if test="${currentPage eq 6}">
					<p class="green">아래에는 사람들이 경험하는 다양한 감정이나 기분을 표현하는 단어들이 제시되어 있습니다.</p>
					<p class="green">최근 2주간 일상에서 각 감정들을 어느 정도로 느꼈는지 체크해 주세요.</p>
					<p>항목 별로 동그라미 버튼을 적당한 곳에 위치해 놓거나, 박스를 클릭하여 1~9점 척도를  선택하면 됩니다.</p>
				</c:if>
			</div>
			
			<div class="research-content step4">
			<c:forEach var="item" items="${inquiryList}" varStatus="status">
				<c:forEach var="item2" items="${item.itemList}" varStatus="status2">
				<div class="content-inner" id="item${item2.item_id}" confirm="${item2.confirm_yn}">
					<p><span><c:if test="${((pageNo-1)*8 + status2.count) lt 10}">0</c:if>${(pageNo-1)*8 + status2.count}. </span> ${item2.item_sentence}</p>
					<div class="question-box">
						<div class="question-ranking" style="background:none;">
							<div class="slider-wrapper">
								<div class="slider-label">
									<p class="left;"><span>전혀 느끼지 않았다</span>(1점)</p>
									<p class="center"><span>중간 정도로 느꼈다</span>(5점)</p>
									<p class="right"><span>매우 강하게 느꼈다</span>(9점)</p>
								</div>
								<div class='slider' id="slider${item2.item_id}"></div>
							</div>
							<c:choose>
									<c:when test="${item2.confirm_yn eq 'Y'}">
										<select class="minbeds" id="select${item2.item_id}" style="border:1px solid #67c6d3;color:#67c6d3">
											<option value="${item2.item_no}" selected="selected">${item2.item_no}</option>
										</select>
									</c:when>
									<c:otherwise>
										<select class="minbeds" id="select${item2.item_id}">
											<option value="0"></option>
											<option value="1" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 1}">selected="selected"</c:when></c:choose>>1</option>
											<option value="2" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 2}">selected="selected"</c:when></c:choose>>2</option>
											<option value="3" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 3}">selected="selected"</c:when></c:choose>>3</option>
											<option value="4" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 4}">selected="selected"</c:when></c:choose>>4</option>
											<option value="5" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 5}">selected="selected"</c:when></c:choose>>5</option>
											<option value="6" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 6}">selected="selected"</c:when></c:choose>>6</option>
											<option value="7" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 7}">selected="selected"</c:when></c:choose>>7</option>
											<option value="8" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 8}">selected="selected"</c:when></c:choose>>8</option>
											<option value="9" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 9}">selected="selected"</c:when></c:choose>>9</option>
										</select>
									</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				</c:forEach>
			</c:forEach>
			<!-- 이전, 다음 버튼 -->
			<div class="btn-wrap">
				<div>
			<!--		<button type="button" class="prev-btn" onclick="Survey.backStep()">이전</button>
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