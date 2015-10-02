using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using System.Data;
using System.IO;

namespace BusinessLogiclayer
{
    public class DataAssembly
    {
        //private static string GetTextFromDataTable(DataTable dataTable)
        //{
        //    var stringBuilder = new StringBuilder();
        //    stringBuilder.AppendLine(string.Join("\t", dataTable.Columns.Cast<DataColumn>().Select(arg => arg.ColumnName)));
        //    foreach (DataRow dataRow in dataTable.Rows)
        //        stringBuilder.AppendLine(string.Join("\t", dataRow.ItemArray.Select(arg => arg.ToString())));
        //    return stringBuilder.ToString();

        //}

        //method for getting data and putting it inside tsv file
        public void getDataForBubble(string date, string hour, string path)
        {
            LineChart lc = new LineChart();
            StringBuilder sb = new StringBuilder();
            //get all the keywords/tags from the clicked date and hour
            List<String> list = lc.getKeyword(date, hour);
            //for every keyword, get frequency of mood and put inside stringbuilder
            foreach (string s in list)
            {
                
                sb.AppendLine(s + "\t" + lc.getFrequencyJoy(s) + "\t" + lc.getFrequencyAnger(s) + "\t" + lc.getFrequencySadness(s) + "\t" + lc.getFrequencySurprised(s) + "\t" + lc.getFrequencyDisgusted(s));
                //lc.getFrequencyJoy(s);
                //lc.getFrequencyAnger(s);
                //lc.getFrequencySadness(s);
                //lc.getFrequencySurprised(s);
                //lc.getFrequencyDisgusted(s);
            }
            //write the data into tsv file for graph display
            File.WriteAllText(path, sb.ToString());
        }
    }
}
