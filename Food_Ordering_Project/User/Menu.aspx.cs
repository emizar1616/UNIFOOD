using Food_Ordering_Project.Admin;
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
    public partial class Menu : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        String rid;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {

                //s = Request.QueryString("id");
                Uri myUri = new Uri(Request.Url.ToString());
                string param1 = HttpUtility.ParseQueryString(myUri.Query).Get("id");
                rid = param1;
                getRestaurant();
                getCategories();
                getProducts();
            }
        }

        void getRestaurant()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            var result = string.Format("SELECT * FROM dbo.Restaurants where RestaurantId={0}", rid);
            cmd = new SqlCommand(result, con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rRestaurants.DataSource = dt;
            rRestaurants.DataBind();
        }

        void getCategories()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            var result = string.Format("SELECT * FROM Categories where RestaurantId = {0} and IsActive = 1", rid);
            cmd = new SqlCommand(result, con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCategories.DataSource = dt;
            rCategories.DataBind();
        }

        void getProducts()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            var result = string.Format("Select p.* from Products p inner join Restaurants r on r.RestaurantId = {0} where p.IsActive = 1 and r.RestaurantId=p.RestaurantId", rid);
            cmd = new SqlCommand(result, con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rProducts.DataSource = dt;
            rProducts.DataBind();
        }
        void getAvgRating()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Select Avg(Rating) from Rating where ProductId = 3", con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            foreach (RepeaterItem item in rProducts.Items)
            {
                Label lbl = item.FindControl("AvgRating") as Label;
                lbl.Text = "hello";

            }
            rProducts.DataSource = dt;
            rProducts.DataBind();


        }
        public string LowerCase(object obj)
        {
            return obj.ToString().ToLower();
        }

        protected void rProducts_ItemdataBound(object sender, RepeaterItemEventArgs e)
        {
            HiddenField hdl = e.Item.FindControl("hdnProductId") as HiddenField;
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Rate_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GetAvg");
            cmd.Parameters.AddWithValue("@ProductId", hdl.Value);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error - " + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }
            double quantity = Convert.ToDouble(dt.Rows[0]["AvgRating"]);
            Label lbl = e.Item.FindControl("AvgRating") as Label;
            lbl.Text = "Rating:" + Convert.ToString(quantity);

        }

        protected void rProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

            if (Session["userId"] != null)
            {
                if (e.CommandName == "addToCart")
                {
                    bool isCartItemUpdated = false;
                    int i = isItemExistInCart(Convert.ToInt32(e.CommandArgument));
                    if (i == 0)
                    { //Adding new item in cart
                        con = new SqlConnection(Connection.GetConnectionString());
                        cmd = new SqlCommand("Cart_Crud", con);
                        cmd.Parameters.AddWithValue("@Action", "INSERT");
                        cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                        cmd.Parameters.AddWithValue("@Quantity", 1);
                        cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                        cmd.CommandType = CommandType.StoredProcedure;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            Response.Write("<script>alert('Error - " + ex.Message + "');</script>");
                        }
                        finally
                        {
                            con.Close();
                        }
                    }
                    else
                    { //Adding existing item in cart
                        Utils utils = new Utils();
                        isCartItemUpdated = utils.updateCartQuantity((i + 1), Convert.ToInt32(e.CommandArgument), Convert.ToInt32(Session["userId"]));
                    }

                    lblMsg.Visible = true;
                    lblMsg.Text = "Item added successfully in your cart!";
                    lblMsg.CssClass = "alert alert-success";
                    Response.AddHeader("REFRESH", "1;URL=Cart.aspx");
                }
                else if (e.CommandName == "addToFav")
                {
                    con = new SqlConnection(Connection.GetConnectionString());
                    cmd = new SqlCommand("Fav_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "INSERT");
                    cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error - " + ex.Message + "');</script>");
                    }
                    finally
                    {
                        con.Close();
                    }
                    lblMsg.Visible = true;
                    lblMsg.Text = "You have successfully added to favourite!";
                    String temptext = "1;URL=Menu.aspx?id=" + Convert.ToString(rid);
                    Response.AddHeader("REFRESH", temptext);
                }
                else if (e.CommandName == "rateProduct")
                {
                    con = new SqlConnection(Connection.GetConnectionString());
                    cmd = new SqlCommand("Rate_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "INSERT");
                    cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error - " + ex.Message + "');</script>");
                    }
                    finally
                    {
                        con.Close();
                    }
                }
                else if (e.CommandName == "SendRate")
                {
                    TextBox txt = e.Item.FindControl("txtRate") as TextBox;
                    con = new SqlConnection(Connection.GetConnectionString());
                    cmd = new SqlCommand("Rate_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "INSERT");
                    cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@Rating", txt.Text);
                    cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error - " + ex.Message + "');</script>");
                    }
                    finally
                    {
                        con.Close();
                    }
                    lblMsg.Visible = true;
                    lblMsg.Text = "You have successfully Rated!";
                    lblMsg.CssClass = "alert alert-success";
                    String temptext = "1;URL=Default.aspx?id=" + Convert.ToString(rid);
                    Response.AddHeader("REFRESH", temptext);
                }

            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "You need to login!";
                lblMsg.CssClass = "alert alert-danger";
                String temptext = "1;URL=Menu.aspx?id=" + Convert.ToString(rid);
                Response.AddHeader("REFRESH", temptext);
            }
    }

        int isItemExistInCart(int productId)
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            int quantity = 0;
            if(dt.Rows.Count > 0)
            {
                quantity = Convert.ToInt32(dt.Rows[0]["Quantity"]);
            }
            return quantity;
        }
    }
}