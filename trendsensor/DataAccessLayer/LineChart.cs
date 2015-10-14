using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Data;
using System.Collections;

namespace DataAccessLayer
{
    public class LineChart
    {

        public List<LineChart> getLineChart(string str)
        {
            int minX = 0;
            int maxX = 0;
            ArrayList hours = new ArrayList();
            DataSet ds = new DataSet();
            DataSet ds1 = new DataSet();
            DataSet ds2 = new DataSet();
            // empty list
            List<LineChart> linechartList = new List<LineChart>();

            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    using (MySqlDataAdapter da = new MySqlDataAdapter(), da1 = new MySqlDataAdapter(), da2 = new MySqlDataAdapter())
                    {
                        // obtain connection string information from app.config
                        cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                        // tell the cmd to use the cn
                        cmd.Connection = cn;
                        // supply the cmd with the necessary SQL Y-M-D FULL
                        cmd.CommandText = "SELECT * FROM tagsretrievedtemp WHERE date = '" + str + "' GROUP BY date,hour;";                                                       
                        //testing/print out sqlquery
                        System.Diagnostics.Debug.WriteLine(cmd.CommandText);
                        // tell the DataAdapter to use the cmd
                        da.SelectCommand = cmd;
                        // open an active connection
                        cn.Open();
                        // rrturns the results
                        da.Fill(ds, "Rate");

                        cmd.CommandText = "SELECT Min(CAST(`hour` AS UNSIGNED))  FROM tagsretrievedtemp WHERE date = '" + str + "';";
                        if (cmd.ExecuteScalar().ToString() != "")
                        {
                            minX = int.Parse(cmd.ExecuteScalar().ToString());
                            cmd.CommandText = "SELECT Max(CAST(`hour` AS UNSIGNED))  FROM tagsretrievedtemp WHERE date = '" + str + "';";
                            if (cmd.ExecuteScalar().ToString() != "")
                            {
                                maxX = int.Parse(cmd.ExecuteScalar().ToString());
                            }
                        }

                        if (maxX != 0)
                        {
                            // get the actually value of hour
                            cmd.CommandText = "SELECT hour FROM tagsretrievedtemp WHERE date = '" + str + "' GROUP BY date,hour;";
                            using (var reader = cmd.ExecuteReader())
                            {
                                
                                while (reader.Read())
                                {
                                    hours.Add(reader.GetString(0));
                                }
                            }


                            // reuse cmd variable
                            // count frequency of a individual mood for a given date and time 
                            foreach (string hour in hours)
                            {
                                cmd.CommandText = "SELECT(SELECT count(*) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE `date` = '" + str + "' and hour='" + hour + "' and mood = 'joy') AS joy,"
                                                        + "(SELECT count(*) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE `date` = '" + str + "' and hour='" + hour + "' and mood = 'sadness') AS sadness,"
                                                        + "(SELECT count(*) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE `date` = '" + str + "' and hour='" + hour + "' and mood = 'surprised') AS surprised,"
                                                        + "(SELECT count(*) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE `date` = '" + str + "' and hour='" + hour + "' and mood = 'anger') AS anger,"
                                                        + "(SELECT count(*) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE `date` = '" + str + "' and hour='" + hour + "' and mood = 'disgusted') AS disgusted";
                                // tell the DataAdapter to use the cmd
                                da1.SelectCommand = cmd;
                                // returns the results
                                da1.Fill(ds1, "mood");
                            }

                            // get the length, incase some number missing between minX and maxX
                            cmd.CommandText = "SELECT count(distinct(hour)) AS maxLength FROM tagsretrievedtemp WHERE date = '" + str + "';";
                            int length = int.Parse(cmd.ExecuteScalar().ToString());
                            // tell the DataAdapter to use the cmd
                            da2.SelectCommand = cmd;
                            // returns the results
                            da2.Fill(ds2, "maxLength");
                        }
                        // close the connection
                        cn.Close();
                    }
                }
            }

            // loop throught the datarows in the DataTable 
            // fetch all the data and pump them into list
            foreach (DataRow dr in ds.Tables["Rate"].Rows)
            {
                LineChart linechart = new LineChart();
                linechart.Hour = dr["hour"].ToString();
                linechart.Frequency = dr["frequency"].ToString();
                linechartList.Add(linechart);
            }
            if (maxX != 0)
            {
                foreach (DataRow dr in ds1.Tables["mood"].Rows)
                {
                    LineChart linechart = new LineChart();
                    linechart.Joy = dr["joy"].ToString();
                    linechart.Sadness = dr["sadness"].ToString();
                    linechart.Surprised = dr["surprised"].ToString();
                    linechart.Anger = dr["anger"].ToString();
                    linechart.Disgusted = dr["disgusted"].ToString();
                    linechartList.Add(linechart);
                }

                foreach (DataRow dr in ds2.Tables["maxLength"].Rows)
                {
                    LineChart linechart = new LineChart();
                    linechart.MaxLength = dr["maxLength"].ToString();
                    linechartList.Add(linechart);
                }
            }
            else if (maxX == 0)
            {
                LineChart linechart = new LineChart();
                linechart.MaxLength = "0";
                linechartList.Add(linechart);
            }
            
            return linechartList;
        }

 
        // private instance variable
        private string _Hour = "";
        private string _Frequency = "";

        private string _Joy = "";
        private string _Anger = "";
        private string _Sadness = "";
        private string _Surprised = "";
        private string _Disgusted = "";

        private string _MaxLength = "";

        // setters and getters
        public string Hour { get { return _Hour; } set { _Hour = value; } }
        public string Frequency { get { return _Frequency; } set { _Frequency = value; } }
        public string Joy { get { return _Joy; } set { _Joy = value; } }
        public string Anger { get { return _Anger; } set { _Anger = value; } }
        public string Sadness { get { return _Sadness; } set { _Sadness = value; } }
        public string Surprised { get { return _Surprised; } set { _Surprised = value; } }
        public string Disgusted { get { return _Disgusted; } set { _Disgusted = value; } }
        public string MaxLength { get { return _MaxLength; } set { _MaxLength = value; } }

    }
}
