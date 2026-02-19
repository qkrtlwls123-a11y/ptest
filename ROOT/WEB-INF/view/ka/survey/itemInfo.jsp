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
						질의항목 수정
					</c:when>
					<c:otherwise>
						질의항목 등록
					</c:otherwise>
				</c:choose>
				</h2>
				<div class="popup_table">
				<form id="ItemForm" method="post" action="/ka/item/goItemAction.do">
				<input type="hidden" name="action_mode" value="${box.action_mode}"/>
				<c:choose>
					<c:when test="${not empty view.id}">
						<input type="hidden" name="inquiry_id" value="${view.inquiry_id}"/>
					</c:when>
					<c:otherwise>
						<input type="hidden" name="inquiry_id" value="${box.inquiry_id}"/>
					</c:otherwise>
				</c:choose>
					<table>
						<tbody>
						<tr>
							<th style="width:25%;">항목내용</th>
							<td style="width:75%;">
									<c:if test="${not empty view.id}">
										<input type="hidden" name="id" value="${view.id}"/>
									</c:if>
									<input type="text" class="yellow w600" name="item_sentence" value="${view.item_sentence}"/>
							</td>
						</tr>
						<tr>
							<th style="width:25%;">평가유형</th>
							<td style="width:75%;">
								<select name="item_type">
									<c:forEach var="item" items="${itemTypeGroup}" varStatus="status">
										<option value="${item.code}" <c:if test="${view.item_type eq item.code}">selected</c:if>>${item.code_nm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<c:if test="${not empty view.id}">
							<tr>
								<th>순서</th>
								<td>
									<input type="hidden" name="original_no" value="${view.item_no}"/>
									<select name="item_no">
										<c:forEach var="item" items="${sortList}" varStatus="status">
											<option value="${item.item_no}" ${item.item_no == view.item_no ? 'selected="selected"' : ''}>${item.item_no}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						</c:if>
						<tr>
							<th>채점포함여부</th>
							<td>
								<select name="estimation_yn">
									<option value="Y" ${'Y' == view.estimation_yn ? 'selected="selected"' : ''}>사용</option>
									<option value="N" ${'N' == view.estimation_yn ? 'selected="selected"' : ''}>미사용</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>역문항여부</th>
							<td>
								<select name="reverse_score_yn">
									<option value="N" ${'N' == view.reverse_score_yn ? 'selected="selected"' : ''}>미사용</option>
									<option value="Y" ${'Y' == view.reverse_score_yn ? 'selected="selected"' : ''}>사용</option>
								</select>
							</td>
						</tr>
						<c:if test="${not empty view.id}">
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
						<c:when test="${not empty view.id}">
							<input type="button" class="ok_btn" value="저장" onclick="InquiryItem.itemAction('modify')"/>
							<input type="button" class="ok_btn" value="삭제" onclick="InquiryItem.itemAction('delete')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:when>
						<c:otherwise>
							<input type="button" class="ok_btn" value="등록" onclick="InquiryItem.itemAction('regist')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:otherwise>
					</c:choose>
				</div>
		</div>