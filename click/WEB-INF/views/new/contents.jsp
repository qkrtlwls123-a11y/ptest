<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{common/layout/base-page-layout}">

<th:block layout:fragment="css">
    <style type="text/css">
        .card-head.list.hide{
            display: none;
        }
        .card-head.board-detail.hide{
            display: none;
        }
        .card-body.list.hide{
            display: none;
        }
        .card-body.board-detail.hide{
            display: none;
        }


        .sample{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .sample > div{
            font-size: 18px;
            margin-top: 30px;
        }
    </style>
</th:block>

<th:block layout:fragment="script">
    <script type="text/javascript" th:inline="javascript">
        $(document).ready(function () {

            /*ë±ë¡íê¸°*/
            $(".card-head .btn-add").off("click");
            $(".card-head .btn-add").on("click", function () {
                registerContents();
            });

            /*ìì¸ë³´ê¸°*/
            /*$(".content-list-item").off("click");
            $(".content-list-item").on("click", function () {
                var cate = $(this).attr("cate");
                var title = $(this).attr("title");
                var imgSrc = $(this).attr("imgSrc");
                viewDetailContents(cate, title, imgSrc);
            });*/

            searchList(1);
        });

        function onFrontScriptReady() {
            console.log("front script ready...");
        }

        //ë±ë¡íê¸°
        function registerContents(){
            showSidePanel("dtx-contents", "right", function () {
                var sidePanelArea = $("#dtx-contents");

                //ìëí° ì½ì
                tinymce.init({
                    selector: '#editor-contents',
                    height : 300,
                    menubar: false
                });

                sidePanelArea.find("input[type='file']").off("click");
                sidePanelArea.find("input[type='file']").on("click", function () {
                    sidePanelArea.find("input[type='file']").off("change");
                    sidePanelArea.find("input[type='file']").on("change", function (e) {

                        var file = e.target.files[0];

                        uploadSummernoteImageFile(file);
                    });
                });

                sidePanelArea.find(".form-box.radio .form-item").off("click");
                sidePanelArea.find(".form-box.radio .form-item").on("click", function () {
                    $(this).addClass("checked");
                    $(this).siblings().removeClass("checked");
                });


                //í´ìíê·¸
                $("#hashTag").on("keypress", function (e) {
                    if(e.key === "Enter" || e.keyCode == 32){
                        var tag = $(this).val();
                        if(tag == ""){
                            alert("ìë ¥ë í¤ìëê° ììµëë¤.");
                            return false;
                        }

                        var tagItem = $("#html-part .tag-wrap").clone();
                        var tagValue;
                        tagItem.find(".keyword-tag").text("#"+tag);
                        $(".hashTage-wrap").append(tagItem);
                        tagValue = $(".hashTage-wrap .keyword-tag").text();
                        var arr = tagValue.split("#");
                        console.log(arr);
                        $(this).val("");
                    }
                });

                $(document).off("click", ".tag-delete");
                $(document).on("click", ".tag-delete", function () {
                    $(this).parent().remove();
                });

                //ìë¨ X ë²í¼
                $(".panel-close-btn").off("click");
                $(".panel-close-btn").on("click", function () {
                    hideSidePanel("right");
                    
                });

                //ë±ë¡ë²í¼
                sidePanelArea.find(".btn-submit > span").text("ë±ë¡");
                sidePanelArea.find(".btn-submit").off("click");
                sidePanelArea.find(".btn-submit").on("click", function () {
                    hideSidePanel("right");

                    fn_insertContents();

                    /*setTimeout(function () {
                        $(".content-list-item").removeClass("hide");
                    }, 1000);*/
                });
            });
        }

        //ìì¸ë³´ê¸°
        function viewDetailContents(seq){
            let sendData = {};

            sendData.command = "detail";
            sendData.seq = seq;

            NSCOMMON.apiPost(NSCONFIG.contentsUrl, sendData, "json", true, function (contentsDetailResult) {

                const seq = contentsDetailResult.response.seq;
                const checkContentsType = contentsDetailResult.response.contentsType;
                let contentsType = "";
                if("H" == checkContentsType){
                    contentsType = "ê±´ê°ì ë³´";
                }else if("W" == checkContentsType){
                    contentsType = "ìë¨ì ë³´";
                }else if("D" == checkContentsType){
                    contentsType = "ì´ëì ë³´";
                }else if("E" == checkContentsType){
                    contentsType = "ê¸°íì ë³´";
                }
                const title = NSCOMMON.B64.decode(contentsDetailResult.response.title);
                const contentItem = NSCOMMON.B64.decode(contentsDetailResult.response.content);
                const imgSrc = contentsDetailResult.response.contentsImage;
                const contentNoTag = NSCOMMON.B64.decode(contentsDetailResult.response.contentNoTag);
                const viewCount = contentsDetailResult.response.viewCount;
                const checkTimeDiff = NSM.timeDiff(contentsDetailResult.response.registeredAt);
                const reserveOffset = contentsDetailResult.response.reserveOffset;
                const htmlString = '<img src="'+imgSrc+'" class="content-img">\n' +
                    '               <div id="contentDetail">\n' +
                    contentItem+
                    '               </div>'
                $("#viewCount").text(viewCount);

                $(".card-head").addClass("hide");
                $(".card-body").addClass("hide");

                $(".card-head.board-detail").removeClass("hide");
                $(".card-body.board-detail").removeClass("hide");

                $(".page-content-wrap").scrollTop(0); // í­ì ìë¨ë¶í°

                $(".card-body.board-detail .content-detail-title").find(".content-label").text(contentsType);
                $(".card-body.board-detail .content-detail-title").find(".title").text(title);
                $(".card-body.board-detail .sample").find(".content-img").attr("src", imgSrc);

                $(".content-detail-info-left").find(".name").text();
                $(".content-detail-info-left").find(".time").text(checkTimeDiff);
                $(".sample").html(htmlString);

                searchListDetail(1, checkContentsType, seq);

                $(".content-modify").off("click");
                $(".content-modify").on("click", function () {
                    modifyContents(seq, contentsType, checkContentsType, checkTimeDiff, title, imgSrc, contentItem, reserveOffset);
                });
                //ì­ì ë²í¼
                $(".content-delete").off("click");
                $(".content-delete").on("click", function () {
                    alert("ì­ì íìê² ìµëê¹?");
                });
                //ì­ì ë²í¼
                // ë±ë¡ > ëìê°ê¸°
                $(".btn-list-back").off("click");
                $(".btn-list-back").on("click", function() {
                    $(".card-head").addClass("hide");
                    $(".card-body").addClass("hide");

                    $(".card-head.list").removeClass("hide");
                    $(".card-body.list").removeClass("hide");
                    
                });
            });


        }

        //ìì íê¸°
        function modifyContents(seq, cate, checkContentsType, checkTimeDiff, title, imgSrc, contentItem, reserveOffset){
            showSidePanel("dtx-contents", "right", function () {
                var sidePanelArea = $("#dtx-contents");

                //ì½íì¸  ìì íê¸°
                $(".panel-head > .panel-title").text("ì½íì¸  ìì íê¸°");
                //ìëí° ì½ì
                tinymce.init({
                    selector: '#editor-contents',
                    height : 300,
                    menubar: false
                });

                //í´ìíê·¸
                $("#hashTag").on("keypress", function (e) {
                    if(e.key === "Enter" || e.keyCode == 32){
                        var tag = $(this).val();
                        if(tag == ""){
                            alert("ìë ¥ë í¤ìëê° ììµëë¤.");
                            return false;
                        }

                        var tagItem = $("#html-part .tag-wrap").clone();
                        var tagValue;
                        tagItem.find(".keyword-tag").text("#"+tag);
                        $(".hashTage-wrap").append(tagItem);
                        tagValue = $(".hashTage-wrap .keyword-tag").text();
                        var arr = tagValue.split("#");
                        console.log(arr);
                        $(this).val("");
                    }
                });

                $(document).off("click", ".tag-delete");
                $(document).on("click", ".tag-delete", function () {
                    $(this).parent().remove();
                });

                //ìë¨ X ë²í¼
                $(".panel-close-btn").off("click");
                $(".panel-close-btn").on("click", function () {
                    hideSidePanel("right");
                    
                });

                /* sample */

                var link = "https://youtu.be/H-LjGVgTNYw";
                var tag = "<div class=\"tag-wrap\">\n" +
                    "        <span class=\"keyword-tag\">#ë¹ë§</span>\n" +
                    "        <i class=\"fa-solid fa-x tag-delete\"></i>\n" +
                    "    </div><div class=\"tag-wrap\">\n" +
                    "        <span class=\"keyword-tag\">#ë³´ê±´ì</span>\n" +
                    "        <i class=\"fa-solid fa-x tag-delete\"></i>\n" +
                    "    </div><div class=\"tag-wrap\">\n" +
                    "        <span class=\"keyword-tag\">#ë¬´ë£ê±´ê°ê²ì§</span>\n" +
                    "        <i class=\"fa-solid fa-x tag-delete\"></i>\n" +
                    "    </div><div class=\"tag-wrap\">\n" +
                    "        <span class=\"keyword-tag\">#íì</span>\n" +
                    "        <i class=\"fa-solid fa-x tag-delete\"></i>\n" +
                    "    </div><div class=\"tag-wrap\">\n" +
                    "        <span class=\"keyword-tag\">#ì¬ì±ê±´ê°</span>\n" +
                    "        <i class=\"fa-solid fa-x tag-delete\"></i>\n" +
                    "    </div>";
                sidePanelArea.find("#contents_type").val(checkContentsType);
                sidePanelArea.find(".title .form-box > input").attr("value",title);
                sidePanelArea.find(".text #editor-contents").html(contentItem);
                sidePanelArea.find(".contents-thumbnail").removeClass("hide");
                sidePanelArea.find(".contents-thumbnail > img").attr("src", imgSrc);
                sidePanelArea.find(".video-link .form-box > input").attr("value",link);

                sidePanelArea.find(".patient .form-box .form-item").eq(2).addClass("checked");
                sidePanelArea.find(".clinical .form-box .form-item").eq(0).addClass("checked");
                sidePanelArea.find(".gender .form-box .form-item").eq(1).addClass("checked");

                sidePanelArea.find(".patient .form-box .form-item > input").eq(2).prop("checked", true);
                sidePanelArea.find(".clinical .form-box .form-item > input").eq(0).prop("checked", true);
                sidePanelArea.find(".gender .form-box .form-item > input").eq(1).prop("checked", true);

                sidePanelArea.find(".contents-provide .form-box-wrap .form-box").eq(0).find("select option").eq(1).prop("selected", true);
                sidePanelArea.find(".contents-provide .form-box-wrap .form-box").eq(1).find("select option").eq(2).prop("selected", true);
                sidePanelArea.find(".contents-provide .form-box-wrap .form-box").eq(2).find("select option").eq(13).prop("selected", true);

                sidePanelArea.find("input[type='file']").off("click");
                sidePanelArea.find("input[type='file']").on("click", function () {
                    sidePanelArea.find("input[type='file']").off("change");
                    sidePanelArea.find("input[type='file']").on("change", function (e) {

                        var file = e.target.files[0];

                        uploadSummernoteImageFile(file);
                    });
                });

                console.log(reserveOffset);
                console.log("ì£¼ : "+fn_formatReverseWeek(reserveOffset))
                console.log("ì¼ : "+fn_formatReverseDay(reserveOffset))
                console.log("ìê° : "+fn_formatReverseHour(reserveOffset))
                sidePanelArea.find("#timeWeek").val(fn_formatReverseWeek(reserveOffset));
                sidePanelArea.find("#timeDay").val(fn_formatReverseDay(reserveOffset));
                sidePanelArea.find("#timeHour").val(fn_formatReverseHour(reserveOffset));

                sidePanelArea.find(".hashTage-wrap").append(tag);

                sidePanelArea.find(".btn-submit > span").text("ìì ");

                sidePanelArea.find(".btn-submit").off("click");
                sidePanelArea.find(".btn-submit").on("click", function () {
                    hideSidePanel("right");

                    fn_updateContents(seq);

                    /*setTimeout(function () {
                        $(".content-list-item").removeClass("hide");
                    }, 1000);*/
                });

            });
        }
        //ëª¨ë°ì¼ íë©´
        function viewMobileContent(){
            showSidePanel("dtx-contents-mobile", "right", function () {
                $(".survey-form-style").removeClass("active");
                $(document).off("click",".survey-form-style")
                $(document).on("click",".survey-form-style",  function () {
                    $(this).addClass("active");
                    $(".survey-form-style").not($(this)).removeClass("active");
                });

                //ìë¨ X ë²í¼
                $(".panel-close-btn").off("click");
                $(".panel-close-btn").on("click", function () {
                    hideSidePanel("right");
                });
            });
        }

        function uploadSummernoteImageFile(file) {
            console.log(file);
            var ajaxData = new FormData();
            ajaxData.append("attach", file);
            console.log(ajaxData)
            $.ajax({
                xhr: function () {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener("progress", function (evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total;
                            console.log("percentComplete=" + (percentComplete * 100));
                        }
                    }, false);
                    return xhr;
                },
                url: NSCONFIG.uploadUrl,
                type: "POST",
                data: ajaxData,
                dataType: 'json',
                cache: false,
                contentType: false,
                processData: false,
                complete: function (xhr) {
                    console.log("uploadCompleted=" + JSON.stringify(xhr));
                },
                success: function (jsonResult) {
                    if (jsonResult.code != 200) {
                        alert(__this.B64.decode(jsonResult.message));
                        return;
                    }
                    console.log(jsonResult);
                    var href = window.URL.createObjectURL(file);

                    console.log(href);
                    var sidePanelArea = $("#dtx-contents");

                    sidePanelArea.find(".text-form-style.contents-thumbnail").removeClass("hide");
                    sidePanelArea.find(".text-form-style.contents-thumbnail > img").attr("src", jsonResult.response);

                    sidePanelArea.find("input[type='file']").off("change");
                    sidePanelArea.find("input[type='file']").val("");
                    //$(editor).summernote('insertImage', jsonResult.response);
                },
                error: function () {
                    console.log("Upload failed.");
                }
            });
        }

        function fn_checkTimeFormat(week, day, hour){
            let totalTime = 0;
            if(!NSCOMMON.isEmpty(week)){
                week = week*7*24*60*60*1000;
                totalTime = totalTime + week;
            }
            if(!NSCOMMON.isEmpty(day)){
                day = day*24*60*60*1000;
                totalTime = totalTime + day;
            }
            if(!NSCOMMON.isEmpty(hour)){
                hour = hour*60*60*1000;
                totalTime = totalTime + hour;
            }

            return totalTime;
        }

        function fn_formatReverseWeek(totalTime){
            let week = 0;
            let check = 7*24*60*60*1000;
            if(!NSCOMMON.isEmpty(totalTime)){
                week = parseInt(totalTime/check);
            }
            return week;
        }

        function fn_formatReverseDay(totalTime){
            let day = 0;
            let check = 24*60*60*1000;
            if(!NSCOMMON.isEmpty(totalTime)){
                day = parseInt(totalTime/check);
                day = day%7;
            }
            return day;
        }

        function fn_formatReverseHour(totalTime){
            let hour = 0;
            let check = 60*60*1000;
            if(!NSCOMMON.isEmpty(totalTime)){
                hour = totalTime/check;
                hour = hour%24;
            }
            return hour;
        }

        function searchList(pageIndex) {
            let sendData = {};

            sendData.searchField = "";
            sendData.searchKeyword = "";
            sendData.command = "list";
            sendData.pageNo = pageIndex;
            sendData.pageSize = 10;
            console.log("sendData : "+sendData);

            NSCOMMON.apiPost(NSCONFIG.contentsUrl, sendData, "json", true, function (contentsListResult) {
                fn_makeList(contentsListResult);
            });
        }

        function searchListDetail(pageIndex, contentsType, seq) {
            let sendData = {};

            sendData.searchField = "contentsType";
            sendData.searchKeyword = contentsType;
            sendData.command = "list";
            sendData.pageNo = pageIndex;
            sendData.pageSize = 5;
            console.log("sendData : "+sendData);

            NSCOMMON.apiPost(NSCONFIG.contentsUrl, sendData, "json", true, function (contentsListResult) {
                fn_makeDetailList(contentsListResult, seq);
                //ìì ë²í¼
            });
        }

        function fn_insertContents(){
            let contentsText = tinymce.get("editor-contents").getContent();
            let title = $("#contents_title").val();
            let contentsType = $("#contents_type").val();
            let timeWeek = parseInt($("#timeWeek").val());
            let timeDay = parseInt($("#timeDay").val());
            let timeHour = parseInt($("#timeHour").val());
            let contentsImage = $("#dtx-contents").find(".text-form-style.contents-thumbnail > img").attr("src");

            console.log("!!!!!!!!!!!!!!!!!"+contentsImage);

            let totalTime = fn_checkTimeFormat(timeWeek, timeDay, timeHour);

            let sendData = {};

            sendData.command = "insert";
            sendData.contentsType = contentsType;
            sendData.title = title;
            sendData.content = contentsText;
            sendData.reserveOffset = totalTime;
            sendData.contentsImage = contentsImage;

            NSCOMMON.apiPost(NSCONFIG.contentsUrl, sendData, "json", true, function (contentsResult) {
                location.reload();
            });

        }

        function fn_updateContents(seq){
            let contentsText = tinymce.get("editor-contents").getContent();
            let title = $("#contents_title").val();
            let contentsType = $("#contents_type").val();
            let timeWeek = parseInt($("#timeWeek").val());
            let timeDay = parseInt($("#timeDay").val());
            let timeHour = parseInt($("#timeHour").val());
            let contentsImage = $("#dtx-contents").find(".text-form-style.contents-thumbnail > img").attr("src");
            console.log(timeWeek);
            console.log(timeDay);
            console.log(timeHour);

            let totalTime = fn_checkTimeFormat(timeWeek, timeDay, timeHour);


            console.log(totalTime);

            let sendData = {};

            sendData.command = "update";
            sendData.contentsType = contentsType;
            sendData.title = title;
            sendData.content = contentsText;
            sendData.reserveOffset = totalTime;
            sendData.contentsImage = contentsImage;
            sendData.seq = seq;

            NSCOMMON.apiPost(NSCONFIG.contentsUrl, sendData, "json", true, function (contentsResult) {
                location.reload();
            });

        }

        function fn_makeList(contentListResult){
            let htmlString = "";
            const totlaCount = contentListResult.resultCount;
            for(let i=0; i<contentListResult.response.length; i++){
                const listNo = contentListResult.response.length-i;
                const checkContentsType = contentListResult.response[i].contentsType;
                let contentsType = "";
                if("H" == checkContentsType){
                    contentsType = "ê±´ê°ì ë³´";
                }else if("W" == checkContentsType){
                    contentsType = "ìë¨ì ë³´";
                }else if("D" == checkContentsType){
                    contentsType = "ì´ëì ë³´";
                }else if("E" == checkContentsType){
                    contentsType = "ê¸°íì ë³´";
                }
                console.log();

                const seq = contentListResult.response[i].seq;
                const title = NSCOMMON.B64.decode(contentListResult.response[i].title);
                const contentNoTag = NSCOMMON.B64.decode(contentListResult.response[i].contentNoTag);
                const viewCount = contentListResult.response[i].viewCount;
                const timeDiff = NSM.timeDiff(contentListResult.response[i].registeredAt);
                const imgSrc = contentListResult.response[i].contentsImage;


                htmlString += '<li class="content-list-item" tag="#ê±´ê°#ë¹ë§#ë³´ê±´ì#ë¬´ë£ê±´ê°ê°ì§#ë¹ë§íì¶">'+
                    '<input type="hidden" class="contentsSeq" value="'+seq+'">'+
                    '<div class="content-info">'+
                    '<div class="content-info-top">'+
                    '<span class="content-label">'+contentsType+'</span>'+
                    '<span class="content-time">'+timeDiff+'</span>'+
                    '</div>'+
                    '<div class="content-info-text">'+
                    '<a class="title">'+title+'</a>'+
                    '<span class="text">'+contentNoTag+'</span>'+
                    '</div>'+
                    '<div class="content-info-tag">'+
                    '<span class="keyword-tag">#ê±´ê°</span>'+
                    '<span class="keyword-tag">#ê²¨ì¸ì² </span>'+
                    '<span class="keyword-tag">#ëì</span>'+
                    '<span class="keyword-tag">#ì´ë¥´ì </span>'+
                    '<span class="keyword-tag">#ìë°©ë²</span>'+
                    '</div>'+
                    '<div class="content-info-bottom">'+
                    '<span class="total-view">ì¡°í <em>'+viewCount+'</em></span>'+
                    '</div>'+
                    '</div>'+
                    '<div class="content-photo">'+
                    '<img src="'+imgSrc+'" class="content-img">'+
                    '</div>'+
                    '</li>';
            }

            $(".total").text(totlaCount+"ê°");

            $(".content-list").html(htmlString);

            $(".content-list-item").off("click");
            $(".content-list-item").on("click", function () {

                const seq = $(this).find(".contentsSeq").val();

                viewDetailContents(seq);
            });
        }

        function fn_makeDetailList(contentListResult, seqIndex){
            let checkContentsType = contentListResult.response[0].contentsType;
            let contentsType = "";
            if("H" == checkContentsType){
                contentsType = "ê±´ê°ì ë³´";
            }else if("W" == checkContentsType){
                contentsType = "ìë¨ì ë³´";
            }else if("D" == checkContentsType){
                contentsType = "ì´ëì ë³´";
            }else if("E" == checkContentsType){
                contentsType = "ê¸°íì ë³´";
            }

            let htmlString = '<li class="content-sub-list-label">\n' +
                '                <span class="content-label">'+contentsType+'</span> ëª©ë¡\n' +
                '            </li>';

            for(let i=0; i<contentListResult.response.length; i++){
                const seq = contentListResult.response[i].seq;
                const title = NSCOMMON.B64.decode(contentListResult.response[i].title);
                const timeDiff = NSM.timeDiff3(contentListResult.response[i].registeredAt);

                let focus = ""
                if(seq == seqIndex){
                    focus = "active";
                }


                htmlString += '<li class="content-sub-list-item" tag="#ê±´ê°#ë¹ë§#ë³´ê±´ì#ë¬´ë£ê±´ê°ê°ì§#ë¹ë§íì¶">'+
                    '<input type="hidden" class="contentsSeq" value="'+seq+'">'+
                    '<a class="'+focus+'">'+title+'</a>'+
                    '<span>'+timeDiff+'</span>'+
                    '</li>';
            }

            $(".content-sub-list").html(htmlString);

            $(".content-sub-list-item").off("click");
            $(".content-sub-list-item").on("click", function () {
                const seq = $(this).find(".contentsSeq").val();
                viewDetailContents(seq);
            });
        }
    </script>
</th:block>

<div class="page-content contents" layout:fragment="content">
    <div class="content-head">
        <div class="content-header">
            <span class="content-title">ì½íì¸  ê´ë¦¬</span>
        </div>
        <ul class="content-sub-header">
            <li>
                <i class="fa-solid fa-house"></i>
                <a href="dashboard">Home</a>
            </li>
            <li class="active">ì½íì¸  ê´ë¦¬</li>
        </ul>
    </div>
    <div class="content-card">
        <div class="card">
            <div class="card-head list">
                <span>ì½íì¸  ëª©ë¡</span>
                <button class="btn btn-circle btn-add">
                    <span>ë±ë¡íê¸°</span>
                    <i class="fa-solid fa-plus"></i>
                </button>
            </div>
            <div class="card-head board-detail hide">
                <span>ì ë³´ ë³´ê¸°</span>
                <button class="btn btn-list-back">
                    <i class="fa-solid fa-arrow-left-long"></i>
                    <span>ëìê°ê¸°</span>
                </button>
            </div>
            <div class="card-body list">
                <div class="card-search-wrap">
                    <span class="total-title">ì ì²´ ê²ìê¸ : <span class="total">3ê°</span></span>
                    <div class="card-search-area">
                        <div class="form-box select-box">
                            <select>
                                <option selected>ì íí´ ì£¼ì¸ì</option>
                                <option>êµ¬ë¶</option>
                                <option>ì ëª©</option>
                                <option>ë´ì©</option>
                                <option>íê·¸</option>
                            </select>
                            <i class="fa-solid fa-chevron-down"></i>
                        </div>
                        <div class="form-box search-box">
                            <input type="text" placeholder="ë°ì´í° ê²ì">
                            <button class="btn-search">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="content-list-group">
                    <ul class="content-list">
                        <!-- ë±ë¡ë²í¼ ëë¥¼ì ëíëë ì»¨íì¸  -->
                        <li class="content-list-item hide" cate="ê±´ê°ì ë³´" title="ê²¨ì¸ì²  ëì âê³ ê´ì âë¡ ì´ì´ì ¸ 20%ë í©ë³ì¦ì ì¬ë§..ìë°©ë²ì" imgSrc="sample_contents_thumbnail.jpeg" tag="#ê±´ê°#ë¹ë§#ë³´ê±´ì#ë¬´ë£ê±´ê°ê°ì§#ë¹ë§íì¶">
                            <div class="content-info">
                                <div class="content-info-top">
                                    <span class="content-label">ê±´ê°ì ë³´</span>
                                    <span class="content-time">ë°©ê¸ì </span>
                                </div>
                                <div class="content-info-text">
                                    <a class="title">ê²¨ì¸ì²  ëì âê³ ê´ì âë¡ ì´ì´ì ¸ 20%ë í©ë³ì¦ì ì¬ë§..ìë°©ë²ì</a>
                                    <span class="text">
                                      ì°ì¼ ë®ì ê¸°ì¨ì ëì´ ë´ë¦¬ë©´ì ì¼ì´ë¶ì ë¹íê¸¸ì ë¸ì¸ë¤ì ëì(è½å·) ìíì´ ëìì§ë¤. ëìì´ë ìì ì ìì§ì ê´ê³ìì´ ê°ìê¸° ëì´ì ¸ ë¼ì ê·¼ì¡ ë±ì ììì ìë ì¬ê³ ë¥¼ ë§íë¤. ì¤ì  65ì¸ ì´ì ë¸ì¸ì 3ë¶ì 1ì´ ë§¤ë í ë² ì´ì ëì´ì§ê³ , ê·¸ì¤ 4ë¶ì 1ì ë³ì ìì ì ì¸ë¥¼ ì§ë¤.
                                      ë¹íê¸¸ì ëêµ¬ìê²ë ìíì ì¸ ììì´ì§ë§ í¹í ë¸ì¸ë¤ì ê·¼ì¡ íëì´ ì¤ì´ë¤ê³  ê´ì ë ì½ê² êµ³ì´ ê· íì ì¡ì§ ëª»í´ ë¹íê¸¸ìì ì½ê² ë¯¸ëë¬ì§ê±°ë ê±¸ë ¤ ëì´ì§ íë¥ ì´ ëë¤.
                                      ëì ì¬ê³ ë¡ ì¸í´ ì²ì¶, ê³ ê´ì  ë±ì ê³¨ì ì´ ë°ìí  ì ìê³  ì´ë í©ë³ì¦ì ì ë°í  ì ìì´ ëì± ì¡°ì¬í´ì¼ íë¤. í¹í, ë¼ì ìì´ ê°ìíê³  ë¼ì ê°ëê° ì½í´ì§ ê³¨ë¤ê³µì¦ íìë ëìì¼ë¡ ì¸í´ ê³¨ì ì´ ì¼ì´ë  ê°ë¥ì±ì´ ë§¤ì° ëì ëìì ì¬ì ì ìë°©íë ê²ì´ ë§¤ì° ì¤ìíë¤.
                                      ëìì¼ë¡ ì¸í´ ë°ìíë ê³¨ì  ì¤ ì²ì¶ ìë°ê³¨ì ì íê²½ê¸° ì¬ì± ì¤ ì½ 25%ìì ê²½íí  ì ëë¡ ííê² ë°ìíë¤. ëí, ê³ ê´ì  ê³¨ì  íìì ì½ 20%ë ê³¨ì ê³¼ ê´ë ¨ë í©ë³ì¦ì¼ë¡ 1ë ë´ ì¬ë§íê³ , 50~60%ë íë³µë íìë ìí ì íê³¼ ë³´íì ì´ë ¤ìì ê²ªì ì ìì¼ë¯ë¡ í¹í ì£¼ìí´ì¼ íë¤.
                                      ëí, ë¸ì¸ìì ëìì¼ë¡ ì¸í ì¬ë§ì í ì°ë ¹ì 10ë°°, ëìì¼ë¡ ì¸í ììë¥ ì í ì°ë ¹ì 8ë°°ì ì¡ë°íë©°, ëìì¼ë¡ ì¸í ì¬ë§ ì´ì¸ìë ì¤ì¦ì ììì¼ë¡ ì¸í´ ì¤ë ììì¼ë¡ ì¸í ë¶í¸ê³¼ ê·¸ íì ì¦ì ìí´ ì¶ì ì§ì´ íì íê² ê°ìíë ë¬¸ì ë¥¼ ì´ëíë¤. ëìì¼ë¡ ë³ìì ì°¾ë ë¸ì¸ì 20-30%ë ëì¶í ëë ìë©ì´ë¼ ê³¨ì ë¡ ê³ ìíë¤. ë¨ì ë¸ì¸ë¤ì ëì¶íì´, ì¬ì ë¸ì¸ë¤ì ê²½ì° ìë©ì´ë¼ ê³¨ì ì´ ë ë§ë¤.
                                  </span>
                                </div>
                                <div class="content-info-tag">
                                    <span class="keyword-tag">#ê±´ê°</span>
                                    <span class="keyword-tag">#ê²¨ì¸ì² </span>
                                    <span class="keyword-tag">#ëì</span>
                                    <span class="keyword-tag">#ì´ë¥´ì </span>
                                    <span class="keyword-tag">#ìë°©ë²</span>
                                </div>
                                <div class="content-info-bottom">
                                    <span class="total-view">ì¡°í <em>202</em></span>
                                </div>
                            </div>
                            <div class="content-photo">
                                <img src="/assets/images/sample/sample_contents_thumbnail.jpeg" class="content-img">
                            </div>
                        </li>

                        <!-- ê±´ê°ì ë³´ -->
                        <li class="content-list-item" cate="ê±´ê°ì ë³´" title="ë¹ë§íì¶~ ë³´ê±´ììì ë¬´ë£ë¡ ê´ë¦¬ë°ì¼ì¸ì!" imgSrc="sample-content-14.jpeg" tag="#ê±´ê°#ë¹ë§#ë³´ê±´ì#ë¬´ë£ê±´ê°ê°ì§#ë¹ë§íì¶">
                          <div class="content-info">
                              <div class="content-info-top">
                                  <span class="content-label">ê±´ê°ì ë³´</span>
                                  <span class="content-time">ë°©ê¸ì </span>
                              </div>
                              <div class="content-info-text">
                                  <a class="title">ë¹ë§íì¶~ ë³´ê±´ììì ë¬´ë£ë¡ ê´ë¦¬ë°ì¼ì¸ì!</a>
                                  <span class="text">
                                      ë§ë³ì ê·¼ìì´ ëë 'ë¹ë§'! ì¸ê³ë³´ê±´ê¸°êµ¬ (WHO)ê° ë¹ë§ì 21ì¸ê¸° ì ì¢ ì ì¼ë³ì¼ë¡ ê·ì íì ì ëì¸ë°ì, ë¯¸êµ­ í ì°êµ¬íì ì¡°ì¬ì ë°ë¥´ë©´ íì¬ ì  ì¸ê³ ì¸êµ¬ì 1/3ì´ ë¹ë§ìíì´ë©°, ì½ 15ë íì¸ 2030ëìë ì ì¸ê³ ì¸êµ¬ì ì ë°ì¸ 32ìµ 8ì²ëªì´ ê³¼ì²´ì¤/ë¹ë§ ìíì ì´ë¥¼ ê²ì´ë¼ í´ì.
                                      ì°ë¦¬ ëë¼ë ì´ë¨ê¹ì? UN ì°íì êµ­ì íë ¥ê¸°êµ¬ GAINì ì¸ê³ìí¥ë¶ê· í ì§ëì ë°ë¥´ë©´ 2015ë ëíë¯¼êµ­ 20ì¸ ì´ì ì±ì¸ ë¨ì±ì 40%, ì±ì¸ ì¬ì±ì 30%ê° ë¹ë§ì´ë¼ê³  í´ì. ë¹ë§ì ìíì ë¶í¸í¨ì ì£¼ê¸°ë íì§ë§, ì ìì¸ì ë¹í´ ë¹ë¨ë³, ê³ íì, ê³ ì§íì¦, ì, ê´ì ì§í ë± ê°ì¢ ì§ë³ì ë°ë³ë¥ ì ëì´ê³  ëìê° ì¬ë§ë¥ ê¹ì§ ì¦ê°ìí¤ê¸°ì ëì± ìííë°ì. ë¹ë§ìì ë²ì´ë ê±´ê°í ëª¸ì ì ì§íê¸° ìí´ ììëë©´ ì ì©í ì ë³´ë¤ì ì ì±ê³µê°ì´ ëª¨ìë´¤ì´ì.
                                  </span>
                              </div>
                              <div class="content-info-tag">
                                  <span class="keyword-tag">#ê±´ê°</span>
                                  <span class="keyword-tag">#ë¹ë§</span>
                                  <span class="keyword-tag">#ë³´ê±´ì</span>
                                  <span class="keyword-tag">#ë¬´ë£ê±´ê°ê²ì§</span>
                                  <span class="keyword-tag">#ë¹ë§íì¶</span>
                              </div>
                              <div class="content-info-bottom">
                                  <span class="total-view">ì¡°í <em>202</em></span>
                              </div>
                          </div>
                          <div class="content-photo">
                              <img src="/assets/images/sample/sample-content-14.jpeg" class="content-img">
                          </div>
                        </li>
                        <!-- ì´ëì ë³´ -->
                        <li class="content-list-item" cate="ì´ëì ë³´" title="ê²¨ì¸ì²  í¬ì¤ì¥ ì´ë³´ì ì´ëìì ê°ë¨ ì ë¦¬" imgSrc="sample-content-17.jpeg" tag="#ê±´ê°#ë¹ë§#ë³´ê±´ì#ë¬´ë£ê±´ê°ê°ì§#ë¹ë§íì¶">
                            <div class="content-info">
                                <div class="content-info-top">
                                    <span class="content-label">ì´ëì ë³´</span>
                                    <span class="content-time">8ìê°ì </span>
                                </div>
                                <div class="content-info-text">
                                    <a class="title">ê²¨ì¸ì²  í¬ì¤ì¥ ì´ë³´ì ì´ëìì ê°ë¨ ì ë¦¬</a>
                                    <span class="text">
                                        í¬ì¤ë ê·¼ë ¥ í¥ìì ìí´ì ì¨ì´í¸ë¥¼ í´ììëë°, ì´ì ë ëª¸ì ì¡°ê°íê¸° ìí´ì í¬ì¤ë¥¼ íê³  ìë¤. ê¸°ì¡´ì ì´ëì ì¢ íë? ë°°ì ë ì¬ëë¤ì ê¸°ë³¸ì ì¼ë¡ ê¸°êµ¬ ì´ì© ë°©ë²ì´ë ë£¨í´ì ìê³  ìê¸° ëë¬¸ì í¬ê² ë¬¸ì ê° ìì§ë§, ì´ë³´ì ìì¥ììë í¬ì¤ì¥ì ë¤ì´ê°ë©´ ë­ë¶í° ììí´ì¼ í ì§ ë§ë§í  ë°ë¦ì¼ ê±°ë¤.
                                        ê·¸ëì ì¤ëì ì´ë³´ìê° í¬ì¤ì¥ìì ë§ë§íì§ ìëë¡ ê°ì¥ ë³´í¸ì ì¸ ì´ë ììë¥¼ ì ì´ë³´ë ¤ê³  íë¤. ë¹ì°í ì ëµì ìëê³  íìê° ì´ë°ì ì´ì©íë ë°©ë²ì´ê³ , ê²½íì ê´ì°®ë¤ê³  ìê°íë ì´ë ììë¥¼ ìê°íë¤. ì´ë³´ìê° í¬ì¤ì¥ìì ì´ëíë ìì 1.ì¤í¸ë ì¹­ ì¼ë¨ ì²ìì´ ê°ì¥ ì¤ìíë¤. ë°°íë íë¡ ì ìë¤ì¡°ì°¨ë ì´ëì ììíê¸° ì ì ì¤í¸ë ì¹­ì íìë¤.
                                    </span>
                                </div>
                                <div class="content-info-tag">
                                    <span class="keyword-tag">#ê±´ê°</span>
                                    <span class="keyword-tag">#ì´ë</span>
                                    <span class="keyword-tag">#ìë¨</span>
                                    <span class="keyword-tag">#ê±·ê¸°</span>
                                    <span class="keyword-tag">#ë§ì¤ì²ë³´ê±·ê¸°</span>
                                </div>
                                <div class="content-info-bottom">
                                    <span class="total-view">ì¡°í <em>202</em></span>
                                </div>
                            </div>
                            <div class="content-photo">
                                <img src="/assets/images/sample/sample-content-17.jpeg" class="content-img">
                            </div>
                        </li>
                        <!-- ìë¨ì ë³´ -->
                        <li class="content-list-item" cate="ìë¨ì ë³´" title="ê±´ê°ìì¼ë¡ ë ì¤ë¥¸ 'ë¶ì ë½ ìë¨' ì´ë»ê² ë¨¹ìê¹?" imgSrc="sample-content-46.jpeg" tag="#ê±´ê°#ë¹ë§#ë³´ê±´ì#ë¬´ë£ê±´ê°ê°ì§#ë¹ë§íì¶">
                            <div class="content-info">
                                <div class="content-info-top">
                                    <span class="content-label">ìë¨ì ë³´</span>
                                    <span class="content-time">2022.12.22</span>
                                </div>
                                <div class="content-info-text">
                                    <a class="title">ê±´ê°ìì¼ë¡ ë ì¤ë¥¸ 'ë¶ì ë½ ìë¨' ì´ë»ê² ë¨¹ìê¹?</a>
                                    <span class="text">
                                      ì­ì¬ê¹ì ìë¨ê³¼ íëì ì¬êµ¬ì±í ìë¨ ëê²° ì¡ìë³´ë¤ ì±ìê³¼ ìì°ìí ìì£¼ ë¹ì·íì§ë§ ì§ì¤í´ìì ì¡ì ì±ì, ë¶ì ë½ì í´ì¡°ë¥ ìì£¼ ì°ë¹ì´ë ë­ê¹? âì°¸ì´ì´âë¡ ë²ì­íê¸°ë íë ì´ ë§ì ë¬¸ì ê·¸ëë¡ íì´íìë©´ âì ì§ë¸ë¤âë ë»ì´ë¤.
                                      ë¶ì ë½ì ëì ì¶ì ì§ì ë»íë ì°ë¹ì ê°ì¥ ê·¼ì í ì§ì­ì¼ë¡ ê¼½íë¤. ë¶ì ë½ì ì ìì´ í´ë§ë¤ ë°ííë ì¸ê³íë³µë³´ê³ ììì ìµììê¶ì ì¹ì¸ì´íë¤ìí¼ íë¤. ì¶ì ë§ì¡±ëê° ëì ì ë½ì¸ë¤ì ì°ë¹ ìíë¬¸íë¥¼ ë°°ì°ìë ì´ëì´ ì¸ê³ ê°ì§ìì ì¼ì´ë  ì ëìë¤. ì´ ê³¼ì ìì ìë°í ìë½ì ì¶êµ¬íë ë´ë§í¬ì âíê²â, ë§ì§ë ì ì§ë ìì ê±¸ ë»íë ì¤ì¨ë´ì âë¼ê³°â, ì ì ì ìë¶ì§ì¡±ì ìíì¤ë¦¬ë¥¼ ë´ì âìíì ë²ì¹â ë±ì´ ë¶ì ë½ì ì°ë¹ì ì§í±í´ì£¼ë ë¹ê²°ë¡ êµ­ì ì¬íì ì£¼ëª©ì ë°ìë¤.
                                  </span>
                                </div>
                                <div class="content-info-tag">
                                    <span class="keyword-tag">#ê±´ê°</span>
                                    <span class="keyword-tag">#ì´ë</span>
                                    <span class="keyword-tag">#ìë¨</span>
                                    <span class="keyword-tag">#ê±·ê¸°</span>
                                    <span class="keyword-tag">#ë§ì¤ì²ë³´ê±·ê¸°</span>
                                </div>
                                <div class="content-info-bottom">
                                    <span class="total-view">ì¡°í <em>202</em></span>
                                </div>
                            </div>
                            <div class="content-photo">
                                <img src="/assets/images/sample/sample-content-46.jpeg" alt="content-img">
                            </div>
                        </li>
                    </ul>
                    <div class="page">
                        <ul class="pagination">
                            <li>
                                <button class="first-page">
                                    ì²ì íì´ì§
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
                                    ë§ì§ë§ íì´ì§
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="card-body board-detail hide">
                <div class="content-detail-wrap">
                    <div class="content-detail">
                        <div class="content-detail-top">
                            <div class="content-detail-title">
                                <span class="content-label">ê±´ê°ì ë³´</span>
                                <span class="title">ê±´ê°ì ì¢ì ê±·ê¸°, ê±´ê°íê² ê±·ë ë°©ë², ìíì ì§íë¥¼ ììë³´ì!</span>
                                <div class="content-info-tag">
                                    <span class="keyword-tag">#ê±´ê°</span>
                                    <span class="keyword-tag">#ì´ë</span>
                                    <span class="keyword-tag">#ìë¨</span>
                                    <span class="keyword-tag">#ê±·ê¸°</span>
                                    <span class="keyword-tag">#ë§ì¤ì²ë³´ê±·ê¸°</span>
                                </div>
                            </div>
                            <div class="content-detail-info">
                                <div class="content-detail-info-left">
                                    <span class="name"></span>
                                    <span class="time">2022.05.05</span>
                                </div>
                                <div class="content-detail-info-right">
                                    <span class="total-view">ì¡°í<em id="viewCount">12,300</em></span>
                                    <button class="btn-mobile-view" onclick="viewMobileContent()">
                                        <i class="fa-solid fa-mobile-screen-button"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="content-detail-text">
                            <div class="sample">

                            </div>
                        </div>
                        <div class="content-detail-bottom">
                                <button class="content-modify">
                                    <i class="fa-solid fa-pencil"></i>
                                    ìì 
                                </button>
                                <button class="content-delete">
                                    <i class="fa-solid fa-trash-can"></i>
                                    ì­ì 
                                </button>
                        </div>
                    </div>
                    <div class="content-sub-list-wrap">
                        <ul class="content-sub-list">

                        </ul>
                    </div>
                    <div class="detail-page">
                        <ul class="detail-pagination">
                            <li class="prev">
                                <a><i class="fa-solid fa-angle-left"></i> ì´ì </a>
                            </li>
                            <li class="next">
                                <a>ë¤ì <i class="fa-solid fa-angle-right"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="html-part" style="display: none;" layout:fragment="html-part">
    <div class="tag-wrap">
        <span class="keyword-tag">#ê±´ê°</span>
        <i class="fa-solid fa-x tag-delete"></i>
    </div>
</div>
</html>