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
	<dl id="alertPopupArea" class="pop-main-style02">
				<dt style="background-color:var(--main-bg-color);">내려보내실 사이트를 선택하세요.</dt>
				<dd>
					<div class="table-responsive">
					<table id="" class="table table-white-space table-bordered row-grouping display no-wrap icheck table-middle text-center">
                            <thead>
                                <tr>
									<th>고객사 명</th>
									<th>사이트 명</th>
									<th>수정일</th>
									<th>등록일</th>
									<th>선택</th>
                                </tr>
                            </thead>
                            <tbody>
                           	<c:forEach var="companyList" items="${companyList}">
                           		<fmt:parseDate var="updt_date" value="${companyList.updt_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:parseDate var="reg_date" value="${companyList.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
								<tr>
									<td>
									    ${companyList.company_name}
									</td>
									<td class="text-center aa">
										${companyList.site_name}
									</td>
									<td class="text-center cc">
									    <fmt:formatDate value="${updt_date}" pattern="yyyy-MM-dd" />
									</td>
									<td class="text-center dd">
									   <fmt:formatDate value="${reg_date}" pattern="yyyy-MM-dd" />
								    </td>
								    <td>
										<div class="btn btn-secondary list-btn" style="width:60px;" data-tooltip="선택" onclick="javascript:fn_selectCompany('${companyList.company_id}', '${parameterVO.contents_id}', '${companyList.site_name}');return false;">선택</div>
									</td>
								</tr>
							</c:forEach>
					    </tbody>
					</table>
					</div>
				</dd>
			</dl>
<script src="${pageContext.request.contextPath}/resources/app-assets/vendors/js/tables/jquery.dataTables.min.js"></script>