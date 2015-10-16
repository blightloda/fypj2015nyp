using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;
using System.IO;

namespace trendsensor
{
    public partial class bubble : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string s = "";
            //string d="";
            //List<BubbleChart> bclist = new List<BubbleChart>();
            //BubbleChart bc = new BubbleChart();
            //bclist = bc.getOverallBubbleData("2015-09-09");
            //string path = Path.Combine(Server.MapPath("~"), @"Data.txt");
            //string ss = bclist[0].Tag;
            //for (int i = 0; i < bclist[0].MoodFrequency.Length; i++)
            //{
            //    s += bclist[0].MoodFrequency[i].ToString();
            //}
            //for (int i = 0; i < bclist.Count; i++)
            //{
            //    d += bclist[i].Tag.ToString();
            //}
            //File.WriteAllText(path, d);
            //lbl_msg.Text = bclist[1].MoodFrequency.Length.ToString();
                
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
    }
}