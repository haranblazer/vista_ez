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
    int pair;
    string rewards = "0";
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader dr;
    SqlDataAdapter da;
    DataTable t = new DataTable();
    DataTable dt = new DataTable();
    DataTable t1;
    int strAwrdName;
    protected void Page_Load(object sender, EventArgs e)
    {
       // InsertFunction.CheckAdminlogin();
        if (!IsPostBack)
        {
           // btnsendaward.Visible = false;
            //putdata();
        }
    }
    public void BindData(int type)
    {
        {
            da = new SqlDataAdapter("DispatchRewardList", con);
            da.SelectCommand.Parameters.AddWithValue("@type", type);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.Fill(dt);
            Label2.Text = dt.Rows.Count.ToString();
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       
        if (rdbtnMobile.Checked)
        {
            //strAwrdName = "Mobile worth Rs. 3,000/-";
            //putdata1(strAwrdName);
            BindData(1);
           
        }
        else if (rdbtnLaptop.Checked)
        {
            //strAwrdName = "Laptop worth Rs. 20,000/-";
            //putdata1(strAwrdName);
            //btnsendaward.Visible = true;
            BindData(2);
        }

        else if (rdbtnBike.Checked)
        {
            //strAwrdName = "Bike worth Rs. 40,000/-";
            //putdata1(strAwrdName);
            //btnsendaward.Visible = true;
            BindData(3);

        }

      

        else if (rbtnAlto.Checked)
        {
            //strAwrdName = "Alto worth Rs. 2.00 lacs";
            //putdata1(strAwrdName);
            //btnsendaward.Visible = true;
            BindData(4);

        }
        else if (rdbtnFiesta.Checked)
        {
            //strAwrdName = "Fiesta worth Rs. 5.00 lacs";
            //putdata1(strAwrdName);
            //btnsendaward.Visible = true;
            BindData(5);

        }
        else if (rbtnHondaCity.Checked)
        {
            //strAwrdName = "Honda City worth Rs. 10.00 lacs";
            //putdata1(strAwrdName);
            //btnsendaward.Visible = true;
            BindData(6);

        }
        else
        {
            Label1.Text = "Please Select Any One option!";
            Label1.Visible = true;
        }
    }
    //public void deletedata()
    //{
    //    string grid = "";
    //    bool chk = false;
    //    foreach (GridViewRow gr in GridView1.Rows)
    //    {
    //        CheckBox deletechkbox = (CheckBox)gr.FindControl("chkregno");
    //        if (deletechkbox.Checked)
    //        {
    //            chk = true;
    //            grid = ((Label)gr.FindControl("lblcheckid")).Text.ToString();
    //            string strregno = gr.Cells[0].Text;
    //            string strname = gr.Cells[1].Text;
    //            string strdate = gr.Cells[2].Text;
    //            string strpair = gr.Cells[3].Text;
    //            string strawardname = gr.Cells[4].Text;
    //            string strinsert = "delete tblreward where appmstregno='" + strregno + "' and awardname='" + strawardname + "'";
    //            com = new SqlCommand(strinsert, con);
    //            con.Open();
    //            com.ExecuteNonQuery();
    //            con.Close();
    //        }
    //    }
    //}
 
    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate))
        {
         
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        Button1_Click(sender, e);
        GridView1.PageSize = Convert.ToInt32(Label1.Text);
        //go1();

        Response.Clear();

        Response.AddHeader("content-disposition", "attachment;filename=Downstatus.xls");

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
