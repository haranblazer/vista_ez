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

public partial class admin_LeftRightShift : System.Web.UI.Page
{
    SqlDataReader sr;
    SqlCommand com;
    SqlDataAdapter dr;
    int id, a = 0, pid = 0, idn = 0, upid = 0, downid = 0, t, left = 0,f=0,TotalLeftRight=0;
    int SponsorID;
    string AppMstTitle, AppMstFName, AppMstLname, AppMstDOJ, AppMstState, AppMstCity, AppMstAddress1, AppMstAddress2;
    string AppMstPinCode, AppMstPrimaryPhone, AppMstPassword, AppMstLogin,str;
    int AppMstID;
    int AppMstRegNo;
    int AppMstSponsorTotal;
    int b;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (leftrightradio.Checked)
        {
            DDleftright.Enabled = true;
            sponserid.Enabled = false;
            RequiredFieldValidator1.Enabled = true;
            RequiredFieldValidator3.Enabled = false;
        }
        else
        {
            sponserid.Enabled = true;
            DDleftright.Enabled = false;
            RequiredFieldValidator3.Enabled = true;
            RequiredFieldValidator1.Enabled = false;
        }
    }
    private void checkid()
    {
        SqlConnection con = new SqlConnection(method.str);
        str = "select * from AppMst where AppMstID='" + idno.Text + "'";
        com = new SqlCommand(str, con);
        con.Open();
        sr = com.ExecuteReader(CommandBehavior.CloseConnection);
        if (sr.HasRows)
        {
            sr.Read();
            pid = Convert.ToInt32(sr["ParentID"]);
            AppMstID = Convert.ToInt32(idno.Text);
            error.Text = "";
            if (leftrightradio.Checked)
            {
                error.Visible = true;
                error.Text = "Success";
                con.Close();
                storeleftright(); 
                getleftvalues();
                parentid();
            }
            else
            {
                sponserid.Enabled = true;
                DDleftright.Enabled = false;
            }
        }
        else
        {
            error.Text = "Invalid Id";
            con.Close();
        }
    }
    private void storeleftright() 
    {
        if (DDleftright.SelectedItem.Value == "Right")
            left = 1;
        else
            left = 0;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("CheckSponsor", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@sid", pid);
        con.Open();
        SqlDataReader dr;
        dr = com.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            if (left == 0)
                TotalLeftRight = Convert.ToInt32(dr["AppMstRightTotal"]);
            else
                TotalLeftRight = Convert.ToInt32(dr["AppMstLeftTotal"]);          
        }
    }
    private void changeleftright()
    {
        int p = 0;
        str = DDleftright.SelectedItem.Value;
        if (str == "Left")
            p = 0;
        else
            p = 1;
        SqlConnection con = new SqlConnection(method.str);
        str = "update AppMst set AppMstLeftRight='" + p + "' where AppMstID='" + idno.Text + "'";
        com = new SqlCommand(str, con);
        con.Open();
        com.ExecuteNonQuery();
        con.Close();
    }
    // Find Parrent IdNo.
    private void parentid()
    {
        int f;
        if (DDleftright.SelectedItem.Value == "Right")
        {
            f = 0;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("select * from AppMst where ParentId ='"+pid+"'  and AppMstLeftRight='"+f+"'", con);
            SqlDataReader dr;
            con.Open();
            dr = com.ExecuteReader();
            //if (dr.HasRows)
            //{
            //    dr.Read();
            //    a = Convert.ToInt32(dr["appmstid"]);
            //    if (a > 0)
            //        pid = Convert.ToInt32(dr["appmstid"]);
            //    else
            //        againfind();
            //    con.Close();
            //    parentid();
            //}
            //else
            {
                updateparentid();
            }
            con.Close();
        }
        if (DDleftright.SelectedItem.Value == "Left")
        {
            f = 1;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("select * from AppMst where ParentId ='" + pid + "'  and AppMstLeftRight='" + f + "'", con);
            SqlDataReader dr;
            con.Open();
            dr = com.ExecuteReader();
            //if (dr.HasRows)
            //{
            //    dr.Read();
            //    a = Convert.ToInt32(dr["appmstid"]);
            //    if (a > 0)
            //        pid = Convert.ToInt32(dr["appmstid"]);
            //    else
            //        againfind();
            //    con.Close();
            //    parentid();
            //}
            //else
            {
                updateparentid();
            }
            con.Close();
        }
    }
    private void againfind()
    {
        int f;
        if (DDleftright.SelectedItem.Value == "Right")
        {
            f = 1;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("select * from AppMst where ParentId ='" + a + "'  and AppMstLeftRight='" + f + "'", con);
            SqlDataReader dr;
            con.Open();
            dr = com.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                a = Convert.ToInt32(dr["appmstid"]);
                againfind();
            }
            con.Close();
        }
        else if (DDleftright.SelectedItem.Value == "Left")
        {
            f = 0;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("select * from AppMst where ParentId ='" + a + "'  and AppMstLeftRight='" + f + "'", con);
            SqlDataReader dr;
            con.Open();
            dr = com.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                a = Convert.ToInt32(dr["appmstid"]);
                con.Close();
                againfind();
            }
        }
    }
    // Update Parrent Id.
    private void updateparentid()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("UpdateParentID", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@pid", pid);
        com.Parameters.AddWithValue("@id", AppMstID);
        con.Open();
        com.ExecuteNonQuery();
        con.Close();
        idn = AppMstID;
        downid = AppMstID;
        changeleftright();
        getpid();
        //getleftvalues();
    }
    // Get Previous Parrent Id
    private void getleftvalues()
    {
        //getpid();
        if (DDleftright.SelectedItem.Value == "Right")
            left = 1;
        else
            left = 0;
        upid = Convert.ToInt32(idno.Text);
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("CheckSponsor", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@sid", upid);
        con.Open();
        SqlDataReader dr;
        dr = com.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            if (left == 0)
            {
                upid = Convert.ToInt32(dr["ParentID"]);
                updateright2();
            }
            else
            {
                upid = Convert.ToInt32(dr["ParentID"]);
                updateleft2();
            }
            upid = Convert.ToInt32(dr["ParentID"]);
        }
    }
    private void getpid()
    {
        upid = Convert.ToInt32(idno.Text);
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("CheckSponsor", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@sid", upid);
        con.Open();
        SqlDataReader dr;
        dr = com.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            upid = Convert.ToInt32(dr["ParentID"]);
        }
        getleftvalues2();
    }

    // Repeat this function
    private void getleftvalues2()
    {
        if (DDleftright.SelectedItem.Value == "Right")
            left = 1;
        else
            left = 0;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("CheckSponsor", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@sid", upid);
        con.Open();
        SqlDataReader dr;
        dr = com.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            if (left == 0)
            {
                t = TotalLeftRight;
                updateleft();
            }
            else
            {
                t = TotalLeftRight;
                updateright();
            }
            a = Convert.ToInt32(dr["ParentID"]);
            //if (a > 0)
            //{
              //  upid = a;
               /// TotalLeftRight++;
                //getleftvalues2();
           // }
        }
    }
    private void updateleft()
    {
        upid = pid;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("UpdateTotalLeft", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@total", t);
        com.Parameters.AddWithValue("@upid", upid);
        con.Open();
        com.ExecuteNonQuery();
        con.Close();
    }
    private void updateright()
    {
        upid = pid;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("UpdateTotalRight", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@total", t);
        com.Parameters.AddWithValue("@upid", upid);
        con.Open();
        com.ExecuteNonQuery();
        con.Close();
    }
    private void updateleft2()
    {
        t = 0;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("UpdateTotalLeft", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@total", t);
        com.Parameters.AddWithValue("@upid", upid);
        con.Open();
        com.ExecuteNonQuery();
        con.Close();
    }
    private void updateright2()
    {
        t = 0;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("UpdateTotalRight", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@total", t);
        com.Parameters.AddWithValue("@upid", upid);
        con.Open();
        com.ExecuteNonQuery();
        con.Close();
    }




    protected void Button2_Click(object sender, EventArgs e)
    {
        int a,b;
        if (sponserid.Enabled == true)
        {
            a = Convert.ToInt32(sponserid.Text);
            b = Convert.ToInt32(idno.Text);
            if (a >= b)
            {
                error.Visible = true;
                error.Text = "Invalid Id :-";
            }
            else
            {
                error.Text = "Success :-";
                changesponser();
            }
        }
        else
        {
            checkvalidparrentid();
        }
    }
    private void checkvalidparrentid()
    {
        SqlConnection con = new SqlConnection(method.str);
        str = "select * from AppMst where AppMstID='" + idno.Text + "'";
        com = new SqlCommand(str, con);
        con.Open();
        sr = com.ExecuteReader(CommandBehavior.CloseConnection);
        if (sr.HasRows)
        {
            sr.Read();
            pid = Convert.ToInt32(sr["ParentID"]);
        }
        else
        {
            error.Text = "Invalid Id";
            con.Close();
        }
        againcheckvalidparrentid();
    }
    private void againcheckvalidparrentid()
    {
        int f;
        if (DDleftright.SelectedItem.Value == "Right")
        {
            f = 1;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("select * from AppMst where ParentId ='" + pid + "'  and AppMstLeftRight='" + f + "'", con);
            SqlDataReader dr;
            con.Open();
            dr = com.ExecuteReader();
            if (dr.HasRows)
            {
                error.Visible = true;
                error.Text = "Invalid Operation";
            }
            else
            {
                con.Close();
                checkid();
            }
        }
        else if (DDleftright.SelectedItem.Value == "Left")
        {
            f = 0;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("select * from AppMst where ParentId ='" + a + "'  and AppMstLeftRight='" + f + "'", con);
            SqlDataReader dr;
            con.Open();
            dr = com.ExecuteReader();
            if (dr.HasRows)
            {
                error.Visible = true;
                error.Text = "Invalid Operation";
            }
            else
            {
                con.Close();
                checkid();
            }
        }
    }
    private void changesponser()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("select * from AppMst where appmstid ='" + idno.Text + "'", con);
        SqlDataReader dr;
        con.Open();
        dr = com.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            f = 0;
            SponsorID = Convert.ToInt32(dr["SponsorID"]);
            con.Close();
            getsponserdata();
            f = 1;
            SponsorID = Convert.ToInt32(sponserid.Text);
            getsponserdata();
            f = 0;
        }
        else
        {
            error.Visible = true;
            error.Text = "Invalid Sponser Id";
        }
        con.Close();
    }
    private void getsponserdata()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("select * from AppMst where appmstid ='" + SponsorID + "'", con);
        SqlDataReader dr;
        con.Open();
        dr = com.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            t = Convert.ToInt32(dr["AppMstSponsorTotal"]);
            con.Close();
            updatetotalsponser();
        }
        con.Close();
    }
    private void updatetotalsponser()
    {
        if (f == 0)
            t--;
        else
            t++;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("update AppMst set AppMstSponsorTotal = '" + t + "' where appmstid ='" + SponsorID + "'", con);
        con.Open();
        com.ExecuteNonQuery();
        con.Close();
        updatetotalsponser2();
    }
    private void updatetotalsponser2()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("update AppMst set SponsorID = '" + sponserid.Text + "' where appmstid ='" + idno.Text + "'", con);
        con.Open();
        com.ExecuteNonQuery();
        con.Close();
    }



    protected void sponserid_TextChanged(object sender, EventArgs e)
    {

    }
    protected void DDleftright_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
