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
using System.IO;

public partial class admin_DocApprovelList : System.Web.UI.Page
{
    DataUtility objDUT = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrd();
        }

    }
    public void BindGrd()
    {
        DataTable dt = objDUT.GetDataTable("select distinct  am.appmstRegNo,Am.panno,(select imageName from scandocs where docType=1 and userid=am.appmstRegno)as IDP,(select imageName from scandocs where docType=2 and userid=am.appmstRegno)as PAN  from scandocs sd,appmst am where am.bstatus=1 and sd.userid=am.appmstRegno ");
        if (dt.Rows.Count > 0)
        {
            StartGrid.DataSource = dt;
            StartGrid.DataBind();
        }
        else
        {
            lbl_msg.Text = "No Request...";
        }
    }
    protected void StartGrid_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Approved")
        {
            GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
            TextBox myTextBox = row.FindControl("txt_PanNo") as TextBox;
            if ((myTextBox.ToString()) != "")
            {
                if (isValidPan(myTextBox.Text))
                {
                    int Result = objDUT.ExecuteSql("update appmst set bstatus=2, panno='" + myTextBox.Text.Trim() + "' where appmstRegno='" + e.CommandArgument.ToString() + "'");
                    if (Result == 1)
                    {
                        BindGrd();
                        lbl_msg.Text = "Successfully Approved..!!";
                    }
                }
                else
                {
                    lbl_msg.Text = "Please enter valid pan card no..!!";
                }
            }
            else
            {
                lbl_msg.Text = "Please enter pan card no..!!";
                return;
            }
        }
        if (e.CommandName == "Reject")
        {
            int Result = objDUT.ExecuteSql("update appmst set bstatus=0 where appmstRegno='" + e.CommandArgument.ToString() + "'");
            if (Result == 1)
            {
                BindGrd();
                lbl_msg.Text = "Rejected..!!";
            }
        }
    }
    protected bool isValidPan(string pan)
    {

        if (pan.Length < 10 || pan.Length > 10)
        {
            
            return false;
        }
        else
        {
            string str5 = pan.Substring(0, 5);
            string num = pan.Substring(5, 4);
            string str10 = pan.Substring(9, 1);
            if (IsNumeric(str5) || !IsNumeric(num) || IsNumeric(str10))
                return false;
            else
                return true;
        }
    }
    protected bool IsNumeric(string sText)
    {
        string ValidChars = "0123456789";
        bool IsNumber = true;
        string Char = "";


        for (int i = 0; i < sText.Length && IsNumber == true; i++)
        {
            Char = sText.Substring(i, 1);
            if (ValidChars.IndexOf(Char) == -1)
            {
                IsNumber = false;
            }
        }

        return IsNumber;

    }
}
