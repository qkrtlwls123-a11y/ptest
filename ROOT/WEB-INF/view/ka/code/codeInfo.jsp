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
	<c:if test="${empty view.code}">
	$("#code_up_code").val($("#codeSch_pcode").val());
	</c:if>
});
</script>
<div id="wrap">
	<div id="pop_content" style="padding:0px 15px;">		
		<c:if test="${empty view.code}">
			<input type="hidden" id="code_sort" name="sort" value="10000"/>
		</c:if>
		<div id="content" class="popup">
				<h2>코드 관리</h2>
				<div class="popup_table">
					<table>
						<tbody>
						<tr>
							<th style="width:25%;">상위코드</th>
							<td style="width:75%;">
								<c:choose>
									<c:when test="${not empty view.code}">
										${view.up_code}
										<input type="hidden" id="code_up_code" name="up_code" value="${view.up_code}"/>
									</c:when>
									<c:otherwise>
										<select id="code_up_code" name="up_code">
											<c:forEach var="item" items="${middleList}" varStatus="status">
												<option value="${item.code}">${item.code_nm} (${item.code})</option>
											</c:forEach>
										</select>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>코드</th>
							<td>
								<c:choose>
									<c:when test="${not empty view.code}">
										${view.code}
										<input type="hidden" id="code_code" name="code" value="${view.code}"/>
									</c:when>
									<c:otherwise>
										<input type="text" class="yellow w300" id="code_code" name="code" value=""/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>코드명</th>
							<td><input type="text" class="yellow w300" id="code_name" name="name" value="${view.code_nm}"/></td>
						</tr>
						<c:if test="${not empty view.code}">
							<tr>
								<th>순서</th>
								<td>
									<input type="hidden" id="original_sort" name="original_sort" value="${view.sort_seq}"/>
									<select id="code_sort" name="sort">
										<c:forEach var="item" items="${sortList}" varStatus="status">
											<option value="${item.sort_seq}" ${item.sort_seq == view.sort_seq ? 'selected="selected"' : ''}>${item.sort_seq}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						</c:if>
						<tr>
							<th>사용여부</th>
							<td>
								<select id="code_use_yn" name="use_yn">
									<option value="Y" ${'Y' == view.use_yn ? 'selected="selected"' : ''}>사용</option>
									<option value="N" ${'N' == view.use_yn ? 'selected="selected"' : ''}>미사용</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>예비컬럼</th>
							<td>
								<input type="text" id="code_reserve1" name="reserve1" value="${view.reserve1}" style="width:500px"/>
							</td>
						</tr>
						<c:if test="${not empty view.code}">
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
				</div>
				<div class="btn_space_formU">
					<c:choose>
						<c:when test="${not empty view.code}">
							<input type="button" class="ok_btn" value="저장" onclick="CodeAdmin.codeAction('modify')"/>
							<input type="button" class="ok_btn" value="삭제" onclick="CodeAdmin.codeAction('delete')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:when>
						<c:otherwise>
							<input type="button" class="ok_btn" value="등록" onclick="CodeAdmin.codeAction('regist')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:otherwise>
					</c:choose>
				</div>
		</div>
	</div>
</div>