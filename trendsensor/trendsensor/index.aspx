<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="trendsensor.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trend Sensor with Twitter</title>
    <script src="/bootstrap/js/jquery.js"></script>
    <script src="/bootstrap/js/jquery-ui.js"></script>
    <script src="/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://www.google.com/jsapi" ></script>
    <link href="/bootstrap/css/jquery-ui.css" rel="stylesheet" />
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" />
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
    <!-- The main container. -->
    <div class="container">
        <!-- First row, with two columns. -->
        <div class="row">
            <div class="span3">
                <!-- Datepicker -->
                <div id="selectedDateTime"></div>
                <div id="datepicker"></div>
            </div>
            <div class="span1"></div>
            <div class="span8">
                <!-- Trend Graph -->
                <div id="chart_div"></div>
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
        // load the visualization API and the piechart package
        google.load('visualization', '1', { 'packages': ['corechart'] });
        google.load('visualization', '1', { 'packages': ['table'] });
        // Set a callback to run when the Google Visualization API is loaded
        google.setOnLoadCallback(drawChart);

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
                    
                    // create the data table
                    var dataTable = new google.visualization.DataTable();
                    dataTable.addColumn('number', 'hour');
                    dataTable.addColumn('number', 'frequency');
                    //---------add row by row--------
                    for (index = 0; index < linechartList.length; index++)
                    {
                        var hr = parseInt(linechartList[index].Hour);
                        var fq = parseInt(linechartList[index].Frequency);
                        dataTable.addRow(new Array(hr, fq));
                    }
                    
                    // set chart options
                    var options =
                    {
                        titleTextStyle: { fontSize: 18, color: 'black', fontName: 'Tahoma, Geneva, sans-serif' },
                        hAxis: { title: 'Hour', titleTextStyle: { color: 'black' } },
                        vAxis: { title: 'Frequency', titleTextStyle: { color: 'black' } },
                        title: 'Singapore Current Affairs'
                    };

                    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
                    chart.draw(dataTable, options);
                    //google.visualization.events.addListener(chart, 'onmouseover', function (e) {
                    //    var hr = linechartList[0][0];
                    //    hr += e.row; //hour
                    //    document.getElementById("selectedDateTime").innerHTML = "2015-09-15" + " @ " + hr + " Hour "
                    //   // topKeywords(str, hr);
                    //});
                }
            );;
            //var isEmpty = true

            //$.post("php/linechart.php", { "ddlValue": str }, function (value) {
            //    isEmpty = false
            //    var dataTable = new google.visualization.DataTable();
            //    dataTable.addColumn('number', 'hour');
            //    dataTable.addColumn('number', 'frequency');
            //    dataTable.addRows(value);

            //    var options =
			//	{
			//	    titleTextStyle: { fontSize: 18, color: 'black', fontName: 'Tahoma, Geneva, sans-serif' },
			//	    hAxis: { title: 'Hour', titleTextStyle: { color: 'black' } },
			//	    vAxis: { title: 'Frequency', titleTextStyle: { color: 'black' } },
			//	    title: 'Singapore Current Affairs'
			//	};
            //    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
            //    chart.draw(dataTable, options);
            //    google.visualization.events.addListener(chart, 'onmouseover', function (e) {
            //        var hr = value[0][0];
            //        hr += e.row; //hour
            //        document.getElementById("selectedDateTime").innerHTML = str + " @ " + hr + " Hour "
            //        topKeywords(str, hr);
            //    });
            //}, "json");

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
