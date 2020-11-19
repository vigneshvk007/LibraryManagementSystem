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
    public partial class Books : System.Web.UI.Page
    {
        SqlConnection sqlCon = null;
        string connctnstring = DbConnection.ConnectionString();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!this.IsPostBack)
            {
                bindAuthor();
                bindPublisher();
                this.BindAllBooks();
                checkSessionstate();
            }
            
                
        }
        public void checkSessionstate()
        {
            if (Session["UserType"] != null)
            {
                string usertype = Session["UserType"].ToString();
                if (usertype == "1")
                    HttpContext.Current.Response.Redirect("~/Dashboard");
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
            ddlAuthor.DataValueField = "Author_Id";
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
            ddlPublisher.DataValueField = "Publisher_Id";
            ddlPublisher.DataBind();
            ddlPublisher.Items.Insert(0, new ListItem("-- Select one--", ""));
        }
        protected void BindAllBooks()
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_GetAllBook", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.Int).Value = 0;
                SqlDataReader reader = sql_cmnd.ExecuteReader();
                var dt = new DataTable();
                dt.Load(reader);
                rptAuthor.DataSource = dt;
                rptAuthor.DataBind();
                sqlCon.Close();
            }
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string id = hdnId.Value;
            if (id == "")
                id = "0";
            string Name = txtName.Text;
            string Author = ddlAuthor.SelectedValue;
            string Publisher = ddlPublisher.SelectedValue;

            if (Name == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter name');", true);
                return;
            }
            if (Author == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please select Author');", true);
                return;
            }

            if (Publisher == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Select Publisher');", true);
                return;
            }

            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_SaveBook", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.NVarChar).Value = id;
                sql_cmnd.Parameters.AddWithValue("@Name", SqlDbType.NVarChar).Value = Name;
                sql_cmnd.Parameters.AddWithValue("@Author", SqlDbType.Int).Value = Author;
                sql_cmnd.Parameters.AddWithValue("@Publisher", SqlDbType.Int).Value = Publisher;
                SqlDataReader reader = sql_cmnd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        if (reader[0].ToString() == "save")
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Saved Successfully');", true);
                            clearfields();
                        }
                        else if (reader[0].ToString() == "update")
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Updated Successfully');", true);
                            clearfields();
                        }
                        else
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please try again');", true);
                    }
                }
                sqlCon.Close();
            }
            BindAllBooks();
        }
        protected void clearfields()
        {
            hdnId.Value = "";
            txtName.Text = "";
            ddlAuthor.SelectedValue = "";
            ddlPublisher.SelectedValue = "";
        }
        protected void repBookDetails_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case ("Delete"):
                    int id = Convert.ToInt32(e.CommandArgument);
                    deleteAuthor(id);
                    break;
                case ("Edit"):
                    id = Convert.ToInt32(e.CommandArgument);
                    bindAuthorDetailToEdit(id);
                    break;
            }
        }
        protected void deleteAuthor(int id)
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_DeleteBook", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.Int).Value = id;

                SqlDataReader reader = sql_cmnd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        if (reader[0].ToString() == "Success")
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Deleted Successfully');", true);
                        else
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Unable to Delete');", true);
                    }
                }
                sqlCon.Close();
            }
            BindAllBooks();
        }
        protected void bindAuthorDetailToEdit(int id)
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_GetAllBook", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.Int).Value = id;
                SqlDataReader reader = sql_cmnd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        hdnId.Value = reader[0].ToString();
                        txtName.Text = reader[1].ToString();
                        ddlAuthor.SelectedValue= reader[2].ToString();
                        ddlPublisher.SelectedValue= reader[3].ToString();
                    }
                }
                sqlCon.Close();
            }
        }
    }
}