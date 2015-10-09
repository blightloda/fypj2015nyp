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
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
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
    </style>
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
                <table class="table table-hover"> 
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
 
        // set width for bubble rectangle
        $(document).ready(function() { 
            document.getElementById("bubble").setAttribute("style", "width:" + (document.getElementById("chart_div").offsetWidth - 105) + "px;"
                + "height:" + document.getElementById("chart_div").offsetHeight + "px;"
                + "border:1px solid black;" + "margin: 0 auto");
         });
        

        var str= "";
        //get today's date
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

        $("#target").click(function () {
            alert(window.innerWidth);
        });
        // detect browser change size
        $(window).resize(function () {
            // resize calendar 
            $('.ui-datepicker').css('font-size', document.getElementById("chart_div").offsetWidth / 85 + 'px');

            // resize bubble
            document.getElementById("bubble").setAttribute("style", "width:" + (document.getElementById("chart_div").offsetWidth - 105) + "px;"
                + "height:" + document.getElementById("chart_div").offsetHeight + "px;"
                + "border:1px solid black;" + "margin: 0 auto");
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
        
        //calendar click function
        $('#datepicker').change(function () {
            
            str = $('#datepicker').val();
            drawChart(str);
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
                        credits: {
                            enabled: false
                        },
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
                            name: 'All',
                            data: datas["data"]
                        }]
                    });
                }
            );;
        }
    </script>

    <script>
        //1st column for KEYWORD
        //2nd column for FREQUENCY based on mood. neutral,joy,anger,sadness,surprised,disgusted respectively
        var data = [
          ["bubble1", [10, 20]],
          ["bubble2", [5, 7]],
          ["bubble3", [6, 6, 10]],
          ["bubble4", [12, 14]],
          ["bubble5", [14, 4]],
          ["bubble6", [15, 5, 10]],
          ["bubble7", [10, 10]],
          ["bubble8", [25, 10]],
          ["bubble9", [10, 25, 10, 10, 10, 10]],
          ["bubble10", [55, 10]],
          ["bubble11", [10, 80, 10, 10]],
          ["bubble12", [50, 50]],
        ];

        var color = d3.scale.ordinal().range(["#ecf0f1", "#f1c40f", "#e74c3c", "#3498db", "#9b59b6", "#2ecc71"]),
        diameter = 380;

        var bubble = d3.layout.pack()
              .value(function (d) { return d3.sum(d[1]); })
              .sort(null)
              .size([diameter, diameter])
              .padding(1.5),
            arc = d3.svg.arc().innerRadius(0),
            pie = d3.layout.pie();

        var svg = d3.select("#bubble").append("svg")
            .attr("width", diameter)
            .attr("height", diameter)
            .attr("class", "bubble");

        var nodes = svg.selectAll("g.node")
            .data(bubble.nodes({ children: data }).filter(function (d) { return !d.children; }));
        nodes.enter().append("g")
            .attr("class", "node")
            .attr("transform", function (d) { return "translate(" + d.x + "," + d.y + ")"; });
            

        var arcGs = nodes.selectAll("g.arc")
            .data(function (d) {
                return pie(d[1]).map(function (m) { m.r = d.r; return m; });
            });
        var arcEnter = arcGs.enter().append("g").attr("class", "arc");

        arcEnter.append("path")
            .attr("d", function (d) {
                arc.outerRadius(d.r);
                return arc(d);
            })
            .style("fill", function (d, i) { return color(i); });

        <%--arcEnter.append("text")
            .attr({
                x: function (d) { arc.outerRadius(d.r); return arc.centroid(d)[0]; },
                y: function (d) { arc.outerRadius(d.r); return arc.centroid(d)[1]; },
                dy: "0.35em"
            })
            .style("text-anchor", "middle")
            .text(function (d) { return d.value; });--%>

        var labels = nodes.selectAll("text.label")
            .data(function (d) { console.log(d); return [d[0]]; });
        labels.enter().append("text")
            .attr({
                "class": "label",
                dy: "0.35em"
            })
            .style("text-anchor", "middle")
            .text(String);

</script>
</body>
</html>
