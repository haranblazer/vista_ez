using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using System.Drawing;

public partial class secretadmin_Title : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindData();
        }
    }

    public void BindData()
    {
        try
        {
            dt = new DataTable();
            con = new SqlConnection(method.str);
            da = new SqlDataAdapter("CurrentPayout", con);

            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@regno", Session["UserId"].ToString());
          
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lbldirect.Text = dt.Rows[0]["TotalCV"].ToString();
                lbldirectInc.Text = dt.Rows[0]["DirectInc"].ToString();
                //lblcvleft.Text = dt.Rows[0]["CVL"].ToString();
               // lblcvright.Text = dt.Rows[0]["CVR"].ToString();
                lblMaxBonus.Text = dt.Rows[0]["CurrentMatching"].ToString();
                lblMaxBonus1.Text = dt.Rows[0]["CurrentMatching"].ToString();
                lblMaxBonusInc.Text = dt.Rows[0]["BinaryIncome"].ToString();
                lblper1.Text = lblper.Text = dt.Rows[0]["Per"].ToString();

                lbl_Self_Per.Text =  dt.Rows[0]["Per"].ToString();
                lbl_SelfCV.Text = dt.Rows[0]["SelfCV"].ToString();
                lbl_Self_directInc.Text =  dt.Rows[0]["Self_Dir_Inc"].ToString();

                //lblTotalMatching.Text = dt.Rows[0]["TotalMatching"].ToString();
            }
        }
        catch
        {
        }
    }
}