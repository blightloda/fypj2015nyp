using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class CloudTag
    {
        public string tagid { get; set; }
        public string tag { get; set; }
        public string date { get; set; }
        public int hour { get; set; }
        public int frequency { get; set; }
        public string content { get; set; }
        public string mood { get; set; }
        public CloudTag() { }
        public CloudTag(string tagid, string tag, int frequency)
        {
            this.tagid = tagid;
            this.tag = tag;
            this.frequency = frequency;
        }

        public List<CloudTag> getCloudTag(string date,int hour)
        {
            List<CloudTag> ctlist = new List<CloudTag>();
            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    // obtain connection string information from app.config
                    cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                    // tell the cmd to use the cn
                    cmd.Connection = cn;
                    // supply the cmd with the necessary SQL Y-M-D FULL
                    cmd.CommandText = "SELECT * FROM tagsretrievedtemp WHERE date = '" + date + "' AND hour ="+hour+"";
                    //testing/print out sqlquery
                    System.Diagnostics.Debug.WriteLine(cmd.CommandText);
                    cn.Open();
                        // returns the results
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            CloudTag ct = new CloudTag(reader.GetString("tagId"), reader.GetString("tag"), reader.GetInt16("frequency"));
                            ctlist.Add(ct);
                        }
                    }
                    
                }
            }
            return ctlist;
        }

        public List<CloudTag> filterCloudTag(string date, string mood, int hour)
        {
            List<CloudTag> ctlist = new List<CloudTag>();
            using (MySqlConnection cn = new MySqlConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    string str = "";
                    //split mood
                    string[] moods = mood.Split(new[] { " " }, StringSplitOptions.None);
                    //rearrange string containing mood for sql query
                    string moo = moods[0];
                    for (int i = 1; i < moods.Length; i++)
                    {
                        moo += "' AND tr.hour="+hour+" OR tr.date = '"+date +"'AND cr.mood = '" + moods[i];
                    }
                    // obtain connection string information from app.config
                    cn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
                    // tell the cmd to use the cn
                    cmd.Connection = cn;
                    // supply the cmd with the necessary SQL Y-M-D FULL
                    str = "SELECT tag, tr.tagid, count( * ) AS frequency FROM `tagsretrievedtemp` tr INNER JOIN `contentsretrievedtemp` cr ON tr.tagId = cr.tagId WHERE tr.date = '" + date + "' AND cr.mood = '" + moo + "' AND tr.hour =" + hour + " GROUP BY tag";
                    System.Diagnostics.Debug.WriteLine(str);
                    cmd.CommandText = str;
                    
                    
                    //testing/print out sqlquery
                    System.Diagnostics.Debug.WriteLine(cmd.CommandText);
                    cn.Open();
                    

                    // returns the results
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            CloudTag ct = new CloudTag(reader.GetString("tagId"), reader.GetString("tag"), reader.GetInt16("frequency"));
                            ctlist.Add(ct);
                        }
                    }

                }
            }
            return ctlist;
        }
    }
}
