<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://www.springframework.org/tags/form" prefix="form"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>인성진단시스템</title>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge; charset=UTF-8" />
	<jsp:include page="/WEB-INF/view/ka/include/head.jsp" />
	<script type='text/javascript' src="/resources/bootstrap/js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.base64.js"></script>
	<script type="text/javascript" src="/resources/js/common.js"></script>
	<script type="text/javascript">
	var User = {
			userParams : {},
			getUserList : function(pageNo){ //리스트 데이터 로딩
				if($("#s_user_nm").val() != "" && $("#s_user_nm").val() != null) {
					User.userParams["s_user_nm"] = $("#s_user_nm").val();
				}else{
					User.userParams["s_user_nm"] = "";
				}
				if($("#s_hp").val() != "" && $("#s_hp").val() != null) {
					User.userParams["s_hp"] = $("#s_hp").val();
				}else{
					User.userParams["s_hp"] = "";
				}
				
				if($("#s_email").val() != "" && $("#s_email").val() != null) {
					User.userParams["s_email"] = $("#s_email").val();
				}else{
					User.userParams["s_email"] = "";
				}
				
				if($("#s_belong_code").val() != "" && $("#s_belong_code").val() != null) {
					User.userParams["s_belong_code"] = $("#s_belong_code").val();
				}else{
					User.userParams["s_belong_code"] = "";
				}
				
				if($("#s_position_code").val() != "" && $("#s_position_code").val() != null) {
					User.userParams["s_position_code"] = $("#s_position_code").val();
				}else{
					User.userParams["s_position_code"] = "";
				}
				if($("#s_job_code").val() != "" && $("#s_job_code").val() != null) {
					User.userParams["s_job_code"] = $("#s_job_code").val();
				}else{
					User.userParams["s_job_code"] = "";
				}
				if($("#s_duty_code").val() != "" && $("#s_duty_code").val() != null) {
					User.userParams["s_duty_code"] = $("#s_duty_code").val();
				}else{
					User.userParams["s_duty_code"] = "";
				}
				
				if($("#s_company_code").val() != "" && $("#s_company_code").val() != null) {
					User.userParams["s_company_code"] = $("#s_company_code").val();
				}else{
					User.userParams["s_company_code"] = "";
				}
				/* if($("#s_user_type").val() != "" && $("#s_user_type").val() != null) {
					User.userParams["s_user_type"] = $("#s_user_type").val();
				}else{
					User.userParams["s_user_type"] = "N";
				} */
				if($("#s_use_yn").val() != "" && $("#s_use_yn").val() != null) {
					User.userParams["s_use_yn"] = $("#s_use_yn").val();
				}else{
					User.userParams["s_use_yn"] = "";
				}
				if( $("#period").val() != "" && $("#period").val() != null) {
					User.userParams["period"] = $("#period").val();
				}else{
					User.userParams["period"] = "";
				}
				var s_start_dt = $("#requestSch_start_dt").val();
				var s_end_dt = $("#requestSch_end_dt").val();
				if((s_start_dt == "" && s_end_dt != "") || (s_start_dt != "" && s_end_dt == "")){
					alert("등록시작일과 등록종료일을 모두 입력하여 주시기 바랍니다.");
					return;
				}
				
				if( $("#requestSch_start_dt").val() != undefined && $("#requestSch_start_dt").val() != "" && $("#requestSch_start_dt").val() != null && $("#requestSch_end_dt").val() != undefined && $("#requestSch_end_dt").val() != "" && $("#requestSch_end_dt").val() != null) {
					User.userParams["s_start_dt"] = $("#requestSch_start_dt").val();
					User.userParams["s_end_dt"] = $("#requestSch_end_dt").val();
				}else{
					User.userParams["s_start_dt"] = "";
					User.userParams["s_end_dt"] = "";
				}

				if(pageNo != undefined && pageNo != null && pageNo != "") {
					User.userParams["pageNo"] = pageNo;
				}else{
					User.userParams["pageNo"] = 1;
				}
				var url = "/ka/user2/getUserList.do";

				$.ajax({
					url			: url,
					type		: "post",
					data		: $.param(User.userParams),
					datatype	: "json",
					success		: function(data){
						User.setUserList(data);
						CODE.createPaging(data,'User.getUserList','pagingArea');
					},
					error	: function(request,status,error){
						alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			setUserList : function(localdata){ //로딩된 데이터를 받아서 그리드 생성
				$("#user_list").html("");
				var tag = "";
				$.each(localdata.list, function(idx, item){
		            tag += 	"<tr>";
		            tag += 	"<td><input type=\"checkbox\" name=\"dchk\" value=\""+item.id+"\" onclick=\"User.dchkClick()\"/></td>";
		            tag +=  "<td>"+(localdata.totalCount - (localdata.numPerPage*(localdata.pageNo-1))-idx)+"</td>";
		            if(item.user_nm != undefined && item.user_nm != null){
		            	tag += 	"<td>"+item.user_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.company_nm != undefined && item.company_nm != null){
		            tag += 	"<td>"+item.company_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.belong_nm != undefined && item.belong_nm != null){
			            tag += 	"<td>"+item.belong_nm+"</td>";
			            }else{
			            	tag += 	"<td></td>";
			        }
		            if(item.position_nm != undefined && item.position_nm != null){
			            tag += 	"<td>"+item.position_nm+"</td>";
			            }else{
			            	tag += 	"<td></td>";
			            }
		            if(item.business_no != undefined && item.business_no != null){
			            tag += 	"<td>"+item.business_no+"</td>";
			            }else{
			            	tag += 	"<td></td>";
			            }
		            if(item.email != undefined && item.email != null){
			            tag += 	"<td>"+item.email+"</td>";
			            }else{
			            	tag += 	"<td></td>";
			            }     
		           /*  if(item.recruit_nm != undefined && item.recruit_nm != null){
			            tag += 	"<td>"+item.recruit_nm+"</td>";
			            }else{
			            	tag += 	"<td></td>";
			            } */
		            
		            if(item.hp != undefined && item.hp != null){
		            tag += 	"<td>"+item.hp+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
			            /*      
		            if(item.position_nm != undefined && item.position_nm != null){
			            tag += 	"<td>"+item.position_nm+"</td>";
			            }else{
			            	tag += 	"<td></td>";
			            }
		                if(item.job_nm != undefined && item.job_nm != null){
			            tag += 	"<td>"+item.job_nm+"</td>";
			            }else{
			            	tag += 	"<td></td>";
			            }			            
		            
		         if(item.login_fail_cnt != undefined && item.login_fail_cnt != null){
		            	tag += 	"<td>"+item.login_fail_cnt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            } 
		          */  if(item.user_type != undefined && item.user_type != null){ 
		            	tag += "<td>";
		            	if(item.user_type == "N"){
		            		tag += "재직자";
		            	}else if(item.user_type == "A"){
		            		tag += "관리자";
		            	}
		            	tag +=  "</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		           /*  if(item.use_yn != undefined && item.use_yn != null){
		            	tag += 	"<td>"+item.use_yn+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            } */
		            if(item.reg_nm != undefined && item.reg_nm != null){
		            	tag += 	"<td>"+item.reg_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.reg_dt != undefined && item.reg_dt != null){
		            	tag += 	"<td>"+item.reg_dt+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            } 
		            tag += 	"<td>"+"<div class=\"ingrid\"><a href=\"javascript:User.userInfoPop('modify','" + item.id + "');\">보기</a></div>"+"</td>";
		            tag += 	'</tr>';
				}); 
				$("#user_list").append(tag);
			},
			userInfoPop : function(action_mode,id){ //수정 화면
				var url = "/ka/user2/goUserInfoPop.do";
				var title = "등록";
				if(action_mode != undefined && action_mode == 'modify'){
					url = url + "?action_mode="+action_mode+"&id="+id;
					title = "수정";
				}else if(action_mode != undefined && action_mode == 'regist'){
					url = url + "?action_mode="+action_mode;
					title = "등록";  
				}
				COMM_POPUP.openPopOfCustom(null, url, title, 1000, 800);
			},
			userAction : function(action_mode){ //추가/수정/삭제 액션
				
				$("#action_mode").val(action_mode);
				var isAllow = false;
				if(action_mode == "modify" || action_mode == "regist"){
					isAllow = true;
				}else if(action_mode == "delete"){
					isAllow = confirm("검사자 정보를 삭제하시겠습니까?");
				}
				
				if(isAllow == true){
					if(action_mode == "regist"){
						if($("#user_email").val() == ''){
							alert("이메일을 입력해 주세요.");
							$("#user_email").focus();
							return false;
						}
						if(isValidEmail($("#user_email")) == false){
							alert("이메일이 형식에 맞지 않습니다.");
							$("#user_email").focus();
							return false;
						}
					}
					if($("#user_nm").val() == ''){
						alert("이름을 입력해 주세요.");
						$("#user_nm").focus();
						return false;
					}
					
					if($("#user_passwd").val() != ''){
						if($("#user_passwd").val() != $("#user_passwd_confirm").val()){
							alert("비밀번호를 정확히 입력하여 주시기 바랍니다.");
							$("#user_passwd").focus();
							return false;
						}else{
							$("#user_passwd").val($.base64.btoa($("#user_passwd_confirm").val()));
						}
					}
				}
				
				if(isAllow == true){
					if(action_mode == "modify" || action_mode == "regist" || action_mode == "delete"){//일반 가입정보
						$("#UserForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									if(data.rcode == 100){
										alert("이미 회원가입된 이메일 입니다.");
									}else{
										alert("정상적으로 처리 되었습니다.");
										User.getUserList(User.userParams["pageNo"]);
									}
								}else{
									alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
								}
					        }
					    });
					}
				}
				COMM_POPUP.close("comm_popup");
			},
			 downloadExcel:function (){
				if(confirm("엑셀로 다운로드 하시겠습니까?")){
					var form = document.getElementById("UserListForm");
					form.action = "/ka/user2/adminUserListExcel.do";
					form.submit();
				}
			},
			fileUploadForm : function(action_mode){ //Request 추가 화면
				var url = "/ka/user2/rawUploadForm.do";
				var title = "파일등록";
				if(action_mode != undefined && action_mode == 'raw_regist'){
					url = url + "?action_mode="+action_mode;
				}else if(action_mode != undefined && action_mode == 'raw_update'){
					url = url + "?action_mode="+action_mode;
				}
				COMM_POPUP.openPopOfCustom(null, url, title, 900, 400);
			},
			deleteCheckRaws:function (){
				if(!confirm("선택한 항목을 삭제 처리 하시겠습니까?")){
					return;
				}
				
				if (UserListForm.dchk.length){ //2개이상일때 
					cnt = $("#UserListForm input:checkbox[name=dchk]:checked").length;
					if(cnt > 0){
						$('#UserListForm [name="action_mode"]').val("raws_delete");
						$("#UserListForm").attr("action","/ka/user/goUserAction2.do");
						$("#UserListForm").attr("method","post");
						$("#UserListForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									alert("정상적으로 처리 되었습니다.");
									User.getUserList(User.userParams["pageNo"]);
									UserListForm.AllCheck.checked = false;
								}else{
									alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
								}
					        }
					    });
					}else{
						alert("삭제 처리할 채용공고를 선택하여 주시기바랍니다.");
					}
				}else{
					if($("#UserListForm input:checkbox[name=dchk]").is(":checked") == true){
						$('#UserListForm [name="action_mode"]').val("raws_delete");
						$("#UserListForm").attr("action","/ka/user/goUserAction2.do");
						$("#UserListForm").attr("method","post");
						$("#UserListForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									alert("정상적으로 처리 되었습니다.");
									User.getUserList(User.userParams["pageNo"]);
									UserListForm.AllCheck.checked = false;
								}else{
									alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
								}
					        }
					    });
					}else{
						alert("삭제 처리할 대상을 선택하여 주시기바랍니다.");
					}
				}
			},
			dchkClick:function (){
				if (UserListForm.dchk.length){ //2개이상일때 
					var totalCnt = $("#UserListForm input:checkbox[name=dchk]").length;
					var checkedCnt = $("#UserListForm input:checkbox[name=dchk]:checked").length;
					if(totalCnt > 0){
						if(totalCnt != checkedCnt){
							UserListForm.AllCheck.checked = false;
						}else{
							UserListForm.AllCheck.checked = true;
						}
					}
				}else{
					if($("#UserListForm input:checkbox[name=dchk]").is(":checked") == true){
						UserListForm.AllCheck.checked = true;
					}else{
						UserListForm.AllCheck.checked = false;
					}
				}
			},
			deleteCheckAll:function(){
				if (UserListForm.dchk.length){ //2개이상일때
					var checkedCnt = $("#UserListForm input:checkbox[name=dchk]:checked").length;
					if(UserListForm.AllCheck.checked == true){
						$("#UserListForm input:checkbox[name=dchk]").each(function(index,item){
							item.checked = true;	
						});
					}else{
						$("#UserListForm input:checkbox[name=dchk]").each(function(index,item){
							item.checked = false;
						});
					}
				}else{
					if(UserListForm.AllCheck.checked == true){
						$("#UserListForm input:checkbox[name=dchk]").attr("checked",true);
					}else{
						$("#UserListForm input:checkbox[name=dchk]").attr("checked",false);
					}
				}
			}
	}
		$(document).ready(function(){
			User.getUserList(1);
			
			$( "#requestSch_start_dt" ).datepicker({
				calendarWeeks: false,
	            todayHighlight: true,
	            autoclose: true,
	            format: "yyyy-mm-dd",
	            language: "kr"
			});
			$( "#requestSch_end_dt" ).datepicker({
				calendarWeeks: false,
	            todayHighlight: true,
	            autoclose: true,
	            format: "yyyy-mm-dd",
	            language: "kr"
			});
		});
		
		
		//날짜 검색      
		function fn_display(data){
			var temp = data.value;
			$("#period").val(temp);
			
			$("#yesterday").removeClass("btn-info");
			$("#yesterday").addClass("btn-default");
			$("#today").removeClass("btn-info");
			$("#today").addClass("btn-default");
			$("#date_all").removeClass("btn-info");
			$("#date_all").addClass("btn-default");
			$("#custom_date").removeClass("btn-info");
			$("#custom_date").addClass("btn-default");
			document.getElementById("set_date").style.display = "none";
			
			if(data.value=='custom_date'){
				document.getElementById("set_date").style.display = "table-row";
				$("#custom_date").removeClass("btn-default");
				$("#custom_date").addClass("btn-info");
			}else if($("#period").val() == "yesterday"){
				$("#yesterday").removeClass("btn-default");
				$("#yesterday").addClass("btn-info");
			}else if($("#period").val() == "today"){
				$("#today").removeClass("btn-default");
				$("#today").addClass("btn-info");
			}else if($("#period").val() == "date_all"){
				$("#date_all").removeClass("btn-default");
				$("#date_all").addClass("btn-info");
				$("#requestSch_start_dt").val("");
				$("#requestSch_end_dt").val("");
			}
			User.getUserList(1);
		}
		
		function sampleDownload(){
	    	location.href="/ka/user/getRawFile.do";
	    }
	</script>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/view/ka/include/topMenu.jsp" />
	<div id="container" class="printNone">	

		<div id="content" class="admin_con">
			<h2>재직자 관리</h2>
			<form id="UserListForm" action="">
				<input type="hidden" id="period" name="period" value=""/>
				<input type="hidden" name="action_mode" value=""/>
				<div class="mem_search">
					<table>
						<tbody>
							<tr>
								<th>소속회사</th>
								<td>
									<select id="s_company_code" name="s_company_code" onchange="User.getUserList()">
									<option value="">전체</option>
									<c:forEach var="item" items="${companyGroup}">
										<option value="${item.code}">${item.code_nm}</option>
									</c:forEach>
									</select>
								</td>
								<th>검사자 이름</th>
								<td>
									<input type="text" id="s_user_nm" name="s_user_nm" maxlength="20" onkeypress="if(event.keyCode == 13) { User.getUserList(); return false;}"/>
								</td>
							</tr>
							<tr>
								<th>부서</th>
								<td>
									<select id="s_belong_code" name="s_belong_code" onchange="User.getUserList(1)">
									<option value="">전체</option>
									<c:forEach var="item" items="${belongGroup}">
										<option value="${item.code}">${item.code_nm}</option>
									</c:forEach>
									</select>
								</td>
								<th>연락처</th>
								<td>
									<input type="text" id="s_hp" name="s_hp" maxlength="50" onkeypress="if(event.keyCode == 13) { User.getUserList(); return false;}"/>
								</td>
							</tr>
							
							
						</tbody>
					</table>
					<div>
						<input type="button" value="조회" onclick="User.getUserList()"/>
					</div>
				</div>
			
			<!-- 리스트에 대한 버튼 영역(위) -->
			<h3>재직자 리스트</h3>
			<div class="btn_space_listT">
				<input type="button" value="리스트다운로드" onclick="User.downloadExcel()"/>
				<!-- <input type="button" value="사용자 업로드 양식다운로드" onclick="sampleDownload()"/>
				-->
				<input type="button" value="재직자정보수정" onclick="User.fileUploadForm('raw_update')"/>				 
				<input type="button" value="선택삭제" onclick="User.deleteCheckRaws()"/>
				 <!-- <input type="button" value="등록" onclick="User.userInfoPop('regist','')"/> -->
			</div>
		
			<div>
				<table class="table table-striped thcss">
			          <thead>
			            <tr>
			              <th><input type="checkbox" name="AllCheck" onclick="User.deleteCheckAll()"/></th>
			              <th>순번</th>
			              <th>이름</th>
			              <th>소속회사</th>
			              <th>부서</th>
			              <th>직급</th>
			              <th>사번</th>
			              <th>이메일</th>
			              <th>연락처</th>
			              <th>유저유형</th>
			              <th>등록자</th>
			              <th>등록일시</th>
			              <th>정보수정</th>
			            </tr>
			          </thead>
			          <tbody id="user_list"></tbody>
				 </table>
				 <div id="pagingArea" style="position:relative;text-align:center; height: 40px;"></div>
			</div>

			<p class="mtop10"></p>
		  	<div class="btn_space_listU"></div>
		  	</form>
		</div>
		
	</div>
	  
	<jsp:include page="/WEB-INF/view/ka/include/foot.jsp" />
	
</div>
</body>
</html>