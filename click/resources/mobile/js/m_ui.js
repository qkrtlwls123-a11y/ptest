$(document).ready(function(e) {
	var checkBrowser = function() {
		var agt = navigator.userAgent.toLowerCase();
		if (agt.indexOf("chrome") != -1) return 'Chrome'; 
		if (agt.indexOf("opera") != -1) return 'Opera'; 
		if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
		if (agt.indexOf("webtv") != -1) return 'WebTV'; 
		if (agt.indexOf("beonex") != -1) return 'Beonex'; 
		if (agt.indexOf("chimera") != -1) return 'Chimera'; 
		if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
		if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
		if (agt.indexOf("firefox") != -1) return 'Firefox'; 
		if (agt.indexOf("safari") != -1) return 'Safari'; 
		if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
		if (agt.indexOf("msie") != -1) return 'Internet Explorer'; 
		if (agt.indexOf("netscape") != -1) return 'Netscape'; 
		if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla'; 
	}

	function onCheckDevice() {
		var isMoble = (/(iphone|ipod|ipad|android|blackberry|windows ce|palm|symbian)/i.test(navigator.userAgent)) ? "mobile" : "pc";
		$("body").addClass(isMoble);

		var deviceAgent = navigator.userAgent.toLowerCase();
		var agentIndex = deviceAgent.indexOf('android');

		if(agentIndex != -1) {
			var androidversion = parseFloat(deviceAgent.match(/android\s+([\d\.]+)/)[1]);

			$("body").addClass("android");

			// favicon();

			if(androidversion < 4.1) {
				$("body").addClass("android_old android_ics");
			}
			else if(androidversion < 4.3) {
				$("body").addClass("android_old android_oldjb");
			}
			else if(androidversion < 4.4) {
				$("body").addClass("android_old android_jb");
			}
			else if(androidversion < 5) {
				$("body").addClass("android_old android_kk");
			}
			else if(androidversion < 6) {
				$("body").addClass("android_old");
			}
			
			if(checkBrowser() == 'Firefox' 
				|| checkBrowser() == 'Mozilla') {
				$("body").removeClass("android_ics android_oldjb android_jb android_kk");
			}
			else if(checkBrowser() == "Chrome") {
				var chromeVersion = parseInt(deviceAgent.substring(deviceAgent.indexOf("chrome") + ("chrome").length + 1));
				
				if(chromeVersion > 40) {
					$("body").removeClass("android_old android_ics android_oldjb android_jb android_kk");
				}
				else {
					$("body").removeClass("android_ics android_oldjb android_jb android_kk");
				}
			}
		}
		else if(deviceAgent.match(/msie 8/) != null || deviceAgent.match(/msie 7/) != null) {
			$("body").addClass("old_ie");
		}
		else if(deviceAgent.match(/iphone|ipod|ipad/) != null) {
			$("body").addClass("ios");
		}
	}

	onCheckDevice();

	// css check
	window.checkSupported = function(property) {
		return property in document.body.style;
	}

	
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

				if($(list).siblings(".txt").find(".val").length > 0) {
					$(list).siblings(".txt").find(".val").text(text);
				}
				else {
					$(list).siblings(".txt").text(text);
				}

				$(list).siblings(".txt").removeClass("on");
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
				var value = $(this).text();

				$(this).parents(".dlst").eq(0).stop().slideUp(time, function() {
					if($(this).siblings(".txt").find(".val").length > 0) {
						$(this).siblings(".txt").find(".val").text(value);
					}
					else {
						$(this).siblings(".txt").text(value);
					}

					$(this).siblings(".txt").focus();
				});

				$(".dropLst > a").removeClass("on");

				$(this).parents(".dlst").eq(0).find("li a").removeClass("on");
				$(this).addClass("on");
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
			}).on("focus", ".dropLst .dlst label", function(evt) {
				$(this).on("keyup", addEnterKeyEvent);
			}).on("blur", "label", function(evt) {
				$(this).off("keyup", addEnterKeyEvent);
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
					if(evt.type == "click") {
						activeList.find(".txt").removeClass("on").removeClass("active");
					}
				}
			});

			function addEnterKeyEvent(evt) {
				var keyCode = evt.keyCode;
				if(keyCode == 13) {
					$(this).children(".hidradio").prop("checked", true).trigger("change");
					$(this).parents(".dropLst").eq(0).find(".txt").focus();
				}
			}

			// init dropdown list value
			$(".dropLst").each(function(i) {
				var groupName = $(this).find(".hidradio").eq(0).attr("name");
				var radios = $(".hidradio[name=" + groupName + "]");
				var checked = $(radios).filter(function() { return $(this).prop("checked") === true; });
				var list = $(this).find(".dlst");
				var text = null;

				if(radios.length > 0 && checked.length > 0) {
					text = (checked.length > 0) ? $(checked).parents("label").find(".value").text() : radios.eq(0).siblings(".value").text();
	
					$(list).find("label").removeClass("on").attr("tabindex", 0);
					$(list).find("label input").attr("tabindex", -1);
					if (checked.length > 0) {
						$(checked).parents("label").eq(0).addClass("on");
					}
					else {
						radios.eq(0).parents("label").eq(0).addClass("on");
					}
				}
				else {
					text = (list.find(".value.on").length > 0) ? list.find(".value.on").text() : (($(this).find(".txt .val").length > 0) ? $(this).find(".txt .val").text() : $(this).find(".txt").text());
				}				

				if($(list).siblings(".txt").find(".val").length > 0) {
					$(list).siblings(".txt").find(".val").text(text);
				}
				else {
					$(list).siblings(".txt").text(text);
				}
			});
		}

		return {
			init : init
		};
	}());

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

	//
	goTop.init();

	//button isDisabled
	$("a.isDisabled").on("click", function(e){
		e.preventDefault();
		return false;
	});

	//popup Close
	$(".popup .btn_close").on("click", function(e){
		e.preventDefault();
		$(this).parents(".popup").bPopup().close();
	});

	//tab Menu
	$(".tab_menu").on("click", function(e){
		e.preventDefault();
		$(".tab_menu").removeClass("active");
		$(this).addClass("active");
	});
	
});

var loading = {
	show : function(target) {
		var html = '<div class="loadings' + ((target) ? ' inner' : '') + '"><div><i></i></div></div>';

		if(target) {
			if($(target).find("> .loadings").length < 1) $(target).append(html);
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

// gotop
var goTop = (function() {
	var btnWrap = null;
	var btn = null;
	var footer = null;
	var padding = 0;

	function init() {
		if($(".sticky_top").length < 1) return false;

		btnWrap = $(".sticky_top");
		btn = $(".btn_top");
		footer = $(".footer");

		// scroll
		$(window).scroll(onScroll).resize(onScroll) //.load(onScroll);

		$(window).on("load", onScroll)

		// click
		btn.on("click", function(evt) {
			evt.preventDefault();
			$("html, body").stop().animate({scrollTop:0}, 500, "easeOutExpo");
		});
	}

	function onScroll() {			
		var top = $(window).scrollTop();
		var padding = 40;

		if(top > 70) {
			btn.parent().fadeIn(100);

			var windowh = (window.innerHeight) ? window.innerHeight : $(window).height();
			var footOffset = footer.offset().top - windowh + padding;
			var topPos = footer.offset().top - btn.outerHeight();

			if(top >= footOffset) {
				btnWrap.addClass("off").css("top",  topPos);
			}
			else {
				btnWrap.removeClass("off").css("top", "auto");
			}
		}
		else {
			btn.parent().fadeOut(100);
		}
	}

	return {
		init : init,
		refresh : onScroll
	}
}());

var jqDatePicker = (function() {
	function init() {
		var dateOption = {
			changeYear: false,
			changeMonth: false,
			autoSize:true, 
			showMonthAfterYear:true, 
			dateFormat:"yy-mm-dd", 
			minDate: "-150y",
			maxDate: "+1y",
			yearRange: "-100:+1",
			showButtonPanel: false,
			closeText: "닫기",
			currentText: 'Today',
			dayNames: ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"], 
			dayNamesMin:["天", "一", "二", "三", "四", "五", "六"], 
			monthNames:["- 01","- 02","- 03","- 04","- 05","- 06","- 07","- 08","- 09","- 10","- 11","- 12"],
			monthNamesShort: [ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" ],
			navigationAsDateFormat: true, 
			prevText: '上個月', 
			nextText: '下個月',
			beforeShow: function(input, picker) {
				// showPrevNextYearButton($(this));
			},
			onChangeMonthYear: function(input, picker) {
				// showPrevNextYearButton($(this));
			}
		};

		$.datepicker.setDefaults(dateOption);		

		$(document).ready(function() {
			$(".txtDate").each(function(i) {
				$(this).datepicker(dateOption);	
				$(this).datepicker('setDate', 'today');			
			});

			$(window).resize(function() {
				$(".txtDate").each(function(i) {
					$(this).datepicker("hide");
				});
			});
		});
	}

	// 달력
	function showPrevNextYearButton($input) {
		setTimeout(function() {
			var header = $input.datepicker('widget').find('.ui-datepicker-header');

			if($input.datepicker('widget').find('.ui-datepicker-header').find(".ui-datepicker-prev").is(".ui-state-disabled") == false) {
				var $prevButton = $('<a title="去年" class="ui-datepicker-prevYear ui-corner-all"><span>去年</span></a>');
				header.find('a.ui-datepicker-prev').before($prevButton);
				$prevButton.unbind("click").bind("click", function() {
					$.datepicker._adjustDate($input, -1, 'Y');
				});
			}

			// ui-state-disabled
			if($input.datepicker('widget').find('.ui-datepicker-header').find(".ui-datepicker-next").is(".ui-state-disabled") == false) {
				var $nextButton = $('<a title="明年" class="ui-datepicker-nextYear ui-corner-all"><span>明年</span></a>');
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

jqDatePicker.init();

var popupCalender = (function() {
	var calender = null;
	var body = null;

	function init() {
		$(document).ready(function() {
			body = $("body");

			var pc = $(".popup_calender").detach();
			body.append(pc);

			calender = $("#pcal").datepicker({
				onSelect : function(input, picker) {
					// console.log("select");
				}
			});

			$(".popup_calender .cal_bg").on("click", onHide);

			$(".popup_calender .cal_bg").on("touchmove", function(evt) {
				evt.preventDefault();
				evt.stopPropagation();
				evt.stopImmediatePropagation();
			});

			$(".btn_show_cal").on("click", function(evt) {
				evt.preventDefault();

				var d = $(this).siblings(".comText").val();

				if(d.length > 2) {
					calender.datepicker("setDate", d);
				}
				else {
					calender.datepicker("setDate", new Date());
				}

				$(".btn_show_cal").removeClass("active");
				$(this).addClass("active");
				onShow();
			});

			$(".cal_btn").on("click", function(evt) {
				evt.preventDefault();
				
				if($(this).hasClass("btn_ok")) {
					var date = $.datepicker.formatDate("yy-mm-dd", calender.datepicker("getDate", "yy-mm-dd"));
					$(".btn_show_cal.active").siblings(".comText").val(date);
					$(".btn_show_cal.active").focus();
				}

				$(".btn_show_cal").removeClass("active");
				onHide();
			});											
		});
	}

	function onShow() {										
		body.addClass("show_calender");
		return false;
	}

	function onHide() {										
		body.removeClass("show_calender");
		return false;
	}

	return {
		init : init,
		show : onShow,
		hide : onHide
	}
}());