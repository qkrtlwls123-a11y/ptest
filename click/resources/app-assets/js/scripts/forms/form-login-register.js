$(document).ready(function(){
	'use strict';
	//Login Register Validation
	

	// Remember checkbox
	if($('.chk-remember').length){
		$('.chk-remember').iCheck({
			checkboxClass: 'icheckbox_square-blue',
			radioClass: 'iradio_square-blue',
		});
	}
	// For change default year in copyright
	var $year = new Date().getFullYear();
	$(".year").text($year);
	
});


function fn_checkRequired(){
	var checkValue = true;
	
	$(".required").each(function(e){
		if($(this).val() == ""){
			alert($(this).attr("placeholder")+"은(는) 필수입력 항목 입니다.");
			checkValue = false;
			return false;
		}
	});
	
	return checkValue;
}

function fn_checkEmail(){
	var checkValue = true;
	var patternEmail = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
	
	$(".email").each(function(e){
		var targetValue = $(this).val(); 
		if(!patternEmail.test(targetValue)){
			alert("이메일 형식이 맞지 않습니다.");
			checkValue = false;
			return false;
		}
	});
	
	return checkValue;
	
}

function fn_checkPassword(){
	var checkValue = true;
	var patternPassword = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;

	$(".password").each(function(e){
		var targetValue = $(this).val(); 
		if(!patternPassword.test(targetValue)){
			alert("비밀번호는 8자리 이상의 숫자, 문자 조합입니다.");
			checkValue = false;
			return false;
		}
	});

	return checkValue;
}