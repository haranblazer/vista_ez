using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Admin_AdminReward : System.Web.UI.Page
{


    string fromdate, todate;
    string sstr;
    double total, tds, handeling, other, dispatch;
    SqlDataAdapter da;

  //  SqlDataReader dr;
    //SqlCommand com;
 //   SqlConnection con = new SqlConnection(method.str);
   // string str;

    utility objUtil = new utility();
    
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataReader dr;
    string str;
    static int Rank = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //str = Convert.ToString(Session["userId"]);
        //InsertFunction.Checklogin();

        string str;
        str = Session["admin"].ToString();
        if (str == "")
            Response.Redirect("adminLog.aspx");

        if (!IsPostBack)
        {


           // GridView1.Visible = false;
          
            rwd.Visible = false;
            t3.Visible = false;
            t2.Visible = false;
        }

       
    }



    public void check()
    {

        cmd = new SqlCommand("SelectReward1", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@regno",TextBox1.Text);
        con.Open();
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {

            dr.Read();
            lblid.Text = dr["AppMstRegNo"].ToString();

            lblDateOfJoining.Text = dr["appmstDoj"].ToString();

            lblLeft.Text = dr["rewardleft"].ToString();

            lblRight.Text = dr["rewardright"].ToString();
            con.Close();

            t2.Visible = true;
          

        
            //binding ends..
        }
        else
        {
            lblmsg.Text = "You have not achieved any award presently...";
            //rwd.Visible = false;
            t2.Visible = false;
          
            lblmsg.Visible = true;
        }
    }

    private void getlr()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        da = new SqlDataAdapter("select case when Comment='0' then '' end   Comment from tblreward where appmstregno='" + TextBox1.Text.Trim() + "' order by srno", con);
        DataTable dt = new DataTable();
        da.Fill(dt);

        cmd = new SqlCommand("rewarduser", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@id",TextBox1.Text);
        cmd.CommandTimeout = 1900;
        con.Open();
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            int a = Convert.ToInt32(dr[0]);

            if (Convert.ToInt32(dr["r1"]) == 1)
            {
                lblDVDPlayer.Text = "<font color=RED>Qualify</font>";
                Label1.Text = dt.Rows[0]["Comment"].ToString();
            }

            if (Convert.ToInt32(dr["r2"]) == 1)
            {
                lblDigitalCamera.Text = "<font color=RED>Qualify</font>";
                Label2.Text = dt.Rows[1]["Comment"].ToString();
            }

            if (Convert.ToInt32(dr["r3"]) == 1)
            {
                lblRefrigrator.Text = "<font color=RED>Qualify</font>";
                Label3.Text = dt.Rows[2]["Comment"].ToString();
            }
            if (Convert.ToInt32(dr["r4"]) == 1)
            {
                lblLaptop.Text = "<font color=RED>Qualify</font>";
                Label4.Text = dt.Rows[3]["Comment"].ToString();
            }
            if (Convert.ToInt32(dr["r5"]) == 1)
            {
                lblBike.Text = "<font color=RED>Qualify</font>";
                Label5.Text = dt.Rows[4]["Comment"].ToString();
            }
            if (Convert.ToInt32(dr["r6"]) == 1)
            {
                lblNanoCar.Text = "<font color=RED>Qualify</font>";
                Label6.Text = dt.Rows[5]["Comment"].ToString();
            }
            if (Convert.ToInt32(dr["r7"]) == 1)
            {
                lblAltoSparkCar.Text = "<font color=RED>Qualify</font>";
                Label7.Text = dt.Rows[6]["Comment"].ToString();
            }
            if (Convert.ToInt32(dr["r8"]) == 1)
            {
                lblSwift.Text = "<font color=RED>Qualify</font>";
                Label8.Text = dt.Rows[7]["Comment"].ToString();
            }
            if (Convert.ToInt32(dr["r9"]) == 1)
            {
                lblSkoda.Text = "<font color=RED>Qualify</font>";
                Label9.Text = dt.Rows[8]["Comment"].ToString();
            }
            if (Convert.ToInt32(dr["r10"]) == 1)
            {
                lblMerceces.Text = "<font color=RED>Qualify</font>";
                Label10.Text = dt.Rows[9]["Comment"].ToString();
            }
            if (Convert.ToInt32(dr["r11"]) == 1)
            {
                lblCash.Text = "<font color=RED>Qualify</font>";
                Label11.Text = dt.Rows[10]["Comment"].ToString();
            }
            if (Convert.ToInt32(dr["r111"]) == 1)
            {
                lblthailand.Text = "<font color=RED>Qualify</font>";
                //  Label12.Text = dt.Rows[11]["Comment"].ToString();
            }
            con.Close();
            rwd.Visible = true;
            t3.Visible = true;

        }


        else
        {
            rwd.Visible = false;
            t3.Visible = false;
        }
    }
    //protected void Timer1_Tick(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string FastTrackDate = "";
    //        DateTime dt = DateTime.UtcNow;
    //        TimeSpan differ;
    //        System.DateTime date1 = new System.DateTime(2014, 4, 10, 20, 10, 0);

    //        if (String.IsNullOrEmpty(FastTrackDate))
    //        {
    //            cmd = new SqlCommand("RewardTimeLeft", con);
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@regno", Session["userId"].ToString());
    //            con.Open();
    //            dr = cmd.ExecuteReader();
    //            if (dr.HasRows)
    //            {
    //                dr.Read();
    //                FastTrackDate = dr["LDate"].ToString();
    //                Rank = Convert.ToInt32(dr["RankName"].ToString());
    //            }
    //            con.Close();
    //        }
    //        date1 = Convert.ToDateTime(FastTrackDate);
    //        differ = date1.Subtract(dt);
    //        double t = differ.TotalSeconds;

    //        if (t > 0)
    //        {
    //            double dy, h, m, s;
    //            dy = differ.Days;
    //            h = differ.Hours;
    //            m = differ.Minutes;
    //            s = differ.Seconds;
    //            //lblDays.Text = dy.ToString();// +" Days " + h + " Hours " + m + " Minutes " + s + " Seconds left for celebration";
    //            //lblH.Text = h.ToString();
    //            //lblM.Text = m.ToString();
    //            //lbls.Text = s.ToString();
    //            if (Rank == 1)
    //                Label1.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //            else if (Rank == 2)
    //                Label2.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //            else if (Rank == 3)
    //                Label3.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //            else if (Rank == 4)
    //                Label4.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //            else if (Rank == 5)
    //                Label5.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //            else if (Rank == 6)
    //                Label6.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //            else if (Rank == 7)
    //                Label7.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //            else if (Rank == 8)
    //                Label8.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //            else if (Rank == 9)
    //                Label9.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //            else if (Rank == 10)
    //                Label10.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //            else if (Rank == 11)
    //                Label11.Text = "D: " + dy.ToString() + " H: " + h + " M: " + m + " S: " + s + "<br/> Time left.";
    //        }
    //        else
    //        {
    //            Label13.Text = "No Time Left...";
    //            Timer1.Enabled = false;
    //        }
    //    }
    //    catch
    //    {
    //    }
    //}
    protected void GridView1_RowCommand1(object sender, GridViewCommandEventArgs e)
    {

       
        
        if (e.CommandName.Equals("PRINT"))
        {
            utility obj = new utility();
            int index = Convert.ToInt32(e.CommandArgument);
           // GridViewRow row = GridView1.Rows[index];

            //Label listPriceTextBox = (Label)row.FindControl("lbl1");
            Session["userId"] = TextBox1.Text;
            Response.Redirect("payoutstatement.aspx?n=" + (e.CommandArgument.ToString()));


        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            GridView1.Visible = false;
            GridView2.Visible = false;

            rwd.Visible = false;
            t3.Visible = false;
            t2.Visible = false;
            finddata();
            go2();
           
        }

        catch
        {
            Response.Write("<script>alert('invalid data')</script>");
        }

      

    }


    private void finddata()
    {
      //  str = TextBox1.Text;
        cmd = new SqlCommand("CheckUserId2 ", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@idno ",TextBox1.Text);
        da = new SqlDataAdapter(cmd);
        //DataTable t = new DataTable();
        DataSet ds = new DataSet();
        da.Fill(ds);
        int r = ds.Tables[0].Rows.Count;
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataColumn dcb = new DataColumn("b", typeof(string));
            DataColumn dcd = new DataColumn("d", typeof(string));
            DataColumn dcL = new DataColumn("L", typeof(string));
            DataColumn dcROI = new DataColumn("ROI", typeof(string));
            DataColumn dcLD = new DataColumn("LD", typeof(string));
            //if (ds.Tables[1].Rows.Count > 0)
            //    dcb.DefaultValue = ds.Tables[1].Rows[0][0].ToString();
            //else
            dcb.DefaultValue = 0;
            //if (ds.Tables[1].Rows.Count > 1)
            //    dcd.DefaultValue = ds.Tables[1].Rows[1][0].ToString();
            //else
            dcd.DefaultValue = 0;
            //if (ds.Tables[1].Rows.Count > 2)
            //    dcL.DefaultValue = ds.Tables[1].Rows[2][0].ToString();
            //else
            dcL.DefaultValue = 0;
            //if (ds.Tables[1].Rows.Count > 3)
            //    dcLD.DefaultValue = ds.Tables[1].Rows[3][0].ToString();
            //else
            dcLD.DefaultValue = 0;
            //if (ds.Tables[1].Rows.Count > 4)
            //    dcROI.DefaultValue = ds.Tables[1].Rows[4][0].ToString();
            //else
            dcROI.DefaultValue = 0;

            ds.Tables[0].Columns.Add(dcb);
            ds.Tables[0].Columns.Add(dcd);
            ds.Tables[0].Columns.Add(dcL);
            ds.Tables[0].Columns.Add(dcLD);
            ds.Tables[0].Columns.Add(dcROI);
            GridView1.DataSource = ds.Tables[0];
            GridView1.DataBind();

            GridView1.Visible = true;

            //go2();
        }
        else 
        
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
            GridView1.Visible = true;

            GridView1.EmptyDataText = "No Data";
        
        }
    }



    public void go2()
    {

        cmd = new SqlCommand("sp_account", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@appmstid",TextBox1.Text);
        da = new SqlDataAdapter(cmd);
        DataTable t = new DataTable();
        da.Fill(t);

        if (t.Rows.Count > 0)
        {


            GridView2.DataSource = t;
            GridView2.DataBind();

            GridView2.Visible = true;

            check();
            getlr();

        }

        //    for (int j = 0; j < t.Rows.Count; j++)
        //    {
        //        total += Convert.ToDouble(t.Rows[j]["totalearning"].ToString());
        //        tds += Convert.ToDouble(t.Rows[j]["tds"].ToString());
        //        handeling += Convert.ToDouble(t.Rows[j]["handlingcharges"].ToString());
        //        other += Convert.ToDouble(t.Rows[j]["othercharges"].ToString());
        //        dispatch += Convert.ToDouble(t.Rows[j]["dispachedamt"].ToString());
        //    }
        //    lblTotalTotalEarned.Text = total.ToString();
        //    lblTotalTdsAmount.Text = tds.ToString();
        //    lblTotalhandlibgCharges.Text = handeling.ToString();
        //    //lblEWalletFund.Text = other.ToString();
        //    lblTotalDispatchedAmount.Text = dispatch.ToString();

        //    t1.Visible = true;

        //}



        else
        {
            GridView2.DataSource = null;
            GridView2.DataBind();

            GridView2.Visible = false;

            GridView2.EmptyDataText = "No Data";

            check();
            getlr();

        }
       

    }
}
    



