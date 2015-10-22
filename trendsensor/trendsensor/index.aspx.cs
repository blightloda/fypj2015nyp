using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;
using System.Web.Script.Services;

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
            //DateTime date = DateTime.Parse(str);
            DateTime date = DateTime.ParseExact(calendarClickDate, "MM/dd/yyyy", null);
            string str1 = date.ToString("yyyy'-'MM'-'dd");

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