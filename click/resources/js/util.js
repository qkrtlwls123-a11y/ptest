
function isdefined(str) {
        var isResult = false;
        var str_temp = String(str);
        str_temp = str_temp.replace(' ', '');
        if(str_temp != 'undefined' && str_temp != '' && str_temp != 'null') {
                isResult = true;
        }

        return isResult;
}


function checkOnlyEnglishAndNumeric(event, obj) {
	
	var e = e || window.event ,keyCode 	= (e.which) ? e.which : e.keyCode;
	if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 39) {
		return;
	} else {
		e.target.value = e.target.value.replace(/[^a-z0-9]/gi,'');
	};

}

//숫자가 아닌경우 자동 삭제    		
function checkOnlyNumeric(e){
	var e = e || window.event ,keyCode 	= (e.which) ? e.which : e.keyCode;

	if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 39) {
		return;
	} else {
		e.target.value = e.target.value.replace(/[^0-9]/g, '');
	};
}


/* 입력 */
function fn_onlyNumber(){
	if((event.keyCode>=48)&&(event.keyCode<=57)){
		return;
	}else if((event.keyCode==45)){
		return;
	}else{
        event.returnValue=false;
	}
}

// 넘어온 값이 빈값인지 체크합니다.
// !value 하면 생기는 논리적 오류를 제거하기 위해
// 명시적으로 value == 사용
// [], {} 도 빈값으로 처리
var isEmpty = function(value) {
        if (value === null) return true
        if (typeof value === 'undefined') return true
        if (value === 'undefined') return true
        if (typeof value === 'string' && value === '') return true
        if (typeof value === 'string' && value === 'null') return true
        if (Array.isArray(value) && value.length < 1) return true
        if (typeof value === 'object' && value.constructor.name === 'Object' && Object.keys(value).length < 1 && Object.getOwnPropertyNames(value) < 1) return true
        if (typeof value === 'object' && value.constructor.name === 'String' && Object.keys(value).length < 1) return true // new String() return false
        if (typeof value === 'object' && value.constructor.name === 'HTMLDivElement' && Object.keys(value).length < 1 && Object.getOwnPropertyNames(value) < 1) return true

        return false;
};

//Javascript에서 js파일 Import 하기.
function includeJs(jsFilePath) {
	var js = document.createElement("script");
	
	js.type = "text/javascript";
	js.src = jsFilePath;
	document.body.appendChild(js);
}

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";

    var weekFullName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var weekName = ["일", "월", "화", "수", "목", "금", "토"];
    var d = this;

    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|SS|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "SS": return d.getMilliseconds().zf(3);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};


function fn_checkSpecialChar(pw, count) {
	var allFoundCharacters = pw.match(/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/g);
	if(!isEmpty(allFoundCharacters) && allFoundCharacters.length >= count)
		return true;
	
	return false;
}

function fn_checkDigitCount(obj, maxCount, comment, onlyDigit) {
	
	if(onlyDigit) {
		obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
		obj.value = obj.value.replace(/[.~!@\#$%<>^&*]/g, '');
	}
	
	if(obj.value.length > maxCount){
		if(comment != null)
			openDefaultPopup("loginPopup",comment);
		obj.value = obj.value.substring(0,maxCount);
		return false;
	}
}

function fn_checkIdReturn(obj){
	checkId = false;
	obj.value = obj.value.replace(/ /g, '');
	obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
	obj.value = obj.value.replace(/[a-zA-Z]/g, '');
	obj.value = obj.value.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g,'');
}

function fn_checkIdReturn2(obj){
	checkId = false;
	obj.value = obj.value.replace(/ /g, '');
	obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
	obj.value = obj.value.replace(/[a-zA-Z]/g, '');
	obj.value = obj.value.replace(/[\{\}\[\]\/?,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g,'');
}


function cloneObject(obj) {
	return JSON.parse(JSON.stringify(obj));
}

