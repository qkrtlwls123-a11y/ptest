
//--------------------------------------------------------------
//
// AtlasHelper
//
//--------------------------------------------------------------
const COLOR = {
    RED: 'RED',
    GREEN: 'GREEN',
    YELLOW: 'YELLOW',
    BLUE: 'BLUE',
    GRAY: 'GRAY',
    ORANGE: 'ORANGE',
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
		
    this.Name = "atlasimage1.png";
    this.Width = 128;
    this.Height = 128;

	this.atlasIdxList = [
		new AtlasImage("WORKER_GREEN", 0, 0, this.Width, this.Height),
        new AtlasImage("WORKER_RED", 1, 0, this.Width, this.Height),
        new AtlasImage("CRANE_GREEN_T", 2, 0, this.Width, this.Height),
        new AtlasImage("CRANE_ORANGE_T", 3, 0, this.Width, this.Height),
        new AtlasImage("CRANE_RED_T", 4, 0, this.Width, this.Height),
        new AtlasImage("CRANE_GREEN_L", 5, 0, this.Width, this.Height),
        new AtlasImage("CRANE_ORANGE_L", 6, 0, this.Width, this.Height),
        new AtlasImage("CRANE_RED_L", 7, 0, this.Width, this.Height),
        new AtlasImage("PIN", 0, 1, this.Width, this.Height),
        new AtlasImage("EQUIP_HAVY000001", 2, 1, this.Width, this.Height), // 굴삭기 
        new AtlasImage("EQUIP_HAVY000002", 3, 1, this.Width, this.Height), // 페이로더 
        new AtlasImage("EQUIP_HAVY000003", 4, 1, this.Width, this.Height), // 지게차
        new AtlasImage("EQUIP_HAVY000004", 5, 1, this.Width, this.Height), // 크롤러크레인
        new AtlasImage("EQUIP_HAVY000005", 6, 1, this.Width, this.Height), // 하이드로크레인
        new AtlasImage("EQUIP_HAVY000006", 7, 1, this.Width, this.Height), // 카고크레인
        new AtlasImage("EQUIP_HAVY000007", 0, 2, this.Width, this.Height), // 콘크리트믹서트럭
        new AtlasImage("EQUIP_HAVY000008", 1, 2, this.Width, this.Height), // 콘크리트펌프트럭
        new AtlasImage("EQUIP_HAVY000009", 2, 2, this.Width, this.Height), // 천공기
        new AtlasImage("EQUIP_HAVY000010", 3, 2, this.Width, this.Height), // 로더 
        new AtlasImage("EQUIP_HAVY000011", 4, 2, this.Width, this.Height), // 진동롤러 
        new AtlasImage("EQUIP_HAVY000012", 5, 2, this.Width, this.Height), // 항타기 
        new AtlasImage("EQUIP_HAVY000013", 6, 2, this.Width, this.Height), // 모터그레이더 
        new AtlasImage("EQUIP_HAVY000014", 7, 2, this.Width, this.Height), // 불도저 
        new AtlasImage("EQUIP_HAVY000015", 0, 3, this.Width, this.Height), // 타워크레인 
        new AtlasImage("EQUIP_HAVY000016", 1, 3, this.Width, this.Height), // 건설용리프트
        new AtlasImage("EQUIP_HAVY000017", 2, 3, this.Width, this.Height), // 곤도라
        new AtlasImage("EQUIP_HAVY000018", 3, 3, this.Width, this.Height), // 차량탑재형고소작업대
        new AtlasImage("EQUIP_HAVY000019", 4, 3, this.Width, this.Height), // 시저형고소작업대
        new AtlasImage("EQUIP_HAVY000020", 5, 3, this.Width, this.Height), // 차주식고소작업대
        new AtlasImage("CRANE_GRAY_T", 6, 3, this.Width, this.Height), // 센서1
        new AtlasImage("CRANE_GRAY_L", 7, 3, this.Width, this.Height), // 센서1
        new AtlasImage("AP_GREEN", 0, 4, this.Width, this.Height), // 센서1
        new AtlasImage("AP_RED", 1, 4, this.Width, this.Height), // 센서2
        new AtlasImage("AP_GRAY", 2, 4, this.Width, this.Height), // 센서2
        new AtlasImage("GAS_BLUE", 3, 4, this.Width, this.Height), // 센서3
        new AtlasImage("GAS_RED", 4, 4, this.Width, this.Height), // 센서4
        new AtlasImage("GAS_GRAY", 5, 4, this.Width, this.Height), // 센서4
        new AtlasImage("RETAIN_GREEN", 6, 4, this.Width, this.Height), // 흙막이 
        new AtlasImage("RETAIN_RED", 7, 4, this.Width, this.Height), // 흙막이
        new AtlasImage("RETAIN_GRAY", 0, 5, this.Width, this.Height), // 흙막이 
        new AtlasImage("STRICTURE_GREEN", 1, 5, this.Width, this.Height), // 장비협착  
        new AtlasImage("STRICTURE_RED", 2, 5, this.Width, this.Height), // 장비협착  
        new AtlasImage("STRICTURE_GRAY", 3, 5, this.Width, this.Height), // 장비협착  
        new AtlasImage("EQUIP_HAVY000021", 4, 5, this.Width, this.Height), // 장비ETC
        new AtlasImage("FIRE_GREEN", 5, 5, this.Width, this.Height), // 게이트레드
		new AtlasImage("FIRE_RED", 6, 5, this.Width, this.Height), // 게이트레드
		new AtlasImage("FIRE_GRAY", 7, 5, this.Width, this.Height), // 게이트레드
		new AtlasImage("FIRE_ORANGE", 0, 6, this.Width, this.Height), // 게이트레드
		new AtlasImage("WATER_GREEN", 1, 6, this.Width, this.Height), // 수위그린
		new AtlasImage("WATER_RED", 2, 6, this.Width, this.Height), // 수위레드
		new AtlasImage("WATER_GRAY", 3, 6, this.Width, this.Height), // 게이트레드
		new AtlasImage("WATER_ORANGE", 4, 6, this.Width, this.Height), // 수위오렌지
		new AtlasImage("SUB_GREEN", 5, 6, this.Width, this.Height), // 침수그린
		new AtlasImage("SUB_RED", 6, 6, this.Width, this.Height), // 침수레드
		new AtlasImage("SUB_GRAY", 7, 6, this.Width, this.Height), // 침수레드
		new AtlasImage("GATE_GREEN", 0, 7, this.Width, this.Height), // 게이트그린
		new AtlasImage("GATE_RED", 1, 7, this.Width, this.Height), // 게이트레드
		new AtlasImage("GATE_GRAY", 2, 7, this.Width, this.Height) // 게이트레드
    ];
	
    this.getAtlasImage = function(type) {
    	for(var idx in this.atlasIdxList) {
    		if(this.atlasIdxList[idx].type == type) return this.atlasIdxList[idx];
    	}	
    }    
}



//--------------------------------------------------------------
//
// AtlasImage
//
//--------------------------------------------------------------

function AtlasImage(type, left, top, width, height) {

    this.left = left * width;
    this.top = top * height;
    this.width = width;
    this.height = height;

    this.type = type;
    this.name = "atlasimage1.png";

    this.setPosition_3 = function (left, top, width) {
        this.left = left;
        this.top = top;
        this.width = width;
        this.height = width;
    }

    this.setPosition = function (left, top, width, height) {
        this.left = left;
        this.top = top;
        this.width = width - left;
        this.height = height - top;
    }

    this.setName = function (name) {
        this.name = name;
    }
    this.getType = function () {
        return this.type;
    }

}
