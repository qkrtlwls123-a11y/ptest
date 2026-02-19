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
				검사자 수정
			</c:when>
			<c:otherwise>
				검사자 등록
			</c:otherwise>
		</c:choose>
		</h2>
		
		<div class="popup_table">
		<form id="UserForm" method="post" action="/ka/user/goUserAction2.do">
		<input type="hidden" name="action_mode" value="${view.action_mode}"/>
		<input type="hidden" name="recruit_survey_id" value=""/>
		<input type="hidden" name="id" value="${view.id}"/>
			<table>
				<colgroup>
					<col width="130">
					<col>
					<col width="130">
					<col>
				</colgroup>
				<tbody>
				<tr>
					<th>등록방법</th>
					<td colspan="3">
						개별등록 : <input type="radio" checked="checked" name="reg_type" value="each1" onclick="User.rowRegView('each1')"/>&nbsp;&nbsp;&nbsp;
						단체등록 : <input type="radio" name="reg_type" value="each2" onclick="User.rowRegView('each2')"/>
						<div class="btn_space_formU">
							<input type="button" class="ok_btn" value="엑셀양식다운로드" onclick="User.sampleDownload()"/>
						</div>
					</td>
				</tr>
				</tbody>
			</table>
			<div id="each1View">
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
						<th>이름</th>
						<td>
							<input type="text" name="user_nm" value="${view.user_nm}" class="w300" maxlength="50"/>
						</td>
						<th>생년월일</th>
						<td>
							<input type="text" name="year_birth" value="${view.year_birth}" class="w100" maxlength="6"/> ex)YYMMDD
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input type="text" id="user_hp" name="hp" value="${view.hp}" class="w200"/>
						</td>
						<th>email</th>
						<td>
							<c:choose>
								<c:when test="${not empty view.email}">
									${view.email}
								</c:when>
								<c:otherwise>
									<input type="text" name="email" value=""/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td colspan="3">
							<input type="text" name="gender_code" value="${view.gender_code}" class="w100" maxlength="50"/> ex)MEN / WOMEN
							<input type="hidden" name="passwd" value=""/>
						</td>
						<!-- <th>비밀번호</th>
						<td>
							<input type="password" name="passwd" value="" class="w300" maxlength="50"/> ex)(YYYYMMDD)
						</td> -->
					</tr>
					<tr>
						<td colspan="4">
							※비밀번호는 생년월일로 자동 설정 됩니다.
						</td>
						<!-- <th>비밀번호</th>
						<td>
							<input type="password" name="passwd" value="" class="w300" maxlength="50"/> ex)(YYYYMMDD)
						</td> -->
					</tr>
					</tbody>
				</table>
				<div class="btn_space_formU">
					<c:choose>
						<c:when test="${not empty view.id}">
							<input type="button" class="ok_btn" value="저장" onclick="User.userAction('modify')"/>
							<input type="button" class="ok_btn" value="삭제" onclick="User.userAction('delete')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:when>
						<c:otherwise>
							<input type="button" class="ok_btn" value="등록" onclick="User.userAction('regist')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div id="each2View" style="display: none">
				<table>
					<caption>파일등록</caption>
					<colgroup>
						<col width="130">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th>엑셀파일</th>
						<td>
							<input type="file" name="upFile" size="32"/>
						</td>
					</tr>
					</tbody>
				</table>
				<div class="btn_space_formU">
					<input type="button" class="ok_btn" value="등록" onclick="User.rowRegAction()"/>
					<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
				</div>
			</div>
		</form>
		</div>

	</div>
	<div id="prog1" style="display:none;">
		<span><img src="/resources/images/common/loading.gif"/></span>
		<span>업로드 중 입니다. 완료까지 기다리세요.</span>
	</div>