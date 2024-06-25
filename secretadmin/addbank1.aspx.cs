using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.Services;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Text.RegularExpressions;
public partial class secretadmin_addbank1 : System.Web.UI.Page
{
    string strajax = "";
    SqlConnection con;
    SqlCommand com;
    utility objUtil = null;
    static string joinfor = "0";
   protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
            {
                utility.CheckSuperAdminLogin();
            }
            else if (Convert.ToString(Session["admintype"]) == "a")
            {
                utility.CheckAdminLogin();
            }
            else
            {
                Response.Redirect("adminLog.aspx");
            }
            if (!Page.IsPostBack)
            {
                ViewState["CurrentAlphabet"] = "ALL";
                this.GenerateAlphabets();
                this.searchbuttentext();

            }
        }
        catch
        {

        }
         
    }
     

    [System.Web.Services.WebMethod] 
   public static List<string> GetCity(string prefixText)
   {


       DataTable dt = new DataTable();
       SqlConnection con = new SqlConnection(method.str);

       con.Open();
       SqlCommand cmd = new SqlCommand("select * from bankmst where bankname like @City+'%'", con);
       cmd.Parameters.AddWithValue("@City", prefixText);
       SqlDataAdapter adp = new SqlDataAdapter(cmd);
       adp.Fill(dt);
       List<string> CityNames = new List<string>();
       for (int i = 0; i < dt.Rows.Count; i++)
       {
           CityNames.Add(dt.Rows[i][1].ToString());
       }
       return CityNames;


   }
     public void searchbuttentext()
        {
            try
            {
                SqlConnection con = new SqlConnection(method.str);

                SqlCommand cmd = new SqlCommand("SELECT * FROM bankmst WHERE bankname LIKE @bankname + '%' OR @bankname = 'ALL' order by bankname asc", con);


                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@bankname", ViewState["CurrentAlphabet"]);
                    sda.SelectCommand = cmd;
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }

                btnsubmit.InnerText = "Save";


            }
            catch { }
        }

    protected void Alphabet_Click(object sender, EventArgs e)
    {
        LinkButton lnkAlphabet = (LinkButton)sender;
        ViewState["CurrentAlphabet"] = lnkAlphabet.Text;
        this.GenerateAlphabets();
        GridView1.PageIndex = 0;
        this.searchbuttentext();
    }
   private void GenerateAlphabets()
   {
       List<ListItem> alphabets = new List<ListItem>();
       ListItem alphabet = new ListItem();

       alphabet.Value = "ALL";

       alphabet.Selected = alphabet.Value.Equals(ViewState

["CurrentAlphabet"]);
       alphabets.Add(alphabet);
       for (int i = 65; i <= 90; i++)
       {
           alphabet = new ListItem();
           alphabet.Value = Char.ConvertFromUtf32(i);
           alphabet.Selected = alphabet.Value.Equals(ViewState

["CurrentAlphabet"]);
           alphabets.Add(alphabet);
       }
       rptAlphabets.DataSource = alphabets;
       rptAlphabets.DataBind();
   }


   protected void lnkupdate_Click(object sender, EventArgs e)
   {
       GridViewRow grid = (GridViewRow)((LinkButton)sender).NamingContainer;
       int bankid = Convert.ToInt32(GridView1.DataKeys

[grid.RowIndex].Value.ToString());

       string city = grid.Cells[1].Text;
       txtBankName.Text = city.Replace("&amp;", "&");
       btnsubmit.InnerText = "Update";
       ViewState["bankid"] = bankid;
       mess.Text = "";
   }

   protected void GridView1_PageIndexChanging(object sender,GridViewPageEventArgs e)
   {

       GridView1.PageIndex = e.NewPageIndex;
       this.searchbuttentext();





   }
    public void bindbanckmst()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);

            SqlCommand cmd = new SqlCommand("bindbankmst", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        catch { }




    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (btnsubmit.InnerText == "Save")
            { 
            if (txtBankName.Text == "")
            {
                mess.Text = "Please Enter Bank Name!";
            }

            if (!Regex.Match(txtBankName.Text, "[A-Z a-z- ]{3,100}").Success)
            {
                // last name was incorrect
                mess.Text = "Invalid Bank Name !";

                return;
            }

            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("Chechbankname", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@bankName", txtBankName.Text.Trim().ToUpper());
            cmd.Parameters.Add("@Result", SqlDbType.VarChar, 120).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string result = cmd.Parameters["@Result"].Value.ToString();
            if (result != "")
            {
                mess.Text = result;
                txtBankName.Focus();

            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "alert('Data Save Sucessfully');", true);

            }
            
            
            }
            if (btnsubmit.InnerText == "Update")
            {
                using (SqlConnection con1 = new SqlConnection(method.str))
                {

                   con1.Open();
                    SqlCommand cmd1 = new SqlCommand("UpdateBankName", con1);
                    cmd1.CommandType = CommandType.StoredProcedure;

                    cmd1.Parameters.AddWithValue("@bankid", ViewState["bankid"]);
                    cmd1.Parameters.AddWithValue("@BankName", txtBankName.Text.Trim().ToUpper());
                    cmd1.ExecuteNonQuery();
                    con1.Close();
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "alert('Data Update Sucessfully');", true);
                }
                btnsubmit.InnerText = "Save";
            }
            txtBankName.Text = "";
            searchbuttentext();
        }
        catch { }
    }


    protected void lnkdelete_Click(object sender, EventArgs e)
    {
        try
        {

            GridViewRow grid = (GridViewRow)((LinkButton)sender).NamingContainer;
            int bankid = Convert.ToInt32(GridView1.DataKeys[grid.RowIndex].Value.ToString());
            using (SqlConnection con = new SqlConnection(method.str))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("deletebankmst", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@bankid", bankid);
                cmd.ExecuteNonQuery();

                con.Close();
            }

            searchbuttentext();
            
        }
        catch 
        {
          
        }

    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //getting username from particular row
            string BankName = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BankName"));
            LinkButton lnkbtnresult = (LinkButton)e.Row.FindControl("lnkdelete");
            lnkbtnresult.Attributes.Add("onclick", "javascript:return ConfirmationBox('" + BankName + "')");

        }


    }
}