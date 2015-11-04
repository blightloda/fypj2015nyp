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
    public class Tweets
    {

        public List<Tweets> getRelatedTweets(string keyword, string date, string hour)
        {
            // empty list
            List<Tweets> tweetList = new List<Tweets>();
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
                        cmd.CommandText = "SELECT * FROM tagsretrievedtemp tR INNER JOIN contentsretrievedtemp cT ON tR.tagId = cT.tagId WHERE tag = '" + keyword 
                            + "'and date='" + date 
                            + "' and hour='" + hour
                            + "'ORDER BY hour DESC;";
                        // tell the DataAdapter to use the cmd
                        da.SelectCommand = cmd;
                        // open an active connection
                        cn.Open();
                        // returns the results
                        da.Fill(ds, "relatedTweets");
                    }
                    // close the connection
                    cn.Close();
                }
            }

            // loop throught the datarows in the DataTable 
            // fetch all the data and pump them into list
            foreach (DataRow dr in ds.Tables["relatedTweets"].Rows)
            {
                Tweets tweets = new Tweets();
                tweets.Mood = dr["mood"].ToString();
                tweets.Content = dr["content"].ToString();
                tweetList.Add(tweets);
            }
            return tweetList;
        }

        // private instance variable
        private string _Mood = "";
        private string _Content = "";

        // setters and getters
        public string Mood { get { return _Mood; } set { _Mood = value; } }
        public string Content { get { return _Content; } set { _Content = value; } }
    }
}
