//--------------------------------------------------------------
//
// AirTag
//
//--------------------------------------------------------------
function AirTag(airTagId) {
	this.airTagId = airTagId;
	this.poiId;
	this.AirtagType;   //AIRTAG_TYPE: WORKER,CRANE,GAS,AP,EQUIP,VISIT,STRICTURE,CCTV,SENSOR,ANEMOMETER
	this.TagTypeId; //AIRTAG_TYPE ID: 동일 AIRTAG_TYPE을 구분하기 위한 구분자. 
	this.apId;
	this.x;
	this.y;
	this.z;
	this.Background;
	this.Text;
	this.ExtraText;
	this.TextColor;
	this.TextSize;
	this.TextTopMargin;
	this.TextLeftMargin;
	this.TextExtraMargin; //태그별 마진을 미세 조정 하기위해 사용. 
	
	this.Visible = "true";
	this.Type;

	this.create = function () {
		createAirTag(this.airTagId);
	}

	this.getId = function () {
		return this.airTagId;
	}
	this.setPoiID = function (poiId) {
		this.poiId = poiId;
	}
	this.getPoiID = function () {
		return this.poiId;
	}
	this.setApID = function (apId) {
		this.apId = apId;
	}
	this.getApID = function () {
		return this.apId;
	}
	this.setAirtagType = function(airTagType) {
		this.AirtagType = airTagType;
	}
	
	this.getAirtagType = function() {
		return this.AirtagType;
	}
	
	this.setTagTypeId = function(tagTypeId) {
		this.TagTypeId = tagTypeId;
	}
	
	this.getTagTypeId = function() {
		return this.TagTypeId;
	}
		
	this.setPosition = function (x, y, z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}
	this.getX = function () {
		return this.x;
	}
	this.getY = function () {
		return this.y;
	}
	this.getZ = function () {
		return this.z;
	}
	this.setBackground = function (background) {
		this.Background = background;
		console.log("background=" + background);
	}
	
	this.getBackground = function () {
		return this.Background;
	}
	
	this.setText = function (text) {
		this.Text = text;
	}
	
	this.getText = function () {
		return this.Text;
	}
	
	this.setExtraText = function (extraText) {
		this.ExtraText = extraText;
	}
	
	this.getExtraText = function () {
		return this.ExtraText;
	}


	this.setTextColor = function (text_color) {
		this.TextColor = text_color;
	}
	this.setTextSize = function (text_size) {
		this.TextSize = text_size;
	}
	this.setTextTopMargin = function (text_topMargin) {
		this.TextTopMargin = text_topMargin;
	}
	this.setTextLeftMargin = function (text_leftMargin) {
		this.TextLeftMargin = text_leftMargin;
	}
	this.setTextExtraMargin = function (text_ExtraMargin) {
		this.TextExtraMargin = text_ExtraMargin;
	}
	this.getTextExtraMargin = function () {
		return this.TextExtraMargin;
	}
	
	this.setVisible = function (visible) {
		this.Visible = visible;
	}
	this.setType = function (Type) {
		this.Type = Type;
	}
	this.show = function () {

		console.log('@@@@show  this.poiId : '+this.poiId);
		console.log('@@@@show  this.y : '+this.y);
		
		if(this.poiId == undefined || this.poiId == null || this.poiId == '') {
			setAirTagPosition(this.airTagId, this.x, this.y, this.z);
		}
		else {
			//setAirTagPosition(this.airTagId, this.x, this.y, this.z);
			if('CRANE' == this.AirtagType) {
				setAirTagPosition(this.airTagId, this.x, this.y, this.z);
			} else {
				setAirTagPositionByPoiId(this.airTagId, this.poiId);
			}
		}
		

		if (this.Background) {
			setAirTagBgImage(this.airTagId, this.Background.name, this.Background.left, this.Background.top, this.Background.width, this.Background.height);
		}
		setAirTagText(this.airTagId, this.Text, this.TextLeftMargin, this.TextTopMargin, this.TextColor, this.TextSize);
		setAirTagAnchorType(this.airTagId, "bottom");
		setAirTagViewType(this.airTagId, "2d");
		setAirTagVisible(this.airTagId, this.Visible);

	}
	this.update = function(isMove) {
		console.log('@@@@update  this.poiId : '+this.poiId);
		console.log('@@@@update  this.y : '+this.y);
		if(isMove) {
			setAirTagPosition(this.airTagId, this.x, this.y, this.z);
			//setAirTagPositionByPoiId(this.airTagId, this.poiId);
		}
		if (this.Background) {
			setAirTagBgImage(this.airTagId, this.Background.name, this.Background.left, this.Background.top, this.Background.width, this.Background.height);
		}
		setAirTagText(this.airTagId, this.Text, this.TextLeftMargin, this.TextTopMargin, this.TextColor, this.TextSize);
		setAirTagAnchorType(this.airTagId, "bottom");
		setAirTagViewType(this.airTagId, "2d");
		setAirTagVisible(this.airTagId, this.Visible);
	}

	this.setTextEx = function (text) {
		this.Text = text;
		setAirTagText(this.airTagId, this.Text, this.TextLeftMargin, this.TextTopMargin, this.TextColor, this.TextSize);
	}
	
	this.setBackgroundEx = function (background) {
		
		this.Background = background;
		setAirTagBgImage(this.airTagId, this.Background.name, this.Background.left, this.Background.top, this.Background.width, this.Background.height);
	}

	this.destroy = function () {
		deleteAirTag(this.airTagId);
	}
}