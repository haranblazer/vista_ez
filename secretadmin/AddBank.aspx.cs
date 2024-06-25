using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_AddBank : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        try
        {

            cmd = new SqlCommand("insertBank", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@bankname", txtBankName.Text.Trim());
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            utility.MessageBox(this, "Submitted Successfully.");

        }
        catch
        {

        }
    }
}