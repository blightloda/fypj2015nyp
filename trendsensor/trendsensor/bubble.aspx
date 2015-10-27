<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bubble.aspx.cs" Inherits="trendsensor.bubble" %>

    <!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trend Sensor with Twitter</title>
    
    <script src="/bootstrap/js/jquery.js" type="text/javascript"></script>
    <script src="/bootstrap/js/jquery-ui.js" type="text/javascript"></script>
    <script src="http://d3js.org/d3.v3.min.js" type="text/javascript"></script>
    <script src="d3.layout.cloud.js" type="text/javascript"></script>
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
    //var data = [
    //  ["bubble1", [10, 20]],
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
    //

    ////cloudtag
    //cloudtag("09/09/2015",9);
    //function cloudtag(date,hour) {
    //    $.ajax
    //    (
    //        {
    //            type: 'POST',
    //            url: 'bubble.aspx/cloudTag',
    //            data: JSON.stringify({ dat: date, hour: hour }),
    //            contentType: 'application/json; charset=utf-8',
    //            dataType: 'json',
    //            async: false
    //        }
    //    ).done
    //    (
    //        function (data, textStatus, jqXHR) {
    //            //var fonti="";
    //            //var ind=0;
    //            var cloudtaglist = data.d;
    //            var worddata=[];
    //            for (i = 0; i < cloudtaglist.length; i++) {
    //                worddata[i] = cloudtaglist[i].tag;
    //            }
    //            var fontsiz = [];
    //            for (i = 0; i < cloudtaglist.length; i++) {
    //                fontsiz[i] = cloudtaglist[i].frequency/100 *5;
    //            }
    //            var fill = d3.scale.category20();
    //            //function mapdata() {
    //            //    return{text:, size:}
    //            //}
    //            var sj = [];
    //            function mapdata() {
    //                for (i = 0; i < worddata.length; i++) {
    //                    sj.push({ text: worddata[i], size: fontsiz[i] });
    //                }
    //            }
    //            mapdata();
    //            d3.layout.cloud().size([300, 300])
    //                .words(sj.map(function (d) {
    //                      return { text: d.text, size: 10 + d.size * 50 };
    //                  }))
    //                .rotate(function () { return 4 * 90; })
    //                .font("Impact")
    //                .fontSize(function (d) { return d.size; })
    //                .on("end", draw)
    //                .start();

    //            function draw(words) {
    //                d3.select("body").append("svg")
    //                    .attr("width", 1000)
    //                    .attr("height", 1000)
    //                  .append("g")
    //                    .attr("transform", "translate(150,150)")
    //                  .selectAll("text")
    //                    .data(words)
    //                  .enter().append("text")
    //                    .style("font-size", function (d) { return d.size + "px"; })
    //                    .style("font-family", "Impact")
    //                    .style("fill", function (d, i) { return fill(i); })
    //                    .style("transition", "all 0.3s ease")
    //                    .attr("text-anchor", "middle")
    //                    .attr("transform", function (d) {
    //                        return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
    //                    })
    //                    .text(function (d) { return d.text; })
    //                    .on("mouseover", function () {
    //                        $(this).css("font-size", "5em");
    //                    })
    //                    .on("mouseout", function (d) {
    //                        //fonti = words[ind].size;
    //                        //ind++;
    //                        $(this).css("font-size", d.size + "px");

    //                    })
    //                    //.on("mouseout", function () {
                            
    //                    //        fonti=words[ind].size;
    //                    //        ind++;
    //                    //    $(this).stop().animate({ fontSize: fonti  + "px" }, 500);
                           
    //                    //})
                        
                        
    //            }
    //        })
    //}
    

    //bar chart
    $(function () {
        // Create the chart
        $('#container').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Mood Chart'
            },
            subtitle: {
                text: 'Click the columns to select filter by mood'
            },
            xAxis: {
                type: 'category'
            },
            yAxis: {
                title: {
                    text: 'Frequency'
                }

            },
            legend: {
                enabled: true
            },
            plotOptions: {
                series: {
                    borderWidth: 0,
                    dataLabels: {
                        enabled: true,
                        format: '{point.y:.1f}%'
                    }
                }
            },

            tooltip: {
                headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
            },

            series: [{
                name: 'Brands',
                colorByPoint: true,
                data: [{
                    name: 'Microsoft Internet Explorer',
                    y: 56.33,
                    drilldown: 'Microsoft Internet Explorer'
                }, {
                    name: 'Chrome',
                    y: 24.03,
                    drilldown: 'Chrome'
                }, {
                    name: 'Firefox',
                    y: 10.38,
                    drilldown: 'Firefox'
                }, {
                    name: 'Safari',
                    y: 4.77,
                    drilldown: 'Safari'
                }, {
                    name: 'Opera',
                    y: 0.91,
                    drilldown: 'Opera'
                }, {
                    name: 'Proprietary or Undetectable',
                    y: 0.2,
                    drilldown: null
                }]
            }],
            drilldown: {
                series: [{
                    name: 'Microsoft Internet Explorer',
                    id: 'Microsoft Internet Explorer',
                    data: [
                        [
                            'v11.0',
                            24.13
                        ],
                        [
                            'v8.0',
                            17.2
                        ],
                        [
                            'v9.0',
                            8.11
                        ],
                        [
                            'v10.0',
                            5.33
                        ],
                        [
                            'v6.0',
                            1.06
                        ],
                        [
                            'v7.0',
                            0.5
                        ]
                    ]
                }, {
                    name: 'Chrome',
                    id: 'Chrome',
                    data: [
                        [
                            'v40.0',
                            5
                        ],
                        [
                            'v41.0',
                            4.32
                        ],
                        [
                            'v42.0',
                            3.68
                        ],
                        [
                            'v39.0',
                            2.96
                        ],
                        [
                            'v36.0',
                            2.53
                        ],
                        [
                            'v43.0',
                            1.45
                        ],
                        [
                            'v31.0',
                            1.24
                        ],
                        [
                            'v35.0',
                            0.85
                        ],
                        [
                            'v38.0',
                            0.6
                        ],
                        [
                            'v32.0',
                            0.55
                        ],
                        [
                            'v37.0',
                            0.38
                        ],
                        [
                            'v33.0',
                            0.19
                        ],
                        [
                            'v34.0',
                            0.14
                        ],
                        [
                            'v30.0',
                            0.14
                        ]
                    ]
                }, {
                    name: 'Firefox',
                    id: 'Firefox',
                    data: [
                        [
                            'v35',
                            2.76
                        ],
                        [
                            'v36',
                            2.32
                        ],
                        [
                            'v37',
                            2.31
                        ],
                        [
                            'v34',
                            1.27
                        ],
                        [
                            'v38',
                            1.02
                        ],
                        [
                            'v31',
                            0.33
                        ],
                        [
                            'v33',
                            0.22
                        ],
                        [
                            'v32',
                            0.15
                        ]
                    ]
                }, {
                    name: 'Safari',
                    id: 'Safari',
                    data: [
                        [
                            'v8.0',
                            2.56
                        ],
                        [
                            'v7.1',
                            0.77
                        ],
                        [
                            'v5.1',
                            0.42
                        ],
                        [
                            'v5.0',
                            0.3
                        ],
                        [
                            'v6.1',
                            0.29
                        ],
                        [
                            'v7.0',
                            0.26
                        ],
                        [
                            'v6.2',
                            0.17
                        ]
                    ]
                }, {
                    name: 'Opera',
                    id: 'Opera',
                    data: [
                        [
                            'v12.x',
                            0.34
                        ],
                        [
                            'v28',
                            0.24
                        ],
                        [
                            'v27',
                            0.17
                        ],
                        [
                            'v29',
                            0.16
                        ]
                    ]
                }]
            }
        });
    });
</script>
            
        </form>
</body>
</html>