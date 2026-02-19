<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{common/layout/base-page-layout}">

<th:block layout:fragment="css">
    <style type="text/css">
    </style>
</th:block>

<th:block layout:fragment="script">
    <script type="text/javascript" th:inline="javascript">
        $(document).ready(function () {
            $(".menu-item#manage").addClass("open");
            $(".menu-item#manage > .sub-menu-wrap li").eq(3).addClass("active");

            /*등록하기*/
            $(".card-head .btn-add").off("click");
            $(".card-head .btn-add").on("click", function () {
                registerSurvey();
            });

            /*수정하기*/
            $(".tb-modify-btn").off("click");
            $(".tb-modify-btn").on("click", function (e) {
                e.stopPropagation();
                e.preventDefault();
                modifySurvey();
            });

            //필수 선택(토글버튼)
            $(document).off("click", ".require-btn");
            $(document).on("click", ".require-btn", function () {
                if($(this).prev().prop("checked") === true){
                    $(this).prev().prop("checked", false);
                }else{
                    $(this).prev().prop("checked", true);
                }
            });

            //질문 - 라디오 버튼
            var radioLabel = $(".radio-label");
            $(document).off("click", ".radio-label");
            $(document).on("click", ".radio-label", function () {
                if($(this).prev().prop("checked") === true){
                    $(this).prev().prop("checked", false);
                }else{
                    $(this).prev().prop("checked", true);
                    radioLabel.not($(this)).prev().prop("checked", false); // 중복선택 막기
                }
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

            searchList(1);
        });
        function onFrontScriptReady() {
            console.log("front script ready...");
        }

        function searchList(pageIndex) {
            let sendData = {};

            sendData.searchField = "";
            sendData.searchKeyword = "";
            sendData.command = "list";
            sendData.pageNo = pageIndex;
            sendData.pageSize = 10;

            NSCOMMON.apiPost(NSCONFIG.surveyUrl, sendData, "json", true, function (surveyListResult) {
                fn_makeList(surveyListResult);
            });
        }

        function fn_makeList(surveyListResult){
            let htmlString = "";
            const totalCount = surveyListResult.resultCount;
            for(let i=0; i<surveyListResult.response.length; i++){
                const listNo = surveyListResult.response.length-i;
                const seq = surveyListResult.response[i].seq;
                const title = NSCOMMON.B64.decode(surveyListResult.response[i].title);
                const createdAt = NSM.timeDiff(surveyListResult.response[i].createdAt);
                const surveyDescription = NSCOMMON.B64.decode(surveyListResult.response[i].surveyDescription);

                htmlString += '<tr seq="'+seq+'" title="'+title+'" surveyDescription="'+surveyDescription+'">'+
                    '<td>'+listNo+'</td>'+
                    '<td>'+
                        '<a class="view-detail">'+title+'</a>'+
                    '</td>'+
                    '<td>'+createdAt+'</td>'+
                    '<td>관리자</td>'+
                    '<td>전체 환자</td>'+
                    '<td>Y</td>'+
                    '<td class="tb-edit">'+
                        '<a class="tb-modify-btn">'+
                            '<i class="tb-edit-icon fa-solid fa-pencil"></i>'+
                        '</a>'+
                        '<a class="tb-delete-btn">'+
                            '<i class="tb-edit-icon fa-solid fa-trash-can"></i>'+
                        '</a>'+
                    '</td>'+
                    '</tr>';
            }

            $(".total").text(totalCount+"개");

            $("#surveyTbodyList").html(htmlString);

            $(".view-detail").off("click");
            $(".view-detail").on("click", function () {
                const seq = $(this).attr("seq");
                const surveyDescription= $(this).attr("surveyDescription");
                const title= $(this).attr("title");
                viewDetailSurvey(seq, title, surveyDescription);
            });

            $(".tb-delete-btn").off("click");
            $(".tb-delete-btn").on("click", function (e) {
                e.stopPropagation();
                e.preventDefault();
                if(confirm("삭제하시겠습니까?")){
                    let sendData = {};

                    sendData.command = "delete";
                    sendData.seq = $(this).parent().parent().attr("seq");

                    NSCOMMON.apiPost(NSCONFIG.surveyUrl, sendData, "json", true, function (surveyListResult) {
                        location.reload();
                    });
                }
            });
        }

        /* 설문지 등록 */
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

                    //날짜형
                    var date = $("#html-part > .input-box.date").clone();

                   var selectSurveyStyle = $(this).index();
                   var surveyStyleMap = {0 : "단답형", 1 : "장문형" , 2 : "객관식 질문 - 1", 3 : "객관식 질문 - 2", 4 : "선형 배율", 5 : "객관식 그리드", 6 : "체크박스 그리드" ,  7: "날짜형"};
                   var surveyStyleClassMap = {0 : "short-text", 1 : "long-text" , 2 : "multiple-choice-radio", 3 : "multiple-choice-check", 4 : "linear-scale", 5 : "radio-grid", 6 : "check-grid" ,  7: "date"};
                   var surveyStyleHtmlMap = {0 : shortText, 1:longText, 2:multipleChoiceRadio, 3:multipleChoiceCheck, 4:linearScale, 5 :radioGrid, 6 :checkGrid, 7:date};

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

                    $("#surveyInsertForm").find(".survey-form-style.item").each(function(i){
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
                                item.itemType = "row";
                                item.itemNo = idx;
                                item.itemTitle = $(this).val();
                                itemList.push(item);
                            });

                            $(this).find(".column-list").find("input[type=text]").each(function(idx){
                                let item = {};
                                item.itemType = "column";
                                item.itemNo = idx;
                                item.itemTitle = $(this).val();
                                itemList.push(item);
                            });
                        }else if("multiple-choice-radio" == form){
                            $(this).find(".multiple-item").each(function(idx){
                                let item = {};
                                item.itemNo = idx;
                                item.itemTitle = $(this).find("input[type=text]").val();
                                item.itemType = "radio";
                                itemList.push(item);
                            })
                        }else if("multiple-choice-check" == form){
                            $(this).find(".multiple-item").each(function(idx){
                                let item = {};
                                item.itemNo = idx;
                                item.itemTitle = $(this).find("input[type=text]").val();
                                item.itemType = "check";
                                itemList.push(item);
                            })
                        }else if("linear-scale" == form){
                            $(this).find(".linear-label").each(function(idx){
                                let item = {};
                                item.itemNo = idx;
                                item.itemTitle = $(this).find("input[type=text]").val();
                                if(idx == 0){
                                    item.itemType = "left";
                                }else{
                                    item.itemType = "right";
                                }
                                itemList.push(item);
                            })
                        }
                        surveyForm.formType = form;
                        surveyForm.formNo = i;
                        surveyForm.question = question;
                        surveyForm.formDescription = formDescription;
                        surveyForm.formPlaceholder = formPlaceholder;
                        surveyForm.itemList = itemList;

                        surveyForms.push(surveyForm);

                        itemCount++;
                    })

                    let sendData = {};

                    sendData.command = "insert";
                    sendData.title = title;
                    sendData.surveyDescription = surveyDescription;
                    sendData.surveyForms = surveyForms;

                    NSCOMMON.apiPost(NSCONFIG.surveyUrl, sendData, "json", true, function (surveyResult) {
                        location.reload();
                    });
                })
            });
        }

        /* 미리보기 */
        function previewSurvey(){
            showSidePanel("dtx-survey-preview", "right", function () {
                $(".panel-back-btn, .btn-back").on("click", function () {
                    registerSurvey();
                });
            });
        }

        /* 설문 보기 */
        function viewDetailSurvey(seq, title, surveyDescription){
            let sendData = {};

            sendData.command = "detail";
            sendData.seq = seq;
            showSidePanel("dtx-survey-detail", "right", function () {});

            NSCOMMON.apiPost(NSCONFIG.surveyUrl, sendData, "json", true, function (surveyResult) {
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
                        '            <input type="text" id="surveyDetailDescription" placeholder="설문지 설명" value="'+surveyDescription+'">' +
                        '          </div>' +
                        '        </div>' +
                        '      </div>';

                    for(let i=0;i<surveyResult.response.length;i++){
                        let formType = surveyResult.response[i].formType;
                        let title = NSCOMMON.B64.decode(surveyResult.response[i].question);
                        let formDescription = surveyResult.response[i].formDescription;
                        let formSeq = surveyResult.response[i].formSeq;
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
                            const formPlaceholder = NSCOMMON.B64.decode(surveyResult.response[i].formPlaceholder);
                            let detailHtml = '<div class="survey-item-detail short-text">\n' +
                                '            <div class="input-box">\n' +
                                '              <input type="text" placeholder="'+formPlaceholder+'">\n' +
                                '            </div>\n' +
                                '          </div>';
                            typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                        }else if("long-text" == formType){
                            const formPlaceholder = NSCOMMON.B64.decode(surveyResult.response[i].formPlaceholder);
                            let detailHtml = '<div class="survey-item-detail long-text">\n' +
                                '            <div class="textarea-box">\n' +
                                '              <textarea placeholder="'+formPlaceholder+'"></textarea>\n' +
                                '            </div>\n' +
                                '          </div>';
                            typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                        }else if("multiple-choice-radio" == formType){
                            const itemsResult = surveyResult.response[i].formItems;
                            let detailHtml = '<div class="survey-item-detail multiple-choice-radio"><ul class="multiple-choice-wrap">';
                            for(let j=0;j<itemsResult.length;j++){
                                const itemTitle = NSCOMMON.B64.decode(itemsResult[j].itemTitle);
                                detailHtml += '<li class="multiple-item">'+
                                                    '<input type="radio" name="radio_'+formSeq+'">'+
                                                    '<label class="radio-label"></label>'+
                                                    '<input type="text" placeholder="옵션" value="'+itemTitle+'">'+
                                                    '<button class="btn-item-add" style="visibility:hidden;"><i class="fa-solid fa-plus"></i></button>'+
                                                    '<button class="btn-item-remove" style="visibility:hidden;"><i class="fa-solid fa-xmark"></i></button>'+
                                                    '</li>';
                            }
                            detailHtml += '</ul></div>';
                            typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                        }else if("multiple-choice-check" == formType){
                            const itemsResult = surveyResult.response[i].formItems;
                            let detailHtml = '<div class="survey-item-detail multiple-choice-check"><ul class="multiple-choice-wrap">';
                            for(let j=0;j<itemsResult.length;j++){
                                const itemTitle = NSCOMMON.B64.decode(itemsResult[j].itemTitle);
                                detailHtml += '<li class="multiple-item">'+
                                            '<input type="checkbox">'+
                                            '<label class="check-label"></label>'+
                                            '<input type="text" placeholder="옵션" value="'+itemTitle+'">'+
                                            '<button class="btn-item-add" style="visibility:hidden;"><i class="fa-solid fa-plus"></i></button>'+
                                            '<button class="btn-item-remove" style="visibility:hidden;"><i class="fa-solid fa-xmark"></i></button>'+
                                            '</li>';
                            }
                            detailHtml += '</ul></div>';
                            typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                        }else if("linear-scale" == formType){
                            const itemsResult = surveyResult.response[i].formItems;
                            let leftValue = "";
                            let rightValue = "";
                            for(let j=0;j<itemsResult.length;j++){
                                const itemTitle = NSCOMMON.B64.decode(itemsResult[j].itemTitle);
                                if("left" == itemsResult[j].itemType){
                                    leftValue = itemTitle;
                                }else if("right" == itemsResult[j].itemType){
                                    rightValue = itemTitle;
                                }
                            }
                            let detailHtml = '<div class="survey-item-detail linear-scale">\n' +
                                '            <ul class="linear-scale-wrap">\n' +
                                '              <li class="linear-label">\n' +
                                '                <input type="text" placeholder="라벨" value="'+leftValue+'">\n' +
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
                                '                <input type="text" placeholder="라벨" value="'+rightValue+'">\n' +
                                '              </li>\n' +
                                '            </ul></div>';
                            typeHtmlStirng = htmlHeader+detailHtml+htmlFooter;
                        }else if("radio-grid" == formType){
                            const itemsResult = surveyResult.response[i].formItems;
                            let columnCount = 0;
                            let detailColumnHtml = '';
                            let detailRowHtml = '';
                            for(let j=0;j<itemsResult.length;j++){
                                if("column" == itemsResult[j].itemType){
                                    columnCount++;
                                }
                            }
                            for(let j=0;j<itemsResult.length;j++){
                                const itemTitle = NSCOMMON.B64.decode(itemsResult[j].itemTitle);
                                let checkColumnHtml = '                  <td>\n' +
                                    '                    <input type="radio">\n' +
                                    '                    <label class="radio-label"></label>\n' +
                                    '                  </td>\n';

                                if("row" == itemsResult[j].itemType){
                                    detailRowHtml += '                <tr>\n' +
                                        '                  <th>'+itemTitle+'</th>\n';
                                    for(let z=0;z<columnCount;z++){
                                        detailRowHtml += checkColumnHtml;
                                    }
                                    detailRowHtml += '                </tr>\n';
                                }else if("column" == itemsResult[j].itemType){
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
                            const itemsResult = surveyResult.response[i].formItems;
                            let columnCount = 0;
                            let detailColumnHtml = '';
                            let detailRowHtml = '';
                            for(let j=0;j<itemsResult.length;j++){
                                if("column" == itemsResult[j].itemType){
                                    columnCount++;
                                }
                            }
                            for(let j=0;j<itemsResult.length;j++){
                                const itemTitle = NSCOMMON.B64.decode(itemsResult[j].itemTitle);
                                let checkColumnHtml = '                  <td>\n' +
                                    '                    <input type="checkbox">\n' +
                                    '                    <label class="check-label"></label>\n' +
                                    '                  </td>\n';

                                if("row" == itemsResult[j].itemType){
                                    detailRowHtml += '                <tr>\n' +
                                        '                  <th>'+itemTitle+'</th>\n';
                                    for(let z=0;z<columnCount;z++){
                                        detailRowHtml += checkColumnHtml;
                                    }
                                    detailRowHtml += '                </tr>\n';
                                }else if("column" == itemsResult[j].itemType){
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

        /* 설문 수정 */
        function modifySurvey(){
            showSidePanel("dtx-survey-modify", "right", function () {
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
        }
    </script>
</th:block>

<div class="page-content survey-manage" layout:fragment="content">
       <div class="content-head">
            <div class="content-header">
                <span class="content-title">설문 관리</span>
            </div>
            <ul class="content-sub-header">
                <li>
                    <i class="fa-solid fa-house"></i>
                    <a href="dashboard">Home</a>
                </li>
                <li><a href="setting">DTx관리</a></li>
                <li class="active">설문 관리</li>
            </ul>
        </div>
       <div class="content-card">
        <div class="card">
            <div class="card-head">
                <span>설문 목록</span>
                <button class="btn btn-circle btn-add">
                    <span>설문지 등록</span>
                    <i class="fa-solid fa-plus"></i>
                </button>
            </div>
            <div class="card-body">
                <div class="card-search-wrap">
                    <span class="total-title">전체 설문 : <span class="total">2개</span></span>
                    <div class="card-search-area">
                        <div class="form-box select-box">
                            <select>
                                <option selected>선택해 주세요</option>
                                <option>입력 수행률</option>
                                <option>이름</option>
                                <option>등록일</option>
                                <option>나이</option>
                                <option>성별</option>
                                <option>배정군</option>
                                <option>당뇨</option>
                                <option>혈압</option>
                                <option>마지막 입력 날짜</option>
                            </select>
                            <i class="fa-solid fa-chevron-down"></i>
                        </div>
                        <div class="form-box search-box">
                            <input type="text" placeholder="데이터 검색">
                            <button class="btn-search">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="content-table">
                    <table id="questionaire-list">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>제목</th>
                                <th>등록일시</th>
                                <th>등록인</th>
                                <th>대상자</th>
                                <th>게시여부</th>
                                <th class="tb-edit">Edit</th>
                            </tr>
                        </thead>
                        <tbody id="surveyTbodyList">

                        </tbody>
                    </table>
                    <div class="page">
                        <ul class="pagination">
                            <li>
                                <button class="first-page">
                                    처음 페이지
                                </button>
                            </li>
                            <li>
                                <button class="previous-page">
                                    <i class="fa-solid fa-angle-left"></i>
                                    <i class="fa-solid fa-angle-left"></i>
                                </button>
                            </li>
                            <li>
                                <button class="num active">1</button>
                            </li>
<!--                            <li>-->
<!--                                <button class="num">2</button>-->
<!--                            </li>-->
<!--                            <li>-->
<!--                                <button class="num">3</button>-->
<!--                            </li>-->
                            <li>
                                <button class="next-page">
                                    <i class="fa-solid fa-angle-right"></i>
                                    <i class="fa-solid fa-angle-right"></i>
                                </button>
                            </li>
                            <li>
                                <button class="last-page">
                                    마지막 페이지
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>
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
</html>