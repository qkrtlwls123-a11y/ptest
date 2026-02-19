<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="dtx-survey-detail" style="background-color: #ffffff; height: 100%; width: 1100px;">
    <div class="panel-head">
      <span class="panel-title" style="padding-left:30px;margin-right:0;">수식 관리&nbsp;&nbsp;
      	<button class="btn btn-primary btn-md btn_score_update"><span class="d-md-block d-none" onclick="javascript:fn_insertSurveyScore();return false;">등록</span></button>
      	<button class="btn btn-danger btn-md btn_score_cancel"><span class="d-md-block d-none" onclick="javascript:fn_cancelModify();return false;">취소</span></button>
      </span>
			      <i class="panel-close-btn feather icon-x"></i>
    </div>
    <div class="panel-body ns-scrollbar survey-form" style="width:50%;float:left;" id="surveyTypeForm">
    	<div class="survey-form-style2 item report">
	        <div class="top"></div>
	        <div class="left"></div>
	        <div class="survey-detail">
	          <div class="survey-item-title">
	            <div class="input-box" style="line-height:2.5rem;">
	              	수식 구분
	            </div>
	            <div class="survey-style-select-box2">
	              <div class="select-box">
	                <div class="select-item">
	                  <span class="select-placeholder" data="normalX">띠 그래프(X축 기준)</span>
	                  <i class="fa-solid fa-chevron-down"></i>
	                </div>
	              </div>
	              <div class="select-list-wrap">
	                <ul class="survey-style-list">
	                  <li class="survey-style-item2">띠 그래프(X축 기준)</li>
	                  <li class="survey-style-item2">띠 그래프(Y축 기준)</li>
	                  <li class="survey-style-item2">라인 그래프</li>
	                </ul>
	              </div>
	            </div>
	            <div class="survey-style-select-box">
	              <div class="select-box">
	                <div class="select-item">
	                  <span class="select-placeholder" data="average">평균</span>
	                  <i class="fa-solid fa-chevron-down"></i>
	                </div>
	              </div>
	              <div class="select-list-wrap">
	                <ul class="survey-style-list">
	                  <li class="survey-style-item">평균</li>
	                  <li class="survey-style-item">합산</li>
	                  <li class="survey-style-item">합산-기준</li>
	                </ul>
	              </div>
	            </div>
	          </div>
	        </div>
      </div>
      <div class="survey-form-style2 item report">
	        <div class="survey-detail">
	          <div class="survey-item-title">
	            <div class="input-box" style="line-height:2.5rem;">
	              	구분 등록
	            </div>
	          </div>
	          <div class="survey-item-detail">
	            <div class="input-box">
	              <input type="text" placeholder="구분 명을 입력 해주세요." id="surveyType">
	            </div>
	          </div>
	        </div>
      </div>
    </div>
    <div class="panel-body ns-scrollbar survey-form surveyInsertForm" id="detailArea" style="width:50%;">
      
    </div>
  </div>
  
<div id="tagArea" style="display: none;">
    <div class="tag-wrap">
        <span class="keyword-tag">구분</span>
        <i class="fa-solid fa-x tag-delete"></i>
    </div>
</div>
<div id="typeArea" style="display:none;">
	<div class="survey-form-style2 item report">
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box typeName" style="line-height:2.5rem;">
              	구분
            </div>
            <i class="feather icon-x delete-type" style="font-size:20px;"></i>
          </div>
          <div class="survey-item-detail">
            <div class="input-box">
             	 배율 : <input type="text" placeholder="배율 입력" style="width:20%;text-align:center;" class="surveyScoreMag">
            </div>
          </div>
          <div class="survey-item-detail">
            <div class="input-box">
             	 문항 : <input type="text" placeholder="문항 입력" class="surveyTypeSeq" style="width:20%;text-align:center;">
            </div>
          </div>
          <div class="hashTage-wrap surveyNumberArea" >
            
          </div>
        </div>
     </div>
</div>
