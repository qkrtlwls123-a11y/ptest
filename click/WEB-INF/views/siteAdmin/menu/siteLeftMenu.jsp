<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<aside>
            <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
            	<li class=" navigation-header"><span>Dashboard</span><i class=" feather icon-minus" data-toggle="tooltip" data-placement="right" data-original-title="Dashboard"></i>
                </li>
				<li id="Dashboard" class=" nav-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/siteMain.do"><i class="feather icon-home"></i><span class="menu-title" data-i18n="HOME">Dashboard</span></a>
				<li class=" navigation-header"><span>기본정보</span><i class=" feather icon-minus" data-toggle="tooltip" data-placement="right" data-original-title="기본정보"></i>
                </li>
				<li id="site" class=" nav-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/siteInfo.do"><i class="feather icon-airplay"></i><span class="menu-title" data-i18n="HOME">사이트 설정</span></a>
                </li>
				<li id="admin" class=" nav-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/siteAdminList.do"><i class="feather icon-user"></i></i><span class="menu-title" data-i18n="관리자 설정">관리자 설정</span></a>
                </li>
                <li id="noticeList" class=" nav-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/noticeList.do"><i class="feather icon-airplay"></i><span class="menu-title" data-i18n="HOME">공지사항 관리</span></a>
                </li>
                <li class=" navigation-header"><span>사용자 정보</span><i class=" feather icon-minus" data-toggle="tooltip" data-placement="right" data-original-title="사용자 정보"></i>
                </li>
                <li id="user" class=" nav-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/siteMemberList.do"><i class="feather icon-users"></i></i><span class="menu-title" data-i18n="사용자 목록">사용자 목록</span></a>
                </li>
                <li id="ranking" class=" nav-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/communityList.do"><i class="feather icon-target"></i><span class="menu-title" data-i18n="콘텐츠 DB">게이미피케이션</span></a>
                	<ul class="menu-content">
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/site/${siteVO.site_name}/communityList.do" data-i18n="의견 관리">의견 관리</a>
                        </li>
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/site/${siteVO.site_name}/rankingList.do" data-i18n="랭킹 관리">랭킹 관리</a>
						</li>
                    </ul>
                </li>
                <li class=" navigation-header"><span>콘텐츠 정보</span><i class=" feather icon-minus" data-toggle="tooltip" data-placement="right" data-original-title="콘텐츠 정보"></i>
                </li>
                <li id="property" class=" nav-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/propertyList.do"><i class="feather icon-target"></i><span class="menu-title" data-i18n="콘텐츠 DB">속성/그룹 관리</span></a>
                	<ul class="menu-content">
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/site/${siteVO.site_name}/propertyList.do" data-i18n="속성 관리">속성 관리</a>
                        </li>
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/site/${siteVO.site_name}/groupList.do" data-i18n="그룹 관리">그룹 관리</a>
						</li>
                    </ul>
                </li>
                <li id="contentsList" class=" nav-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/contentsList.do"><i class="feather icon-file-text"></i><span class="menu-title" data-i18n="콘텐츠 DB">콘텐츠 DB</span></a>
					<ul class="menu-content">
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/site/${siteVO.site_name}/contentsList.do" data-i18n="공용 콘텐츠">공용 콘텐츠</a>
                        </li>
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/site/${siteVO.site_name}/siteContentsList.do" data-i18n="고객사 콘텐츠">고객사 콘텐츠</a>
						</li>
                    </ul>
                </li>
                <li id="stamp" class=" nav-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/stampList.do"><i class="feather icon-award"></i><span class="menu-title" data-i18n="설정">스탬프/스티커 관리</span></a>
					<ul class="menu-content">
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/site/${siteVO.site_name}/stampList.do" data-i18n="스탬프 관리">스탬프 관리</a>
                        </li>
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/site/${siteVO.site_name}/stickerList.do" data-i18n="스티커 관리">스티커 관리</a>
						</li>
                    </ul>
                </li>
                <li id="courseList" class="nav-item"><a href="${pageContext.request.contextPath}/site/${siteVO.site_name}/courseList.do"><i class="feather icon-clipboard"></i><span class="menu-title" data-i18n="코스">코스 관리</span></a>
                </li>
            </ul>
        </aside>
