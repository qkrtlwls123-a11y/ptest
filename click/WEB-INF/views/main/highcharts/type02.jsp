<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var chartHeight = parseInt("${parameterVO.chartHeight}", 10);
/* var pmOneThreshold = parseInt("${parameterVO.pm_one_threshold}", 10);
var pmTwohalfThreshold = parseInt("${parameterVO.pm_twohalf_threshold}", 10);
var pmTenThreshold = parseInt("${parameterVO.pm_ten_threshold}", 10); */
var pmOneThreshold = 0;
var pmTwohalfThreshold = 0;
var pmTenThreshold = 0;
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highchartsData.js"></script>

<form:form id="parameterVO" commandName="parameterVO" name="parameterVO" action="" method="post">
<input type="hidden" id="charNo" name="charNo" value="2"/>
<input type="hidden" id="notUsePage" name="notUsePage" value="Y"/>
<input type="hidden" id="search_sensor_type" name="search_sensor_type" value="2"/>
<input type="hidden" id="search_sensor_detail_type" name="search_sensor_detail_type" value=""/>
<input type="hidden" id="search_date_type" name="search_date_type" value="DAY_HOUR" />
<input type="hidden" id="day_hour" name="day_hour" value="-24"/>
<input type="hidden" id="month" name="month" value=""/>
<input type="hidden" id="skp_sensor_id" name="skp_sensor_id" value="${parameterVO.skp_sensor_id}"/>
<input type="hidden" id="skp_device_id" name="skp_device_id" value="${parameterVO.skp_device_id}"/>
</form:form>

<div id="container" style="padding-top: 80px;"></div>

<style>
.highcharts-figure, .highcharts-data-table table {
    min-width: 310px; 
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
var pmOneData = new Array();
var pmTwohalfData = new Array();
var pmTenData = new Array();

var dateValue = "";
var dateY = 0;
var dateM = 0;
var dateD = 0;
var timeH = 0;
var timeI = 0;
var threshold = 0; // 임계치
var MaxdateValue = "";
var MaxdateY = 0;
var MaxdateM = 0;
var MaxdateD = 0;
var MaxtimeH = 0;
var MaxtimeI = 0;
var threshold = 0;
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
	        	for(var i=0;i<result.resultList1.length;i++){
	        		// PM1.0 Data
	        		if(0==i){
	        			dateValue = result.resultList1[i].time_observation;
						dateY = parseInt(dateValue.substring(0, 4), 10);
						dateM = parseInt(dateValue.substring(4, 6), 10)-1;
						dateD = parseInt(dateValue.substring(6, 8), 10);
						timeH = parseInt(dateValue.substring(8, 10), 10);
						timeI = parseInt(dateValue.substring(10, 12), 10);
	        		}
	        		if(result.resultList1.length==(i+1)){
	        			MaxdateValue = result.resultList1[i].time_observation;
	        			MaxdateY = parseInt(MaxdateValue.substring(0, 4), 10);
	        			MaxdateM = parseInt(MaxdateValue.substring(4, 6), 10)-1;
	        			MaxdateD = parseInt(MaxdateValue.substring(6, 8), 10);
	        			MaxtimeH = parseInt(MaxdateValue.substring(8, 10), 10);
	        			MaxtimeI = parseInt(MaxdateValue.substring(10, 12), 10);
	        		}
	        		// PM1.0 Data
	        		if( result.resultList1[i].value != "null" ){
		        		pmOneData.push(parseFloat(result.resultList1[i].value));
	        		}else{
		        		pmOneData.push(null);
	        		}
	        	}
	        	for(var i=0;i<result.resultList2.length;i++){
	        		// PM2.5 Data
	        		if( result.resultList2[i].value != "null" ){
		        		pmTwohalfData.push(parseFloat(result.resultList2[i].value));
	        		}else{
		        		pmTwohalfData.push(null);
	        		}
	        	}
	        	for(var i=0;i<result.resultList3.length;i++){
	        		// PM10 Data
	        		if( result.resultList3[i].value != "null" ){
		        		pmTenData.push(parseFloat(result.resultList3[i].value));
	        		}else{
		        		pmTenData.push(null);
	        		}
	        	}
	        	
	        	if(result.resultList1_THRESHOLD != null && result.resultList1_THRESHOLD.length > 0 ){
		        	pmOneThreshold 		= result.resultList1_THRESHOLD[0].threshold;
	        	}
	        	if(result.resultList2_THRESHOLD != null && result.resultList2_THRESHOLD.length > 0){
		        	pmTwohalfThreshold 	= result.resultList2_THRESHOLD[0].threshold;
	        	}
	        	if(result.resultList3_THRESHOLD != null && result.resultList3_THRESHOLD.length > 0){
		        	pmTenThreshold 		= result.resultList3_THRESHOLD[0].threshold;
	        	}
	        	fn_drawChart();
	        }else{
	            openDefaultPopup("loginPopup", result.message);
	        }
		}
	});
}

function fn_drawChart(){
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
		    tickInterval : (2 * 3600 * 1000),
	        labels: {
	            overflow: 'justify'
	        }
		},
	    yAxis: {
	        title: {
	            text: ' '
	        },
	        minorGridLineWidth: 3,
	        gridLineWidth: 0,
	        alternateGridColor: null,
	        plotBands: [{
	            from: pmOneThreshold,
	            to: pmOneThreshold,
	            color: 'rgba(192 , 36 , 37 , 0.3)',
	            label: {
	                text: 'PM1.0 '+'<spring:message code="click.critical.value"/>',
	                style: {
	                    color: 'rgba(192 , 36 , 37 , 1)',
	                    fontWeight : 'bolder'
	                }
	            }
	            , gridZIndex: 7
	            , zIndex : 7
	            , connectNulls : true
	        },{
	            from: pmTwohalfThreshold,
	            to: pmTwohalfThreshold,
	            color: 'rgba(192 , 36 , 37 , 0.3)',
	            label: {
	                text: 'PM2.5 '+'<spring:message code="click.critical.value"/>',
	                style: {
	                    color: 'rgba(192 , 36 , 37 , 1)',
	                    fontWeight : 'bolder'
	                }
	            }
	            , gridZIndex: 7
	            , zIndex : 7
	            , connectNulls : true
	        },{
	            from: pmTenThreshold,
	            to: pmTenThreshold,
	            color: 'rgba(192 , 36 , 37 , 0.3)',
	            label: {
	                text: 'PM10 '+'<spring:message code="click.critical.value"/>',
	                style: {
	                    color: 'rgba(192 , 36 , 37 , 1)',
	                    fontWeight : 'bolder'
	                }
	            }
	            , gridZIndex: 7
	            , zIndex : 7
	            , connectNulls : true
	        }]
	    },
	    tooltip: {
	        valueSuffix: ' μg/㎥'
	    },
	    plotOptions: {
	        spline: {
	            lineWidth: 1,
	            states: {
	                hover: {
	                    lineWidth: 4
	                }
	            },
	            marker: {
	                enabled: false
	            }
	            //, pointStart: Date.UTC(dateY, dateM, dateD, timeH, timeI)
	            //, pointInterval: 60000
	            //, pointInterval: (2 * 3600 * 1000)
	            //, pointRange: 2 * 3600 * 1000
	            //, tickInterval : (2 * 3600 * 1000)
		        , connectNulls : true
	        } ,
	    },
	    series: [{
	        name: 'PM1.0',
	        data: pmOneData
	        , zIndex: 5
            , pointStart: Date.UTC(dateY, dateM, dateD, timeH, timeI)
            , pointInterval: 60000
            , connectNulls : true
	    }, {
	        name: 'PM2.5',
	        data: pmTwohalfData
	        , zIndex: 5
            , pointStart: Date.UTC(dateY, dateM, dateD, timeH, timeI)
            , pointInterval: 60000
            , connectNulls : true
	    }, {
	        name: 'PM10',
	        data: pmTenData
	        , zIndex: 5
            , pointStart: Date.UTC(dateY, dateM, dateD, timeH, timeI)
            , pointInterval: 60000
            , connectNulls : true
	    }],
	    navigation: {
	        menuItemStyle: {
	            fontSize: '10px'
	        }
	    }
	});
}
</script>