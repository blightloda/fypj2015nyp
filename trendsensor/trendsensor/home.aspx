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

</head>
<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar navbar-default navbar-fixed-top">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <div class="col-lg-1">
                    <a class="navbar-brand" href="home.aspx">Current Trendsensor</a>
                </div>
                <div class="col-lg-11">
                    <div id="datepaginator"></div>
                </div>
            </div>
            <!-- /.navbar-top-links -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                            <a href="home.aspx"><i class="fa fa-home fa-fw"></i>Home</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-info fa-fw"></i>Live Count<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>Incoming Live Tweets
                                    <br />
                                    Since 10/01/2013 :
                                </li>

                                <li>
                                    <div id="amount">0</div>
                                    <!-- /.live count -->
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <div id="page-wrapper">

            <div class="row">
                <div class="col-lg-6">
                    <h1 class="page-header">DateTime Selected: </h1>
                </div>
                <!-- /.col-lg-3 -->

                <div class="col-lg-6">
                    <h1 id="selectedDateTime" class="page-header"></h1>
                </div>
            </div>
            <!-- /.row -->

            <%--<div class="row">
                <div class="col-lg-12 col-md-12">
                    <!-- Markup - paginator will be injected as html into this div -->
                    <hr />
                </div>
            </div>--%>

            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-line-chart"></i>Singapore Current Affairs
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <!-- Trend Graph -->
                            <div id="chart_div"></div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->

                <div class="col-lg-12">
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-cloud"></i>Tag Cloud	         		            		             
                        </div>
                        <div class="panel-heading">
                            <i class="fa fa-filter"></i>Emotions Filter&nbsp;&nbsp;&nbsp;&nbsp;	
                            <input type="checkbox" checked data-toggle="toggle" data-on="<img src='bootstrap/img/anger4.png' height='34' width='34'></img> Anger" data-off="<img src='bootstrap/img/anger4.png' height='34' width='34'></img> Anger" data-onstyle="danger" />&nbsp;
                            <input type="checkbox" checked data-toggle="toggle" data-on="<img src='bootstrap/img/joy4.png' height='34' width='34'></img> Joy" data-off="<img src='bootstrap/img/joy4.png' height='34' width='34'></img> Joy" data-onstyle="warning" />   &nbsp;
                            <input type="checkbox" checked data-toggle="toggle" data-on="<img src='bootstrap/img/sadness4.png' height='34' width='34'></img> Sadness" data-off="<img src='bootstrap/img/sadness4.png' height='34' width='34'></img> Sadness" data-onstyle="success" />&nbsp;
                            <input type="checkbox" checked data-toggle="toggle" data-on="<img src='bootstrap/img/surprised4.png' height='34' width='34'></img> Surprised" data-off="<img src='bootstrap/img/surprised4.png' height='34' width='34'></img> Surprised" data-onstyle="info" />&nbsp;
                            <input type="checkbox" checked data-toggle="toggle" data-on="<img src='bootstrap/img/disgusted4.png' height='34' width='34'></img> Disgusted" data-off="<img src='bootstrap/img/disgusted4.png' height='34' width='34'></img> Disgusted" data-onstyle="primary" />		         		            		             
                        </div>
                        <!-- /.panel-heading -->
                        <div id="cloudtag" class="panel-body">                        
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>

                <div class="col-lg-12">
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-clock-o fa-fw"></i>Related Tweets
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <ul class="timeline">
                                <li>
                                    <div class="timeline-badge">
                                        <i class="fa fa-check"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Lorem ipsum dolor</h4>
                                            <p>
                                                <small class="text-muted"><i class="fa fa-clock-o"></i>11 hours ago via Twitter</small>
                                            </p>
                                        </div>
                                        <div class="timeline-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Libero laboriosam dolor perspiciatis omnis exercitationem. Beatae, officia pariatur? Est cum veniam excepturi. Maiores praesentium, porro voluptas suscipit facere rem dicta, debitis.</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                                    <div class="timeline-badge warning">
                                        <i class="fa fa-credit-card"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Lorem ipsum dolor</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Autem dolorem quibusdam, tenetur commodi provident cumque magni voluptatem libero, quis rerum. Fugiat esse debitis optio, tempore. Animi officiis alias, officia repellendus.</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Laudantium maiores odit qui est tempora eos, nostrum provident explicabo dignissimos debitis vel! Adipisci eius voluptates, ad aut recusandae minus eaque facere.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="timeline-badge danger">
                                        <i class="fa fa-bomb"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Lorem ipsum dolor</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellendus numquam facilis enim eaque, tenetur nam id qui vel velit similique nihil iure molestias aliquam, voluptatem totam quaerat, magni commodi quisquam.</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Lorem ipsum dolor</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptates est quaerat asperiores sapiente, eligendi, nihil. Itaque quos, alias sapiente rerum quas odit! Aperiam officiis quidem delectus libero, omnis ut debitis!</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="timeline-badge info">
                                        <i class="fa fa-save"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Lorem ipsum dolor</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nobis minus modi quam ipsum alias at est molestiae excepturi delectus nesciunt, quibusdam debitis amet, beatae consequuntur impedit nulla qui! Laborum, atque.</p>
                                            <hr />
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown">
                                                    <i class="fa fa-gear"></i><span class="caret"></span>
                                                </button>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li><a href="#">Action</a>
                                                    </li>
                                                    <li><a href="#">Another action</a>
                                                    </li>
                                                    <li><a href="#">Something else here</a>
                                                    </li>
                                                    <li class="divider"></li>
                                                    <li><a href="#">Separated link</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Lorem ipsum dolor</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi fuga odio quibusdam. Iure expedita, incidunt unde quis nam! Quod, quisquam. Officia quam qui adipisci quas consequuntur nostrum sequi. Consequuntur, commodi.</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                                    <div class="timeline-badge success">
                                        <i class="fa fa-graduation-cap"></i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title">Lorem ipsum dolor</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Deserunt obcaecati, quaerat tempore officia voluptas debitis consectetur culpa amet, accusamus dolorum fugiat, animi dicta aperiam, enim incidunt quisquam maxime neque eaque.</p>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>

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
    <script src="d3.layout.cloud.js" type="text/javascript"></script>


    <script type="text/javascript">

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
                                                var finalDateTime = n + " " + selectedTime;

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
                    //var fonti="";
                    //var ind=0;
                    var divwidth = document.getElementById("cloudtag").clientWidth;
                    var cloudtaglist = data.d;
                    var worddata=[];
                    for (i = 0; i < cloudtaglist.length; i++) {
                        worddata[i] = cloudtaglist[i].tag;
                    }
                    var fontsiz = [];
                    for (i = 0; i < cloudtaglist.length; i++) {
                        fontsiz[i] = cloudtaglist[i].frequency/10;
                    }
                    var fill = d3.scale.category20();
                    //function mapdata() {
                    //    return{text:, size:}
                    //}
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
                        .font("Impact")
                        .fontSize(function (d) { return d.size; })
                        .on("end", draw)
                        .start();

                    function draw(words) {
                        d3.select("#cloudtag").append("svg")
                            .attr("width", document.getElementById("cloudtag").clientWidth)
                            .attr("height", 300)
                          .append("g")
                            .attr("transform", "translate("+divwidth/2 +",150)")
                          .selectAll("text")
                            .data(words)
                          .enter().append("text")
                            .style("font-size", function (d) { return d.size + "px"; })
                            .style("font-family", "Impact")
                            .style("fill", function (d, i) { return fill(i); })
                            .style("transition", "all 0.3s ease")
                            .attr("text-anchor", "middle")
                            .attr("transform", function (d) {
                                return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                            })
                            .text(function (d) { return d.text; })
                            .on("mouseover", function () {
                                $(this).css("font-size", "5em");
                                // update bar chart

                            })
                            .on("mouseout", function (d) {
                                //fonti = words[ind].size;
                                //ind++;
                                $(this).css("font-size", d.size + "px");

                            })
                            //.on("mouseout", function () {

                            //        fonti=words[ind].size;
                            //        ind++;
                            //    $(this).stop().animate({ fontSize: fonti  + "px" }, 500);

                            //})


                    }
                })
        }
    </script>
</body>
</html>
