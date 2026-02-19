
//--------------------------------------------------------------
//
// AirTagHelper
//
//--------------------------------------------------------------

const AIRTAG_TYPE = {
	WORKER: 'WORKER',
	CRANE: 'CRANE',
	GAS: 'GAS',
	AP: 'AP',
	EQUIP: 'EQUIP',
	VISIT: 'VISIT',
	STRICTURE: 'STRICTURE',
	CCTV: 'CCTV',
	SENSOR: 'SENSOR',
	ANEMOMETER: 'ANEMOMETER',
	RETAIN_U: 'RETAIN_U',
	RETAIN_B: 'RETAIN_B',
	RETAIN_G: 'RETAIN_G',
	RETAIN_M: 'RETAIN_M',
	RETAIN_E: 'RETAIN_E',
	WATER: 'WATER',
	SUB: 'SUB',
	GATE: 'GATE',
	FIRE: 'FIRE'
}

const MENU_TYPE = {
		LOCATION: 'LOCATION',
		RETAIN: 'RETAIN',
		CRANE: 'CRANE',
		STRICTURE: 'STRICTURE',
		DASHBOARD: 'DASHBOARD',
		FEVER: 'FEVER',
		GATE: 'GATE',
		SUBMERGENCE: 'SUBMERGENCE',
		FIRE: 'FIRE',
		AP : 'AP'
	}

const FEVER_MAPTYPE = {
	    GATE: 'GATE',
	    AP: 'AP'
	}


function AirTagHelper() {

    this.tagMap;
    this.tcMap;
    this.poiWidthMap;
    this.poiHeightMap;
    this.ismvr;
    this.rePosSpace = 35;
    
    this.hAtlasHelper;

    this.show_myPosition = false;
    this.airtag_id_myPosition;

    this.setshow_myPosition = function (bshow) {
        this.show_myPosition = bshow;
    }

    this.getshow_myPosition = function () {
        return this.show_myPosition;
    }

    this.setid_myPosition = function (airtag_id) {
        this.airtag_id_myPosition = airtag_id;
    }

    this.getid_myPositon = function () {
        return this.airtag_id_myPosition;
    }
    
    this.setRePosSpace = function (space) {
        this.rePosSpace = space;
    }

    
    this.getRePosSpace = function () {
        return this.rePosSpace;
    }



    this.setup = function () {

        this.ismvr = true; //unity 연결 여부
        this.tagMap = new ArrayList();
        this.tcMap = new ArrayList();

        this.hAtlasHelper = new AtlasHelper();

        this.setPoiAreaList();
    }

    this.getAirtagMap = function () {
        return this.tagMap;
    }


    this.showAll = function (bShow) {
        if (this.ismvr) {
            setAirTagVisible(null, bShow);
        }
    }

    this.clear = function () {

        if (this.tagMap != null) {
            var delAirtag = "";

            for (var i = 0; i < this.tagMap.size() ; i++) {
                var airtag = this.tagMap.get(i);

                delAirtag += airtag.getId();

                if (i != this.tagMap.size() - 1) {
                    delAirtag += ",";
                }
            }

            if (this.ismvr != null) {
                if (delAirtag != "") {
                    deleteAirTag(delAirtag);
                }
            }
            this.tagMap.clear();
        }
        
        //타워크레인을 삭제한다. 
        if (this.tcMap != null) {

            for (var i = 0; i < this.tcMap.size() ; i++) {
                var tc = this.tcMap.get(i);

				deleteTowercrane(tc.device_no);
            }
            this.tcMap.clear();
        }

    }

    this.delete = function (airTagId) {

        var delAirtag = null;

        if (this.tagMap != null) {

            for (var i = 0; i < this.tagMap.size() ; i++) {
                var airtag = this.tagMap.get(i);
                if (airtag.getId() == airTagId) {
                    delAirtag = airtag;
                }
            }
        }
        if (delAirtag != null) {
            if (this.ismvr) {
                deleteAirTag(delAirtag.getId());
            }
            this.tagMap.remove_item(delAirtag);
        }
    }
    
    this.deleteByList = function (delTagList) {

        if (delTagList != null) {
            var delAirtag = "";

            for (var i = 0; i < delTagList.length ; i++) {
                var airtag = delTagList[i];

                delAirtag += airtag.getId();

                if (i != delTagList.length - 1) {
                    delAirtag += ",";
                }
                
                this.tagMap.remove_item(airtag);
            }

            if (this.ismvr != null) {
                if (delAirtag != "") {
                    deleteAirTag(delAirtag);
                }
            }
        }
    }
    
    this.getTagByAp = function (apId) {
		var airTags = null;

		for (var i = 0; i < this.tagMap.size() ; i++) {
			var tag = this.tagMap.get(i);
			if (apId == tag.getApID()) {
				airTags = tag;
			}
		}
		return airTags;
	}
    
    this.setTagByAp = function (apId, tag) {
		for (var i = 0; i < this.tagMap.size() ; i++) {
			if (apId == this.tagMap.get(i).getApID()) {
				this.tagMap.list[i] = tag;
				break;
			}
		}
	}

    this.getTag = function (airTagId) {
        var airTag = null;

        for (var i = 0; i < this.tagMap.size() ; i++) {
            var tag = this.tagMap.get(i);
            if (airTagId == tag.getId()) {
                airTag = tag;
                break;
            }
        }
        return airTag;
    }
    
    this.setTag = function (airTagId, tag) {
		for (var i = 0; i < this.tagMap.size() ; i++) {
			if (airTagId == this.tagMap.get(i).getId()) {
				this.tagMap.list[i] = tag;
				break;
			}
		}
	}

    this.getTc = function (device_no) {
        var airTc = null;

        for (var i = 0; i < this.tcMap.size() ; i++) {
            var tc = this.tcMap.get(i);
            if (device_no == tc.device_no) {
            	airTc = tc;
                break;
            }
        }
        return airTc;
    }
    
    
    this.getTagByPoi = function (poiId) {
        var airTags = new ArrayList();

        for (var i = 0; i < this.tagMap.size() ; i++) {
            var tag = this.tagMap.get(i);
            if (poiId == tag.getPoiID()) {
                airTags.add(tag);
            }
        }
        return airTags;
    }
    
    this.getTagByTagTypeId = function (poiId, airtagType, tagTypeId) {
        var airTags = new ArrayList();

        for (var i = 0; i < this.tagMap.size() ; i++) {
            var tag = this.tagMap.get(i);
            if (poiId == tag.getPoiID() && airtagType == tag.getAirtagType() && tagTypeId == tag.getTagTypeId()) {
                airTags.add(tag);
            }
        }
        return airTags;
    }
    
    this.getTagByTagType = function (airtagType) {
        var airTags = new ArrayList();

        for (var i = 0; i < this.tagMap.size() ; i++) {
            var tag = this.tagMap.get(i);
            if (airtagType == tag.getAirtagType()) {
                airTags.add(tag);
            }
        }
        return airTags;
    }

        
    String.format = function (format) {
        var args = Array.prototype.slice.call(arguments, 1);
        return format.replace(/{(\d+)}/g, function (match, number) {
            return typeof args[number] != 'undefined'
              ? args[number]
              : match
            ;
        });
    };
    
    this.releasTc = function (device_no) {

        for (var i = 0; i < this.tcMap.size() ; i++) {
            var tc = this.tcMap.get(i);
            if (device_no == tc.device_no) {
            	tc.destroy();
                this.tcMap.remove_item(tc);
                return;
            }
        }
    }
    
    this.releaseAirTag = function (airTagId) {

        for (var i = 0; i < this.tagMap.size() ; i++) {
            var tag = this.tagMap.get(i);
            if (airTagId == tag.getId()) {
                tag.destroy();
                this.tagMap.remove_item(tag);
                return;
            }
        }
    }

    this.rePositionAirTag = function (poiId) {

        var airTags_arr = this.getTagByPoi(poiId);
        var size = airTags_arr.size();
        if (size > 1) {
            for (var i = 0; i < airTags_arr.size() ; i++) {
                var tag = airTags_arr.get(i);
                var position = AIRTAG_POSITION.LEFT_TOP;
                switch (i) {
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
                    case 5:
                        position = AIRTAG_POSITION.RIGHT;
                        break;
                    case 6:
                        position = AIRTAG_POSITION.LEFT;
                        break;
                    case 7:
                        position = AIRTAG_POSITION.BOTTOM;
                        break;
                    case 8:
                        position = AIRTAG_POSITION.TOP;
                        break;
                }
                this.rePositionAirTag_3(tag.getId(), poiId, position);
            }
        } else if (airTags_arr.size() == 1) {
           // var tag = airTags_arr.get(0);
           // this.rePositionAirTag_3(tag.getId(), poiId, AIRTAG_POSITION.CENTER);
        }
    }


    this.rePositionAirTag_new = function (poiId) {

        var airTags_arr = this.getTagByPoi(poiId);
        var size = airTags_arr.size();
        if (size > 1) {
            for (var i = 0; i < airTags_arr.size() ; i++) {
                var tag = airTags_arr.get(i);
                var position = AIRTAG_POSITION.LEFT_TOP;
                switch (i) {
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
                    case 5:
                        position = AIRTAG_POSITION.RIGHT;
                        break;
                    case 6:
                        position = AIRTAG_POSITION.LEFT;
                        break;
                    case 7:
                        position = AIRTAG_POSITION.BOTTOM;
                        break;
                    case 8:
                        position = AIRTAG_POSITION.TOP;
                        break;
                        
                }
                this.rePositionAirTag_3(tag.getId(), poiId, position);
            }
        } else if (airTags_arr.size() == 1) {
          //  var tag = airTags_arr.get(0);
           // this.rePositionAirTag_3(tag.getId(), poiId, AIRTAG_POSITION.CENTER);
        }
    }


    this.isValid = function () {
        return this.tagMap != null;
    }

    this.rePositionAirTag_3 = function (airTagId, poiId, position) {

        var posX = 0;
        var posY = 0;
        var posZ = 0;

        var nXUnit = parseFloat(this.getPoiWidth(poiId) * this.rePosSpace / 100);
        var nZUnit = parseFloat(this.getPoiHeight(poiId) * this.rePosSpace / 100);

        var poiInfo;

        if (this.ismvr) {
            poiInfo = getPoiInfo(poiId);
        }
        if (poiInfo == null) {
            return;
        }
        posX = parseFloat(poiInfo.posX);
        posY = parseFloat(poiInfo.sizeY);
        posZ = parseFloat(poiInfo.posZ);

        switch (position) {
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

        if (this.ismvr) {
            setAirTagPosition(airTagId, posX, posY, posZ);
            //setAirTagPositionByPoiId( airTagId, poiId );
        }
    }

    this.getPoiWidth = function (poiId) {

        var defValue = 12;

        if (this.poiWidthMap != null && this.poiWidthMap.size() == 0) {
            this.setPoiAreaList();
        }

        if (this.poiWidthMap != null && this.poiWidthMap.get(poiId) != null) {
            defValue = this.poiWidthMap.get(poiId);
        }

        return defValue;
    }

    this.getPoiHeight = function (poiId) {

        var defValue = 12;

        if (this.poiHeightMap != null && this.poiHeightMap.size() == 0) {
            this.setPoiAreaList();
        }

        if (this.poiHeightMap != null && this.poiHeightMap.get(poiId) != null) {
            defValue = this.poiHeightMap.get(poiId);
        }

        return defValue;
    }

    this.CoordXComparator = function (p1, p2) {
        return (p1.x - p2.x);
    }

    this.CoordZComparator = function (p1, p2) {
        return (p1.z - p2.z);
    }

    this.setPoiAreaList = function () {

        if (this.poiWidthMap == null) {
            this.poiWidthMap = new HashMap();
        } else {
            this.poiWidthMap.clear();
        }

        if (this.poiHeightMap == null) {
            this.poiHeightMap = new HashMap();
        } else {
            this.poiHeightMap.clear();
        }

        if (s_PoiAreaList != null) {
            for (var i = 0; i < s_PoiAreaList.poiAreaList.length; i++) {
                var poiArea = s_PoiAreaList.poiAreaList[i];
                var poiId = poiArea.poiId;

                var coordList = poiArea.coordList;
                if (coordList != null && coordList.length >= 2) {

                    coordList.sort(this.CoordXComparator);
                    this.poiWidthMap.put(poiId, coordList[coordList.length - 1].x - coordList[0].x);

                    coordList.sort(this.CoordZComparator);
                    this.poiHeightMap.put(poiId, coordList[coordList.length - 1].z - coordList[0].z);
                }
            }
        }
    }

    this.showWorker = function (tagInfo) {
    	
    	tagInfo.textTopMargin = 70;
        tagInfo.textExtraMargin = -1;
        if(tagInfo.text.length == 2)
        {
                tagInfo.textExtraMargin = 5;
        }
        else if(tagInfo.text.length == 3)
        {       
                tagInfo.textExtraMargin = 3;
        } 

        tagInfo.textSize = 20;
    	
        return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(tagInfo.airtagType + "_" +  tagInfo.color));
    }
    
    this.showEquip = function (tagInfo) {
    	
    	tagInfo.textTopMargin = 70;
    	tagInfo.textExtraMargin = 0;
    	tagInfo.textSize = 20;

        return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(tagInfo.airtagType + "_" +  tagInfo.equipId));
    }
    
    this.showGas = function(tagInfo) {
    	
    	tagInfo.textTopMargin = 73;
    	tagInfo.textExtraMargin = 0;
    	tagInfo.textSize = 20;

    	return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(tagInfo.airtagType + "_" +  tagInfo.color));
	}
    
    this.showStricture = function(tagInfo) {
    	    	
    	tagInfo.textTopMargin = 61;
    	tagInfo.textExtraMargin = 0;
    	tagInfo.textSize = 18;
    	
    	if(!tagInfo.isMainBuilding ) {
        	tagInfo.extraText = "NO";
        	tagInfo.textExtraMargin = -2;
    	} 


    	return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(tagInfo.airtagType + "_" +  tagInfo.color));
	}
        
    this.showRetain = function (tagInfo) {
    	
    	tagInfo.textTopMargin = 72;
    	tagInfo.textExtraMargin = 0;
    	tagInfo.textSize = 20;

    	return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(this.getAtlasImageTypeByTagInfo(tagInfo)));
    }
    
    this.showCrane = function(tagInfo) {
    	
    	tagInfo.textTopMargin = 65;
    	tagInfo.textExtraMargin = 0;
    	tagInfo.textSize = 20;

    	return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(this.getAtlasImageTypeByTagInfo(tagInfo)));
    }
    
    this.showGate = function(tagInfo) {
    	
    	tagInfo.textTopMargin = 63;
    	tagInfo.textExtraMargin = 4;
    	tagInfo.textSize = 20;
    	tagInfo.extraText = "G";
    	
    	//임시방편, 추후 아틀라스 이미지 보정 예정. 
    	if(tagInfo.color == "GREEN") {
        	tagInfo.textExtraMargin = tagInfo.textExtraMargin + 2;
    	} else if(tagInfo.color == "RED") {
        	tagInfo.textTopMargin = tagInfo.textTopMargin - 2;
        	tagInfo.textExtraMargin = tagInfo.textExtraMargin + 2;
    	}


    	return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(tagInfo.airtagType + "_" +  tagInfo.color));
	}
    
    this.showFire = function(tagInfo) {
    	
    	tagInfo.textTopMargin = 67;
    	tagInfo.textExtraMargin = 0;
    	tagInfo.textSize = 20;
    	
    	//임시방편, 추후 아틀라스 이미지 보정 예정. 
    	if(tagInfo.color == "GRAY") {
        	tagInfo.textExtraMargin = tagInfo.textExtraMargin-2;
    	} 
    	else if(tagInfo.color == "ORANGE") {
        	tagInfo.textTopMargin = 64;
    	} 


    	return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(tagInfo.airtagType + "_" +  tagInfo.color));
	}
    
    this.showWater = function(tagInfo) {
    	
    	tagInfo.textTopMargin = 63;
    	tagInfo.textExtraMargin = 0;
    	tagInfo.textSize = 20;
    
    	return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(tagInfo.airtagType + "_" +  tagInfo.color));
	}
    
    this.showSub = function(tagInfo) {
    	
    	tagInfo.textTopMargin = 62;
    	tagInfo.textExtraMargin = 0;
    	tagInfo.textSize = 20;
    	
    	//임시방편, 추후 아틀라스 이미지 보정 예정. 
    	if(tagInfo.color == "RED") {
    	} 
    	else if(tagInfo.color == "GRAY") {
        	tagInfo.textExtraMargin = -2;
    	} 

    	return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(tagInfo.airtagType + "_" +  tagInfo.color));
	}
    
    this.showAp = function(tagInfo) {
    	
    	tagInfo.textTopMargin = 74;
    	tagInfo.textExtraMargin = 6;
    	tagInfo.textSize = 20;
    	
    	if(tagInfo.color == "RED") {
        	tagInfo.textExtraMargin = 4;
    	} 

    	tagInfo.extraText = "A";

    	return this.showAirTag(tagInfo, this.hAtlasHelper.getAtlasImage(tagInfo.airtagType + "_" +  tagInfo.color));
	}
    
    this.showAirTag = function (tagInfo, background) {
    	
        if (!this.isValid())
            return null;
        
        if(isEmpty(background) || isEmpty(tagInfo.poiId)) {
        	console.log("showAirTag: Invalid Tag Info. Background=" + tagInfo.background + ", poiId=" + tagInfo.poiId);
        	return null;
        }
        
        var airTagId = String.format(tagInfo.airtagType + "_" + tagInfo.tagTypeId + "_{0}_", tagInfo.poiId) + new Date().getTime() + "guid_" + GetGuidCountAirTag();


        var tag = new AirTag(airTagId);
        tag.create();
        tag.setPoiID(tagInfo.poiId);
        tag.setAirtagType(tagInfo.airtagType);
        tag.setTagTypeId(tagInfo.tagTypeId);
        tag.setBackground(background);
        tag.setExtraText(tagInfo.extraText);
        
        var baseHeight = 3;
        var info = getPoiInfo(tagInfo.poiId);
    	if(info != null) {
    		//lkl crane AirTag 분기 처리   crane AirTag 는 TowerCrane 의 InCircle 의 높이에 위치시킨다.
    		if( AIRTAG_TYPE.CRANE == tagInfo.airtagType ) {
    			tag.setPosition(info.posX, parseInt(baseHeight)+(tagInfo.idx * 4), info.posZ);
    		} else {
    			tag.setPosition(info.posX, info.sizeY, info.posZ);
    		}
    	}
    	tagInfo.text = tagInfo.extraText + tagInfo.text;
    	
    	//console.log(">>>>>>>>>>>>>>>>>> x=" + info.posX + ", y=" + info.sizeY + ", z=" + info.posZ);
    	
    	tag.setText(tagInfo.text);
        tag.setTextColor("#ffffffff");
        tag.setTextSize(tagInfo.textSize);
        tag.setTextTopMargin(tagInfo.textTopMargin);
        tag.setTextLeftMargin(tagInfo.textExtraMargin + this.getTextLeftMargin(tagInfo.text));
        tag.setTextExtraMargin(tagInfo.textExtraMargin)

        tag.setType(POI_BILLBOARD.TYPE_2D);
        this.tagMap.add(tag);

        tag.show();
        
        return tag;
    }
    
    this.updateAirTag = function(tagInfo) {
    	    			
		var tag  = this.getTag(tagInfo.airTagId);
		var info = getPoiInfo(tagInfo.poiId);
	    	
		var backGround = this.hAtlasHelper.getAtlasImage(this.getAtlasImageTypeByTagInfo(tagInfo));
    	
		tagInfo.text = tag.getExtraText() + tagInfo.text;
		
		tag.setBackground(backGround);
		tag.setTextColor("#ffffffff");
		tag.setText(tagInfo.text);
        tag.setTextLeftMargin(tag.getTextExtraMargin() + this.getTextLeftMargin(tagInfo.text));
		tag.setType(POI_BILLBOARD.TYPE_2D);

		this.setTag(tagInfo.airTagId, tag);
		tag.update(false);
		return tag;
	}
    
    this.getTextLeftMargin = function(text) {
        if (text.length >= 3) {
            return 42;
        } else if (text.length >= 2) {
            return 46;
        } else if (length >= 1) {
            return 58;
        } else {
            return 58;
        }
    }    
    
    //타워크레인 관련  추가. 
    this.createTowercrane = function(crane, baseHeight, render_queue) {

        var barAngle = 0;

        var checkInfo = getPoiInfo(crane.poi_id);
        //lkl T/L 형 Towercrane 각도 계산
//        if("" == crane.pitch || null == crane.pitch){
//        	barAngle = crane.yaw;
//        }else{
//            barAngle = crane.pitch;
//        }
        if( crane.yaw != null ) {
        	barAngle = parseInt(crane.yaw) + 265;
        } 
        var idx = render_queue - 1;
        
        if("T" == crane.crane_type){
        	if(parseInt(crane.counter_jib_length) > parseInt(crane.jib_length) ) {
            	crane.counter_jib_length = parseFloat(crane.jib_length)/5;
            } 
        	if(crane.trolly_distance == null) {
        		crane.trolly_distance = 0.1;
        	}
        	createTowercrane(crane.device_no, checkInfo.posX, checkInfo.posY, checkInfo.posZ, crane.jib_length, crane.trolly_distance, 1.2 +  parseInt(idx), 1.4 + parseInt(idx), "6CBCFF66", "6CBCFFE6", barAngle, crane.jib_length, crane.counter_jib_length, 2.5, 3.5 + parseInt(idx), "FFF95AFF", render_queue);
        }else{
        	if(parseInt(crane.counter_jib_length) > parseInt(crane.radius) ) {
            	crane.counter_jib_length = parseFloat(crane.radius)/5;
            } 
            createTowercrane(crane.device_no, checkInfo.posX, checkInfo.posY, checkInfo.posZ, crane.radius, crane.jib_length, 1.2 + parseInt(idx), 1.4 + parseInt(idx), "6CBCFFE6", "6CBCFF66", barAngle, crane.radius, crane.counter_jib_length, 2.5, 3.5 + parseInt(idx), "FFF95AFF", render_queue);
        }
    	setVisibleTowercrane(crane.device_no, true);	
    	setViewTypeTowercrane(crane.device_no, "2d");
    	
    	this.tcMap.add(crane);
    }

    this.updateTowerCrane = function(craneId, poiId, yaw, pitch, render_queue) {
    	
    	var checkInfo = getPoiInfo(poiId);
    	var barAngl   = 0;

        if( yaw != null ) {
        	barAngle = parseInt(yaw) + 265;
        } else {
        	console.log(">> yaw == null" );
        }
    	
    	setBarAngleTowercrane(craneId, barAngle);
    }
    
    var bTagShow = false;
    var gateAirTagId = "guid_" + GetGuidCountAirTag();
    this.refreshGateWorker = function (count) {
    	
    	console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>refreshGateWorker>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

    	var background = this.hAtlasHelper.getAtlasImage("WORKER_GREEN");
    	
    	console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        
        var tag = new AirTag(gateAirTagId);
        tag.create();
        tag.setPoiID("");
        tag.setAirtagType("WORKER_GREEN");
        tag.setTagTypeId("");
        tag.setBackground(background);
        tag.setExtraText("");
        
        var baseHeight = 3;
    	tag.setPosition(-23, 25, -110);
    		
        tag.setText(count);
        tag.setTextColor("#ffffffff");
        tag.setTextSize(20);
        tag.setTextTopMargin(70);
        tag.textExtraMargin = -1;
        tag.setTextLeftMargin(58);
        
        if(count.toString().length == 2)
	    {
        	tag.setTextSize(15);
        	tag.setTextLeftMargin(55);
        	tag.setTextExtraMargin(5);
	    }
	    else if(count.toString().length == 3)
	    {       
        	tag.setTextSize(15);
        	tag.setTextLeftMargin(51);
        	tag.setTextExtraMargin(3);
	    }
	    else
    	{
	    	tag.setTextSize(20);
	    	tag.setTextLeftMargin(58);
	    	tag.setTextExtraMargin(-1);
    	}
        tag.setType(POI_BILLBOARD.TYPE_2D);
        
        if(!bTagShow)
        {
        	this.tagMap.add(tag);
        	bTagShow = true;
        }

        tag.show();
        
        return tag;    	
    }
    
    this.deleteGateWorker = function () {
    	
    	deleteAirTag(gateAirTagId);
    }

    
    /** @description .
     * 측위 및 서버로부터 수신 받은 데이터와 MAP에 표시한 AirTag를 비교하여, 
     * 데이터에서 없어진 AirTag는 삭제한다. 
     * 데이터가 변경된 에어테그는 업데이트를 한다.
     * 신규 추가된 AirTag는 신규 생성한다. 
     * 동일 POI에 여러 태그가 있을 경우, 순서를 정렬한다. 
     * @param {id} Element ID.
     * @param {value} 설정할 데이터 .
     * svrTagList: [poiId, airtagType, tagTypeId, color, text ]
     * svrPoiList: [unique poiId]
     * isMainBuilding: 조감도 여부를 나타낸다. 
     * @return {void}
     */
    this.refreshAirtags = function (svrTagList, svrPoiList, isMainBuilding) {
    	var delTagList = new Array();
    	var updTagList = new Array();
    	var newTagList = new Array();
    	var idx = 0;
    	
    	if(isEmpty(this.tagMap))
    		return ;
    	
    	//1) 삭제 또는 업데이트할 에어태그 목록을 체크한다. 
        for (idx = 0; idx < this.tagMap.size() ; idx++) {
        	var tag = this.tagMap.get(idx);
        	
        	var svrPoi = this.searchServerPoi(tag, svrTagList);
        	if(isEmpty(svrPoi))
        		delTagList.push(tag);
        	else if(this.isChangeAirTagContent(svrPoi, tag)){
        		svrPoi.airTagId = tag.getId();
        		svrPoi.isMainBuilding = isMainBuilding;
        		updTagList.push(svrPoi);
        	}
        }
        
        // 신규 추가된 AirTag가 있는지 체크한다. 
        for(idx = 0; idx < svrTagList.length; idx++) {
        	var tag = this.searchMapAirTag(svrTagList[idx]);
        	if(isEmpty(tag)) {
        		svrTagList[idx].isMainBuilding = isMainBuilding;
        		newTagList.push(svrTagList[idx]);
        	}
        }
        
        //1) AirTag 삭제. 
        this.deleteByList(delTagList);
        
        //2) update태그 리스트 
        this.updateAirTagList(updTagList);
        
        // 3) 신규생성 태그 리스트 
        this.createAirTagList(newTagList);
        
        if(delTagList.length <= 0 && newTagList.length <= 0)
        	return ;
       
        for (idx = 0; idx < svrPoiList.length ; idx++) {
        	svrPoiList[idx].isMainBuilding = isMainBuilding;
        	this.rePositionAirTag(svrPoiList[idx]);
        }
    }
    
    this.createAirTagList = function(newTagList) {
    	
        for(idx = 0; idx < newTagList.length; idx++) {
        	var newTag = newTagList[idx];
        	        	
        	if(newTag.airtagType == AIRTAG_TYPE.WORKER)
        		this.showWorker(newTag);
        	else if(newTag.airtagType == AIRTAG_TYPE.GAS)
        		this.showGas(newTag);
        	else if(newTag.airtagType == AIRTAG_TYPE.EQUIP)
        		this.showEquip(newTag);
        	else if(newTag.airtagType == AIRTAG_TYPE.STRICTURE)
        		this.showStricture(newTag);
        	else if(newTag.airtagType == AIRTAG_TYPE.CRANE) {
        		newTag.idx = idx;
        		this.showCrane(newTag);
        	}else if(newTag.airtagType == AIRTAG_TYPE.WATER){
        		this.showWater(newTag);
        	}else if(newTag.airtagType == AIRTAG_TYPE.SUB){
        		this.showSub(newTag);
        	}else if(newTag.airtagType == AIRTAG_TYPE.GATE){
        		this.showGate(newTag);
        	}else if(newTag.airtagType == AIRTAG_TYPE.FIRE){
        		this.showFire(newTag);
        	}else if(newTag.airtagType == AIRTAG_TYPE.AP){
        		this.showAp(newTag);
        	}else if(this.isRetainAirTag(newTag.airtagType)) 
        		this.showRetain(newTag);
        }
    }
    
    this.updateAirTagList = function(updTagList) {
        for(idx = 0; idx < updTagList.length; idx++) {
        	this.updateAirTag(updTagList[idx]);
        }
    }
    
    //서버에서 조회한 AirTag 리스트와 맵에 그려진 리스트를 비교한다. 
    this.searchServerPoi = function(tag, svrTagList) {
    	
    	for(var i = 0; i < svrTagList.length; i++) {
    		var svrPoi = svrTagList[i];
    		
    		if(tag.getPoiID() == svrPoi.poiId && tag.getAirtagType() == svrPoi.airtagType && svrPoi.tagTypeId == tag.getTagTypeId()) {
    			return svrPoi;
    		}
    	}
    	return null;
    }
    
    //맵에 그려진 리스트와 서버에서 가져온 AirTag리스트를 비교한다. 
    this.searchMapAirTag = function(svrPoi) {
    	
    	for(var i = 0; i < this.tagMap.size(); i++) {
        	
            var tag = this.getTagByTagTypeId(svrPoi.poiId, svrPoi.airtagType, svrPoi.tagTypeId);
            if(!isEmpty(tag) && tag.size() > 0)
            	return tag;
    	}
    	return null;
    }
    
    //화면에 그려진 AirTag의 정보가(색상 또는 문구) 변경되었는지 확인한다. 
    this.isChangeAirTagContent = function(svrPoi, tag) {
    	
    	var atlasType = this.getAtlasImageTypeByTagInfo(svrPoi)
    	
    	if(isEmpty(tag) || isEmpty(tag.getBackground())) {
    		console.log("isChangeAirTagContent: Invalid Tag Info=" + tag);
    		return false;
    	}
    	
    	if(atlasType == tag.getBackground().getType() && svrPoi.text == tag.getText())
    		return false;
    	
    	return true;
    }
    
    //AriTagType이 흙막이인지 여부를 체크한다. 
    this.isRetainAirTag = function(airtagType) {
    	
    	if(airtagType == AIRTAG_TYPE.RETAIN_U || airtagType == AIRTAG_TYPE.RETAIN_B ||
    	   airtagType == AIRTAG_TYPE.RETAIN_G || airtagType == AIRTAG_TYPE.RETAIN_M || 
    	   airtagType == AIRTAG_TYPE.RETAIN_E)
    		return true;

    	return false;
    }
    
    //AtlasImage에서 사용하는 타입정보를 가져온다. 
    //CRANE 및 EQUIP는 타입정보 체계가 달라, 아래와 같이 예외처리를 해줌. 
    this.getAtlasImageTypeByTagInfo = function(tagInfo) {
    	if(tagInfo.airtagType == AIRTAG_TYPE.CRANE)
    		return tagInfo.airtagType + "_" +  tagInfo.color + "_" + tagInfo.craneType;
    	else if(tagInfo.airtagType == AIRTAG_TYPE.EQUIP)
    		return tagInfo.airtagType + "_" +  tagInfo.equipId ;
    	else if(this.isRetainAirTag(tagInfo.airtagType)) 
    		return "RETAIN" + "_" +  tagInfo.color;
    	else
    		return tagInfo.airtagType + "_" +  tagInfo.color;
    }
    
    //위치관제메뉴에서 상단 탭을 클릭했을 경우, 에어태그를 보여줄지 여부를 설정한다. 
    this.setAirTagVisible = function(airtagType, visible) {
    	var airtagList = this.getTagByTagType(airtagType);
    	var airtagIds = "";
    	
        for (var i = 0; i < airtagList.size() ; i++) {
            var airtag = airtagList.get(i); 

            airtagIds += airtag.getId();
            if (i != airtagList.size() - 1) {
            	airtagIds += ",";
            }            
        }
        setAirTagVisible(airtagIds, visible);
    }
}