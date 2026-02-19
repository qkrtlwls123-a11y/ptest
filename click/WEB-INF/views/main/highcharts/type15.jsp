<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/highcharts-more.js"></script>
	<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="https://code.highcharts.com/modules/export-data.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>
	<script type="text/javascript">
		var chartHeight = parseInt("${parameterVO.chartHeight}", 10);
		var gasType = parseInt("${parameterVO.gas_type}");
		var gasValue = parseFloat("${parameterVO.gas_value}");
		var status = '${parameterVO.status}';
		var colortype = 7;
		var gasUnit = "%";
		$(document).ready(function(){
			$("#container").css("height", chartHeight);
			if(gasType == 1){
				gasUnit = "%";
				//gasValue = gasValue.toFixed(1);
			}else if(gasType == 2){
				gasUnit = "ppm";
				//gasValue = gasValue.toFixed(1);
			}else if(gasType == 3){
				gasUnit = "ppm";
				//gasValue = gasValue.toFixed(1);
			}else if(gasType == 4){
				gasUnit = "%";
				//gasValue = gasValue.toFixed(1);
			}
			if(status != 'S'){
				colortype = 8;
			}
			fn_draw();
		});
	</script>

<form:form id="dashParameterVO" commandName="dashParameterVO" name="dashParameterVO" action="" method="post">
<input type="hidden" id="process_gubun" name="process_gubun" value="">
</form:form>
<div id="container" style="width:100%;"></div>
<style>
#container {
  height: 130px; 
}

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
</style>


<script type="text/javascript">
function fn_draw(){
	Highcharts.chart('container', {

	    chart: {
	        type: 'solidgauge',
	        height: '60%',
	    },

	    title: {
	        text: null
	    },
	    
	    tooltip: {
	        enabled: false
	    },

	    pane: {
	        startAngle: 0,
	        endAngle: 360,
	        background: [{ // Track for Move
	            outerRadius: '112%',
	            innerRadius: '88%',
	            backgroundColor: Highcharts.color(Highcharts.getOptions().colors[7])
	                .setOpacity(0.3)
	                .get(),
	            borderWidth: 0
	        }]
	    },

	    yAxis: {
	        min: 0,
	        max: 100,
	        lineWidth: 0,
	        tickPositions: []
	    },

	    plotOptions: {
	        solidgauge: {
	            dataLabels: {
	            	borderWidth: 0,
	                enabled: true,
	                style: {
			            fontSize: '16px'
			        },
	    			position : "center",
	    			verticalAlign: 'middle',
	    			format: '{y} '+gasUnit
	            },
	            linecap: 'round',
	            stickyTracking: false,
	            rounded: true
	        }
	    },
	    
	    credits: {
	        enabled: false
	    },
	    
	    exporting: { enabled: false },

	    series: [{
	        name: '',
	        data: [{
	            color: Highcharts.getOptions().colors[colortype],
	            radius: '112%',
	            innerRadius: '88%',
	            y: gasValue
	        }]
	    }]
	});
}
</script>