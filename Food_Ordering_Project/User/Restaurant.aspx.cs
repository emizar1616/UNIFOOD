using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Food_Ordering_Project.User
{
    public partial class Restaurant : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getRestaurants();
            }
        }


        void getRestaurants()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("SELECT * FROM dbo.Restaurants", con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rRestaurants.DataSource = dt;
            rRestaurants.DataBind();
        }

        public string LowerCase(object obj)
        {
            return obj.ToString().ToLower();
        }

    }
}