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
using System.Net;
using System.IO;
using System.Text;
using System.Linq;

public partial class admin_UpgradePin : System.Web.UI.Page, ICallbackEventHandler
{
    string strajax;
    WebClient client = new WebClient();
    utility obj = new utility();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;    
    string date;
   
    protected void Page_Load(object sender, EventArgs e)
    {

     
  
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminlogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!IsPostBack)
        {   
       

            getPins(); 
            BindUserID();   
            bindProduct();
             if (Request.QueryString.Count > 0)
            {
                string R1 = obj.base64Decode(Request.QueryString["r"].ToString());
                string R2 = obj.base64Decode(Request.QueryString["s"].ToString());
                string R3 = obj.base64Decode(Request.QueryString["n"].ToString());
                string R4 = obj.base64Decode(Request.QueryString["p"].ToString());
               



                txtid.Text = obj.base64Decode(Request.QueryString["s"].ToString());
                txtid.Enabled = false;
                try
                {
                    ddlPaidStatus.Items.FindByValue(obj.base64Decode(Request.QueryString["PT"].ToString())).Selected = true;
                    ddlProduct.Items.FindByValue(obj.base64Decode(Request.QueryString["p"].ToString())).Selected = true;
                    DataRow[] dr = ((DataTable)ViewState["dt"]).Select("srno='" + ddlProduct.SelectedValue.ToString() + "'");
                    if (dr.Count() > 0)
                        txtAmount.Text = dr[0]["amount"].ToString();
                    else
                        txtAmount.Text = "0";
                    ddlProduct.Enabled = false;
                }
                catch { }
                txtNOP.Text = obj.base64Decode(Request.QueryString["n"].ToString());
                txtNOP.Enabled = false;
            }
            else
            {
                txtid.Enabled = true;
                ddlProduct.Enabled = true;
                txtNOP.Enabled = true;
            }
        }
        date = DateTime.Now.ToString();
        //--Ajax Start
        lblUser.Text = "";
        string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
        StringBuilder newFunction = new StringBuilder();
        newFunction.Append("function ServerSendValue(arg,ctx)");
        newFunction.Append("{");
        newFunction.Append(js);
        newFunction.Append(";}");
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
        //--End here
    }
    private void BindUserID()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            DataTable tbl = new DataTable();
            da = new SqlDataAdapter("select appmstregno from appmst", con);
            da.Fill(tbl);
            divUserID.InnerText = string.Empty;
            foreach (DataRow row in tbl.Rows)
            {
                divUserID.InnerText += row["appmstregno"].ToString().Trim() + ",";
            }

        }
        catch
        {
        }
        finally
        {
        }
    }
    public void getPins()
    {
        cmd = new SqlCommand("FindPinsrNo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@pinsrno", SqlDbType.Int).Direction = ParameterDirection.Output;
        con.Open();
        cmd.ExecuteNonQuery();
        pinno.Text = cmd.Parameters["@pinsrno"].Value.ToString();
        txtid.Text = "";
        if (ddlPinType.SelectedValue.ToString() == "2")
        {         
            txtAmount.Text = "0";
        }
        //else
        //{
        //    txtAmount.Text = "500";           
        //}

        con.Close();
    }
    public void UpgradePin()
    {
        try
        {
            string topins = Convert.ToString((Convert.ToInt32(pinno.Text) + Convert.ToInt32(txtNOP.Text)) - 1);
            cmd = new SqlCommand("AllotPin", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Amount", txtAmount.Text.Trim());
            cmd.Parameters.AddWithValue("@ProductId", ddlProduct.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@Remark", txtRemark.Text.Trim());
            cmd.Parameters.AddWithValue("@pintype", ddlPinType.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@paidstatus", ddlPaidStatus.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@allotedto", txtid.Text.Trim());
            cmd.Parameters.AddWithValue("@mode", ddlMode.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@TransactionNumber", txtTransactionNumber.Text.Trim());
            cmd.Parameters.AddWithValue("@bank", ddlBankName.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@branch", txtBranch.Text.Trim());
            cmd.Parameters.AddWithValue("@depositedamount", txtDepositedAmount.Text.Trim());
            cmd.Parameters.AddWithValue("@fromPinSrNo", pinno.Text.Trim());
            cmd.Parameters.AddWithValue("@toPinSrNo", topins);
            cmd.Parameters.AddWithValue("@noofpin",txtNOP.Text);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            //utility.MessageBox(this,"Pin Alloted Successfully!");
            if (Request.QueryString.Count > 0)
            {
                try
                {
                    con = new SqlConnection(method.str);
                    cmd = new SqlCommand("update PinRequestMst set status=1 where srno=@srno", con);
                    con.Open();
                    cmd.Parameters.AddWithValue("@srno", Convert.ToInt32(obj.base64Decode(Request.QueryString["r"])));
                    int r = cmd.ExecuteNonQuery();
                    if (r > 0)
                    {
                        utility.MessageBox(this, "Request Rejected");
                    }
                    con.Close();
                }
                catch { }
            }
            txtid.Text=txtNOP.Text = txtTransactionNumber.Text = txtBranch.Text = txtDepositedAmount.Text = txtRemark.Text = string.Empty;
            ddlMode.SelectedIndex = ddlBankName.SelectedIndex = 0;

            ddlProduct.SelectedIndex = 0;
            txtAmount.Text = "";


            getPins();
        }
        catch
        {
            utility.MessageBox(this,"Unsuccessfull please try later!");
        }
        finally
        {
        }
    }
    //private void chkuseid()
    //{
    //    SqlConnection con = new SqlConnection(method.str);
    //    SqlCommand com = new SqlCommand("SELECT * from AppMst where  AppMstRegNo=@AppMstRegNo", con);
    //    com.Parameters.AddWithValue("@AppMstRegNo",txtid.Text.Trim());
    //    con.Open();
    //    SqlDataReader dr;
    //    dr = com.ExecuteReader();
    //    if (dr.HasRows)
    //    {
    //       UpgradePin();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this,"ID Does Not Exsist!");
    //    }
    //}
    #region (ICallbackEventHandlar Methods..)
    public string GetCallbackResult()
    {
        return strajax;
    }
    public void RaiseCallbackEvent(string eventArguments)
    {
        con.Close();
        if (eventArguments != "")
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr;
            cmd.CommandText = "select appmsttitle+space(1)+appmstfname as name from appmst where appmstregno='" + eventArguments.Trim() + "'";
            cmd.Connection = con;
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                strajax = Convert.ToString(dr["name"]);
                Session["sname"] = Convert.ToString(dr["name"]);
            }
            else
            {
                strajax = "User Does Not Exist!";
            }

            dr.Close();
            con.Close();
        }
        else
        {
            strajax = "Required field cannot be blank !";
        }
    }
    #endregion
    
    protected void Button1_Click(object sender, EventArgs e)
    {
       

        if (txtid.Text=="")
        {
            utility.MessageBox(this, "Enter User ID");
            return;
        }

        if (ddlProduct.SelectedIndex <= 0)
        {
            utility.MessageBox(this,"Select product name.");
            return;
        }

           if (ddlMode.SelectedValue.ToString() == "0")
            {
                utility.MessageBox(this,"Please Select transaction Mode!");
            }
            else if ((ddlMode.SelectedValue.ToString() == "Cheque") || (ddlMode.SelectedValue.ToString() == "DD") || (ddlMode.SelectedValue.ToString() == "Transfer"))
            {
                if (string.IsNullOrEmpty(txtTransactionNumber.Text.Trim()))
                {
                    utility.MessageBox(this,"Please Enter Cheque Number / DD No / Transfer Id!");
                }
                else if (ddlBankName.SelectedValue.ToString() == "0")
                {
                    utility.MessageBox(this,"Please Select Bank!");
                }
                else if (string.IsNullOrEmpty(txtBranch.Text.Trim()))
                {
                    utility.MessageBox(this,"Please Enter Branch!");
                }
                else if (string.IsNullOrEmpty(txtDepositedAmount.Text.Trim()))
                {
                    utility.MessageBox(this,"Please Enter Deposited Amount!");
                }
                else
                {
                    if (Convert.ToInt32(txtDepositedAmount.Text) < (Convert.ToInt32(txtAmount.Text) * Convert.ToInt32(txtNOP.Text)))
                    {
                        utility.MessageBox(this,"Insufficient Deposited Amount !");
                    }
                    else
                    {
                        UpgradePin();
                    }
                }
            }
           else if (ddlMode.SelectedValue.ToString() == "Cash")
            {

                UpgradePin();
            }

           ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Pins Alloted Successfully.');window.location='UpgradePin.aspx';", true);
        //   utility.MessageBox(this, "pin alloted");
           //Response.Write("<script>alert('Pin Alloted Successfully')</script>");
       //    Response.Write("<script>alert('Pin Alloted Successfully');window.location='UpgradePin.aspx'</script>");
           //Response.Redirect("~/admin/UpgradePin.aspx");



    }





    protected void ddlMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlMode.SelectedItem.Text == "Cash")
        {
            txtTransactionNumber.Text = string.Empty;
            txtTransactionNumber.Enabled = false;
            ddlBankName.SelectedIndex = 0;
            ddlBankName.Enabled = false;
            txtBranch.Text = string.Empty;
            txtBranch.Enabled = false;
            txtDepositedAmount.Text = string.Empty;
            txtDepositedAmount.Enabled = false;
        }
        else if (ddlMode.SelectedItem.Text == "Cheque")
        {
            txtTransactionNumber.Text = string.Empty;
            txtTransactionNumber.Enabled = true;
            ddlBankName.SelectedIndex = 0;
            ddlBankName.Enabled = true;
            txtBranch.Text = string.Empty;
            txtBranch.Enabled = true;
            txtDepositedAmount.Text = string.Empty;
            txtDepositedAmount.Enabled = true;
        }
        else if (ddlMode.SelectedItem.Text == "DD")
        {
            txtTransactionNumber.Text = string.Empty;
            txtTransactionNumber.Enabled = true;
            ddlBankName.SelectedIndex = 0;
            ddlBankName.Enabled = true;
            txtBranch.Text = string.Empty;
            txtBranch.Enabled = true;
            txtDepositedAmount.Text = string.Empty;
            txtDepositedAmount.Enabled = true;
        }
        else if (ddlMode.SelectedItem.Text == "Transfer")
        {

            ddlBankName.SelectedIndex = 0;
            ddlBankName.Enabled = true;
            txtBranch.Text = string.Empty;
            txtBranch.Enabled = true;
            txtDepositedAmount.Text = string.Empty;
            txtDepositedAmount.Enabled = true;
        }
        else
        {
        }
    }

   
    private void bindProduct()
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("getProductAmount", con);
            com.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            con.Open();
            SqlDataReader dr = com.ExecuteReader();
            dt.Load(dr);
            con.Close();
            ViewState["dt"] = dt;
            ddlProduct.DataSource = dt;
            ddlProduct.DataTextField = "productname";
            ddlProduct.DataValueField = "srno";
            
            ddlProduct.DataBind();
            ddlProduct.Items.Insert(0, new ListItem("-Select-", "0"));
		    txtAmount.Text ="0";// dt.Rows[0]["amount"].ToString();
        }
        catch
        {
        }
    }
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
       DataRow[] dr= ((DataTable)ViewState["dt"]).Select("srno='"+ddlProduct.SelectedValue.ToString()+"'");
if(dr.Count()>0)
       txtAmount.Text = dr[0]["amount"].ToString();
else 
txtAmount.Text="0";
        
    }
}
