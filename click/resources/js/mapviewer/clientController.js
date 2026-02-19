var socket = null;
var buffer = null;
var imageData = null;
var worker = null;
var utilCntVal = null;
var img = new Image();
var g_ctx = null;
var g_canvas = null;
var g_realposx = 0;
var g_realposy = 0;
var g_realratio = 0;
var sep_n = "\\n";
var sep_b = "\\b";

var g_MapServerPort = "8348";

var g_GUID_Count_AirTag = 0;
var s_bFirstBuildNode_client = false;
var g_use_old_socket = false;
var g_re_connectsocket = false;
var g_load_img_client = false;

var checkLoadMap = false;
var r_reg_data = "-1";

//------------------------------------------------------------
// 유니티 해상도 변수
// 해상도 관련 처리
// - 3D지도 확대노출 필요(테스트해상도1920)
// - 1152:720 (브라우저해상도)/ 960: 600(유니티)
// - 1440:900 (브라우저해상도)/ 1152:720(유니티)
//------------------------------------------------------------
var g_unity_resolution_width = 1152;
var g_unity_resolution_height = 720;


//------------------------------------------------------------
// 유니티 기본 프레임
// 30 프레임으로 설정
// 100 퀄리티으로 설정
//------------------------------------------------------------
var g_unity_frame_count = 30;
var g_unity_graphic_quality = 100;

var firstWidth = 0;
var firstHeight = 0;

/** canvas 사이즈 조절 */
function canvasResize() {

   var canvasContainerWidth = $('.con-area').width();
   var canvasContainerHeight = $('.con-area').height() - 2;
   var canversHeight = canvasContainerWidth * 10 / 16;
   var canversWidth = canvasContainerWidth;
   if(canvasContainerHeight < canversHeight) {
      canversHeight = canvasContainerHeight;
      canversWidth = canvasContainerHeight * 16 / 10
   }

   // //비율 적용
   $('#mycanvas').attr('width', canvasContainerWidth).attr('height', canvasContainerHeight);
}


function GetGuidCountAirTag() {
    g_GUID_Count_AirTag += 1;
    return g_GUID_Count_AirTag;
}

var s_url_localserver = "http://127.0.0.1:9000/";

var canvas_rect = null;
var s_bmouse_down = 0;
var s_mouse_down_id = 0;

var s_timerid_socket = 0;
var s_timerid_connect = 0;
var s_timerid_connect_mapviewer = 0;
var s_count_websocket_connect_btol = 0;
var s_browser_guid = 1583921021478;
var s_bDoubleConnect = 0;

var s_bSuccess_MapDownload = 0;
var s_timerId_Mapdownload = 0;

var s_timerid_check_connect_state = 0;

var s_PoiAreaList;
var s_PoiList;


var s_AirTagHelper;

var s_array_CameraTable;

var s_success_poi_info = false;
var s_count_fail_poi_info = 0;

// TEMP CALLBACK
var g_loadMapCallBack = null;
var g_initMapCallBack = null;
var g_mainMapCallBack = null;

//현장별 MAP정보를 변경하기 위해 사용함. 
//초기 또는 현장정보가 변경될때 본 API를 호출해야함.
var g_ProjectId = "";
var g_MapUrl = "";
var g_SceneId = "";
var g_ChgSceneId = ""; //변경 시도중인 SceneId
var g_SiteId = "";
var g_mapView = null;
var g_isLoadingMap = false;


function setMapCallBack(name, callBack) {
	g_loadMapCallBack = callBack;
}

//조감도에서 클릭시,처리하는 이벤트. 
function setMainMapCallBack(callBack) {
	g_mainMapCallBack = callBack;
}



includeJs("/click/resources/js/mapviewer/airTag.js");
includeJs("/click/resources/js/mapviewer/atlasHelper.js");
includeJs("/click/resources/js/mapviewer/airTagHelper.js");


function set_site_info(company_id, projedct_id, map_url, scene_id) {
	g_SiteId = company_id;
	g_MapUrl = map_url;
	g_ProjectId = projedct_id;
	g_SceneId = scene_id;
	
	console.log("gScenId= " +g_SceneId );
}


function invalid_websocket() {

	if(g_use_event_page_move_sessionstorage) {
		if(g_event_page_move_sessionstorage == 1) {

		}
		else {
			location.href = '/html/MainPage.html';
		}
	}
	else {
		// 근무 현황과 설정, 로그아웃 버튼 클릭시 재 시작 방지 처리
		// 로그아웃 버튼 클릭을 하게되면 처리하지 않도록 처리한다.
		var key = sessionStorage.getItem('prevent_re_mainpage');
		if(isdefined(key)) {
			// console.log('prevent_re_mainpage 0001' );
			sessionStorage.setItem('prevent_re_mainpage', '');
		}
		else {
			//location.href = '/view/main.html';
		}
	}
}

// -----------------------------------------------------------------
// 웹소켓 관련 처리
// -----------------------------------------------------------------

var g_use_event_page_move_sessionstorage = false;
var g_event_page_move_sessionstorage = '0';

function save_sessionstorage_client() {

	if(g_use_event_page_move_sessionstorage) {

		close_websocket_msg();

		socket.close();

		// new page
		g_event_page_move_sessionstorage = '1';
		sessionStorage.setItem('event_page_move_sessionstorage', g_event_page_move_sessionstorage);

		// save id
		sessionStorage.setItem('browser_guid_sessionstorage', s_browser_guid);

		location.href = '/html/ServiceManagement/ServiceManagement.html';
	}
}

function close_sessionstorage_client() {

	if(g_use_event_page_move_sessionstorage) {
		g_event_page_move_sessionstorage = '0';
		sessionStorage.setItem('event_page_move_sessionstorage', g_event_page_move_sessionstorage);
	}
}

function load_sessionstorage_client() {

	if(g_use_event_page_move_sessionstorage) {

		g_event_page_move_sessionstorage = sessionStorage.getItem('event_page_move_sessionstorage');

		if(g_event_page_move_sessionstorage == '1') {


			s_browser_guid = sessionStorage.getItem('browser_guid_sessionstorage');

			start_websocket_msg();
		}
	}
}



function delete_myPosition_client() {

	if(s_AirTagHelper) {
		if(s_AirTagHelper.getshow_myPosition()) {
			s_AirTagHelper.setshow_myPosition(false);

			var airtag = s_AirTagHelper.getid_myPositon();
			if(airtag) {
				s_AirTagHelper.delete(s_AirTagHelper.airtag_id_myPosition);
			}
		}
	}
}

var s_array_msg_scene_onload;

//---------------------------------------------------------
//  
//---------------------------------------------------------

//---------------------------------------------------------
//  초기화 함수
//---------------------------------------------------------

var g_currentMenu = "";
function bootstrap(menu, callBack) {
	
	console.log("MENU=" + menu);
	console.log("callBack=" + callBack);
	
	g_currentMenu = menu;

	s_Array_SceneCamera = new Array();

	s_array_msg_scene_onload = new Array();

	s_PoiTableMap = new PoiTableMap;
	s_count_fail_poi_info = 0;

	s_Array_ObjectTransparency_Safe = new Array();

	s_Array_ObjectTransparency = new Array();
	s_Array_PrevObjectTransparency = new Array();
	
	s_Array_ObjectTransparency_Em = new Array();


    // 맵 서버로 부터 초기 POI 정보 담는 클래스
    // PoiAreaList(POI의 개수에 따라서 2개 이상일 경우 위치할 값) / PoiList 
    s_PoiTableMap = new PoiTableMap;

    s_count_fail_poi_info = 0;

   // generate_id();

    // F5번
    document.addEventListener("keydown", onkeydown_handler);

    // refresh
    window.onbeforeunload = CleanPage;
    window.unload = CleanPage;   

    var canvas = document.getElementById('mycanvas');
    g_canvas = canvas;
    g_ctx = canvas.getContext('2d');

    document.oncontextmenu = function (e) {
        return false;
    }

    canvas_rect = canvas.getBoundingClientRect();

    // event mouse
    canvas.onmousedown = onmouse_down;
    canvas.onmouseup = onmouse_up;
    canvas.onmousemove = onmouse_move;
    canvas.onmousewheel = onmouse_wheel;
    
    g_loadMapCallBack = callBack;
    
    console.log('connectSocket = ' + connectSocket);
    
	if(connectSocket) {
	    
	    ChangeScene(g_SceneId);

	} else {
	    // 로컬 서버 연결 상태 체크
	   start_Connect();
	   
	}
};

function bootstrap2(menu, callBack, canvasId) {
	
	console.log("MENU=" + menu);
	console.log("callBack=" + callBack);
		
	g_currentMenu = menu;

	s_Array_SceneCamera = new Array();

	s_array_msg_scene_onload = new Array();

	s_PoiTableMap = new PoiTableMap;
	s_count_fail_poi_info = 0;

	s_Array_ObjectTransparency_Safe = new Array();

	s_Array_ObjectTransparency = new Array();
	s_Array_PrevObjectTransparency = new Array();
	
	s_Array_ObjectTransparency_Em = new Array();


    // 맵 서버로 부터 초기 POI 정보 담는 클래스
    // PoiAreaList(POI의 개수에 따라서 2개 이상일 경우 위치할 값) / PoiList 
    s_PoiTableMap = new PoiTableMap;

    s_count_fail_poi_info = 0;

   // generate_id();

    // F5번
    document.addEventListener("keydown", onkeydown_handler);

    // refresh
    window.onbeforeunload = CleanPage;
    window.unload = CleanPage;   

    var canvas = document.getElementById(canvasId);
    g_canvas = canvas;
    g_ctx = canvas.getContext('2d');

    document.oncontextmenu = function (e) {
        return false;
    }

    canvas_rect = canvas.getBoundingClientRect();

    // event mouse
    canvas.onmousedown = onmouse_down;
    canvas.onmouseup = onmouse_up;
    canvas.onmousemove = onmouse_move;
    canvas.onmousewheel = onmouse_wheel;
    
    g_loadMapCallBack = callBack;
    
    console.log('connectSocket = ' + connectSocket);
    
	if(connectSocket) {
	    
	    ChangeScene2(g_SceneId);

	} else {
	    // 로컬 서버 연결 상태 체크
	   start_check_connect_state();	
	   start_Connect();
	   
	}
};

function bootstrap3(menu, callBack, initMapCallBack) {
	
	console.log("MENU=" + menu);
	console.log("callBack=" + callBack);
		
	g_currentMenu = menu;

	s_Array_SceneCamera = new Array();

	s_array_msg_scene_onload = new Array();

	s_PoiTableMap = new PoiTableMap;
	s_count_fail_poi_info = 0;

	s_Array_ObjectTransparency_Safe = new Array();

	s_Array_ObjectTransparency = new Array();
	s_Array_PrevObjectTransparency = new Array();
	
	s_Array_ObjectTransparency_Em = new Array();


    // 맵 서버로 부터 초기 POI 정보 담는 클래스
    // PoiAreaList(POI의 개수에 따라서 2개 이상일 경우 위치할 값) / PoiList 
    s_PoiTableMap = new PoiTableMap;

    s_count_fail_poi_info = 0;

   // generate_id();

    // F5번
    document.addEventListener("keydown", onkeydown_handler);

    // refresh
    window.onbeforeunload = CleanPage;
    window.unload = CleanPage;   

    var canvas = document.getElementById('mycanvas');
    g_canvas = canvas;
    g_ctx = canvas.getContext('2d');

    document.oncontextmenu = function (e) {
        return false;
    }

    canvas_rect = canvas.getBoundingClientRect();

    // event mouse
    canvas.onmousedown = onmouse_down;
    canvas.onmouseup = onmouse_up;
    canvas.onmousemove = onmouse_move;
    canvas.onmousewheel = onmouse_wheel;
    
    g_loadMapCallBack = callBack;
    g_initMapCallBack = initMapCallBack;

    console.log('connectSocket = ' + connectSocket);
    
	if(connectSocket) {
		
		if(initMapCallBack != null)
			initMapCallBack();
	    
	} else {
	    // 로컬 서버 연결 상태 체크
		
		g_SceneId = "";
		console.log("gScenId= " +g_SceneId );

	   start_Connect();
	   
	}
};

function CleanPage() {
	console.log('clientController.CleanPage');
    clearInterval(s_timerid_check_connect_state);
    
    if (s_AirTagHelper)
        s_AirTagHelper.clear();

    // 웹 소켓 종료
    stop_websocket();

    // 유니티 종료
    post_msg_sync_btos("msg_send_browser_close_btos", "00001");
}


function generate_id() {

    s_browser_guid = sessionStorage.getItem('browser_guid');
}

function onkeydown_handler() {
    switch (event.keyCode) {
        case 116: // 'F5'
            if (s_bDoubleConnect) {

            }
            else {
                // 유니티 종료 
                post_msg_btos("msg_send_browser_close_btos", "00001");
            }
            break;
    }
}

function start_worker() {
    worker = new Worker('/click/resources/js/doWorker.js');
    //console.log('bootstrap start_worker()');
    worker.onmessage = function (event) {
        var imageData = event.data;
        img.src = "data:image/jpeg;base64," + imageData;
    }

    img.onload = function () {

        //var unityWidth = 1152;
        //var unityHeight = 720;
        //var basicWidth = 1152;
        //var basicHeight = 720;

        //해상도 관련 처리
        // - 3D지도 확대노출 필요(테스트해상도1920)
        // - 1152:720 (브라우저해상도)/ 960: 600(유니티)
        // - 1440:900 (브라우저해상도)/ 1152:720(유니티)

        var unityWidth = g_unity_resolution_width;
        var unityHeight = g_unity_resolution_height;
        var save_tab = sessionStorage.getItem('save_tab');
		//console.log('bootstrap get save_tab :'+save_tab);
        
//        console.log("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+g_canvas.width);
//        console.log("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+g_canvas.height);

        
        var basicWidth = 1920;
        var basicHeight = 1200;

        var realposx = (g_canvas.width - basicWidth) / 2;
        var realposy = (g_canvas.height - basicHeight) / 2;

        g_realratio = unityWidth / basicWidth;

        g_realposx = realposx;
        g_realposy = realposy;
        g_ctx.drawImage(this, 0, 0, unityWidth, unityHeight, realposx, realposy, basicWidth, basicHeight);
        
    }
}


function stop_worker() {

    if (isdefined(worker)) {
        worker.terminate();
        worker = undefined;
    }
}

function check_timer() {

	var date = new Date();
	var hour = date.getHours();
	var min = date.getMinutes();
	
	if((hour+"").length < 2){
		hour="0"+hour; 
	}	
	if((min+"").length < 2){
		min="0"+min; 
	}
	var time = hour + "" + min;
	
	// 새벽 3시에 맵 재연결
	if(time == "0300")
	{
		console.log("execute msg_send_mapviewer_restart_btos");
		post_msg_btos('msg_send_mapviewer_restart_btos', '0002');
	}

}

var connectSocket = false;
var retryCount    = 0;
// websocket은 브라우저와 유니티 통신 
// 만약 실패하면 websocket은 페이지 재로딩 방식으로 다시 접속 
function start_websocket() {

    console.log("start_websocket");

    socket = new WebSocket('ws://127.0.0.1:4649/Laputa');

    socket.binaryType = 'arraybuffer';
    
    clearInterval(s_timerid_socket);
    s_timerid_socket = setInterval("check_timer()", 59000);

    //var key_value = sessionStorage.getItem('dashboard_page');
    //if (isdefined(key_value)) {
    //    if (key_value == "true") {
    //    }
    //    else {
    //
    //    }
    //}
    //else {
    //    waitForSocketConnection(socket, function (msg) { sendmessage(msg); });
    //}

    // onopen이 되었다는 것은 유니티와 브라우저가 웹소켓을 통해서 붙었다는 이야기임. 
    socket.onopen = function () {
    	         
             console.log("socket.onopen");

        connectSocket = true;

        localStorage.setItem('count_connect_mapviewer', 0);

        //var key_value = sessionStorage.getItem('dashboard_page');
        init_map();
    }

    socket.onmessage = handleReceive;

    socket.onclose = function (event) {
    	connectSocket = false;
    	
        var reason;

        Debug_Log("Socket.OnClose: Disconnected.<br> event.code : "+event.code, "gray");

        if (event.code == 1000)
            reason = "Normal closure, meaning that the purpose for which the connection was established has been fulfilled.";
        else if (event.code == 1001)
            reason = "An endpoint is \"going away\", such as a server going down or a browser having navigated away from a page.";
        else if (event.code == 1002)
            reason = "An endpoint is terminating the connection due to a protocol error";
        else if (event.code == 1003)
            reason = "An endpoint is terminating the connection because it has received a type of data it cannot accept (e.g., an endpoint that understands only text data MAY send this if it receives a binary message).";
        else if (event.code == 1004)
            reason = "Reserved. The specific meaning might be defined in the future.";
        else if (event.code == 1005) {
            reason = "No status code was actually present.";
        }
        else if (event.code == 1006)
            reason = "The connection was closed abnormally, e.g., without sending or receiving a Close control frame";
        else if (event.code == 1007)
            reason = "An endpoint is terminating the connection because it has received data within a message that was not consistent with the type of the message (e.g., non-UTF-8 [http://tools.ietf.org/html/rfc3629] data within a text message).";
        else if (event.code == 1008)
            reason = "An endpoint is terminating the connection because it has received a message that \"violates its policy\". This reason is given either if there is no other sutible reason, or if there is a need to hide specific details about the policy.";
        else if (event.code == 1009)
            reason = "An endpoint is terminating the connection because it has received a message that is too big for it to process.";
        else if (event.code == 1010)
            reason = "An endpoint (client) is terminating the connection because it has expected the server to negotiate one or more extension, but the server didn't return them in the response message of the WebSocket handshake. <br /> Specifically, the extensions that are needed are: " + event.reason;
        else if (event.code == 1011)
            reason = "A server is terminating the connection because it encountered an unexpected condition that prevented it from fulfilling the request.";
        else if (event.code == 1015)
            reason = "The connection was closed due to a failure to perform a TLS handshake (e.g., the server certificate can't be verified).";
        else
            reason = "Unknown reason";

        //if (socket) {
            //Debug_Log("Socket.OnClose: Disconnected.<br>", "gray");
        //	socket.terminate();
        //}

        var key = sessionStorage.getItem('prevent_re_mainpage');
        if (isdefined(key)) {
            sessionStorage.setItem('prevent_re_mainpage', "");
        }
        else {
            // 유니티가 페이지에 붙지 않았을 경우 재시도 
           // post_msg_sync_btos("msg_send_mapviewer_exe_btos", "00");
            ////console.log('유니티가 페이지에 붙지 않았을 경우 재시도 ');
            //movePageMain("/view/map/worker.html");
           // location.href = "/view/main.html";
            //bootstrap();
        }
        //if(event.code == 1006){
        //	post_msg_sync_btos("msg_send_mapviewer_exe_btos", "00");
            ////console.log('event.code 1006');
            //movePageMain("/view/map/worker.html");
            //location.href = "/view/main.html";
        	//start_websocket();
        	//return false;
        //}
        retryCount = retryCount + 1;
        //if( retryCount > 4 ) {
        //	retryCount = 0;
        //} else {
            start_websocket();
        	console.log("execute msg_send_mapviewer_exe_btos");
            post_msg_sync_btos("msg_send_mapviewer_exe_btos", "00");
        	//post_msg_btos('msg_send_mapviewer_restart_btos', '0002');

        	return false;
        //}
        

    };

}

function isConnct_webSocket() {
	if(socket) {
		if(socket.readyState === 1) {
			return true;
		}
	}
	return false;
}

// 유니티와 웹페이지 붙게 하는 부분 
function waitForSocketConnection(wsocket, callback) {
    setTimeout(
        function () {

            s_count_websocket_connect_btol++;

            if (s_count_websocket_connect_btol < 10) {

                if (wsocket.readyState === 1) {

                    if (callback != null) {
                        callback();
                    }
                    return;

                } else if (wsocket.readyState === 0) {
                    waitForSocketConnection(wsocket, callback);
                }
                else {
                    waitForSocketConnection(wsocket, callback);
                }
            }
            if (s_count_websocket_connect_btol >= 10) {
                s_count_websocket_connect_btol = 0;
                return;
            }

        }, 2000);
}

// 확인
function stop_websocket() {
    if (socket) {
        socket.close();
    }
}

//----------------------------------------------
// 로컬 서버에 레지스트리 data read
// 하이닉스 프로젝트에서 개인별 설정의 화면 설정을 레지스터에 저장하기 위해 사용
//----------------------------------------------
function func_Read_RegData() {

    post_msg_sync_btos("msg_send_data_read", "00");
}

//----------------------------------------------
// 로컬 서버에 레지스트리 data write
//----------------------------------------------
function func_Write_RegData(data) {

    post_msg_sync_btos("msg_send_data_write", data);
}


// 동기 :  브라우저 -> 로컬서버 
function post_msg_sync_btos(msg, param) {

	console.log("post_msg_sync_btos=" + msg + ", param=" + param);

    $.ajax({
        type: "POST",
        async: false,
        url: s_url_localserver,
        contentType: "text/plain",
        data: { id: s_browser_guid, msg: msg, param: param },
        error: function () {
            on_error_post_msg_btos(msg, param);
        },
		success : function(msg) {
            onMessage_stob(msg)
		}        
    });
}


// 비동기 : 브라우저 -> 로컬서버 
function post_msg_btos(msg, param) {

	console.log("post_msg_btos=" + msg + ", param=" + param);

    $.ajax({
        type: "POST",
        url: s_url_localserver,
        contentType: "text/plain",
        data: { id: s_browser_guid, msg: msg, param: param },
        error: function () {
            on_error_post_msg_btos(msg, param);
        },
		success : function(msg) {
            onMessage_stob(msg)
		}        
    });
}

// 로컬 서버 -> 브라우저를 통해서 메시지 처리 
function onMessage_stob(msg) {

	console.log("onMessage_stob=" + msg);

    if (msg.length == 0) {
        return;
    }

    // browser id 비교 처리 
    var jbSplit = msg.split('&');

    var _id;
    var _msg;
    var _param_0;
    var _param_1;
    for (var i in jbSplit) {

        if (i == 0) {
            _id = jbSplit[i];
        }
        if (i == 1) {
            _msg = jbSplit[i];
        }
        if (i == 2) {
            _param_0 = jbSplit[i];
        }
        if (i == 3) {
            _param_1 = jbSplit[i];
        }
    }

    //Debug_Log("post_msg = " + _msg);

    if (_id != "-1") {
        if (_id != s_browser_guid) {

            //Debug_Log("double connect!!");
            //Debug_Log("double connect!! _id = " + _id + " s_browser_guid = " + s_browser_guid);

            // 이중 브라우저 예외처리
            s_bDoubleConnect = true;

            // 타이머 해제
            clearInterval(s_timerid_connect);
            //alert("double connect!!");
           // location.href = "/view/main.html";
            return;
        }
    }

    switch (_msg) {
        case "msg_recv_data":
            {
                // reg 정보 
                r_reg_data = _param_0;
                callback_reg_data(r_reg_data);

            }
            break;
        case "msg_recv_connect_stob": // 브라우저와 로컬서버가 정상 접속 되었음.
            {
        	
        		start_check_connect_state();	

                // 접속이 되었다면 타이머 해제
                clearInterval(s_timerid_connect);

                Debug_Log("msg_recv_connect_stob");

                // 맵 다운로드 상태 체크
                var key_value = sessionStorage.getItem('dashboard_page');
                if (isdefined(key_value)) {
                    if (key_value == "true") {
                        // 연결 처리
                        start_connect_mapviewer();
                    }
                    else {

                    }
                }
                else {

                    // 맵 다운로드 시작 처리
                    post_msg_btos("msg_send_browser_mapdownload_btos", "");
                }

            }
            break;
        case "msg_recv_browser_mapdownload_stob":
            {
                // 맵 다운로드 상태 확인

                switch (_param_0) {
                    case "success_mapdownload":
                        {
                            clearInterval(s_timerId_Mapdownload);

                            //-------------------------------------------
                            // 맵뷰어 연결 카운트
                            // start - key
                            //-------------------------------------------
                            //var count_cm_key = localStorage.getItem("count_connect_mapviewer");

                            //var count_key = 1;

                            //if (isdefined(count_cm_key)) {
                            //    count_key = parseInt(count_cm_key);
                            //}
                            //var save_count_key = count_key + 1;

                            //localStorage.setItem('count_connect_mapviewer', save_count_key);

                            //var interval_time = 3000 * count_key;

                            ////console.log("interval_time = " + interval_time);
                            //-------------------------------------------
                            // end - key
                            //-------------------------------------------

                            s_timerid_connect_mapviewer = setInterval("start_connect_mapviewer()", 3000);

                            // 유니티 실행
                            post_msg_sync_btos("msg_send_mapviewer_exe_btos", "00");

                        }
                        break;
                    case "fail_mapdownload":
                        {
                            clearInterval(s_timerId_Mapdownload);
                        }
                        break;
                    case "s_Process_MapDownload":
                        {
                            // 1~100 까지 카운팅 
                            var process = _param_1;

			    if(process < 100) {
  		            	s_timerId_Mapdownload = setInterval(function () {
                                	post_msg_btos("msg_send_browser_mapdownload_btos", "");
                            	}, 1000);// 1초마다 체크
			    } else {
				clearInterval(s_timerId_Mapdownload);
 			    	s_timerid_connect_mapviewer = setInterval("start_connect_mapviewer()", 3000);
                                post_msg_sync_btos("msg_send_mapviewer_exe_btos", "00");	
			    } 
			
                        }
                        break;
                }
            }
            break;
        case "msg_recv_map_poi_info":  
            {
        		console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                //poi정보 와 poiarea 정상으로 받음. , 현재 poi정보와 poiarea정보는 로컬서버가 받아서 브라우저에 전달해줌
                var poi_list_info = _param_0;
                var poi_area_list_info = _param_1;

                if (poi_list_info != "-1" && poi_area_list_info != "-1") {
                    // 성공일 경우

                    // poi 
                    s_PoiList = new PoiList_Response();
                    s_PoiList.setData(JSON.parse(poi_list_info));
                    ////console.log('poi_list_info : '+poi_list_info);
                    s_PoiTableMap.setPoiList(s_PoiList);

                    // poi area
                    s_PoiAreaList = new PoiAreaList_Response();
                    s_PoiAreaList.setData(JSON.parse(poi_area_list_info));
                    s_PoiTableMap.setPoiAreaList(s_PoiAreaList);

                    s_success_poi_info = true;
                }
                else {
                    s_success_poi_info = false;

                    s_count_fail_poi_info++;

                    if (s_count_fail_poi_info > 2) {
                        // 소스안  poi 정보 설정
                        // 2번 회수가 넘어서 더이상 poi정보를 가지고 올 수 없으면, 예외 처리해서 브라우저 종료하거나
                        // 자체적으로 poi정보를 구축해서 예외처리 해야함. 

                        s_success_poi_info = true;
                    }
                    else {
                        setTimeout(function () {

                            post_msg_btos("msg_send_map_poi_info_btos", "1");

                        }, 1000);
                    }

                }
            }
            break;
    }
}

function start_connect_mapviewer() {

	console.log("start_connect_mapviewer");
    // start websock
    var result = start_websocket();
    // start worker
    start_worker();

    if(result != false)
    	clearInterval(s_timerid_connect_mapviewer);
}

// 에러 체크 

var count_error = 0;
function on_error_post_msg_btos(msg, param) {

	console.log('on_error_post_msg_btos : '+msg);
}

function start_Connect() {

    // mapBasicURL은 MapData인 서버 URL주소이며, 로컬 서버에게 알려줌. 
    var str_url_project_id = g_MapUrl + "%" + g_ProjectId;

    post_msg_btos("msg_send_connect_btos", str_url_project_id);
    post_msg_btos("msg_send_map_poi_info_btos", "1");
}

function start_LocalServer() {

}


function start_check_connect_state() {

	clearInterval(s_timerid_check_connect_state);
    // 로컬 서버 연결 상태 체크
    // 1초 마다 
    s_timerid_check_connect_state = setInterval(function () {

        post_msg_btos("msg_send_check_connect_state_btos", "1");

    }, 1000);
}


function sendmessage(msg) {
    try {
        send("connect");

        init_map();
    }
    catch (ex) {
    }
}

function send(msg) {
	
	console.log("send=" + msg);
	
    if (isdefined(socket)) {
        socket.send(msg);
    }
}

//------------------------------------------------------------
// 맵 초기화 함수 :  (브라우저 죽기전까지 한번 호출)
//------------------------------------------------------------
function init_map() {
	
	console.log('init_map ');
	console.log("g_Sceneid - " + g_SceneId);

    setMapDataPath("C:/MapData/");

    setProjectId(g_ProjectId);

    set_resolution_msg(g_unity_resolution_width, g_unity_resolution_height);

    set_frame_count(g_unity_frame_count);

    set_graphic_quality(g_unity_graphic_quality);

    setBackgroundColor("#F0F0F0");

    //현대 개발 초기 카매라 세팅
//    setInitCameraParam(30.91358, 41.92752, 1186.841, 1, 1500);
//    setCameraTargetPos(-124.4398, 0, 0.3201447);
//    setCameraPos(-528.2856, 361.9131, -449.3385);
    
    //현대 테해란로 카매라 세팅
   // setInitCameraParam(32.65086, -42.76476, 1450.584, 1, 1500);
   // setInitCameraParam(100, 0, 800.584, 1, 1500);
    
    //seLanguageCode("KO");
    
	if(g_initMapCallBack != null)
		g_initMapCallBack();

    fn_getMapViewInfo(g_SceneId);
    
}

//-----------------------------------------------------------------
// 웹소켓 관련 처리
//-----------------------------------------------------------------

var s_PoiTableMap = null;

function GetPoiTableMap() {

    return s_success_poi_info;
}

function PoiTableMap() {
    this.PoiAreaList = null;
    this.PoiList = null;

    this.setPoiAreaList = function (PoiAreaList) {
        this.PoiAreaList = PoiAreaList;
    }

    this.setPoiList = function (PoiList) {
        this.PoiList = PoiList;
    }
}


//---------------------------------------------------------
//  fps
//---------------------------------------------------------

function UtilCnt() {
    this.g_util_ElapedTime = 0;
    this.g_util_frameCnt = 1000;
    this.g_util_curCnt = 0;
    this.g_util_fps = 0;
    this.g_util_curticks = 0;
    this.g_util_prevticks = 0;
    this.g_util_dwStart = 0;
    this.g_util_dwEnd = 0;
}

function drawFPS(ctx) {
    // //console.log("FPS : " + utilCntVal.g_util_fps.toFixed(3));
}

function calcFPS() {
    if (utilCntVal.g_util_curCnt++ === utilCntVal.g_util_frameCnt) {
        var local_now = new Date();
        utilCntVal.g_util_dwEnd = local_now.getTime();
        utilCntVal.g_util_fps = utilCntVal.g_util_frameCnt * 1000 / (utilCntVal.g_util_dwEnd - utilCntVal.g_util_dwStart);
        utilCntVal.g_util_curCnt = 0;
        utilCntVal.g_util_dwStart = local_now.getTime();
        delete local_;
    }
}

function calcFPSAll(ctx) {

}

function calcFPSAll2() {
    calcFPS();
}



//---------------------------------------------------------
// log
//---------------------------------------------------------
function Debug_Log(msg) {
    try {
        console.log('Debug_Log '+msg);
    }
    catch (e) { }
}

function Debug_Log_Msg(msg) {
    try {
        console.log('Debug_Log_Msg '+msg);
    }
    catch (e) { }
}

function Debug_Log_Re_Msg(msg) {
    try {
       console.log('Debug_Log_Re_Msg '+msg);
    }
    catch (e) { }
}

function Debug_Log_Camera_Msg(msg) {
    try {
        //  console.log(msg);
    }
    catch (e) { }
}

//------------------------------------------------------------
//
// 유니티에서 맵 로딩 성공시 호출되는 콜백 함수
//
//------------------------------------------------------------
function on_loadmap(result_code, result_ms) {
    
    console.log("s_success_poi_info : "+s_success_poi_info);
    
    setControlLock("false", "false");
    
    if(null == getLocalStorage("locale") || 'ko_KR' == getLocalStorage("locale")) {
    	setLanguageCode('KO');
    } else {
    	setLanguageCode('EN');
    }
    
    if (s_success_poi_info) {

        on_final_load();
        	
    	if(g_currentMenu == MENU_TYPE.CRANE) {
    		//setCameraPos(0, 90, 0);
    		//setCameraZoom(800);
    		lockPinchEvent('1','0');

    	} else {
    		//setCameraPos(55, 500, -147);
    		lockPinchEvent('1','1');
    	}

        if(!isEmpty(g_mapView) && !isEmpty(g_mapView.angle) && !isEmpty(g_mapView.rotation) && !isEmpty(g_mapView.zoom))
        	setInitCameraParam(g_mapView.angle, g_mapView.rotation, g_mapView.zoom, 1, 1500);
        else if(!isEmpty(g_mapView) && !isEmpty(g_mapView.zoom))
        	setInitCameraParam(90, 0, g_mapView.zoom, 1, 1500);
        else
       		setInitCameraParam(45, 0, 600, 1, 1500);
        
        setCameraTargetPos(0, 0, 0);
        
		if(!isEmpty(g_mapView) && !isEmpty(g_mapView.airtag_space))
			s_AirTagHelper.setRePosSpace(g_mapView.airtag_space);
		else
			s_AirTagHelper.setRePosSpace(35);

                        
        if(g_loadMapCallBack != null) 
        	g_loadMapCallBack()

        g_isLoadingMap = false;
        
        
        if(!isEmpty(g_ChgSceneId))
        	g_SceneId = g_ChgSceneId;
        
    	console.log("gScenId= " +g_SceneId );

        
        g_ChgSceneId = "";
    }
    else {
        on_check_load();
    }
}


function on_check_load() {

    setTimeout(function () {

        if (s_success_poi_info) {
            on_final_load();
        }
        else {
            on_check_load();
        }

    }, 100);
}

function on_final_load() {
	console.log(' ******on_final_load ');
	checkLoadMap = true;
    //-----------------------------------------------------------------------------
    // AtlasHelper 사용법
    //-----------------------------------------------------------------------------

    if (s_AirTagHelper == null) {
        s_AirTagHelper = new AirTagHelper;

        // setup
        s_AirTagHelper.setup();
    }
    
    s_AirTagHelper.clear();
}

//------------------------------------------------------------
// Poi ID에 의한 로딩 콜백함수
//------------------------------------------------------------
function on_loadMapByPoiID(result_code, result_msg) {

}

//------------------------------------------------------------
// 좌표에 의한 맵 로딩 콜백함수
//------------------------------------------------------------
function on_loadMapByCoordinate(result_code, result_msg) {

}

//------------------------------------------------------------
// 현재 맵 ID 얻는 콜백 함수
//------------------------------------------------------------
function on_getCurrentMapId(map_id) {

}

//------------------------------------------------------------
// 맵 초기 콜백 함수
//------------------------------------------------------------
function on_initializeMap(result_code, result_msg) {

}

//------------------------------------------------------------
// 맵 로딩 시작 콜백 함수
//------------------------------------------------------------
function on_onLoadStart() {

}

//------------------------------------------------------------
// 카메라 상태 콜백 함수
//------------------------------------------------------------
function on_getCameraState(angle, rotation, zoom) {
//	console.log('on_getCameraState angle :'+angle);
//	console.log('on_getCameraState rotation :'+rotation);
//	console.log('on_getCameraState zoom :'+zoom);
}

//------------------------------------------------------------
// 현재 카메라 정보 콜백 함수
//------------------------------------------------------------
function on_getCameraPosition(vCameraPos_x, vCameraPos_y, vCameraPos_z, vTargetPos_x, vTargetPos_y, vTargetPos_z) {
	console.log('!!!on_getCameraPosition vCameraPos_x :'+vCameraPos_x);
	console.log('!!!on_getCameraPosition vCameraPos_y :'+vCameraPos_y);
	console.log('!!!on_getCameraPosition vCameraPos_z :'+vCameraPos_z);
	console.log('!!!on_getCameraPosition vTargetPos_x :'+vTargetPos_x);
	console.log('!!!on_getCameraPosition vTargetPos_y :'+vTargetPos_y);
	console.log('!!!on_getCameraPosition vTargetPos_z :'+vTargetPos_z);
}

//------------------------------------------------------------
// 리소스 클린 콜백 함수
//------------------------------------------------------------
function on_cleanResource() {

}

//------------------------------------------------------------
// 터치시 콜백 함수
//------------------------------------------------------------
function on_onObjectTouched(objType, objId) {

    console.log('$$ on_onObjectTouched objId : '+objId);
    // 터치
    switch (objType) {
        case "AIRTAG":
            {
	            fn_commonTouchEvent(objId);

            }
            break;
        case "DEVICE":
            {
                var xx = 0;
            }
            break;
        case "POI":
            {
                var building_val = $("#building_id option:eq(0)").attr("value2");
                var zone_val = $("#zone_id option:selected").val();
                
                if("장비협착현황" == building_val && isEmpty(zone_val)){
                    fn_clickMainpoi();
                }
                else{
                    var poi_id = objId;
                    moveMapbyPoi(poi_id);
                }
                
            }
            break;
    }
}

function fn_commonTouchEvent(objId) {
	
    var airtag = s_AirTagHelper.getTag(objId);                
    console.log(airtag.getPoiID());
    if (airtag) {
    	
		moveMapbyPoi(airtag.getPoiID());
		setCameraZoom(800);

        var obj_type = "";

        if (objId.indexOf("WORKER_") != -1) {
            obj_type = "WORKER";
            fn_callBackTouch(airtag.getPoiID(), obj_type);
        }
        
        if (objId.indexOf("GAS_") != -1) {
            obj_type = "GAS";
            fn_callBackTouch(airtag.getPoiID(), obj_type);
        }
        
        if (objId.indexOf("EQUIP_") != -1) {
            obj_type = "EQUIP";
            fn_callBackTouch(airtag.getPoiID(), obj_type);
        }

        
        if (objId.indexOf("STRICTURE_") != -1) {
            obj_type = "STRICTURE";
            
            fn_callBackTouch(airtag.getPoiID(), airtag.getTagTypeId());

        }
        
        if (objId.indexOf("RETAIN_") != -1) {
            obj_type = "RETAIN";
            fn_callBackTouch(airtag.getPoiID(), airtag.getAirtagType());
        }
        
        if (objId.indexOf("CRANE_") != -1) {
            obj_type = "CRANE";
            fn_callBackTouchByAirTag(airtag.getPoiID());
        }
        
        if (objId.indexOf("WATER_") != -1) {
            obj_type = "WATER";
            fn_callBackTouch(airtag.getPoiID(), obj_type);
        }
        
        if (objId.indexOf("SUB_") != -1) {
            obj_type = "SUB";
            fn_callBackTouch(airtag.getPoiID(), obj_type);
        }
        
        if (objId.indexOf("GATE_") != -1) {
            obj_type = "GATE";
            fn_callBackTouch(airtag.getPoiID(), obj_type);
        }
        
        if (objId.indexOf("FIRE_") != -1) {
            obj_type = "FIRE";
            fn_callBackTouch(airtag.getPoiID(), obj_type);
        }
    }
	
}




//--------------------------------------------------------------
//
// HashMap
//
//--------------------------------------------------------------
var HashMap = function () {
    this.map = new Object();
}

HashMap.prototype = {
    put: function (key, value) {
        this.map[key] = value;
    },
    get: function (key) {
        return this.map[key];
    },
    containsKey: function (key) {
        return key in this.map;
    },
    containsValue: function (value) {
        for (var prop in this.map) {
            if (this.map[prop] == value) {
                return true;
            }
        }
        return false;
    },
    clear: function () {
        for (var prop in this.map) {
            delete this.map[prop];
        }
    },
    remove: function (key) {
        delete this.map[key];
    },
    keys: function () {
        var arKey = new Array();
        for (var prop in this.map) {
            arKey.push(prop);
        }
        return arKey;
    },
    values: function () {
        var arVal = new Array();
        for (var prop in this.map) {
            arVal.push(this.map[prop]);
        }
        return arVal;
    },
    size: function () {
        var count = 0;
        for (var prop in this.map) {
            count++;
        }
        return count;
    }
}

//--------------------------------------------------------------
//
// ArrayList
//
//--------------------------------------------------------------
ArrayList = function arrayList() {

    this.list = [];

    this.add = function (item) {
        this.list.push(item);
    };

    this.get = function (index) {
        return this.list[index];
    };

    this.removeAll = function () {
        this.list = [];
    };

    this.clear = function () {
        this.list = [];
    }

    this.size = function () {
        return this.list.length;
    };

    this.remove = function (index) {
        var newList = [];
        for (var i = 0; i < this.list.length; i++) {
            if (i != index) {
                newList.push(this.list[i]);
            };
        };
        this.list = newList;
    };

    this.remove_item = function (item) {
        var newList = [];
        for (var i = 0; i < this.list.length; i++) {
            if (item != this.list[i]) {
                newList.push(this.list[i]);
            };
        };
        this.list = newList;
    };
};



//--------------------------------------------------------------
//
// PoiInfo
//
//--------------------------------------------------------------
function PoiInfo() {
    this.PosX;
    this.PosY;
    this.PosZ;

    this.getPosX = function () {
        return this.PosX;
    }
    this.getPosY = function () {
        return this.PosY;
    }
    this.getPosZ = function () {
        return this.PosZ;
    }
}


//------------------------------------------------------
//
//
// PoiList
//
//
// ------------------------------------------------------
var PoiList_Request = function() {
	// this.apiToken = '';
	this.appToken = '';
	this.clientType = '';
	// this.sessionKey = '';
	// this.osType = '';

	this.projectId = '';
	this.sceneId = '';
	this.poiId = '';

	this.callback_success_PoiList = null;
	this.callback_fail_PoiList = null;
}


PoiList_Request.prototype = {
	send_Request: function(mapBasicURL, appToken, clientType, projectId, poiId, updateDate, callback_success_PoiList, callback_fail_PoiList) {

		// this.apiToken = apiToken;
		this.appToken = appToken;
		this.clientType = clientType;
		// this.sessionKey = sessionKey;
		// this.osType = osType;

		this.projectId = projectId;
		this.poiId = poiId;
		this.updateDate = updateDate;

		this.callback_success_PoiList = callback_success_PoiList;
		this.callback_fail_PoiList = callback_fail_PoiList;

		var send_Data = this.getData();
		// var URL = 'http://218.55.23.196:8348/idrlbs/wlbmaps/poi/list';
		var URL = mapBasicURL + '/idrlbs/wlbmaps/poi/list';

		$.support.cors = true;

		$.ajax({
			type: 'POST',
			url: URL,
			contentType: 'application/json;charset=UTF-8',

			data: send_Data,
			success: this.callback_success_PoiList,
			error: this.callback_fail_PoiList
		});
	},

	getData: function() {
		var header = new Object();
		// header.apiToken = this.apiToken;
		header.appToken = this.appToken;
		header.clientType = this.clientType;
		// header.sessionKey = this.sessionKey;
		// header.osType = this.osType;

		var body = new Object();
		body.projectId = this.projectId;
		body.poiId = this.poiId;
		body.updateDate = this.updateDate;

		var reqData = new Object();
		reqData.header = header;
		reqData.body = body;

		return JSON.stringify(reqData);
	}
}

var PoiList_Response = function() {

	this.resultCode = '';
	this.resultMsg = '';

	this.poiList = function() {
		this.poiId = '';

		this.poiNmList = function() {
			this.langCd = '';
			this.name = '';
		}

		this.poiCode = '';

		this.posX = '';
		this.posY = '';
		this.posZ = '';

		this.sceneId = '';
		this.sectionId = '';
		this.createBy = '';
		this.createDate = '';
		this.updateDate = '';

		this.itemList = function() {
			this.index = '';
			this.item = '';
			this.value = '';
		}

		this.descriptionList = function() {
			this.langCd = '';
			this.name = '';
		}
	}
}

PoiList_Response.prototype = {
	setData: function(parseData) {
		this.result_code = parseData.header.result_code;
		this.result_msg = parseData.header.result_msg;

		if(parseData.body == 0) {

		}
		else {
			this.poiNmList = parseData.body.poiNmList;
			this.itemList = parseData.body.itemList;
			this.descriptionList = parseData.body.descriptionList;

			this.poiList = parseData.body.poiList;
		}
	}
}

function callback_success_PoiList(data) {
	var response = new PoiList_Response();
	response.setData(data);

	s_PoiList = response;

	var result = response.result_code;
	if(result == '0000') {}

	s_PoiTableMap.setPoiList(s_PoiList);
}

function getPoiInfo(poi_id) {
	for(var i = 0; i < s_PoiList.poiList.length; i++) {
		if(poi_id == s_PoiList.poiList[i].poiId) {
			return s_PoiList.poiList[i];
		}
	}
	return null;
}

function getPoiInfo_BuildingName(building_name) {
	for(var i = 0; i < s_PoiList.poiList.length; i++) {
		if(building_name == s_PoiList.poiList[i].poiNmList[0].name) {
			return s_PoiList.poiList[i];
		}
	}
	return null;
}

function callback_fail_PoiList(data) {

}


// ------------------------------------------------------
//
// PoiAreaList
//
//
// ------------------------------------------------------



var PoiAreaList_Request = function() {
	// this.apiToken = '';
	this.appToken = '';
	this.clientType = '';
	// this.sessionKey = '';
	// this.osType = '';

	this.projectId = '';
	this.sceneId = '';
	this.poiId = '';

	this.callback_success_PoiAreaList = null;
	this.callback_fail_PoiAreaList = null;
}


PoiAreaList_Request.prototype = {
	send_Request: function(mapBasicURL, appToken, clientType, projectId, sceneId, poiId, callback_success_PoiAreaList, callback_fail_PoiAreaList) {

		this.appToken = appToken;
		this.clientType = clientType;

		this.projectId = projectId;
		this.sceneId = sceneId;
		this.poiId = poiId;

		this.callback_success_PoiAreaList = callback_success_PoiAreaList;
		this.callback_fail_PoiAreaList = callback_fail_PoiAreaList;

		var send_Data = this.getData();
		var URL = mapBasicURL + '/idrlbs/wlbmaps/poi/area/list';

		$.support.cors = true;

		$.ajax({
			type: 'POST',
			url: URL,
			contentType: 'application/json;charset=UTF-8',

			data: send_Data,
			success: this.callback_success_PoiAreaList,
			error: this.callback_fail_PoiAreaList
		});
	},

	getData: function() {
		var header = new Object();
		header.appToken = this.appToken;
		header.clientType = this.clientType;

		var body = new Object();
		body.projectId = this.projectId;
		body.sceneId = this.sceneId;
		body.poiId = this.poiId;

		var reqData = new Object();
		reqData.header = header;
		reqData.body = body;

		return JSON.stringify(reqData);
	}
}

var PoiAreaList_Response = function() {

	this.resultCode = '';
	this.resultMsg = '';

	this.poiAreaList = function() {
		this.poiId = '';

		this.poiNmList = function() {
			this.langCd = '';
			this.name = '';
		}

		this.sceneId = '';

		this.coordList = function() {
			this.x = '';
			this.z = '';
		}

		this.createBy = '';
		this.createDate = '';
		this.updateDate = '';
	}
}

PoiAreaList_Response.prototype = {
	setData: function(parseData) {
		this.result_code = parseData.header.result_code;
		this.result_msg = parseData.header.result_msg;

		if(parseData.body == 0) {}
		else {
			this.poiNmList = parseData.body.poiNmList;
			this.coordList = parseData.body.coordList;

			this.poiAreaList = parseData.body.poiAreaList;
		}
	}
}


function callback_success_PoiAreaList(data) {
	var response = new PoiAreaList_Response();
	response.setData(data);

	s_PoiAreaList = response;

	var result = response.result_code;
	if(result == '0000') {}

	s_PoiTableMap.setPoiAreaList(s_PoiAreaList);
	//console.log('!!!callback_success_PoiAreaList');
}

function callback_fail_PoiAreaList(data) {

	var ixx = 0;
	//console.log('!!!callback_fail_PoiAreaList');
}


//---------------------------------------------------------------
//
// cctv
//
//---------------------------------------------------------------
function Play_CCTV_URL(url) {

    var str = url + " --no-qt-name-in-title --no-autoscale --width=720 --height=480 --no-video-title-show";
    post_msg_btos("msg_send_play_cctv_url_btos", str);
}


function handleReceive(message) {
	//console.log("message : "+message);
    var data = message.data;

    var comb = data.substring(0, 3);

    if (comb == "###") {

        //Debug_Log_Msg("data ###");
        //Debug_Log_Msg(data);
        var data_r = data.substring(5, data.length);
        //Debug_Log_Msg(data_r);
        MessagePump(data_r);
    }
    else {
        worker.postMessage({ "buffer": data });
    }
}


// 유니티에서 브라우저로 온 메시지 처리 
// 라임아이에서 message type을 command,event,message,binary로 나누어서 처리함 
function MessagePump(message) {
    var lines = message.split("\\n");
    var type = lines[0];
    var command = lines[1];
    var param = lines[2];

    //Debug_Log_Msg("type = " + type);
    //Debug_Log_Msg("command = " + command);
    //Debug_Log_Msg("param = " + param);
    console.log("type = " + type);
    console.log("command = " + command);
    console.log("param = " + param);

    switch (type) {
        case "Command":
            {
                On_Message_Command(command, param);
            }
            break;
        case "Event":
            {
                On_Message_Event(command, param);
            }
            break;
        case "Message":
            {
                On_Message_Message(command, param);
            }
            break;
        case "Binary":
            {
                On_Message_Binary(command, param);
            }
            break;
    }
}

function On_Message_Command(command, param) {


}


//------------------------------------------------
// poi
//------------------------------------------------
function KSJSONPOIBodyInfo() {
    this.PoiList = new ArrayList();
}

function KSJSONPOIList() {
    this.body = new KSJSONPOIBodyInfo();

    this.Clear = function () {
        body.PoiList.Clear();
    }
}

function KSJSONPOIInfo() {
    this.POIID;                               // POI 식별자, Key(10)
    this.SceneID;
    this.NameKO;                              // POI 이름(한글)
    this.NameEN;                              // POI 이름(영문)
    this.CategoryID;                          // 카테고리 대분류
    this.CategorySubID;                       // 카테고리 중분류
    this.PosX;                                // 월드 좌표계 X값
    this.PosY;                                // 월드 좌표계 Y값
    this.PosZ;                                // 월드 좌표계 Z값
    this.Tag;                                 // Custom Data
    this.Desc;                                // 설명
}

function On_Message_Event(command, param) {

    switch (command) {
        case "getPoiInfo":
            {
                var params = param.split(sep_b);
                var jsonval = params[0];
                var poiInfo_list = new KSJSONPOIList(JSON.parse(jsonval));
            }
            break;
        case "getCategoryInfo":
            {
                var params = param.split(sep_b);
                var jsonval = params[0];
            }
            break;
        case "onSelectPoi":
            {
                var params = param.split(sep_b);
                var jsonval = params[0];
                var poiInfo = new KSJSONPOIInfo(JSON.parse(jsonval));
                
                var poiList = JSON.parse(jsonval);
                
                //fn_callBackTouch(JSON.stringify(poiList.body.PoiList[0].POIID));
                
                //중앙으로 이동. 
       			moveMapbyPoi(JSON.stringify(poiList.body.PoiList[0].POIID));
                
                if(g_mainMapCallBack != null)
                	g_mainMapCallBack();

            }
            break;
        case "onSelectMyPosition":
            {
                var params = param.split(sep_b);
                var jsonval = params[0];
            }
            break;
        case "onTouchInfo":
            {
                var params = param.split(sep_b);
                var iEvent = params[0];
                var angle = params[1];
                var rotation = params[2];
                var zoom = params[3];
                var vTargetCamPos_x = params[4];
                var vTargetCamPos_y = params[5];
                var vTargetCamPos_z = params[6];
                var vCamPos_x = params[7];
                var vCamPos_y = params[8];
                var vCamPos_z = params[9];
                
            }
            break;
        case "OnGoBackPressed":
            {

            }
            break;
        case "onPressButton":
            {
                var params = param.split(sep_b);
                var UxID = params[0];
            }
            break;
        case "onReleaseButton":
            {
                var params = param.split(sep_b);
                var UxID = params[0];
            }
            break;
    }
}

function On_Message_Message(command, param) {
	console.log('!! On_Message_Message command : '+command);
    switch (command) {
        case "loadMap":
            {
                var params = param.split(sep_b);
                var result_code = params[0];
                var result_msg = params[1];

                if (result_code == "1") {
                    on_loadmap(result_code, result_msg);
                }
            }
            break;
        case "loadMapByPoiID":
            {
                var params = param.split(sep_b);
                var result_code = params[0];
                var result_msg = params[1];

                on_loadMapByPoiID(result_code, result_msg);
            }
            break;
        case "loadMapByCoordinate":
            {
                var params = param.split(sep_b);
                var result_code = params[0];
                var result_msg = params[1];

                on_loadMapByCoordinate(result_code, result_msg);
            }
            break;
        case "getCurrentMapId":
            {
                var params = param.split(sep_b);
                var map_id = params[0];

                on_getCurrentMapId(map_id);
            }
            break;
        case "initializeMap":
            {
                var params = param.split(sep_b);
                var result_code = params[0];
                var result_msg = params[1];

                on_initializeMap(result_code, result_msg);
            }
            break;
        case "onLoadStart":
            {
                on_onLoadStart();
            }
            break;
        case "getCameraState":
            {
                var params = param.split(sep_b);
                var angle = params[0];
                var rotation = params[1];
                var zoom = params[2];

                //Debug_Log_Camera_Msg("angle = " + angle + " rotation = " + rotation + " zoom = " + zoom);

                on_getCameraState(angle, rotation, zoom);
            }
            break;
        case "getCameraPosition":
            {
                var params = param.split(sep_b);
                var vCameraPos_x = params[0];
                var vCameraPos_y = params[1];
                var vCameraPos_z = params[2];
                var vTargetPos_x = params[3];
                var vTargetPos_y = params[4];
                var vTargetPos_z = params[5];

                //Debug_Log_Camera_Msg("vCameraPos_x = " + vCameraPos_x + " vCameraPos_y = " + vCameraPos_y + " vCameraPos_z = " + vCameraPos_z + "vTargetPos_x = " + vTargetPos_x + " vTargetPos_y = " + vTargetPos_y + " vTargetPos_z = " + vTargetPos_z);

                on_getCameraPosition(vCameraPos_x, vCameraPos_y, vCameraPos_z, vTargetPos_x, vTargetPos_y, vTargetPos_z);
            }
            break;
        case "cleanResource":
            {
                on_cleanResource();
            }
            break;
        case "onObjectTouched":
            {
                var params = param.split(sep_b);
                var objType = params[0];
                var objId = params[1];

                on_onObjectTouched(objType, objId);
            }
            break;

        case "getViewAreaPosition":
            {
                var params = param.split(sep_b);
                var obj_id = params[0];
                var vPos_x = params[1];
                var vPos_y = params[2];
                var vPos_z = params[3];

                on_getViewAreaPosition(obj_id, vPos_x, vPos_y, vPos_z);
            }
            break;
    }
}


function on_getViewAreaPosition(obj_id, vPos_x, vPos_y, vPos_z) {
    var xx = 0;
}

function On_Message_Binary(command, param) {


}


//--------------------------------------------------------------
//
// event mouse
//
//--------------------------------------------------------------

function getMousePos(e) {
	
	//return { x: e.offsetX, y: e.offsetY };
    return { x: (e.clientX - canvas_rect.left - g_realposx) * g_realratio, y: (e.clientY - canvas_rect.top - g_realposy) * g_realratio };
}

function send_mouse(event_msg, e) {
    var mousecoords = getMousePos(e);

    var msg = "";
    msg += "Command" + sep_n;
    msg += event_msg + sep_n;
    msg += e.button + sep_b;
    msg += mousecoords.x + sep_b;
    msg += mousecoords.y + sep_b;
    send(msg);
}

function send_pinch(){
var msg = "";
msg += "Command" + sep_n;
msg += "lockPinchEvent" + sep_n;
msg += true + sep_b;
msg += false + sep_b;
send(msg);
}


function onmouse_down(e) {

    s_bmouse_down = 1;

    if (e.button == 2) {
        s_mouse_down_id = 1;
    }
    else {
        s_mouse_down_id = 0;
    }
    send_mouse("setMouseDown", e);

    var mousecoords = getMousePos(e);
    //Debug_Log_Msg("m  : button = " + e.button + " x = " + mousecoords.x + " y = " + mousecoords.y);
}

function onmouse_up(e) {
    s_bmouse_down = 0;
    send_mouse("setMouseUp", e);
}

function onmouse_move(e) {
    if (s_bmouse_down == 0) return;

    var mousecoords = getMousePos(e);

    var msg = "";
    msg += "Command" + sep_n;
    msg += "setMouseMove" + sep_n;
    msg += s_mouse_down_id + sep_b;
    msg += mousecoords.x + sep_b;
    msg += mousecoords.y + sep_b;
    send(msg);

    //send_mouse("setMouseMove", e);
    //Debug_Log_Msg("m : onmouse_move ");
}

function onmouse_wheel(e) {
    //var delta = e.wheelDelta ? e.wheelDelta : -e.detail;

    var delta = e.wheelDelta ? -e.wheelDelta : e.detail;

    var msg = "";
    msg += "Command" + sep_n;
    msg += "setMouseWheel" + sep_n;
    msg += delta + sep_b;
    send(msg);
}


//------------------------------------------------------
//
// PoiList_Response / PoiAreaList
//
//------------------------------------------------------

var PoiList_Response = function () {

    this.resultCode = "";
    this.resultMsg = "";

    this.poiList = function () {
        this.poiId = "";

        this.poiNmList = function () {
            this.langCd = "";
            this.name = "";
        }

        this.poiCode = "";

        this.posX = "";
        this.posY = "";
        this.posZ = "";

        this.sceneId = "";
        this.sectionId = "";
        this.createBy = "";
        this.createDate = "";
        this.updateDate = "";

        this.itemList = function () {
            this.index = "";
            this.item = "";
            this.value = "";
        }

        this.descriptionList = function () {
            this.langCd = "";
            this.name = "";
        }
    }
}


PoiList_Response.prototype = {
    setData: function (parseData) {
        this.result_code = parseData.header.result_code;
        this.result_msg = parseData.header.result_msg;

        if (parseData.body == 0) {
        } else {
            this.poiNmList = parseData.body.poiNmList;
            this.itemList = parseData.body.itemList;
            this.descriptionList = parseData.body.descriptionList;

            this.poiList = parseData.body.poiList;
        }
    }
}

var PoiAreaList_Response = function () {

    this.resultCode = "";
    this.resultMsg = "";

    this.poiAreaList = function () {
        this.poiId = "";

        this.poiNmList = function () {
            this.langCd = "";
            this.name = "";
        }

        this.sceneId = "";

        this.coordList = function () {
            this.x = "";
            this.z = "";
        }

        this.createBy = "";
        this.createDate = "";
        this.updateDate = "";
    }
}


PoiAreaList_Response.prototype = {
    setData: function (parseData) {
        this.result_code = parseData.header.result_code;
        this.result_msg = parseData.header.result_msg;

        if (parseData.body == 0) {
        } else {
            this.poiNmList = parseData.body.poiNmList;
            this.coordList = parseData.body.coordList;

            this.poiAreaList = parseData.body.poiAreaList;
        }
    }
}

function moveMapbyPoi(poi_id) {
	
	var info = getPoiInfo(poi_id);
	if(info != null) {
		moveMap(info.posX, info.posY, info.posZ);
	}

}
//--------------------------------------------------------------
//
// set api
//
//--------------------------------------------------------------

// 0
function setMapDataPath(data_path) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setMapDataPath" + sep_n;
    msg += data_path + sep_b;                               // path
    send(msg);
}

// 1
function setProjectId(project_id) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setProjectId" + sep_n;
    msg += project_id + sep_b;                              // project id
    send(msg);
}

// 2
function setZoomRange(zoom_min, zoom_max) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setZoomRange" + sep_n;
    msg += zoom_min + sep_b;                                // zoom_min
    msg += zoom_max + sep_b;                                // zoom_max
    send(msg);
}

// 3
function setDebugMode(bshow) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setDebugMode" + sep_n;
    msg += bshow + sep_b;                                   // true, false
    send(msg);
}

// 4
function loadMap(map_id) {
	
	g_isLoadingMap = true;
	
    var msg = "";

    msg += "Command" + sep_n;
    msg += "loadMap" + sep_n;
    msg += map_id + sep_b;                                  // map_id
    send(msg);
}

// 5
function loadMapByPosition(map_id, x, y, z) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "loadMapByPosition" + sep_n;
    msg += map_id + sep_b;                                  // map_id
    msg += x + sep_b;                                       // x
    msg += y + sep_b;                                       // y
    msg += z + sep_b;                                       // z
    send(msg);
}


// 6
function moveMap(x, y, z) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "moveMap" + sep_n;
    msg += x + sep_b;                                       // x
    msg += y + sep_b;                                       // y
    msg += z + sep_b;                                       // z 
    send(msg);
}

// 7 
function getCurrentMapId() {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "getCurrentMapId" + sep_n;
    send(msg);
}

// 8
function initializeMap() {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "initializeMap" + sep_n;
    send(msg);
}

// 9
function setBackgroundColor(bg_color) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setBackgroundColor" + sep_n;
    msg += bg_color + sep_b;                                // bg_color
    send(msg);
}

// 10
function setCameraAngle(camera_angle) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setCameraAngle" + sep_n;
    msg += camera_angle + sep_b;                            // camera_angle
    send(msg);
}

// 11
function setCameraRotation(camera_rotation) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setCameraRotation" + sep_n;
    msg += camera_rotation + sep_b;                         // camera_rotation
    send(msg);
}

// 12 : camera_zoom 수치가 클수록 작아진다. 
function setCameraZoom(camera_zoom) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setCameraZoom" + sep_n;
    msg += camera_zoom + sep_b;                             // camera_zoom
    send(msg);
}

// 13
function showPoiById(visibility, filter_poi_id) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "showPoiById" + sep_n;
    msg += visibility + sep_b;                              // visibility true, false
    msg += filter_poi_id + sep_b;                           // filter_poi_id
    send(msg);
}

// 14
function showRoute(visibility) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "showRoute" + sep_n;
    msg += visibility + sep_b;                              // visibility true, false
    send(msg);
}

// 15
function addRoutingPath(line_width, link_color, shadow_off_x, shadow_off_y, shadow_off_z, shadow_color, arrow_size_width, arrow_size_height, pos_array) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "addRoutingPath" + sep_n;
    msg += line_width + sep_b;                              // line_width
    msg += link_color + sep_b;                              // link_color
    msg += shadow_off_x + sep_b;                            // shadow_off_x
    msg += shadow_off_y + sep_b;                            // shadow_off_y
    msg += shadow_off_z + sep_b;                            // shadow_off_z
    msg += shadow_color + sep_b;                            // shadow_color
    msg += arrow_size_width + sep_b;                        // arrow_size_width
    msg += arrow_size_height + sep_b;                       // arrow_size_height

    nodeCount = pos_array.length;
    msg += nodeCount + sep_b;                               // nodeCount

    for (var i = 0; i < pos_array.length; i++) {
        msg += pos_array[i][0] + sep_b;                 // x
        msg += pos_array[i][1] + sep_b;                 // y
        msg += pos_array[i][2] + sep_b;                 // z
    }
    send(msg);
}

// 16
function cleanRoutingPath() {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "cleanRoutingPath" + sep_n;
    send(msg);
}

// 17
function addDynamicPoi(id, pos_x, pos_y, pos_z, uvStartPosX, uvStartPosY, uvEndPosX, uvEndPosY, texname, type, text) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "addDynamicPoi" + sep_n;
    msg += id + sep_b;                                      // id
    msg += pos_x + sep_b;                                   // pos_x
    msg += pos_y + sep_b;                                   // pos_y
    msg += pos_z + sep_b;                                   // pos_z
    msg += uvStartPosX + sep_b;                             // uvStartPosX
    msg += uvStartPosY + sep_b;                             // uvStartPosY
    msg += uvEndPosX + sep_b;                               // uvEndPosX
    msg += uvEndPosY + sep_b;                               // uvEndPosY
    msg += texname + sep_b;                                 // texname
    msg += type + sep_b;                                    // type
    msg += text + sep_b;                                    // text
    send(msg);
}

// 18
function showDynamicPoi(show, poi_id) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "showDynamicPoi" + sep_n;
    msg += show + sep_b;                                    // show
    msg += poi_id + sep_b;                                  // poi_id
    send(msg);
}

// 19
function setPositionDynamicPoi(id, pos_x, pos_y, pos_z) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setPositionDynamicPoi" + sep_n;
    msg += id + sep_b;                                      // id
    msg += pos_x + sep_b;                                   // pos_x
    msg += pos_y + sep_b;                                   // pos_y
    msg += pos_z + sep_b;                                   // pos_z
    send(msg);
}

// 20
function setTypeDynamicPoi(id, type) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setTypeDynamicPoi" + sep_n;
    msg += id + sep_b;                                      // id
    msg += type + sep_b;                                    // type
    send(msg);
}

// 21
function setTypePoi(id, type) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setTypePoi" + sep_n;
    msg += id + sep_b;                                      // id
    msg += type + sep_b;                                    // type
    send(msg);
}

// 22
function getCameraState() {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "getCameraState" + sep_n;
    send(msg);
}

// 23
function setInitCameraParam(angle, rot, zoom, zoom_min, zoom_max) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setInitCameraParam" + sep_n;
    msg += angle + sep_b;                                   // angle
    msg += rot + sep_b;                                     // rot
    msg += zoom + sep_b;                                    // zoom
    msg += zoom_min + sep_b;                                // zoom_min
    msg += zoom_max + sep_b;                                // zoom_max
    send(msg);
}

// 24
function setTextDynamicPoi(id, text) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setTextDynamicPoi" + sep_n;
    msg += id + sep_b;                                      // id
    msg += text + sep_b;                                    // text
    send(msg);
}

// 25
function setColorTextDynamicPoi(id, textcolor) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setColorTextDynamicPoi" + sep_n;
    msg += id + sep_b;                                      // id
    msg += textcolor + sep_b;                               // textcolor
    send(msg);
}

// 26
function releaseDynamicPoi(id) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "releaseDynamicPoi" + sep_n;
    msg += id + sep_b;                                      // id
    send(msg);
}

// 27
function setDynamicPoiAnchor(poi_ids, anchor) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setDynamicPoiAnchor" + sep_n;
    msg += poi_ids + sep_b;                                 // poi_ids
    msg += anchor + sep_b;                                  // anchor
    send(msg);
}

// 28
function directionPressUp(method) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "directionPressUp" + sep_n;
    msg += method + sep_b;                                  // method
    send(msg);
}

// 29
function directionPressDown(method) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "directionPressDown" + sep_n;
    msg += method + sep_b;                                  // method
    send(msg);
}

// 30
function setLanguageCode(language_code) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setLanguageCode" + sep_n;
    msg += language_code + sep_b;                           // language_code
    send(msg);
}

// 31
function setShowPoiColor(id, visibility, color) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setShowPoiColor" + sep_n;
    msg += id + sep_b;                                      // id
    msg += visibility + sep_b;                              // visibility
    msg += color + sep_b;                                   // color
    send(msg);
}

// 32
function setIconToolTipById(id, objectId, objectType, visibility, fontColor, fontSize, texFileName, text, lefttop, rightbottom, textpos, anchorpos) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setIconToolTipById" + sep_n;
    msg += id + sep_b;                                      // id
    msg += objectId + sep_b;                                // objectId
    msg += objectType + sep_b;                              // objectType
    msg += visibility + sep_b;                              // visibility
    msg += fontColor + sep_b;                               // fontColor
    msg += fontSize + sep_b;                                // fontSize
    msg += texFileName + sep_b;                             // texFileName
    msg += text + sep_b;                                    // text
    msg += lefttop + sep_b;                                 // lefttop
    msg += rightbottom + sep_b;                             // rightbottom
    msg += textpos + sep_b;                                 // textpos
    msg += anchorpos + sep_b;                               // anchorpos
    send(msg);
}

// 33
function setIconToolTipByPosition(id, pos_x, pos_y, pos_z, visibility, fontColor, fontSize, texFileName, text, lefttop, rightbottom, textpos, anchorpos) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setIconToolTipByPosition" + sep_n;
    msg += id + sep_b;                                      // id
    msg += pos_x + sep_b;                                   // pos_x
    msg += pos_y + sep_b;                                   // pos_y
    msg += pos_z + sep_b;                                   // pos_z
    msg += visibility + sep_b;                              // visibility
    msg += fontColor + sep_b;                               // fontColor
    msg += fontSize + sep_b;                                // fontSize
    msg += texFileName + sep_b;                             // texFileName
    msg += text + sep_b;                                    // text
    msg += lefttop + sep_b;                                 // lefttop
    msg += rightbottom + sep_b;                             // rightbottom
    msg += textpos + sep_b;                                 // textpos
    msg += anchorpos + sep_b;                               // anchorpos
    send(msg);
}

// 34
function changeTextureObject(id, orig_texname, new_texname) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "changeTextureObject" + sep_n;
    msg += id + sep_b;                                      // id
    msg += orig_texname + sep_b;                            // orig_texname
    msg += new_texname + sep_b;                             // new_texname
    send(msg);
}

// 35
function releaseIconToolTip(id) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "releaseIconToolTip" + sep_n;
    msg += id + sep_b;                                      // id
    send(msg);
}

// 36
function setSpeedZoom(speed) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setSpeedZoom" + sep_n;
    msg += speed + sep_b;                                   // speed
    send(msg);
}

// 37
function setCameraTargetPos(x, y, z) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setCameraTargetPos" + sep_n;
    msg += x + sep_b;                                       // x
    msg += y + sep_b;                                       // y
    msg += z + sep_b;                                       // z
    send(msg);
}

// 38
function setCameraPos(x, y, z) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setCameraPos" + sep_n;
    msg += x + sep_b;                                       // x
    msg += y + sep_b;                                       // y
    msg += z + sep_b;                                       // z
    send(msg);
}

// 39
function setCameraPathPos(camera_x, camera_y, camera_z, target_x, target_y, target_z) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setCameraPathPos" + sep_n;
    msg += camera_x + sep_b;                                // camera_x
    msg += camera_y + sep_b;                                // camera_y
    msg += camera_z + sep_b;                                // camera_z
    msg += target_x + sep_b;                                // target_x
    msg += target_y + sep_b;                                // target_y
    msg += target_z + sep_b;                                // target_z
    send(msg);
}

// 40
function getCameraPosition() {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "getCameraPosition" + sep_n;
    send(msg);
}

// 41
function showPoiIconById(visibility, filter_poi_id) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "showPoiIconById" + sep_n;
    msg += visibility + sep_b;                              // visibility
    msg += filter_poi_id + sep_b;                           // filter_poi_id
    send(msg);
}

// 42
function cleanResource() {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "cleanResource" + sep_n;
    send(msg);
}

// 43
function addDynamicPoiByPoiID(id, poiID, uvStartPosX, uvStartPosY, uvEndPosX, uvEndPosY, texname, type, text) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "addDynamicPoiByPoiID" + sep_n;
    msg += id + sep_b;                                      // id
    msg += poiID + sep_b;                                   // poiID
    msg += uvStartPosX + sep_b;                             // uvStartPosX
    msg += uvStartPosY + sep_b;                             // uvStartPosY
    msg += uvEndPosX + sep_b;                               // uvEndPosX
    msg += uvEndPosY + sep_b;                               // uvEndPosY
    msg += texname + sep_b;                                 // texname
    msg += type + sep_b;                                    // type
    msg += text + sep_b;                                    // text
    send(msg);
}

// 44
function setTouchRotateSpeed(speed) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setTouchRotateSpeed" + sep_n;
    msg += speed + sep_b;                                   // speed
    send(msg);
}

// 45
function setPressRotateSpeed(speed) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setPressRotateSpeed" + sep_n;
    msg += speed + sep_b;                                   // speed
    send(msg);
}

// 46
function setPressAngleSpeed(speed) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setPressAngleSpeed" + sep_n;
    msg += speed + sep_b;                                   // speed
    send(msg);
}

// 47
function create3dObject(id, modelName, scale) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "create3dObject" + sep_n;
    msg += id + sep_b;                                      // id
    msg += modelName + sep_b;                               // modelName
    msg += scale + sep_b;                                   // scale
    send(msg);
}

// 48
function set3dObjectPosition(objId, pos_x, pos_y, pos_z, dir_vector_x, dir_vector_y, dir_vector_z) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "set3dObjectPosition" + sep_n;
    msg += objId + sep_b;                                   // objId
    msg += pos_x + sep_b;                                   // pos_x
    msg += pos_y + sep_b;                                   // pos_y
    msg += pos_z + sep_b;                                   // pos_z
    msg += dir_vector_x + sep_b;                            // dir_vector_x
    msg += dir_vector_y + sep_b;                            // dir_vector_y
    msg += dir_vector_z + sep_b;                            // dir_vector_z
    send(msg);
}

// 49
function set3dObjectViewType(objId, viewType) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "set3dObjectViewType" + sep_n;
    msg += objId + sep_b;                                   // objId
    msg += viewType + sep_b;                                // viewType
    send(msg);
}

// 50
function set3dObjectVisible(objId, visible) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "set3dObjectVisible" + sep_n;
    msg += objId + sep_b;                                   // objId
    msg += visible + sep_b;                                 // visible
    send(msg);
}

// 51
function delete3dObject(objId) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "delete3dObject" + sep_n;
    msg += objId + sep_b;                                   // objId
    send(msg);
}

// 52
function createAirTag(ids) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "createAirTag" + sep_n;
    msg += ids + sep_b;                                     // ids
    send(msg);
}

// 53
function setAirTagPosition(airTagIds, pos_x, pos_y, pos_z) {
    var msg = "";
    console.log('11111setAirTagPosition airTagIds : '+airTagIds);
    console.log('11111setAirTagPosition airTagIds : '+pos_y);
    msg += "Command" + sep_n;
    msg += "setAirTagPosition" + sep_n;
    msg += airTagIds + sep_b;                               // airTagIds
    msg += pos_x + sep_b;                                   // pos_x
    msg += pos_y + sep_b;                                   // pos_y
    msg += pos_z + sep_b;                                   // pos_z
    send(msg);
}

// 54
function setAirTagPositionByPoiId(airTagIds, poiId) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setAirTagPositionByPoiId" + sep_n;
    msg += airTagIds + sep_b;                               // airTagIds
    msg += poiId + sep_b;                                   // poiId
    send(msg);
}

// 55
function setAirTagBgImage(airTagIds, bgImgName, bgImgLeftPos, bgImgTopPos, bgImgWidth, bgImgHeight) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setAirTagBgImage" + sep_n;
    msg += airTagIds + sep_b;                               // airTagIds
    msg += bgImgName + sep_b;                               // bgImgName
    msg += bgImgLeftPos + sep_b;                            // bgImgLeftPos
    msg += bgImgTopPos + sep_b;                             // bgImgTopPos
    msg += bgImgWidth + sep_b;                              // bgImgWidth
    msg += bgImgHeight + sep_b;                             // bgImgHeight
    send(msg);
}

// 56
function setAirTagIconImage(airTagIds, iconImgName, iconImgLeftPos, iconImgTopPos, iconImgWidth, iconImgHeight, iconMarginLeft, iconMarginTop) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setAirTagIconImage" + sep_n;
    msg += airTagIds + sep_b;                               // airTagIds
    msg += iconImgName + sep_b;                             // iconImgName
    msg += iconImgLeftPos + sep_b;                          // iconImgLeftPos
    msg += iconImgTopPos + sep_b;                           // iconImgTopPos
    msg += iconImgWidth + sep_b;                            // iconImgWidth
    msg += iconImgHeight + sep_b;                           // iconImgHeight
    msg += iconMarginLeft + sep_b;                          // iconMarginLeft
    msg += iconMarginTop + sep_b;                           // iconMarginTop
    send(msg);
}

// 57
function setAirTagText(airTagIds, text, textMarginLeft, textMarginTop, fontColor, fontSize) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setAirTagText" + sep_n;
    msg += airTagIds + sep_b;                               // airTagIds
    msg += text + sep_b;                                    // text
    msg += textMarginLeft + sep_b;                          // textMarginLeft
    msg += textMarginTop + sep_b;                           // textMarginTop
    msg += fontColor + sep_b;                               // fontColor
    msg += fontSize + sep_b;                                // fontSize
    send(msg);
}

// 58
function setAirTagAnchorType(airTagIds, anchorType) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setAirTagAnchorType" + sep_n;
    msg += airTagIds + sep_b;                               // airTagIds
    msg += anchorType + sep_b;                              // anchorType
    send(msg);
}

// 59
function setAirTagViewType(airTagIds, viewType) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setAirTagViewType" + sep_n;
    msg += airTagIds + sep_b;                               // airTagIds
    msg += viewType + sep_b;                                // viewType
    send(msg);
}

// 60
function setAirTagVisible(airTagIds, visible) {
    var msg = "";

    if (airTagIds == null) {
        airTagIds = "-1";
    }
    msg += "Command" + sep_n;
    msg += "setAirTagVisible" + sep_n;
    msg += airTagIds + sep_b;                               // airTagIds
    msg += visible + sep_b;                                 // visible
    send(msg);
}

// 61
function deleteAirTag(airTagIds) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "deleteAirTag" + sep_n;
    msg += airTagIds + sep_b;                               // airTagIds
    console.log("delete air tag !!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    send(msg);
}

// 62
function setSpeedAngle(speed) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setSpeedAngle" + sep_n;
    msg += speed + sep_b;                                   // speed
    send(msg);
}

// 63
function setControlLock(lockCamera, lockObjectTouch) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setControlLock" + sep_n;
    msg += lockCamera + sep_b;                              // lockCamera
    msg += lockObjectTouch + sep_b;                         // lockObjectTouch
    send(msg);
}

// 64
function setOutlineVisible(bVisible) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setOutlineVisible" + sep_n;
    msg += bVisible + sep_b;                                // bVisible
    send(msg);
}

// 65
function setOutlineWidth(width) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setOutlineWidth" + sep_n;
    msg += width + sep_b;                                   // width
    send(msg);
}

// 66
function setOutlineColor(color) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setOutlineColor" + sep_n;
    msg += color + sep_b;                                   // color
    send(msg);
}

// 67
function setDefaultOutline(color, thick) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setDefaultOutline" + sep_n;
    msg += color + sep_b;                                   // color
    msg += thick + sep_b;                                   // thick
    send(msg);
}

// 68
function setObjectOutline(ids, color, width) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setObjectOutline" + sep_n;
    msg += ids + sep_b;                                     // ids
    msg += color + sep_b;                                   // color
    msg += width + sep_b;                                   // width
    send(msg);
}

// 69
function setObjectOriginalOutline(ids) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setObjectOriginalOutline" + sep_n;
    msg += ids + sep_b;                                     // ids
    send(msg);
}

// 70
function setObjectColor(ids, color) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setObjectColor" + sep_n;
    msg += ids + sep_b;                                     // ids
    msg += color + sep_b;                                   // color
    send(msg);
}

// 71
function setObjectTransparency(ids, alpha) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setObjectTransparency" + sep_n;
    msg += ids + sep_b;                                     // ids
    msg += alpha + sep_b;                                   // alpha
    send(msg);
}

// 72
function setDeviceVisible(deviceTypes, bVisible) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setDeviceVisible" + sep_n;
    msg += deviceTypes + sep_b;                             // deviceTypes
    msg += bVisible + sep_b;                                // bVisible
    send(msg);
}

// 73
function setObjectOriginalColor(ids) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setObjectOriginalColor" + sep_n;
    msg += ids + sep_b;                                     // ids
    send(msg);
}

// 74
function activateView(bActive) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "activateView" + sep_n;
    msg += bActive + sep_b;                                 // bActive true, false
    send(msg);
}

// 75
function lockPinchEvent(pinchZoom, pinchAngle) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "lockPinchEvent" + sep_n;
    msg += pinchZoom + sep_b;                               // pinchZoom
    msg += pinchAngle + sep_b;                              // pinchAngle
    send(msg);
}

// 76
function setLodEnabled(enabled) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setLodEnabled" + sep_n;
    msg += enabled + sep_b;                                 // enabled true, false
    send(msg);
}

// 77
function setPoiTouchRatio(touchratio) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setPoiTouchRatio" + sep_n;
    msg += touchratio + sep_b;                              // touchratio
    send(msg);
}

// 82
function setZoomInOut(zoom) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setZoomInOut" + sep_n;
    msg += zoom + sep_b;                                // camera zoom in/out
    send(msg);
}

// 83
function start_websocket_msg() {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "start_websocket" + sep_n;
    send(msg);
}

// 84
function close_websocket_msg() {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "close_websocket" + sep_n;
    send(msg);
}

// 85
function set_resolution_msg(width, height) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "set_resolution" + sep_n;
    msg += width + sep_b;                               // width
    msg += height + sep_b;                              // height
    send(msg);
}

// 86
function set_frame_count(frame) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "set_frame_count" + sep_n;
    msg += frame + sep_b;                               // frame
    send(msg);
}

// 87
function set_graphic_quality(quality) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "set_graphic_quality" + sep_n;
    msg += quality + sep_b;                               // quality
    send(msg);
}

// 88
function createViewArea(id, color, radius, height, angle, angle_icon_height, angle_icon_size, angle_icon_visible, viewtype) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "createViewArea" + sep_n;
    msg += id + sep_b;                                   // id
    msg += color + sep_b;                                // color
    msg += radius + sep_b;                               // radius
    msg += height + sep_b;                               // height
    msg += angle + sep_b;                               // angle
    msg += angle_icon_height + sep_b;                               // angle_icon_height
    msg += angle_icon_size + sep_b;                               // angle_icon_size
    msg += angle_icon_visible + sep_b;                               // angle_icon_visible
    msg += viewtype + sep_b;                               // viewtype
    send(msg);
}

// 88
function setViewAreaColor(id, color) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setViewAreaColor" + sep_n;
    msg += id + sep_b;                                   // id
    msg += color + sep_b;                                // color
    send(msg);
}

// 89
function setViewAreaPosition(id, pos_x, pos_y, pos_z) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setViewAreaPosition" + sep_n;
    msg += id + sep_b;                                      // id
    msg += pos_x + sep_b;                                   // pos_x
    msg += pos_y + sep_b;                                   // pos_y
    msg += pos_z + sep_b;                                   // pos_z
    send(msg);
}

// 90
function setViewAreaPositionByPoiId(id, poiId, offset_pos_x, offset_pos_y, offset_pos_z) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setViewAreaPositionByPoiId" + sep_n;
    msg += id + sep_b;                                      // id
    msg += poiId + sep_b;                                   // id
    msg += offset_pos_x + sep_b;                            // pos_x
    msg += offset_pos_y + sep_b;                            // pos_y
    msg += offset_pos_z + sep_b;                            // pos_z
    send(msg);
}

// 91
function setViewAreaVisible(id, visible) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setViewAreaVisible" + sep_n;
    msg += id + sep_b;                                      // id
    msg += visible + sep_b;                                 // visible
    send(msg);
}

// 91
function setViewAreaViewType(id, viewtype) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "setViewAreaViewType" + sep_n;
    msg += id + sep_b;                                      // id
    msg += viewtype + sep_b;                                 // angle_viewtype
    send(msg);
}

// 92
function deleteViewArea(id) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "deleteViewArea" + sep_n;
    msg += id + sep_b;                                      // id
    send(msg);
}

// 93
function getViewAreaPosition(id, angle, length) {
    var msg = "";

    msg += "Command" + sep_n;
    msg += "getViewAreaPosition" + sep_n;
    msg += id + sep_b;                                      // id
    msg += angle + sep_b;                                   // id
    msg += length + sep_b;                                  // id
    send(msg);
}


function DelNode_AirTag(type, node) {

	if(!isdefined(node.poi)) {
		return;
	}
	// 카운트가 0 일 경우 삭제 처리
	for(var i = 0; i < s_AirTag_NodeList.length; i++) {
		var airnode = s_AirTag_NodeList[i];

		if(airnode.type == type && airnode.poi_id == node.poi.poiId) {

			s_AirTag_NodeList.splice(i, 1);
			s_AirTagHelper.delete(airnode.airTagId);
			break;
		}
	}
}

function stCameraData(scene_id, angle, rotation, zoom, camera_x, camera_y, camera_z, target_x, target_y, target_z) {

	this.scene_id = scene_id;

	this.angle = angle;
	this.rotation = rotation;
	this.zoom = zoom;

	this.camera_x = camera_x;
	this.camera_y = camera_y;
	this.camera_z = camera_z;

	this.target_x = target_x;
	this.target_y = target_y;
	this.target_z = target_z;
}

//----------------------------------------------------------------------------------------------------------
//
//
//      [ api test ] 
//
//
//----------------------------------------------------------------------------------------------------------
// 0
function onclick_setMapDataPath() {
    setMapDataPath("data_path");
}

// 1
function onclick_setProjectId() {
    setProjectId("PRJ000203");
}

// 2
function onclick_setZoomRange() {
    setZoomRange(30, 1300);
}

// 3
var s_bDebugMode = "true";

function onclick_setDebugMode() {
    if (s_bDebugMode == "true") {
        s_bDebugMode = "false";
    }
    else {
        s_bDebugMode = "true";
    }
    setDebugMode(s_bDebugMode);
}

// 4
var s_loadMap_0 = "SCN000001";
function onclick_loadMap() {
    if (s_loadMap_0 == "SCN000001") {
        s_loadMap_0 = "SCN000002";
    }
    else {
        s_loadMap_0 = "SCN000001"
    }
    loadMap(s_loadMap_0);
}

// 5
var s_map_id = "";

function onclick_loadMapByPosition() {
    if (s_map_id == "SCN000001") {
        s_map_id = "SCN000002";
    }
    else {
        s_map_id = "SCN000001"
    }
    loadMapByPosition(s_map_id, 20, 0, 20);
}

// 6
function onclick_moveMap() {
    moveMap(10, 10, 0);
}

// 7
function onclick_getCurrentMapId() {
    getCurrentMapId();
}

// 8
function onclick_initializeMap() {
    initializeMap();
}

// 9
function onclick_setBackgroundColor() {
    setBackgroundColor("#FF0000");
}

// 10
var s_camera_angle = 0;
function onclick_setCameraAngle() {
    s_camera_angle += 30;
    s_camera_angle = s_camera_angle % 90;
    setCameraAngle(s_camera_angle);
}

// 11
var s_camera_rotation = 0;
function onclick_setCameraRotation() {
    s_camera_rotation += 40;
    s_camera_rotation = s_camera_rotation % 360;
    setCameraRotation(s_camera_rotation);
}

// 12
var s_camera_zoom = 500;
function onclick_setCameraZoom() {
    s_camera_zoom += 10;
    setCameraZoom(s_camera_zoom);
}

// 13 
var s_showPoiById = "true";

function onclick_showPoiById() {
    if (s_showPoiById == "true") {
        s_showPoiById = "false";
    }
    else {
        s_showPoiById = "true";
    }
    showPoiById(s_showPoiById, "-1");
}

// 14
var s_showRoute = "false";
function onclick_showRoute() {
    if (s_showRoute == "true") {
        s_showRoute = "false";
    }
    else {
        s_showRoute = "true";
    }
    showRoute(s_showRoute);
}

// 15
function onclick_addRoutingPath() {
    var pos_array =
    [
        // [x]  [y]  [z]
        [20.0, 0.0, 45.0],  // [0]
        [31.0, 0.0, 45.0],  // [1]
        [31.0, 0.0, 38.0],  // [2]
        [31.0, 0.0, 28.0],  // [3]
        [31.0, 0.0, -2.0],  // [4]
        [26.0, 0.0, -2.0]   // [5]
];

    addRoutingPath(0.8, "FF0000", 0.4, -0.4, 0.0, "4D4D4D", 0.025, 0.02, pos_array);
}

// 16
function onclick_cleanRoutingPath() {
    cleanRoutingPath();
}

// 17
function onclick_addDynamicPoi() {
    addDynamicPoi("0", -13.3, 2.24, 51.77, 21, 11, 77, 90, "all_128_128.png", "3d", "64_2");
}

// 18
var s_bshowDynamicPoi = true;
function onclick_showDynamicPoi() {
    if (s_bshowDynamicPoi == "true") {
        s_bshowDynamicPoi = "false";
    }
    else {
        s_bshowDynamicPoi = "true";
    }
    showDynamicPoi(s_bshowDynamicPoi, "0");
}

// 19
function onclick_setPositionDynamicPoi() {
    setPositionDynamicPoi("0", 50, 1.4, 0);
}

// 20
var s_setTypeDynamicPoi = "2d";
function onclick_setTypeDynamicPoi() {
    if (s_setTypeDynamicPoi == "2d") {
        s_setTypeDynamicPoi = "3d";
    }
    else {
        s_setTypeDynamicPoi = "2d";
    }
    setTypeDynamicPoi("0", s_setTypeDynamicPoi);
}

// 21
var s_setTypePoi = "2d";
function onclick_setTypePoi() {
    if (s_setTypePoi == "2d") {
        s_setTypePoi = "3d";
    }
    else {
        s_setTypePoi = "2d";
    }
    setTypePoi("POI000001, POI000002, POI000004", s_setTypePoi);
}

// 22
function onclick_getCameraState() {
    getCameraState();
}

// 23
function onclick_setInitCameraParam() {
    setInitCameraParam(60.0, 90.0, 300.0, 1.0, 1700.0);
}

// 24
var s_setTextDynamicPoi = "text_0";
function onclick_setTextDynamicPoi() {
    if (s_setTextDynamicPoi == "text_0") {
        s_setTextDynamicPoi = "text_11";
    }
    else {
        s_setTextDynamicPoi = "text_0";
    }
    setTextDynamicPoi("0", s_setTextDynamicPoi);
}

// 25
var s_setColorTextDynamicPoi = "#FF0000";

function onclick_setColorTextDynamicPoi() {
    if (s_setColorTextDynamicPoi == "#FF0000") {
        s_setColorTextDynamicPoi == "#00FF00";
    }
    else {
        s_setColorTextDynamicPoi == "#FF0000";
    }
    setColorTextDynamicPoi("0", s_setColorTextDynamicPoi);
}

// 26
function onclick_releaseDynamicPoi() {
    releaseDynamicPoi("0");
}

// 27
var s_DynamicPoiAnchor = "bottom";
function onclick_setDynamicPoiAnchor() {
    if (s_DynamicPoiAnchor == "bottom") {
        s_DynamicPoiAnchor = "center";
    }
    else {
        s_DynamicPoiAnchor = "bottom";
    }
    setDynamicPoiAnchor("0", s_DynamicPoiAnchor);
}

// 28
function onclick_directionPressUp() {
    // 1 up, 2 right, 3, down, 4 left
    directionPressUp(1);
}

// 29
function onclick_directionPressDown() {
    // 1 up, 2 right, 3, down, 4 left
    directionPressDown(1);
}

// 30
var s_setLanguageCode = "KO";
function onclick_setLanguageCode() {
    if (s_setLanguageCode == "EN") {
        s_setLanguageCode = "KO";
    }
    else {
        s_setLanguageCode = "EN";
    }
    setLanguageCode(s_setLanguageCode);
}

// 31
var s_setShowPoiColor = 0;
function onclick_setShowPoiColor() {
    setShowPoiColor("-1", "1", "#FF0000");

    if (s_setShowPoiColor == 0) {
        s_setShowPoiColor = 1;
        setShowPoiColor("POI000048", "1", "#FF0000");
    }
    else {
        s_setShowPoiColor = 0;
        setShowPoiColor("POI000048", "0", "#FF5533");
    }
}

// 32
function onclick_setIconToolTipById() {
    setIconToolTipById("0", "POI000048", 1, 1, "FFFFFF", 20, "routepoi_128_128.png", "1", "256,256", "384,384", "320,324", "320,384");
}

// 33
function onclick_setIconToolTipByPosition() {
    var iinterval = 256;
    var itp_left_0 = iinterval * 2;
    var itp_top_0 = iinterval * 2;
    var itp_right_0 = itp_left_0 + iinterval;
    var itp_bottom_0 = itp_top_0 + iinterval;
    var itp_anchor_x_0 = itp_left_0 + iinterval / 2;
    var itp_anchor_y_0 = itp_bottom_0;
    var itp_textpos_x_0 = itp_anchor_x_0 + 20;
    var itp_textpos_y_0 = itp_anchor_y_0 - 80;

    var leftTop = [itp_left_0, itp_top_0];
    var rightBottom = [itp_right_0, itp_bottom_0];
    var AnchorXY = [itp_anchor_x_0, itp_anchor_y_0];
    var TextPos = [itp_textpos_x_0, itp_textpos_y_0];

    setIconToolTipByPosition("1", 5.0, 10.0, 0.0, 1, "#0000FF", 30, "routepoi_128_128.png", "\u260E\nKOREA\nUSAAA", leftTop, rightBottom, TextPos, AnchorXY);
}

// 34
function onclick_changeTextureObject() {

}

// 35
function onclick_releaseIconToolTip() {
    releaseIconToolTip("0");
    releaseIconToolTip("1");
}

// 36
var s_SpeedZoom = 0;
function onclick_setSpeedZoomp() {
    s_SpeedZoom += 10;
    setSpeedZoom(s_SpeedZoom);
}

// 37
function onclick_setCameraTargetPos() {
    setCameraTargetPos(-131.0, 1.34, -91.0);
}

// 38
function onclick_setCameraPos() {
    setCameraPos(-58.549999, 1.49, -77.199997);
}

// 39
function onclick_setCameraPathPos() {
    setCameraPathPos("100", "100", "0", "10", "10", "13");
}

// 40
function onclick_getCameraPosition() {
    getCameraPosition();
}

// 41
var s_bshowPoiIconById = "true";
function onclick_showPoiIconById() {
    if (s_bshowPoiIconById == "true") {
        s_bshowPoiIconById = "false";
    }
    else {
        s_bshowPoiIconById = "true";
    }
    showPoiIconById(s_bshowPoiIconById, "-1");

}

// 42
function onclick_cleanResource() {
    cleanResource();
}

// 43
function onclick_addDynamicPoiByPoiID() {
    addDynamicPoiByPoiID("0", "POI000029", 0, 0, 128, 128, "atlasimage.png", "2d", "0_init");
}

// 44
var s_TouchRotateSpeed = 0;
function onclick_setTouchRotateSpeed() {
    s_TouchRotateSpeed -= 1.5;
    setTouchRotateSpeed(s_TouchRotateSpeed);
}

// 45
var s_PressRotateSpeed = 0;
function onclick_setPressRotateSpeed() {
    s_PressRotateSpeed -= 1.5;
    setPressRotateSpeed(s_PressRotateSpeed);
};

// 46
var s_PressAngleSpeed = 0;
function onclick_setPressAngleSpeed() {
    s_PressAngleSpeed -= 1.5;
    setPressAngleSpeed(s_PressAngleSpeed);
}

// 47
function onclick_create3dObject() {
    create3dObject("0", "information.fbx", "20.0");
}

// 48
function onclick_set3dObjectPosition() {
    set3dObjectPosition("0", 40, 0, 40, 1, 0, 0);
}

// 49
var s_3dObjectViewType = "3d";
function onclick_set3dObjectViewType() {
    if (s_3dObjectViewType == "3d") {
        s_3dObjectViewType = "2d";
    }
    else {
        s_3dObjectViewType = "3d";
    }
    set3dObjectViewType("0", s_3dObjectViewType);
}

// 50
var s_3dObjectVisible = "true";
function onclick_set3dObjectVisible() {
    if (s_3dObjectVisible == "true") {
        s_3dObjectVisible = "false";
    }
    else {
        s_3dObjectVisible = "true";
    }
    set3dObjectVisible("0", s_3dObjectVisible);
}

// 51
function onclick_delete3dObject() {
    delete3dObject("0");
}

// 52
function onclick_createAirTag() {
    createAirTag("0");
    createAirTag("1");
}

// 53
function onclick_setAirTagPosition() {
    setAirTagPosition("0", 0, 20, 0);
    setAirTagPosition("1", 10, 20, 10);
}

// 54
function onclick_setAirTagPositionByPoiId() {
    setAirTagPositionByPoiId("0", "POI000001");
    setAirTagPositionByPoiId("1", "POI000003");
}

// 55
function onclick_setAirTagBgImage() {
    setAirTagBgImage("0", "poi_64_64.png", 0, 0, 256, 256);
    setAirTagBgImage("1", "poi_64_64.png", 0, 0, 256, 256);
}

// 56
function onclick_setAirTagIconImage() {
    setAirTagIconImage("0", "poi_64_64.png", 256, 0, 64, 64, 170, 80);
    setAirTagIconImage("1", "poi_64_64.png", 256, 0, 64, 64, 170, 80);
}

// 57
var s_setAirTagTex = 0;
function onclick_setAirTagText() {
    if (s_setAirTagTex == 0) {
        setAirTagText("0", "text_0_TTTT", 175, 85, "#FFFF00FF", 40);
        setAirTagText("1", "text_0", 175, 85, "#FFFF00FF", 40);
        s_setAirTagTex = 1;
    }
    else {
        setAirTagText("0", "text_1_XXXXX", 175, 85, "#FF0000FF", 20);
        setAirTagText("1", "text_2_YYYYY", 175, 85, "#FF0000FF", 20);
        s_setAirTagTex = 0;
    }
}

// 58
var s_AirTagAnchorType = "bottom";
function onclick_setAirTagAnchorType() {
    if (s_AirTagAnchorType == "bottom") {
        s_AirTagAnchorType = "center";
    }
    else {
        s_AirTagAnchorType = "bottom";
    }
    setAirTagAnchorType("0", s_AirTagAnchorType);
    setAirTagAnchorType("1", s_AirTagAnchorType);
}

// 59
var s_AirTagViewType = "3d";

function onclick_setAirTagViewType() {
    if (s_AirTagViewType == "3d") {
        s_AirTagViewType = "2d";
    }
    else {
        s_AirTagViewType = "3d";
    }
    setAirTagViewType("0", s_AirTagViewType);
    setAirTagViewType("1", s_AirTagViewType);
}

// 60
var s_bAirTagVisible = "true";

function onclick_setAirTagVisible() {
    if (s_bAirTagVisible == "true") {
        s_bAirTagVisible = "false";
    }
    else {
        s_bAirTagVisible = "true";
    }
    setAirTagVisible("0", s_bAirTagVisible);
    setAirTagVisible("1", s_bAirTagVisible);
}

// 61
function onclick_deleteAirTag() {
    deleteAirTag("0");
    deleteAirTag("1");
}

// 62
var s_SpeedAngle = 0;
function onclick_setSpeedAngle() {
    s_SpeedAngle += 10;

    setSpeedAngle(s_SpeedAngle);
}

// 63
var s_blockCamera = "true";
var s_blockObjectTouch = "true";
function onclick_setControlLock() {
    if (s_blockCamera == "true") {
        s_blockCamera = "false";
    }
    else {
        s_blockCamera = "true";
    }

    if (s_blockObjectTouch == "true") {
        s_blockObjectTouch = "false";
    }
    else {
        s_blockObjectTouch = "true";
    }

    setControlLock(s_blockCamera, s_blockObjectTouch);
}

// 64
var s_bOutlineVisible = "true";

function onclick_setOutlineVisible() {
    if (s_bOutlineVisible == "true") {
        s_bOutlineVisible = "false";
    }
    else {
        s_bOutlineVisible = "true";
    }
    setOutlineVisible(s_bOutlineVisible);
}

// 65
var s_setOutlineWidth = 0.1;
function onclick_setOutlineWidth() {
    s_setOutlineWidth += 0.1;
    setOutlineWidth(s_setOutlineWidth);
}

// 66
var s_OutlineColor = "#FF0000";
function onclick_setOutlineColor() {
    if (s_OutlineColor == "#FF0000") {
        s_OutlineColor = "#00FF00";
    }
    else {
        s_OutlineColor = "#FF0000";
    }
    setOutlineColor(s_OutlineColor);
}

// 67
function onclick_setDefaultOutline() {
    setDefaultOutline("#FF0000", 0.1);
}

// 68
function onclick_setObjectOutline() {
    setObjectOutline("seo_977476558", "#FF0000", 0.3);
}

// 69
function onclick_setObjectOriginalOutline() {
    setObjectOriginalOutline("seo_977476558");
}

// 70
function onclick_setObjectColor() {
    setObjectColor("seo_977489290", "#FFFF00AA");
    setObjectColor("seo_977476558", "#00FFFFAA");
    setObjectColor("seo_975609740", "#00FF00AA");
    setObjectColor("seo_975532220", "#00FF00AA");
    setObjectColor("seo_975371415", "#FF000077");

    setObjectColor("poo_988139098", "#FFFF00AA");
}

// 71
var s_ObjectTransparency = 255;
function onclick_setObjectTransparency() {
    // 0 - 255
    s_ObjectTransparency -= 40;
    setObjectTransparency("seo_977476558", s_ObjectTransparency);
    setObjectTransparency("seo_975609740", s_ObjectTransparency);
}

// 72
var s_bDeviceVisible = "true";
var s_countDeviceVisible = 0;
function onclick_setDeviceVisible() {
    // beacon, ap, cctv
    if (s_bDeviceVisible == "true") {
        s_bDeviceVisible = "false";
    }
    else {
        s_bDeviceVisible = "true";
    }

    if (s_countDeviceVisible == 0) {
        setDeviceVisible("beacon", s_bDeviceVisible);
        s_countDeviceVisible++;
    }
    else if (s_countDeviceVisible == 1) {
        setDeviceVisible("ap", s_bDeviceVisible);
        s_countDeviceVisible++;
    }

    else if (s_countDeviceVisible == 2) {
        setDeviceVisible("cctv", s_bDeviceVisible);
        s_countDeviceVisible = 0;
    }
}

// 73
function onclick_setObjectOriginalColor() {
    setObjectOriginalColor("0");
}

// 74
var s_activateView = "true";
function onclick_activateView() {
    if (s_activateView == "true") {
        s_activateView = "false";
    }
    else {
        s_activateView = "true";
    }
    activateView(s_activateView);
}

// 75
var s_bpinchZoom = "true";
var s_bpinchAngle = "true";

function onclick_lockPinchEvent() {
    if (s_bpinchZoom == "true") {
        s_bpinchZoom = "false";
    }
    else {
        s_bpinchZoom = "true";
    }

    if (s_bpinchAngle == "true") {
        s_bpinchAngle = "false";
    }
    else {
        s_bpinchAngle = "true";
    }
    lockPinchEvent(s_bpinchZoom, s_bpinchAngle);
}

// 76
var s_LodEnabled = "true";
function onclick_setLodEnabled() {
    if (s_LodEnabled == "true") {
        s_LodEnabled = "false";
    }
    else {
        s_LodEnabled = "true";
    }
    setLodEnabled(s_LodEnabled);
}

// 77
var s_PoiTouchRatio = 1.0;
function onclick_setPoiTouchRatio() {
    s_PoiTouchRatio += 1.0;
    setPoiTouchRatio(s_PoiTouchRatio);
}

function fn_clearAirTag(){
	s_AirTagHelper.clear();
}

function craneInfo() {
    this.crane_id = "";
    this.coord_x = '';
    this.coord_y = '';
    this.coord_z = '';
}

function fn_refreshAirTag(menu, svrTagList, svrPoiList, isMainBuilding) {
	
	if(isEmpty(s_AirTagHelper))
	{
		return ;
	}
	
	if(g_currentMenu != menu) {
		console.log("currentMenu=" + g_currentMenu + ", callMenu=" + menu);
		return ;
	}
	
	if(g_isLoadingMap) {
		console.log("LOADING >>>>>>>> MAP");
		return ;
	}

	s_AirTagHelper.refreshAirtags(svrTagList, svrPoiList, isMainBuilding);
}


function fn_refreshGateWorkerCount(count, isMainBuilding)
{
	if(isEmpty(s_AirTagHelper))
	{
		return ;
	}
	
	if(isMainBuilding)
	{
		s_AirTagHelper.refreshGateWorker(count);
	}
	else
	{
		s_AirTagHelper.deleteGateWorker();
	}
}

function fn_visibleAirTags(airtagType, visible) {
	
	if(!isEmpty(s_AirTagHelper))
		s_AirTagHelper.setAirTagVisible(airtagType, visible);
}

function fn_makeTowerCrane(crane, baseHeight, render_queue) {

	if(!isEmpty(s_AirTagHelper))
		s_AirTagHelper.createTowercrane(crane, baseHeight, render_queue);
}

function fn_updateTowerCrane(crane, poiId, yaw, pitch, render_queue) {
	
	if(g_currentMenu != MENU_TYPE.CRANE) {
		return ;
	}
	
	var baseHeight = 2;
	if(!isEmpty(s_AirTagHelper)){
		var airTc = s_AirTagHelper.getTc(crane.device_no);
		if( null == airTc) {
			s_AirTagHelper.createTowercrane(crane, baseHeight, render_queue);
		} else {
			if(airTc.crane_type == crane.crane_type) {
				s_AirTagHelper.updateTowerCrane(crane.device_no, poiId, yaw, pitch, render_queue);
			} else {
				s_AirTagHelper.releasTc();
				airTc.crane_type = crane.crane_type;
				deleteTowercrane(crane.device_no);
				s_AirTagHelper.createTowercrane(crane, baseHeight, render_queue);
			}
		}
	}
}

function fn_touchCrane(cellId){
	$.ajax({
		url : "${pageContext.request.contextPath}/selectCrane.json?cellId="+cellId,
		type : "GET",
		success : function(result) {
			if(result.resultCode == "success"){
				alert(result.craneResultVO.device_no);
			}else{
				openDefaultPopup("loginPopup", result.message);
			}
		}
	});
}

//------------------------------------------------------------
//맵 변경
//------------------------------------------------------------
function ChangeScene(scene_id) {
		
	if(null == scene_id) {
		fn_closeLoadingPopup();
	}
	
	if(s_AirTagHelper != null) {
		s_AirTagHelper.clear();
		console.log("CLEAR ALL AIR TAG....................[SUCC]");
	}

		
	if( null != scene_id && (g_ChgSceneId != "" && g_ChgSceneId == scene_id)){
		console.log("ChangeScene. SAME >>> scene_id=" + scene_id + ", g_ChgSceneId=" + g_ChgSceneId);
		return;
	}
	
	g_ChgSceneId = scene_id;

	fn_getMapViewInfo(scene_id);
 // 로드
}

function ChangeScene2(scene_id) {
	
	if(null == scene_id) {
		fn_closeLoadingPopup();
	}
		
	g_ChgSceneId = scene_id;

	if(s_AirTagHelper != null)
		s_AirTagHelper.clear();
	
	fn_getMapViewInfo(scene_id);
 // 로드
}


function fn_getMapViewInfo(scene_id){
	
	g_mapView = null;
	
	var params = "scene_id=" + scene_id;
	
	if(scene_id == "") {
		console.log("fn_getMapViewInfo. scene_id=null");
		return ;
	}
	
	$.ajax({
		url : "/click/getMapViewInfo.json",
		type : "POST",
		data: params,
		success : function(result) {
			if(result.resultCode == "success"){
				g_mapView = result.mapView;				
			}
			
			setTimeout(function() {
				console.log('loadMaploadMap. scene_id=' + scene_id);
				
				loadMap(scene_id);
			}, 1000);
			
		}
	});
}


function nvl(obj){
	return obj;
}

function createTowercrane(id, x, y, z, radiusIn, radiusOut, heightIn, heightOut, colorIn, colorOut, barAngle, barRadius, barBackRadius, barThickness, barHeight, barColor, render_queue) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "createTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += x + sep_b;                                       // x
    msg += y + sep_b;                                       // y
    msg += z + sep_b;                                       // z
    msg += radiusIn + sep_b;                                // radiusIn
    msg += radiusOut + sep_b;                               // radiusOut
    msg += heightIn + sep_b;                                // heightIn
    msg += heightOut + sep_b;                               // heightOut
    msg += colorIn + sep_b;                                 // colorIn
    msg += colorOut + sep_b;                                // colorOut
    msg += barAngle + sep_b;                                // barAngle
    msg += barRadius + sep_b;                               // barRadius
    msg += barBackRadius + sep_b;                           // barBackRadius
    msg += barThickness + sep_b;                            // barThickness
    msg += barHeight + sep_b;                               // barHeight
    msg += barColor + sep_b;                                // barColor
    msg += render_queue + sep_b;                            // render_queue
    send(msg);
}
// 95
function setRadiusInTowercrane(id, radius) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "setRadiusInTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += radius + sep_b;                                  // radius
    send(msg);
}
// 96
function setRadiusOutTowercrane(id, radius) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "setRadiusOutTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += radius + sep_b;                                  // radius
    send(msg);
}
// 97
function setColorInTowercrane(id, color) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "setColorInTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += color + sep_b;                                   // color
    send(msg);
}
// 98
function setColorOutTowercrane(id, color) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "setColorOutTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += color + sep_b;                                   // color
    send(msg);
}
// 99
function setBarAngleTowercrane(id, angle) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "setBarAngleTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += angle + sep_b;                                   // angle
    send(msg);
}
// 100
function setBarRadiusTowercrane(id, radius) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "setBarRadiusTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += radius + sep_b;                                  // radius
    send(msg);
}
// 101
function setBarBackRadiusTowercrane(id, radius) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "setBarBackRadiusTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += radius + sep_b;                                  // radius
    send(msg);
}
// 102
function setBarColorTowercrane(id, color) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "setBarColorTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += color + sep_b;                                   // color
    send(msg);
}
// 103
function deleteTowercrane(id) {
	
    var msg = "";
    msg += "Command" + sep_n;
    msg += "deleteTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    send(msg);
}
// 104
function setVisibleTowercrane(id, bvisible) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "setVisibleTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += bvisible + sep_b;                                // bvisible
    send(msg);
}
// 105
function setViewTypeTowercrane(id, ViewType) {
    var msg = "";
    msg += "Command" + sep_n;
    msg += "setViewTypeTowercrane" + sep_n;
    msg += id + sep_b;                                      // id
    msg += ViewType + sep_b;                                // ViewType
    send(msg);
}
