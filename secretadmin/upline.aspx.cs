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
using System.Text.RegularExpressions;
public partial class admin_upline : System.Web.UI.Page
{
    string spstr;
       
    int sp = 2;
    DataTable t = new DataTable();
    string strsessionid;
    SqlConnection con = new SqlConnection(method.str);
    SqlDataReader sr;
    SqlCommand com;
    SqlDataAdapter dr;
    protected void Page_Load(object sender, EventArgs e)
    {

        InsertFunction.CheckAdminlogin();
        //string strsession = Convert.ToString(Session["userName"]);
        //if (strsession == "")
        //{
        //    Response.Redirect("adminLog.aspx");
        //}
        if(!IsPostBack){
            spstr = TextBox1.Text;
            go();


        }




    }
    public void go()
    {


        string qstr = "select AppMstRegNo,AppMstTitle+space(1)+AppMstFName+space(1)+AppMstLName as AppMstFName,SponsorID,ParentID,AppMstLeftRight,CONVERT(VARCHAR(10), appmstdoj, 103) as AppmstDOJ,joinfor,appmstpaid=case appmstpaid when 0 then 'UnPaid' when 1 then 'Paid' end from AppMst where appmstregno='" + spstr + "'";
        DataTable t1 = new DataTable();
        dr = new SqlDataAdapter(qstr, con);
        dr.Fill(t1);
        t = new DataTable();
        DataColumn c = new DataColumn();
        c.ColumnName = "AppMstRegNo";
        t.Columns.Add(c);

        DataColumn c1 = new DataColumn();
        c1.ColumnName = "AppMstFName";
        t.Columns.Add(c1);
        DataColumn c2 = new DataColumn();
        c2.ColumnName = "SponsorID";
        t.Columns.Add(c2);
        DataColumn c3 = new DataColumn();
        c3.ColumnName = "ParentID";
        t.Columns.Add(c3);
        DataColumn c4 = new DataColumn();
        c4.ColumnName = "AppMstLeftRight";
        t.Columns.Add(c4);
        DataColumn c5 = new DataColumn();
        c5.ColumnName = "AppmstDOJ";
        t.Columns.Add(c5);
        DataColumn c6 = new DataColumn();
        c6.ColumnName = "Joinfor";
        t.Columns.Add(c6);
        DataColumn c7 = new DataColumn();
        c7.ColumnName = "appmstpaid";
          t.Columns.Add(c7);


  
        if (t1.Rows.Count > 0)
        {
            for (int i = 0; i < t1.Rows.Count; i++)
            {
                string pstr = t1.Rows[i][4].ToString();
                if (pstr == "0")
                {


                    string str3 = t1.Rows[i][sp].ToString();
                    //===========
                    DataRow r = t.NewRow();
                    r["AppMstRegNo"] = t1.Rows[i][0].ToString();

                    r["AppMstFName"] = t1.Rows[i][1].ToString();
                    r["SponsorID"] = t1.Rows[i][2].ToString();
                    r["ParentID"] = t1.Rows[i][3].ToString();
                    r["AppMstLeftRight"] = "Left";
                    r["AppmstDOJ"] = t1.Rows[i][5].ToString();
                    r["Joinfor"] = t1.Rows[i][6].ToString();
                    r["appmstpaid"] = t1.Rows[i][7].ToString();
                    t.Rows.Add(r);




                    if (str3 == null)
                    {

                    }
                    else
                    {
                        lput(str3);
                    }

                }
                else
                {

                    string str4 = t1.Rows[i][sp].ToString();
                    DataRow r = t.NewRow();
                    r["AppMstRegNo"] = t1.Rows[i][0].ToString();

                    r["AppMstFName"] = t1.Rows[i][1].ToString();
                    r["SponsorID"] = t1.Rows[i][2].ToString();
                    r["ParentID"] = t1.Rows[i][3].ToString();
                    r["AppMstLeftRight"] = "Right";
                    r["AppmstDOJ"] = t1.Rows[i][5].ToString();
                    r["Joinfor"] = t1.Rows[i][6].ToString();
                    r["appmstpaid"] = t1.Rows[i][7].ToString();
                    t.Rows.Add(r);

                    if (str4 == null)
                    {

                    }
                    else
                    {
                        rput(str4);


                    }
                }
            } dgrid.DataSource = t;
            dgrid.DataBind();
        }
        else { }
    }
    //================================

    public void lput(string lstr)
    {
        string lqstr = "select  AppMstRegNo,AppMstTitle+space(1)+AppMstFName+space(1)+AppMstLName as AppMstFName,SponsorID,ParentID,AppMstLeftRight,CONVERT(VARCHAR(10), appmstdoj, 103) as AppmstDOJ,joinfor,appmstpaid=case appmstpaid when 0 then 'UnPaid' when 1 then 'Paid' end from AppMst where appmstregno='" + lstr + "'";
        DataTable t1 = new DataTable();
        dr = new SqlDataAdapter(lqstr, con);
        dr.Fill(t1);
        for (int i = 0; i < t1.Rows.Count; i++)
        {
            string pstr = t1.Rows[i][4].ToString();
            if (pstr == "0")
            {

                string lstr3 = t1.Rows[i][sp].ToString();
                DataRow r = t.NewRow();
                r["AppMstRegNo"] = t1.Rows[i][0].ToString();

                r["AppMstFName"] = t1.Rows[i][1].ToString();
                r["SponsorID"] = t1.Rows[i][2].ToString();
                r["ParentID"] = t1.Rows[i][3].ToString();
                r["AppMstLeftRight"] = "Left";
                r["AppmstDOJ"] = t1.Rows[i][5].ToString();
                r["Joinfor"] = t1.Rows[i][6].ToString();
                r["appmstpaid"] = t1.Rows[i][7].ToString();
                t.Rows.Add(r);



                if (lstr3 == null)
                {

                }
                else
                {
                    lput(lstr3);
                }

            }
            else
            {

                string lstr4 = t1.Rows[i][sp].ToString();
                DataRow r = t.NewRow();
                r["AppMstRegNo"] = t1.Rows[i][0].ToString();

                r["AppMstFName"] = t1.Rows[i][1].ToString();
                r["SponsorID"] = t1.Rows[i][2].ToString();
                r["ParentID"] = t1.Rows[i][3].ToString();
                r["AppMstLeftRight"] = "Right";
                r["AppmstDOJ"] = t1.Rows[i][5].ToString();
                r["Joinfor"] = t1.Rows[i][6].ToString();
                r["appmstpaid"] = t1.Rows[i][7].ToString();
                t.Rows.Add(r);


                if (lstr4 == null)
                {

                }
                else
                {
                    lput(lstr4);


                }
            }
        }

    }
    public void rput(string rstr)
    {

        string rqstr = "select  AppMstRegNo,AppMstTitle+space(1)+AppMstFName+space(1)+AppMstLName as AppMstFName,SponsorID,ParentID,AppMstLeftRight,CONVERT(VARCHAR(10), appmstdoj, 103) as AppmstDOJ,joinfor,appmstpaid=case appmstpaid when 0 then 'UnPaid' when 1 then 'Paid' end from AppMst where appmstregno='" + rstr + "'";
        DataTable t1 = new DataTable();
        dr = new SqlDataAdapter(rqstr, con);
        dr.Fill(t1);
        for (int i = 0; i < t1.Rows.Count; i++)
        {
            string pstr = t1.Rows[i][4].ToString();
            if (pstr == "0")
            {

                string rstr3 = t1.Rows[i][sp].ToString();
                DataRow r = t.NewRow();
                r["AppMstRegNo"] = t1.Rows[i][0].ToString();

                r["AppMstFName"] = t1.Rows[i][1].ToString();
                r["SponsorID"] = t1.Rows[i][2].ToString();
                r["ParentID"] = t1.Rows[i][3].ToString();
                r["AppMstLeftRight"] = "Left";
                r["AppmstDOJ"] = t1.Rows[i][5].ToString();
                r["Joinfor"] = t1.Rows[i][6].ToString();
                r["appmstpaid"] = t1.Rows[i][7].ToString();
                t.Rows.Add(r);



                if (rstr3 == null)
                {

                }
                else
                {
                    rput(rstr3);
                }

            }
            else
            {

                string rstr4 = t1.Rows[i][sp].ToString();
                DataRow r = t.NewRow();
                r["AppMstRegNo"] = t1.Rows[i][0].ToString();

                r["AppMstFName"] = t1.Rows[i][1].ToString();
                r["SponsorID"] = t1.Rows[i][2].ToString();
                r["ParentID"] = t1.Rows[i][3].ToString();
                r["AppMstLeftRight"] = "Right";
                r["AppmstDOJ"] = t1.Rows[i][5].ToString();
                r["Joinfor"] = t1.Rows[i][6].ToString();
                r["appmstpaid"] = t1.Rows[i][7].ToString();
                t.Rows.Add(r);



                if (rstr4 == null)
                {

                }
                else
                {
                    rput(rstr4);


                }
            }
        }
    }
    protected void dgrid_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        dgrid.CurrentPageIndex = e.NewPageIndex;
        go();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Regex.Match(TextBox1.Text, @"^[a-zA-Z0-9]*$").Success)
        {

            dgrid.CurrentPageIndex = 0;
            TextBox2.Text = "";
            spstr = TextBox1.Text;
            sp = 2;
            go();
        }
        else
        {
            Label1.Text = "Invalid UserID";
        }
        

    }

    protected void parent_Click(object sender, EventArgs e)
    {
       

        if (Regex.Match(TextBox2.Text, @"^[a-zA-Z0-9]*$").Success)
        {

            dgrid.CurrentPageIndex = 0;
            TextBox1.Text = "";
            spstr = TextBox2.Text;
            sp = 3;
            go();

        }
        else
        {
            Label1.Text = "Invalid UserID";
        }
        

    }
  
}
