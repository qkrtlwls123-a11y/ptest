
var filesTempArr = [];
var fileName = "";

function fn_addFiles(e) {
		filesTempArr = [];
	    var files = e.target.files;
	    var filesArr = Array.prototype.slice.call(files);
	    var filesArrLen = filesArr.length;
	    var filesTempArrLen = filesTempArr.length;
	    for( var i=0; i<filesArrLen; i++ ) {
	        filesTempArr.push(filesArr[i]);
	        fileName = filesArr[i].name;
	        fn_insertFile();
	    }
	}
	
	function fn_insertFile(){
		var formData = new FormData();
		 
		// 파일 데이터
		for(var i=0, filesTempArrLen = filesTempArr.length; i<filesTempArrLen; i++) {
		   formData.append("files", filesTempArr[i]);
		}
		 
		$.ajax({
		    type : "POST",
		    url : "/click/file/uploadFeverImage.json",
		    data : formData,
		    processData: false,
		    contentType: false,
		    success : function(result) {
		        if(result.resultCode == "success"){
		        	var htmlString = '';
		        	for(var i=0; i<1; i++){
		        		var fileId = result.fileList[i].file_id;
		        		$("#realFileName").html(fileName);
						$("#fever_file_id").val(fileId);
						/* htmlString += '<img src="${pageContext.request.contextPath}/file/down/'+fileId+'.png" alt="" class="tunnel-img-it">';
						$("#previewImage").html(htmlString); */
						$("#btnDelete").removeClass("dis-none");
		        	}
		        }else if(result.resultCode == "imageError"){
		        	openDefaultPopup("loginPopup", '유효하지 않은 파일형식 입니다.');
		        }else{
		            openDefaultPopup("loginPopup", result.message);
		        }
		    },
		    err : function(err) {
		    	openDefaultPopup("loginPopup", err.status);
		    }
		});
	}
	
	function fn_removeFiles() {
		openConfirmPopup('등록된 이미지를 삭제하시겠습니까?', '확 인', "fn_removeFiles_callback");
	}
	
	function fn_removeFiles_callback() {
		
		if(!isEmpty($("#fever_file_name").val())) {
			$("#realFileName").html($("#fever_file_name").val());
		} else {
			$("#realFileName").html("※ 선택된 파일 없음.");
		}
		
		$("#fileupload").val("");
		$("#fever_file_id").val("");
		$("#btnDelete").addClass("dis-none");
		filesTempArr = [];
		fn_closePopup();
	}
