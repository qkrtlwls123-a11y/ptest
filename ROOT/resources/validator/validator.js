// 문자열 공백제거
// 오른쪽 공백제거
function rightTrim(str) {
	str = str + "";
	var len = str.length;

	for(var i = (len - 1); (str.charAt(i) == ' ');i--);
	str = str.substring(0, i + 1);

	return str;
}
// 왼쪽 공백제거
function leftTrim(str) {
	var len = str.length;
	var i = 0;

	for(i = 0; str.charAt(i) == ' '; i++);
	str = str.substring(i, len);

	return str;
}
// 양쪽 공백제거
function trimStr(str) {
	return leftTrim(rightTrim(str)); 
}
// 문자열 공백제거

// 조사 검사
String.prototype.hasFinalConsonant = function(str) { 
    str = this != window ? this : str; 
    var strTemp = str.substr(str.length-1); 
    return ((strTemp.charCodeAt(0)-16)%28!=0); 
} 

function josa(str,tail) { 
    return (str.hasFinalConsonant()) ? str+tail.substring(0,1) : str+tail.substring(1,2); 
} 
// 조사 검사

// text, textarea 입력값 체크
function isTextValidate(obj,kind,len,name)
{
	var str  = "";
	str = trimStr(obj.value);
	if (str == "" || str == " ")
	{
		alert(josa(name,"을를") + " 입력하세요.");
		obj.focus();
		return false;
	}

	if (kind == "number")
	{
        if (isNaN(str) || /^\s+$/.test(str))
        {
			alert(josa(name,"은는") + " 숫자만 입력하세요.");
			obj.focus();
			return false;
        }
	}
	else if (kind == "alpha")
	{
		if (!/^[a-z A-Z]+$/.test(str))
		{
			alert(josa(name,"은는") + " 알파벳만 입력하세요.");
			obj.focus();
			return false;
        }
	}
	else if (kind == "alphanum")
	{
		if (/\W/.test(str))
		{
			alert(josa(name,"은는") + " 알파벳과 숫자만 입력하세요.");
			obj.focus();
			return false;
        }
	}
	else if (kind == "radio")
	{
		var len = obj.length;
		var flag = false;
		for(var i=0; i<len; i++)
		{
			if (obj[i].checked == true)
			{
				flag = true;
			}
		}

		if (!flag)
		{
			alert(josa(name,"을를") + " 선택하세요.");
			return false;
		}
	}
	else if (kind == "image")
	{
		var tmp = str.split(".");
		var ext = tmp[tmp.length-1];
		ext = ext.toLowerCase();
		if (ext != "gif" && ext != "jpg" && ext != "png")
		{
			alert(josa(name,"은는") + " 이미지 파일만 가능합니다.");
			return false;
		}
	}

	if (len > 0 && str.length < len)
	{
		alert(josa(name,"은는") + " "+len+"자 이상 입력하세요.");
		obj.focus();
		return false;
	}

	return true;
}

// 숫자만 입력 확인.
function onlyNumber(){
	// - 음수 표시를 위해 45 허용
    if((event.keyCode!=45 && event.keyCode<48)||(event.keyCode>57))
    event.returnValue=false;
}

// 입력된 값의 확인하여 maxlen 까지만 남긴다.
function lengthCheck(obj, maxlen)
{
    var string = obj.value;
    if ( getStringLength(string) > maxlen )
    {
        alert("입력된 값이 허용된 길이를 초과합니다.");
        obj.value = obj.value.substring(0, getStrngCount(obj.value, maxlen));
    }
}

// 문자열 길이 체크 알파뉴메릭(1자리), 한글(2자리)
function getStringLength (str)
{
    var retCode = 0;
    var strLength = 0;

    for (i=0; i<str.length; i++)
    {
        var code = str.charCodeAt(i);
        var ch = str.substr(i,1).toUpperCase();

        code = parseInt(code);

        if ( (ch < "0" || ch > "9") && ( ch < "A" || ch > "Z") && ( (code > 255) || (code < 0) ) )
            strLength = strLength + 2;
        else
            strLength = strLength + 1;
    }
    return strLength;
}

// 문자열 길이에 따른 문자 갯수
function getStrngCount(str, maxlen)
{
    var retCode = 0;
    var strLength = 0;
    var count = 0;

    for (i=0; i<str.length; i++)
    {
        var code = str.charCodeAt(i);
        var ch = str.substr(i,1).toUpperCase();

        code = parseInt(code);

        if ( (ch < "0" || ch > "9") && ( ch < "A" || ch > "Z") && ( (code > 255) || (code < 0) ) )
            strLength = strLength + 2;
        else
            strLength = strLength + 1;

        if ( strLength > maxlen ) break;
        
        count++;
    }
    return count;
}