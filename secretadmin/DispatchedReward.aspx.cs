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

public partial class SIMadmin_DispatchedReward : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    DataTable t = new DataTable();
    DataTable dt = new DataTable();
 
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (!IsPostBack)
        {
            getData();
        }

    }

   
    public void BindData(int aRank)
    {
        {
            da = new SqlDataAdapter("rewardlist", con);
            da.SelectCommand.Parameters.AddWithValue("@type", "da");
            da.SelectCommand.Parameters.AddWithValue("@awardRank", aRank);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.Fill(dt);
            Label3.Text = dt.Rows.Count.ToString();
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        getData();
    }
    public void getData()
    {
        
        if (rdbtnDVDPlayer.Checked)
        {

            BindData(1);

        }
        else if (rdbtnDigitalCamera.Checked)
        {

            BindData(2);
        }

        else if (rdbtnRefrigrator.Checked)
        {

            BindData(3);

        }



        else if (rbtnLaptop.Checked)
        {

            BindData(4);

        }
        else if (rdbtnBike.Checked)
        {

            BindData(5);

        }
        else if (rbtnNanoCar.Checked)
        {

            BindData(6);

        }
        else if (rbtnAltoSparkCar.Checked)
        {

            BindData(7);

        }
        else if (rbtnSwift.Checked)
        {

            BindData(8);

        }
        else if (rbtnSkoda.Checked)
        {

            BindData(9);

        }
        else if (rbtnMerceces.Checked)
        {

            BindData(10);

        }
        else if (rbtnCash.Checked)
        {

            BindData(11);

        }
        else
        {
            Label1.Text = "Please Select Any One option!";
            Label1.Visible = true;
        }
    }
   
    protected void Button3_Click(object sender, EventArgs e)
    {

        GridView1.PageSize = Convert.ToInt32(Label3.Text);
     

        Response.Clear();

        Response.AddHeader("content-disposition", "attachment;filename=Dispatchedrewards.xls");

        Response.Charset = "";

        // If you want the option to open the Excel file without saving than

        // comment out the line below

        // Response.Cache.SetCacheability(HttpCacheability.NoCache);

        Response.ContentType = "application/vnd.xls";

        System.IO.StringWriter stringWrite = new System.IO.StringWriter();

        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

        GridView1.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());

        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
   
}
