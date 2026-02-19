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
		$('#user_email').keyup(function () {
			$(this).val( $(this).val().replace(/[^a-z0-9@.]/g,""));
		});
		$('#user_hp').keyup(function () {
			$(this).val( $(this).val().replace(/[^0-9]/g,"") );
		});
		$('#year_birth').keyup(function () {
			$(this).val( $(this).val().replace(/[^0-9]/g,"") );
		});
		<c:if test="${view.use_yn eq 'N'}">
			//$('.allContent input').prop('readonly', true);
			//$('.allContent option').attr('disabled', true);
		</c:if>
	});

</script>
	<div id="content" class="popup">
		<h2>
		<c:choose>
			<c:when test="${not empty view.id}">
				재직자 수정
			</c:when>
			<c:otherwise>
				재직자 등록
			</c:otherwise>
		</c:choose>
		</h2>
		
		<div class="popup_table">
		<form id="UserForm" method="post" action="/ka/user/goUserAction.do">
		<input type="hidden" id="action_mode" name="action_mode" value="${view.action_mode}"/>
		<input type="hidden" id="user_type" name="user_type" value="N"/>
		<input type="hidden" id="id" name="id" value="${view.id}"/>
			<table>
				<caption>상세내역</caption>
				<colgroup>
					<col width="130">
					<col>
					<col width="130">
					<col>
				</colgroup>
				<tbody>
				<tr>
					<th>사용여부</th>
					<td>
						<select id="user_use_yn" name="use_yn">
							<option value="Y" ${'Y' == view.use_yn ? 'selected="selected"' : ''}>사용</option>
							<option value="N" ${'N' == view.use_yn ? 'selected="selected"' : ''}>미사용</option>
						</select>
					</td>
					<th>이름</th>
					<td>
						<input type="text" name="user_nm" value="${view.user_nm}" class="w300" maxlength="50"/>
					</td>
				</tr>
				<tr>
					<th>email</th>
					<td>
						<c:choose>
							<c:when test="${not empty view.email}">
								${view.email}
							</c:when>
							<c:otherwise>
								<input type="text" id="user_email" name="email" value=""/>
							</c:otherwise>
						</c:choose>
					</td>
					<th>휴대폰</th>
					<td>
						<input type="text" id="user_hp" name="hp" value="${view.hp}" class="w200"/>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" id="user_passwd" name="passwd" value="" class="w300" maxlength="50"/>
					</td>
					<th>비밀번호확인</th>
					<td>
						<input type="password" id="user_passwd_confirm" name="passwd_confirm" value="" class="w300" maxlength="50"/>
					</td>
				</tr>
				<tr>
					<th>소속회사</th>
					<td>
						<select name="company_code">
						<option value="">소속회사를 선택하세요.</option>
						<c:forEach var="item" items="${companyGroup}">
							<option value="${item.code}" <c:if test="${view.company_code eq item.code}">selected</c:if>>${item.code_nm}</option>
						</c:forEach>
						</select>
					</td>
					<!-- <th>회원유형</th>
					<td>
						<select name="user_type">
							<option value="" >재직자</option>
						</select>
					</td>
				</tr>
				<tr>
					 --><th>회사지역</th>
					<td>  <!--<td colspan="3">  -->
						<input type="text" name="area" value="${view.area}" class="w300" maxlength="100"/>
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<select name="gender_code">						
							<option value="">성별을 선택하세요.</option>
							<c:forEach var="item" items="${genderGroup}">
								<option value="${item.code}" <c:if test="${view.gender_code eq item.code}">selected</c:if>>${item.code_nm}</option>
							</c:forEach>
						</select>
					</td>
					<th>출생연월일</th>
					<td>
						<input type="text" name="year_birth" value="${view.year_birth}" class="w100" maxlength="6"/>
					</td>
				</tr>
				<tr>
					<th>재직구분</th>
					<td>
						<select name="recruit_code">						
							<option value="">재직구분을 선택하세요.</option>
							<c:forEach var="item" items="${recruitGroup}">
								<option value="${item.code}" <c:if test="${view.recruit_code eq item.code}">selected</c:if>>${item.code_nm}</option>
							</c:forEach>
						</select>
					</td>
					<th>직위</th>
					<td>
						<select name="position_code">						
							<option value="">직위를 선택하세요.</option>
							<c:forEach var="item" items="${positionGroup}">
								<option value="${item.code}" <c:if test="${view.position_code eq item.code}">selected</c:if>>${item.code_nm}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>직군</th>
					<td>
						<select name="job_code">						
							<option value="">직군을 선택하세요.</option>
							<c:forEach var="item" items="${jobGroup}">
								<option value="${item.code}" <c:if test="${view.job_code eq item.code}">selected</c:if>>${item.code_nm}</option>
							</c:forEach>
						</select>
					</td>
					<th>직무</th>
					<td>
					<select name="duty_code">
						<option value="">직무를 선택하세요.</option>
						<c:forEach var="item" items="${dutyGroup}">
							<option value="${item.code}" <c:if test="${view.duty_code eq item.code}">selected</c:if>>${item.code_nm}</option>
						</c:forEach>
						</select>		
					</td>
				</tr>
				<tr>
					<th>소속</th>
					<td>
						<select name="belong_code">
						<option value="">소속을 선택하세요.</option>
						<c:forEach var="item" items="${belongGroup}">
							<option value="${item.code}" <c:if test="${view.belong_code eq item.code}">selected</c:if>>${item.code_nm}</option>
						</c:forEach>
						</select>						
					</td>
					<th>사번</th>
					<td>
						<input type="text" name="business_no" value="${view.business_no}" class="w100" maxlength="20"/>
					</td>
				</tr>				
				</tbody>
			</table>
		</form>
		</div>
	
		<div class="btn_space_formU">
			<c:choose>
				<c:when test="${not empty view.id}">
					<input type="button" class="ok_btn" value="저장" onclick="User.userAction('modify')"/>
					<input type="button" class="ok_btn" value="삭제" onclick="User.userAction('delete')"/>
				</c:when>
				<c:otherwise>
					<input type="button" class="ok_btn" value="등록" onclick="User.userAction('regist')"/>
				</c:otherwise>
			</c:choose>
		</div>
	</div>