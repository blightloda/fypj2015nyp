<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="trendsensor.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Trend Sensor with Twitter</title>
    <script src="/bootstrap/js/jquery.js" type="text/javascript"></script>
    <script src="/bootstrap/js/jquery-ui.js" type="text/javascript"></script>
    <script src="http://d3js.org/d3.v3.min.js" type="text/javascript"></script>
    <script src="/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="/bootstrap/js/highcharts.js" type="text/javascript"></script>
    <script src="/bootstrap/js/exporting.js" type="text/javascript"></script>
    <link href="/bootstrap/css/jquery-ui.css" rel="stylesheet" />
    <link href="/bootstrap/css/highcharts.css" rel="stylesheet" />
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" />
    <link href="/bootstrap/css/emoIcon.css" rel="stylesheet" />
    <link href="/bootstrap/css/aboutBox.css" rel="stylesheet" />
    <link rel="icon" href="data:;base64,iVBORw0KGgo=" />
</head>
<body>
    <style>
         #tooltip {
            position: absolute;
            width: 200px;
            height: auto;
            padding: 10px;
            background-color: white;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;
            -webkit-box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.4);
            -mox-box-shadow: 4px 4px 4px 10px rgba(0, 0, 0, 0.4);
            box-shadow: 4px 4px 10px #ecf0f1;
            pointer-events: none;
        }
        #tooltip.hidden {
            opacity: 0;
        }
        #tooltip p {
            margin: 0;
            font-family: sans-serif;
            font-size: 16px;
            line-height: 20px;
        }
        .image { 
            position: relative; 
            width: 100%; /* for IE 6 */
        }
        .module {
            width: 270px;
            height: 150px;
            float: left;
            background: url(/bootstrap/img/NewLogo3.png);
            background-size: 270px 150px;
            position: relative;
        }
        body {
            background-image: url(/bootstrap/img/0.png);
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            z-index: -10;
        }
        h2 {
            position: absolute;
            bottom: 75px;
            left: 5px;
            padding: 4px 8px;
            color: black;
            margin: 0;
            font: 10px Sans-Serif;
        }

        .opp h2 {
            background: rgba(255, 255, 255, 0.75);
            color: black;
        }
    </style>
    <!-- The main container. -->
    <div class="container-fluid">
        <!-- First row, with two columns. -->
        <div class="row-fluid">
            <div class="span2" style="margin-top:20px; ">
                <!-- Datepicker -->
                <div id="selectedDateTime"></div>
                <div id="datepicker"></div>
                <div class="module" style="margin-top:10px">
                  <h2><div id="label">Incoming Live Tweets <br>Since 10/01/2013 :<div id="amount"></div>
                    </div></h2>
                </div>
                <%--<div><img id="logo" src="/bootstrap/img/NewLogo3.png" /></div>
                <!-- aboutBox.css -->
                <div id="aboutBox">
                    <div id="label">Incoming Live Tweets <br>Since 10/01/2013 : 
                        <div id="amount"></div>
                    </div>
                </div>--%>
            </div>
            <div class="span10">
                <!-- Trend Graph -->
                <div id="chart_div" style="min-width: 310px; height: 400px; margin: 0 auto; margin-top:20px; border-radius:10px; padding:10px;background-color:#FFFFFF"></div>
            </div>
        </div>

        <hr />
 
        <!-- Another row, with two columns. -->
        <div class="row">
            <div class="span3">
                <!-- Mood Selector -->
                <table class="table table-hover" style ="background-color:#FFFFFF;border-radius:10px;padding:10px"> 
                    <thead>
                        <tr>
                            <th>Mood Selector</th>
                        </tr>             
                    </thead>
                    <tbody>
                        <tr>
                            <td>All</td>
                            <td><img src="bootstrap/img/normal.png" class="emoIcon" /></td>
                        </tr>
                        <tr>
                            <td>Joy</td>
                            <td><img src="bootstrap/img/joy4.png" class="emoIcon" /></td>
                        </tr>
                        <tr>
                            <td>Anger</td>
                            <td><img src="bootstrap/img/anger4.png" class="emoIcon" /></td>
                        </tr>
                        <tr>
                            <td>Sadness</td>
                            <td><img src="bootstrap/img/sadness4.png" class="emoIcon" /></td>
                        </tr>
                        <tr>
                            <td>Surprised</td>
                            <td><img src="bootstrap/img/surprised4.png" class="emoIcon" /></td>
                        </tr>
                        <tr>
                            <td>Disgusted</td>
                            <td><img src="bootstrap/img/disgusted4.png" class="emoIcon" /></td>
                        </tr> 
                    </tbody>
                </table>
            </div>
            <div class="span9">
                <!-- Tag Graph -->
                <div id="bubble" style="border:1px solid black; min-width: 310px; height: 400px; margin: 0 auto"></div>
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

        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear();
        // add 0 infront for 0-9
        if (dd < 10) { dd = '0' + dd }
        if (mm < 10) { mm = '0' + mm }
        //get today's date
        today = mm + '/' + dd + '/' + yyyy;

        // draw linechart on today
        drawChart(today);

        // detect browser change size
        $(window).resize(function () {
            // resize calendar 
            $('.ui-datepicker').css('font-size', document.getElementById("chart_div").offsetWidth / 85 + 'px');

            // resize bubble
            document.getElementById("bubble").setAttribute("style", "width:" + (document.getElementById("chart_div").offsetWidth - 105) + "px;"
                + "height:" + document.getElementById("chart_div").offsetHeight + "px;"
                + "border:1px solid black;" + "margin: 0 auto");
        });

        // set width for bubble rectangle
        $(document).ready(function () {
            getLiveCounter();
            document.getElementById("bubble").setAttribute("style", "width:" + (document.getElementById("chart_div").offsetWidth - 105) + "px;"
                + "height:" + document.getElementById("chart_div").offsetHeight + "px;"
                + "border:1px solid black;" + "margin: 0 auto"); 
         });
        
        

        var calendarClickDate = "";

        //calendar click function
        $('#datepicker').change(function () {
            calendarClickDate = $('#datepicker').val();
            drawChart(calendarClickDate);
        });

        // draw line charts
        function drawChart(calendarClickDate) {
            $.ajax
            (
                {
                    type: 'POST',
                    url: 'index.aspx/getLineChart',
                    data: "{calendarClickDate: '" + calendarClickDate + "'}",
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
                    // get max length for x
                    var maxLength = linechartList[linechartList.length - 1].MaxLength;

                    var hours = [];
                    // all line data
                    var datas = { "name": "Frequency", "data": [] };
                    // individual mood data
                    var moodDatas = { "name": "Frequency", "joy": [], "anger": [], "sadness": [], "surprised": [], "disgusted": [] };
                    // loop through return data from database (linechartList)
                    // push them into chart graph
                    // last row is not taken as it is for 5 individual mood
                    for (index = 0; index < linechartList.length - maxLength - 1 ; index++)
                    {
                        hours.push(linechartList[index].Hour);
                        datas["data"].push(parseInt(linechartList[index].Frequency));
                    }
                    
                    for (index = maxLength; index > 0; index--)
                    {
                        // push data for individual mood
                        moodDatas["joy"].push(parseInt(linechartList[linechartList.length - index - 1].Joy));
                        moodDatas["anger"].push(parseInt(linechartList[linechartList.length - index - 1].Anger));
                        moodDatas["sadness"].push(parseInt(linechartList[linechartList.length - index - 1].Sadness));
                        moodDatas["surprised"].push(parseInt(linechartList[linechartList.length - index - 1].Surprised));
                        moodDatas["disgusted"].push(parseInt(linechartList[linechartList.length - index - 1].Disgusted));
                    }
                   
                    // ready to draw line chart
                    $('#chart_div').highcharts({

                        credits: {
                            enabled: false
                        },

                        title: {
                            text: 'Singapore Current Affairs',
                            x: -20 //center
                        },

                        tooltip: {
                            shared: true,
                            crosshairs: true
                        },

                        xAxis: {
                            title: {
                                text: 'Hour'
                            },
                            tickWidth: 0,
                            gridLineWidth: 1,
                            labels: {
                                align: 'left',
                                x: 3,
                                y: -3
                            },
                            categories: hours
                        },

                        yAxis: [{ // left y axis
                            title: {
                                text: 'Frequency'
                            },
                            labels:{
                                align: 'left',
                                x: 3,
                                y:16,
                                format: '{value:.,of}'
                            },
                            showFirstLabel: false,
                        },{  // right y axis
                            linkedTo: 0,
                            gridLineWidth: 0,
                            opposite: true,
                            title: {
                                text: 'Frequency'
                            },
                            labels: {
                                align: 'right',
                                x: -3,
                                y: 16,
                                format: '{value:.,0f}'
                            },
                            showFirstLabel: false
                        }],



                        plotOptions: {
                            line: {
                                dataLabels: {
                                    enabled: false
                                },
                            }
                        },

                        series: [{
                            name: 'All',
                            color: '#000000',
                            data: datas["data"]
                        }, {
                            name: 'Anger',
                            color: '#FF0000',
                            data: moodDatas["anger"]
                        }, {
                            name: 'Joy',
                            color: '#FF8000',
                            data: moodDatas["joy"]
                        }, {
                            name: 'Sadness',
                            color: '#008000',
                            data: moodDatas["sadness"]
                        }, {
                            name: 'Surprised',
                            color: '#FFC0CB',
                            data: moodDatas["surprised"]
                        }, {
                            name: 'Disgusted',
                            color: '#0000FF',
                            data: moodDatas["disgusted"]
                        }]
                    });
                }
            ).fail(function (jqXHR, textStatus, errorThrown) {
                console.log('The function attached to the ajax\'s fail() method has been executed.')
                console.log('The jqXRH Status Error Code is : ' + jqXHR.status);
            });//end of $.ajax(...);
            ;;
        }

        // get the number of tweets recorded so far
        function getLiveCounter() {
            $.ajax
            (
                {
                    type: 'GET',
                    url: 'index.aspx/getLiveCount',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false
                }
            ).done
            (
                function (data, textStatus, jqXHR) {
                    var liveCount = data.d;
                    $('#amount').html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + liveCount);
                    updateLiveCount();
                }
            ).fail(function (jqXHR, textStatus, errorThrown) {
                console.log('The function attached to the ajax\'s fail() method has been executed.')
                console.log('The jqXRH Status Error Code is : ' + jqXHR.status);
            });//end of $.ajax(...);

        }
        function updateLiveCount() {
            var counter = setInterval(function () {
                var str = $('#amount').html();
                var tag = "&nbsp;";
                for (tag in str) {
                    str = str.replace("&nbsp;", "");
                }
                var liveCount = str;
                liveCount++;
                $('#amount').html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + liveCount);
            }, 200);
        }
</script>
</body>
</html>
