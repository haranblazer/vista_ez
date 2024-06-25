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
public partial class admin_rewards : System.Web.UI.Page
{
   
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
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
  
    public void chkme(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            if (((CheckBox)(GridView1.HeaderRow.Cells[6].FindControl("chkHeader"))).Checked == true)
            {
                ((CheckBox)(GridView1.Rows[i].Cells[6].FindControl("chkregno"))).Checked = true;
            }
            else
            {
                ((CheckBox)(GridView1.Rows[i].Cells[6].FindControl("chkregno"))).Checked = false;
            }
        }
    }
    public void BindData(int aRank)
    {
        {
            da = new SqlDataAdapter("rewardlist", con);
            da.SelectCommand.Parameters.AddWithValue("@type", "a");
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
        btnsendaward.Visible = true;
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
    protected void btnsendaward_Click(object sender, EventArgs e)
    {
        string grid = "";
        bool chk = false;

        foreach (GridViewRow gr in GridView1.Rows)
        {
            CheckBox deletechkbox = (CheckBox)gr.FindControl("chkregno");
            if (deletechkbox.Checked)
            {
                chk = true;
                grid = ((Label)gr.FindControl("lblcheckid")).Text.ToString();
                string srno = gr.Cells[0].Text;


                string strupdate = "update tblreward set isQualified=1,AwardDispatchDate=(dateadd(minute,(330),getutcdate())) where srno='" + srno + "' ";
                com = new SqlCommand(strupdate, con);
                con.Open();
                int a= com.ExecuteNonQuery();
                if (a>0)
                {
                    Label1.Text = "Approved Sucessfully";
                }
                else
                {
                    Label1.Text = "Error!!!";
                }
                con.Close();
              
            }
            
        }
        getData();
    }
  

    protected void Button3_Click(object sender, EventArgs e)
    {

        GridView1.PageSize = Convert.ToInt32(Label3.Text);
        GridView1.Columns[6].Visible = false;

        Response.Clear();

        Response.AddHeader("content-disposition", "attachment;filename=rewards.xls");

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
