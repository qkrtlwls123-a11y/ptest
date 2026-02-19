<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
:root {
		  --main-bg-color: rgba(64, 78, 103, 1);
		  --sub-bg-color: rgba(241, 245, 249, 1);
		  --sub-hover-color: rgba(241, 245, 249, 0.3);
		  --sub-bg-area-color: rgba(56, 68, 90, 1);
	}
</style>
<nav class="header-navbar navbar-expand-lg navbar navbar-with-menu fixed-top navbar-semi-dark navbar-shadow">
        <div class="navbar-wrapper">
            <div class="navbar-header">
                <ul class="nav navbar-nav flex-row">
                    <li class="nav-item mobile-menu d-md-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="feather icon-menu font-large-1"></i></a></li>
                    <li class="nav-item"><a class="navbar-brand" href="${pageContext.request.contextPath}/siteList.do">
						<!--<img class="brand-logo" alt="stack admin logo" src="${pageContext.request.contextPath}/resources/app-assets/images/logo/stack-logo.png">-->
                            <h2 class="brand-text">ONION BOX</h2>
                        </a></li>
                    <li class="nav-item d-md-none"><a class="nav-link open-navbar-container" data-toggle="collapse" data-target="#navbar-mobile"><i class="fa fa-ellipsis-v"></i></a></li>
                </ul>
            </div>
            <div class="navbar-container content">
                <div class="collapse navbar-collapse" id="navbar-mobile">
                    <ul class="nav navbar-nav mr-auto float-left">
                        <li class="nav-item d-none d-md-block"><a class="nav-link nav-link-expand" href="#"><i class="ficon feather icon-maximize"></i></a></li>
                    </ul>
                    <ul class="nav navbar-nav float-right">
                        
                        <%-- <li class="dropdown dropdown-notification nav-item"><a class="nav-link nav-link-label" href="#" data-toggle="dropdown"><i class="ficon feather icon-bell"></i><span class="badge badge-pill badge-danger badge-up">1</span></a>
                            <ul class="dropdown-menu dropdown-menu-media dropdown-menu-right">
                                <li class="dropdown-menu-header">
                                    <h6 class="dropdown-header m-0"><span class="grey darken-2">공지사항</span><span class="notification-tag badge badge-danger float-right m-0">1 New</span></h6>
                                </li>
                                <li class="scrollable-container media-list"><a href="${pageContext.request.contextPath}/noticeList.do">
                                        <div class="media">
                                            <div class="media-left align-self-center"><i class="feather icon-plus-square icon-bg-circle bg-cyan"></i></div>
                                            <div class="media-body">
                                                <h6 class="media-heading">공지사항 TEST1</h6>
                                                <p class="notification-text font-small-3 text-muted">공지사항 TEST1</p><small>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </li> --%>
                        <li class="dropdown dropdown-user nav-item"><a class="dropdown-toggle nav-link dropdown-user-link" href="#" data-toggle="dropdown">
                                <div class="avatar avatar-online"></div><span class="user-name">${loginVO.admin_name}</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right"><a class="dropdown-item" href="${pageContext.request.contextPath}/logOut.do"><i class="feather icon-power"></i> 로그아웃</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
