<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Restaurant.aspx.cs" Inherits="Food_Ordering_Project.User.Restaurant" %>
<%@ Import Namespace="Food_Ordering_Project" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="food_section layout_padding" style="background-image: url('../Images/chefCap3.png'); width: 100%; height:100%; background-repeat:no-repeat; 
            background-size: contain; background-attachment:fixed; background-position:left">
        <div class="container">
            <div class="h   eading_container heading_center">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <h2>Restaurants
                </h2>
            </div>

            <div class="filters-content">
                <div class="row grid">
                    <asp:Repeater ID="rRestaurants" runat="server">
                        <ItemTemplate>
                            <div class="col-sm-6 col-lg-4">
                                <div class="box">
                                    <div>
                                        <div class="img-box">
                                            <img src="<%#Utils.GetImageUrl( Eval("ImageUrl")) %>" alt="">
                                        </div>
                                        <div class="detail-box">
                                            <h5><%# Eval("Name") %></h5>
                                            <p>
                                                <%# Eval("Description") %>
                                            </p>
                                                <a href="Menu.aspx?id=<%#Eval("RestaurantId")%>">Menu</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
            </div>

        </div>
    </section>
</asp:Content>
