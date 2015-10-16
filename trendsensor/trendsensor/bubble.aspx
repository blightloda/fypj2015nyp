<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bubble.aspx.cs" Inherits="trendsensor.bubble" %>

    <!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
        <form id="form1" runat="server">
            <div id="bubble">
                <div id="tooltip" class="hidden">
    <p><strong>Frequency:</strong>
    </p>
    <p><span id="value">100</span> tweets</p>
</div>
            </div>
        <script src="http://d3js.org/d3.v3.min.js"></script>
<style>
  body {
    font-family: sans-serif;
  }
  g.arc path {
    stroke: #828282;
    stroke-width: 1;
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
<script type="text/javascript">
    
    //1st column for KEYWORD
    //2nd column for FREQUENCY based on mood. neutral,joy,anger,sadness,surprised,disgusted respectively
    //var data = [
    //  ["bubble1", [10, 220]],
    //  ["bubble2", [5, 7]],
    //  ["bubble3", [6, 6, 10]],
    //  ["bubble4", [12, 14]],
    //  ["bubble5", [14, 4]],
    //  ["bubble6", [15, 5, 10]],
    //  ["bubble7", [10, 10]],
    //  ["bubble8", [25, 10]],
    //  ["bubble9", [10, 25, 10, 10, 10, 10]],
    //  ["bubble10", [55, 10]],
    //  ["bubble11", [10, 80, 10, 10]],
    //  ["bubble12", [50, 50]],
    //];
    drawChart2("09/09/2015");
    function drawChart2(str) {
        $.ajax
        (
            {
                type: 'POST',
                url: 'bubble.aspx/getBubbleChart',
                data: "{str: '" + str + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                async: false
            }
        ).done
        (
            function (data1, textStatus, jqXHR)
            {
                // prevent json hijacking
                var linechartList = data1.d;
                var twodata = [];
                var data = [[]];
                var frequencydata = [];
                //for (index = 0; index < linechartList.length; index++) {
                //    frequencydata = linechartList.length
                //}
                for (var index = 0; index < linechartList.length - 195; index++) {
                    data[index] = [];
                    twodata.push(linechartList[index].Tag);
                    frequencydata.push(linechartList[index].MoodFrequency);
                }
                for (var i = 0; i < twodata.length; i++) {
                    data[i][0]=twodata[i];
                    data[i][1]=frequencydata[i];
                }
                var color = d3.scale.ordinal().range(["#E4F1FE", "#EEE657", "#e74c3c", "#3498db", "#9b59b6", "#2ecc71"]),
                diameter = 500;

                var inde = 0;

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
                   .attr("r", "10%")
                   .attr("id", function (d, i) { return "grad" + i; });
                grads.append("stop").attr("offset", "15%").style("stop-color", function (d, i) { return color(i); });
                grads.append("stop").attr("offset", "20%").style("stop-color", "white");
                grads.append("stop").attr("offset", "15%").style("stop-color", function (d, i) { return color(i); });

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
            }
        )
    }
    //var color = d3.scale.ordinal().range(["#E4F1FE", "#EEE657", "#e74c3c", "#3498db", "#9b59b6", "#2ecc71"]),
    //diameter = 500;

    //var inde = 0;

    //var bubble = d3.layout.pack()
    //      .value(function (d) { return d3.sum(d[1]); })
    //      .sort(null)
    //      .size([diameter, diameter])
    //      .padding(1.5),
    //    arc = d3.svg.arc().innerRadius(0),
    //    pie = d3.layout.pie();

    //var svg = d3.select("#bubble").append("svg")
    //    .attr("width", diameter)
    //    .attr("height", diameter)
    //    .attr("class", "bubble");

    //var nodes = svg.selectAll("g.node")
    //    .data(bubble.nodes({ children: data }).filter(function (d) { return !d.children; }));
    //nodes.enter().append("g")
    //    .attr("class", "node")
    //    .attr("transform", function (d) { return "translate(" + d.x + "," + d.y + ")"; });

    //var arcGs = nodes.selectAll("g.arc")
    //    .data(function (d) {
    //        return pie(d[1]).map(function (m) { m.r = d.r; return m; });
    //    });
    //var arcEnter = arcGs.enter().append("g").attr("class", "arc");

    
    //var grads = svg.append("defs").selectAll("radialGradient").data(function (d) { return data;})
    //   .enter().append("radialGradient")
    //   .attr("gradientUnits", "userSpaceOnUse")
    //   .attr("cx", 0)
    //   .attr("cy", 0)
    //   .attr("r", "10%")
    //   .attr("id", function (d, i) { return "grad" + i; });
    //    grads.append("stop").attr("offset", "15%").style("stop-color", function (d, i) { return color(i); });
    //    grads.append("stop").attr("offset", "20%").style("stop-color", "white");
    //    grads.append("stop").attr("offset", "15%").style("stop-color", function (d, i) { return color(i); });
    
    //arcEnter.append("path")
    //    .attr("d", function (d) {
    //        arc.outerRadius(d.r);
    //        return arc(d);
    //    })
    //    .style("fill", function(d, i) { return "url(#grad" + i + ")"; })
    //    //.style("fill", function (d, i) { return color(i); })
    //.on("mouseover", function (d) {
    //    d3.select("#tooltip")
    //        .style("left", d3.event.pageX + "px")
    //        .style("top", d3.event.pageY + "px")
    //        .style("display", "block")
    //        .select("#value")
    //        .text(d.value);
    //})
    //.on("mouseout", function () {
    //    // Hide the tooltip
    //    d3.select("#tooltip")
    //        .style("display", "none");
    //});

    ////arcEnter.append("text")
    ////    .attr({
    ////        x: function (d) { arc.outerRadius(d.r); return arc.centroid(d)[0]; },
    ////        y: function (d) { arc.outerRadius(d.r); return arc.centroid(d)[1]; },
    ////        dy: "0.35em"
    ////    })
    ////    .style("text-anchor", "middle")
    ////    .text(function (d) { return d.value; });

    //var labels = nodes.selectAll("text.label")
    //    .data(function (d) { console.log(d); return [d[0]]; });
    //labels.enter().append("text")
    //    .attr({
    //        "class": "label",
    //        dy: "0.35em"
    //    })
    //    .style("text-anchor", "middle")
    //    .text(String);

    
</script>
            
            <asp:Label ID="lbl_msg" runat="server" Text="Label"></asp:Label>
            
        </form>
</body>
</html>