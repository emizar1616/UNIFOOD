using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Food_Ordering_Project.Admin
{
    public partial class Restaurants : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    getRestaurants();
                }
            }
            lblMsg.Visible = false;
        }

        private void getRestaurants()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Restaurant_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rRestaurant.DataSource = dt;
            rRestaurant.DataBind();
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int RestaurantId = Convert.ToInt32(hdnId.Value);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Restaurant_Crud", con);
            cmd.Parameters.AddWithValue("@Action", RestaurantId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@RestaurantId", RestaurantId);
            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Username", TextUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@Mobile", TextMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", TextEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Address", TextAddress.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", TextPassword.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());

            if (fuRestaurantImage.HasFile)
            {
                if (Utils.IsValidExtension(fuRestaurantImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuRestaurantImage.FileName);
                    imagePath = "Images/Product/" + obj.ToString() + fileExtension;
                    fuRestaurantImage.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + obj.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                    isValidToExecute = true;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Please select .jpg, .jpeg or .png image";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExecute = false;
                }
            }
            else
            {
                isValidToExecute = true;
            }

            if (isValidToExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = RestaurantId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Restaurant " + actionName + " successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    getRestaurants();
                    clear();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error-" + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void rRestaurant_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "edit")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Restaurant_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@RestaurantId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtName.Text = dt.Rows[0]["Name"].ToString();
                txtDescription.Text = dt.Rows[0]["Description"].ToString();
                TextUsername.Text = dt.Rows[0]["Username"].ToString();
                TextMobile.Text = dt.Rows[0]["Mobile"].ToString();
                TextEmail.Text = dt.Rows[0]["Email"].ToString();
                TextAddress.Text = dt.Rows[0]["Address"].ToString();
                TextPassword.Text = dt.Rows[0]["Password"].ToString();
                imgRestaurant.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ? "../Images/No_image.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
                imgRestaurant.Height = 200;
                imgRestaurant.Width = 200;
                hdnId.Value = dt.Rows[0]["RestaurantId"].ToString();
                btnAddOrUpdate.Text = "Update";
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
            else if (e.CommandName == "delete")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Restaurant_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@RestaurantId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Restaurant deleted successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    getRestaurants();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error : " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }


        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        void clear()
        {
            txtName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            TextEmail.Text = string.Empty;
            TextUsername.Text = string.Empty;
            TextMobile.Text = string.Empty;
            TextAddress.Text = string.Empty;
            TextPassword.Text = string.Empty;
            txtDescription.Text = string.Empty;
            hdnId.Value = "0";
            btnAddOrUpdate.Text = "Add";
        }
    }
}