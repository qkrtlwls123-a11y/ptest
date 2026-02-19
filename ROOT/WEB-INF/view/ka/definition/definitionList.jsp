<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%
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
	var DefinitionAdmin = {
			params : {},
			getDefinitionList : function(pageNo){ //사용자 리스트 데이터 로딩
				if( $("#s_category_code").val() != "" && $("#s_category_code").val() != null) {
					DefinitionAdmin.params["s_category_code"] = $("#s_category_code").val();
				}else{
					DefinitionAdmin.params["s_category_code"] = "";
				}
				
				if( $("#s_definition_nm").val() != "" && $("#s_definition_nm").val() != null) {
					DefinitionAdmin.params["s_definition_nm"] = $("#s_definition_nm").val();
				}else{
					DefinitionAdmin.params["s_definition_nm"] = "";
				}
				
				if( $("#s_use_yn").val() != "" && $("#s_use_yn").val() != null) {
					DefinitionAdmin.params["s_use_yn"] = $("#s_use_yn").val();
				}else{
					DefinitionAdmin.params["s_use_yn"] = "";
				}
				
				if(pageNo != undefined && pageNo != null && pageNo != "") {
					DefinitionAdmin.params["pageNo"] = pageNo;
				}else{
					DefinitionAdmin.params["pageNo"] = 1;
				}
				
				var url = "/ka/definition/getList.do";

				$.ajax({
					url			: url,
					type		: "post",
					data		: $.param(DefinitionAdmin.params),
					success		: function(data){
						DefinitionAdmin.setDefinitionList(data);
						CODE.createPaging(data,'DefinitionAdmin.getDefinitionList','pagingGridList');
					},
					error	: function(request,status,error){
						alert("[definition] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
					}
				});
			},
			setDefinitionList : function(data){ //로딩된 데이터를 받아서 그리드 생성
				$("#grid_commCdList").html("");
				var tag = "";
				$.each(data.list, function(idx, item){
		            tag += 	"<tr>";
		            tag +=  "<td>"+(data.totalCount - (data.numPerPage*(data.pageNo-1))-idx)+"</td>";
		            if(item.category_nm != undefined && item.category_nm != null){
		            	tag += 	"<td>"+item.category_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.definition_nm != undefined && item.definition_nm != null){
		            	tag += 	"<td>"+item.definition_nm+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.cause1 != undefined && item.cause1 != null){
		            	tag += 	"<td>"+item.cause1+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            if(item.cause2 != undefined && item.cause2 != null){
		            	tag += 	"<td>"+item.cause2+"</td>";
		            }else{
		            	tag += 	"<td></td>";
		            }
		            tag += 	"<td>"+item.use_yn+"</td>";
		            
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
		            tag += 	"<td>"+"<div class=\"ingrid\"><a href=\"javascript:DefinitionAdmin.definitionInfo('modify','" + item.id + "');\">수정</a></div></td>";
		            tag += 	'</tr>';
				});
				$("#grid_commCdList").append(tag);
			},
			definitionInfo : function(action_mode,definition_id){ //정의관리 추가 화면
				var url = "/ka/definition/goInfoPop.do";
				var title = "정의관리등록";
				if(action_mode != undefined && action_mode == 'modify'){
					url = url + "?action_mode="+action_mode+"&id="+definition_id;
					title = "정의관리수정";
				}else if(action_mode != undefined && action_mode == 'regist'){
					url = url + "?action_mode="+action_mode;
					title = "정의관리추가";
				}
				COMM_POPUP.openPopOfCustom(null, url, title, 800, 400);	
			},
			definitionAction : function(action_mode){ //정의관리 추가/수정/삭제 액션
				$('#DefinitionForm [name="action_mode"]').val(action_mode);
				var isAllow = false;
				if(action_mode == "modify" || action_mode == "regist"){
					isAllow = true;
				}else if(action_mode == "delete"){
					isAllow = confirm("정의항목을 삭제하시겠습니까?");
				}
						
				if(isAllow == true){
					if($('#DefinitionForm [name="definition_nm"]').val() == ''){
						alert("정의명을 입력해 주세요.");
						$('#DefinitionForm [name="definition_nm"]').focus();
						return false;
					}
					if($('#DefinitionForm [name="category_code"]').val() == ''){
						alert("분류코드를 선택해 주세요.");
						$('#DefinitionForm [name="company_code"]').focus();
						return false;
					}
					if(action_mode == "modify" || action_mode == "regist" || action_mode == "delete"){//일반 가입정보
						$("#DefinitionForm").ajaxSubmit({
							success:function(data){
								if(data.rcode > -1){
									alert("정상적으로 처리 되었습니다.");
									DefinitionAdmin.getDefinitionList(DefinitionAdmin.params["pageNo"]);
								}else{
									alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
								}
								COMM_POPUP.close("comm_popup");
					        }
					    });
					}
				}
			}
	}
		$(document).ready(function(){
			DefinitionAdmin.getDefinitionList(1);
			//공통정의관리 셋팅
			CODE.subCodeList("s_category_code", "DEFINITION_TYPE", "addAll");
			$("#s_definition_nm").keyup(function(e){
				if (e.keyCode == 13) {
					DefinitionAdmin.getDefinitionList(1);
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
			<h2>정의관리</h2>
			<!-- 사용자 조회조건 영역 -->
				<div class="mem_search">
					<table>
						<colgroup>
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<th>정의명</th>
								<td><input type="text" id="s_definition_nm"/></td>
								<th>분류정의관리</th>
								<td><select id="s_category_code" onchange="DefinitionAdmin.getDefinitionList(1)"></select></td>
								<th>사용여부</th>
								<td>
									<select id="s_use_yn" onchange="DefinitionAdmin.getDefinitionList(1)">
										<option value="">전체</option>
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
					<div>
						<input type="button" value="조회" onclick="DefinitionAdmin.getDefinitionList(1)"/>
					</div>
				</div>
			
			<!-- 리스트에 대한 버튼 영역(위) -->
			<div class="btn_space_listT">
				<input type="button" value="추가" onclick="DefinitionAdmin.definitionInfo('regist')"/>
			</div>
		
			<div id="jqxWidget">
					<table class="table table-striped thcss">
		              <thead>
		                <tr>
		                  <th width="5%">순번</th>
		                  <th width="10%">분류명</th>
		                  <th width="25%">정의명</th>
		                  <th width="10%">요인1</th>
		                  <th width="10%">요인2</th>
		                  <th width="10%">사용여부</th>
		                  <th width="10%">등록자</th>
		                  <th width="10%">등록일시</th>
		                  <th width="10%">수정</th>
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