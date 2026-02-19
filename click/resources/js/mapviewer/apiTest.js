
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
var s_setLanguageCode = "EN";
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

function fn_makeAirTagHelper(tagType, tagCount, tagColor, poiId) {
	
    // get
//    var tagMap = s_AirTagHelper.getAirtagMap();

    // test
    /*var AirTag_01 = new AirTag("airtag_001");

    var AirTag_02 = new AirTag("airtag_002");

    var AirTag_03 = new AirTag("airtag_003");
    tagMap.add(AirTag_01);
    tagMap.add(AirTag_02);
    tagMap.add(AirTag_03);*/
    
  //  s_AirTagHelper.showWorker("POI000004", tagCount, WORKER_COLOR.RED, 'worker');
    
  // s_AirTagHelper.showWorker("POI000012", tagCount, WORKER_COLOR.GREEN, 'worker');
    
 //   s_AirTagHelper.showWorker("POI000015", tagCount, WORKER_COLOR.GREEN, 'worker');
    
    
    
    if(tagType == "worker"){
    	if(tagColor == "RED"){
    		s_AirTagHelper.showWorker(poiId, tagCount, WORKER_COLOR.RED, 'worker');
    	}else{
    		s_AirTagHelper.showWorker(poiId, tagCount, WORKER_COLOR.GREEN, 'worker');
    	}
	}else if(tagType == "gas"){
		s_AirTagHelper.showGasValue(poiId, "msg", SAFE_STATE.CHECK);
	}else if(tagType == "equip"){
		
	}else if(tagType == "crane"){
		var info = new craneInfo();
		info.crane_id = '1';
		var checkInfo = getPoiInfo("POI000036");
		var checkInfo2 = getPoiInfo("POI000037");
		/*info.coord_x = checkInfo.posX;
		info.coord_y = checkInfo.posY;
		info.coord_z = checkInfo.posZ;
		s_AirTagHelper.showCrane(CRANE_COLOR.GREEN_ON, info, "msg", '');*/
		
		var str_id_2 = "2";
		var str_id_3 = "3";
        createTowercrane(str_id_2, checkInfo.posX, checkInfo.posY, checkInfo.posZ, 40.0, 45.0, 5.0, 5.1, "74BFFF", "BCDBF7", 160.0, 40.0, 20.0, 3.0, 7.5, "FFF95B", 3);
        createTowercrane(str_id_3, checkInfo2.posX, checkInfo2.posY, checkInfo2.posZ, 40.0, 45.0, 5.0, 5.1, "74BFFF", "BCDBF7", 160.0, 40.0, 20.0, 3.0, 7.5, "FFF95B", 3);
        //setRadiusInTowercrane(str_id_1, 10);
        // setRadiusOutTowercrane(str_id_1, 30);
        ////setColorInTowercrane(str_id, "FF0000FF");
        //setColorOutTowercrane(str_id_1, "FF0000FF");
        //setBarAngleTowercrane(str_id_1, 90.0f);
        // setBarRadiusTowercrane(str_id_1, 30);
        //setBarColorTowercrane(str_id_1, "FFFF00FF");
        setVisibleTowercrane(str_id_2, true);
        setVisibleTowercrane(str_id_3, true);
        //setViewTypeTowercrane(str_id_2, "2d");
        //deleteTowercrane(str_id);
	}
    // showWorker
    
    // showCCTV
    //s_AirTagHelper.showCCTV("POI000032", 100, SAFE_STATE.NORMAL);
    
    // showAp
    //s_AirTagHelper.showAp("POI000002", null, AP_COLOR.GREEN_ON);
//    s_AirTagHelper.showAp("POI000005", 1, AP_COLOR.GREEN_ON);
//    s_AirTagHelper.showAp("POI000006", 2, AP_COLOR.GREEN_OFF);
//    s_AirTagHelper.showAp("POI000007", 3, AP_COLOR.RED_ON);
//    s_AirTagHelper.showAp("POI000008", 4, AP_COLOR.RED_OFF);
    
    //showStricture
//    s_AirTagHelper.showStricture("POI000005", 1, STRICTURE_COLOR.GREEN_ON);
//    s_AirTagHelper.showStricture("POI000006", 2, STRICTURE_COLOR.GREEN_OFF);
//    s_AirTagHelper.showStricture("POI000007", 3, STRICTURE_COLOR.RED_ON);
//    s_AirTagHelper.showStricture("POI000008", 4, STRICTURE_COLOR.RED_OFF);
    
  //showRetain
//    s_AirTagHelper.showRetain("POI000015", 1, RETAIN_COLOR.GREEN_NONE);
//    s_AirTagHelper.showRetain("POI000016", 2, RETAIN_COLOR.RED_NONE);
 


    // getAirtagByPoiId
    //var list_Airtag = s_AirTagHelper.getAirtagByPoiId("poi_01");

    // showAll
    s_AirTagHelper.showAll("true");

    // clear
    //s_AirTagHelper.clear();

    // delete
    //s_AirTagHelper.delete("airtag_002");

    // showSensor
    //s_AirTagHelper.showSensor("poi_01", 150);

    // showAp
    //s_AirTagHelper.showAp("POI000002", null, AP.GREEN);

    // showWorker
    //s_AirTagHelper.showWorker("poi_01", 200, WORKER_COLOR.RED);

    // showCCTV
    //s_AirTagHelper.showCCTV("poi_01", 100, SAFE_STATE.NORMAL);

    //// showVisit
    //s_AirTagHelper.showVisit("poi_01", 100);

    //// showMessageBoxSmall
    //s_AirTagHelper.showMessageBoxSmall("poi_01", "msg", SAFE_STATE.CHECK);

    //// showGasValue
    //s_AirTagHelper.showGasValue("poi_01", "msg", SAFE_STATE.CHECK);

    //// showMessageBoxLarge
    //s_AirTagHelper.showMessageBoxLarge("poi_01", "msg", SAFE_STATE.CHECK);

    //// showMyPosition
    //s_AirTagHelper.showMyPosition("poi_01");

    //// showAirTag
    //background = AtlasImage();
    //s_AirTagHelper.showAirTag("poi_01", "airtag_01", 100, background);

    //// showAirTag
    //s_AirTagHelper.showAirTag("poi_01", "airtag_01", 100, background, 10);

    //// releaseAirTag
    //s_AirTagHelper.releaseAirTag("airtag_01");

    //// getTag
    //s_AirTagHelper.getTag("airtag_01");

    //// getTagByPoi
    //s_AirTagHelper.getTagByPoi("poi_01");

    //// rePositionAirTag
    //s_AirTagHelper.rePositionAirTag("poi_01");

    //// isValid
    //s_AirTagHelper.isValid();

    //// rePositionAirTag
    //s_AirTagHelper.rePositionAirTag_3("airtag_01", "poi_01", AIRTAG_POSITION.LEFT);

    //// getPoiWidth
    //s_AirTagHelper.getPoiWidth("airtag_01");

    //// getPoiHeight
    //s_AirTagHelper.getPoiHeight("airtag_01");

}

