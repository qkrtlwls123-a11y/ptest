<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="left_menu_wrap">
	<div class="areas">
		<div class="left_container" style="width:100%;">
			<div class="photo">
				<c:if test="${memberSessionVO.member_profile == null || memberSessionVO.member_profile == ''}">
					<img src="${pageContext.request.contextPath}/resources/mobile/images/profile.png" alt="프로필 이미지">
				</c:if>
				<c:if test="${memberSessionVO.member_profile != null && memberSessionVO.member_profile != ''}">
					<img src="http://ptest.co.kr/click/file/down/${memberSessionVO.member_profile}" alt="프로필 이미지">
				</c:if>
			</div>
			<div style="float:left;padding-left:10px;width:55%;">
				<p style="font-size:12px;"><span style="color:#FC739E;font-size:14px;">Hello, </span><span style="color:#000;font-size:14px;">${memberSessionVO.member_name}</span> 님</p>
				<p style="font-size:12px;color:#999;">${memberSessionVO.member_comment}</p>
			</div>
			<div style="float:right;font-size:28px;padding-top:10px;padding-right:30px;">
				<i class="feather icon-bell"></i>
			</div>
		</div><!-- container -->
		<div style="width:100%;border-top:2px solid #F6F6F6;display:inline-block;">
			<div style="float:left;width:50%;text-align:center;padding: 10px 0;" onclick="javascript:fn_rankingList();return false;">
				<p style="color:#FC739E;font-size:16px;">${memberSessionVO.member_ranking}</p>
				<p style="font-size:14px;color:#999;">랭킹</p>
			</div>
			<div style="float:left;width:50%;text-align:center;padding: 10px 0;">
				<p style="color:#FFA63D;font-size:16px;">${memberSessionVO.member_progress}%</p>
				<p style="font-size:14px;color:#999;">총 진도율</p>
			</div>
		</div>
		<div style="width:100%;border-top:2px solid #F6F6F6;display:inline-block;">
			<div style="float:left;width:100%;text-align:left;padding: 15px 0 15px 20px;" onclick="javascript:fn_mypage();return false;">
				<p style="font-size:20px;color:#666;line-height:22px;"><i class="feather icon-user"></i><span style="font-size:16px;padding-left:20px;">마이페이지</span></p>
			</div>
			<div style="float:left;width:100%;text-align:left;padding: 5px 0 15px 20px;" onclick="javascript:fn_study();return false;">
				<p style="font-size:20px;color:#666;line-height:22px;"><i class="icon-notebook"></i><span style="font-size:16px;padding-left:20px;">학습현황</span></p>
			</div>
			<div style="float:left;width:100%;text-align:left;padding: 5px 0 15px 20px;" onclick="javascript:fn_noticeList();return false;">
				<p style="font-size:20px;color:#666;line-height:22px;"><i class="feather icon-volume-1"></i><span style="font-size:16px;padding-left:20px;">공지사항</span></p>
			</div>
			<div style="float:left;width:100%;text-align:left;padding: 5px 0 15px 20px;">
				<p style="font-size:20px;color:#666;line-height:22px;"><i class="icon-bubbles"></i><span style="font-size:16px;padding-left:20px;">커뮤니티</span></p>
			</div>
			<div style="float:left;width:100%;text-align:left;padding: 5px 0 15px 20px;" onclick="javascript:fn_pointList();return false;">
				<p style="font-size:20px;color:#666;line-height:22px;"><i class="icon-game-controller"></i><span style="font-size:16px;padding-left:20px;">게임</span></p>
			</div>
			<div style="float:left;width:100%;text-align:left;padding: 5px 0 15px 20px;" onclick="javascript:fn_rankingList();return false;">
				<p style="font-size:20px;color:#666;line-height:22px;"><i class="icon-trophy"></i><span style="font-size:16px;padding-left:20px;">랭킹</span></p>
			</div>
		</div>
		<div style="position:fixed;bottom:0;width:280px;">
			<div style="width:150px;float:left;padding: 0 0 15px 15px;">
				<img src="${pageContext.request.contextPath}/resources/mobile/images/onionbox_logo.png" alt="">
			</div>
			<div style="width:100px;text-align:right;float:left;font-size:20px;padding-top:3px;">
				<i class="feather icon-settings" onclick="javascript:fn_setting();return false;"></i>
			</div>
		</div>
	</div><!-- areas -->
	
</div><!-- wrap -->
