<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/util.js"></script>
<script type="text/javascript">
var chartHeight = parseInt("${parameterVO.chartHeight}", 10);
var sectionArray = new Array();
var sectionNameArray = new Array();
$(document).ready(function(){
	fn_init();
	$("#container").height(chartHeight);
});

function fn_init(){
	var callCount = parseInt('${parameterVO.pageIndex}');
	$('.process_gubun').val("33");
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
							var checkData = { label : result.tunnelTotalList[callCount-1].sectionList[j].section_name, y : parseFloat(diggingProgress)};
							sectionArray.push(checkData);
							sectionNameArray.push(result.tunnelTotalList[callCount-1].sectionList[j].section_name);
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
<div id="container" style="width:220px;height:100px;"></div>

<style>
.highcharts-figure, .highcharts-data-table table {
  min-width: 100px;
  max-width: 100px;
  margin: 0 auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 1.5em auto;
	text-align: center;
	width: 100%;
	max-width: 100px;
}
.highcharts-data-table th {
	font-weight: 600;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
  padding: 0px;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
  background: #f8f8f8;
}
.highcharts-data-table tr:hover {
  background: #f1f7ff;
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
		    polar: true,
		    type: 'line'
		  },
		  title: {
		    text: null
		  },

		  pane: {
		    size: '85%'
		  },

		  xAxis: {
		    categories: sectionNameArray,
		    tickmarkPlacement: 'on',
		    lineWidth: 0
		  },

		  yAxis: {
		    gridLineInterpolation: 'polygon',
		    lineWidth: 0,
		    min: 0
		  },

		  tooltip: {
		    shared: true,
		    pointFormat: '<span style="color:{series.color}">{series.name}: <b>{point.y:,.0f}</b><br/>'
		  },

		  legend: {
			  alignColumns : false,
			  enabled : false
		  },
		  plotOptions: {
		        bar: {
		            dataLabels: {
		                enabled: true
		            }
		        }
		    },
		  credits: {
		        enabled: false
		    },

		  series: [{
			name: '',
		    data: sectionArray
		  }],
		  navigation : {
				menuItemStyle : {
					fontSize : '8px'
				},
				buttonOptions : {
					enabled : false
				}
			}

		});
}
</script>