<%@ Page Title="Home Page" Language="C#"  AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LibraryManagementSystem._Default" %>



<html>
<form runat="server">
   <body>
       <div>  
            <asp:Label ID="labelId" runat="server">User Name</asp:Label>  
            <asp:TextBox ID="UserName" runat="server" ToolTip="Enter User Name"></asp:TextBox>  
            <asp:Label ID="label1" runat="server">Password</asp:Label>  
            <asp:TextBox ID="Password" runat="server" ToolTip="Enter Password"></asp:TextBox>
        </div>  
        <p>  
        <asp:Button ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" />  
        </p>  
        <br />  
       </body>
    </form>
    </html>
   

