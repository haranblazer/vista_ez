using System;
using System.Data;
using System.Web;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls; 

public partial class secretadmin_AddEditQuantity : System.Web.UI.Page
{
    SqlDataAdapter da = null;
    SqlConnection con = null;
    DataTable dt = null;
    SqlCommand cmd = null;
    utility u = new utility();
    string months, msg;
    int k;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["franchiseid"] == null)
                Response.Redirect("Logout.aspx");
            else
            {
                BindMfgYear();
                BindExpiryYear();
                bindproduct();
                BindColor();
                BindSize();
            }
        }
    }

    private void BindColor()
    {
        DataUtility obj = new DataUtility();
        DataTable dt = obj.GetDataTable("Select CLRId, ColorName, ColorCode from tbl_Color Where IsActive=1");
        ddl_color.DataSource = dt;
        ddl_color.DataTextField = "ColorName";
        ddl_color.DataValueField = "CLRId";
        ddl_color.DataBind();
        ddl_color.Items.Insert(0, new ListItem("No Color", "0"));
        ddl_color.Items[0].Attributes.Add("style", "background-color:white;");
        int row = 1;
        foreach (DataRow dr in dt.Rows)
        {
            ddl_color.Items[row].Attributes.Add("style", "background-color:" + dr["ColorCode"].ToString());
            row = row + 1;
        }
    }

    private void BindSize()
    {
        DataUtility obj = new DataUtility();
        ddl_Size.DataSource = obj.GetDataTable("Select SZId, Size from tbl_size where IsActive=1");
        ddl_Size.DataTextField = "Size";
        ddl_Size.DataValueField = "SZId";
        ddl_Size.DataBind();
        ddl_Size.Items.Insert(0, new ListItem("No Size", "0"));
    }



    void BindMfgYear()
    {
        ddlmfgyear.Items.Clear();
        for (int i = 4; i >= 0; i--)
        {
            string Year = DateTime.Now.AddYears(-i).ToString("yyyy");
            ddlmfgyear.Items.Insert(0, new ListItem(Year, Year));
        }
        ddlmfgyear.Items.Insert(0, new ListItem("Select", "0"));
    }

    void BindExpiryYear()
    {
        ddl_ExpiryYear.Items.Clear();
        for (int i = 7; i >= 0; i--)
        {
            string Year = DateTime.Now.AddYears(i).ToString("yyyy");
            ddl_ExpiryYear.Items.Insert(0, new ListItem(Year, Year));
        }
        ddl_ExpiryYear.Items.Insert(0, new ListItem("Select", "0"));
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            if (HttpContext.Current.Session["franchiseid"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            lblmsg.Text = "";

            double GST = Convert.ToDouble(ddlGST.SelectedValue);
            double MRP = Convert.ToDouble(txt_MRP.Text.Trim() == "" ? "0" : txt_MRP.Text.Trim());
            double Disc_Perc_Val = Convert.ToDouble(txt_Disc_Perc_Val.Text.Trim() == "" ? "0" : txt_Disc_Perc_Val.Text.Trim());

            string FinalVal = (MRP - (MRP * Disc_Perc_Val / 100)).ToString();
            txtDPWithTax.Text = FinalVal;
            txt_DpStockWithTax.Text = FinalVal;
            txt_PORateWithGST.Text = FinalVal;




            double DPWithTax = Convert.ToDouble(txtDPWithTax.Text.Trim() == "" ? "0" : txtDPWithTax.Text.Trim());
            if (DPWithTax > 0 && GST > 0)
                txtDP.Text = (DPWithTax * 100 / (GST + 100)).ToString();
            else
            {
                if (DPWithTax > 0)
                    txtDP.Text = DPWithTax.ToString();
                else
                    txtDP.Text = "0";
            }


            double DpStockWithTax = Convert.ToDouble(txt_DpStockWithTax.Text.Trim() == "" ? "0" : txt_DpStockWithTax.Text.Trim());
            if (DpStockWithTax > 0 && GST > 0)
                txt_DpStock.Text = (DpStockWithTax * 100 / (GST + 100)).ToString();
            else
            {
                if (DpStockWithTax > 0)
                    txt_DpStock.Text = DpStockWithTax.ToString();
                else
                    txt_DpStock.Text = "0";
            }


            double CompanyRateWithGST = Convert.ToDouble(txt_CompanyRateWithGST.Text.Trim() == "" ? "0" : txt_CompanyRateWithGST.Text.Trim());
            if (CompanyRateWithGST > 0 && GST > 0)
                txt_CompanyRate.Text = (CompanyRateWithGST * 100 / (GST + 100)).ToString();
            else
            {
                if (CompanyRateWithGST > 0)
                    txt_CompanyRate.Text = CompanyRateWithGST.ToString();
                else
                    txt_CompanyRate.Text = "0";
            }



            double PORateWithGST = Convert.ToDouble(txt_PORateWithGST.Text.Trim() == "" ? "0" : txt_PORateWithGST.Text.Trim());
            if (PORateWithGST > 0 && GST > 0)
                txt_PORate.Text = (PORateWithGST * 100 / (GST + 100)).ToString();
            else
            {
                if (PORateWithGST > 0)
                    txt_PORate.Text = PORateWithGST.ToString();
                else
                    txt_PORate.Text = "0";
            }


            double CustomerWithGST = Convert.ToDouble(txt_CustomerWithGST.Text.Trim() == "" ? "0" : txt_CustomerWithGST.Text.Trim());
            if (CustomerWithGST > 0 && GST > 0)
                txt_CustomerRate.Text = (CustomerWithGST * 100 / (GST + 100)).ToString();
            else
            {
                if (CustomerWithGST > 0)
                    txt_CustomerRate.Text = CustomerWithGST.ToString();
                else
                    txt_CustomerRate.Text = "0";
            }



            string ExpiryDate = "", MFGDate = "";
            if (ddlmfgyear.SelectedValue == "0")
                MFGDate = "Jan-" + DateTime.Now.ToString("yyyy");
            else
                MFGDate = ddlmfgmonth.SelectedValue + "-" + ddlmfgyear.SelectedValue;

            if (ddl_ExpiryYear.SelectedValue == "0")
                ExpiryDate = "Jan-" + DateTime.Now.AddYears(10).ToString("yyyy");
            else
                ExpiryDate = ddl_ExpiryMonth.SelectedValue + "-" + ddl_ExpiryYear.SelectedValue;

            string PV = txtPV.Text.Trim() == "" ? "0" : txtPV.Text.Trim();
            string BV = PV;



            con = new SqlConnection(method.str);
            cmd = new SqlCommand("UpdateProductQty", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "insert");
            cmd.Parameters.AddWithValue("@CLRId", ddl_color.SelectedValue);
            cmd.Parameters.AddWithValue("@SZId", ddl_Size.SelectedValue);


            cmd.Parameters.AddWithValue("@soldby", HttpContext.Current.Session["franchiseid"].ToString());
            cmd.Parameters.AddWithValue("@batchid", ddl_BatchNo.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@pid", Convert.ToInt32(ddlproductname.SelectedValue.ToString()));
            cmd.Parameters.AddWithValue("@batchdate", MFGDate);
            cmd.Parameters.AddWithValue("@batchno", txtbatchno.Text.Trim().ToUpper());
            cmd.Parameters.AddWithValue("@ExpiryDate", ExpiryDate);


            cmd.Parameters.AddWithValue("@MRP", MRP);
            cmd.Parameters.AddWithValue("@Disc_Perc_Val", Disc_Perc_Val);

            cmd.Parameters.AddWithValue("@BV_ON", ddl_BV_ON.SelectedValue);
            cmd.Parameters.AddWithValue("@PERC_FLAT", ddl_PERC_FLAT.SelectedValue);
            cmd.Parameters.AddWithValue("@BV_Value_Base", txt_BV_Value_Base.Text.Trim() == "" ? "0" : txt_BV_Value_Base.Text.Trim());

            cmd.Parameters.AddWithValue("@GST", GST);
            cmd.Parameters.AddWithValue("@DPWithTax", txtDPWithTax.Text.Trim() == "" ? "0" : txtDPWithTax.Text.Trim());
            cmd.Parameters.AddWithValue("@DP", txtDP.Text.Trim() == "" ? "0" : txtDP.Text.Trim());
            cmd.Parameters.AddWithValue("@PV", PV);
            cmd.Parameters.AddWithValue("@BV", BV);

            cmd.Parameters.AddWithValue("@FPV", txt_FPV.Text.Trim() == "" ? "0" : txt_FPV.Text.Trim());
            cmd.Parameters.AddWithValue("@APV", txt_APV.Text.Trim() == "" ? "0" : txt_APV.Text.Trim());

            cmd.Parameters.AddWithValue("@DpStockWithTax", txt_DpStockWithTax.Text.Trim() == "" ? "0" : txt_DpStockWithTax.Text.Trim());
            cmd.Parameters.AddWithValue("@DpStock", txt_DpStock.Text.Trim() == "" ? "0" : txt_DpStock.Text.Trim());

            cmd.Parameters.AddWithValue("@CompWithTax", txt_CompanyRateWithGST.Text.Trim() == "" ? "0" : txt_CompanyRateWithGST.Text.Trim());
            cmd.Parameters.AddWithValue("@CompRate", txt_CompanyRate.Text.Trim() == "" ? "0" : txt_CompanyRate.Text.Trim());


            cmd.Parameters.AddWithValue("@POWithTax", txt_PORateWithGST.Text.Trim() == "" ? "0" : txt_PORateWithGST.Text.Trim());
            cmd.Parameters.AddWithValue("@PORate", txt_PORate.Text.Trim() == "" ? "0" : txt_PORate.Text.Trim());

            cmd.Parameters.AddWithValue("@CustomerWithTax", txt_CustomerWithGST.Text.Trim() == "" ? "0" : txt_CustomerWithGST.Text.Trim());
            cmd.Parameters.AddWithValue("@CustomerRate", txt_CustomerRate.Text.Trim() == "" ? "0" : txt_CustomerRate.Text.Trim());

            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            msg = cmd.Parameters["@flag"].Value.ToString();
            if (msg == "1")
            {
                utility.MessageBox(this, "Your details save successfully.!!");
                Reset();

                //Response.Redirect("BatchList.aspx");
            }
            else
            {
                lblmsg.Text = msg;
            }
            con.Close();
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
            utility.MessageBox(this, ex.ToString());
        }

    }

    private void Reset()
    {
        ddlproductname.SelectedValue = "0";
        ddl_BatchNo.SelectedValue = "0";
        ddlmfgmonth.SelectedValue = "0";
        ddlmfgyear.SelectedValue = "0";
        ddl_ExpiryMonth.SelectedValue = "0";
        ddl_ExpiryYear.SelectedValue = "0";
        ddl_BatchNo.SelectedValue = "0";
        ddlGST.SelectedValue = "0";

        ddl_color.SelectedValue = "0";
        ddl_color.SelectedValue = "0";

        txtbatchno.Text = "";
        txt_MRP.Text = "";
        txt_Disc_Perc_Val.Text = "";
        
        txtDPWithTax.Text = "";
        txtDP.Text = "";
        txtPV.Text = "";
        txtBV.Text = "";
        txt_FPV.Text = "";
        txt_APV.Text = "";
        txt_CompanyRateWithGST.Text = "";
        txt_CompanyRate.Text = "";
        txt_DpStockWithTax.Text = "";
        txt_DpStock.Text = "";
        txt_PORateWithGST.Text = "";
        txt_PORate.Text = "";
        txt_CustomerWithGST.Text = "";
        txt_CustomerRate.Text = "";
    }

    public void bindproduct()
    {
        con = new SqlConnection(method.str);
        cmd = new SqlCommand("UpdateProductQty", con);
        cmd.Parameters.AddWithValue("@action", "bindproduct");
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        ddlproductname.Items.Clear();
        ddlproductname.DataTextField = "productname";
        ddlproductname.DataValueField = "productid";
        ddlproductname.DataSource = cmd.ExecuteReader();
        ddlproductname.DataBind();

        ddlproductname.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Product", "0"));
        con.Close();

        ddl_BatchNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Batch", "0"));
    }

    public void BindBatch(string Pid)
    {
        DataUtility objDu = new DataUtility();
        SqlParameter outparam = new SqlParameter("@flag", SqlDbType.VarChar, 100);
        outparam.Direction = ParameterDirection.Output;

        SqlParameter[] param = new SqlParameter[]
        {  new SqlParameter("@action", "GETBATCH"), new SqlParameter("@pid", Pid), outparam };

        DataTable dt = objDu.GetDataTableSP(param, "UpdateProductQty");
        if (dt.Rows.Count > 0 && Pid != "0")
        {
            ddl_BatchNo.DataTextField = "BatchNo";
            ddl_BatchNo.DataValueField = "Batchid";
            ddl_BatchNo.DataSource = dt;
            ddl_BatchNo.DataBind();

            ddl_BatchNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("New Batch", "0"));

            string Batchid = dt.Compute("Max(Batchid)", string.Empty).ToString();
            BindBatchDetails(Batchid);
            ddl_BatchNo.SelectedValue = Batchid;

            BindVeriant(Batchid);
        }
        else
        {
            ddl_BatchNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("New Batch", "0"));
            BindBatchDetails("0");
        }


    }

    protected void ddlproductname_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddl_BatchNo.Items.Clear();
        string Pid = ddlproductname.SelectedValue.ToString();
        BindBatch(Pid);
    }

    protected void ddl_BatchNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Batchid = ddl_BatchNo.SelectedValue.ToString();
        if (Batchid != "0")
        {
            BindBatchDetails(Batchid);
        }
        else
        {
            txtbatchno.Text = "";
        }
        BindVeriant(Batchid);
    }


    private void BindVeriant(string Batchid)
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@pid", ddlproductname.SelectedValue) };
        string IsVariant = objDu.GetScaler(param1, "Select IsVariant=isnull(IsVariant,0) from ShopProductMst Where ProductId=@pid").ToString();
        if (IsVariant.ToLower() == "true")
        {
            div_variant.InnerHtml = "Variant <i class='fa fa-check' aria-hidden='true' style='color:green; font-size:20px'></i>";
            if (Batchid == "0")
                ddl_Size.Enabled = ddl_color.Enabled = true;
            else
                ddl_Size.Enabled = ddl_color.Enabled = false;
        }
        else
        {
            ddl_Size.Enabled = ddl_color.Enabled = false;
            div_variant.InnerHtml = "Variant <i class='fa fa-times' aria-hidden='true' style='color:red; font-size:20px'></i>";
        }
    }

    private void BindBatchDetails(string Batchid)
    {

        if (int.Parse(Batchid) > 0)
        {
            DataUtility objDu = new DataUtility();
            SqlParameter outparam = new SqlParameter("@flag", SqlDbType.VarChar, 100);
            outparam.Direction = ParameterDirection.Output;
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@action ", "GETBATCHDETAILS"), new SqlParameter("@pid", Batchid), outparam };

            DataTable dt = objDu.GetDataTableSP(param, "UpdateProductQty");
            if (dt.Rows.Count > 0)
            {
                ddl_color.SelectedValue = dt.Rows[0]["CLRId"].ToString();
                ddl_Size.SelectedValue = dt.Rows[0]["SZId"].ToString();
                div_colorCode.Attributes.Add("style", "height:20px; width:20px; background-color:" + dt.Rows[0]["ColorCode"].ToString() + "; display:inline-block; border-radius:50%;");
                ddl_Size.Enabled = ddl_color.Enabled = false;


                txtbatchno.Text = dt.Rows[0]["BatchNo"].ToString();
                txt_MRP.Text = dt.Rows[0]["MRP"].ToString();
                txt_Disc_Perc_Val.Text = dt.Rows[0]["Disc_Perc_Val"].ToString();
                ddl_BV_ON.Text = dt.Rows[0]["BV_ON"].ToString();
                ddl_PERC_FLAT.Text = dt.Rows[0]["PERC_FLAT"].ToString();
                txt_BV_Value_Base.Text = dt.Rows[0]["BV_Value_Base"].ToString();

                double Tax = Convert.ToDouble(dt.Rows[0]["Tax"].ToString());

                ddlGST.SelectedValue = Tax.ToString();
                txtDPWithTax.Text = dt.Rows[0]["DPWithTax"].ToString();
                txtDP.Text = dt.Rows[0]["DPAmt"].ToString();
                txtPV.Text = dt.Rows[0]["pbvamt"].ToString();
                txtBV.Text = dt.Rows[0]["BVAmt"].ToString();
                txt_FPV.Text = dt.Rows[0]["FPV"].ToString();
                txt_APV.Text = dt.Rows[0]["APV"].ToString();

                txt_DpStockWithTax.Text = dt.Rows[0]["DpStockWithTax"].ToString();
                txt_DpStock.Text = dt.Rows[0]["DpStock"].ToString();


                txt_CompanyRateWithGST.Text = dt.Rows[0]["CompWithTax"].ToString();
                txt_CompanyRate.Text = dt.Rows[0]["CompRate"].ToString();


                txt_PORateWithGST.Text = dt.Rows[0]["POWithTax"].ToString();
                txt_PORate.Text = dt.Rows[0]["PORate"].ToString();

                // txt_CustomerWithGST.Text = dt.Rows[0]["CustomerWithTax"].ToString();
                //  txt_CustomerRate.Text = dt.Rows[0]["CustomerRate"].ToString();

                try
                {
                    String[] Date = dt.Rows[0]["BatchDate"].ToString().Split(new String[] { "-" }, StringSplitOptions.RemoveEmptyEntries);
                    ddlmfgmonth.SelectedValue = Date[0];
                    ddlmfgyear.SelectedValue = Date[1];


                    String[] ExpiryDate = dt.Rows[0]["ExpiryDate"].ToString().Split(new String[] { "-" }, StringSplitOptions.RemoveEmptyEntries);
                    ddl_ExpiryMonth.SelectedValue = ExpiryDate[0];
                    ddl_ExpiryYear.SelectedValue = ExpiryDate[1];

                }
                catch { }
            }
            else
            {
                ResetControl();
            }
        }
        else
        {
            ResetControl();
        }
    }
    [WebMethod]
    public static string GetColor(string CLRId)
    {
        String Result = "";
        if (CLRId != "0")
        {
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@CLRId", CLRId) };
            DataUtility objDu = new DataUtility();
            Result = objDu.GetScaler(param, "Select ColorCode from tbl_Color where CLRId=@CLRId").ToString();
        }
        return Result;
    }

    private void ResetControl()
    {
        txtbatchno.Text = "";
        txt_MRP.Text = "";
        ddlGST.SelectedValue = "0";
        txtDPWithTax.Text = "";
        txtDP.Text = "";
        txtPV.Text = "";
        txtBV.Text = "";
        txt_FPV.Text = "";
        txt_APV.Text = "";
        txt_DpStockWithTax.Text = "";
        txt_DpStock.Text = "";
        txt_PORateWithGST.Text = "";
        txt_PORate.Text = "";

        txt_CustomerWithGST.Text = "";
        txt_CustomerRate.Text = "";


        txt_CompanyRateWithGST.Text = "";
        txt_CompanyRate.Text = "";

        ddlmfgmonth.SelectedValue = "0";
        ddlmfgyear.SelectedValue = "0";
        ddl_ExpiryMonth.SelectedValue = "0";
        ddl_ExpiryYear.SelectedValue = "0";
    }
}