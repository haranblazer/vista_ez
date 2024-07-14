using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class direct : System.Web.UI.Page
{
    string userid;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["userId"] == null)
            Response.Redirect("login.aspx", false);
        else
        {
            if (!IsPostBack)
            {
                userid = Convert.ToString(Session["userid"]);
                Reset();
                if (userid != "")
                {
                    BindTree(userid, 0);
                }
                else
                {
                    Response.Redirect("loginagain.aspx");
                }
            }
        }
    }
    public void BindTree(string regno, int appmstid)
    {
        int totalsponsor = 0;
        con = new SqlConnection(method.str);
        com = new SqlCommand("directtree", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", regno.Trim());
        com.Parameters.AddWithValue("@appmstid", appmstid);
        try
        {
            con.Open();
            sdr = com.ExecuteReader();
            if (sdr.HasRows)
            {
                sdr.Read();
                //first node bind, 0 level bind 
                bindText(LinkButton5, Label1, ImageButton1, sdr["appmstregno"].ToString().Trim(), sdr["appmstfname"].ToString().Trim(), sdr["appmstpaid"].ToString().Trim(), sdr["ypin"].ToString().Trim(), sdr["doj"].ToString().Trim(), sdr["cnt"].ToString().Trim(), sdr["jamount"].ToString().Trim(), sdr["investment"].ToString().Trim(), sdr["pbvamt"].ToString().Trim(), sdr["gbvAmt"].ToString().Trim(), sdr["tlper"].ToString().Trim(), sdr["oldgbv"].ToString().Trim(), sdr["pbv"].ToString().Trim(), sdr["gbv"].ToString().Trim(), sdr["BillAmt"].ToString().Trim(), sdr["AppMstLeftRight"].ToString().Trim());
                totalsponsor = Convert.ToInt32(sdr["totalsponsor"].ToString().Trim());
                HideShow(LinkButton1, totalsponsor);

                string str = "";

                str += "<table class='table table-bordered'>";
                str += "<tbody>";
                str += "<tr>";
                str += "<td colspan='4' style='background-color: #000; color: white'>Member Current Status </td>";
                str += "</tr>";
                str += "<tr style='border-bottom: 1px solid #d3d3d3;'>";
                str += "<td style='text-align: center'> " + sdr["appmstfname"].ToString() + " </td>";
                str += "<td style='text-align: center'>" + sdr["appmstregno"].ToString() + " </td>";
                str += "</tr>";
                str += "<tr style='border-bottom: 1px solid #d3d3d3;'>";
                str += "<td style='text-align: center'>DOJ: " + sdr["doj"].ToString() + " </td>";
                str += "<td style='text-align: center'>BV: " + sdr["pbvamt"].ToString() + "  </td>";
                str += "</tr>";
                str += "<tr style='border-bottom: 1px solid #d3d3d3;'>";
                str += "<td style='text-align: center'>GBV : " + sdr["gbvAmt"].ToString() + " </td>";
                str += "<td style='text-align: center'>Rank: " + sdr["tlper"].ToString() + " </td>";
                str += "</tr>";
                str += "</tbody>";
                str += "</table>";

                tbl_UserDetail.InnerHtml = str;
            }
            // 1st level bind
            if (!sdr.IsClosed)
            {
                if (sdr.HasRows)
                {
                    sdr.NextResult();
                    DataTable dt = new DataTable();
                    dt.Load(sdr);
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i == 0)
                        {
                            bindText(LinkButton6, Label2, ImageButton2, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                            totalsponsor = Convert.ToInt32(dt.Rows[i]["totalsponsor"].ToString().Trim());
                            HideShow(LinkButton2, totalsponsor);
                        }
                        if (i == 1)
                        {
                            bindText(LinkButton7, Label3, ImageButton3, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                            totalsponsor = Convert.ToInt32(dt.Rows[i]["totalsponsor"].ToString().Trim());
                            HideShow(LinkButton3, totalsponsor);
                        }
                        if (i == 2)
                        {
                            bindText(LinkButton8, Label4, ImageButton4, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                            totalsponsor = Convert.ToInt32(dt.Rows[i]["totalsponsor"].ToString().Trim());
                            HideShow(LinkButton4, totalsponsor);
                            LinkButton1.ValidationGroup = dt.Rows[i]["appmstid"].ToString();
                        }
                    }
                }
            }
            //if (sdr.HasRows)
            //{
            //    while (sdr.Read())
            //    {
            //        DataTable dt = new DataTable();
            //        dt.Load(sdr);

            //        // Your existing code to bind data to controls here
            //    }
            //}
            //2nd level bind start
            if (!sdr.IsClosed)
            {
                if (sdr.HasRows)
                {
                    //sdr.NextResult();
                    DataTable dt = new DataTable();
                    dt.Load(sdr);
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i == 0)
                        {
                            bindText(LinkButton9, Label5, ImageButton5, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                        }
                        if (i == 1)
                        {
                            bindText(LinkButton10, Label6, ImageButton6, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                        }
                        if (i == 2)
                        {
                            bindText(LinkButton11, Label7, ImageButton7, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                            LinkButton2.ValidationGroup = dt.Rows[i]["appmstid"].ToString();
                        }
                    }
                }
            }
            // //2nd level bind start (middle block)
            if (!sdr.IsClosed)
            {
                if (sdr.HasRows)
                {
                    //sdr.NextResult();
                    DataTable dt = new DataTable();
                    dt.Load(sdr);
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i == 0)
                        {
                            bindText(LinkButton12, Label8, ImageButton8, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                        }
                        if (i == 1)
                        {
                            bindText(LinkButton13, Label9, ImageButton9, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                        }
                        if (i == 2)
                        {
                            bindText(LinkButton14, Label10, ImageButton10, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                            LinkButton3.ValidationGroup = dt.Rows[i]["appmstid"].ToString();
                        }
                    }
                }
            }
            // //2nd level bind start (3rd and last block)
            if (!sdr.IsClosed)
            {
                if (sdr.HasRows)
                {
                    //sdr.NextResult();
                    DataTable dt = new DataTable();
                    dt.Load(sdr);
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i == 0)
                        {
                            bindText(LinkButton15, Label11, ImageButton11, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                        }
                        if (i == 1)
                        {
                            bindText(LinkButton16, Label12, ImageButton12, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                        }
                        if (i == 2)
                        {
                            bindText(LinkButton17, Label13, ImageButton13, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                            LinkButton4.ValidationGroup = dt.Rows[i]["appmstid"].ToString();
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
    public void BindTree2(string regno, int appmstid, LinkButton lnk1, LinkButton lnk2, LinkButton lnk3, LinkButton lnk4, Label lbl1, Label lbl2, Label lbl3, Label lbl4, ImageButton img1, ImageButton img2, ImageButton img3, ImageButton img4, LinkButton more)
    {
        Reset2(lnk1, lnk2, lnk3, lnk4, lbl1, lbl2, lbl3, lbl4, img1, img2, img3, img4);
        int totalsponsor = 0;
        con = new SqlConnection(method.str);
        com = new SqlCommand("directTree2", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", regno.Trim());
        com.Parameters.AddWithValue("@appmstid", appmstid);
        try
        {
            con.Open();
            sdr = com.ExecuteReader();
            if (sdr.HasRows)
            {
                sdr.Read();
                //first node bind, 0 level bind
                bindText(lnk1, lbl1, img1, sdr["appmstregno"].ToString().Trim(), sdr["appmstfname"].ToString().Trim(), sdr["appmstpaid"].ToString().Trim(), sdr["ypin"].ToString().Trim(), sdr["doj"].ToString().Trim(), sdr["cnt"].ToString().Trim(), sdr["jamount"].ToString().Trim(), sdr["investment"].ToString().Trim(), sdr["pbvamt"].ToString().Trim(), sdr["gbvAmt"].ToString().Trim(), sdr["tlper"].ToString().Trim(), sdr["oldgbv"].ToString().Trim(), sdr["pbv"].ToString().Trim(), sdr["gbv"].ToString().Trim(), sdr["BillAmt"].ToString().Trim(), sdr["AppMstLeftRight"].ToString().Trim());
                totalsponsor = Convert.ToInt32(sdr["totalsponsor"].ToString().Trim());
                HideShow(more, totalsponsor);

            }
            // 1st level bind
            if (!sdr.IsClosed)
            {
                if (sdr.HasRows)
                {
                    sdr.NextResult();
                    DataTable dt = new DataTable();
                    dt.Load(sdr);
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i == 0)
                        {
                            bindText(lnk2, lbl2, img2, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                            totalsponsor = Convert.ToInt32(dt.Rows[i]["totalsponsor"].ToString().Trim());

                        }
                        if (i == 1)
                        {
                            bindText(lnk3, lbl3, img3, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                            totalsponsor = Convert.ToInt32(dt.Rows[i]["totalsponsor"].ToString().Trim());

                        }
                        if (i == 2)
                        {
                            bindText(lnk4, lbl4, img4, dt.Rows[i]["appmstregno"].ToString().Trim(), dt.Rows[i]["appmstfname"].ToString().Trim(), dt.Rows[i]["appmstpaid"].ToString().Trim(), dt.Rows[i]["ypin"].ToString().Trim(), dt.Rows[i]["doj"].ToString().Trim(), dt.Rows[i]["cnt"].ToString().Trim(), dt.Rows[i]["jamount"].ToString().Trim(), dt.Rows[i]["investment"].ToString().Trim(), dt.Rows[i]["pbvamt"].ToString().Trim(), dt.Rows[i]["gbvAmt"].ToString().Trim(), dt.Rows[i]["tlper"].ToString().Trim(), dt.Rows[i]["oldgbv"].ToString().Trim(), dt.Rows[i]["pbv"].ToString().Trim(), dt.Rows[i]["gbv"].ToString().Trim(), dt.Rows[i]["BillAmt"].ToString().Trim(), dt.Rows[i]["AppMstLeftRight"].ToString().Trim());
                            totalsponsor = Convert.ToInt32(dt.Rows[i]["totalsponsor"].ToString().Trim());
                            more.ValidationGroup = dt.Rows[i]["appmstid"].ToString();
                        }
                    }
                }
            }
        }
        catch
        {
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    private void bindText(LinkButton lnk, Label lbl, ImageButton img, string lnlText, string lblText, string imgText, string ypin,
    string doj, string totalmember, string investment, string turnover, string pbv, string gbv, string tlper, string oldgbv, string pbv1, string gbv1, string BAmt, string LR)
    {
        lnk.Text = lnlText;
        lbl.Text = lblText;
        img.ImageUrl = imgText;
        lnk.ToolTip = "";
        lnk.ToolTip = "Name:" + lblText;
        lnk.ToolTip += "\n" + "ID NO: " + lnk.Text.Trim();
        lnk.ToolTip += "\n" + "DATE OF JOINING: " + doj;
        lnk.ToolTip += "\n" + method.PV + ": " + pbv;
        lnk.ToolTip += "\n" + method.GBV + ": " + gbv;
        lnk.ToolTip += "\n" + "Rank : " + tlper;


        if (imgText == "1")
        {
            if (Convert.ToInt32(BAmt) < 1500)
            {
                if (LR == "1")
                    img.ImageUrl = "~/user/images/part_paid_r.gif";
                else
                    img.ImageUrl = "~/user/images/part_paid_l.gif";
            }
            else
            {
                if (LR == "1")
                    img.ImageUrl = "~/user/images/paid_r.gif";
                else
                    img.ImageUrl = "~/user/images/paid_l.gif";
            }
        }
        else
        {
            if (LR == "1")
                img.ImageUrl = "~/user/images/unpaid_r.gif";
            else
                img.ImageUrl = "~/user/images/unpaid_l.gif";
        }


    }
    private void HideShow(LinkButton lnk, int stotal)
    {
        if (stotal > 3)
            lnk.Visible = true;
        else
            lnk.Visible = false;
    }
    private void Reset2(LinkButton lnk1, LinkButton lnk2, LinkButton lnk3, LinkButton lnk4, Label lbl1, Label lbl2, Label lbl3, Label lbl4, ImageButton img1, ImageButton img2, ImageButton img3, ImageButton img4)
    {
        lnk1.Text = "";
        lnk2.Text = "";
        lnk3.Text = "";
        lnk4.Text = "";
        lbl1.Text = "Open";
        lbl2.Text = "Open";
        lbl3.Text = "Open";
        lbl4.Text = "Open";
        img1.ImageUrl = "~/user/images/unpaid12.gif";
        img2.ImageUrl = "~/user/images/unpaid12.gif";
        img3.ImageUrl = "~/user/images/unpaid12.gif";
        img4.ImageUrl = "~/user/images/unpaid12.gif";
    }
    private void Reset()
    {
        LinkButton5.Text = "";
        LinkButton6.Text = "";
        LinkButton7.Text = "";
        LinkButton8.Text = "";
        LinkButton9.Text = "";
        LinkButton10.Text = "";
        LinkButton11.Text = "";
        LinkButton12.Text = "";
        LinkButton13.Text = "";
        LinkButton14.Text = "";
        LinkButton15.Text = "";
        LinkButton16.Text = "";
        LinkButton17.Text = "";
        Label1.Text = "Open";
        Label2.Text = "Open";
        Label3.Text = "Open";
        Label4.Text = "Open";
        Label5.Text = "Open";
        Label6.Text = "Open";
        Label7.Text = "Open";
        Label8.Text = "Open";
        Label9.Text = "Open";
        Label10.Text = "Open";
        Label11.Text = "Open";
        Label12.Text = "Open";
        Label13.Text = "Open";
        ImageButton1.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton2.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton3.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton4.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton5.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton6.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton7.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton8.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton9.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton10.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton11.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton12.ImageUrl = "~/user/images/unpaid12.gif";
        ImageButton13.ImageUrl = "~/user/images/unpaid12.gif";
        LinkButton1.Visible = false;
        LinkButton2.Visible = false;
        LinkButton3.Visible = false;
        LinkButton4.Visible = false;
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string regno = LinkButton5.Text.Trim();
        int appmstid;
        appmstid = Convert.ToInt32(LinkButton1.ValidationGroup.ToString());
        Reset();
        BindTree(regno, appmstid);
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        string regno = LinkButton6.Text.Trim();
        int appmstid;
        appmstid = Convert.ToInt32(LinkButton2.ValidationGroup.ToString());

        BindTree2(regno, appmstid, LinkButton6, LinkButton9, LinkButton10, LinkButton11, Label2, Label5, Label6, Label7, ImageButton2, ImageButton5, ImageButton6, ImageButton7, LinkButton2);
    }
    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        string regno = LinkButton7.Text.Trim();
        int appmstid;
        appmstid = Convert.ToInt32(LinkButton3.ValidationGroup.ToString());

        BindTree2(regno, appmstid, LinkButton7, LinkButton12, LinkButton13, LinkButton14, Label3, Label8, Label9, Label10, ImageButton3, ImageButton8, ImageButton9, ImageButton10, LinkButton3);
    }
    protected void LinkButton4_Click(object sender, EventArgs e)
    {

        string regno = LinkButton8.Text.Trim();
        int appmstid;
        appmstid = Convert.ToInt32(LinkButton4.ValidationGroup.ToString());

        BindTree2(regno, appmstid, LinkButton8, LinkButton15, LinkButton16, LinkButton17, Label4, Label11, Label12, Label13, ImageButton4, ImageButton11, ImageButton12, ImageButton13, LinkButton4);
    }
    protected void LinkButton5_Click(object sender, EventArgs e)
    {
        string regno = LinkButton5.Text.Trim();
        Reset();
        BindTree(regno, 0);
    }
    protected void LinkButton6_Click(object sender, EventArgs e)
    {
        string regno = LinkButton5.Text.Trim();
        Reset();
        BindTree(regno, 0);
    }
    protected void BindAgain(object sender, EventArgs e)
    {
        string regno = ((System.Web.UI.WebControls.LinkButton)(sender)).Text.Trim();
        Reset();
        BindTree(regno, 0);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblmsg.Text = "";
        SqlParameter[] param = new SqlParameter[]
                    {
                    new SqlParameter("@sessionUserId",Session["userId"].ToString()),
                    new SqlParameter("@UserId", txt_Userid.Text.Trim())
                    };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "sp_getSponsorDownLine");
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["AppMstId"].ToString() == "1")
            {
                string regno = txt_Userid.Text.Trim();

                BindTree(regno, 0);
            }
            else
            {
                lblmsg.Text = "Not Your DownLine";
            }
        }
    }
}
