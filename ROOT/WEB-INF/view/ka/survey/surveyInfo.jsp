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
	//스마트 에디터 적용
	var oEditors = [];
	$(function(){
		$('#SurveyForm [name="survey_cnt"]').keyup(function () {
			$(this).val( $(this).val().replace(/[^0-9]/g,"") );
		});
		$('#SurveyForm [name="start_day"]').datepicker({
			calendarWeeks: false,
            todayHighlight: true,
            autoclose: true,
            format: "yyyy-mm-dd",
            language: "kr"
		});
		$('#SurveyForm [name="end_day"]').datepicker({
			calendarWeeks: false,
            todayHighlight: true,
            autoclose: true,
            format: "yyyy-mm-dd",
            language: "kr"
		});
		//$("#popup_start_hour").keyup(function(){
		//	$(this).val($(this).val().replace(/[^0-9\b]/g,""));
		//});
		//$("#popup_end_hour").keyup(function(){
		//	$(this).val($(this).val().replace(/[^0-9\b]/g,""));
		//});
		
		setTimeout(() => {
			createEditor();
		}, 500);
	});
		
		function createEditor(){
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "board_content",
				sSkinURI: "/resources/smartEditor/SmartEditor2Skin.html",
				fCreator: "createSEditor2",
				htParams : {
					bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					//bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
					//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
				}
			});
		}
</script>
		<div id="content" class="popup">
				<h2>
				<c:choose>
					<c:when test="${not empty view.id}">
						인성진단 수정
					</c:when>
					<c:otherwise>
						인성진단 등록
					</c:otherwise>
				</c:choose>
				</h2>
				<div class="popup_table">
				<form id="SurveyForm" method="post" action="/ka/survey/goSurveyAction.do">
				<input type="hidden" name="action_mode" value="${box.action_mode}"/>
					<table>
						<tbody>
						<tr>
							<th style="width:15%;">진단명</th>
							<td style="width:35%;">
									<input type="hidden" name="id" value="${view.id}"/>
									<input type="text" class="yellow w300" name="survey_nm" value="${view.survey_nm}"/>
							</td>
							<th style="width:15%;">소속회사</th>
							<td style="width:35%;">
								<select name="company_code">
									<option value="">소속회사를 선택하세요.</option>
									<c:forEach var="item" items="${companyGroup}" varStatus="status">
										<option value="${item.code}" <c:if test="${view.company_code eq item.code}">selected</c:if>>${item.code_nm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>설문시작일</th>
							<td>
									<input type="text" class="yellow w300" name="start_day" value="${view.start_day}"/>
							</td>
							<th>설문종료일</th>
							<td>
									<input type="text" class="yellow w300" name="end_day" value="${view.end_day}"/>
							</td>
						</tr>
						<tr>
							<th>대상인원</th>
							<td>
									<input type="text" class="yellow w300" name="survey_cnt" value="${view.survey_cnt}"/>
							</td>
							<th>사용여부</th>
							<td>
								<select name="use_yn">
									<option value="Y" ${'Y' == view.use_yn ? 'selected="selected"' : ''}>사용</option>
									<option value="N" ${'N' == view.use_yn ? 'selected="selected"' : ''}>미사용</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>직군사용여부</th>
							<td>
								<select name="job_yn">
									<option value="N" ${'N' == view.job_yn ? 'selected="selected"' : ''}>미사용</option>
									<option value="Y" ${'Y' == view.job_yn ? 'selected="selected"' : ''}>사용</option>
								</select>
							</td>
							<th>직무사용여부</th>
							<td>
								<select name="duty_yn">
									<option value="N" ${'N' == view.duty_yn ? 'selected="selected"' : ''}>미사용</option>
									<option value="Y" ${'Y' == view.duty_yn ? 'selected="selected"' : ''}>사용</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>성별사용여부</th>
							<td>
								<select name="gender_yn">
									<option value="N" ${'N' == view.gender_yn ? 'selected="selected"' : ''}>미사용</option>
									<option value="Y" ${'Y' == view.gender_yn ? 'selected="selected"' : ''}>사용</option>
								</select>
							</td>
							<th>연령대사용여부</th>
							<td>
								<select name="age_group_yn">
									<option value="N" ${'N' == view.age_group_yn ? 'selected="selected"' : ''}>미사용</option>
									<option value="Y" ${'Y' == view.age_group_yn ? 'selected="selected"' : ''}>사용</option>
								</select>
							</td>
						</tr>
						<c:if test="${not empty view.id}">
						<tr>
							<th>설문URL</th>
							<td colspan="3">http://www.ptest.co.kr/survey/${view.id}/login.do</td>
						</tr>
						</c:if>
						<tr>
							<th colspan="4">설문 안내메세지</th>
						</tr>
						<tr>
							<td colspan="4">
							<textarea id="board_content" name="survey_info" style="width:100%;height:400px;" placeholder="내용을 입력하세요">${view.survey_info}</textarea>
							</td>
						</tr>
						<c:if test="${not empty view.id}">
							<tr>
								<th>등록일</th>
								<td><c:if test="${not empty view.reg_dt}">${view.reg_dt}</c:if></td>
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
							<input type="button" class="ok_btn" value="저장" onclick="Survey.surveyAction('modify')"/>
							<input type="button" class="ok_btn" value="삭제" onclick="Survey.surveyAction('delete')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:when>
						<c:otherwise>
							<input type="button" class="ok_btn" value="등록" onclick="Survey.surveyAction('regist')"/>
							<input type="button" class="cancle_btn" value="취소" onclick="COMM_POPUP.close()"/>
						</c:otherwise>
					</c:choose>
				</div>
		</div>