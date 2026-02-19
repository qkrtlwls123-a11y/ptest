/*=========================================================================================
    File Name: page-users.js
    Description: Users page
    --------------------------------------------------------------------------------------
    Item Name: Stack - Responsive Admin Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/
$(document).ready(function () {

    // variable declaration
    var usersTable;
    var usersDataArray = [];
    // datatable initialization
    if ($("#users-list-datatable").length > 0) {
        usersTable = $("#users-list-datatable").DataTable({
            'columnDefs': [{
                "orderable": false,
                "targets": [7]
            }]
        });
    };
    // on click selected users data from table(page named page-users-list)
    // to store into local storage to get rendered on second page named page-users-view
    $(document).on("click", "#users-list-datatable tr", function () {
        $(this).find("td").each(function () {
            usersDataArray.push($(this).text().trim())
        })
        localStorage.setItem("usersId", usersDataArray[0]);
        localStorage.setItem("usersUsername", usersDataArray[1]);
        localStorage.setItem("usersName", usersDataArray[2]);
        localStorage.setItem("usersVerified", usersDataArray[4]);
        localStorage.setItem("usersRole", usersDataArray[5]);
        localStorage.setItem("usersStatus", usersDataArray[6]);
    })
    // render stored local storage data on page named page-users-view
    if (localStorage.usersId !== undefined) {
        $(".users-view-id").html(localStorage.getItem("usersId"));
        $(".users-view-username").html(localStorage.getItem("usersUsername"));
        $(".users-view-name").html(localStorage.getItem("usersName"));
        $(".users-view-verified").html(localStorage.getItem("usersVerified"));
        $(".users-view-role").html(localStorage.getItem("usersRole"));
        $(".users-view-status").html(localStorage.getItem("usersStatus"));
        // update badge color on status change
        if ($(".users-view-status").text() === "Banned") {
            $(".users-view-status").toggleClass("badge-light-success badge-light-danger")
        }
        // update badge color on status change
        if ($(".users-view-status").text() === "Close") {
            $(".users-view-status").toggleClass("badge-light-success badge-light-warning")
        }
    }
    // page users list verified filter
    $("#users-list-verified").on("change", function () {
        var usersVerifiedSelect = $("#users-list-verified").val();
        usersTable.search(usersVerifiedSelect).draw();
    });
    // page users list role filter
    $("#users-list-role").on("change", function () {
        var usersRoleSelect = $("#users-list-role").val();
        // console.log(usersRoleSelect);
        usersTable.search(usersRoleSelect).draw();
    });
    // page users list status filter
    $("#users-list-status").on("change", function () {
        var usersStatusSelect = $("#users-list-status").val();
        // console.log(usersStatusSelect);
        usersTable.search(usersStatusSelect).draw();
    });
    // users language select
    if ($("#users-language-select2").length > 0) {
        $("#users-language-select2").select2({
            dropdownAutoWidth: true,
            width: '100%'
        });
    }
    // users music select
    if ($("#users-music-select2").length > 0) {
        $("#users-music-select2").select2({
            dropdownAutoWidth: true,
            width: '100%'
        });
    }
    // users movies select
    if ($("#users-movies-select2").length > 0) {
        $("#users-movies-select2").select2({
            dropdownAutoWidth: true,
            width: '100%'
        });
    }
    // users birthdate date
    if ($(".birthdate-picker").length > 0) {
        $('.birthdate-picker').pickadate({
            format: 'mmmm, d, yyyy'
        });
    }
    // Input, Select, Textarea validations except submit button validation initialization
    if ($(".users-edit").length > 0) {
        $("input,select,textarea").not("[type=submit]").jqBootstrapValidation();
    }
    
    $(".list-group-item").on("click", function(){
    	$(".list-group-item").removeClass("active");
    	$(this).addClass("active");
    	
    	$("#groupPropertyList").html("");
    	$("#group_id").val($(this).find("input[type=hidden]").val());
    	
    	var params = $("form[name=parameterVO]").serialize();
    	
    	$.ajax({
			url : "/click/selectGroupPropertyList.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					var htmlString = '';
					for(var i=0;i<result.groupPropertyList.length;i++){
						console.log(result.groupPropertyList[i].property_id);
						htmlString += '<div class="card text-center m-05 property-card3" id="group_object_id_'+result.groupPropertyList[i].property_id+'">'+
											'<input type="hidden" name="group_object" value="'+result.groupPropertyList[i].property_id+'">'+
								         	'<div class="card-content">'+
									     		'<div class="card-body2">'+
									                '<span class="card-text bt-card">'+result.groupPropertyList[i].property_name+'<button class="btn btn-primary btn-darken-3 ml-05 pd-05" onclick="javascript:fn_delete('+result.groupPropertyList[i].property_id+');return false;"><i class="feather icon-x align-middle"></i></button></span>'+
									            '</div>'+
									        '</div>'+
									     '</div>';
					}
    					
					$("#groupPropertyList").html(htmlString);
				} else if(result.resultCode == "empty") {
					var htmlString = '<div class="card text-center m-05">'+
							         	'<div class="card-content">'+
							         		'<div class="card-body2">'+
							                    '<span class="card-text bt-card">조회결과 없음</span>'+
							                '</div>'+
							            '</div>'+
							         '</div>';
					$("#groupPropertyList").html(htmlString);
				}else {
					alert("시스템 오류 입니다.");
				}
			}
		});
    });
    
    $(".property-card").on("doubleTap", function(){
    	if($("#group_id").val() == "" || $("#group_id").val == undefined){
    		alert("그룹을 먼저 선택하세요.");
    	}else{
    		var propertyId = $(this).find("input[type=hidden]").val();
    		var propertyName = $(this).find(".bt-card").text();
    		var htmlString = '<div class="card text-center m-05 property-card3" id="group_object_id_'+propertyId+'">'+
    							'<input type="hidden" name="group_object" value="'+propertyId+'">'+
					         	'<div class="card-content">'+
						     		'<div class="card-body2">'+
						                '<span class="card-text bt-card">'+propertyName+'<button class="btn btn-primary btn-darken-3 ml-05 pd-05" onclick="javascript:fn_delete('+propertyId+');return false;"><i class="feather icon-x align-middle"></i></button></span>'+
						            '</div>'+
						        '</div>'+
						     '</div>';
    		var checkProperty = 0;
    		var property_id_group = "";
    		var checkDuplicate = false;
    		$("input[name=group_object]").each(function(){
    			checkProperty++;
    			if($(this).val() == propertyId){
    				checkDuplicate = true;
    			}
    		});
    		
    		if(checkDuplicate){
    			alert("이미 등록되어있는 속성입니다.");
    		}else{
    			if(checkProperty == 0){
        			$("#groupPropertyList").html(htmlString);
        		}else{
        			$("#groupPropertyList").append(htmlString);
        		}
        		
        		$("input[name=group_object]").each(function(){
        			if(property_id_group == ""){
        				property_id_group += $(this).val();
        			}else{
        				property_id_group += "/"+$(this).val();
        			}
        		});
        		
        		$("#property_id_group").val(property_id_group);
        		
        		var params = $("form[name=parameterVO]").serialize();
            	
            	$.ajax({
        			url : "/click/updateGroup.json",
        			type : "POST",
        			data : params,
        			success : function(result) {
        				if(result.resultCode == "fail"){
        					alert("시스템 오류 입니다");
        				}
        			}
        		});
    		}
    	}
    });
    
    $(".property-card").on("dblclick", function(){
    	if($("#group_id").val() == "" || $("#group_id").val == undefined){
    		alert("그룹을 먼저 선택하세요.");
    	}else{
    		var propertyId = $(this).find("input[type=hidden]").val();
    		var propertyName = $(this).find(".bt-card").text();
    		var htmlString = '<div class="card text-center m-05 property-card3" id="group_object_id_'+propertyId+'">'+
    							'<input type="hidden" name="group_object" value="'+propertyId+'">'+
					         	'<div class="card-content">'+
						     		'<div class="card-body2">'+
						                '<span class="card-text bt-card">'+propertyName+'<button class="btn btn-primary btn-darken-3 ml-05 pd-05" onclick="javascript:fn_delete('+propertyId+');return false;"><i class="feather icon-x align-middle"></i></button></span>'+
						            '</div>'+
						        '</div>'+
						     '</div>';
    		var checkProperty = 0;
    		var property_id_group = "";
    		var checkDuplicate = false;
    		$("input[name=group_object]").each(function(){
    			checkProperty++;
    			if($(this).val() == propertyId){
    				checkDuplicate = true;
    			}
    		});
    		
    		if(checkDuplicate){
    			alert("이미 등록되어있는 속성입니다.");
    		}else{
    			if(checkProperty == 0){
        			$("#groupPropertyList").html(htmlString);
        		}else{
        			$("#groupPropertyList").append(htmlString);
        		}
        		
        		$("input[name=group_object]").each(function(){
        			if(property_id_group == ""){
        				property_id_group += $(this).val();
        			}else{
        				property_id_group += "/"+$(this).val();
        			}
        		});
        		
        		$("#property_id_group").val(property_id_group);
        		
        		var params = $("form[name=parameterVO]").serialize();
            	
            	$.ajax({
        			url : "/click/updateGroup.json",
        			type : "POST",
        			data : params,
        			success : function(result) {
        				if(result.resultCode == "fail"){
        					alert("시스템 오류 입니다");
        				}
        			}
        		});
    		}
    	}
    });
});

function fn_insert(){
	if(fn_checkRequired()){
		var params = $("form[name=parameterVO]").serialize();
		var groupName = $("form[name=parameterVO]").find("input[name=group_name]").val();
		
		$.ajax({
			url : "/click/insertGroup.json",
			type : "POST",
			data : params,
			success : function(result) {
				if (result.resultCode == "success") {
					var htmlString = '<a href="#" class="list-group-item border-0 d-flex align-items-center justify-content-between">'+
										'<input type="hidden" id="group_id_'+result.groupVO.group_id+'" name="group_name_'+result.groupVO.group_id+'" value="'+result.groupVO.group_id+'"/>'+
					                    '<span>'+groupName+'</span>'+
					                '</a>';
									
					$("#groupList").before(htmlString);
					$("form[name=parameterVO]").find("input[name=group_name]").val("");
					
					$(".list-group-item").on("click", function(){
				    	$(".list-group-item").removeClass("active");
				    	$(this).addClass("active");
				    });
					location.reload();
				} else {
					alert("시스템 오류 입니다.");
				}
			}
		});
	}
}

function fn_delete(idx){
	$("#group_object_id_"+idx).remove();
	
	var propertyId = idx;
	var checkProperty = 0;
	var property_id_group = "";
	
	$("input[name=group_object]").each(function(){
		checkProperty++;
	});
	
	if(checkProperty == 0){
		var htmlString = '<div class="card text-center m-05">'+
					     	'<div class="card-content">'+
					     		'<div class="card-body2">'+
					                '<span class="card-text bt-card">조회결과 없음</span>'+
					            '</div>'+
					        '</div>'+
					     '</div>';
		$("#groupPropertyList").html(htmlString);
	}
	
	$("input[name=group_object]").each(function(){
		if(property_id_group == ""){                        
			property_id_group += $(this).val();
		}else{
			property_id_group += "/"+$(this).val();
		}
	});
	
	$("#property_id_group").val(property_id_group);
	
	var params = $("form[name=parameterVO]").serialize();
	
	$.ajax({
		url : "/click/updateGroup.json",
		type : "POST",
		data : params,
		success : function(result) {
			if(result.resultCode == "fail"){
				alert("시스템 오류 입니다");
			}
		}
	});
}

function fn_update(){
	var params = $("form[name=updateVO]").serialize();
	
	$.ajax({
		url : "/click/updateProperty.json",
		type : "POST",
		data : params,
		success : function(result) {
			if (result.resultCode == "success") {
				location.href="/click/propertyList.do";
			} else {
				alert("시스템 오류 입니다.");
			}
		}
	});
}

function fn_checkRequired(){
	var checkValue = true;
	
	$('form[name=parameterVO]').find(".required").each(function(e){
		if($(this).val() == ""){
			alert($(this).attr("placeholder")+"은(는) 필수입력 항목 입니다.");
			checkValue = false;
			return false;
		}
	});
	
	return checkValue;
}