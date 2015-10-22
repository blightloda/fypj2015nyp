<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bubble.aspx.cs" Inherits="trendsensor.bubble" %>

    <!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
    <link rel="icon" href="data:;base64,iVBORw0KGgo=" />
</head>
<body>
        <form id="form1" runat="server">
            <div id="bubble">
                <div id="tooltip" class="hidden">
    <p><strong>Frequency:</strong>
    </p>
    <p><span id="value">100</span> tweets</p>
</div>
            </div>
        
<style>
  body {
    font-family: sans-serif;
  }
  g.arc path {
    stroke: #828282;
    stroke-width: 0.5;
  }
  g.arc text {
    font-size: 10px;
  }
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
    display: none;
}

#tooltip p {
    margin: 0;
    font-family: sans-serif;
    font-size: 16px;
    line-height: 20px;
}
</style>
<script>
    
    //1st column for KEYWORD
    //2nd column for FREQUENCY based on mood. neutral,joy,anger,sadness,surprised,disgusted respectively
    var data = [
      ["pap", [10, 20, 10, 10, 10, 10]],
      ["singaporean voters", [10, 25, 10, 20, 10, 5]],
      ["vote", [10, 5, 10, 10, 10, 25]],
      ["wu sen", [10, 10, 10, 17, 20, 15]],
      ["avinda", [0, 4, 12, 3, 10, 3]],
      ["Obama", [30, 20, 10, 5, 5, 7]],
      //["bubble5", [14, 4]],
      //["bubble6", [15, 5, 10]],
      //["bubble7", [10, 10]],
      //["bubble8", [25, 10]],
      //["bubble9", [10, 25, 10, 10, 10, 10]],
      //["bubble10", [55, 10]],
      //["bubble11", [10, 80, 10, 10]],
      //["bubble12", [50, 50]],
    ];
    //drawChart2("09/09/2015");
    //function drawChart2(str) {
    //    $.ajax
    //    (
    //        {
    //            type: 'POST',
    //            url: 'bubble.aspx/getBubbleChart',
    //            data: "{str: '" + str + "'}",
    //            contentType: 'application/json; charset=utf-8',
    //            dataType: 'json',
    //            async: false
    //        }
    //    ).done
    //    (
    //        function (data1, textStatus, jqXHR) {
                // prevent json hijacking
                //var linechartList = data1.d;
                //var twodata = [];
                //var data = [[]];
                //var frequencydata = [];
                ////for (index = 0; index < linechartList.length; index++) {
                ////    frequencydata = linechartList.length
                ////}
                //for (var index = 0; index < linechartList.length - 190; index++) {
                //    data[index] = [];
                //    twodata.push(linechartList[index].Tag);
                //    frequencydata.push(linechartList[index].MoodFrequency);
                //}
                //for (var i = 0; i < twodata.length; i++) {
                //    data[i][0] = twodata[i];
                //    data[i][1] = frequencydata[i];
                //}
                var color = d3.scale.ordinal().range(["#E4F1FE", "#EEE657", "#e74c3c", "#3498db", "#9b59b6", "#2ecc71"]),
                diameter = 500;

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

                var grads = svg.append("defs").selectAll("radialGradient").data(function (d) { return data; })
                   .enter().append("radialGradient")
                   .attr("gradientUnits", "userSpaceOnUse")
                   .attr("cx", 0)
                   .attr("cy", 0)
                   .attr("r", "100%")
                   .attr("id", function (d, i) { return "grad" + i; });
                grads.append("stop").attr("offset", "0%").style("stop-color", function (d, i) { return color(i); });
                grads.append("stop").attr("offset", "50%").style("stop-color", "white");
                grads.append("stop").attr("offset", "30%").style("stop-color", function (d, i) { return color(i); });

                arcEnter.append("path")
                    .attr("d", function (d) {
                        arc.outerRadius(d.r);
                        return arc(d);
                    })
                    .style("fill", function (d, i) { return "url(#grad" + i + ")"; })
                    //.style("fill", function (d, i) { return color(i); })
                .on("mouseover", function (d) {
                    d3.select("#tooltip")
                        .style("left", d3.event.pageX + "px")
                        .style("top", d3.event.pageY + "px")
                        .style("display", "block")
                        .select("#value")
                        .text(d.value);
                })
                .on("mouseout", function () {
                    // Hide the tooltip
                    d3.select("#tooltip")
                        .style("display", "none");
                });

                //arcEnter.append("text")
                //    .attr({
                //        x: function (d) { arc.outerRadius(d.r); return arc.centroid(d)[0]; },
                //        y: function (d) { arc.outerRadius(d.r); return arc.centroid(d)[1]; },
                //        dy: "0.35em"
                //    })
                //    .style("text-anchor", "middle")
                //    .text(function (d) { return d.value; });

                var labels = nodes.selectAll("text.label")
                    .data(function (d) { console.log(d); return [d[0]]; });
                labels.enter().append("text")
                    .attr({
                        "class": "label",
                        dy: "0.35em"
                    })
                    .style("text-anchor", "middle")
                    .text(String);
    //        })
    //}
</script>
            
        </form>
</body>
</html>