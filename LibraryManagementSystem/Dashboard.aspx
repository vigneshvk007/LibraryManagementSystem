﻿<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Site.Master" CodeBehind="Dashboard.aspx.cs" Inherits="LibraryManagementSystem.Dashboard" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2>DashBoard</h2>
    </div>

    <p>  
        <asp:Button ID="AddButton" runat="server" Text="Add/Edit Books" OnClick="AddButton_Click" />  
        </p>  
        <br />

    <div>  
            <asp:Label ID="lblName" runat="server">Search by Book Name</asp:Label>  
            <asp:TextBox ID="txtName" runat="server" ToolTip="Enter Book Name"></asp:TextBox>  
            <asp:Label ID="lblAuthor" runat="server">Search by Author</asp:Label>
            <asp:DropDownList ID="ddlAuthor" runat="server">
            </asp:DropDownList> 
            <asp:Label ID="lblPublisher" runat="server">Search by Publisher</asp:Label>
            <asp:DropDownList ID="ddlPublisher" runat="server"> 
            </asp:DropDownList>  
        </div>  
    <p>  
        <asp:Button ID="SubmitButton" runat="server" Text="Search" OnClick="SearchButton_Click" />  
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
                    <b>Lend</b>
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
            
            <td>
                            <asp:imagebutton tooltip="Lend the book" onclientclick="javascript:return confirm('Do you want to lend this book?')" id="imgBtnLender" commandname="Lend" commandargument='<%#Eval("Book_Id") %>' runat="server" imageurl="view.jpg">
           </asp:imagebutton></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>
</asp:Content>
