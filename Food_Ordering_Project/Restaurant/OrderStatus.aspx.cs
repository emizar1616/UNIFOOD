using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Food_Ordering_Project.Restaurant
{
    public partial class OrderStatus : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        String rid;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["RestaurantId"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    Uri myUri = new Uri(Request.Url.ToString());
                    string param1 = HttpUtility.ParseQueryString(myUri.Query).Get("id");
                    rid = param1;
                    getOrderStatus();
                }
            }
            pUpdateOrderStatus.Visible = false;
        }

        private void getOrderStatus()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Invoice", con);
            cmd.Parameters.AddWithValue("@Action", "GETSTATU");
            cmd.Parameters.AddWithValue("@RestaurantId", rid);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rOrderStatus.DataSource = dt;
            rOrderStatus.DataBind();
        }

        protected void rOrderStatus_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "edit")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Invoice", con);
                cmd.Parameters.AddWithValue("@Action", "STATUSBYID");
                cmd.Parameters.AddWithValue("@OrderDetailsId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                ddlOrderStatus.SelectedValue = dt.Rows[0]["Status"].ToString();
                hdnId.Value = dt.Rows[0]["OrderDetailsId"].ToString();
                pUpdateOrderStatus.Visible = true;
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            int orderDetailsId = Convert.ToInt32(hdnId.Value);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Invoice", con);
            cmd.Parameters.AddWithValue("@Action", "UPDTSTATUS");
            cmd.Parameters.AddWithValue("@OrderDetailsId", orderDetailsId);
            cmd.Parameters.AddWithValue("@Status", ddlOrderStatus.SelectedValue);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Order status updated successfully!";
                lblMsg.CssClass = "alert alert-success";
                getOrderStatus();
            }
            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error- " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
            finally
            {
                con.Close();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pUpdateOrderStatus.Visible = false;
        }
    }
}