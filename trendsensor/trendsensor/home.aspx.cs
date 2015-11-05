using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;
using System.Web.Script.Services;
using System.Globalization;


namespace trendsensor
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static object getLineChart(string calendarClickDate)
        {
            // create a list, which can hold linechart instances
            List<LineChart> linechartList = new List<LineChart>();

            //convert to correct date format
            string format = "MM-dd-yyyy";
            string format2 = "MM/dd/yyyy";
            DateTime dateTime;
            string str1 = "";
            if (DateTime.TryParseExact(calendarClickDate, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out dateTime))
            {
                str1 = dateTime.ToString("yyyy'-'MM'-'dd");
            }
            else if (DateTime.TryParseExact(calendarClickDate, format2, CultureInfo.InvariantCulture, DateTimeStyles.None, out dateTime))
            {
                str1 = dateTime.ToString("yyyy'-'MM'-'dd");
            }

            // create a linechart class instance so that i
            // can talk to database 
            LineChart linechart = new LineChart();
            linechartList = linechart.getLineChart(str1);

            // assign the linechartList to the response object
            object response = linechartList;
            return response;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static int getLiveCount()
        {
            int liveCount = 0;

            // create a linechart class instance so that i
            // can talk to database 
            LineChart linechart = new LineChart();
            liveCount = linechart.getLiveCount();

            return liveCount;
        }

        [WebMethod]
        public static object cloudTag(string dat, int hour)
        {
            // create a list, which can hold linechart instances
            List<CloudTag> ctlist = new List<CloudTag>();

            //convert to correct date format
            //DateTime date = DateTime.Parse(str);
            DateTime date = DateTime.ParseExact(dat, "MM-dd-yyyy", null);
            string str1 = date.ToString("yyyy'-'MM'-'dd");

            // create a linechart class instance so that i
            // can talk to database 
            CloudTag ct = new CloudTag();
            ctlist = ct.getCloudTag(str1, hour);

            // assign the linechartList to the response object
            object response = ctlist;
            return response;
        }

        [WebMethod]
        public static object getRelatedTweets(string selectedWord, string selectedDate, string selectedTime)
        {
            // create a list, which can hold tweets instances
            List<Tweets> tweetList = new List<Tweets>();

            //convert to correct date format
            string format = "MM-dd-yyyy";
            string format2 = "MM/dd/yyyy";
            DateTime dateTime;
            string str1 = "";
            if (DateTime.TryParseExact(selectedDate, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out dateTime))
            {
                str1 = dateTime.ToString("yyyy'-'MM'-'dd");
            }
            else if (DateTime.TryParseExact(selectedDate, format2, CultureInfo.InvariantCulture, DateTimeStyles.None, out dateTime))
            {
                str1 = dateTime.ToString("yyyy'-'MM'-'dd");
            }

            // create a tweets class instance so that i
            // can talk to database 
            Tweets tweets = new Tweets();
            tweetList = tweets.getRelatedTweets(selectedWord, str1, selectedTime);

            // assign the tweetList to the response object
            object response = tweetList;
            return response;
        }
    }
}