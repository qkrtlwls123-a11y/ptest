<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
:root {
		  --main-bg-color: ${siteVO.site_color};
		  --sub-bg-color: ${siteVO.site_color2};
		  --sub-hover-color: ${siteVO.site_color3};
		  --sub-bg-area-color: ${siteVO.site_color4};
	}
</style>

<nav class="header-navbar navbar-expand-lg navbar navbar-with-menu fixed-top navbar-semi-dark navbar-shadow">
        <div class="navbar-wrapper">
            <div class="navbar-header">
                <ul class="nav navbar-nav flex-row">
                    <li class="nav-item mobile-menu d-md-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="feather icon-menu font-large-1"></i></a></li>
                    <li class="nav-item"><a class="navbar-brand" href="${pageContext.request.contextPath}/site/${siteVO.site_name}/siteMain.do">
						<!--<img class="brand-logo" alt="stack admin logo" src="${pageContext.request.contextPath}/resources/app-assets/images/logo/stack-logo.png">-->
                            <h2 class="brand-text"><c:if test="${siteVO.site_logo != null && siteVO.site_logo != ''}"><img style="height:35px;max-width:200px;" src="http://ptest.co.kr/click/file/down/${siteVO.site_logo}" alt="branding logo"></c:if></h2>
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
                        
                        <li class="dropdown dropdown-user nav-item"><a class="dropdown-toggle nav-link dropdown-user-link" href="#" data-toggle="dropdown">
                                <div class="avatar avatar-online"></div><span class="user-name">${loginVO.admin_name}</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right"><a class="dropdown-item" href="${pageContext.request.contextPath}/siteLogOut.do"><i class="feather icon-power"></i> 로그아웃</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
