using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;

namespace trendsensor
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static object getLineChart(string str)
        {
            // create a list, which can hold linechart instances
            List<LineChart> linechartList = new List<LineChart>();

            //convert to correct date format
            //DateTime date = DateTime.Parse(str);
            DateTime date = DateTime.ParseExact(str, "MM/dd/yyyy", null);
            string str1 = date.ToString("yyyy'-'MM'-'dd");

            // create a linechart class instance so that i
            // can talk to database 
            LineChart linechart = new LineChart();
            linechartList = linechart.getLineChart(str1);

            //testing/printout date
            System.Diagnostics.Debug.WriteLine(str1);

            // assign the linechartList to the response object
            object response = linechartList;
            return response;
        }
    }
}