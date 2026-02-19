function doAjax(url, param, callback) {
	$.ajax({
				url : url,
				type : "post",
				data : param,
				success : function(responseData) {
					var data = responseData;
					$("#resultHTML").html(data);
					var resultType = $("input[id=resultType]").val();
					if (resultType == "invalid.session") {
						loading_remove();
						var loginParam = "";
						$.map(param, function(value, key) {
							if (loginParam.length > 0) {
								loginParam = loginParam + "&"
							}
							loginParam = key + "=" + value
						});
						var retUrl = window.location.pathname + "?"
								+ loginParam;
						fn_login(retUrl)
					} else {
						if (resultType == "error.sys") {
							loading_remove();
							alert("시스템 오류가 발생 하였습니다.\n오류가 계속되는 경우 관리자에게 문의하시기 바랍니다.")
						} else {
							if (resultType == "error.biz") {
								loading_remove();
								alert(document.getElementById("error_message").innerHTML)
							} else {
								eval(callback + "(data)")
							}
						}
					}
				},
				error : function(request, status, error) {
				}
			})
}
function doDivSH(c, a, b) {
	if (c == "show") {
		$("#" + a).show(b)
	} else {
		if (c == "hide") {
			$("#" + a).hide(b)
		} else {
			if (c == "toggle") {
				$("#" + a).toggle()
			} else {
				if (c == "empty") {
					$("#" + a).empty()
				} else {
					if (c == "slideUp") {
						$("#" + a).slideUp(b)
					} else {
						if (c == "slideDown") {
							$("#" + a).slideDown(b)
						} else {
							if (c == "slideToggle") {
								$("#" + a).slideToggle(b)
							}
						}
					}
				}
			}
		}
	}
}
function isNullAndTrim(a, b) {
	$(a).val(ltrim($(a).val()));
	$(a).val(rtrim($(a).val()));
	return isNull($(a), b)
}
function ltrim(a) {
	while (a.substring(0, 1) == " ") {
		a = a.substring(1, a.length)
	}
	return a
}
function rtrim(a) {
	while (a.substring(a.length - 1, a.length) == " ") {
		a = a.substring(0, a.length - 1)
	}
	return a
}
function isNull(a, b) {
	if ($(a).val() == "") {
		alert(b);
		var c = a.id;
		if ($(a).is(":visible")) {
			$(a).focus()
		}
		return false
	}
	return true
}
function isRadioValueChk(c, a) {
	var b = $("input:radio[name=" + c + "]:checked").val();
	if (b == "" || b == null) {
		alert(a);
		return false
	}
	return true
}
function isValidIPAddress(c, e) {
	var f = $(c).val();
	var b = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
	if (b.test(f)) {
		var d = f.split(".");
		if (parseInt(parseFloat(d[0])) == 0) {
			alert(e);
			c.focus();
			return false
		}
		for (var a = 0; a < d.length; a++) {
			if (parseInt(parseFloat(d[a])) > 255) {
				alert(e);
				c.focus();
				return false
			}
		}
		return true
	} else {
		alert(e);
		c.focus();
		return false
	}
}
function isValidPhone(b) {
	if (!isNullAndTrim(b, "전화번호를 입력해주세요.")) {
		$(b).focus();
		return false
	} else {
		var d = $(b).val();
		var a = d.split("-").length;
		var c = "";
		if (a == 2) {
			c = /^\d{3,4}-\d{4}$/
		} else {
			if (a == 3) {
				c = /^\d{3,4}-\d{4}$/
			} else {
				c = /^\d{4}$/
			}
		}
		if (!c.test()) {
			if ($(b).val().length == 4) {
				alert("전화번호는 [숫자]만 입력 가능 합니다.\n다시 입력해주세요.")
			} else {
				alert("전화번호는 [숫자,-]만 입력 가능 합니다.\n다시 입력해주세요.")
			}
			$(b).focus();
			return false
		}
	}
	return true
}
function isValidEmail(a) {
	if (!isNullAndTrim($(a), "이메일주소를 입력해주세요.")) {
		$(a).focus();
		return false
	}
	var b = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,10}(?:\.[a-z]{2})?)$/i;
	if ($(a).val().length < 6 || !b.test($(a).val())) {
		alert("이메일형식이 맞지 않습니다.\n다시 입력해주세요.");
		$(a).focus();
		return false
	}
	return true
}
function isValidNumber(b, c) {
	var a = $(b).val();
	a += "";
	a = a.replace(/^\s*|\s*$/g, "");
	if (a == "" || isNaN(a) || a.indexOf(".") > -1 || a.indexOf("-") > -1) {
		alert(c);
		$(b).focus();
		return false
	}
	return true
}
function fn_ImgResize(a) {
	jQuery("table").filter(".table_style1").find(".comment").find("img").each(
			function() {
				var e = $(this).width();
				if (e > a) {
					var c = $(this).attr("HEIGHT");
					var d = e / c;
					var b = Math.round(a / d);
					$(this).css({
						height : b,
						width : a,
						cursor : "pointer"
					});
					$(this).click(function() {
						window.open($(this).attr("src"))
					})
				}
			})
}
function leadingZeros(d, c) {
	var b = "";
	d = d.toString();
	if (d.length < c) {
		for (var a = 0; a < c - d.length; a++) {
			b += "0"
		}
	}
	return b + d
}
function setToday(f) {
	var c = $("#" + f);
	var d = new Date();
	var g = leadingZeros(d.getFullYear(), 4);
	var e = leadingZeros(d.getMonth() + 1, 2);
	var b = leadingZeros(d.getDate(), 2);
	var a = g + "-" + e + "-" + b;
	c.val(a)
}
function setOneMonth(g) {
	var c = $("#" + g);
	var d = new Date();
	var e = new Date(new Date(d).setMonth(d.getMonth() + 2));
	var h = leadingZeros(e.getFullYear(), 2);
	var f = leadingZeros(e.getMonth(), 2);
	var b = leadingZeros(e.getDate(), 2);
	var a = h + "-" + f + "-" + b;
	c.val(a)
}
function getToday(d) {
	var c = new Date();
	if (d == "") {
		d = "-"
	}
	var f = leadingZeros(c.getFullYear(), 4);
	var e = leadingZeros(c.getMonth() + 1, 2);
	var b = leadingZeros(c.getDate(), 2);
	var a = f + d + e + d + b;
	return a
}
function validationDate(f, d) {
	var g = $(f).val();
	var b = g.replace(/-/g, "");
	if (b == null || b == "") {
		alert(d + "이(가) 없습니다.");
		f.focus();
		return false
	}
	if (b.length != 8 || f.length == 8) {
		alert(d + "의 날짜 형식이 맞지 않습니다.");
		f.focus();
		return false
	}
	var e = b.substr(0, 4);
	var a = b.substr(4, 2) - 1;
	var c = b.substr(6, 2);
	var h = new Date(e, a, c);
	if (Number(e) < 1753) {
		alert(d + "의 1753년 부터 입력 가능 합니다.");
		$(f).focus();
		return false
	}
	if (h.getFullYear() != e || h.getMonth() != a || h.getDate() != c) {
		alert(d + "의 날짜 형식이 맞지 않습니다.");
		$(f).focus();
		return false
	}
	return true
}
function setDateFormat(f, d) {
	var h = $(f).val();
	var b = h.replace(/-/g, "");
	var g = "";
	if (b.length == 8) {
		var e = b.substr(0, 4);
		var a = leadingZeros(b.substr(4, 2), 2);
		var c = b.substr(6, 2);
		g = e + "-" + a + "-" + c;
		$(f).val(g);
		if (!validationDate(f, d)) {
			$(f).val("")
		}
	} else {
		if (b.length > 8) {
			alert(d + "의 날짜 자리수가  맞지 않습니다.");
			$(f).focus()
		}
	}
}
function compareDate(c, h) {
	var a = $(c).val();
	var d = $(h).val();
	var e = a.split("-");
	var b = d.split("-");
	e[1] = (Number(e[1]) - 1) + "";
	b[1] = (Number(b[1]) - 1) + "";
	var k = new Date(e[0], e[1], e[2]);
	var g = new Date(b[0], b[1], b[2]);
	var f = (g.getTime() - k.getTime()) / 1000 / 60 / 60 / 24;
	if (f < 0) {
		alert("종료일을 시작일 이후로 지정해주세요.");
		return false
	}
	return true
}
function chr_byte(b) {
	if (escape(b).length > 4) {
		return 2
	} else {
		var a = b.charCodeAt(0);
		if (a >= 65 && a <= 90) {
			return 1.33
		} else {
			if (a >= 97 && a <= 122) {
				return 1.19
			} else {
				return 1
			}
		}
	}
}
function fn_popup(a, l, k, f, g, c) {
	var b = (screen.width) ? (screen.width - k) / 2 : 0;
	var d = (screen.height) ? (screen.height - f) / 2 : 0;
	if (c == null || c == "") {
		c = "yes"
	}
	var e = "height=" + f + ",width=" + k + ",top=" + d + ",left=" + b
			+ ",scrollbars=" + g + ",resizable=" + c;
	window.open(a, l, e)
}
function fn_window(a) {
	window.open(a, "_blank")
}
function getByte(a) {
	if (escape(a).length > 4) {
		return 2
	} else {
		return 1
	}
}
function isLengthChk(f, c, e) {
	var b = $(f).val();
	var a = b.length;
	var g = 0;
	for (var d = 0; d < a; d++) {
		g += getByte(b.charAt(d))
	}
	if (g > c) {
		alert(e);
		$(f).focus();
		return false
	}
	return true
}
function isMinLengthChk(f, c, e) {
	var b = $(f).val();
	var a = b.length;
	var g = 0;
	for (var d = 0; d < a; d++) {
		g += getByte(b.charAt(d))
	}
	if (g < c - 1) {
		alert(e);
		$(f).focus();
		return false
	}
	return true
}
function isCommaChk(c, b) {
	var a = $(c).val();
	if (a.indexOf(",") > -1) {
		alert(b);
		$(c).focus();
		return false
	}
	return true
}
function fn_checkBoxCheckd(a, e, c) {
	var d = e.split(c);
	for (var b = 0; b < d.length; b++) {
		$("#contents input[name='" + a + "'][value='" + d[b] + "']").attr(
				"checked", true)
	}
}
function fn_number_validator(a) {
	if (isNaN($(a).val())) {
		alert("정수만 입력 가능합니다.");
		$(a).val("");
		$(a).focus()
	}
}
function fn_GetEvent(a) {
	if (navigator.appName == "Netscape") {
		keyVal = a.which
	} else {
		keyVal = event.keyCode
	}
	return keyVal
}
function fn_numbersonly(c) {
	var e = window.event ? window.event : c;
	var d = window.event ? true : false;
	var b = fn_GetEvent(c);
	var a = false;
	if (e.shiftKey) {
		a = false
	} else {
		if ((b >= 48 && b <= 57) || (b >= 96 && b <= 105) || (b == 8)
				|| (b == 9) || (b == 46) || (b == 37) || (b == 39) || (b == 17)
				|| (b == 190)) {
			a = true
		} else {
			alert("정수만 입력 가능합니다.");
			a = false
		}
	}
	if (!a) {
		if (!d) {
			e.preventDefault()
		} else {
			e.returnValue = false
		}
	}
}
String.prototype.comma = function() {
	tmp = this.split(".");
	var c = new Array();
	var a = tmp[0].replace(/,/gi, "");
	for (var b = 0; b <= a.length; b++) {
		c[c.length] = a.charAt(a.length - b);
		if (b % 3 == 0 && b != 0 && b != a.length) {
			c[c.length] = "."
		}
	}
	c = c.reverse().join("").replace(/\./gi, ",");
	return (tmp.length == 2) ? c + "." + tmp[1] : c
};
function chkMsgLength(c, a) {
	var b = lengthMsg($(a).val());
	if (b > c) {
		alert("최대" + c + "Byte(한글 " + c / 2
				+ "자)까지 입력 가능합니다.\r\n초과된 부분은 자동으로 삭제됩니다.");
		$(a).val($(a).val().replace(/\r\n$/, ""));
		$(a).val(assertMsg(c, $(a).val()))
	}
}
function lengthMsg(a) {
	var b = 0;
	for (var c = 0; c < a.length; c++) {
		var d = a.charAt(c);
		if (escape(d).length > 4) {
			b += 2
		} else {
			if (d == "\n") {
				if (a.charAt(c - 1) != "\r") {
					b += 1
				}
			} else {
				if (d == "<" || d == ">") {
					b += 4
				} else {
					b += 1
				}
			}
		}
	}
	return b
}
function assertMsg(e, a) {
	var f = 0;
	var b = 0;
	var g = "";
	var h = a.length;
	for (var c = 0; c < h; c++) {
		var d = a.charAt(c);
		if (escape(d).length > 4) {
			f = 2
		} else {
			if (d == "\n") {
				if (a.charAt(c - 1) != "\r") {
					f = 1
				}
			} else {
				if (d == "<" || d == ">") {
					f = 4
				} else {
					f = 1
				}
			}
		}
		if ((b + f) > e) {
			break
		}
		b += f;
		g += d
	}
	return g
}
function fn_print() {
	self.print()
}
function fn_TextAreaInputLimit(b, a, k) {
	var m = $("textarea[name='" + b + "']");
	var c = "";
	var h = "";
	var e = 0;
	var g = 0;
	var l = 0;
	for (var d = 0; d < m.val().length; d++) {
		c = m.val().charAt(d);
		if (escape(c).length > 4) {
			e += 2;
			g++
		} else {
			e++
		}
		if (e <= k) {
			l = d + 1
		}
	}
	if (e > k) {
		alert("최대 글자수를 초과하였습니다.");
		var f = e - k;
		h = m.val().substr(0, l);
		m.val(h);
		$("#" + a).html(k)
	} else {
		$("#" + a).html(e)
	}
}
function checkNum(a) {
	if ($("#" + a).val().match(/[^0-9]/g) != null) {
		alert("숫자만 입력 가능 합니다.");
		$("#" + a).val($("#" + a).val().replace(/[^0-9]/g, ""))
	}
}
function checkMail(a) {
	if ($("#" + a).val().match(/[^a-z0-9]/gi) != null) {
		alert("영문과 숫자만 입력 가능 합니다.");
		$("#" + a).val($("#" + a).val().replace(/[^a-z0-9]/gi, ""))
	}
}
function checkAlphaNum(a) {
	if ($("#" + a).val().match(/[^a-z0-9]/gi) != null) {
		alert("영문과 숫자만 입력 가능 합니다.");
		$("#" + a).val($("#" + a).val().replace(/[^a-z0-9]/gi, ""))
	}
}
function mailcheck(e, c) {
	var d = $("#" + e).val();
	var b = $("#" + c).val();
	var f = d + "@" + b;
	var a = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if (!a.test(f)) {
		alert("올바른 이메일주소를 입력해주세요.");
		$("#" + e).focus();
		return false
	}
	return true
}
function BizRegisterNo_Check(R_No) {
	var re = /-/g;
	R_No = R_No.replace("-", "");
	if (R_No.length != 13) {
		return false
	}
	var arr_regno = R_No.split("");
	var arr_wt = new Array(1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2);
	var iSum_regno = 0;
	var iCheck_digit = 0;
	for (i = 0; i < 12; i++) {
		iSum_regno += eval(arr_regno[i]) * eval(arr_wt[i])
	}
	iCheck_digit = 10 - (iSum_regno % 10);
	iCheck_digit = iCheck_digit % 10;
	if (iCheck_digit != arr_regno[12]) {
		return false
	}
	return true
}
function BizCorpNo_Check(a) {
	var e, d, c, b;
	e = a.charAt(8) * 5;
	d = parseInt((e / 10), 10);
	c = e % 10;
	b = a.charAt(0) * 1 + a.charAt(1) * 3 + a.charAt(2) * 7;
	b += a.charAt(3) * 1 + a.charAt(4) * 3 + a.charAt(5) * 7;
	b += a.charAt(6) * 1 + a.charAt(7) * 3 + a.charAt(9) * 1;
	b += (d + c);
	if (!(b % 10)) {
		return true
	} else {
		return false
	}
}
function id_check(a) {
	var c = 0;
	for (var b = 0; b < a.length; b++) {
		var d = a.charAt(b);
		if (!((d >= "0" && d <= "9") || (d >= "a" && d <= "z") || (d >= "A" && d <= "Z"))) {
			c++
		}
	}
	if (c == 0) {
		return true
	} else {
		return false
	}
}
function password_check(a) {
	var c = 0;
	for (var b = 0; b < a.length; b++) {
		var d = a.charAt(b);
		if (((d == ",") || (d == "'"))) {
			c++
		}
	}
	if (c == 0) {
		return true
	} else {
		return false
	}
}
function fn_length_chk(b, a, c) {
	if (b.val().length < a) {
		alert(c + " 길이가 짧습니다");
		b.focus();
		return false
	}
	return true
}
function fn_back() {
	history.go(-1)
}
function fn_main() {
	window.location = "/main.do"
}
function fn_removeclass() {
	$("#lnb").remove()
}
function commify(b) {
	var a = /(^[+-]?\d+)(\d{3})/;
	b += "";
	while (a.test(b)) {
		b = b.replace(a, "$1,$2")
	}
	return b
}
function eventCheckBoxCheck(thisForm) {
	var frmCnt;
	var cFrm;
	var frNm;
	var tmpFrm;
	var strValue;
	frmCnt = thisForm.elements.length;
	for (i = 0; i <= frmCnt - 1; i++) {
		var cFrm = thisForm[i];
		if (cFrm.type.toLowerCase() == "textarea"
				|| cFrm.type.toLowerCase() == "text") {
			frNm = cFrm.name;
			tmpFrm = eval("thisForm." + frNm);
			strValue = tmpFrm.value;
			for (j = 0; j < strValue.length; j++) {
				strValue = strValue.replace(/, /g, ",")
			}
			tmpFrm.value = strValue
		}
	}
}
function LengthCheck(e, c, b, d) {
	var a = 0;
	a = GetLength(e);
	if (b > 0 && a == 0) {
		msg = "[" + c + "] : 입력해주십시오!";
		alert(msg);
		return false
	}
	if (a < b || a > d) {
		if (b == d) {
			msg = "[" + c + "] : " + b
					+ "자를 입력해주십시오!\r\n\r\n (주의: 한글 1자는 2자로 계산함.)";
			alert(msg);
			return false
		} else {
			msg = "[" + c + "] : " + b + " - " + d
					+ " 자를  입력해주십시오!\r\n\r\n (주의: 한글 1자는 2자로 계산함.)";
			alert(msg);
			return false
		}
	} else {
		return true
	}
}
function GetLength(e) {
	var c = 0;
	var a;
	var b;
	for (var d = 0; d <= e.length - 1; d++) {
		a = e.substring(d, d + 1);
		chrEscaped = escape(a);
		if (chrEscaped.substring(0, 2) == "%u") {
			c = c + 2
		} else {
			c++
		}
	}
	return c
}
function trim(c) {
	var e = new Array();
	var d;
	var b = "";
	if (c == null) {
		return ""
	}
	d = c.length;
	for (var a = 0; a < d; a++) {
		e[a] = c.charAt(a);
		if (e[a] == " ") {
			if (a > 0) {
				if (!e[a - 1]) {
					e[a] = ""
				}
			} else {
				e[a] = ""
			}
		}
	}
	for (a = d - 1; a >= 0; a--) {
		if (e[a] == " ") {
			if (a < d - 1) {
				if (!e[a + 1]) {
					e[a] = ""
				}
			} else {
				e[a] = ""
			}
		}
	}
	for (a = 0; a < d; a++) {
		if (e[a]) {
			b += e[a]
		}
	}
	return b
}
function fn_check_password(b) {
	var d = $(b).val();
	var c = d.search(/[0-9]/g);
	var a = d.search(/[a-z]/ig);
	if (c < 0 || a < 0) {
		alert("비밀번호는 숫자와 영문자를 혼용하여야 합니다.");
		return false
	}
	return true
}

function loading_init() {
	$("body").append('<div class="modal-backdrop fade in"></div>');
	$("body")
			.append(
					'<div class="loading-backdrop"><img src="/resorce/images/common/loading.gif" alt="로딩중"></div>')
}
function loading_remove() {
	$(".modal-backdrop").remove();
	$(".loading-backdrop").remove()
};