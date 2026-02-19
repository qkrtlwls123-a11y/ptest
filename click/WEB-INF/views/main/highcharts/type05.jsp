<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var chartHeight = parseInt("${parameterVO.chartHeight}", 10);
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highchartsData.js"></script>

<form:form id="parameterVO" commandName="parameterVO" name="parameterVO" action="" method="post">
<input type="hidden" id="charNo" name="charNo" value="3}"/>
<input type="hidden" id="notUsePage" name="notUsePage" value="Y"/>
<input type="hidden" id="search_sensor_type" name="search_sensor_type" value="1"/>
<input type="hidden" id="search_sensor_detail_type" name="search_sensor_detail_type" value="3"/>
<input type="hidden" id="search_date_type" name="search_date_type" value="DAY_HOUR" />
<input type="hidden" id="day_hour" name="day_hour" value="-24"/>
<input type="hidden" id="month" name="month" value=""/>
</form:form>
		
<div id="container" style="padding-top: 80px;"></div>

<style>
.highcharts-figure, .highcharts-data-table table {
    min-width: 360px; 
    max-width: 800px;
    margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}
.highcharts-credits {
    display: none;
}
</style>

<script type="text/javascript">
var data = new Array();
var dateValue = "";
var dateY = 0;
var dateM = 0;
var dateD = 0;
var timeH = 0;
var timeI = 0;
var threshold = 1000; // 임계치
var MaxdateValue = "";
var MaxdateY = 0;
var MaxdateM = 0;
var MaxdateD = 0;
var MaxtimeH = 0;
var MaxtimeI = 0;
var threshold = 1000;
$(document).ready(function(e) {
	fn_searchChartData();
});

function fn_searchChartData(){

	var params = $("form[name=parameterVO]").serialize(); 
	$.ajax({
		url : "${pageContext.request.contextPath}/selectSkpCollectList.json",
		type : "POST",
		data: params,
		success : function(result) {
			if(result.resultCode == "success"){
				if(0 < result.totalCnt){
		        	//for(var i=0; i<result.totalCnt; i++){
		        	for(var i=0; i<result.resultList.length;i++){
		        		if(0 ==i){
		        			dateValue = result.resultList[i].time_observation;
							dateY = parseInt(dateValue.substring(0, 4), 10);
							dateM = parseInt(dateValue.substring(4, 6), 10)-1;
							dateD = parseInt(dateValue.substring(6, 8), 10);
							timeH = parseInt(dateValue.substring(8, 10), 10);
							timeI = parseInt(dateValue.substring(10, 12), 10);
		        		}
		        		if(result.resultList.length==(i+1)){
		        			MaxdateValue = result.resultList[i].time_observation;
		        			MaxdateY = parseInt(MaxdateValue.substring(0, 4), 10);
		        			MaxdateM = parseInt(MaxdateValue.substring(4, 6), 10)-1;
		        			MaxdateD = parseInt(MaxdateValue.substring(6, 8), 10);
		        			MaxtimeH = parseInt(MaxdateValue.substring(8, 10), 10);
		        			MaxtimeI = parseInt(MaxdateValue.substring(10, 12), 10);
		        		}
		        		
		        		if( result.resultList[i].wind_wspd != "null" ){
			        		data.push(parseFloat(result.resultList[i].wind_wspd));
		        		}else{
			        		data.push(null);
		        		}
		        	}
		        	// threshold = result.resultList[0].threshold;
		        	fn_drawChart();
				}
	        }else{
	            openDefaultPopup("loginPopup", result.message);
	        }
		}
	});
}
function fn_drawChart(){
	Highcharts.setOptions({
	    colors: ['#973ecf']
	});
	
	Highcharts.chart('container', {
	    chart: {
	        type: 'spline',
	    },
	    title: {
	        text: '',
	        align: 'left'
	    },
	    subtitle: {
	        text: '',
	        align: 'left'
	    },
	  	xAxis: {
		    type: 'datetime',
		    minPadding: 0,
		    maxPadding: 0,
		    min : Date.UTC(dateY, dateM, dateD, timeH , timeI),
		    max : Date.UTC(MaxdateY,MaxdateM, MaxdateD , MaxtimeH ,MaxtimeI),
		    tickInterval : (2 * 3600 * 1000)
		    , gridZIndex: 5
		},
	    /*
	    xAxis: {
	        type: 'datetime',
	        labels: {
	            overflow: 'justify'
				 , formatter: function () {
	                var label = this.axis.defaultLabelFormatter.call(this);
	                return label.substring(0,2) + 'h';
	            }
	        }
	    },
	    */
        yAxis: {
            title: {
              text: null
            },
    	  	labels: {
    			format: '{value} m/s'
    	    },
	        plotBands: [{
	            from: threshold,
	            to: 100.0,
	            color: 'rgba(192 , 36 , 37 , 0.3)',
	            label: {
	                text: '<spring:message code="click.danger.level"/>',
	                style: {
	                    color: 'rgba(192 , 36 , 37 , 1)',
	                    fontWeight : 'bolder'
	                }
	            }
     	        , gridZIndex: 7
     	        , zIndex : 7
	        }
	        ]
          },
          legend: {
              enabled: false
            },
	    tooltip: {
	        valueSuffix: ' m/s'
	    },
	    plotOptions: {
	        spline: {
	            lineWidth: 1,
	            states: {
	                hover: {
	                    lineWidth: 1
	                }
	            },
	            marker: {
	                enabled: false
	            }
	            , pointStart: Date.UTC(dateY, dateM, dateD, timeH, timeI)
	            , pointInterval: 60000
	            , gridZIndex: 4
	            , zIndex : 4
	            , connectNulls : true
	        }
	    },
	    series: [{
	        name: '<spring:message code="click.wind.speed"/> ',
	        data: data,
	        zIndex: 5
	    }],
	    navigation: {
	        menuItemStyle: {
	            fontSize: '10px'
	        }
	    }
	});
}
</script>