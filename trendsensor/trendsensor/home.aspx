<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="trendsensor.home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="author" content="Nanyang Polytechnic SIT" />

    <title>Current Trendsensor</title>

    <!-- Bootstrap Core CSS -->
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Custom Fonts -->
    <link href="/bootstrap/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Toggle CSS -->
    <link href="/bootstrap/css/bootstrap-toggle.css" rel="stylesheet" />
    <!-- Datepicker Core CSS -->
    <link href="/bootstrap/css/bootstrap-datepicker.css" rel="stylesheet" media="screen" />
    <!-- MetisMenu CSS -->
    <link href="/bootstrap/css/metisMenu.min.css" rel="stylesheet" />
    <!-- Timeline CSS -->
    <link href="/bootstrap/css/timeline.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <link href="/bootstrap/css/sb-admin-2.css" rel="stylesheet" />
    <!-- High Charts CSS -->
    <link href="/bootstrap/css/highcharts.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="/bootstrap/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    
    <style type="text/css">
        a.dp-nav.dp-nav-right{
            border-left-style: hidden!important;
            width: 19px;
        }
        #menu {
            position: fixed;
            left: 0;
            top: 50%;
            width: 14em;
            margin: -2.5em 0 0 0;
            z-index: 5;
            background: hsla(80, 88%, 40%, 0.7);
            color: white;
            font-weight: bold;
            font-size: large;
            text-align: left;
            border: solid hsla(80, 90%, 40%, 0.5);
            border-right: none;
            padding: 0.5em 0.5em 0.5em 1.5em;
            box-shadow: 0 1px 3px black;
            border-radius: 0.5em 3em 3em 0.5em;
        }
        #menu li { margin: 0 }
        #menu a { color: inherit }

        /* Make menu absolute, not fixed, on IE 5 & 6 */
        #menu { position: absolute }
        *>#menu { position: fixed }

        p.stb { text-indent: 0; margin-top: 0.83em }
        p.mtb { text-indent: 0; margin-top: 2.17em }
        p.ltb { text-indent: 0; margin-top: 3.08em }

        #currentSelectedDateTime {
            position: fixed;
            left: 0;
            top: 67%;
            width: 14em;
            margin: -2.5em 0 0 0;
            z-index: 5;
            background: hsla(80, 88%, 40%, 0.7);
            color: white;
            font-weight: bold;
            font-size: large;
            text-align: left;
            border: solid hsla(80, 90%, 40%, 0.5);
            border-right: none;
            padding: 0.5em 0.5em 0.5em 1.5em;
            box-shadow: 0 1px 3px black;
            border-radius: 0.5em 3em 3em 0.5em;
        }
        #currentSelectedDateTime li { margin: 0 }
        #currentSelectedDateTime a { color: inherit }

        /* Make menu absolute, not fixed, on IE 5 & 6 */
        #currentSelectedDateTime { position: absolute }
        *>#currentSelectedDateTime { position: fixed }

        p.stb { text-indent: 0; margin-top: 0.83em }
        p.mtb { text-indent: 0; margin-top: 2.17em }
        p.ltb { text-indent: 0; margin-top: 3.08em }
    </style>
</head>
<body>

    <div id="wrapper">

        <!-- /.fixed float menu -->
        <ul id="menu">
            <li>Incoming Tweets</li>
            <li><div id="amount">0</div></li>
        </ul>
        <ul id="currentSelectedDateTime">
            <li>DateTime Selected</li>
            <li><h1 id="selectedDateTime" class="page-header"></h1></li>
        </ul>

        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar navbar-default navbar-fixed-top">
                <div class="col-lg-1">
                    <a class="navbar-brand" href="home.aspx">Current Trendsensor</a>
                </div>
                <div class="col-lg-11">
                    <div id="datepaginator" style="margin-left:20px;margin-right:20px"></div>
                </div>
            </div>
            <!-- /.navbar-top-links -->
        </nav>
        
        <div id="page-wrapper">
            
            <div class="row">
                <hr />
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-line-chart"></i>Line Chart
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                        More
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu pull-right" role="menu">
                                        <li><a href="#">Print</a>
                                        </li>
                                        <li><a href="#">Save As Image</a>
                                        </li>
                                        <li><a href="#">Save As Pdf</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="chart_div"></div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->  
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-cloud"></i>Tag Cloud	         		            		             
                        </div>
                        <div class="panel-heading">
                            <i class="fa fa-filter"></i>Emotions Filter&nbsp;&nbsp;&nbsp;&nbsp;	
                            <input type="checkbox" checked data-toggle="toggle" data-on="<img src='bootstrap/img/anger4.png' height='34' width='34'></img> Anger" data-off="<img src='bootstrap/img/anger4.png' height='34' width='34'></img> Anger" data-onstyle="danger" id="angercheck"/>&nbsp;
                            <input type="checkbox" checked data-toggle="toggle" data-on="<img src='bootstrap/img/joy4.png' height='34' width='34'></img> Joy" data-off="<img src='bootstrap/img/joy4.png' height='34' width='34'></img> Joy" data-onstyle="warning" id="joycheck"/>   &nbsp;
                            <input type="checkbox" checked data-toggle="toggle" data-on="<img src='bootstrap/img/sadness4.png' height='34' width='34'></img> Sadness" data-off="<img src='bootstrap/img/sadness4.png' height='34' width='34'></img> Sadness" data-onstyle="success" id="sadnesscheck"/>&nbsp;
                            <input type="checkbox" checked data-toggle="toggle" data-on="<img src='bootstrap/img/surprised4.png' height='34' width='34'></img> Surprised" data-off="<img src='bootstrap/img/surprised4.png' height='34' width='34'></img> Surprised" data-onstyle="info" id="surprisedcheck"/>&nbsp;
                            <input type="checkbox" checked data-toggle="toggle" data-on="<img src='bootstrap/img/disgusted4.png' height='34' width='34'></img> Disgusted" data-off="<img src='bootstrap/img/disgusted4.png' height='34' width='34'></img> Disgusted" data-onstyle="primary" id="disgustedcheck"/>		         		            		             
                        </div>
                        <!-- /.panel-heading -->
                        <div id="cloudtag" class="panel-body">                        
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->          
                </div>
                <!-- /.col-lg-8 -->
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-clock-o fa-fw"></i>Related Tweets
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <ul class="timeline" id="relatedTweetUL">
 
                            </ul>  
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart"></i>Bar Chart	         		            		             
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">  
                            <div id="barchart"></div>                      
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-4 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- Bootstrap Core JavaScript -->
    <script src="/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- Toggle JavaScript -->
    <script src="/bootstrap/js/bootstrap-toggle.js" type="text/javascript" ></script>
    <!-- Metis Menu Plugin JavaScript -->
    <script src="/bootstrap/js/metisMenu.min.js" type="text/javascript"></script>
    <!-- High Charts JavaScript -->
    <script src="/bootstrap/js/highcharts.js" type="text/javascript"></script>
    <!-- Custom Theme JavaScript -->
    <script src="/bootstrap/js/sb-admin-2.js" type="text/javascript"></script>
    <!-- DatePicker JavaScript -->
    <script src="/bootstrap/js/moment-with-locales.js" type="text/javascript"></script>
    <script src="/bootstrap/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script src="/bootstrap/js/bootstrap-datepaginator.min.js" type="text/javascript"></script>
    <!-- D3.js -->
    <script src="http://d3js.org/d3.v3.min.js" type="text/javascript"></script>
    <!-- D3 Cloud Tag-->
    <script src="/bootstrap/js/d3.layout.cloud.js" type="text/javascript"></script>
    <!-- Highcharts 3d-->
    <script src="http://code.highcharts.com/highcharts-3d.js"></script>

    <script type="text/javascript">

        // use to update barchart
        var cloudtaglist;

        $( document ).ready(function() {
            var d = new Date();
            var n = d.toDateString();
            document.getElementById('selectedDateTime').innerHTML = n;
        });

        //get current date
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear();
        // add 0 infront for 0-9
        if (dd < 10) { dd = '0' + dd }
        if (mm < 10) { mm = '0' + mm }
        today = mm + '-' + dd + '-' + yyyy;

        // draw linechart on current date
        drawChart(today);
        // get live count
        getLiveCounter();

        // Basic initialization using defaults
        var options = {
            selectedDateFormat: 'MM-DD-YYYY'
        }
        $('#datepaginator').datepaginator(options);

        // date change event
        var dateChanged = {
            onSelectedDateChanged: function (event, date) {
                $('#datepaginator').datepaginator('setSelectedDate', [date, 'MM-DD-YYYY']);
                var calendarClickDate = date.format('MM-DD-YYYY');
                // draw new linechart after date change
                drawChart(calendarClickDate);
                // write selected date to label
                var d = new Date(calendarClickDate);
                var n = d.toDateString();
                document.getElementById('selectedDateTime').innerHTML = n;
            }
        }
        $('#datepaginator').datepaginator(dateChanged);


        // dateTime to update Tweets
        var selectedDate = "";
        var selectedTimeForRelatedTweets = "";
        // draw line charts
        function drawChart(calendarClickDate) {
            $.ajax
            (
                {
                    type: 'POST',
                    url: 'home.aspx/getLineChart',
                    data: "{calendarClickDate: '" + calendarClickDate + "'}",
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false
                }
            ).done
            (
                function (data, textStatus, jqXHR) {

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
                    for (index = 0; index < linechartList.length - maxLength - 1 ; index++) {
                        hours.push(linechartList[index].Hour);
                        datas["data"].push(parseInt(linechartList[index].Frequency));
                    }

                    for (index = maxLength; index > 0; index--) {
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
                            text: ''
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
                            labels: {
                                align: 'left',
                                x: 3,
                                y: 16,
                                format: '{value:.,of}'
                            },
                            showFirstLabel: false,
                        }, {  // right y axis
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

                        legend: {
                            align: 'left',
                            verticalAlign: 'top',
                            x: 0,
                            y: 0
                        },

                        plotOptions: {
                            series: {
                                cursor: 'pointer',
                                point: {
                                    events: {
                                        mouseOver: function () {     
                                                // format date 
                                                var selectedTime;
                                                if (this.x >= 12 && this.x <= 23) {
                                                    selectedTime = this.x + " PM";
                                                } else if (this.x >= 1 && this.x <= 11) {
                                                    selectedTime = this.x + " AM";
                                                } else if (this.x == 0) {
                                                   selectedTime = "24 AM";
                                                }
                                                var d = new Date(calendarClickDate);
                                                var n = d.toDateString();
                                                selectedDate = calendarClickDate;
                                                selectedTimeForRelatedTweets = this.x;
                                                var finalDateTime = n + " " + selectedTime;
                                                
                                                //check checkbox without triggering .change()
                                                $("#joycheck").data("bs.toggle").on(true);
                                                $("#angercheck").data("bs.toggle").on(true);
                                                $("#sadnesscheck").data("bs.toggle").on(true);
                                                $("#surprisedcheck").data("bs.toggle").on(true);
                                                $("#disgustedcheck").data("bs.toggle").on(true);


                                                //$('#joycheck').bootstrapToggle('on');
                                                //$('#angercheck').bootstrapToggle('on');
                                                //$('#sadnesscheck').bootstrapToggle('on');
                                                //$('#surprisedcheck').bootstrapToggle('on');
                                                //$('#disgustedcheck').bootstrapToggle('on');
                                                // update selected dateTime
                                                document.getElementById('selectedDateTime').innerHTML = finalDateTime;
                                                cloudtag(calendarClickDate, this.x);
                                        }
                                    }
                                },
                                marker: {
                                    lineWidth: 1
                                }
                            }
                        },

                        series: [{
                            name: 'All',
                            color: '#000000',
                            data: datas["data"]
                        }, {
                            name: 'Anger',
                            color: '#FF0000',
                            data: moodDatas["anger"],
                            visible: false
                        }, {
                            name: 'Joy',
                            color: '#FF8000',
                            data: moodDatas["joy"],
                            visible: false
                        }, {
                            name: 'Sadness',
                            color: '#008000',
                            data: moodDatas["sadness"],
                            visible: false
                        }, {
                            name: 'Surprised',
                            color: '#FFC0CB',
                            data: moodDatas["surprised"],
                            visible: false
                        }, {
                            name: 'Disgusted',
                            color: '#0000FF',
                            data: moodDatas["disgusted"],
                            visible: false
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
                    url: 'home.aspx/getLiveCount',
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
        //cloudtag
        function cloudtag(date, hour) {
            //clear tag cloud content
            document.getElementById("cloudtag").innerHTML = "";
            $.ajax
            (
                {
                    type: 'POST',
                    url: 'home.aspx/cloudTag',
                    data: JSON.stringify({ dat: date, hour: hour }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false
                }
            ).done
            (
                function (data, textStatus, jqXHR) {
                    // prevent json hijacking
                    cloudtaglist = data.d;
                    // get width for cloud
                    var divwidth = document.getElementById("cloudtag").clientWidth;
                    
                    var worddata = [];
                    var index = 0;
                    var str = "";
                    
                    // loop the json data and assign them into array 
                    for (i = 0; i < cloudtaglist.length; i++) {
                        worddata[i] = cloudtaglist[i].tag;
                    }

                    
                    var fontsiz = [];
                    // keyword size base on frequency
                    for (i = 0; i < cloudtaglist.length; i++) {
                        fontsiz[i] = cloudtaglist[i].frequency/10;
                    }

                    // color for text
                    var fill = d3.scale.category20();
                    // json data for data with size
                    var sj = [];
                    function mapdata() {
                        for (i = 0; i < worddata.length; i++) {
                            sj.push({ text: worddata[i], size: fontsiz[i] });
                        }
                    }

                    mapdata();
                    d3.layout.cloud().size([divwidth, 300])
                        .words(sj.map(function (d) {
                              return { text: d.text, size: 10 + d.size * 50 };
                          }))
                        .rotate(function () { return 4 * 90; })
                        .font("impact")
                        .fontsize(function (d) { return d.size; })
                        .on("end", draw)
                        .start();

                    //function draw(words) {
                    //    d3.select("#cloudtag").append("svg")
                    //        .attr("width", document.getElementById("cloudtag").clientWidth)
                    //        .attr("height", 300)
                    //      .append("g")
                    //        .attr("transform", "translate("+divwidth/2 +",150)")
                    //      .selectAll("text")
                    //        .data(words)
                    //      .enter().append("text")
                    //        .style("font-size", function (d) { return d.size + "px"; })
                    //        .style("font-family", "Impact")
                    //        .style("fill", function (d, i) { return fill(i); })
                    //        .style("transition", "all 0.3s ease")
                    //        .attr("text-anchor", "middle")
                    //        .attr("transform", function (d) {
                    //            return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                    //        })
                    //        .text(function (d) { return d.text; })
                    //        .on("mouseover", function () {
                    //            $(this).css("font-size", "5em");
                    //            // update bar chart
                    //            index = cloudtaglist.map(function (d) { return d['tag']; }).indexOf($(this).text());
                    //            // draw bar chart
                    //            barchart(cloudtaglist[index].tagid, $(this).text());
                    //            // retreive tweets
                    //            relatedTweets($(this).text(), selectedDate, selectedTimeForRelatedTweets);
                    //        })
                    //        .on("mouseout", function (d) {
                    //            $(this).css("font-size", d.size + "px");
                    //        })
                    //}
                })
        }
        // update related tweets
        function relatedTweets(selectedWord, selectedDate, selectedTime) {
            $.ajax
            (
               {
                   type: 'POST',
                   url: 'home.aspx/getRelatedTweets',
                   data: "{selectedWord: '" + selectedWord + "', selectedDate: '" + selectedDate + "', selectedTime: '" + selectedTime + "'}",
                   contentType: 'application/json; charset=utf-8',
                   dataType: 'json',
                   async: false
               }
            ).done
            (
               function (data, textStatus, jqXHR) {

                   // prevent json hijacking
                   var tweetList = data.d;
                   $(relatedTweetUL).empty();
                   var counter = 0;
                   for (i = 0; i < tweetList.length; i++) {
                       $("#relatedTweetUL").append("<li><div class=\"timeline-badge\"><i class=\"fa fa-check\"></i></div>"
                           + "<div class=\"timeline-panel\">"
                           + "<div class=\"timeline-body\">"
                           + "<p>" + tweetList[i].Content + "</p></div></div></li>");
                       counter++;
                       if (counter >= 2) {
                           break;
                       }
                   }
               }
            )
        }

        //barchart
        function barchart(tagid, tag) {

            $.ajax
            (
                {
                    type: 'POST',
                    url: 'bubble.aspx/getBarChart',
                    data: JSON.stringify({ tagd: tagid }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false
                }
            ).done
            (
                function (data, textStatus, jqXHR) {
                    var bclist = data.d;
                    var barneutral = 0;
                    var barjoy = 0;
                    var baranger = 0;
                    var barsadness = 0;
                    var barsurprised = 0;
                    var bardisgusted = 0;
                    for (i = 0; i < bclist.length; i++) {
                        if (bclist[i].mood == 'joy') {
                            barjoy++;
                        }
                        else if (bclist[i].mood == 'anger') {
                            baranger++;
                        }
                        else if (bclist[i].mood == 'sadness') {
                            barsadness++;
                        }
                        else if (bclist[i].mood == 'surprised') {
                            barsurprised++;
                        }
                        else if (bclist[i].mood == 'disgusted') {
                            bardisgusted++;
                        }
                        else {
                            barneutral++;
                        }
                    }
                    $(function () {
                        $('#barchart').highcharts({
                            chart: {
                                type: 'column',
                                margin: 75,
                                options3d: {
                                    enabled: true,
                                    alpha: 10,
                                    beta: 25,
                                    depth: 70
                                }
                            },
                            title: {
                                text: tag,
                                style: {
                                    "fontWeight":"bold"
                                }
                            },
                            subtitle: {
                                text: 'mood bar chart'
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
                                name: 'Neutral',
                                data: [barneutral],
                                color: '#6C7A89',
                                dataLabels: {
                                    enabled: true
                                }
                            }, {
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
                                data: [barsadness],
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
        //checkbox change event
        //update cloudtag based on mood
        $("#joycheck").change(function () {
            var mood = "";
            if (this.checked) {
                if ($('#cloudtag').children().length == 0) {
                    alert("No Data");
                } else {
                    if (document.getElementById("joycheck").checked) {
                        mood += "joy";
                    }
                    if (document.getElementById("angercheck").checked) {
                        mood += " anger";
                    }
                    if (document.getElementById("sadnesscheck").checked) {
                        mood += " sadness";
                    }
                    if (document.getElementById("surprisedcheck").checked) {
                        mood += " surprised";
                    }
                    if (document.getElementById("disgustedcheck").checked) {
                        mood += " disgusted";
                    }
                    filtercloudtag(globaldate, mood, globaltime);
                }
            }
            else {
                if ($('#cloudtag').children().length == 0) {
                    alert("No Data");
                } else {
                    if (document.getElementById("joycheck").checked) {
                        mood += "joy";
                    }
                    if (document.getElementById("angercheck").checked) {
                        mood += " anger";
                    }
                    if (document.getElementById("sadnesscheck").checked) {
                        mood += " sadness";
                    }
                    if (document.getElementById("surprisedcheck").checked) {
                        mood += " surprised";
                    }
                    if (document.getElementById("disgustedcheck").checked) {
                        mood += " disgusted";
                    }
                    filtercloudtag(globaldate, mood, globaltime);
                }
            }
        });
        $("#angercheck").change(function () {
            var mood = "";
            if (this.checked) {
                if ($('#cloudtag').children().length == 0) {
                    alert("No Data");
                } else {
                    if (document.getElementById("joycheck").checked) {
                        mood += "joy";
                    }
                    if (document.getElementById("angercheck").checked) {
                        mood += " anger";
                    }
                    if (document.getElementById("sadnesscheck").checked) {
                        mood += " sadness";
                    }
                    if (document.getElementById("surprisedcheck").checked) {
                        mood += " surprised";
                    }
                    if (document.getElementById("disgustedcheck").checked) {
                        mood += " disgusted";
                    }
                    filtercloudtag(globaldate, mood, globaltime);
                }
            }
            else {
                if ($('#cloudtag').children().length == 0) {
                    alert("No Data");
                } else {
                    if (document.getElementById("joycheck").checked) {
                        mood += "joy";
                    }
                    if (document.getElementById("angercheck").checked) {
                        mood += " anger";
                    }
                    if (document.getElementById("sadnesscheck").checked) {
                        mood += " sadness";
                    }
                    if (document.getElementById("surprisedcheck").checked) {
                        mood += " surprised";
                    }
                    if (document.getElementById("disgustedcheck").checked) {
                        mood += " disgusted";
                    }
                    filtercloudtag(globaldate, mood, globaltime);
                }
            }
        });
        $("#sadnesscheck").change(function () {
            var mood = "";
            if (this.checked) {
                if ($('#cloudtag').children().length == 0) {
                    alert("No Data");
                } else {
                    if (document.getElementById("joycheck").checked) {
                        mood += "joy";
                    }
                    if (document.getElementById("angercheck").checked) {
                        mood += " anger";
                    }
                    if (document.getElementById("sadnesscheck").checked) {
                        mood += " sadness";
                    }
                    if (document.getElementById("surprisedcheck").checked) {
                        mood += " surprised";
                    }
                    if (document.getElementById("disgustedcheck").checked) {
                        mood += " disgusted";
                    }
                    filtercloudtag(globaldate, mood, globaltime);
                }
            }
            else {
                if ($('#cloudtag').children().length == 0) {
                    alert("No Data");
                } else {
                    if (document.getElementById("joycheck").checked) {
                        mood += "joy";
                    }
                    if (document.getElementById("angercheck").checked) {
                        mood += " anger";
                    }
                    if (document.getElementById("sadnesscheck").checked) {
                        mood += " sadness";
                    }
                    if (document.getElementById("surprisedcheck").checked) {
                        mood += " surprised";
                    }
                    if (document.getElementById("disgustedcheck").checked) {
                        mood += " disgusted";
                    }
                    filtercloudtag(globaldate, mood, globaltime);
                }
            }
        });
        $("#surprisedcheck").change(function () {
            var mood = "";
            if (this.checked) {
                if ($('#cloudtag').children().length == 0) {
                    alert("No Data");
                } else {
                    if (document.getElementById("joycheck").checked) {
                        mood += "joy";
                    }
                    if (document.getElementById("angercheck").checked) {
                        mood += " anger";
                    }
                    if (document.getElementById("sadnesscheck").checked) {
                        mood += " sadness";
                    }
                    if (document.getElementById("surprisedcheck").checked) {
                        mood += " surprised";
                    }
                    if (document.getElementById("disgustedcheck").checked) {
                        mood += " disgusted";
                    }
                    filtercloudtag(globaldate, mood, globaltime);
                }
            }
            else {
                if ($('#cloudtag').children().length == 0) {
                    alert("No Data");
                } else {
                    if (document.getElementById("joycheck").checked) {
                        mood += "joy";
                    }
                    if (document.getElementById("angercheck").checked) {
                        mood += " anger";
                    }
                    if (document.getElementById("sadnesscheck").checked) {
                        mood += " sadness";
                    }
                    if (document.getElementById("surprisedcheck").checked) {
                        mood += " surprised";
                    }
                    if (document.getElementById("disgustedcheck").checked) {
                        mood += " disgusted";
                    }
                    filtercloudtag(globaldate, mood, globaltime);
                }
            }
        });
        $("#disgustedcheck").change(function () {
            var mood = "";
            if (this.checked) {
                if ($('#cloudtag').children().length == 0) {
                    alert("No Data");
                } else {
                    if (document.getElementById("joycheck").checked) {
                        mood += "joy";
                    }
                    if (document.getElementById("angercheck").checked) {
                        mood += " anger";
                    }
                    if (document.getElementById("sadnesscheck").checked) {
                        mood += " sadness";
                    }
                    if (document.getElementById("surprisedcheck").checked) {
                        mood += " surprised";
                    }
                    if (document.getElementById("disgustedcheck").checked) {
                        mood += " disgusted";
                    }
                    filtercloudtag(globaldate, mood, globaltime);
                }
            }
            else {
                if ($('#cloudtag').children().length == 0) {
                    alert("No Data");
                } else {
                    if (document.getElementById("joycheck").checked) {
                        mood += "joy";
                    }
                    if (document.getElementById("angercheck").checked) {
                        mood += " anger";
                    }
                    if (document.getElementById("sadnesscheck").checked) {
                        mood += " sadness";
                    }
                    if (document.getElementById("surprisedcheck").checked) {
                        mood += " surprised";
                    }
                    if (document.getElementById("disgustedcheck").checked) {
                        mood += " disgusted";
                    }
                    filtercloudtag(globaldate, mood, globaltime);
                }
            }
        });
    </script>
</body>
</html>
