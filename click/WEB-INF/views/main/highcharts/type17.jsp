<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts.js"></script>
	<script type="text/javascript">
		var chartHeight = parseInt("${parameterVO.chartHeight}", 10);
		var iotSensorNameArr = new Array();
		var pmValue1Array = new Array();
		var pmValue2Array = new Array();
		var pmValue3Array = new Array();
		
		$(document).ready(function(){
			fn_init();
		});
	
		function fn_init(){
			$('#process_gubun').val("9");
			// ajax 호출
			var params = $("form[name=dashParameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/dashLocationProcess.json" ,
				type : "POST",
				data: params,
				success : function(result) {
					for(var i=0;i<result.environmentList.length;i++){
						iotSensorNameArr.push('');
						pmValue1Array.push(0);
					}
					$("#enviContainer").css("height", chartHeight);
					fn_draw();
				}
			})
		}
	</script>

<form:form id="dashParameterVO" commandName="dashParameterVO" name="dashParameterVO" action="" method="post">
<input type="hidden" id="process_gubun" name="process_gubun" value="">
</form:form>
<div id="enviContainer"></div>
<style>
.highcharts-figure, .highcharts-data-table table {
    min-width: 310px; 
    max-width: 800px;
    margin: 1em auto;
}

#container {
    height: 140px;
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
function fn_draw(){
	Highcharts.chart('enviContainer', {
	    chart: {
	        type: 'column'
	    },
	    title: {
	        text: null
	    },
	    xAxis: {
	        categories: iotSensorNameArr
	    },
	    yAxis: {
	        min: 0,
	        title: {
	            text: null
	        }
	    },
	    plotOptions: {
	        column: {
	            pointPadding: 0.2,
	            borderWidth: 0,
	            dataLabels: {
	                enabled: true
	            }
	        }
	    } ,
	    series: [
	    	{ 
	    		name : '' ,
	    		data : pmValue1Array
	    	}
	    ]
	});
}
</script>