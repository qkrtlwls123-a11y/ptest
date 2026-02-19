$(document).ready(function(e) {

	if($(".subPage").length > 0) {
		if($(".lnb").length < 1) {
			$(".subPage").addClass("withOutLnb");
		}
	}


	// input tag focus
	$(document).on("focus", ".comText, textarea", function(evt) {
		$(this).parent().addClass("focus");
	}).on("blur", ".comText, textarea", function(evt) {
		$(this).parent().removeClass("focus");
	});

	// css check
	window.checkSupported = function(property) {
		return property in document.body.style;
	}

	// select
	var selectList = (function() {
		function init() {
			// select
			$(document).on("change", ".selectbox select", function(evt) {
				if($(this).attr("readonly")) {
					return false;
				}

				var text = $(this).find("option:selected").text();
				$(this).siblings(".txt").text(text);
			}).on("keyup", ".selectbox > .txt", function(evt) {
				var keyCode = evt.keyCode;
				var labelText = $(this).text();
				var selectObj = $(this).siblings("select");
				var idx = ($(this).text() == $(selectObj).children("option:selected").text()) ? $(selectObj).children("option:selected").index() : 0;

				if(keyCode == 38 || keyCode == 37) {
					if(idx == 0) $(selectObj).children().eq($(selectObj).children().length - 1).attr("selected", "selected").trigger("change");
					else $(selectObj).children().eq(idx - 1).attr("selected", "selected").trigger("change");
				} 
				else if(keyCode == 40 || keyCode == 39) {
					if(idx == ($(selectObj).children().length - 1)) $(selectObj).children().eq(0).attr("selected", "selected").trigger("change");
					else $(selectObj).children().eq(idx + 1).attr("selected", "selected").trigger("change");
				}
			}).on("click", ".selectbox > .txt", function(evt) {
				return false;
			}).on("focus", ".selectbox select", function(evt) {
				$(this).siblings(".txt").addClass("focus");
			}).on("blur", ".selectbox select", function(evt) {
				$(this).siblings(".txt").removeClass("focus");
			}).on("reset", "form", function(evt) {
				var selects = $(this).find(".selectbox select");
				
				setTimeout(function() {
					$(selects).each(function(i) {
						var text = ($(this).find("option:selected").text().length > 0) ? $(this).find("option:selected").text() : $(this).find("option").eq(0).text();
						$(this).siblings(".txt").text(text);
					});
				}, 30);
			});

			// init select box value
			$(".selectbox select").each(function(i) {
				// var title = $(this).attr("title") + "\n상하 화살표키를 이용해 값을 선택하실 수 있습니다.";
				// $(this).attr("title", title);

				var text = ($(this).find("option:selected").text().length > 0) ? $(this).find("option:selected").text() : $(this).find("option").eq(0).text();
				$(this).siblings(".txt").text(text);
			});

		}

		return {
			init : init
		};
	}());

	// dropdown list
	var dropList = (function() {
		function init() {
			var time = 150;

			// dropdown list
			$(document).on("change", ".dropLst .hidradio", function(evt) {
				var groupName = $(this).attr("name");
				var radios = $(".hidradio[name=" + groupName + "]");
				var checked = radios.filter(function() { return $(this).prop("checked") === true; });
				var text = $(checked).parents("label").find(".value").text();
				var list = $(checked).parents(".dlst").eq(0);

				$(list).find("label").removeClass("on");
				$(checked).parents("label").eq(0).addClass("on");

				$(list).siblings(".txt").text(text).removeClass("on");
				$(checked).parents(".dlst").slideUp(time);
			}).on("click", ".dropLst > a", function(evt) {
				evt.preventDefault();
				
				var label = $(this);
				var target = $(this).parents(".dropLst").eq(0);
				var list = $(this).siblings(".dlst");
				var openList = $(".dropLst").filter(function() { return $(this).find(".dlst").css("display") != "none" && $(this) != target });

				$(openList).find(".dlst").stop().slideUp(time);
				$(target).find(" > a").removeClass("on").addClass("active");

				$(list).stop().slideToggle(time, function() {
					if($(this).css("display") != "none") $(label).addClass("on");
					else $(label).removeClass("on");

					$(label).removeClass("active");
				});
			}).on("click", ".dropLst li a", function(evt) {
				var linkOnly = ($(this).attr("target") != "_blank") ? false : true;
				var value = $(this).text();

				$(this).parents(".dlst").eq(0).stop().slideUp(time, function() {
					if(!linkOnly) {
						$(this).siblings(".txt").focus().text(value);
					}
				});

				$(".dropLst > a").removeClass("on");

				$(this).parents(".dlst").eq(0).find("li a").removeClass("on");
				
				if(!linkOnly) {
					$(this).addClass("on");
				}
			}).on("keyup", ".dropLst > a", function(evt) {
				var keyCode = evt.keyCode;

				var target = $(this).parents(".dropLst").eq(0);
				var list = $(this).siblings(".dlst");
				var chkRadio = $(this).siblings(".dlst").find(".hidradio:checked");
				var hoverRadio = $(list).find(".hover");
				var idx = -1;

				if(hoverRadio.length < 1) idx = (chkRadio.parents("li").eq(0).index() > -1) ? chkRadio.parents("li").eq(0).index() : 0;
				else idx = hoverRadio.parents("li").eq(0).index();

				var openList = $(list).filter(function() { return $(this).css("display") != "none" });
				if(openList.length < 1) return false;

				if(keyCode == 13) {
					$(list).find("li").find(".hover").find(".hidradio").prop("checked", true).trigger("change");
					$(list).find("label").removeClass("hover");
				} 
				else if(keyCode == 38 || keyCode == 37) {
					$(list).find("label").removeClass("hover");

					if(idx == 0) $(list).find("li").eq($(list).find("li").length - 1).find("label").addClass("hover");
					else $(list).find("li").eq(idx - 1).find("label").addClass("hover");
				}
				else if(keyCode == 40 || keyCode == 39) {
					$(list).find("label").removeClass("hover");
					
					if(idx == ($(list).find("li").length - 1)) $(list).find("li").eq(0).find("label").addClass("hover");
					else $(list).find("li").eq(idx + 1).find("label").addClass("hover");
				}
			}).on("click touchstart", function(evt) {
				var evt = evt ? evt : event;
				var target = null;

				if (evt.srcElement) target = evt.srcElement;
				else if (evt.target) target = evt.target;

				var openList = $(".dropLst").filter(function() { return $(this).find(".dlst").css("display") != "none" });
				var activeList = $(".dropLst").filter(function() { return $(this).find(".txt").hasClass("on") === true });
				if($(target).parents(".dropLst").eq(0).length < 1) {
					$(openList).find(".dlst").slideUp(time);
					$(".dropLst > a").removeClass("on").removeClass("active");
				}
				else if(activeList.length > 0) {
					activeList.find(".txt").removeClass("on").removeClass("active");
				}
			});

			// init dropdown list value
			$(".dropLst").each(function(i) {
				var groupName = $(this).find(".hidradio").eq(0).attr("name");
				var radios = $(".hidradio[name=" + groupName + "]");
				var checked = $(radios).filter(function() { return $(this).prop("checked") === true; });
				var text = $(checked).parents("label").find(".value").text();
				var list = $(checked).parents(".dlst").eq(0);

				$(list).find("label").removeClass("on");
				$(checked).parents("label").eq(0).addClass("on");

				$(list).siblings(".txt").text(text);
			});
		}

		return {
			init : init
		};
	}());

	selectList.init();
	dropList.init();

	// file
	window.upFile = (function() {
		function init() {
			// file event
			$(document).on("change", ".hidFile", function(evt) {
				var file = $(this).val().split(/(\\|\/)/g).pop();
				var ext = file.split(".").pop();
				var fileLabel = $(this).siblings(".comText");
				var helpText = fileLabel.attr("title");

				if($(this).attr("readonly")) {
					return false;
				}

				if(file.length > 1) {
					fileLabel.text(file).removeClass("unselect");
				}
				else {
					fileLabel.text(helpText).addClass("unselect");
				}
			}).on("reset", "form", function(evt) {
				$(this).find(".hidFile").each(function(i) {
					var helpText = $(this).siblings(".comText").attr("title");
					$(this).siblings(".comText").text(helpText).addClass("unselect");
				});
			});
		}

		return {
			init : init
		}
	}());

	upFile.init();

	// lnb
	siteLnb.init();

	// popup
	popupSize.init();
});

var checkMinDate = "-150y";
var before_start_date = "";
var before_end_date = "";
var gLocale = "";

var jqDatePicker = (function() {
	function init() {
		if(gLocale == "en"){
			var dateOption = {
					changeYear: false,
					changeMonth: false,
					autoSize:true, 
					showMonthAfterYear:true, 
					dateFormat:"yy-mm-dd", 
					minDate: checkMinDate,
					maxDate: "+100y",
					yearRange: "-100:+100",
					showButtonPanel: false,
					closeText: "닫기",
					currentText: 'Today',
					dayNames: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], 
					dayNamesMin:["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"],
					monthNames:["- 01","- 02","- 03","- 04","- 05","- 06","- 07","- 08","- 09","- 10","- 11","- 12"],
					monthNamesShort: [ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" ],
					navigationAsDateFormat: true, 
					prevText: '&nbsp;&nbsp;', 
					nextText: '&nbsp;&nbsp;',
					beforeShow: function() {
						showPrevNextYearButton($(this));
					},
					onChangeMonthYear: function() {
						showPrevNextYearButton($(this));
					}
			};
		}else{
			var dateOption = {
					changeYear: false,
					changeMonth: false,
					autoSize:true, 
					showMonthAfterYear:true, 
					dateFormat:"yy-mm-dd", 
					minDate: checkMinDate,
					maxDate: "+100y",
					yearRange: "-100:+100",
					showButtonPanel: false,
					closeText: "닫기",
					currentText: 'Today',
					dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"], 
					dayNamesMin:["일", "월", "화", "수", "목", "금", "토"], 
					monthNames:["- 01","- 02","- 03","- 04","- 05","- 06","- 07","- 08","- 09","- 10","- 11","- 12"],
					monthNamesShort: [ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" ],
					navigationAsDateFormat: true, 
					prevText: '&nbsp;&nbsp;', 
					nextText: '&nbsp;&nbsp;',
					beforeShow: function() {
						showPrevNextYearButton($(this));
					},
					onChangeMonthYear: function() {
						showPrevNextYearButton($(this));
					}
			};
		}

		$.datepicker.setDefaults(dateOption);

		$(document).ready(function() {
			$(".txtDate").each(function(i) {
				$(this).datepicker(dateOption);
			});

			$(window).resize(function() {
				$(".txtDate").each(function(i) {
					$(this).datepicker("hide");
				});
			});
			$('#start_date').click(function(){
				before_start_date = $('#start_date').val();
			})
			$('#end_date').click(function(){
				before_end_date = $('#end_date').val();
			})
		});
	}

	// 달력
	function showPrevNextYearButton($input) {
		setTimeout(function() {
			var header = $input.datepicker('widget').find('.ui-datepicker-header');

			if($input.datepicker('widget').find('.ui-datepicker-header').find(".ui-datepicker-prev").is(".ui-state-disabled") == false) {
				var $prevButton = $('<a title="이전년도" class="ui-datepicker-prevYear ui-corner-all"><span>이전년도</span></a>');
				header.find('a.ui-datepicker-prev').before($prevButton);
				$prevButton.unbind("click").bind("click", function() {
					$.datepicker._adjustDate($input, -1, 'Y');
				});
			}

			// ui-state-disabled
			if($input.datepicker('widget').find('.ui-datepicker-header').find(".ui-datepicker-next").is(".ui-state-disabled") == false) {
				var $nextButton = $('<a title="다음년도" class="ui-datepicker-nextYear ui-corner-all"><span>다음년도</span></a>');
				header.find('a.ui-datepicker-next').after($nextButton);
				$nextButton.unbind("click").bind("click", function() {
					$.datepicker._adjustDate($input, +1, 'Y');
				});
			}
		}, 1);
	};
	
	// mobile check
	function isMobile() {
		return /(iphone|ipod|ipad|android|blackberry|windows ce|palm|symbian)/i.test(navigator.userAgent);
	}

	return { 
		init : init
	};
}());

//jqDatePicker.init();

function fn_ckeckDate(minDate, dateType, gap , locale){
	if(!isEmpty(minDate)){
		checkMinDate = "-"+minDate+dateType;
	}else{
		checkMinDate = "-150y";
	}
	gLocale = locale;
	
	var dateOption = {
		changeYear: false,
		changeMonth: false,
		autoSize:true, 
		showMonthAfterYear:true, 
		dateFormat:"yy-mm-dd", 
		minDate: checkMinDate,
		maxDate: "+1y",
		yearRange: "-100:+1",
		showButtonPanel: false,
		closeText: "닫기",
		currentText: 'Today',
		dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"], 
		dayNamesMin:["일", "월", "화", "수", "목", "금", "토"], 
		monthNames:["- 01","- 02","- 03","- 04","- 05","- 06","- 07","- 08","- 09","- 10","- 11","- 12"],
		monthNamesShort: [ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" ],
		navigationAsDateFormat: true, 
		prevText: '&nbsp;&nbsp;', 
		nextText: '&nbsp;&nbsp;',
		beforeShow: function() {
			showPrevNextYearButton($(this));
		},
		onChangeMonthYear: function() {
			showPrevNextYearButton($(this));
		}
	};

	$.datepicker.setDefaults(dateOption);
	jqDatePicker.init();
	
	if(!isEmpty(gap)){
		$('#start_date').change(function(){
			fn_checkBase();
			fn_checkGap(gap, "start_date");
		});
		$('#end_date').change(function(){
			fn_checkBase();
			fn_checkGap(gap, "end_date");
		});
	}else{
		$('#start_date').change(function(){
			fn_checkBase();
		});
		$('#end_date').change(function(){
			fn_checkBase();
		});
	}
}

function fn_checkGap(gap, place){
	var startDate = $('#start_date').val();
	var endDate = $('#end_date').val();
	var startDateArr = startDate.split('-');
	var endDateArr = endDate.split('-');
	var startDateCompare = new Date( startDateArr[0], parseInt(startDateArr[1])-1, startDateArr[2] );
	var endDateCompare = new Date( endDateArr[0], parseInt(endDateArr[1])-1, endDateArr[2] );
	var tmpDiff = Math.abs(endDateCompare.getTime()-startDateCompare.getTime());
	var diff = Math.ceil( tmpDiff / (1000*3600*24) );
	if( diff > parseInt(gap) ){
		if(place == "start_date"){
			$('#start_date').val(before_start_date);
		}else if(place == "end_date"){
			$('#end_date').val(before_end_date);
		}
		if(null == getLocalStorage("locale") || 'ko_KR' == getLocalStorage("locale")) {
			openDefaultPopup("loginPopup" ,"최대 "+gap+"일간의 DATA만 조회 가능합니다." );
		} else {
			openDefaultPopup("loginPopup" ,"You can search only the data for the maximum "+gap+" day.");
		}
			
	}
}

function fn_checkBase(){
	var startDate = $("#start_date").val();
	var endDate = $("#end_date").val();
	if(!isEmpty(startDate)){
		startDate = parseInt(startDate.replace(/-/gi, ''));
	}
	if(!isEmpty(endDate)){
		endDate = parseInt(endDate.replace(/-/gi, ''));
	}
	if(!isEmpty(startDate) && !isEmpty(endDate)){
		if(startDate > endDate){
			if(null == getLocalStorage("locale") || 'ko_KR' == getLocalStorage("locale")) {
				openDefaultPopup("loginPopup" ,"시작일이 종료일 보다 클 수 없습니다." );
			} else {
				openDefaultPopup("loginPopup" ,"The start date cannot be later than the end date." );
			}
			$("#start_date").val(before_start_date);
		}
	} 
}

var loading = {
	show : function(target) {
		var html = '<div class="loadings' + ((target) ? ' inner' : '') + '"><div><i></i></div></div>';

		if(target) {
			$(target).append(html);
		}
		else {
			$("body").append(html);
		}
	},

	hide : function(target) {
		if(target) {
			$(target).find(".loadings").remove();
		}
		else {
			$(".loadings").remove();
		}
	}
}

var count = {
	start : function(target) {
		var options = {
			useEasing: true, 
			useGrouping: true, 
			separator: ',', 
			decimal: '.', 
		};

		var startNum = (target.attr("start-val")) ? target.attr("start-val") : 0;
		var endNum = (target.attr("end-val")) ? target.attr("end-val") : parseInt(target.html());
		var duration = (target.attr("duration")) ? target.attr("duration") : 1;
		var num = new CountUp(target[0], startNum, endNum, 0, duration, options);
		
		if (!num.error) {
			num.start();
		} else {
			console.error(num.error);
		}
	}
}


var siteLnb = (function() {
	var lnb = null;
	var bottomButtom = null;
	var minTop = 0;
	var header = null;

	function init() {
		$(document).ready(function() {
			if($(".lnb").length < 1) return;

			header = $(".sub_layout .header");
			lnb = $(".lnb .nav_area");

			var removeUl = $(".nav_list .snav").filter(function() { return $(this).find("ul > li").length < 1; });

			removeUl.remove();

			// lnb event
			$(".nav_list").on("click", ".tnav", function(evt) {
				if($(this).siblings(".snav").length > 0) {
					evt.preventDefault();

					var liObj = $(this).parents("li").eq(0);
					
					if(!liObj.hasClass("on")) {
						$(this).siblings(".snav").stop().slideDown(200);
						liObj.addClass("on");
					}else{
						$(this).siblings(".snav").stop().slideUp(200);
						liObj.removeClass("on");
					}
					
				}
			});


			fixLnb();
		});
	}

	function fixLnb() {
		$(window).resize(onScroll).load(onScroll).scroll(onScroll);
		onScroll();	
	}

	function onScroll() {
		var wh = window.innerHeight;
		var headerHeight = header.outerHeight();
		var scrollTop = $(window).scrollTop();
		var scrollLeft = $(window).scrollLeft();

		if(header.css("position") != "fixed") {
			if(scrollTop > headerHeight) {
				lnb.addClass("fixed");
			}
			else {
				lnb.removeClass("fixed");
			}

			if(scrollLeft > 0 && lnb.hasClass("fixed")) {
				lnb.css("margin-left", -1 * scrollLeft);
			}
			else {
				lnb.css("margin-left", 0);
			}
		}
		else {
			if(scrollLeft > 0) {
				header.css("margin-left", -1 * scrollLeft);
			}
			else {
				header.css("margin-left", 0);
			}
		}
	}

	function onRefresh() {
		if(lnb.length < 1) return;

		onScroll();
	}

	return {
		init : init,
		refresh : onRefresh,
	}
}());


// image view
var imgView = (function() {
	var modal = null;
	var html = '<div class="modal_view"><div class="bg"></div><div class="modal_vcont"></div><a href="#" class="btn_close">x<em>닫기</em></a></div>';
	var showTime = null;
	var atime = 300;

	function init() {
		if($("body").find(".modal_view").length < 1) {
			$("body").append(html);
		}

		modal = $(".modal_view");
		modal.find(".bg").on("click", onClose);
		modal.find(".btn_close").on("click", onClose);
	}

	function onShow(imgSrc, imgCaption, callback) {
		if($("body").find(".modal_view").length < 1) {
			init();
		}

		// modal.find(".modal_vcont").append(imgObj.clone().attr({"class":"", "style":"", "witdh":"", "height":""}));
		modal.find(".modal_vcont").append('<img src="' + imgSrc + '" alt=""/>');

		if(imgCaption) {
			modal.find(".modal_vcont").append('<p class="fcaption">' + imgCaption + '</p>');
		}

		modal.show();
		modal.removeClass("hide").addClass("show");

		clearTimeout(showTime);

		showTime = setTimeout(function() {
			if($.isFunction(callback)) {
				callback();
			}
		}, atime);
	}

	function onClose() {
		modal.removeClass("show").addClass("hide");
		
		clearTimeout(showTime);

		showTime = setTimeout(function() {
			modal.hide();
			modal.find("img").remove();
			modal.find(".fcaption").remove();
		}, atime);

		return false;
	}

	return {
		init : init,
		show : onShow,
		close : onClose
	}
}());

// popup resize
var popupSize = {
	init : function() {
		$(document).ready(function() {
			if($("body").hasClass("popupPage") > 0) {

				$(window).load(function() {
					popupSize.refresh();
				});
			}
		});
	},

	refresh : function() {
		var popupContent = $(".popup_section");
		var dw = popupContent.outerWidth();
		var dh = popupContent.outerHeight();

		var mw = window.outerWidth - window.innerWidth;
		var mh = window.outerHeight - window.innerHeight;

		var newWidth = dw + mw;
		var newHeight = dh + mh;

		window.resizeTo(newWidth, newHeight);
		window.moveTo((screen.width / 2) - (newWidth / 2), 20);
	}
}


//추가
$(document).ready(function(e) {
	$(".btn_sort").on("click", function(e){
		e.preventDefault();
		var text = $(this).html();
		if(text.indexOf("▲") > -1)
		{
			$(this).text(text.replace('▲', '▼'));
		}
		else
		{
			$(this).text(text.replace('▼', '▲'));
		}

	})
});