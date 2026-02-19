<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout">

<div id="app-dialog-part" style="display: none;" th:fragment="baseDialogPartFragment">
    <div class="dialog-main app-confirm">
        <div class="dialog-header">
            <h2>íì¸</h2>
            <i class="wooriga-icon frog"></i>
        </div>
        <div class="dialog-content neoul-scrollbar">
            <span class="dialog-message"></span>
        </div>
        <div class="dialog-action">
            <button class="btn-ripple btn-secondary">
                <span class="btn-label">ì·¨ì</span>
            </button>
            <button class="btn-ripple btn-primary">
                <span class="btn-label">íì¸</span>
            </button>
        </div>
    </div>
    <div class="dialog-main app-alert">
        <div class="dialog-header">
            <h2>ìë´</h2>
            <i class="wooriga-icon frog"></i>
        </div>
        <div class="dialog-content neoul-scrollbar">
            <span class="dialog-message"></span>
        </div>
        <div class="dialog-action">
            <button class="btn-ripple btn-primary">
                <span class="btn-label">íì¸</span>
            </button>
        </div>
    </div>
    <div class="dialog-main date-picker">
        <div class="dialog-content neoul-scrollbar">
            <div class="picker-nav-wrap">
                <ul class="picker-nav">
                    <li class="picker-item date">
                        ë ì§
                        <span class="picker-active"></span>
                    </li>
                    <li class="picker-item time">
                        ìê°
                        <span class="picker-active"></span>
                    </li>
                </ul>
            </div>
            <div class="picker-selected">
                <div class="selected-section date hide">
                    <span class="date-item year"><em></em><em>ë</em></span>
                    <span class="date-item month" style="margin-left: 8px;"><em></em><em>ì</em></span>
                    <span class="date-item day" style="margin-left: 8px;"><em></em><em>ì¼</em></span>
                </div>
                <div class="selected-section time hide">
                    <span class="time-item ampm"><em></em><em></em></span>
                    <span class="time-item hour" style="margin-left: 15px;"><em></em><em></em></span>
                    <span class="time-item delim" style="margin: 0px 8px;"><em>:</em><em></em></span>
                    <span class="time-item minute"><em></em><em></em></span>
                </div>
            </div>
            <div class="picker-content date year">
                <ul class="picker-year"></ul>
            </div>
            <div class="picker-content date month">
                <ul class="picker-month"></ul>
            </div>
            <div class="picker-content date day neoul-scrollbar">
                <ul class="picker-day"></ul>
            </div>
            <div class="picker-content time hour">
                <div style="width: 240px; height: 240px; margin-top: 20px; position: absolute; left: 50%; transform: translateX(-50%);">
                    <div style="width: 100%; height: 100%; position: relative;">
                        <div class="clock-overlay">
                            <div style="position:relative; width: 100%; height: 100%;">
                                <span class="center-dot"></span>
                                <span class="selected"></span>
                                <span class="choice-line"></span>
                            </div>
                        </div>
                        <ul class="picker-hour"></ul>
                    </div>
                </div>
                <span class="picker-ampm am">ì¤ì </span>
                <span class="picker-ampm pm">ì¤í</span>
            </div>
            <div class="picker-content time minute">
                <div style="width: 240px; height: 240px; margin-top: 20px; position: absolute; left: 50%; transform: translateX(-50%);">
                    <div style="width: 100%; height: 100%; position: relative;">
                        <div class="clock-overlay">
                            <div style="position:relative; width: 100%; height: 100%;">
                                <span class="center-dot"></span>
                                <span class="selected"></span>
                                <span class="choice-line"></span>
                            </div>
                        </div>
                        <ul class="picker-minute"></ul>
                    </div>
                </div>
                <span class="picker-ampm am">ì¤ì </span>
                <span class="picker-ampm pm">ì¤í</span>
            </div>
        </div>
        <div class="dialog-action">
            <button class="btn-ripple btn-secondary">
                <span class="btn-label">ì·¨ì</span>
            </button>
            <button class="btn-ripple btn-primary">
                <span class="btn-label">íì¸</span>
            </button>
        </div>
    </div>
</div>

</html>