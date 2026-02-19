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
		$(".table-body tr").each(function(index, item){ 
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
							location.href="/survey/${box.id}/step6.do?currentPage=${currentPage+1}";
						</c:when>
						<c:otherwise>
						location.href="/survey/${box.id}/complete.do?currentPage=${currentPage+1}";
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
				location.href="/survey/${box.id}/step5.do?currentPage=${currentPage-1}";
			</c:when>
			<c:otherwise>
				location.href="/survey/${box.id}/step6.do?currentPage=${currentPage-1}";
			</c:otherwise>
		</c:choose>
	}
}

function fn_validation() {
	let result = true;
	$(".table-body tr").each(function(index, item){
		if($('input:radio[name='+$(item).attr("id")+']').is(':checked') == false){
			result = false;
			$(item).focus();
			alert("모든 질문에 첵크하여 주시기 바랍니다.");
			return false;
		}
	});
	
	return result;
}
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
					<div class="part part2"></div>
					<div class="part part3"></div>
					<div class="part part4 on"></div>
				</div>
			</div>
			<div class="sub-text">
				<c:if test="${currentPage eq 20}">
				<p class="green">다음의 문항은 일상생활에서 경험하는 기분, 생각 또는 행동들에 대한 것입니다. 자연스럽고 솔직하게 응답하시기 바랍니다.</p>
				<p>문항을 읽고 오늘을 포함하여 지난 2주일 간 자신에게 있었던 경험을 가장 잘 나타내는 선택지에 체크해 주세요.</p>
				</c:if>
			</div>
			<div class="research-content">
			
				<!-- <h4>* 문항을 읽고 오늘을 포함하여 지난 2주일 간 자신에게 있었던 경험을 가장 잘 나타내는 선택지에  체크해주세요.</h4> -->
				
				<table class="table-wrap green">
					<thead class="table-head">
						<tr>
							<td class="first-span"></td>
							<td>전혀 아니다</td>
							<td>별로 아니다</td>
							<td>약간 그렇다</td>
							<td>많이 그렇다</td>
							<td>매우 그렇다</td>
						</tr>
					</thead>
					<tbody class="table-body">
					<c:forEach var="item" items="${inquiryList}" varStatus="status">
						<c:forEach var="item2" items="${item.itemList}" varStatus="status2">
							<c:choose>
								<c:when test="${item2.confirm_yn eq 'Y'}">
									<tr id="item${item2.item_id}">
										<td class="first-div">${item2.item_sentence}</td>
										<td>
											<div class="radio-wrap2">
												<input id="item1${item2.item_id}" disabled="disabled" value="1" type="radio" name="item${item2.item_id}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 1}">checked="checked"</c:when></c:choose>/>
												<label for="item1${item2.item_id}">
													<span class="chk-icon"></span>
													<span class="m-block">전혀 아니다</span>
												</label>
											</div>
										</td>
										<td>
											<div class="radio-wrap2">
												<input id="item2${item2.item_id}" disabled="disabled" value="2" type="radio" name="item${item2.item_id}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 2}">checked="checked"</c:when></c:choose>>
												<label for="item2${item2.item_id}">
													<span class="chk-icon"></span>
													<span class="m-block">별로 아니다</span>
												</label>
											</div>
										</td>
										<td>
											<div class="radio-wrap2">
												<input id="item3${item2.item_id}" disabled="disabled" value="3" type="radio" name="item${item2.item_id}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 3}">checked="checked"</c:when></c:choose>>
												<label for="item3${item2.item_id}">
													<span class="chk-icon"></span>
													<span class="m-block">약간 그렇다</span>
												</label>
											</div>
										</td>
										<td>
											<div class="radio-wrap2">
												<input id="item4${item2.item_id}" disabled="disabled" value="4" type="radio" name="item${item2.item_id}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 4}">checked="checked"</c:when></c:choose>>
												<label for="item4${item2.item_id}">
													<span class="chk-icon"></span>
													<span class="m-block">많이 그렇다</span>
												</label>
											</div>
										</td>
										<td>
											<div class="radio-wrap2">
												<input id="item5${item2.item_id}" disabled="disabled" value="5" type="radio" name="item${item2.item_id}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 5}">checked="checked"</c:when></c:choose>>
												<label for="item5${item2.item_id}">
													<span class="chk-icon"></span>
													<span class="m-block">매우 그렇다</span>
												</label>
											</div>
										</td>
									</tr>
							</c:when>
							<c:otherwise>
									<tr id="item${item2.item_id}">
										<td class="first-div">${item2.item_sentence}</td>
										<td>
											<div class="radio-wrap2">
												<input id="item1${item2.item_id}" onclick="Survey.changeItemNo('${item2.item_id}','1')" value="1" type="radio" name="item${item2.item_id}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 1}">checked="checked"</c:when></c:choose>/>
												<label for="item1${item2.item_id}">
													<span class="chk-icon"></span>
													<span class="m-block">전혀 아니다</span>
												</label>
											</div>
										</td>
										<td>
											<div class="radio-wrap2">
												<input id="item2${item2.item_id}" onclick="Survey.changeItemNo('${item2.item_id}','2')" value="2" type="radio" name="item${item2.item_id}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 2}">checked="checked"</c:when></c:choose>>
												<label for="item2${item2.item_id}">
													<span class="chk-icon"></span>
													<span class="m-block">별로 아니다</span>
												</label>
											</div>
										</td>
										<td>
											<div class="radio-wrap2">
												<input id="item3${item2.item_id}" onclick="Survey.changeItemNo('${item2.item_id}','3')" value="3" type="radio" name="item${item2.item_id}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 3}">checked="checked"</c:when></c:choose>>
												<label for="item3${item2.item_id}">
													<span class="chk-icon"></span>
													<span class="m-block">약간 그렇다</span>
												</label>
											</div>
										</td>
										<td>
											<div class="radio-wrap2">
												<input id="item4${item2.item_id}" onclick="Survey.changeItemNo('${item2.item_id}','4')" value="4" type="radio" name="item${item2.item_id}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 4}">checked="checked"</c:when></c:choose>>
												<label for="item4${item2.item_id}">
													<span class="chk-icon"></span>
													<span class="m-block">많이 그렇다</span>
												</label>
											</div>
										</td>
										<td>
											<div class="radio-wrap2">
												<input id="item5${item2.item_id}" onclick="Survey.changeItemNo('${item2.item_id}','5')" value="5" type="radio" name="item${item2.item_id}" <c:choose><c:when test="${empty item2.answer_no}"></c:when><c:when test="${item2.item_no eq 5}">checked="checked"</c:when></c:choose>>
												<label for="item5${item2.item_id}">
													<span class="chk-icon"></span>
													<span class="m-block">매우 그렇다</span>
												</label>
											</div>
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:forEach>
					</tbody>
				</table>
				
			</div>
			
			<!-- 이전, 다음 버튼 -->
			<div class="btn-wrap">
				<div>
					<button type="button" class="prev-btn">이전</button>
					<button type="button" class="next-btn" onclick="Survey.nextStep()">다음</button>
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