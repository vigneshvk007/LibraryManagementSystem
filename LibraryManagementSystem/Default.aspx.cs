using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryManagementSystem
{
    public partial class _Default : Page
    {

        SqlConnection sqlCon = null;
        string connctnstring = DbConnection.ConnectionString();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if(!IsPostBack)
                //checkSessionstate();
            
        }
        //public void checkSessionstate()
        //{
        //    if (Session["UserType"] != null)
        //    {
        //            HttpContext.Current.Response.Redirect("~/Dashboard");
        //    }
            
        //}
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            
            string User = UserName.Text;
            string pass = Password.Text;


            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_CheckLoginStatus", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@UserName", SqlDbType.NVarChar).Value = User;
                sql_cmnd.Parameters.AddWithValue("@Password", SqlDbType.NVarChar).Value = pass;
                SqlDataReader reader=sql_cmnd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        Session["UserId"] = reader[0].ToString();
                        Session["UserType"] = reader[1].ToString();
                        HttpContext.Current.Response.Redirect("~/Dashboard");
                        
                    }
                }
                sqlCon.Close();
            }

        }
        //[WebMethod]
        //public static void clearsession()
        //{
        //    Page.Session ses = new Page.Session();
        //    Session.Clear();
        //}
        
    }
}