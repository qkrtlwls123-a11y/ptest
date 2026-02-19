/**
@file ChartHelper.js
@date 2021/01/14
@author sykim (johnnyf.kim@sgsone.com)
@version 1.0
@brief 차트 제어 관련 
*/

includeJs("/click/resources/js/HashMap.js");

function ChartHelper() {
	
    this.chartMap = new HashMap();
    this.multiTextMap = new HashMap();
    	
    this.get = function (chartId) {
    	return this.chartMap.get(chartId);
    }
    
    this.put = function (chartId, item) {
    	this.chartMap.put(chartId, item);
    }

    this.clear = function (chartId) {
    	this.chartMap.remove(chartId);
    }
    
    this.putMultiText = function (code, text) {
    	this.multiTextMap.put(code, text);
    }
    
    this.getMultiText = function (code) {
    	return this.multiTextMap.get(code);
    }

    
    this.getPlotBand = function (warring, danger, maxVal) {
		
		return {plotBands : [
			{
				id : 'plotBandWarning',
				from : parseInt(warring),
				to : parseInt(danger),
				color : 'rgba(223 , 126 , 55 , 0.3)',
				label : {
					text : this.getMultiText("click.caution.level"),
					style : {
						color : 'rgba(223 , 126 , 55 , 1)',
						fontWeight : 'normal'
					}
				}
			},
			{
				from : parseInt(danger),
				to : parseInt(maxVal),
				color : 'rgba(192 , 36 , 37 , 0.3)',
				label : {
					text : this.getMultiText("click.danger.level"),
					style : {
						color : 'rgba(192 , 36 , 37 , 1)',
						fontWeight : 'normal'
					}
				}
			} ]
		}
	}

    

    this.replacePlotBand = function (axis, id, replacement) {
      axis.removePlotBand(id);
      axis.addPlotBand(replacement);
    }
}