using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Collections;
using System.Data;
namespace TrendSensor2013
{
    public partial class mysql : System.Web.UI.Page
    {
        public ArrayList result = new ArrayList();
        protected void Page_Load(object sender, EventArgs e)
        {
            MySqlConnection conn = new MySqlConnection();
            conn.ConnectionString = "server=localhost; userid=root; password=; database=twitter_stream;";
            MySqlCommand cmd = new MySqlCommand();
            cmd.Connection = conn;
            cmd.CommandText = "SELECT * FROM contentsretrievedtemp;";
            conn.Open();
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
            adapter.Fill(table);
            foreach (DataRow row in table.Rows)
            {
                string content = row["content"].ToString();
                result.Add(content);
            }
        }
    }
}