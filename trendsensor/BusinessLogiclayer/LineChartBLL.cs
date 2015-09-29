using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace BusinessLogicLayer
{
    public class LineChartBLL
    {
        [WebMethod]
        public static object getLineChart()
        {
            // create a list, which can hold linechart instances
            List<LineChart> linechartList = new List<LineChart>();

            // create a linechart class instance so that i
            // can talk to database 
            LineChart linechart = new LineChart();
            linechartList = linechart.getLineChart();

            // assign the linechartList to the response object
            object response = linechartList;
            return response;
        }
    }
}
