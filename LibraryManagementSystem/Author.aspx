<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Author.aspx.cs" Inherits="LibraryManagementSystem.Author" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2>Author</h2>
    </div>
    <div>  
            <asp:Label ID="lblName" runat="server">Name</asp:Label>  
            <asp:TextBox ID="txtName" runat="server" ToolTip="Enter Name"></asp:TextBox>  
            <asp:HiddenField ID="hdnId" runat="server" />
            <asp:Label ID="lblAddress" runat="server">Address</asp:Label>
            <asp:TextBox ID="txtAddress" runat="server" ToolTip="Enter Address"></asp:TextBox>
            <asp:Label ID="lblPhoneNumber" runat="server">Phone Number</asp:Label>  
            <asp:TextBox ID="txtPhoneNumber" runat="server" ToolTip="Enter PhoneNumber"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                    ControlToValidate="txtPhoneNumber" runat="server"
                    ErrorMessage="Only Numbers allowed"
                    ValidationExpression="\d+">
            </asp:RegularExpressionValidator>
        </div>  
        <p>  
        <asp:Button ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" />  
        </p>  
        <br />
    
    <asp:Repeater ID="rptAuthor" onitemcommand="repAuthorDetails_ItemCommand" runat="server">
    <HeaderTemplate>
        <table id="tblUserDetails">
            <tr class="altRow">
                <td>
                    <b>Slno</b>
                </td>
                <td>
                    <b>Name</b>
                </td>
                <td>
                    <b>Address</b>
                </td>
                <td>
                    <b>Phone Number</b>
                </td>
                
                <td>
                    <b>Action</b>
                </td>
            </tr>
    </HeaderTemplate>
    <ItemTemplate>
        <tr >
            <td>
                <%#Container.ItemIndex+1%>
            </td>
            <td>
                <%# Eval("Name") %>
            </td>
            <td>
               <%# Eval("Address") %>
            </td>
            <td>
                <%# Eval("PhoneNumber") %>
            </td>
            
            <td><asp:imagebutton id="imgBtnEdit" commandname="Edit" tooltip="Edit a record." commandargument='<%#Eval("Author_Id") %>' runat="server" imageurl="././edit.png"></asp:imagebutton>
                            <asp:imagebutton tooltip="Delete a record." onclientclick="javascript:return confirm('Are you sure to delete record?')" id="imgBtnDelete" commandname="Delete" commandargument='<%#Eval("Author_Id") %>' runat="server" imageurl="delete.png">
           </asp:imagebutton></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>
</asp:Content>
