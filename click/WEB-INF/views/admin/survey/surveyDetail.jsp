<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="dtx-survey-detail" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <span class="panel-title" style="padding-left:30px;margin-right:0;">설문지 상세&nbsp;&nbsp;
      	<button class="btn btn-primary btn-md btn_modify"><span class="d-md-block d-none" onclick="javascript:fn_surveyModify();return false;">정보 수정</span></button>
      	<button class="btn btn-primary btn-md btn_cal"><span class="d-md-block d-none" onclick="javascript:fn_calModify();return false;">수식 관리</span></button>
      	<button class="btn btn-primary btn-md btn_update dis-none"><span class="d-md-block d-none" onclick="javascript:fn_updateSurvey();return false;">수정</span></button>
      	<button class="btn btn-danger btn-md btn_cancel dis-none"><span class="d-md-block d-none" onclick="javascript:fn_cancelModify();return false;">취소</span></button>
      </span>
			      <i class="panel-close-btn feather icon-x"></i>
    </div>
    <div class="panel-body ns-scrollbar survey-form surveyInsertForm" id="detailArea">
      <!-- 설문 제목 -->
      <div class="survey-form-style title">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="input-box">
            <input type="text" id="surveyDetailTitle" placeholder="제목을 입력하세요" value="환자 진료 만족도 설문조사" readonly>
          </div>
          <div class="input-box">
            <input type="text" id="surveyDetailDescription" placeholder="설문지 설명" value="만족도 조사를 통해서 방문하는 환자의 요구사항을 파악하여 개선하기 위함이다.">
          </div>
        </div>
      </div>
      <div class="survey-form-style item report">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="Q. 고객님의 성함은 어떻게 되십니까?" readonly>
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked readonly>
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
          <div class="survey-item-detail short-text">
            <div class="input-box">
              <input type="text" placeholder="병원에 등록된 실명으로 작성해 주세요.">
            </div>
          </div>
        </div>
      </div>
      <div class="survey-form-style item report">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="Q. 고객님의 연령대는 어떻게 되십니까?" readonly>
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked readonly>
              <label class="require-btn"></label>
            </div>
            <div class="survey-style-select-box">
              <div class="select-box">
                <div class="select-item">
                  <span class="select-placeholder">객관식 질문 - 1</span>
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
          <div class="survey-item-detail multiple-choice-radio">
            <ul class="multiple-choice-wrap">
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="10대 미만" readonly>
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="10대 ~ 20대" readonly>
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="30대 ~ 40대" readonly>
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="50대 ~ 60대" readonly>
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="70대 이상">
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="survey-form-style item report">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="Q. 병원에 내원 하시게 된 계기는 무엇인가요?" readonly>
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked readonly>
              <label class="require-btn"></label>
            </div>
            <div class="survey-style-select-box">
              <div class="select-box">
                <div class="select-item">
                  <span class="select-placeholder">객관식 질문 - 2</span>
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
          <div class="survey-item-detail multiple-choice-check">
            <ul class="multiple-choice-wrap">
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="정기검진" readonly>
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="낙상 사고" readonly>
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="혈당수치가 높아서" readonly>
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="고혈압 또는 저혈압 체크를 위해서" readonly>
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="기타">
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="survey-form-style item report">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="Q. 병원의 접근성에 대해 어떻게 생각 하십니까?" readonly>
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked readonly>
              <label class="require-btn"></label>
            </div>
            <div class="survey-style-select-box">
              <div class="select-box">
                <div class="select-item">
                  <span class="select-placeholder">선형 배율</span>
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
              <input type="text" placeholder="질문 설명" value="고객님이 병원에 내원하시는데 만족도를 알아보기 위함입니다." readonly>
            </div>
          </div>
          <div class="survey-item-detail linear-scale">
            <ul class="linear-scale-wrap">
              <li class="linear-label">
                <input type="text" placeholder="라벨" value="매우 불만족스럽다" readonly>
              </li>
              <li class="linear-item">
                <div class="radio-wrap">
                  <span>1</span>
                  <input type="radio">
                  <label class="radio-label"></label>
                </div>
              </li>
              <li class="linear-item">
                <div class="radio-wrap">
                  <span>2</span>
                  <input type="radio">
                  <label class="radio-label"></label>
                </div>
              </li>
              <li class="linear-item">
                <div class="radio-wrap">
                  <span>3</span>
                  <input type="radio">
                  <label class="radio-label"></label>
                </div>
              </li>
              <li class="linear-item">
                <div class="radio-wrap">
                  <span>4</span>
                  <input type="radio">
                  <label class="radio-label"></label>
                </div>
              </li>
              <li class="linear-item">
                <div class="radio-wrap">
                  <span>5</span>
                  <input type="radio">
                  <label class="radio-label"></label>
                </div>
              </li>
              <li class="linear-label">
                <input type="text" placeholder="라벨" value="매우 만족스럽다" readonly>
              </li>
            </ul></div>
        </div>
      </div>
      <div class="survey-form-style item report">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="Q. 병원의 친절도에 대해 어떻게 생각하십니까?" readonly>
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked readonly>
              <label class="require-btn"></label>
            </div>
            <div class="survey-style-select-box">
              <div class="select-box">
                <div class="select-item">
                  <span class="select-placeholder">객관식 그리드</span>
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
              <input type="text" placeholder="질문 설명" value="고객님이 병원을 이용하는데 있어 어떤 느낌을 받았는지에 대해 체크하기 위함입니다." readonly>
            </div>
          </div>
          <div class="survey-item-detail radio-grid">
            <div class="grid-check-wrap">
              <table>
                <tr>
                  <th class="empty"></th>
                  <th>부족함</th>
                  <th>괜찮음</th>
                  <th>만족스러움</th>
                  <th>매우 좋음</th>
                  <th>훌륭함</th>
                </tr>
                <tr>
                  <th>의사</th>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                </tr>
                <tr>
                  <th>간호사</th>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                </tr>
                <tr>
                  <th>행정직원</th>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                </tr>
                <tr>
                  <th>보안요원</th>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                </tr>
                <tr>
                  <th>기타직원</th>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                  <td>
                    <input type="radio">
                    <label class="radio-label"></label>
                  </td>
                </tr>
              </table>
            </div>
          </div>
        </div>
      </div>
      <div class="survey-form-style item report">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="Q. 친절하게 느낀 직원 추천 부탁드립니다." readonly>
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" readonly>
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
          <div class="survey-item-detail short-text">
            <div class="input-box">
              <input type="text" placeholder="이름 또는 인상착의를 작성해 주세요">
            </div>
          </div>
        </div>
      </div>
      <div class="survey-form-style item report">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="Q. 조언하실 말씀이 있다면 부탁드립니다." readonly>
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox">
              <label class="require-btn"></label>
            </div>
            <div class="survey-style-select-box">
              <div class="select-box">
                <div class="select-item">
                  <span class="select-placeholder">장문형</span>
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
              <input type="text" placeholder="질문 설명" value="고객님의 건강을 책임지는 병원으로서 발전할 수 있도록 조언하실 말씀이 있으시다면 자유롭게 남겨주시면 감사하겠습니다.">
            </div>
          </div>
          <div class="survey-item-detail long-text">
            <div class="textarea-box">
              <textarea placeholder="자세한 후기를 남기시면 향후 병원의 발전에에 도움이 됩니다."></textarea>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>