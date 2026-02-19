<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts.js"></script>
	<script type="text/javascript">
		var chartHeight = parseInt("${parameterVO.chartHeight}", 10);
		var eventArray = new Array();
		var pieColors = (function () {
		var colors = [],
		    base = Highcharts.getOptions().colors[0],i;
		
		  for (i = 0; i < 10; i += 1) {
		    colors.push(Highcharts.color(base).brighten((i - 3) / 7).get());
		  }
		  return colors;
		}());
		$(document).ready(function(){
			fn_init();
		});

		function fn_init(){
			$('#process_gubun').val("16");
			// ajax 호출
			var params = $("form[name=dashParameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/dashEventProcess.json" ,
				type : "POST",
				data: params,
				success : function(result) {
					if(result.resultCode == "success"){
						var noAction = '';
						var required = '';
						var completed = '';
						
						if('en' == '${locale}'){
							noAction = 'No Action';
							required = 'Action Required';
							completed = 'Action Completed';
						}else{
							noAction = '미조치';
							required = '조치필요';
							completed = '조치완료';
						}
						
						
						var event0 = { name : noAction, y : parseInt(result.eventVO.event0)};
						eventArray.push(event0);
						var event1 = { name : required, y : parseInt(result.eventVO.event1)};
						eventArray.push(event1);
						var event2 = { name : completed, y : parseInt(result.eventVO.event2)};
						eventArray.push(event2);
						fn_draw();
					}
				}
			})
		}
	</script>

<form:form id="dashParameterVO" commandName="dashParameterVO" name="dashParameterVO" action="" method="post">
<input type="hidden" id="process_gubun" name="process_gubun" value="">
</form:form>
<div id="container"></div>
<style>
#container {
  height: 120px; 
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
	    	plotBackgroundColor: null,
    	    plotBorderWidth: null,
    	    plotShadow: false,
    	    type: 'pie'
	    },
	    title: {
	        text: null
	    },
	    accessibility: {
	        point: {
	            valueSuffix: '%'
	        }
	    },
	    plotOptions: {
	        pie: {
	            allowPointSelect: true,
	            cursor: 'pointer',
	            colors: pieColors,
	            depth: 0,
	            dataLabels: {
	            	enabled: true,
	                format: '{point.name}:<b>{point.y}</b>',
	                distance: 0
	            }
	        }
	    },
	    series: [{
	        type: 'pie',
	        name: '',
	        data: eventArray
	    }]
	});
}
</script>