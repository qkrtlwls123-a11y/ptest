<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- - var menuBorder = true-->
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Stack admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities.">
    <meta name="keywords" content="admin template, stack admin template, dashboard template, flat admin template, responsive admin template, web app">
    <title>ONION BOX</title>
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/apple-icon-120.png">
<!--<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/favicon.ico">-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i%7COpen+Sans:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/pickers/daterange/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/selects/select2.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/extensions/dragula.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/tables/datatable/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/tables/extensions/rowReorder.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/tables/extensions/responsive.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/icheck/icheck.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/icheck/custom.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/components.css">
    <!-- END: Theme CSS-->

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/pages/gallery.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/quizlist2.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- END: Custom CSS-->
    <script type="text/javascript">

    $(document).ready(function(){
    	$("#game").addClass("active open");
    	
    	$(document).on("click", ".delete-all", function(){
    		let checkCount = 0;
    		$(".input-chk").each(function(){
    			if($(this).val() == "on"){
    				
    			}else{
    				if($(this).is(":checked")){
    					checkCount++;
        			}
    			}
    		})
    		
    		if(confirm(checkCount+"개 항목을 삭제하시겠습니까?")){
    			let checkId = "";
    			$(".input-chk").each(function(){
        			if($(this).is(":checked")){
        				if($(this).val() == "on"){
            				
            			}else{
            				checkId += "/"+$(this).val();
            			}
        			}
        		})
        		
        		$("#quiz_id").val(checkId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/deleteAllQuiz.json",
    				type : "POST",
    				data : params,
    				success : function(result) {
    					if (result.resultCode == "success") {
    						alert("삭제 되었습니다.");
    						location.reload();
    					} else {
    						
    					}
    				}
    			});
    		}
    	})
    });
	
	function fn_quizRegi(){
		document.parameterVO.action = "${pageContext.request.contextPath}/quizRegi.do";
		document.parameterVO.submit();
	}
	
	function fn_quizDetail(idx){
		$("#quiz_id").val(idx);
		document.parameterVO.action = "${pageContext.request.contextPath}/editor.do";
		document.parameterVO.submit();
	}
	
	function fn_sendMail(email){
		$("#admin_email").val(email);
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/sendMail.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					alert("발송 되었습니다.");
				} else {
					
				}
			}
		});
	}
	
	function fn_changeCompany(idx){
		$("#company_id").val(idx.value);
		document.parameterVO.action = "${pageContext.request.contextPath}/quizList.do";
		document.parameterVO.submit();
	}
	
	function fn_updateQuiz(idx){
		$("#quiz_id").val(idx);
		document.parameterVO.action = "${pageContext.request.contextPath}/quizDetail.do";
		document.parameterVO.submit();
	}
	
</script>	

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu content-left-sidebar todo-application  fixed-navbar" data-open="click" data-menu="vertical-menu" data-col="content-left-sidebar">

    <!-- BEGIN: Header-->
    <c:import url="/systemTopMenu.do"/>
    <!-- END: Header-->


    <!-- BEGIN: Main Menu-->
    <div class="main-menu menu-fixed menu-dark menu-accordion menu-shadow" data-scroll-to-active="true">
        <c:import url="/systemLeftMenu.do"/>
    </div>
    <!-- END: Main Menu-->

    <!-- BEGIN: Content-->
    <div class="app-content content content-radius">
        <div class="content-right" style="width: calc(100% - 15px) !important;">
            <div class="content-overlay"></div>
            <div class="content-wrapper">
            	<form:form id="parameterVO" name="parameterVO">
            		<input type="hidden" id="quiz_id" name="quiz_id" value=""/>
            		<input type="hidden" id="company_id" name="company_id" value="${parameterVO.company_id}"/>
            	</form:form>
                <div class="content-header row">
                </div>
                <div class="content-body">
                    <div class="app-content-overlay"></div>
					<h3 class="content-header-title mb-0 mt-1 pl-1">퀴즈 관리</h3>
					<div class="row breadcrumbs-top mb-1 pl-1">
						<div class="breadcrumb-wrapper col-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/siteList.do">HOME</a>
								</li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/quizList.do">게임 관리</a>
								</li>
								<li class="breadcrumb-item active">퀴즈 관리
								</li>
							</ol>
						</div>
					</div>
                    <section class="card contentsArea">
                    	<div class="card-head">
                             <div class="card-header">
                                 <h4 class="card-title"></h4>
                                 <div class="controls">
									<select class="select2 form-control" style="width:200px;" onchange="javascript:fn_changeCompany(this);return false;">
										<option value="0" <c:if test="${parameterVO.company_id == 0}">selected</c:if>>공용</option>
										<c:forEach var="companyList" items="${companyList}" varStatus="status">
											<option value="${companyList.company_id}" <c:if test="${parameterVO.company_id == companyList.company_id}">selected</c:if>>${companyList.company_name}</option>
										</c:forEach>
									</select>
								</div>
                                 <div class="heading-elements mt-0">
                                     <button class="btn btn-primary btn-md" ><i class="d-md-none d-block feather icon-plus white"></i>
                                         <span class="d-md-block d-none" onclick="javascript:fn_quizRegi();return false;">퀴즈 등록</span></button>
                                 </div>
                             </div>
                         </div>
                         <div class="card-body">
                         	<button type="button" class="btn btn-danger btn-sm delete-all mb-1">삭제</button>
                                        <!-- Task List table -->
                                        <div class="table-responsive">
                                            <table id="" class="table table-white-space table-bordered row-grouping display no-wrap icheck table-middle text-center">
                                                <thead>
                                                    <tr>
                                                    	<th><div class="icheckbox_square-blue" style="position: relative;"><input type="checkbox" class="input-chk" id="check-all" onclick="toggle();" style="position: absolute; opacity: 0;"></div></th>
                                                        <th>문항</th>
                                                        <th>퀴즈 타입</th>
                                                        <th>문항 수</th>
														<th>정답 수</th>
														<th>수정일</th>
														<th>등록일</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                	<c:forEach var="resultList" items="${resultList}">
                                                		<fmt:parseDate var="updt_date" value="${resultList.updt_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                		<fmt:parseDate var="reg_date" value="${resultList.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                                                    <tr>
	                                                    	<td>
	                                                    		<div class="icheckbox_square-blue" style="position: relative;"><input type="checkbox" class="input-chk check" style="position: absolute; opacity: 0;" value="${resultList.quiz_id}"></div>
	                                                    	</td>
	                                                        <td>
	                                                           <a href="#" onclick="javascript:fn_updateQuiz(${resultList.quiz_id});return false;">${resultList.quiz_name}</a>
	                                                        </td>
	                                                        <td>
	                                                            <c:if test="${resultList.quiz_type == 'M'}"><span class="btn btn-primary btn-sm">객관식</span></c:if>
	                                                            <c:if test="${resultList.quiz_type == 'S'}"><span class="btn btn-success btn-sm">주관식</span></c:if>
	                                                        </td>
	                                                        <td class="text-center aa">
	                                                        	<c:if test="${resultList.quiz_type == 'M'}">${resultList.quiz_count}개</c:if>
	                                                            <c:if test="${resultList.quiz_type == 'S'}">-</c:if>
	                                                        </td>
	                                                        <td class="double-line bb"><c:if test="${resultList.quiz_type == 'M'}">${resultList.quiz_answer_count}개</c:if>
	                                                            <c:if test="${resultList.quiz_type == 'S'}">-</c:if></td>
	                                                        <td class="text-center cc">
	                                                            <fmt:formatDate value="${updt_date}" pattern="yyyy-MM-dd HH:mm:ss" />
	                                                        </td>
	                                                        <td class="text-center dd">
	                                                           <fmt:formatDate value="${reg_date}" pattern="yyyy-MM-dd HH:mm:ss" />
	                                                        </td>
	                                                    </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                    <!--/ Image grid -->
                </section>

                </div>
            </div>
        </div>
    </div>
    <!-- END: Content-->

    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

    <!-- BEGIN: Footer-->
    <footer class="footer footer-static footer-light navbar-border">
        <p class="clearfix blue-grey lighten-2 text-sm-center mb-0 px-2"><span class="float-md-left d-block d-md-inline-block">Copyright &copy; 2023 <a class="text-bold-800 grey darken-2" href="#">ONION BOX </a></span></p>
    </footer>
    <!-- END: Footer-->


	<script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/extensions/jquery.raty.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/datatable/dataTables.bootstrap4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/datatable/dataTables.responsive.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/datatable/dataTables.rowReorder.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/icheck/icheck.min.js"></script>

	<script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/daterange/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/daterange/daterangepicker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/extensions/dragula.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/app-contacts.js"></script>
    <!-- END: Page JS-->
    
</body>
<!-- END: Body-->

</html>