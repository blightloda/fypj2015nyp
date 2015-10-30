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
<script src="http://code.highcharts.com/highcharts-3d.js"></script>
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
    var ser = [{'name':'Joy'}]
    var mood = ['Joy', 'Anger', 'Sadness', 'Surprised', 'Disgusted'];
    var colour = ['#F5D76E', '#F22613', '#2ECC71', '#E08283', '#4183D7'];
    var datas = [2, 4, 0, 1, 6];
    //bar chart
    barchart('2013-01-2216home');
    function barchart(tagid) {
        
        $.ajax
        (
            {
                type: 'POST',
                url: 'bubble.aspx/getBarChart',
                data: JSON.stringify({ tagd: tagid}),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                async: false
            }
        ).done
        (
            function (data, textStatus, jqXHR) {
                var bclist = data.d;
                var barjoy = 0;
                var baranger = 0;
                var barsadness = 0;
                var barsurprised = 0;
                var bardisgusted = 0;
                for (i = 0; i < bclist.length; i++) {
                    if (bclist[i].mood == 'joy') {
                        barjoy++;
                    }
                    if(bclist[i].mood =='anger'){
                        baranger++;
                    }
                    if (bclist[i].mood == 'sadness') {
                        barsadness++;
                    }
                    if (bclist[i].mood == 'surprised') {
                        barsurprised++;
                    }
                    if(bclist[i].mood =='disgusted') {
                        bardisgusted++;
                    }
                    
                }
                $(function () {
                    $('#bubble').highcharts({
                        chart: {
                            type: 'column',
                            margin: 75,
                            options3d: {
                                enabled: true,
                                alpha: 10,
                                beta: 25,
                                depth: 70
                            },
                            color: colour
                        },
                        title: {
                            text: '3D chart with null values'
                        },
                        subtitle: {
                            text: 'Notice the difference between a 0 value and a null point'
                        },
                        plotOptions: {
                            column: {
                                depth: 35
                            },
                            series: {
                                groupPadding: 0.05
                            }
                        },
                        xAxis: {


                        },
                        yAxis: {
                            title: {
                                text: 'Frequency'
                            }
                        },
                        series: [{
                            name: 'Joy',
                            data: [barjoy],
                            color: '#F5D76E',
                            dataLabels: {
                                enabled: true
                            }
                        },
                        {
                            name: 'Anger',
                            data: [baranger],
                            color: '#F22613',
                            dataLabels: {
                                enabled: true
                            }
                        },
                        {
                            name: 'Sadness',
                            data:[barsadness],
                            color: '#2ECC71',
                            dataLabels: {
                                enabled: true
                            }
                        },
                        {
                            name: 'Surprised',
                            data: [barsurprised],
                            color: '#E08283',
                            dataLabels: {
                                enabled: true
                            }
                        },
                        {
                            name: 'Disgusted',
                            data: [bardisgusted],
                            color: '#4183D7',
                            dataLabels: {
                                enabled: true
                            }
                        }]

                    });
                });
            })
    }
</script>
            
        </form>
</body>
</html>