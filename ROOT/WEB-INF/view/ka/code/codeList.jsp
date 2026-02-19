<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge; charset=UTF-8" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<title>인성검사시스템</title>
	<jsp:include page="/WEB-INF/view/ka/include/head.jsp" />
	
	<script type="text/javascript">
		$(document).ready(function(){
			CodeAdmin.getCodeList(1);
			//공통코드 셋팅
			CODE.subCodeList("codeSch_pcode", "-", "addAll");
			$("#codeSch_code").keyup(function(e){
				if (e.keyCode == 13) {
					CodeAdmin.getCodeList(1);
			    }
			});
			$("#codeSch_name").keyup(function(e){
				if (e.keyCode == 13) {
					CodeAdmin.getCodeList(1);
			    }
			});
		});
	</script>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/view/ka/include/topMenu.jsp" />
	<div id="container">		
		<div id="content" class="admin_con">
			<h2>코드관리</h2>
			<!-- 사용자 조회조건 영역 -->
				<div class="mem_search">
					<table>
						<colgroup>
							<col width="10%">
							<col width="11%">
							<col width="11%">
							<col width="11%">
							<col width="11%">
							<col width="11%">
							<col width="11%">
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<th>코드</th>
								<td><input type="text" id="codeSch_code" name="s_code"/></td>
								<th>코드명</th>
								<td><input type="text" id="codeSch_name" name="s_name"/></td>
								<th>분류코드</th>
								<td><select id="codeSch_pcode" name="s_up_code" onchange="CodeAdmin.getCodeList(1)"></select></td>
								<th>사용여부</th>
								<td>
									<select id="codeSch_use_yn" name="s_use_yn" onchange="CodeAdmin.getCodeList(1)">
										<option value="">전체</option>
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
					<div>
						<input type="button" value="조회" onclick="CodeAdmin.getCodeList(1)"/>
					</div>
				</div>
			
			<!-- 리스트에 대한 버튼 영역(위) -->
			<div class="btn_space_listT">
				<input type="button" value="추가" onclick="CodeAdmin.codeInfo('regist')"/>
			</div>
		
			<div id="jqxWidget">
					<table class="table table-striped thcss">
		              <thead>
		                <tr>
		                  <th>NO</th>
		                  <th>상위코드</th>
		                  <th>코드</th>
		                  <th>코드명</th>
		                  <th>정렬순서</th>
		                  <th>사용여부</th>
		                  <th>등록자</th>
		                  <th>등록일시</th>
		                  <th>수정</th>
		                </tr>
		              </thead>
		              <tbody id="grid_commCdList"></tbody>
		            </table>
				<div id="pagingGridList" style="position:relative;text-align:center; height: 40px;"></div>
			</div>
			<!-- 리스트에 대한 버튼 영역(아래) -->
		  	<div class="btn_space_listU"></div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/view/ka/include/foot.jsp" />
</div>
</body>
</html>