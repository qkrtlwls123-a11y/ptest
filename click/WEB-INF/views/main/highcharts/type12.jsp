<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts.js"></script>
	<script type="text/javascript">
		var chartHeight = parseInt("${parameterVO.chartHeight}", 10);
		var VibrationThreshold1 = 0;
		var VibrationThreshold2 = 0;
		var danger1 = '';
		var danger2 = '';
		var no1 = '';
		var no2 = '';
		var no3 = '';
		var no4 = '';
		var no5 = '';
		
		if('en' == '${locale}'){
			danger1 = 'Danger Level 1';
			danger2 = 'Danger Level 2';
			no1 = 'No. 1';
			no2 = 'No. 2';
			no3 = 'No. 3';
			no4 = 'No. 4';
			no5 = 'No. 5';
		}else{
			danger1 = '1번 위험단계';
			danger2 = '2번 위험단계';
			no1 = '1번';
			no2 = '2번';
			no3 = '3번';
			no4 = '4번';
			no5 = '5번';
		}
		
		
		$(document).ready(function(){
			fn_init();
		});

		function fn_init(){
			$('#process_gubun').val("4");
			// ajax 호출
			var params = $("form[name=dashParameterVO]").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/selectVibrationGraph.json" ,
				type : "POST",
				data: params,
				success : function(result) {
					var tmpArray = new Array();
					VibrationThreshold1 = Number(result.resultList[0].threshold);
					VibrationThreshold2 = Number(result.resultList[1].threshold);
					fn_draw();
				}
			})
		}
	</script>

<form:form id="dashParameterVO" commandName="dashParameterVO" name="dashParameterVO" action="" method="post">
<input type="hidden" id="process_gubun" name="process_gubun" value="">
</form:form>
<div id="container"></div>
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

</style>


<script type="text/javascript">
function fn_draw(){
	Highcharts.chart('container', {

	    title: {
	        text: null
	    },

	    subtitle: {
	        text: null
	    },

	    yAxis: {
	        title: {
	            text: null
	        },
    	  	labels: {
    			format: '{value} db'
    	    },
	        plotBands: [{
	            from: VibrationThreshold1,
	            to: VibrationThreshold1,
	            color: 'rgba(192 , 36 , 37 , 0.3)',
	            label: {
	                text: danger1,
	                style: {
	                    color: 'rgba(192 , 36 , 37 , 1)',
	                    fontWeight : 'bolder'
	                }
	            }
	        },{
	            from: VibrationThreshold2,
	            to: VibrationThreshold2,
	            color: 'rgba(192 , 36 , 37 , 0.3)',
	            label: {
	                text: danger2,
	                style: {
	                    color: 'rgba(192 , 36 , 37 , 1)',
	                    fontWeight : 'bolder'
	                }
	            }
	        }
	        ]
	    },

	    xAxis: {
	        accessibility: {
	            rangeDescription: null
	        }
	    },

	    legend: {
	        layout: 'vertical',
	        align: 'right',
	        verticalAlign: 'middle'
	    },

	    plotOptions: {
	        series: {
	            label: {
	                connectorAllowed: false
	            },
	            pointStart: 2020
	        }
	    },

	    series: [{
	        name: no1,
	        data: [15, 8, 12, 6,61]
	    }, {
	        name: no2,
	        data: [25, 32, 13, 5,59]
	    }, {
	        name: no3,
	        data: [20, 41, 16, 2,45]
	    }, {
	        name: no4,
	        data: [17, 6, 14, 4,38]
	    }, {
	        name: no5,
	        data: [16, 10, 15, 7,66]
	    }],

	    responsive: {
	        rules: [{
	            condition: {
	                maxWidth: 500
	            },
	            chartOptions: {
	                legend: {
	                    layout: 'horizontal',
	                    align: 'center',
	                    verticalAlign: 'bottom'
	                }
	            }
	        }]
	    }

	});
}
</script>