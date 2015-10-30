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
    public partial class bubble : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static object getBubbleChart(string str)
        {
            // create a list, which can hold linechart instances
            List<BubbleChart> bubblechartList = new List<BubbleChart>();
            
            //convert to correct date format
            //DateTime date = DateTime.Parse(str);
            DateTime date = DateTime.ParseExact(str, "MM/dd/yyyy", null);
            string str1 = date.ToString("yyyy'-'MM'-'dd");

            // create a linechart class instance so that i
            // can talk to database 
            BubbleChart bubble = new BubbleChart();
            bubblechartList = bubble.getOverallBubbleData(str1);
            //System.Diagnostics.Debug.Write();
            //testing/printout date
            System.Diagnostics.Debug.WriteLine(str1);

            // assign the linechartList to the response object
            object response = bubblechartList;

            return response;
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
        public static object getBarChart(string tagd)
        {
            List<BarChart> bclist = new List<BarChart>();
            BarChart bc = new BarChart();
            bclist = bc.getBarChart(tagd);
            object response = bclist;
            return response;
        }
    }
}