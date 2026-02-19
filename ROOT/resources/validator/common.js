var isIE = (navigator.appName.indexOf("Microsoft") != -1) ? 1 : 0;
//━━━━━━━━━━━━━━━━━━━━━━━
// 포커스이동
//───────────────────────
function MoveFocus(num,	formform,	toform){
	var str = formform.value.length;
	if(str == num) {
		toform.focus();
	}    
}
//━━━━━━━━━━━━━━━━━━━━━━━
// Left함수
//───────────────────────
String.prototype.Left = function(n){
	if (n <= 0)
		return "";
	else if (n > this.length)
		return this;
	else
		return this.substring(0,n);
};


//━━━━━━━━━━━━━━━━━━━━━━━
// Right함수
//───────────────────────
String.prototype.Right = function(n){
    if (n <= 0)
       return "";
    else if (n > this.length)
       return this;
    else {
       var iLen = this.length;
       return this.substring(iLen, iLen - n);
    }
};

//───────────────────────
// Trim - 장문용
//───────────────────────
function trim2(str){
	str = str.replace(/^\s+/, '');
	for (var i = str.length - 1; i > 0; i--) {
		if (/\S/.test(str.charAt(i))) {
			str = str.substring(0, i + 1);
			break;
		}
	}
	return str;
}

//━━━━━━━━━━━━━━━━━━━━━━━
// replaceAll
//───────────────────────
String.prototype.replaceAll = function(str1, str2)
    {
      var temp_str = "";

      if (this.trim() != "" && str1 != str2){
        temp_str = this.trim();

        while (temp_str.indexOf(str1) > -1){
          temp_str = temp_str.replace(str1, str2);
        }
      }

      return temp_str;
    };

//━━━━━━━━━━━━━━━━━━━━━━━
// 문자열길이 반환 Byte
//───────────────────────
String.prototype.byte = function() {
	var cnt = 0;
	for (var i = 0; i < this.length; i++) {
		if (this.charCodeAt(i) > 127){
			cnt += 2;
		}else{
			cnt++;
		}
	}
	return cnt;
};
//━━━━━━━━━━━━━━━━━━━━━━━
// 정수형으로 반환 (@return : String)
//───────────────────────
String.prototype.int = function() {
	if(!isNaN(this)) {
		return parseInt(this);
	}else {
		return null;    
	}
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 숫자만 가져오기 (@return : String)
//───────────────────────
String.prototype.num = function() {
	return (this.trim().replace(/[^0-9]/g, ""));
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 3자리수 콤마 (돈표시) (@return : String)
//───────────────────────
String.prototype.money = function() {
	var num = this.trim();
	while((/(-?[0-9]+)([0-9]{3})/).test(num)) {
		num = num.replace((/(-?[0-9]+)([0-9]{3})/), "$1,$2");
	}
	return num;
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 숫자의 자리수(cnt)에 맞도록 반환 (@return : String) - Ex: 01 001
//───────────────────────
String.prototype.digits = function(cnt) {
	var digit = "";
	if (this.length < cnt) {
		for(var i = 0; i < cnt - this.length; i++) {
			digit += "0";
		}
	}
	return digit + this;
};

//━━━━━━━━━━━━━━━━━━━━━━━
//파일 확장자만 가져오기 (@return : String)
//───────────────────────
String.prototype.ext = function() {
	return (this.indexOf(".") < 0) ? "" : this.substring(this.lastIndexOf(".") + 1, this.length);    
};

//━━━━━━━━━━━━━━━━━━━━━━━
//URL에서 파라메터 제거한 순수한 url 얻기(@return : String)
//───────────────────────
String.prototype.URL = function() {
	var arr = this.split("?");
	arr = arr[0].split("#");
	return arr[0];    
};


//━━━━━━━━━━━━━━━━━━━━━━━
//최소 최대 길이인지 검증(@return : boolean) str.isLength(min [,max])
//입력폼에서 사용 STR.isLength(4,20) 4자이상 20자 이내이면 true
//───────────────────────
String.prototype.isLength = function() {
	var min = arguments[0];
	var max = arguments[1] ? arguments[1] : null;
	var success = true;
	if(this.length < min) {
		success = false;
	}
	if(max && this.length > max) {
		success = false;
	}
	return success;
};
//━━━━━━━━━━━━━━━━━━━━━━━
// 최소 최대 바이트인지 검증(@return : boolean) str.isByteLength(min [,max])
//입력폼에서 사용 STR.isLength(4,20) 4바이트이상 20바이트 이내이면 true
//───────────────────────
String.prototype.isByteLength = function() {
	var min = arguments[0];
	var max = arguments[1] ? arguments[1] : null;
	alert(arguments[0]);
	alert(arguments[1]);
	var success = true;
	if(this.byte() < min) {
		success = false;
	}
	if(max && this.byte() > max) {
		success = false;
	}
	return success;

 };

//━━━━━━━━━━━━━━━━━━━━━━━
// 공백이나 널인지 확인(@return : boolean) / Trim이 있어야함
//───────────────────────
String.prototype.isBlank = function() {
	var str = this.trim();
	for(var i = 0; i < str.length; i++) {
		if ((str.charAt(i) != "\\t") && (str.charAt(i) != "\\n") && (str.charAt(i)!="\\r")) {
			return false;
		}
	}
	return true;
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 숫자로 구성되어 있는지 학인arguments[0] : 허용할 문자셋(@return : boolean)
//───────────────────────
String.prototype.isNum = function() {
	return (/^[0-9]+$/).test(this) ? true : false;
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 영어만 허용 arguments[0] : 허용할 문자셋(@return : boolean)
//───────────────────────
String.prototype.isEng = function() {
	return (/^[a-zA-Z]+$/).test(this) ? true : false;
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 숫자와 영어만 허용 arguments[0] : 허용할 문자셋(@return : boolean)
//───────────────────────
String.prototype.isEngNum = function() {
	return (/^[0-9a-zA-Z]+$/).test(this) ? true : false;
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 숫자와 영어만 허용 arguments[0] : 허용할 문자셋(@return : boolean)
//───────────────────────
String.prototype.isNumEng = function() {
	return this.isEngNum();
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 아이디 체크 영어와 숫자만 체크 첫글자는 영어로 시작 arguments[0] : 허용할 문자셋(@return : boolean)
//───────────────────────
String.prototype.isUserid = function() {
    return (/^[a-zA-z]{1}[0-9a-zA-Z]+$/).test(this) ? true : false;
 };

//━━━━━━━━━━━━━━━━━━━━━━━
// 한글 체크 arguments[0] : 허용할 문자셋(@return : boolean)
//───────────────────────
String.prototype.isKor = function() {
	return (/^[가-힣]+$/).test(this) ? true : false;
};

//━━━━━━━━━━━━━━━━━━━━━━━
//  주민번호 체크 - arguments[0] : 주민번호 구분자 (@return : boolean)
//───────────────────────
String.prototype.isJumin = function() {
	var arg = arguments[0] ? arguments[0] : "";
	var jumin = eval("this.match(/[0-9]{2}[01]{1}[0-9]{1}[0123]{1}[0-9]{1}" + arg + "[1234]{1}[0-9]{6}$/)");

	if(jumin == null) {
		return false;
	}else {
		jumin = jumin.toString().num().toString();
	}

	 // 생년월일 체크
	var birthYY = (parseInt(jumin.charAt(6)) == (1 ||2)) ? "19" : "20";
	birthYY += jumin.substr(0, 2);
	var birthMM = jumin.substr(2, 2) - 1;
	var birthDD = jumin.substr(4, 2);
	var birthDay = new Date(birthYY, birthMM, birthDD);

	if(birthDay.getYear() % 100 != jumin.substr(0,2) || birthDay.getMonth() != birthMM || birthDay.getDate() != birthDD) {
		return false;
	}        

	var sum = 0;
	var num = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5];
	var last = parseInt(jumin.charAt(12));
	for(var i = 0; i < 12; i++) {
		sum += parseInt(jumin.charAt(i)) * num[i];
	}

	return ((11 - sum % 11) % 10 == last) ? true : false;

};

//━━━━━━━━━━━━━━━━━━━━━━━
//사업자번호 체크 - arguments[0] : 등록번호 구분자 (@return : boolean)
//───────────────────────
String.prototype.isBiznum = function() {
	var arg = arguments[0] ? arguments[0] : "";
	var biznum = eval("this.match(/[0-9]{3}" + arg + "[0-9]{2}" + arg + "[0-9]{5}$/)");

	if(biznum == null) {
		return false;
	}else {
		biznum = biznum.toString().num().toString();
	}

	var sum = parseInt(biznum.charAt(0));
	var num = [0, 3, 7, 1, 3, 7, 1, 3];

	for(var i = 1; i < 8; i++) sum += (parseInt(biznum.charAt(i)) * num[i]) % 10;
	sum += Math.floor(parseInt(parseInt(biznum.charAt(8))) * 5 / 10);
	sum += (parseInt(biznum.charAt(8)) * 5) % 10 + parseInt(biznum.charAt(9));

	return (sum % 10 == 0) ? true : false;
};

//━━━━━━━━━━━━━━━━━━━━━━━
//법인 등록번호 체크 - arguments[0] : 등록번호 구분자 (@return : boolean)
//───────────────────────
String.prototype.isCorpnum = function() {
	var arg = arguments[0] ? arguments[0] : "";
	var corpnum = eval("this.match(/[0-9]{6}" + arg + "[0-9]{7}$/)");
	if(corpnum == null) {
		return false;
	}else {
		corpnum = corpnum.toString().num().toString();
	}

	var sum = 0;
	var num = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
	var last = parseInt(corpnum.charAt(12));

	for(var i = 0; i < 12; i++) {
		sum += parseInt(corpnum.charAt(i)) * num[i];
	}
	return ((10 - sum % 10) % 10 == last) ? true : false;
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 이메일의 유효성을 체크 (@return : boolean)
//───────────────────────
String.prototype.isEmail = function() {
	return (/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i).test(this.trim());
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 전화번호 체크 arguments[0] : 전화번호 구분자 (@return : boolean)
//───────────────────────
String.prototype.isPhone = function() {
	var arg = arguments[0] ? arguments[0] : "";
	return eval("(/(02|0[3-9]{1}[0-9]{1})" + arg + "[1-9]{1}[0-9]{2,3}" + arg + "[0-9]{4}$/).test(this)");
};

//━━━━━━━━━━━━━━━━━━━━━━━
// 핸드폰번호 체크 - arguments[0] : 핸드폰 구분자 (@return : boolean)
//───────────────────────
String.prototype.isMobile = function() {
	var arg = arguments[0] ? arguments[0] : "";
	return eval("(/01[016789]" + arg + "[1-9]{1}[0-9]{2,3}" + arg + "[0-9]{4}$/).test(this)");
};

String.prototype.isNum2=function(){
   var str=this;
   if(str.length <= 0)
     return false;

   for(i=0; i<str.length; i++)
   {
     var cv = str.charCodeAt(i);
     if(!( 0x30 <=cv && cv<= 0x39 || cv == 0x2D || cv == 0x2E ))
     {
         return false;

     }
   }   
   return true;

};

function OptionSelect(selObj,selVal) {
	if (selObj) {
		for(var i=0;i<selObj.options.length;i++) {
			if (selObj.options[i].value==selVal) {
				selObj.options[i].selected=true;
				return;
			}
		}
	}
}

function RdoSelect(selObj,selVal) {
	if (selObj) {
	if (selObj.length) {
		for(var i=0;i<selObj.length;i++) {
			if (selObj[i].value==selVal) {
				selObj[i].checked=true;
				return;
			}
		}
	}}
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
   window.open(theURL,winName,features);
 } 


//━━━━━━━━━━━━━━━━━━━━━━━
//숫자만 입력 받게끔 하는 함수.
//usage : <input type='text' onkeydown='handlerNum(this)'>
//━━━━━━━━━━━━━━━━━━━━━━━
function handlerNum( obj ) {

e = window.event; //윈도우의 event를 잡는것입니다.

//입력 허용 키
if( ( e.keyCode >= 48 && e.keyCode <= 57 ) || //숫자열 0 ~ 9 : 48 ~ 57
( e.keyCode >= 96 && e.keyCode <= 105 ) || //키패드 0 ~ 9 : 96 ~ 105
e.keyCode == 8 || //BackSpace
e.keyCode == 46 || //Delete
e.keyCode == 110 || //소수점(.) : 문자키배열
e.keyCode == 190 || //소수점(.) : 키패드
e.keyCode == 37 || //좌 화살표
e.keyCode == 39 || //우 화살표
e.keyCode == 35 || //End 키
e.keyCode == 36 || //Home 키
e.keyCode == 9 //Tab 키
) {

if(e.keyCode == 48 || e.keyCode == 96) { //0을 눌렀을경우
if ( obj.value == "" || obj.value == '0' ) //아무것도 없거나 현재 값이 0일 경우에서 0을 눌렀을경우
e.returnValue=false; //-->입력되지않는다.
else //다른숫자뒤에오는 0은
return; //-->입력시킨다.
}

else if ( e.keyCode == 110 || e.keyCode == 190 ) { //소수점을 눌렀을 경우
if ( obj.value == "" ) { //아무것도 없는 상태에서 소수점을 입력했을경우 "0."으로 표기
obj.value = "0";
return;
}

if ( obj.value.indexOf(".") != -1 ) { //기존에 소수점이 들어있다면
e.returnValue=false; //입력시키지 않는다.
}
}
else //0이 아닌숫자
return; //-->입력시킨다.
}
else //숫자가 아니면 넣을수 없다.
e.returnValue=false;
}

//━━━━━━━━━━━━━━━━━━━━━━━
// 세자리 콤마 찍기 
//━━━━━━━━━━━━━━━━━━━━━━━
function commaNum(n){
	return Number(n).toLocaleString().slice(0,-3);
}
//━━━━━━━━━━━━━━━━━━━━━━━



/* 오픈 팝업 스크립트 */
function goPopup(url, name, _width, _height, _scrollbar){
	var screenX;
	var screenY;

	if(navigator.appName == "Microsoft Internet Explorer") {
		screenX = window.screen.availWidth;
		screenY = window.screen.availHeight;
	}
	else {
		screenX = window.outerWidth;
		screenY = window.outerHeight;
	}

	var h, w;
	w = (screenX - _width)/2;
	h = (screenY - _height)/2;

	var newWin = window.open(url, name, 'left=' + w + ' top=' + h + ' width=' +_width + ' height=' + _height + ' scrollbars=' + _scrollbar + 'resize=no,toolbar=no,status=no,menu=no');

	newWin.focus();

	return newWin;
}

//레이어팝업
function hideLayer(target){
  document.getElementById(target).style.visibility = "hidden";
}

 function showLayer(target) {
  document.getElementById(target).style.visibility = "visible";
}


// 토글 레이어
function toggle(e){
	if(document.getElementById(e).style.display == "none"){
		document.getElementById(e).style.display = "block";
	} else {
	document.getElementById(e).style.display = "none";
	}

}

//━━━━━━━━━━━━━━━━━━━━━━━
// 체크박스 전체 선택 (jquery include)
//───────────────────────
function checkAll()
{
   var checkboxCnt = $("input[name=chk]:checkbox").length; // 체크박스 전체 갯수
   var checkYn = $('#chkAll').attr('checked');
   if(checkYn){
	   $('input[name=chk]:checkbox').attr('checked',true);
	   $('#chkAll').attr('checked',true);
   }else{
	   $('input[name=chk]:checkbox').attr('checked',false);
	   $('#chkAll').attr('checked',false);
   } 

}

//━━━━━━━━━━━━━━━━━━━━━━━
// 체크박스 개별 선택 (jquery include)
//───────────────────────
function onCheckBoxClick()
{
   var checkboxCnt = $("input[name=chk]:checkbox").length; // 체크박스 전체 갯수
   var cnt = $("input[name=chk]:checkbox:checked").length; // 첵크된 갯수
   if(checkboxCnt == cnt){
	   $('#chkAll').attr('checked',true);
   }else{
	   $('#chkAll').attr('checked',false);
   } 
}

//━━━━━━━━━━━━━━━━━━━━━━━
//체크박스 전체 선택 (jquery include)
//───────────────────────
function AllCheckbox(name, bln) { 
    var obj = document.getElementsByName(name); 
    if(obj == null) return;

    var max = obj.length;
    if(max == null) {
        obj.checked = bln;
    }else {
        for(var i = 0; i < max; i++) { 
            obj[i].checked = bln;
        }
    }
} 

function ResizeIframe(n) {
	var h;
	if(el = parent.document.getElementById(n)) {
		el.height = 0;
		if(isIE) h = document.body.scrollHeight;
		else h = document.documentElement.scrollHeight;
		if(h > 10) el.height = h;
		else el.height = 0;
	}
}

/**
* 파일명: lib.validate.js
* 설  명: 폼 체크, 값 표준화
* 작성자: jstoy project
* 날  짜: 2003-10-28
*   lainTT (2003-11-20) : FormChecker Class의 함수 prototype화 & 전역변수를 클래스 안으로...-_-;
***********************************************
*/

/**
* <pre>
* 폼 체크 trigger 함수
* </pre>
*
* @param Form Object
* @return boolean
*/
function validate(form) {
    var result;
    var checker = new FormChecker(form);

    result = checker.go();
    checker.destroy();
    return result;
}

function validate_init() {
    for (var i=0; i<document.forms.length; i++) {
        var formObj = document.forms[i];
        if (document.forms[i].getAttribute('VALIDATE') != null) {
            // pre_validate를 사용하지 않는다면 이 아랫줄을 주석처리합니다.
            new FormLoader(formObj);
            formObj.submitAction = formObj.onsubmit;
            formObj.onsubmit = function() {
                formObj.submitAction;
                return validate(this);
            };
        }
    }
}

FormChecker = function(form) {
    /**
    * <pre>
    * 미리 정의된 에러 메시지들
    * </pre>
    */
    this.FORM_ERROR_MSG = {
       //common   : "입력하신 내용이 규칙에 어긋납니다.\n규칙에 어긋나는 내용을 바로잡아주세요.",
	   common	: "",
       required : "반드시 입력하셔야 합니다.",
       notequal : "서로 일치하지 않습니다.",
       invalid  : "입력 형식에 어긋납니다.",
	   denied  : "업로드가 제한된 파일입니다.",
       minbyte  : "길이가 {minbyte}Byte 이상이어야 합니다.",
       maxbyte  : "길이가 {maxbyte}Byte를 초과할 수 없습니다."
    };

    /**
    * <pre>
    * 폼 체크 함수 매핑
    * </pre>
    */
    this.VALIDATE_FUNCTION = {
       email   : this.func_isValidEmail,
       phone   : this.func_isValidPhone,
       userid  : this.func_isValidUserid,
       hangul  : this.func_hasHangul,
       number  : this.func_isNumeric,
       engonly : this.func_alphaOnly,
       bizno   : this.func_isValidBizNo
    };

    /**
    * <pre>
    * 에러 출력 플래그
    * </pre>
    */
    this.ERROR_MODE_FLAG = {
       all         : 1,         // 전체 에러를 표시
       one         : 2,         // 처음에 걸린 에러 하나만 표시
       one_per_obj : 3          // 한 object당 처음의 에러 표시
    };

    this.form      = form;
    this.isErr     = false;
    this.errMsg    = (this.FORM_ERROR_MSG["common"] != "") ? this.FORM_ERROR_MSG["common"] + "\n\n" : "";
    this.errObj    = "";
    this.curObj    = "";
    this.errMode   = this.ERROR_MODE_FLAG["one"];  // 에러메시지 출력모드
};

FormChecker.prototype.go = function() {
    for (var i = 0; i < this.form.elements.length; i++) {
        var el = this.form.elements[i];
        if (el.tagName.toLowerCase() == "fieldset" || el.tagName.toLowerCase() == "object")
            continue;

        if (el.getAttribute("HNAME") == null || el.getAttribute("HNAME") == "")
            el.setAttribute("HNAME", el.getAttribute("NAME"));

		var trim    = el.getAttribute("TRIM");
        var minbyte = el.getAttribute("MINBYTE");
        var maxbyte = el.getAttribute("MAXBYTE");
        var option  = el.getAttribute("OPTION");
        var match   = el.getAttribute("MATCH");
        var delim    = el.getAttribute("DELIM");
        var glue    = el.getAttribute("GLUE");
        var pattern = el.getAttribute("PATTERN");
		var allow = el.getAttribute("ALLOW");
		var deny = el.getAttribute("DENY");

        if (el.type == "text") {
            switch (trim) {
                case "ltrim": el.value = el.value.ltrim(); break;
                case "rtrim": el.value = el.value.rtrim(); break;
                case "notrim": break;
                default:      el.value = el.value.trim();  break;
            }
        }
        if (el.getAttribute("REQUIRED") != null) {
            switch (el.type) {
                case "file": case "textarea": case "password": case "hidden":
                case "text": 
                	try { 
                		submitSmartEditor(); 
                		//el.value = this.trim(this.strip_tags(el.value).replace(/&nbsp;/g, ""));
					} catch(e) {}
                    if (el.value == null || el.value == "") this.addError(el,"required");
                    break;
                case "select-one":
                    if (el[el.selectedIndex].value == null || el[el.selectedIndex].value == "") this.addError(el,"required");
                    break;
                case "radio":
                    var elCheck = this.form.elements[el.name];
                    for (var j = 0, isChecked = false; j < elCheck.length; j++) {
                        if (elCheck[j].checked == true) isChecked = true;
                    }
                    if (isChecked == false) this.addError(el,"required");
                    break;
                case "checkbox":
                    if (el.checked == false) this.addError(el,"required");
                    break;
            }
        }
        if (el.type == "text" || el.type == "password") {
            if (minbyte != null) {
                if (el.value.bytes() < parseInt(minbyte)) this.addError(el,"minbyte");
            }
            if (maxbyte != null) {
                if (el.value.bytes() > parseInt(maxbyte)) this.addError(el,"maxbyte");
            }
            if (match && (el.value != this.form.elements[match].value)) {
                this.addError(el,"notequal");
            }
            if (el.value && option != null) {
                if (glue != null) {
                    var _value = new Array(el.value);
					var glue_arr = glue.split(",");
                    for (var j = 0; j < glue_arr.length; j++) {
                        _value[j+1] = this.form.elements[glue_arr[j]].value;

                    }
                    var value = _value.join(delim == null ? "" : delim);
                    var tmp_msg = this.VALIDATE_FUNCTION[option](el, value);
                    if (tmp_msg != true) this.addError(el,tmp_msg);
                } else {
                    var tmp_msg = this.VALIDATE_FUNCTION[option](el);
                    if (tmp_msg != true) this.addError(el,tmp_msg);
                }
            }
            if (pattern != null) {
                pattern = new RegExp(pattern);
                if (!pattern.test(el.value)) this.addError(el,'invalid');
            }
        }
        if (el.type == "file") {
            if (el.value && allow != null && allow != "") {
                pattern = new RegExp("(" + allow.replace(",", "|").toLowerCase() + ")$");
                if (!pattern.test(el.value.toLowerCase())) this.addError(el,'denied');
			}
            if (el.value && deny != null && deny != "") {
                pattern = new RegExp("(" + deny.replace(",", "|").toLowerCase() + ")$");
                if (pattern.test(el.value.toLowerCase())) this.addError(el,'denied');
			}
		}
    }
    return !this.isErr;
};

FormChecker.prototype.destroy = function() {
    if (this.isErr == true) {
        alert(this.errMsg);
        if (this.errObj.getAttribute("delete") != null)
            this.errObj.value = "";
        if (this.errObj.getAttribute("select") != null)
            this.errObj.select();
        if (this.errObj.getAttribute("nofocus") == null && this.errObj.type != "hidden")
            this.errObj.focus();
    }
    this.errMsg = "";
    this.errObj = "";
};

FormChecker.prototype.addError = function(el, type) {
    var pattern = /\{([a-zA-Z0-9_]+)\}/i;
    var msg = (this.FORM_ERROR_MSG[type]) ? this.FORM_ERROR_MSG[type] : type;
	if (el.getAttribute("errmsg") != null) msg = el.getAttribute("errmsg");
    
    if (pattern.test(msg) == true) {
        while (pattern.exec(msg)) msg = msg.replace(pattern, el.getAttribute(RegExp.$1));
    }

    if (!this.errObj || this.errMode != this.ERROR_MODE_FLAG["one"]) {
        if (this.curObj == el.name && el.getAttribute("errmsg") == null) {
            if (this.errMode == this.ERROR_MODE_FLAG["all"]) {
                this.errMsg += "   - "+ msg +"\n";
			}
        } else if (this.curObj != el.name) {
            if (this.curObj) {
                    this.errMsg += "\n";
			}
			if (el.getAttribute("errmsg") != null) {
				this.errMsg += el.getAttribute("errmsg");
			} else {
				this.errMsg += "["+ el.getAttribute("hname") +"] 항목은 "+ msg +"\n";
			}
			//el.style.backgroundColor = "yellow";
        }
    }

	if (!this.errObj) this.errObj = el;
    this.curObj = el.name;
    this.isErr = true;
    return;
};

/// 패턴 검사 함수들 ///
FormChecker.prototype.func_isValidEmail = function(el,value) {
   var value = value ? value : el.value;
   var pattern = /^[_a-zA-Z0-9-\.]+@[\.a-zA-Z0-9-]+\.[a-zA-Z]+$/;
   return (pattern.test(value)) ? true : "invalid";
};

/*
FormChecker.prototype.func_isValidUserid = function(el) {
   var pattern = /^[a-zA-Z]{1}[a-zA-Z0-9_]{3,14}$/;
   return (pattern.test(el.value)) ? true : "4자이상 15자 미만,\n 영문,숫자, _ 문자만 사용할 수 있습니다";
}
*/

FormChecker.prototype.func_isValidUserid = function(el) {
   var pattern = /^[a-zA-Z0-9_]{4,14}$/;
   return (pattern.test(el.value)) ? true : "4자이상 15자 미만,\n 영문,숫자, _ 문자만 사용할 수 있습니다";
};

FormChecker.prototype.func_hasHangul = function(el) {
   var pattern = /[가-힝]/;
   return (pattern.test(el.value)) ? true : "반드시 한글을 포함해야 합니다";
};

FormChecker.prototype.func_alphaOnly = function(el) {
   var pattern = /^[a-zA-Z]+$/;
   return (pattern.test(el.value)) ? true : "invalid";
};

FormChecker.prototype.func_isNumeric = function(el) {
   var pattern = /^-?[0-9]+$/;
   return (pattern.test(el.value)) ? true : "반드시 숫자로만 입력해야 합니다";
};

FormChecker.prototype.func_isValidBizNo = function(el,value) {
    var pattern = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/;
    var num = value ? value : el.value;
    if (!pattern.test(num)) return "invalid";
    num = RegExp.$1 + RegExp.$2 + RegExp.$3;
    var cVal = 0;
    for (var i=0; i<8; i++) {
        var cKeyNum = parseInt(((_tmp = i % 3) == 0) ? 1 : ( _tmp  == 1 ) ? 3 : 7);
        cVal += (parseFloat(num.substring(i,i+1)) * cKeyNum) % 10;
    }
    var li_temp = parseFloat(num.substring(i,i+1)) * 5 + "0";
    cVal += parseFloat(li_temp.substring(0,1)) + parseFloat(li_temp.substring(1,2));
    return (parseInt(num.substring(9,10)) == 10-(cVal % 10)%10) ? true : "invalid";
};

FormChecker.prototype.func_isValidPhone = function(el,value) {
    var pattern = /^([0]{1}[0-9]{1,2})-([1-9]{1}[0-9]{2,3})-([0-9]{4})$/;
    var num = value ? value : el.value;
    if (pattern.exec(num)) {
        if(RegExp.$1 == "011" || RegExp.$1 == "016" || RegExp.$1 == "017" || RegExp.$1 == "018" || RegExp.$1 == "019") {
            if(!el.getAttribute("span"))
                el.value = RegExp.$1 + "-" + RegExp.$2 + "-" + RegExp.$3;
        }
        return true;
    } else {
        return "invalid";
    }
};

FormChecker.prototype.strip_tags = function(str, allowed_tags) {
	var key='',allowed=false;
	var matches=[];
	var allowed_array=[];
	var allowed_tag='';
	var i=0;
	var k='';
	var html='';
	var replacer = function(search,replace,str){
		return str.split(search).join(replace);
	};
	if(allowed_tags){
		allowed_array=allowed_tags.match(/([a-zA-Z0-9]+)/gi);
	}
	str+='';
	matches=str.match(/(<\/?[\S][^>]*>)/gi);
	for(key in matches){
		if(isNaN(key)){continue;}
		html=matches[key].toString();
		allowed=false;
		for(k in allowed_array){
			allowed_tag=allowed_array[k];
			i=-1;
			if(i!=0){ i=html.toLowerCase().indexOf('<'+allowed_tag+'>'); }
			if(i!=0){i=html.toLowerCase().indexOf('<'+allowed_tag+' ');}
			if(i!=0){i=html.toLowerCase().indexOf('</'+allowed_tag);}
			if(i==0){allowed=true;break;}}
			if(!allowed){str=replacer(html,"",str);
		}
	}
	return str;
};

FormChecker.prototype.trim = function(str,charlist){var whitespace,l=0,i=0;str+='';if(!charlist){whitespace=" \n\r\t\f\x0b\xa0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000";}else{charlist+='';whitespace=charlist.replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g,'$1');}
l=str.length;for(i=0;i<l;i++){if(whitespace.indexOf(str.charAt(i))===-1){str=str.substring(i);break;}}
l=str.length;for(i=l-1;i>=0;i--){if(whitespace.indexOf(str.charAt(i))===-1){str=str.substring(0,i+1);break;}}
return whitespace.indexOf(str.charAt(0))===-1?str:'';};

String.prototype.trim = function(str) {
    str = this != window ? this : str;
    return str.ltrim().rtrim();
};

String.prototype.ltrim = function(str) {
    str = this != window ? this : str;
    return str.replace(/^\s+/g,"");
};

String.prototype.rtrim = function(str) {
    str = this != window ? this : str;
    return str.replace(/\s+$/g,"");
};

String.prototype.bytes = function(str) {
    var len = 0;
    str = this != window ? this : str;
    for (j=0; j<str.length; j++) {
        var chr = str.charAt(j);
        len += (chr.charCodeAt() > 128) ? 2 : 1;
    }
    return len;
};

String.prototype.bytesCut = function(bytes) {
    var str = this;
    var len = 0;
    for (j=0; j<str.length; j++) {
        var chr = str.charAt(j);
        len += (chr.charCodeAt() > 128) ? 2 : 1;
        if (len > bytes) {
            str = str.substring(0, j);
            break;
        }
    }
    return str;
};

function autoNext(el, limit, next_el) {
	if(el.value.bytes() == 6) next_el.focus();
}

function confirmGo(obj, url) {
	if(typeof obj == "object"){ 
		msg = obj.value;
	}else{
		msg = obj;
	}
	if(confirm(msg + " 하시겠습니까?")) {
		location.href = url;
	}
}

function openDialog(nLink, nWin, nWidth, nHeight, xPos, yPos) {
	if(typeof nLink == "object") url = nLink.href;
	else url = nLink;
	qResult = window.showModalDialog( url, nWin,
          				"dialogwidth:"+nWidth+"px;dialogheight:"+nHeight+"px;toolbar:no;location:no;help:no;directories:no;status:no;menubar:no;scroll:no;resizable:no");
}

function openWindow(nLink, nTarget, nWidth, nHeight, scroll, xPos, yPos, resize) {
	var url = "";
	if(typeof nLink == "object") {
		url = nLink.href;
	}else {
		url = nLink;
	}

	scroll = scroll == "Y" ? "yes" : "no";
	resize = resize == "Y" ?  "yes" : "no";

	adjX = xPos ? xPos : (window.screen.width/2 - nWidth/2);
	adjY = yPos ? yPos : (window.screen.height/2 - nHeight/2 - 50);
	qResult = window.open( url, nTarget, "width="+nWidth+", height="+nHeight+",left="+adjX+",top="+adjY+",toolbar=no,status=yes,scrollbars=" + scroll + ",resizable=" + resize);
	qResult.focus();
}

function openWindows(nLink, nTarget, nWidth, nHeight, xPos, yPos, resize) {
	openWindow(nLink, nTarget, nWidth, nHeight, "Y", xPos, yPos, resize);
}

function __setElement(el, v, a) {
	if (v){
		v = v.replace(/__&LT__/g, '<').replace(/__&GT__/g, '>');
	}
	if (typeof (el) != 'object'){
		return;
	}
	if (v != null){
		switch (el.type) {
		case 'text':
		case 'hidden':
		case 'password':
		case 'file':
			el.value = v;
			break;
		case 'textarea':
			el.value = v;
			break;
		case 'checkbox':
		case 'radio':
			if (el.value == v){
				el.checked = true;
			}else{
				el.checked = false;
			}
			break;
		case 'select-one':
			for ( var i = 0; i < el.options.length; i++){
				if (el.options[i].value == v){
					el.options[i].selected = true;
				}
			}
			break;
		default:
			for ( var i = 0; i < el.length; i++){
				if (el[i].value == v){
					el[i].checked = true;
				}
			}
			el = el[0];
			break;
		}
	}

	if (typeof (a) == 'object') {
		if (el.type != 'select-one' && el.length > 1){
			el = el[0];
		}
		for (i in a){
			el.setAttribute(i, a[i]);
		}
	}
}

var AUTO_CHECK_STATUS = true;

function autoCheck(formName, attributeName) {
	var f = document.forms[formName];
	if(!f || !f[attributeName]) return;
	if(typeof(f[attributeName]) == "object") {
		if(f[attributeName].length > 0) {
			for(var i=0; i<f[attributeName].length; i++) {
				f[attributeName][i].checked = AUTO_CHECK_STATUS;
			}
		} else {
			f[attributeName].checked = AUTO_CHECK_STATUS;
		}
		if(AUTO_CHECK_STATUS == true) {
			AUTO_CHECK_STATUS = false;
		} else {
			AUTO_CHECK_STATUS = true;
		}
	}
}