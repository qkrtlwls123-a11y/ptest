<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{common/layout/base-page-layout}">

<th:block layout:fragment="css">
    <style type="text/css">
    </style>
</th:block>

<th:block layout:fragment="script">
    <script type="text/javascript" th:inline="javascript">
        $(document).ready(function () {

            /*등록하기*/
            $(".card-head .btn-add").off("click");
            $(".card-head .btn-add").on("click", function () {
                registerPatient();
            });

            /*상세보기*/


            // $(".content-table .view-detail").on("click", function () {
            //     if($(this).hasClass("open") == false){
            //         $(this).addClass("open");
            //         var name = $(this).text();
            //         var phase = $(this).data("phase");
            //         var num = $(this).data("num");
            //         var gender = $(this).data("gender");
            //         var age = $(this).data("age");
            //         var profileImg = $(this).data("profile-img");
            //         //var d = "<a data-phase=\"normal\" data-num=\"PH345\" data-gender=\"여\" data-age=\"39세\" data-profile-img=\"sample-patient-pic09.jpeg\" class=\"view-detail open\" href=\"javascript:showPatientCard();\">정환자</a>";
            //         var patientIndex = "<div class=\"patient-index-item\" data-name=\'" + name + "'\ data-num=\'" + num + "'\ data-gender=\'" + gender + "'\ data-age=\'" + age + "'\ data-profile-img=\'" + profileImg + "'\ >\n" +
            //             "         <div class=\"phase " +  phase +"\"></div>\n" +
            //             "         <div class=\"index-info\">\n" +
            //             "           <span class=\"name\">"+ name + "</span>\n" +
            //             "           <span class=\"code\">"+ num + "</span>\n" +
            //             "         </div>\n" +
            //             "        </div>";
            //
            //         $(".patient-index-list li.patient-index-item-wrap").prepend(patientIndex);
            //
            //         /* 카드 내용 수정 최대한 */
            //
            //         $(".patient-card .patient-card-head > .title > .name").text(name);
            //         $(".patient-card .patient-card-head > .title > .patient-code").text(num);
            //
            //         $(".patient-card .patient-profile-img > .profile-img-wrap > img").attr("src", "/assets/images/sample/" + profileImg);
            //         $(".patient-card .patient-profile-info > .name").text(name);
            //         $(".patient-card .patient-profile-info .age").text(age);
            //         $(".patient-card .patient-profile-info .gender").text(gender);
            //
            //
            //         if($(".patient-arrow-btn").hasClass("close") == true){
            //             $(".patient-arrow-btn").removeClass("close");
            //             $("#side-panel-area").animate({
            //                 "margin-right":"0px"
            //             }, 500);
            //         }
            //
            //     }
            // });

            //상단 X 버튼
            $(document).off("click", ".patient-arrow-btn");
            $(document).on("click", ".patient-arrow-btn", function () {
                if($(".patient-arrow-btn").hasClass("close") == false){
                    $(".patient-arrow-btn").addClass("close");
                    $("#side-panel-area").animate({
                        "margin-right":"-1130px"
                    }, 500);
                }else{
                    $(".patient-arrow-btn").removeClass("close");
                    $("#side-panel-area").animate({
                        "margin-right":"0px"
                    }, 500);
                }
            });


            $(document).on("click", ".patient-index-item", function () {
                if($(".patient-arrow-btn").hasClass("close") == false){
                    $(".patient-arrow-btn").addClass("close");
                    $("#side-panel-area").animate({
                        "margin-right":"-1130px"
                    }, 500);
                }else{
                    $(".patient-arrow-btn").removeClass("close");
                    $("#side-panel-area").animate({
                        "margin-right":"0px"
                    }, 500);
                }

            });

            $(document).on("mouseout", ".patient-index-item", function () {

                //console.log($(".patient-index-item-wrap > .patient-index-item").eq(0).data());
                var name = $(".patient-index-item-wrap > .patient-index-item").eq(0).data("name");
                var num = $(".patient-index-item-wrap > .patient-index-item").eq(0).data("num");
                var profileImg = $(".patient-index-item-wrap > .patient-index-item").eq(0).data("profile-img");
                var age = $(".patient-index-item-wrap > .patient-index-item").eq(0).data("age");
                var gender = $(".patient-index-item-wrap > .patient-index-item").eq(0).data("gender");
                /* 카드 내용 수정 최대한 */

                $(".patient-card .patient-card-head > .title > .name").text(name);
                $(".patient-card .patient-card-head > .title > .patient-code").text(num);
                $(".patient-card .patient-profile-img > .profile-img-wrap > img").attr("src", "/assets/images/sample/" + profileImg);
                $(".patient-card .patient-profile-info > .name").text(name);
                $(".patient-card .patient-profile-info .age").text(age);
                $(".patient-card .patient-profile-info .gender").text(gender);
            });
            searchList(1);
        });

        function onFrontScriptReady() {
            console.log("front script ready...");
        }

        function registerPatient(){
            showSidePanel("dtx-register-patient", "right", function () {

                //상단 X 버튼
                $(".panel-close-btn").off("click");
                $(".panel-close-btn").on("click", function () {
                    hideSidePanel("right");
                });
            });
        }

        function viewDetailPatientCard () {
            showSidePanel("dtx-patient-card", "right", function () {
                $("#side-panel-area").css({"width":"1180px", "left":"unset", "overflow":"unset"});
                $(".side-panel-content.right").css({"overflow":"unset"});
                $(".side-panel-dim").hide();

                $(".tab-nav-item").off("click");
                $(".tab-nav-item").on("click", function () {
                   $(this).addClass("active");
                   $(this).siblings().removeClass("active");

                    $(".tab-content").eq($(this).index()).addClass("active");
                    $(".tab-content").eq($(this).index()).siblings().removeClass("active");
                });

                $(".tab-nav-item").eq(0).trigger("click");

                //질문지 박스 선택시 active 클래스 추가
                $(".survey-form-style").removeClass("active");
                $(document).off("click",".survey-form-style")
                $(document).on("click",".survey-form-style",  function () {
                    $(this).addClass("active");
                    $(".survey-form-style").not($(this)).removeClass("active");
                });
                var questionnaireDetail = $("#html-part > .patient-questionnaire.detail").clone();
                var recordDetail = $("#html-part > .patient-record.detail").clone();
                var healthDetail = $("#html-part > .patient-health.detail").clone();
                var exerciseDetail = $("#html-part > .patient-exercise.detail").clone();

                //문진표 상세보기
                $(".patient-questionnaire tbody tr").off("click");
                $(".patient-questionnaire tbody tr").on("click", function () {
                    $(".patient-questionnaire.list").addClass("hide");
                    $(".tab-content").eq(1).append(questionnaireDetail);

                    //돌아가기
                    $(".patient-questionnaire.detail .btn-back").off("click");
                    $(".patient-questionnaire.detail .btn-back").on("click", function () {
                        $(".patient-questionnaire.list").removeClass("hide");
                        $(".patient-questionnaire.detail").remove();
                    });
                });

                //기록 상세보기
                $(".patient-record tbody tr").off("click");
                $(".patient-record tbody tr").on("click", function () {
                    $(".patient-record.list").addClass("hide");
                    $(".tab-content").eq(2).append(recordDetail);

                    //돌아가기
                    $(".patient-record.detail .btn-back").off("click");
                    $(".patient-record.detail .btn-back").on("click", function () {
                        $(".patient-record.list").removeClass("hide");
                        $(".patient-record.detail").remove();
                    });
                });

                //건강 상세보기
                $(".patient-health tbody tr").off("click");
                $(".patient-health tbody tr").on("click", function () {
                    $(".patient-health.list").addClass("hide");
                    $(".tab-content").eq(3).append(healthDetail);

                    //돌아가기
                    $(".patient-health.detail .btn-back").off("click");
                    $(".patient-health.detail .btn-back").on("click", function () {
                        $(".patient-health.list").removeClass("hide");
                        $(".patient-health.detail").remove();
                    });
                });

                $(".patient-health .patient-health-nav > .nav-item").off("click");
                $(".patient-health .patient-health-nav > .nav-item").on("click", function () {
                    var navIndex = $(this).index();

                    $(this).addClass("active").siblings().removeClass("active");
                    $(".patient-health-content").eq(navIndex).removeClass("hide").siblings().addClass("hide");

                });
                $(".patient-health .patient-health-nav > .nav-item").eq(0).trigger("click");

                //헬스 상세보기
                $(".patient-exercise tbody tr").off("click");
                $(".patient-exercise tbody tr").on("click", function () {
                    $(".patient-exercise.list").addClass("hide");
                    $(".tab-content").eq(4).append(exerciseDetail);

                    //돌아가기
                    $(".patient-exercise.detail .btn-back").off("click");
                    $(".patient-exercise.detail .btn-back").on("click", function () {
                        $(".patient-exercise.list").removeClass("hide");
                        $(".patient-exercise.detail").remove();
                    });
                });


                //상단 X 버튼
                $(".patient-card-close-btn").off("click");
                $(".patient-card-close-btn").on("click", function () {
                    hideSidePanel("right");
                    $(".view-detail").removeClass("open");
                    $("li.patient-index-item-wrap").empty();
                });

            });


        }

        function searchList(pageIndex) {
            let sendData = {};

            sendData.searchType = "";
            sendData.searchKeyword = "";
            sendData.command = "list";
            sendData.pageNo = pageIndex;
            sendData.pageSize = 10;
            console.log("sendData : "+sendData);

            NSCOMMON.apiPost(NSCONFIG.patientUrl, sendData, "json", true, function (patientListResult) {
                fn_makeList(patientListResult);
            });
        }

        function fn_makeList(patientListResult){
            let htmlString = "";
            const totalCount = patientListResult.resultCount;
            for(let i=0; i<patientListResult.response.length; i++){
                let testString = "";
                let testImage = "";
                if(i%2 == 0){
                    testString = "#컨트롤군,#혈압";
                    testImage = "https://dtx.neoulsoft.com/open-api/res/aHR0cHM6Ly9zMy5kdHguczMuYXAtbm9ydGhlYXN0LTIuYW1hem9uYXdzLmNvbS9kdHgvY29udGVudHMvY2IzYWQwZWRmZTQ0ZGE5MWUyYWNiZDEwMGM4YmExMjZmMWFhNWUxYWU2Y2FiMDM1YWQ5MzNiZGFmYmUxNWExMC5qcGVn";
                }else{
                    testString = "#일반임상,#혈압,#혈당";
                    testImage = "https://dtx.neoulsoft.com/open-api/res/aHR0cHM6Ly9zMy5kdHguczMuYXAtbm9ydGhlYXN0LTIuYW1hem9uYXdzLmNvbS9kdHgvY29udGVudHMvY2IzYWQwZWRmZTQ0ZGE5MWUyYWNiZDEwMGM4YmExMjYzNDNmMjM0ZjJmM2Q4Mjk1ZjNmYzI2NWRmOTE0ODI5Yi5qcGVn";
                }

                const listNo = patientListResult.response.length-i;
                const uid = patientListResult.response[i].uid;

                let gender = "";
                if(patientListResult.response[i].gender){
                    gender = "여";
                }else{
                    gender = "남";
                }
                const birthday = patientListResult.response[i].birthday;
                const year = birthday.substring(0, 4);
                const month = birthday.substring(4,6);
                const day = birthday.substring(6,8);

                const today = new Date();
                const birthDate = new Date(year,month,day);
                const age = today.getFullYear() - birthDate.getFullYear() + 1;

                const patientName = NSCOMMON.B64.decode(patientListResult.response[i].patientName);
                const patientNo = NSCOMMON.B64.decode(patientListResult.response[i].patientNo);
                const patientRegisteredAt = patientListResult.response[i].registeredAt.dateTime.substring(0, 10);
                const patientParticipatedAt = patientListResult.response[i].participatedAt.dateTime.substring(0, 10);
                htmlString += '<tr>'+
                    '<td>'+listNo+'</td>'+
                    '<td>'+
                    '<a data-uid="'+uid+'" data-phase="normal" data-num="'+patientNo+'" data-gender="'+gender+'" data-age="'+age+'세" data-profile-img="'+testImage+'" class="view-detail">'+patientName+'</a>'+
                    '</td>'+
                    '<td>'+gender+'</td>'+
                    '<td>'+age+'세</td>'+
                    '<td>'+patientRegisteredAt+'</td>'+
                    '<td>전체</td>'+
                    '<td><span class="normal">정상</span></td>'+
                    '<td>'+patientParticipatedAt+'</td>'+
                    '<td class="low">10%</td>'+
                    '</tr>';
            }

            $(".total").text(totalCount+"명");
            $("#tbodyList").html(htmlString);

            $(".content-table tbody tr").off("click");
            $(".content-table tbody tr").on("click", function () {

                $(this).find("a").attr("data-phase")

                $(".patient-card-head").find(".name").text($(this).find("a").text());
                $(".patient-card-head").find(".patient-code").text($(this).find("a").attr("data-num"));
                $(".patient-profile-info").find(".name").text($(this).find("a").text());
                $(".patient-profile-info").find(".age").text($(this).find("a").attr("data-age"));
                $(".patient-profile-info").find(".gender").text($(this).find("a").attr("data-gender"));
                let checkImage = $(this).find("a").attr("data-profile-img");
                let imageTest = '<img src="'+checkImage+'">';
                $(".patient-profile-img").find(".profile-img-wrap").html(imageTest);

                $(this).addClass("open");
                $(this).siblings().removeClass("open");
                $(this).find(".view-detail").addClass("open");
                $(this).siblings().find(".view-detail").removeClass("open");

                const patientNo = $(this).find("a").attr("data-num");

                fn_searchPatientDetail(patientNo)

                viewDetailPatientCard();

            });
        }

        function fn_searchPatientDetail(patientNo){
            let sendData = {};

            sendData.command = "detail";
            sendData.patientNo = patientNo;

            NSCOMMON.apiPost(NSCONFIG.patientUrl, sendData, "json", true, function (patientListResult) {
                fn_makeDetail(patientListResult);
            });
        }

        function fn_makeDetail(patientListResult){

            $(".patient-card-content").each(function(){
                $(this).find(".record-num").text("-");
                $(this).find(".date").text("-");
            })

            const checkDetection = patientListResult.response.checkDetection;

            if(checkDetection){
                let checkTime = patientListResult.response.emergency.occurredAt.dateTime;
                $(".person-falling").show();
                $(".person-falling").find(".date").text(checkTime);

            }else{
                $(".person-falling").hide();
            }

            for(let i=0;i<patientListResult.response.clinicalList.length;i++){
                const clinicalType =  NSCOMMON.B64.decode(patientListResult.response.clinicalList[i].clinicalType);
                if("blood-pressure" == clinicalType){
                    let factor0 = patientListResult.response.clinicalList[i].factor0;
                    let factor1 = patientListResult.response.clinicalList[i].factor1;
                    let checkTime = patientListResult.response.clinicalList[i].measuredAt.dateTime;
                    let factor = factor0+"/"+factor1;

                    $(".blood-pressure-pannel").find(".record-num").text(factor);
                    $(".blood-pressure-pannel").find(".date").text(checkTime);

                }else if("pulse" == clinicalType){
                    let checkTime = patientListResult.response.clinicalList[i].measuredAt.dateTime;
                    let factor = patientListResult.response.clinicalList[i].factor0;

                    $(".pulse-pannel").find(".record-num").text(factor);
                    $(".pulse-pannel").find(".date").text(checkTime);
                }else if("blood-sugar" == clinicalType){
                    let checkTime = patientListResult.response.clinicalList[i].measuredAt.dateTime;
                    let factor = patientListResult.response.clinicalList[i].factor0;

                    $(".blood-sugar-pannel").find(".record-num").text(factor);
                    $(".blood-sugar-pannel").find(".date").text(checkTime);
                }else if("oxygen" == clinicalType){
                    let checkTime = patientListResult.response.clinicalList[i].measuredAt.dateTime;
                    let factor = patientListResult.response.clinicalList[i].factor0;

                    $(".oxygen-pannel").find(".record-num").text(factor);
                    $(".oxygen-pannel").find(".date").text(checkTime);
                }
            }

            for(let i=0;i<patientListResult.response.healthList.length;i++){
                const healthType =  NSCOMMON.B64.decode(patientListResult.response.healthList[i].healthType);

                if("step-count" == healthType){
                    let checkTime = patientListResult.response.healthList[i].measuredAt.dateTime;
                    let factor = patientListResult.response.healthList[i].factor0;

                    $(".step-count-pannel").find(".record-num").text(factor);
                    $(".step-count-pannel").find(".date").text(checkTime);

                }else if("calorie" == healthType){
                    let checkTime = patientListResult.response.healthList[i].measuredAt.dateTime;
                    let factor0 = patientListResult.response.healthList[i].factor0;
                    let factor1 = patientListResult.response.healthList[i].factor1;

                    $(".calorie-pannel").find(".record-num").text(factor1);
                    $(".calorie-pannel").find(".date").text(checkTime);
                }else if("inbody" == healthType){
                    let checkTime = patientListResult.response.healthList[i].measuredAt.dateTime;
                    let factor = patientListResult.response.healthList[i].factor1;

                    $(".inbody-pannel").find(".record-num").text(factor);
                    $(".inbody-pannel").find(".date").text(checkTime);
                }
            }

        }
    </script>
</th:block>

<div class="page-content patient" layout:fragment="content">
    <!-- 콘텡츠 제목 -->
    <div class="content-head">
        <!-- 제목 -->
        <div class="content-header">
            <span class="content-title">환자 관리</span>
        </div>
        <!-- map -->
        <ul class="content-sub-header">
            <li>
                <i class="fa-solid fa-house"></i>
                <a href="dashboard">Home</a>
            </li>
            <li class="active">환자 관리</li>
        </ul>
    </div>
    <!-- 콘텐츠 내용 -->
    <div class="content-card">
        <div class="card">
            <!-- 리스트 제목 -->
            <div class="card-head">
                <span>환자 목록</span>
                <button class="btn btn-circle btn-add" onclick="registerSurvey()">
                    <span>환자 등록</span>
                    <i class="fa-solid fa-plus"></i>
                </button>
            </div>
            <!-- 리스트 -->
            <div class="card-body">
                <!--    리스트 : 전체숫자 / 검색 필터 & 검색창 -->
                <div class="card-search-wrap">
                    <span class="total-title">전체 환자 : <span class="total">185명</span></span>
                    <div class="card-search-area">
                        <div class="form-box select-box">
                                <select>
                                    <option selected>선택해 주세요</option>
                                    <option>입력 수행률</option>
                                    <option>이름</option>
                                    <option>등록일</option>
                                    <option>나이</option>
                                    <option>성별</option>
                                    <option>배정군</option>
                                    <option>당뇨</option>
                                    <option>혈압</option>
                                    <option>마지막 입력 날짜</option>
                                </select>
                                <i class="fa-solid fa-chevron-down"></i>
                        </div>
                        <div class="form-box search-box">
                            <input type="text" placeholder="데이터 검색">
                            <button class="btn-search">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- 리스트 : 테이블 -->
                <div class="content-table">
                    <table>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>환자명</th>
                                <th>성별</th>
                                <th>나이</th>
                                <th>등록일</th>
                                <th>주요정보</th>
                                <th>상태</th>
                                <th>최근 측정 일자</th>
                                <th>설문 응답률</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyList">
                            <!--<tr>
                                <td>5</td>
                                <td>
                                    <a data-phase="normal" data-num="PH345" data-gender="여" data-age="39세" data-profile-img="sample-patient-pic09.jpeg" class="view-detail">정환자</a>
                                </td>
                                <td>여</td>
                                <td>39세</td>
                                <td>2021-10-10</td>
                                <td>전체</td>
                                <td><span class="normal">정상</span></td>
                                <td>2022-05-15</td>
                                <td class="low">10%</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>
                                    <a data-phase="normal" data-num="QW345" data-gender="남" data-age="39세" data-profile-img="sample-patient-pic03.png" class="view-detail">유재석</a>
                                </td>
                                <td>남</td>
                                <td>39세</td>
                                <td>2021-10-10</td>
                                <td>전체</td>
                                <td><span class="danger">위험</span></td>
                                <td>2022-05-15</td>
                                <td>80%</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>
                                    <a data-phase="high-risk" data-num="SR345" data-gender="여" data-age="78세" data-profile-img="sample-patient-pic08.jpeg" class="view-detail">강부자</a>
                                </td>
                                <td>여</td>
                                <td>78세</td>
                                <td>2021-03-02</td>
                                <td>정형외과</td>
                                <td><span class="warning">경고</span></td>
                                <td>2021-03-02</td>
                                <td>100%</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>
                                    <a data-phase="normal" data-num="LO345" data-gender="남" data-age="39세" data-profile-img="sample-patient-pic04.jpeg" class="view-detail">하동훈</a>
                                </td>
                                <td>남</td>
                                <td>39세</td>
                                <td>2021-10-10</td>
                                <td>전체</td>
                                <td><span class="normal">정상</span></td>
                                <td>2022-05-15</td>
                                <td>80%</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>
                                    <a data-phase="high-risk" data-num="AS123" data-gender="남" data-age="78세" data-profile-img="sample-patient-pic02.png" class="view-detail">오일남</a>
                                </td>
                                <td>남</td>
                                <td>78세</td>
                                <td>2021-03-02</td>
                                <td>정형외과</td>
                                <td><span class="high-risk">고위험</span></td>
                                <td>2021-03-02</td>
                                <td class="low">10%</td>
                            </tr>-->
                        </tbody>
                    </table>
                    <div class="page">
                        <ul class="pagination">
                            <li>
                                <button class="first-page">
                                    처음 페이지
                                </button>
                            </li>
                            <li>
                                <button class="previous-page">
                                    <i class="fa-solid fa-angle-left"></i>
                                    <i class="fa-solid fa-angle-left"></i>
                                </button>
                            </li>
                            <li>
                                <button class="num active">1</button>
                            </li>
                            <li>
                                <button class="next-page">
                                    <i class="fa-solid fa-angle-right"></i>
                                    <i class="fa-solid fa-angle-right"></i>
                                </button>
                            </li>
                            <li>
                                <button class="last-page">
                                    마지막 페이지
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="html-part" style="display: none;" layout:fragment="html-part">
    <!-- 문진표 상세보기 -->
    <div class="patient-questionnaire detail">
        <div class="progressbar-bar-wrap">
            <span class="rate-title">입력 수행률 : <span class="rate">30%</span></span>
            <div class="progressbar-bar">
                <div class="progressbar-bar-success" style="background-color: #36c6d3; width: 30%; animation: patient-progressbar-bar 2s 1"></div>
            </div>
        </div>
        <!-- 설문 제목 -->
        <div class="survey-form-style title">
            <div class="top"></div>
            <div class="left"></div>
            <div class="survey-detail">
                <div class="input-box">
                    <input type="text" placeholder="제목을 입력하세요" value="일상생활 운동습관 문진표" readonly="">
                </div>
                <div class="input-box">
                    <input type="text" placeholder="설문지 설명" value="평소 일주일 동안 환자가 참여하고 있는 다양한 신체활동 시간과 관련된 질문들이다.">
                </div>
            </div>
        </div>
        <div class="survey-form-style item report">
            <div class="top"></div>
            <div class="left"></div>
            <div class="survey-detail">
                <div class="survey-item-title">
                    <div class="input-box">
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 본인의 일은 고강도 신체 활동을 포함하고 있습니까?" readonly>
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
                <div class="survey-item-explanation">
                    <div class="input-box">
                        <input type="text" placeholder="질문 설명" value="고강도 활동 : 격렬한 신체활동으로, 무거운 것을 들어올리거나 나르는일, 땅파기, 건설 현장에서의 노동 등의 활동">
                    </div>
                </div>
                <div class="survey-item-detail multiple-choice-radio">
                    <ul class="multiple-choice-wrap">
                        <li class="multiple-item">
                            <input type="radio">
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="예" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio" checked>
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="아니오" readonly="">
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 본인의 일은 중강도 신체 활동을 포함하고 있습니까?" readonly>
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
                <div class="survey-item-explanation">
                    <div class="input-box">
                        <input type="text" placeholder="질문 설명" value="중강도 활동 : 중간 정도의 신체활동으로, 빠르게 걷기, 가벼운 물건 나르기, 청소, 육아 등">
                    </div>
                </div>
                <div class="survey-item-detail multiple-choice-radio">
                    <ul class="multiple-choice-wrap">
                        <li class="multiple-item">
                            <input type="radio" checked>
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="예" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio">
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="아니오" readonly="">
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 평소 일주일 동안, 일과 관련된 신체 활동을 몇일 하십니까?" readonly>
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
                        <input type="text" placeholder="" value="5일" readonly>
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 평소 하루에 일과 관련된 신체 활동을 몇 시간 하십니까?" readonly>
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
                        <input type="text" placeholder="" value="6시간" readonly>
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 평소 장소를 이동할 때 최소 10분 이상 계속 걷거나 자전거 이용을 하십니까?" readonly>
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
                            <input type="text" placeholder="옵션" value="예" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio" checked>
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="아니오" readonly="">
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 평소 최소 10분 이상 심장이 매우 빠르게 뛰는 등의 여가활동을 하십니까?" readonly>
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
                            <input type="text" placeholder="옵션" value="예" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio" checked>
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="아니오" readonly="">
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 최근 일주일 동안 근력운동을 한 날은 몇일입니까?" readonly="">
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
                <div class="survey-item-explanation">
                    <div class="input-box">
                        <input type="text" placeholder="질문 설명" value="근력운동 : 팔굽혀 펴기, 윗몸일으키기, 아령, 역기, 철봉 등">
                    </div>
                </div>
                <div class="survey-item-detail multiple-choice-radio">
                    <ul class="multiple-choice-wrap">
                        <li class="multiple-item">
                            <input type="radio" checked>
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="전혀 하지 않음" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio">
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="1일" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio">
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="2일" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio">
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="3일" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio">
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="4일" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio">
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="5일" readonly="">
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 제시된 운동의 선호도에 대해 체크해 주세요." readonly="">
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
                            <tr>
                            <th class="empty"></th>
                            <th>1</th>
                            <th>2</th>
                            <th>3</th>
                            <th>4</th>
                            <th>5</th>
                        </tr>
                            <tr>
                                <th>빠르게 걷기</th>
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
                                    <input type="radio" checked="">
                                    <label class="radio-label"></label>
                                </td>
                            </tr>
                            <tr>
                                <th>등산</th>
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
                                    <input type="radio" checked="">
                                    <label class="radio-label"></label>
                                </td>
                                <td>
                                    <input type="radio">
                                    <label class="radio-label"></label>
                                </td>
                            </tr>
                            <tr>
                                <th>수영</th>
                                <td>
                                    <input type="radio">
                                    <label class="radio-label"></label>
                                </td>
                                <td>
                                    <input type="radio" checked="">
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
                                <th>에어로빅</th>
                                <td>
                                    <input type="radio">
                                    <label class="radio-label"></label>
                                </td>
                                <td>
                                    <input type="radio">
                                    <label class="radio-label"></label>
                                </td>
                                <td>
                                    <input type="radio" checked="">
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
                                <th>스피닝</th>
                                <td>
                                    <input type="radio" checked="">
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 운동을 할 때 가슴에 통증을 느낀 적이 있습니까?" readonly>
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
                            <input type="text" placeholder="옵션" value="예" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio" checked>
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="아니오" readonly="">
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 어지럼증이나 의식소실로 인해 균형을 잃은 적이 있습니까?" readonly>
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
                            <input type="text" placeholder="옵션" value="예" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio" checked>
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="아니오" readonly="">
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
                        <input type="text" placeholder="질문을 입력하세요" value="Q. 운동을 하면 안되는 다른 이유가 있습니까?" readonly>
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
                            <input type="text" placeholder="옵션" value="예" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="multiple-item">
                            <input type="radio" checked>
                            <label class="radio-label"></label>
                            <input type="text" placeholder="옵션" value="아니오" readonly="">
                            <button class="btn-item-add" style="visibility: hidden"><i class="fa-solid fa-plus"></i></button>
                            <button class="btn-item-remove" style="visibility: hidden"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                    </ul></div>
            </div>
        </div>
        <!-- 돌아가기 -->
        <div class="panel-form-btn-box">
            <button class="btn btn-back"><span>돌아가기</span></button>
        </div>
    </div>
    <!-- 기록 상세보기 -->
    <div class="patient-record detail">
        <table>
            <thead>
            <tr>
                <th>No</th>
                <th>기록명</th>
                <th>기록</th>
                <th>기록 시점</th>
                <th>기록 시점시 관련사항</th>
                <th>기록시 증상</th>
            </tr>
            </thead>
            <tbody>
            <tr>
               <td>1</td>
               <td>혈압</td>
               <td>
                   <span class="record">138/78<em>mmHg</em></span>
               </td>
               <td>
                   <div class="choice-wrap">
                       <input type="radio" checked>
                       <label class="radio-label"></label>
                       <span class="label-name">기상 직후</span>
                   </div>
                   <div class="choice-wrap">
                       <input type="radio">
                       <label class="radio-label"></label>
                       <span class="label-name">취침 전</span>
                   </div>
                   <div class="choice-wrap">
                       <input type="radio">
                       <label class="radio-label"></label>
                       <span class="label-name">식사 전</span>
                   </div>
                   <div class="choice-wrap">
                       <input type="radio">
                       <label class="radio-label"></label>
                       <span class="label-name">식사 후 1시간 이내</span>
                   </div>
               </td>
               <td>
                   <div class="choice-wrap">
                       <input type="radio" checked>
                       <label class="radio-label"></label>
                       <span class="label-name">배뇨 직후(5분 이내)</span>
                   </div>
                   <div class="choice-wrap">
                       <input type="radio">
                       <label class="radio-label"></label>
                       <span class="label-name">운동 직후</span>
                   </div>
                   <div class="choice-wrap">
                       <input type="radio">
                       <label class="radio-label"></label>
                       <span class="label-name">해당 없음</span>
                   </div>
               </td>
                <td>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">어지러움</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">두통</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">두근거림</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">스트레스</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">해당 없음</span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>맥박</td>
                <td>
                    <span class="record">89<em>mmHg</em></span>
                </td>
                <td>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">기상 직후</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">취침 전</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">식사 전</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">식사 후 1시간 이내</span>
                    </div>
                </td>
                <td>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">배뇨 직후(5분 이내)</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">운동 직후</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">해당 없음</span>
                    </div>
                </td>
                <td>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">어지러움</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">두통</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">두근거림</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">스트레스</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">해당 없음</span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>3</td>
                <td>혈당</td>
                <td>
                    <span class="record">121<em>mg/dl</em></span>
                </td>
                <td>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">기상 직후</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">취침 전</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">식사 전</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">식사 후 1시간 이내</span>
                    </div>
                </td>
                <td>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">배뇨 직후(5분 이내)</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">운동 직후</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">해당 없음</span>
                    </div>
                </td>
                <td>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">어지러움</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">두통</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">두근거림</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">스트레스</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">해당 없음</span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>4</td>
                <td>산소포화도</td>
                <td>
                    <span class="record">96<em>%</em></span>
                </td>
                <td>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">기상 직후</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">취침 전</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">식사 전</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">식사 후 1시간 이내</span>
                    </div>
                </td>
                <td>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">배뇨 직후(5분 이내)</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">운동 직후</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">해당 없음</span>
                    </div>
                </td>
                <td>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">어지러움</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">두통</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio" checked>
                        <label class="radio-label"></label>
                        <span class="label-name">두근거림</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">스트레스</span>
                    </div>
                    <div class="choice-wrap">
                        <input type="radio">
                        <label class="radio-label"></label>
                        <span class="label-name">해당 없음</span>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <!-- 돌아가기 -->
        <div class="panel-form-btn-box" style="margin-top: 20px;">
            <button class="btn btn-back"><span>돌아가기</span></button>
        </div>
    </div>
    <!-- 건강 상세보기 -->
    <div class="patient-health detail">
        <table>
            <thead>
            <tr>
                <th>No</th>기
                <th>기록명</th>
                <th>당일 기록</th>
                <th>이전 기록</th>
                <th>30일 평균</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>혈압</td>
                <td>
                    <span class="record">145/66<em>mmHg</em></span>
                </td>
                <td>
                    <span class="record">122/55<em>mmHg</em></span>
                </td>
                <td>
                    <span class="record">138/78<em>mmHg</em></span>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>맥박</td>
                <td>
                    <span class="record">77<em>mmHg</em></span>
                </td>
                <td>
                    <span class="record">65<em>mmHg</em></span>
                </td>
                <td>
                    <span class="record">89<em>mmHg</em></span>
                </td>
            </tr>
            <tr>
                <td>3</td>
                <td>혈당</td>
                <td>
                    <span class="record">101<em>mg/dl</em></span>
                </td>
                <td>
                    <span class="record">99<em>mg/dl</em></span>
                </td>
                <td>
                    <span class="record">121<em>mg/dl</em></span>
                </td>
            </tr>
            <tr>
                <td>4</td>
                <td>산소포화도</td>
                <td>
                    <span class="record">96<em>%</em></span>
                </td>
                <td>
                    <span class="record">55<em>%</em></span>
                </td>
                <td>
                    <span class="record">96<em>%</em></span>
                </td>
            </tr>
            </tbody>
        </table>
        <!-- 돌아가기 -->
        <div class="panel-form-btn-box" style="margin-top: 20px;">
            <button class="btn btn-back"><span>돌아가기</span></button>
        </div>
    </div>
    <!-- 헬스 상세보기-->
    <div class="patient-exercise detail">
        <table>
            <thead>
            <tr>
                <th>No</th>
                <th>기록명</th>
                <th>당일 기록</th>
                <th>이전 기록</th>
                <th>30일 평균</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>걸음수</td>
                <td>
                    <span class="record">3,245<em>/10,000</em></span>
                </td>
                <td>
                    <span class="record">3,245<em>/10,000</em></span>
                </td>
                <td>
                    <span class="record">3,245<em>/10,000</em></span>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>활동량</td>
                <td>
                    <span class="record">350<em>kcal</em></span>
                </td>
                <td>
                    <span class="record">350<em>kcal</em></span>
                </td>
                <td>
                    <span class="record">350<em>kcal</em></span>
                </td>
            </tr>
            </tbody>
        </table>
        <!-- 돌아가기 -->
        <div class="panel-form-btn-box" style="margin-top: 20px;">
            <button class="btn btn-back"><span>돌아가기</span></button>
        </div>
    </div>
</div>
</html>