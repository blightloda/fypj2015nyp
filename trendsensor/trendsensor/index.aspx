<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="trendsensor.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Trend Sensor with Twitter</title>
    <script src="/bootstrap/js/jquery.js" type="text/javascript"></script>
    <script src="/bootstrap/js/jquery-ui.js" type="text/javascript"></script>
    <script src="/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://www.google.com/jsapi" type="text/javascript"></script>
    <script src="/bootstrap/js/highcharts.js" type="text/javascript"></script>
    <script src="/bootstrap/js/exporting.js" type="text/javascript"></script>
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

    <script type="text/javascript">
 
        var str= "";
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();

        if(dd<10) {
           dd='0'+dd
        } 

        if(mm<10) {
          mm='0'+mm
        } 

        today = mm+'/'+dd+'/'+yyyy;

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

        drawChart(today);

        $('#datepicker').change(function () {
            
            str = $('#datepicker').val();
            drawChart(str);
            //drawTable(str);
            //confirm(str);
        });
        function drawChart(str) {
            $.ajax
            (
                {
                    type: 'POST',
                    url: 'index.aspx/getLineChart',
                    data: "{str: '" + str + "'}",
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false
                }
            ).done
            (
                function (data, textStatus, jqXHR)
                {
                    // prevent json hijacking
                    var linechartList = data.d;
                    // 
                    var hours = [];
                    var datas = { "name": "Frequency", "data": [] };
                    // loop through return data from database (linechartList)
                    // push them into chart graph
                    for (index = 0; index < linechartList.length; index++)
                    {
                        hours.push(linechartList[index].Hour);
                        datas["data"].push(parseInt(linechartList[index].Frequency));
                    }
                    // ready to draw line chart
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
                            categories: hours
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
                            }],
                           
                        },
                        series: [{
                            name: 'Frequency',
                            data: datas["data"]
                        }]
                    });
                }
            );;
        }
    </script>
</body>
</html>
