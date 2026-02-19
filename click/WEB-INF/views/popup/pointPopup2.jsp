<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<script type="text/javascript">
	$(function(){
		$('.closeBtn').focus();
		// CCTV
		
		
	})
	</script>
	<dl id="alertPopupArea" class="pop-main-style02" style="width:300px;margin-top:400px;">
				<dt style="background-color:var(--main-bg-color);">포인트를 입력하세요.</dt>
				<dd>
					<div class="table-responsive">
						<p><input type="text" class="form-control" placeholder="포인트 " name="member_point" value="" style="width:200px;display:inline-block"><button type="button" class="btn btn-primary" onclick="javascript:fn_pointUpdate('M');return false;">등록</button></p>
					</div>
				</dd>
			</dl>
