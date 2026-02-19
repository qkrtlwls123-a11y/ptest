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
    <meta name="author" content="PIXINVENT">
    <title>ONION BOX</title>
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/apple-icon-120.png">
<!--<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/app-assets/images/ico/favicon.ico">-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i%7COpen+Sans:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/pickers/daterange/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/selects/select2.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/vendors/css/forms/quill/quill.snow.css">
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/pages/app-todo.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/css/pages/app-contacts.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/app-assets/fonts/simple-line-icons/style.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/neoulsoft/dtx.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/neoulsoft/dtx-side-panel.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/neoulsoft/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- END: Custom CSS-->
    <script type="text/javascript">

    $(document).ready(function(){
    	$("#surveyList").addClass("active");
    	
    	$(".menu-item#manage").addClass("open");
        $(".menu-item#manage > .sub-menu-wrap li").eq(3).addClass("active");

        $(".card-head .btn-add").off("click");
        $(".card-head .btn-add").on("click", function () {
            registerSurvey();
        });

        $(".tb-modify-btn").off("click");
        $(".tb-modify-btn").on("click", function (e) {
            e.stopPropagation();
            e.preventDefault();
            modifySurvey();
        });

        $(document).off("click", ".require-btn");
        $(document).on("click", ".require-btn", function () {
            if($(this).prev().prop("checked") === true){
                $(this).prev().prop("checked", false);
            }else{
                $(this).prev().prop("checked", true);
            }
        });

        var radioLabel = $(".radio-label");
        $(document).off("click", ".radio-label");
        $(document).on("click", ".radio-label", function () {
            $(this).parent().parent().parent().parent().parent().find(".radio-label").prev().prop("checked", false);
            $(this).prev().prop("checked", true);
            radioLabel.not($(this)).prev().prop("checked", false); // 중복선택 막기
        });

        //질문 - 체크 버튼
        $(document).off("click", ".check-label");
        $(document).on("click", ".check-label", function () {
            if($(this).prev().prop("checked") === true){
                $(this).prev().prop("checked", false);
            }else{
                $(this).prev().prop("checked", true);
            }
        });

        $(document).off("click", ".check-label");
        $(document).on("click", ".check-label", function () {
            if($(this).prev().prop("checked") === true){
                $(this).prev().prop("checked", false);
            }else{
                $(this).prev().prop("checked", true);
            }
        });
        
    	
    	$(document).on("click", ".panel-close-btn", function(){
    		hideSidePanel("right");
    	});
    	
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
        		
        		$("#survey_id").val(checkId);
    			var params = $("form[name=parameterVO]").serialize();
    			$.ajax({
    				url : "${pageContext.request.contextPath}/deleteAllSurvey.json",
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
    		
    		hideSidePanel("right");
    	})
    });
    
    function previewSurvey(){
        showSidePanel("dtx-survey-preview", "right", function () {
            $(".panel-back-btn, .btn-back").on("click", function () {
                registerSurvey();
            });
        });
    }
	
	function fn_surveyRegi(){
		registerSurvey();
	}
	
	function fn_surveyDetail(idx){
		$("#survey_id").val(idx);
		document.parameterVO.action = "${pageContext.request.contextPath}/surveyDetail.do";
		document.parameterVO.submit();
	}
	
	function registerSurvey(){
        showSidePanel("dtx-survey-form", "right", function () {
            //질문지 박스 선택시 active 클래스 추가
            $(".survey-form-style").removeClass("active");
            $(document).off("click",".survey-form-style")
            $(document).on("click",".survey-form-style",  function () {
                $(this).addClass("active");
                $(".survey-form-style").not($(this)).removeClass("active");
            });

            //상단 X 버튼
            $(".panel-close-btn").off("click");
            $(".panel-close-btn").on("click", function () {
                hideSidePanel("right");
            });

            //추가버튼 클릭시 기본(단답형) 질문지 추가
            //질문지 추가 버튼
            $(document).off("click", ".survey-item-add-btn");
            $(document).on("click", ".survey-item-add-btn", function () {
                var surveyAddItem = $("#html-part > .survey-add-item").clone();
                $(this).parents(".survey-form-style").after(surveyAddItem);
            });

            //질문지 삭제 버튼
            $(document).off("click", "#dtx-survey-form .survey-item-remove-btn");
            $(document).on("click", "#dtx-survey-form .survey-item-remove-btn", function () {
                if($("#dtx-survey-form .survey-form-style.item").length <= 1){
                    alert("질문이 한개 이상은 존재해야 합니다.");
                }else{
                    $(this).parents(".survey-form-style.item").remove();
                }
            });

            //미리보기 버튼
            $(".btn-preview").off("click");
            $(".btn-preview").on("click", function () {
                previewSurvey();
            });

            //질문지 스타일 드롭박스
            $(document).off("click",".survey-style-select-box");
            $(document).on("click",".survey-style-select-box", function () {
               $(this).toggleClass("open");
            });

            //질문지 스타일 드롭박스 - 아이템
            $(document).off("click", ".survey-style-item");
            $(document).on("click", ".survey-style-item", function () {
                //단답형
                var shortText = $("#html-part > .input-box.short-text").clone();

                //장문형
                var longText = $("#html-part > .textarea-box.long-text").clone();

                //객관식 질문 - 1
                var multipleChoiceRadio = $("#html-part > .multiple-choice-wrap.multiple-choice-radio").clone();

                //객관식 질문 - 2
                var multipleChoiceCheck = $("#html-part > .multiple-choice-wrap.multiple-choice-check").clone();

                //선형 배율
                var linearScale = $("#html-part > .linear-scale-wrap.linear-scale").clone();

                //객관식 그리드
               var radioGrid = $("#html-part > .grid-make-wrap.radio-grid").clone();

                //체크박스 그리드
                var checkGrid = $("#html-part > .grid-make-wrap.check-grid").clone();


               var selectSurveyStyle = $(this).index();
               var surveyStyleMap = {0 : "단답형", 1 : "장문형" , 2 : "객관식 질문 - 1", 3 : "객관식 질문 - 2", 4 : "선형 배율", 5 : "객관식 그리드", 6 : "체크박스 그리드"};
               var surveyStyleClassMap = {0 : "short-text", 1 : "long-text" , 2 : "multiple-choice-radio", 3 : "multiple-choice-check", 4 : "linear-scale", 5 : "radio-grid", 6 : "check-grid"};
               var surveyStyleHtmlMap = {0 : shortText, 1:longText, 2:multipleChoiceRadio, 3:multipleChoiceCheck, 4:linearScale, 5 :radioGrid, 6 :checkGrid};

               $(this).parents(".survey-style-select-box").find(".select-box > .select-item > span").text(surveyStyleMap[selectSurveyStyle]);
               $(this).parents(".survey-detail").find(".survey-item-detail").removeClass().addClass("survey-item-detail " + surveyStyleClassMap[selectSurveyStyle]);
               $(this).parents(".survey-detail").find(".survey-item-detail").attr("formType", surveyStyleClassMap[selectSurveyStyle]);
               $(this).parents(".survey-detail").find(".survey-item-detail").empty().append(surveyStyleHtmlMap[selectSurveyStyle]);
            });

            //객관식 질문 - 추가
            $(document).off("click", " .btn-item-add");
            $(document).on("click", " .btn-item-add", function () {
                var multipleItem = "";
                     multipleItem  = "<li class=\"multiple-item\">\n";

                    if($(this).parents(".survey-item-detail").hasClass("multiple-choice-radio")){
                        multipleItem += "<input type=\"radio\">\n" +
                            "<label class=\"radio-label\"></label>\n";
                    }
                    if($(this).parents(".survey-item-detail").hasClass("multiple-choice-check")){
                            multipleItem += "<input type=\"checkbox\">\n" +
                                "<label class=\"check-label\"></label>\n";
                    }
                      multipleItem += "<input type=\"text\" placeholder=\"옵션\">\n" +
                                      "<button class=\"btn-item-add\"><i class=\"fa-solid fa-plus\"></i></button>" +
                                      "<button class=\"btn-item-remove\"><i class=\"fa-solid fa-xmark\"></i></button>" +
                                      "</li>";
                $(this).parent().after(multipleItem);
            });

            //객관식 질문 - 삭제
            $(document).off("click", ".multiple-choice-1 .btn-item-remove");
            $(document).on("click", ".multiple-choice-1 .btn-item-remove", function () {
                $(this).parent(".multiple-item").remove();
            });

            $(document).off("click", "#btn-survey");
            $(document).on("click", "#btn-survey", function(){
                let title = $("#surveyTitle").val();
                let surveyDescription = $("#surveyDescription").val();
                let itemCount = 0
                let surveyForms = [];

                $(".surveyInsertForm").find(".survey-form-style.item").each(function(i){
                    let surveyForm = {}

                    let form = "";
                    if(NSCOMMON.isEmpty($(this).find(".survey-item-detail").attr("formType"))){
                        form = "short-text";
                    }else{
                        form = $(this).find(".survey-item-detail").attr("formType");
                    }
                    let question = $(this).find(".survey-item-title").find("input[type=text]").val();
                    let formDescription = $(this).find(".survey-item-explanation").find("input[type=text]").val();

                    let formPlaceholder = "";
                    if("short-text" == form){
                        formPlaceholder = $(this).find(".survey-item-detail").find("input[type=text]").val();
                    }

                    if("long-text" == form){
                        formPlaceholder = $(this).find(".survey-item-detail").find(".surveyTextarea").val();
                    }
                    let itemList = [];
                    if("check-grid" == form || "radio-grid" == form){
                        $(this).find(".row-list").find("input[type=text]").each(function(idx){
                            let item = {};
                            item.survey_item_type = "row";
                            item.survey_item_no = idx;
                            item.survey_item_title = $(this).val();
                            itemList.push(item);
                        });

                        $(this).find(".column-list").find("input[type=text]").each(function(idx){
                            let item = {};
                            item.survey_item_type = "column";
                            item.survey_item_no = idx;
                            item.survey_item_title = $(this).val();
                            itemList.push(item);
                        });
                    }else if("multiple-choice-radio" == form){
                        $(this).find(".multiple-item").each(function(idx){
                            let item = {};
                            item.survey_item_no = idx;
                            item.survey_item_title = $(this).find("input[type=text]").val();
                            item.survey_item_type = "radio";
                            itemList.push(item);
                        })
                    }else if("multiple-choice-check" == form){
                        $(this).find(".multiple-item").each(function(idx){
                            let item = {};
                            item.survey_item_no = idx;
                            item.survey_item_title = $(this).find("input[type=text]").val();
                            item.survey_item_type = "check";
                            itemList.push(item);
                        })
                    }else if("linear-scale" == form){
                        $(this).find(".linear-label").each(function(idx){
                            let item = {};
                            item.survey_item_no = idx;
                            item.survey_item_title = $(this).find("input[type=text]").val();
                            if(idx == 0){
                                item.survey_item_type = "left";
                            }else{
                                item.survey_item_type = "right";
                            }
                            itemList.push(item);
                        })
                    }
                    surveyForm.survey_form_type = form;
                    surveyForm.survey_form_no = i;
                    surveyForm.survey_form_question = question;
                    surveyForm.survey_form_description = formDescription;
                    surveyForm.survey_form_placeholder = formPlaceholder;
                    surveyForm.itemList = itemList;

                    surveyForms.push(surveyForm);

                    itemCount++;
                })

                let sendData = {};

                sendData.command = "insert";
                sendData.survey_title = title;
                sendData.survey_description = surveyDescription;
                sendData.surveyFormList = surveyForms;

                NSCOMMON.apiPost("${pageContext.request.contextPath}/insertSurvey.json", sendData, "json", true, function (surveyResult) {
                	alert("등록되었습니다.");
                    location.reload();
                });
            })
        });
    }
	
	function viewDetailSurvey(seq, title, surveyDescription){
        let sendData = {};

        sendData.command = "detail";
        sendData.survey_id = seq;
        showSidePanel("dtx-survey-detail", "right", function () {});
        
        $("#survey_id").val(seq);

        NSCOMMON.apiPost("${pageContext.request.contextPath}/surveyDetail.json", sendData, "json", true, function (surveyResult) {
            showSidePanel("dtx-survey-detail", "right", function () {
                $("#surveyDetailTitle").val(title);
                $("#surveyDetailDescription").val(surveyDescription);
                let htmlString = '<div class="survey-form-style title">' +
                    '        <div class="top"></div>' +
                    '        <div class="left"></div>' +
                    '        <div class="survey-detail">' +
                    '          <div class="input-box">' +
                    '            <input type="text" id="surveyDetailTitle" placeholder="제목을 입력하세요" value="'+title+'" readonly>' +
                    '          </div>' +
                    '          <div class="input-box">' +
                    '            <input type="text" id="surveyDetailDescription" placeholder="설문지 설명" value="'+surveyDescription+'" readonly>' +
                    '          </div>' +
                    '        </div>' +
                    '      </div>';

                for(let i=0;i<surveyResult.response.length;i++){
                    let formType = surveyResult.response[i].survey_form_type;
                    let title = surveyResult.response[i].survey_form_question;
                    let formDescription = surveyResult.response[i].survey_form_description;
                    let formSeq = surveyResult.response[i].survey_form_id;
                    let typeHtmlStirng = "";
                    let selectString = "";
                    if("short-text"==formType){
                        selectString = "단답형";
                    }else if("long-text"==formType){
                        selectString = "장문형";
                    }else if("multiple-choice-radio"==formType){
                        selectString = "객관식 질문 - 1";
                    }else if("multiple-choice-check"==formType){
                        selectString = "객관식 질문 - 2";
                    }else if("linear-scale"==formType){
                        selectString = "선형 배율";
                    }else if("radio-grid"==formType){
                        selectString = "객관식 그리드";
                    }else if("check-grid"==formType){
                        selectString = "체크박스 그리드";
                    }

                    let htmlHeader = '<div class="survey-form-style item report">' +
                        '        <div class="top"></div>' +
                        '        <div class="left"></div>' +
                        '        <div class="survey-detail">' +
                        '          <div class="survey-item-title">' +
                        '            <div class="input-box">' +
                        '              <input type="text" placeholder="질문을 입력하세요" value="'+title+'" readonly>' +
                        '            </div>' +
                        '            <div class="require-select">' +
                        '              <span>필수</span>' +
                        '              <input class="require-tgl" type="checkbox" checked readonly>' +
                        '              <label class="require-btn"></label>' +
                        '            </div>' +
                        '            <div class="survey-style-select-box">' +
                        '              <div class="select-box">' +
                        '                <div class="select-item">' +
                        '                  <span class="select-placeholder">'+selectString+'</span>' +
                        '                  <i class="fa-solid fa-chevron-down"></i>' +
                        '                </div>' +
                        '              </div>' +
                        '              <div class="select-list-wrap">' +
                        '                <ul class="survey-style-list">' +
                        '                  <li class="survey-style-item">단답형</li>' +
                        '                  <li class="survey-style-item">장문형</li>' +
                        '                  <li class="survey-style-item">객관식 질문 - 1</li>' +
                        '                  <li class="survey-style-item">객관식 질문 - 2</li>' +
                        '                  <li class="survey-style-item">선형 배율</li>' +
                        '                  <li class="survey-style-item">객관식 그리드</li>' +
                        '                  <li class="survey-style-item">체크박스 그리드</li>' +
                        '                </ul>' +
                        '              </div>' +
                        '            </div>' +
                        '          </div>';
                    let htmlFooter = '</div>' +
                        '      </div>';

                    $("#html-part > .input-box."+formType).find(".survey-item-title").find("input[type=text]").val(title);
                    $("#html-part > .input-box."+formType).find(".survey-item-explanation").find("input[type=text]").val(formDescription);
                    if("short-text" == formType){
                        const formPlaceholder = surveyResult.response[i].survey_form_placeholder;
                        let detailHtml = '<div class="survey-item-detail short-text">\n' +
                            '            <div class="input-box">\n' +
                            '              <input type="text" placeholder="'+formPlaceholder+'" readonly>\n' +
                            '            </div>\n' +
                            '          </div>';
                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("long-text" == formType){
                        const formPlaceholder = surveyResult.response[i].survey_form_placeholder;
                        let detailHtml = '<div class="survey-item-detail long-text">\n' +
                            '            <div class="textarea-box">\n' +
                            '              <textarea placeholder="'+formPlaceholder+'" readonly></textarea>\n' +
                            '            </div>\n' +
                            '          </div>';
                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("multiple-choice-radio" == formType){
                        const itemsResult = surveyResult.response[i].itemList;
                        let detailHtml = '<div class="survey-item-detail multiple-choice-radio"><ul class="multiple-choice-wrap">';
                        for(let j=0;j<itemsResult.length;j++){
                            const itemTitle = itemsResult[j].survey_item_title;
                            const itemSeq = itemsResult[j].survey_form_item_id;
                            const itemScore = itemsResult[j].survey_item_score;
                            detailHtml += '<li class="multiple-item">'+
                                                '<input type="radio" name="radio_'+formSeq+'">'+
                                                '<label class="radio-label"></label>'+
                                                '<input type="text" placeholder="옵션" value="'+itemTitle+'" readonly>'+
                                                '<input type="text" id="'+formSeq+'" class="itemScore" value="'+itemScore+'" readonly>'+
                                                '</li>';
                        }
                        detailHtml += '</ul></div>';
                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("multiple-choice-check" == formType){
                        const itemsResult = surveyResult.response[i].itemList;
                        let detailHtml = '<div class="survey-item-detail multiple-choice-check"><ul class="multiple-choice-wrap">';
                        for(let j=0;j<itemsResult.length;j++){
                            const itemTitle = itemsResult[j].survey_item_title;
                            detailHtml += '<li class="multiple-item">'+
                                        '<input type="checkbox">'+
                                        '<label class="check-label"></label>'+
                                        '<input type="text" placeholder="옵션" value="'+itemTitle+'" readonly>'+
                                        '<button class="btn-item-add" style="visibility:hidden;"><i class="fa-solid fa-plus"></i></button>'+
                                        '<button class="btn-item-remove" style="visibility:hidden;"><i class="fa-solid fa-xmark"></i></button>'+
                                        '</li>';
                        }
                        detailHtml += '</ul></div>';
                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("linear-scale" == formType){
                        const itemsResult = surveyResult.response[i].itemList;
                        let leftValue = "";
                        let rightValue = "";
                        for(let j=0;j<itemsResult.length;j++){
                            const itemTitle = itemsResult[j].survey_item_title;
                            if("left" == itemsResult[j].survey_item_type){
                                leftValue = itemTitle;
                            }else if("right" == itemsResult[j].survey_item_type){
                                rightValue = itemTitle;
                            }
                        }
                        let detailHtml = '<div class="survey-item-detail linear-scale">\n' +
                            '            <ul class="linear-scale-wrap">\n' +
                            '              <li class="linear-label">\n' +
                            '                <input type="text" placeholder="라벨" value="'+leftValue+'" readonly>\n' +
                            '              </li>\n' +
                            '              <li class="linear-item">\n' +
                            '                <div class="radio-wrap">\n' +
                            '                  <span>1</span>\n' +
                            '                  <input type="radio">\n' +
                            '                  <label class="radio-label"></label>\n' +
                            '                </div>\n' +
                            '              </li>\n' +
                            '              <li class="linear-item">\n' +
                            '                <div class="radio-wrap">\n' +
                            '                  <span>2</span>\n' +
                            '                  <input type="radio">\n' +
                            '                  <label class="radio-label"></label>\n' +
                            '                </div>\n' +
                            '              </li>\n' +
                            '              <li class="linear-item">\n' +
                            '                <div class="radio-wrap">\n' +
                            '                  <span>3</span>\n' +
                            '                  <input type="radio">\n' +
                            '                  <label class="radio-label"></label>\n' +
                            '                </div>\n' +
                            '              </li>\n' +
                            '              <li class="linear-item">\n' +
                            '                <div class="radio-wrap">\n' +
                            '                  <span>4</span>\n' +
                            '                  <input type="radio">\n' +
                            '                  <label class="radio-label"></label>\n' +
                            '                </div>\n' +
                            '              </li>\n' +
                            '              <li class="linear-item">\n' +
                            '                <div class="radio-wrap">\n' +
                            '                  <span>5</span>\n' +
                            '                  <input type="radio">\n' +
                            '                  <label class="radio-label"></label>\n' +
                            '                </div>\n' +
                            '              </li>\n' +
                            '              <li class="linear-label">\n' +
                            '                <input type="text" placeholder="라벨" value="'+rightValue+'" readonly>\n' +
                            '              </li>\n' +
                            '            </ul></div>';
                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("radio-grid" == formType){
                        const itemsResult = surveyResult.response[i].itemList;
                        let columnCount = 0;
                        let detailColumnHtml = '';
                        let detailRowHtml = '';
                        for(let j=0;j<itemsResult.length;j++){
                            if("column" == itemsResult[j].survey_item_type){
                                columnCount++;
                            }
                        }
                        for(let j=0;j<itemsResult.length;j++){
                            const itemTitle = itemsResult[j].survey_item_title;
                            let checkColumnHtml = '                  <td>\n' +
                                '                    <input type="radio">\n' +
                                '                    <label class="radio-label"></label>\n' +
                                '                  </td>\n';

                            if("row" == itemsResult[j].survey_item_type){
                                detailRowHtml += '                <tr>\n' +
                                    '                  <th>'+itemTitle+'</th>\n';
                                for(let z=0;z<columnCount;z++){
                                    detailRowHtml += checkColumnHtml;
                                }
                                detailRowHtml += '                </tr>\n';
                            }else if("column" == itemsResult[j].survey_item_type){
                                detailColumnHtml += '<th>'+itemTitle+'</th>\n';
                            }
                        }
                        let detailHtml = '<div class="survey-item-detail radio-grid">\n' +
                            '            <div class="grid-check-wrap">\n' +
                            '              <table>\n' +
                            '                <tr>\n' +
                            '                  <th class="empty"></th>\n' +detailColumnHtml+
                            '                </tr>\n' + detailRowHtml +
                            '              </table>\n' +
                            '            </div>\n' +
                            '          </div>';

                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("check-grid" == formType){
                        const itemsResult = surveyResult.response[i].itemList;
                        let columnCount = 0;
                        let detailColumnHtml = '';
                        let detailRowHtml = '';
                        for(let j=0;j<itemsResult.length;j++){
                            if("column" == itemsResult[j].survey_item_type){
                                columnCount++;
                            }
                        }
                        for(let j=0;j<itemsResult.length;j++){
                            const itemTitle = itemsResult[j].survey_item_title;
                            let checkColumnHtml = '                  <td>\n' +
                                '                    <input type="checkbox">\n' +
                                '                    <label class="check-label"></label>\n' +
                                '                  </td>\n';

                            if("row" == itemsResult[j].survey_item_type){
                                detailRowHtml += '                <tr>\n' +
                                    '                  <th>'+itemTitle+'</th>\n';
                                for(let z=0;z<columnCount;z++){
                                    detailRowHtml += checkColumnHtml;
                                }
                                detailRowHtml += '                </tr>\n';
                            }else if("column" == itemsResult[j].survey_item_type){
                                detailColumnHtml += '<th>'+itemTitle+'</th>\n';
                            }
                        }
                        let detailHtml = '<div class="survey-item-detail check-grid">\n' +
                            '            <div class="grid-check-wrap">\n' +
                            '              <table>\n' +
                            '                <tr>\n' +
                            '                  <th class="empty"></th>\n' +detailColumnHtml+
                            '                </tr>\n' + detailRowHtml +
                            '              </table>\n' +
                            '            </div>\n' +
                            '          </div>';

                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }

                    htmlString = htmlString + typeHtmlStirng;
                }

                $("#detailArea").html(htmlString);

                $(".survey-form-style").removeClass("active");
                $(document).off("click",".survey-form-style")
                $(document).on("click",".survey-form-style",  function () {
                    $(this).addClass("active");
                    $(".survey-form-style").not($(this)).removeClass("active");
                });

                //상단 X 버튼
                $(".panel-close-btn").off("click");
                $(".panel-close-btn").on("click", function () {
                    hideSidePanel("right");
                });

            });
        });

    }
	
	function fn_cancelModify(){
		hideSidePanel("right");
	}
	
	function fn_surveyModify(){
		let seq = $("#survey_id").val();
		let title = $("#surveyDetailTitle").val();
		let surveyDescription = $("#surveyDetailDescription").val();
        let sendData = {};

        sendData.command = "detail";
        sendData.survey_id = seq;
        showSidePanel("dtx-survey-detail", "right", function () {});

        NSCOMMON.apiPost("${pageContext.request.contextPath}/surveyDetail.json", sendData, "json", true, function (surveyResult) {
            showSidePanel("dtx-survey-detail", "right", function () {
                let htmlString = '<div class="survey-form-style title">' +
                    '        <div class="top"></div>' +
                    '        <div class="left"></div>' +
                    '        <div class="survey-detail">' +
                    '          <div class="input-box">' +
                    '            <input type="text" id="surveyDetailTitle" placeholder="제목을 입력하세요" value="'+title+'">' +
                    '          </div>' +
                    '          <div class="input-box">' +
                    '            <input type="text" id="surveyDetailDescription" placeholder="설문지 설명" value="'+surveyDescription+'">' +
                    '          </div>' +
                    '        </div>' +
                    '      </div>';

                for(let i=0;i<surveyResult.response.length;i++){
                    let formType = surveyResult.response[i].survey_form_type;
                    let title = surveyResult.response[i].survey_form_question;
                    let formDescription = surveyResult.response[i].survey_form_description;
                    let formSeq = surveyResult.response[i].survey_form_id;
                    let typeHtmlStirng = "";
                    let selectString = "";
                    if("short-text"==formType){
                        selectString = "단답형";
                    }else if("long-text"==formType){
                        selectString = "장문형";
                    }else if("multiple-choice-radio"==formType){
                        selectString = "객관식 질문 - 1";
                    }else if("multiple-choice-check"==formType){
                        selectString = "객관식 질문 - 2";
                    }else if("linear-scale"==formType){
                        selectString = "선형 배율";
                    }else if("radio-grid"==formType){
                        selectString = "객관식 그리드";
                    }else if("check-grid"==formType){
                        selectString = "체크박스 그리드";
                    }

                    let htmlHeader = '<div class="survey-form-style item report">' +
                    	'        <input type="hidden" id="formSeq'+i+'" value="'+formSeq+'">' +
                        '        <div class="top"></div>' +
                        '        <div class="left"></div>' +
                        '        <div class="survey-detail">' +
                        '          <div class="survey-item-title">' +
                        '            <div class="input-box">' +
                        '              <input type="text" placeholder="질문을 입력하세요" value="'+title+'">' +
                        '            </div>' +
                        '            <div class="require-select">' +
                        '              <span>필수</span>' +
                        '              <input class="require-tgl" type="checkbox" checked>' +
                        '              <label class="require-btn"></label>' +
                        '            </div>' +
                        '            <div class="survey-style-select-box">' +
                        '              <div class="select-box">' +
                        '                <div class="select-item">' +
                        '                  <span class="select-placeholder">'+selectString+'</span>' +
                        '                  <i class="fa-solid fa-chevron-down"></i>' +
                        '                </div>' +
                        '              </div>' +
                        '              <div class="select-list-wrap">' +
                        '                <ul class="survey-style-list">' +
                        '                  <li class="survey-style-item">단답형</li>' +
                        '                  <li class="survey-style-item">장문형</li>' +
                        '                  <li class="survey-style-item">객관식 질문 - 1</li>' +
                        '                  <li class="survey-style-item">객관식 질문 - 2</li>' +
                        '                  <li class="survey-style-item">선형 배율</li>' +
                        '                  <li class="survey-style-item">객관식 그리드</li>' +
                        '                  <li class="survey-style-item">체크박스 그리드</li>' +
                        '                </ul>' +
                        '              </div>' +
                        '            </div>' +
                        '          </div>';
                    let htmlFooter = '</div>' +
                        '      </div>';

                    $("#html-part > .input-box."+formType).find(".survey-item-title").find("input[type=text]").val(title);
                    $("#html-part > .input-box."+formType).find(".survey-item-explanation").find("input[type=text]").val(formDescription);
                    if("short-text" == formType){
                        const formPlaceholder = surveyResult.response[i].survey_form_placeholder;
                        let detailHtml = '<div class="survey-item-detail short-text" formType="'+formType+'">\n' +
                            '            <div class="input-box">\n' +
                            '              <input type="text" placeholder="'+formPlaceholder+'" class="itemValue">\n' +
                            '            </div>\n' +
                            '          </div>';
                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("long-text" == formType){
                        const formPlaceholder = surveyResult.response[i].survey_form_placeholder;
                        let detailHtml = '<div class="survey-item-detail long-text" formType="'+formType+'">\n' +
                            '            <div class="textarea-box">\n' +
                            '              <textarea placeholder="'+formPlaceholder+'" class="itemValue" id="'+itemSeq+'"></textarea>\n' +
                            '            </div>\n' +
                            '          </div>';
                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("multiple-choice-radio" == formType){
                        const itemsResult = surveyResult.response[i].itemList;
                        let detailHtml = '<div class="survey-item-detail multiple-choice-radio" formType="'+formType+'"><ul class="multiple-choice-wrap">';
                        for(let j=0;j<itemsResult.length;j++){
                            const itemTitle = itemsResult[j].survey_item_title;
                            const itemSeq = itemsResult[j].survey_form_item_id;
                            const itemScore = itemsResult[j].survey_item_score;
                            detailHtml += '<li class="multiple-item">'+
                                                '<input type="radio" name="radio_'+formSeq+'">'+
                                                '<label class="radio-label"></label>'+
                                                '<input type="text" placeholder="옵션" class="itemValue" value="'+itemTitle+'">'+
                                                '<input type="text" id="'+itemSeq+'" class="itemScore" value="'+itemScore+'">'+
                                                '</li>';
                        }
                        detailHtml += '</ul></div>';
                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("multiple-choice-check" == formType){
                        const itemsResult = surveyResult.response[i].itemList;
                        let detailHtml = '<div class="survey-item-detail multiple-choice-check" formType="'+formType+'"><ul class="multiple-choice-wrap">';
                        for(let j=0;j<itemsResult.length;j++){
                            const itemTitle = itemsResult[j].survey_item_title;
                            const itemSeq = itemsResult[j].survey_form_item_id;
                            const itemScore = itemsResult[j].survey_item_score;
                            detailHtml += '<li class="multiple-item">'+
                                        '<input type="checkbox">'+
                                        '<label class="check-label"></label>'+
                                        '<input type="text" placeholder="옵션" class="itemValue" value="'+itemTitle+'">'+
                                        '<input type="text" id="'+itemSeq+'" class="itemScore" value="'+itemScore+'">'+
                                        '</li>';
                        }
                        detailHtml += '</ul></div>';
                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("linear-scale" == formType){
                        const itemsResult = surveyResult.response[i].itemList;
                        let leftValue = "";
                        let rightValue = "";
                        for(let j=0;j<itemsResult.length;j++){
                            const itemTitle = itemsResult[j].survey_item_title;
                            if("left" == itemsResult[j].survey_item_type){
                                leftValue = itemTitle;
                            }else if("right" == itemsResult[j].survey_item_type){
                                rightValue = itemTitle;
                            }
                        }
                        let detailHtml = '<div class="survey-item-detail linear-scale" formType="'+formType+'">\n' +
                            '            <ul class="linear-scale-wrap">\n' +
                            '              <li class="linear-label">\n' +
                            '                <input type="text" placeholder="라벨" class="itemValue" value="'+leftValue+'">\n' +
                            '              </li>\n' +
                            '              <li class="linear-item">\n' +
                            '                <div class="radio-wrap">\n' +
                            '                  <span>1</span>\n' +
                            '                  <input type="radio">\n' +
                            '                  <label class="radio-label"></label>\n' +
                            '                </div>\n' +
                            '              </li>\n' +
                            '              <li class="linear-item">\n' +
                            '                <div class="radio-wrap">\n' +
                            '                  <span>2</span>\n' +
                            '                  <input type="radio">\n' +
                            '                  <label class="radio-label"></label>\n' +
                            '                </div>\n' +
                            '              </li>\n' +
                            '              <li class="linear-item">\n' +
                            '                <div class="radio-wrap">\n' +
                            '                  <span>3</span>\n' +
                            '                  <input type="radio">\n' +
                            '                  <label class="radio-label"></label>\n' +
                            '                </div>\n' +
                            '              </li>\n' +
                            '              <li class="linear-item">\n' +
                            '                <div class="radio-wrap">\n' +
                            '                  <span>4</span>\n' +
                            '                  <input type="radio">\n' +
                            '                  <label class="radio-label"></label>\n' +
                            '                </div>\n' +
                            '              </li>\n' +
                            '              <li class="linear-item">\n' +
                            '                <div class="radio-wrap">\n' +
                            '                  <span>5</span>\n' +
                            '                  <input type="radio">\n' +
                            '                  <label class="radio-label"></label>\n' +
                            '                </div>\n' +
                            '              </li>\n' +
                            '              <li class="linear-label">\n' +
                            '                <input type="text" placeholder="라벨" class="itemValue" value="'+rightValue+'">\n' +
                            '              </li>\n' +
                            '            </ul></div>';
                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("radio-grid" == formType){
                        const itemsResult = surveyResult.response[i].itemList;
                        let columnCount = 0;
                        let detailColumnHtml = '';
                        let detailRowHtml = '';
                        for(let j=0;j<itemsResult.length;j++){
                            if("column" == itemsResult[j].survey_item_type){
                                columnCount++;
                            }
                        }
                        for(let j=0;j<itemsResult.length;j++){
                            const itemTitle = itemsResult[j].survey_item_title;
                            const itemScore = itemsResult[j].survey_item_score;
                            let checkColumnHtml = '                  <td>\n' +
                                '                    <input type="radio" class="itemValue" value="'+itemScore+'">\n' +
                                '                    <label class="radio-label"></label>\n' +
                                '                  </td>\n';

                            if("row" == itemsResult[j].survey_item_type){
                                detailRowHtml += '                <tr>\n' +
                                    '                  <th>'+itemTitle+'</th>\n';
                                for(let z=0;z<columnCount;z++){
                                    detailRowHtml += checkColumnHtml;
                                }
                                detailRowHtml += '                </tr>\n';
                            }else if("column" == itemsResult[j].survey_item_type){
                                detailColumnHtml += '<th>'+itemTitle+'</th>\n';
                            }
                        }
                        let detailHtml = '<div class="survey-item-detail radio-grid" formType="'+formType+'">\n' +
                            '            <div class="grid-check-wrap">\n' +
                            '              <table>\n' +
                            '                <tr>\n' +
                            '                  <th class="empty"></th>\n' +detailColumnHtml+
                            '                </tr>\n' + detailRowHtml +
                            '              </table>\n' +
                            '            </div>\n' +
                            '          </div>';

                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }else if("check-grid" == formType){
                        const itemsResult = surveyResult.response[i].itemList;
                        let columnCount = 0;
                        let detailColumnHtml = '';
                        let detailRowHtml = '';
                        for(let j=0;j<itemsResult.length;j++){
                            if("column" == itemsResult[j].survey_item_type){
                                columnCount++;
                            }
                        }
                        for(let j=0;j<itemsResult.length;j++){
                            const itemTitle = itemsResult[j].survey_item_title;
                            const itemScore = itemsResult[j].survey_item_score;
                            let checkColumnHtml = '                  <td>\n' +
                                '                    <input type="checkbox" class="itemValue" value="'+itemScore+'">\n' +
                                '                    <label class="check-label"></label>\n' +
                                '                  </td>\n';

                            if("row" == itemsResult[j].survey_item_type){
                                detailRowHtml += '                <tr>\n' +
                                    '                  <th>'+itemTitle+'</th>\n';
                                for(let z=0;z<columnCount;z++){
                                    detailRowHtml += checkColumnHtml;
                                }
                                detailRowHtml += '                </tr>\n';
                            }else if("column" == itemsResult[j].survey_item_type){
                                detailColumnHtml += '<th>'+itemTitle+'</th>\n';
                            }
                        }
                        let detailHtml = '<div class="survey-item-detail check-grid" formType="'+formType+'">\n' +
                            '            <div class="grid-check-wrap">\n' +
                            '              <table>\n' +
                            '                <tr>\n' +
                            '                  <th class="empty"></th>\n' +detailColumnHtml+
                            '                </tr>\n' + detailRowHtml +
                            '              </table>\n' +
                            '            </div>\n' +
                            '          </div>';

                        typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                    }

                    htmlString = htmlString + typeHtmlStirng;
                }

                $("#detailArea").html(htmlString);

                $(".survey-form-style").removeClass("active");
                $(document).off("click",".survey-form-style")
                $(document).on("click",".survey-form-style",  function () {
                    $(this).addClass("active");
                    $(".survey-form-style").not($(this)).removeClass("active");
                });

                //상단 X 버튼
                $(".panel-close-btn").off("click");
                $(".panel-close-btn").on("click", function () {
                    hideSidePanel("right");
                });
                
                $(".btn_modify").addClass("dis-none");
        		$(".btn_update").removeClass("dis-none");
        		$(".btn_cancel").removeClass("dis-none");

            });
        });

    }
	
	function fn_updateSurvey(){
        let title = $("#surveyDetailTitle").val();
        let surveyDescription = $("#surveyDetailDescription").val();
        let itemCount = 0
        let surveyForms = [];

        $(".surveyInsertForm").find(".survey-form-style.item").each(function(i){
            let surveyForm = {}

            let form = "";
            if(NSCOMMON.isEmpty($(this).find(".survey-item-detail").attr("formType"))){
                form = "short-text";
            }else{
                form = $(this).find(".survey-item-detail").attr("formType");
            }
            let question = $(this).find(".survey-item-title").find("input[type=text]").val();
            let formDescription = $(this).find(".survey-item-explanation").find("input[type=text]").val();

            let formPlaceholder = "";
            if("short-text" == form){
                formPlaceholder = $(this).find(".survey-item-detail").find("input[type=text]").val();
            }

            if("long-text" == form){
                formPlaceholder = $(this).find(".survey-item-detail").find(".surveyTextarea").val();
            }
            let itemList = [];
            if("check-grid" == form || "radio-grid" == form){
                $(this).find(".row-list").find("input[type=text]").each(function(idx){
                    let item = {};
                    item.survey_item_type = "row";
                    item.survey_item_no = idx;
                    item.survey_item_title = $(this).val();
                    itemList.push(item);
                });

                $(this).find(".column-list").find("input[type=text]").each(function(idx){
                    let item = {};
                    item.survey_item_type = "column";
                    item.survey_item_no = idx;
                    item.survey_item_title = $(this).val();
                    itemList.push(item);
                });
            }else if("multiple-choice-radio" == form){
                $(this).find(".multiple-item").each(function(idx){
               	 console.log("multiple-item : "+idx);
                    let item = {};
                    item.survey_form_item_id = $(this).find(".itemScore").attr("id");
                    item.survey_item_no = idx;
                    item.survey_item_title = $(this).find(".itemValue").val();
                    item.survey_item_score = $(this).find(".itemScore").val();
                    item.survey_item_type = "radio";
                    itemList.push(item);
                })
            }else if("multiple-choice-check" == form){
                $(this).find(".multiple-item").each(function(idx){
                    let item = {};
                    item.survey_form_item_id = $(this).find(".itemScore").attr("id");
                    item.survey_item_no = idx;
                    item.survey_item_title = $(this).find(".itemValue").val();
                    item.survey_item_score = $(this).find(".itemScore").val();
                    item.survey_item_type = "check";
                    itemList.push(item);
                })
            }else if("linear-scale" == form){
                $(this).find(".linear-label").each(function(idx){
                    let item = {};
                    item.survey_item_no = idx;
                    item.survey_item_title = $(this).find(".itemValue").val();
                    if(idx == 0){
                        item.survey_item_type = "left";
                    }else{
                        item.survey_item_type = "right";
                    }
                    itemList.push(item);
                })
            }
            surveyForm.survey_form_id = $("#formSeq"+i).val();
            surveyForm.survey_form_type = form;
            surveyForm.survey_form_no = i;
            surveyForm.survey_form_question = question;
            console.log(surveyForm.survey_form_question);
            surveyForm.survey_form_description = formDescription;
            surveyForm.survey_form_placeholder = formPlaceholder;
            surveyForm.itemList = itemList;

            surveyForms.push(surveyForm);

            itemCount++;
        })

        let sendData = {};

        sendData.command = "update";
        sendData.survey_id = $("#survey_id").val();
        sendData.survey_title = title;
        sendData.survey_description = surveyDescription;
        sendData.surveyFormList = surveyForms;

        NSCOMMON.apiPost("${pageContext.request.contextPath}/updateSurvey.json", sendData, "json", true, function (surveyResult) {
        	alert("수정 되었습니다.");
            location.reload();
        });
   }
	
	function fn_calModify(){
		let seq = $("#survey_id").val();
		let title = $("#surveyDetailTitle").val();
		let surveyDescription = $("#surveyDetailDescription").val();
        let sendData = {};

        sendData.command = "detail";
        sendData.survey_id = seq;

        NSCOMMON.apiPost("${pageContext.request.contextPath}/surveyScoreDetail.json", sendData, "json", true, function (surveyResult) {
            showSidePanel2("dtx-survey-detail", "right", function () {
                let htmlString = '<div class="survey-form-style2 title">' +
                    '        <div class="top"></div>' +
                    '        <div class="left"></div>' +
                    '        <div class="survey-detail">' +
                    '          <div class="input-box">' +
                    '            <input type="text" id="surveyDetailTitle" placeholder="제목을 입력하세요" value="'+title+'">' +
                    '          </div>' +
                    '          <div class="input-box">' +
                    '            <input type="text" id="surveyDetailDescription" placeholder="설문지 설명" value="'+surveyDescription+'">' +
                    '          </div>' +
                    '        </div>' +
                    '      </div>';

                for(let i=0;i<surveyResult.response.length;i++){
                    let formType = surveyResult.response[i].survey_form_type;
                    let title = surveyResult.response[i].survey_form_question;
                    let formDescription = surveyResult.response[i].survey_form_description;
                    let formSeq = surveyResult.response[i].survey_form_id;
                    let typeHtmlStirng = "";
                    let selectString = "";

                    let htmlHeader = '<div class="survey-form-style2 item report">' +
                    	'        <input type="hidden" id="formSeq'+i+'" value="'+formSeq+'">' +
                        '        <div class="top"></div>' +
                        '        <div class="left"></div>' +
                        '        <div class="survey-detail">' +
                        '          <div class="survey-item-title">' +
                        '            <div class="input-box">' +
                        '              <input type="text" placeholder="질문을 입력하세요" value="Q.'+(i+1)+' '+title+'" readonly>' +
                        '            </div>' +
                        '          </div>';
                    let htmlFooter = '</div>' +
                        '      </div>';
                    typeHtmlStirng = htmlHeader+htmlFooter;

                    htmlString = htmlString + typeHtmlStirng;
                }

                $("#detailArea").html(htmlString);
                
                for(let k=0;k<surveyResult.responseScore.length;k++){
                    let scoreType = surveyResult.responseScore[k].survey_score_type;
                    let scoreGroupName = surveyResult.responseScore[k].survey_score_group_name;
                    let scoreGroupMag = surveyResult.responseScore[k].surveyScoreList[0].survey_score_mag;
                    
                    var groupItem = $("#typeArea .survey-form-style2").clone();
                    var groupValue;
                    groupItem.find(".typeName").html(scoreGroupName);
                    groupItem.find(".surveyScoreMag").val(scoreGroupMag);
                    $("#surveyTypeForm").append(groupItem);
                    
                    for(let h=0;h<surveyResult.responseScore[k].surveyScoreList.length;h++){
                    	
                    	let surveyScoreFormId = surveyResult.responseScore[k].surveyScoreList[h].survey_score_form_id;
                    	let surveyScoreFormText = surveyResult.responseScore[k].surveyScoreList[h].survey_score_form_text;
                    	
                    	var tagItem = $("#tagArea .tag-wrap").clone();
                        var tagValue;
                        tagItem.find(".keyword-tag").text(surveyScoreFormText);
                        tagItem.find(".keyword-tag").attr("data", surveyScoreFormId);
                        
                    	groupItem.find(".surveyNumberArea").append(tagItem);
                    }
                    
                    $(".survey-style-select-box").find(".select-box > .select-item > span").attr("data", surveyResult.responseScore[k].survey_score_type);
                    if("average" == surveyResult.responseScore[k].survey_score_type){
                    	$(".survey-style-select-box").find(".select-box > .select-item > span").text("평균");	
                    }else if("sum" == surveyResult.responseScore[k].survey_score_type){
                    	$(".survey-style-select-box").find(".select-box > .select-item > span").text("합산");
                    }else if("standard" == surveyResult.responseScore[k].survey_score_type){
                    	$(".survey-style-select-box").find(".select-box > .select-item > span").text("합산-기준");
                    }
                    
                    $(".survey-style-select-box2").find(".select-box > .select-item > span").attr("data", surveyResult.responseScore[k].survey_score_graph);
                    if("average" == surveyResult.responseScore[k].survey_score_graph){
                    	$(".survey-style-select-box2").find(".select-box > .select-item > span").text("띠 그래프(X축 기준)");	
                    }else if("sum" == surveyResult.responseScore[k].survey_score_graph){
                    	$(".survey-style-select-box2").find(".select-box > .select-item > span").text("띠 그래프(Y축 기준)");
                    }else if("standard" == surveyResult.responseScore[k].survey_score_graph){
                    	$(".survey-style-select-box2").find(".select-box > .select-item > span").text("라인 그래프");
                    }
                }

                $(".survey-form-style").removeClass("active");
                $(document).off("click",".survey-form-style")
                $(document).on("click",".survey-form-style",  function () {
                    $(this).addClass("active");
                    $(".survey-form-style").not($(this)).removeClass("active");
                });

                //상단 X 버튼
                $(".panel-close-btn").off("click");
                $(".panel-close-btn").on("click", function () {
                    hideSidePanel("right");
                });
                
                $(".btn_modify").addClass("dis-none");
        		$(".btn_cancel").removeClass("dis-none");
        		
        		$(document).off("click",".survey-style-select-box");
                $(document).on("click",".survey-style-select-box", function () {
                   $(this).toggleClass("open");
                });
                
                $(document).off("click", ".survey-style-item");
                $(document).on("click", ".survey-style-item", function () {
                    //단답형
                   var selectSurveyStyle = $(this).index();
                   var surveyStyleMap = {0 : "평균", 1 : "합산" , 2 : "합산 - 기준"};
                   var surveyStyleClassMap = {0 : "average", 1 : "sum" , 2 : "standard"};

                   $(this).parents(".survey-style-select-box").find(".select-box > .select-item > span").text(surveyStyleMap[selectSurveyStyle]);
                   $(this).parents(".survey-style-select-box").find(".select-box > .select-item > span").attr("data", surveyStyleClassMap[selectSurveyStyle]);
                });
                
                $(document).off("click",".survey-style-select-box2");
                $(document).on("click",".survey-style-select-box2", function () {
                   $(this).toggleClass("open");
                });
                
                $(document).off("click", ".survey-style-item2");
                $(document).on("click", ".survey-style-item2", function () {
                    //단답형
                   var selectSurveyStyle = $(this).index();
                   var surveyStyleMap = {0 : "띠 그래프(X축 기준)", 1 : "띠 그래프(Y축 기준)" , 2 : "라인 그래프"};
                   var surveyStyleClassMap = {0 : "normalX", 1 : "normalY" , 2 : "line"};

                   $(this).parents(".survey-style-select-box2").find(".select-box > .select-item > span").text(surveyStyleMap[selectSurveyStyle]);
                   $(this).parents(".survey-style-select-box2").find(".select-box > .select-item > span").attr("data", surveyStyleClassMap[selectSurveyStyle]);
                });
                
                
                
                $("#surveyType").off("keypress");
                $("#surveyType").on("keypress", function (e) {
                    if(e.key === "Enter" || e.keyCode == 32){
                        var tag = $(this).val();
                        if(tag == ""){
                            alert("입력된 구분명이 없습니다.");
                            return false;
                        }

                        var tagItem = $("#typeArea .survey-form-style2").clone();
                        var tagValue;
                        tagItem.find(".typeName").html(tag);
                        $("#surveyTypeForm").append(tagItem);
                        $(this).val("");
                        
                        $(".delete-type").off("click");
                        $(".delete-type").on("click", function (e) {
                            $(this).parent().parent().parent().remove();
                        });
                        
                        $(".surveyTypeSeq").off("keypress");
                        $(".surveyTypeSeq").on("keypress", function (e) {
                            if(e.key === "Enter" || e.keyCode == 32){
                                var tag = $(this).val();
                                if(tag == ""){
                                    alert("입력된 문항이 없습니다.");
                                    return false;
                                }
                                
                                var checkTag = parseInt(tag)-1;
                                var checkTagValue = $("#formSeq"+checkTag).val();
                                if(NSCOMMON.isEmpty(checkTagValue)){
                                	alert("없는 문항 번호 입니다.");
                                	$(this).val("");
                                	return false;
                                }
                                console.log(checkTagValue);
                                
                                var checkCount = 0;
                                
                                $(this).parent().parent().parent().find(".surveyNumberArea").find(".keyword-tag").each(function(){
                                	var checkText = $(this).text();
                                	if(tag == checkText){
                                		checkCount++;
                                	}
                                })
                                
                                if(checkCount > 0){
                                	alert("해당 구분에 이미 존재하는 문항 번호 입니다.");
                                	$(this).val("");
                                	return false;
                                }
                                
                                var tagItem = $("#tagArea .tag-wrap").clone();
                                var tagValue;
                                tagItem.find(".keyword-tag").text(tag);
                                tagItem.find(".keyword-tag").attr("data", checkTagValue);
                                $(this).parent().parent().parent().find(".surveyNumberArea").append(tagItem);
                                $(this).val("");
                                
                                $(".tag-delete").off("click");
                                $(".tag-delete").on("click", function (e) {
                                    $(this).parent().remove();
                                });
                            }
                        });
                    }
                });
                
                $(".tag-delete").off("click");
                $(".tag-delete").on("click", function (e) {
                    $(this).parent().remove();
                });

            });
        });

    }
	
	function fn_insertSurveyScore(){
		var surveyId = $("#survey_id").val();
		console.log("surveyId : "+surveyId);
		var surveyScoreType = $(".survey-style-select-box").find(".select-box > .select-item > span").attr("data");
		console.log("surveyScoreType : "+surveyScoreType);
		
		var surveyScoreGraph = $(".survey-style-select-box2").find(".select-box > .select-item > span").attr("data");
		
		let surveyForms = [];
		
		$("#surveyTypeForm").find(".typeName").each(function(){
			var surveyScoreName = $(this).html();
			
			if(!NSCOMMON.isEmpty(surveyScoreName)){
				let surveyForm = {}
				
				console.log("surveyScoreType : "+surveyScoreName);
				
				
				
				var scoreMag = $(this).parent().parent().find(".surveyScoreMag").val();
				
				
				
				console.log("scoreMag : "+scoreMag);
				
				let scoreList = [];
				
				$(this).parent().parent().find(".surveyNumberArea").find(".keyword-tag").each(function(){
					var scoreFormText =  $(this).text();
					var scoreFormId = $(this).attr("data");
					let score = {};
					score.survey_score_type = surveyScoreType;
					score.survey_score_mag = scoreMag;
					score.survey_score_form_id = scoreFormId;
					score.survey_score_form_text = scoreFormText;
					
					console.log("scoreFormText : "+scoreFormText);
					console.log("scoreFormId : "+scoreFormId);
					
					scoreList.push(score);
				});
				
				surveyForm.survey_score_type = surveyScoreType;
				surveyForm.survey_score_graph = surveyScoreGraph;
				surveyForm.survey_score_group_name = surveyScoreName;
				surveyForm.surveyScoreList = scoreList;
				surveyForms.push(surveyForm);
			}
		})
		
		let sendData = {};

        sendData.command = "insert";
        sendData.survey_id = $("#survey_id").val();
        sendData.surveyScoreGroupList = surveyForms;
        
        console.log(sendData);
        let checkKeyword = 0;
        
        $(".keyword-tag").each(function(){
        	checkKeyword++;
        })
        
        if(checkKeyword > 0){
        	NSCOMMON.apiPost("${pageContext.request.contextPath}/insertSurveyScore.json", sendData, "json", true, function (surveyResult) {
            	alert("등록 되었습니다.");
                location.reload();
            });	
        }else{
        	alert("등록된 문항이 없습니다.");
        }
	}
	
	function fn_surveySample(){
		window.open('${pageContext.request.contextPath}/surveySample.do', '_blank', 'width=500, height=800');
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
                <!-- todo new task sidebar -->
	<div id="side-panel-area" class="hide">
		<div class="side-panel-dim"></div>
		<div class="side-panel-content right active">
             
		</div>
	</div>
    <div class="app-content content content-radius">
    	
        <div class="content-right" style="width: calc(100% - 15px) !important;">
            <div class="content-overlay"></div>
            <div class="content-wrapper">
                <div class="content-header row">
                </div>
                <div class="content-body">
                    <div class="app-content-overlay"></div>
					<h3 class="content-header-title mb-0 mt-1 pl-1">진단/설문 관리</h3>
					<div class="row breadcrumbs-top mb-1 pl-1">
						<div class="breadcrumb-wrapper col-12">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/siteList.do">Home</a>
								</li>
								<li class="breadcrumb-item active">진단/설문 관리
								</li>
							</ol>
						</div>
					</div>
                    <section class="row all-contacts">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-head">
                                    <div class="card-header">
                                        <h4 class="card-title"></h4>
                                        <div class="heading-elements mt-0">
                                            <button class="btn btn-primary btn-md" ><i class="d-md-none d-block feather icon-plus white"></i>
                                                <span class="d-md-block d-none" onclick="javascript:fn_surveyRegi();return false;">진단 등록</span></button>
                                            <button class="btn btn-primary btn-md" ><i class="d-md-none d-block feather icon-plus white"></i>
                                                <span class="d-md-block d-none" onclick="javascript:fn_surveySample();return false;">결과 샘플</span></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-content">
                                	<form:form id="parameterVO" name="parameterVO">
                                		<input type="hidden" id="survey_id" name="survey_id" value=""/>
                                	</form:form>
                                    <div class="card-body">
                                        <!-- Task List table -->
                                        <button type="button" class="btn btn-danger btn-sm delete-all mb-1">삭제</button>
                                        <div class="table-responsive">
                                            <table id="" class="table table-white-space table-bordered row-grouping display no-wrap icheck table-middle text-center">
                                                <thead>
                                                    <tr>
                                                    	<th><div class="icheckbox_square-blue" style="position: relative;"><input type="checkbox" class="input-chk" id="check-all" onclick="toggle();" style="position: absolute; opacity: 0;"></div></th>
                                                        <th>진단 제목</th>
                                                        <th>진단 설명</th>
														<th>등록일</th>
														<th>수정일</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                	<c:forEach var="surveyList" items="${surveyList}">
                                                		<fmt:parseDate var="reg_date" value="${surveyList.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                		<fmt:parseDate var="updt_date" value="${surveyList.updt_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                                                    <tr>
	                                                    	<td>
	                                                    		<div class="icheckbox_square-blue" style="position: relative;"><input type="checkbox" class="input-chk check" style="position: absolute; opacity: 0;" value="${surveyList.survey_id}"></div>
	                                                    	</td>
	                                                        <td class="text-center aa" onclick="javascript:viewDetailSurvey('${surveyList.survey_id}', '${surveyList.survey_title}', '${surveyList.survey_description}');return false;">
	                                                        	<a href="#" onclick="javascript:viewDetailSurvey('${surveyList.survey_id}', '${surveyList.survey_title}', '${surveyList.survey_description}');return false;" >${surveyList.survey_title}</a>
	                                                        </td>
	                                                        <td>
	                                                            ${surveyList.survey_description}
	                                                        </td>
															<td class="text-center double-line">
	                                                            <fmt:formatDate value="${reg_date}" pattern="yyyy-MM-dd HH:mm:ss" />
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
                                </div>
                            </div>
                        </div>
                    </section>

                </div>
            </div>
        </div>
    </div>
    <div id="html-part" style="display: none;" layout:fragment="html-part">
    <!-- 추가시 기본(단답형) 질문지 추가 -->
    <div class="survey-form-style item survey-add-item">
       <div class="top"></div>
       <div class="left"></div>
       <div class="survey-detail">
            <div class="survey-item-title">
              <div class="input-box">
                  <input type="text" placeholder="질문을 입력하세요">
              </div>
              <div class="require-select">
                  <span>필수</span>
                  <input class="require-tgl" type="checkbox">
                  <label class="require-btn"></label>
              </div>
              <div class="survey-style-select-box">
                <div class="select-box">
                    <div class="select-item">
                        <span class="select-placeholder">단답형</span>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                </div>
                <div class="select-list-wrap">
                    <ul class="survey-style-list">
                        <li class="survey-style-item">단답형</li>
                        <li class="survey-style-item">장문형</li>
                        <li class="survey-style-item">객관식 질문 - 1</li>
                        <li class="survey-style-item">객관식 질문 - 2</li>
                        <li class="survey-style-item">선형 배율</li>
                        <li class="survey-style-item">객관식 그리드</li>
                        <li class="survey-style-item">체크박스 그리드</li>
                        <li class="survey-style-item">날짜형</li>
                    </ul>
                </div>
              </div>
            </div>
            <div class="survey-item-explanation">
                <div class="input-box">
                    <input type="text" placeholder="질문 설명">
                </div>
            </div>
            <div class="survey-item-detail short-text">
                <div class="input-box">
                    <input type="text" placeholder="미리보기 설명 작성 - ex. 1~3글자를 입력하세요">
                </div>
            </div>
            <div class="survey-item-setting">
                <button class="survey-item-add-btn"><i class="fa-solid fa-plus"></i></button>
                <button class="survey-item-remove-btn"><i class="fa-solid fa-trash-can"></i></button>
            </div>
       </div>
    </div>

    <!-- 설문종류 : 단답형 / 장문형 / 객관직 질문(1) / 객관식 질문(2) / 선형 배율 / 객관식 그리드 / 체크박스 그리드 / 날짜형 -->
    <!-- 단답형 -->
    <div class="input-box short-text">
        <input type="text" placeholder="미리보기 설명 작성 - ex. 1~3글자를 입력하세요">
    </div>;
    <!-- 장문형 -->
    <div class="textarea-box long-text">
        <textarea class="surveyTextarea" placeholder="미리보기 설명 작성 - ex. 자세한 후기를 남기면 향후 치료에 도움이 됩니다"></textarea>
    </div>;
    <!-- 객관식 질문 - 1 -->
    <ul class="multiple-choice-wrap multiple-choice-radio">
         <li class="multiple-item">
             <input type="radio">
            <label class="radio-label"></label>
            <input type="text" placeholder="옵션">
            <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
            <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
         </li>
    </ul>";
    <!-- 객관식 질문 - 2 -->
    <ul class="multiple-choice-wrap multiple-choice-check">
        <li class="multiple-item">
            <input type="checkbox">
            <label class="check-label"></label>
            <input type="text" placeholder="옵션">
            <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
            <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
        </li>
    </ul>;
    <!-- 선형 배율 -->
    <ul class="linear-scale-wrap linear-scale">
        <li class="linear-label">
           <input type="text" placeholder="라벨">
       </li>
       <li class="linear-item">
            <div class="radio-wrap">
            <span>1</span>
            <input type="radio">
            <label class="radio-label"></label>
             </div>
       </li>
       <li class="linear-item">
            <div class="radio-wrap">
                <span>2</span>
                <input type="radio">
                <label class="radio-label"></label>
            </div>
        </li>
       <li class="linear-item">
            <div class="radio-wrap">
                <span>3</span>
                <input type="radio">
                <label class="radio-label"></label>
            </div>
        </li>
       <li class="linear-item">
        <div class="radio-wrap">
            <span>4</span>
            <input type="radio">
            <label class="radio-label"></label>
        </div>
        </li>
           <li class="linear-item">
            <div class="radio-wrap">
                <span>5</span>
                <input type="radio">
                <label class="radio-label"></label>
            </div>
        </li>
           <li class="linear-label">
            <input type="text" placeholder="라벨">
        </li>
    </ul>
    <!-- 객관식 그리드 -->
    <div class= "grid-make-wrap radio-grid">
        <ul class="row-list">
            <li class="row-list-label">행</li>
            <li class="row-list-item">
                <input type="text" placeholder="행 라벨">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
            </li>
        </ul>
        <ul class="column-list">
            <li class="column-list-label">열</li>
            <li class="column-list-item">
                <input type="text" placeholder="열 라벨">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
            </li>
        </ul>
    </div>
    <!-- 체크박스 그리드 -->
    <div class="grid-make-wrap check-grid">
        <ul class="row-list">
            <li class="row-list-label">행</li>
            <li class="row-list-item">
                <input type="text" placeholder="행 라벨">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
           </li>
         </ul>
        <ul class="column-list">
            <li class="column-list-label">열</li>
            <li class="column-list-item">
                <input type="text" placeholder="열 라벨">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
            </li>
       </ul>
   </div>
    <!-- 날짜형 -->
    <div class="input-box date">
        <input type="date">
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
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/forms/quill/quill.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/extensions/dragula.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app-menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/core/app.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/neoulsoft/dtx.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/neoulsoft/neoulsoft-mobile.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/neoulsoft/common.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/neoulsoft/config.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/app-contacts.js"></script>
    <script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/app-todo.js"></script>
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>