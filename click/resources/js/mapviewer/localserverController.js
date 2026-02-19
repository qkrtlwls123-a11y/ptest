var r_url_localserver = 'http://127.0.0.1:9000/';
var r_browser_guid = 0;
var r_count_error = 0;
var r_timerid_connect;
var r_timerid_check_connect_state;
var r_localserver_version = -1;
var r_bool_check_version = false;
var r_sessionkey;
var r_file_url;
var r_bool_dummy_versioncheck = false;
var r_reg_data = '-1';

$(function() {
	// refresh
	window.onbeforeunload = CleanPage_localserver;

	// refresh
	window.unload = CleanPage_localserver;
});

function CleanPage_localserver() {
	//sessionStorage.setItem('local_version_check', '');
}

function start_version_localserver(callBack) {

	console.log('start_version_localserver');
	// 맵뷰어 연결 카운트
	localStorage.setItem('count_connect_mapviewer', '');

	// browser id
	func_generate_id();

	// 버전 체크
	func_localserver_version(callBack);
	//func_localserver_version(callBack);

}

function start_localserver() {

	// browser id
	func_generate_id();

	// 이중 접속 테스트 
	func_post_msg_sync_btos('msg_send_double_check_btos', '00001', null);

	// 연결 상태 체크
	func_check_connect_state();
}

//----------------------------------------------
// 로그인 페이지 다시 이동시 초기화
//----------------------------------------------
function clear_storage_localserver() {
	sessionStorage.setItem('browser_guid', '');
	sessionStorage.setItem('local_version_check', '');

	// browser_guid  초기화 처리
	func_post_msg_sync_btos('msg_send_browser_close_btos', '00001', null);
}

//----------------------------------------------
// 로컬 서버 버전 체크
//----------------------------------------------
function func_localserver_version(callBack) {

	// var key = sessionStorage.getItem('local_version_check');
	// if(isdefined(key)) {

	// }
	// else {

	r_sessionkey = sessionStorage.getItem('sessionKey');


	r_bool_check_version = true;

	// 로컬 서버 연결 시도
	func_post_msg_sync_btos('msg_send_version', '00', callBack);

	sessionStorage.setItem('local_version_check', 'true');
	// }

}

//----------------------------------------------
// 2018_0316_kim
// 맵 서버에 프로젝트 리스트 요청
//----------------------------------------------
function func_request_map_project_list(project_id) {
	func_post_msg_sync_btos('msg_send_map_project_list_btos', project_id, null);
}
//----------------------------------------------
// 브라우저 id 생성
//----------------------------------------------
function func_generate_id() {

	var key = sessionStorage.getItem('browser_guid');
	if(isdefined(key)) {
		r_browser_guid = key;
	}
	else {
		r_browser_guid = new Date().getTime();
		sessionStorage.setItem('browser_guid', r_browser_guid);
	}
}

//----------------------------------------------
// 로컬 서버와 연결 시작 
//----------------------------------------------
function func_start_Connect() {

	func_post_msg_sync_btos('msg_send_mapviewer_exe_btos', '00', null);
}

//----------------------------------------------
// 로컬 서버에 레지스트리 data read
//----------------------------------------------
function func_Read_RegData() {

	func_post_msg_sync_btos('msg_send_data_read', '00', null);
}

//----------------------------------------------
// 로컬 서버에 레지스트리 data write
//----------------------------------------------
function func_Write_RegData(data) {

	func_post_msg_sync_btos('msg_send_data_write', data, null);
}


//----------------------------------------------
// 로컬 서버와 연결 상태 시간 체크 사용 여부
//----------------------------------------------
function func_start_connect_state() {

	// 사용
	//func_post_msg_sync_btos('msg_send_start_time_continue_check', '00');

	// 사용 안함
	//func_post_msg_sync_btos('msg_send_stop_time_continue_check', '00');
}


//----------------------------------------------
// 로컬 서버와 연결 체크
//----------------------------------------------
function func_check_connect_state() {

	// 1초 마다 
	r_timerid_check_connect_state = setInterval(function() {

		func_post_msg_sync_btos('msg_send_check_connect_state_btos', '1', null);

	}, 1000);
}

//----------------------------------------------
// 동기
//----------------------------------------------
function func_post_msg_sync_btos(msg, param, callBack) {
	$.ajax({
		type: 'POST',
		async: false,
		url: r_url_localserver,
		contentType: 'text/plain',
		data: {
			id: r_browser_guid,
			msg: msg,
			param: param
		},
		error: function() {
			func_on_error_post_msg_btos(msg, param, callBack);
		},
		success: function(msg) {
			func_onMessage_stob(msg, callBack)
		}
	});
}


function func_onMessage_stob(msg, callBack) {

	if(msg.length == 0) {

		//debug_log('double connect!!');

		return;
	}

	// browser id 비교 처리 
	var jbSplit = msg.split('&');

	var _id;
	var _msg;
	var _param_0;
	var _param_1;
	for(var i in jbSplit) {
		if(i == 0) {
			_id = jbSplit[i];
		}
		if(i == 1) {
			_msg = jbSplit[i];
		}
		if(i == 2) {
			_param_0 = jbSplit[i];
		}
		if(i == 3) {
			_param_1 = jbSplit[i];
		}
	}

	if(_id != '-1') {
		if(_id != r_browser_guid) {

			//debug_log('double connect!! _id = ' + _id + ' r_browser_guid = ' + r_browser_guid);
			// 이중 브라우저 예외처리

			clearInterval(r_timerid_check_connect_state);

			//window.open('about:blank', '_self').self.close();

			// 팝업
			//alert('double connect!!');
			return;
		}
	}

	switch(_msg) {
		case 'msg_recv_data':
			// reg 정보 
			r_reg_data = _param_0;
			callback_reg_data(r_reg_data);
			break;
		case 'msg_recv_version':
			// 서버에 요청
			//Request_UploadFileWebList();
			// 설치 파일 버전
			r_localserver_version = _param_0;
			callBack(r_localserver_version);
			console.log("@@@@@@@@@@@@@@@@@@@@@@@version : "+r_localserver_version+"@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			break;
		case 'msg_recv_mapviewer_exe_stob':
			// 유니티 실행 성공
			if(isdefined(r_timerid_connect)) {
				clearInterval(r_timerid_connect);
			}
			break;
		case 'msg_recv_dummy_stob':
			// 더미 메시지
			if(r_bool_check_version) {
				// Ioneuron_Setup_2017_1221_ru_4st 버전 체크 처리!!
				if(!r_bool_dummy_versioncheck) {
					r_bool_dummy_versioncheck = true;
					Request_UploadFileWebList();
				}
			}
			break;
		case 'msg_recv_check_connect_state_stob':
			// 연결 상태 메시지 
			break;
		case 'msg_recv_map_project_list_info':
			// 맵서버에 프로젝트 리스트 정보
			response_map_project_list(_param_0);
			break;
	}
}


//----------------------------------------------
// 에러 체크
//----------------------------------------------

function func_on_error_post_msg_btos(msg, param, callBack) {
	switch(msg) {
		case 'msg_send_version':
		case 'msg_recv_version':
		case 'msg_send_double_check_btos':
			// 서버에 요청
			//Request_UploadFileWebList();
			//show_popup_sw_setup();
			
			if(callBack != null) {
				callBack(param);
			}
			break;
	}
}

//---------------------------------------------------------
// log
//---------------------------------------------------------
function debug_log(msg) {
	try {
		//console.log(msg);
	}
	catch(e) {}
}

//--------------------------------------------------------------------------------------------- 
//
// UploadFileWebList Request
//
//---------------------------------------------------------------------------------------------

function compare_fileid_localserver(a, b) {
	if(parseInt(a.version) < parseInt(b.version)) {
		return -1;
	}
	if(parseInt(a.version) > parseInt(b.version)) {
		return 1;
	}
	return 0;
}



function Request_UploadFileWebList() {
	var reqUploadFileWebList = new upload_file_web_list_Request();
	reqUploadFileWebList.send_Request('SMARTPHONE', '', r_sessionkey, '', '', '', callback_success_UploadFileWebList, callback_fail_UploadFileWebList);
}

function callback_success_UploadFileWebList(data) {
	var response = new upload_file_web_list_Response();
	response.setData(data);

	if(response.result_code == '0000') {
		var file_list = response.file_list;

		// sort
		file_list.sort(compare_fileid_localserver);

		if(file_list.length > 0) {
			var hfile = file_list[file_list.length - 1];

			var file_id = parseInt(hfile.version);
			var localserver_version = parseInt(r_localserver_version);
			if(file_id == localserver_version) {
				// 동일 버전
				// 메인페이지로 이동 처리
				var thisfilefullname = document.URL.substring(document.URL.lastIndexOf("/") + 1, document.URL.length);

				if(thisfilefullname !="main.html"){
					location.href = '/view/main.html';	
				}
				
			}
			else if(file_id > localserver_version) {
				// 설치 파일 다운로드 팝업 띄움
				r_file_url = hfile.file_url;
				show_popup_sw_setup();
			}
			else {
				// 설치 파일 다운로드 팝업 띄움
				r_file_url = hfile.file_url;

				// console.log('높은 버전');

				show_popup_sw_setup();
			}
		}
		else {
			// 서버에 설치 파일이 없는 경우
			alert('설치파일 없음');
		}
	}
	else if(response.result_code == '8002') {

	}
	else {

	}
}


function callback_fail_UploadFileWebList(data) {
	if(data.statusText == 'timeout') {
		popup_network_error();
	}
}