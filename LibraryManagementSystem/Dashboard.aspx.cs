using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryManagementSystem
{
    public partial class Dashboard : System.Web.UI.Page
    {
        
        
        SqlConnection sqlCon = null;
        string connctnstring = DbConnection.ConnectionString();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                bindAuthor();
                bindPublisher();
                this.BindAllBooks(sender, e);
                checkSessionstate();
            }
        }
        public void checkSessionstate()
        {
            if (Session["UserType"] != null) { 
            string usertype = Session["UserType"].ToString();   
            if (usertype == "1")
                AddButton.Visible = false;
            }
            else
            {
                HttpContext.Current.Response.Redirect("~/Default");
            }
        }
        protected void bindAuthor()
        {
            sqlCon = new SqlConnection(connctnstring);
            string com = "Select * from LMS_tbl_Author where IsDeleted=0";
            SqlDataAdapter adpt = new SqlDataAdapter(com, sqlCon);
            DataTable dt = new DataTable();
            adpt.Fill(dt);
            ddlAuthor.DataSource = dt;
            ddlAuthor.DataTextField = "Name";
            ddlAuthor.DataValueField = "Name";
            ddlAuthor.DataBind();
            ddlAuthor.Items.Insert(0, new ListItem("-- Select one--", ""));
        }
        protected void bindPublisher()
        {
            sqlCon = new SqlConnection(connctnstring);
            string com = "Select * from LMS_tbl_Publisher where IsDeleted=0";
            SqlDataAdapter adpt = new SqlDataAdapter(com, sqlCon);
            DataTable dt = new DataTable();
            adpt.Fill(dt);
            ddlPublisher.DataSource = dt;
            ddlPublisher.DataTextField = "Name";
            ddlPublisher.DataValueField = "Name";
            ddlPublisher.DataBind();
            ddlPublisher.Items.Insert(0, new ListItem("-- Select one--", ""));
        }
        protected void AddButton_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Response.Redirect("~/Books");
        }
        protected void BindAllBooks(object sender, EventArgs e)
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_SearchBook", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Name", SqlDbType.VarChar).Value = txtName.Text;
                sql_cmnd.Parameters.AddWithValue("@Author", SqlDbType.VarChar).Value = ddlAuthor.SelectedValue;
                sql_cmnd.Parameters.AddWithValue("@Publisher", SqlDbType.VarChar).Value = ddlPublisher.SelectedValue;
                SqlDataReader reader = sql_cmnd.ExecuteReader();
                var dt = new DataTable();
                dt.Load(reader);
                rptAuthor.DataSource = dt;
                rptAuthor.DataBind();
                sqlCon.Close();
            }
        }
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            BindAllBooks(sender, e);
        }
        protected void repBookDetails_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case ("Lend"):
                    int id = Convert.ToInt32(e.CommandArgument);
                    LendBook(id);
                    break;
                
            }
        }
        protected void LendBook(int id)
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_LendBook", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.Int).Value = id;

                SqlDataReader reader = sql_cmnd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        if (reader[0].ToString() == "Success")
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Lended Successfully');", true);
                        else
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Sorry, the book is already lended');", true);
                    }
                }
                sqlCon.Close();
            }
        }
    }
}