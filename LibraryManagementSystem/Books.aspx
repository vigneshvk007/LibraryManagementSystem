<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Books.aspx.cs" Inherits="LibraryManagementSystem.Books" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2>Books</h2>
    </div>
    <div>  
            <asp:Label ID="lblName" runat="server">Book Name</asp:Label>  
            <asp:TextBox ID="txtName" runat="server" ToolTip="Enter Book Name"></asp:TextBox>  
            <asp:HiddenField ID="hdnId" runat="server" />
            <asp:Label ID="lblAuthor" runat="server">Author</asp:Label>
            <asp:DropDownList ID="ddlAuthor" runat="server">
                <asp:ListItem Value="">Select All</asp:ListItem>
            </asp:DropDownList> 
            <asp:Label ID="lblPublisher" runat="server">Publisher</asp:Label>
            <asp:DropDownList ID="ddlPublisher" runat="server"> 
                <asp:ListItem Value="">Select All</asp:ListItem>
            </asp:DropDownList>  
            
        </div>  
        <p>  
        <asp:Button ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" />  
        </p>  
        <br />
    
    <asp:Repeater ID="rptAuthor" onitemcommand="repBookDetails_ItemCommand" runat="server">
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
                    <b>Author</b>
                </td>
                <td>
                    <b>Publisher</b>
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
               <%# Eval("Author") %>
            </td>
            <td>
                <%# Eval("Publisher") %>
            </td>
            
            <td><asp:imagebutton id="imgBtnEdit" commandname="Edit" tooltip="Edit a record." commandargument='<%#Eval("Book_Id") %>' runat="server" imageurl="././edit.png"></asp:imagebutton>
                            <asp:imagebutton tooltip="Delete a record." onclientclick="javascript:return confirm('Are you sure to delete record?')" id="imgBtnDelete" commandname="Delete" commandargument='<%#Eval("Book_Id") %>' runat="server" imageurl="delete.png">
           </asp:imagebutton></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>
</asp:Content>

