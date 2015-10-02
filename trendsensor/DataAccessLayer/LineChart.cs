using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Data;

namespace DataAccessLayer
{
    public class LineChart
    {

        public List<LineChart> getLineChart(string str)
        {

            DataSet ds = new DataSet();
            // empty list
            List<LineChart> linechartList = new List<LineChart>();

            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand(), cmd1 = new MySqlCommand())
                {
                    using (MySqlDataAdapter da = new MySqlDataAdapter())
                    {
                        // obtain connection string information from app.config
                        cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                        // tell the cmd to use the cn
                        cmd.Connection = cn;
                        cmd1.Connection = cn;
                        // supply the cmd with the necessary SQL Y-M-D FULL
                        cmd.CommandText = "SELECT * FROM tagsretrievedtemp WHERE date = '" + str + "' GROUP BY date,hour;";
                        // get individual mood 
                        cmd1.CommandText = "";
                        //testing/print out sqlquery
                        System.Diagnostics.Debug.WriteLine(cmd.CommandText);
                        // tell the DataAdapter to use the cmd
                        da.SelectCommand = cmd;
                        // open an active connection
                        cn.Open();
                        // rrturns the results
                        da.Fill(ds, "Rate");
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
            return linechartList;
        }

        // private instance variable
        private string _Hour = "";
        private string _Frequency = "";

        // getters
        public string Hour { get { return _Hour; } set { _Hour = value; } }
        public string Frequency { get { return _Frequency; } set { _Frequency = value; } }

        //get keyword/tag
        public List<String> getKeyword(string date, string hour)
        {
            List<String> list = new List<String>();

            DataSet ds = new DataSet();

            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    using (MySqlDataAdapter da = new MySqlDataAdapter())
                    {
                        // obtain connection string information from app.config
                        cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                        // tell the cmd to use the cn
                        cmd.Connection = cn;
                        // supply the cmd with the necessary SQL Y-M-D FULL
                        cmd.CommandText = "SELECT tag FROM tagsretrievedtemp WHERE date = '" + date + "' and hour = " + hour + "";

                        //testing/print out sqlquery
                        System.Diagnostics.Debug.WriteLine(cmd.CommandText);
                        // tell the DataAdapter to use the cmd
                        da.SelectCommand = cmd;
                        // open an active connection
                        cn.Open();
                        // rrturns the results
                        da.Fill(ds, "tags");
                        // close the connection
                        cn.Close();
                    }
                }
            }
            foreach (DataRow row in ds.Tables["name"].Rows)
            {
                list.Add(row["companyName"].ToString());
            }
            return list;
        }
        //get frequency of mood
        public int getFrequencyJoy(string s)
        {
            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    using (MySqlDataReader Reader = cmd.ExecuteReader())
                    {
                        // obtain connection string information from app.config
                        cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                        // tell the cmd to use the cn
                        cmd.Connection = cn;
                        // supply the cmd with the necessary SQL Y-M-D FULL
                        cmd.CommandText = "SELECT count(*) FROM contentsretrievedtemp WHERE tag = '" + s + "' and mood = 'joy';";

                        //testing/print out sqlquery
                        System.Diagnostics.Debug.WriteLine(cmd.CommandText);

                        // open an active connection
                        cn.Open();
                        Int32 number = Convert.ToInt32(cmd.ExecuteScalar());
                        // close the connection
                        cn.Close();
                        return number;
                    }
                }
            }

        }
        public int getFrequencyAnger(string s)
        {
            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    using (MySqlDataReader Reader = cmd.ExecuteReader())
                    {
                        // obtain connection string information from app.config
                        cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                        // tell the cmd to use the cn
                        cmd.Connection = cn;
                        // supply the cmd with the necessary SQL Y-M-D FULL
                        cmd.CommandText = "SELECT count(*) FROM contentsretrievedtemp WHERE tag = '" + s + "' and mood = 'anger';";

                        //testing/print out sqlquery
                        System.Diagnostics.Debug.WriteLine(cmd.CommandText);

                        // open an active connection
                        cn.Open();
                        Int32 number = Convert.ToInt32(cmd.ExecuteScalar());
                        // close the connection
                        cn.Close();
                        return number;
                    }
                }
            }
        }

        public int getFrequencySadness(string s)
        {
            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    using (MySqlDataReader Reader = cmd.ExecuteReader())
                    {
                        // obtain connection string information from app.config
                        cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                        // tell the cmd to use the cn
                        cmd.Connection = cn;
                        // supply the cmd with the necessary SQL Y-M-D FULL
                        cmd.CommandText = "SELECT count(*) FROM contentsretrievedtemp WHERE tag = '" + s + "' and mood = 'sadness';";

                        //testing/print out sqlquery
                        System.Diagnostics.Debug.WriteLine(cmd.CommandText);

                        // open an active connection
                        cn.Open();
                        Int32 number = Convert.ToInt32(cmd.ExecuteScalar());
                        // close the connection
                        cn.Close();
                        return number;
                    }
                }
            }
        }
        public int getFrequencySurprised(string s)
        {
            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    using (MySqlDataReader Reader = cmd.ExecuteReader())
                    {
                        // obtain connection string information from app.config
                        cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                        // tell the cmd to use the cn
                        cmd.Connection = cn;
                        // supply the cmd with the necessary SQL Y-M-D FULL
                        cmd.CommandText = "SELECT count(*) FROM contentsretrievedtemp WHERE tag = '" + s + "' and mood = 'surprised';";

                        //testing/print out sqlquery
                        System.Diagnostics.Debug.WriteLine(cmd.CommandText);

                        // open an active connection
                        cn.Open();
                        Int32 number = Convert.ToInt32(cmd.ExecuteScalar());
                        // close the connection
                        cn.Close();
                        return number;
                    }
                }
            }
        }
        public int getFrequencyDisgusted(string s)
        {
            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    using (MySqlDataReader Reader = cmd.ExecuteReader())
                    {
                        // obtain connection string information from app.config
                        cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                        // tell the cmd to use the cn
                        cmd.Connection = cn;
                        // supply the cmd with the necessary SQL Y-M-D FULL
                        cmd.CommandText = "SELECT count(*) FROM contentsretrievedtemp WHERE tag = '" + s + "' and mood = 'disgusted';";

                        //testing/print out sqlquery
                        System.Diagnostics.Debug.WriteLine(cmd.CommandText);

                        // open an active connection
                        cn.Open();
                        Int32 number = Convert.ToInt32(cmd.ExecuteScalar());
                        // close the connection
                        cn.Close();
                        return number;
                    }
                }
            }
        }
    }
}
