var CodeAdmin = {
		params : {},
		getCodeList : function(pageNo){ //사용자 리스트 데이터 로딩
			if( $("#codeSch_code").val() != "" && $("#codeSch_code").val() != null) {
				CodeAdmin.params["s_code"] = $("#codeSch_code").val();
			}else{
				CodeAdmin.params["s_code"] = "";
			}
			
			if( $("#codeSch_name").val() != "" && $("#codeSch_name").val() != null) {
				CodeAdmin.params["s_code_nm"] = $("#codeSch_name").val();
			}else{
				CodeAdmin.params["s_code_nm"] = "";
			}
			
			if( $("#codeSch_pcode").val() != "" && $("#codeSch_pcode").val() != null) {
				CodeAdmin.params["s_up_code"] = $("#codeSch_pcode").val();
			}else{
				CodeAdmin.params["s_up_code"] = "";
			}
			
			if( $("#codeSch_use_yn").val() != "" && $("#codeSch_use_yn").val() != null) {
				CodeAdmin.params["s_use_yn"] = $("#codeSch_use_yn").val();
			}else{
				CodeAdmin.params["s_use_yn"] = "";
			}
			
			if(pageNo != undefined && pageNo != null && pageNo != "") {
				CodeAdmin.params["pageNo"] = pageNo;
			}else{
				CodeAdmin.params["pageNo"] = 1;
			}
			
			var url = "/ka/code/getList.do";

			$.ajax({
				url			: url,
				type		: "post",
				data		: $.param(CodeAdmin.params),
				datatype	: "json",
				success		: function(data){
					CodeAdmin.setCodeList(data);
					CODE.createPaging(data,'CodeAdmin.getCodeList','pagingGridList');
				},
				error	: function(request,status,error){
					alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
				}
			});
		},
		setCodeList : function(data){ //로딩된 데이터를 받아서 그리드 생성
			$("#grid_commCdList").html("");
			var tag = "";
			$.each(data.list, function(idx, item){
	            tag += 	"<tr>";
	            tag +=  "<td>"+(data.totalCount - (data.numPerPage*(data.pageNo-1))-idx)+"</td>";
	            tag += 	"<td>"+item.up_code+"</td>";
	            tag += 	"<td>"+item.code+"</td>";
	            tag += 	"<td>"+item.code_nm+"</td>";
	            if(item.sort_num != undefined && item.sort_num != null){
	            	tag += 	"<td>"+item.sort_num+"</td>";
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
	            tag += 	"<td>"+"<div class=\"ingrid\"><a href=\"javascript:CodeAdmin.codeInfo('modify','" + item.up_code + "','"+item.code+"');\">수정</a></div>"+"</td>";
	            tag += 	'</tr>';
			});
			$("#grid_commCdList").append(tag);
		},
		codeInfo : function(action_mode,upCode,code){ //코드 추가 화면
			var url = "/ka/code/goInfoPop.do";
			var title = "코드등록";
			if(action_mode != undefined && action_mode == 'modify'){
				url = url + "?action_mode="+action_mode+"&up_code="+upCode+"&code="+code;
				title = "코드수정";
			}else if(action_mode != undefined && action_mode == 'regist'){
				url = url + "?action_mode="+action_mode;
				title = "코드추가";
			}
			COMM_POPUP.openPopOfCustom(null, url, title, 800, 400);	
		},
		codeAction : function(action_mode){ //코드 추가/수정/삭제 액션
			var params = {};
			params["action_mode"] = action_mode;
			params["up_code"] = $("#code_up_code").val();
			params["code"] = $("#code_code").val();
			params["code_nm"] = $("#code_name").val();
			params["sort"] = $("#code_sort").val();
			params["original_sort"] = $("#original_sort").val();
			params["use_yn"] = $("#code_use_yn").val();
			params["reserve1"] = $("#code_reserve1").val();
				
			var url = "/ka/code/goCodeAction.do";

			$.ajax({
				url			: url,
				type		: "post",
				data		: $.param(params),
				datatype	: "json",
				success		: function(data){
					//console.log(data);
					if(data.rcode > -1){
						alert("정상적으로 처리 되었습니다.");
						if($("#code_up_code").val() == "-"){
							CODE.subCodeList("codeSch_pcode", "-", "addAll");
						}
						CodeAdmin.getCodeList(CodeAdmin.params["pageNo"]);
					}else{
						alert("오류가 발생했습니다. 확인 후 다시 시도하여 주시기바랍니다.");
					}
				},
				error	: function(request,status,error){
					alert("[code] : " + request.status	+ "\n"	+ "[message] : " + request.responseText	+ "\n"	+ "[error] : " + error);
				}
			});
			COMM_POPUP.close();
		}
}

var CODE = {
	/**
	 * id : 리스트 그릴 타켓 아이디명 
	 * pcode : 상위(그룹)코드
	 * callType : addAll(전체 표기), dataOnly(전체 누락)
	 */
	subCodeList : function(id, up_code, callType){	
		var url = "/common/code/getSubList.do";
		$.ajax({
			url			: url,
			type		: "post",
			data		: {up_code : up_code},
			datatype	: "json",
			success		: function(result){
				$("#" + id).children().remove();
				if(result != null){
					if(callType != "dataOnly"){
						$("#" + id).append("<option value=''>전체</option>");
					}
					for(var i = 0; i < result.length; i++){
							$("#" + id).append("<option value=" + result[i].code + " id=" + result[i].code + ">" + result[i].code_nm + "</option>");
					}
				}else{
					$("#" + id).append("<option value=''>없음</option>");
				}
			}
		});
	},
	/**
	 * 관리자 공통페이징 영역 생성
	 */
	createPaging : function(localdata, pagingFunction,id,params){
		var element = $('<ul class="pagination pagination-sm" style="margin-top: 3px;"></ul>');
        
        var firstElement = '<li><a href="#">&lt;&lt;</a></li>';
        var firstElementObject = $(firstElement);
        firstElementObject.appendTo(element);
        if(localdata.endPage != 0 && localdata.startPage != 1){
	        firstElementObject.click(function (event){
	            var pagenum = 1;
	            eval(pagingFunction+"(pagenum)");
	        });
        }
        
        var secondElement = '<li><a href="#">&lt;</a></li>';
        var secondElementObject = $(secondElement);
        secondElementObject.appendTo(element);
        if(localdata.endPage != 0 && localdata.startPage != 1){
	        secondElementObject.click(function (event) {
	            var pagenum = parseInt(localdata.startPage-1);
	            eval(pagingFunction+"(pagenum)");
	        });
        }
        
        for (i = localdata.startPage; i <= localdata.endPage; i++) {
        	if(i == localdata.pageNo){
        		var middleElement = '<li class="active"><a href="#">'+i+'</a></li>';
        	}else{
        		var middleElement = '<li><a href="#">'+i+'</a></li>';
        	}
            var anchor = $(middleElement);
            anchor.appendTo(element);
            if(i != localdata.pageNo){
                anchor.click(function (event) {
                    var pagenum = parseInt($(event.target).text());
    	            eval(pagingFunction+"(pagenum)");
                });
            }
        }
        
        var beforeLastElement = '<li><a href="#">&gt;</a></li>';
        var beforeLastElementObject = $(beforeLastElement);
        beforeLastElementObject.appendTo(element);
        
        if(localdata.endPage != localdata.totalPage){
        	beforeLastElementObject.click(function (event) {
            	var pagenum = parseInt(localdata.endPage+1);
	            eval(pagingFunction+"(pagenum)");
            });
        }
        
        var lastElement = '<li><a href="#">&gt;&gt;</a></li>';
        var lastElementObject = $(lastElement);
        lastElementObject.appendTo(element);
        if(localdata.endPage != localdata.totalPage){
	        lastElementObject.click(function (event) {
	        	var pagenum = parseInt(localdata.totalPage);
	            eval(pagingFunction+"(pagenum)");
	        });
        }
        $('#'+id).html(element);
        var statusElement = '<div style="position:absolute;top:5px;right:10px;margin-left: 0px;">'+(localdata.startRow+1)+'-'+localdata.endRow+'	of '+localdata.totalCount+'</div>';
        $(statusElement).appendTo('#'+id);
        
	},
	/**
	 * 프론트 PC 공통페이징 영역 생성
	 */
	createPcPaging : function(localdata, pagingFunction){	
		var element = $('.notice_paging');
        
        var firstElement = '<div class="m_page_arrow"> << </div>';
        var firstElementObject = $(firstElement);
        firstElementObject.appendTo(element);
        if(localdata.endPage != 0 && localdata.startPage != 1){
	        firstElementObject.click(function (event){
	            var pagenum = 1;
	            eval(pagingFunction+"(pagenum)");
	        });
        }
        
        var secondElement = '<div class="m_page_arrow"> < </div>';
        var secondElementObject = $(secondElement);
        secondElementObject.appendTo(element);
        if(localdata.endPage != 0 && localdata.startPage != 1){
	        secondElementObject.click(function (event) {
	            var pagenum = parseInt(localdata.startPage-1);
	            eval(pagingFunction+"(pagenum)");
	        });
        }
        
        for (i = localdata.startPage; i <= localdata.endPage; i++) {
        	if(i == localdata.pageNo){
        		var middleElement = '<div class="m_page_num" style="background-color: #f1f1f1; color:#2f63d0;">'+i+'</div>';
        	}else{
        		var middleElement = '<div class="m_page_num">'+i+'</div>';
        	}
        	
        	
            var anchor = $(middleElement);
            anchor.appendTo(element);
            if(i != localdata.pageNo){
                anchor.click(function (event) {
                    // go to a page.
                    var pagenum = parseInt($(event.target).text());
                    eval(pagingFunction+"(pagenum)");
                });
            }
        }
        
        var beforeLastElement = '<div class="m_page_arrow"> > </div>';
        var beforeLastElementObject = $(beforeLastElement);
        beforeLastElementObject.appendTo(element);
        
        if(localdata.endPage != localdata.totalPage){
        	beforeLastElementObject.click(function (event) {
            	var pagenum = parseInt(localdata.endPage+1);
            	eval(pagingFunction+"(pagenum)");
            });
        }
        
        var lastElement = '<div class="m_page_arrow"> >> </div>';
        var lastElementObject = $(lastElement);
        lastElementObject.appendTo(element);
        if(localdata.endPage != localdata.totalPage){
	        lastElementObject.click(function (event) {
	        	var pagenum = parseInt(localdata.totalPage);
	        	eval(pagingFunction+"(pagenum)");
	        });
        }

	}
};