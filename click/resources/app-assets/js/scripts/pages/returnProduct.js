/*=========================================================================================
    File Name: app-contacts.js
    Description: Users contacts configurations
    ----------------------------------------------------------------------------------------
    Item Name: Stack - Responsive Admin Theme
    Author: Pixinvent
    Author URL: hhttp://www.themeforest.net/user/pixinvent
==========================================================================================*/

$(document).ready(function() {
	$(".fileupload").on("change", fn_addFiles);
	
	var filesTempArr = [];
	var filesTempArr2 = [];
	var fileName = "";
	var fileFirmwareName = "";
	var fileFirmwareDeleteArray = [];
	
	function fn_addFiles(e) {
		var targetName = $(this).attr("id");
		filesTempArr = [];
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		var filesArrLen = filesArr.length;
		var filesTempArrLen = filesTempArr.length;
		for( var i=0; i<filesArrLen; i++ ) {
			filesTempArr.push(filesArr[i]);
			fileName = filesArr[i].name;
			var fileType = fileName.split(".");
			fn_insertFile(targetName);
		}
	}
	
	function fn_removeFiles(e) {
		filesTempArr = [];
	}

	function fn_insertFile(targetName){

		var formData = new FormData();
		 
		// 파일 데이터
		for(var i=0, filesTempArrLen = filesTempArr.length; i<filesTempArrLen; i++) {
		   formData.append("files", filesTempArr[i]);
		}

		var htmlString = '<img src="./app-assets/images/backgrounds/bg-2.jpg" alt="avatar" class="w-100" style="height:100%;">';

		$("#"+targetName+"Image").html(htmlString);


		/*$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/file/uploadProductImage.json",
			data : formData,
			processData: false,
			contentType: false,
			success : function(result) {
				if(result.resultCode == "success"){
					var htmlString = "";
					for(var i=0; i<1; i++){
						var fileId = result.fileList[i].file_id;
						$("#realFileName").html(fileName);
						htmlString += '<img src="${pageContext.request.contextPath}/file/down/image/'+fileId+'" alt="">';
						$("#profile_img_id").val(fileId);
						$("#fileList").html(htmlString);
					}
				}else{
					fn_removeFiles();
					openDefaultPopup("loginPopup", '<spring:message code="click.not.meet.standard.check.registering"/>');
					return false;
				}
			},
			err : function(err) {
				openDefaultPopup("loginPopup", err.status);
			}
		});*/
	}


    if($('.sidebar-detached.sidebar-left').length > 0){
        var sidebar_fixed = new PerfectScrollbar('.sidebar-detached.sidebar-left',{
            wheelPropagation: false,
        });
    }

    // Datatable
    var userDataTable = $('#data-list').DataTable();
    // Set the search textbox functionality in sidebar
    $('#search-contacts').on( 'keyup', function () {
        userDataTable.search( this.value ).draw();
    });
    
    // Checkbox & Radio 1
    $('.input-chk').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
    });

	$('.list-group-item').on("click", function(){
		alert($(this).attr("id"));
	});
        
    userDataTable.on( 'draw.dt', function () {
        // Checkbox & Radio 1
        $('.input-chk').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
        });
    });

    // Favorite star click
    $(document).on("click", ".favorite", function() {
      $(this).toggleClass("active");
    });

    // Remove Row for datatable in responsive
    $('#data-list').on("click", ".delete", function(){
        userDataTable.row($(this).parents('tr')).remove().draw();
    });

    $(document).on("click", ".delete-all", function() {
        userDataTable.rows($("#data-list").find(".checked").closest("tr")).remove().draw();
        $("input#check-all").iCheck("uncheck");
    });

    // check / uncheck all
    $(document).on("ifClicked", 'input#check-all', function() {
        var checkboxes = $("input.input-chk");
        $(document).on("ifChecked", 'input#check-all', function(event) {
            checkboxes.iCheck("check");
        });
        $(document).on("ifUnchecked", 'input#check-all', function(event) {
            checkboxes.iCheck("uncheck");
        });
    });

    // Add new Datatable contact
    var counter = 1;
 
    $('#add-item').on( 'click', function (e) {
        e.preventDefault();
		var itemArray = [];
		var orderNo = "";
		$(".insert-item").each(function(check){
			var item = "";
			if($(this).hasClass("fileupload")){
				if($(this).val() == "" || $(this).val() == null || $(this).val() == undefined){
					item = '<div>'+
							'<div><i class="feather icon-x-square"></i></div>'+
						'</div>';
				}else{
					item = '<div>'+
							'<div><span class="avatar avatar-sm avatar-online"><img src="'+$(this).val()+'" alt="avatar"></span></div>'+
						'</div>';
				}
				itemArray.push(item);
				itemArray.push("2022-04-20");
			}else{
				if($(this).attr("name") == 'orderNo'){
					if($(this).val() == "" || $(this).val() == null || $(this).val() == undefined){
						orderNo = "-";
					}else{
						orderNo = $(this).val();
					}
				}else if($(this).attr("name") == 'shopName'){
					orderNo += "<br>"+$(this).val();
					item = orderNo;
					itemArray.push(item);
				}else{
					item = $(this).val();
					itemArray.push(item);
				}
			}
		});

		itemArray.push("검수전");
		itemArray.push("픽업요청");

        userDataTable.row.add( itemArray ).draw( false );
 
        counter++;

		$(".insert-item").each(function(check){
			$(this).val("");
		});

		$(".preview").each(function(e){
			$(this).html("");
		});

    } );

    var currentRow = null;

    $(document).on('click', '.edit', function () {
        currentRow= $(this).parents('tr');
        $("#phone").val("");
        $("#name").val($(this).closest('tr').find('td .name').text());
        $("#email").val($(this).closest('tr').find('.email').text());
        $("#phone").val($(this).closest('tr').find('td.phone', 'td .phone').text());
        $("#fav").val('');
        if($(this).closest('tr').find('.favorite').hasClass('active')){
            $("#fav").text('active');
        }
    });
    // Edit Datatable item
    $('#edit-contact-item').on( 'click', function (e) {
        e.preventDefault();
        var name = $("#name").val();
        var email = $("#email").val();
        var contact = $("#phone").val();
        var favClass = $("#fav").text();

        userDataTable.row(currentRow).data( [
            '<input type="checkbox" class="input-chk check">',
            '<div class="media">'+
                '<div class="media-left pr-1"><span class="avatar avatar-sm avatar-online rounded-circle"><img src="../../../app-assets/images/portrait/small/avatar-s-2.png" alt="avatar"><i></i></span></div>'+
                '<div class="media-body media-middle">'+
                    '<a class="name" class="media-heading">'+name+'</a>'+
                '</div>'+
            '</div>',
            '<a class="email" href="'+email+'">'+email+'</a>',
            '<span class="phone">'+contact+'</span>',
            '<div class="favorite '+favClass+'"><i class="feather icon-star"></i></div>',
            '<a data-toggle="modal" data-target="#EditContactModal" class="primary edit mr-1"><i class="fa fa-pencil"></i></a>'+
                '<a class="danger delete mr-1"><i class="fa fa-trash-o"></i></a>'+
                '<span class="dropdown">'+
                    '<a id="btnSearchDrop2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" class="dropdown-toggle dropdown-menu-right"><i class="fa fa-ellipsis-v"></i></a>'+
                    '<span aria-labelledby="btnSearchDrop2" class="dropdown-menu mt-1 dropdown-menu-right">'+
                        '<a data-toggle="modal" data-target="#EditContactModal" class="dropdown-item edit"><i class="feather icon-edit-2"></i> Edit</a>'+
                        '<a href="#" class="dropdown-item delete"><i class="feather icon-trash-2"></i> Delete</a>'+
                        '<a href="#" class="dropdown-item"><i class="feather icon-plus-circle primary"></i> Projects</a>'+
                        '<a href="#" class="dropdown-item"><i class="feather icon-plus-circle info"></i> Team</a>'+
                        '<a href="#" class="dropdown-item"><i class="feather icon-plus-circle warning"></i> Clients</a>'+
                        '<a href="#" class="dropdown-item"><i class="feather icon-plus-circle success"></i> Friends</a>'+
                    '</span>'+
                '</span>'
        ] ).draw( );
 
        counter++;
    } );

    // Main menu toggle should hide app menu
    $('.menu-toggle').on('click',function(e){
        $('.app-content .sidebar-left').removeClass('show');
        $('.app-content .content-overlay').removeClass('show');
    });

    // Chat sidebar toggle
    $('.sidebar-toggle').on('click',function(e){
        e.stopPropagation();
        $('.app-content .sidebar-left').toggleClass('show');
        $('.app-content .content-overlay').addClass('show');
    });
    $('.app-content .content-overlay').on('click',function(e){
        $('.app-content .sidebar-left').removeClass('show');
        $('.app-content .content-overlay').removeClass('show');
    });

    // For chat sidebar on small screen
    if ($(window).width() > 992) {
        if($('.app-content .content-overlay').hasClass('show')){
            $('.app-content .content-overlay').removeClass('show');
        }
    }

});

$(window).on("resize", function() {
    // remove show classes from sidebar and overlay if size is > 992
    if ($(window).width() > 992) {
        if($('.app-content .content-overlay').hasClass('show')){
            $('.app-content .sidebar-left').removeClass('show');
            $('.app-content .content-overlay').removeClass('show');
        }
    }
});

$(document).ready(function(){
	$("#returnProduct").addClass("active");
});