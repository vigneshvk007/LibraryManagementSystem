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
    public partial class User : System.Web.UI.Page
    {
        SqlConnection sqlCon = null;
        string connctnstring = DbConnection.ConnectionString();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.BindAllUser();
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
        protected void BindAllUser()
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_GetAllUser", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.Int).Value = 0;
                SqlDataReader reader = sql_cmnd.ExecuteReader();
                var dt = new DataTable();
                dt.Load(reader);
                rptCustomers.DataSource = dt;
                rptCustomers.DataBind();
                sqlCon.Close();
            }
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string id = hdnId.Value;
            if (id == "")
                id = "0";
            string Name = txtName.Text;
            string UserName = txtUserName.Text;
            string Password = txtPassword.Text;
            string PhoneNumber = txtPhoneNumber.Text;

            if (Name == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter name');", true);
                return;
            }
            if (UserName == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter UserName');", true);
                return;
            }
            if (Password == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter Password');", true);
                return;
            }
            if (PhoneNumber == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter PhoneNumber');", true);
                return;
            }

            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_SaveUser", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.NVarChar).Value = id;
                sql_cmnd.Parameters.AddWithValue("@Name", SqlDbType.NVarChar).Value = Name;
                sql_cmnd.Parameters.AddWithValue("@PhoneNumber", SqlDbType.BigInt).Value = PhoneNumber;
                sql_cmnd.Parameters.AddWithValue("@UserName", SqlDbType.NVarChar).Value = UserName;
                sql_cmnd.Parameters.AddWithValue("@Password", SqlDbType.NVarChar).Value = Password;
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
                        else if(reader[0].ToString() == "update")
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
            BindAllUser();
        }
        protected void clearfields()
        {
            hdnId.Value = "";
            txtUserName.Text = "";
            txtPassword.Text = "";
            txtName.Text = "";
            txtPhoneNumber.Text = "";
        }
        protected void repEmployeeDetails_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case ("Delete"):
                    int id = Convert.ToInt32(e.CommandArgument);
                    deleteUser(id);
                    break;
                case ("Edit"):
                    id = Convert.ToInt32(e.CommandArgument);
                    bindUserDetailToEdit(id);
                    break;
            }
        }
        protected void deleteUser(int id)
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_DeleteUser", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.Int).Value = id;
                
                SqlDataReader reader = sql_cmnd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                       if(reader[0].ToString()=="Success")
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Deleted Successfully');", true);
                       else
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Unable to Delete');", true);
                    }
                }
                sqlCon.Close();
            }
            BindAllUser();
        }
        protected void bindUserDetailToEdit(int id)
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_GetAllUser", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.Int).Value = id;
                SqlDataReader reader = sql_cmnd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        hdnId.Value= reader[0].ToString();
                        txtUserName.Text = reader[1].ToString();
                        txtPassword.Text = reader[2].ToString();
                        txtName.Text = reader[3].ToString();
                        txtPhoneNumber.Text = reader[4].ToString();
                    }
                }
                sqlCon.Close();
            }
        }
    }
}