<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout">

<div class="side-panel left fixed ns-scrollbar">
    <ul class="left-main-menu">
        <li class="user-info-box" onclick="location.href ='profile'">
            <div class="user-info">
                <div class="user-picture-wrap">
                    <div class="user-picture">
                        <img src="/assets/images/sample/sample-user-pic.jpeg">
                    </div>
                </div>
                <div class="user-details">
                    <span class="user-name">Dr. Joon Wan Kim</span>
                    <span class="user-role">Administrator</span>
                </div>
            </div>
        </li>
        <li class="menu-item" id="dashboard">
            <a class="menu-link" href="dashboard">
                <div class="menu-title-wrap">
                    <i class="menu-icon fa-solid fa-desktop"></i>
                    <span class="menu-title">Dashboard</span>
                </div>
            </a>
        </li>
        <li class="menu-item" id="patient">
            <a class="menu-link" href="patient">
                <div class="menu-title-wrap">
                    <i class="menu-icon fa-solid fa-hospital-user"></i>
                    <span class="menu-title">íì ê´ë¦¬</span>
                </div>
            </a>
        </li>
        <li class="menu-item" id="contents">
            <a class="menu-link" href="contents">
                <div class="menu-title-wrap">
                    <i class="menu-icon fa-solid fa-file-lines"></i>
                    <span class="menu-title">ì½íì¸  ê´ë¦¬</span>
                </div>
            </a>
        </li>
        <li class="menu-item menu-toggle" id="statistics">
            <a class="menu-link" href="statistics">
                <div class="menu-title-wrap">
                    <i class="menu-icon fa-solid fa-chart-line"></i>
                    <span class="menu-title">íµê³</span>
                </div>
                <i class="menu-arrow fa-solid fa-angle-left menu-arrow-left"></i>
            </a>
            <ul class="sub-menu-wrap">
                <li class="sub-menu-item">
                    <a class="menu-link" href="statistics">
                        <span class="menu-title">íµê³</span>
                    </a>
                </li>
                <li class="sub-menu-item">
                    <a class="menu-link" href="#">
                        <span class="menu-title">#íì¤í¸ ë©ë´</span>
                    </a>
                </li>
                <li class="sub-menu-item">
                    <a class="menu-link" href="#">
                        <span class="menu-title">#íì¤í¸ ë©ë´</span>
                    </a>
                </li>
            </ul>
        </li>
        <li class="menu-item menu-toggle" id="manage">
            <a class="menu-link" href="admin-manage">
                <div class="menu-title-wrap">
                    <i class="menu-icon fa-solid fa-gear"></i>
                    <span class="menu-title">DTx ê´ë¦¬</span>
                </div>
                <i class="menu-arrow fa-solid fa-angle-left menu-arrow-left"></i>
            </a>
            <ul class="sub-menu-wrap">
                <li class="sub-menu-item">
                    <a class="menu-link" href="admin-manage">
                        <span class="menu-title">ê´ë¦¬ì ê´ë¦¬</span>
                    </a>
                </li>
                <li class="sub-menu-item">
                    <a class="menu-link" href="data-manage">
                        <span class="menu-title">ë°ì´í° ê´ë¦¬</span>
                    </a>
                </li>
                <li class="sub-menu-item">
                    <a class="menu-link" href="push-manage">
                        <span class="menu-title">í¸ì ê´ë¦¬</span>
                    </a>
                </li>
                <li class="sub-menu-item">
                    <a class="menu-link" href="survey-manage">
                        <span class="menu-title">ì¤ë¬¸ ê´ë¦¬</span>
                    </a>
                </li>
            </ul>
        </li>
    </ul>
</div>


<script type="text/javascript" th:inline="javascript">

    function onFrontScriptReady() {
        console.log("front script ready...");

        $(".user-info-box").off("click");
        $(".user-info-box").on("click", function () {
            location.href = "/page/profile" ;
        });
    }

</script>

</html>