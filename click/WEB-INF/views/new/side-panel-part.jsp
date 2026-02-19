<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout">


<div id="side-panel-part" style="display: none;" th:fragment="sidePanelPartFragment">
  <!-- 업데이트 환자 리스트 -->
  <div id="update-patient" style="background-color: #ffffff; height: 100%; width: 500px;">
    <div class="panel-head">
      <i class="panel-close-btn fa-solid fa-x"></i>
      <span class="panel-title">업데이트 필요 환자</span>
    </div>
    <div class="panel-body update-body ns-scrollbar">
      <ul class="update-patient-list">
        <li class="update-patient-item">
          <div class="profile-img-wrap">
            <img src="/assets/images/sample/sample-patient-pic01.jpeg" alt="profile-img">
          </div>
          <div class="update-patient-info">
            <span class="name">현봉식</span>
            <span class="date">2022-05-04 12:34:56</span>
          </div>
          <div class="update-btn-wrap">
            <div class="update-patient">
            </div>
          </div>
        </li>
        <li class="update-patient-item">
          <div class="profile-img-wrap">
          </div>
          <div class="update-patient-info">
            <span class="name">정아름</span>
            <span class="date">2022-05-04 12:34:56</span>
          </div>
          <div class="update-btn-wrap">
            <div class="update-patient">
            </div>
          </div>
        </li>
        <li class="update-patient-item">
          <div class="profile-img-wrap">
            <img src="/assets/images/sample/sample-patient-pic02.png" alt="profile-img">
          </div>
          <div class="update-patient-info">
            <span class="name">오일남</span>
            <span class="date">2022-05-04 12:34:56</span>
          </div>
          <div class="update-btn-wrap">
            <div class="update-patient">
            </div>
          </div>
        </li>
        <li class="update-patient-item">
          <div class="profile-img-wrap">
          </div>
          <div class="update-patient-info">
            <span class="name">현재승</span>
            <span class="date">2022-05-04 12:34:56</span>
          </div>
          <div class="update-btn-wrap">
            <div class="update-patient">
            </div>
          </div>
        </li>
        <li class="update-patient-item">
          <div class="profile-img-wrap">
          </div>
          <div class="update-patient-info">
            <span class="name">권기후</span>
            <span class="date">2022-05-04 12:34:56</span>
          </div>
          <div class="update-btn-wrap">
            <div class="update-patient">
            </div>
          </div>
        </li>
        <li class="update-patient-item">
          <div class="profile-img-wrap">
            <img src="/assets/images/sample/sample-patient-pic04.jpeg" alt="profile-img">
          </div>
          <div class="update-patient-info">
            <span class="name">이혜연</span>
            <span class="date">2022-05-04 12:34:56</span>
          </div>
          <div class="update-btn-wrap">
            <div class="update-patient">
            </div>
          </div>
        </li>
        <li class="update-patient-item">
          <div class="profile-img-wrap">
            <img src="/assets/images/sample/sample-patient-pic06.jpeg" alt="profile-img">
          </div>
          <div class="update-patient-info">
            <span class="name">강소라</span>
            <span class="date">2022-05-04 12:34:56</span>
          </div>
          <div class="update-btn-wrap">
            <div class="update-patient">
            </div>
          </div>
        </li>
        <li class="update-patient-item">
          <div class="profile-img-wrap">
            <img src="/assets/images/sample/sample-patient-pic08.jpeg" alt="profile-img">
          </div>
          <div class="update-patient-info">
            <span class="name">강부자</span>
            <span class="date">2022-05-04 12:34:56</span>
          </div>
          <div class="update-btn-wrap">
            <div class="update-patient">
            </div>
          </div>
        </li>
        <li class="update-patient-item">
          <div class="profile-img-wrap">
          </div>
          <div class="update-patient-info">
            <span class="name">김환자</span>
            <span class="date">2022-05-04 12:34:56</span>
          </div>
          <div class="update-btn-wrap">
            <div class="update-patient">
            </div>
          </div>
        </li>
      </ul>
    </div>
  </div>

  <!-- 알림 리스트 -->
  <div id="alarm" class="ns-scrollbar" style="background-color: #ffffff; height: 100%; width: 1000px;">
    <div class="ns-scrollbar">
      <img src="/assets/images/sample/sample-push.png">
      <img src="/assets/images/sample/sample-push.png">
      <img src="/assets/images/sample/sample-push.png">
    </div>
  </div>

   <!-- 등록 및 수정 폼-->
  <div id="dtx-register-form" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head register-head patient">
      <div class="patient-basic-info-wrap"> <!-- dtx.css : 873-->
        <div class="profile-img-wrap">
<!--          <img src="/assets/images/sample/sample-patient-pic01.jpeg" alt="patient-img">-->
        </div>
        <div class="patient-basic-info" style="visibility: hidden">
          <span class="patient-name">현봉식</span>
          <span class="patient-gender"><i class="fa-solid fa-mars"></i></span>
          <span class="patient-age">39세</span>
          <span class="patient-code">PA8412034</span>
        </div>
      </div>
    </div>
    <div class="panel-body register-body patient">
      <div class="register-form-style ns-scrollbar">
        <div class="register-form-head">
          <div class="title">
            <i class="fa-solid fa-clipboard-list"></i>
            <span>환자 정보 카드</span>
          </div>
          <span class="register-date" style="visibility: hidden">2022-05-04</span>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required>
          <label><span>Q1. 환자의 이름을 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required>
          <label><span>Q2. 환자의 성별을 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required>
          <label><span>Q3. 환자의 생년월일을 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required>
          <label><span>Q4. 스마트폰 번호를 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required>
          <label><span>Q5. 환자의 거주 주소를 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required>
          <label><span>Q6. 환자의 과거 병력을 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required>
          <label><span>Q7. 환자가 규칙적으로 생활을 하는 정도를 선택하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required>
          <label><span>Q8. 환자가 즐겨하는 운동을 선택하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required>
          <label><span>Q9. 환자의 콜레스테롤 지수를 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required>
          <label><span>Q10. 환자의 심리상태를 입력하세요.<em class="require"></em></span></label>
        </div>
      </div>
    </div>
  </div>
  <!-- 등록 및 수정 폼-->
  <div id="dtx-register-form-sample-01" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head register-head patient">
      <div class="patient-basic-info-wrap">
        <div class="profile-img-wrap">
          <img src="/assets/images/sample/sample-patient-pic10.jpeg" alt="patient-img">
        </div>
        <div class="patient-basic-info">
          <span class="patient-name">이정재</span>
          <span class="patient-gender"><i class="fa-solid fa-mars"></i></span>
          <span class="patient-age">50세</span>
          <span class="patient-code">PA3412034</span>
        </div>
      </div>
    </div>
    <div class="panel-body register-body patient">
      <div class="register-form-style ns-scrollbar">
        <div class="register-form-head">
          <div class="title">
            <i class="fa-solid fa-clipboard-list"></i>
            <span>환자 정보 카드</span>
          </div>
          <span class="register-date">2022-05-04</span>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required value="이정재">
          <label><span>Q1. 환자의 이름을 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required value="남자" class="select-input-box">
          <label><span>Q2. 환자의 성별을 입력하세요.<em class="require"></em></span></label>
          <ul class="form-select-box">
            <li class="select-item"><span>남자</span></li>
            <li class="select-item"><span>여자</span></li>
          </ul>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required value="1973.10.20">
          <label><span>Q3. 환자의 생년월일을 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required value="010-1234-5678">
          <label><span>Q4. 스마트폰 번호를 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required value="서울광역시 종로구 세종대로 209">
          <label><span>Q5. 환자의 거주 주소를 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required value="맹장수술">
          <label><span>Q6. 환자의 과거 병력을 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required value="보통">
          <label><span>Q7. 환자가 규칙적으로 생활을 하는 정도를 선택하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required value="싸이클, 등산, 헬스">
          <label><span>Q8. 환자가 즐겨하는 운동을 선택하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required value="180LDL">
          <label><span>Q9. 환자의 콜레스테롤 지수를 입력하세요.<em class="require"></em></span></label>
        </div>
        <div class="register-form-box">
          <input type="text" autocomplete="off" required value="매우 안정">
          <label><span>Q10. 환자의 심리상태를 입력하세요.<em class="require"></em></span></label>
        </div>
      </div>
    </div>
  </div>

  <!--------------------------------------- 다시 작성 --------------------------------------->

  <!-- 환자 카드 -->
  <div id="dtx-patient-card" style="background-color: #ffffff; height: 100%; width: 1180px;">
    <div class="patient-index-list-wrap">
      <ul class="patient-index-list">
        <li class="patient-arrow-btn">
          <i class="fa-solid fa-angle-right"></i>
        </li>
        <li class="patient-arrow-btn">
          <i class="fa-solid fa-angle-right"></i>
        </li>
      </ul>
    </div>
    <div class="patient-card">
      <div class="patient-card-head">
        <span class="title"><span class="name">현환자</span> 환자 카드 <span class="patient-code">PA123</span></span>
        <i class="patient-card-close-btn fa-solid fa-x"></i>
      </div>
      <div class="patient-card-body">

        <div class="patient-card-content-wrap info ns-scrollbar">
          <!-- 환자간략정보-->
          <div class="patient-card-content patient-info">
            <div class="patient-profile-img">
              <div class="profile-img-wrap">
                <img src="/assets/images/sample/sample-patient-pic05.jpeg">
              </div>
            </div>
            <div class="patient-profile-info">
              <span class="name">현환자</span>
              <span>
                <span class="gender">남</span>
                <span class="age">41세</span>
              </span>
            </div>
          </div>
          <!-- 낙상 -->
          <div class="patient-card-content patient-health person-falling">
            <i class="ic-warning"></i>
            <span>
              <em>낙상</em>
              <em class="date">2023-03-19 19:22:09</em>
            </span>
          </div>
          <!-- 혈압 -->
          <div class="patient-card-content blood-pressure-pannel">
            <div class="label">
              <i class="ic-blood-pressure"></i>
            </div>
            <span class="title">
                <em>혈압</em>
                <em class="date"></em>
            </span>
            <span class="record">
              <em class="record-num"></em>
              <em class="record-volum">mmHg</em>
            </span>
          </div>
          <!-- 혈당 -->
          <div class="patient-card-content blood-sugar-pannel">
            <div class="label">
              <i class="ic-blood-sugar"></i>
            </div>
            <span class="title">
                <em>혈당</em>
                <em class="date"></em>
            </span>
            <span class="record">
              <em class="record-num"></em>
              <em class="record-volum">mg/dL</em>
            </span>
          </div>
          <!-- 맥박 -->
          <div class="patient-card-content pulse-pannel">
            <div class="label">
              <i class="ic-pulse"></i>
            </div>
            <span class="title">
                <em>맥박</em>
                <em class="date"></em>
            </span>
            <span class="record">
              <em class="record-num"></em>
              <em class="record-volum">회</em>
            </span>
          </div>
          <!-- 산소포화도 -->
          <div class="patient-card-content oxygen-pannel">
            <div class="label">
              <i class="ic-oxygen-saturation"></i>
            </div>
            <span class="title">
                <em>산소포화도</em>
                <em class="date"></em>
            </span>
            <span class="record">
              <em class="record-num"></em>
              <em class="record-volum">%</em>
            </span>
          </div>
          <!-- 걸음수 -->
          <div class="patient-card-content step-count-pannel">
            <div class="label">
              <i class="ic-number-steps"></i>
            </div>
            <span class="title">
                <em>걸음수</em>
                <em class="date"></em>
            </span>
            <span class="record">
              <em class="record-num"></em>
              <em class="record-volum">보</em>
            </span>
          </div>
          <!-- 칼로리 -->
          <div class="patient-card-content calorie-pannel">
            <div class="label">
              <i class="ic-calorie"></i>
            </div>
            <span class="title">
                <em>칼로리</em>
                <em class="date"></em>
            </span>
            <span class="record">
              <em class="record-num"></em>
              <em class="record-volum">Kcal</em>
            </span>
          </div>
          <!-- 인바디 -->
          <div class="patient-card-content inbody-pannel">
            <div class="label">
              <i class="ic-inbody"></i>
            </div>
            <span class="title">
                <em>인바디</em>
                <em class="date"></em>
            </span>
            <span class="record">
              <em class="record-num"></em>
              <em class="record-volum">%</em>
            </span>
          </div>
        </div>

        <div class="patient-card-content-wrap tab">
          <div class="patient-card-content">
            <ul class="tab-nav">
              <li class="tab-nav-item">
                <span class="tab-name">환자정보</span>
                <div></div>
              </li>
              <li class="tab-nav-item">
                <span class="tab-name">문진표</span>
                <div></div>
              </li>
              <li class="tab-nav-item">
                <span class="tab-name">측정이력</span>
                <div></div>
              </li>
              <li class="tab-nav-item">
                <span class="tab-name">기록</span>
                <div></div>
              </li>
              <li class="tab-nav-item">
                <span class="tab-name">헬스</span>
                <div></div>
              </li>
              <li class="tab-nav-item">
                <span class="tab-name">설정</span>
                <div></div>
              </li>
            </ul>
            <!-- 환자정보 -->
            <div class="tab-content ns-scrollbar">
              <!-- 환자 정보 카드 -->
              <div class="patient-info-card">
                <div class="progressbar-bar-wrap">
                  <span class="rate-title">입력 수행률 : <span class="rate">75%</span></span>
                  <div class="progressbar-bar">
                    <div class="progressbar-bar-success" style="background-color: #28cbfb; width: 75%; animation: patient-progressbar-bar 2s 1"></div>
                  </div>
                </div>
                <!-- 설문 제목 -->
                <div class="survey-form-style title">
                  <div class="top"></div>
                  <div class="left"></div>
                  <div class="survey-detail">
                    <div class="input-box">
                      <input type="text" placeholder="제목을 입력하세요" value="환자 정보 카드" readonly="">
                    </div>
                    <div class="input-box">
                      <input type="text" placeholder="설문지 설명" value="환자의 세부정보를 파악하고 관리하기 위함이다.">
                    </div>
                  </div>
                </div>
                <div class="survey-form-style item report">
                  <div class="top"></div>
                  <div class="left"></div>
                  <div class="survey-detail">
                    <div class="survey-item-title">
                      <div class="input-box">
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 성함은 어떻게 되십니까?" readonly>
                      </div>
                      <div class="require-select">
                        <span>필수</span>
                        <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                            <li class="survey-style-item">날짜형</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="survey-item-detail short-text">
                      <div class="input-box">
                        <input type="text" placeholder="병원에 등록된 실명으로 작성해 주세요." value="정환자" readonly>
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 생년월일은 어떻게 되십니까?" readonly>
                      </div>
                      <div class="require-select">
                        <span>필수</span>
                        <input class="require-tgl" type="checkbox" checked readonly>
                        <label class="require-btn"></label>
                      </div>
                      <div class="survey-style-select-box">
                        <div class="select-box">
                          <div class="select-item">
                            <span class="select-placeholder">날짜형</span>
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
                            <li class="survey-style-item">날짜형</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="survey-item-detail date">
                      <div class="input-box">
                      <input type="text" placeholder="년도 - 월 - 일" value="1988-10-20" readonly>
                    </div>
                      <button class="btn-calendar" style="visibility: hidden">
                        <i class="fa-solid fa-calendar-days"></i>
                      </button>
                    </div>
                  </div>
                </div>
                <div class="survey-form-style item report">
                  <div class="top"></div>
                  <div class="left"></div>
                  <div class="survey-detail">
                    <div class="survey-item-title">
                      <div class="input-box">
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 성별은 어떻게 되십니까?" readonly="">
                      </div>
                      <div class="require-select">
                        <span>필수</span>
                        <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                            <li class="survey-style-item">날짜형</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="survey-item-detail multiple-choice-radio">
                      <ul class="multiple-choice-wrap">
                        <li class="multiple-item">
                          <input type="radio">
                          <label class="radio-label"></label>
                          <input type="text" placeholder="옵션" value="남" readonly="">
                          <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                          <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                          <input type="radio" checked>
                          <label class="radio-label"></label>
                          <input type="text" placeholder="옵션" value="여" readonly="">
                          <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                          <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 스마트폰 번호는 어떻게 되십니까?" readonly>
                      </div>
                      <div class="require-select">
                        <span>필수</span>
                        <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                            <li class="survey-style-item">날짜형</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="survey-item-detail short-text">
                      <div class="input-box">
                        <input type="text" placeholder="병원에 등록된 실명으로 작성해 주세요." value="010-1234-5678" readonly>
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 과거 혹은 현재 해당 질병을 앍은 적이 있습니까?" readonly="">
                      </div>
                      <div class="require-select">
                        <span>필수</span>
                        <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                            <li class="survey-style-item">날짜형</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="survey-item-detail multiple-choice-check">
                      <ul class="multiple-choice-wrap">
                        <li class="multiple-item">
                          <input type="checkbox" checked>
                          <label class="check-label"></label>
                          <input type="text" placeholder="옵션" value="알레르기 질환 (음식포함)" readonly="">
                          <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                          <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                          <input type="checkbox">
                          <label class="check-label"></label>
                          <input type="text" placeholder="옵션" value="아토피피부염, 천식 등" readonly="">
                          <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                          <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                          <input type="checkbox">
                          <label class="check-label"></label>
                          <input type="text" placeholder="옵션" value="내과질환(당뇨, 심장병, 만성신부전증, 혈우병, 결핵, 간염, 악성종양 등)" readonly="">
                          <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                          <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                          <input type="checkbox" checked>
                          <label class="check-label"></label>
                          <input type="text" placeholder="옵션" value="난청, 중이염, 축농증, 알레르기성 비염 등" readonly="">
                          <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                          <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                          <input type="checkbox">
                          <label class="check-label"></label>
                          <input type="text" placeholder="옵션" value="선천적 또는 사고로 인한 운동장애">
                          <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                          <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                          <input type="checkbox">
                          <label class="check-label"></label>
                          <input type="text" placeholder="옵션" value="수술한 경우 및 기타 질환">
                          <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                          <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                          <input type="checkbox">
                          <label class="check-label"></label>
                          <input type="text" placeholder="옵션" value="해당사항 없음">
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 현재 치료중인 질병 또는 과거병력을 자세히 적어주세요." readonly="">
                      </div>
                      <div class="require-select">
                        <span>필수</span>
                        <input class="require-tgl" type="checkbox" checked>
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
                            <li class="survey-style-item">날짜형</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="survey-item-explanation">
                      <div class="input-box">
                        <input type="text" placeholder="질문 설명" value="환자분의 건강관리를 위해 병원에서 유의해야 할 사항이 있을 경우 질병명, 진료병원, 진료내용 등과 함께 적어주세요.">
                      </div>
                    </div>
                    <div class="survey-item-detail long-text">
                      <div class="textarea-box">
                        <textarea placeholder="특히, 알레르기나 약에 대한 부작용이 있는 경우 꼭 기입">계절성 콜린성 두드리러기 / 룰루병원 / 6개월간 병원통원 치료 및 먹는 약물치료 병행
                        </textarea>
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 하루 활동량에 대해 어떻게 생각하십니까?" readonly="">
                      </div>
                      <div class="require-select">
                        <span>필수</span>
                        <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                            <li class="survey-style-item">날짜형</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="survey-item-explanation">
                      <div class="input-box">
                        <input type="text" placeholder="질문 설명" value="환자의 하루 활동량에 대한 강도를 알아보기 위합입니다." readonly="">
                      </div>
                    </div>
                    <div class="survey-item-detail linear-scale">
                      <ul class="linear-scale-wrap">
                        <li class="linear-label">
                          <input type="text" placeholder="라벨" value="거의 정적이다" readonly="">
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
                            <input type="radio" checked>
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
                          <input type="text" placeholder="라벨" value="매우 활동적이다" readonly="">
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 생활 습관을 체크해 주세요." readonly="">
                      </div>
                      <div class="require-select">
                        <span>필수</span>
                        <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                            <li class="survey-style-item">날짜형</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="survey-item-explanation">
                      <div class="input-box">
                        <input type="text" placeholder="질문 설명" value="1=전혀 그렇지 않다 / 3=보통이다 / 5=매우 그렇다" readonly="">
                      </div>
                    </div>
                    <div class="survey-item-detail radio-grid">
                      <div class="grid-check-wrap">
                        <table>
                          <tbody><tr>
                            <th class="empty"></th>
                            <th>1</th>
                            <th>2</th>
                            <th>3</th>
                            <th>4</th>
                            <th>5</th>
                          </tr>
                          <tr>
                            <th>흡연</th>
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
                              <input type="radio" checked>
                              <label class="radio-label"></label>
                            </td>
                          </tr>
                          <tr>
                            <th>음주</th>
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
                              <input type="radio" checked>
                              <label class="radio-label"></label>
                            </td>
                            <td>
                              <input type="radio">
                              <label class="radio-label"></label>
                            </td>
                          </tr>
                          <tr>
                            <th>운동</th>
                            <td>
                              <input type="radio">
                              <label class="radio-label"></label>
                            </td>
                            <td>
                              <input type="radio" checked>
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
                            <th>식사</th>
                            <td>
                              <input type="radio">
                              <label class="radio-label"></label>
                            </td>
                            <td>
                              <input type="radio">
                              <label class="radio-label"></label>
                            </td>
                            <td>
                              <input type="radio" checked>
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
                            <th>수면</th>
                            <td>
                              <input type="radio" checked>
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
                          </tbody>
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 친절하게 느낀 직원 추천 부탁드립니다." readonly="">
                      </div>
                      <div class="require-select">
                        <span>필수</span>
                        <input class="require-tgl" type="checkbox" readonly="">
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
                            <li class="survey-style-item">날짜형</li>
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 조언하실 말씀이 있다면 부탁드립니다." readonly="">
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
                            <li class="survey-style-item">날짜형</li>
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
            <!-- 문진표 -->
            <div class="tab-content ns-scrollbar">
              <div class="patient-questionnaire list">
                <div class="card-search-wrap">
                  <span class="total-title">전체 문진표 : <span class="total">2개</span></span>
                </div>
                <table>
                  <thead>
                  <tr>
                    <th>No</th>
                    <th>문진표명</th>
                    <th>작성일</th>
                    <th>작성수행률</th>
                    <th>작성여부</th>
                  </tr>
                  </thead>
                  <tbody>
                  <tr>
                    <td>2</td>
                    <td>
                      <a class="view-detail">
                        일상생활 운동습관 문진표
                      </a></td>
                    <td>-</td>
                    <td class="low">0%</td>
                    <td>
                      <span class="incomplete">미작성</span>
                    </td>
                  </tr>
                  <tr>
                    <td>1</td>
                    <td>
                      <a class="view-detail">
                        기본 건강검진 문진표
                      </a>
                    </td>
                    <td>2021-10-10</td>
                    <td>90%</td>
                    <td>
                      <span class="complete">작성완료</span>
                    </td>
                  </tr>
                  </tbody>
                </table>
              </div>
            </div>
            <!-- 측정이력 -->
            <div class="tab-content ns-scrollbar">
              <div class="patient-record list">
                <div class="card-search-wrap">
                  <span class="total-title">전체 기록 : <span class="total">2개</span></span>
                </div>
                <table>
                  <thead>
                  <tr>
                    <th>No</th>
                    <th>기록명</th>
                    <th>기록일</th>
                    <th>기록수행률</th>
                  </tr>
                  </thead>
                  <tbody>
                  <tr>
                    <td>2</td>
                    <td>
                      <a class="view-detail">
                        2022-05-11 기록 측정
                      </a>
                    </td>
                    <td>2022-05-11</td>
                    <td class="low">20%</td>
                  </tr>
                  <tr>
                    <td>1</td>
                    <td>
                      <a class="view-detail">
                       2022-04-10 기룍 측정
                      </a>
                    </td>
                    <td>2022-04-10</td>
                    <td>90%</td>
                  </tr>
                  </tbody>
                </table>
              </div>
            </div>
            <!-- 기록 -->
            <div class="tab-content ns-scrollbar">
              <div class="patient-health">
                <ul class="patient-health-nav">
                  <li class="nav-item">
                    <i class="ic-blood-pressure"></i>
                    <span class="record">
                      <em>138/72</em>
                      <em>mmHg</em>
                    </span>
                    <span class="title">혈압</span>
                  </li>
                  <li class="nav-item">
                    <i class="ic-blood-sugar"></i>
                    <span class="record">
                      <em>75</em>
                      <em>mg/dL</em>
                    </span>
                    <span class="title">혈당</span>
                  </li>
                  <li class="nav-item">
                    <i class="ic-pulse"></i>
                    <span class="record">
                      <em>159</em>
                      <em>회</em>
                    </span>
                    <span class="title">맥박</span>
                  </li>
                  <li class="nav-item">
                    <i class="ic-oxygen-saturation"></i>
                    <span class="record">
                      <em>27</em>
                      <em>%</em>
                    </span>
                    <span class="title">산소포화도</span>
                  </li>
                </ul>
                <div class="patient-health-contents">
                  <!-- 건강 : 혈압 -->
                  <div class="patient-health-content blood-pressure">
                    <!-- 범위 -->
                    <div class="scope">
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>이번주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>4주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>12주</span>
                    </div>
                    <!-- 그래프 -->
                    <div class="graph">
                      <div class="graph-area">
                        <span class="graph-title">아침</span>
                        <div class="graph-box">
                          <!-- 그래프 샘플 -->
                          <img src="/assets/images/sample/sample-graph_01.png" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <ul class="graph-date">
                          <li><span>월</span></li>
                          <li><span>화</span></li>
                          <li><span>수</span></li>
                          <li><span>목</span></li>
                          <li><span>금</span></li>
                          <li><span>토</span></li>
                          <li><span>일</span></li>
                        </ul>
                        <span class="graph-title">자기 전</span>
                        <div class="graph-box">
                          <!-- 그래프 샘플 -->
                          <img src="/assets/images/sample/sample-graph_01.png" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <ul class="graph-date">
                          <li><span>월</span></li>
                          <li><span>화</span></li>
                          <li><span>수</span></li>
                          <li><span>목</span></li>
                          <li><span>금</span></li>
                          <li><span>토</span></li>
                          <li><span>일</span></li>
                        </ul>
                      </div>
                      <div class="graph-avg">
                        <span class="avg am">
                          <em class="title">아침 평균</em>
                          <em class="record">138 / 72</em>
                        </span>
                        <span class="avg pm">
                          <em class="title">자기 전 평균</em>
                          <em class="record">138 / 72</em>
                        </span>
                        <span class="avg etc">
                          <em class="title">기타</em>
                          <em class="record">138 / 72</em>
                        </span>
                      </div>
                    </div>
                    <!-- 종합 -->
                    <div class="record-all-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="date">07/20 ~ 09/27</span>
                          <div class="btn-wrap">
                            <div class="btn-left">
                              <i class="ic-arrow-left"></i>
                            </div>
                            <div class="btn-right">
                              <i class="ic-arrow-right"></i>
                            </div>
                          </div>
                        </div>
                        <ul class="record-content">
                          <li>
                            <span class="day">월</span>
                            <span class="record">
                              <em>138/78</em>
                              <em>138/78</em>
                              <em>138/78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">화</span>
                            <span class="record">
                              <em>138/78</em>
                              <em>138/78</em>
                              <em>138/78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">수</span>
                            <span class="record">
                              <em>138/78</em>
                              <em>138/78</em>
                              <em>138/78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">목</span>
                            <span class="record">
                              <em>138/78</em>
                              <em>138/78</em>
                              <em>138/78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">금</span>
                            <span class="record">
                              <em>138/78</em>
                              <em>138/78</em>
                              <em>138/78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">토</span>
                            <span class="record">
                              <em>138/78</em>
                              <em>138/78</em>
                              <em>138/78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">일</span>
                            <span class="record">
                              <em>138/78</em>
                              <em>138/78</em>
                              <em>138/78</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                    <!-- 측정이력 -->
                    <div class="record-item-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="title">측정이력</span>
                          <div class="btn-wrap">
                            <div class="btn-left">
                              <i class="ic-arrow-left"></i>
                            </div>
                            <div class="btn-right">
                              <i class="ic-arrow-right"></i>
                            </div>
                          </div>
                        </div>
                        <ul class="record-content">
                          <li>
                            <span class="item-title">기립</span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                      <div class="record">
                        <div class="record-head">
                          <span></span>
                          <div class="btn-wrap">
                            <div class="btn-left">
                              <i class="ic-arrow-left"></i>
                            </div>
                            <div class="btn-right">
                              <i class="ic-arrow-right"></i>
                            </div>
                          </div>
                        </div>
                        <ul class="record-content">
                          <li>
                            <span class="item-title">식사</span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">11/18</span>
                            <span class="record">
                              <em>120/8</em>
                              <em>100/60</em>
                              <em>-20/-20</em>
                              <em>75</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <!-- 건강 : 혈당 -->
                  <div class="patient-health-content blood-sugar">
                    <!-- 범위 -->
                    <div class="scope">
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>이번주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>4주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>12주</span>
                    </div>
                    <!-- 그래프 -->
                    <div class="graph">
                      <div class="graph-area">
                        <span class="graph-title">
                          <em>고혈당</em>
                          <em>저혈당</em>
                        </span>
                        <div class="graph-box">
                          <!-- 그래프 샘플 -->
                          <img src="/assets/images/sample/sample-graph_02.png" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <ul class="graph-date">
                          <li><span>월</span></li>
                          <li><span>화</span></li>
                          <li><span>수</span></li>
                          <li><span>목</span></li>
                          <li><span>금</span></li>
                          <li><span>토</span></li>
                          <li><span>일</span></li>
                        </ul>
                      </div>
                      <div class="graph-avg">
                        <span class="avg">
                          <em class="title">아침 평균</em>
                          <em class="record">138 / 72</em>
                        </span>
                        <span class="avg">
                          <em class="title">점심 평균</em>
                          <em class="record">138 / 72</em>
                        </span>
                        <span class="avg">
                          <em class="title">저녁 평균</em>
                          <em class="record">138 / 72</em>
                        </span>
                        <span class="avg">
                          <em class="title">자기 전 평균</em>
                          <em class="record">138 / 72</em>
                        </span>
                      </div>
                    </div>
                    <!-- 종합 -->
                    <div class="record-all-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="date">07/20 ~ 09/27</span>
                          <div class="btn-wrap">
                            <div class="btn-left">
                              <i class="ic-arrow-left"></i>
                            </div>
                            <div class="btn-right">
                              <i class="ic-arrow-right"></i>
                            </div>
                          </div>
                        </div>
                        <ul class="record-content">
                          <li>
                            <span class="day">월</span>
                            <span class="record">
                              <em>96/103</em>
                              <em>96/103</em>
                              <em>-/96</em>
                              <em>96/-</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">화</span>
                            <span class="record">
                              <em>96/103</em>
                              <em>96/103</em>
                              <em>-/96</em>
                              <em>96/-</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">수</span>
                            <span class="record">
                              <em>96/103</em>
                              <em>96/103</em>
                              <em>-/96</em>
                              <em>96/-</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">목</span>
                            <span class="record">
                              <em>96/103</em>
                              <em>96/103</em>
                              <em>-/96</em>
                              <em>96/-</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">금</span>
                            <span class="record">
                              <em>96/103</em>
                              <em>96/103</em>
                              <em>-/96</em>
                              <em>96/-</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">토</span>
                            <span class="record">
                              <em>96/103</em>
                              <em>96/103</em>
                              <em>-/96</em>
                              <em>96/-</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">일</span>
                            <span class="record">
                              <em>96/103</em>
                              <em>96/103</em>
                              <em>-/96</em>
                              <em>96/-</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                    <!-- 측정이력 -->
                    <div class="record-item-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="title"></span>
                          <div class="btn-wrap">
                            <div class="btn-left">
                              <i class="ic-arrow-left"></i>
                            </div>
                            <div class="btn-right">
                              <i class="ic-arrow-right"></i>
                            </div>
                          </div>
                        </div>
                        <ul class="record-content">
                          <li class="low-blood-sugar">
                            <span class="title">저혈당</span>
                            <span class="record">
                              <i class="ic-arrow"></i>
                              <em>70</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">8/31</span>
                            <span class="record">
                              <em>96</em>
                              <em>18:06</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">7/13</span>
                            <span class="record">
                              <em>96</em>
                              <em>18:06</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">7/08</span>
                            <span class="record">
                              <em>96</em>
                              <em>18:06</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">6/28</span>
                            <span class="record">
                              <em>96</em>
                              <em>18:06</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">6/25</span>
                            <span class="record">
                              <em>96</em>
                              <em>18:06</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">6/01</span>
                            <span class="record">
                              <em>96</em>
                              <em>18:06</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <!-- 건강 : 맥박 -->
                  <div class="patient-health-content pulse">
                    <!-- 범위 -->
                    <div class="scope">
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>이번주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>4주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>12주</span>
                    </div>
                    <!-- 그래프 -->
                    <div class="graph">
                      <div class="graph-area">
                        <span class="graph-title">
                        </span>
                        <div class="graph-box">
                          <!-- 그래프 샘플 -->
                          <img src="/assets/images/sample/sample-graph_03.png" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <ul class="graph-date">
                          <li><span>월</span></li>
                          <li><span>화</span></li>
                          <li><span>수</span></li>
                          <li><span>목</span></li>
                          <li><span>금</span></li>
                          <li><span>토</span></li>
                          <li><span>일</span></li>
                        </ul>
                      </div>
                      <div class="graph-avg">
                        <span class="avg">
                          <em class="title">최고 평균</em>
                          <em class="record">75</em>
                        </span>
                        <span class="avg">
                          <em class="title">최저 평균</em>
                          <em class="record">112</em>
                        </span>
                      </div>
                    </div>
                    <!-- 종합 -->
                    <div class="record-all-list">
                      <div class="record">
                        <ul class="record-content">
                          <li>
                            <span class="day">월</span>
                            <span class="record">
                              <em>96</em>
                              <em>103</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">화</span>
                            <span class="record">
                              <em>96</em>
                              <em>103</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">수</span>
                            <span class="record">
                              <em>96</em>
                              <em>103</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">목</span>
                            <span class="record">
                              <em>96</em>
                              <em>103</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">금</span>
                            <span class="record">
                              <em>96</em>
                              <em>103</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">토</span>
                            <span class="record">
                              <em>96</em>
                              <em>103</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">일</span>
                            <span class="record">
                              <em>96</em>
                              <em>103</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                    <!-- 측정이력 -->
                    <div class="record-item-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="title">측정이력</span>
                        </div>
                        <ul class="record-content">
                          <li class="active">
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <!-- 건강 : 산소포화 -->
                  <div class="patient-health-content oxygen-saturation">
                    <!-- 범위 -->
                    <div class="scope">
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>이번주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>4주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>12주</span>
                    </div>
                    <!-- 그래프 -->
                    <div class="graph">
                      <div class="graph-area">
                        <span class="graph-title">
                        </span>
                        <div class="graph-box">
                          <!-- 그래프 샘플 -->
                          <img src="/assets/images/sample/sample-graph_04.png" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <ul class="graph-date">
                          <li><span>월</span></li>
                          <li><span>화</span></li>
                          <li><span>수</span></li>
                          <li><span>목</span></li>
                          <li><span>금</span></li>
                          <li><span>토</span></li>
                          <li><span>일</span></li>
                        </ul>
                      </div>
                      <div class="graph-avg">
                        <span class="avg">
                          <em class="title">최저 평균</em>
                          <em class="record">62</em>
                        </span>
                      </div>
                    </div>
                    <!-- 종합 -->
                    <div class="record-all-list">
                      <div class="record">
                        <ul class="record-content">
                          <li>
                            <span class="day">월</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">화</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">수</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">목</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">금</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">토</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">일</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                    <!-- 측정이력 -->
                    <div class="record-item-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="title">측정이력</span>
                        </div>
                        <ul class="record-content">
                          <li class="active">
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- 헬스 -->
            <div class="tab-content ns-scrollbar">
              <div class="patient-health">
                <ul class="patient-health-nav">
                  <li class="nav-item">
                    <i class="ic-number-steps"></i>
                    <span class="record">
                      <em>12,817</em>
                      <em>보</em>
                    </span>
                    <span class="title">걸음수</span>
                  </li>
                  <li class="nav-item">
                    <i class="ic-calorie"></i>
                    <span class="record">
                      <em>2,100</em>
                      <em>Kcal</em>
                    </span>
                    <span class="title">칼로리</span>
                  </li>
                  <li class="nav-item">
                    <i class="ic-inbody"></i>
                    <span class="record">
                      <em>38</em>
                      <em>%</em>
                    </span>
                    <span class="title">인바디</span>
                  </li>
                </ul>
                <div class="patient-health-contents">
                  <!-- 헬스 : 걸음수 -->
                  <div class="patient-health-content number-steps">
                    <!-- 범위 -->
                    <div class="scope">
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>이번주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>4주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>12주</span>
                    </div>
                    <!-- 그래프 -->
                    <div class="graph">
                      <div class="graph-area">
                        <span class="graph-title">
                        </span>
                        <div class="graph-box">
                          <!-- 그래프 샘플 -->
                          <img src="/assets/images/sample/sample-graph_04.png" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <ul class="graph-date">
                          <li><span>월</span></li>
                          <li><span>화</span></li>
                          <li><span>수</span></li>
                          <li><span>목</span></li>
                          <li><span>금</span></li>
                          <li><span>토</span></li>
                          <li><span>일</span></li>
                        </ul>
                      </div>
                      <div class="graph-avg">
                        <span class="avg">
                          <em class="title">평균</em>
                          <em class="record">16,865</em>
                        </span>
                      </div>
                    </div>
                    <!-- 종합 -->
                    <div class="record-all-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="date">07/20 ~ 09/27</span>
                          <div class="btn-wrap">
                            <div class="btn-left">
                              <i class="ic-arrow-left"></i>
                            </div>
                            <div class="btn-right">
                              <i class="ic-arrow-right"></i>
                            </div>
                          </div>
                        </div>
                        <ul class="record-content">
                          <li>
                            <span class="day">월</span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">화</span>
                            <span class="record">
                              <em>8,700</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">수</span>
                            <span class="record">
                              <em>15,200</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">목</span>
                            <span class="record">
                              <em>20,001</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">금</span>
                            <span class="record">
                              <em>13,580</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">토</span>
                            <span class="record">
                              <em>56</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">일</span>
                            <span class="record">
                              <em>6,743</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                    <!-- 측정이력 -->
                    <div class="record-item-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="title">측정이력</span>
                        </div>
                        <ul class="record-content">
                          <li class="active">
                            <span class="date">
                              <em>2023년 03월19일</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                            <div class="bar-graph">
                              <div class="graph-wrap">
                                <ul class="bar-frame">
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                </ul>
                                <div class="bar-gray" style="width:93.856%;"></div>
                                <ul class="bar-color">
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                </ul>
                                <div class="graph-x-name">
                                  <span>0</span>
                                  <span>1만</span>
                                  <span>2만 이상</span>
                                </div>
                              </div>
                            </div>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                            </span>
                            <span class="record">
                              <em>8,700</em>
                            </span>
                            <div class="bar-graph">
                              <div class="graph-wrap">
                                <ul class="bar-frame">
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                </ul>
                                <div class="bar-gray" style="width: 66.4%;"></div>
                                <ul class="bar-color">
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                </ul>
                                <div class="graph-x-name">
                                  <span>0</span>
                                  <span>1만</span>
                                  <span>2만 이상</span>
                                </div>
                              </div>
                            </div>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                            </span>
                            <span class="record">
                              <em>15,200</em>
                            </span>
                            <div class="bar-graph">
                              <div class="graph-wrap">
                                <ul class="bar-frame">
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                </ul>
                                <div class="bar-gray" style="width: 22.3%;"></div>
                                <ul class="bar-color">
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                </ul>
                                <div class="graph-x-name">
                                  <span>0</span>
                                  <span>1만</span>
                                  <span>2만 이상</span>
                                </div>
                              </div>
                            </div>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                            </span>
                            <span class="record">
                              <em>20,001</em>
                            </span>
                            <div class="bar-graph">
                              <div class="graph-wrap">
                                <ul class="bar-frame">
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                </ul>
                                <div class="bar-gray" style="width: 0%;"></div>
                                <ul class="bar-color">
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                </ul>
                                <div class="graph-x-name">
                                  <span>0</span>
                                  <span>1만</span>
                                  <span>2만 이상</span>
                                </div>
                              </div>
                            </div>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                            </span>
                            <span class="record">
                              <em>13,580</em>
                            </span>
                            <div class="bar-graph">
                              <div class="graph-wrap">
                                <ul class="bar-frame">
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                </ul>
                                <div class="bar-gray" style="width: 37.23567%;"></div>
                                <ul class="bar-color">
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                  <li></li>
                                </ul>
                                <div class="graph-x-name">
                                  <span>0</span>
                                  <span>1만</span>
                                  <span>2만 이상</span>
                                </div>
                              </div>
                            </div>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <!-- 헬스 : 칼로리 -->
                  <div class="patient-health-content calorie">
                    <!-- 범위 -->
                    <div class="scope">
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>이번주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>4주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>12주</span>
                    </div>
                    <!-- 그래프 -->
                    <div class="graph">
                      <div class="graph-area">
                        <span class="graph-title">
                        </span>
                        <div class="graph-box">
                          <!-- 그래프 샘플 -->
                          <img src="/assets/images/sample/sample-graph_04.png" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <ul class="graph-date">
                          <li><span>월</span></li>
                          <li><span>화</span></li>
                          <li><span>수</span></li>
                          <li><span>목</span></li>
                          <li><span>금</span></li>
                          <li><span>토</span></li>
                          <li><span>일</span></li>
                        </ul>
                      </div>
                      <div class="graph-avg">
                        <span class="avg">
                          <em class="title">평균</em>
                          <em class="record">16,865</em>
                        </span>
                      </div>
                    </div>
                    <!-- 종합 -->
                    <div class="record-all-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="date">07/20 ~ 09/27</span>
                          <div class="btn-wrap">
                            <div class="btn-left">
                              <i class="ic-arrow-left"></i>
                            </div>
                            <div class="btn-right">
                              <i class="ic-arrow-right"></i>
                            </div>
                          </div>
                        </div>
                        <ul class="record-content">
                          <li>
                            <span class="day">월</span>
                            <span class="record">
                              <em>785</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">화</span>
                            <span class="record">
                              <em>100</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">수</span>
                            <span class="record">
                              <em>500</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">목</span>
                            <span class="record">
                              <em>1,000</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">금</span>
                            <span class="record">
                              <em>983</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">토</span>
                            <span class="record">
                              <em>48</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">일</span>
                            <span class="record">
                              <em>890</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                    <!-- 측정이력 -->
                    <div class="record-item-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="title">측정이력</span>
                        </div>
                        <ul class="record-content">
                          <li class="active">
                            <span class="date">
                              <em>2023년 03월19일</em>
                            </span>
                            <span class="record-time">
                              <em>12:47:02</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                            </span>
                            <span class="record-time">
                              <em>12:47:02</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                            </span>
                            <span class="record-time">
                              <em>12:47:02</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                            </span>
                            <span class="record-time">
                              <em>12:47:02</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                            </span>
                            <span class="record-time">
                              <em>12:47:02</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <!-- 헬스 : 인바디 -->
                  <div class="patient-health-content inbody">
                    <!-- 범위 -->
                    <div class="scope">
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>이번주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>4주</span>
                      <input type="radio">
                      <label class="radio-label"></label>
                      <span>12주</span>
                    </div>
                    <!-- 그래프 -->
                    <div class="graph">
                      <div class="graph-area">
                        <span class="graph-title">
                        </span>
                        <div class="graph-box">
                          <!-- 그래프 샘플 -->
                          <img src="/assets/images/sample/sample-graph_04.png" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <ul class="graph-date">
                          <li><span>월</span></li>
                          <li><span>화</span></li>
                          <li><span>수</span></li>
                          <li><span>목</span></li>
                          <li><span>금</span></li>
                          <li><span>토</span></li>
                          <li><span>일</span></li>
                        </ul>
                      </div>
                      <div class="graph-avg">
                        <span class="avg">
                          <em class="title">평균</em>
                          <em class="record">16,865</em>
                        </span>
                      </div>
                    </div>
                    <!-- 종합 -->
                    <div class="record-all-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="date">07/20 ~ 09/27</span>
                          <div class="btn-wrap">
                            <div class="btn-left">
                              <i class="ic-arrow-left"></i>
                            </div>
                            <div class="btn-right">
                              <i class="ic-arrow-right"></i>
                            </div>
                          </div>
                        </div>
                        <ul class="record-content">
                          <li>
                            <span class="day">월</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">화</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">수</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">목</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">금</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">토</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                          <li>
                            <span class="day">일</span>
                            <span class="record">
                              <em>78</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                    <!-- 측정이력 -->
                    <div class="record-item-list">
                      <div class="record">
                        <div class="record-head">
                          <span class="title">측정이력</span>
                        </div>
                        <ul class="record-content">
                          <li class="active">
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                          <li>
                            <span class="date">
                              <em>2023년 03월19일</em>
                              <em>19:22:09</em>
                            </span>
                            <span class="record">
                              <em>72</em>
                            </span>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- 설정 -->
            <div class="tab-content ns-scrollbar">tab-6</div>
          </div>
        </div>

      </div>
    </div>
  </div>

  <!--  스케쥴 등록 -->
  <div id="dtx-register-schedule" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <i class="panel-close-btn"></i>
      <span class="panel-title">일정 등록</span>
    </div>
    <div class="panel-body ns-scrollbar survey-form">
      <!-- 저장 -->
      <div class="panel-form-btn-box">
        <button class="btn btn-submit"><span>등록</span></button>
      </div>
    </div>
  </div>
  <!--------------------------------------- 다시 작성 --------------------------------------->

  <!-- 메모 -->
  <div id="dtx-calendar-memo" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <i class="panel-close-btn"></i>
      <span class="panel-title">메모 등록하기</span>
    </div>
    <div class="panel-body ns-scrollbar memo-form">
      <div class="text-form-style category">
        <label class="form-label">구분<span class="require">*</span></label>
        <div class="form-box">
          <select>
            <option>진료</option>
            <option>기타</option>
          </select>
          <i class="fa-solid fa-chevron-down"></i>
        </div>
      </div>
      <div class="text-form-style title">
        <label class="form-label">제목<span class="require">*</span></label>
        <div class="form-box">
          <input type="text">
        </div>
      </div>
      <div class="text-form-style date">
        <label class="form-label">등록일<span class="require">*</span></label>
        <div class="form-box">
          <input type="date">
        </div>
      </div>
      <div class="text-form-style text">
        <label class="form-label">내용<span class="require">*</span></label>
        <div id="editor-memo"></div>
      </div>
      <!-- 저장 -->
      <div class="panel-form-btn-box">
        <button class="btn btn-submit"><span>등록</span></button>
      </div>
    </div>
  </div>

  <!-- 환자등록 -->
  <div id="dtx-register-patient" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <i class="panel-close-btn"></i>
      <span class="panel-title">환자 등록하기</span>
    </div>
    <div class="panel-body ns-scrollbar survey-form">
      <!-- 설문 제목 -->
      <div class="survey-form-style title">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="input-box">
            <input type="text" placeholder="제목을 입력하세요" value="환자 정보 카드" readonly="">
          </div>
          <div class="input-box">
            <input type="text" placeholder="설문지 설명" value="환자의 세부정보를 파악하고 관리하기 위함이다.">
          </div>
        </div>
      </div>
      <div class="survey-form-style item report">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 성함은 어떻게 되십니까?" readonly>
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                  <li class="survey-style-item">날짜형</li>
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
              <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 생년월일은 어떻게 되십니까?">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked readonly>
              <label class="require-btn"></label>
            </div>
            <div class="survey-style-select-box">
              <div class="select-box">
                <div class="select-item">
                  <span class="select-placeholder">날짜형</span>
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-detail date">
            <div class="input-box">
              <input type="date" placeholder="년도 - 월 - 일">
            </div>
            <button class="btn-calendar" style="visibility: hidden">
              <i class="fa-solid fa-calendar-days"></i>
            </button>
          </div>
        </div>
      </div>
      <div class="survey-form-style item report">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 성별은 어떻게 되십니까?" readonly="">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-detail multiple-choice-radio">
            <ul class="multiple-choice-wrap">
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="남" readonly="">
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="여" readonly="">
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
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
              <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 스마트폰 번호는 어떻게 되십니까?" readonly>
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                  <li class="survey-style-item">날짜형</li>
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
              <input type="text" placeholder="질문을 입력하세요" value="Q. 과거 혹은 현재 해당 질병을 앍은 적이 있습니까?" readonly="">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-detail multiple-choice-check">
            <ul class="multiple-choice-wrap">
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="알레르기 질환 (음식포함)" readonly="">
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="아토피피부염, 천식 등" readonly="">
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="내과질환(당뇨, 심장병, 만성신부전증, 혈우병, 결핵, 간염, 악성종양 등)" readonly="">
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="난청, 중이염, 축농증, 알레르기성 비염 등" readonly="">
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="선천적 또는 사고로 인한 운동장애">
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="수술한 경우 및 기타 질환">
                <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="해당사항 없음">
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
              <input type="text" placeholder="질문을 입력하세요" value="Q. 현재 치료중인 질병 또는 과거병력을 자세히 적어주세요." readonly="">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked>
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-explanation">
            <div class="input-box">
              <input type="text" placeholder="질문 설명" value="환자분의 건강관리를 위해 병원에서 유의해야 할 사항이 있을 경우 질병명, 진료병원, 진료내용 등과 함께 적어주세요.">
            </div>
          </div>
          <div class="survey-item-detail long-text">
            <div class="textarea-box">
                        <textarea placeholder="특히, 알레르기나 약에 대한 부작용이 있는 경우 꼭 기입">
                        </textarea>
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
              <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 하루 활동량에 대해 어떻게 생각하십니까?" readonly="">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-explanation">
            <div class="input-box">
              <input type="text" placeholder="질문 설명" value="환자의 하루 활동량에 대한 강도를 알아보기 위합입니다." readonly="">
            </div>
          </div>
          <div class="survey-item-detail linear-scale">
            <ul class="linear-scale-wrap">
              <li class="linear-label">
                <input type="text" placeholder="라벨" value="거의 정적이다" readonly="">
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
                <input type="text" placeholder="라벨" value="매우 활동적이다" readonly="">
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
              <input type="text" placeholder="질문을 입력하세요" value="Q. 환자분의 생활 습관을 체크해 주세요." readonly="">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked="" readonly="">
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-explanation">
            <div class="input-box">
              <input type="text" placeholder="질문 설명" value="1=전혀 그렇지 않다 / 3=보통이다 / 5=매우 그렇다" readonly="">
            </div>
          </div>
          <div class="survey-item-detail radio-grid">
            <div class="grid-check-wrap">
              <table>
                <tbody><tr>
                  <th class="empty"></th>
                  <th>1</th>
                  <th>2</th>
                  <th>3</th>
                  <th>4</th>
                  <th>5</th>
                </tr>
                <tr>
                  <th>흡연</th>
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
                  <th>음주</th>
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
                  <th>운동</th>
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
                  <th>식사</th>
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
                  <th>수면</th>
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
                </tbody>
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
              <input type="text" placeholder="질문을 입력하세요" value="Q. 친절하게 느낀 직원 추천 부탁드립니다." readonly="">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" readonly="">
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
                  <li class="survey-style-item">날짜형</li>
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
              <input type="text" placeholder="질문을 입력하세요" value="Q. 조언하실 말씀이 있다면 부탁드립니다." readonly="">
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
                  <li class="survey-style-item">날짜형</li>
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
      <!-- 저장 -->
      <div class="panel-form-btn-box">
        <button class="btn btn-submit"><span>등록</span></button>
      </div>
    </div>
  </div>
  <!-- 콘텐츠 -->
  <div id="dtx-contents" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <i class="panel-close-btn"></i>
      <span class="panel-title">콘텐츠 등록하기</span>
    </div>
    <div class="panel-body ns-scrollbar contents-form">
      <div class="text-form-style category">
        <label class="form-label">구분<span class="require">*</span></label>
        <div class="form-box">
          <select id="contents_type">
            <option value="H">건강정보</option>
            <option value="W">식단정보</option>
            <option value="D">운동정보</option>
            <option value="E">기타정보</option>
          </select>
          <i class="fa-solid fa-chevron-down"></i>
        </div>
      </div>
      <div class="text-form-style title">
        <label class="form-label">제목<span class="require">*</span></label>
        <div class="form-box">
          <input type="text" id="contents_title">
        </div>
      </div>
      <div class="text-form-style text">
        <label class="form-label">내용<span class="require">*</span></label>
        <div id="editor-contents"></div>
      </div>
      <div class="text-form-style img">
        <label class="form-label">첨부사진<span class="require">*</span></label>
        <div class="form-box contents-img">
          <input type="file">
        </div>
<!--        <div class="img-file-add-box">-->
<!--          <button class="btn-add-img">-->
<!--            <div class="icon-plus"></div>-->
<!--            <span class="btn-name">사진<em class="cnt">0</em></span>-->
<!--          </button>-->
<!--          <div class="img-file-wrap ns-scrollbar-none">-->
<!--            <ul class="img-file-list">-->
<!--              <li class="img-item">-->
<!--                <img src="/assets/images/sample/sample-content-01.jpeg">-->
<!--              </li>-->
<!--              <li class="img-item">-->
<!--                <img src="/assets/images/sample/sample-content-02.jpeg">-->
<!--              </li>-->
<!--              <li class="img-item">-->
<!--                <img src="/assets/images/sample/sample-content-03.jpeg">-->
<!--              </li>-->
<!--            </ul>-->
<!--          </div>-->
<!--        </div>-->
      </div>
      <div class="text-form-style contents-thumbnail hide">
        <img>
      </div>
      <div class="text-form-style video-link">
        <label class="form-label">유튜브 주소</label>
        <div class="form-box">
          <input type="text">
        </div>
      </div>
      <div class="text-form-style-group">
        <label class="form-label">제공대상<span class="require">*</span></label>
        <div class="group">
          <div class="text-form-style patient radio horizontal">
            <label class="form-label">환자타입</label>
            <div class="form-box radio horizontal">
              <div class="form-item">
                <input type="radio" id="patient-basic">
                <label class="radio-label" for="patient-basic"></label>
                <span>일반</span>
              </div>
              <div class="form-item">
                <input type="radio" id="patient-control">
                <label class="radio-label" for="patient-control"></label>
                <span>콘트롤</span>
              </div>
              <div class="form-item">
                <input type="radio" id="patient-all">
                <label class="radio-label" for="patient-all"></label>
                <span>모두</span>
              </div>
            </div>
          </div>
          <div class="text-form-style clinical radio horizontal">
            <label class="form-label">임상타입</label>
            <div class="form-box radio horizontal">
              <div class="form-item">
                <input type="radio" id="blood-pressure">
                <label class="radio-label" for="blood-pressure"></label>
                <span>혈압</span>
              </div>
              <div class="form-item">
                <input type="radio" id="blood-sugar">
                <label class="radio-label" for="blood-sugar"></label>
                <span>혈당</span>
              </div>
              <div class="form-item">
                <input type="radio" id="clinical-all">
                <label class="radio-label" for="clinical-all"></label>
                <span>모두</span>
              </div>
            </div>
          </div>
          <div class="text-form-style gender radio horizontal">
            <label class="form-label">성별</label>
            <div class="form-box radio horizontal">
              <div class="form-item">
                <input type="radio" id="gender-male">
                <label class="radio-label" for="gender-male"></label>
                <span>남</span>
              </div>
              <div class="form-item">
                <input type="radio" id="gender-female">
                <label class="radio-label" for="gender-female"></label>
                <span>여</span>
              </div>
              <div class="form-item">
                <input type="radio" id="gender-all">
                <label class="radio-label" for="gender-all"></label>
                <span>모두</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="text-form-style contents-provide">
        <label class="form-label">제공시기<span class="require">*</span></label>
        <div class="form-box-wrap">
          <div class="form-box">
            <select id="timeWeek">
              <option value="0">주</option>
              <option value="1">1주</option>
              <option value="2">2주</option>
              <option value="3">3주</option>
              <option value="4">4주</option>
              <option value="5">5주</option>
              <option value="6">6주</option>
              <option value="7">7주</option>
            </select>
            <i class="fa-solid fa-chevron-down"></i>
          </div>
          <div class="form-box">
            <select id="timeDay">
              <option value="0">일</option>
              <option value="1">1일</option>
              <option value="2">2일</option>
              <option value="3">3일</option>
              <option value="4">4일</option>
              <option value="5">5일</option>
              <option value="6">6일</option>
            </select>
            <i class="fa-solid fa-chevron-down"></i>
          </div>
          <div class="form-box">
            <select id="timeHour">
              <option value="0">시간</option>
              <option value="1">1시간</option>
              <option value="2">2시간</option>
              <option value="3">3시간</option>
              <option value="4">4시간</option>
              <option value="5">5시간</option>
              <option value="6">6시간</option>
              <option value="7">7시간</option>
              <option value="8">8시간</option>
              <option value="9">9시간</option>
              <option value="10">10시간</option>
              <option value="11">11시간</option>
              <option value="12">12시간</option>
              <option value="13">13시간</option>
              <option value="14">14시간</option>
              <option value="15">15시간</option>
              <option value="16">16시간</option>
              <option value="17">17시간</option>
              <option value="18">18시간</option>
              <option value="19">19시간</option>
              <option value="20">20시간</option>
              <option value="21">21시간</option>
              <option value="22">22시간</option>
              <option value="23">23시간</option>
            </select>
            <i class="fa-solid fa-chevron-down"></i>
          </div>
        </div>

      </div>
      <div class="text-form-style tag">
        <label class="form-label">콘텐츠 태그<span class="require">*</span></label>
        <div class="form-box">
          <input type="text" id="hashTag" placeholder="키워드 입력 후 Enter키를 누르세요 (최대 5개 등록)">
        </div>
        <div class="hashTage-wrap">
        </div>
      </div>
      <!-- 저장 -->
      <div class="panel-form-btn-box">
        <button class="btn btn-submit"><span>등록</span></button>
      </div>
    </div>
  </div>

  <div id="dtx-contents-mobile" style="background-color: #ffffff; height: 100%; width: 500px;">
    <div class="panel-head">
      <i class="panel-close-btn"></i>
      <span class="panel-title">모바일 화면 보기</span>
    </div>
    <div class="panel-body ns-scrollbar contents-form">
      <div class="content-detail-wrap">
        <div class="content-detail">
          <div class="content-detail-top">
            <div class="content-detail-title">
              <span class="content-label">건강정보</span>
              <span class="title">비만탈출~ 보건소에서 무료로 관리받으세요!</span>
              <div class="content-info-tag">
                <span class="keyword-tag">#건강</span>
                <span class="keyword-tag">#운동</span>
                <span class="keyword-tag">#식단</span>
                <span class="keyword-tag">#걷기</span>
                <span class="keyword-tag">#만오천보걷기</span>
              </div>
            </div>
            <div class="content-detail-info">
              <div class="content-detail-info-left">
                <span class="name">정아름</span>
                <span class="time">2022.05.05</span>
              </div>
              <div class="content-detail-info-right">
                <span class="total-view">조회<em>12,300</em></span>
              </div>
            </div>
          </div>
          <div class="content-detail-text">
            <div class="sample">
              <img src="/assets/images/sample/sample-content-14.jpeg" alt="content-img">

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!--------------------------------------- DTx 관리 --------------------------------------->
  <!-- 관리자 관리 -->
  <div id="dtx-admin" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <i class="panel-close-btn"></i>
      <span class="panel-title">관리자 등록하기</span>
    </div>
    <div class="panel-body ns-scrollbar admin-form">
      <div class="text-form-style category">
        <label class="form-label">관리자 등급<span class="require">*</span></label>
        <div class="form-box">
          <select>
            <option selected>선택하세요</option>
            <option>슈퍼관리자</option>
            <option>중간관리자</option>
            <option>관리자</option>
          </select>
          <i class="fa-solid fa-chevron-down"></i>
        </div>
      </div>
      <div class="text-form-style id">
        <label class="form-label">아이디<span class="require">*</span></label>
        <div class="form-box">
          <input type="email" placeholder="이메일을 입력하세요">
        </div>
      </div>
      <div class="text-form-style password">
        <label class="form-label">비밀번호<span class="require">*</span></label>
        <div class="form-box">
          <input type="password" placeholder="비밀번호를 입력하세요">
        </div>
      </div>
      <div class="text-form-style password">
        <label class="form-label">비밀번호 확인<span class="require">*</span></label>
        <div class="form-box">
          <input type="password" placeholder="비밀번호를 입력하세요">
        </div>
      </div>
      <div class="text-form-style name">
        <label class="form-label">이름<span class="require">*</span></label>
        <div class="form-box">
          <input type="text" placeholder="이름을 입력하세요">
        </div>
      </div>
      <div class="text-form-style phone-number">
        <label class="form-label">연락처<span class="require">*</span></label>
        <div class="form-box">
          <input type="number" placeholder="휴대폰번호를 입력하세요">
        </div>
      </div>
      <div class="text-form-style e-mail">
        <label class="form-label">이메일<span class="require">*</span></label>
        <div class="form-box">
          <input type="number" placeholder="이메일을 입력하세요">
        </div>
      </div>
      <div class="text-form-style">
        <label class="form-label">계정잠금<span class="require">*</span></label>
        <div class="form-box radio horizontal">
          <div class="form-item">
            <input type="radio" id="account-lock-yes">
            <label class="radio-label" for="account-lock-yes"></label>
            <span>Y</span>
          </div>
          <div class="form-item">
            <input type="radio" id="account-lock-no">
            <label class="radio-label" for="account-lock-no"></label>
            <span>N</span>
          </div>
        </div>
      </div>
      <!-- 저장 -->
      <div class="panel-form-btn-box">
        <button class="btn btn-submit"><span>등록</span></button>
      </div>
    </div>
  </div>

  <!-- 푸시 관리 -->
  <div id="dtx-push" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <i class="panel-close-btn"></i>
      <span class="panel-title">푸시 등록하기</span>
    </div>
    <div class="panel-body ns-scrollbar push-form">
      <div class="text-form-style title">
        <label class="form-label">제목<span class="require">*</span></label>
        <div class="form-box">
          <input type="text">
        </div>
      </div>
      <div class="text-form-style text">
        <label class="form-label">내용<span class="require">*</span></label>
        <div id="editor-push"></div>
      </div>
      <div class="text-form-style target">
        <label class="form-label">발송 대상<span class="require">*</span></label>
        <div class="form-box check">
          <div class="form-item">
            <input type="checkbox" id="all-target">
            <label class="check-label" for="all-target"></label>
            <span>전체발송하기</span>
          </div>
        </div>
      </div>
      <div class="text-form-style search-target">
        <label class="form-label">대상자 찾기<span class="require"></span></label>
        <div class="form-box">
          <input type="text">
          <button class="btn-search">
            <i class="fa-solid fa-magnifying-glass"></i>
          </button>
        </div>
      </div>
      <div class="text-form-style reservation-delivery">
        <label class="form-label">예약설정<span class="require"></span></label>
        <div class="form-box check">
          <div class="form-item">
            <input type="checkbox" id="reservation">
            <label class="check-label" for="reservation"></label>
            <span>예약설정</span>
          </div>
        </div>
        <div class="form-box-wrap d-flex">
            <div class="form-box">
              <input type="date">
            </div>
            <div class="form-box">
              <input type="time">
            </div>
        </div>

      </div>
      <!-- 저장 -->
      <div class="panel-form-btn-box">
        <button class="btn btn-submit"><span>발송</span></button>
      </div>
    </div>
  </div>

  <!-- 설문 관리 -->
  <!--  설문지 등록 -->
  <div id="dtx-survey-form" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <i class="panel-close-btn"></i>
      <span class="panel-title">설문지 등록</span>
    </div>
    <div class="panel-body ns-scrollbar survey-form" id="surveyInsertForm">
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
                  <li class="survey-style-item">날짜형</li>
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
        <button class="btn btn-preview"><span>미리보기</span></button>
        <button class="btn btn-submit" id="btn-survey"><span>등록</span></button>
      </div>
    </div>
  </div>

  <!-- 설문지 미리보기 : 테스트 설문조사 -->
  <div id="dtx-survey-preview" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <i class="panel-back-btn fa-solid fa-chevron-left"></i>
      <span class="panel-title">설문지 미리보기</span>
    </div>
    <div class="panel-body ns-scrollbar survey-form">
      <!-- 설문 제목 -->
      <div class="survey-form-style title">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="input-box">
            <input type="text" placeholder="제목을 입력하세요" value="테스트 설문조사" readonly>
          </div>
          <div class="input-box">
            <input type="text" placeholder="설문지 설명" value="만족도 조사를 통해서 방문하는 환자의 요구사항을 파악하여 개선하기 위함이다.">
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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
            </ul></div>
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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
      <!-- 저장 -->
      <div class="panel-form-btn-box">
        <button class="btn btn-back"><span>돌아가기</span></button>
      </div>
    </div>
  </div>

  <!-- 설문지 보기 : 환자 진료 만족도 설문조사 -->
  <div id="dtx-survey-detail" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <i class="panel-close-btn"></i>
      <span class="panel-title">설문지 보기</span>
    </div>
    <div class="panel-body ns-scrollbar survey-form" id="detailArea">
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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
                  <li class="survey-style-item">날짜형</li>
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

  <!-- 설문지 수정 -->
  <div id="dtx-survey-modify" style="background-color: #ffffff; height: 100%; width: 800px;">
    <div class="panel-head">
      <i class="panel-close-btn"></i>
      <span class="panel-title">설문지 수정하기</span>
    </div>
    <div class="panel-body ns-scrollbar survey-form">
      <!-- 설문 제목 -->
      <div class="survey-form-style title">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="input-box">
            <input type="text" placeholder="제목을 입력하세요" value="환자 진료 만족도 설문조사">
          </div>
          <div class="input-box">
            <input type="text" placeholder="설문지 설명" value="만족도 조사를 통해서 방문하는 환자의 요구사항을 파악하여 개선하기 위함이다.">
          </div>
        </div>
      </div>
      <div class="survey-form-style item">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="고객님의 성함은 어떻게 되십니까?">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked>
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-detail short-text">
            <div class="input-box">
              <input type="text" placeholder="병원에 등록된 실명으로 작성해 주세요.">
            </div>
          </div>
          <div class="survey-item-setting">
            <button class="survey-item-add-btn"><i class="fa-solid fa-plus"></i></button>
            <button class="survey-item-remove-btn"><i class="fa-solid fa-trash-can"></i></button>
          </div>
        </div>
      </div>
      <div class="survey-form-style item">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="고객님의 연령대는 어떻게 되십니까?">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked>
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-detail multiple-choice-radio">
            <ul class="multiple-choice-wrap">
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="10대 미만">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="10대 ~ 20대">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="30대 ~ 40대">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="50대 ~ 60대">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="radio">
                <label class="radio-label"></label>
                <input type="text" placeholder="옵션" value="70대 이상">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
            </ul></div>
        </div>
      </div>
      <div class="survey-form-style item">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="병원에 내원 하시게 된 계기는 무엇인가요?">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked>
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-detail multiple-choice-check">
            <ul class="multiple-choice-wrap">
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="정기검진">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="낙상 사고">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="혈당수치가 높아서">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="옵션" value="고혈압 또는 저혈압 체크를 위해서">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="checkbox">
                <label class="check-label"></label>
                <input type="text" placeholder="기타">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
            </ul>
          </div>
          <div class="survey-item-setting">
            <button class="survey-item-add-btn"><i class="fa-solid fa-plus"></i></button>
            <button class="survey-item-remove-btn"><i class="fa-solid fa-trash-can"></i></button>
          </div>
        </div>
      </div>
      <div class="survey-form-style item">
        <div class="top"></div>
        <div class="left"></div>
        <div class="survey-detail">
          <div class="survey-item-title">
            <div class="input-box">
              <input type="text" placeholder="질문을 입력하세요" value="병원의 접근성에 대해 어떻게 생각 하십니까?">
            </div>
            <div class="require-select">
              <span>필수</span>
              <input class="require-tgl" type="checkbox" checked>
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-explanation">
            <div class="input-box">
              <input type="text" placeholder="질문 설명" value="고객님이 병원에 내원하시는데 만족도를 알아보기 위함입니다.">
            </div>
          </div>
          <div class="survey-item-detail linear-scale">
            <ul class="linear-scale-wrap">
              <li class="linear-label">
                <input type="text" placeholder="라벨" value="매우 불만족스럽다">
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
                <input type="text" placeholder="라벨" value="매우 만족스럽다">
              </li>
            </ul></div>
          <div class="survey-item-setting">
            <button class="survey-item-add-btn"><i class="fa-solid fa-plus"></i></button>
            <button class="survey-item-remove-btn"><i class="fa-solid fa-trash-can"></i></button>
          </div>
        </div>
      </div>
      <div class="survey-form-style item">
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-explanation">
            <div class="input-box">
              <input type="text" placeholder="질문 설명" value="고객님이 병원을 이용하는데 있어 어떤 느낌을 받았는지에 대해 체크하기 위함입니다." readonly>
            </div>
          </div>
          <div class="survey-item-detail radio-grid"><div class="grid-make-wrap">
            <ul class="row-list">
              <li class="row-list-label">행</li>
              <li class="row-list-item">
                <input type="text" placeholder="행 라벨" value="의사">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="text" placeholder="행 라벨" value="간호사">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="text" placeholder="행 라벨" value="행정직원">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="text" placeholder="행 라벨" value="보안요원">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="text" placeholder="행 라벨" value="기타직원">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
            </ul>
            <ul class="column-list">
              <li class="column-list-label">열</li>
              <li class="column-list-item">
                <input type="text" placeholder="열 라벨" value="부족함">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="text" placeholder="열 라벨" value="괜찮음">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="text" placeholder="열 라벨" value="만족스러움">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="text" placeholder="열 라벨" value="매우 좋음">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
              <li class="multiple-item">
                <input type="text" placeholder="열 라벨" value="훌륭함">
                <button class="btn-item-add"><i class="fa-solid fa-plus"></i></button>
                <button class="btn-item-remove"><i class="fa-solid fa-xmark"></i></button>
              </li>
            </ul>
          </div></div>
          <div class="survey-item-setting">
            <button class="survey-item-add-btn"><i class="fa-solid fa-plus"></i></button>
            <button class="survey-item-remove-btn"><i class="fa-solid fa-trash-can"></i></button>
          </div>
        </div>
      </div>
      <div class="survey-form-style item">
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
                  <li class="survey-style-item">날짜형</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="survey-item-detail short-text">
            <div class="input-box">
              <input type="text" placeholder="이름 또는 인상착의를 작성해 주세요">
            </div>
          </div>
          <div class="survey-item-setting">
            <button class="survey-item-add-btn"><i class="fa-solid fa-plus"></i></button>
            <button class="survey-item-remove-btn"><i class="fa-solid fa-trash-can"></i></button>
          </div>
        </div>
      </div>
      <div class="survey-form-style item">
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
                  <li class="survey-style-item">날짜형</li>
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
          <div class="survey-item-setting">
            <button class="survey-item-add-btn"><i class="fa-solid fa-plus"></i></button>
            <button class="survey-item-remove-btn"><i class="fa-solid fa-trash-can"></i></button>
          </div>
        </div>
      </div>
      <!-- 저장 -->
      <div class="panel-form-btn-box">
        <button class="btn btn-submit"><span>수정</span></button>
      </div>
    </div>
  </div>
</div>

</html>