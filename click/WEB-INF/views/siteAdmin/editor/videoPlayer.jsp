<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="plyr-video-player" class="eMovie" data="${realfileName}">
    <iframe class="eVideoPlayer" src="${pageContext.request.contextPath}/resources/movie/${fileName}?origin=https://plyr.io&amp;iv_load_policy=3&amp;modestbranding=1&amp;playsinline=1&amp;showinfo=0&amp;rel=0&amp;enablejsapi=1" allowfullscreen style="border:0px;"></iframe>
</div>
<script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/ui/plyr.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/app-assets/js/scripts/pages/ex-component-media-player.js"></script>

