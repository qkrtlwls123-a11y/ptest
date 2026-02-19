<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/file-uploaders/dropzone.min.css">
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/plugins/file-uploaders/dropzone.css">
    <!-- END: Custom CSS-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript">
	
	
	
	$(document).ready(function(){
		
		
		$("#courseList").addClass("active open");
		
		$("#logoZone").on("change", fn_addFiles);
		$("#backZone").on("change", fn_addFiles2);
		
		function fn_addFiles(e) {
			filesTempArr = [];
		    var files = e.target.files;
		    var filesArr = Array.prototype.slice.call(files);
		    var filesArrLen = filesArr.length;
		    var filesTempArrLen = filesTempArr.length;
		    for( var i=0; i<filesArrLen; i++ ) {
		    	filesTempArr.push(filesArr[i]);
		        fileName = filesArr[i].name;
		        console.log(fileName);
		        var img = new Image();
		        var _URL = window.URL || window.webkitURL;
		        
		        
		        img.src = _URL.createObjectURL(filesArr[i]);
		        
		        img.onload =function(){
		        	console.log("sizeWidth : "+img.width);
		        	console.log("sizeHeight : "+img.height);
		        	fn_insertFile(img.width, img.height, fileName);
		        }
		    }
		}
		
		function fn_addFiles2(e) {
			filesTempArr = [];
		    var files = e.target.files;
		    var filesArr = Array.prototype.slice.call(files);
		    var filesArrLen = filesArr.length;
		    var filesTempArrLen = filesTempArr.length;
		    for( var i=0; i<filesArrLen; i++ ) {
		    	filesTempArr.push(filesArr[i]);
		        fileName = filesArr[i].name;
		        console.log(fileName);
		        var img = new Image();
		        var _URL = window.URL || window.webkitURL;
		        
		        img.src = _URL.createObjectURL(filesArr[i]);
		        
		        img.onload =function(){
		        	console.log("sizeWidth : "+img.width);
		        	console.log("sizeHeight : "+img.height);
		        	fn_insertFile2(img.width, img.height, fileName);
		        }
		    }
		}
		
		function fn_insertFile(imageWidth, imageHeight, fileName){
			var formData = new FormData();
			 
			// 파일 데이터
			for(var i=0, filesTempArrLen = filesTempArr.length; i<filesTempArrLen; i++) {
			   formData.append("files", filesTempArr[i]);
			}
			 
			$.ajax({
			    type : "POST",
			    url : "${pageContext.request.contextPath}/file/upload.json",
			    data : formData,
			    processData: false,
			    contentType: false,
			    success : function(result) {
			        if(result.resultCode == "success"){
			        	var htmlString = "";
			        	for(var i=0; i<1; i++){
			        		var fileId = result.fileList[i].file_id;
			        		
			    			var htmlString = '<img class="eImage" style="width:100px;" src="${pageContext.request.contextPath}/file/down/'+fileId+'" data="'+fileName+'"/>';
			    			
			    			$("#course_image1").val(fileId);
			    			$("#logoImage").html(htmlString);
			    			$("#logoFileName").text(fileName);
			        	}
			        }else{
	        			fn_removeFiles();
			        	
			        	return false;
			        }
			    },
			    err : function(err) {
			    	
			    }
			});
		}
		
		function fn_insertFile2(imageWidth, imageHeight, fileName){
			var formData = new FormData();
			 
			// 파일 데이터
			for(var i=0, filesTempArrLen = filesTempArr.length; i<filesTempArrLen; i++) {
			   formData.append("files", filesTempArr[i]);
			}
			 
			$.ajax({
			    type : "POST",
			    url : "${pageContext.request.contextPath}/file/upload.json",
			    data : formData,
			    processData: false,
			    contentType: false,
			    success : function(result) {
			        if(result.resultCode == "success"){
			        	var htmlString = "";
			        	for(var i=0; i<1; i++){
			        		var fileId = result.fileList[i].file_id;
			        		
			    			var htmlString = '<img class="eImage" style="width:200px;" src="${pageContext.request.contextPath}/file/down/'+fileId+'" data="'+fileName+'"/>';
			    			
			    			$("#course_image2").val(fileId);
			    			$("#backImage").html(htmlString);
			    			$("#backFileName").text(fileName);
			        	}
			        }else{
	        			fn_removeFiles();
			        	
			        	return false;
			        }
			    },
			    err : function(err) {
			    	
			    }
			});
		}
	});

	function fn_insertCourse() {
		
		if($("#course_main_control").is(":checked")){
			$("#course_main").val("1");
		}else{
			$("#course_main").val("0");
		}
		
		var params = $("form[name=parameterVO]").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/updateCourse.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					var checkCourseId = result.courseId;
					$("#course_id").val(checkCourseId);
					
					location.href = "${pageContext.request.contextPath}/courseUpdateDetail.do?course_id="+checkCourseId+"&company_id=0";
					
				} else {
					
				}
			}
		});
	}
	</script>

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu 2-columns   fixed-navbar" data-open="click" data-menu="vertical-menu-modern" data-col="2-columns">

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
                    <div class="card">
                        <div class="card-content">
                            <div class="card-body">
                                <ul class="nav nav-tabs mb-2" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link d-flex align-items-center active" id="account-tab" data-toggle="tab" href="#account" aria-controls="account" role="tab" aria-selected="true">
                                            <i class="feather icon-airplay mr-25"></i><span class="d-none d-sm-block fw-1000 fs-1">공용 코스 상세</span>
                                        </a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="account" aria-labelledby="account-tab" role="tabpanel">
                                    	<form:form id="parameterVO" name="parameterVO">
                                    	<input type="hidden" id="course_id" name="course_id" value="${courseVO.course_id}"/>
                                    	<input type="hidden" id="course_image1" name="course_image1" value="${courseVO.course_image1}"/>
                                    	<input type="hidden" id="course_image2" name="course_image2" value="${courseVO.course_image2}"/>
                                    	<input type="hidden" id="company_id" name="company_id" value="0"/>
                                    	<input type="hidden" id="course_main" name="course_main" value="0"/>
                                        <!-- users edit media object start -->
                                        <div class="media mb-1">
                                            <div class="media-body">
                                                <h5 class="media-heading fw-1000">- 코스 정보</h5>
                                            </div>
                                        </div>
                                        
                                        <div class="row mb-2">
                                        	<div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <div class="controls">
                                                        <label><span class="required-star">*</span> 코스 명</label>
                                                        <input type="text" class="form-control" placeholder="코스 명 " name="course_name" value="${courseVO.course_name}" required data-validation-required-message="코스 명은 필수 입력 항목입니다.">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="controls">
                                                        <label><span class="required-star">*</span> 코스 설명</label>
                                                        <input type="text" class="form-control" placeholder="코스 설명 " name="course_text" value="${courseVO.course_text}" required data-validation-required-message="코스 설명은 필수 입력 항목입니다.">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label><span class="required-star">*</span> 접속가능 사용자 수</label>
                                                    <input type="text" class="form-control w-25" name="course_people" placeholder="사용자 수" value="${courseVO.course_people}">
                                                </div>
                                                <div class="form-group">
                                                    <label>최저 이용 시간</label>
                                                    <input type="text" class="form-control w-25" name="course_time" placeholder="이용시간" value="${courseVO.course_time}">
                                                </div>
                                                <div class="form-group">
                                                    <div class="custom-control custom-checkbox"><input type="checkbox" id="course_main_control" class="custom-control-input" <c:if test="${courseVO.course_main == '1'}">checked="checked"</c:if>>
                                                        <label class="custom-control-label" for="course_main_control">메인 등록 여부</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </form:form>
                                        <div class="row">
					                        <div class="col-12 col-sm-6">
					                            <div class="card">
				                                    <h5 class="media-heading fw-1000">- 코스 이미지(350px X 700px)</h5>
					                                <div class="card-content collapse show">
					                                    <div class="card-body">
					                                    	<p><input type="file" id="logoZone" class="form-control-file fileuploadFile" style="display:none;"/><label for="logoZone" class="btn btn-primary">로고 업로드</label><label id="logoFileName" style="padding-left:20px;"></label></p>
					                                    	<p id="logoImage"><img class="eImage" style="width:100px;" src="${pageContext.request.contextPath}/file/down/${courseVO.course_image1}"/></p>
					                                    </div>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="col-12 col-sm-6">
					                            <div class="card">
				                                    <h5 class="media-heading fw-1000">- 코스 이미지(425px X 300px)</h5>
					                                <div class="card-content collapse show">
					                                    <div class="card-body">
					                                        <p><input type="file" id="backZone" class="form-control-file fileuploadFile" style="display:none;"/><label for="backZone" class="btn btn-primary">배경 업로드</label><label id="backFileName" style="padding-left:20px;"></label></p>
					                                    	<p id="backImage"><img class="eImage" style="width:100px;" src="${pageContext.request.contextPath}/file/down/${courseVO.course_image2}"/></p>
					                                    </div>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
                                        <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                                            <button type="button" onclick="javascript:fn_insertCourse();return false;" class="btn btn-primary glow mb-1 mb-sm-0 mr-0 mr-sm-1">다음</button>
                                            <button type="reset" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/site/${siteVO.site_name}/courseList.do'">취소</button>
                                        </div>
                                        <!-- users edit account form ends -->
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
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/pickadate/picker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/pickers/pickadate/picker.date.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/extensions/dropzone.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/ui/prism.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/page-users.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/app-invoice.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/navs/navs.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/jquery.minicolors.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/jquery.minicolors.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/colorpicker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/extensions/dropzone.js"></script>
    
    
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>