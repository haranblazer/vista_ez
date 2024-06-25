using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class admin_admincheckmail : System.Web.UI.Page
{
    SqlConnection cn = new SqlConnection(method.str);
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string gvIDs = "";
        bool chkBox = false;

        foreach (GridViewRow gv in GridView1.Rows)
        {
            CheckBox deleteChkBxItem = (CheckBox)gv.FindControl("deleteRec");
            if (deleteChkBxItem.Checked)
            {
                chkBox = true;

                gvIDs += ((Label)gv.FindControl("EmpID")).Text.ToString() + ",";
            }
        }


      
        if (chkBox)
        {

            try
            {
                string deleteSQL = "DELETE from MailMst WHERE Name IN ('" +
                  gvIDs.Substring(0, gvIDs.LastIndexOf(",")) + "')";
               cmd = new SqlCommand(deleteSQL, cn);
                cn.Open();
                cmd.ExecuteNonQuery();

                string strSe = "Select * from MailMst";
                SqlDataAdapter da = new SqlDataAdapter(strSe, cn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = null;

                GridView1.DataBind();

            }
            catch (SqlException err)
            {
                Response.Write(err.Message.ToString());
            }
            finally
            {
                cn.Close();
            }

        }
    }



}
