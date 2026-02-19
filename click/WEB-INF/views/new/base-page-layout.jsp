<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout">

<head th:fragment="configFragment">
    <meta charset="utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <meta name="format-detection" content="telephone=no"/>

    <title>ONION BOX</title>

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

    <script src="https://cdn.tiny.cloud/1/u4pcrmqd8aeiio1e0l11nsaa0ykf974oprfp5xiglof2tige/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>

    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
    <script type="text/javascript"
            src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/neoulsoft/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/neoulsoft/dtx.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>

    <!-- user define css -->
    <th:block layout:fragment="css"></th:block>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/neoulsoft/jquery.number.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/neoulsoft/jquery.base64.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/neoulsoft/config.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/neoulsoft/common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/neoulsoft/neoulsoft-mobile.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/neoulsoft/dtx.js"></script>

    <!-- user define javascripts -->
    <th:block layout:fragment="script"></th:block>

    <script type="text/javascript">
        var skipAuthentication = false;
        var defaultFontSize = "font-normal";

        var pendingScriptMap = {};

        function checkFrontScriptCallback() {
            if (typeof onFrontScriptReady !== "undefined") {
                if (NSCOMMON.isScriptReady() == false) {
                    setTimeout(checkFrontScriptCallback, 100);
                    return;
                }

                NSCONFIG.defaultFontSize = DTX.getSetting("font-size", "font-normal");
                $(document.body).addClass(NSCONFIG.defaultFontSize);

                $(window).on("resize", function (e) {
                    if (typeof onWindowResized !== "undefined")
                        onWindowResized($(window).width());
                });

                NSM.initClickOutside();

                if ($(".wrap")) {
                    $(".wrap").css({"position": "", "left": "0px"});
                    $(".wrap").addClass("after-onload");
                }

                var pathNameStr = location.pathname;
                console.log("!!!!!!!!!!!!!!!!!!!!"+pathNameStr)
                var pathName =  "#" + pathNameStr.replace("/page/","");

                if(pathName === "#admin-manage" || pathName === "#statistics"){
                    if(pathName === "#admin-manage"){
                        pathName = "#manage";
                    }
                    $(".menu-item" + pathName).addClass("open")
                    $(".menu-item" + pathName + " > .sub-menu-wrap li").eq(0).addClass("active");
                }else{
                    $(".menu-item" + pathName).addClass("active");
                }
                console.log("skipAuthentication");
                if (skipAuthentication == false) {
                    NSCOMMON.accessInitialize(onFrontScriptReady);
                }
                else {
                    onFrontScriptReady();
                }

            } else {
                setTimeout(checkFrontScriptCallback, 100);
            }
        }

        function runPendingScripts() {
            if (pendingScriptMap == null || Object.keys(pendingScriptMap).length == 0)
                return;

            var scriptKeys = Object.keys(pendingScriptMap);
            for (var i = 0; i < scriptKeys.length; i++) {
                if (typeof pendingScriptMap[scriptKeys[i]] !== "undefined") {
                    console.log("[PENDING] call " + scriptKeys[i] + "();");
                    pendingScriptMap[scriptKeys[i]]();
                }
                delete pendingScriptMap[scriptKeys[i]];
            }
        }

        $(document).ready(function () {
            if (typeof setSkipAuthentication === "function")
                NSCONFIG.skipAuthentication = setSkipAuthentication();
            checkFrontScriptCallback();

        });
    </script>
</head>


<body class="service-page">

<div class="page-container">
    <div class="page-area">
        <c:import url="/page-header.do"/>

        <div class="content-wrap">
        	<c:import url="/page-left.do"/>
            <div class="page-content-wrap ns-scrollbar">
                <div class="page-content" layout:fragment="content"></div>

                <c:import url="/page-footer.do"/>
            </div>

        </div>

        <div id="dialog-part" style="display: none;" layout:fragment="dialog-part"></div>
        <div id="sub-page-part" style="display: none;" layout:fragment="sub-page-part"></div>
        <div id="side-panel-part" style="display: none;" th:replace="/common/fragments/side-panel-part :: sidePanelPartFragment"></div>
        <div id="html-part" style="display: none;" layout:fragment="html-part"></div>
    </div>

    <div id="dialog-wrap" ></div>

    <div id="sub-page-area" class="hide"></div>

    <div id="side-panel-area" class="hide">
        <div class="side-panel-dim"></div>
        <div class="side-panel-content left"></div>
        <div class="side-panel-content right"></div>
        <div class="side-panel-content bottom"></div>
    </div>

    <div class="attach-hidden-box">
        <form id="uploadForm" name="uploadForm" method="post" enctype="multipart/form-data">
            <input type="file" id="attach" name="attach"/>
        </form>
    </div>

    <div id="app-dialog-part" style="display: none;"
         th:replace="/common/fragments/base-dialog-part :: baseDialogPartFragment"></div>
</div>

</body>

</html>
