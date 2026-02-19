<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts.js"></script>
	<script type="text/javascript">
		var chartHeight = parseInt("${parameterVO.chartHeight}", 10);
		var workerNewCount = 0;
		var workerSeniorCount = 0;
		var workerNationalityCount = 0;
		var myArray = new Array(); 
		
		$(document).ready(function(){
			fn_init();
		});
	
		function fn_init(){
			$('#process_gubun').val("2");
			
			// ajax 호출
			var params = $("form[name=dashParameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/dashLocationProcess.json" ,
				type : "POST",
				data: params,
				success : function(result) {
					var callCount = parseInt('${parameterVO.call_count}');
					workerNewCount = result.workerVO.new_count;
					workerSeniorCount = result.workerVO.senior_count;
					workerNationalityCount = result.workerVO.nationality_count;
					myArray.push(parseInt(workerNewCount));
					myArray.push(parseInt(workerSeniorCount));
					myArray.push(parseInt(workerNationalityCount));
					fn_drawChart();
				}
			})
		}
	</script>

<form:form id="dashParameterVO" commandName="dashParameterVO" name="dashParameterVO" action="" method="post">
<input type="hidden" id="type_id" name="type_id" value="${dashList.type_id}">
<input type="hidden" id="dash_id" name="dash_id" value="${dashList.dash_id}">
<input type="hidden" id="sel_frame_id" name="sel_frame_id" value="">
<input type="hidden" id="dash_yn" name="dash_yn" value="Y">
<input type="hidden" id="process_gubun" name="process_gubun" value="">
</form:form>
<div id="container2"></div>



<style>
.highcharts-figure, .highcharts-data-table table {
    min-width: 100px; 
    max-width: 300px;
    margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 100px;
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
.highcharts-legend{
	display : none;
}
.highcharts-background{
	height: 100%;
}
.highcharts-plot-background{
	height : 100%;
}
</style>

<script type="text/javascript">
function fn_drawChart(){
	chart = new Highcharts.chart('container2', {
	    chart: {
	        type: 'column'
	    },
	    title: {
	        text: null
	    },
	    xAxis: {
	        categories: ['<spring:message code="click.new"/>','<spring:message code="click.the.elderly"/>','<spring:message code="click.foreigner"/>']
	    },
	    yAxis: {
	        min: 0,
	        max: null,
	        title: {
	            text: null
	        }
	    },
	    legend: {
	        align: 'center',
	        verticalAlign: 'top',
	        floating: true,
	        backgroundColor:
	            Highcharts.defaultOptions.legend.backgroundColor || 'white',
	        borderColor: '#CCC',
	        borderWidth: 1,
	        shadow: false
	    },
	    plotOptions: {
	        column: {
	            stacking: 'normal',
	            dataLabels: {
	                enabled: true
	            }
	        }
	    },
	    series: [{
	    	type: 'column',
	    	name: '',
	        colorByPoint: true,
	        data: myArray,
	        showInLegend: false
	    }]
	});
}

</script>