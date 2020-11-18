using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace LibraryManagementSystem
{
    public class DbConnection
    {
        public static string ConnectionString()
        {
            string Connectionstring = "Data Source = DESKTOP-OVU97QO; Initial Catalog = LibraryManagementSystem; Integrated Security = true";
            return Connectionstring;
        }
    }
}