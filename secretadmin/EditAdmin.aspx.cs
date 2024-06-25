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
using System.Linq;
using System.Collections.Generic;

public partial class admin_CreateAdmin : System.Web.UI.Page
{
    DataTable dt = null;
    SqlDataReader sdr;
    SqlConnection con = null;
    SqlCommand cmd;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {
                GetOptionsList();
                GetAdminList();
            }
        }
        catch
        {

        }
       
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (ddlAdmin.SelectedIndex > 0)
        {
            List<CheckBoxList> ObjChkList = Master.FindControl("ContentPlaceHolder1").Controls.OfType<CheckBoxList>().Where(o => o is CheckBoxList).ToList();
            foreach (CheckBoxList chklist in ObjChkList)
            {
                foreach (ListItem item in chklist.Items)
                {
                    if (item.Selected)
                        SavePagePermissions(item.Value, 1);
                    else
                        SavePagePermissions(item.Value, 0);
                }
            }
            InsertUpdatePagePermission();
        }
        else
            utility.MessageBox(this,"Select a admin ");
    }



    /// <summary>
    /// 
    /// </summary>
    private void GetOptionsList()
    {
        //tabAccessCodeSystem
        HtmlGenericControl Div = (HtmlGenericControl)Master.FindControl("divmain");
        foreach (HtmlGenericControl tabDiv in Div.Controls.Cast<Control>().Where(o => o is HtmlGenericControl))
        {
            //l_tabAccessCodeSystem
            HtmlGenericControl Legend = Master.FindControl("ContentPlaceHolder1").FindControl("l_"+tabDiv.ID) == null ? null : (HtmlGenericControl)Master.FindControl("ContentPlaceHolder1").FindControl("l_"+tabDiv.ID);
           
            CheckBoxList chkList=Master.FindControl("ContentPlaceHolder1").FindControl(tabDiv.ID)==null?null:(CheckBoxList)Master.FindControl("ContentPlaceHolder1").FindControl(tabDiv.ID);
            if (Legend != null)
                Legend.InnerText = (System.Web.UI.LiteralControl)(tabDiv.Controls[0])==null?"":((System.Web.UI.LiteralControl)(tabDiv.Controls[0])).Text.Replace("<li>", "").Replace("</li>", "");
            if (chkList != null)
            {
                foreach (HtmlAnchor Anchor in tabDiv.Controls.Cast<Control>().Where(o => o is HtmlAnchor))
                {
                    //value is made lower
                    chkList.Items.Add(new ListItem(Anchor.InnerText, Anchor.HRef.ToLower()));
                }
            }
        }
    }

    public void SavePagePermissions(string pagename, int permission)
    {
        if (pagename.Trim() == "welcome.aspx")
            permission = 1;

        if (dt == null)
        {
            dt = new DataTable();
            DataColumn dc1 = new DataColumn("userid", typeof(string));
            DataColumn dc2 = new DataColumn("pagename", typeof(string));
            DataColumn dc3 = new DataColumn("permission", typeof(int));
            dt.Columns.Add(dc1);
            dt.Columns.Add(dc2);
            dt.Columns.Add(dc3);
        }
        DataRow row = dt.NewRow();
        row["userid"] = ddlAdmin.SelectedItem.Value;
        row["pagename"] = pagename.Trim();
        row["permission"] = permission;
        dt.Rows.Add(row);

        if (pagename.Trim() == "adchangeprofile.aspx")
        {
            DataRow row1 = dt.NewRow();
            row1["userid"] = ddlAdmin.SelectedItem.Value;
            row1["pagename"] = "Edit.aspx";
            row1["permission"] = 1;
            dt.Rows.Add(row1);
        }
    }

    private void GetAdminList()
    {
        try
        {
            //and isdeleted=0
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("select username as uname, name=name +' ('+ username +')' from controlmst where admintype!='sa'", con);
            
            con.Open();
            sdr = cmd.ExecuteReader();
            if (sdr.HasRows)
            {
                ddlAdmin.DataSource = sdr;
                ddlAdmin.DataTextField = "name";
                ddlAdmin.DataValueField = "uname";
                ddlAdmin.DataBind();
                ddlAdmin.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            con.Close();
        }
        catch
        {
        }
    }

    private void GetPagePermission(string uid)
    {
        try
        {
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("select userid,pagename,permission from pagepermissions where userid=@userid", con);
            cmd.Parameters.AddWithValue("@userid", uid);
            con.Open();
            sdr = cmd.ExecuteReader();
            if (sdr.HasRows)
            {
                while (sdr.Read())
                {
                    SavePagePermissions(sdr["pagename"].ToString(), Convert.ToInt32(sdr["permission"]));
                }
            }
            con.Close();

        }
        catch
        {
        }
    }

    private void InsertUpdatePagePermission()
    {
        try
        {
            
                con = new SqlConnection(method.str);
                con.Open();
                SqlCommand com = null;
                foreach (DataRow row in dt.Rows)
                {                    
                    com = new SqlCommand("if(exists(select srno from pagepermissions where  userid=@userid and pagename=@pagename))" +
                        "update pagepermissions set permission=@permission where  userid=@userid and pagename=@pagename else " +
                        "insert into pagepermissions (userid,pagename,permission) values(@userid,@pagename,@permission)", con);
                    com.Parameters.AddWithValue("@userid", row["userid"].ToString());
                    com.Parameters.AddWithValue("@pagename", row["pagename"].ToString());
                    com.Parameters.AddWithValue("@permission", row["permission"].ToString());
                    com.ExecuteNonQuery();
                }
                con.Close();
                utility.MessageBox(this,"Permissions granted successfully.");
              //  ResetControls();
            
           
        }
        catch
        {
        }
    }

    private void ResetControls()
    {
         List<CheckBoxList> ObjChkList = Master.FindControl("ContentPlaceHolder1").Controls.OfType<CheckBoxList>().Where(o => o is CheckBoxList).ToList();
         foreach (CheckBoxList chklist in ObjChkList)
         {
             chklist.ClearSelection();
         }
    }



    protected void ddlAdmin_SelectedIndexChanged(object sender, EventArgs e)
    {
        ResetControls();
        GetPagePermission(ddlAdmin.SelectedItem.Value);
        if (dt != null)
        {
            List<CheckBoxList> ObjChkList = Master.FindControl("ContentPlaceHolder1").Controls.OfType<CheckBoxList>().Where(o => o is CheckBoxList).ToList();
            foreach (CheckBoxList chklist in ObjChkList)
            {
                foreach (ListItem item in chklist.Items)
                {
                    //string value = dt.AsEnumerable().Where(o =>string.Compare( o.Field<string>("pagename"),item.Value,true)==0 && o.Field<int>("permission") == 1).FirstOrDefault() == null ? null : dt.AsEnumerable().Where(o => o.Field<string>("pagename") == item.Value && o.Field<int>("permission") == 1).FirstOrDefault().Field<string>("pagename").ToLower();
                    string value = dt.AsEnumerable().Where(o => string.Compare(o.Field<string>("pagename"), item.Value, true) == 0 && o.Field<int>("permission") == 1).FirstOrDefault() == null ? null : dt.AsEnumerable().Where(o => string.Compare(o.Field<string>("pagename"), item.Value, true) == 0 && o.Field<int>("permission") == 1).FirstOrDefault().Field<string>("pagename").ToLower();
                    if (chklist.Items.FindByValue(value) != null)
                        chklist.Items.FindByValue(value).Selected = true;
                }
            }
        }
    }
}

