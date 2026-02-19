var COMM_POPUP = {
		params : {},
		option : {},
		callback : "",
		error : undefined,
		window : undefined,
		set : function(width, height, id){
			id = id || "comm_popup";
			COMM_POPUP.params = {};
			COMM_POPUP.option = {};
			$("#"+id+" #popup_content").empty();
			$("#"+id).find(".modal-dialog").css("max-width","1600px");
			$("#"+id).find(".modal-dialog").css("max-height","1600px");
			$("#"+id).find(".modal-dialog").css("width",width+"px");
			$("#"+id).find(".modal-dialog").css("height",height+"px");
			$("#"+id).find(".modal-body").css("height",(height-50)+"px");
		},
		
		/**
		 * 팝업창을 띄운다.
		 * @param url 팝업창 내용의 url 주소
		 * @param popTitle 팝업창 제목
		 * @param id 대상 팝업창 id
		 */
		open : function(url, popTitle, id){
			id = id || "comm_popup";
			$("#" + id).find(".modal-title").text(popTitle);
			$.ajax({
				url : url,
				method : "GET",
				dataType : "html",
				async : false,
				cache : false,
				beforeSend : function(){
					$("#loading").show();
				},
				complete : function(){
					$("#loading").hide();
				},
				success : function(html){
					//if(html.indexOf("/admin/login/goLoginView.do") > -1) {
					//	alert("로그인이 필요합니다.");
					//	document.location.href="/admin/login/goLoginView.do?retUrl="+document.location.href;
					//}
					$("#"+id).find(".modal-body").html(html);
				},
				error : function(request,status,error){
					alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
				}
			});
			$("#" + id).modal({
				fadeDuration: 2000,
  				fadeDelay: 0.50
			});
			return $("#" + id);
		},
		close : function(id){
			id = id || "comm_popup";
			$("#" + id).modal("hide");
		},
		/**
		 * 팝업 띄울때 아래 파라미터 값들과 함께 호출
		 * 필수항목 : url(body에 뿌릴 requestMapping url), popTitle, width, height
		 * 참고사항 : 
		 * 				id = null or comm_popup >> comm_popup
		 * 				id = child_comm_popup >> child_comm_popup  
		 */
		openPopOfCustom : function(id, url, popTitle, width, height, callback){
			COMM_POPUP.set(width, height, id);
			COMM_POPUP.callback = callback;

			COMM_POPUP.open(url, popTitle, id);
		}
};