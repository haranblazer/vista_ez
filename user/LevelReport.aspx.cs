using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.UI;
using System.Collections.Generic;
using System.IO;

public partial class user_LEVELReport : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    string strsessionid;
    int total1 = 0;
    int total2 = 0;
    int total3 = 0;
    int total4 = 0;
    int total5 = 0;
    int total6 = 0;

    int total7 = 0;
    int total8 = 0;
    int total9 = 0;
    int total10 = 0;
    int total11 = 0;
    int total12 = 0;
    int total13 = 0;
    int total14 = 0;
    int total15 = 0;
    int total16 = 0;
    int total17 = 0;
    int total18 = 0;
    int total19 = 0;
    int total20 = 0;
    int total21 = 0;
    int total22 = 0;
    int total23 = 0;
    int total24 = 0;
    int total25 = 0;
    int total26 = 0;
    int total27 = 0;
    int total28 = 0;
    int total29 = 0;
    int total30 = 0;
    int total31 = 0;
    int total32 = 0;
    int total33 = 0;
    int total34 = 0;
    int total35 = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
         //InsertFunction.Checklogin();
        strsessionid = Convert.ToString(Session["userId"]);

        
            if (!IsPostBack)
            {
                go1();
               // go2();
               // go3();
               // go4();
                //go5();
                //go6();
                //go7();
                //go8();
               // go9();
                //go10();
              //  Label27.Text = Convert.ToString(Convert.ToDouble(Label1.Text) + Convert.ToDouble(Label2.Text) + Convert.ToDouble(Label3.Text) + Convert.ToDouble(Label4.Text) + Convert.ToDouble(Label5.Text) + Convert.ToDouble(Label6.Text) + Convert.ToDouble(Label7.Text) + Convert.ToDouble(Label8.Text) + Convert.ToDouble(Label9.Text) + Convert.ToDouble(Label10.Text));

               // go11();
               // go12();
               // go13();
               // go14();
                //go15();
                //go16();
                //go17();
                //go18();
                //go19();
                //go20();

                //go21();
                //go22();
                //go23();
                //go24();
                //go25();
                //go26();
                //go27();


           
        }

    }
    public void go1()
    {
        try
        { 
            if (Convert.ToInt32(txt_Level.Text) > 12)
            {
                txt_Level.Text = "12";
            }
            lbl_level.Text = txt_Level.Text;
            DataTable dt1 = new DataTable();
            da = new SqlDataAdapter("LevelReport", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
            da.SelectCommand.Parameters.AddWithValue("@level", txt_Level.Text.Trim());
            con.Open();
            da.Fill(dt1);
            if (dt1.Rows.Count > 0)
            {
                lblCount1.Text = dt1.Compute("count(appmstregno)", "true").ToString();
                GridView1.DataSource = dt1;
                GridView1.DataBind();
            }
            else
            {
                l1.Visible = false;
                l1d.Visible = false;
                l1t.Visible = false;
            }
            con.Close();
        }
        catch (Exception er) {
            GridView1.DataSource = null;
            GridView1.DataBind();
            lblCount1.Text = er.Message;
        }
    }
    public void go2()
    {
        DataTable dt2 = new DataTable();
        int level = 2;
        //if (Regex.Match(strsessionid, @"^[A-Z0-9]+$").Success)
        //{
            da = new SqlDataAdapter("LevelReport", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
            da.SelectCommand.Parameters.AddWithValue("@level", level);
            con.Open();
            da.Fill(dt2);

            if (dt2.Rows.Count > 0)
            {
                lblCount2.Text = dt2.Compute("count(appmstregno)", "true").ToString();
           // lblCount1
                GridView2.DataSource = dt2;
                GridView2.DataBind();
                //for (int i = 0; i < dt2.Rows.Count; i++)
                //{
                //  //  total2 = Convert.ToInt32(dt2.Rows[i]["amount"].ToString()) + total2;
                //}
                //Label2.Text = Convert.ToString(total2);
            }
            else
            {
                l2.Visible = false;
                l2d.Visible = false;
                l2t.Visible = false;

            }

            con.Close();
        //}
        //else
        //{
        //    Label2.Text = "Invalid UserId!";
        //}
    }
    public void go3()
    {
        DataTable dt3 = new DataTable();
        int level = 3;
        //if (Regex.Match(strsessionid, @"^[A-Z0-9]+$").Success)
        //{
        da = new SqlDataAdapter("LevelReport", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
            da.SelectCommand.Parameters.AddWithValue("@level", level);
            con.Open();
            da.Fill(dt3);

            if (dt3.Rows.Count > 0)
            {
               // lblRequired3.Text = "1000";
                lblCount3.Text = dt3.Compute("count(appmstregno)", "true").ToString();
                //lblPending3.Text = Convert.ToString(Convert.ToInt32(lblRequired3.Text) - Convert.ToInt32(lblCount3.Text));
                GridView3.DataSource = dt3;
                GridView3.DataBind();
                //for (int i = 0; i < dt3.Rows.Count; i++)
                //{
                //    //total3 = Convert.ToInt32(dt3.Rows[i]["amount"].ToString()) + total3;
                //}
                //Label3.Text = Convert.ToString(total3);
            }
            else
            {
                l3.Visible = false;
                l3d.Visible = false;
                l3t.Visible = false;

            }

            con.Close();
        //}
        //else
        //{
        //    Label3.Text = "Invalid UserId!";
        //}
    }
   // public void go4()
    //{
       // DataTable dt4 = new DataTable();
        //int level = 4;
        //if (Regex.Match(strsessionid, @"^[A-Z0-9]+$").Success)
        //{
          //  da = new SqlDataAdapter("LevelReport", con);
           // da.SelectCommand.CommandType = CommandType.StoredProcedure;
            //da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
            //da.SelectCommand.Parameters.AddWithValue("@level", level);
           // con.Open();
           // da.Fill(dt4);

            //if (dt4.Rows.Count > 0)
            //{
                //lblRequired4.Text = "5100";
               // lblCount4.Text = dt4.Compute("count(appmstregno)", "true").ToString();
                //lblPending4.Text = Convert.ToString(Convert.ToInt32(lblRequired4.Text) - Convert.ToInt32(lblCount4.Text));
               // GridView4.DataSource = dt4;
               // GridView4.DataBind();
                //for (int i = 0; i < dt4.Rows.Count; i++)
                //{
                //  //  total4 = Convert.ToInt32(dt4.Rows[i]["amount"].ToString()) + total4;
                //}
                //Label4.Text = Convert.ToString(total4);
           // }
           // else
           // {
           //     l4.Visible = false;
             //   l4d.Visible = false;
              //  l4t.Visible = false;

           // }



            //con.Close();
        //}
        //else
        //{
        //    Label4.Text = "Invalid UserId!";
        //}
   // }
 //public void go5()
   // {
     //   DataTable dt5 = new DataTable();
       // int level = 5;
        //if (Regex.Match(strsessionid, @"^[A-Z0-9]+$").Success)
        //{
         //   da = new SqlDataAdapter("LevelReport", con);
           // da.SelectCommand.CommandType = CommandType.StoredProcedure;
            //da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
            //da.SelectCommand.Parameters.AddWithValue("@level", level);
            //con.Open();
           // da.Fill(dt5);

            //if (dt5.Rows.Count > 0)
            //{
                //lblRequired4.Text = "5100";
               // lblCount5.Text = dt5.Compute("count(appmstregno)", "true").ToString();
                //lblPending4.Text = Convert.ToString(Convert.ToInt32(lblRequired5.Text) - Convert.ToInt32(lblCount5.Text));
                //GridView5.DataSource = dt5;
                //GridView5.DataBind();
                //for (int i = 0; i < dt4.Rows.Count; i++)
                //{
                //  //  total4 = Convert.ToInt32(dt4.Rows[i]["amount"].ToString()) + total4;
                //}
                //Label4.Text = Convert.ToString(total4);
            //}
            //else
            //{
              //  l5.Visible = false;
                //l5d.Visible = false;
                //l5t.Visible = false;

            //}



           // con.Close();
        //}
        //else
        //{
        //    Label4.Text = "Invalid UserId!";
        //}
   // }
    //public void go15()
    //{
    //    DataTable dt15 = new DataTable();
    //    int level = 15;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt15);

    //        if (dt15.Rows.Count > 0)
    //        {
    //            GridView15.DataSource = dt15;
    //            GridView15.DataBind();
    //            for (int i = 0; i < dt15.Rows.Count; i++)
    //            {
    //                total15 = Convert.ToInt32(dt15.Rows[i]["amount"].ToString()) + total15;
    //            }
    //            Label15.Text = Convert.ToString(total15);
    //        }
    //        else
    //        {
    //            l15.Visible = false;
    //            l15d.Visible = false;
    //            l15t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label15.Text = "Invalid UserId!";
    //    }
    //}

    //public void go16()
    //{
    //    DataTable dt16 = new DataTable();
    //    int level = 16;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt16);

    //        if (dt16.Rows.Count > 0)
    //        {
    //            GridView16.DataSource = dt16;
    //            GridView16.DataBind();
    //            for (int i = 0; i < dt16.Rows.Count; i++)
    //            {
    //                total16 = Convert.ToInt32(dt16.Rows[i]["amount"].ToString()) + total16;
    //            }
    //            Label16.Text = Convert.ToString(total16);
    //        }
    //        else
    //        {
    //            l16.Visible = false;
    //            l16d.Visible = false;
    //            l16t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label16.Text = "Invalid UserId!";
    //    }
    //}

    //public void go17()
    //{
    //    DataTable dt17 = new DataTable();
    //    int level = 17;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt17);

    //        if (dt17.Rows.Count > 0)
    //        {
    //            GridView17.DataSource = dt17;
    //            GridView17.DataBind();
    //            for (int i = 0; i < dt17.Rows.Count; i++)
    //            {
    //                total17 = Convert.ToInt32(dt17.Rows[i]["amount"].ToString()) + total17;
    //            }
    //            Label17.Text = Convert.ToString(total17);
    //        }
    //        else
    //        {
    //            l17.Visible = false;
    //            l17d.Visible = false;
    //            l17t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label1.Text = "Invalid UserId!";
    //    }
    //}

    //public void go18()
    //{
    //    DataTable dt18 = new DataTable();
    //    int level = 18;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt18);

    //        if (dt18.Rows.Count > 0)
    //        {
    //            GridView18.DataSource = dt18;
    //            GridView18.DataBind();
    //            for (int i = 0; i < dt18.Rows.Count; i++)
    //            {
    //                total18 = Convert.ToInt32(dt18.Rows[i]["amount"].ToString()) + total18;
    //            }
    //            Label18.Text = Convert.ToString(total18);
    //        }
    //        else
    //        {
    //            l18.Visible = false;
    //            l18d.Visible = false;
    //            l18t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label18.Text = "Invalid UserId!";
    //    }
    //}

    //public void go19()
    //{
    //    DataTable dt19 = new DataTable();
    //    int level = 19;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt19);

    //        if (dt19.Rows.Count > 0)
    //        {
    //            GridView19.DataSource = dt19;
    //            GridView19.DataBind();
    //            for (int i = 0; i < dt19.Rows.Count; i++)
    //            {
    //                total19 = Convert.ToInt32(dt19.Rows[i]["amount"].ToString()) + total19;
    //            }
    //            Label19.Text = Convert.ToString(total19);
    //        }
    //        else
    //        {
    //            l19.Visible = false;
    //            l19d.Visible = false;
    //            l19t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label19.Text = "Invalid UserId!";
    //    }
    //}

    //public void go20()
    //{
    //    DataTable dt20 = new DataTable();
    //    int level = 20;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt20);

    //        if (dt20.Rows.Count > 0)
    //        {
    //            GridView20.DataSource = dt20;
    //            GridView20.DataBind();
    //            for (int i = 0; i < dt20.Rows.Count; i++)
    //            {
    //                total20 = Convert.ToInt32(dt20.Rows[i]["amount"].ToString()) + total20;
    //            }
    //            Label20.Text = Convert.ToString(total20);
    //        }
    //        else
    //        {
    //            l20.Visible = false;
    //            l20d.Visible = false;
    //            l20t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label20.Text = "Invalid UserId!";
    //    }
    //}

    //public void go21()
    //{
    //    DataTable dt21 = new DataTable();
    //    int level = 21;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt21);

    //        if (dt21.Rows.Count > 0)
    //        {
    //            GridView21.DataSource = dt21;
    //            GridView21.DataBind();
    //            for (int i = 0; i < dt21.Rows.Count; i++)
    //            {
    //                total21 = Convert.ToInt32(dt21.Rows[i]["amount"].ToString()) + total21;
    //            }
    //            Label21.Text = Convert.ToString(total21);
    //        }
    //        else
    //        {
    //            l21.Visible = false;
    //            l21d.Visible = false;
    //            l21t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label21.Text = "Invalid UserId!";
    //    }
    //}

    //public void go22()
    //{
    //    DataTable dt22 = new DataTable();
    //    int level = 22;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt22);

    //        if (dt22.Rows.Count > 0)
    //        {
    //            GridView22.DataSource = dt22;
    //            GridView22.DataBind();
    //            for (int i = 0; i < dt22.Rows.Count; i++)
    //            {
    //                total22 = Convert.ToInt32(dt22.Rows[i]["amount"].ToString()) + total22;
    //            }
    //            Label22.Text = Convert.ToString(total22);
    //        }
    //        else
    //        {
    //            l22.Visible = false;
    //            l22d.Visible = false;
    //            l22t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label22.Text = "Invalid UserId!";
    //    }
    //}

    //public void go23()
    //{
    //    DataTable dt23 = new DataTable();
    //    int level = 23;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt23);

    //        if (dt23.Rows.Count > 0)
    //        {
    //            GridView23.DataSource = dt23;
    //            GridView23.DataBind();
    //            for (int i = 0; i < dt23.Rows.Count; i++)
    //            {
    //                total23 = Convert.ToInt32(dt23.Rows[i]["amount"].ToString()) + total23;
    //            }
    //            Label23.Text = Convert.ToString(total23);
    //        }
    //        else
    //        {
    //            l23.Visible = false;
    //            l23d.Visible = false;
    //            l23t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label23.Text = "Invalid UserId!";
    //    }
    //}

    //public void go24()
    //{
    //    DataTable dt24 = new DataTable();
    //    int level = 24;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt24);

    //        if (dt24.Rows.Count > 0)
    //        {
    //            GridView24.DataSource = dt24;
    //            GridView24.DataBind();
    //            for (int i = 0; i < dt24.Rows.Count; i++)
    //            {
    //                total24 = Convert.ToInt32(dt24.Rows[i]["amount"].ToString()) + total24;
    //            }
    //            Label24.Text = Convert.ToString(total24);
    //        }
    //        else
    //        {
    //            l24.Visible = false;
    //            l24d.Visible = false;
    //            l24t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label24.Text = "Invalid UserId!";
    //    }
    //}

    //public void go25()
    //{
    //    DataTable dt25 = new DataTable();
    //    int level = 25;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {

    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt25);

    //        if (dt25.Rows.Count > 0)
    //        {
    //            GridView25.DataSource = dt25;
    //            GridView25.DataBind();
    //            for (int i = 0; i < dt25.Rows.Count; i++)
    //            {
    //                total25 = Convert.ToInt32(dt25.Rows[i]["amount"].ToString()) + total25;
    //            }
    //            Label25.Text = Convert.ToString(total25);
    //        }
    //        else
    //        {
    //            l25.Visible = false;
    //            l25d.Visible = false;
    //            l25t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label25.Text = "Invalid UserId!";
    //    }
    //}

    //public void go26()
    //{
    //    DataTable dt26 = new DataTable();
    //    int level = 26;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt26);

    //        if (dt26.Rows.Count > 0)
    //        {
    //            GridView26.DataSource = dt26;
    //            GridView26.DataBind();
    //            for (int i = 0; i < dt26.Rows.Count; i++)
    //            {
    //                total26 = Convert.ToInt32(dt26.Rows[i]["amount"].ToString()) + total26;
    //            }
    //            Label26.Text = Convert.ToString(total26);
    //        }
    //        else
    //        {
    //            l26.Visible = false;
    //            l26d.Visible = false;
    //            l26t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label26.Text = "Invalid UserId!";
    //    }
    //}


    //public void go27()
    //{
    //    DataTable dt27 = new DataTable();
    //    int level = 27;
    //    if (Regex.Match(strsessionid, @"^[0-9]*$").Success)
    //    {
    //        da = new SqlDataAdapter("LevelReportNew", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
    //        da.SelectCommand.Parameters.AddWithValue("@level", level);
    //        con.Open();
    //        da.Fill(dt27);

    //        if (dt27.Rows.Count > 0)
    //        {
    //            GridView27.DataSource = dt27;
    //            GridView27.DataBind();
    //            for (int i = 0; i < dt27.Rows.Count; i++)
    //            {
    //                total27 = Convert.ToInt32(dt27.Rows[i]["amount"].ToString()) + total27;
    //            }
    //            Label27.Text = Convert.ToString(total27);
    //        }
    //        else
    //        {
    //            l27.Visible = false;
    //            l27d.Visible = false;
    //            l27t.Visible = false;

    //        }

    //        con.Close();
    //    }
    //    else
    //    {
    //        Label27.Text = "Invalid UserId!";
    //    }
    //}

    //public void go28()
    //{
    //    DataTable dt28 = new DataTable();
    //    string qstr = "select b.appmstregno,UPPER(b.appmstfname) as fname,s.amount,doe=convert(char(10),s.doe,103)  ,c.appmstregno as SponsorId  from apptransponsor a , sharemst s ,appmst b,appmst c where a.appmstid=s.appmstid and a.appmstid=b.appmstid and  a.parentid in(select appmstid from appmst where appmstRegno='" + strsessionid + "') and sponsorlevel=28  and c.appmstregno=b.sponsorid order by a.appmstid ";
    //    da = new SqlDataAdapter(qstr, con);
    //    con.Open();
    //    da.Fill(dt28);

    //    if (dt28.Rows.Count > 0)
    //    {
    //        GridView28.DataSource = dt28;
    //        GridView28.DataBind();
    //        for (int i = 0; i < dt28.Rows.Count; i++)
    //        {
    //            total28 = Convert.ToInt32(dt28.Rows[i]["amount"].ToString()) + total28;
    //        }
    //        Label28.Text = Convert.ToString(total28);
    //    }
    //    else
    //    {
    //        l28.Visible = false;
    //        l28d.Visible = false;
    //        l28t.Visible = false;

    //    }

    //    con.Close();
    //}


    //public void go29()
    //{
    //    DataTable dt29 = new DataTable();
    //    string qstr = "select b.appmstregno,b.appmstfname+space(1)+b.appmstlname as fname,s.amount,doe=convert(char(10),s.doe,103)  ,c.appmstregno as SponsorId  from apptransponsor a , sharemst s ,appmst b,appmst c where a.appmstid=s.appmstid and a.appmstid=b.appmstid and  a.parentid in(select appmstid from appmst where appmstRegno='" + strsessionid + "') and sponsorlevel=29  and c.appmstregno=b.sponsorid order by a.appmstid ";
    //    da = new SqlDataAdapter(qstr, con);
    //    con.Open();
    //    da.Fill(dt29);

    //    if (dt29.Rows.Count > 0)
    //    {
    //        GridView29.DataSource = dt29;
    //        GridView29.DataBind();
    //        for (int i = 0; i < dt29.Rows.Count; i++)
    //        {
    //            total29 = Convert.ToInt32(dt29.Rows[i]["amount"].ToString()) + total29;
    //        }
    //        Label29.Text = Convert.ToString(total29);
    //    }
    //    else
    //    {
    //        l29.Visible = false;
    //        l29d.Visible = false;
    //        l29t.Visible = false;

    //    }

    //    con.Close();
    //}



    //public void go30()
    //{
    //    DataTable dt30 = new DataTable();
    //    string qstr = "select b.appmstregno,b.appmstfname+space(1)+b.appmstlname as fname,s.amount,doe=convert(char(10),s.doe,103)  ,c.appmstregno as SponsorId  from apptransponsor a , sharemst s ,appmst b,appmst c where a.appmstid=s.appmstid and a.appmstid=b.appmstid and  a.parentid in(select appmstid from appmst where appmstRegno='" + strsessionid + "') and sponsorlevel=30  and c.appmstregno=b.sponsorid order by a.appmstid ";
    //    da = new SqlDataAdapter(qstr, con);
    //    con.Open();
    //    da.Fill(dt30);

    //    if (dt30.Rows.Count > 0)
    //    {
    //        GridView30.DataSource = dt30;
    //        GridView30.DataBind();
    //        for (int i = 0; i < dt30.Rows.Count; i++)
    //        {
    //            total30 = Convert.ToInt32(dt30.Rows[i]["amount"].ToString()) + total30;
    //        }
    //        Label30.Text = Convert.ToString(total30);
    //    }
    //    else
    //    {
    //        l30.Visible = false;
    //        l30d.Visible = false;
    //        l30t.Visible = false;

    //    }

    //    con.Close();
    //}


    //public void go31()
    //{
    //    DataTable dt31 = new DataTable();
    //    string qstr = "select b.appmstregno,b.appmstfname+space(1)+b.appmstlname as fname,s.amount,doe=convert(char(10),s.doe,103)  ,c.appmstregno as SponsorId  from apptransponsor a , sharemst s ,appmst b,appmst c where a.appmstid=s.appmstid and a.appmstid=b.appmstid and  a.parentid in(select appmstid from appmst where appmstRegno='" + strsessionid + "') and sponsorlevel=31  and c.appmstregno=b.sponsorid order by a.appmstid ";
    //    da = new SqlDataAdapter(qstr, con);
    //    con.Open();
    //    da.Fill(dt31);

    //    if (dt31.Rows.Count > 0)
    //    {
    //        GridView31.DataSource = dt31;
    //        GridView31.DataBind();
    //        for (int i = 0; i < dt31.Rows.Count; i++)
    //        {
    //            total31 = Convert.ToInt32(dt31.Rows[i]["amount"].ToString()) + total31;
    //        }
    //        Label31.Text = Convert.ToString(total31);
    //    }
    //    else
    //    {
    //        l31.Visible = false;
    //        l31d.Visible = false;
    //        l31t.Visible = false;

    //    }

    //    con.Close();
    //}


    //public void go32()
    //{
    //    DataTable dt32 = new DataTable();
    //    string qstr = "select b.appmstregno,b.appmstfname+space(1)+b.appmstlname as fname,s.amount,doe=convert(char(10),s.doe,103)  ,c.appmstregno as SponsorId  from apptransponsor a , sharemst s ,appmst b,appmst c where a.appmstid=s.appmstid and a.appmstid=b.appmstid and  a.parentid in(select appmstid from appmst where appmstRegno='" + strsessionid + "') and sponsorlevel=32  and c.appmstregno=b.sponsorid order by a.appmstid ";
    //    da = new SqlDataAdapter(qstr, con);
    //    con.Open();
    //    da.Fill(dt32);

    //    if (dt32.Rows.Count > 0)
    //    {
    //        GridView32.DataSource = dt32;
    //        GridView32.DataBind();
    //        for (int i = 0; i < dt32.Rows.Count; i++)
    //        {
    //            total32 = Convert.ToInt32(dt32.Rows[i]["amount"].ToString()) + total32;
    //        }
    //        Label32.Text = Convert.ToString(total32);
    //    }
    //    else
    //    {
    //        l32.Visible = false;
    //        l32d.Visible = false;
    //        l32t.Visible = false;

    //    }

    //    con.Close();
    //}


    //public void go33()
    //{
    //    DataTable dt33 = new DataTable();
    //    string qstr = "select b.appmstregno,b.appmstfname+space(1)+b.appmstlname as fname,s.amount,doe=convert(char(10),s.doe,103)  ,c.appmstregno as SponsorId  from apptransponsor a , sharemst s ,appmst b,appmst c where a.appmstid=s.appmstid and a.appmstid=b.appmstid and  a.parentid in(select appmstid from appmst where appmstRegno='" + strsessionid + "') and sponsorlevel=33  and c.appmstregno=b.sponsorid order by a.appmstid ";
    //    da = new SqlDataAdapter(qstr, con);
    //    con.Open();
    //    da.Fill(dt33);

    //    if (dt33.Rows.Count > 0)
    //    {
    //        GridView33.DataSource = dt33;
    //        GridView33.DataBind();
    //        for (int i = 0; i < dt33.Rows.Count; i++)
    //        {
    //            total33 = Convert.ToInt32(dt33.Rows[i]["amount"].ToString()) + total33;
    //        }
    //        Label33.Text = Convert.ToString(total33);
    //    }
    //    else
    //    {
    //        l33.Visible = false;
    //        l33d.Visible = false;
    //        l33t.Visible = false;

    //    }

    //    con.Close();
    //}


    //public void go34()
    //{
    //    DataTable dt34 = new DataTable();
    //    string qstr = "select b.appmstregno,b.appmstfname+space(1)+b.appmstlname as fname,s.amount,doe=convert(char(10),s.doe,103)  ,c.appmstregno as SponsorId  from apptransponsor a , sharemst s ,appmst b,appmst c where a.appmstid=s.appmstid and a.appmstid=b.appmstid and  a.parentid in(select appmstid from appmst where appmstRegno='" + strsessionid + "') and sponsorlevel=34  and c.appmstregno=b.sponsorid order by a.appmstid ";
    //    da = new SqlDataAdapter(qstr, con);
    //    con.Open();
    //    da.Fill(dt34);

    //    if (dt34.Rows.Count > 0)
    //    {
    //        GridView34.DataSource = dt34;
    //        GridView34.DataBind();
    //        for (int i = 0; i < dt34.Rows.Count; i++)
    //        {
    //            total34 = Convert.ToInt32(dt34.Rows[i]["amount"].ToString()) + total34;
    //        }
    //        Label34.Text = Convert.ToString(total34);
    //    }
    //    else
    //    {
    //        l34.Visible = false;
    //        l34d.Visible = false;
    //        l34t.Visible = false;

    //    }

    //    con.Close();
    //}


    //public void go35()
    //{
    //    DataTable dt35 = new DataTable();
    //    string qstr = "select b.appmstregno,b.appmstfname+space(1)+b.appmstlname as fname,s.amount,doe=convert(char(10),s.doe,103)  ,c.appmstregno as SponsorId  from apptransponsor a , sharemst s ,appmst b,appmst c where a.appmstid=s.appmstid and a.appmstid=b.appmstid and  a.parentid in(select appmstid from appmst where appmstRegno='" + strsessionid + "') and sponsorlevel=35  and c.appmstregno=b.sponsorid order by a.appmstid ";
    //    da = new SqlDataAdapter(qstr, con);
    //    con.Open();
    //    da.Fill(dt35);

    //    if (dt35.Rows.Count > 0)
    //    {
    //        GridView35.DataSource = dt35;
    //        GridView35.DataBind();
    //        for (int i = 0; i < dt35.Rows.Count; i++)
    //        {
    //            total35 = Convert.ToInt32(dt35.Rows[i]["amount"].ToString()) + total35;
    //        }
    //        Label35.Text = Convert.ToString(total35);
    //    }
    //    else
    //    {
    //        l35.Visible = false;
    //        l35d.Visible = false;
    //        l35t.Visible = false;

    //    }

    //    con.Close();
    //}

    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    go1();
    //}
    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView2.PageIndex = e.NewPageIndex;
        go2();
    }
    protected void GridView3_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView3.PageIndex = e.NewPageIndex;
        go3();
    }
   // protected void GridView4_PageIndexChanging(object sender, GridViewPageEventArgs e)
   // {
   //     GridView4.PageIndex = e.NewPageIndex;
    //    go4();
   // }

   // protected void GridView5_PageIndexChanging(object sender, GridViewPageEventArgs e)
   // {
       /// GridView4.PageIndex = e.NewPageIndex;
       // go5();
   // }
    //protected void GridView7_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView7.PageIndex = e.NewPageIndex;
    //    go7();
    //}

    //protected void GridView8_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView8.PageIndex = e.NewPageIndex;
    //    go8();
    //}

    //protected void GridView9_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView9.PageIndex = e.NewPageIndex;
    //    go9();
    //}

    //protected void GridView10_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView10.PageIndex = e.NewPageIndex;
    //    go10();
    //}

    //protected void GridView11_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView11.PageIndex = e.NewPageIndex;
    //    go11();
    //}

    //protected void GridView12_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView12.PageIndex = e.NewPageIndex;
    //    go12();
    //}

    //protected void GridView13_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView13.PageIndex = e.NewPageIndex;
    //    go13();
    //}

    //protected void GridView14_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView14.PageIndex = e.NewPageIndex;
    //    go14();
    //}

    //protected void GridView15_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView15.PageIndex = e.NewPageIndex;
    //    go15();
    //}

    //protected void GridView16_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView16.PageIndex = e.NewPageIndex;
    //    go16();
    //}

    //protected void GridView17_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView17.PageIndex = e.NewPageIndex;
    //    go17();
    //}

    //protected void GridView18_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView18.PageIndex = e.NewPageIndex;
    //    go18();
    //}

    //protected void GridView19_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView19.PageIndex = e.NewPageIndex;
    //    go19();
    //}

    //protected void GridView20_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView20.PageIndex = e.NewPageIndex;
    //    go20();
    //}

    //protected void GridView21_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView21.PageIndex = e.NewPageIndex;
    //    go21();
    //}

    //protected void GridView22_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView22.PageIndex = e.NewPageIndex;
    //    go22();
    //}

    //protected void GridView23_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView23.PageIndex = e.NewPageIndex;
    //    go23();
    //}

    //protected void GridView24_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView24.PageIndex = e.NewPageIndex;
    //    go24();
    //}

    //protected void GridView25_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView25.PageIndex = e.NewPageIndex;
    //    go25();
    //}

    //protected void GridView26_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView26.PageIndex = e.NewPageIndex;
    //    go26();
    //}

    //protected void GridView27_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView27.PageIndex = e.NewPageIndex;
    //    go27();
    //}

    //protected void GridView28_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView28.PageIndex = e.NewPageIndex;
    //    go28();
    //}

    //protected void GridView29_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView29.PageIndex = e.NewPageIndex;
    //    go29();
    //}

    //protected void GridView30_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView30.PageIndex = e.NewPageIndex;
    //    go30();
    //}

    //protected void GridView31_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView31.PageIndex = e.NewPageIndex;
    //    go31();
    //}

    //protected void GridView32_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView32.PageIndex = e.NewPageIndex;
    //    go32();
    //}

    //protected void GridView33_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView33.PageIndex = e.NewPageIndex;
    //    go33();
    //}

    //protected void GridView34_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView34.PageIndex = e.NewPageIndex;
    //    go34();
    //}

    //protected void GridView35_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView35.PageIndex = e.NewPageIndex;
    //    go35();
    //}


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        go1();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void imgbtnExport_Click(object sender, ImageClickEventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LeveReport.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            GridView1.AllowPaging = false;
            go1();
            GridView1.HeaderRow.BackColor = System.Drawing.Color.White;
            foreach (TableCell cell in GridView1.HeaderRow.Cells)
            {
                cell.BackColor = GridView1.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in GridView1.Rows)
            {
                row.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = GridView1.RowStyle.BackColor;
                    }
                    cell.CssClass = "textmode";


                    List<Control> controls = new List<Control>();

                    //Add controls to be removed to Generic List
                    foreach (Control control in cell.Controls)
                    {
                        controls.Add(control);
                    }

                    //Loop through the controls to be removed and replace with Literal
                    foreach (Control control in controls)
                    {
                        switch (control.GetType().Name)
                        {
                            case "HyperLink":
                                cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
                                break;
                            case "TextBox":
                                cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
                                break;
                            case "LinkButton":
                                cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
                                break;
                        }
                        cell.Controls.Remove(control);
                    }
                }
            }

            GridView1.RenderControl(hw);
            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }

    }
}
