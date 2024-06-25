using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_Calc_title : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter sda;
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btn_cal_title_Click(object sender, EventArgs e)
    {
        try
        {
            com = new SqlCommand("Calculate_Rank", con);
            com.CommandType = CommandType.StoredProcedure;
           // com.Parameters.AddWithValue("@max1", "1");
            con.Open();
            com.CommandTimeout = 1900;
            com.ExecuteNonQuery();
            con.Close();
            utility.MessageBox(this, " Wow... Ranks Updated Successfully.");

        }
        catch { }
    }
}