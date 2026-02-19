﻿﻿var socket = null;
var first = 1;
var buffer = null;
var imageData = null;
var worker = null;
var utilCntVal = null;
var img = new Image();
var g_ctx = null;
var g_canvas = null; // 2017.12.17
var g_realposx = 0; // 2017.12.17
var g_realposy = 0; // 2017.12.17
var g_realratio = 0; // 2017.12.17
var sep_n = '\\n';
var sep_b = '\\b';

var g_MapServerPort = _url[mode].mapPort;
//var g_MapServerPort = '8348';
var g_GUID_Count_AirTag = 0;
var s_bFirstBuildNode_client = false;
var g_use_old_socket = false;
var g_re_connectsocket = false;
var g_load_img_client = false;
var r_reg_data = '-1';

// ------------------------------------------------------------
// 유니티 해상도 변수
// 해상도 관련 처리
// - 3D지도 확대노출 필요(테스트해상도1920)
// - 1152:720 (브라우저해상도)/ 960: 600(유니티)
// - 1440:900 (브라우저해상도)/ 1152:720(유니티)
// ------------------------------------------------------------
var g_unity_resolution_width = 1152;
var g_unity_resolution_height = 720;


// ------------------------------------------------------------
// 유니티 기본 프레임
// 30 프레임으로 설정
// 100 퀄리티으로 설정
// ------------------------------------------------------------
var g_unity_frame_count = 30;
var g_unity_graphic_quality = 100;


function GetGuidCountAirTag() {
	g_GUID_Count_AirTag += 1;
	return g_GUID_Count_AirTag;
}

var s_url_localserver = 'http://127.0.0.1:9000/';

var canvas_rect = null;
var s_bmouse_down = 0;
var s_mouse_down_id = 0;

var s_timerid_connect = 0;
var s_timerid_connect_mapviewer = 0;
var s_count_websocket_connect_btol = 0;
var s_browser_guid = 0;
var s_bDoubleConnect = 0;

var s_bPageCleanedUp = 0;

var s_bSuccess_MapDownload = 0;
var s_timerId_Mapdownload = 0;

var s_timerid_check_connect_state = 0;

var s_PoiAreaList;
var s_PoiList;


var s_AirTagHelper;
var s_bLoadScene = false;
var s_arrBuilding_Node = null;
var s_AirTag_NodeList = null;

var s_reqMapViewList;

var s_MainSceneID = 'SCN000001';
var s_CurSelZoneID;
var s_CurSelCellID;

var s_ZoneNode;
var s_CellNode;

var s_Array_ObjectTransparency;
var s_Array_PrevObjectTransparency;

var s_Array_ObjectTransparency_Safe;

var s_Array_ObjectTransparency_Em;	// 비상대피구역 색상 표시

var s_array_CameraTable;

var s_success_poi_info = false;
var s_count_fail_poi_info = 0;

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
			location.href = '/html/MainPage.html';
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




// //-----------------------------------------------------------------
// // 검색 필터
// //-----------------------------------------------------------------

// var s_stWorkerFilterInfo;
// function stWorkerFilterInfo() {
// this.iblobl = null; // 인력 구분
// this.construction_id = null; // 공종 아이디
// this.cooperator_id = null; // 협력 업체 아이디
// this.job_id = null; // 직종 아이디
// }

// function GetWorkerFilterInfo() {
// return s_stWorkerFilterInfo;
// }


const LAYER_STATE = {

	BUILDING: 'BUILDING',
	ZONE: 'ZONE',
	CELL: 'CELL',
}

var s_current_layer_state = LAYER_STATE.BUILDING; // BUILDING;

function setLayerState(layer) {
	s_current_layer_state = layer;
	Update_Scene();
}

var s_tableInfo;

function setTableInfo(tableInfo) {
	s_tableInfo = tableInfo;
}


function GetSceneLayout() {
	var layout = 'layer_depth_0';
	switch(s_current_layer_state) {
		case LAYER_STATE.BUILDING:
			layout = 'layer_depth_0';
			break;
		case LAYER_STATE.ZONE:
			layout = 'layer_depth_1';
			break;
		case LAYER_STATE.ZONE:
			layout = 'layer_depth_1';
			break;
	}
	return layout;

}

// -------------------------------------------------------
// 버튼 상태에 따른 표시
// -------------------------------------------------------
const TAB_STATE = {
	AREA_SAFE: 'AREA_SAFE', // 구역 안전 관제
	FOCUS_CONTROL: 'FOCUS_CONTROL', // 중점 관리 구역
	WARNING: 'WARNING', // 위험 경고 현황
	EMERGENCY: 'EMERGENCY' // 비상 대피 구역
}

var s_tab_state = TAB_STATE.AREA_SAFE;

function getTabState() {
	var state;
	switch(s_tab_state) {
		case TAB_STATE.AREA_SAFE:
			state = 'AREA_SAFE';
			break;
		case TAB_STATE.FOCUS_CONTROL:
			state = 'FOCUS_CONTROL';
			break;
		case TAB_STATE.WARNING:
			state = 'WARNING';
			break;
		case TAB_STATE.EMERGENCY:
			state = 'EMERGENCY';
			break;
	}
	return state;
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

function setTabState(state) {
	ClearArrBuilding_Node();
	switch(state) {
		case '0':
			// ---------------------------------------------
			// 구역 안전 관제
			// ---------------------------------------------
			delete_myPosition_client();
			setOrig_ObjectColor();
			clear_AirTags();// 초기화

			// 구역 안전 관제
			s_tab_state = TAB_STATE.AREA_SAFE;

			// 버튼 상태 - 디폴트 상태
			s_bShow_worker = s_bShowOrig_worker = true;
			s_bShow_safe_worker = s_bShowOrig_safe_worker = true;
			s_bShow_cctv = s_bShowOrig_cctv = false;
			s_bShow_sensor = s_bShowOrig_sensor = false;

			s_bShow_all = false;
			// 긴급
			s_bShow_imCall_EventType = false;
			// 가스
			s_bShow_gas = false;
			// 침범
			s_bShow_violation_EventType = false;

			s_bShow_actionStop_EventType = false;
			
			//비상대피구역 메시지박스
			s_bShow_emergency_msg = false;
			break;
		case '1':
			// ---------------------------------------------
			// 중점 관리 구역
			// ---------------------------------------------
			delete_myPosition_client();
			setOrig_ObjectColor();
			clear_AirTags();// 초기화

			// 중점 관리 구역
			s_tab_state = TAB_STATE.FOCUS_CONTROL;

			// 버튼 상태 - 디폴트 상태
			s_bShow_worker = true;
			s_bShow_safe_worker = true;
			s_bShow_cctv = false;
			s_bShow_sensor = false;

			s_bShow_all = false;
			// 긴급
			s_bShow_imCall_EventType = false;
			// 가스
			s_bShow_gas = false;
			// 침범
			s_bShow_violation_EventType = false;

			s_bShow_actionStop_EventType = false;
			
			//비상대피구역 메시지박스
			s_bShow_emergency_msg = false;
			break;
		case '2':
			// ---------------------------------------------
			// 위험 경고 현황
			// ---------------------------------------------
			delete_myPosition_client();
			setOrig_ObjectColor();
			clear_AirTags();

			// 위험 경고 현황
			s_tab_state = TAB_STATE.WARNING;
			// parent.parent.Update_AreaSafe_Waring(s_tableInfo);

			// 버튼 상태
			s_bShow_worker = false;
			s_bShow_safe_worker = false;
			s_bShow_cctv = false;
			s_bShow_sensor = false;

			// 디폴트 상태
			s_bShow_all = true;
			s_bShowOrig_all = true;

			// 긴급
			s_bShowOrig_imCall_EventType = false;
			s_bShow_imCall_EventType = true

			// 가스
			s_bShowOrig_gas = false;
			s_bShow_gas = true;

			// 침범
			s_bShowOrig_violation_EventType = false;
			s_bShow_violation_EventType = true;
			
			//비상대피구역 메시지박스
			s_bShow_emergency_msg = false;
			
			//디바이스
			s_bShowOrig_actionStop_EventType = false;
			s_bShow_actionStop_EventType = true;
			break;
		case '3':
			// ---------------------------------------------
			// 비상 대피 구역
			// ---------------------------------------------
			delete_myPosition_client();
			setOrig_ObjectColor();
			clear_AirTags();// 초기화

			// 비상 대피 구역
			s_tab_state = TAB_STATE.EMERGENCY;

			// 버튼 상태 - 디폴트 상태
			s_bShow_worker = false;
			s_bShow_safe_worker = false;
			s_bShow_cctv = false;
			s_bShow_sensor = false;

			// 디폴트 상태
			s_bShow_all = false;
			
			// 긴급
			s_bShow_imCall_EventType = false;
			
			// 가스
			s_bShow_gas = false;
			
			// 침범
			s_bShow_violation_EventType = false;

			s_bShow_actionStop_EventType = false;
			
			//비상대피구역 메시지박스
			s_bShow_emergency_msg = s_bShowOrig_emergency_msg = true;
			break;
	}
}

// orig show button state
var s_bShowOrig_worker = true;
var s_bShowOrig_safe_worker = true;
var s_bShowOrig_sensor = false;
var s_bShowOrig_cctv = false;

var s_bShowOrig_emergency_msg = false;

var s_bShowOrig_violation_EventType = false;
var s_bShowOrig_imCall_EventType = false;
var s_bShowOrig_actionStop_EventType = false;
var s_bShowOrig_all = true;
var s_bShowOrig_gas = false;
var s_bShowOrig_MyPosition = false;

// interior show button state
var s_bShow_worker = true;
var s_bShow_safe_worker = true;
var s_bShow_sensor = false;
var s_bShow_cctv = false;

var s_bShow_emergency_msg = true;

var s_bShow_violation_EventType = false;
var s_bShow_imCall_EventType = false;
var s_bShow_actionStop_EventType = false;
var s_bShow_all = true;
var s_bShow_gas = false;

function SelectDropDown() {

}

function setBack() {

	// 뒤로
	switch(s_current_layer_state) {
		case LAYER_STATE.BUILDING:
			break;
		case LAYER_STATE.ZONE:
			s_current_layer_state = LAYER_STATE.BUILDING;
			break;
		case LAYER_STATE.CELL:
			g_select_cell_id_in_depth2_sys = '';
			g_select_cell_node_sys = '';
			s_current_layer_state = LAYER_STATE.BUILDING;
			break;

	}

	// 탭 상태에 따른 정보 표시
	switch(s_tab_state) {
		case TAB_STATE.AREA_SAFE:
			// 구역 안전 관제
			s_bShow_worker = s_bShowOrig_worker;
			s_bShow_safe_worker = s_bShowOrig_safe_worker;
			s_bShow_sensor = s_bShowOrig_sensor;
			s_bShow_cctv = s_bShowOrig_cctv;
			break;
		case TAB_STATE.FOCUS_CONTROL:
			// 중점 관리 구역
			break;
		case TAB_STATE.WARNING:
			// 위험 경고 현황
			s_bShow_violation_EventType = s_bShowOrig_violation_EventType;
			s_bShow_imCall_EventType = s_bShowOrig_imCall_EventType;
			s_bShow_actionStop_EventType = s_bShowOrig_actionStop_EventType;
			s_bShow_all = s_bShowOrig_all;
			s_bShow_gas = s_bShowOrig_gas;
			break;
		case TAB_STATE.EMERGENCY:
			s_bShow_emergency_msg = s_bShowOrig_emergency_msg;
			break;
	}

	ChangeScene(s_MainSceneID);

}

function stMsg_onLoadScene(msg, param_0, param_1, param_2) {
	this.msg = msg;
	this.param_0 = param_0;
	this.param_1 = param_1;
	this.param_2 = param_2;
}
var s_array_msg_scene_onload;


function SetWorkerPos(building_id, zone_id, cell_id, poi_id) {

	switch(s_current_layer_state) {
		case LAYER_STATE.BUILDING:
			// zone id로 해당 씬을 찾는다.
			var scene_id = GetSceneID_FromZoneID(zone_id);
			s_CurSelZoneID = zone_id;

			var stmsg = new stMsg_onLoadScene('msg_worker_pos', poi_id, '', '');
			s_array_msg_scene_onload.push(stmsg);

			s_current_layer_state = LAYER_STATE.ZONE;

			ChangeScene(scene_id);
			update_scene_tab_state_sys();
			break;
		case LAYER_STATE.ZONE:
			clear_AirTags();

			var scene_id = GetSceneID_FromZoneID(zone_id);
			ChangeScene(scene_id);
			update_scene_tab_state_sys();

			var stmsg = new stMsg_onLoadScene('msg_worker_pos', poi_id, '', '');
			s_array_msg_scene_onload.push(stmsg);
			break;
		case LAYER_STATE.CELL:
			clear_AirTags();

			var scene_id = GetSceneID_FromZoneID(zone_id);
			ChangeScene(scene_id);
			update_scene_tab_state_sys();

			var stmsg = new stMsg_onLoadScene('msg_worker_pos', poi_id, '', '');
			s_array_msg_scene_onload.push(stmsg);
			break;

	}
}

function setShow_worker(show) {

	s_bShow_worker = show;
	s_bShowOrig_worker = show;

	if(show) {
		s_bShow_sensor = false;
		s_bShowOrig_sensor = false;
	}
	Update_Scene();
}

function setShow_safe_worker(show) {

	s_bShow_safe_worker = show;
	s_bShowOrig_safe_worker = show;

	if(show) {
		s_bShow_sensor = false;
		s_bShowOrig_sensor = false;
	}
	Update_Scene();
}

function setShow_sensor(show) {

	s_bShow_sensor = show;
	s_bShowOrig_sensor = show;

	if(show) {
		s_bShow_worker = false;
		s_bShowOrig_worker = false;

		s_bShow_safe_worker = false;
		s_bShowOrig_safe_worker = false;
	}
	Update_Scene();
}

function setShow_cctv(show) {

	s_bShow_cctv = show;
	s_bShowOrig_cctv = show;

	if(show) {
		s_bShow_worker = false;
		s_bShowOrig_worker = false;

		s_bShow_safe_worker = false;
		s_bShowOrig_safe_worker = false;
	}

	Update_Scene();
}

function setShow_violation_EventType(show) {

	// 침범
	s_bShowOrig_violation_EventType = !s_bShowOrig_violation_EventType;
	s_bShow_violation_EventType = s_bShowOrig_violation_EventType;
	// s_bShowOrig_violation_EventType = show;

	if(show) {
		s_bShow_imCall_EventType = false;
		s_bShowOrig_imCall_EventType = false;

		s_bShow_actionStop_EventType = false;
		s_bShowOrig_actionStop_EventTyp = false;

		s_bShow_gas = false;
		s_bShowOrig_gas = false;

		s_bShow_all = false;
		s_bShowOrig_all = false;
	}

	Update_Scene();
}

function setShow_imCall_EventType(show) {

	console.log('setShow_imCall_EventType show : '+show);
	console.log('setShow_imCall_EventType s_bShow_gas : '+s_bShow_gas);
	console.log('setShow_imCall_EventType s_bShowOrig_gas : '+s_bShowOrig_gas);
	
	// 긴급
	s_bShowOrig_imCall_EventType = !s_bShowOrig_imCall_EventType;
	s_bShow_imCall_EventType = s_bShowOrig_imCall_EventType;
	// s_bShowOrig_imCall_EventType = show;

	if(show) {
		s_bShow_violation_EventType = false;
		s_bShowOrig_violation_EventType = false;

		s_bShow_actionStop_EventType = false;
		s_bShowOrig_actionStop_EventTyp = false;

		s_bShow_gas = false;
		s_bShowOrig_gas = false;

		s_bShow_all = false;
		s_bShowOrig_all = false;
	}

	Update_Scene();
}

function setShow_actionStop_EventType(show) {

	s_bShowOrig_actionStop_EventTyp = !s_bShowOrig_actionStop_EventTyp;
	s_bShow_actionStop_EventType = s_bShowOrig_actionStop_EventTyp;
	// s_bShowOrig_actionStop_EventTyp = show;

	if(show) {
		s_bShow_violation_EventType = false;
		s_bShowOrig_violation_EventType = false;

		s_bShow_imCall_EventType = false;
		s_bShowOrig_imCall_EventType = false;

		s_bShow_gas = false;
		s_bShowOrig_gas = false;

		s_bShow_all = false;
		s_bShowOrig_all = false;
	}

	Update_Scene();
}

function setShow_gas(show) {

	console.log('setShow_gas show : '+show);
	console.log('setShow_gas s_bShow_gas : '+s_bShow_gas);
	console.log('setShow_gas s_bShowOrig_gas : '+s_bShowOrig_gas);
	
	s_bShowOrig_gas = !s_bShowOrig_gas;
	s_bShow_gas = s_bShowOrig_gas;
	// s_bShowOrig_gas = show;

	if(show) {
		s_bShow_violation_EventType = false;
		s_bShowOrig_violation_EventType = false;

		s_bShow_imCall_EventType = false;
		s_bShowOrig_imCall_EventType = false;

		s_bShow_actionStop_EventType = false;
		s_bShowOrig_actionStop_EventTyp = false;

		s_bShow_all = false;
		s_bShowOrig_all = false;
	}

	Update_Scene();
}


function setShow_All(show) {

	s_bShowOrig_all = !s_bShowOrig_all;
	s_bShow_all = s_bShowOrig_all;
	// s_bShowOrig_all = show;

	if(s_bShow_all) {
		s_bShow_violation_EventType = true;
		s_bShowOrig_violation_EventType = false;

		s_bShow_imCall_EventType = true;
		s_bShowOrig_imCall_EventType = false;

		s_bShow_actionStop_EventType = true;
		s_bShowOrig_actionStop_EventTyp = false;

		s_bShow_gas = true;
		s_bShowOrig_gas = false;
	}
	else {
		s_bShow_violation_EventType = false;
		s_bShowOrig_violation_EventType = false;

		s_bShow_imCall_EventType = false;
		s_bShowOrig_imCall_EventType = false;

		s_bShow_actionStop_EventType = false;
		s_bShowOrig_actionStop_EventTyp = false;

		s_bShow_gas = false;
		s_bShowOrig_gas = false;
	}

	Update_Scene();
}

function setHide_All() {
	s_bShow_violation_EventType = false;
	s_bShowOrig_violation_EventType = false;

	s_bShow_imCall_EventType = false;
	s_bShowOrig_imCall_EventType = false;

	s_bShow_actionStop_EventType = false;
	s_bShowOrig_actionStop_EventTyp = false;

	s_bShow_gas = false;
	s_bShowOrig_gas = false;

	Update_Scene();
}

function IsLoadScene() {
	return s_bLoadScene;
}

var s_PoiTableMap = null;

function GetPoiTableMap() {

	return s_success_poi_info;
	// return s_PoiTableMap;
}

function PoiTableMap() {
	this.PoiAreaList = null;
	this.PoiList = null;

	this.setPoiAreaList = function(PoiAreaList) {
		this.PoiAreaList = PoiAreaList;
	}

	this.setPoiList = function(PoiList) {
		this.PoiList = PoiList;
	}
}

// ---------------------------------------------------------
// Transfer To Bridge
// ---------------------------------------------------------
// MapViewer --> 메인 페이지
function Send_ToBridge_InMapViewer(msg, param0, param1, param2, param3) {

	// 보낼 때
	Send_MapViewer_ToBridge(msg, param0, param1, param2, param3);
}

// 메인 페이지 --> MapViewer
function Recv_BridgeToMapViewer(msg, param0, param1, param2, param3) {

	// 받을 때

	var cc = IsLoadScene();

	// var TableMap = GetMCTableMap();


	// console.log('[클라] 메인에서 받음 : ' + msg);
}

// ---------------------------------------------------------
// fps
// ---------------------------------------------------------

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
	// console.log('FPS : ' + utilCntVal.g_util_fps.toFixed(3));
}

function calcFPS() {
	if(utilCntVal.g_util_curCnt++ === utilCntVal.g_util_frameCnt) {
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



// ---------------------------------------------------------
// log
// ---------------------------------------------------------
function Debug_Log(msg) {
	try {
		// console.log(msg);
	}
	catch(e) {}
}

function Debug_Log_Msg(msg) {
	try {
		// console.log(msg);
	}
	catch(e) {}
}

function Debug_Log_Re_Msg(msg) {
	try {
		// console.log(msg);
	}
	catch(e) {}
}

function Debug_Log_Camera_Msg(msg) {
	try {
		// console.log(msg);
	}
	catch(e) {}
}


// ---------------------------------------------------------
// start
// ---------------------------------------------------------

function bootstrap() {

	if(g_use_event_page_move_sessionstorage) {
		load_sessionstorage_client();
	}


	// 로컬 서버 연결 상태 체크
	start_check_connect_state();

	// 로딩바

	// loadingMapView(1);

	loadingView(1, 'bootstrap');

	InitCameraInfo();

	s_Array_SceneCamera = new Array();


	s_array_msg_scene_onload = new Array();

	s_PoiTableMap = new PoiTableMap;
	s_count_fail_poi_info = 0;

	s_Array_ObjectTransparency_Safe = new Array();

	s_Array_ObjectTransparency = new Array();
	s_Array_PrevObjectTransparency = new Array();
	
	s_Array_ObjectTransparency_Em = new Array();

	// s_stWorkerFilterInfo = new stWorkerFilterInfo();

	// map view list
	// GetMapViewList();
	// s_arrBuilding_Node = new ArrayList();

	// browser id

	if(g_use_event_page_move_sessionstorage) {
		if(g_event_page_move_sessionstorage == '1') {

		}
		else {
			generate_id();
		}
	}
	else {
		generate_id();
	}

	// F5번
	document.addEventListener('keydown', onkeydown_handler);
	
	// 더블 클릭 후 텍스트 선택 방지
	//document.addEventListener('mousedown', function(e){ e.preventDefault(); }, false);


	// refresh
	window.onbeforeunload = CleanPage;

	// refresh
	window.unload = CleanPage;


	var canvas = document.getElementById('mycanvas');
	g_canvas = canvas; // 2017.12.17
	g_ctx = canvas.getContext('2d');

	// iexplore 작동 되지 않음
	// canvas.addEventListener('contextmenu', event => event.preventDefault());

	document.oncontextmenu = function(e) {
		// alert('오른쪽버튼을 이용할 수 없습니다...');
		return false;
	}

	canvas_rect = canvas.getBoundingClientRect();

	// event mouse
	canvas.onmousedown = onmouse_down;
	canvas.onmouseup = onmouse_up;
	canvas.onmousemove = onmouse_move;
	canvas.onmousewheel = onmouse_wheel;

	if(g_use_event_page_move_sessionstorage) {
		if(g_event_page_move_sessionstorage == '1') {

			start_connect_mapviewer();
		}
		else {
			// connect service app
			start_Connect();
		}
	}
	else {
		// connect service app
		start_Connect();
	}
};


function CleanPage() {

	if(!g_use_old_socket) {

		clearInterval(s_timerid_check_connect_state);

		var key_value = sessionStorage.getItem('link_page');
		if(isdefined(key_value)) {
			if(key_value == 'true') {

				setOrig_ObjectColor();

				stop_worker();

				clear_AirTags();

				sessionStorage.setItem('link_page', '');
				return;
			}
		}

		if(g_re_connectsocket) {
			g_re_connectsocket = false;
			return;
		}
		// 종료
		post_msg_sync_btos('msg_send_browser_close_btos', '00001');

		return;

	}

	if(!s_bPageCleanedUp) {
		// service app
		if(s_bDoubleConnect) {

		}
		else {

			if(g_use_event_page_move_sessionstorage) {
				clearInterval(s_timerid_check_connect_state);
				// post_msg_sync_btos('msg_send_browser_close_btos', '00001');

				if(g_event_page_move_sessionstorage == '1') {

				}
				else {

					close_sessionstorage_client();
					post_msg_sync_btos('msg_send_browser_close_btos', '00001');
				}
			}
			else {

				clearInterval(s_timerid_check_connect_state);
				post_msg_sync_btos('msg_send_browser_close_btos', '00001');
			}
		}
	}
}


function generate_id() {

	if(g_use_old_socket) {
		s_browser_guid = new Date().getTime();
	}
	else {
		s_browser_guid = sessionStorage.getItem('browser_guid');
	}

}

function onkeydown_handler() {
	switch(event.keyCode) {
		case 116: // 'F5'
			if(s_bDoubleConnect) {

			}
			else {
				// service app
				post_msg_btos('msg_send_browser_close_btos', '00001');
			}
			break;
	}
}

function start_worker() {
	worker = new Worker('/js/newjs/doWorker.js');

	worker.onmessage = function(event) {
		// console.log('worker msg --0000');
		var imageData = event.data;
		img.src = 'data:image/jpeg;base64,' + imageData;
	}

	img.onload = function() {
		// 2017.12.17 start
		if(!g_loadingView_net) {

			if(g_load_img_client) {
				var old = false;
				if(old) {

					var basicWidth = 1152;
					var basicHeight = 720;

					var realposx = (g_canvas.width - basicWidth) / 2;
					var realposy = (g_canvas.height - basicHeight) / 2;

					g_realratio = 960 / basicWidth;

					g_realposx = realposx;
					g_realposy = realposy;
					g_ctx.drawImage(this, 0, 0, 960, 600, realposx, realposy, basicWidth, basicHeight);
				}
				else {

					// var unityWidth = 1152;
					// var unityHeight = 720;
					// var basicWidth = 1152;
					// var basicHeight = 720;

					// 해상도 관련 처리
					// - 3D지도 확대노출 필요(테스트해상도1920)
					// - 1152:720 (브라우저해상도)/ 960: 600(유니티)
					// - 1440:900 (브라우저해상도)/ 1152:720(유니티)


					var unityWidth = g_unity_resolution_width;
					var unityHeight = g_unity_resolution_height;
					// var basicWidth = 1440;
					// var basicHeight = 900;
					var basicWidth = 1440;
					var basicHeight = 900;

					var realposx = (g_canvas.width - basicWidth) / 2;
					var realposy = (g_canvas.height - basicHeight) / 2;

					g_realratio = unityWidth / basicWidth;

					g_realposx = realposx;
					g_realposy = realposy;
					g_ctx.drawImage(this, 0, 0, unityWidth, unityHeight, realposx, realposy, basicWidth, basicHeight);
				}
			}
		}
	}
}

function stop_worker() {

	if(isdefined(worker)) {
		worker.terminate();
		worker = undefined;
	}
}

// function restart_websocket() {
// setTimeout(function () {

// start_websocket();

// }, 200);
// }

var connectSocket = false;

function start_websocket() {

	socket = new WebSocket('ws://127.0.0.1:4649/Laputa');
	// if(!isdefined(socket))
	// {
	// if(socket.readyState == 3)
	// {
	// // 연결이 종료되었거나, 연결에 실패한 경우에 해당
	// restart_websocket();

	// console.log('restart_websocket');

	// return;
	// }
	// }


	socket.binaryType = 'arraybuffer';

	if(g_use_old_socket) {
		waitForSocketConnection(socket, function(msg) {
			sendmessage(msg);
		});
	}
	else {
		var key_value = sessionStorage.getItem('dashboard_page');
		if(isdefined(key_value)) {
			if(key_value == 'true') {

				// setInitCameraParam(58.34585, -4.8724737, 1887.9319, 1,
				// 1200);//1700);

				// loadMap('SCN000001');
			}
			else {

			}
		}
		else {
			waitForSocketConnection(socket, function(msg) {
				sendmessage(msg);
			});
		}
	}

	socket.onopen = function() {

		if(g_use_old_socket) {

		}
		else {
			connectSocket = true;

			var key_value = sessionStorage.getItem('dashboard_page');
			if(isdefined(key_value)) {
				if(key_value == 'true') {

					// 로딩바

					// loadingMapView(1);

					loadingView(1, 'socket.onopen');

					s_bLoadScene = true;

					if(g_tab_state_sys == TAB_STATE_SYS.tab_emergency) {
						console.log('setInitCameraParam1');
						setInitCameraParam(55.00001, 0.4725055, 1500, 1, 2500);
					    //setCameraTargetPos(14.63107, 100, -99.96201);
					    //setCameraPos(12.8345, 411.1276, -317.8084);
					}
					else {
						console.log('setInitCameraParam2');
						setInitCameraParam(55.00001, 0.4725055, 1500, 1, 2500);
					    //setCameraTargetPos(14.63107, 100, -99.96201);
					    //setCameraPos(12.8345, 411.1276, -317.8084);
						
					}
					loadMap('SCN000001');


					// -----------------------------------------------------------------------------
					// AtlasHelper 사용법
					// -----------------------------------------------------------------------------

					if(s_AirTagHelper == null) {
						s_AirTagHelper = new AirTagHelper;

						// setup
						s_AirTagHelper.setup();
					}

					setOrig_ObjectColor();

					// //-----------------------------------------------------------------------------
					// // 중점 구역 일 경우
					// //-----------------------------------------------------------------------------
					// if(s_tab_state == TAB_STATE.FOCUS_CONTROL) {
					// Update_ObjectTransparency();
					// }
				}
				else {

				}
			}
		}
	}

	socket.onmessage = handleReceive;

	socket.onclose = function(event) {

		var reason;

		Debug_Log('Socket.OnClose: Disconnected.<br>', 'gray');

		if(event.code == 1000) {
			reason = 'Normal closure, meaning that the purpose for which the connection was established has been fulfilled.';
		}
		else if(event.code == 1001) {
			reason = 'An endpoint is \'going away\', such as a server going down or a browser having navigated away from a page.';
		}
		else if(event.code == 1002) {
			reason = 'An endpoint is terminating the connection due to a protocol error';
		}
		else if(event.code == 1003) {
			reason = 'An endpoint is terminating the connection because it has received a type of data it cannot accept (e.g., an endpoint that understands only text data MAY send this if it receives a binary message).';
		}
		else if(event.code == 1004) {
			reason = 'Reserved. The specific meaning might be defined in the future.';
		}
		else if(event.code == 1005) {
			reason = 'No status code was actually present.';
		}
		else if(event.code == 1006) {
			reason = 'The connection was closed abnormally, e.g., without sending or receiving a Close control frame';
		}
		else if(event.code == 1007) {
			reason = 'An endpoint is terminating the connection because it has received data within a message that was not consistent with the type of the message (e.g., non-UTF-8 [http://tools.ietf.org/html/rfc3629] data within a text message).';
		}
		else if(event.code == 1008) {
			reason = 'An endpoint is terminating the connection because it has received a message that \'violates its policy\'. This reason is given either if there is no other sutible reason, or if there is a need to hide specific details about the policy.';
		}
		else if(event.code == 1009) {
			reason = 'An endpoint is terminating the connection because it has received a message that is too big for it to process.';
		}
		else if(event.code == 1010) {
			reason = 'An endpoint (client) is terminating the connection because it has expected the server to negotiate one or more extension, but the server didn\'t return them in the response message of the WebSocket handshake. <br /> Specifically, the extensions that are needed are: ' + event.reason;
		}
		else if(event.code == 1011) {
			reason = 'A server is terminating the connection because it encountered an unexpected condition that prevented it from fulfilling the request.';
		}
		else if(event.code == 1015) {
			reason = 'The connection was closed due to a failure to perform a TLS handshake (e.g., the server certificate can\'t be verified).';
		}
		else {
			reason = 'Unknown reason';
		}

		if(socket) {
			Debug_Log('Socket.OnClose: Disconnected.<br>', 'gray');
		}
		if(g_use_old_socket) {
			socket = null;

			stop_worker();

			invalid_websocket();
		}
		else {

			var key = sessionStorage.getItem('prevent_re_mainpage');
			if(isdefined(key)) {
				// console.log('prevent_re_mainpage 0001' );
				sessionStorage.setItem('prevent_re_mainpage', '');
			}
			else {
				post_msg_sync_btos('msg_send_mapviewer_exe_btos', '00');
				location.href = '/html/MainPage.html';
			}

		}

	};

	socket.onerror = function(event) {
		// console.log('Socket.OnError');
		if(g_use_old_socket) {
			socket = null;
			Debug_Log('Socket.OnError: \'' + event.data + '\'<br>', 'red');
		}
		else {
			if(connectSocket == false) {
				g_re_connectsocket = true;

				var key = sessionStorage.getItem('prevent_re_mainpage');
				if(isdefined(key)) {
					sessionStorage.setItem('prevent_re_mainpage', '');
				}
				else {
					location.href = '/html/MainPage.html';
				}
			}
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

function waitForSocketConnection(wsocket, callback) {
	setTimeout(function() {

		s_count_websocket_connect_btol++;

		if(s_count_websocket_connect_btol < 10) {

			if(wsocket.readyState === 1) {
				//				Debug_Log('Connection is made')
				if(callback != null) {
					callback();
				}
				return;

			}
			else if(wsocket.readyState === 0) {
				Debug_Log('wait for connection...')
				waitForSocketConnection(wsocket, callback);
			}
			else {
				Debug_Log('wait for connection... 33')
				waitForSocketConnection(wsocket, callback);
			}
		}
		// websocket ready state 계속 체크를 하다가
		// 3회까지 응답이 없다면 LocalServer에게 MapViewer 실행 여부 상태를 검사하여
		// MapViewer가 실행되지 않은 경우에는 실행 처리
		if(s_count_websocket_connect_btol >= 10) {
			// post_msg_btos('msg_send_mapviewer_restart_btos', '0002');
			Debug_Log('msg_send_mapviewer_restart_btos')
			s_count_websocket_connect_btol = 0;
			return;
		}

	}, 2000);
}

function stop_websocket() {
	if(socket) {
		socket.close();
	}
}

// ----------------------------------------------
// 로컬 서버에 레지스트리 data read
// ----------------------------------------------
function func_Read_RegData() {

	post_msg_sync_btos('msg_send_data_read', '00');
}

// ----------------------------------------------
// 로컬 서버에 레지스트리 data write
// ----------------------------------------------
function func_Write_RegData(data) {

	post_msg_sync_btos('msg_send_data_write', data);
}


// 동기
function post_msg_sync_btos(msg, param) {

	// var log_mag = msg + param;
	// console.log(log_mag);

	$.ajax({
		type: 'POST',
		async: false,
		url: s_url_localserver,
		contentType: 'text/plain',
		data: {
			id: s_browser_guid,
			msg: msg,
			param: param
		},
		error: function() {
			on_error_post_msg_btos(msg, param);
		},
	}).success(function(msg) {
		onMessage_stob(msg);
	});
}


// 비동기
function post_msg_btos(msg, param) {

	// var log_mag = msg + param;
	// console.log(log_mag);

	$.ajax({
		type: 'POST',
		url: s_url_localserver,
		contentType: 'text/plain',
		data: {
			id: s_browser_guid,
			msg: msg,
			param: param
		},
		error: function() {
			on_error_post_msg_btos(msg, param);
		},

	}).success(function(msg) {
		onMessage_stob(msg);
	});
}

function onMessage_stob(msg) {
	if(msg.length == 0) {
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

	//	Debug_Log('post_msg = ' + _msg);
	if(_id != '-1') {
		if(_id != s_browser_guid) {
			//			Debug_Log('double connect!!');
			//			Debug_Log('double connect!! _id = ' + _id + ' s_browser_guid = ' + s_browser_guid);

			// 이중 브라우저 예외처리
			s_bDoubleConnect = true;

			// 타이머 해제
			clearInterval(s_timerid_connect);
			alert('double connect!!');
			return;
		}
	}

	switch(_msg) {
		case 'msg_recv_data':
			// reg 정보
			r_reg_data = _param_0;
			callback_reg_data(r_reg_data);
			break;
		case 'msg_recv_connect_stob':
			// 접속이 되었다면 타이머 해제
			clearInterval(s_timerid_connect);

			Debug_Log('msg_recv_connect_stob');

			// 맵 다운로드 상태 체크
			if(g_use_old_socket) {
				post_msg_btos('msg_send_browser_mapdownload_btos', '');
			}
			else {

				var key_value = sessionStorage.getItem('dashboard_page');
				if(isdefined(key_value)) {
					if(key_value == 'true') {
						// 연결 처리
						start_connect_mapviewer();

						// init_map();
					}
					else {

					}
				}
				else {
					post_msg_btos('msg_send_browser_mapdownload_btos', '');
				}
			}

			break;
		case 'msg_recv_browser_mapdownload_stob':
			// 맵 다운로드 상태 확인
			switch(_param_0) {
				case 'success_mapdownload':
					clearInterval(s_timerId_Mapdownload);

					// -------------------------------------------
					// 맵뷰어 연결 카운트
					// start - key
					// -------------------------------------------
					var count_cm_key = localStorage.getItem('count_connect_mapviewer');

					var count_key = 1;

					if(isdefined(count_cm_key)) {
						count_key = parseInt(count_cm_key);
					}
					var save_count_key = count_key + 1;

					localStorage.setItem('count_connect_mapviewer', save_count_key);

					var interval_time = 3000 * count_key;

					// -------------------------------------------
					// end - key
					// -------------------------------------------
					s_timerid_connect_mapviewer = setInterval('start_connect_mapviewer()', interval_time); // 12000);
					// //3000

					// 유니티 실행
					post_msg_sync_btos('msg_send_mapviewer_exe_btos', '00');

					// // 로딩바
					// loadingView(0);
					break;
				case 'fail_mapdownload':
					clearInterval(s_timerId_Mapdownload);
					break;
				case 's_Process_MapDownload':
					var process = _param_1;

					s_timerId_Mapdownload = setInterval(function() {
						post_msg_btos('msg_send_browser_mapdownload_btos', '');
					}, 1000);  // 1초마다 체크
					break;
			}
			break;
		case 'msg_recv_map_poi_info':
			var poi_list_info = _param_0;
			var poi_area_list_info = _param_1;

			if(poi_list_info != '-1' && poi_area_list_info != '-1') {
				// 성공일 경우
				
				//console.log(poi_list_info);
				//console.log(poi_area_list_info);

				// poi
				s_PoiList = new PoiList_Response();
				s_PoiList.setData(JSON.parse(poi_list_info));
				s_PoiTableMap.setPoiList(s_PoiList);

				// poi area
				s_PoiAreaList = new PoiAreaList_Response();
				s_PoiAreaList.setData(JSON.parse(poi_area_list_info));
				s_PoiTableMap.setPoiAreaList(s_PoiAreaList);

				s_success_poi_info = true;
			}
			else {
				s_success_poi_info = false;
				//s_count_fail_poi_info++;
				//if(s_count_fail_poi_info > 2) {
				//	// 소스안 poi 정보 설정
				//	GetResponse_PoiListInfo();
				//	s_success_poi_info = true;
				//}
				//else {
				//	setTimeout(function() {
				//		post_msg_btos('msg_send_map_poi_info_btos', '1');
				//	}, 1000);
				//}
				setTimeout(function() {
					post_msg_btos('msg_send_map_poi_info_btos', '1');
				}, 1000);
			}
			break;
		case 'msg_recv_mapviewer_restart_stob':
			Debug_Log('msg_recv_mapviewer_restart_stob');
			// s_timerid_connect_mapviewer =
			// setInterval('start_connect_mapviewer()', 3000);
			break;

		case 'msg_recv_update_stob':
			break;

		case 'msg_recv_dummy_stob':
			// 더미 메시지
			break;
		case 'msg_recv_browser_close_stob':
			s_bPageCleanedUp = true;
			break;
	}
}

function start_connect_mapviewer() {
	// start websock
	start_websocket();

	// start worker
	// 이부분은 페이지 별로 처리 해야함.
	start_worker();

	clearInterval(s_timerid_connect_mapviewer);
}

// 에러 체크

var count_error = 0;

function on_error_post_msg_btos(msg, param) {

	location.href = '/html/MainPage.html';

	// var log_mag = 'on_error_post_msg_btos' + msg + param;
	// console.log(log_mag);

	// switch (msg) {

	// case 'msg_send_connect_btos':
	// {
	// if(g_use_event_page_move_sessionstorage) {

	// if(g_event_page_move_sessionstorage == '1') {

	// }
	// else {
	// // 연결 실패 일 경우
	// if(count_error == 0) {
	// // 두번째
	// // 강제로 로컬 서버 띄움
	// start_LocalServer();

	// }
	// if(count_error == 1) {
	// // 로컬 서버를 띄웠는데 연결 실패를 했다면
	// // 설치 파일 다운로드
	// // 타이머 해제
	// clearInterval(s_timerid_connect);
	// alert('설치 파일 다운로드 해 주세요.');
	// }
	// count_error++;
	// }

	// }
	// else {

	// // 연결 실패 일 경우
	// if(count_error == 0) {
	// // 두번째
	// // 강제로 로컬 서버 띄움
	// start_LocalServer();

	// }
	// if(count_error == 1) {
	// // 로컬 서버를 띄웠는데 연결 실패를 했다면
	// // 설치 파일 다운로드
	// // 타이머 해제
	// clearInterval(s_timerid_connect);
	// alert('설치 파일 다운로드 해 주세요.');
	// }
	// count_error++;
	// }
	// }
	// break;
	// case 'msg_send_update_btos':
	// {
	// // LocalServer 응답 실패할 경우

	// // 강제로 로컬 서버 띄움
	// //start_LocalServer();

	// }
	// break;

	// }
}

function start_Connect() {

	// 시작 하자 마자 바로 보낸다.

	var TempBasicURL = testBasicURL;
	TempBasicURL = TempBasicURL.split('.');
	TempBasicURL[0] = TempBasicURL[0].substring(7, TempBasicURL[0].length);
	var TempBasicURL_last = TempBasicURL[3].split(':');
	var mapBasicURL = 'http://' + TempBasicURL[0] + '.' + TempBasicURL[1] + '.' + TempBasicURL[2] + '.' + TempBasicURL_last[0] + ':' + g_MapServerPort + '/idrlbs';

	var str_url_project_id = mapBasicURL + '%' + projectid_net;

	post_msg_btos('msg_send_connect_btos', str_url_project_id);


	// poi info
	post_msg_btos('msg_send_map_poi_info_btos', '1');

	if(g_use_old_socket) {
		// 1초 경과 후 다시
		s_timerid_connect = setInterval(function() {

			post_msg_btos('msg_send_connect_btos', '1');

		}, 1000);
	}
	else {}

}

function start_LocalServer() {
	// setup 설치는 되어 있으나 LocalServer가 실행되지 않을 경우
	// LocalServer 실행 처리
	// window.location.href = 'LocalServer_MapViewer_Run://';

	// window.location.replace('LocalServer_MapViewer_Run://');
}


function start_check_connect_state() {

	// 로컬 서버 연결 상태 체크
	// 1초 마다
	s_timerid_check_connect_state = setInterval(function() {

		post_msg_btos('msg_send_check_connect_state_btos', '1');

	}, 1000);
}


function sendmessage(msg) {
	try {
		send('connect');

		init_map();
	}
	catch(ex) {}
}

function send(msg) {
	if(isdefined(socket)) {
		socket.send(msg);
	}
}

function handleReceive(message) {

	var data = message.data;

	var comb = data.substring(0, 3);

	if(comb == '###') {
		Debug_Log_Msg('data ###');
		Debug_Log_Msg(data);
		var data_r = data.substring(5, data.length);
		Debug_Log_Msg(data_r);
		MessagePump(data_r);
	}
	else {
		worker.postMessage({
			'buffer': data
		});
	}
}

function MessagePump(message) {
	var lines = message.split('\\n');
	var type = lines[0];
	var command = lines[1];
	var param = lines[2];

	Debug_Log_Msg('type = ' + type);
	Debug_Log_Msg('command = ' + command);
	Debug_Log_Msg('param = ' + param);

	switch(type) {
		case 'Command':
			On_Message_Command(command, param);
			break;
		case 'Event':
			On_Message_Event(command, param);
			break;
		case 'Message':
			On_Message_Message(command, param);
			break;
		case 'Binary':
			On_Message_Binary(command, param);
			break;
	}
}

function On_Message_Command(command, param) {


}


// ------------------------------------------------
// poi
// ------------------------------------------------
function KSJSONPOIBodyInfo() {
	this.PoiList = new ArrayList();
}

function KSJSONPOIList() {
	this.body = new KSJSONPOIBodyInfo();

	this.Clear = function() {
		body.PoiList.Clear();
	}
}

function KSJSONPOIInfo() {
	this.POIID; // POI 식별자, Key(10)
	this.SceneID;
	this.NameKO; // POI 이름(한글)
	this.NameEN; // POI 이름(영문)
	this.CategoryID; // 카테고리 대분류
	this.CategorySubID; // 카테고리 중분류
	this.PosX; // 월드 좌표계 X값
	this.PosY; // 월드 좌표계 Y값
	this.PosZ; // 월드 좌표계 Z값
	this.Tag; // Custom Data
	this.Desc; // 설명
}

function On_Message_Event(command, param) {

	switch(command) {
		case 'getPoiInfo':
			var params = param.split(sep_b);
			var jsonval = params[0];
			var poiInfo_list = new KSJSONPOIList(JSON.parse(jsonval));
			break;
		case 'getCategoryInfo':
			var params = param.split(sep_b);
			var jsonval = params[0];
			break;
		case 'onSelectPoi':
			var params = param.split(sep_b);
			var jsonval = params[0];
			var poiInfo = new KSJSONPOIInfo(JSON.parse(jsonval));
			break;
		case 'onSelectMyPosition':
			var params = param.split(sep_b);
			var jsonval = params[0];
			break;
		case 'onTouchInfo':
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
			break;
		case 'OnGoBackPressed':
			break;
		case 'onPressButton':
			var params = param.split(sep_b);
			var UxID = params[0];
			break;
		case 'onReleaseButton':
			var params = param.split(sep_b);
			var UxID = params[0];
			break;
	}
}

function On_Message_Message(command, param) {

	switch(command) {
		case 'loadMap':
			var params = param.split(sep_b);
			var result_code = params[0];
			var result_msg = params[1];

			if(result_code == '1') {
				on_loadmap(result_code, result_msg);
			}
			break;
		case 'loadMapByPoiID':
			var params = param.split(sep_b);
			var result_code = params[0];
			var result_msg = params[1];

			on_loadMapByPoiID(result_code, result_msg);
			break;
		case 'loadMapByCoordinate':
			var params = param.split(sep_b);
			var result_code = params[0];
			var result_msg = params[1];

			on_loadMapByCoordinate(result_code, result_msg);
			break;
		case 'getCurrentMapId':
			var params = param.split(sep_b);
			var map_id = params[0];

			on_getCurrentMapId(map_id);
			break;
		case 'initializeMap':
			var params = param.split(sep_b);
			var result_code = params[0];
			var result_msg = params[1];

			on_initializeMap(result_code, result_msg);
			break;
		case 'onLoadStart':
			on_onLoadStart();
			break;
		case 'getCameraState':
			var params = param.split(sep_b);
			var angle = params[0];
			var rotation = params[1];
			var zoom = params[2];

			Debug_Log_Camera_Msg('angle = ' + angle + ' rotation = ' + rotation + ' zoom = ' + zoom);
			console.log('angle = ' + angle + ' rotation = ' + rotation + ' zoom = ' + zoom);

			on_getCameraState(angle, rotation, zoom);
			break;
		case 'getCameraPosition':
			var params = param.split(sep_b);
			var vCameraPos_x = params[0];
			var vCameraPos_y = params[1];
			var vCameraPos_z = params[2];
			var vTargetPos_x = params[3];
			var vTargetPos_y = params[4];
			var vTargetPos_z = params[5];

			Debug_Log_Camera_Msg('vCameraPos_x = ' + vCameraPos_x + ' vCameraPos_y = ' + vCameraPos_y + ' vCameraPos_z = ' + vCameraPos_z + 'vTargetPos_x = ' + vTargetPos_x + ' vTargetPos_y = ' + vTargetPos_y + ' vTargetPos_z = ' + vTargetPos_z);

			on_getCameraPosition(vCameraPos_x, vCameraPos_y, vCameraPos_z, vTargetPos_x, vTargetPos_y, vTargetPos_z);
			break;
		case 'cleanResource':
			on_cleanResource();
			break;
		case 'onObjectTouched':
			var params = param.split(sep_b);
			var objType = params[0];
			var objId = params[1];

			on_onObjectTouched(objType, objId);
			break;
	}
}


function On_Message_Binary(command, param) {


}


// --------------------------------------------------------------
//
// event mouse
//
// --------------------------------------------------------------

function getMousePos(e) {

	// console.log('final X : '+(e.clientX - canvas_rect.left -
	// g_realposx)*g_realratio+' Y : '+(e.clientY- canvas_rect.top -
	// g_realposy)*g_realratio);
	// console.log('eclient X : '+e.clientX- canvas_rect.left+ ' eclient Y :
	// '+e.clientY - canvas_rect.top);
	// console.log('grealposX : '+g_realposx+' grealposY : '+g_realposy);
	// console.log('g_realratio : '+g_realratio);
	// return { x: e.clientX - canvas_rect.left, y: e.clientY - canvas_rect.top
	// };
	return {
		x: (e.clientX - canvas_rect.left - g_realposx) * g_realratio,
		y: (e.clientY - canvas_rect.top - g_realposy) * g_realratio
	}; // 2017.12.17
}

function send_mouse(event_msg, e) {
	var mousecoords = getMousePos(e);

	var msg = '';
	msg += 'Command' + sep_n;
	msg += event_msg + sep_n;
	msg += e.button + sep_b;
	msg += mousecoords.x + sep_b;
	msg += mousecoords.y + sep_b;
	send(msg);
}

function onmouse_down(e) {

	s_bmouse_down = 1;

	if(e.button == 2) {
		s_mouse_down_id = 1;
	}
	else {
		s_mouse_down_id = 0;
	}
	send_mouse('setMouseDown', e);

	var mousecoords = getMousePos(e);
	Debug_Log_Msg('m  : button = ' + e.button + ' x = ' + mousecoords.x + ' y = ' + mousecoords.y);
}

function onmouse_up(e) {
	s_bmouse_down = 0;
	send_mouse('setMouseUp', e);
}

function onmouse_move(e) {
	if(s_bmouse_down == 0) return;

	var mousecoords = getMousePos(e);

	var msg = '';
	msg += 'Command' + sep_n;
	msg += 'setMouseMove' + sep_n;
	msg += s_mouse_down_id + sep_b;
	msg += mousecoords.x + sep_b;
	msg += mousecoords.y + sep_b;
	send(msg);

	// send_mouse('setMouseMove', e);
	Debug_Log_Msg('m : onmouse_move ');
}

function onmouse_wheel(e) {
	// var delta = e.wheelDelta ? e.wheelDelta : -e.detail;

	var delta = e.wheelDelta ? -e.wheelDelta : e.detail;

	var msg = '';
	msg += 'Command' + sep_n;
	msg += 'setMouseWheel' + sep_n;
	msg += delta + sep_b;
	send(msg);
}

// --------------------------------------------------------------
//
// set api
//
// --------------------------------------------------------------

// 0
function setMapDataPath(data_path) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setMapDataPath' + sep_n;
	msg += data_path + sep_b; // path
	send(msg);
}

// 1
function setProjectId(project_id) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setProjectId' + sep_n;
	msg += project_id + sep_b; // project id
	send(msg);
}

// 2
function setZoomRange(zoom_min, zoom_max) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setZoomRange' + sep_n;
	msg += zoom_min + sep_b; // zoom_min
	msg += zoom_max + sep_b; // zoom_max
	send(msg);
}

// 3
function setDebugMode(bshow) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setDebugMode' + sep_n;
	msg += bshow + sep_b; // true, false
	send(msg);
}

// 4
function loadMap(map_id) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'loadMap' + sep_n;
	msg += map_id + sep_b; // map_id
	send(msg);
}

// 5
function loadMapByPosition(map_id, x, y, z) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'loadMapByPosition' + sep_n;
	msg += map_id + sep_b; // map_id
	msg += x + sep_b; // x
	msg += y + sep_b; // y
	msg += z + sep_b; // z
	send(msg);
}


// 6
function moveMap(x, y, z) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'moveMap' + sep_n;
	msg += x + sep_b; // x
	msg += y + sep_b; // y
	msg += z + sep_b; // z
	send(msg);
}

// 7
function getCurrentMapId() {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'getCurrentMapId' + sep_n;
	send(msg);
}

// 8
function initializeMap() {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'initializeMap' + sep_n;
	send(msg);
}

// 9
function setBackgroundColor(bg_color) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setBackgroundColor' + sep_n;
	msg += bg_color + sep_b; // bg_color
	send(msg);
}

// 10
function setCameraAngle(camera_angle) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setCameraAngle' + sep_n;
	msg += camera_angle + sep_b; // camera_angle
	send(msg);
}

// 11
function setCameraRotation(camera_rotation) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setCameraRotation' + sep_n;
	msg += camera_rotation + sep_b; // camera_rotation
	send(msg);
}

// 12
function setCameraZoom(camera_zoom) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setCameraZoom' + sep_n;
	msg += camera_zoom + sep_b; // camera_zoom
	send(msg);
}

// 13
function showPoiById(visibility, filter_poi_id) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'showPoiById' + sep_n;
	msg += visibility + sep_b; // visibility true,
	// false
	msg += filter_poi_id + sep_b; // filter_poi_id
	send(msg);
}

// 14
function showRoute(visibility) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'showRoute' + sep_n;
	msg += visibility + sep_b; // visibility true,
	// false
	send(msg);
}

// 15
function addRoutingPath(line_width, link_color, shadow_off_x, shadow_off_y, shadow_off_z, shadow_color, arrow_size_width, arrow_size_height, pos_array) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'addRoutingPath' + sep_n;
	msg += line_width + sep_b; // line_width
	msg += link_color + sep_b; // link_color
	msg += shadow_off_x + sep_b; // shadow_off_x
	msg += shadow_off_y + sep_b; // shadow_off_y
	msg += shadow_off_z + sep_b; // shadow_off_z
	msg += shadow_color + sep_b; // shadow_color
	msg += arrow_size_width + sep_b; // arrow_size_width
	msg += arrow_size_height + sep_b; // arrow_size_height

	nodeCount = pos_array.length;
	msg += nodeCount + sep_b; // nodeCount

	for(var i = 0; i < pos_array.length; i++) {
		msg += pos_array[i][0] + sep_b; // x
		msg += pos_array[i][1] + sep_b; // y
		msg += pos_array[i][2] + sep_b; // z
	}
	send(msg);
}

// 16
function cleanRoutingPath() {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'cleanRoutingPath' + sep_n;
	send(msg);
}

// 17
function addDynamicPoi(id, pos_x, pos_y, pos_z, uvStartPosX, uvStartPosY, uvEndPosX, uvEndPosY, texname, type, text) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'addDynamicPoi' + sep_n;
	msg += id + sep_b; // id
	msg += pos_x + sep_b; // pos_x
	msg += pos_y + sep_b; // pos_y
	msg += pos_z + sep_b; // pos_z
	msg += uvStartPosX + sep_b; // uvStartPosX
	msg += uvStartPosY + sep_b; // uvStartPosY
	msg += uvEndPosX + sep_b; // uvEndPosX
	msg += uvEndPosY + sep_b; // uvEndPosY
	msg += texname + sep_b; // texname
	msg += type + sep_b; // type
	msg += text + sep_b; // text
	send(msg);
}

// 18
function showDynamicPoi(show, poi_id) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'showDynamicPoi' + sep_n;
	msg += show + sep_b; // show
	msg += poi_id + sep_b; // poi_id
	send(msg);
}

// 19
function setPositionDynamicPoi(id, pos_x, pos_y, pos_z) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setPositionDynamicPoi' + sep_n;
	msg += id + sep_b; // id
	msg += pos_x + sep_b; // pos_x
	msg += pos_y + sep_b; // pos_y
	msg += pos_z + sep_b; // pos_z
	send(msg);
}

// 20
function setTypeDynamicPoi(id, type) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setTypeDynamicPoi' + sep_n;
	msg += id + sep_b; // id
	msg += type + sep_b; // type
	send(msg);
}

// 21
function setTypePoi(id, type) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setTypePoi' + sep_n;
	msg += id + sep_b; // id
	msg += type + sep_b; // type
	send(msg);
}

// 22
function getCameraState() {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'getCameraState' + sep_n;
	send(msg);
}

// 23
function setInitCameraParam(angle, rot, zoom, zoom_min, zoom_max) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setInitCameraParam' + sep_n;
	msg += angle + sep_b; // angle
	msg += rot + sep_b; // rot
	msg += zoom + sep_b; // zoom
	msg += zoom_min + sep_b; // zoom_min
	msg += zoom_max + sep_b; // zoom_max
	send(msg);
}

// 24
function setTextDynamicPoi(id, text) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setTextDynamicPoi' + sep_n;
	msg += id + sep_b; // id
	msg += text + sep_b; // text
	send(msg);
}

// 25
function setColorTextDynamicPoi(id, textcolor) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setColorTextDynamicPoi' + sep_n;
	msg += id + sep_b; // id
	msg += textcolor + sep_b; // textcolor
	send(msg);
}

// 26
function releaseDynamicPoi(id) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'releaseDynamicPoi' + sep_n;
	msg += id + sep_b; // id
	send(msg);
}

// 27
function setDynamicPoiAnchor(poi_ids, anchor) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setDynamicPoiAnchor' + sep_n;
	msg += poi_ids + sep_b; // poi_ids
	msg += anchor + sep_b; // anchor
	send(msg);
}

// 28
function directionPressUp(method) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'directionPressUp' + sep_n;
	msg += method + sep_b; // method
	send(msg);
}

// 29
function directionPressDown(method) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'directionPressDown' + sep_n;
	msg += method + sep_b; // method
	send(msg);
}

// 30
function setLanguageCode(language_code) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setLanguageCode' + sep_n;
	msg += language_code + sep_b; // language_code
	send(msg);
}

// 31
function setShowPoiColor(id, visibility, color) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setShowPoiColor' + sep_n;
	msg += id + sep_b; // id
	msg += visibility + sep_b; // visibility
	msg += color + sep_b; // color
	send(msg);
}

// 32
function setIconToolTipById(id, objectId, objectType, visibility, fontColor, fontSize, texFileName, text, lefttop, rightbottom, textpos, anchorpos) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setIconToolTipById' + sep_n;
	msg += id + sep_b; // id
	msg += objectId + sep_b; // objectId
	msg += objectType + sep_b; // objectType
	msg += visibility + sep_b; // visibility
	msg += fontColor + sep_b; // fontColor
	msg += fontSize + sep_b; // fontSize
	msg += texFileName + sep_b; // texFileName
	msg += text + sep_b; // text
	msg += lefttop + sep_b; // lefttop
	msg += rightbottom + sep_b; // rightbottom
	msg += textpos + sep_b; // textpos
	msg += anchorpos + sep_b; // anchorpos
	send(msg);
}

// 33
function setIconToolTipByPosition(id, pos_x, pos_y, pos_z, visibility, fontColor, fontSize, texFileName, text, lefttop, rightbottom, textpos, anchorpos) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setIconToolTipByPosition' + sep_n;
	msg += id + sep_b; // id
	msg += pos_x + sep_b; // pos_x
	msg += pos_y + sep_b; // pos_y
	msg += pos_z + sep_b; // pos_z
	msg += visibility + sep_b; // visibility
	msg += fontColor + sep_b; // fontColor
	msg += fontSize + sep_b; // fontSize
	msg += texFileName + sep_b; // texFileName
	msg += text + sep_b; // text
	msg += lefttop + sep_b; // lefttop
	msg += rightbottom + sep_b; // rightbottom
	msg += textpos + sep_b; // textpos
	msg += anchorpos + sep_b; // anchorpos
	send(msg);
}

// 34
function changeTextureObject(id, orig_texname, new_texname) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'changeTextureObject' + sep_n;
	msg += id + sep_b; // id
	msg += orig_texname + sep_b; // orig_texname
	msg += new_texname + sep_b; // new_texname
	send(msg);
}

// 35
function releaseIconToolTip(id) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'releaseIconToolTip' + sep_n;
	msg += id + sep_b; // id
	send(msg);
}

// 36
function setSpeedZoom(speed) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setSpeedZoom' + sep_n;
	msg += speed + sep_b; // speed
	send(msg);
}

// 37
function setCameraTargetPos(x, y, z) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setCameraTargetPos' + sep_n;
	msg += x + sep_b; // x
	msg += y + sep_b; // y
	msg += z + sep_b; // z
	send(msg);
}

// 38
function setCameraPos(x, y, z) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setCameraPos' + sep_n;
	msg += x + sep_b; // x
	msg += y + sep_b; // y
	msg += z + sep_b; // z
	send(msg);
}

// 39
function setCameraPathPos(camera_x, camera_y, camera_z, target_x, target_y, target_z) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setCameraPathPos' + sep_n;
	msg += camera_x + sep_b; // camera_x
	msg += camera_y + sep_b; // camera_y
	msg += camera_z + sep_b; // camera_z
	msg += target_x + sep_b; // target_x
	msg += target_y + sep_b; // target_y
	msg += target_z + sep_b; // target_z
	send(msg);
}

// 40
function getCameraPosition() {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'getCameraPosition' + sep_n;
	send(msg);
}

// 41
function showPoiIconById(visibility, filter_poi_id) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'showPoiIconById' + sep_n;
	msg += visibility + sep_b; // visibility
	msg += filter_poi_id + sep_b; // filter_poi_id
	send(msg);
}

// 42
function cleanResource() {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'cleanResource' + sep_n;
	send(msg);
}

// 43
function addDynamicPoiByPoiID(id, poiID, uvStartPosX, uvStartPosY, uvEndPosX, uvEndPosY, texname, type, text) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'addDynamicPoiByPoiID' + sep_n;
	msg += id + sep_b; // id
	msg += poiID + sep_b; // poiID
	msg += uvStartPosX + sep_b; // uvStartPosX
	msg += uvStartPosY + sep_b; // uvStartPosY
	msg += uvEndPosX + sep_b; // uvEndPosX
	msg += uvEndPosY + sep_b; // uvEndPosY
	msg += texname + sep_b; // texname
	msg += type + sep_b; // type
	msg += text + sep_b; // text
	send(msg);
}

// 44
function setTouchRotateSpeed(speed) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setTouchRotateSpeed' + sep_n;
	msg += speed + sep_b; // speed
	send(msg);
}

// 45
function setPressRotateSpeed(speed) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setPressRotateSpeed' + sep_n;
	msg += speed + sep_b; // speed
	send(msg);
}

// 46
function setPressAngleSpeed(speed) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setPressAngleSpeed' + sep_n;
	msg += speed + sep_b; // speed
	send(msg);
}

// 47
function create3dObject(id, modelName, scale) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'create3dObject' + sep_n;
	msg += id + sep_b; // id
	msg += modelName + sep_b; // modelName
	msg += scale + sep_b; // scale
	send(msg);
}

// 48
function set3dObjectPosition(objId, pos_x, pos_y, pos_z, dir_vector_x, dir_vector_y, dir_vector_z) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'set3dObjectPosition' + sep_n;
	msg += objId + sep_b; // objId
	msg += pos_x + sep_b; // pos_x
	msg += pos_y + sep_b; // pos_y
	msg += pos_z + sep_b; // pos_z
	msg += dir_vector_x + sep_b; // dir_vector_x
	msg += dir_vector_y + sep_b; // dir_vector_y
	msg += dir_vector_z + sep_b; // dir_vector_z
	send(msg);
}

// 49
function set3dObjectViewType(objId, viewType) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'set3dObjectViewType' + sep_n;
	msg += objId + sep_b; // objId
	msg += viewType + sep_b; // viewType
	send(msg);
}

// 50
function set3dObjectVisible(objId, visible) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'set3dObjectVisible' + sep_n;
	msg += objId + sep_b; // objId
	msg += visible + sep_b; // visible
	send(msg);
}

// 51
function delete3dObject(objId) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'delete3dObject' + sep_n;
	msg += objId + sep_b; // objId
	send(msg);
}

// 52
function createAirTag(ids) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'createAirTag' + sep_n;
	msg += ids + sep_b; // ids
	send(msg);
}

// 53
function setAirTagPosition(airTagIds, pos_x, pos_y, pos_z) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setAirTagPosition' + sep_n;
	msg += airTagIds + sep_b; // airTagIds
	msg += pos_x + sep_b; // pos_x
	msg += pos_y + sep_b; // pos_y
	msg += pos_z + sep_b; // pos_z
	send(msg);
}

// 54
function setAirTagPositionByPoiId(airTagIds, poiId) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setAirTagPositionByPoiId' + sep_n;
	msg += airTagIds + sep_b; // airTagIds
	msg += poiId + sep_b; // poiId
	send(msg);
}

// 55
function setAirTagBgImage(airTagIds, bgImgName, bgImgLeftPos, bgImgTopPos, bgImgWidth, bgImgHeight) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setAirTagBgImage' + sep_n;
	msg += airTagIds + sep_b; // airTagIds
	msg += bgImgName + sep_b; // bgImgName
	msg += bgImgLeftPos + sep_b; // bgImgLeftPos
	msg += bgImgTopPos + sep_b; // bgImgTopPos
	msg += bgImgWidth + sep_b; // bgImgWidth
	msg += bgImgHeight + sep_b; // bgImgHeight
	send(msg);
}

// 56
function setAirTagIconImage(airTagIds, iconImgName, iconImgLeftPos, iconImgTopPos, iconImgWidth, iconImgHeight, iconMarginLeft, iconMarginTop) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setAirTagIconImage' + sep_n;
	msg += airTagIds + sep_b; // airTagIds
	msg += iconImgName + sep_b; // iconImgName
	msg += iconImgLeftPos + sep_b; // iconImgLeftPos
	msg += iconImgTopPos + sep_b; // iconImgTopPos
	msg += iconImgWidth + sep_b; // iconImgWidth
	msg += iconImgHeight + sep_b; // iconImgHeight
	msg += iconMarginLeft + sep_b; // iconMarginLeft
	msg += iconMarginTop + sep_b; // iconMarginTop
	send(msg);
}

// 57
function setAirTagText(airTagIds, text, textMarginLeft, textMarginTop, fontColor, fontSize) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setAirTagText' + sep_n;
	msg += airTagIds + sep_b; // airTagIds
	msg += text + sep_b; // text
	msg += textMarginLeft + sep_b; // textMarginLeft
	msg += textMarginTop + sep_b; // textMarginTop
	msg += fontColor + sep_b; // fontColor
	msg += fontSize + sep_b; // fontSize
	send(msg);
}

// 58
function setAirTagAnchorType(airTagIds, anchorType) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setAirTagAnchorType' + sep_n;
	msg += airTagIds + sep_b; // airTagIds
	msg += anchorType + sep_b; // anchorType
	send(msg);
}

// 59
function setAirTagViewType(airTagIds, viewType) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setAirTagViewType' + sep_n;
	msg += airTagIds + sep_b; // airTagIds
	msg += viewType + sep_b; // viewType
	send(msg);
}

// 60
function setAirTagVisible(airTagIds, visible) {
	var msg = '';

	if(airTagIds == null) {
		airTagIds = '-1';
	}
	msg += 'Command' + sep_n;
	msg += 'setAirTagVisible' + sep_n;
	msg += airTagIds + sep_b; // airTagIds
	msg += visible + sep_b; // visible
	send(msg);
}

// 61
function deleteAirTag(airTagIds) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'deleteAirTag' + sep_n;
	msg += airTagIds + sep_b; // airTagIds
	send(msg);
}

// 62
function setSpeedAngle(speed) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setSpeedAngle' + sep_n;
	msg += speed + sep_b; // speed
	send(msg);
}

// 63
function setControlLock(lockCamera, lockObjectTouch) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setControlLock' + sep_n;
	msg += lockCamera + sep_b; // lockCamera
	msg += lockObjectTouch + sep_b; // lockObjectTouch
	send(msg);
}

// 64
function setOutlineVisible(bVisible) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setOutlineVisible' + sep_n;
	msg += bVisible + sep_b; // bVisible
	send(msg);
}

// 65
function setOutlineWidth(width) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setOutlineWidth' + sep_n;
	msg += width + sep_b; // width
	send(msg);
}

// 66
function setOutlineColor(color) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setOutlineColor' + sep_n;
	msg += color + sep_b; // color
	send(msg);
}

// 67
function setDefaultOutline(color, thick) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setDefaultOutline' + sep_n;
	msg += color + sep_b; // color
	msg += thick + sep_b; // thick
	send(msg);
}

// 68
function setObjectOutline(ids, color, width) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setObjectOutline' + sep_n;
	msg += ids + sep_b; // ids
	msg += color + sep_b; // color
	msg += width + sep_b; // width
	send(msg);
}

// 69
function setObjectOriginalOutline(ids) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setObjectOriginalOutline' + sep_n;
	msg += ids + sep_b; // ids
	send(msg);
}

// 70
function setObjectColor(ids, color) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setObjectColor' + sep_n;
	msg += ids + sep_b; // ids
	msg += color + sep_b; // color
	send(msg);
}

// 71
function setObjectTransparency(ids, alpha) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setObjectTransparency' + sep_n;
	msg += ids + sep_b; // ids
	msg += alpha + sep_b; // alpha
	send(msg);
}

// 72
function setDeviceVisible(deviceTypes, bVisible) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setDeviceVisible' + sep_n;
	msg += deviceTypes + sep_b; // deviceTypes
	msg += bVisible + sep_b; // bVisible
	send(msg);
}

// 73
function setObjectOriginalColor(ids) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setObjectOriginalColor' + sep_n;
	msg += ids + sep_b; // ids
	send(msg);
}

// 74
function activateView(bActive) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'activateView' + sep_n;
	msg += bActive + sep_b; // bActive true,
	// false
	send(msg);
}

// 75
function lockPinchEvent(pinchZoom, pinchAngle) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'lockPinchEvent' + sep_n;
	msg += pinchZoom + sep_b; // pinchZoom
	msg += pinchAngle + sep_b; // pinchAngle
	send(msg);
}

// 76
function setLodEnabled(enabled) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setLodEnabled' + sep_n;
	msg += enabled + sep_b; // enabled true,
	// false
	send(msg);
}

// 77
function setPoiTouchRatio(touchratio) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setPoiTouchRatio' + sep_n;
	msg += touchratio + sep_b; // touchratio
	send(msg);
}

// 82
function setZoomInOut(zoom) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'setZoomInOut' + sep_n;
	msg += zoom + sep_b; // camera zoom in/out
	send(msg);
}

// 83
function start_websocket_msg() {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'start_websocket' + sep_n;
	send(msg);
}

// 84
function close_websocket_msg() {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'close_websocket' + sep_n;
	send(msg);
}

// 85
function set_resolution_msg(width, height) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'set_resolution' + sep_n;
	msg += width + sep_b; // width
	msg += height + sep_b; // height
	send(msg);
}

// 86
function set_frame_count(frame) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'set_frame_count' + sep_n;
	msg += frame + sep_b; // frame
	send(msg);
}

// 87
function set_graphic_quality(quality) {
	var msg = '';

	msg += 'Command' + sep_n;
	msg += 'set_graphic_quality' + sep_n;
	msg += quality + sep_b; // quality
	send(msg);
}
// --------------------------------------------------------------
//
// api test
//
// --------------------------------------------------------------

// 0 -> ok
function onclick_setMapDataPath() {
	setMapDataPath('data_path');
}

// 1 -> ok
function onclick_setProjectId() {
	setProjectId('PRJ000203');
}

// 2 -> ok
function onclick_setZoomRange() {
	setZoomRange(30, 1300);
}

// 3 -> ok
var s_bDebugMode = 'true';

function onclick_setDebugMode() {
	if(s_bDebugMode == 'true') {
		s_bDebugMode = 'false';
	}
	else {
		s_bDebugMode = 'true';
	}
	setDebugMode(s_bDebugMode);
}

// 4 -> ok
var s_loadMap_0 = 'SCN000001';

function onclick_loadMap() {
	if(s_loadMap_0 == 'SCN000001') {
		s_loadMap_0 = 'SCN000002';
	}
	else {
		s_loadMap_0 = 'SCN000001';
	}
	loadMap(s_loadMap_0);
}

// 5 -> ok
var s_map_id = '';

function onclick_loadMapByPosition() {
	if(s_map_id == 'SCN000001') {
		s_map_id = 'SCN000002';
	}
	else {
		s_map_id = 'SCN000001';
	}
	loadMapByPosition(s_map_id, 20, 0, 20);
}

// 6 -> ok
function onclick_moveMap() {
	moveMap(10, 10, 0);
}

// 7 -> ok
function onclick_getCurrentMapId() {
	getCurrentMapId();
}

// 8 -> ok
function onclick_initializeMap() {
	initializeMap();
}

// 9 -> ok
function onclick_setBackgroundColor() {
	setBackgroundColor('#FF0000');
}

// 10-> ok
var s_camera_angle = 0;

function onclick_setCameraAngle() {
	s_camera_angle += 30;
	s_camera_angle = s_camera_angle % 90;
	setCameraAngle(s_camera_angle);
}

// 11-> ok
var s_camera_rotation = 0;

function onclick_setCameraRotation() {
	s_camera_rotation += 40;
	s_camera_rotation = s_camera_rotation % 360;
	setCameraRotation(s_camera_rotation);
}

// 12-> ok
var s_camera_zoom = 500;

function onclick_setCameraZoom() {
	s_camera_zoom += 10;
	// s_camera_zoom = s_camera_zoom % 100;
	setCameraZoom(s_camera_zoom);
}

// 13 -> ok
var s_showPoiById = 'true';

function onclick_showPoiById() {
	if(s_showPoiById == 'true') {
		s_showPoiById = 'false';
	}
	else {
		s_showPoiById = 'true';
	}
	showPoiById(s_showPoiById, '-1');
}

// 14 -> ok
var s_showRoute = 'false';

function onclick_showRoute() {
	if(s_showRoute == 'true') {
		s_showRoute = 'false';
	}
	else {
		s_showRoute = 'true';
	}
	showRoute(s_showRoute);
}

// 15 -> ok
function onclick_addRoutingPath() {
	// var pos_array = 0;
	var pos_array =   [   // [x]  [y]  [z]
		  
		[20.0, 0.0, 45.0],   // [0]
		[31.0, 0.0, 45.0],   // [1]
		  
		[31.0, 0.0, 38.0],   // [2]
		  
		[31.0, 0.0, 28.0],   // [3]
		[31.0, 0.0, -2.0],   // [4]
		[26.0, 0.0, -2.0]  // [5]
	];

	addRoutingPath(0.8, 'FF0000', 0.4, -0.4, 0.0, '4D4D4D', 0.025, 0.02, pos_array);
}

// 16 -> ok
function onclick_cleanRoutingPath() {
	cleanRoutingPath();
}

// 17 -> ok
function onclick_addDynamicPoi() {
	addDynamicPoi('0', -13.3, 2.24, 51.77, 21, 11, 77, 90, 'all_128_128.png', '3d', '64_2');
}

// 18 -> ok
var s_bshowDynamicPoi = true;

function onclick_showDynamicPoi() {
	if(s_bshowDynamicPoi == 'true') {
		s_bshowDynamicPoi = 'false';
	}
	else {
		s_bshowDynamicPoi = 'true';
	}
	showDynamicPoi(s_bshowDynamicPoi, '0');
}

// 19 -> ok
function onclick_setPositionDynamicPoi() {
	setPositionDynamicPoi('0', 50, 1.4, 0);
}

// 20
var s_setTypeDynamicPoi = '2d';

function onclick_setTypeDynamicPoi() {
	if(s_setTypeDynamicPoi == '2d') {
		s_setTypeDynamicPoi = '3d';
	}
	else {
		s_setTypeDynamicPoi = '2d';
	}
	setTypeDynamicPoi('0', s_setTypeDynamicPoi);
}

// 21
var s_setTypePoi = '2d';

function onclick_setTypePoi() {
	if(s_setTypePoi == '2d') {
		s_setTypePoi = '3d';
	}
	else {
		s_setTypePoi = '2d';
	}
	setTypePoi('POI000001, POI000002, POI000004', s_setTypePoi);
}

// 22 -> ok
function onclick_getCameraState() {
	getCameraState();
}

// 23 -> ok
function onclick_setInitCameraParam() {
	if(g_tab_state_sys == TAB_STATE_SYS.tab_emergency) {
		console.log('setInitCameraParam3');
		setInitCameraParam(55.00001, 0.4725055, 871.2037, 1, 1500);
	}
	else {
		console.log('setInitCameraParam4');
		setInitCameraParam(55.00001, 0.4725055, 871.2037, 1, 1500);
	}
}

// 24 -> ok
var s_setTextDynamicPoi = 'text_0';

function onclick_setTextDynamicPoi() {
	if(s_setTextDynamicPoi == 'text_0') {
		s_setTextDynamicPoi = 'text_11';
	}
	else {
		s_setTextDynamicPoi = 'text_0';
	}
	setTextDynamicPoi('0', s_setTextDynamicPoi);
}

// 25 -> ok
var s_setColorTextDynamicPoi = '#FF0000';

function onclick_setColorTextDynamicPoi() {
	if(s_setColorTextDynamicPoi == '#FF0000') {
		s_setColorTextDynamicPoi == '#00FF00';
	}
	else {
		s_setColorTextDynamicPoi == '#FF0000';
	}
	setColorTextDynamicPoi('0', s_setColorTextDynamicPoi);
}

// 26 -> ok
function onclick_releaseDynamicPoi() {
	releaseDynamicPoi('0');
}

// 27 -> ok
var s_DynamicPoiAnchor = 'bottom';

function onclick_setDynamicPoiAnchor() {
	if(s_DynamicPoiAnchor == 'bottom') {
		s_DynamicPoiAnchor = 'center';
	}
	else {
		s_DynamicPoiAnchor = 'bottom';
	}
	setDynamicPoiAnchor('0', s_DynamicPoiAnchor);
}

// 28 -> ok
function onclick_directionPressUp() {
	// 1 up, 2 right, 3, down, 4 left
	directionPressUp(1);
}

// 29 -> ok
function onclick_directionPressDown() {
	// 1 up, 2 right, 3, down, 4 left
	directionPressDown(1);
}

// 30 -> ok
var s_setLanguageCode = 'EN';

function onclick_setLanguageCode() {
	if(s_setLanguageCode == 'EN') {
		s_setLanguageCode = 'KO';
	}
	else {
		s_setLanguageCode = 'EN';
	}
	setLanguageCode(s_setLanguageCode);
}

// 31
var s_setShowPoiColor = 0;

function onclick_setShowPoiColor() {
	setShowPoiColor('-1', '1', '#FF0000');

	if(s_setShowPoiColor == 0) {
		s_setShowPoiColor = 1;
		setShowPoiColor('POI000048', '1', '#FF0000');
	}
	else {
		s_setShowPoiColor = 0;
		setShowPoiColor('POI000048', '0', '#FF5533');
	}
}

// 32 -> ok
function onclick_setIconToolTipById() {
	setIconToolTipById('0', 'POI000048', 1, 1, 'FFFFFF', 20, 'routepoi_128_128.png', '1', '256,256', '384,384', '320,324', '320,384');
}

// 33 -> ok
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

	setIconToolTipByPosition('1', 5.0, 10.0, 0.0, 1, '#0000FF', 30, 'routepoi_128_128.png', '\u260E\nKOREA\nUSAAA', leftTop, rightBottom, TextPos, AnchorXY);
}

// 34
function onclick_changeTextureObject() {
	// changeTextureObject(id, orig_texname, new_texname);
}

// 35 -> ok
function onclick_releaseIconToolTip() {
	releaseIconToolTip('0');
	releaseIconToolTip('1');
}

// 36 -> ok
var s_SpeedZoom = 0;

function onclick_setSpeedZoomp() {
	s_SpeedZoom += 10;
	setSpeedZoom(s_SpeedZoom);
}

// 37 -> ok
function onclick_setCameraTargetPos() {
	setCameraTargetPos(-131.0, 1.34, -91.0);
}

// 38 -> ok
function onclick_setCameraPos() {
	setCameraPos(-58.549999, 1.49, -77.199997);
}

// 39 -> ok
function onclick_setCameraPathPos() {
	setCameraPathPos('100', '100', '0', '10', '10', '13');
}

// 40 -> ok
function onclick_getCameraPosition() {
	getCameraPosition();
}

// 41
var s_bshowPoiIconById = 'true';

function onclick_showPoiIconById() {
	if(s_bshowPoiIconById == 'true') {
		s_bshowPoiIconById = 'false';
	}
	else {
		s_bshowPoiIconById = 'true';
	}
	showPoiIconById(s_bshowPoiIconById, '-1');

}

// 42 -> ok
function onclick_cleanResource() {
	cleanResource();
}

// 43
function onclick_addDynamicPoiByPoiID() {
	addDynamicPoiByPoiID('0', 'POI000029', 0, 0, 128, 128, 'atlasimage.png', '2d', '0_init');
}

// 44 -> ok
var s_TouchRotateSpeed = 0;

function onclick_setTouchRotateSpeed() {
	s_TouchRotateSpeed -= 1.5;
	setTouchRotateSpeed(s_TouchRotateSpeed);
}

// 45 -> ok
var s_PressRotateSpeed = 0;

function onclick_setPressRotateSpeed() {
	s_PressRotateSpeed -= 1.5;
	setPressRotateSpeed(s_PressRotateSpeed);
};

// 46 -> ok
var s_PressAngleSpeed = 0;

function onclick_setPressAngleSpeed() {
	s_PressAngleSpeed -= 1.5;
	setPressAngleSpeed(s_PressAngleSpeed);
}

// 47 -> ok
function onclick_create3dObject() {
	create3dObject('0', 'information.fbx', '20.0');
}

// 48 -> ok
function onclick_set3dObjectPosition() {
	set3dObjectPosition('0', 40, 0, 40, 1, 0, 0);
}

// 49
var s_3dObjectViewType = '3d';

function onclick_set3dObjectViewType() {
	if(s_3dObjectViewType == '3d') {
		s_3dObjectViewType = '2d';
	}
	else {
		s_3dObjectViewType = '3d';
	}
	set3dObjectViewType('0', s_3dObjectViewType);
}

// 50 -> ok
var s_3dObjectVisible = 'true';

function onclick_set3dObjectVisible() {
	if(s_3dObjectVisible == 'true') {
		s_3dObjectVisible = 'false';
	}
	else {
		s_3dObjectVisible = 'true';
	}
	set3dObjectVisible('0', s_3dObjectVisible);
}

// 51 -> ok
function onclick_delete3dObject() {
	delete3dObject('0');
}

// 52-> ok
function onclick_createAirTag() {
	createAirTag('0');
	createAirTag('1');
}

// 53 -> ok
function onclick_setAirTagPosition() {
	setAirTagPosition('0', 0, 20, 0);
	setAirTagPosition('1', 10, 20, 10);
}

// 54 -> ok
function onclick_setAirTagPositionByPoiId() {
	setAirTagPositionByPoiId('0', 'POI000001');
	setAirTagPositionByPoiId('1', 'POI000003');
}

// 55 -> ok
function onclick_setAirTagBgImage() {
	setAirTagBgImage('0', 'poi_64_64.png', 0, 0, 256, 256);
	setAirTagBgImage('1', 'poi_64_64.png', 0, 0, 256, 256);
}

// 56 -> ok
function onclick_setAirTagIconImage() {
	setAirTagIconImage('0', 'poi_64_64.png', 256, 0, 64, 64, 170, 80);
	setAirTagIconImage('1', 'poi_64_64.png', 256, 0, 64, 64, 170, 80);
}

// 57 -> ok
var s_setAirTagTex = 0;

function onclick_setAirTagText() {
	if(s_setAirTagTex == 0) {
		setAirTagText('0', 'text_0_TTTT', 175, 85, '#FFFF00FF', 40);
		setAirTagText('1', 'text_0', 175, 85, '#FFFF00FF', 40);
		s_setAirTagTex = 1;
	}
	else {
		setAirTagText('0', 'text_1_XXXXX', 175, 85, '#FF0000FF', 20);
		setAirTagText('1', 'text_2_YYYYY', 175, 85, '#FF0000FF', 20);
		s_setAirTagTex = 0;
	}
}

// 58 -> ok
var s_AirTagAnchorType = 'bottom';

function onclick_setAirTagAnchorType() {
	if(s_AirTagAnchorType == 'bottom') {
		s_AirTagAnchorType = 'center';
	}
	else {
		s_AirTagAnchorType = 'bottom';
	}
	setAirTagAnchorType('0', s_AirTagAnchorType);
	setAirTagAnchorType('1', s_AirTagAnchorType);
}

// 59
var s_AirTagViewType = '3d';

function onclick_setAirTagViewType() {
	if(s_AirTagViewType == '3d') {
		s_AirTagViewType = '2d';
	}
	else {
		s_AirTagViewType = '3d';
	}
	setAirTagViewType('0', s_AirTagViewType);
	setAirTagViewType('1', s_AirTagViewType);
}

// 60 -> ok
var s_bAirTagVisible = 'true';

function onclick_setAirTagVisible() {
	if(s_bAirTagVisible == 'true') {
		s_bAirTagVisible = 'false';
	}
	else {
		s_bAirTagVisible = 'true';
	}
	setAirTagVisible('0', s_bAirTagVisible);
	setAirTagVisible('1', s_bAirTagVisible);
}

// 61 -> ok
function onclick_deleteAirTag() {
	deleteAirTag('0');
	deleteAirTag('1');
}

// 62 -> ok
var s_SpeedAngle = 0;

function onclick_setSpeedAngle() {
	s_SpeedAngle += 10;

	setSpeedAngle(s_SpeedAngle);
}

// 63 -> ok
var s_blockCamera = 'true';
var s_blockObjectTouch = 'true';

function onclick_setControlLock() {
	if(s_blockCamera == 'true') {
		s_blockCamera = 'false';
	}
	else {
		s_blockCamera = 'true';
	}

	if(s_blockObjectTouch == 'true') {
		s_blockObjectTouch = 'false';
	}
	else {
		s_blockObjectTouch = 'true';
	}

	setControlLock(s_blockCamera, s_blockObjectTouch);
}

// 64 -> ok
var s_bOutlineVisible = 'true';

function onclick_setOutlineVisible() {
	if(s_bOutlineVisible == 'true') {
		s_bOutlineVisible = 'false';
	}
	else {
		s_bOutlineVisible = 'true';
	}
	setOutlineVisible(s_bOutlineVisible);
}

// 65 -> ok
var s_setOutlineWidth = 0.1;

function onclick_setOutlineWidth() {
	s_setOutlineWidth += 0.1;
	setOutlineWidth(s_setOutlineWidth);
}

// 66 -> ok
var s_OutlineColor = '#FF0000';

function onclick_setOutlineColor() {
	if(s_OutlineColor == '#FF0000') {
		s_OutlineColor = '#00FF00';
	}
	else {
		s_OutlineColor = '#FF0000';
	}
	setOutlineColor(s_OutlineColor);
}

// 67 -> ok
function onclick_setDefaultOutline() {
	setDefaultOutline('#FF0000', 0.1);
}

// 68 -> ok
function onclick_setObjectOutline() {
	setObjectOutline('seo_977476558', '#FF0000', 0.3);
}

// 69 -> ok
function onclick_setObjectOriginalOutline() {
	setObjectOriginalOutline('seo_977476558');
}

// 70 -> ok
function onclick_setObjectColor() {
	setObjectColor('seo_977489290', '#FFFF00AA');
	setObjectColor('seo_977476558', '#00FFFFAA');
	setObjectColor('seo_975609740', '#00FF00AA');
	setObjectColor('seo_975532220', '#00FF00AA');
	setObjectColor('seo_975371415', '#FF000077');

	setObjectColor('poo_988139098', '#FFFF00AA');
}

// 71 -> ok
var s_ObjectTransparency = 255;

function onclick_setObjectTransparency() {
	// 0 - 255
	s_ObjectTransparency -= 40;
	setObjectTransparency('seo_977476558', s_ObjectTransparency);
	setObjectTransparency('seo_975609740', s_ObjectTransparency);
}

// 72
var s_bDeviceVisible = 'true';
var s_countDeviceVisible = 0;

function onclick_setDeviceVisible() {
	// beacon, ap, cctv
	if(s_bDeviceVisible == 'true') {
		s_bDeviceVisible = 'false';
	}
	else {
		s_bDeviceVisible = 'true';
	}

	if(s_countDeviceVisible == 0) {
		setDeviceVisible('beacon', s_bDeviceVisible);
		s_countDeviceVisible++;
	}
	else if(s_countDeviceVisible == 1) {
		setDeviceVisible('ap', s_bDeviceVisible);
		s_countDeviceVisible++;
	}

	else if(s_countDeviceVisible == 2) {
		setDeviceVisible('cctv', s_bDeviceVisible);
		s_countDeviceVisible = 0;
	}
}

// 73
function onclick_setObjectOriginalColor() {
	setObjectOriginalColor('0');
}

// 74 -> ok
var s_activateView = 'true';

function onclick_activateView() {
	if(s_activateView == 'true') {
		s_activateView = 'false';
	}
	else {
		s_activateView = 'true';
	}
	activateView(s_activateView);
}

// 75 -> ok
var s_bpinchZoom = 'true';
var s_bpinchAngle = 'true';

function onclick_lockPinchEvent() {
	if(s_bpinchZoom == 'true') {
		s_bpinchZoom = 'false';
	}
	else {
		s_bpinchZoom = 'true';
	}

	if(s_bpinchAngle == 'true') {
		s_bpinchAngle = 'false';
	}
	else {
		s_bpinchAngle = 'true';
	}
	lockPinchEvent(s_bpinchZoom, s_bpinchAngle);
}

// 76 -> ok
var s_LodEnabled = 'true';

function onclick_setLodEnabled() {
	if(s_LodEnabled == 'true') {
		s_LodEnabled = 'false';
	}
	else {
		s_LodEnabled = 'true';
	}
	setLodEnabled(s_LodEnabled);
}

// 77 -> ok
var s_PoiTouchRatio = 1.0;

function onclick_setPoiTouchRatio() {
	s_PoiTouchRatio += 1.0;
	setPoiTouchRatio(s_PoiTouchRatio);
}



// //------------------------------------------------------------
// // 테스트
// //------------------------------------------------------------
function init_map() {

	// loadingView(1, 'init_map');

	setMapDataPath('C:/MapData/');

	setProjectId(projectid_net); // 'PRJ000024');


	set_resolution_msg(g_unity_resolution_width, g_unity_resolution_height);

	set_frame_count(g_unity_frame_count);

	set_graphic_quality(g_unity_graphic_quality);

	setBackgroundColor('#F0F0F0');
	
	//
	//setCameraPathPos('100', '100', '0', '100', '100', '13');

	var checkSession_alram = sessionStorage.getItem('alramPopup_another_page');
	if(isdefined(checkSession_alram)) {
		// setBuilding_Node 에서 처리하도록 함.
		console.log('setInitCameraParam5');
		//setInitCameraParam(50.51357, -4.07246, 1300, 1, 1500);
		setInitCameraParam(55.00001, 0.4725055, 1500, 1, 2500);
	    //setCameraTargetPos(14.63107, 100, -99.96201);
	    //setCameraPos(12.8345, 411.1276, -317.8084);
		s_bLoadScene = true;
	}
	else {
		if(g_tab_state_sys == TAB_STATE_SYS.tab_emergency) {
			console.log('setInitCameraParam7');
			setInitCameraParam(55.00001, 0.4725055, 1500, 1, 2500);
		    //setCameraTargetPos(14.63107, 100, -99.96201);
		    //setCameraPos(12.8345, 411.1276, -317.8084);
		}
		else {
			console.log('setInitCameraParam8');
			setInitCameraParam(55.00001, 0.4725055, 1500, 1, 2500);
		    //setCameraTargetPos(14.63107, 100, -99.96201);
		    //setCameraPos(12.8345, 411.1276, -317.8084);
			//setInitCameraParam(50.51357, -4.07246, 1300, 1, 1500);
		}
		loadMap('SCN000001');
	}


}


var s_CurScene_ID;
var s_coord_camera_x = 0;
var s_coord_camera_y = 0;
var s_coord_camera_z = 0;


function ChangeScene(scene_id) {
	loadingView(1, 'ChangeScene');
	loadingMapView(1);

	s_CurScene_ID = scene_id;

	// 복원
	setOrig_ObjectColor();

	clear_AirTags();

	if(g_tab_state_sys == TAB_STATE_SYS.tab_emergency) {
		console.log('setInitCameraParam9');
		setInitCameraParam(55.00001, 0.4725055, 1500, 1, 2500);
	    //setCameraTargetPos(14.63107, 100, -99.96201);
	    //setCameraPos(12.8345, 411.1276, -317.8084);
	}
	else {
		console.log('setInitCameraParam10');
		setInitCameraParam(55.00001, 0.4725055, 1500, 1, 2500);
	    //setCameraTargetPos(14.63107, 100, -99.96201);
	    //setCameraPos(12.8345, 411.1276, -317.8084);
	}
	// 로드
	loadMap(scene_id);
}


// Scene_Floor
function setSelect_Floor(building_id, zone_id, cell_id, scene_id) {

	s_CurSelZoneID = zone_id;
	s_CurSelCellID = cell_id;

	s_CurScene_ID = scene_id; // GetSceneID_FromZoneID(zone_id);

	var _zone_node = GetZoneNode_FromZoneID(zone_id);
	s_CellNode = GetCellNode_ZoneNode(_zone_node, cell_id);


	s_current_layer_state = LAYER_STATE.ZONE;
	ChangeScene(s_CurScene_ID);
}


function clear_AirTags() {
	// 초기화

	// Hide_AirTags();

	if(s_AirTagHelper) {
		s_AirTagHelper.clear();
	}

	if(s_AirTag_NodeList != null) {
		s_AirTag_NodeList.length = 0;
	}
}

// ------------------------------------------------------------
//
// 맵 뷰어에서 오는 이벤트 처리
//
// ------------------------------------------------------------

var g_bOneEntyrLoadMap = false;

function on_loadmap(result_code, result_ms) {

	if(!g_use_old_socket) {

		sessionStorage.setItem('dashboard_page', '');
	}

	// 다시 table 요청

	if(isdefined(s_tableInfo)) {
		Send_Main_ToBridge('msg_table', s_tableInfo);
	}

	if(!g_bOneEntyrLoadMap) {
		// 로딩바
		setTimeout(function() {

			loadingView(0, 'on_loadmap');

		}, 400);
		// loadingView(0);
		g_bOneEntyrLoadMap = true;
	}


	s_bLoadScene = true;

	setTimeout(function() {

		if(g_req_listview_warning_tab_sys_alram) {
			loadingView(0, 'focusmove_listview_warning_request_sys_alram');
			g_req_listview_warning_tab_sys_alram = false;
		}
		loadingView(0, 'on_loadmap');
		loadingMapView(0);

		g_load_img_client = true;

	}, 400);
	// loadingMapView(0);

	// setDefaultOutline('#202020', 0.2);
	// setOutlineVisible('true');

	var camera_info = FindCameraTable(s_CurScene_ID);

//	if(camera_info) {
//		setCameraAngle(camera_info.angle);
//		setCameraRotation(camera_info.rotation);
//		setCameraZoom(camera_info.zoom);
//		setCameraPathPos(camera_info.camera_x, camera_info.camera_y, camera_info.camera_z, camera_info.target_x, camera_info.target_y, camera_info.target_z);
//	}


	Debug_Log_Msg('on_loadmap');

	// console.log('on_loadmap 1111');
	if(s_success_poi_info) {

		// console.log('on_loadmap 2222');
		on_final_load();
		// console.log('on_loadmap 3333');
	}
	else {
		// console.log('on_loadmap 4444');
		on_check_load();

		// console.log('on_loadmap 5555');
	}
	// //console.log('on_loadmap');
	// //-----------------------------------------------------------------------------
	// // AtlasHelper 사용법
	// //-----------------------------------------------------------------------------




	// if(s_AirTagHelper == null) {
	// s_AirTagHelper = new AirTagHelper;

	// // setup
	// s_AirTagHelper.setup();
	// }

	// //-----------------------------------------------------------------------------
	// // 메시지 처리
	// //-----------------------------------------------------------------------------
	// for (var i = 0; i < s_array_msg_scene_onload.length; i++) {
	// var stmsg = s_array_msg_scene_onload[i];

	// switch (stmsg.msg) {
	// case 'msg_worker_pos':
	// {
	// clear_AirTags();

	// var poi_id = stmsg.param_0;
	// s_AirTagHelper.showMyPosition(poi_id);

	// var info = getPoiInfo(poi_id);
	// if(info != null) {
	// moveMap(info.posX, info.posY, info.posZ);
	// }
	// }
	// break;
	// }
	// }

	// if(s_array_msg_scene_onload) {
	// s_array_msg_scene_onload.length = 0;
	// }


	// //-----------------------------------------------------------------------------
	// // 중점 구역 일 경우
	// //-----------------------------------------------------------------------------
	// if(s_tab_state == TAB_STATE.FOCUS_CONTROL) {
	// setOrig_ObjectColor();
	// }

	// //Update_Scene();

	// //-----------------------------------------------------------------------------
	// // 중점 구역 일 경우
	// //-----------------------------------------------------------------------------
	// if(s_tab_state == TAB_STATE.FOCUS_CONTROL) {
	// Update_ObjectTransparency();
	// }
	//Test_AirTagHelper();
}


function on_check_load() {

	setTimeout(function() {

		if(s_success_poi_info) {
			on_final_load();
		}
		else {
			on_check_load();
		}

	}, 100);
}

function on_final_load() {
	// -----------------------------------------------------------------------------
	// AtlasHelper 사용법
	// -----------------------------------------------------------------------------

	if(s_AirTagHelper == null) {
		s_AirTagHelper = new AirTagHelper;

		// setup
		s_AirTagHelper.setup();
	}

	// -----------------------------------------------------------------------------
	// 메시지 처리
	// -----------------------------------------------------------------------------
	for(var i = 0; i < s_array_msg_scene_onload.length; i++) {
		var stmsg = s_array_msg_scene_onload[i];

		switch(stmsg.msg) {
			case 'msg_worker_pos':
				clear_AirTags();

				var poi_id = stmsg.param_0;
				s_AirTagHelper.showMyPosition(poi_id);

				var info = getPoiInfo(poi_id);
				if(info != null) {
					moveMap(info.posX, info.posY, info.posZ);
				}
				break;
		}
	}

	if(s_array_msg_scene_onload) {
		s_array_msg_scene_onload.length = 0;
	}


	// -----------------------------------------------------------------------------
	// 중점 구역 일 경우
	if(s_tab_state == TAB_STATE.FOCUS_CONTROL) {
		setOrig_ObjectColor();
		Update_ObjectTransparency();
	}
	// 비상대피 구역 일 경우
	else if(s_tab_state == TAB_STATE.EMERGENCY) {
		Update_ObjectTransparency_Em();
	}
	// -----------------------------------------------------------------------------
}

function on_loadMapByPoiID(result_code, result_msg) {

}

function on_loadMapByCoordinate(result_code, result_msg) {

}

function on_getCurrentMapId(map_id) {

}

function on_initializeMap(result_code, result_msg) {

}

function on_onLoadStart() {

}

function on_getCameraState(angle, rotation, zoom) {
//	console.log('on_getCameraState angle :'+angle);
//	console.log('on_getCameraState rotation :'+rotation);
//	console.log('on_getCameraState zoom :'+zoom);
}

function on_getCameraPosition(vCameraPos_x, vCameraPos_y, vCameraPos_z, vTargetPos_x, vTargetPos_y, vTargetPos_z) {
//	console.log('!!!on_getCameraPosition vCameraPos_x :'+vCameraPos_x);
//	console.log('!!!on_getCameraPosition vCameraPos_y :'+vCameraPos_y);
//	console.log('!!!on_getCameraPosition vCameraPos_z :'+vCameraPos_z);
//	console.log('!!!on_getCameraPosition vTargetPos_x :'+vTargetPos_x);
//	console.log('!!!on_getCameraPosition vTargetPos_y :'+vTargetPos_y);
//	console.log('!!!on_getCameraPosition vTargetPos_z :'+vTargetPos_z);
}

function on_cleanResource() {

}

function on_onObjectTouched(objType, objId) {

	if(!IsLoadScene()) {
		return;
	}

	// 에어태그 위험경고현황 선택시 지역 선택시
	var select_airtag_zoneid_depth0 = null;

	// 터치
	switch(objType) {
		case 'AIRTAG':
			var airtag = s_AirTagHelper.getTag(objId);
			if(airtag) {

				// Main에게 전달
				var obj_type = '';
				var bChangeScene = false;
				if(objId.indexOf('SENSOR_') != -1) {
					obj_type = 'SENSOR';
				}

				if(objId.indexOf('AP_') != -1) {
					obj_type = 'AP';
				}

				if(objId.indexOf('WK_') != -1) {
					bChangeScene = true;
					obj_type = 'WK';
					
					console.log(' hTouchInfo airtag.poiId : '+airtag.poiId);

					var hTouchInfo = GetTouchInfo_FromPoiID(airtag.poiId);
					
					console.log(' hTouchInfo hTouchInfo.building_id : '+hTouchInfo.building_id);
					if(hTouchInfo) {
						Send_ToBridge_InMapViewer('SELECT_WORKER_CALLBACK', hTouchInfo.building_id, hTouchInfo.zone_id, hTouchInfo.cell_id, hTouchInfo.poi_id);
					}
				}

				if(objId.indexOf('CCTV_') != -1) {
					obj_type = 'CCTV';

					var hTouchInfo = GetTouchInfo_FromPoiID(airtag.poiId);

					// 직접 cctv 리스트 전달 처리
					if(hTouchInfo) {
						var array_cctv_list = GetCCTVPoiID_FromPoiID(hTouchInfo.poi_id);
						Send_ToBridge_InMapViewer('SELECT_CCTV_POI_CALLBACK', hTouchInfo.building_id, hTouchInfo.zone_id, hTouchInfo.cell_id, array_cctv_list[0]);
					}
				}

				if(objId.indexOf('VISIT_') != -1) {
					obj_type = 'VISIT';
				}

				if(objId.indexOf('MESSAGE_S_') != -1) {
					bChangeScene = true;
					obj_type = 'MESSAGE_S';
					var hTouchInfo = GetTouchInfo_FromPoiID(airtag.poiId);
					if(hTouchInfo) {

						switch(s_current_layer_state) {
							case LAYER_STATE.BUILDING:
								// 위험 경고 현황
								var _building_node = hTouchInfo.building_node; // GetBuilding_Node(hTouchInfo.poi_id);

								select_airtag_zoneid_depth0 = null;
								var select_type = null;

								if(objId.indexOf('violation') != -1) {
									if(_building_node.arr_zone_violation.length > 0) {
										select_airtag_zoneid_depth0 = _building_node.arr_zone_violation[0].zone.zone_id;

										select_type = 'invasion';

									}

								}
								if(objId.indexOf('imcall') != -1) {
									if(_building_node.arr_zone_imCall.length > 0) {
										select_airtag_zoneid_depth0 = _building_node.arr_zone_imCall[0].zone.zone_id;

										select_type = 'emergency';
									}
								}
								if(objId.indexOf('actionstop') != -1) {
									if(_building_node.arr_zone_actionstop.length > 0) {
										select_airtag_zoneid_depth0 = _building_node.arr_zone_actionstop[0].zone.zone_id;

										select_type = 'actionstop';
									}
								}

								if(objId.indexOf('gas') != -1) {
									if(_building_node.arr_zone_gas.length > 0) {
										select_airtag_zoneid_depth0 = _building_node.arr_zone_gas[0].zone.zone_id;

										select_type = 'gas';
									}
								}

								// Send_ToBridge_InMapViewer('SELECT_AIRTAG_POI_CALLBACK',
								// hTouchInfo.building_id,
								// select_airtag_zoneid_depth0,
								// hTouchInfo.cell_id,
								// hTouchInfo.poi_id);
								Send_ToBridge_InMapViewer('SELECT_AIRTAG_POI_CALLBACK', hTouchInfo.building_id, select_airtag_zoneid_depth0, hTouchInfo.cell_id, select_type);
								break;
							case LAYER_STATE.ZONE:
								// 위험 경고 현황
								var _cell_node = hTouchInfo.cell_node; // tBuilding_Node(hTouchInfo.cell_node);

								select_airtag_cellid_depth0 = null;
								var select_type = null;

								if(objId.indexOf('violation') != -1) {
									if(_cell_node.h_violation_use) {
										select_type = 'invasion';
									}

								}
								if(objId.indexOf('imcall') != -1) {
									if(_cell_node.h_imCall_use) {
										select_type = 'emergency';
									}
								}
								if(objId.indexOf('actionstop') != -1) {
									if(_cell_node.h_actionstop_use) {
										select_type = 'actionstop';
									}
								}

								if(objId.indexOf('gas') != -1) {
									if(_cell_node.h_gas_use) {
										select_type = 'gas';
									}
								}

								Send_ToBridge_InMapViewer('SELECT_AIRTAG_POI_CALLBACK', hTouchInfo.building_id, hTouchInfo.zone_id, hTouchInfo.cell_id, select_type);
								break;
						}
					}
				}

				if(objId.indexOf('MESSAGE_L_') != -1) {
					bChangeScene = true;
					obj_type = 'MESSAGE_L';
					var hTouchInfo = GetTouchInfo_FromPoiID(airtag.poiId);
					if(hTouchInfo) {
						switch(s_current_layer_state) {
							case LAYER_STATE.BUILDING:
								// 위험 경고 현황
								var _building_node = hTouchInfo.building_node; // GetBuilding_Node(hTouchInfo.poi_id);

								select_airtag_zoneid_depth0 = null;
								var select_type = null;

								// 2017_12_25 주석
								// if(objId.indexOf('violation') != -1)
								// {
								// if
								// (_building_node.arr_zone_violation.length
								// > 0) {
								// select_airtag_zoneid_depth0 =
								// _building_node.arr_zone_violation[0].zone.zone_id;

								// select_type = 'invasion';

								// }

								// }
								// if(objId.indexOf('imcall') != -1) {
								// if
								// (_building_node.arr_zone_imCall.length
								// > 0) {
								// select_airtag_zoneid_depth0 =
								// _building_node.arr_zone_imCall[0].zone.zone_id;

								// select_type = 'emergency';
								// }
								// }
								// if(objId.indexOf('actionstop') !=
								// -1) {
								// if
								// (_building_node.arr_zone_actionstop.length
								// > 0) {
								// select_airtag_zoneid_depth0 =
								// _building_node.arr_zone_actionstop[0].zone.zone_id;

								// select_type = 'actionstop';
								// }
								// }

								// if(objId.indexOf('gas') != -1) {
								// if
								// (_building_node.arr_zone_gas.length >
								// 0) {
								// select_airtag_zoneid_depth0 =
								// _building_node.arr_zone_gas[0].zone.zone_id;

								// select_type = 'gas';
								// }
								// }

								if(objId.indexOf('violation') != -1) {
									if(_building_node.arr_zone_violation.length > 0) {
										select_airtag_zoneid_depth0 = _building_node.arr_zone_violation[0].zone.zone_id;


									}
									select_type = 'non_authorize'; // invasion
									// 에서
									// non_authorize로
									// 변경

								}
								if(objId.indexOf('imcall') != -1) {
									if(_building_node.arr_zone_imCall.length > 0) {
										select_airtag_zoneid_depth0 = _building_node.arr_zone_imCall[0].zone.zone_id;

									}
									select_type = 'emergency';
								}
								if(objId.indexOf('actionstop') != -1) {
									if(_building_node.arr_zone_actionstop.length > 0) {
										select_airtag_zoneid_depth0 = _building_node.arr_zone_actionstop[0].zone.zone_id;

									}
									select_type = 'actionstop';
								}

								if(objId.indexOf('gas') != -1) {
									if(_building_node.arr_zone_gas.length > 0) {
										select_airtag_zoneid_depth0 = _building_node.arr_zone_gas[0].zone.zone_id;

									}
									select_type = 'gas';
								}


								// Send_ToBridge_InMapViewer('SELECT_AIRTAG_POI_CALLBACK',
								// hTouchInfo.building_id,
								// select_airtag_zoneid_depth0,
								// hTouchInfo.cell_id,
								// hTouchInfo.poi_id);
								Send_ToBridge_InMapViewer('SELECT_AIRTAG_POI_CALLBACK', hTouchInfo.building_id, select_airtag_zoneid_depth0, hTouchInfo.cell_id, select_type);
								break;
							case LAYER_STATE.ZONE:
								// 위험 경고 현황
								var _cell_node = hTouchInfo.cell_node; // tBuilding_Node(hTouchInfo.cell_node);

								select_airtag_cellid_depth0 = null;
								var select_type = null;

								if(objId.indexOf('violation') != -1) {
									if(_cell_node.h_violation_use) {
										select_type = 'invasion';
									}

								}
								if(objId.indexOf('imcall') != -1) {
									if(_cell_node.h_imCall_use) {
										select_type = 'emergency';
									}
								}
								if(objId.indexOf('actionstop') != -1) {
									if(_cell_node.h_actionstop_use) {
										select_type = 'actionstop';
									}
								}

								if(objId.indexOf('gas') != -1) {
									if(_cell_node.h_gas_use) {
										select_type = 'gas';
									}
								}
								
								Send_ToBridge_InMapViewer('SELECT_AIRTAG_POI_CALLBACK', hTouchInfo.building_id, hTouchInfo.zone_id, hTouchInfo.cell_id, select_type);
								break;
						}
					}
				}
				
				if(objId.indexOf('MESSAGE_EM_') != -1) {
					bChangeScene = true;
					// 비상대비구역 이벤트
					if(s_tab_state == TAB_STATE.EMERGENCY) {
						var hTouchInfo = GetTouchInfo_FromPoiID(airtag.poiId);
						if(hTouchInfo) {
							Send_ToBridge_InMapViewer('SELECT_WORKER_CALLBACK', hTouchInfo.building_id, hTouchInfo.zone_id, hTouchInfo.cell_id, hTouchInfo.poi_id);
							if(s_current_layer_state == LAYER_STATE.BUILDING) {
								var _building_node = hTouchInfo.building_node;
								var _zone_node = _building_node.zones[0].zone;
								$('#scene4_search_0').val(hTouchInfo.building_id).change();
								var scene4_search_1_val = $('#scene4_search_1').val();
								if(scene4_search_1_val == _zone_node.zone_id){
									$('#scene4_search_1').val(_zone_node.zone_id).change();
								}								
								$('#scene4_search_keyword').val('');
								Btn_Scene4_Search();
							}
						}
					}
				}
				
				if(objId.indexOf('POSITION_') != -1) {
					obj_type = 'POSITION';
				}

				if(bChangeScene) {
					switch(s_current_layer_state) {
						case LAYER_STATE.BUILDING:
							// 현재 빌딩이면
							// poi 선택시 층으로 이동
							if(select_airtag_zoneid_depth0) {
								// 위험 경고 현황

								s_CurSelZoneID = select_airtag_zoneid_depth0;
								var scene_id = GetSceneID_FromZoneID(s_CurSelZoneID);

								// console.log(scene_id);

								ChangeScene(scene_id);

								s_current_layer_state = LAYER_STATE.ZONE;

							}
							else {
								var build_node = GetBuilding_Node(airtag.poiId);
								if(build_node) {

									var rand_zone = Math.floor(Math.random() * build_node.zones.length);

									// 중점 관리 구역 일 경우 area 으로 이동 처리하도록
									// 한다.
									var zone_node = null;

									if(s_tab_state == TAB_STATE.FOCUS_CONTROL) {

										// 중점 관리 구역 일 경우
										if(isdefined(build_node)) {
											for(var g = 0; g < build_node.zones.length; g++) {
												var _zone_node = build_node.zones[g];
												if(_zone_node.watch_area_yn) {
													zone_node = _zone_node;
													break;
												}
											}
										}

										if(zone_node == null) {
											zone_node = GetZoneNode_Index(build_node, 0); // rand_zone);
										}
										if(zone_node) {

											s_CurSelZoneID = zone_node.zone.zone_id;
											console.log(7)
											ChangeScene(zone_node.zone.scene_id);
											s_current_layer_state = LAYER_STATE.ZONE;
										}
									}
									else {
										zone_node = GetZoneNode_Index(build_node, 0); // rand_zone);
										if(zone_node) {

											s_CurSelZoneID = zone_node.zone.zone_id;
											ChangeScene(zone_node.zone.scene_id);
											s_current_layer_state = LAYER_STATE.ZONE;
										}
									}
								}
							}
							break;
						case LAYER_STATE.ZONE:
							break;
					}
				}
			}
			break;
		case 'DEVICE':
			var xx = 0;
			break;
		case 'POI':
			var poi_id = objId;

			var hTouchInfo = GetTouchInfo_FromPoiID(poi_id);
			if(hTouchInfo) {

				if(s_tab_state == TAB_STATE.FOCUS_CONTROL) {
					var build_node = GetBuildingHandle_Node(hTouchInfo.building_id);
					if(build_node.watch_area_yn) {
						Send_ToBridge_InMapViewer('SELECT_WORKER_CALLBACK', hTouchInfo.building_id, hTouchInfo.zone_id, hTouchInfo.cell_id, hTouchInfo.poi_id);
					}
				}
				if(s_tab_state == TAB_STATE.EMERGENCY) {
					
				}
				else {
					Send_ToBridge_InMapViewer('SELECT_WORKER_CALLBACK', hTouchInfo.building_id, hTouchInfo.zone_id, hTouchInfo.cell_id, hTouchInfo.poi_id);
				}
			}

			if(s_current_layer_state == LAYER_STATE.BUILDING) {
				// 현재 빌딩이면
				// poi 선택시 층으로 이동
				var build_node = GetBuilding_Node(objId);
				if(build_node) {

					var zone_node = null;
					if(s_tab_state == TAB_STATE.FOCUS_CONTROL) {
						zone_node = GetZoneNode_Watch(build_node);
					}
					else {
						zone_node = GetZoneNode_Index(build_node, 0);
					}
					// var zone_node = GetZoneNode_Index(build_node, 0);
					// var zone_node = GetZoneNode_Watch(build_node);
					if(zone_node) {
						// 비상대비구역 이벤트
						if(s_tab_state == TAB_STATE.EMERGENCY) {
							var info = g_TableInfo.Safe_Emergency_Info;		// 비상대피 현황
							if(info != null) {
								var building_list = nvl(info.building_total_list, []);
								for(var i = 0; i < building_list.length; i++) {
									var _building_node = building_list[i];
									var zone_list = _building_node.zone_total_list;
									for(var j = 0; j < zone_list.length; j++) {
										var _zone_node = zone_list[j];
										if(zone_node.zone.zone_id == _zone_node.zone_id) {

											if(hTouchInfo) {
												Send_ToBridge_InMapViewer('SELECT_WORKER_CALLBACK', hTouchInfo.building_id, hTouchInfo.zone_id, hTouchInfo.cell_id, hTouchInfo.poi_id);
											}
											s_CurSelZoneID = zone_node.zone.zone_id;
											s_current_layer_state = LAYER_STATE.ZONE;
											ChangeScene(zone_node.zone.scene_id);
											$('#scene4_search_0').val(build_node.building.building_id).change();
											$('#scene4_search_1').val(s_CurSelZoneID).change();
											$('#scene4_search_keyword').val('');
											Btn_Scene4_Search();
											loadingView(0, 'scene4_search');
											break;
										}
									}
								}
							}
						}
						else {
							s_CurSelZoneID = zone_node.zone.zone_id;
							s_current_layer_state = LAYER_STATE.ZONE;
							ChangeScene(zone_node.zone.scene_id);
							// console.log(objId + ' ' + s_CurSelZoneID);
						}
					}
				}
			}
//			else if(s_current_layer_state == LAYER_STATE.ZONE) {
//				
//				// 비상대비구역 이벤트
//				if(s_tab_state == TAB_STATE.EMERGENCY) {
//					var cell_node = find_cell_node_from_poi_id(objId);
//					if(cell_node) {
//						var zone_node = find_zone_node_datamgr_from_id(cell_node.hcell.zone_id);
//						if(zone_node) {
//							$('#scene4_search_0').val(zone_node.hzone.building_id).change();
//							$('#scene4_search_1').val(cell_node.hcell.zone_id).change();
//							$('#scene4_search_2').val(cell_node.hcell.cell_id);
//							$('#scene4_search_keyword').val('');
//							Btn_Scene4_Search();
//							loadingView(0, 'scene4_search');
//						}
//					}
//				}
//			}
			break;
	}
}

// --------------------------------------------------------------
//
// AtlasImage
//
// --------------------------------------------------------------

function AtlasImage() {

	this.left = 0;
	this.top = 0;
	this.width = 0;
	this.height = 0;

	this.name = '';

	this.setPosition_3 = function(left, top, width) {
		this.left = left;
		this.top = top;
		this.width = width;
		this.height = width;
	}

	this.setPosition = function(left, top, width, height) {
		this.left = left;
		this.top = top;
		this.width = width - left;
		this.height = height - top;
	}

	this.setName = function(name) {
		this.name = name;
	}

}


// --------------------------------------------------------------
//
// AtlasHelper
//
// --------------------------------------------------------------
const WORKER_COLOR = {
	RED: 'RED',
	GREEN: 'GREEN',
	BLUE: 'BLUE',
}

const SAFE_STATE = {
	NORMAL: 'NORMAL',
	ERROR: 'ERROR',
	CHECK: 'CHECK',
	WARNING: 'WARNING',
}

const POI_BILLBOARD = {
	TYPE_2D: '2d',
	TYPE_3D: '3d',
}

const AIRTAG_POSITION = {
	LEFT_TOP: 'LEFT_TOP',
	RIGHT_TOP: 'RIGHT_TOP',
	LEFT_BOTTOM: 'LEFT_BOTTOM',
	RIGHT_BOTTOM: 'RIGHT_BOTTOM',
	TOP: 'TOP',
	BOTTOM: 'BOTTOM',
	LEFT: 'LEFT',
	RIGHT: 'RIGHT',
	CENTER: 'CENTER',
}


function AtlasHelper() {
	this.Name = 'atlasimage.png';

	this.getMyPosition = function() {
		var image = new AtlasImage();
		image.setPosition_3(0, 256, 128);
		image.setName(this.Name);
		return image;
	}

	this.getVisit = function() {
		var image = new AtlasImage();
		image.setPosition_3(384, 128, 128);
		image.setName(this.Name);
		return image;
	}

	this.getSensor = function() {
		var image = new AtlasImage();
		image.setPosition_3(128, 0, 128);
		image.setName(this.Name);
		return image;
	}

	this.getAp = function() {
		var image = new AtlasImage();
		image.setPosition_3(0, 0, 128);
		image.setName(this.Name);
		return image;
	}

	this.getWorker = function(color) {
		var image = new AtlasImage();
		switch(color) {
			case WORKER_COLOR.RED:
				image.setPosition_3(256, 128, 128);
				break;
			case WORKER_COLOR.BLUE:
				image.setPosition_3(128, 128, 128);
				break;
			case WORKER_COLOR.GREEN:
				image.setPosition_3(0, 128, 128);
				break;
			default:
				image.setPosition_3(0, 128, 128);

		}

		image.setName(this.Name);
		return image;
	}

	this.getMessageBoxSmall = function(state) {
		var image = new AtlasImage();
		switch(state) {
			case SAFE_STATE.ERROR:
				image.setPosition(0, 384, 228, 384 + 128);
				break;
			case SAFE_STATE.CHECK:
				image.setPosition(768, 384, 768 + 228, 384 + 128);
				break;
			case SAFE_STATE.WARNING:
				image.setPosition(512, 384, 512 + 228, 384 + 128);
				break;
			default:
				image.setPosition(256, 384, 256 + 228, 384 + 128);
				break;
		}

		image.setName(this.Name);
		return image;
	}
	
	this.getMessageBoxGas = function(state) {
		var image = new AtlasImage();
		switch(state) {
			case SAFE_STATE.ERROR:
				image.setPosition(0, 384, 228, 384 + 128);
				break;
			case SAFE_STATE.CHECK:
				image.setPosition(768, 384, 768 + 228, 384 + 128);
				break;
			case SAFE_STATE.WARNING:
				image.setPosition(512, 384, 512 + 228, 384 + 128);
				break;
			default:
				image.setPosition(256, 384, 256 + 228, 384 + 128);
				break;
		}

		image.setName(this.Name);
		return image;
	}

	this.getMessageBoxLarge = function(color) {
		var image = new AtlasImage();
		switch(color) {
			case SAFE_STATE.ERROR:
				image.setPosition(0, 512 + 81, 228, 512 + 81 + 175);
				break;
			case SAFE_STATE.CHECK:
				image.setPosition(256, 768 + 81, 256 + 228, 768 + 81 + 175);
				break;
			case SAFE_STATE.WARNING:
				image.setPosition(0, 768 + 81, 228, 768 + 81 + 175);
				break;
			default:
				image.setPosition(256, 512 + 81, 256 + 228, 512 + 81 + 175);
				break;
		}
		image.setName(this.Name);
		return image;
	}

	this.getCCTV = function(color) {
		var image = new AtlasImage();
		switch(color) {
			case SAFE_STATE.ERROR:
				image.setPosition_3(384, 0, 128);
				break;
			default:
				image.setPosition_3(256, 0, 128);
				break;
		}
		image.setName(this.Name);
		return image;
	}
}

// --------------------------------------------------------------
//
// HashMap
//
// --------------------------------------------------------------
var HashMap = function() {
	this.map = new Object();
}

HashMap.prototype = {
	put: function(key, value) {
		this.map[key] = value;
	},
	get: function(key) {
		return this.map[key];
	},
	containsKey: function(key) {
		return key in this.map;
	},
	containsValue: function(value) {
		for(var prop in this.map) {
			if(this.map[prop] == value) {
				return true;
			}
		}
		return false;
	},
	clear: function() {
		for(var prop in this.map) {
			delete this.map[prop];
		}
	},
	remove: function(key) {
		delete this.map[key];
	},
	keys: function() {
		var arKey = new Array();
		for(var prop in this.map) {
			arKey.push(prop);
		}
		return arKey;
	},
	values: function() {
		var arVal = new Array();
		for(var prop in this.map) {
			arVal.push(this.map[prop]);
		}
		return arVal;
	},
	size: function() {
		var count = 0;
		for(var prop in this.map) {
			count++;
		}
		return count;
	}
}

// --------------------------------------------------------------
//
// ArrayList
//
// --------------------------------------------------------------
ArrayList = function arrayList() {

	this.list = [];

	this.add = function(item) {
		this.list.push(item);
	};

	this.get = function(index) {
		return this.list[index];
	};

	this.removeAll = function() {
		this.list = [];
	};

	this.clear = function() {
		this.list = [];
	}

	this.size = function() {
		return this.list.length;
	};

	this.remove = function(index) {
		var newList = [];
		for(var i = 0; i < this.list.length; i++) {
			if(i != index) {
				newList.push(this.list[i]);
			};
		};
		this.list = newList;
	};

	this.remove_item = function(item) {
		var newList = [];
		for(var i = 0; i < this.list.length; i++) {
			if(item != this.list[i]) {
				newList.push(this.list[i]);
			};
		};
		this.list = newList;
	};
};

// --------------------------------------------------------------
//
// AirTag
//
// --------------------------------------------------------------
function AirTag(airTagId) {
	this.airTagId = airTagId;
	this.poiId;
	this.Background;
	this.Text;
	this.TextColor;
	this.TextSize;
	this.TextTopMargin;
	this.TextLeftMargin;
	this.Visible = 'true';
	this.Type;

	this.create = function() {
		createAirTag(this.airTagId);
	}

	this.getId = function() {
		return this.airTagId;
	}
	this.setPoiID = function(poiId) {
		this.poiId = poiId;
	}
	this.getPoiID = function() {
		return this.poiId;
	}
	this.setBackground = function(background) {
		this.Background = background;
	}
	this.setText = function(text) {
		this.Text = text;
	}
	this.setTextColor = function(text_color) {
		this.TextColor = text_color;
	}
	this.setTextSize = function(text_size) {
		this.TextSize = text_size;
	}
	this.setTextTopMargin = function(text_topMargin) {
		this.TextTopMargin = text_topMargin;
	}
	this.setTextLeftMargin = function(text_leftMargin) {
		this.TextLeftMargin = text_leftMargin;
	}
	this.setVisible = function(visible) {
		this.Visible = visible;
	}
	this.setType = function(Type) {
		this.Type = Type;
	}
	this.show = function() {

		setAirTagPositionByPoiId(this.airTagId, this.poiId);

		if(this.Background) {
			setAirTagBgImage(this.airTagId, this.Background.name, this.Background.left, this.Background.top, this.Background.width, this.Background.height);
		}
		setAirTagText(this.airTagId, this.Text, this.TextLeftMargin, this.TextTopMargin, this.TextColor, this.TextSize);
		setAirTagAnchorType(this.airTagId, 'bottom');
		setAirTagViewType(this.airTagId, '2d');
		setAirTagVisible(this.airTagId, this.Visible);
	}

	this.setTextEx = function(text) {
		this.Text = text;
		setAirTagText(this.airTagId, this.Text, this.TextLeftMargin, this.TextTopMargin, this.TextColor, this.TextSize);
	}
	
	this.setBackgroundEx = function (background) {
		
		this.Background = background;
		setAirTagBgImage(this.airTagId, this.Background.name, this.Background.left, this.Background.top, this.Background.width, this.Background.height);
	}

	this.destroy = function() {
		deleteAirTag(this.airTagId);
	}
}

// --------------------------------------------------------------
//
// PoiInfo
//
// --------------------------------------------------------------
function PoiInfo() {
	this.PosX;
	this.PosY;
	this.PosZ;

	this.getPosX = function() {
		return this.PosX;
	}
	this.getPosY = function() {
		return this.PosY;
	}
	this.getPosZ = function() {
		return this.PosZ;
	}
}

// --------------------------------------------------------------
//
// AirTagHelper
//
// --------------------------------------------------------------
function AirTagHelper() {

	this.tagMap;
	this.poiWidthMap;
	this.poiHeightMap;
	this.ismvr;

	this.hAtlasHelper;

	this.show_myPosition = false;
	this.airtag_id_myPosition;

	this.setshow_myPosition = function(bshow) {
		this.show_myPosition = bshow;
	}

	this.getshow_myPosition = function() {
		return this.show_myPosition;
	}

	this.setid_myPosition = function(airtag_id) {
		this.airtag_id_myPosition = airtag_id;
	}

	this.getid_myPositon = function() {
		return this.airtag_id_myPosition;
	}


	this.setup = function() {

		this.ismvr = true; // unity 연결 여부
		this.tagMap = new ArrayList();

		this.hAtlasHelper = new AtlasHelper();

		this.setPoiAreaList();
	}

	this.getAirtagMap = function() {
		return this.tagMap;
	}

	this.getAirtagByPoiId = function(poiId) {

		var airTags = new ArrayList();

		if(this.tagMap != null) {
			for(var i = 0; i < this.tagMap.size(); i++) {
				var airTag = this.tagMap.get(i);

				if(poiId == airTag.getPoiID()) {
					airTags.add(airTag);
				}
			}
		}

		return airTags;
	}

	this.showAll = function(bShow) {
		if(this.ismvr) {
			setAirTagVisible(null, bShow);
		}
	}

	this.clear = function() {

		if(this.tagMap != null) {
			var delAirtag = '';

			for(var i = 0; i < this.tagMap.size(); i++) {
				var airtag = this.tagMap.get(i);

				delAirtag += airtag.getId();

				if(i != this.tagMap.size() - 1) {
					delAirtag += ',';
				}
			}

			if(this.ismvr != null) {
				if(delAirtag != '') {
					deleteAirTag(delAirtag);
				}
			}
			this.tagMap.clear();
		}
	}

	this.delete = function(airTagId) {

		var delAirtag = null;

		if(this.tagMap != null) {

			for(var i = 0; i < this.tagMap.size(); i++) {
				var airtag = this.tagMap.get(i);
				if(airtag.getId() == airTagId) {
					delAirtag = airtag;
				}
			}
		}
		if(delAirtag != null) {
			if(this.ismvr) {
				deleteAirTag(delAirtag.getId());
			}
			this.tagMap.remove_item(delAirtag);
		}
	}

	String.format = function(format) {
		var args = Array.prototype.slice.call(arguments, 1);
		return format.replace(/{(\d+)}/g, function(match, number) {
			return typeof args[number] != 'undefined' ?
				args[number] :
				match;
		});
	};

	this.showSensor = function(poiId, count) {

		var airTagId = String.format('SENSOR_{0}_', poiId) + new Date().getTime() + 'guid_' + GetGuidCountAirTag();
		// this.releaseAirTag(airTagId);

		var sensorTag = this.showAirTag(poiId, airTagId, count, this.hAtlasHelper.getSensor());

		return sensorTag;
	}

	this.showAp = function(poiId, count) {

		var airTagId = String.format('AP_{0}_', poiId) + new Date().getTime() + 'guid_' + GetGuidCountAirTag();
		// this.releaseAirTag(airTagId);

		return this.showAirTag(poiId, airTagId, count, this.hAtlasHelper.getAp());
	}

	this.showWorker = function(poiId, count, color, type) {

		var airTagId = String.format('WK_{0}_', poiId) + new Date().getTime() + 'guid_' + GetGuidCountAirTag() + '_' + type;
		// this.releaseAirTag(airTagId);

		Debug_Log_Re_Msg('showWorker = ' + airTagId);

		return this.showAirTag(poiId, airTagId, count, this.hAtlasHelper.getWorker(color));
	}

	this.showCCTV = function(poiId, count, state, type) {

		var airTagId = String.format('CCTV_{0}_', poiId) + new Date().getTime() + 'guid_' + GetGuidCountAirTag() + '_' + type;
		// this.releaseAirTag(airTagId);

		return this.showAirTag(poiId, airTagId, count, this.hAtlasHelper.getCCTV(state));
	}

	this.showVisit = function(poiId, count) {

		var airTagId = String.format('VISIT_{0}_', poiId) + new Date().getTime() + 'guid_' + GetGuidCountAirTag();
		// this.releaseAirTag(airTagId);

		return this.showAirTag(poiId, airTagId, count, this.hAtlasHelper.getVisit());
	}

	this.showGasValue = function(poiId, message, state) {
		if(!this.isValid()) {
			return null;
		}

		var airTagId = String.format('MESSAGE_S_{0}_', poiId) + new Date().getTime() + 'guid_' + GetGuidCountAirTag();
		// this.releaseAirTag(airTagId);

		var tag = new AirTag(airTagId);
		tag.create();
		tag.setPoiID(poiId);
		tag.setBackground(this.hAtlasHelper.getMessageBoxSmall(state));
		tag.setText(message);
		tag.setTextColor('#ffffffff');
		tag.setTextSize(20);
		tag.setTextTopMargin(15);
		tag.setTextLeftMargin(10);
		tag.setVisible(false);

		this.tagMap.add(tag);
		// this.rePositionAirTag(poiId);

		tag.show();

		return tag;
	}

	this.showMessageBoxEm = function(poiId, message, state) {
		if(!this.isValid()) {
			return null;
		}

		var airTagId = String.format('MESSAGE_EM_{0}_', poiId) + new Date().getTime() + 'guid_' + GetGuidCountAirTag() + '_';
		// this.releaseAirTag(airTagId);

		var tag = new AirTag(airTagId);
		tag.create();
		tag.setPoiID(poiId);
		tag.setBackground(this.hAtlasHelper.getMessageBoxSmall(state));
		tag.setText(message);
		tag.setTextColor('#ffffffff');
		tag.setTextSize(20);
		tag.setTextTopMargin(20);
		tag.setTextLeftMargin(20);

		this.tagMap.add(tag);

		tag.show();

		return tag;
	}

	this.showMessageBoxSmall = function(poiId, message, state, type) {
		if(!this.isValid()) {
			return null;
		}

		var airTagId = String.format('MESSAGE_S_{0}_', poiId) + new Date().getTime() + 'guid_' + GetGuidCountAirTag() + '_' + type;
		// this.releaseAirTag(airTagId);

		var tag = new AirTag(airTagId);
		tag.create();
		tag.setPoiID(poiId);
		tag.setBackground(this.hAtlasHelper.getMessageBoxSmall(state));
		tag.setText(message);
		tag.setTextColor('#ffffffff');
		tag.setTextSize(20);
		tag.setTextTopMargin(20);
		tag.setTextLeftMargin(20);
//		tag.setVisible(false);

		this.tagMap.add(tag);
		// this.rePositionAirTag(poiId);

		tag.show();

		return tag;
	}

	this.showMessageBoxLarge = function(poiId, message, state, type) {
		if(!this.isValid()) {
			return null;
		}

		var airTagId = String.format('MESSAGE_L_{0}_', poiId) + new Date().getTime() + 'guid_' + GetGuidCountAirTag() + '_' + type;
		// this.releaseAirTag(airTagId);

		var tag = new AirTag(airTagId);
		tag.create();
		tag.setPoiID(poiId);
		tag.setBackground(this.hAtlasHelper.getMessageBoxLarge(state));
		tag.setText(message);
		tag.setTextColor('#ffffffff');
		tag.setTextSize(20);
		tag.setTextTopMargin(15);
		tag.setTextLeftMargin(10);
		tag.setVisible(false);

		this.tagMap.add(tag);
		// this.rePositionAirTag(poiId);

		tag.show();

		return tag;
	}

	this.showMyPosition = function(poiId) {
		if(!this.isValid()) {
			return null;
		}

		var airTagId = String.format('POSITION_{0}_', poiId) + new Date().getTime() + 'guid_' + GetGuidCountAirTag();
		// this.releaseAirTag(airTagId);

		var tag = new AirTag(airTagId);
		tag.create();
		tag.setPoiID(poiId);
		tag.setBackground(this.hAtlasHelper.getMyPosition());
		tag.setVisible(true);

		this.show_myPosition = true;
		this.airtag_id_myPosition = airTagId;

		this.tagMap.add(tag);
		// this.rePositionAirTag(poiId);

		tag.show();
		return tag;
	}

	this.showAirTag = function(poiId, airTagId, count, background) {

		return this.showAirTag_ex(poiId, airTagId, count, background, 72);
	}

	this.showAirTag_ex = function(poiId, airTagId, count, background, textTopMargin) {
		if(!this.isValid()) {
			return null;
		}

		var tag = new AirTag(airTagId);
		tag.create();
		tag.setPoiID(poiId);
		tag.setBackground(background);

		tag.setText(count);
		tag.setTextColor('#ffffffff');
		tag.setTextSize(20);
		tag.setTextTopMargin(textTopMargin);

		if(count >= 1000) {
			tag.setTextLeftMargin(40);
		}
		else if(count >= 100) {
			tag.setTextLeftMargin(46);
		}
		else if(count >= 10) {
			tag.setTextLeftMargin(52);
		}
		else {
			tag.setTextLeftMargin(58);
		}

		tag.setType(POI_BILLBOARD.TYPE_2D);


		this.tagMap.add(tag);
		// this.rePositionAirTag(poiId);

		tag.show();

		return tag;
	}

	this.releaseAirTag = function(airTagId) {

		for(var i = 0; i < this.tagMap.size(); i++) {
			var tag = this.tagMap.get(i);
			if(airTagId == tag.getId()) {
				tag.destroy();
				this.tagMap.remove_item(tag);
				// this.rePositionAirTag(tag.getPoiID());
				return;
			}
		}
	}

	this.getTag = function(airTagId) {
		var airTag = null;

		for(var i = 0; i < this.tagMap.size(); i++) {
			var tag = this.tagMap.get(i);
			if(airTagId == tag.getId()) {
				airTag = tag;
				break;
			}
		}
		return airTag;
	}

	this.getTagByPoi = function(poiId) {
		var airTags = new ArrayList();

		for(var i = 0; i < this.tagMap.size(); i++) {
			var tag = this.tagMap.get(i);
			if(poiId == tag.getPoiID()) {
				airTags.add(tag);
			}
		}
		return airTags;
	}

	this.rePositionAirTag = function(poiId) {

		var airTags_arr = this.getTagByPoi(poiId);
		var size = airTags_arr.size();
		if(size > 1) {
			for(var i = 0; i < airTags_arr.size(); i++) {
				var tag = airTags_arr.get(i);
				var position = AIRTAG_POSITION.LEFT_TOP;
				switch(i) {
					case 0:
						position = AIRTAG_POSITION.LEFT_TOP;
						break;
					case 1:
						position = AIRTAG_POSITION.RIGHT_BOTTOM;
						break;
					case 2:
						position = AIRTAG_POSITION.RIGHT_TOP;
						break;
					case 3:
						position = AIRTAG_POSITION.LEFT_BOTTOM;
						break;
					case 4:
						position = AIRTAG_POSITION.CENTER;
						break;
				}
				this.rePositionAirTag_3(tag.getId(), poiId, position);
			}
		}
		else if(airTags_arr.size() == 1) {
			var tag = airTags_arr.get(0);
			this.rePositionAirTag_3(tag.getId(), poiId, AIRTAG_POSITION.CENTER);
		}
	}


	this.rePositionAirTag_new = function(poiId) {

		var airTags_arr = this.getTagByPoi(poiId);
		var size = airTags_arr.size();
		if(size > 1) {
			for(var i = 0; i < airTags_arr.size(); i++) {
				var tag = airTags_arr.get(i);
				var position = AIRTAG_POSITION.LEFT_TOP;
				switch(i) {
					case 0:
						position = AIRTAG_POSITION.LEFT_TOP;
						break;
					case 1:
						position = AIRTAG_POSITION.RIGHT_BOTTOM;
						break;
					case 2:
						position = AIRTAG_POSITION.RIGHT_TOP;
						break;
					case 3:
						position = AIRTAG_POSITION.LEFT_BOTTOM;
						break;
					case 4:
						position = AIRTAG_POSITION.CENTER;
						break;
				}
				this.rePositionAirTag_3(tag.getId(), poiId, position);
			}
		}
		else if(airTags_arr.size() == 1) {
			var tag = airTags_arr.get(0);
			this.rePositionAirTag_3(tag.getId(), poiId, AIRTAG_POSITION.CENTER);
		}
	}


	this.isValid = function() {
		return this.tagMap != null;
	}

	this.rePositionAirTag_3 = function(airTagId, poiId, position) {

		var posX = 0;
		var posY = 0;
		var posZ = 0;

		var nXUnit = parseFloat(this.getPoiWidth(poiId) * 10 / 100);
		var nZUnit = parseFloat(this.getPoiHeight(poiId) * 50 / 100);

		var poiInfo;

		if(this.ismvr) {
			poiInfo = getPoiInfo(poiId);
		}
		
		if(poiInfo == null) {
			return;
		}
		
		posX = parseFloat(poiInfo.posX);
		posY = parseFloat(poiInfo.posY);
		posZ = parseFloat(poiInfo.posZ);

		switch(position) {
			case AIRTAG_POSITION.LEFT_TOP:
				posX -= nXUnit;
				posZ += nZUnit;
				break;
			case AIRTAG_POSITION.RIGHT_TOP:
				posX += nXUnit;
				posZ += nZUnit;
				break;
			case AIRTAG_POSITION.LEFT_BOTTOM:
				posX -= nXUnit;
				posZ -= nZUnit;
				break;
			case AIRTAG_POSITION.RIGHT_BOTTOM:
				posX += nXUnit;
				posZ -= nZUnit;
				break;
			case AIRTAG_POSITION.TOP:
				posZ += nZUnit;
				break;
			case AIRTAG_POSITION.BOTTOM:
				posZ -= nZUnit;
				break;
			case AIRTAG_POSITION.LEFT:
				posX -= nXUnit;
				break;
			case AIRTAG_POSITION.RIGHT:
				posX += nXUnit;
				break;
			case AIRTAG_POSITION.CENTER:
				break;
		}
		
		//debugger;
		
		//하동운영
//		switch(poiId) {
//		case 'POI000072':
//			posY = 10;
//			break;
//		case 'POI000073':
//			posY = 132;
//			break;
//		case 'POI000074':
//			posY = 1;
//			break;
//		case 'POI000075':
//			posY = 33;
//			break;
//		case 'POI000076':
//			posY = 33;
//			break;
//		case 'POI000077':
//			posY = 5;
//			break;
//		case 'POI000078':
//			posY = 125;
//			break;
//		case 'POI000079':
//			posY = 160;
//			break;
//		case 'POI000080':
//			posY = 134;
//			break;
//		case 'POI000081':
//			posY = 134;
//			break;
//		case 'POI000082':
//			posY = 134;
//			break;
//		case 'POI000083':
//			posY = 5;
//			break;
//		case 'POI000084':
//			posY = 5;
//			break;
//		case 'POI000085':
//			posY = 25;
//			break;
//		case 'POI000086':
//			posY = 30;
//			break;
//		case 'POI000087':
//			posY = 24;
//			break;
//		case 'POI000088':
//			posY = 5;
//			break;
//		case 'POI000089':
//			posY = 120;
//			break;
//		case 'POI000090':
//			posY = 120;
//			break;
//		case 'POI000091':
//			posY = 120;
//			break;
//		}
		
		//하동개발
//		switch(poiId) {
//		case 'POI000001':
//			posY = 10;
//			break;
//		case 'POI000002':
//			posY = 160;
//			break;
//		case 'POI000003':
//			posY = 1;
//			break;
//		case 'POI000004':
//			posY = 30;
//			break;
//		case 'POI000005':
//			posY = 30;
//			break;
//		case 'POI000006':
//			posY = 5;
//			break;
//		case 'POI000007':
//			posY = 160;
//			break;
//		case 'POI000008':
//			posY = 160;
//			break;
//		case 'POI000009':
//			posY = 160;
//			break;
//		case 'POI000010':
//			posY = 130;
//			break;
//		case 'POI000011':
//			posY = 160;
//			break;
//		case 'POI000012':
//			posY = 1;
//			break;
//		case 'POI000013':
//			posY = 20;
//			break;
//		case 'POI000014':
//			posY = 30;
//			break;
//		case 'POI000015':
//			posY = 20;
//			break;
//		case 'POI000016':
//			posY = 115;
//			break;
//		case 'POI000017':
//			posY = 115;
//			break;
//		case 'POI000018':
//			posY = 115;
//			break;
//		}

		if(this.ismvr) {
			setAirTagPosition(airTagId, posX, posY, posZ);  //2018.6.26 lkl 다른 화면과의 airTag 노출위치 syncf 를 위한 함수 변경
			//setAirTagPositionByPoiId( airTagId, poiId );
		}
	}

	this.getPoiWidth = function(poiId) {

		var defValue = 12;

		if(this.poiWidthMap != null && this.poiWidthMap.size() == 0) {
			this.setPoiAreaList();
		}

		if(this.poiWidthMap != null && this.poiWidthMap.get(poiId) != null) {
			defValue = this.poiWidthMap.get(poiId);
		}

		return defValue;
	}

	this.getPoiHeight = function(poiId) {

		var defValue = 12;

		if(this.poiHeightMap != null && this.poiHeightMap.size() == 0) {
			this.setPoiAreaList();
		}

		if(this.poiHeightMap != null && this.poiHeightMap.get(poiId) != null) {
			defValue = this.poiHeightMap.get(poiId);
		}

		return defValue;
	}

	this.CoordXComparator = function(p1, p2) {
		return(p1.x - p2.x);
	}

	this.CoordZComparator = function(p1, p2) {
		return(p1.z - p2.z);
	}

	this.setPoiAreaList = function() {

		if(this.poiWidthMap == null) {
			this.poiWidthMap = new HashMap();
		}
		else {
			this.poiWidthMap.clear();
		}

		if(this.poiHeightMap == null) {
			this.poiHeightMap = new HashMap();
		}
		else {
			this.poiHeightMap.clear();
		}

		if(s_PoiAreaList != null) {
			for(var i = 0; i < s_PoiAreaList.poiAreaList.length; i++) {
				var poiArea = s_PoiAreaList.poiAreaList[i];
				var poiId = poiArea.poiId;

				var coordList = poiArea.coordList;
				if(coordList != null && coordList.length >= 2) {

					coordList.sort(this.CoordXComparator);
					this.poiWidthMap.put(poiId, coordList[coordList.length - 1].x - coordList[0].x);

					coordList.sort(this.CoordZComparator);
					this.poiHeightMap.put(poiId, coordList[coordList.length - 1].z - coordList[0].z);
				}
			}
		}
	}
}

// ------------------------------------------------------
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

function PoiList_Action(poi_id) {
	var req = new PoiList_Request();

	var TempBasicURL = testBasicURL;
	TempBasicURL = TempBasicURL.split('.');
	TempBasicURL[0] = TempBasicURL[0].substring(7, TempBasicURL[0].length);
	var TempBasicURL_last = TempBasicURL[3].split(':');
	var mapBasicURL = 'http://' + TempBasicURL[0] + '.' + TempBasicURL[1] + '.' + TempBasicURL[2] + '.' + TempBasicURL_last[0] + ':' + g_MapServerPort;

	req.send_Request(mapBasicURL, '5678%^&*efgh', 'APP', projectid_net, poi_id, '', callback_success_PoiList, callback_fail_PoiList);
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

function PoiAreaList_Action() {

	var req = new PoiAreaList_Request();
	var TempBasicURL = testBasicURL;
	TempBasicURL = TempBasicURL.split('.');
	TempBasicURL[0] = TempBasicURL[0].substring(7, TempBasicURL[0].length);
	var TempBasicURL_last = TempBasicURL[3].split(':');
	var mapBasicURL = 'http://' + TempBasicURL[0] + '.' + TempBasicURL[1] + '.' + TempBasicURL[2] + '.' + TempBasicURL_last[0] + ':' + g_MapServerPort;

	req.send_Request(mapBasicURL, '5678%^&*efgh', 'APP', projectid_net, '', '', callback_success_PoiAreaList, callback_fail_PoiAreaList);

}


function callback_success_PoiAreaList(data) {
	var response = new PoiAreaList_Response();
	response.setData(data);

	s_PoiAreaList = response;

	var result = response.result_code;
	if(result == '0000') {}

	s_PoiTableMap.setPoiAreaList(s_PoiAreaList);
}

function callback_fail_PoiAreaList(data) {

	var ixx = 0;
}

function GetResponse_PoiListInfo() {

	// -----------------------------------------
	// poi/area/list
	// -----------------------------------------
	var data_area_list;
	if(testBasicURL.indexOf('218.55.23.196') != -1) {
		// 테스트 서버
		data_area_list = '{"header":{"resultCode":"0000","resultMsg":"Success"},"body":{"poiAreaList":[{"poiId":"POI000001","poiNmList":[{"langCd":"EN","name":"FABtest"},{"langCd":"KO","name":"FABtest"}],"sceneId":"","coordList":null,"createBy":"cosmoz","createDate":"2017-10-13 10:22:40.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000002","poiNmList":[{"langCd":"EN","name":"M15"},{"langCd":"KO","name":"M15"}],"sceneId":"SCN000001","coordList":[{"x":"104.00","z":"115.00"},{"x":"104.00","z":"-207.00"},{"x":"305.00","z":"-207.00"},{"x":"305.00","z":"115.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:22:41.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000005","poiNmList":[{"langCd":"EN","name":"동문"},{"langCd":"KO","name":"동문"}],"sceneId":"","coordList":null,"createBy":"cosmoz","createDate":"2017-10-13 10:22:51.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000006","poiNmList":[{"langCd":"EN","name":"서문"},{"langCd":"KO","name":"서문"}],"sceneId":"","coordList":null,"createBy":"cosmoz","createDate":"2017-10-13 10:22:52.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000009","poiNmList":[{"langCd":"EN","name":"근로자쉼터"},{"langCd":"KO","name":"근로자쉼터"}],"sceneId":"SCN000002","coordList":[{"x":"-25.04","z":"-195.05"},{"x":"-10.07","z":"-194.92"},{"x":"-9.94","z":"-210.62"},{"x":"-24.99","z":"-210.55"}],"createBy":"cosmoz","createDate":"2017-10-13 10:22:53.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000010","poiNmList":[{"langCd":"EN","name":"북문(사람OUT)"},{"langCd":"KO","name":"북문(사람OUT)"}],"sceneId":"SCN000016","coordList":[{"x":"147.00","z":"250.00"},{"x":"147.00","z":"230.00"},{"x":"187.00","z":"230.00"},{"x":"187.00","z":"250.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:22:54.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000011","poiNmList":[{"langCd":"EN","name":"북문(사람IN)"},{"langCd":"KO","name":"북문(사람IN)"}],"sceneId":"SCN000016","coordList":[{"x":"147.00","z":"229.00"},{"x":"147.00","z":"209.00"},{"x":"187.00","z":"209.00"},{"x":"187.00","z":"229.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:22:56.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000012","poiNmList":[{"langCd":"EN","name":"FAB_B1F"},{"langCd":"KO","name":"FAB_B1F"}],"sceneId":"SCN000020","coordList":[{"x":"-171.00","z":"90.00"},{"x":"-171.00","z":"-91.00"},{"x":"176.00","z":"-91.00"},{"x":"176.00","z":"90.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:22:57.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000013","poiNmList":[{"langCd":"EN","name":"FAB_1F"},{"langCd":"KO","name":"FAB_1F"}],"sceneId":"SCN000021","coordList":[{"x":"-166.00","z":"76.50"},{"x":"-166.00","z":"-98.50"},{"x":"174.00","z":"-98.50"},{"x":"174.00","z":"76.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:22:57.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000014","poiNmList":[{"langCd":"EN","name":"FAB_2F"},{"langCd":"KO","name":"FAB_2F"}],"sceneId":"SCN000022","coordList":[{"x":"-165.00","z":"76.50"},{"x":"-165.00","z":"-98.50"},{"x":"175.00","z":"-98.50"},{"x":"175.00","z":"76.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:22:57.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000015","poiNmList":[{"langCd":"EN","name":"FAB_3F"},{"langCd":"KO","name":"FAB_3F"}],"sceneId":"SCN000023","coordList":[{"x":"-165.00","z":"77.50"},{"x":"-165.00","z":"-97.50"},{"x":"175.00","z":"-97.50"},{"x":"175.00","z":"77.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:22:58.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000016","poiNmList":[{"langCd":"EN","name":"FAB_4F"},{"langCd":"KO","name":"FAB_4F"}],"sceneId":"SCN000024","coordList":[{"x":"-166.74","z":"78.50"},{"x":"-166.74","z":"-96.50"},{"x":"172.74","z":"-96.50"},{"x":"172.74","z":"78.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:22:58.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000017","poiNmList":[{"langCd":"EN","name":"CUB_1F"},{"langCd":"KO","name":"CUB_1F"}],"sceneId":"SCN000026","coordList":[{"x":"-99.00","z":"37.50"},{"x":"-99.00","z":"-12.50"},{"x":"94.00","z":"-12.50"},{"x":"94.00","z":"37.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:22:59.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000018","poiNmList":[{"langCd":"EN","name":"WWT_B1F"},{"langCd":"KO","name":"WWT_B1F"}],"sceneId":"","coordList":null,"createBy":"cosmoz","createDate":"2017-10-13 10:22:59.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000019","poiNmList":[{"langCd":"EN","name":"WWT_1F"},{"langCd":"KO","name":"WWT_1F"}],"sceneId":"SCN000036","coordList":[{"x":"-79.55","z":"65.63"},{"x":"-78.93","z":"-59.46"},{"x":"89.55","z":"-59.80"},{"x":"89.18","z":"65.80"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:00.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000020","poiNmList":[{"langCd":"EN","name":"CUB"},{"langCd":"KO","name":"CUB"}],"sceneId":"SCN000001","coordList":[{"x":"-169.50","z":"179.35"},{"x":"24.52","z":"179.95"},{"x":"24.90","z":"130.58"},{"x":"10.10","z":"130.84"},{"x":"10.11","z":"128.82"},{"x":"-156.44","z":"128.45"},{"x":"-156.57","z":"130.17"},{"x":"-169.05","z":"129.99"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:00.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000021","poiNmList":[{"langCd":"EN","name":"WWT"},{"langCd":"KO","name":"WWT"}],"sceneId":"SCN000001","coordList":[{"x":"-278.43","z":"-111.30"},{"x":"-278.81","z":"-150.96"},{"x":"-285.50","z":"-150.94"},{"x":"-284.60","z":"-236.25"},{"x":"-225.13","z":"-236.22"},{"x":"-225.05","z":"-212.56"},{"x":"-122.10","z":"-212.20"},{"x":"-122.91","z":"-169.19"},{"x":"-115.50","z":"-168.98"},{"x":"-115.54","z":"-111.15"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:01.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000022","poiNmList":[{"langCd":"EN","name":"북문"},{"langCd":"KO","name":"북문"}],"sceneId":"SCN000001","coordList":[{"x":"77.15","z":"249.52"},{"x":"77.00","z":"219.60"},{"x":"137.60","z":"219.50"},{"x":"137.49","z":"250.10"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:01.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000023","poiNmList":[{"langCd":"EN","name":"남문"},{"langCd":"KO","name":"남문"}],"sceneId":"SCN000001","coordList":[{"x":"-80.69","z":"-220.40"},{"x":"-80.90","z":"-240.20"},{"x":"-63.90","z":"-240.06"},{"x":"-64.21","z":"-220.77"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:01.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000024","poiNmList":[{"langCd":"EN","name":"남문(IN)"},{"langCd":"KO","name":"남문(IN)"}],"sceneId":"SCN000018","coordList":[{"x":"-97.00","z":"-199.00"},{"x":"-97.00","z":"-229.00"},{"x":"-37.00","z":"-229.00"},{"x":"-37.00","z":"-199.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:02.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000025","poiNmList":[{"langCd":"EN","name":"남문(OUT)"},{"langCd":"KO","name":"남문(OUT)"}],"sceneId":"SCN000018","coordList":[{"x":"-97.00","z":"-231.00"},{"x":"-97.00","z":"-261.00"},{"x":"-37.00","z":"-261.00"},{"x":"-37.00","z":"-231.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:02.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000026","poiNmList":[{"langCd":"EN","name":"북문(차량IN)"},{"langCd":"KO","name":"북문(차량IN)"}],"sceneId":"SCN000016","coordList":[{"x":"78.00","z":"229.00"},{"x":"78.00","z":"199.00"},{"x":"138.00","z":"199.00"},{"x":"138.00","z":"229.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:03.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000027","poiNmList":[{"langCd":"EN","name":"북문(차량OUT)"},{"langCd":"KO","name":"북문(차량OUT)"}],"sceneId":"SCN000016","coordList":[{"x":"78.00","z":"260.00"},{"x":"78.00","z":"230.00"},{"x":"138.00","z":"230.00"},{"x":"138.00","z":"260.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:03.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000028","poiNmList":[{"langCd":"EN","name":"FAB"},{"langCd":"KO","name":"FAB"}],"sceneId":"SCN000001","coordList":[{"x":"-263.20","z":"98.34"},{"x":"-263.13","z":"-89.60"},{"x":"96.80","z":"-88.64"},{"x":"96.60","z":"100.40"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:04.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000029","poiNmList":[{"langCd":"EN","name":"저수조"},{"langCd":"KO","name":"저수조"}],"sceneId":"SCN000001","coordList":[{"x":"-300.00","z":"215.00"},{"x":"-200.00","z":"215.00"},{"x":"-200.00","z":"115.00"},{"x":"-300.00","z":"115.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:04.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000030","poiNmList":[{"langCd":"EN","name":"FAB_외각"},{"langCd":"KO","name":"FAB_외각"}],"sceneId":"SCN000002","coordList":[{"x":"-99.90","z":"119.85"},{"x":"-99.67","z":"92.65"},{"x":"-20.03","z":"93.07"},{"x":"-19.70","z":"120.55"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:05.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000031","poiNmList":[{"langCd":"EN","name":"E01"},{"langCd":"KO","name":"E01"}],"sceneId":"","coordList":null,"createBy":"cosmoz","createDate":"2017-10-13 10:23:05.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000032","poiNmList":[{"langCd":"EN","name":"가설식당"},{"langCd":"KO","name":"가설식당"}],"sceneId":"SCN000001","coordList":[{"x":"216.70","z":"182.43"},{"x":"250.26","z":"182.65"},{"x":"250.70","z":"122.77"},{"x":"217.14","z":"122.55"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:06.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000033","poiNmList":[{"langCd":"EN","name":"주차장"},{"langCd":"KO","name":"주차장"}],"sceneId":"","coordList":null,"createBy":"cosmoz","createDate":"2017-10-13 10:23:06.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000034","poiNmList":[{"langCd":"EN","name":"S21"},{"langCd":"KO","name":"S21"}],"sceneId":"SCN000037","coordList":[{"x":"-283.80","z":"204.95"},{"x":"-283.31","z":"157.38"},{"x":"-232.00","z":"157.25"},{"x":"-232.33","z":"204.66"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:06.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000035","poiNmList":[{"langCd":"EN","name":"154K"},{"langCd":"KO","name":"154K"}],"sceneId":"SCN000001","coordList":[{"x":"153.00","z":"208.00"},{"x":"193.00","z":"208.00"},{"x":"193.00","z":"120.15"},{"x":"153.06","z":"120.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:07.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000036","poiNmList":[{"langCd":"EN","name":"가설식당-2"},{"langCd":"KO","name":"가설식당-2"}],"sceneId":"SCN000041","coordList":[{"x":"216.70","z":"182.43"},{"x":"250.26","z":"182.65"},{"x":"250.70","z":"122.77"},{"x":"217.14","z":"122.55"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:07.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000038","poiNmList":[{"langCd":"EN","name":"E01_154K"},{"langCd":"KO","name":"E01_154K"}],"sceneId":"SCN000039","coordList":[{"x":"149.60","z":"205.65"},{"x":"188.40","z":"205.65"},{"x":"188.40","z":"122.10"},{"x":"149.65","z":"121.95"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:08.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000039","poiNmList":[{"langCd":"EN","name":"A1"},{"langCd":"KO","name":"A1"}],"sceneId":"SCN000032","coordList":[{"x":"-79.10","z":"64.50"},{"x":"-60.41","z":"64.46"},{"x":"-60.10","z":"19.43"},{"x":"-79.03","z":"19.30"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:09.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000040","poiNmList":[{"langCd":"EN","name":"A2"},{"langCd":"KO","name":"A2"}],"sceneId":"SCN000032","coordList":[{"x":"-53.11","z":"58.00"},{"x":"-59.91","z":"58.00"},{"x":"-59.91","z":"21.00"},{"x":"-56.02","z":"21.00"},{"x":"-56.02","z":"26.00"},{"x":"-53.11","z":"26.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:09.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000041","poiNmList":[{"langCd":"EN","name":"A3"},{"langCd":"KO","name":"A3"}],"sceneId":"SCN000032","coordList":[{"x":"-44.24","z":"64.41"},{"x":"-44.24","z":"39.61"},{"x":"-36.34","z":"39.61"},{"x":"-36.34","z":"64.41"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:10.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000042","poiNmList":[{"langCd":"EN","name":"A4"},{"langCd":"KO","name":"A4"}],"sceneId":"SCN000032","coordList":[{"x":"-44.15","z":"39.36"},{"x":"-44.15","z":"20.56"},{"x":"-36.25","z":"20.56"},{"x":"-36.25","z":"39.36"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:10.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000043","poiNmList":[{"langCd":"EN","name":"A5"},{"langCd":"KO","name":"A5"}],"sceneId":"SCN000032","coordList":[{"x":"-36.11","z":"64.55"},{"x":"-36.11","z":"16.05"},{"x":"-20.11","z":"16.05"},{"x":"-20.11","z":"64.55"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:11.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000044","poiNmList":[{"langCd":"EN","name":"A6"},{"langCd":"KO","name":"A6"}],"sceneId":"SCN000032","coordList":[{"x":"-78.50","z":"3.50"},{"x":"-70.50","z":"3.41"},{"x":"-70.54","z":"-57.50"},{"x":"-78.50","z":"-57.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:11.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000045","poiNmList":[{"langCd":"EN","name":"A7"},{"langCd":"KO","name":"A7"}],"sceneId":"SCN000032","coordList":[{"x":"-70.00","z":"3.50"},{"x":"-61.00","z":"3.41"},{"x":"-61.05","z":"-57.50"},{"x":"-70.00","z":"-57.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:12.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000046","poiNmList":[{"langCd":"EN","name":"A8"},{"langCd":"KO","name":"A8"}],"sceneId":"SCN000032","coordList":[{"x":"-60.00","z":"3.50"},{"x":"-21.00","z":"3.41"},{"x":"-21.20","z":"-57.50"},{"x":"-60.00","z":"-57.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:12.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000047","poiNmList":[{"langCd":"EN","name":"B1"},{"langCd":"KO","name":"B1"}],"sceneId":"SCN000032","coordList":[{"x":"61.43","z":"38.60"},{"x":"61.35","z":"7.00"},{"x":"88.05","z":"7.17"},{"x":"88.05","z":"38.60"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:13.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000048","poiNmList":[{"langCd":"EN","name":"B2"},{"langCd":"KO","name":"B2"}],"sceneId":"SCN000032","coordList":[{"x":"61.73","z":"52.50"},{"x":"61.65","z":"39.50"},{"x":"88.35","z":"39.57"},{"x":"88.35","z":"52.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:13.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000049","poiNmList":[{"langCd":"EN","name":"B3"},{"langCd":"KO","name":"B3"}],"sceneId":"SCN000032","coordList":[{"x":"31.47","z":"51.70"},{"x":"50.20","z":"51.49"},{"x":"49.85","z":"16.17"},{"x":"31.40","z":"16.10"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:14.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000050","poiNmList":[{"langCd":"EN","name":"B4"},{"langCd":"KO","name":"B4"}],"sceneId":"SCN000032","coordList":[{"x":"-19.85","z":"65.38"},{"x":"-19.81","z":"15.33"},{"x":"31.25","z":"15.21"},{"x":"31.15","z":"65.33"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:14.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000051","poiNmList":[{"langCd":"EN","name":"A복도"},{"langCd":"KO","name":"A복도"}],"sceneId":"SCN000032","coordList":[{"x":"-78.69","z":"14.75"},{"x":"-79.13","z":"7.75"},{"x":"60.87","z":"7.79"},{"x":"60.87","z":"14.75"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:18.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000052","poiNmList":[{"langCd":"EN","name":"B복도"},{"langCd":"KO","name":"B복도"}],"sceneId":"SCN000032","coordList":[{"x":"50.82","z":"65.09"},{"x":"50.79","z":"14.09"},{"x":"60.79","z":"14.36"},{"x":"60.79","z":"65.09"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:19.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000053","poiNmList":[{"langCd":"EN","name":"북서문(IN)"},{"langCd":"KO","name":"북서문(IN)"}],"sceneId":"SCN000043","coordList":[{"x":"-343.50","z":"179.00"},{"x":"-343.50","z":"159.00"},{"x":"-308.50","z":"159.00"},{"x":"-308.50","z":"179.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:19.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000054","poiNmList":[{"langCd":"EN","name":"북서문(OUT)"},{"langCd":"KO","name":"북서문(OUT)"}],"sceneId":"SCN000043","coordList":[{"x":"-355.50","z":"202.00"},{"x":"-355.50","z":"182.00"},{"x":"-320.50","z":"182.00"},{"x":"-320.50","z":"202.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:20.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000055","poiNmList":[{"langCd":"EN","name":"북서문"}],"sceneId":"SCN000001","coordList":[{"x":"-352.45","z":"198.12"},{"x":"-352.50","z":"178.56"},{"x":"-332.50","z":"178.50"},{"x":"-332.54","z":"198.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:20.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000056","poiNmList":[{"langCd":"EN","name":"FAB_5F"}],"sceneId":"SCN000045","coordList":[{"x":"-166.74","z":"78.50"},{"x":"-166.74","z":"-96.50"},{"x":"172.74","z":"-96.50"},{"x":"172.74","z":"78.50"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:21.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000057","poiNmList":[{"langCd":"EN","name":"공동구1"},{"langCd":"KO","name":"공동구1"}],"sceneId":"SCN000046","coordList":[{"x":"-44.20","z":"45.30"},{"x":"-31.20","z":"45.30"},{"x":"-31.26","z":"-57.90"},{"x":"-44.14","z":"-57.90"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:21.0","updateDate":"2017-10-13 10:51:35.0"},{"poiId":"POI000058","poiNmList":[{"langCd":"EN","name":"공동구2"},{"langCd":"KO","name":"공동구2"}],"sceneId":"SCN000047","coordList":[{"x":"-60.00","z":"-20.00"},{"x":"-60.00","z":"-50.00"},{"x":"-35.00","z":"-50.00"},{"x":"-35.00","z":"-20.00"}],"createBy":"cosmoz","createDate":"2017-10-13 10:23:22.0","updateDate":"2017-10-13 10:51:35.0"}]}}';
	}
	else {
		data_area_list = '{"header":{"resultCode":"0000","resultMsg":"Success"},"body":{"poiAreaList":[{"poiId":"POI000085","poiNmList":[{"langCd":"EN","name":"전력공동구"},{"langCd":"KO","name":"전력공동구"}],"sceneId":"SCN000051","coordList":[{"x":"149.60","z":"205.65"},{"x":"188.40","z":"205.65"},{"x":"188.40","z":"122.10"},{"x":"149.65","z":"121.95"}],"createBy":"cosmoz","createDate":"2017-10-18 09:54:51.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000073","poiNmList":[{"langCd":"EN","name":"B103"},{"langCd":"KO","name":"B103"}],"sceneId":"SCN000050","coordList":[{"x":"-319.00","z":"145.00"},{"x":"-319.00","z":"121.00"},{"x":"-232.00","z":"121.00"},{"x":"-232.00","z":"145.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:37:31.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000075","poiNmList":[{"langCd":"EN","name":"저수조기계실"},{"langCd":"KO","name":"저수조기계실"}],"sceneId":"SCN000050","coordList":[{"x":"-231.00","z":"203.00"},{"x":"-231.00","z":"121.00"},{"x":"-193.00","z":"121.00"},{"x":"-193.00","z":"203.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:37:33.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000087","poiNmList":[{"langCd":"EN","name":"CUB_3F"},{"langCd":"KO","name":"CUB_3F"}],"sceneId":"SCN000053","coordList":[{"x":"-97.50","z":"45.00"},{"x":"-97.50","z":"-11.00"},{"x":"97.50","z":"-11.00"},{"x":"97.50","z":"45.00"}],"createBy":"cosmoz","createDate":"2017-11-03 18:43:58.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000056","poiNmList":[{"langCd":"EN","name":"FAB_5F"},{"langCd":"KO","name":"FAB_5F"}],"sceneId":"SCN000054","coordList":[{"x":"-166.74","z":"78.50"},{"x":"-166.74","z":"-96.50"},{"x":"172.74","z":"-96.50"},{"x":"172.74","z":"78.50"}],"createBy":"cosmoz","createDate":"2017-09-29 17:05:21.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000146","poiNmList":[{"langCd":"EN","name":"B6"}],"sceneId":"SCN000036","coordList":[{"x":"1.50","z":"20.00"},{"x":"1.50","z":"15.00"},{"x":"30.50","z":"15.00"},{"x":"30.50","z":"20.00"}],"createBy":"cosmoz","createDate":"2017-12-22 17:00:05.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000147","poiNmList":[{"langCd":"EN","name":"B7"}],"sceneId":"SCN000036","coordList":[{"x":"49.50","z":"50.00"},{"x":"49.50","z":"45.00"},{"x":"78.50","z":"45.00"},{"x":"78.50","z":"50.00"}],"createBy":"cosmoz","createDate":"2017-12-22 17:00:06.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000148","poiNmList":[{"langCd":"EN","name":"B8"}],"sceneId":"SCN000036","coordList":[{"x":"49.50","z":"44.00"},{"x":"49.50","z":"39.00"},{"x":"78.50","z":"39.00"},{"x":"78.50","z":"44.00"}],"createBy":"cosmoz","createDate":"2017-12-22 17:00:06.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000149","poiNmList":[{"langCd":"EN","name":"B9"}],"sceneId":"SCN000036","coordList":[{"x":"49.50","z":"38.00"},{"x":"49.50","z":"33.00"},{"x":"78.50","z":"33.00"},{"x":"78.50","z":"38.00"}],"createBy":"cosmoz","createDate":"2017-12-22 17:00:07.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000150","poiNmList":[{"langCd":"EN","name":"B10"}],"sceneId":"SCN000036","coordList":[{"x":"49.50","z":"32.00"},{"x":"49.50","z":"27.00"},{"x":"78.50","z":"27.00"},{"x":"78.50","z":"32.00"}],"createBy":"cosmoz","createDate":"2017-12-22 17:00:07.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000151","poiNmList":[{"langCd":"EN","name":"B11"}],"sceneId":"SCN000036","coordList":[{"x":"49.50","z":"26.00"},{"x":"49.50","z":"21.00"},{"x":"78.50","z":"21.00"},{"x":"78.50","z":"26.00"}],"createBy":"cosmoz","createDate":"2017-12-22 17:00:08.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000152","poiNmList":[{"langCd":"EN","name":"B12"}],"sceneId":"SCN000036","coordList":[{"x":"49.50","z":"20.00"},{"x":"49.50","z":"15.00"},{"x":"78.50","z":"15.00"},{"x":"78.50","z":"20.00"}],"createBy":"cosmoz","createDate":"2017-12-22 17:00:08.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000038","poiNmList":[{"langCd":"EN","name":"E01_154K"},{"langCd":"KO","name":"E01_154K"}],"sceneId":"SCN000039","coordList":[{"x":"149.60","z":"205.65"},{"x":"188.40","z":"205.65"},{"x":"188.40","z":"122.10"},{"x":"149.65","z":"121.95"}],"createBy":"liveinyou26","createDate":"2017-09-05 16:34:09.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000082","poiNmList":[{"langCd":"EN","name":"01_FTC01"},{"langCd":"KO","name":"01_FTC01"}],"sceneId":"SCN000045","coordList":[{"x":"-119.92","z":"58.95"},{"x":"-119.92","z":"38.95"},{"x":"-139.92","z":"38.95"},{"x":"-139.92","z":"58.95"}],"createBy":"cosmoz","createDate":"2017-10-17 21:00:46.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000083","poiNmList":[{"langCd":"EN","name":"02_FTC03"},{"langCd":"KO","name":"02_FTC03"}],"sceneId":"SCN000045","coordList":[{"x":"9.08","z":"58.95"},{"x":"9.08","z":"38.95"},{"x":"-10.92","z":"38.95"},{"x":"-10.92","z":"58.95"}],"createBy":"cosmoz","createDate":"2017-10-17 21:00:47.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000078","poiNmList":[{"langCd":"EN","name":"03_FTC06"},{"langCd":"KO","name":"03_FTC06"}],"sceneId":"SCN000045","coordList":[{"x":"171.08","z":"50.95"},{"x":"171.08","z":"30.95"},{"x":"151.08","z":"30.95"},{"x":"151.08","z":"50.95"}],"createBy":"cosmoz","createDate":"2017-10-17 21:00:44.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000079","poiNmList":[{"langCd":"EN","name":"04_FTC19"},{"langCd":"KO","name":"04_FTC19"}],"sceneId":"SCN000045","coordList":[{"x":"-117.92","z":"-52.05"},{"x":"-117.92","z":"-72.05"},{"x":"-137.92","z":"-72.05"},{"x":"-137.92","z":"-52.05"}],"createBy":"cosmoz","createDate":"2017-10-17 21:00:44.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000080","poiNmList":[{"langCd":"EN","name":"05_FTC21"},{"langCd":"KO","name":"05_FTC21"}],"sceneId":"SCN000045","coordList":[{"x":"11.08","z":"-53.05"},{"x":"11.08","z":"-73.05"},{"x":"-8.92","z":"-73.05"},{"x":"-8.92","z":"-53.05"}],"createBy":"cosmoz","createDate":"2017-10-17 21:00:45.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000081","poiNmList":[{"langCd":"EN","name":"05_FTC23"},{"langCd":"KO","name":"05_FTC23"}],"sceneId":"SCN000045","coordList":[{"x":"142.08","z":"-54.05"},{"x":"142.08","z":"-74.05"},{"x":"122.08","z":"-74.05"},{"x":"122.08","z":"-54.05"}],"createBy":"cosmoz","createDate":"2017-10-17 21:00:46.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000058","poiNmList":[{"langCd":"EN","name":"PIT(공동구)"},{"langCd":"KO","name":"PIT(공동구)"}],"sceneId":"SCN000047","coordList":[{"x":"-99.00","z":"-5.00"},{"x":"-99.00","z":"-19.00"},{"x":"-3.00","z":"-19.00"},{"x":"-3.00","z":"-5.00"}],"createBy":"cosmoz","createDate":"2017-10-09 17:04:01.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000076","poiNmList":[{"langCd":"EN","name":"07_CTC01"},{"langCd":"KO","name":"07_CTC01"}],"sceneId":"SCN000048","coordList":[{"x":"-44.00","z":"15.00"},{"x":"-44.00","z":"-5.00"},{"x":"-64.00","z":"-5.00"},{"x":"-64.00","z":"15.00"}],"createBy":"cosmoz","createDate":"2017-10-17 21:00:42.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000077","poiNmList":[{"langCd":"EN","name":"08_CTC03"},{"langCd":"KO","name":"08_CTC03"}],"sceneId":"SCN000048","coordList":[{"x":"41.00","z":"15.00"},{"x":"41.00","z":"-5.00"},{"x":"21.00","z":"-5.00"},{"x":"21.00","z":"15.00"}],"createBy":"cosmoz","createDate":"2017-10-17 21:00:43.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000084","poiNmList":[{"langCd":"EN","name":"09_WTC02"},{"langCd":"KO","name":"09_WTC02"}],"sceneId":"SCN000049","coordList":[{"x":"-44.92","z":"5.95"},{"x":"-44.92","z":"-14.05"},{"x":"-64.92","z":"-14.05"},{"x":"-64.92","z":"5.95"}],"createBy":"cosmoz","createDate":"2017-10-17 21:00:48.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000074","poiNmList":[{"langCd":"EN","name":"PIT(B1M03)"},{"langCd":"KO","name":"PIT(B1M03)"}],"sceneId":"SCN000050","coordList":[{"x":"-327.00","z":"203.00"},{"x":"-320.00","z":"203.00"},{"x":"-320.00","z":"121.00"},{"x":"-327.00","z":"121.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:37:32.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000071","poiNmList":[{"langCd":"EN","name":"B101"},{"langCd":"KO","name":"B101"}],"sceneId":"SCN000050","coordList":[{"x":"-319.00","z":"203.00"},{"x":"-319.00","z":"170.00"},{"x":"-232.00","z":"170.00"},{"x":"-232.00","z":"203.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:37:28.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000072","poiNmList":[{"langCd":"EN","name":"B102"},{"langCd":"KO","name":"B102"}],"sceneId":"SCN000050","coordList":[{"x":"-319.00","z":"169.00"},{"x":"-319.00","z":"146.00"},{"x":"-232.00","z":"146.00"},{"x":"-232.00","z":"169.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:37:31.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000024","poiNmList":[{"langCd":"EN","name":"남문(IN)"},{"langCd":"KO","name":"남문(IN)"}],"sceneId":"SCN000016","coordList":[{"x":"-97.00","z":"-199.00"},{"x":"-97.00","z":"-229.00"},{"x":"-37.00","z":"-229.00"},{"x":"-37.00","z":"-199.00"}],"createBy":"liveinyou26","createDate":"2017-08-25 17:31:36.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000025","poiNmList":[{"langCd":"EN","name":"남문(OUT)"},{"langCd":"KO","name":"남문(OUT)"}],"sceneId":"SCN000016","coordList":[{"x":"-97.00","z":"-231.00"},{"x":"-97.00","z":"-261.00"},{"x":"-37.00","z":"-261.00"},{"x":"-37.00","z":"-231.00"}],"createBy":"liveinyou26","createDate":"2017-08-25 17:31:37.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000015","poiNmList":[{"langCd":"EN","name":"FAB_3F"},{"langCd":"KO","name":"FAB_3F"}],"sceneId":"SCN000023","coordList":[{"x":"-165.00","z":"77.50"},{"x":"-165.00","z":"-97.50"},{"x":"175.00","z":"-97.50"},{"x":"175.00","z":"77.50"}],"createBy":"liveinyou26","createDate":"2017-08-25 14:04:09.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000027","poiNmList":[{"langCd":"EN","name":"북문(차량OUT)"},{"langCd":"KO","name":"북문(차량OUT)"}],"sceneId":"SCN000016","coordList":[{"x":"78.00","z":"260.00"},{"x":"78.00","z":"230.00"},{"x":"138.00","z":"230.00"},{"x":"138.00","z":"260.00"}],"createBy":"liveinyou26","createDate":"2017-08-25 17:35:04.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000026","poiNmList":[{"langCd":"EN","name":"북문(차량IN)"},{"langCd":"KO","name":"북문(차량IN)"}],"sceneId":"SCN000016","coordList":[{"x":"78.00","z":"229.00"},{"x":"78.00","z":"199.00"},{"x":"138.00","z":"199.00"},{"x":"138.00","z":"229.00"}],"createBy":"liveinyou26","createDate":"2017-08-25 17:35:04.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000010","poiNmList":[{"langCd":"EN","name":"북문(사람OUT)"},{"langCd":"KO","name":"북문(사람OUT)"}],"sceneId":"SCN000016","coordList":[{"x":"147.00","z":"250.00"},{"x":"147.00","z":"230.00"},{"x":"187.00","z":"230.00"},{"x":"187.00","z":"250.00"}],"createBy":"liveinyou26","createDate":"2017-08-24 13:17:02.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000011","poiNmList":[{"langCd":"EN","name":"북문(사람IN)"},{"langCd":"KO","name":"북문(사람IN)"}],"sceneId":"SCN000016","coordList":[{"x":"147.00","z":"229.00"},{"x":"147.00","z":"209.00"},{"x":"187.00","z":"209.00"},{"x":"187.00","z":"229.00"}],"createBy":"liveinyou26","createDate":"2017-08-24 13:17:03.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000024","poiNmList":[{"langCd":"EN","name":"남문(IN)"},{"langCd":"KO","name":"남문(IN)"}],"sceneId":"SCN000016","coordList":[{"x":"-90.00","z":"-210.00"},{"x":"-90.00","z":"-230.00"},{"x":"-50.00","z":"-230.00"},{"x":"-50.00","z":"-210.00"}],"createBy":"liveinyou26","createDate":"2017-08-25 17:31:36.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000025","poiNmList":[{"langCd":"EN","name":"남문(OUT)"},{"langCd":"KO","name":"남문(OUT)"}],"sceneId":"SCN000016","coordList":[{"x":"-90.00","z":"-233.00"},{"x":"-90.00","z":"-253.00"},{"x":"-50.00","z":"-253.00"},{"x":"-50.00","z":"-233.00"}],"createBy":"liveinyou26","createDate":"2017-08-25 17:31:37.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000054","poiNmList":[{"langCd":"EN","name":"북서문(OUT)"},{"langCd":"KO","name":"북서문(OUT)"}],"sceneId":"SCN000016","coordList":[{"x":"-391.00","z":"200.00"},{"x":"-391.00","z":"180.00"},{"x":"-351.00","z":"180.00"},{"x":"-351.00","z":"200.00"}],"createBy":"cosmoz","createDate":"2017-09-22 13:52:00.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000053","poiNmList":[{"langCd":"EN","name":"북서문(IN)"},{"langCd":"KO","name":"북서문(IN)"}],"sceneId":"SCN000016","coordList":[{"x":"-369.00","z":"177.00"},{"x":"-369.00","z":"157.00"},{"x":"-329.00","z":"157.00"},{"x":"-329.00","z":"177.00"}],"createBy":"cosmoz","createDate":"2017-09-22 13:51:59.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000088","poiNmList":[{"langCd":"EN","name":"저수조 TBM"},{"langCd":"KO","name":"저수조 TBM"}],"sceneId":"SCN000016","coordList":[{"x":"-290.00","z":"230.00"},{"x":"-290.00","z":"210.00"},{"x":"-230.00","z":"210.00"},{"x":"-230.00","z":"230.00"}],"createBy":"cosmoz","createDate":"2017-11-03 18:48:56.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000089","poiNmList":[{"langCd":"EN","name":"154Kv TBM"},{"langCd":"KO","name":"154Kv TBM"}],"sceneId":"SCN000016","coordList":[{"x":"147.00","z":"208.00"},{"x":"147.00","z":"188.00"},{"x":"187.00","z":"188.00"},{"x":"187.00","z":"208.00"}],"createBy":"cosmoz","createDate":"2017-11-03 18:48:57.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000090","poiNmList":[{"langCd":"EN","name":"FAB TBM"},{"langCd":"KO","name":"FAB TBM"}],"sceneId":"SCN000016","coordList":[{"x":"88.50","z":"86.00"},{"x":"88.50","z":"-74.00"},{"x":"113.50","z":"-74.00"},{"x":"113.50","z":"86.00"}],"createBy":"cosmoz","createDate":"2017-11-03 18:48:58.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000091","poiNmList":[{"langCd":"EN","name":"WWT TBM"},{"langCd":"KO","name":"WWT TBM"}],"sceneId":"SCN000016","coordList":[{"x":"-90.00","z":"-170.50"},{"x":"-90.00","z":"-205.50"},{"x":"-40.00","z":"-205.50"},{"x":"-40.00","z":"-170.50"}],"createBy":"cosmoz","createDate":"2017-11-03 18:48:59.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000122","poiNmList":[{"langCd":"EN","name":"발전기동"},{"langCd":"KO","name":"발전기동"}],"sceneId":"SCN000016","coordList":[{"x":"-35.00","z":"217.50"},{"x":"-35.00","z":"192.50"},{"x":"25.00","z":"192.50"},{"x":"25.00","z":"217.50"}],"createBy":"cosmoz","createDate":"2017-12-01 13:11:33.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000013","poiNmList":[{"langCd":"EN","name":"FAB_1F"},{"langCd":"KO","name":"FAB_1F"}],"sceneId":"SCN000021","coordList":[{"x":"-166.00","z":"76.50"},{"x":"-166.00","z":"-98.50"},{"x":"174.00","z":"-98.50"},{"x":"174.00","z":"76.50"}],"createBy":"liveinyou26","createDate":"2017-08-24 13:37:41.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000016","poiNmList":[{"langCd":"EN","name":"FAB_4F"},{"langCd":"KO","name":"FAB_4F"}],"sceneId":"SCN000024","coordList":[{"x":"-166.74","z":"78.50"},{"x":"-166.74","z":"-96.50"},{"x":"172.74","z":"-96.50"},{"x":"172.74","z":"78.50"}],"createBy":"liveinyou26","createDate":"2017-08-25 14:04:09.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000086","poiNmList":[{"langCd":"EN","name":"CUB_2F"},{"langCd":"KO","name":"CUB_2F"}],"sceneId":"SCN000052","coordList":[{"x":"-100.00","z":"46.00"},{"x":"-100.00","z":"-10.00"},{"x":"95.00","z":"-10.00"},{"x":"95.00","z":"46.00"}],"createBy":"cosmoz","createDate":"2017-11-03 18:43:57.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000131","poiNmList":[{"langCd":"EN","name":"압입구"},{"langCd":"KO","name":"압입구"}],"sceneId":"SCN000056","coordList":[{"x":"-325.00","z":"184.00"},{"x":"-325.00","z":"152.00"},{"x":"-305.00","z":"152.00"},{"x":"-305.00","z":"184.00"}],"createBy":"cosmoz","createDate":"2017-12-07 13:57:20.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000035","poiNmList":[{"langCd":"EN","name":"154Kv"},{"langCd":"KO","name":"154Kv"}],"sceneId":"SCN000001","coordList":[{"x":"153.00","z":"208.00"},{"x":"193.00","z":"208.00"},{"x":"193.00","z":"120.15"},{"x":"153.06","z":"120.00"}],"createBy":"liveinyou26","createDate":"2017-09-05 16:29:51.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000028","poiNmList":[{"langCd":"EN","name":"FAB"},{"langCd":"KO","name":"FAB"}],"sceneId":"SCN000001","coordList":[{"x":"-263.20","z":"98.34"},{"x":"-263.13","z":"-89.60"},{"x":"96.80","z":"-88.64"},{"x":"96.60","z":"100.40"}],"createBy":"liveinyou26","createDate":"2017-08-25 19:03:29.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000067","poiNmList":[{"langCd":"EN","name":"F04-2"},{"langCd":"KO","name":"F04-2"}],"sceneId":"SCN000020","coordList":[{"x":"-45.00","z":"-58.00"},{"x":"70.00","z":"-58.00"},{"x":"70.00","z":"-89.00"},{"x":"-45.00","z":"-89.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:08:18.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000066","poiNmList":[{"langCd":"EN","name":"F04-1"},{"langCd":"KO","name":"F04-1"}],"sceneId":"SCN000020","coordList":[{"x":"-120.00","z":"-58.00"},{"x":"-120.00","z":"-89.00"},{"x":"-46.00","z":"-89.00"},{"x":"-46.00","z":"-58.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:08:09.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000069","poiNmList":[{"langCd":"EN","name":"가스공동구"},{"langCd":"KO","name":"가스공동구"}],"sceneId":"SCN000020","coordList":[{"x":"-126.00","z":"53.00"},{"x":"-121.00","z":"53.00"},{"x":"-121.00","z":"-57.00"},{"x":"-126.00","z":"-57.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:08:34.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000064","poiNmList":[{"langCd":"EN","name":"F02-1"},{"langCd":"KO","name":"F02-1"}],"sceneId":"SCN000020","coordList":[{"x":"-169.00","z":"-1.00"},{"x":"-127.00","z":"-1.00"},{"x":"-127.00","z":"-89.00"},{"x":"-169.00","z":"-89.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:07:43.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000065","poiNmList":[{"langCd":"EN","name":"F02-2"},{"langCd":"KO","name":"F02-2"}],"sceneId":"SCN000020","coordList":[{"x":"-169.00","z":"53.00"},{"x":"-127.00","z":"53.00"},{"x":"-127.00","z":"0.00"},{"x":"-169.00","z":"0.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:07:54.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000032","poiNmList":[{"langCd":"EN","name":"가설식당"},{"langCd":"KO","name":"가설식당"}],"sceneId":"SCN000001","coordList":[{"x":"216.70","z":"182.43"},{"x":"250.26","z":"182.65"},{"x":"250.70","z":"122.77"},{"x":"217.14","z":"122.55"}],"createBy":"liveinyou26","createDate":"2017-08-31 17:14:15.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000020","poiNmList":[{"langCd":"EN","name":"CUB"},{"langCd":"KO","name":"CUB"}],"sceneId":"SCN000001","coordList":[{"x":"-171.00","z":"186.18"},{"x":"28.61","z":"187.00"},{"x":"29.00","z":"119.90"},{"x":"13.78","z":"120.25"},{"x":"13.78","z":"117.50"},{"x":"-157.56","z":"117.00"},{"x":"-157.69","z":"119.34"},{"x":"-170.54","z":"119.10"}],"createBy":"liveinyou26","createDate":"2017-08-25 17:28:19.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000002","poiNmList":[{"langCd":"EN","name":"Outdoor"},{"langCd":"KO","name":"Outdoor"}],"sceneId":"SCN000001","coordList":[{"x":"104.00","z":"115.00"},{"x":"104.00","z":"-207.00"},{"x":"305.00","z":"-207.00"},{"x":"305.00","z":"115.00"}],"createBy":"liveinyou26","createDate":"2017-07-18 17:26:21.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000029","poiNmList":[{"langCd":"EN","name":"저수조"},{"langCd":"KO","name":"저수조"}],"sceneId":"SCN000001","coordList":[{"x":"-300.00","z":"215.00"},{"x":"-200.00","z":"215.00"},{"x":"-200.00","z":"115.00"},{"x":"-300.00","z":"115.00"}],"createBy":"liveinyou26","createDate":"2017-08-31 17:13:59.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000021","poiNmList":[{"langCd":"EN","name":"WWT"},{"langCd":"KO","name":"WWT"}],"sceneId":"SCN000001","coordList":[{"x":"-290.00","z":"-107.00"},{"x":"-80.00","z":"-107.00"},{"x":"-80.00","z":"-237.00"},{"x":"-290.00","z":"-237.00"}],"createBy":"liveinyou26","createDate":"2017-08-25 17:28:21.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000132","poiNmList":[{"langCd":"EN","name":"압입구"},{"langCd":"KO","name":"압입구"}],"sceneId":"SCN000001","coordList":[{"x":"-328.00","z":"185.50"},{"x":"-308.00","z":"185.50"},{"x":"-308.00","z":"150.50"},{"x":"-328.00","z":"150.50"}],"createBy":"cosmoz","createDate":"2017-12-08 12:17:07.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000068","poiNmList":[{"langCd":"EN","name":"F04-3"},{"langCd":"KO","name":"F04-3"}],"sceneId":"SCN000020","coordList":[{"x":"71.00","z":"-58.00"},{"x":"71.00","z":"-89.00"},{"x":"174.00","z":"-89.00"},{"x":"174.00","z":"-58.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:08:27.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000061","poiNmList":[{"langCd":"EN","name":"F03-1"},{"langCd":"KO","name":"F03-1"}],"sceneId":"SCN000020","coordList":[{"x":"-169.00","z":"84.00"},{"x":"-169.00","z":"54.00"},{"x":"-99.00","z":"54.00"},{"x":"-99.00","z":"84.00"}],"createBy":"cosmoz","createDate":"2017-10-17 19:48:34.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000062","poiNmList":[{"langCd":"EN","name":"F03-2"},{"langCd":"KO","name":"F03-2"}],"sceneId":"SCN000020","coordList":[{"x":"-98.00","z":"84.00"},{"x":"-98.00","z":"54.00"},{"x":"-25.00","z":"54.00"},{"x":"-25.00","z":"84.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:06:05.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000063","poiNmList":[{"langCd":"EN","name":"F03-3"},{"langCd":"KO","name":"F03-3"}],"sceneId":"SCN000020","coordList":[{"x":"-24.00","z":"84.00"},{"x":"-24.00","z":"54.00"},{"x":"62.00","z":"54.00"},{"x":"62.00","z":"84.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:06:44.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000070","poiNmList":[{"langCd":"EN","name":"배관공동구"},{"langCd":"KO","name":"배관공동구"}],"sceneId":"SCN000020","coordList":[{"x":"-44.00","z":"53.00"},{"x":"-44.00","z":"-57.00"},{"x":"-31.00","z":"-57.00"},{"x":"-31.00","z":"53.00"}],"createBy":"cosmoz","createDate":"2017-10-17 20:08:48.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000044","poiNmList":[{"langCd":"EN","name":"A6"},{"langCd":"KO","name":"A6"}],"sceneId":"SCN000032","coordList":[{"x":"-78.50","z":"3.50"},{"x":"-70.50","z":"3.41"},{"x":"-70.54","z":"-57.50"},{"x":"-78.50","z":"-57.50"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:54.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000045","poiNmList":[{"langCd":"EN","name":"A7"},{"langCd":"KO","name":"A7"}],"sceneId":"SCN000032","coordList":[{"x":"-70.00","z":"3.50"},{"x":"-61.00","z":"3.41"},{"x":"-61.05","z":"-57.50"},{"x":"-70.00","z":"-57.50"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:55.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000009","poiNmList":[{"langCd":"EN","name":"근로자쉼터"},{"langCd":"KO","name":"근로자쉼터"}],"sceneId":"","coordList":[{"x":"-25.04","z":"-195.05"},{"x":"-10.07","z":"-194.92"},{"x":"-9.94","z":"-210.62"},{"x":"-24.99","z":"-210.55"}],"createBy":"liveinyou26","createDate":"2017-07-20 14:51:41.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000014","poiNmList":[{"langCd":"EN","name":"FAB_2F"},{"langCd":"KO","name":"FAB_2F"}],"sceneId":"SCN000022","coordList":[{"x":"-165.00","z":"76.50"},{"x":"-165.00","z":"-98.50"},{"x":"175.00","z":"-98.50"},{"x":"175.00","z":"76.50"}],"createBy":"liveinyou26","createDate":"2017-08-25 11:19:23.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000030","poiNmList":[{"langCd":"EN","name":"FAB_외각"},{"langCd":"KO","name":"FAB_외각"}],"sceneId":"","coordList":[{"x":"-99.90","z":"119.85"},{"x":"-99.67","z":"92.65"},{"x":"-20.03","z":"93.07"},{"x":"-19.70","z":"120.55"}],"createBy":"liveinyou26","createDate":"2017-08-31 17:14:06.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000124","poiNmList":[{"langCd":"EN","name":"WASTE WATER"},{"langCd":"KO","name":"WASTE WATER"}],"sceneId":"SCN000026","coordList":[{"x":"8.63","z":"35.30"},{"x":"8.61","z":"21.34"},{"x":"32.54","z":"21.30"},{"x":"32.81","z":"35.26"}],"createBy":"cosmoz","createDate":"2017-12-01 17:51:43.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000125","poiNmList":[{"langCd":"EN","name":"RAW WATER"},{"langCd":"KO","name":"RAW WATER"}],"sceneId":"SCN000026","coordList":[{"x":"32.72","z":"35.26"},{"x":"32.70","z":"21.30"},{"x":"56.63","z":"21.26"},{"x":"56.90","z":"35.22"}],"createBy":"cosmoz","createDate":"2017-12-01 17:51:43.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000126","poiNmList":[{"langCd":"EN","name":"FILTERED WATER"},{"langCd":"KO","name":"FILTERED WATER"}],"sceneId":"SCN000026","coordList":[{"x":"57.07","z":"35.18"},{"x":"92.46","z":"35.20"},{"x":"92.55","z":"21.40"},{"x":"56.85","z":"21.40"}],"createBy":"cosmoz","createDate":"2017-12-01 17:51:44.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000046","poiNmList":[{"langCd":"EN","name":"A8"},{"langCd":"KO","name":"A8"}],"sceneId":"SCN000032","coordList":[{"x":"-60.00","z":"3.50"},{"x":"-21.00","z":"3.41"},{"x":"-21.20","z":"-57.50"},{"x":"-60.00","z":"-57.50"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:55.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000047","poiNmList":[{"langCd":"EN","name":"B1"},{"langCd":"KO","name":"B1"}],"sceneId":"SCN000032","coordList":[{"x":"61.43","z":"38.60"},{"x":"61.35","z":"7.00"},{"x":"88.05","z":"7.17"},{"x":"88.05","z":"38.60"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:54:58.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000048","poiNmList":[{"langCd":"EN","name":"B2"},{"langCd":"KO","name":"B2"}],"sceneId":"SCN000032","coordList":[{"x":"61.73","z":"52.50"},{"x":"61.65","z":"39.50"},{"x":"88.35","z":"39.57"},{"x":"88.35","z":"52.50"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:54:58.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000049","poiNmList":[{"langCd":"EN","name":"B3"},{"langCd":"KO","name":"B3"}],"sceneId":"SCN000032","coordList":[{"x":"31.47","z":"51.70"},{"x":"50.20","z":"51.49"},{"x":"49.85","z":"16.17"},{"x":"31.40","z":"16.10"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:54:59.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000040","poiNmList":[{"langCd":"EN","name":"A2"},{"langCd":"KO","name":"A2"}],"sceneId":"SCN000032","coordList":[{"x":"-53.11","z":"58.00"},{"x":"-59.91","z":"58.00"},{"x":"-59.91","z":"21.00"},{"x":"-56.02","z":"21.00"},{"x":"-56.02","z":"26.00"},{"x":"-53.11","z":"26.00"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:52.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000042","poiNmList":[{"langCd":"EN","name":"A4"},{"langCd":"KO","name":"A4"}],"sceneId":"SCN000032","coordList":[{"x":"-44.15","z":"39.36"},{"x":"-44.15","z":"20.56"},{"x":"-36.25","z":"20.56"},{"x":"-36.25","z":"39.36"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:53.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000041","poiNmList":[{"langCd":"EN","name":"A3"},{"langCd":"KO","name":"A3"}],"sceneId":"SCN000032","coordList":[{"x":"-44.24","z":"64.41"},{"x":"-44.24","z":"39.61"},{"x":"-36.34","z":"39.61"},{"x":"-36.34","z":"64.41"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:53.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000043","poiNmList":[{"langCd":"EN","name":"A5"},{"langCd":"KO","name":"A5"}],"sceneId":"SCN000032","coordList":[{"x":"-36.11","z":"64.55"},{"x":"-36.11","z":"16.05"},{"x":"-20.11","z":"16.05"},{"x":"-20.11","z":"64.55"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:54.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000017","poiNmList":[{"langCd":"EN","name":"CUB_1F"},{"langCd":"KO","name":"CUB_1F"}],"sceneId":"SCN000026","coordList":[{"x":"-101.00","z":"36.50"},{"x":"-101.00","z":"-14.50"},{"x":"-1.00","z":"-14.50"},{"x":"-1.00","z":"36.50"}],"createBy":"liveinyou26","createDate":"2017-08-25 16:17:49.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000059","poiNmList":[{"langCd":"EN","name":"전력 공동구(CUB)"},{"langCd":"KO","name":"전력 공동구(CUB)"}],"sceneId":"SCN000026","coordList":[{"x":"-100.30","z":"41.20"},{"x":"-100.30","z":"36.20"},{"x":"92.70","z":"36.20"},{"x":"92.70","z":"41.20"}],"createBy":"cosmoz","createDate":"2017-10-17 19:47:13.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000060","poiNmList":[{"langCd":"EN","name":"전력 공동구(주차장)"},{"langCd":"KO","name":"전력 공동구(주차장)"}],"sceneId":"SCN000026","coordList":[{"x":"93.20","z":"41.50"},{"x":"93.20","z":"34.50"},{"x":"106.20","z":"34.50"},{"x":"106.20","z":"41.50"}],"createBy":"cosmoz","createDate":"2017-10-17 19:48:09.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000127","poiNmList":[{"langCd":"EN","name":"RO PERMEATE"},{"langCd":"KO","name":"RO PERMEATE"}],"sceneId":"SCN000026","coordList":[{"x":"32.50","z":"6.98"},{"x":"32.50","z":"-12.02"},{"x":"56.50","z":"-12.02"},{"x":"56.50","z":"6.98"}],"createBy":"cosmoz","createDate":"2017-12-01 17:51:44.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000128","poiNmList":[{"langCd":"EN","name":"PRETREATED WATER"},{"langCd":"KO","name":"PRETREATED WATER"}],"sceneId":"SCN000026","coordList":[{"x":"57.50","z":"7.00"},{"x":"57.50","z":"-12.00"},{"x":"69.50","z":"-12.00"},{"x":"69.50","z":"7.00"}],"createBy":"cosmoz","createDate":"2017-12-01 17:51:45.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000129","poiNmList":[{"langCd":"EN","name":"DBP REGENERATION"},{"langCd":"KO","name":"DBP REGENERATION"}],"sceneId":"SCN000026","coordList":[{"x":"70.50","z":"7.00"},{"x":"70.50","z":"2.00"},{"x":"82.50","z":"2.00"},{"x":"82.50","z":"7.00"}],"createBy":"cosmoz","createDate":"2017-12-01 17:51:46.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000130","poiNmList":[{"langCd":"EN","name":"RECLAIM WATER"},{"langCd":"KO","name":"RECLAIM WATER"}],"sceneId":"SCN000026","coordList":[{"x":"70.50","z":"1.00"},{"x":"70.50","z":"-4.00"},{"x":"82.50","z":"-4.00"},{"x":"82.50","z":"1.00"}],"createBy":"cosmoz","createDate":"2017-12-01 17:51:46.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000141","poiNmList":[{"langCd":"EN","name":"B1"}],"sceneId":"SCN000036","coordList":[{"x":"1.50","z":"50.00"},{"x":"1.50","z":"45.00"},{"x":"30.50","z":"45.00"},{"x":"30.50","z":"50.00"}],"createBy":"cosmoz","createDate":"2017-12-22 16:59:08.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000142","poiNmList":[{"langCd":"EN","name":"B2"}],"sceneId":"SCN000036","coordList":[{"x":"1.50","z":"44.00"},{"x":"1.50","z":"39.00"},{"x":"30.50","z":"39.00"},{"x":"30.50","z":"44.00"}],"createBy":"cosmoz","createDate":"2017-12-22 16:59:09.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000143","poiNmList":[{"langCd":"EN","name":"B3"}],"sceneId":"SCN000036","coordList":[{"x":"1.50","z":"38.00"},{"x":"1.50","z":"33.00"},{"x":"30.50","z":"33.00"},{"x":"30.50","z":"38.00"}],"createBy":"cosmoz","createDate":"2017-12-22 17:00:04.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000144","poiNmList":[{"langCd":"EN","name":"B4"}],"sceneId":"SCN000036","coordList":[{"x":"1.50","z":"32.00"},{"x":"1.50","z":"27.00"},{"x":"30.50","z":"27.00"},{"x":"30.50","z":"32.00"}],"createBy":"cosmoz","createDate":"2017-12-22 17:00:04.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000036","poiNmList":[{"langCd":"EN","name":"가설식당-2"},{"langCd":"KO","name":"가설식당-2"}],"sceneId":"SCN000041","coordList":[{"x":"216.70","z":"182.43"},{"x":"250.26","z":"182.65"},{"x":"250.70","z":"122.77"},{"x":"217.14","z":"122.55"}],"createBy":"liveinyou26","createDate":"2017-09-05 16:30:38.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000145","poiNmList":[{"langCd":"EN","name":"B5"}],"sceneId":"SCN000036","coordList":[{"x":"1.50","z":"26.00"},{"x":"1.50","z":"21.00"},{"x":"30.50","z":"21.00"},{"x":"30.50","z":"26.00"}],"createBy":"cosmoz","createDate":"2017-12-22 17:00:05.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000034","poiNmList":[{"langCd":"EN","name":"저수조_1F"},{"langCd":"KO","name":"저수조_1F"}],"sceneId":"SCN000037","coordList":[{"x":"-327.79","z":"203.63"},{"x":"-326.50","z":"120.60"},{"x":"-192.21","z":"120.38"},{"x":"-193.08","z":"203.12"}],"createBy":"liveinyou26","createDate":"2017-09-05 16:26:56.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000054","poiNmList":[{"langCd":"EN","name":"북서문(OUT)"},{"langCd":"KO","name":"북서문(OUT)"}],"sceneId":"SCN000016","coordList":[{"x":"-355.50","z":"202.00"},{"x":"-355.50","z":"182.00"},{"x":"-320.50","z":"182.00"},{"x":"-320.50","z":"202.00"}],"createBy":"cosmoz","createDate":"2017-09-22 13:52:00.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000053","poiNmList":[{"langCd":"EN","name":"북서문(IN)"},{"langCd":"KO","name":"북서문(IN)"}],"sceneId":"SCN000016","coordList":[{"x":"-343.50","z":"179.00"},{"x":"-343.50","z":"159.00"},{"x":"-308.50","z":"159.00"},{"x":"-308.50","z":"179.00"}],"createBy":"cosmoz","createDate":"2017-09-22 13:51:59.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000057","poiNmList":[{"langCd":"EN","name":"공동구1"},{"langCd":"KO","name":"공동구1"}],"sceneId":"","coordList":[{"x":"-44.20","z":"45.30"},{"x":"-31.20","z":"45.30"},{"x":"-31.26","z":"-57.90"},{"x":"-44.14","z":"-57.90"}],"createBy":"cosmoz","createDate":"2017-10-09 16:58:22.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000051","poiNmList":[{"langCd":"EN","name":"A복도"},{"langCd":"KO","name":"A복도"}],"sceneId":"SCN000032","coordList":[{"x":"-78.69","z":"14.75"},{"x":"-79.13","z":"7.75"},{"x":"60.87","z":"7.79"},{"x":"60.87","z":"14.75"}],"createBy":"liveinyou26","createDate":"2017-09-06 14:09:56.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000052","poiNmList":[{"langCd":"EN","name":"B복도"},{"langCd":"KO","name":"B복도"}],"sceneId":"SCN000032","coordList":[{"x":"50.82","z":"65.09"},{"x":"50.79","z":"14.09"},{"x":"60.79","z":"14.36"},{"x":"60.79","z":"65.09"}],"createBy":"liveinyou26","createDate":"2017-09-06 14:09:56.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000039","poiNmList":[{"langCd":"EN","name":"A1"},{"langCd":"KO","name":"A1"}],"sceneId":"SCN000032","coordList":[{"x":"-79.10","z":"64.50"},{"x":"-60.41","z":"64.46"},{"x":"-60.10","z":"19.43"},{"x":"-79.03","z":"19.30"}],"createBy":"liveinyou26","createDate":"2017-09-05 17:26:14.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000050","poiNmList":[{"langCd":"EN","name":"B4"},{"langCd":"KO","name":"B4"}],"sceneId":"SCN000032","coordList":[{"x":"-19.85","z":"65.38"},{"x":"-19.81","z":"15.33"},{"x":"31.25","z":"15.21"},{"x":"31.15","z":"65.33"}],"createBy":"liveinyou26","createDate":"2017-09-06 09:54:59.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000019","poiNmList":[{"langCd":"EN","name":"WWT_1F"},{"langCd":"KO","name":"WWT_1F"}],"sceneId":"SCN000036","coordList":[{"x":"-80.55","z":"65.63"},{"x":"-80.27","z":"-59.46"},{"x":"-3.45","z":"-59.80"},{"x":"-3.62","z":"65.80"}],"createBy":"liveinyou26","createDate":"2017-08-25 16:17:51.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000133","poiNmList":[{"langCd":"EN","name":"A1"}],"sceneId":"SCN000036","coordList":[{"x":"-3.00","z":"7.00"},{"x":"-3.00","z":"0.00"},{"x":"14.00","z":"0.00"},{"x":"14.00","z":"7.00"}],"createBy":"cosmoz","createDate":"2017-12-22 16:59:04.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000134","poiNmList":[{"langCd":"EN","name":"A2"}],"sceneId":"SCN000036","coordList":[{"x":"-3.00","z":"-1.00"},{"x":"-3.00","z":"-8.00"},{"x":"14.00","z":"-8.00"},{"x":"14.00","z":"-1.00"}],"createBy":"cosmoz","createDate":"2017-12-22 16:59:05.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000135","poiNmList":[{"langCd":"EN","name":"A3"}],"sceneId":"SCN000036","coordList":[{"x":"-3.00","z":"-9.00"},{"x":"-3.00","z":"-16.00"},{"x":"14.00","z":"-16.00"},{"x":"14.00","z":"-9.00"}],"createBy":"cosmoz","createDate":"2017-12-22 16:59:05.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000136","poiNmList":[{"langCd":"EN","name":"A4"}],"sceneId":"SCN000036","coordList":[{"x":"-3.00","z":"-17.00"},{"x":"-3.00","z":"-24.00"},{"x":"14.00","z":"-24.00"},{"x":"14.00","z":"-17.00"}],"createBy":"cosmoz","createDate":"2017-12-22 16:59:06.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000138","poiNmList":[{"langCd":"EN","name":"A6"}],"sceneId":"SCN000036","coordList":[{"x":"43.00","z":"-1.00"},{"x":"43.00","z":"-8.00"},{"x":"76.00","z":"-8.00"},{"x":"76.00","z":"-1.00"}],"createBy":"cosmoz","createDate":"2017-12-22 16:59:07.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000137","poiNmList":[{"langCd":"EN","name":"A5"}],"sceneId":"SCN000036","coordList":[{"x":"43.00","z":"7.00"},{"x":"43.00","z":"0.00"},{"x":"76.00","z":"0.00"},{"x":"76.00","z":"7.00"}],"createBy":"cosmoz","createDate":"2017-12-22 16:59:06.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000139","poiNmList":[{"langCd":"EN","name":"A7"}],"sceneId":"SCN000036","coordList":[{"x":"43.00","z":"-9.00"},{"x":"43.00","z":"-16.00"},{"x":"76.00","z":"-16.00"},{"x":"76.00","z":"-9.00"}],"createBy":"cosmoz","createDate":"2017-12-22 16:59:07.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000140","poiNmList":[{"langCd":"EN","name":"A8"}],"sceneId":"SCN000036","coordList":[{"x":"43.00","z":"-17.00"},{"x":"43.00","z":"-24.00"},{"x":"76.00","z":"-24.00"},{"x":"76.00","z":"-17.00"}],"createBy":"cosmoz","createDate":"2017-12-22 16:59:08.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000005","poiNmList":[{"langCd":"EN","name":"동문"},{"langCd":"KO","name":"동문"}],"sceneId":"","coordList":null,"createBy":"liveinyou26","createDate":"2017-07-20 10:23:08.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000023","poiNmList":[{"langCd":"EN","name":"남문"},{"langCd":"KO","name":"남문"}],"sceneId":"","coordList":null,"createBy":"liveinyou26","createDate":"2017-08-25 17:28:27.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000012","poiNmList":[{"langCd":"EN","name":"FAB_B1F"},{"langCd":"KO","name":"FAB_B1F"}],"sceneId":"","coordList":null,"createBy":"liveinyou26","createDate":"2017-08-24 13:36:23.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000022","poiNmList":[{"langCd":"EN","name":"북문"},{"langCd":"KO","name":"북문"}],"sceneId":"","coordList":null,"createBy":"liveinyou26","createDate":"2017-08-25 17:28:26.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000006","poiNmList":[{"langCd":"EN","name":"서문"},{"langCd":"KO","name":"서문"}],"sceneId":"","coordList":null,"createBy":"liveinyou26","createDate":"2017-07-20 10:23:08.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000031","poiNmList":[{"langCd":"EN","name":"E01"},{"langCd":"KO","name":"E01"}],"sceneId":"","coordList":null,"createBy":"liveinyou26","createDate":"2017-08-31 17:14:14.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000033","poiNmList":[{"langCd":"EN","name":"주차장"},{"langCd":"KO","name":"주차장"}],"sceneId":"","coordList":null,"createBy":"liveinyou26","createDate":"2017-08-31 17:14:16.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000055","poiNmList":[{"langCd":"EN","name":"북서문"},{"langCd":"KO","name":"북서문"}],"sceneId":"","coordList":null,"createBy":"cosmoz","createDate":"2017-09-22 14:08:13.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000018","poiNmList":[{"langCd":"EN","name":"WWT_B1F"},{"langCd":"KO","name":"WWT_B1F"}],"sceneId":"","coordList":null,"createBy":"liveinyou26","createDate":"2017-08-25 16:17:50.0","updateDate":"2017-12-22 17:03:23.0"},{"poiId":"POI000001","poiNmList":[{"langCd":"EN","name":"FABtest"},{"langCd":"KO","name":"FABtest"}],"sceneId":"","coordList":null,"createBy":"liveinyou26","createDate":"2017-07-18 17:26:15.0","updateDate":"2017-12-22 17:03:23.0"}]}}';

	}


	s_PoiAreaList = new PoiAreaList_Response();
	s_PoiAreaList.setData(JSON.parse(data_area_list));
	s_PoiTableMap.setPoiAreaList(s_PoiAreaList);

	// -----------------------------------------
	// poi/list
	// -----------------------------------------
	var data_list;
	if(testBasicURL.indexOf('218.55.23.196') != -1) {
		// 테스트 서버
		data_list = '{"header":{"resultCode":"0000","resultMsg":"Success"},"body":{"poiList":[{"poiId":"POI000001","poiNmList":[{"langCd":"EN","name":"FABtest"},{"langCd":"KO","name":"FABtest"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:40.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000002","poiNmList":[{"langCd":"EN","name":"M15"},{"langCd":"KO","name":"M15"}],"poiCode":"","posX":"204.5","posY":"0","posZ":"-46","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:41.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000005","poiNmList":[{"langCd":"EN","name":"동문"},{"langCd":"KO","name":"동문"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:51.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000006","poiNmList":[{"langCd":"EN","name":"서문"},{"langCd":"KO","name":"서문"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:52.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000009","poiNmList":[{"langCd":"EN","name":"근로자쉼터"},{"langCd":"KO","name":"근로자쉼터"}],"poiCode":"","posX":"-17.49","posY":"0","posZ":"-202.77","sceneId":"SCN000002","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:53.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000010","poiNmList":[{"langCd":"EN","name":"북문(사람OUT)"},{"langCd":"KO","name":"북문(사람OUT)"}],"poiCode":"","posX":"167","posY":"0","posZ":"240","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:54.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000011","poiNmList":[{"langCd":"EN","name":"북문(사람IN)"},{"langCd":"KO","name":"북문(사람IN)"}],"poiCode":"","posX":"167","posY":"0","posZ":"219","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:56.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000012","poiNmList":[{"langCd":"EN","name":"FAB_B1F"},{"langCd":"KO","name":"FAB_B1F"}],"poiCode":"","posX":"2.5","posY":"0","posZ":"-0.5","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:57.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000013","poiNmList":[{"langCd":"EN","name":"FAB_1F"},{"langCd":"KO","name":"FAB_1F"}],"poiCode":"","posX":"4","posY":"0","posZ":"-11","sceneId":"SCN000021","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:57.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000014","poiNmList":[{"langCd":"EN","name":"FAB_2F"},{"langCd":"KO","name":"FAB_2F"}],"poiCode":"","posX":"5","posY":"0","posZ":"-11","sceneId":"SCN000022","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:57.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000015","poiNmList":[{"langCd":"EN","name":"FAB_3F"},{"langCd":"KO","name":"FAB_3F"}],"poiCode":"","posX":"5","posY":"0","posZ":"-10","sceneId":"SCN000023","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:58.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000016","poiNmList":[{"langCd":"EN","name":"FAB_4F"},{"langCd":"KO","name":"FAB_4F"}],"poiCode":"","posX":"3","posY":"0","posZ":"-9","sceneId":"SCN000024","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:58.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000017","poiNmList":[{"langCd":"EN","name":"CUB_1F"},{"langCd":"KO","name":"CUB_1F"}],"poiCode":"","posX":"-2.5","posY":"0","posZ":"12.5","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:59.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000018","poiNmList":[{"langCd":"EN","name":"WWT_B1F"},{"langCd":"KO","name":"WWT_B1F"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:22:59.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000019","poiNmList":[{"langCd":"EN","name":"WWT_1F"},{"langCd":"KO","name":"WWT_1F"}],"poiCode":"","posX":"5","posY":"0","posZ":"3","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:00.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000020","poiNmList":[{"langCd":"EN","name":"CUB"},{"langCd":"KO","name":"CUB"}],"poiCode":"","posX":"-72.3","posY":"0","posZ":"154.2","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:00.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000021","poiNmList":[{"langCd":"EN","name":"WWT"},{"langCd":"KO","name":"WWT"}],"poiCode":"","posX":"-200.5","posY":"0","posZ":"-173.7","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:01.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000022","poiNmList":[{"langCd":"EN","name":"북문"},{"langCd":"KO","name":"북문"}],"poiCode":"","posX":"107.3","posY":"0","posZ":"234.8","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:01.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000023","poiNmList":[{"langCd":"EN","name":"남문"},{"langCd":"KO","name":"남문"}],"poiCode":"","posX":"-72.4","posY":"0","posZ":"-230.3","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:01.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000024","poiNmList":[{"langCd":"EN","name":"남문(IN)"},{"langCd":"KO","name":"남문(IN)"}],"poiCode":"","posX":"-67","posY":"0","posZ":"-214","sceneId":"SCN000018","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:02.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000025","poiNmList":[{"langCd":"EN","name":"남문(OUT)"},{"langCd":"KO","name":"남문(OUT)"}],"poiCode":"","posX":"-67","posY":"0","posZ":"-246","sceneId":"SCN000018","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:02.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000026","poiNmList":[{"langCd":"EN","name":"북문(차량IN)"},{"langCd":"KO","name":"북문(차량IN)"}],"poiCode":"","posX":"108","posY":"0","posZ":"214","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:03.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000027","poiNmList":[{"langCd":"EN","name":"북문(차량OUT)"},{"langCd":"KO","name":"북문(차량OUT)"}],"poiCode":"","posX":"108","posY":"0","posZ":"245","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:03.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000028","poiNmList":[{"langCd":"EN","name":"FAB"},{"langCd":"KO","name":"FAB"}],"poiCode":"","posX":"-83.2","posY":"0","posZ":"5.4","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:04.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000029","poiNmList":[{"langCd":"EN","name":"저수조"},{"langCd":"KO","name":"저수조"}],"poiCode":"","posX":"-250","posY":"0","posZ":"165","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:04.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000030","poiNmList":[{"langCd":"EN","name":"FAB_외각"},{"langCd":"KO","name":"FAB_외각"}],"poiCode":"","posX":"-59.8","posY":"0","posZ":"106.6","sceneId":"SCN000002","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:05.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000031","poiNmList":[{"langCd":"EN","name":"E01"},{"langCd":"KO","name":"E01"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:05.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000032","poiNmList":[{"langCd":"EN","name":"가설식당"},{"langCd":"KO","name":"가설식당"}],"poiCode":"","posX":"233.7","posY":"0","posZ":"152.6","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:06.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000033","poiNmList":[{"langCd":"EN","name":"주차장"},{"langCd":"KO","name":"주차장"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:06.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000034","poiNmList":[{"langCd":"EN","name":"S21"},{"langCd":"KO","name":"S21"}],"poiCode":"","posX":"-257.9","posY":"0","posZ":"181.1","sceneId":"SCN000037","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:06.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000035","poiNmList":[{"langCd":"EN","name":"154K"},{"langCd":"KO","name":"154K"}],"poiCode":"","posX":"173","posY":"0","posZ":"164","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:07.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000036","poiNmList":[{"langCd":"EN","name":"가설식당-2"},{"langCd":"KO","name":"가설식당-2"}],"poiCode":"","posX":"233.7","posY":"0","posZ":"152.6","sceneId":"SCN000041","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:07.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000038","poiNmList":[{"langCd":"EN","name":"E01_154K"},{"langCd":"KO","name":"E01_154K"}],"poiCode":"","posX":"169","posY":"0","posZ":"163.8","sceneId":"SCN000039","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:08.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000039","poiNmList":[{"langCd":"EN","name":"A1"},{"langCd":"KO","name":"A1"}],"poiCode":"","posX":"-69.6","posY":"0","posZ":"41.9","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:09.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000040","poiNmList":[{"langCd":"EN","name":"A2"},{"langCd":"KO","name":"A2"}],"poiCode":"","posX":"-56.51","posY":"0","posZ":"39.5","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:09.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000041","poiNmList":[{"langCd":"EN","name":"A3"},{"langCd":"KO","name":"A3"}],"poiCode":"","posX":"-40.29","posY":"0","posZ":"52.01","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:10.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000042","poiNmList":[{"langCd":"EN","name":"A4"},{"langCd":"KO","name":"A4"}],"poiCode":"","posX":"-40.2","posY":"0","posZ":"29.96","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:10.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000043","poiNmList":[{"langCd":"EN","name":"A5"},{"langCd":"KO","name":"A5"}],"poiCode":"","posX":"-28.11","posY":"0","posZ":"40.3","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:11.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000044","poiNmList":[{"langCd":"EN","name":"A6"},{"langCd":"KO","name":"A6"}],"poiCode":"","posX":"-74.5","posY":"0","posZ":"-27","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:11.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000045","poiNmList":[{"langCd":"EN","name":"A7"},{"langCd":"KO","name":"A7"}],"poiCode":"","posX":"-65.5","posY":"0","posZ":"-27","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:12.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000046","poiNmList":[{"langCd":"EN","name":"A8"},{"langCd":"KO","name":"A8"}],"poiCode":"","posX":"-40.5","posY":"0","posZ":"-27","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:12.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000047","poiNmList":[{"langCd":"EN","name":"B1"},{"langCd":"KO","name":"B1"}],"poiCode":"","posX":"74.7","posY":"0","posZ":"22.8","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:13.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000048","poiNmList":[{"langCd":"EN","name":"B2"},{"langCd":"KO","name":"B2"}],"poiCode":"","posX":"75","posY":"0","posZ":"46","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:13.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000049","poiNmList":[{"langCd":"EN","name":"B3"},{"langCd":"KO","name":"B3"}],"poiCode":"","posX":"40.8","posY":"0","posZ":"33.9","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:14.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000050","poiNmList":[{"langCd":"EN","name":"B4"},{"langCd":"KO","name":"B4"}],"poiCode":"","posX":"5.7","posY":"0","posZ":"40.3","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:14.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000051","poiNmList":[{"langCd":"EN","name":"A복도"},{"langCd":"KO","name":"A복도"}],"poiCode":"","posX":"-9.13","posY":"0","posZ":"11.25","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:18.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000052","poiNmList":[{"langCd":"EN","name":"B복도"},{"langCd":"KO","name":"B복도"}],"poiCode":"","posX":"55.79","posY":"0","posZ":"39.59","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:19.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000053","poiNmList":[{"langCd":"EN","name":"북서문(IN)"},{"langCd":"KO","name":"북서문(IN)"}],"poiCode":"","posX":"-326","posY":"0","posZ":"169","sceneId":"SCN000043","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:19.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000054","poiNmList":[{"langCd":"EN","name":"북서문(OUT)"},{"langCd":"KO","name":"북서문(OUT)"}],"poiCode":"","posX":"-338","posY":"0","posZ":"192","sceneId":"SCN000043","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:20.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000055","poiNmList":[{"langCd":"EN","name":"북서문"}],"poiCode":"","posX":"-342.5","posY":"0","posZ":"188.5","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:20.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000056","poiNmList":[{"langCd":"EN","name":"FAB_5F"}],"poiCode":"","posX":"3","posY":"0","posZ":"-9","sceneId":"SCN000045","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:21.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000057","poiNmList":[{"langCd":"EN","name":"공동구1"},{"langCd":"KO","name":"공동구1"}],"poiCode":"","posX":"-37.7","posY":"0","posZ":"-6.3","sceneId":"SCN000046","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:21.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]},{"poiId":"POI000058","poiNmList":[{"langCd":"EN","name":"공동구2"},{"langCd":"KO","name":"공동구2"}],"poiCode":"","posX":"-47.5","posY":"0","posZ":"-35","sceneId":"SCN000047","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-13 10:23:22.0","updateDate":"2017-10-13 10:51:35.0","itemList":[{"index":"0","item":"","value":""},{"index":"1","item":"","value":""},{"index":"2","item":"","value":""},{"index":"3","item":"","value":""},{"index":"4","item":"","value":""},{"index":"5","item":"","value":""},{"index":"6","item":"","value":""},{"index":"7","item":"","value":""},{"index":"8","item":"","value":""},{"index":"9","item":"","value":""}]}]}}';
	}
	else {
		data_list = '{"header":{"resultCode":"0000","resultMsg":"Success"},"body":{"poiList":[{"poiId":"POI000012","poiNmList":[{"langCd":"EN","name":"FAB_B1F"},{"langCd":"KO","name":"FAB_B1F"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-24 13:36:23.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000013","poiNmList":[{"langCd":"EN","name":"FAB_1F"},{"langCd":"KO","name":"FAB_1F"}],"poiCode":"","posX":"4","posY":"0","posZ":"-11","sceneId":"SCN000021","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-24 13:37:41.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000014","poiNmList":[{"langCd":"EN","name":"FAB_2F"},{"langCd":"KO","name":"FAB_2F"}],"poiCode":"","posX":"5","posY":"0","posZ":"-11","sceneId":"SCN000022","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 11:19:23.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000015","poiNmList":[{"langCd":"EN","name":"FAB_3F"},{"langCd":"KO","name":"FAB_3F"}],"poiCode":"","posX":"5","posY":"0","posZ":"-10","sceneId":"SCN000023","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 14:04:09.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000016","poiNmList":[{"langCd":"EN","name":"FAB_4F"},{"langCd":"KO","name":"FAB_4F"}],"poiCode":"","posX":"3","posY":"0","posZ":"-9","sceneId":"SCN000024","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 14:04:09.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000017","poiNmList":[{"langCd":"EN","name":"CUB_1F"},{"langCd":"KO","name":"CUB_1F"}],"poiCode":"","posX":"-51","posY":"0","posZ":"11","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 16:17:49.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000018","poiNmList":[{"langCd":"EN","name":"WWT_B1F"},{"langCd":"KO","name":"WWT_B1F"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 16:17:50.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000019","poiNmList":[{"langCd":"EN","name":"WWT_1F"},{"langCd":"KO","name":"WWT_1F"}],"poiCode":"","posX":"-42","posY":"0","posZ":"3","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 16:17:51.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000020","poiNmList":[{"langCd":"EN","name":"CUB"},{"langCd":"KO","name":"CUB"}],"poiCode":"","posX":"-71","posY":"0","posZ":"152","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 17:28:19.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000021","poiNmList":[{"langCd":"EN","name":"WWT"},{"langCd":"KO","name":"WWT"}],"poiCode":"","posX":"-185","posY":"0","posZ":"-172","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 17:28:21.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000022","poiNmList":[{"langCd":"EN","name":"북문"},{"langCd":"KO","name":"북문"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 17:28:26.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000023","poiNmList":[{"langCd":"EN","name":"남문"},{"langCd":"KO","name":"남문"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 17:28:27.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000024","poiNmList":[{"langCd":"EN","name":"남문(IN)"},{"langCd":"KO","name":"남문(IN)"}],"poiCode":"","posX":"-70","posY":"0","posZ":"-220","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 17:31:36.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000025","poiNmList":[{"langCd":"EN","name":"남문(OUT)"},{"langCd":"KO","name":"남문(OUT)"}],"poiCode":"","posX":"-70","posY":"0","posZ":"-243","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 17:31:37.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000026","poiNmList":[{"langCd":"EN","name":"북문(차량IN)"},{"langCd":"KO","name":"북문(차량IN)"}],"poiCode":"","posX":"108","posY":"0","posZ":"214","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 17:35:04.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000027","poiNmList":[{"langCd":"EN","name":"북문(차량OUT)"},{"langCd":"KO","name":"북문(차량OUT)"}],"poiCode":"","posX":"108","posY":"0","posZ":"245","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 17:35:04.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000028","poiNmList":[{"langCd":"EN","name":"FAB"},{"langCd":"KO","name":"FAB"}],"poiCode":"","posX":"-83.2","posY":"0","posZ":"5.4","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-25 19:03:29.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000029","poiNmList":[{"langCd":"EN","name":"저수조"},{"langCd":"KO","name":"저수조"}],"poiCode":"","posX":"-250","posY":"0","posZ":"165","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-31 17:13:59.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000030","poiNmList":[{"langCd":"EN","name":"FAB_외각"},{"langCd":"KO","name":"FAB_외각"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-31 17:14:06.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000031","poiNmList":[{"langCd":"EN","name":"E01"},{"langCd":"KO","name":"E01"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-31 17:14:14.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000032","poiNmList":[{"langCd":"EN","name":"가설식당"},{"langCd":"KO","name":"가설식당"}],"poiCode":"","posX":"233.7","posY":"0","posZ":"152.6","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-31 17:14:15.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000033","poiNmList":[{"langCd":"EN","name":"주차장"},{"langCd":"KO","name":"주차장"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-31 17:14:16.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000034","poiNmList":[{"langCd":"EN","name":"저수조_1F"},{"langCd":"KO","name":"저수조_1F"}],"poiCode":"","posX":"-260","posY":"0","posZ":"162","sceneId":"SCN000037","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-05 16:26:56.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000035","poiNmList":[{"langCd":"EN","name":"154Kv"},{"langCd":"KO","name":"154Kv"}],"poiCode":"","posX":"173","posY":"0","posZ":"164","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-05 16:29:51.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000001","poiNmList":[{"langCd":"EN","name":"FABtest"},{"langCd":"KO","name":"FABtest"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-07-18 17:26:15.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000002","poiNmList":[{"langCd":"EN","name":"Outdoor"},{"langCd":"KO","name":"Outdoor"}],"poiCode":"","posX":"204.5","posY":"0","posZ":"-46","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-07-18 17:26:21.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000005","poiNmList":[{"langCd":"EN","name":"동문"},{"langCd":"KO","name":"동문"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-07-20 10:23:08.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000006","poiNmList":[{"langCd":"EN","name":"서문"},{"langCd":"KO","name":"서문"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-07-20 10:23:08.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000009","poiNmList":[{"langCd":"EN","name":"근로자쉼터"},{"langCd":"KO","name":"근로자쉼터"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-07-20 14:51:41.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000010","poiNmList":[{"langCd":"EN","name":"북문(사람OUT)"},{"langCd":"KO","name":"북문(사람OUT)"}],"poiCode":"","posX":"167","posY":"0","posZ":"240","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-24 13:17:02.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000011","poiNmList":[{"langCd":"EN","name":"북문(사람IN)"},{"langCd":"KO","name":"북문(사람IN)"}],"poiCode":"","posX":"167","posY":"0","posZ":"219","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-08-24 13:17:03.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000052","poiNmList":[{"langCd":"EN","name":"B복도"},{"langCd":"KO","name":"B복도"}],"poiCode":"","posX":"55.79","posY":"0","posZ":"39.59","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 14:09:56.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000053","poiNmList":[{"langCd":"EN","name":"북서문(IN)"},{"langCd":"KO","name":"북서문(IN)"}],"poiCode":"","posX":"-349","posY":"0","posZ":"167","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-09-22 13:51:59.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000054","poiNmList":[{"langCd":"EN","name":"북서문(OUT)"},{"langCd":"KO","name":"북서문(OUT)"}],"poiCode":"","posX":"-371","posY":"0","posZ":"190","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-09-22 13:52:00.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000055","poiNmList":[{"langCd":"EN","name":"북서문"},{"langCd":"KO","name":"북서문"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-09-22 14:08:13.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000056","poiNmList":[{"langCd":"EN","name":"FAB_5F"},{"langCd":"KO","name":"FAB_5F"}],"poiCode":"","posX":"3","posY":"0","posZ":"-9","sceneId":"SCN000054","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-09-29 17:05:21.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000057","poiNmList":[{"langCd":"EN","name":"공동구1"},{"langCd":"KO","name":"공동구1"}],"poiCode":"","posX":"","posY":"","posZ":"","sceneId":"","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-09 16:58:22.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000078","poiNmList":[{"langCd":"EN","name":"03_FTC06"},{"langCd":"KO","name":"03_FTC06"}],"poiCode":"","posX":"161.08","posY":"0.6","posZ":"40.95","sceneId":"SCN000045","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 21:00:44.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000058","poiNmList":[{"langCd":"EN","name":"PIT(공동구)"},{"langCd":"KO","name":"PIT(공동구)"}],"poiCode":"","posX":"-51","posY":"0","posZ":"-12","sceneId":"SCN000047","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-09 17:04:01.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000059","poiNmList":[{"langCd":"EN","name":"전력 공동구(CUB)"},{"langCd":"KO","name":"전력 공동구(CUB)"}],"poiCode":"","posX":"-3.8","posY":"0","posZ":"38.7","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 19:47:13.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000060","poiNmList":[{"langCd":"EN","name":"전력 공동구(주차장)"},{"langCd":"KO","name":"전력 공동구(주차장)"}],"poiCode":"","posX":"99.7","posY":"0","posZ":"38","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 19:48:09.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000061","poiNmList":[{"langCd":"EN","name":"F03-1"},{"langCd":"KO","name":"F03-1"}],"poiCode":"","posX":"-134","posY":"0","posZ":"69","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 19:48:34.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000062","poiNmList":[{"langCd":"EN","name":"F03-2"},{"langCd":"KO","name":"F03-2"}],"poiCode":"","posX":"-61.5","posY":"0","posZ":"69","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:06:05.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000064","poiNmList":[{"langCd":"EN","name":"F02-1"},{"langCd":"KO","name":"F02-1"}],"poiCode":"","posX":"-148","posY":"0","posZ":"-45","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:07:43.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000065","poiNmList":[{"langCd":"EN","name":"F02-2"},{"langCd":"KO","name":"F02-2"}],"poiCode":"","posX":"-148","posY":"0","posZ":"26.5","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:07:54.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000069","poiNmList":[{"langCd":"EN","name":"가스공동구"},{"langCd":"KO","name":"가스공동구"}],"poiCode":"","posX":"-123.5","posY":"0","posZ":"-2","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:08:34.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000070","poiNmList":[{"langCd":"EN","name":"배관공동구"},{"langCd":"KO","name":"배관공동구"}],"poiCode":"","posX":"-37.5","posY":"0","posZ":"-2","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:08:48.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000066","poiNmList":[{"langCd":"EN","name":"F04-1"},{"langCd":"KO","name":"F04-1"}],"poiCode":"","posX":"-83","posY":"0","posZ":"-73.5","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:08:09.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000067","poiNmList":[{"langCd":"EN","name":"F04-2"},{"langCd":"KO","name":"F04-2"}],"poiCode":"","posX":"12.5","posY":"0","posZ":"-73.5","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:08:18.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000072","poiNmList":[{"langCd":"EN","name":"B102"},{"langCd":"KO","name":"B102"}],"poiCode":"","posX":"-275.5","posY":"0","posZ":"157.5","sceneId":"SCN000050","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:37:31.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000063","poiNmList":[{"langCd":"EN","name":"F03-3"},{"langCd":"KO","name":"F03-3"}],"poiCode":"","posX":"19","posY":"0","posZ":"69","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:06:44.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000068","poiNmList":[{"langCd":"EN","name":"F04-3"},{"langCd":"KO","name":"F04-3"}],"poiCode":"","posX":"122.5","posY":"0","posZ":"-73.5","sceneId":"SCN000020","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:08:27.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000073","poiNmList":[{"langCd":"EN","name":"B103"},{"langCd":"KO","name":"B103"}],"poiCode":"","posX":"-275.5","posY":"0","posZ":"133","sceneId":"SCN000050","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:37:31.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000074","poiNmList":[{"langCd":"EN","name":"PIT(B1M03)"},{"langCd":"KO","name":"PIT(B1M03)"}],"poiCode":"","posX":"-323.5","posY":"0","posZ":"162","sceneId":"SCN000050","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:37:32.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000076","poiNmList":[{"langCd":"EN","name":"07_CTC01"},{"langCd":"KO","name":"07_CTC01"}],"poiCode":"","posX":"-54","posY":"0.6","posZ":"5","sceneId":"SCN000048","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 21:00:42.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000077","poiNmList":[{"langCd":"EN","name":"08_CTC03"},{"langCd":"KO","name":"08_CTC03"}],"poiCode":"","posX":"31","posY":"0.6","posZ":"5","sceneId":"SCN000048","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 21:00:43.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000075","poiNmList":[{"langCd":"EN","name":"저수조기계실"},{"langCd":"KO","name":"저수조기계실"}],"poiCode":"","posX":"-212","posY":"0","posZ":"162","sceneId":"SCN000050","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:37:33.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000071","poiNmList":[{"langCd":"EN","name":"B101"},{"langCd":"KO","name":"B101"}],"poiCode":"","posX":"-275.5","posY":"0","posZ":"186.5","sceneId":"SCN000050","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 20:37:28.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000082","poiNmList":[{"langCd":"EN","name":"01_FTC01"},{"langCd":"KO","name":"01_FTC01"}],"poiCode":"","posX":"-129.92","posY":"0.6","posZ":"48.95","sceneId":"SCN000045","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 21:00:46.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000036","poiNmList":[{"langCd":"EN","name":"가설식당-2"},{"langCd":"KO","name":"가설식당-2"}],"poiCode":"","posX":"233.7","posY":"0","posZ":"152.6","sceneId":"SCN000041","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-05 16:30:38.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000038","poiNmList":[{"langCd":"EN","name":"E01_154K"},{"langCd":"KO","name":"E01_154K"}],"poiCode":"","posX":"169","posY":"0","posZ":"163.8","sceneId":"SCN000039","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-05 16:34:09.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000039","poiNmList":[{"langCd":"EN","name":"A1"},{"langCd":"KO","name":"A1"}],"poiCode":"","posX":"-69.6","posY":"0","posZ":"41.9","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-05 17:26:14.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000040","poiNmList":[{"langCd":"EN","name":"A2"},{"langCd":"KO","name":"A2"}],"poiCode":"","posX":"-56.51","posY":"0","posZ":"39.5","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:52.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000041","poiNmList":[{"langCd":"EN","name":"A3"},{"langCd":"KO","name":"A3"}],"poiCode":"","posX":"-40.29","posY":"0","posZ":"52.01","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:53.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000042","poiNmList":[{"langCd":"EN","name":"A4"},{"langCd":"KO","name":"A4"}],"poiCode":"","posX":"-40.2","posY":"0","posZ":"29.96","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:53.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000048","poiNmList":[{"langCd":"EN","name":"B2"},{"langCd":"KO","name":"B2"}],"poiCode":"","posX":"75","posY":"0","posZ":"46","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:54:58.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000043","poiNmList":[{"langCd":"EN","name":"A5"},{"langCd":"KO","name":"A5"}],"poiCode":"","posX":"-28.11","posY":"0","posZ":"40.3","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:54.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000044","poiNmList":[{"langCd":"EN","name":"A6"},{"langCd":"KO","name":"A6"}],"poiCode":"","posX":"-74.5","posY":"0","posZ":"-27","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:54.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000045","poiNmList":[{"langCd":"EN","name":"A7"},{"langCd":"KO","name":"A7"}],"poiCode":"","posX":"-65.5","posY":"0","posZ":"-27","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:55.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000046","poiNmList":[{"langCd":"EN","name":"A8"},{"langCd":"KO","name":"A8"}],"poiCode":"","posX":"-40.5","posY":"0","posZ":"-27","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:51:55.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000047","poiNmList":[{"langCd":"EN","name":"B1"},{"langCd":"KO","name":"B1"}],"poiCode":"","posX":"74.7","posY":"0","posZ":"22.8","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:54:58.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000049","poiNmList":[{"langCd":"EN","name":"B3"},{"langCd":"KO","name":"B3"}],"poiCode":"","posX":"40.8","posY":"0","posZ":"33.9","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:54:59.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000050","poiNmList":[{"langCd":"EN","name":"B4"},{"langCd":"KO","name":"B4"}],"poiCode":"","posX":"5.7","posY":"0","posZ":"40.3","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 09:54:59.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000051","poiNmList":[{"langCd":"EN","name":"A복도"},{"langCd":"KO","name":"A복도"}],"poiCode":"","posX":"-9.13","posY":"0","posZ":"11.25","sceneId":"SCN000032","sectionId":"SEC000001","descriptionList":[],"createBy":"liveinyou26","createDate":"2017-09-06 14:09:56.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000086","poiNmList":[{"langCd":"EN","name":"CUB_2F"},{"langCd":"KO","name":"CUB_2F"}],"poiCode":"","posX":"-2.5","posY":"0","posZ":"18","sceneId":"SCN000052","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-11-03 18:43:57.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000087","poiNmList":[{"langCd":"EN","name":"CUB_3F"},{"langCd":"KO","name":"CUB_3F"}],"poiCode":"","posX":"0","posY":"0","posZ":"17","sceneId":"SCN000053","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-11-03 18:43:58.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000088","poiNmList":[{"langCd":"EN","name":"저수조 TBM"},{"langCd":"KO","name":"저수조 TBM"}],"poiCode":"","posX":"-260","posY":"0","posZ":"220","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-11-03 18:48:56.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000089","poiNmList":[{"langCd":"EN","name":"154Kv TBM"},{"langCd":"KO","name":"154Kv TBM"}],"poiCode":"","posX":"167","posY":"0","posZ":"198","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-11-03 18:48:57.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000090","poiNmList":[{"langCd":"EN","name":"FAB TBM"},{"langCd":"KO","name":"FAB TBM"}],"poiCode":"","posX":"101","posY":"0","posZ":"6","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-11-03 18:48:58.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000091","poiNmList":[{"langCd":"EN","name":"WWT TBM"},{"langCd":"KO","name":"WWT TBM"}],"poiCode":"","posX":"-65","posY":"0","posZ":"-188","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-11-03 18:48:59.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000085","poiNmList":[{"langCd":"EN","name":"전력공동구"},{"langCd":"KO","name":"전력공동구"}],"poiCode":"","posX":"169","posY":"0","posZ":"163.8","sceneId":"SCN000051","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-18 09:54:51.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000079","poiNmList":[{"langCd":"EN","name":"04_FTC19"},{"langCd":"KO","name":"04_FTC19"}],"poiCode":"","posX":"-127.92","posY":"0.6","posZ":"-62.05","sceneId":"SCN000045","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 21:00:44.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000080","poiNmList":[{"langCd":"EN","name":"05_FTC21"},{"langCd":"KO","name":"05_FTC21"}],"poiCode":"","posX":"1.08","posY":"0.6","posZ":"-63.05","sceneId":"SCN000045","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 21:00:45.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000081","poiNmList":[{"langCd":"EN","name":"05_FTC23"},{"langCd":"KO","name":"05_FTC23"}],"poiCode":"","posX":"132.08","posY":"0.6","posZ":"-64.05","sceneId":"SCN000045","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 21:00:46.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000083","poiNmList":[{"langCd":"EN","name":"02_FTC03"},{"langCd":"KO","name":"02_FTC03"}],"poiCode":"","posX":"-0.92","posY":"0.6","posZ":"48.95","sceneId":"SCN000045","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 21:00:47.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000084","poiNmList":[{"langCd":"EN","name":"09_WTC02"},{"langCd":"KO","name":"09_WTC02"}],"poiCode":"","posX":"-54.92","posY":"0.6","posZ":"-4.05","sceneId":"SCN000049","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-10-17 21:00:48.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000122","poiNmList":[{"langCd":"EN","name":"발전기동"},{"langCd":"KO","name":"발전기동"}],"poiCode":"","posX":"-5","posY":"0","posZ":"205","sceneId":"SCN000016","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-01 13:11:33.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000133","poiNmList":[{"langCd":"EN","name":"A1"}],"poiCode":"","posX":"5.5","posY":"0.5","posZ":"3.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 16:59:04.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000134","poiNmList":[{"langCd":"EN","name":"A2"}],"poiCode":"","posX":"5.5","posY":"0.5","posZ":"-4.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 16:59:05.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000135","poiNmList":[{"langCd":"EN","name":"A3"}],"poiCode":"","posX":"5.5","posY":"0.5","posZ":"-12.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 16:59:05.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000136","poiNmList":[{"langCd":"EN","name":"A4"}],"poiCode":"","posX":"5.5","posY":"0.5","posZ":"-20.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 16:59:06.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000137","poiNmList":[{"langCd":"EN","name":"A5"}],"poiCode":"","posX":"59.5","posY":"0.5","posZ":"3.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 16:59:06.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000142","poiNmList":[{"langCd":"EN","name":"B2"}],"poiCode":"","posX":"16","posY":"0.5","posZ":"41.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 16:59:09.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000149","poiNmList":[{"langCd":"EN","name":"B9"}],"poiCode":"","posX":"64","posY":"0.5","posZ":"35.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 17:00:07.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000124","poiNmList":[{"langCd":"EN","name":"WASTE WATER"},{"langCd":"KO","name":"WASTE WATER"}],"poiCode":"","posX":"20.71","posY":"0","posZ":"28.3","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-01 17:51:43.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000125","poiNmList":[{"langCd":"EN","name":"RAW WATER"},{"langCd":"KO","name":"RAW WATER"}],"poiCode":"","posX":"44.8","posY":"0","posZ":"28.26","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-01 17:51:43.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000126","poiNmList":[{"langCd":"EN","name":"FILTERED WATER"},{"langCd":"KO","name":"FILTERED WATER"}],"poiCode":"","posX":"74.7","posY":"0","posZ":"28.3","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-01 17:51:44.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000127","poiNmList":[{"langCd":"EN","name":"RO PERMEATE"},{"langCd":"KO","name":"RO PERMEATE"}],"poiCode":"","posX":"44.5","posY":"0","posZ":"-2.52","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-01 17:51:44.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000128","poiNmList":[{"langCd":"EN","name":"PRETREATED WATER"},{"langCd":"KO","name":"PRETREATED WATER"}],"poiCode":"","posX":"63.5","posY":"0","posZ":"-2.5","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-01 17:51:45.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000129","poiNmList":[{"langCd":"EN","name":"DBP REGENERATION"},{"langCd":"KO","name":"DBP REGENERATION"}],"poiCode":"","posX":"76.5","posY":"0","posZ":"4.5","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-01 17:51:46.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000130","poiNmList":[{"langCd":"EN","name":"RECLAIM WATER"},{"langCd":"KO","name":"RECLAIM WATER"}],"poiCode":"","posX":"76.5","posY":"0","posZ":"-1.5","sceneId":"SCN000026","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-01 17:51:46.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000131","poiNmList":[{"langCd":"EN","name":"압입구"},{"langCd":"KO","name":"압입구"}],"poiCode":"","posX":"-315","posY":"0","posZ":"168","sceneId":"SCN000056","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-07 13:57:20.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000132","poiNmList":[{"langCd":"EN","name":"압입구"},{"langCd":"KO","name":"압입구"}],"poiCode":"","posX":"-318","posY":"0","posZ":"168","sceneId":"SCN000001","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-08 12:17:07.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":""},{"index":"1","item":null,"value":""},{"index":"2","item":null,"value":""},{"index":"3","item":null,"value":""},{"index":"4","item":null,"value":""},{"index":"5","item":null,"value":""},{"index":"6","item":null,"value":""},{"index":"7","item":null,"value":""},{"index":"8","item":null,"value":""},{"index":"9","item":null,"value":""}]},{"poiId":"POI000140","poiNmList":[{"langCd":"EN","name":"A8"}],"poiCode":"","posX":"59.5","posY":"0.5","posZ":"-20.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 16:59:08.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000141","poiNmList":[{"langCd":"EN","name":"B1"}],"poiCode":"","posX":"16","posY":"0.5","posZ":"47.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 16:59:08.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000143","poiNmList":[{"langCd":"EN","name":"B3"}],"poiCode":"","posX":"16","posY":"0.5","posZ":"35.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 17:00:04.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000144","poiNmList":[{"langCd":"EN","name":"B4"}],"poiCode":"","posX":"16","posY":"0.5","posZ":"29.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 17:00:04.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000138","poiNmList":[{"langCd":"EN","name":"A6"}],"poiCode":"","posX":"59.5","posY":"0.5","posZ":"-4.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 16:59:07.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000139","poiNmList":[{"langCd":"EN","name":"A7"}],"poiCode":"","posX":"59.5","posY":"0.5","posZ":"-12.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 16:59:07.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000145","poiNmList":[{"langCd":"EN","name":"B5"}],"poiCode":"","posX":"16","posY":"0.5","posZ":"23.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 17:00:05.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000146","poiNmList":[{"langCd":"EN","name":"B6"}],"poiCode":"","posX":"16","posY":"0.5","posZ":"17.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 17:00:05.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000147","poiNmList":[{"langCd":"EN","name":"B7"}],"poiCode":"","posX":"64","posY":"0.5","posZ":"47.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 17:00:06.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000148","poiNmList":[{"langCd":"EN","name":"B8"}],"poiCode":"","posX":"64","posY":"0.5","posZ":"41.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 17:00:06.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000150","poiNmList":[{"langCd":"EN","name":"B10"}],"poiCode":"","posX":"64","posY":"0.5","posZ":"29.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 17:00:07.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000151","poiNmList":[{"langCd":"EN","name":"B11"}],"poiCode":"","posX":"64","posY":"0.5","posZ":"23.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 17:00:08.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]},{"poiId":"POI000152","poiNmList":[{"langCd":"EN","name":"B12"}],"poiCode":"","posX":"64","posY":"0.5","posZ":"17.5","sceneId":"SCN000036","sectionId":"SEC000001","descriptionList":[],"createBy":"cosmoz","createDate":"2017-12-22 17:00:08.0","updateDate":"2017-12-22 17:03:23.0","itemList":[{"index":"0","item":null,"value":null},{"index":"1","item":null,"value":null},{"index":"2","item":null,"value":null},{"index":"3","item":null,"value":null},{"index":"4","item":null,"value":null},{"index":"5","item":null,"value":null},{"index":"6","item":null,"value":null},{"index":"7","item":null,"value":null},{"index":"8","item":null,"value":null},{"index":"9","item":null,"value":null}]}]}}';
	}

	s_PoiList = new PoiList_Response();
	s_PoiList.setData(JSON.parse(data_list));
	s_PoiTableMap.setPoiList(s_PoiList);
}
// --------------------------------------------------------------
//
// 테스트
// 
// --------------------------------------------------------------
function Test_AirTagHelper() {

	var s_AtlasHelper = new AtlasHelper;
	var Image = s_AtlasHelper.getMyPosition();

	var s_AirTagHelper = new AirTagHelper;

	// setup
	s_AirTagHelper.setup();

	// get
	var tagMap = s_AirTagHelper.getAirtagMap();

	// test
	var AirTag_01 = new AirTag('airtag_001');

	var AirTag_02 = new AirTag('airtag_002');
	AirTag_02.setPoiID('poi_01');

	var AirTag_03 = new AirTag('airtag_003');

	tagMap.add(AirTag_01);
	tagMap.add(AirTag_02);
	tagMap.add(AirTag_03);

	// getAirtagByPoiId
	var list_Airtag = s_AirTagHelper.getAirtagByPoiId('poi_01');

	// showAll
	s_AirTagHelper.showAll('true');

	// clear
	// s_AirTagHelper.clear();

	// delete
	s_AirTagHelper.delete('airtag_002');

	// showSensor
//	s_AirTagHelper.showSensor('poi_01', 150);
//
//	// showAp
//	s_AirTagHelper.showAp('poi_01', 100);
//
//	// showWorker
	s_AirTagHelper.showWorker('POI000006', 200, WORKER_COLOR.RED);
//
//	// showCCTV
//	s_AirTagHelper.showCCTV('poi_01', 100, SAFE_STATE.NORMAL);
//
//	// showVisit
//	s_AirTagHelper.showVisit('poi_01', 100);

	// showMessageBoxSmall
	s_AirTagHelper.showMessageBoxSmall('POI000006', 'msg', SAFE_STATE.NORMAL, 'gas');

//	// showGasValue
//	s_AirTagHelper.showGasValue('poi_01', 'msg', SAFE_STATE.CHECK);
//
//	// showMessageBoxLarge
//	s_AirTagHelper.showMessageBoxLarge('poi_01', 'msg', SAFE_STATE.CHECK);
//
//	// showMyPosition
//	s_AirTagHelper.showMyPosition('poi_01');

	// showAirTag
	background = AtlasImage();
	s_AirTagHelper.showAirTag('poi_01', 'airtag_01', 100, background);

	// showAirTag
	s_AirTagHelper.showAirTag('poi_01', 'airtag_01', 100, background, 10);

	// releaseAirTag
	s_AirTagHelper.releaseAirTag('airtag_01');

	// getTag
	s_AirTagHelper.getTag('airtag_01');

	// getTagByPoi
	s_AirTagHelper.getTagByPoi('poi_01');

	// rePositionAirTag
	s_AirTagHelper.rePositionAirTag('poi_01');

	// isValid
	s_AirTagHelper.isValid();

	// rePositionAirTag
	s_AirTagHelper.rePositionAirTag_3('airtag_01', 'poi_01', AIRTAG_POSITION.LEFT);

	// getPoiWidth
	s_AirTagHelper.getPoiWidth('airtag_01');

	// getPoiHeight
	s_AirTagHelper.getPoiHeight('airtag_01');


}

// --------------------------------------------------------------------
//
//
//
// --------------------------------------------------------------------
function EventType_Node(condition_type) {
	this.condition_type = condition_type;
	this.total_count = 0;
	this.unsolved_count = 0;
}

function SensorBecon_Node() {
	this.sensors_node = new Array; // Sensor_Node
	this.sb_node;
}

function Gas_Node() {
	this.sb_node = new Array; // SensorBecon_Node
	this.gas;
}

function GetName_SensorType(sensor_type) {
	var type = '';
	switch(sensor_type) {
		case 'SSTP0000':
			type = '산소';
			break;
		case 'SSTP0001':
			type = '일산화탄소';
			break;
		case 'SSTP0002':
			type = '메탄';
			break;
		case 'SSTP0003':
			type = '황화수소';
			break;
		case 'SSTP0004':
			type = '온도';
			break;
		case 'SSTP0005':
			type = '습도';
			break;
		case 'SSTP0006':
			type = '진동';
			break;
		case 'SSTP0007':
			type = '배터리';
			break;
		case 'SSTP0008':
			type = '온/습도';
			break;
		case 'SSTP0100':
			type = '심장박동';
			break;
		case 'SSTP0101':
			type = '일산화탄소';
			break;
		case 'SSTP0102':
			type = '배터리';
			break;
		case 'SSTP0103':
			type = '움직임';
			break;
		case 'SSTP0200':
			type = '배터리';
			break;
		case 'SSTP1100':
			type = '온도';
			break;
		case 'SSTP1101':
			type = '풍속';
			break;
	}
	return type;
}

function Cell_Area_Type() {
	this.poi_id = '';
	this.color = '#ffffff';
}

function Cell_Node() {
	this.cell = null;
	this.count_worker = 0;

	this.poi = null;

	this.arrAirTag_Node = new Array;

	// 중점관리 여부
	this.watch_area_yn = false;

	// worker
	this.count_safe_worker = 0;

	// cctv
	this.count_cctv = 0;

	this.array_poi_cctv = new Array;

	this.push_poi_cctv = function(poi_id) {
		this.filter_array_poi(this.array_poi_cctv, poi_id);
	}

	this.filter_array_poi = function(arr, poi_id) {
		var bFind = false;
		for(var i = 0; i < arr.length; i++) {
			if(arr[i] == poi_id) {
				bFind = true;
			}
		}
		if(!bFind) {
			arr.push(poi_id);
		}
	}

	// gas
	this.gas_node = new Gas_Node;
	this.count_gas_01 = 0; // 안전
	this.count_gas_02 = 0; // 점검
	this.count_gas_03 = 0; // 주의
	this.count_gas_04 = 0; // 위험

	this.gas_msg;
	
	this.array_sb_msg = new Array;
	
	this.push_sb_msg = function(sb_msg, sb_status) {
		//this.filter_array_sb_msg(this.array_sb_msg, sb_msg);
		this.array_sb_msg.push({
			 msg : sb_msg,
			 status : sb_status
		});
	}

	this.filter_array_sb_msg = function(arr, sb_msg) {
		var bFind = false;
		for(var i = 0; i < arr.length; i++) {
			if(arr[i] == sb_msg) {
				bFind = true;
			}
		}
		if(!bFind) {
			arr.push(sb_msg);
		}
	}

	this.gas_safe_status_check = false; // 점검
	
	this.gas_safe_status = '01'; // 안전

	// 뎁스 1에서 위험 경고 현황
	this.h_violation_use = false;
	this.h_imCall_use = false;
	this.h_actionstop_use = false;
	this.h_gas_use = false;

	this.update = function() {

		var sensors_node_null = false;
		for(var i = 0; i < this.gas_node.sb_node.length; i++) {
			var sb_node = this.gas_node.sb_node[i];

			var sensors_node = sb_node.sensors_node[0];
			if(sensors_node == null) {
				sensors_node_null = true;
				break;
			}
//			if(i == 0) {
				this.gas_msg = this.cell.cell_name + '구역\n\n';

				var stype_0_value = '';
				var stype_1_value = '';
				var stype_2_value = '';
				var stype_3_value = '';

				// 0
				var stype_0 = sb_node.sensors_node[0];
				if(stype_0) {
					var stype_0_name = GetName_SensorType(stype_0.sensor_type);
					stype_0_value = stype_0.sensor_value;
				}

				// 1
				var stype_1 = sb_node.sensors_node[1];
				if(stype_1) {
					var stype_1_name = GetName_SensorType(stype_1.sensor_type);
					stype_1_value = stype_1.sensor_value;
				}

				// 2
				var stype_2 = sb_node.sensors_node[2];
				if(stype_2) {
					var stype_2_name = GetName_SensorType(stype_2.sensor_type);
					stype_2_value = stype_2.sensor_value;
				}

				// 3
				var stype_3 = sb_node.sensors_node[3];
				if(stype_3) {
					var stype_3_name = GetName_SensorType(stype_3.sensor_type);
					stype_3_value = stype_3.sensor_value;
				}

				// if(stype_0_name == undefined)
				// {
				// var xxx = 0;
				// }

				this.gas_msg += stype_0_name + ':' + stype_0_value + '/' + stype_1_name + ':' + stype_1_value + '\n\n';
				this.gas_msg += stype_2_name + ':' + stype_2_value + '/' + stype_3_name + ':' + stype_3_value + '\n\n';
				
				//this.gas_msg += stype_0_name + ':' + stype_0_value + '\n';
				
				this.sb_msg = this.gas_msg;
				
				this.push_sb_msg(this.gas_msg, sb_node.status);
//				break;
//			}
		}

		if(this.count_gas_02 == 0 && this.count_gas_03 == 0 && this.count_gas_04 == 0) {
			this.gas_msg = null;
		}
		else {

			if(this.count_gas_02 > 0) {
				this.gas_safe_status_check = true;

				this.gas_msg = this.cell.cell_name + ' 구역';

				this.h_gas_use = true;
			}
			else if(this.count_gas_03 > 0 || this.count_gas_04 > 0) {
				this.gas_safe_status_check = false;

				this.h_gas_use = true;
			}


			// this.h_gas_use = true;

			if(sensors_node_null) {
				this.h_gas_use = false;
			}
		}

		if(this.violation_EventType_today.condition_type == 'CDTP0100' || this.violation_EventType_total.condition_type == 'CDTP0100') {

			if(parseInt(this.violation_EventType_today.unsolved_count) == 0 &&
				parseInt(this.violation_EventType_today.total_count) == 0 &&
				parseInt(this.violation_EventType_total.unsolved_count) == 0 &&
				parseInt(this.violation_EventType_total.total_count) == 0) {
				this.violation_EventType_msg = null;
			}
			else {
				if(this.violation_EventType_today.unsolved_count == 0 &&
					this.violation_EventType_total.unsolved_count == 0) {

					this.violation_EventType_msg = null;
				}
				else {
					this.violation_EventType_msg = '[제한구역침범]' + this.cell.cell_name + '\n\n';
					this.violation_EventType_msg += '>일일:미해결 ' + parseInt(this.violation_EventType_today.unsolved_count) + '/' + parseInt(this.violation_EventType_today.total_count) + '\n\n';
					this.violation_EventType_msg += '>누적:미해결 ' + parseInt(this.violation_EventType_total.unsolved_count) + '/' + parseInt(this.violation_EventType_total.total_count);

					if(this.violation_EventType_today.unsolved_count > 0) {
						this.h_violation_use = true;
					}
					if(this.violation_EventType_total.unsolved_count > 0) {
						this.h_violation_use = true;
					}
				}
			}
		}

		if(this.imCall_EventType_today.condition_type == 'CDTP0201' || this.imCall_EventType_total.condition_type == 'CDTP0201' || 
		   this.actionStop_EventType_today.condition_type == 'CDTP0411' || this.actionStop_EventType_total.condition_type == 'CDTP0411') {

			if(parseInt(this.imCall_EventType_today.unsolved_count) == 0 &&
				parseInt(this.imCall_EventType_today.total_count) == 0 &&
				parseInt(this.imCall_EventType_total.unsolved_count) == 0 &&
				parseInt(this.imCall_EventType_total.total_count) == 0 && 
				
				parseInt(this.actionStop_EventType_today.unsolved_count) == 0 &&
				parseInt(this.actionStop_EventType_today.total_count) == 0 &&
				parseInt(this.actionStop_EventType_total.unsolved_count) == 0 &&
				parseInt(this.actionStop_EventType_total.total_count) == 0
			) {
				this.imCall_EventType_msg = null;
			}
			else {
				if(this.imCall_EventType_today.unsolved_count == 0 &&
					this.imCall_EventType_total.unsolved_count == 0 && 
					this.actionStop_EventType_today.unsolved_count == 0 &&
					this.actionStop_EventType_total.unsolved_count == 0 ) {

					this.imCall_EventType_msg = null;
				}
				else {
					this.imCall_EventType_msg = '[긴급호출/정지]' + this.cell.cell_name + '\n\n';
					
					this.imCall_EventType_msg += '>일일:미해결 ' + parseInt(this.imCall_EventType_today.unsolved_count + this.actionStop_EventType_today.unsolved_count) + '/' +parseInt(this.actionStop_EventType_today.total_count + this.imCall_EventType_today.total_count) + '\n\n';
					this.imCall_EventType_msg += '>누적:미해결 ' + parseInt(this.imCall_EventType_total.unsolved_count + this.actionStop_EventType_total.unsolved_count) + '/' + parseInt(this.actionStop_EventType_total.total_count + this.imCall_EventType_total.total_count);

					if(this.imCall_EventType_today.unsolved_count > 0) {
						this.h_imCall_use = true;
					}
					if(this.imCall_EventType_total.unsolved_count > 0) {
						this.h_imCall_use = true;
					}

				}
			}
		}

		if(this.gas_EventType_today.condition_type == 'CDTP0000' || this.gas_EventType_total.condition_type == 'CDTP0000') {
			if(parseInt(this.gas_EventType_today.unsolved_count) == 0 &&
				parseInt(this.gas_EventType_today.total_count) == 0 &&
				parseInt(this.gas_EventType_total.unsolved_count) == 0 &&
				parseInt(this.gas_EventType_total.total_count) == 0) {
				this.gas_EventType_msg = null;
			}
			else {
				if(this.gas_EventType_today.unsolved_count == 0 &&
					this.gas_EventType_total.unsolved_count == 0) {
					this.gas_EventType_msg = null;
				}
				else {
					this.gas_EventType_msg = '[센서안전기준]' + this.cell.cell_name + '\n\n';
					this.gas_EventType_msg += '>일일:미해결 ' + parseInt(this.gas_EventType_today.unsolved_count) + '/' + parseInt(this.gas_EventType_today.total_count) + '\n\n';
					this.gas_EventType_msg += '>누적:미해결 ' + parseInt(this.gas_EventType_total.unsolved_count) + '/' + parseInt(this.gas_EventType_total.total_count);

					if(this.gas_EventType_today.unsolved_count > 0) {
						this.h_actionstop_use = true;
					}
					if(this.gas_EventType_total.unsolved_count > 0) {
						this.h_actionstop_use = true;
					}
				}
			}
		}
		
//		this.sb_msg = '안전' + this.count_gas_01 + '건/위험' + this.count_gas_04 + '건\n\n';
//		this.sb_msg += '주의' + this.count_gas_03 + '건/점검' + this.count_gas_02 + '건';

		if(this.count_gas_04 > 0) {
			this.gas_safe_status = '04';
		}
		else if(this.count_gas_03 > 0) {
			this.gas_safe_status = '03';
		}
		else if(this.count_gas_02 > 0) {
			this.gas_safe_status = '02';
		}
		else if(this.count_gas_01 > 0) {
			this.gas_safe_status = '01';
		}else{
			this.gas_safe_status = '';
			this.sb_msg = null;
		}
		
//		if(this.count_gas_01 ==0 && this.count_gas_02 == 0 &&
//			this.count_gas_03 == 0 &&
//			this.count_gas_04 == 0) {
//			this.gas_msg = null;
//		}
//		else {
//			this.gas_msg = '안전' + this.count_gas_01 + '건/위험' + this.count_gas_04 + '건\n\n';
//			this.gas_msg += '주의' + this.count_gas_03 + '건/점검' + this.count_gas_02 + '건';
//
//
//			if(this.count_gas_03 > 0 || this.count_gas_04 > 0) {
//				this.gas_safe_status_check = false;
//			}
//			else if(this.count_gas_03 == 0 && this.count_gas_04 == 0 && this.count_gas_02 > 0) {
//				this.gas_safe_status_check = true;
//			}
//
//		}
//		
//		this.sb_msg = this.gas_msg;


		if(this.count_gas_04 > 0) {
			this.gas_safe_status = '04';
		}
		else if(this.count_gas_03 > 0) {
			this.gas_safe_status = '03';
		}
		else if(this.count_gas_02 > 0) {
			this.gas_safe_status = '02';
		}else{
			this.gas_safe_status = '01';
		}
	}
	
	// gas
	this.gas;
	this.count_gas_01 = 0; // 안전
	this.count_gas_02 = 0; // 점검
	this.count_gas_03 = 0; // 주의
	this.count_gas_04 = 0; // 위험

	this.gas_msg;


	this.violation_EventType_msg;
	this.imCall_EventType_msg;
	this.actionStop_EventType_msg;
	this.gas_EventType_msg;
	this.sb_msg;

	// ----------------------------------
	// today
	// ----------------------------------

	// 침법
	this.violation_EventType_today = new EventType_Node('CDTP0100');

	// 긴급 호출
	this.imCall_EventType_today = new EventType_Node('CDTP0201');

	// 동작 멈춤 - > 작업자 정지 ( sk 버전 동작멈춤 = CDTP0000 하동, 삼성 작업자정지 = CDTP0411)
	this.actionStop_EventType_today = new EventType_Node('CDTP0411');
	
	// 가스센서 이밴트
	this.gas_EventType_today = new EventType_Node('CDTP0000');

	// ----------------------------------
	// total
	// ----------------------------------
	// 침법
	this.violation_EventType_total = new EventType_Node('CDTP0100');

	// 긴급 호출
	this.imCall_EventType_total = new EventType_Node('CDTP0201');

	// 동작 멈춤
	this.actionStop_EventType_total = new EventType_Node('CDTP0411');
	
	// 가스센서 이밴트
	this.gas_EventType_total = new EventType_Node('CDTP0000');
}

function Zone_Node() {
	this.cells = new Array; // node
	this.zone = null;

	this.arrAirTag_Node = new Array;

	// 리스트
	this.array_poi_worker = new Array;
	this.array_poi_cctv = new Array;
	this.array_poi_gas = new Array;

	// 뎁스 1에서 위험 경고 현황
	this.arr_cell_violation = new Array;
	this.arr_cell_imCall = new Array;
	this.arr_cell_actionstop = new Array;
	this.arr_cell_gas = new Array;
	this.arr_cell_EventType = new Array;

	// 2017_12_25_추가
	this.focus_control = false;

	this.filter_array_poi = function(arr, poi_id) {
		var bFind = false;
		for(var i = 0; i < arr.length; i++) {
			if(arr[i] == poi_id) {
				bFind = true;
			}
		}
		if(!bFind) {
			arr.push(poi_id);
		}
	}
	this.push_poi_worker = function(poi_id) {
		this.filter_array_poi(this.array_poi_worker, poi_id);
	}

	this.push_poi_cctv = function(poi_id) {
		this.filter_array_poi(this.array_poi_cctv, poi_id);
	}

	this.push_poi_gas = function(poi_id) {
		this.filter_array_poi(this.array_poi_gas, poi_id);
	}

	this.update = function() {
		// update
		for(var i = 0; i < this.cells.length; i++) {
			var node = this.cells[i];
			node.update();

			this.count_worker += node.count_worker;
			this.count_safe_worker += node.count_safe_worker;
			this.count_cctv += node.count_cctv;

			this.count_gas_01 += node.count_gas_01;
			this.count_gas_02 += node.count_gas_02;
			this.count_gas_03 += node.count_gas_03;
			this.count_gas_04 += node.count_gas_04;

			if(parseInt(node.count_gas_01) == 0 &&
				parseInt(node.count_gas_02) == 0 &&
				parseInt(node.count_gas_03) == 0 &&
				parseInt(node.count_gas_04) == 0) {}
			else {
				this.arr_cell_gas.push(node);
			}

			// 일일
			if(this.violation_EventType_today.condition_type == node.violation_EventType_today.condition_type) {
				this.violation_EventType_today.total_count += node.violation_EventType_today.total_count;
				this.violation_EventType_today.unsolved_count += node.violation_EventType_today.unsolved_count;

				if(parseInt(node.violation_EventType_today.unsolved_count) > 0) {
					this.arr_cell_violation.push(node);
				}
			}

			if(this.imCall_EventType_today.condition_type == node.imCall_EventType_today.condition_type) {
				this.imCall_EventType_today.total_count += node.imCall_EventType_today.total_count;
				this.imCall_EventType_today.unsolved_count += node.imCall_EventType_today.unsolved_count;

				if(parseInt(node.imCall_EventType_today.unsolved_count) > 0) {
					this.arr_cell_imCall.push(node);
				}
			}

			if(this.actionStop_EventType_today.condition_type == node.actionStop_EventType_today.condition_type) {
				this.actionStop_EventType_today.total_count += node.actionStop_EventType_today.total_count;
				this.actionStop_EventType_today.unsolved_count += node.actionStop_EventType_today.unsolved_count;

				if(parseInt(node.actionStop_EventType_today.unsolved_count) > 0) {
					this.arr_cell_actionstop.push(node);
				}
			}
			
			if(this.gas_EventType_today.condition_type == node.gas_EventType_today.condition_type) {
				this.gas_EventType_today.total_count += node.gas_EventType_today.total_count;
				this.gas_EventType_today.unsolved_count += node.gas_EventType_today.unsolved_count;

				if(parseInt(node.gas_EventType_today.unsolved_count) > 0) {
					this.arr_cell_EventType.push(node);
				}

			}

			// 누적
			if(this.violation_EventType_total.condition_type == node.violation_EventType_total.condition_type) {
				this.violation_EventType_total.total_count += node.violation_EventType_total.total_count;
				this.violation_EventType_total.unsolved_count += node.violation_EventType_total.unsolved_count;

				if(parseInt(node.violation_EventType_total.unsolved_count) > 0) {
					this.arr_cell_violation.push(node);
				}

			}

			if(this.imCall_EventType_total.condition_type == node.imCall_EventType_total.condition_type) {
				this.imCall_EventType_total.total_count += node.imCall_EventType_total.total_count;
				this.imCall_EventType_total.unsolved_count += node.imCall_EventType_total.unsolved_count;

				if(parseInt(node.imCall_EventType_total.unsolved_count) > 0) {
					this.arr_cell_imCall.push(node);
				}

			}

			if(this.actionStop_EventType_total.condition_type == node.actionStop_EventType_total.condition_type) {
				this.actionStop_EventType_total.total_count += node.actionStop_EventType_total.total_count;
				this.actionStop_EventType_total.unsolved_count += node.actionStop_EventType_total.unsolved_count;

				if(parseInt(node.actionStop_EventType_total.unsolved_count) > 0) {
					this.arr_cell_actionstop.push(node);
				}

			}
			
			if(this.gas_EventType_total.condition_type == node.gas_EventType_total.condition_type) {
				this.gas_EventType_total.total_count += node.gas_EventType_total.total_count;
				this.gas_EventType_total.unsolved_count += node.gas_EventType_total.unsolved_count;

				if(parseInt(node.gas_EventType_total.unsolved_count) > 0) {
					this.arr_cell_EventType.push(node);
				}

			}
		}
	}

	// worker
	this.count_worker = 0;
	this.count_safe_worker = 0;

	// cctv
	this.count_cctv = 0;

	// gas
	this.gas;
	this.count_gas_01 = 0; // 안전
	this.count_gas_02 = 0; // 점검
	this.count_gas_03 = 0; // 주의
	this.count_gas_04 = 0; // 위험

	// ----------------------------------
	// today
	// ----------------------------------
	this.violation_EventType_msg;
	this.imCall_EventType_msg;
	this.actionStop_EventType;
	this.gas_EventType_msg;

	// ----------------------------------
	// today
	// ----------------------------------

	// 침법
	this.violation_EventType_today = new EventType_Node('CDTP0100');

	// 긴급 호출
	this.imCall_EventType_today = new EventType_Node('CDTP0201');

	// 동작 멈춤 - > 작업자 정지 ( sk 버전 동작멈춤 = CDTP0000 하동, 삼성 작업자정지 = CDTP0411)
	this.actionStop_EventType_today = new EventType_Node('CDTP0411');
	
	// 가스센서 이밴트
	this.gas_EventType_today = new EventType_Node('CDTP0000');

	// ----------------------------------
	// total
	// ----------------------------------
	// 침법
	this.violation_EventType_total = new EventType_Node('CDTP0100');

	// 긴급 호출
	this.imCall_EventType_total = new EventType_Node('CDTP0201');

	// 동작 멈춤
	this.actionStop_EventType_total = new EventType_Node('CDTP0411');
	
	// 가스센서 이밴트
	this.gas_EventType_total = new EventType_Node('CDTP0000');
}


function Building_Node() {
	this.zones = new Array; // node
	this.building = null;
	this.poi = null;
	this.color;

	this.arrAirTag_Node = new Array;

	// 중점관리 여부
	this.watch_area_yn = false;

	// 뎁스 1에서 위험 경고 현황
	this.arr_zone_violation = new Array;
	this.arr_zone_imCall = new Array;
	this.arr_zone_actionstop = new Array;
	this.arr_zone_gas = new Array;
	this.arr_zone_EventType = new Array;


	this.gas_safe_status_check = false; // 점검
	
	this.gas_safe_status = '01'; // 안전

	// 리스트
	this.array_poi_worker = new Array;
	this.array_poi_cctv = new Array;
	this.array_poi_gas = new Array;
	
	this.array_sb_msg = new Array;

	this.filter_array_poi = function(arr, poi_id) {
		var bFind = false;
		for(var i = 0; i < arr.length; i++) {
			if(arr[i] == poi_id) {
				bFind = true;
			}
		}
		if(!bFind) {
			arr.push(poi_id);
		}
	}
	this.push_poi_worker = function(poi_id) {
		this.filter_array_poi(this.array_poi_worker, poi_id);
	}

	this.push_poi_cctv = function(poi_id) {
		this.filter_array_poi(this.array_poi_cctv, poi_id);
	}

	this.push_poi_gas = function(poi_id) {
		this.filter_array_poi(this.array_poi_gas, poi_id);
	}

	this.update = function() {
		// update
		for(var i = 0; i < this.zones.length; i++) {
			var node = this.zones[i];
			node.update();

			this.count_worker += node.count_worker;
			this.count_safe_worker += node.count_safe_worker;
			this.count_cctv += node.count_cctv;

			this.count_gas_01 += node.count_gas_01;
			this.count_gas_02 += node.count_gas_02;
			this.count_gas_03 += node.count_gas_03;
			this.count_gas_04 += node.count_gas_04;

			if(parseInt(node.count_gas_01) == 0 &&
				parseInt(node.count_gas_02) == 0 &&
				parseInt(node.count_gas_03) == 0 &&
				parseInt(node.count_gas_04) == 0) {}
			else {
				this.arr_zone_gas.push(node);
			}

			if(this.violation_EventType_today.condition_type == node.violation_EventType_today.condition_type) {
				this.violation_EventType_today.total_count += node.violation_EventType_today.total_count;
				this.violation_EventType_today.unsolved_count += node.violation_EventType_today.unsolved_count;

				if(parseInt(node.violation_EventType_today.unsolved_count) > 0) {
					this.arr_zone_violation.push(node);
				}
			}

			if(this.imCall_EventType_today.condition_type == node.imCall_EventType_today.condition_type) {
				this.imCall_EventType_today.total_count += node.imCall_EventType_today.total_count;
				this.imCall_EventType_today.unsolved_count += node.imCall_EventType_today.unsolved_count;

				if(parseInt(node.imCall_EventType_today.unsolved_count) > 0) {
					this.arr_zone_imCall.push(node);
				}
			}

			if(this.actionStop_EventType_today.condition_type == node.actionStop_EventType_today.condition_type) {
				this.actionStop_EventType_today.total_count += node.actionStop_EventType_today.total_count;
				this.actionStop_EventType_today.unsolved_count += node.actionStop_EventType_today.unsolved_count;

				if(parseInt(node.actionStop_EventType_today.unsolved_count) > 0) {
					this.arr_zone_actionstop.push(node);
				}
			}
			
			if(this.gas_EventType_today.condition_type == node.gas_EventType_today.condition_type) {
				this.gas_EventType_today.total_count += node.gas_EventType_today.total_count;
				this.gas_EventType_today.unsolved_count += node.gas_EventType_today.unsolved_count;

				if(parseInt(node.gas_EventType_today.unsolved_count) > 0) {
					this.arr_zone_EventType.push(node);
				}
			}

			if(this.violation_EventType_total.condition_type == node.violation_EventType_total.condition_type) {
				this.violation_EventType_total.total_count += node.violation_EventType_total.total_count;
				this.violation_EventType_total.unsolved_count += node.violation_EventType_total.unsolved_count;

				if(parseInt(node.violation_EventType_total.unsolved_count) > 0) {
					this.arr_zone_violation.push(node);
				}
			}

			if(this.imCall_EventType_total.condition_type == node.imCall_EventType_total.condition_type) {
				this.imCall_EventType_total.total_count += node.imCall_EventType_total.total_count;
				this.imCall_EventType_total.unsolved_count += node.imCall_EventType_total.unsolved_count;

				if(parseInt(node.imCall_EventType_total.unsolved_count) > 0) {
					this.arr_zone_imCall.push(node);
				}
			}

			if(this.actionStop_EventType_total.condition_type == node.actionStop_EventType_total.condition_type) {
				this.actionStop_EventType_total.total_count += node.actionStop_EventType_total.total_count;
				this.actionStop_EventType_total.unsolved_count += node.actionStop_EventType_total.unsolved_count;

				if(parseInt(node.actionStop_EventType_total.unsolved_count) > 0) {
					this.arr_zone_actionstop.push(node);
				}
			}
			
			if(this.gas_EventType_total.condition_type == node.gas_EventType_total.condition_type) {
				this.gas_EventType_total.total_count += node.gas_EventType_total.total_count;
				this.gas_EventType_total.unsolved_count += node.gas_EventType_total.unsolved_count;

				if(parseInt(node.gas_EventType_total.unsolved_count) > 0) {
					this.arr_zone_EventType.push(node);
				}
			}
		}

		if(this.violation_EventType_today.condition_type == 'CDTP0100' || this.violation_EventType_total.condition_type == 'CDTP0100') {

			if(parseInt(this.violation_EventType_today.unsolved_count) == 0 &&
				parseInt(this.violation_EventType_today.total_count) == 0 &&
				parseInt(this.violation_EventType_total.unsolved_count) == 0 &&
				parseInt(this.violation_EventType_total.total_count) == 0) {
				this.violation_EventType_msg = null;
			}
			else {
				// 2017_12_25 수정
				if(this.violation_EventType_today.unsolved_count == 0 &&
					this.violation_EventType_total.unsolved_count == 0) {
					this.violation_EventType_msg = null;
				}
				else {
					this.violation_EventType_msg = '[제한구역침범]' + this.building.building_name + '\n\n';
					this.violation_EventType_msg += '>일일:미해결 ' + parseInt(this.violation_EventType_today.unsolved_count) + '/' + parseInt(this.violation_EventType_today.total_count) + '\n\n';
					this.violation_EventType_msg += '>누적:미해결 ' + parseInt(this.violation_EventType_total.unsolved_count) + '/' + parseInt(this.violation_EventType_total.total_count);

				}

			}
		}

		if(this.imCall_EventType_today.condition_type == 'CDTP0201' || this.imCall_EventType_total.condition_type == 'CDTP0201' || 
		   this.actionStop_EventType_today.condition_type == 'CDTP0411' || this.actionStop_EventType_total.condition_type == 'CDTP0411') {	
			
			if(parseInt(this.imCall_EventType_today.unsolved_count) == 0 &&
				parseInt(this.imCall_EventType_today.total_count) == 0 &&
				parseInt(this.imCall_EventType_total.unsolved_count) == 0 &&
				parseInt(this.imCall_EventType_total.total_count) == 0 && 
				parseInt(this.actionStop_EventType_today.unsolved_count) == 0 &&
				parseInt(this.actionStop_EventType_today.total_count) == 0 &&
				parseInt(this.actionStop_EventType_total.unsolved_count) == 0 &&
				parseInt(this.actionStop_EventType_total.total_count) == 0) {
				this.imCall_EventType_msg = null;
			}
			else {
				// 2017_12_25 수정
				// 미해결 건수만
				if(this.imCall_EventType_today.unsolved_count == 0 &&
					this.imCall_EventType_total.unsolved_count == 0 && 
					this.actionStop_EventType_today.unsolved_count == 0 &&
					this.actionStop_EventType_total.unsolved_count == 0 ) {
					this.imCall_EventType_msg = null;
				}
				else {
					this.imCall_EventType_msg = '[긴급호출/정지]' + this.building.building_name + '\n\n';
					this.imCall_EventType_msg += '>일일:미해결 ' + parseInt(this.imCall_EventType_today.unsolved_count + this.actionStop_EventType_today.unsolved_count) + '/' + parseInt(this.imCall_EventType_today.total_count + this.actionStop_EventType_today.total_count) + '\n\n';
					this.imCall_EventType_msg += '>누적:미해결 ' + parseInt(this.imCall_EventType_total.unsolved_count + this.actionStop_EventType_total.unsolved_count) + '/' + parseInt(this.imCall_EventType_total.total_count + this.actionStop_EventType_total.total_count);
				}
			}
		}

//		console.log('this.gas_EventType_today.condition_type : '+this.gas_EventType_today.condition_type);
//		console.log('this.gas_EventType_today.total_count : '+this.gas_EventType_today.total_count);
//		console.log('this.gas_EventType_total.total_count : '+this.gas_EventType_total.total_count);
		if(this.gas_EventType_today.condition_type == 'CDTP0000' || this.gas_EventType_total.condition_type == 'CDTP0000') {
			if(parseInt(this.gas_EventType_today.unsolved_count) == 0 &&
				parseInt(this.gas_EventType_today.total_count) == 0 &&
				parseInt(this.gas_EventType_total.unsolved_count) == 0 &&
				parseInt(this.gas_EventType_total.total_count) == 0) {
				this.gas_EventType_msg = null;
			}
			else {
				if(this.gas_EventType_today.unsolved_count == 0 &&
					this.gas_EventType_total.unsolved_count == 0) {
					this.gas_EventType_msg = null;
				}
				else {
					this.gas_EventType_msg = '[센서안전기준]' + this.building.building_name + '\n\n';
					this.gas_EventType_msg += '>일일:미해결 ' + parseInt(this.gas_EventType_today.unsolved_count) + '/' + parseInt(this.gas_EventType_today.total_count) + '\n\n';
					this.gas_EventType_msg += '>누적:미해결 ' + parseInt(this.gas_EventType_total.unsolved_count) + '/' + parseInt(this.gas_EventType_total.total_count);

				}
			}
		}

		// 2017_12_27 수정
		// -------------------------------------------------------------------
		// if(this.count_gas_01 == 0 &&
		// this.count_gas_02 == 0 &&
		// this.count_gas_03 == 0 &&
		// this.count_gas_04 == 0) {
		// this.gas_msg = null;
		// }
		// else {
		// this.gas_msg = '안전' + this.count_gas_01 + '건/위험' +
		// this.count_gas_04 + '건\n\n';
		// this.gas_msg += '주의' + this.count_gas_03 + '건/점검' +
		// this.count_gas_02 + '건';


		// }
		// -------------------------------------------------------------------

		if(this.count_gas_02 == 0 &&
			this.count_gas_03 == 0 &&
			this.count_gas_04 == 0) {
			this.gas_msg = null;
		}
		else {
			this.gas_msg = '안전' + this.count_gas_01 + '건/위험' + this.count_gas_04 + '건\n\n';
			this.gas_msg += '주의' + this.count_gas_03 + '건/점검' + this.count_gas_02 + '건';


			if(this.count_gas_03 > 0 || this.count_gas_04 > 0) {
				this.gas_safe_status_check = false;
			}
			else if(this.count_gas_03 == 0 && this.count_gas_04 == 0 && this.count_gas_02 > 0) {
				this.gas_safe_status_check = true;
			}

		}
		
		this.sb_msg = '안전' + this.count_gas_01 + '건/위험' + this.count_gas_04 + '건\n\n';
		this.sb_msg += '주의' + this.count_gas_03 + '건/점검' + this.count_gas_02 + '건';


		if(this.count_gas_04 > 0) {
			this.gas_safe_status = '04';
		}
		else if(this.count_gas_03 > 0) {
			this.gas_safe_status = '03';
		}
		else if(this.count_gas_02 > 0) {
			this.gas_safe_status = '02';
		}
		else if(this.count_gas_01 > 0) {
			this.gas_safe_status = '01';
		}else{
			this.gas_safe_status = '';
			this.sb_msg = null;
		}
	}

	// work
	this.count_worker = 0;
	this.count_safe_worker = 0;

	// cctv
	this.count_cctv = 0;

	// gas
	this.gas;
	this.count_gas_01 = 0; // 안전
	this.count_gas_02 = 0; // 점검
	this.count_gas_03 = 0; // 주의
	this.count_gas_04 = 0; // 위험

	this.gas_msg;

	// ----------------------------------
	// today
	// ----------------------------------
	this.violation_EventType_msg;
	this.imCall_EventType_msg;
	this.actionStop_EventType;
	this.gas_EventType_msg;

	// ----------------------------------
	// today
	// ----------------------------------

	// 침법
	this.violation_EventType_today = new EventType_Node('CDTP0100');

	// 긴급 호출
	this.imCall_EventType_today = new EventType_Node('CDTP0201');

	// 동작 멈춤 - > 작업자 정지 ( sk 버전 동작멈춤 = CDTP0000 하동, 삼성 작업자정지 = CDTP0411)
	this.actionStop_EventType_today = new EventType_Node('CDTP0411');
	
	// 가스센서 이밴트
	this.gas_EventType_today = new EventType_Node('CDTP0000');

	// ----------------------------------
	// total
	// ----------------------------------
	// 침법
	this.violation_EventType_total = new EventType_Node('CDTP0100');

	// 긴급 호출
	this.imCall_EventType_total = new EventType_Node('CDTP0201');

	// 동작 멈춤
	this.actionStop_EventType_total = new EventType_Node('CDTP0411');
	
	// 가스센서 이밴트
	this.gas_EventType_total = new EventType_Node('CDTP0000');
}

function CreateArrBuilding_Node() {
	if(s_arrBuilding_Node != null) {
		s_arrBuilding_Node.length = 0;
	}
	s_arrBuilding_Node = new ArrayList();
	return s_arrBuilding_Node;
}

function ClearArrBuilding_Node() {
	if(s_arrBuilding_Node != null) {
		s_arrBuilding_Node.length = 0;
	}
}


function GetArrBuilding_Node() {
	return s_arrBuilding_Node;
}


// 현재 빌딩 -> 존으로 이동
function GetBuilding_Node(poi_id) {
	// 주어진 poi id로 building poi_id

	if(s_arrBuilding_Node == null) return null;

	for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
		var build_node = s_arrBuilding_Node.get(i);
		if(build_node.poi.poiId == poi_id) {
			return build_node;
		}
	}
	return null;
}


function GetBuildingHandle_Node(building_id) {
	// 주어진 poi id로 building poi_id

	if(s_arrBuilding_Node == null) return null;

	for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
		var build_node = s_arrBuilding_Node.get(i);
		if(build_node.building.building_id == building_id) {
			return build_node;
		}
	}
	return null;
}

// function GetBuildingFormID_Node(poi_id) {
// if(s_arrBuilding_Node == null) return null;

// for (var i = 0; i < s_arrBuilding_Node.size() ; i++) {
// var build_node = s_arrBuilding_Node.get(i);
// if(build_node.poi.poiId == poi_id) {
// return build_node;
// }
// }
// return null;
// }

function GetZoneNode_Name(building_node, zone_name) {

	if(!building_node) return null;

	for(var i = 0; i < building_node.zones.length; i++) {
		var zone_node = building_node.zones[i];
		if(zone_node.zone.zone_name == zone_name) {
			return zone_node;
		}
	}
	return null;
}

function GetZoneNode_ID(building_node, zone_id) {

	if(!building_node) {
		return null;
	}
	for(var i = 0; i < building_node.zones.length; i++) {
		var zone_node = building_node.zones[i];
		if(zone_node.zone.zone_id == zone_id) {
			return zone_node;
		}
	}
	return null;
}


function GetZoneNode_Index(building_node, zone_index) {

	if(!building_node) {
		return null;
	}
	if(building_node.zones.length > zone_index) {
		return building_node.zones[zone_index];
	}
	return null;
}

// 2017_12_25 추가
function GetZoneNode_Watch(building_node) {
	if(!building_node) {
		return null;
	}
	for(var i = 0; i < building_node.zones.length; ++i) {

		if(building_node.zones[i].watch_area_yn == true) {
			return building_node.zones[i];
		}
	}
	return null;
}

function GetSceneID_FromZoneID(zone_id) {
	if(s_arrBuilding_Node == null) return null;

	for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
		var build_node = s_arrBuilding_Node.get(i);
		for(var j = 0; j < build_node.zones.length; j++) {
			var zone_node = build_node.zones[j];

			if(zone_node.zone.zone_id == zone_id) {
				return zone_node.zone.scene_id;
			}
		}
	}
	return null;
}

function GetZoneNode_FromZoneID(zone_id) {
	if(s_arrBuilding_Node == null) return null;

	for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
		var build_node = s_arrBuilding_Node.get(i);
		for(var j = 0; j < build_node.zones.length; j++) {
			var zone_node = build_node.zones[j];

			if(zone_node.zone.zone_id == zone_id) {
				return zone_node;
			}
		}
	}
	return null;
}



function GetCellNode_BuildingNode(building_node, cell_id) {

	if(!building_node) {
		return null;
	}
	for(var i = 0; i < building_node.zones.length; i++) {
		var zone_node = building_node.zones[i];

		var cell_node = GetCellNode_ZoneNode(zone_node, cell_id);
		if(cell_node) {
			return cell_node;
		}
	}
	return null;
}

function GetCellNode_ZoneNode(zone_node, cell_id) {

	if(!zone_node) {
		return null;
	}
	for(var i = 0; i < zone_node.cells.length; i++) {
		var cell_node = zone_node.cells[i];
		if(cell_node.cell.cell_id == cell_id) {
			return cell_node;
		}
	}
	return null;
}

function AirTag_Node() {
	this.poi_id;
	this.param_0;
	this.param_1;
	this.type;
	this.bShow;
	this.hAirTag;
}

function Filter_AirtagNode(AirTag_NodeList, filter_type, poi_id, param_0, param_1, bmarker, background) {

	var find_node = null;
	

	for(var j = 0; j < AirTag_NodeList.length; j++) {
		var node = AirTag_NodeList[j];
		if(node.type != filter_type) {
			continue;
		}
		if(node.poi_id == poi_id) {// && node.param_1 == param_1
			
			if(node.param_0 != param_0) {
				// 내용만 변경 된 경우
				node.param_0 = param_0;

				if(node.hAirTag) {

					if(bmarker) {
						var count = parseInt(param_0);
						if(count >= 1000) {
							node.hAirTag.setTextLeftMargin(40);
						}
						else if(count >= 100) {
							node.hAirTag.setTextLeftMargin(46);
						}
						else if(count >= 10) {
							node.hAirTag.setTextLeftMargin(52);
						}
						else {
							node.hAirTag.setTextLeftMargin(58);
						}
					}
					node.hAirTag.setTextEx(param_0);
				}

				// setAirTagVisible(node.airTagId, param_0);
			}
			if(node.param_1 != param_1) {
				// 색이 변경 된 경우
				console.log('!!!!----- node.param_1 : '+node.param_1);
				console.log('!!!!----- 색 변경 param_1 : '+param_1);
				node.param_1 = param_1;
				if(background){
					node.hAirTag.setBackgroundEx(background);
				}
				
			}

			find_node = node;
			break;
		}
	}

	return find_node;
}

function Update_Scene() {

	// console.log('Update_Scene');
	if(!IsLoadScene()) {
		return;
	}

	if(s_AirTag_NodeList == null) {
		s_AirTag_NodeList = new Array();
	}

	switch(s_current_layer_state) {
		case LAYER_STATE.BUILDING:
			Update_Building();
			break;
		case LAYER_STATE.ZONE:
			if(s_arrBuilding_Node != null) {
				var find_node = null;
				for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
					var build_node = s_arrBuilding_Node.get(i);
					find_node = GetZoneNode_ID(build_node, s_CurSelZoneID);
					if(find_node) {
						break;
					}
				}
				if(find_node) {
					s_ZoneNode = find_node;
					Update_Zone(find_node);
				}
			}
			break;
		case LAYER_STATE.CELL:
			Update_Cell(s_CellNode);
			break;
	}

	LateUpdate_Node_AirTag();
}

// -------------------------------------------------------
//
// update building
//
// -------------------------------------------------------
function setBuilding_Node(arrBuilding_Node) {
	s_arrBuilding_Node = arrBuilding_Node;

	if(!s_bFirstBuildNode_client) {

		loadingView(0, 'networkmgr_init');

		// 대쉬보드 처음 한번만 들어오는 부분
		var checkSession_alram = sessionStorage.getItem('alramPopup_another_page');
		if(isdefined(checkSession_alram)) {
			s_current_layer_state = LAYER_STATE.ZONE;
			checkSession_alram = JSON.parse(checkSession_alram);
			Send_ToBridge_InMapViewer('FORCE_WARNING_TAB_ALRAM_CALLBACK', checkSession_alram);
			sessionStorage.setItem('alramPopup_another_page', '');
		}

		s_bFirstBuildNode_client = true;
	}

	if(g_loadingView_req_event_state) {
		g_loadingView_req_event_state = false;
		loadingView(0, 'req_event_state');
	}
}

function Update_Building() {
	if(s_arrBuilding_Node == null) {
		return;
	}

	if(s_tab_state == TAB_STATE.EMERGENCY) {
		s_AirTagHelper.clear();
	}
	
	var info = g_TableInfo.Safe_Emergency_Info;
	var building_list = [];
	if(nvl(info) != '' && nvl(info.emergency_id) != '') {
		building_list = info.building_total_list;
	}
	
	for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
		var build_node = s_arrBuilding_Node.get(i);
		if(s_tab_state == TAB_STATE.FOCUS_CONTROL) {
			if(build_node.watch_area_yn) {
				Update_Node_AirTag(build_node);
			}
		}
		else if(s_tab_state == TAB_STATE.EMERGENCY) {
			for(var j = 0; j < building_list.length; j++) {
				if(build_node.building.building_id == building_list[j].building_id) {
					var zone_list = building_list[j].zone_total_list;
					var area = '';

					// 층 정보
//					for(var k = 0; k < zone_list.length; k++) {
//						if(k != 0) {
//							area += ','
//						}
//						area += zone_list[k].zone_name;
//					}
					// 셀 정보
					for(var k = 0; k < zone_list.length; k++) {
						var cell_list = zone_list[k].cell_total_list;
						area = cell_list.length;
//						for(var l = 0; l < cell_list.length; l++) {
//							var cell = cell_list[l];
//							if(l != 0) {
//								area += ','
//							}
//							area += cell.cell_name;
//						}
					}
					// 구역정보 표시 -- 주석
//					var text = building_list[j].building_name + '/'+area;
					var text = building_list[j].building_name + ' / '+area+' 구역';
					text += '\n\n미대피자 : '+building_list[j].victim_count;
					build_node.emergency = {
							text: text
					};
					Update_Node_AirTag(build_node);
				}
			}
		}
		else {
			Update_Node_AirTag(build_node);
		}
	}
}

// -------------------------------------------------------
// update zone
// cell 보여준다.	
// -------------------------------------------------------
function Update_Zone(zone_node) {
	if(zone_node == null) {
		return;
	}

	var info = g_TableInfo.Safe_Emergency_Info;
	var cell_list = [];
	if(nvl(info) != '' && nvl(info.emergency_id) != '') {
		var building_list = info.building_total_list;
		for(var a = 0; a < building_list.length; a++) {
			var zone_list = building_list[a].zone_total_list;
			for(var b = 0; b < zone_list.length; b++) {
				if(s_CurSelZoneID == zone_list[b].zone_id) {
					cell_list = zone_list[b].cell_total_list;
					break;
				}
			}
		}
	}
	for(var i = 0; i < zone_node.cells.length; i++) {
		var cell_node = zone_node.cells[i];

		if(s_tab_state == TAB_STATE.FOCUS_CONTROL) {
			if(cell_node.watch_area_yn) {
				Update_Node_AirTag(cell_node);
			}
		}
		else if(s_tab_state == TAB_STATE.EMERGENCY) {
			for(var j = 0; j < cell_list.length; j++) {
				if(cell_node.cell.cell_id == cell_list[j].cell_id) {
					Update_Node_AirTag(cell_node, true);
				}
			}
		}
		else {
			Update_Node_AirTag(cell_node, true);
		}
	}
}

// -------------------------------------------------------
//
// update cell
//
// -------------------------------------------------------
function Update_Cell(cell_node) {
	if(cell_node == null) {
		return;
	}
	Update_Node_AirTag(cell_node, true);
}

function Hide_AirTags() {
	var msg_hide_airtag = '';

	if(s_AirTag_NodeList) {
		for(var i = 0; i < s_AirTag_NodeList.length; i++) {
			var airnode = s_AirTag_NodeList[i];

			msg_hide_airtag += airnode.airTagId;
			if(i == s_AirTag_NodeList.length - 1) {}
			else {
				msg_hide_airtag += ',';
			}
		}
	}
	setAirTagVisible(msg_hide_airtag, 'false');
}

function UpdateShow_AirTag() {

	var arrShow_AirTag = new Array();
	var arrHide_AirTag = new Array();

	for(var i = 0; i < s_AirTag_NodeList.length; i++) {
		var airnode = s_AirTag_NodeList[i];

		var bShow;
		switch(airnode.type) {
			case 'worker':
				bShow = s_bShow_worker;
				break;
			case 'safe_worker':
				bShow = s_bShow_safe_worker;
				break;
			case 'sensor':
				bShow = s_bShow_sensor;
				break;
			case 'cctv':
				bShow = s_bShow_cctv;
				break;
			case 'violation_EventType':
				bShow = s_bShow_violation_EventType;
				break;
			case 'imCall_EventType':
				bShow = s_bShow_imCall_EventType;
				break;
			case 'actionStop_EventType':
				bShow = s_bShow_actionStop_EventType;
				break;
			case 'gas':
				bShow = s_bShow_gas;
				break;
		}
		if(airnode.bShow == bShow) {
			continue;
		}
		airnode.bShow = bShow;
		if(bShow) {
			arrShow_AirTag.push(airnode.airTagId);
		}
		else {
			arrHide_AirTag.push(airnode.airTagId);
		}
	}

	// show
	if(arrShow_AirTag.length > 0) {
		var msg_show_airtag = '';
		for(var i = 0; i < arrShow_AirTag.length; i++) {
			msg_show_airtag += arrShow_AirTag[i];
			if(i == arrShow_AirTag.length - 1) {}
			else {
				msg_show_airtag += ',';
			}
		}
		setAirTagVisible(msg_show_airtag, 'true');
	}

	// hide
	if(arrHide_AirTag.length > 0) {

		var msg_hide_airtag = '';
		for(var i = 0; i < arrHide_AirTag.length; i++) {
			msg_hide_airtag += arrHide_AirTag[i];
			if(i == arrHide_AirTag.length - 1) {}
			else {
				msg_hide_airtag += ',';
			}
		}
		setAirTagVisible(msg_hide_airtag, 'false');
	}
}

function LateUpdate_Node_AirTag() {

	switch(s_current_layer_state) {
		case LAYER_STATE.BUILDING:
			rePosition_Node_AirTag_ArrayList(s_arrBuilding_Node);
			break;
		case LAYER_STATE.ZONE:
			rePosition_Node_AirTag_Array(s_ZoneNode);
			break;
		case LAYER_STATE.CELL:
			// 구현 처리해야함.
			rePosition_Node_AirTag(s_CellNode);
			break;
	}


	setTimeout(function() {
		UpdateShow_AirTag();
		Update_ObjectTransparency_Safe();
		Update_ObjectTransparency();
		Update_ObjectTransparency_Em();
	}, 30);

}

function rePosition_Node_AirTag_ArrayList(node) {
	if(node == null) {
		return;
	}
	for(var i = 0; i < node.size(); i++) {
		var _node = node.get(i);

		// poi_id 동일함.
		if(_node.arrAirTag_Node.length > 1) {
			for(var j = 0; j < _node.arrAirTag_Node.length; j++) {
				var airtag_node = _node.arrAirTag_Node[j];

				var position = AIRTAG_POSITION.LEFT_TOP;
				switch(j) {
					case 0:
						position = AIRTAG_POSITION.LEFT_TOP;
						break;
					case 1:
						position = AIRTAG_POSITION.RIGHT_BOTTOM;
						break;
					case 2:
						position = AIRTAG_POSITION.RIGHT_TOP;
						break;
					case 3:
						position = AIRTAG_POSITION.LEFT_BOTTOM;
						break;
					case 4:
						position = AIRTAG_POSITION.CENTER;
						break;
				}

				s_AirTagHelper.rePositionAirTag_3(airtag_node.airTagId, airtag_node.poi_id, position);
			}
		}
		else if(_node.arrAirTag_Node.length == 1) {
			var airtag_node = _node.arrAirTag_Node[0];
			s_AirTagHelper.rePositionAirTag_3(airtag_node.airTagId, airtag_node.poi_id, AIRTAG_POSITION.CENTER);
		}
	}
}

function rePosition_Node_AirTag_Array(node) {
	if(node == null) {
		return;
	}
	for(var i = 0; i < node.cells.length; i++) {
		var _node = node.cells[i];

		// poi_id 동일함.
		if(_node.arrAirTag_Node.length > 1) {
			for(var j = 0; j < _node.arrAirTag_Node.length; j++) {
				var airtag_node = _node.arrAirTag_Node[j];

				var position = AIRTAG_POSITION.LEFT_TOP;
				switch(j) {
					case 0:
						position = AIRTAG_POSITION.LEFT_TOP;
						break;
					case 1:
						position = AIRTAG_POSITION.RIGHT_BOTTOM;
						break;
					case 2:
						position = AIRTAG_POSITION.RIGHT_TOP;
						break;
					case 3:
						position = AIRTAG_POSITION.LEFT_BOTTOM;
						break;
					case 4:
						position = AIRTAG_POSITION.CENTER;
						break;
				}

				s_AirTagHelper.rePositionAirTag_3(airtag_node.airTagId, airtag_node.poi_id, position);
			}
		}
		else if(_node.arrAirTag_Node.length == 1) {
			var airtag_node = _node.arrAirTag_Node[0];
			s_AirTagHelper.rePositionAirTag_3(airtag_node.airTagId, airtag_node.poi_id, AIRTAG_POSITION.CENTER);
		}
	}
}

function rePosition_Node_AirTag(_node) {
	if(_node == null) {
		return;
	}
	if(_node.arrAirTag_Node.length > 1) {
		for(var j = 0; j < _node.arrAirTag_Node.length; j++) {
			var airtag_node = _node.arrAirTag_Node[j];

			var position = AIRTAG_POSITION.LEFT_TOP;
			switch(j) {
				case 0:
					position = AIRTAG_POSITION.LEFT_TOP;
					break;
				case 1:
					position = AIRTAG_POSITION.RIGHT_BOTTOM;
					break;
				case 2:
					position = AIRTAG_POSITION.RIGHT_TOP;
					break;
				case 3:
					position = AIRTAG_POSITION.LEFT_BOTTOM;
					break;
				case 4:
					position = AIRTAG_POSITION.CENTER;
					break;
			}

			s_AirTagHelper.rePositionAirTag_3(airtag_node.airTagId, airtag_node.poi_id, position);
		}
	}
	else if(_node.arrAirTag_Node.length == 1) {
		var airtag_node = _node.arrAirTag_Node[0];
		s_AirTagHelper.rePositionAirTag_3(airtag_node.airTagId, airtag_node.poi_id, AIRTAG_POSITION.CENTER);
	}
}

function Update_Node_AirTag(node, use_cell_color) {

	if(node.arrAirTag_Node != null) {
		node.arrAirTag_Node.length = 0;
	}

	if(s_AirTagHelper != null && s_AirTagHelper.getshow_myPosition()) {

	}
	else {
		// safe_worker
//		console.log('s_bShow_safe_worker : '+s_bShow_safe_worker);
		if(s_bShow_safe_worker) {
//			console.log('node.count_safe_worker : '+node.count_safe_worker);
//			console.log('node.poi : '+node.poi);
			if(node.count_safe_worker != 0 && s_tab_state != TAB_STATE.WARNING) {
				if(node.poi == null) {

				}
				else {
					var find_node = Filter_AirtagNode(s_AirTag_NodeList, 'safe_worker', node.poi.poiId, node.count_safe_worker, WORKER_COLOR.BLUE, true);
					if(!find_node) {
						var airnode = new AirTag_Node();
						airnode.poi_id = node.poi.poiId;
						airnode.param_0 = node.count_safe_worker;
						airnode.param_1 = WORKER_COLOR.BLUE;
						airnode.type = 'safe_worker';

						s_AirTag_NodeList.push(airnode);

						var airtag = s_AirTagHelper.showWorker(node.poi.poiId, node.count_safe_worker, WORKER_COLOR.BLUE, 'watch');

						airnode.airTagId = airtag.airTagId;
						airnode.bShow = false;
						airnode.hAirTag = airtag;
						find_node = airnode;
					}

					node.arrAirTag_Node.push(find_node);
				}
			}
			else {
				// 카운트가 0 일 경우 삭제 처리
				DelNode_AirTag('safe_worker', node);
			}
		}

		// worker
		if(s_bShow_worker) {

			if(node.count_worker != 0 && s_tab_state != TAB_STATE.WARNING) {

				if(node.poi == null) {

				}
				else {
					var find_node = Filter_AirtagNode(s_AirTag_NodeList, 'worker', node.poi.poiId, node.count_worker, WORKER_COLOR.GREEN, true);
					if(!find_node) {
						var airnode = new AirTag_Node();
						airnode.poi_id = node.poi.poiId;
						airnode.param_0 = node.count_worker;
						airnode.param_1 = WORKER_COLOR.GREEN;
						airnode.type = 'worker';

						s_AirTag_NodeList.push(airnode);

						var airtag = s_AirTagHelper.showWorker(node.poi.poiId, node.count_worker, WORKER_COLOR.GREEN, 'worker');

						airnode.airTagId = airtag.airTagId;
						airnode.bShow = false;
						airnode.hAirTag = airtag;
						find_node = airnode;
					}

					node.arrAirTag_Node.push(find_node);
				}
			}
			else {
				// 카운트가 0 일 경우 삭제 처리
				DelNode_AirTag('worker', node);
			}
		}
		
		// sensor
		if(s_bShow_sensor) {

			//console.log('!!! s_bShow_gas node.poi.poiId : '+node.poi.poiId);
			if(node.sb_msg != null && s_tab_state == TAB_STATE.AREA_SAFE) {
				if(node.poi == null) {

				}
				else {

					var _safe_state = SAFE_STATE.NORMAL;
					if(node.gas_safe_status == '04') {
						_safe_state = SAFE_STATE.ERROR;
					}else if(node.gas_safe_status == '03') {
						_safe_state = SAFE_STATE.WARNING;
					}else if(node.gas_safe_status == '02') {
						_safe_state = SAFE_STATE.CHECK;
					}

					if(node.array_sb_msg.length > 0){
						for(var i = 0; i < node.array_sb_msg.length; i++) {
							var item = node.array_sb_msg[i];
							if(isdefined(item.status)){
								if(item.status == '04') {
									_safe_state = SAFE_STATE.ERROR;
								}else if(item.status == '03') {
									_safe_state = SAFE_STATE.WARNING;
								}else if(item.status == '02') {
									_safe_state = SAFE_STATE.CHECK;
								}else{
									_safe_state = SAFE_STATE.NORMAL;
								}
							}
							//console.log('item : '+item);
							var find_node = Filter_AirtagNode(s_AirTag_NodeList, 'sensor_'+i, node.poi.poiId, item.msg, _safe_state, false, s_AirTagHelper.hAtlasHelper.getMessageBoxSmall(_safe_state));
							if(!find_node) {
								var airnode = new AirTag_Node();
								airnode.poi_id = node.poi.poiId;
								airnode.param_0 = item.msg;
								airnode.param_1 = _safe_state;
								airnode.type = 'sensor';

								s_AirTag_NodeList.push(airnode);

								var airtag = null;
								if(s_current_layer_state == LAYER_STATE.BUILDING) {
									airtag = s_AirTagHelper.showMessageBoxSmall(node.poi.poiId, item.msg, _safe_state, 'sensor');
								}
								else {
									airtag = s_AirTagHelper.showMessageBoxLarge(node.poi.poiId, item.msg, _safe_state, 'sensor');
								}

								airnode.airTagId = airtag.airTagId;
								airnode.bShow = false;
								airnode.hAirTag = airtag;
								find_node = airnode;
							}

							node.arrAirTag_Node.push(find_node);
						}
					}else{
						var find_node = Filter_AirtagNode(s_AirTag_NodeList, 'sensor', node.poi.poiId, node.sb_msg, _safe_state, false, s_AirTagHelper.hAtlasHelper.getMessageBoxSmall(_safe_state));
						if(!find_node) {
							var airnode = new AirTag_Node();
							airnode.poi_id = node.poi.poiId;
							airnode.param_0 = node.sb_msg;
							airnode.param_1 = _safe_state;
							airnode.type = 'sensor';

							s_AirTag_NodeList.push(airnode);

							var airtag = null;
							if(s_current_layer_state == LAYER_STATE.BUILDING) {
								airtag = s_AirTagHelper.showMessageBoxSmall(node.poi.poiId, node.sb_msg, _safe_state, 'sensor');
							}
							else {
								airtag = s_AirTagHelper.showMessageBoxLarge(node.poi.poiId, node.sb_msg, _safe_state, 'sensor');
							}

							airnode.airTagId = airtag.airTagId;
							airnode.bShow = false;
							airnode.hAirTag = airtag;
							find_node = airnode;
						}

						node.arrAirTag_Node.push(find_node);
					}
				}
			}
			else {
				// 카운트가 0 일 경우 삭제 처리
				DelNode_AirTag('sensor', node);
			}
		}

		// cctv
		if(s_bShow_cctv) {

			if(node.count_cctv != 0 && s_tab_state != TAB_STATE.WARNING) {
				if(node.poi == null) {

				}
				else {
					// Debug_Log_Re_Msg('Update_Node_AirTag show = ' +
					// s_bShow_cctv);
					var find_node = Filter_AirtagNode(s_AirTag_NodeList, 'cctv', node.poi.poiId, node.count_cctv, SAFE_STATE.NORMAL, true);
					if(!find_node) {
						var airnode = new AirTag_Node();
						airnode.poi_id = node.poi.poiId;
						airnode.param_0 = node.count_cctv;
						airnode.param_1 = SAFE_STATE.NORMAL;
						airnode.type = 'cctv';

						s_AirTag_NodeList.push(airnode);

						var airtag = s_AirTagHelper.showCCTV(node.poi.poiId, node.count_cctv, SAFE_STATE.NORMAL, 'cctv');

						airnode.airTagId = airtag.airTagId;
						airnode.bShow = false;
						airnode.hAirTag = airtag;
						find_node = airnode;
					}

					node.arrAirTag_Node.push(find_node);
				}
			}
			else {
				// 카운트가 0 일 경우 삭제 처리
				DelNode_AirTag('cctv', node);
			}
		}

		// violation_EventType
		if(s_bShow_violation_EventType) {

			if(node.violation_EventType_msg != null) {

				if(node.poi == null) {

				}
				else {
					var find_node = Filter_AirtagNode(s_AirTag_NodeList, 'violation_EventType', node.poi.poiId, node.violation_EventType_msg, SAFE_STATE.ERROR);
					if(!find_node) {
						var airnode = new AirTag_Node();
						airnode.poi_id = node.poi.poiId;
						airnode.param_0 = node.violation_EventType_msg;
						airnode.param_1 = SAFE_STATE.ERROR;
						airnode.type = 'violation_EventType';

						s_AirTag_NodeList.push(airnode);

						var airtag = s_AirTagHelper.showMessageBoxLarge(node.poi.poiId, node.violation_EventType_msg, SAFE_STATE.ERROR, 'violation');

						airnode.airTagId = airtag.airTagId;
						airnode.bShow = false;
						airnode.hAirTag = airtag;
						find_node = airnode;
					}

					node.arrAirTag_Node.push(find_node);
				}
			}
			else {
				// 카운트가 0 일 경우 삭제 처리
				DelNode_AirTag('violation_EventType', node);
			}
		}

		// imCall_EventType
		if(s_bShow_imCall_EventType) {
			if(node.imCall_EventType_msg != null) {

				if(node.poi == null) {

				}
				else {
					var find_node = Filter_AirtagNode(s_AirTag_NodeList, 'imCall_EventType', node.poi.poiId, node.imCall_EventType_msg, SAFE_STATE.ERROR);
					if(!find_node) {
						var airnode = new AirTag_Node();
						airnode.poi_id = node.poi.poiId;
						airnode.param_0 = node.imCall_EventType_msg;
						airnode.param_1 = SAFE_STATE.ERROR;
						airnode.type = 'imCall_EventType';

						s_AirTag_NodeList.push(airnode);

						var airtag = s_AirTagHelper.showMessageBoxLarge(node.poi.poiId, node.imCall_EventType_msg, SAFE_STATE.ERROR, 'imcall');

						airnode.airTagId = airtag.airTagId;
						airnode.bShow = false;
						airnode.hAirTag = airtag;
						find_node = airnode;
					}

					node.arrAirTag_Node.push(find_node);
				}
			}
			else {
				// 카운트가 0 일 경우 삭제 처리
				DelNode_AirTag('imCall_EventType', node);
			}
		}

		// gas
		if(s_bShow_gas) {

			//console.log('!!! s_bShow_gas node.poi.poiId : '+node.poi.poiId);
			if(node.gas_EventType_msg != null) {
				if(node.poi == null) {

				}
				else {

					var _safe_state = SAFE_STATE.ERROR;
					if(node.gas_safe_status_check) {
						_safe_state = SAFE_STATE.CHECK;
					}

					var find_node = Filter_AirtagNode(s_AirTag_NodeList, 'gas', node.poi.poiId, node.gas_EventType_msg, _safe_state);
					if(!find_node) {
						var airnode = new AirTag_Node();
						airnode.poi_id = node.poi.poiId;
						airnode.param_0 = node.gas_EventType_msg;
						airnode.param_1 = _safe_state;
						airnode.type = 'gas';

						s_AirTag_NodeList.push(airnode);

						var airtag = null;
						if(s_current_layer_state == LAYER_STATE.BUILDING) {
							airtag = s_AirTagHelper.showMessageBoxLarge(node.poi.poiId, node.gas_EventType_msg, _safe_state, 'gas');
						}
						else {
							airtag = s_AirTagHelper.showMessageBoxLarge(node.poi.poiId, node.gas_EventType_msg, _safe_state, 'gas');
						}

						airnode.airTagId = airtag.airTagId;
						airnode.bShow = false;
						airnode.hAirTag = airtag;
						find_node = airnode;
					}

					node.arrAirTag_Node.push(find_node);
				}
			}
			else {
				// 카운트가 0 일 경우 삭제 처리
				DelNode_AirTag('gas', node);
			}
		}
	}

	if(s_tab_state == TAB_STATE.FOCUS_CONTROL && node.watch_area_yn) {
		if(node.poi) {
			var bFind = false;
			for(var i = 0; i < s_Array_ObjectTransparency.length; i++) {
				var item = s_Array_ObjectTransparency[i];
				if(item == node.poi.poiId) {
					bFind = true;
				}
			}
			if(!bFind) {
				// 없는 경우에만 넣는다.
				s_Array_ObjectTransparency.push(node.poi.poiId);
			}
		}
	}

	// 비상대피구역 색상 표시
	if(s_tab_state == TAB_STATE.EMERGENCY) {
		if(node.poi) {
			var bFind = false;
			for(var i = 0; i < s_Array_ObjectTransparency_Em.length; i++) {
				var item = s_Array_ObjectTransparency_Em[i];
				if(item == node.poi.poiId) {
					bFind = true;
				}
			}
			if(!bFind) {
				// 없는 경우에만 넣는다.
				s_Array_ObjectTransparency_Em.push(node.poi.poiId);
			}
		}
		if(node.emergency) {
			s_AirTagHelper.showMessageBoxEm(node.poi.poiId, node.emergency.text, SAFE_STATE.WARNING);
		}
	}

	// 구역안전관제, 위험경고현황 2뎁스에서 셀에 색상 정보 표기
	if(use_cell_color) {
		if(s_tab_state == TAB_STATE.FOCUS_CONTROL || s_tab_state == TAB_STATE.EMERGENCY) {
			// 중점관리구역, 비상대피구역 제외
		}
		else {
			if(node.cell.area_type_id == 'AREA000001') {
				// default color
			}
			else {
				var bFind = false;
				for(var i = 0; i < s_Array_ObjectTransparency_Safe.length; i++) {
					var item = s_Array_ObjectTransparency_Safe[i];

					if(item.poi_id) {
						if(item.poi_id == node.poi.poiId) {
							bFind = true;
						}
					}
				}
				if(!bFind) {
					// 없는 경우에만 넣는다.
					if(node.poi) {
						var _CellAreaType = new Cell_Area_Type();
						_CellAreaType.poi_id = node.poi.poiId;
						_CellAreaType.color = node.cell.color;

						s_Array_ObjectTransparency_Safe.push(_CellAreaType);
					}
				}
			}
		}
	}
}

function Update_ObjectTransparency_Safe() {
	if(s_tab_state == TAB_STATE.FOCUS_CONTROL) {
		return;
	}

	// 구역안전관제, 위험경고현황
	for(var i = 0; i < s_Array_ObjectTransparency_Safe.length; i++) {

		var item = s_Array_ObjectTransparency_Safe[i];

		setObjectColor(item.poi_id, item.color);
		setObjectTransparency(item.poi_id, '150');
	}
}

function Update_ObjectTransparency_Em() {
	if(s_tab_state != TAB_STATE.EMERGENCY) {
		return;
	}

	// 비상대피구역
	for(var i = 0; i < s_Array_ObjectTransparency_Em.length; i++) {
		var item = s_Array_ObjectTransparency_Em[i];
		setObjectColor(item, '#DF1E1E66');
		setObjectTransparency(item, '150');
	}
}

function Update_ObjectTransparency() {
	if(s_tab_state == TAB_STATE.FOCUS_CONTROL || s_tab_state == TAB_STATE.EMERGENCY) {
		return;
	}

	if(s_Array_PrevObjectTransparency.length > 0) {
		var new_Object_list = '';
		var erase_Object_list = '';

		// 이전값이 현재에 속하지 않는값
		for(var i = 0; i < s_Array_PrevObjectTransparency.length; i++) {
			var item = s_Array_PrevObjectTransparency[i];
			if(s_Array_ObjectTransparency.indexOf(item) < 0) {
				erase_Object_list += item;
				erase_Object_list += ',';
			}
		}

		if(erase_Object_list) {
			setObjectOriginalColor(erase_Object_list);
			// setObjectTransparency(erase_Object_list, '150');
		}

		// 새로 추가 된 거
		for(var i = 0; i < s_Array_ObjectTransparency.length; i++) {
			var item = s_Array_ObjectTransparency[i];
			if(s_Array_PrevObjectTransparency.indexOf(item) < 0) {
				new_Object_list += item;
				new_Object_list += ',';
			}
		}

		if(new_Object_list) {
			setObjectColor(new_Object_list, '#2E75B666'); // '#0000FFAA');
			setObjectTransparency(new_Object_list, '150');
		}
	}
	else {
		var Object_list = '';
		for(var i = 0; i < s_Array_ObjectTransparency.length; i++) {

			var item = s_Array_ObjectTransparency[i];

			Object_list += item;
			if(i == s_Array_ObjectTransparency.length - 1) {}
			else {
				Object_list += ',';
			}
		}

		if(Object_list) {
			setObjectColor(Object_list, '#2E75B666'); // '#0000FFAA');
			setObjectTransparency(Object_list, '150');
		}
	}

	s_Array_PrevObjectTransparency = s_Array_ObjectTransparency.slice();
}

function setOrig_ObjectColor() {
	var orig_Object_list = '';
	for(var i = 0; i < s_Array_ObjectTransparency.length; i++) {

		var item = s_Array_ObjectTransparency[i];

		orig_Object_list += item;
		if(i == s_Array_ObjectTransparency.length - 1) {}
		else {
			orig_Object_list += ',';
		}
	}
	if(orig_Object_list) {
		setObjectOriginalColor(orig_Object_list);
	}
	s_Array_ObjectTransparency = new Array();
	s_Array_PrevObjectTransparency = new Array();

	var orig_Object_list_safe = '';
	for(var i = 0; i < s_Array_ObjectTransparency_Safe.length; i++) {

		var item = s_Array_ObjectTransparency_Safe[i];

		orig_Object_list_safe += item.poi_id;
		if(i == s_Array_ObjectTransparency_Safe.length - 1) {}
		else {
			orig_Object_list_safe += ',';
		}
	}
	if(orig_Object_list_safe.length > 0) {
		setObjectOriginalColor(orig_Object_list_safe);
	}
	s_Array_ObjectTransparency_Safe = new Array();

	var orig_Object_list_em = '';
	for(var i = 0; i < s_Array_ObjectTransparency_Em.length; i++) {
		var item = s_Array_ObjectTransparency_Em[i];
		orig_Object_list_em += item;
		if(i == s_Array_ObjectTransparency_Em.length - 1) {}
		else {
			orig_Object_list_em += ',';
		}
	}
	if(orig_Object_list_em) {
		setObjectOriginalColor(orig_Object_list_em);
	}
	s_Array_ObjectTransparency_Em = new Array();
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

function InitCameraInfo() {
	s_array_CameraTable = new Array();

	// -----------------------------------------------------------------------
	// 실서버 start
	// -----------------------------------------------------------------------
	var real_data_0 = new stCameraData('SCN000021', 54.54593, 42.72752, 869.067, -171.7165, 307.8778, -202.7606, -22.96281, 0, -41.71307);
	s_array_CameraTable.push(real_data_0);

	var real_data_1 = new stCameraData('SCN000048', 57.54587, 0.3275372, 683.8575, -0.4015933, 197.6768, -101.8333, 0.3170464, 0, 23.87632);
	s_array_CameraTable.push(real_data_1);

	var real_data_2 = new stCameraData('SCN000049', 49.14585, 21.12754, 700.2369, -57.90486, 185.7575, -149.8495, 0, 0, 0);
	s_array_CameraTable.push(real_data_2);

	var real_data_3 = new stCameraData('SCN000050', 64.14589, 37.5274, 689.9776, -341.9779, 214.5953, 98.35651, -278.6335, 0, 180.8266);
	s_array_CameraTable.push(real_data_3);

	var real_data_4 = new stCameraData('SCN000051', 57.54586, -1.672468, 595.4338, 170.6834, 150.0012, 72.572991, 167.89935, 0, 167.9249);
	s_array_CameraTable.push(real_data_4);

	var real_data_5 = new stCameraData('SCN000052', 58.54586, -0.472466, 709.6501, 0.3153976, 215.1567, -89.62465, -0.7698698, 0, 41.98227);
	s_array_CameraTable.push(real_data_5);

	var real_data_6 = new stCameraData('SCN000053', 58.54586, -0.472466, 709.6501, 0.3153976, 215.1567, -89.62465, -0.7698698, 0, 41.98227);
	s_array_CameraTable.push(real_data_6);

	var real_data_7 = new stCameraData('SCN000054', 59.54586, -0.2724648, 884.6281, -6.304178, 337.5683, -182.4923, -7.248024, 0, 15.98461);
	s_array_CameraTable.push(real_data_7);

	var real_data_8 = new stCameraData('SCN000056', 63.14587, 48.5275, 629.3583, -373.3308, 177.1078, 122.5789, -306.1406, 0, 181.9662);
	s_array_CameraTable.push(real_data_8);


	// -----------------------------------------------------------------------
	// 실서버 end
	// -----------------------------------------------------------------------
	// SCN000022
	var data_0 = new stCameraData('SCN000022', 37.34585, 41.32752, 897.7418, -213.0316, 244.636, -240.0164, -1.320661, 0, 0.7358688);
	s_array_CameraTable.push(data_0);

	// SCN000023
	var data_1 = new stCameraData('SCN000023', 37.34585, 41.32752, 897.7418, -213.0316, 244.636, -240.0164, -1.320661, 0, 0.7358688);
	s_array_CameraTable.push(data_1);

	// SCN000024
	var data_2 = new stCameraData('SCN000024', 37.34585, 41.32752, 897.7418, -213.0316, 244.636, -240.0164, -1.320661, 0, 0.7358688);
	s_array_CameraTable.push(data_2);

	// SCN000045
	var data_3 = new stCameraData('SCN000045', 37.34585, 41.32752, 897.7418, -213.0316, 244.636, -240.0164, -1.320661, 0, 0.7358688);
	s_array_CameraTable.push(data_3);

	// SCN000046
	var data_4 = new stCameraData('SCN000046', 37.34585, 41.32752, 897.7418, -213.0316, 244.636, -240.0164, -1.320661, 0, 0.7358688);
	s_array_CameraTable.push(data_4);

	// SCN000026
	var data_5 = new stCameraData('SCN000026', 37.34585, 41.32752, 675.7238, -121.4047, 138.7593, -135.8206, -1.320661, 0, 0.7358688);
	s_array_CameraTable.push(data_5);

	// SCN000047
	var data_6 = new stCameraData('SCN000047', 44.34585, 42.52753, 591.8882, -115.6571, 122.7854, -130.1096, -30.74385, 0, -37.53246);
	s_array_CameraTable.push(data_6);

	// SCN000032
	var data_7 = new stCameraData('SCN000032', 54.54586, 42.72753, 647.5742, -92.051091, 171.1707, -109.4297, -9.348339, 0, -19.89195);
	s_array_CameraTable.push(data_7);

	// SCN000036
	var data_8 = new stCameraData('SCN000036', 54.54586, 42.72753, 647.5742, -92.051091, 171.1707, -109.4297, -9.348339, 0, -19.89195);
	s_array_CameraTable.push(data_8);

	// SCN000037
	var data_9 = new stCameraData('SCN000037', 54.54586, 42.72753, 669.9103, -330.0671, 183.144, 82.31596, -241.5794, 0, 178.116);
	s_array_CameraTable.push(data_9);

	// SCN000039
	var data_10 = new stCameraData('SCN000039', 49.14585, 35.92753, 685.8332, 82.07194, 178.2142, 27.93033, 172.5063, 0, 152.7342);
	s_array_CameraTable.push(data_10);

	// SCN000041
	var data_11 = new stCameraData('SCN000041', 54.54586, 42.72753, 628.4807, 163.9118, 161.2579, 35.09768, 241.825, 0, 119.4501);
	s_array_CameraTable.push(data_11);

	// SCN000043
	var data_12 = new stCameraData('SCN000043', 54.54586, 42.72753, 554.5162, -380.0372, 125.6626, 113.4068, -319.3222, 0, 179.1397);
	s_array_CameraTable.push(data_12);

	// SCN000016
	var data_13 = new stCameraData('SCN000016', 54.54586, 42.72753, 681.263, 55.06322, 189.3855, 128.0572, 146.5666, 0, 227.123);
	s_array_CameraTable.push(data_13);

	// SCN000002
	var data_14 = new stCameraData('SCN000002', 54.54586, 42.72753, 711.577, -96.49717, 206.5662, -326.2054, 3.307231, 0, -218.1526);
	s_array_CameraTable.push(data_14);

	// SCN000018
	var data_15 = new stCameraData('SCN000018', 54.54586, 42.72753, 664.922, -136.8843, 180.4348, -333.684, -49.70554, 0, -239.3053);
	s_array_CameraTable.push(data_15);

	// SCN000020
	var data_16 = new stCameraData('SCN000020', 54.54586, 42.72753, 869.0662, -171.7165, 307.877, -202.7606, -22.96281, 0, -41.71307);
	s_array_CameraTable.push(data_16);

	// SCN000021
	var data_17 = new stCameraData('SCN000021', 54.54586, 42.72753, 869.0662, -171.7165, 307.8778, -202.7606, -22.96281, 0, -41.713073);
	s_array_CameraTable.push(data_17);

	// default
	// var data_18 = new stCameraData('SCN000001', 58.345856, -4.872474, 1500, 32.10098, 613.0229, -376.5674, 0, 0, 0);
	var data_18 = new stCameraData('SCN000001', 50.51357, -4.07246, 1332.427, 40.0928, 685.1767, -563.1181, 0, 0, 0);
	s_array_CameraTable.push(data_18);

}

function FindCameraTable(scene_id) {

	for(var i = 0; i < s_array_CameraTable.length; i++) {
		var _data = s_array_CameraTable[i];
		if(_data.scene_id == scene_id) {
			return _data;
		}
	}

	// default
	var _data0 = s_array_CameraTable[s_array_CameraTable.length - 1];

	return _data0;
}


var mapViewList_Response = function() {

	this.result_code = '';
	this.result_msg = '';

	this.mapview_list = function() {
		this.scene_type = '';
		this.scene_id = '';
		this.angle = '';
		this.rotation = '';
		this.zoom = '';
		this.coord_x = '';
		this.coord_y = '';
		this.coord_z = '';
		this.reg_dt = '';
		this.mod_dt = '';
		this.mod_id = '';
	}
}

mapViewList_Response.prototype = {
	setData: function(parseData) {
		this.result_code = parseData.header.result_code;
		this.result_msg = parseData.header.result_msg;

		if(parseData.body == 0) {}
		else {
			this.mapview_list = parseData.body.mapview_list;
		}
	}
}

// -------------------------------------------------------
//
// update zone
// cell 보여준다.
// -------------------------------------------------------

function stTouchInfo() {
	this.building_id = null;
	this.zone_id = null;
	this.cell_id = null;
	this.poi_id = null;

	this.building_node;
	this.zone_node;
	this.cell_node;

}

function GetTouchInfo_FromPoiID(poi_id) {
	switch(s_current_layer_state) {
		case LAYER_STATE.BUILDING:
			if(s_arrBuilding_Node == null) return;

			for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
				var build_node = s_arrBuilding_Node.get(i);

				if(build_node.poi.poiId == poi_id) {
					var hTouchInfo = new stTouchInfo();

					hTouchInfo.building_id = build_node.building.building_id;
					hTouchInfo.zone_id = null;
					hTouchInfo.cell_id = null;
					hTouchInfo.poi_id = poi_id;

					hTouchInfo.building_node = build_node;
					return hTouchInfo;
				}
			}
			break;
		case LAYER_STATE.ZONE:
			if(s_arrBuilding_Node == null) return;
			
			for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
				var build_node = s_arrBuilding_Node.get(i);

				for(var j = 0; j < build_node.zones.length; j++) {
					var zone_node = build_node.zones[j];
					for(var k = 0; k < zone_node.cells.length; k++) {
						var cell_node = zone_node.cells[k];
						
						if(cell_node.poi == null) {
							continue;
						}
						//console.log('$$ GetTouchInfo_FromPoiID cell_node.poi.poiId : '+cell_node.poi.poiId);
						if(cell_node.poi.poiId == poi_id) {
							var hTouchInfo = new stTouchInfo();

							hTouchInfo.building_id = build_node.building.building_id;
							hTouchInfo.zone_id = zone_node.zone.zone_id;
							hTouchInfo.cell_id = cell_node.cell.cell_id;
							hTouchInfo.poi_id = poi_id;

							hTouchInfo.building_node = build_node;
							hTouchInfo.zone_node = zone_node;
							hTouchInfo.cell_node = cell_node;
							//console.log('$$ GetTouchInfo_FromPoiID building_id : '+build_node.building.building_id);
							//console.log('$$ GetTouchInfo_FromPoiID zone_id : '+zone_node.zone.zone_id);
							//console.log('$$ GetTouchInfo_FromPoiID cell_id : '+cell_node.cell.cell_id);

							return hTouchInfo;
						}
					}
				}
			}
			break;
		case LAYER_STATE.CELL:
			if(s_arrBuilding_Node == null) return;

			for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
				var build_node = s_arrBuilding_Node.get(i);

				for(var j = 0; j < build_node.zones.length; j++) {
					var zone_node = build_node.zones[j];
					for(var k = 0; k < zone_node.cells.length; k++) {
						var cell_node = zone_node.cells[k];

						if(cell_node.poi == null) {
							continue;
						}
						if(cell_node.poi.poiId == poi_id) {
							var hTouchInfo = new stTouchInfo();

							hTouchInfo.building_id = build_node.building.building_id;
							hTouchInfo.zone_id = zone_node.zone.zone_id;
							hTouchInfo.cell_id = cell_node.cell.cell_id;
							hTouchInfo.poi_id = poi_id;

							hTouchInfo.building_node = build_node;
							hTouchInfo.zone_node = zone_node;
							hTouchInfo.cell_node = cell_node;

							return hTouchInfo;
						}
					}
				}
			}
			break;
	}

	return null;
}

// ---------------------------------------------------------------
//
// cctv list
//
// ---------------------------------------------------------------

function GetCCTVPoiID_FromPoiID(poi_id) {
	switch(s_current_layer_state) {
		case LAYER_STATE.BUILDING:
			if(s_arrBuilding_Node == null) {
				return;
			}

			for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
				var build_node = s_arrBuilding_Node.get(i);

				if(build_node.poi.poiId == poi_id) {
					return build_node.array_poi_cctv;
				}
			}
			break;
		case LAYER_STATE.ZONE:
			break;
		case LAYER_STATE.CELL:
			if(s_arrBuilding_Node == null) {
				return;
			}

			for(var i = 0; i < s_arrBuilding_Node.size(); i++) {
				var _building_node = s_arrBuilding_Node.get(i);

				for(var j = 0; j < _building_node.zones.length; j++) {
					var _zone_node = _building_node.zones[j];
					for(var h = 0; h < _zone_node.cells.length; h++) {
						var _cell_node = _zone_node.cells[h];

						if(_cell_node.poi.poiId == poi_id) {
							return _cell_node.array_poi_cctv;
						}
					}
				}
			}
			break;
	}

	return null;
}


function Play_CCTV_URL(url) {

	var str = url + ' --no-qt-name-in-title --no-autoscale --width=720 --height=480 --no-video-title-show';
	post_msg_btos('msg_send_play_cctv_url_btos', str);


	// post_msg_btos('msg_send_play_cctv_url_btos', url);
}