

var s_PoiTableMap = null;
var s_PoiAreaList;
var s_PoiList;


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
	//console.log('!!!callback_success_PoiAreaList');
}

function callback_fail_PoiAreaList(data) {

	var ixx = 0;
	//console.log('!!!callback_fail_PoiAreaList');
}
