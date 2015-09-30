<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highchartDemo.aspx.cs" Inherits="trendsensor.highchartDemo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Highcharts Example</title>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<style type="text/css">
        body {
		font-family: 'Source Sans Pro', sans-serif;
		margin: 0px;
	}
	#top {
	    background: #252530;
	    height: 60px;
	    position: relative;
	    z-index: 2;
	}
	#top #logo {
	    position: absolute;
	    left: 20px;
	    top: 10px;
	}
	#top img {
 	  	height: 100px;
 	  	margin-top: -25px;
	}
	#wrap {
		display: inline-block;
		width: 700px;
		overflow: auto;
		padding: 10px;
	}
	#result {
		position: fixed;
		left: 750px;
		top: 100px;
		min-height: 100px;
		min-width: 600px;
	}
	form {
		width: 650px;
		margin: 0 auto;
		padding:15px;
	}
	input, textarea {
		float: left;
		width :250px;
		margin-right:15px;
		clear: left;
	}
	textarea {
		width:650px;
		margin:0px;
		margin-bottom: 15px;
		border:1px solid black;
	}
	input[type=radio]{
		width: auto;
	}
	input[type=submit]{
		width: 150px;
		float: right;
		position: relative;
		margin: 1em 0 0 1em;
	}
	label {
		display: block;
		padding-bottom:5px;
		padding-top:2em;
		clear:both;
	}
	label.radio {
		display:inline;
		font-size: 0.8em;
	}
	select {
		margin-right:150px;
		position: relative;
		float:left;
	}
	.info {
		font-size: 0.8em;
		color: gray;
	}

	div#toggle{
		visibility: hidden;
	}
	.CodeMirror-wrap {
		border: 1px solid #ddd
	}
	</style>
	<script type="text/javascript">
		$(function () {
		    $('#container').highcharts({
		        title: {
		            text: 'Monthly Average Temperature',
		            x: -20 //center
		        },
		        subtitle: {
		            text: 'Source: WorldClimate.com',
		            x: -20
		        },
		        xAxis: {
		            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
		        },
		        yAxis: {
		            title: {
		                text: 'Temperature (°C)'
		            },
		            plotLines: [{
		                value: 0,
		                width: 1,
		                color: '#808080'
		            }]
		        },
		        tooltip: {
		            valueSuffix: '°C'
		        },
		        legend: {
		            layout: 'vertical',
		            align: 'right',
		            verticalAlign: 'middle',
		            borderWidth: 0
		        },
		        series: [{
		            name: 'Tokyo',
		            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
		        }, {
		            name: 'New York',
		            data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
		        }, {
		            name: 'Berlin',
		            data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
		        }, {
		            name: 'London',
		            data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
		        }]
		    });
		});
	</script>
</head>
<body>
    <script src="/bootstrap/js/highcharts.js"></script>
    <script src="/bootstrap/js/exporting.js"></script>

    <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</body>
</html>
