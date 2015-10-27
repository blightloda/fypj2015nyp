using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class BarChart
    {
        public string mood { get; set; }
        public int frequency { get; set; }
        public BarChart(string mood, int frequency)
        {
            this.mood = mood;
            this.frequency = frequency;
        }
        public List<BarChart> getBarChart(string tid)
        {
            List<BarChart> bclist = new List<BarChart>();
            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    // obtain connection string information from app.config
                    cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                    // tell the cmd to use the cn
                    cmd.Connection = cn;
                    // supply the cmd with the necessary SQL Y-M-D FULL
                    cmd.CommandText = "SELECT * FROM contentsretrievedtemp WHERE tagId = '" + tid + "'";
                    //testing/print out sqlquery
                    System.Diagnostics.Debug.WriteLine(cmd.CommandText);
                    cn.Open();
                    // returns the results
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            BarChart bc = new BarChart(reader.GetString("mood"), reader.GetInt16("frequency"));
                            bclist.Add(bc);
                        }
                    }

                }
            }
            return bclist;
        }
    }
}
