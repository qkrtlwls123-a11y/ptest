<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
	#container {
  height: 400px;
}

.highcharts-figure,
.highcharts-data-table table {
  min-width: 320px;
  max-width: 800px;
  margin: 1em auto;
}

.highcharts-data-table table {
  font-family: Verdana, sans-serif;
  border-collapse: collapse;
  border: 1px solid #ebebeb;
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

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
  padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
  background: #f8f8f8;
}

.highcharts-data-table tr:hover {
  background: #f1f7ff;
}
</style>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script>
$(document).ready(function(){
	const chart = Highcharts.chart('#container', {
		  title: {
		    text: 'Unemployment rates in engineering and ICT subjects, 2021',
		    align: 'left'
		  },
		  subtitle: {
		    text: 'Chart option: Plain | Source: ' +
		      '<a href="https://www.nav.no/no/nav-og-samfunn/statistikk/arbeidssokere-og-stillinger-statistikk/helt-ledige"' +
		      'target="_blank">NAV</a>',
		    align: 'left'
		  },
		  colors: [
		    '#4caefe',
		    '#3fbdf3',
		    '#35c3e8',
		    '#2bc9dc',
		    '#20cfe1',
		    '#16d4e6',
		    '#0dd9db',
		    '#03dfd0',
		    '#00e4c5',
		    '#00e9ba',
		    '#00eeaf',
		    '#23e274'
		  ],
		  xAxis: {
		    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
		  },
		  series: [{
		    type: 'column',
		    name: 'Unemployed',
		    borderRadius: 5,
		    colorByPoint: true,
		    data: [5412, 4977, 4730, 4437, 3947, 3707, 4143, 3609,
		      3311, 3072, 2899, 2887],
		    showInLegend: false
		  }]
		});

})

</script>
<div id="dtx-survey-detail" style="background-color: #ffffff; height: 100%; width: 480px;">
    <div class="panel-head">
      <span class="panel-title" style="padding-left:30px;margin-right:0;">
      </span>
			      <i class="panel-close-btn feather icon-x"></i>
    </div>
    <div class="panel-body ns-scrollbar survey-form surveyInsertForm" id="detailArea">
    	<figure class="highcharts-figure">
		  <div id="container"></div>
		</figure>
    </div>
  </div>