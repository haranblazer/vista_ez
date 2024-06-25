using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_OfferProdReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
            Response.Redirect("~/Login.aspx");

        if (!Page.IsPostBack)
        {
            BindScheme();
            txtFromDate.Text = DateTime.Now.Date.AddDays(-10).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            BindGrid();
        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        BindGrid();
    }


    public void BindGrid()
    {
        if (Session["admin"] == null)
            Response.Redirect("~/Login.aspx");

        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        DateTime fromDate = new DateTime();
        DateTime toDate = new DateTime();
        try
        {
            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }

        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@min", fromDate),
            new SqlParameter("@max", toDate),
            new SqlParameter("@SalesRepId", txt_SellerId.Text.Trim()),
            new SqlParameter("@SoldTo", txt_BuyerId.Text.Trim()),
            new SqlParameter("@OfferType", ddl_OfferType.SelectedValue),
            new SqlParameter("@SID", ddl_Scheme.SelectedValue),
            new SqlParameter("@ITEMID", ddl_OfferItem.SelectedValue),
        };
        DataUtility obj_du = new DataUtility();
        DataTable dt = obj_du.GetDataTableSP(param, "Get_Offer_Loyalty_Prod");
        Session["dt"] = dt;
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }


    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Dispatch")
            {
                GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
                string Srno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
                string OFFERID = GridView1.DataKeys[row.RowIndex].Values[1].ToString();

                SqlParameter[] param = new SqlParameter[]
                {
                    new SqlParameter("@Srno", Srno),
                    new SqlParameter("@OFFERID", OFFERID),
                    new SqlParameter("@OFFER_STR", OFFERID+",")
                };
                DataUtility objDu = new DataUtility();
                int Result = objDu.ExecuteSql(param, @"Update BillMst Set 
                Dispatch_Offerid=(Case [dbo].GetDispatchStatus(@OFFERID, isnull(Dispatch_Offerid,'')) when 0 then (isnull(Dispatch_Offerid,'') + @OFFER_STR) else isnull(Dispatch_Offerid,'') End)
                Where Srno=@Srno");

                if (Result > 0)
                {
                    utility.MessageBox(this, "Offer dispatch save successfully.!!");
                    BindGrid();
                }
                else
                {
                    utility.MessageBox(this, "This user not in your downline.!!");
                }


            }
        }
        catch (Exception er) { }
    }


    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["dt"];

            if (dt.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "OfferProductReport.xls"));
                Response.ContentType = "application/ms-excel";
                string str = string.Empty;
                foreach (DataColumn dtcol in dt.Columns)
                {
                    Response.Write(str + dtcol.ColumnName);
                    str = "\t";
                }
                Response.Write("\n");
                foreach (DataRow dr in dt.Rows)
                {
                    str = "";
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Response.Write(str + Convert.ToString(dr[j]));
                        str = "\t";
                    }
                    Response.Write("\n");
                }
                Response.End();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
            }
        }
        catch (Exception er) { }

    }

    private void BindScheme()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@"Select SID, Scheme from SchemeMst order by SID desc");
        ddl_Scheme.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl_Scheme.DataSource = dt;
            ddl_Scheme.DataTextField = "Scheme";
            ddl_Scheme.DataValueField = "SID";
            ddl_Scheme.DataBind();
            ddl_Scheme.Items.Insert(0, new ListItem("All Scheme", "0"));
        }
        else
        {
            ddl_Scheme.Items.Insert(0, new ListItem("All Scheme", "0"));
        }
        ddl_OfferItem.Items.Insert(0, new ListItem("All Item", "0"));
    }

    private void BindOffer()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@sid", ddl_Scheme.SelectedValue) };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param, @"Select ITEMID, ItemName from ItemOffer where sid=@sid");
        ddl_OfferItem.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl_OfferItem.DataSource = dt;
            ddl_OfferItem.DataTextField = "ItemName";
            ddl_OfferItem.DataValueField = "ITEMID";
            ddl_OfferItem.DataBind();
            ddl_OfferItem.Items.Insert(0, new ListItem("All Item", "0"));
        }
        else
        {
            ddl_OfferItem.Items.Insert(0, new ListItem("All Item", "0"));
        }
    }

    protected void ddl_Scheme_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindOffer();
    }
}