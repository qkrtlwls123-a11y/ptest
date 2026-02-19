<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<form:form id="parameterVO" commandName="parameterVO" name="parameterVO" action="" method="post">
		<input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
		<input type="hidden" id="menuId" name="menuId" value="${parameterVO.menuId}"/>
		<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="10"/>
	</form:form>
			<div class="page-navigation">
				<ul>
					<li><a href="#">Home</a></li>
					<li class="gray">></li>
					<li><a href="#"><spring:message code="click.my.page"/></a></li>
				</ul>
			</div>
			<div class="con-area">
				<div class="content-box">
					<div class="table mt10 mb20 font14 no-hover">
						<table>
						<colgroup>
							<col width="15%">
							<col width="45%">
							<col width="15%">
							<col width="25%">
						</colgroup>
						<tbody>           
							<tr>
								<th class="center"><spring:message code="click.use.or.not"/></th>
								<td>
									<span><spring:message code="click.available"/></span>
								</td>
								<th class="center"><spring:message code="click.account.status"/></th>
								<td>
									<span><spring:message code="click.normal"/></span>
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="click.site.authority"/></th>
								<td colspan="3">
									<span>기흥 경부(상행선) 건설현장</span>
								</td>
							</tr>
						</tbody>
						</table>
					</div>
					<div class="table mt10 mb20 font14 no-hover">
						<table>
						<colgroup>
							<col width="15%">
							<col width="45%">
							<col width="15%">
							<col width="25%">
						</colgroup>
						<tbody>                                
							<tr>
								<th class="center"><spring:message code="click.employee.number"/></th>
								<td>
									<span> - </span>
								</td>
								<th class="center"><spring:message code="click.name"/></th>
								<td>
									<span><spring:message code="click.hancock"/></span>
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="click.id"/></th>
								<td colspan="3">
									<span>korea</span>
								</td>
							</tr>
							<tr>
								<th class="center">* <spring:message code="click.change.password"/></th>
								<td colspan="3">
									<input type="text" style="width: 250px;" placeholder="">
									<!--결과값 출력-->
									<span class="red font14 ml10">※ <spring:message code="click.not.possible.delete.it"/></span>
									<span class="blue font14 ml10">※ <spring:message code="click.can.be.used"/></span>
									<!--결과값 출력 끝-->
								</td>
							</tr>
							<tr>
								<th class="center">* <spring:message code="click.password.reenter"/></th>
								<td colspan="3">
									<input type="text" style="width: 250px;" placeholder="">
									<!--결과값 출력-->
									<span class="red font14 ml10">※ <spring:message code="click.not.match"/></span>
									<span class="blue font14 ml10">※ <spring:message code="click.can.be.used"/></span>
									<!--결과값 출력 끝-->
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="click.company.name"/></th>
								<td>
									<span><spring:message code="click.sgsone.engineering.constraction"/></span>
								</td>
								<th class="center"><spring:message code="click.business.item"/></th>
								<td><spring:message code="click.construction"/></td>
							</tr>
							<tr>
								<th class="center">* <spring:message code="click.contact.information"/></th>
								<td>
									<c:set var="account_phone" value="${sessionVO.account_phone}"/>
									<select name="" id="">
										<option value=""><spring:message code="click.selection"/></option>
										<option value="010" <c:if test="${fn:substring(account_phone,0,3) == '010'}">selected="selected"</c:if>>010</option>
										<option value="011" <c:if test="${fn:substring(account_phone,0,3) == '011'}">selected="selected"</c:if>>011</option>
										<option value="016" <c:if test="${fn:substring(account_phone,0,3) == '016'}">selected="selected"</c:if>>016</option>
										<option value="017" <c:if test="${fn:substring(account_phone,0,3) == '017'}">selected="selected"</c:if>>017</option>
										<option value="019" <c:if test="${fn:substring(account_phone,0,3) == '019'}">selected="selected"</c:if>>019</option>
										<option value="02" <c:if test="${fn:substring(account_phone,0,2) == '02'}">selected="selected"</c:if>>02</option>
										<option value="031" <c:if test="${fn:substring(account_phone,0,3) == '031'}">selected="selected"</c:if>>031</option>
										<option value="032" <c:if test="${fn:substring(account_phone,0,3) == '032'}">selected="selected"</c:if>>032</option>
										<option value="033" <c:if test="${fn:substring(account_phone,0,3) == '033'}">selected="selected"</c:if>>033</option>
										<option value="041" <c:if test="${fn:substring(account_phone,0,3) == '041'}">selected="selected"</c:if>>041</option>
										<option value="042" <c:if test="${fn:substring(account_phone,0,3) == '042'}">selected="selected"</c:if>>042</option>
										<option value="043" <c:if test="${fn:substring(account_phone,0,3) == '043'}">selected="selected"</c:if>>043</option>
										<option value="044" <c:if test="${fn:substring(account_phone,0,3) == '044'}">selected="selected"</c:if>>044</option>
										<option value="051" <c:if test="${fn:substring(account_phone,0,3) == '051'}">selected="selected"</c:if>>051</option>
										<option value="052" <c:if test="${fn:substring(account_phone,0,3) == '052'}">selected="selected"</c:if>>052</option>
										<option value="053" <c:if test="${fn:substring(account_phone,0,3) == '053'}">selected="selected"</c:if>>053</option>
										<option value="054" <c:if test="${fn:substring(account_phone,0,3) == '054'}">selected="selected"</c:if>>054</option>
										<option value="055" <c:if test="${fn:substring(account_phone,0,3) == '055'}">selected="selected"</c:if>>055</option>
										<option value="061" <c:if test="${fn:substring(account_phone,0,3) == '061'}">selected="selected"</c:if>>061</option>
										<option value="062" <c:if test="${fn:substring(account_phone,0,3) == '062'}">selected="selected"</c:if>>062</option>
										<option value="063" <c:if test="${fn:substring(account_phone,0,3) == '063'}">selected="selected"</c:if>>063</option>
										<option value="064" <c:if test="${fn:substring(account_phone,0,3) == '064'}">selected="selected"</c:if>>064</option>
										<option value="050" <c:if test="${fn:substring(account_phone,0,3) == '050'}">selected="selected"</c:if>>050</option>
										<option value="070" <c:if test="${fn:substring(account_phone,0,3) == '070'}">selected="selected"</c:if>>070</option>
										<option value="080" <c:if test="${fn:substring(account_phone,0,3) == '080'}">selected="selected"</c:if>>080</option>
										<option value="0303" <c:if test="${fn:substring(account_phone,0,4) == '0303'}">selected="selected"</c:if>>0303</option>
										<option value="0503" <c:if test="${fn:substring(account_phone,0,4) == '0503'}">selected="selected"</c:if>>0503</option>
										<option value="0504" <c:if test="${fn:substring(account_phone,0,4) == '0504'}">selected="selected"</c:if>>0504</option>
										<option value="0505" <c:if test="${fn:substring(account_phone,0,4) == '0505'}">selected="selected"</c:if>>0505</option>
										<option value="0506" <c:if test="${fn:substring(account_phone,0,4) == '0506'}">selected="selected"</c:if>>0506</option>
										<option value="0507" <c:if test="${fn:substring(account_phone,0,4) == '0507'}">selected="selected"</c:if>>0507</option>
									</select>
									<input type="text" style="width: 150px;" value="${fn:substring(account_phone,3,7)}">
									<input type="text" style="width: 150px;" value="${fn:substring(account_phone,7,11)}">
								</td>
								<th class="center"><spring:message code="click.whether.employed"/></th>
								<td> - </td>
							</tr>
							
						</tbody>
						</table>
					</div>
					<div class="center mt10">
						<button type="button" class="btn btn-blue btn-type2 mr10"><spring:message code="click.edit"/></button>
						<button type="button" class="btn btn-main btn-gray-main btn-type2"><spring:message code="click.cancel"/></button>
					</div>
				</div>
			</div><!--본문 영역 끝-->
