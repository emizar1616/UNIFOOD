using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Food_Ordering_Project.User
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con,con2;
        SqlCommand cmd,cmd2;
        SqlDataAdapter sda,sda2;
        DataTable dt,dt2;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtUsername.Text.Trim() == "Admin" & txtPassword.Text.Trim() == "123")
            {
                Session["admin"] = txtUsername.Text.Trim();
                Response.Redirect("../Admin/Dashboard.aspx");
            }
            else
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT4LOGIN");
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                if(dt.Rows.Count == 1)
                {
                    Session["username"] = txtUsername.Text.Trim();
                    Session["userId"] = dt.Rows[0]["UserId"];
                    //teacher control
                    con2 = new SqlConnection(Connection.GetConnectionString());
                    cmd2 = new SqlCommand("User_Crud", con2);
                    cmd2.Parameters.AddWithValue("@Action", "ISTEACHER");
                    cmd2.Parameters.AddWithValue("@UserId", Session["userId"]);
                    cmd2.CommandType = CommandType.StoredProcedure;
                    sda2 = new SqlDataAdapter(cmd2);
                    dt2 = new DataTable();
                    sda2.Fill(dt2);
                    if (dt2.Rows.Count == 1)
                    {
                        Session["teacher"] = "teacher card";
                    }
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    con2 = new SqlConnection(Connection.GetConnectionString());
                    cmd2 = new SqlCommand("Restaurant_Crud", con2);
                    cmd2.Parameters.AddWithValue("@Action", "SELECT4LOGIN");
                    cmd2.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd2.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    cmd2.CommandType = CommandType.StoredProcedure;
                    sda2 = new SqlDataAdapter(cmd2);
                    dt2 = new DataTable();
                    sda2.Fill(dt2);
                    if (dt2.Rows.Count == 1)
                    {
                        Session["username"] = txtUsername.Text.Trim();
                        Session["RestaurantId"] = dt2.Rows[0]["RestaurantId"];
                        Response.Redirect("../Restaurant/Dashboard.aspx");

                    }
                    else
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Invalid Credentials..!";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
            }
        }

    }
}