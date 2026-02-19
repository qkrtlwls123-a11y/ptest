<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="dtx-survey-form" style="background-color: #ffffff; height: 100%; width: 800px;">
			    <div class="panel-head">
			    <span class="panel-title" style="padding-left:30px;margin-right:0;">설문지 등록</span>
			      <i class="panel-close-btn feather icon-x"></i>
			    </div>
			    <div class="panel-body ns-scrollbar survey-form surveyInsertForm">
			      <!-- 설문 제목 -->
			      <div class="survey-form-style title">
			        <div class="top"></div>
			        <div class="left"></div>
			        <div class="survey-detail">
			          <div class="input-box">
			            <input type="text" id="surveyTitle" placeholder="제목을 입력하세요">
			          </div>
			          <div class="input-box">
			            <input type="text" id="surveyDescription" placeholder="설문지 설명">
			          </div>
			        </div>
			      </div>
			      <!-- 단답형(기본) -->
			      <div class="survey-form-style item">
			        <div class="top"></div>
			        <div class="left"></div>
			        <div class="survey-detail">
			          <div class="survey-item-title">
			            <div class="input-box">
			              <input type="text" placeholder="질문을 입력하세요">
			            </div>
			            <div class="require-select">
			              <span>필수</span>
			              <input class="require-tgl" type="checkbox">
			              <label class="require-btn"></label>
			            </div>
			            <div class="survey-style-select-box">
			              <div class="select-box">
			                <div class="select-item">
			                  <span class="select-placeholder">단답형</span>
			                  <i class="fa-solid fa-chevron-down"></i>
			                </div>
			              </div>
			              <div class="select-list-wrap">
			                <ul class="survey-style-list">
			                  <li class="survey-style-item">단답형</li>
			                  <li class="survey-style-item">장문형</li>
			                  <li class="survey-style-item">객관식 질문 - 1</li>
			                  <li class="survey-style-item">객관식 질문 - 2</li>
			                  <li class="survey-style-item">선형 배율</li>
			                  <li class="survey-style-item">객관식 그리드</li>
			                  <li class="survey-style-item">체크박스 그리드</li>
			                </ul>
			              </div>
			            </div>
			          </div>
			          <div class="survey-item-explanation">
			            <div class="input-box">
			              <input type="text" placeholder="질문 설명">
			            </div>
			          </div>
			          <div class="survey-item-detail short-text">
			            <div class="input-box">
			              <input type="text" placeholder="미리보기 설명 작성 - ex. 1~3글자를 입력하세요">
			            </div>
			          </div>
			          <div class="survey-item-setting">
			            <button class="survey-item-add-btn"><i class="fa-solid fa-plus"></i></button>
			            <button class="survey-item-remove-btn"><i class="fa-solid fa-trash-can"></i></button>
			          </div>
			        </div>
			      </div>
			      <!-- 저장 -->
			      <div class="panel-form-btn-box">
			        <button class="btn btn-submit" id="btn-survey"><span>등록</span></button>
			      </div>
			    </div>
			  </div>