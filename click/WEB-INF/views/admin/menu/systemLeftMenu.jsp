<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<aside>
	  <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
				<li id="site" class="nav-item"><a href="${pageContext.request.contextPath}/siteList.do"><i class="feather icon-home"></i><span class="menu-title" data-i18n="HOME">사이트 개설/관리</span></a>
                </li>
				<li id="admin" class="nav-item"><a href="${pageContext.request.contextPath}/adminList.do"><i class="feather icon-settings"></i><span class="menu-title" data-i18n="관리자 설정">관리자 설정</span></a>
					<ul class="menu-content">
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/adminList.do" data-i18n="관리자 목록">관리자 목록</a>
                        </li>
                    </ul>
                </li>
                <li id="property" class="nav-item"><a href="${pageContext.request.contextPath}/propertyList.do"><i class="feather icon-target"></i><span class="menu-title" data-i18n="콘텐츠 DB">속성/그룹 관리</span></a>
                	<ul class="menu-content">
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/propertyList.do" data-i18n="속성 관리">속성 관리</a>
                        </li>
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/groupList.do" data-i18n="그룹 관리">그룹 관리</a>
						</li>
                    </ul>
                </li>
                <li><p></p></li>
				<li id="contentsList" class="nav-item"><a href="${pageContext.request.contextPath}/contentsList.do"><i class="feather icon-file-text"></i><span class="menu-title" data-i18n="콘텐츠 DB">콘텐츠 DB</span></a>
					<ul class="menu-content">
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/contentsList.do" data-i18n="공용 콘텐츠">공용 콘텐츠</a>
                        </li>
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/siteContentsList.do" data-i18n="고객사 콘텐츠">고객사 콘텐츠</a>
						</li>
                    </ul>
                </li>
				<li id="stamp" class="nav-item"><a href="${pageContext.request.contextPath}/stampList.do"><i class="feather icon-award"></i><span class="menu-title" data-i18n="설정">스탬프/스티커 관리</span></a>
					<ul class="menu-content">
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/stampList.do" data-i18n="스탬프 관리">스탬프 관리</a>
                        </li>
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/stickerList.do" data-i18n="스티커 관리">스티커 관리</a>
						</li>
                    </ul>
                </li>
                <li id="game" class="nav-item"><a href="${pageContext.request.contextPath}/gameList.do"><i class="icon-game-controller"></i><span class="menu-title" data-i18n="게임">게임 관리</span></a>
					<ul class="menu-content">
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/gameList.do" data-i18n="룰렛 관리">룰렛 관리</a>
                        </li>
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/quizList.do" data-i18n="퀴즈 관리">퀴즈 관리</a>
                        </li>
                    </ul>
                </li>
                <li id="emoticon" class="nav-item"><a href="${pageContext.request.contextPath}/emoticonList.do"><i class="feather icon-eye"></i><span class="menu-title" data-i18n="이모티콘">이모티콘 관리</span></a>
					<ul class="menu-content">
                        <li><a class="menu-item" href="${pageContext.request.contextPath}/emoticonList.do" data-i18n="룰렛 관리">이모티콘 관리</a>
                        </li>
                    </ul>
                </li>
                <li><p></p></li>
                <li id="noticeList" class="nav-item"><a href="${pageContext.request.contextPath}/noticeList.do"><i class="feather icon-volume-1"></i><span class="menu-title" data-i18n="공지사항">공지사항 관리</span></a>
                </li>
                <li id="surveyList" class="nav-item"><a href="${pageContext.request.contextPath}/surveyList.do"><i class="feather icon-book"></i><span class="menu-title" data-i18n="진단">진단/설문 관리</span></a>
                </li>
                <li id="courseList" class="nav-item"><a href="${pageContext.request.contextPath}/courseList.do"><i class="feather icon-clipboard"></i><span class="menu-title" data-i18n="코스">코스 관리</span></a>
                </li>
            </ul>
	</aside>

	
<%-- <div class="main-menu-content">
            <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
				<li id="site" class="nav-item"><a href="${pageContext.request.contextPath}/siteList.do"><i class="feather icon-home"></i><span class="menu-title" data-i18n="HOME">사이트 개설/관리</span><span class="badge badge badge-primary badge-pill float-right mr-2">3</span></a>
                </li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/adminList.do"><i class="feather icon-settings"></i></i><span class="menu-title" data-i18n="관리자 설정">관리자 설정</span></a>
					<ul class="menu-content">
                        <li id="admin"><a class="menu-item" href="${pageContext.request.contextPath}/adminList.do" data-i18n="관리자 목록">관리자 목록</a>
                        </li>
                        <li id="mail"><a class="menu-item" href="${pageContext.request.contextPath}/mailList.do" data-i18n="초대 메일 발송">초대 메일 발송</a>
						</li>
                    </ul>
                </li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/propertyList.do"><i class="feather icon-target"></i><span class="menu-title" data-i18n="콘텐츠 DB">속성/그룹 관리</span></a>
                	<ul class="menu-content">
                        <li id="property"><a class="menu-item" href="${pageContext.request.contextPath}/propertyList.do" data-i18n="속성 관리">속성 관리</a>
                        </li>
                        <li id="group"><a class="menu-item" href="${pageContext.request.contextPath}/groupList.do" data-i18n="그룹 관리">그룹 관리</a>
						</li>
                    </ul>
                </li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/contentsList.do"><i class="feather icon-file-text"></i><span class="menu-title" data-i18n="콘텐츠 DB">콘텐츠 DB</span></a>
					<ul class="menu-content">
                        <li id="contentsList"><a class="menu-item" href="${pageContext.request.contextPath}/contentsList.do" data-i18n="공용 콘텐츠">공용 콘텐츠</a>
                        </li>
                        <li id="siteContentsList"><a class="menu-item" href="${pageContext.request.contextPath}/siteContentsList.do" data-i18n="고객사 콘텐츠">고객사 콘텐츠</a>
						</li>
                    </ul>
                </li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/stampList.do"><i class="feather icon-award"></i><span class="menu-title" data-i18n="설정">스탬프/스티커 관리</span></a>
					<ul class="menu-content">
                        <li id="stamp"><a class="menu-item" href="${pageContext.request.contextPath}/stampList.do" data-i18n="스탬프 관리">스탬프 관리</a>
                        </li>
                        <li id="sticker"><a class="menu-item" href="${pageContext.request.contextPath}/stickerList.do" data-i18n="스티커 관리">스티커 관리</a>
						</li>
                    </ul>
                </li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/gameList.do"><i class="icon-game-controller"></i><span class="menu-title" data-i18n="게임">게임 관리</span></a>
					<ul class="menu-content">
                        <li id="game"><a class="menu-item" href="${pageContext.request.contextPath}/gameList.do" data-i18n="룰렛 관리">룰렛 관리</a>
                        </li>
                        <li id="quiz"><a class="menu-item" href="${pageContext.request.contextPath}/quizList.do" data-i18n="퀴즈 관리">퀴즈 관리</a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/emoticonList.do"><i class="feather icon-eye"></i><span class="menu-title" data-i18n="이모티콘">이모티콘 관리</span></a>
					<ul class="menu-content">
                        <li id="emoticon"><a class="menu-item" href="${pageContext.request.contextPath}/emoticonList.do" data-i18n="룰렛 관리">이모티콘 관리</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div> --%>