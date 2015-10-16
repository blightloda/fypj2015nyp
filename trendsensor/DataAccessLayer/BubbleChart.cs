using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class BubbleChart
    {
        public string Tag { get; set; }
        //public List<int> MoodFrequency{ get; set; }
        public int[] MoodFrequency { get; set; }
        public BubbleChart()
        {

        }

        public BubbleChart(string Tag, int[] MoodFrequency)
        {
            this.Tag = Tag;
            this.MoodFrequency = MoodFrequency;
        }
        public List<BubbleChart> getOverallBubbleData(string date)
        {
            List<BubbleChart> bubbledata = new List<BubbleChart>();
            List<string> tags = new List<string>();
            List<string> tagids = new List<string>();
            List<int> mf = new List<int>();
            DataSet ds = new DataSet();
            int i = 0;
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
                        cmd.CommandText = "SELECT tag FROM tagsretrievedtemp WHERE date = '" + date + "'";
                        //testing/print out sqlquery
                        System.Diagnostics.Debug.WriteLine(cmd.CommandText);
                        // tell the DataAdapter to use the cmd
                        //da.SelectCommand = cmd;
                        // open an active connection
                        cn.Open();
                        // returns the results
                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                tags.Add(reader.GetString("tag"));
                            }
                        }

                        //foreach (string tag in tags)
                        //{
                        //    cmd.CommandText = "SELECT tagId FROM tagsretrievedtemp WHERE tag = '"+tag+"' AND date = '"+date+"'";
                        //    using (var reader = cmd.ExecuteReader())
                        //    {
                        //        while (reader.Read())
                        //        {
                        //            tagids.Add(reader.GetString("tagId"));
                        //        }
                        //    }
                        //}
                        foreach (string tag in tags)
                        {
                            cmd.CommandText = "SELECT count( * ) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE date = '" + date + "' AND mood = '-' AND tag = '" + tag + "'";
                            i = int.Parse(cmd.ExecuteScalar().ToString());

                            mf.Add(i);

                            cmd.CommandText = "SELECT count( * ) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE date = '" + date + "' AND mood = 'joy' AND tag = '" + tag + "'";
                            i = int.Parse(cmd.ExecuteScalar().ToString());

                            mf.Add(i);

                            cmd.CommandText = "SELECT count( * ) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE date = '" + date + "' AND mood = 'anger' AND tag = '" + tag + "'";
                            i = int.Parse(cmd.ExecuteScalar().ToString());

                            mf.Add(i);

                            cmd.CommandText = "SELECT count( * ) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE date = '" + date + "' AND mood = 'sadness' AND tag = '" + tag + "'";
                            i = int.Parse(cmd.ExecuteScalar().ToString());

                            mf.Add(i);

                            cmd.CommandText = "SELECT count( * ) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE date = '" + date + "' AND mood = 'surprised' AND tag = '" + tag + "'";
                            i = int.Parse(cmd.ExecuteScalar().ToString());

                            mf.Add(i);

                            cmd.CommandText = "SELECT count( * ) FROM tagsretrievedtemp tr INNER JOIN contentsretrievedtemp ct ON tr.tagId = ct.tagId WHERE date = '" + date + "' AND mood = 'disgusted' AND tag = '" + tag + "'";
                            i = int.Parse(cmd.ExecuteScalar().ToString());

                            mf.Add(i);

                            BubbleChart bc = new BubbleChart(tag, mf.ToArray());
                            bubbledata.Add(bc);
                            mf.Clear();

                        }
                    }
                }


                return bubbledata;
            }

        }
    }
}
