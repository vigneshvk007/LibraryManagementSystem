using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryManagementSystem
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btn_LogoutClick(object sender, EventArgs e)
        {
            Session.Abandon();
            HttpContext.Current.Response.Redirect("~/Default");
        }
    }
}