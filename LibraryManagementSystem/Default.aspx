<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LibraryManagementSystem._Default" %>



<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

   <form id="form1" runat="server"> 
       <div>  
            <asp:Label ID="labelId" runat="server">User Name</asp:Label>  
            <asp:TextBox ID="UserName" runat="server" ToolTip="Enter User Name"></asp:TextBox>  
        </div>  
        <p>  
        <asp:Button ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" />  
        </p>  
        <br />         
   </form>

</asp:Content>
