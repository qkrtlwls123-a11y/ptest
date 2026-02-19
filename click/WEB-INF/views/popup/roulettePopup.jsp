<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript">
	$(function(){
		$('.closeBtn').focus();
		// CCTV
	})
	</script>
	<dl id="alertPopupArea" class="pop-main-style02">
				<dt style="background-color:var(--main-bg-color);">룰렛 게임을 선택하세요.</dt>
				<dd>
					<table  class="table table-white-space table-bordered row-grouping display no-wrap icheck table-middle text-center">
					<thead>
                        <tr>
                            <th>룰렛 명</th>
                            <th>룰렛 개수</th>
                            <th>수정일</th>
                            <th>등록일</th>
                            <th>선택</th>
                        </tr>
                    </thead>
                    <tbody>
					<c:forEach var="resultList" items="${resultList}" varStatus="status">
								<tr>
									<td>${resultList.game_name}</td>
									<td>룰렛 타입 : ${resultList.game_count}개</td>
									<td>${resultList.updt_date}</td>
									<td>${resultList.reg_date}</td>
									<td>
										<div class="btn btn-secondary list-btn" style="width:60px;" data-tooltip="선택" onclick="javascript:fn_selectRouletteDetail('${resultList.game_id}');return false;">선택</div>
									</td>
								</tr>
					</c:forEach>
					</tbody>
					</table>
				</dd>
			</dl>
