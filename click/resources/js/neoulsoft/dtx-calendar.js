var dtxCalendarScript = function () {

    var __this = this;
    var __date = new Date();

    __this.initCalendar = function () {

        /* 달력 */

        //달력 그리기
        displayCalendar(__date);

        var calendarHeader = $(".calendar-head");
        var calendarContent = $(".calendar-body");

        //왼쪽버튼
        calendarHeader.find(".calendar-left-btn").off("click");
        calendarHeader.find(".calendar-left-btn").on("click", function () {
            calendarContent.find("table > tbody").empty();
            var _month = __date.getMonth();
            __date.setMonth(__date.getMonth() - 1);
            var _beforeMonth = __date.getMonth();
            if(_month === 11 && _beforeMonth === 11) {
                __date.setMonth(10);
            }else{
                __date.setMonth(__date.getMonth());
            }
            displayCalendar(__date);
        });

        //오른쪽버튼
        calendarHeader.find(".calendar-right-btn").off("click");
        calendarHeader.find(".calendar-right-btn").on("click", function () {
            calendarContent.find("table > tbody").empty();
            var _month = __date.getMonth();
            __date.setMonth(__date.getMonth() + 1);
            var _afterMonth = __date.getMonth();
            if(_month === 0 && _afterMonth === 2) {
                __date.setMonth(1);
            }else{
                __date.setMonth(__date.getMonth());
            }
            displayCalendar(__date);
        });


        /* 달력 상세내용 */

        var calendarDetailCard = $(".card.calendar-detail");
        var calendarTabNav = calendarDetailCard.find(".calendar-tab-nav");
        var calendarTabContent = calendarDetailCard.find(".calendar-tab-content");

        // 메모등록
        calendarDetailCard.find(".btn-add.memo").off("click");
        calendarDetailCard.find(".btn-add.memo").on("click", function () {
            showSidePanel("dtx-calendar-memo", "right", function () {
                var sidePanelArea = $("#dtx-calendar-memo");
                sidePanelArea.find(".text-form-style.text").css("height", "calc(100% - 355px");
                var textFormHeight = sidePanelArea.find(".text-form-style.text").height();
                //에디터 삽입
                tinymce.init({
                    selector: '#editor-memo',
                    height : textFormHeight - 53,
                    menubar: false
                });
                //상단 X 버튼
                sidePanelArea.find(".panel-close-btn").off("click");
                sidePanelArea.find(".panel-close-btn").on("click", function () {
                    hideSidePanel("right");
                });

                //등록버튼
                sidePanelArea.find(".btn-submit").off("click");
                sidePanelArea.find(".btn-submit").on("click", function () {
                    var memoCate = sidePanelArea.find(".text-form-style.category").find("select option:selected").text();
                    var memoTitle = sidePanelArea.find(".text-form-style.title").find("input[type='text']").val();
                    var memoDate = sidePanelArea.find(".text-form-style.date").find("input[type='date']").val()
                    var memoText = tinymce.get("editor-memo").getContent();
                    hideSidePanel("right");
                    setTimeout(function () {
                        var alarm = $("#html-part").find(".alarm").clone();
                        $(".calendar-body table").find("td#day_" + memoDate + " > .day-wrap").append(alarm);
                        var alarmSample = $("#html-part").find("tr").clone();
                        $(".calendar-tab-content.memo-list table tbody").append(alarmSample);
                    }, 1000);
                });
            });
        });


        //달력 상세내용 탭 클릭
        calendarTabNav.find(".calendar-tab-nav-item").off("click");
        calendarTabNav.find(".calendar-tab-nav-item").on("click", function () {
            $(this).addClass("active");
            $(this).siblings().removeClass("active");

            calendarTabContent.eq($(this).index()).removeClass("hide");
            calendarTabContent.eq($(this).index()).siblings().addClass("hide");
        });
        calendarTabNav.find(".calendar-tab-nav-item").eq(0).trigger("click");
    }

}

/* 달력그리기 */
function displayCalendar(displayDate){

    //달력그리기
    var year = displayDate.getFullYear(); //2022
    var month = displayDate.getMonth(); //4
    var date = displayDate.getDate(); //30

    //전달
    var beforeMonth = month - 1; //3

    //다음달
    var afterMonth = month + 1; //5

    var insertMonth = ((month + 1) < 10) ? "0" + (month + 1) : month + 1; //05
    var insertToday = ((date) < 10) ? "0" + date : date; // 30

    //년월제목입력
    $(".insert-year-month").html(year + "." + insertMonth);

    //저번달 -- 첫째날, 마지막날
    var lastMonthFirstDate = new Date(year, month - 1, 1); // 2022년 4월1일
    var lastMonthLastDate = new Date(lastMonthFirstDate.getFullYear(), lastMonthFirstDate.getMonth() + 1, 0); // 2022년 4월 30일
    var __lastMonthLastDate = lastMonthLastDate.getDate(); // 4월은 30일이 마지막

    //이번달 -- 첫째날, 마지막날
    var thisMonthFirstDate = new Date(year, month, 1); // 2022년 5월1일
    var thisMonthLastDate = new Date(thisMonthFirstDate.getFullYear(), thisMonthFirstDate.getMonth() + 1, 0); // 2022년 5월31
    var __thisMonthLastDate = thisMonthLastDate.getDate(); // 5월은 31일이 마지막

    var theDay = thisMonthFirstDate.getDay(); // 요일값, 0일 앞의 빈칸 갯수

    var calDate = new Date(thisMonthFirstDate.setDate(thisMonthFirstDate.getDate() - theDay));

    //다음달 -- 첫째날, 마지막날
    var nextMonthFirstDate = new Date(year, month + 1, 1);
    var nextMonthLastDate = new Date(nextMonthFirstDate.getFullYear(), nextMonthFirstDate.getMonth() + 1, 0);

    var calendar = "";
    for (var i = 0;i < 6 ; i++){ // 행
        calendar += "<tr>";
        for(var k = 0; k < 7 ; k++){ // 열
            var classDivStr = (month != calDate.getMonth()) ? "not-day-wrap" : "day-wrap";
            var classSpanStr = (month != calDate.getMonth()) ? "not-this-month" : "this-month";
            var today = (date == calDate.getDate() && month == calDate.getMonth()) ? "selected" : "";
            var dateStr = calDate.getFullYear() +"-"
                + ((calDate.getMonth() + 1) < 10 ? "0" + (calDate.getMonth() + 1) : calDate.getMonth() + 1) +"-"
                + ((calDate.getDate()) < 10 ? "0" + (calDate.getDate()) : calDate.getDate());

            calendar += "<td id='day_" + dateStr + "' class='date day-" + calDate.getDay()+"'>";

            //해당 달 X
            if(classDivStr == "not-day-wrap" && classSpanStr == "not-this-month"){
                calendar += "<div class='" + classDivStr + " " + today + "'>" // <div class = "this_month selected" ~
                    + "<span class='"+classSpanStr+"'>" + calDate.getDate() + "</span>"
                    + "</div>";
            }else{
                //해당 달 O
                calendar += "<div class='" + classDivStr + " " + today + "'>" // <div class = "this_month selected" ~
                    + "<span class='"+classSpanStr+"'>" + calDate.getDate() + "</span>"

                //샘플 : 알람(낙상 또는 증상 또는 푸시 또는 메모가 있는 경우)
                if(dateStr == "2023-02-01" || dateStr == "2023-02-06" || dateStr == "2023-02-12" || dateStr == "2022-02-14" || dateStr == "2023-02-16" || dateStr == "2023-12-20" || dateStr == "2023-02-21" || dateStr == "2023-02-28"){
                    calendar += "<span class=\"alarm\">\n" +
                        "<span></span>\n" +
                        "</span>";
                }
                + "</div>";
            }

            calendar += "</td>";
            calDate = new Date(calDate.setDate(calDate.getDate() + 1));
        }
        calendar += "</tr>";

    }

    $(".card.calendar > .card-body > .calendar-body > table").find("tbody").append(calendar);

    var calendarContent = $(".calendar-body");

    var calendarDetailCard = $(".card.calendar-detail");
    var calendarTabNav = calendarDetailCard.find(".calendar-tab-nav");
    var calendarTabContent = calendarDetailCard.find(".calendar-tab-content");

    //상세일정 나오게
    calendarContent.find("table td > .day-wrap").off("click");
    calendarContent.find("table td > .day-wrap").on("click", function () {
        $(this).addClass("selected");
        var dayStr = $(this).parent().attr("id");
        var selectDay = dayStr.split("-");
        calendarDetailCard.find(".detail-date").html(selectDay[0].replace("day_","") + "." + selectDay[1] + "." + selectDay[2]);

        var noAlarm = $("#html-part .no-alarm").clone();

        var sample_01 = $("#html-part .calendar-table-content.sample_01").clone();
        var sample_02 = $("#html-part .calendar-table-content.sample_02").clone();
        var sample_03 = $("#html-part .calendar-table-content.sample_03").clone();
        var sample_04 = $("#html-part .calendar-table-content.sample_04").clone();

        if ($(this).find(".alarm").length) {
            //  달력 - 내용 있을 시
            calendarTabNav.find(".calendar-tab-name").eq(0).html("낙상<em class='cnt'>2</em>");
            calendarTabNav.find(".calendar-tab-name").eq(1).html("증상<em class='cnt'>2</em>");
            calendarTabNav.find(".calendar-tab-name").eq(2).html("푸시<em class='cnt'>1</em>");
            calendarTabNav.find(".calendar-tab-name").eq(3).html("메모<em class='cnt'>2</em>");

            calendarTabContent.empty();

            calendarTabContent.eq(0).append(sample_01);
            calendarTabContent.eq(1).append(sample_02);
            calendarTabContent.eq(2).append(sample_03);
            calendarTabContent.eq(3).append(sample_04);

        } else {
            // 달력 - 내용 없을 시
            calendarTabNav.find(".calendar-tab-name > em.cnt").remove();
            calendarTabContent.empty();
            calendarTabContent.append(noAlarm);
        }

        calendarContent.find(".day-wrap").not($(this)).removeClass("selected");

    });

    //selected 클래스 있을 경우 자동 클릭
    calendarContent.find("table td > .day-wrap.selected").trigger("click");

    // 메모 리스트에서 메모 클릭
    $(".memo-list table tbody tr").off("click");
    $(".memo-list table tbody tr").on("click", function() {
        NSM.showDialog("memo");
    });

}

var DCS = new dtxCalendarScript();