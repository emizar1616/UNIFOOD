<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Food_Ordering_Project.User.About" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <!-- about section -->

  <section class="about_section layout_padding">
    <div class="container  ">
      <div class="row">
        <div class="col-md-6 ">
          <div class="img-box">
            <img src="../UserFiles/images/unifood.jpeg" alt="">
          </div>
        </div>
        <div class="col-md-6">
          <div class="detail-box">
            <div class="heading_container">
              <h2>
                About UNIFOOD
              </h2>
            </div>
            <p>
              UNIFOOD is a web-based application that facilitates the seamless browsing and ordering of meals from various restaurants.
              By providing users with a platform to explore restaurants, view menus, and place orders, it enhances the dining experience by combining convenience and variety.
              The application boasts an intuitive interface and is equipped with features for user registration and login. Administrators can manage restaurant information, while end-users can effortlessly browse through listed restaurants, read descriptions, and view images before making informed decisions on their orders. Ultimately, UNIFOOD  serves as a bridge connecting food lovers with restaurants, promoting a more efficient and pleasurable dining experience.
            </p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- end about section -->

</asp:Content>
