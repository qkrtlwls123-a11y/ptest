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
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>파일업로드</title>
	<link rel="shortcut icon" href="/resources/images/common/favicon.ico"/>
	<script type="text/javascript" src="/resources/js/common/common.file.js"></script>
	<!-- common js -->
	<script type="text/javascript" src="/resources/js/jquery-2.2.4.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.number.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.form.js"></script>
	
	<link rel="stylesheet" type="text/css" href="/resources/css/admin/admin_common.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/admin/admin_header.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/admin/admin_popup.css">
	<script type="text/javascript">
		$(document).ready(function(){
			var program_code = $("#file_program_code").val();
			var fileLimit = 0; //업로드가능 파일개수
			var listMode = '';
			if( (program_code == "BOARD" && program_code == "NOTICE") || program_code == "BANNER" || program_code == "POPUP"){
				var fileLimit = 1;
				var listMode = '';
			}else if(program_code == "OFFLINE_LECTURE" || program_code == "PRODUCT" || program_code == "LECTURE"){
				var fileLimit = 3;
				var listMode = 'A';
			}else{
				var fileLimit = 0;
				var listMode = '';
			}
			CommonFile.init(fileLimit,listMode);
		});
	</script>
</head>
<body>
	<div id="wrap">
		
		<div id="pop" class="popup">
			<h2>파일업로드</h2>
			<form method="post" action="/common/file/goFileAction.do" id="fileForm" enctype="multipart/form-data">
			<input type="hidden" id="file_action_mode" name="action_mode" value="regist"/>
			<input type="hidden" id="file_program_id" name="program_id" value="${view.program_id}"/>
			<input type="hidden" id="file_program_code" name="program_code" value="${view.program_code}"/>
			<input type="hidden" id="file_board_code" name="board_code" value="${view.board_code}"/>
			<input type="hidden" id="upFileNum" name="upFileNum" value="${view.upFileNum}"/>
			<div class="popup_table mtop10"> 
			
				<table>
					<tr>
						<th style="width:90px;">파일</th>
						<td>
							<div style="position:relative;">
								<input type="file" id="file_upFile" name="upFile" size="32"/>
							</div>
						</td>
					</tr>
					</table>
			
					<div class="poploading">
						<div id="prog" style="display:none;">
							<span><img src="/resources/images/common/loading.gif"/></span>
							<span>업로드 중 입니다. 완료까지 기다리세요.</span>
						</div>
						<div class="popbtn tcenter">
							<a href="javascript:CommonFile.fileAction2('regist');">저장</a>
							<a href="javascript:window.close();">취소</a>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>