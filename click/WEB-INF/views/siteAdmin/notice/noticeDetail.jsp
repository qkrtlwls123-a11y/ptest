<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Stack admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities.">
    <meta name="keywords" content="admin template, stack admin template, dashboard template, flat admin template, responsive admin template, web app">
    <meta name="author" content="PIXINVENT">
    <title>ONION BOX</title>
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/apple-icon-120.png">
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i%7COpen+Sans:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/plugins/forms/validation/form-validation.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/selects/select2.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/pickers/pickadate/pickadate.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/ui/prism.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/katex.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/monokai-sublime.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/quill.snow.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/quill.bubble.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/tables/datatable/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/tables/extensions/rowReorder.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/tables/extensions/responsive.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/icheck/icheck.css">
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/pages/page-users.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/jquery.minicolors.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/core/colors/palette-gradient.css">
    
    <!-- END: Custom CSS-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript">
	
	
	
	$(document).ready(function(){
		$("#noticeList").addClass("active");
		
		setTimeout(fn_updateData, 500);
		
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
        		
        		$("#comment_id").val(checkId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/deleteAllComment.json",
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

	
	function fn_updateData(){
		$(".ql-editor").html('${noticeVO.notice_contents}');
	}
	
	function fn_deleteNotice() {
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/site/${siteVO.site_name}/deleteNotice.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					
					alert("삭제되었습니다.");
					location.href = "${pageContext.request.contextPath}/site/${siteVO.site_name}/noticeList.do";
				} else {
					
				}
			}
		});
	}
	
	function fn_updateNotice() {
		var checkContents = $(".ql-editor").html();
		$("#notice_contents").val(checkContents);
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/updateNotice.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					
					alert("수정되었습니다.");
					location.href = "${pageContext.request.contextPath}/site/${siteVO.site_name}/noticeList.do";
				} else {
					
				}
			}
		});
	}
	
	</script>

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu 2-columns   fixed-navbar" data-open="click" data-menu="vertical-menu" data-col="2-columns">

    <!-- BEGIN: Header-->
    <!-- BEGIN: Header-->
    <c:import url="/siteTopMenu.do"/>
    <!-- END: Header-->


    <!-- BEGIN: Main Menu-->
    <div class="main-menu menu-fixed menu-dark menu-accordion menu-shadow" data-scroll-to-active="true">
        <c:import url="/siteLeftMenu.do"/>
    </div>
    <!-- END: Main Menu-->

    <!-- BEGIN: Content-->
    <div class="app-content content content-radius">
        <div class="content-overlay"></div>
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body">
                <!-- users edit start -->
                <section class="users-edit">
                    <div class="card contentsArea">
                        <div class="card-content">
                            <div class="card-body">
                                <ul class="nav nav-tabs mb-2" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link d-flex align-items-center active" id="account-tab" data-toggle="tab" href="#account" aria-controls="account" role="tab" aria-selected="true">
                                            <i class="feather icon-airplay mr-25"></i><span class="d-none d-sm-block fw-1000 fs-1">공지사항 수정</span>
                                        </a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="account" aria-labelledby="account-tab" role="tabpanel">
                                    	<form:form id="parameterVO" name="parameterVO">
                                    	<input type="hidden" id="notice_id" name="notice_id" value="${noticeVO.notice_id}"/>
                                    	<input type="hidden" id="notice_contents" name="notice_contents" value=""/>
                                    	<input type="hidden" id="comment_id" name="comment_id" value=""/>
                                        <!-- users edit media object start -->
                                        <div class="media mb-1">
                                            <div class="media-body">
                                                <h5 class="media-heading fw-1000">- 공지사항 정보</h5>
                                            </div>
                                        </div>
                                        <!-- users edit media object ends -->
                                        <!-- users edit account form start -->
                                        <div class="row mb-2">
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <div class="controls">
                                                        <label>공지사항 제목</label>
                                                        <input type="text" class="form-control" placeholder="공지사항 제목 " name="notice_title" value="${noticeVO.notice_title}" required data-validation-required-message="공지사항 제목은 필수 입력 항목입니다.">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>공지사항 내용</label>
                                                    <div id="full-container" class="full-container">
		                                                <div class="editor">
		                                                	
		                                                </div>
		                                            </div>
                                                </div>
                                            </div>
                                        </div>
                                        </form:form>
                                        <div class="card-content">
		                                    <div class="card-body">
		                                        <!-- Task List table -->
		                                        <button type="button" class="btn btn-danger btn-sm delete-all mb-1">삭제</button>
		                                        <div class="table-responsive">
		                                            <table id="" class="table table-white-space table-bordered row-grouping display no-wrap icheck table-middle text-center">
		                                                <thead>
		                                                    <tr>
		                                                    	<th><div class="icheckbox_square-blue" style="position: relative;"><input type="checkbox" class="input-chk" id="check-all" onclick="toggle();" style="position: absolute; opacity: 0;"></div></th>
		                                                        <th>댓글 내용</th>
		                                                        <th>회사 명</th>
		                                                        <th>작성자</th>
		                                                        <th>좋아요</th>
		                                                        <th>스크랩</th>
																<th>등록일</th>
																<th>수정일</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                	<c:forEach var="commentList" items="${commentList}">
		                                                		<fmt:parseDate var="regi_date" value="${commentList.regi_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
		                                                		<fmt:parseDate var="updt_date" value="${commentList.updt_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
			                                                    <tr>
			                                                    	<td>
			                                                    		<c:if test="${sessionVO.company_id == noticeVO.company_id}">
			                                                    			<div class="icheckbox_square-blue" style="position: relative;"><input type="checkbox" class="input-chk check" style="position: absolute; opacity: 0;" value="${commentList.comment_id}"></div>
			                                                    		</c:if>
			                                                    	</td>
			                                                        <td class="text-center aa">
			                                                        	<a href="#" onclick="javascript:fn_commentDetail(${commentList.comment_id});return false;">${commentList.comment_text}</a>
			                                                        </td>
			                                                        <td class="text-center aa">
			                                                        	${commentList.company_name}
			                                                        </td>
			                                                        <td class="double-line bb">${commentList.member_name}(${commentList.member_email})</td>
			                                                        <td class="double-line bb">${commentList.comment_like_count}</td>
			                                                        <td class="double-line bb">${commentList.comment_scrap_count}</td>
																	<td class="text-center double-line">
			                                                            <fmt:formatDate value="${regi_date}" pattern="yyyy-MM-dd HH:mm:ss" />
			                                                        </td>
			                                                        <td class="text-center double-line">
			                                                            <fmt:formatDate value="${updt_date}" pattern="yyyy-MM-dd HH:mm:ss" />
			                                                        </td>
			                                                    </tr>
		                                                    </c:forEach>
		                                                </tbody>
		                                            </table>
		                                        </div>
		                                    </div>
                                        <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                                        	<c:if test="${sessionVO.company_id == noticeVO.company_id}">
                                            <button type="button" onclick="javascript:fn_updateNotice();return false;" class="btn btn-primary glow mb-1 mb-sm-0 mr-0 mr-sm-1">수정</button>
                                            <button type="button" onclick="javascript:fn_deleteNotice();return false;" class="btn btn-danger glow mb-1 mb-sm-0 mr-0 mr-sm-1">삭제</button>
                                            </c:if>
                                            <button type="reset" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/site/${siteVO.site_name}/noticeList.do'">취소</button>
                                        </div>
                                        <!-- users edit account form ends -->
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- users edit ends -->
            </div>
        </div>
    </div>
    <!-- END: Content-->

    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

    <!-- BEGIN: Footer-->
    <footer class="footer footer-static footer-light navbar-border">
        <p class="clearfix blue-grey lighten-2 text-sm-center mb-0 px-2"><span class="float-md-left d-block d-md-inline-block">Copyright &copy; 2023 <a class="text-bold-800 grey darken-2" href="#" >클릭컨설팅 </a></span></p>
    </footer>
    <!-- END: Footer-->


    <!-- BEGIN: Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/extensions/jquery.raty.js"></script>

    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/extensions/dragula.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/datatable/dataTables.bootstrap4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/datatable/dataTables.responsive.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/datatable/dataTables.rowReorder.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/pickadate/picker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/pickadate/picker.date.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/quill/quill.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/quill/katex.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/icheck/icheck.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/daterange/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/ui/prism.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/forms/quill/form-text-editor.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/page-users.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/app-invoice.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/navs/navs.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/jquery.minicolors.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/jquery.minicolors.min.js"></script>
    
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/app-contacts.js"></script>
    
    
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>