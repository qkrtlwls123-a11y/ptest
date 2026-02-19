
//유니티 API 목록 
//--------------------------------------------------------------
//
// set api
//
//--------------------------------------------------------------


var sep_n = "\\n";
var sep_b = "\\b";


function getMousePos(e) {
	
	return { x: e.offsetX, y: e.offsetY };
    //return { x: (e.clientX - canvas_rect.left - g_realposx) * g_realratio, y: (e.clientY - canvas_rect.top - g_realposy) * g_realratio };
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

// 12
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
    msg += "-1" + sep_b;                               // airTagIds
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