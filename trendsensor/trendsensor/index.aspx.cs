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
    public partial class index : System.Web.UI.Page
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

            //DateTime date = new DateTime();
            //try {
            //    date = DateTime.ParseExact(calendarClickDate, "MM-dd-yyyy", null);
            //}
            //catch (InvalidCastException e)
            //{

            //}

           

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

    }
}