var socket = null;
var connectSocket = false;
var s_timerId_Mapdownload = 0;


// websocket은 브라우저와 유니티 통신 
// 만약 실패하면 websocket은 페이지 재로딩 방식으로 다시 접속 
function start_websocket() {

    console.log("start_websocket");

    socket = new WebSocket('ws://127.0.0.1:4649/Laputa');

    socket.binaryType = 'arraybuffer';

    var key_value = sessionStorage.getItem('dashboard_page');
    if (isdefined(key_value)) {
        if (key_value == "true") {
        }
        else {

        }
    }
    else {
        waitForSocketConnection(socket, function (msg) { sendmessage(msg); });
    }

    // onopen이 되었다는 것은 유니티와 브라우저가 웹소켓을 통해서 붙었다는 이야기임. 
    socket.onopen = function () {
         
             console.log("socket.onopen");

        connectSocket = true;

        localStorage.setItem('count_connect_mapviewer', 0);

        var key_value = sessionStorage.getItem('dashboard_page');

        // 대시보드라는 키값을 이용해서 로그인페이지를 제외한 다른 페이지에서 다시
        // 유니티가 있는 페이지로 올 때에, 유니티에 대한 처리를 하려면 아래의
        // loadMap있는 위치에서 코딩을 해야 한다.  
        if (isdefined(key_value)) {
            if (key_value == "true") {

                s_bLoadScene = true;

                // 해당 페이지유니티 시작해서 처음 API 사용가능한 위치 
                //setInitCameraParam(50.51357, -4.07246, 1332.427, 1, 1500);
                loadMap("SCN000008");

                //-----------------------------------------------------------------------------
                // AtlasHelper 사용법 : 라임아이에서 만든 POI 제어 클래스
                //-----------------------------------------------------------------------------

                if (s_AirTagHelper == null) {
                    s_AirTagHelper = new AirTagHelper;

                    // setup
                    s_AirTagHelper.setup();
                }
            }
        }
    }

    socket.onmessage = handleReceive;

    socket.onclose = function (event) {

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

        if (socket) {
            //Debug_Log("Socket.OnClose: Disconnected.<br>", "gray");
        }

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
        if(event.code == 1006){
        	post_msg_sync_btos("msg_send_mapviewer_exe_btos", "00");
            ////console.log('event.code 1006');
            //movePageMain("/view/map/worker.html");
            //location.href = "/view/main.html";
        	start_websocket();
        	return false;
        }

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

function sendmessage(msg) {
    try {
        send("connect");

        init_map();
    }
    catch (ex) {
    }
}

function send(msg) {
    if (isdefined(socket)) {
        socket.send(msg);
    }
}


// 확인
function stop_websocket() {
    if (socket) {
        socket.close();
    }
}


function handleReceive(message) {

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

//------------------------------------------------------------
//
// 유니티에서 맵 로딩 성공시 호출되는 콜백 함수
//
//------------------------------------------------------------
var g_bOneEntyrLoadMap = false;

function on_loadmap(result_code, result_ms) {

    sessionStorage.setItem('dashboard_page', "");
    
    s_bLoadScene = true;

    //Debug_Log_Msg("on_loadmap");
    Debug_Log_Msg("s_success_poi_info : "+s_success_poi_info);

    setControlLock("false", "false");
    
    if (s_success_poi_info) {

        on_final_load();
    }
    else {
        on_check_load();
    }

    //TEST
    s_AirTagHelper.showWorker('POI000016', 300, WORKER_COLOR.RED, 'worker');

    
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
    
    // -----------------------------------------------------------------------------
	// 메시지 처리
	// -----------------------------------------------------------------------------
    //console.log(' ******on_final_load s_array_msg_scene_onload.length : '+s_array_msg_scene_onload.length);
    if(isdefined(s_array_msg_scene_onload)){
    	for(var i = 0; i < s_array_msg_scene_onload.length; i++) {
    		var stmsg = s_array_msg_scene_onload[i];

    		switch(stmsg.msg) {
    			case 'msg_worker_pos':
    				clear_AirTags();

    				var poi_id = stmsg.param_0;
    				console.log(' ******on_final_load poi_id : '+poi_id);
    				s_AirTagHelper.showMyPosition(poi_id);

    				var info = getPoiInfo(poi_id);
    				if(info != null) {
    					moveMap(info.posX, info.posY, info.posZ);
    				}
    				break;
    		}
    	}
    }
	

	if(s_array_msg_scene_onload) {
		s_array_msg_scene_onload.length = 0;
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

//------------------------------------------------------------
//리소스 클린 콜백 함수
//------------------------------------------------------------
function on_cleanResource() {

}

//------------------------------------------------------------
//터치시 콜백 함수
//------------------------------------------------------------
function on_onObjectTouched(objType, objId) {

 if (!IsLoadScene()) {
     return;
 }
 console.log('$$ on_onObjectTouched objId : '+objId);
 // 터치
 switch (objType) {
     case "AIRTAG":
         {
             var airtag = s_AirTagHelper.getTag(objId);
             console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@###"+airtag.poiId);
             var hTouchInfo = GetTouchInfo_FromPoiID(airtag.poiId);
//             console.log('$$ on_onObjectTouched airtag.poiId : '+airtag.getPoiID());
//             console.log('$$ on_onObjectTouched airtag.poiId : '+airtag.getApID());
             
             console.log(airtag.getPoiID());
           //  moveMap();
             if (airtag) {

                 var obj_type = "";
                 var bChangeScene = false;
                 if (objId.indexOf("SENSOR_") != -1) {
                     obj_type = "SENSOR"
                 }

                 if (objId.indexOf("AP_") != -1) {
                     obj_type = "AP"
                     //alert("touch ap");
                 }

                 if (objId.indexOf("WK_") != -1) {
                     bChangeScene = true;
                     obj_type = "WK";
                     console.log("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                     console.log(hTouchInfo.cell_id);
                     
                     //alert("touch work");
                     //click_select_cell(hTouchInfo.cell_id);
                     //set_scene1();
                 }
                 
                 if (objId.indexOf("GAS_") != -1) {
                     bChangeScene = true;
                     obj_type = "GAS";
                     click_select_cell_scene2(hTouchInfo.cell_id);
                     set_scene2();

                 }
                 
                 if (objId.indexOf("STRICTURE_") != -1) {
                     bChangeScene = true;
                     obj_type = "STRICTURE";
                     click_select_cell_scene3(hTouchInfo.cell_id);
                     set_scene3();
                     
                     onClickStricture(hTouchInfo.building_id, hTouchInfo.zone_id, hTouchInfo.cell_id);

                 }
                 
                 if (objId.indexOf("RETAIN_") != -1) {
                     bChangeScene = true;
                     obj_type = "RETAIN"
                     click_select_cell_scene4(hTouchInfo.cell_id);
                     set_scene4();
                     
                     //alert("touch RETAIN hTouchInfo.building_id : "+hTouchInfo.building_id+" hTouchInfo.zone_id : "+hTouchInfo.zone_id+" hTouchInfo.cell_id :"+hTouchInfo.cell_id);
                     onClickRetain(hTouchInfo.building_id, hTouchInfo.zone_id, hTouchInfo.cell_id, airtag.poiId);
                 }
                 
                 if (objId.indexOf("CRANE_") != -1) {
                     bChangeScene = true;
                     obj_type = "CRANE";
                     
                     //fn_touchCrane();
                     
                     //set_scene5();

                 }
                 
                 if (objId.indexOf("ANEMOMETER_") != -1) {
                     bChangeScene = true;
                     obj_type = "ANEMOMETER";
                     click_select_cell_scene6(hTouchInfo.cell_id);
                     if(isdefined(airtag.getApID())){
                     	onClickAnemometer(airtag.getApID());
                     }
                     
                     set_scene6();

                 }

                 if (objId.indexOf("CCTV_") != -1) {
                     obj_type = "CCTV"
                     alert("touch cctv");
                 }

                 if (objId.indexOf("VISIT_") != -1) {
                     obj_type = "VISIT"
                 }

                 if (objId.indexOf("MESSAGE_S_") != -1) {
                     bChangeScene = true;
                     obj_type = "MESSAGE_S"
                 }

                 if (objId.indexOf("MESSAGE_L_") != -1) {
                     bChangeScene = true;
                     obj_type = "MESSAGE_L"

                 }

                 if (objId.indexOf("POSITION_") != -1) {
                     obj_type = "POSITION"
                 }


//                 if (bChangeScene) {
//                 	ChangeScene("");
//                 }
             }
         }
         break;
     case "DEVICE":
         {
             var xx = 0;
         }
         break;
     case "POI":
         {
             var poi_id = objId;


         }
         break;
 }
}

//------------------------------------------------------------
//Poi ID에 의한 로딩 콜백함수
//------------------------------------------------------------
function on_loadMapByPoiID(result_code, result_msg) {

}

//------------------------------------------------------------
//좌표에 의한 맵 로딩 콜백함수
//------------------------------------------------------------
function on_loadMapByCoordinate(result_code, result_msg) {

}

//------------------------------------------------------------
//현재 맵 ID 얻는 콜백 함수
//------------------------------------------------------------
function on_getCurrentMapId(map_id) {

}

//------------------------------------------------------------
//맵 초기 콜백 함수
//------------------------------------------------------------
function on_initializeMap(result_code, result_msg) {

}

//------------------------------------------------------------
//맵 로딩 시작 콜백 함수
//------------------------------------------------------------
function on_onLoadStart() {

}

//------------------------------------------------------------
//카메라 상태 콜백 함수
//------------------------------------------------------------
function on_getCameraState(angle, rotation, zoom) {
//	console.log('on_getCameraState angle :'+angle);
//	console.log('on_getCameraState rotation :'+rotation);
//	console.log('on_getCameraState zoom :'+zoom);
}

//------------------------------------------------------------
//현재 카메라 정보 콜백 함수
//------------------------------------------------------------
function on_getCameraPosition(vCameraPos_x, vCameraPos_y, vCameraPos_z, vTargetPos_x, vTargetPos_y, vTargetPos_z) {
//	console.log('!!!on_getCameraPosition vCameraPos_x :'+vCameraPos_x);
//	console.log('!!!on_getCameraPosition vCameraPos_y :'+vCameraPos_y);
//	console.log('!!!on_getCameraPosition vCameraPos_z :'+vCameraPos_z);
//	console.log('!!!on_getCameraPosition vTargetPos_x :'+vTargetPos_x);
//	console.log('!!!on_getCameraPosition vTargetPos_y :'+vTargetPos_y);
//	console.log('!!!on_getCameraPosition vTargetPos_z :'+vTargetPos_z);
}



//동기 :  브라우저 -> 로컬서버 
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


//비동기 : 브라우저 -> 로컬서버 
function post_msg_btos(msg, param) {

	//console.log("post_msg_btos=" + msg + ", param=" + param);

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

//로컬 서버 -> 브라우저를 통해서 메시지 처리 
function onMessage_stob(msg) {

	//console.log("onMessage_stob=" + msg);

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
                         var count_cm_key = localStorage.getItem("count_connect_mapviewer");

                         var count_key = 1;

                         if (isdefined(count_cm_key)) {
                             count_key = parseInt(count_cm_key);
                         }
                         var save_count_key = count_key + 1;

                         localStorage.setItem('count_connect_mapviewer', save_count_key);

                         var interval_time = 3000 * count_key;

                         ////console.log("interval_time = " + interval_time);
                         //-------------------------------------------
                         // end - key
                         //-------------------------------------------

                         s_timerid_connect_mapviewer = setInterval("start_connect_mapviewer()", interval_time);

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

                         s_timerId_Mapdownload = setInterval(function () {
                             post_msg_btos("msg_send_browser_mapdownload_btos", "");
                         }, 1000); // 1초마다 체크
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

//에러 체크 

var count_error = 0;
function on_error_post_msg_btos(msg, param) {

	console.log('on_error_post_msg_btos : '+msg);
}
