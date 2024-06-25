using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.Linq;
using System.Collections;

public partial class secretadmin_PackingSlip : System.Web.UI.Page
{
    static string Invoiceno = "", BilltypeValue = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
            Response.Redirect("Logout.aspx");

        if (!IsPostBack)
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
            try
            {
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["id"] != "")
                    {
                        utility obj = new utility();
                        Invoiceno = obj.base64Decode(Request.QueryString["id"].ToString());
                        BindDetail(Invoiceno);
                    }
                }
            }
            catch (Exception er) { }
        }
    }



    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();

                XElement element = null;
                element = new XElement("Bill");
                foreach (GridViewRow row in GridView1.Rows)
                {
                    TextBox txt_BoxNo = (TextBox)row.FindControl("txt_BoxNo");
                    Label lbl_productname = (Label)row.FindControl("lbl_productname");
                    HiddenField hdn_Pid = (HiddenField)row.FindControl("hdn_Pid");
                    HiddenField hdn_Qty = (HiddenField)row.FindControl("hdn_Qty");

                    XElement prdXml = new XElement("P",
                            new XElement("Box", txt_BoxNo.Text),
                            new XElement("pname", lbl_productname.Text),
                            new XElement("cd", hdn_Pid.Value),
                            new XElement("Qnt", hdn_Qty.Value)
                      );
                    element.Add(prdXml);
                }


                var xmlObject = new XmlDocument();
                xmlObject.LoadXml(element.ToString());
                if (element != null)
                {
                    SqlConnection con = new SqlConnection(method.str);
                    SqlCommand com = new SqlCommand("AddPackingSlip", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@Invoiceno", Invoiceno);
                    com.Parameters.Add("@Detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                    com.Parameters.AddWithValue("@Inv_Type", "StockTranReport");
                    com.Parameters.Add("@flag", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    string status = com.Parameters["@flag"].Value.ToString();
                    if (status == "1")
                    {
                        utility.MessageBox(this, "Your details save successfully.");
                        return;
                    }
                }
            }
            else
            {
                utility.MessageBox(this, "Don't refresh this page.!!");
                return;
            }
        }
        catch (Exception er)
        {
            utility.MessageBox(this, er.Message);
            return;
        }

    }


    private void BindDetail(String Invoiceno)
    {
        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@Invoiceno", Invoiceno),
            new SqlParameter("@Inv_Type", "StockTranReport")
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetPackingSlip");
        if (dt.Rows.Count > 0)
        {
            GridView1.Columns[0].FooterText = "Total: ";
            GridView1.Columns[3].FooterText = dt.Compute("sum(quantity)", "true").ToString();
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        SqlParameter[] param1 = new SqlParameter[]
        {  new SqlParameter("@Invoiceno", Invoiceno.Trim()) };
        DataTable dtNew = objDu.GetDataTable(param1, "Select srno from StockTranReport where InvoiceNo=@Invoiceno");
        if (dtNew.Rows.Count > 0)
        {
            userdetail(dtNew.Rows[0]["srno"].ToString());
            BindFranchiseDetail(dtNew.Rows[0]["srno"].ToString());
        }
    }

    private void userdetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@invoice", srno) };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "stockTransferBill");
        if (dt.Rows.Count > 0)
        {
            //lbl_GrossTotal.Text = dt.Rows[0]["Amount"].ToString();
            //lbl_Discount.Text = dt.Rows[0]["Discount"].ToString();
            //lbl_tottax.Text = dt.Rows[0]["TaxRs"].ToString();
            //lbl_NetTotal.Text = dt.Rows[0]["NetAmt"].ToString();
            lbl_Userid.Text = dt.Rows[0]["Franchiseid"].ToString();
            lbl_UserMobileNo.Text = dt.Rows[0]["mobile"].ToString();
            lbl_UserGSTIN.Text = dt.Rows[0]["GST"].ToString();
            lbl_UserINVNo.Text = dt.Rows[0]["InvoiceNo"].ToString();
            lbl_UserINVDate.Text = lbl_User_Date_PO_NO.Text = dt.Rows[0]["Doe"].ToString();
            lbl_UserName.Text = dt.Rows[0]["FName"].ToString();
            lbl_UserAdd.Text = dt.Rows[0]["Address"].ToString();
            lbl_UserSate.Text = dt.Rows[0]["State"].ToString();
            lbl_UserEmail.Text = dt.Rows[0]["email"].ToString();
        }
    }

    private void BindFranchiseDetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@invoiceno", srno)
        };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "proc_frachisedetail");
        if (dt.Rows.Count > 0)
        {
            lbl_Regno.Text = dt.Rows[0]["SalesRepID"].ToString();
            lbl_DisplayName.Text = dt.Rows[0]["FName"].ToString();
            lbl_Phone.Text = dt.Rows[0]["Mobile"].ToString();
            lbl_F_Email.Text = dt.Rows[0]["email"].ToString();
            lbl_GSTIN.Text = dt.Rows[0]["GST"].ToString();
            lbl_place_supply.Text = dt.Rows[0]["PlaceOfSupply"].ToString();
            lbl_B_Address.Text = dt.Rows[0]["Address"].ToString();
            lbl_B_state.Text = dt.Rows[0]["State"].ToString();
            lbl_ShipingAdd.Text = dt.Rows[0]["ToAddress"].ToString();
            lbl_UserPAN.Text = dt.Rows[0]["PanNo"].ToString();
            lbl_UserCIN.Text = dt.Rows[0]["CinNo"].ToString();
        }
    }
}