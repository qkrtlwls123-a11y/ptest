$(function () {
    //환자업데이트리스트
    $(".top-menu-item > .update-patient").off("click");
    $(".top-menu-item > .update-patient").on("click", function () {
        showSidePanel("update-patient", "right", function () {

        });
    });
    //알림 리스트
    $(".top-menu-item > .alarm").off("click");
    $(".top-menu-item > .alarm").on("click", function () {
        showSidePanel("alarm", "right", function () {

        });
    });
    //등록버튼 - 사이드 패널
    // $(".card.patient-item > .card-head > .patient-card-select > .modify").on("click", function () {
    //     showSidePanel("dtx-register-form-sample-01", "right", function () {
    //     });
    // });
    //
    // $(" .btn-add, td.tb-edit > .tb-modify-btn").on("click", function () {
    //     showSidePanel("dtx-register-form", "right", function () {
    //     });
    // });
    //
    // $(" .content-sample > div > .sample-mb-btn").on("click", function () {
    //     showSidePanel("sample-mobile", "right", function () {
    //     });
    // });



    var menuItem = $(".left-main-menu > .menu-item > a.menu-link");
    var subMenuItem = $(".sub-menu-item");
    //
    menuItem.on("click", function () {
        subMenuItem.removeClass("active");
        if($(this).parent().hasClass("menu-toggle") == true){
            $(this).parent().toggleClass("open");
        }else{
            $(this).parent().toggleClass("active");
        }
        menuItem.not($(this)).parent().removeClass("open");
        menuItem.not($(this)).parent().removeClass("active");
    });

    subMenuItem.on("click", function () {
       $(this).toggleClass("active");
        subMenuItem.not($(this)).removeClass("active");
    });

    // $("input").off("click");
    // $("input").on("click", function () {
    //     $(this).parent(".form-box").toggleClass("active");
    // });

    $(".btn-patient-card").on("click", function (){
        $(this).toggleClass("active");
    });

    $(".top-menu-item .profile-img-wrap").on("click", function () {
        $(this).next(".dropdown-menu").toggleClass("open");
    });

    // $("body").off("click");
    // $("body").on("click", function () {
    //     if($(".form-box").hasClass("active")){
    //         $(".form-box").removeClass("active");
    //     }
    //
    // });

    $(".register-form-box > input.select-input-box").off("click");
    $(".register-form-box > input.select-input-box").on("click",function () {
        $(this).toggleClass("open");
    });

    $(".form-select-box > li.select-item").off("click");
    $(".form-select-box > li.select-item").on("click",function () {
        $(this).next("span").text();
        alert();
    });

    $(".form-box.select-box").on("click", function () {
       $(this).toggleClass("active");
    });



});
/* ======================================= side panel show/hide =================*/
var elemSidePanel = null;
var activeSidePanelContainer = null;
function showSidePanel(sidePanelName, panelSide, callback) {
	
	if("dtx-survey-form" == sidePanelName){
		$.ajax({
			url : "/click/surveyRegi.do",
			type : "POST",
			success : function(result) {
				$("#side-panel-area .side-panel-content.right").html(result);
				if (elemSidePanel != null) {
			        $(elemSidePanel).detach();
			        $("#side-panel-part").append(elemSidePanel);
			        elemSidePanel = null;
			    }

			    var panelContainer = $("#side-panel-area .side-panel-content.right");
			    $(panelContainer).append(elemSidePanel);
			    activeSidePanelContainer = panelContainer;
			    
			    console.log(panelContainer);

			    $(panelContainer).get(0).style.setProperty("--panel-outer-factor", "800px");

			    setTimeout(function () {
			        $(panelContainer).addClass("active");
			    }, 410);

			    $("#side-panel-area").removeClass("hide");
			    setTimeout(function() {
			        $("#side-panel-area .side-panel-dim").addClass("active");
			    }, 30);

			    $("#side-panel-area .side-panel-dim").off("click");
			    $("#side-panel-area .side-panel-dim").on("click", function() {
			        hideSidePanel(panelSide);
			    });

			    // WRGA.preventBackPress(true, function() {
			    //     $("#side-panel-container .side-panel-dim").trigger("click");
			    // });

			    if (callback) callback();
			}
		});
	}else{
		$.ajax({
			url : "/click/surveyDetail.do",
			type : "POST",
			success : function(result) {
				$("#side-panel-area .side-panel-content.right").html(result);
				if (elemSidePanel != null) {
			        $(elemSidePanel).detach();
			        $("#side-panel-part").append(elemSidePanel);
			        elemSidePanel = null;
			    }

			    var panelContainer = $("#side-panel-area .side-panel-content.right");
			    $(panelContainer).append(elemSidePanel);
			    activeSidePanelContainer = panelContainer;
			    
			    console.log(panelContainer);

			    $(panelContainer).get(0).style.setProperty("--panel-outer-factor", "800px");

			    setTimeout(function () {
			        $(panelContainer).addClass("active");
			    }, 410);

			    $("#side-panel-area").removeClass("hide");
			    setTimeout(function() {
			        $("#side-panel-area .side-panel-dim").addClass("active");
			    }, 30);

			    $("#side-panel-area .side-panel-dim").off("click");
			    $("#side-panel-area .side-panel-dim").on("click", function() {
			        hideSidePanel(panelSide);
			    });

			    // WRGA.preventBackPress(true, function() {
			    //     $("#side-panel-container .side-panel-dim").trigger("click");
			    // });

			    if (callback) callback();
			}
		});
	}
}

function showSidePanel2(sidePanelName, panelSide, callback) {
	
		$.ajax({
			url : "/click/surveyDetailCal.do",
			type : "POST",
			success : function(result) {
				$("#side-panel-area .side-panel-content.right").html(result);
				if (elemSidePanel != null) {
			        $(elemSidePanel).detach();
			        $("#side-panel-part").append(elemSidePanel);
			        elemSidePanel = null;
			    }

			    var panelContainer = $("#side-panel-area .side-panel-content.right");
			    $(panelContainer).append(elemSidePanel);
			    activeSidePanelContainer = panelContainer;
			    
			    console.log(panelContainer);

			    $(panelContainer).get(0).style.setProperty("--panel-outer-factor", "1100px");

			    setTimeout(function () {
			        $(panelContainer).addClass("active");
			    }, 410);

			    $("#side-panel-area").removeClass("hide");
			    setTimeout(function() {
			        $("#side-panel-area .side-panel-dim").addClass("active");
			    }, 30);

			    $("#side-panel-area .side-panel-dim").off("click");
			    $("#side-panel-area .side-panel-dim").on("click", function() {
			        hideSidePanel(panelSide);
			    });

			    // WRGA.preventBackPress(true, function() {
			    //     $("#side-panel-container .side-panel-dim").trigger("click");
			    // });

			    if (callback) callback();
			}
		});
}

function hideSidePanel(panelSide, callback) {
    var panelContainer = $("#side-panel-area .side-panel-content." + panelSide);
    var outerFactor = ((panelSide === "bottom")
        ? $(panelContainer).find(" > div:eq(0)").outerHeight()
        : $(panelContainer).find(" > div:eq(0)").outerWidth()) + "px";
    $(panelContainer).get(0).style.setProperty("--panel-outer-factor", outerFactor);
    $(panelContainer).removeClass("active");

    setTimeout(function() {
        $("#side-panel-area .side-panel-dim").removeClass("active");
        setTimeout(function() {
            $("#side-panel-area").addClass("hide");
            if (callback) callback();
            //activeSidePanelContainer = null;
        }, 410);
    }, 410);
}
/* ======================================= side panel show/hide =================*/

var DTxScript = function() {
    var __this = this;
    var __cfunc = {};
    var __cparam = {};

    __this.getSetting = function(key, defaultValue) {
        return defaultValue;
    };

    __this.setSetting = function(key, value) {

    };

    return __this;
};

var DTX = new DTxScript();


