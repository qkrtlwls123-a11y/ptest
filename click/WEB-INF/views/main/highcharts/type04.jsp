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
<input type="hidden" id="charNo" name="charNo" value="1"/>
<input type="hidden" id="notUsePage" name="notUsePage" value="Y"/>
<input type="hidden" id="search_sensor_type" name="search_sensor_type" value="1"/>
<input type="hidden" id="search_sensor_detail_type" name="search_sensor_detail_type" value="1"/>
<input type="hidden" id="search_date_type" name="search_date_type" value="DAY_HOUR" />
<input type="hidden" id="day_hour" name="day_hour" value="-12"/>
<input type="hidden" id="month" name="month" value=""/>
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
var temperatureTcData = new Array();
var humidityData = new Array();
var dateValue = "";
var dateY = 0;
var dateM = 0;
var dateD = 0;
var timeH = 0;
var timeI = 0;

var MaxdateValue = "";
var MaxdateY = 0;
var MaxdateM = 0;
var MaxdateD = 0;
var MaxtimeH = 0;
var MaxtimeI = 0;
var threshold = 1000;

$(document).ready(function(e) {
	fn_searchChartData();
	//fn_drawChart();
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
		        	//for(var i=0; i<result.totalCnt;i++){
		        	for(var i=0; i<result.resultList.length;i++){
		        		if(0==i){
		        			dateValue = result.resultList[i].time_observation;
							dateY = parseInt(dateValue.substring(0, 4), 10);
							dateM = parseInt(dateValue.substring(4, 6), 10)-1;
							dateD = parseInt(dateValue.substring(6, 8), 10);
							timeH = parseInt(dateValue.substring(8, 10), 10);
							timeI = parseInt(dateValue.substring(10, 12), 10);
		        		}
		        		
		        		if((i+1)==result.resultList.length){
		        			MaxdateValue = result.resultList[i].time_observation;
		        			MaxdateY = parseInt(MaxdateValue.substring(0, 4), 10);
		        			MaxdateM = parseInt(MaxdateValue.substring(4, 6), 10)-1;
		        			MaxdateD = parseInt(MaxdateValue.substring(6, 8), 10);
		        			MaxtimeH = parseInt(MaxdateValue.substring(8, 10), 10);
		        			MaxtimeI = parseInt(MaxdateValue.substring(10, 12), 10);
		        		}
		        		
		        		if( result.resultList[i].humidity != "null" ){
			        		humidityData.push(parseFloat(result.resultList[i].humidity));
		        		}else{
		        			humidityData.push(null);
		        		}
		        		
		        		if( result.resultList[i].temperature_tc != "null" ){
			        		temperatureTcData.push(parseFloat(result.resultList[i].temperature_tc));
		        		}else{
			        		temperatureTcData.push(null);
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
	    colors: ['#0072ff', '#2ad890']
	});
	Highcharts.chart('container', {
		  chart: {
		    zoomType: 'xy'
		  },
		  title: {
		    text: null
		  },
		  subtitle: {
		    text: null
		  },
		  xAxis: {
			    type: 'datetime',
			    minPadding: 0,
			    maxPadding: 0,
			    min : Date.UTC(dateY, dateM, dateD, timeH , timeI),
			    max : Date.UTC(MaxdateY,MaxdateM, MaxdateD , MaxtimeH ,MaxtimeI),
			    tickInterval: 3600 * 1000,
			  },
		  yAxis: [{ // Primary yAxis
		    labels: {
		      format: '{value} %',
		      style: {
		        color: Highcharts.getOptions().colors[1]
		      }
		    },
		    title: {
		      text: null,
		      style: {
		        color: Highcharts.getOptions().colors[1]
		      }
		    }
		    , opposite: true
		  }, { // Secondary yAxis
		    title: {
		      text: null,
		      style: {
		        color: Highcharts.getOptions().colors[0]
		      }
		    },
		    labels: {
		      format: '{value} °C',
		      style: {
		        color: Highcharts.getOptions().colors[0]
		      }
		    }
		  }],
          legend: {
              enabled: false
            },
		  tooltip: {
		    shared: true
		  },
		  series: [
		  {
				name : '<spring:message code="click.temperature"/> '  ,
			    type: 'spline' ,
			    yAxis: 1,
			    data: temperatureTcData,
			    tooltip: {
			        valueSuffix: '°C'
			      },
				marker: {
				    enabled: false
				}
			    , pointStart: Date.UTC(dateY, dateM, dateD, timeH , timeI)
			    , pointInterval: 60000
			    , connectNulls : true
		  } ,
		  {
				name : '<spring:message code="click.humidity"/> ' ,
			    type: 'spline' ,
			    data: humidityData ,
			    tooltip: {
			        valueSuffix: '%' 
			      },
				marker: {
				    enabled: false
				}
			    , pointStart: Date.UTC(dateY, dateM, dateD, timeH , timeI)
			    , pointInterval: 60000
			    , connectNulls : true
		  }
		  ]
		});

}
</script>