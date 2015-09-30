<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="trendsensor.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Trend Sensor with Twitter</title>
    <script src="/bootstrap/js/jquery.js"></script>
    <script src="/bootstrap/js/jquery-ui.js"></script>
    <script src="/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://www.google.com/jsapi" ></script>
    <script src="/bootstrap/js/highcharts.js"></script>
    <script src="/bootstrap/js/exporting.js"></script>
    <link href="/bootstrap/css/jquery-ui.css" rel="stylesheet" />
    <link href="/bootstrap/css/highcharts.css" rel="stylesheet" />
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" />
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
    <!-- The main container. -->
    <div class="container-fluid">
        <!-- First row, with two columns. -->
        <div class="row-fluid">
            <div class="span2">
                <!-- Datepicker -->
                <div id="selectedDateTime"></div>
                <div id="datepicker"></div>
            </div>
            <div class="span10">
                <!-- Trend Graph -->
                <div id="chart_div" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
            </div>
        </div>

        <hr />
 
        <!-- Another row, with two columns. -->
        <div class="row">
            <div class="span3">
                <!-- Mood Selector -->
            </div>
            <div class="span9">
                <!-- Tag Graph -->
            </div>
        </div>
    </div>

    <%--<!-- Keyword Modal -->
    <div id="popup" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="popupLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="popupLabel">Login</h3>
        </div>
        <div class="modal-body">
            <p>Enter login details...</p>
        </div>
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
            <button class="btn btn-primary">Login</button>
        </div>
    </div>--%>

    <script>
        
        //// load the visualization API and the piechart package
        //google.load('visualization', '1', { 'packages': ['corechart'] });
        //google.load('visualization', '1', { 'packages': ['table'] });
        //// Set a callback to run when the Google Visualization API is loaded
        //google.setOnLoadCallback(drawChart);



        $("#datepicker").datepicker({
            inline: true
        });

        // Hover states on the static widgets
        $("#dialog-link, #icons li").hover(
            function () {
                $(this).addClass("ui-state-hover");
            },
            function () {
                $(this).removeClass("ui-state-hover");
            }
        );

        drawChart();

        function drawChart() {
            $.ajax
            (
                {
                    type: 'POST',
                    url: 'index.aspx/getLineChart',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false
                }
            ).done
            (
                function (data, textStatus, jqXHR)
                {
                    var linechartList = data.d;

                    // get x , y values
                    var xAxisValue = [];
                    var yAxisValue = [];
                    for (index = 0; index < linechartList.length; index++)
                    {
                        var hr = linechartList[index].Hour;
                        var fq = parseInt(linechartList[index].Frequency);
                        xAxisValue[index] = hr;
                        yAxisValue[index] = fq;
                    }
                    $(document).ready(function (xAxisValue, yAxisValue) {
                        $('#chart_div').highcharts({
                            title: {
                                text: 'Singapore Current Affairs',
                                x: -20 //center
                            },
                            subtitle: {
                                text: 'Source: Twitter.com',
                                x: -20
                            },
                            xAxis: {
                                title: {
                                    text: 'Hour'
                                },
                                categories: ['16', '17', '18', '19', '20']
                            },
                            yAxis: {
                                alternateGridColor: '#FDFFD5',
                                allowDecimals: false,
                                title: {
                                    text: 'Frequency'
                                },
                                plotLines: [{
                                    value: 0,
                                    width: 1,
                                    color: '#808080'
                                }]
                            },
                            tooltip: {
                                valueSuffix: ' occurs'
                            },
                            legend: {
                                layout: 'vertical',
                                align: 'right',
                                verticalAlign: 'middle',
                                borderWidth: 0
                            },
                            series: [{
                                name: 'tags',
                                data: [26, 39, 18, 19, 55]
                            }]
                        });
                    });
                    //// create the data table
                    //var dataTable = new google.visualization.DataTable();
                    //dataTable.addColumn('number', 'hour');
                    //dataTable.addColumn('number', 'frequency');
                    ////---------add row by row--------
                    //for (index = 0; index < linechartList.length; index++)
                    //{
                    //    var hr = parseInt(linechartList[index].Hour);
                    //    var fq = parseInt(linechartList[index].Frequency);
                    //    dataTable.addRow(new Array(hr, fq));
                    //}
                    
                    //// set chart options
                    //var options =
                    //{
                    //    titleTextStyle: { fontSize: 18, color: 'black', fontName: 'Tahoma, Geneva, sans-serif' },
                    //    hAxis: { title: 'Hour', titleTextStyle: { color: 'black' } },
                    //    vAxis: { title: 'Frequency', titleTextStyle: { color: 'black' } },
                    //    title: 'Singapore Current Affairs'
                    //};

                    //// append to html tag
                    //var chart = new google.visualization.LineChart(document.getElementById('chart_div'));

                    //// draw the graph
                    //chart.draw(dataTable, options);
                    //google.visualization.events.addListener(chart, 'onmouseover', function (e) {
                    //    var hr = linechartList[0][0];
                    //    hr += e.row; //hour
                    //    document.getElementById("selectedDateTime").innerHTML = "2015-09-15" + " @ " + hr + " Hour "
                    //   // topKeywords(str, hr);
                    //});
                }
            );;

            //if (isEmpty) {
            //    var dataTable = new google.visualization.DataTable();
            //    dataTable.addColumn('number', 'hour');
            //    dataTable.addColumn('number', 'frequency');
            //    dataTable.addRows(0, 0, 0, 0, 0);

            //    var options =
			//	{
			//	    titleTextStyle: { fontSize: 18, color: 'black', fontName: 'Tahoma, Geneva, sans-serif' },
			//	    hAxis: { title: 'Hour', titleTextStyle: { color: 'black' } },
			//	    vAxis: { title: 'Frequency', titleTextStyle: { color: 'black' } },
			//	    title: 'Singapore Current Affairs'
			//	};
            //    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
            //    chart.draw(dataTable, options);
            //}
        }
    </script>
</body>
</html>
