<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bubble.aspx.cs" Inherits="trendsensor.bubble" %>

    <!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
        <form id="form1" runat="server">
        <script src="http://d3js.org/d3.v3.min.js"></script>
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
</style>
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

    var color = d3.scale.ordinal().range(["#FFFFFF", "#FFFF99", "#FF0066", "#99FF66", "#FF99FF", "#3399FF"]),
    diameter = 500;

    var bubble = d3.layout.pack()
          .value(function (d) { return d3.sum(d[1]); })
          .sort(null)
          .size([diameter, diameter])
          .padding(1.5),
        arc = d3.svg.arc().innerRadius(0),
        pie = d3.layout.pie();

    var svg = d3.select("body").append("svg")
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

    arcEnter.append("text")
        .attr({
            x: function (d) { arc.outerRadius(d.r); return arc.centroid(d)[0]; },
            y: function (d) { arc.outerRadius(d.r); return arc.centroid(d)[1]; },
            dy: "0.35em"
        })
        .style("text-anchor", "middle")
        .text(function (d) { return d.value; });

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
            
        </form>
</body>
</html>