﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryManagementSystem
{
    public partial class Publisher : System.Web.UI.Page
    {
        SqlConnection sqlCon = null;
        string connctnstring = DbConnection.ConnectionString();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.BindAllPublisher();
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
        protected void BindAllPublisher()
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_GetAllPublisher", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.Int).Value = 0;
                SqlDataReader reader = sql_cmnd.ExecuteReader();
                var dt = new DataTable();
                dt.Load(reader);
                rptPublisher.DataSource = dt;
                rptPublisher.DataBind();
                sqlCon.Close();
            }
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string id = hdnId.Value;
            if (id == "")
                id = "0";
            string Name = txtName.Text;
            string OwnerName = txtOwnerName.Text;
            string Address = txtAddress.Text;
            string PhoneNumber = txtPhoneNumber.Text;

            if (Name == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter name');", true);
                return;
            }
            if (OwnerName == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter owner name');", true);
                return;
            }
            if (Address == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter Address');", true);
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
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_SavePublisher", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.NVarChar).Value = id;
                sql_cmnd.Parameters.AddWithValue("@Name", SqlDbType.NVarChar).Value = Name;
                sql_cmnd.Parameters.AddWithValue("@OwnerName", SqlDbType.NVarChar).Value = OwnerName;
                sql_cmnd.Parameters.AddWithValue("@Address", SqlDbType.NVarChar).Value = Address;
                sql_cmnd.Parameters.AddWithValue("@PhoneNumber", SqlDbType.BigInt).Value = PhoneNumber;
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
            BindAllPublisher();
        }
        protected void clearfields()
        {
            hdnId.Value = "";
            txtAddress.Text = "";
            txtName.Text = "";
            txtOwnerName.Text = "";
            txtPhoneNumber.Text = "";
        }
        protected void repPublisherDetails_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case ("Delete"):
                    int id = Convert.ToInt32(e.CommandArgument);
                    deletePublisher(id);
                    break;
                case ("Edit"):
                    id = Convert.ToInt32(e.CommandArgument);
                    bindPublisherDetailToEdit(id);
                    break;
            }
        }
        protected void deletePublisher(int id)
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_DeletePublisher", sqlCon);
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
            BindAllPublisher();
        }
        protected void bindPublisherDetailToEdit(int id)
        {
            using (sqlCon = new SqlConnection(connctnstring))
            {
                sqlCon.Open();
                SqlCommand sql_cmnd = new SqlCommand("LMS_sp_GetAllPublisher", sqlCon);
                sql_cmnd.CommandType = CommandType.StoredProcedure;
                sql_cmnd.Parameters.AddWithValue("@Id", SqlDbType.Int).Value = id;
                SqlDataReader reader = sql_cmnd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        hdnId.Value = reader[0].ToString();
                        txtName.Text = reader[1].ToString();
                        txtOwnerName.Text = reader[2].ToString();
                        txtAddress.Text = reader[5].ToString();
                        txtPhoneNumber.Text = reader[3].ToString();
                    }
                }
                sqlCon.Close();
            }
        }
    }
}