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
using System.Collections.Generic;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Collections.Generic;
using System.Linq;

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
            BindYear();
            bindproduct();
        }
    }


    void BindYear()
    {
        ddlmfgyear.Items.Clear();
        for (int i = 4; i >= 0; i--)
        {
            string Year = DateTime.Now.AddYears(-i).ToString("yyyy");
            ddlmfgyear.Items.Insert(0, new System.Web.UI.WebControls.ListItem(Year, Year));
        }
        ddlmfgyear.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select", "0"));
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            lblmsg.Text = "";
            string Qty = txtqty.Text == "" ? "0" : txtqty.Text;

            if (Convert.ToInt32(Qty) <= 0)
            {
                utility.MessageBox(this, "please Enter Positive Quantity");
                return;
            }
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("UpdateProductQty", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "insert");
            cmd.Parameters.AddWithValue("@batchid", ddl_BatchNo.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@pid", Convert.ToInt32(ddlproductname.SelectedValue.ToString()));
            cmd.Parameters.AddWithValue("@batchdate", ddlmfgmonth.SelectedItem.Text + "-" + ddlmfgyear.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@batchno", txtbatchno.Text.Trim().ToUpper());
            cmd.Parameters.AddWithValue("@type", ddltype.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@qty", Qty);

            cmd.Parameters.AddWithValue("@MRP", txt_MRP.Text.Trim() == "" ? "0" : txt_MRP.Text.Trim());
            cmd.Parameters.AddWithValue("@GST", ddlGST.SelectedValue);
            cmd.Parameters.AddWithValue("@DPWithTax", txtDPWithTax.Text.Trim() == "" ? "0" : txtDPWithTax.Text.Trim());
            cmd.Parameters.AddWithValue("@DP", txtDP.Text.Trim() == "" ? "0" : txtDP.Text.Trim());
            cmd.Parameters.AddWithValue("@PV", txtPV.Text.Trim() == "" ? "0" : txtPV.Text.Trim());
            cmd.Parameters.AddWithValue("@BV", txtBV.Text.Trim() == "" ? "0" : txtBV.Text.Trim());

            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            msg = cmd.Parameters["@flag"].Value.ToString();
            if (msg == "1")
            {
                Reset();
                Response.Redirect("BatchList.aspx");
            }
            else
            {
                lblmsg.Text = msg;
            }
            con.Close();
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }

    }

    private void Reset()
    {
        ddlproductname.SelectedValue = "0";
        ddl_BatchNo.SelectedValue = "0";
        ddlmfgmonth.SelectedValue = "0";
        ddlmfgyear.SelectedValue = "0";
        ddltype.SelectedValue = "0";
        ddl_BatchNo.SelectedValue = "0";
        ddlGST.SelectedValue = "0";

        txtbatchno.Text = "";
        txtqty.Text = "";
        txt_MRP.Text = "";
        txtDPWithTax.Text = "";
        txtDP.Text = "";
        txtPV.Text = "";
        txtBV.Text = "";

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
        if (dt.Rows.Count > 0)
        {
            ddl_BatchNo.DataTextField = "BatchNo";
            ddl_BatchNo.DataValueField = "Batchid";
            ddl_BatchNo.DataSource = dt;
            ddl_BatchNo.DataBind();

            ddl_BatchNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("New Batch", "0"));
        }
        else
            ddl_BatchNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("New Batch", "0"));

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
                txtbatchno.Text = dt.Rows[0]["BatchNo"].ToString();
                txt_MRP.Text = dt.Rows[0]["MRP"].ToString();
                ddlGST.SelectedValue = dt.Rows[0]["Tax"].ToString();
                txtDPWithTax.Text = dt.Rows[0]["DPWithTax"].ToString();
                txtDP.Text = dt.Rows[0]["DPAmt"].ToString();
                txtPV.Text = dt.Rows[0]["pbvamt"].ToString();
                txtBV.Text = dt.Rows[0]["BVAmt"].ToString();

                String[] Date = dt.Rows[0]["BatchDate"].ToString().Split(new String[] { "-" }, StringSplitOptions.RemoveEmptyEntries);

                ddlmfgmonth.SelectedValue = Date[0];
                ddlmfgyear.SelectedValue = Date[1];
            }
        }
        else
        {
            txtbatchno.Text = "";
            txt_MRP.Text = "";
            ddlGST.SelectedValue = "0";
            txtDPWithTax.Text = "";
            txtDP.Text = "";
            txtPV.Text = "";
            txtBV.Text = "";

            ddlmfgmonth.SelectedValue = "0";
            ddlmfgyear.SelectedValue = "0";
        }

    }
}