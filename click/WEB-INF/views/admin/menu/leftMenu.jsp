<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="main-menu-content">
            <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
				<li id="home" class=" nav-item"><a href="${pageContext.request.contextPath}/voomerangSetting.do"><i class="feather icon-home"></i><span class="menu-title" data-i18n="HOME">HOME</span><span class="badge badge badge-primary badge-pill float-right mr-2">3</span></a>
                </li>
				<li id="returnProduct" class=" nav-item"><a href="${pageContext.request.contextPath}/returnProductList.do"><i class="feather icon-package"></i><span class="menu-title" data-i18n="반품관리">반품관리</span></a>
                </li>
				<li id="product" class=" nav-item"><a href="${pageContext.request.contextPath}/siteList.do"><i class="fa fa-chevron-down"></i><span class="menu-title" data-i18n="부메랑관리">부메랑관리</span></a>
                </li>
				<li class=" nav-item"><a href="${pageContext.request.contextPath}/autoReturnSetting.do"><i class="feather icon-settings"></i><span class="menu-title" data-i18n="설정">설정</span></a>
					<ul class="menu-content">
                        <li id="autoReturnSetting"><a class="menu-item" href="${pageContext.request.contextPath}/autoReturnSetting.do" data-i18n="eCommerce">반품 자동 설정</a>
                        </li>
                        <li id="voomerangSetting"><a class="menu-item" href="${pageContext.request.contextPath}/voomerangSetting.do" data-i18n="Analytics">부메랑 설정</a>
						</li>
                    </ul>
                </li>
            </ul>
			<ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
				<li class=" nav-item"><a href="index.html"><i class="feather icon-user"></i><span class="menu-title" data-i18n="HOME">나의 계정</span></a>
					<ul class="menu-content">
                        <li id="mypage"><a class="menu-item" href="${pageContext.request.contextPath}/mypage.do" data-i18n="eCommerce">내정보</a>
                        </li>
                        <li id="inquiry"><a class="menu-item" href="${pageContext.request.contextPath}/inquiry.do" data-i18n="Analytics">문의</a>
						</li>
						<li id="faq"><a class="menu-item" href="${pageContext.request.contextPath}/faq.do" data-i18n="Analytics">FAQ</a>
                        </li>
                        <li id="notice"><a class="menu-item" href="${pageContext.request.contextPath}/noticeList.do" data-i18n="Fitness">공지사항</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>