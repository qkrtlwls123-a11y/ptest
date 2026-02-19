<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/util.js"></script>
<script type="text/javascript">
var chartHeight = parseInt("${parameterVO.chartHeight}", 10);
var sectionArray = new Array();
var sectionNameArray = new Array();
$(document).ready(function(){
	fn_init();
});

function fn_init(){
	var callCount = parseInt('${parameterVO.pageIndex}');
	var nowLocale = '${locale}';
	$('.process_gubun').val("6");
	// ajax 호출
	var params = $("form[id=tunnelParameterVO2]").serialize();
	$.ajax({
		url : "${pageContext.request.contextPath}/dashTunnelProcess.json",
		type : "POST",
		data: params,
		success : function(result) {
			if(result.resultCode == "success"){
				var tunnelTotal = parseInt(result.tunnelTotalTotal);
				if(!isEmpty(result.tunnelTotalList)){
					if(!isEmpty(result.tunnelTotalList[callCount-1].sectionList)){
						for(var j=0;j<result.tunnelTotalList[callCount-1].sectionList.length;j++){
							var diggingProgress = 0;
							if(!isEmpty(result.tunnelTotalList[callCount-1].sectionList[j].digging_aggregate) && !isEmpty(result.tunnelTotalList[callCount-1].sectionList[j].end_pos) && !isEmpty(result.tunnelTotalList[callCount-1].sectionList[j].start_pos)){
								diggingProgress = (parseFloat(result.tunnelTotalList[callCount-1].sectionList[j].digging_aggregate)/parseInt(result.tunnelTotalList[callCount-1].sectionList[j].end_pos - result.tunnelTotalList[callCount-1].sectionList[j].start_pos)*100).toFixed(1);
							}
							console.log("diggingProgress : "+diggingProgress);
							if('en' == nowLocale){
								var checkData = { label : result.tunnelTotalList[callCount-1].sectionList[j].section_name_eng, y : parseFloat(diggingProgress)};
								sectionArray.push(checkData);
								sectionNameArray.push(result.tunnelTotalList[callCount-1].sectionList[j].section_name_eng);
							}else{
								var checkData = { label : result.tunnelTotalList[callCount-1].sectionList[j].section_name, y : parseFloat(diggingProgress)};
								sectionArray.push(checkData);
								sectionNameArray.push(result.tunnelTotalList[callCount-1].sectionList[j].section_name);
							}

						}
					}
				}
				fn_drawChart();
			}
		}
	})
}

</script>
<form:form id="tunnelParameterVO2" commandName="tunnelParameterVO" name="tunnelParameterVO" action="" method="post">
<input type="hidden" class="process_gubun" name="process_gubun" value="">
</form:form>
<form:form id="dashParameterVO" commandName="dashParameterVO" name="dashParameterVO" action="" method="post">
<input type="hidden" id="type_id" name="type_id" value="${dashList.type_id}">
<input type="hidden" id="dash_id" name="dash_id" value="${dashList.dash_id}">
<input type="hidden" id="sel_frame_id" name="sel_frame_id" value="">
<input type="hidden" id="dash_yn" name="dash_yn" value="Y">
<input type="hidden" id="process_gubun" name="process_gubun" value="">
<input type="hidden" id="pageIndex" name="pageIndex" value="">
</form:form>
<div id="container"></div>

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
	Highcharts.chart('container', {
	    chart: {
	        type: 'bar'
	    },
	    title: {
	        text: null
	    },
	    subtitle: {
	        text: null
	    },
	    xAxis: {
	        categories: sectionNameArray,
	        title: {
	            text: null
	        }
	    },
	    yAxis: {
	        min: 0,
	        max: 100,
	        title: {
	            text: null
	        },
	        labels: {
	            overflow: 'justify'
	        }
	    },
	    tooltip: {
	        valueSuffix: '%'
	    },
	    plotOptions: {
	        bar: {
	            dataLabels: {
	                enabled: true
	            }
	        }
	    },
	    legend: {
	        layout: 'vertical',
	        align: 'right',
	        verticalAlign: 'top',
	        x: -40,
	        y: 80,
	        floating: true,
	        borderWidth: 1,
	        backgroundColor:
	            Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
	        shadow: true
	    },
	    credits: {
	        enabled: false
	    },
	    series: [{
	    	name: '',
	        data: sectionArray
	    }]
	});
}
</script>