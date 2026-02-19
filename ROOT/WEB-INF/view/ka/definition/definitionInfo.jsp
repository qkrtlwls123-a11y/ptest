<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://www.springframework.org/tags/form" prefix="form"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
<script type="text/javascript">
$(function(){
	$('#DefinitionForm [name="cause1"]').keyup(function () {
		$(this).val( $(this).val().replace(/[^0-9]/g,"") );
	});
	$('#DefinitionForm [name="cause2"]').keyup(function () {
		$(this).val( $(this).val().replace(/[^0-9]/g,"") );
	});
});
</script>
<div id="wrap">
	<div id="pop_content" style="padding:0px 15px;">		
		
		<div id="content" class="popup">
				<h2>정의관리</h2>
				<div class="popup_table">
				<form id="DefinitionForm" method="post" action="/ka/definition/goDefinitionAction.do">
					<input type="hidden" name="action_mode" value="${view.action_mode}"/>
					<c:if test="${not empty view.id}">
						<input type="hidden" id="definition_id" name="id" value="${view.id}"/>
					</c:if>
					<table>
						<tbody>
						<tr>
							<th style="width:25%;">분류코드</th>
							<td style="width:75%;">								
								<select id="definition_category_code" name="category_code">
									<option value="">선택</option>
									<c:forEach var="item" items="${definitionList}" varStatus="status">
										<option value="${item.code}" ${item.code == view.category_code ? 'selected="selected"' : ''}>${item.code_nm}</option>
									</c:forEach>
								</select>		
							</td>
						</tr>
						<tr>						
							<th>정의명</th>
							<td><input type="text" class="yellow w300" id="definition_definition_nm" name="definition_nm" value="${view.definition_nm}"/></td>
						</tr>
						<tr>						
							<th colspan="2">정의문구</th>
						</tr>
						<tr>						
							<td colspan="2"><textarea style="width:100%;height:100px" name="definition_txt">${view.definition_txt}</textarea></td>
						</tr>						
						<tr>						
							<th>산정요인1</th>
							<td><input type="text" class="yellow w100" id="definition_cause1" name="cause1" value="${view.cause1}"/></td>
						</tr><tr>						
							<th>산정요인2</th>
							<td><input type="text" class="yellow w100" id="definition_cause2" name="cause2" value="${view.cause2}"/></td>
						</tr>								
						<tr>
							<th>사용여부</th>
							<td>
								<select id="definition_use_yn" name="use_yn">
									<option value="Y" ${'Y' == view.use_yn ? 'selected="selected"' : ''}>사용</option>
									<option value="N" ${'N' == view.use_yn ? 'selected="selected"' : ''}>미사용</option>
								</select>
							</td>
						</tr>						
						<c:if test="${not empty view.definition}">
							<tr>
								<th>등록일</th>
								<td><c:if test="${not empty view.reg_dt}">${view.reg_dt}</c:if></td>
							</tr>
							<tr>
								<th>수정일</th>
								<td><c:if test="${not empty view.edit_dt}">${view.edit_dt}</c:if> </td>
							</tr>
						</c:if>
						</tbody>
					</table>
				</form>
				</div>
				<div class="btn_space_formU">
					<c:choose>
						<c:when test="${not empty view.id}">
							<input type="button" class="ok_btn" value="저장" onclick="DefinitionAdmin.definitionAction('modify')"/>
							<input type="button" class="ok_btn" value="삭제" onclick="DefinitionAdmin.definitionAction('delete')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:when>
						<c:otherwise>
							<input type="button" class="ok_btn" value="등록" onclick="DefinitionAdmin.definitionAction('regist')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:otherwise>
					</c:choose>
				</div>
		</div>
	</div>
</div>