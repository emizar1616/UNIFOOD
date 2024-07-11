<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Restaurants.aspx.cs" Inherits="Food_Ordering_Project.Admin.Restaurants" %>
<%@ Import Namespace="Food_Ordering_Project" %>
<asp:Content ID="Contente" ContentPlaceHolderID="head" runat="server">
    <script>
        /*For disappearing alert message*/
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
              }, seconds * 1000);
        };
    </script>
     <script>
         function ImagePreview(input) {
             if (input.files && input.files[0]) {
                 var reader = new FileReader();
                 reader.onload = function (e) {
                     $('#<%=imgRestaurant.ClientID%>').prop('src', e.target.result)
                         .width(200)
                         .height(200);
                 };
                 reader.readAsDataURL(input.files[0]);
             }
         }
     </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pcoded-inner-content pt-0">
        <div class="align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-4 col-lg-4">
                                            <h4 class="sub-title">Restaurants</h4>
                                            <div>
                                                <div class="form-group">
                                                    <label>Restaurant Name</label>
                                                    <div>
                                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                                            placeholder="Enter Restaurant Name"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" 
                                                            ErrorMessage="Name is required" SetFocusOnError="true" Display="Dynamic" 
                                                            ControlToValidate="txtName">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Restaurant Username</label>
                                                    <div>
                                                        <asp:TextBox ID="TextUsername" runat="server" CssClass="form-control"
                                                            placeholder="Enter Restaurant username for login" TextMode="MultiLine"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" 
                                                            ErrorMessage="username is required" SetFocusOnError="true" Display="Dynamic" 
                                                            ControlToValidate="TextUsername">
                                                        </asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Restaurant phone number</label>
                                                    <div>
                                                        <asp:TextBox ID="TextMobile" runat="server" CssClass="form-control"
                                                            placeholder="Enter Restaurant mobile phone number" TextMode="MultiLine"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" 
                                                            ErrorMessage="number is required" SetFocusOnError="true" Display="Dynamic" 
                                                            ControlToValidate="TextMobile">
                                                        </asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Restaurant email</label>
                                                    <div>
                                                        <asp:TextBox ID="TextEmail" runat="server" CssClass="form-control"
                                                            placeholder="Enter Restaurant email" TextMode="MultiLine"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red" 
                                                            ErrorMessage="email is required" SetFocusOnError="true" Display="Dynamic" 
                                                            ControlToValidate="TextEmail">
                                                        </asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Restaurant address</label>
                                                    <div>
                                                        <asp:TextBox ID="TextAddress" runat="server" CssClass="form-control"
                                                            placeholder="Enter Restaurant address" TextMode="MultiLine"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red" 
                                                            ErrorMessage="address is required" SetFocusOnError="true" Display="Dynamic" 
                                                            ControlToValidate="TextAddress">
                                                        </asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Restaurant Description</label>
                                                    <div>
                                                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"
                                                            placeholder="Enter Restaurant Description" TextMode="MultiLine"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" 
                                                            ErrorMessage="Description is required" SetFocusOnError="true" Display="Dynamic" 
                                                            ControlToValidate="txtDescription">
                                                        </asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Restaurant Password</label>
                                                    <div>
                                                        <asp:TextBox ID="TextPassword" runat="server" CssClass="form-control"
                                                            placeholder="Enter Restaurant password for login" TextMode="MultiLine"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red" 
                                                            ErrorMessage="password is required" SetFocusOnError="true" Display="Dynamic" 
                                                            ControlToValidate="TextPassword">
                                                        </asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                
              

                                                <div class="form-group">
                                                    <label>Restaurant Image</label>
                                                    <div>
                                                        <asp:FileUpload ID="fuRestaurantImage" runat="server" CssClass="form-control" 
                                                            onchange="ImagePreview(this);"/>
                                                    </div>
                                                </div>
                                                <div class="pb-5">
                                                    <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-primary"
                                                        OnClick="btnAddOrUpdate_Click" />
                                                    &nbsp;
                                                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary"
                                                        OnClick="btnClear_Click" CausesValidation="false" />
                                                </div>
                                                <div>
                                                    <asp:Image ID="imgRestaurant" runat="server" CssClass="img-thumbnail" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                            <h4 class="sub-title">Restaurant Lists</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Repeater ID="rRestaurant" runat="server" OnItemCommand="rRestaurant_ItemCommand">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Name</th>
                                                                        <th>Image</th>
                                                                        <th>Username</th>
                                                                        <th>Email</th>
                                                                        <th>CreatedDate</th>
                                                                        <th class="datatable-nosort">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>

                                                            <tr>
                                                                <td class="table-plus"><%# Eval("Name") %></td>
                                                                <td>
                                                                    <img width="40" src="<%# Utils.GetImageUrl( Eval("ImageUrl")) %>" 
                                                                        alt='<%# Eval("ImageUrl") %>'>
                                                                </td>
                                                                <td><%# Eval("Username") %></td>
                                                                <td><%# Eval("CreatedDate") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                        CommandArgument='<%# Eval("RestaurantId") %>' CommandName="edit" 
                                                                        CausesValidation="false">
                                                                            <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CssClass="badge bg-danger" CommandArgument='<%# Eval("RestaurantId") %>'
                                                                        OnClientClick="return confirm('Do you want to delete this product?');" 
                                                                        CausesValidation="false">
                                                                            <i class="ti-trash"></i>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

