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
		<div id="content" class="popup">
				<h2>
				<c:choose>
					<c:when test="${not empty view.id}">
						질의 수정
					</c:when>
					<c:otherwise>
						질의 등록
					</c:otherwise>
				</c:choose>
				</h2>
				<div class="popup_table">
				<form id="InquiryForm" method="post" action="/ka/inquiry/goInquiryAction.do">
				<input type="hidden" name="action_mode" value="${box.action_mode}"/>
				<c:choose>
					<c:when test="${not empty view.id}">
						<input type="hidden" name="survey_id" value="${view.survey_id}"/>
					</c:when>
					<c:otherwise>
						<input type="hidden" name="survey_id" value="${box.survey_id}"/>
					</c:otherwise>
				</c:choose>
					<table>
						<tbody>
						<tr>
							<th style="width:25%;">질의 내용</th>
							<td style="width:75%;">
									<c:if test="${not empty view.id}">
										<input type="hidden" name="id" value="${view.id}"/>
									</c:if>
									<input type="text" class="yellow w600" name="inquiry_sentence" value="${view.inquiry_sentence}"/>
							</td>
						</tr>
				<c:choose>
					<c:when test="${empty view.id}">
						<tr>
							<th style="width:25%;">질의유형</th>
							<td style="width:75%;">
								<select name="inquiry_type">
									<option value="">질의유형을 선택하세요.</option>
									<c:forEach var="item" items="${inquiryTypeGroup}" varStatus="status">
										<option value="${item.code}">${item.code_nm} (${item.code})</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<th style="width:25%;">질의유형</th>
							<td style="width:75%;">
								<input type="hidden" name="inquiry_type" value="${view.inquiry_type}"/>
								${view.inquiry_type_nm} (${view.inquiry_type})
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
						<c:if test="${not empty view.id}">
							<tr>
								<th>순서</th>
								<td>
									<input type="hidden" name="original_inquiry_no" value="${view.inquiry_no}"/>
									<select name="inquiry_no">
										<c:forEach var="item" items="${sortList}" varStatus="status">
											<option value="${item.inquiry_no}" ${item.inquiry_no == view.inquiry_no ? 'selected="selected"' : ''}>${item.inquiry_no}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
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
							<input type="button" class="ok_btn" value="저장" onclick="Inquiry.inquiryAction('modify')"/>
							<input type="button" class="ok_btn" value="삭제" onclick="Inquiry.inquiryAction('delete')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:when>
						<c:otherwise>
							<input type="button" class="ok_btn" value="등록" onclick="Inquiry.inquiryAction('regist')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:otherwise>
					</c:choose>
				</div>
		</div>