using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Xml.Linq;
using System.Xml;


public partial class d2000admin_BillingFrom : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand com = null;
    utility objUtil = null;
    string regno = string.Empty;
    DataTable dt = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;

        if (Session["franchiseid"] == null)
        {
            Response.Redirect("../Default.aspx");
        }
        else
        {
            regno = Session["franchiseid"].ToString();
        }

        if (!IsPostBack)
        {
            BindProducts();
            BindGrid();
            BindAddress();
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }

    //private void BindProducts()
    //{
    //    con = new SqlConnection(method.str);
    //    SqlDataAdapter da = new SqlDataAdapter();
    //    //ViewState["Count"] = null;
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        da = new SqlDataAdapter("select ProductName,MRP,BVAmt as BV from ShopProductMst where isdeleted=0 order by productId", con);
    //        da.Fill(dt);
    //        if (!IsPostBack)
    //        {
    //            List<string> objProductList = new List<string>(); ;
    //            String strPrdPrice = string.Empty;
    //            strPrdPrice += "<table id='tblMRP'>";
    //            divProduct.InnerText = string.Empty;
    //            foreach (DataRow drw in dt.Rows)
    //            {
    //                divProduct.InnerText += drw["ProductName"].ToString().Trim() + ",";
    //                strPrdPrice += "<tr><td>" + drw["ProductName"].ToString() + "</td><td>" + drw["MRP"].ToString() + "</td><td>" + drw["BV"].ToString() + "</td></tr>";
    //                objProductList.Add(drw["ProductName"].ToString());
    //            }
    //            strPrdPrice += "</table>";
    //            divMRP.InnerHtml = strPrdPrice;
    //            ViewState["pname"] = objProductList;
    //        }
    //    }
    //    catch
    //    {
    //    }
    //    finally
    //    {
    //    }
    //}

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (updateQuantity(string.Empty))
            {
                int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
                DataTable dt = null;
                if (ViewState["product"] != null)
                    dt = (DataTable)ViewState["product"];
                if (dt != null)
                {
                    dt.Rows.Remove(dt.Select().Where(o => o.Field<int>("id") == id).FirstOrDefault());
                    dt.AcceptChanges();
                }
                ViewState["product"] = dt;
                BindGrid();
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
        }
    }

    /// <summary>
    /// This method is used to generate the bill.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnGenerateBill_Click(object sender, EventArgs e)
    {
        if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();

            dt = (DataTable)ViewState["product"];
            if (updateQuantity(string.Empty))
            {
                //BindGrid();
                //call method to save to database
                string strReturn = SaveDetail();
                if (strReturn == "1")
                {
                    Response.Redirect("OrderList.aspx", false);
                }
                else
                    lblMsg.Text = strReturn;
            }
        }
    }

    private string SaveDetail()
    {
        string status = string.Empty;
        dt = (DataTable)ViewState["product"];

        DataTable tempDt = new DataTable();
        tempDt = dt.Copy();
        if (tempDt != null)
        {
            double amt = 0;//Convert.ToDouble(dt.Compute("sum(total)","1").ToString());
            XElement element = null;
            //make xml node and calculate amount
            //
            List<DataRow> objRows = tempDt.AsEnumerable().Where(o => string.IsNullOrEmpty(o.Field<string>("pname")) || o.Field<int>("quantity") == 0).ToList();
            foreach (DataRow row in objRows)
            {
                tempDt.Rows.Remove(row);
                tempDt.AcceptChanges();
            }

            if (tempDt.Rows.Count > 0)
            {
                element = new XElement("Bill");
                foreach (DataRow row in tempDt.AsEnumerable().Where(o => !string.IsNullOrEmpty(o.Field<string>("pname")) && o.Field<int>("quantity") > 0).CopyToDataTable().Rows)
                {
                    int qnt = 0;
                    if (row["pname"].ToString().Trim().Length > 0 && Convert.ToInt32(string.IsNullOrEmpty(row["quantity"].ToString().Trim()) ? "0" : row["quantity"].ToString().Trim()) > 0)
                    {
                        qnt = Convert.ToInt32(string.IsNullOrEmpty(row["quantity"].ToString()) ? "0" : row["quantity"].ToString());
                        amt += Convert.ToDouble(string.IsNullOrEmpty(row["MRP"].ToString()) ? "0" : row["MRP"].ToString()) * qnt;

                        XElement prdXml = new XElement("P",
                           new XElement("pname", row["pname"].ToString()),
                           new XElement("Qnt", row["quantity"].ToString()),
                            new XElement("MRP", row["MRP"].ToString()),
                             new XElement("BV", row["BV"].ToString()),
                              new XElement("total", row["total"].ToString()));
                        element.Add(prdXml);
                    }
                    //else
                    //    row.Delete();
                }
            }
            //dt.AcceptChanges();

            if (element == null || amt == 0)
            {
                BindGrid();
                return "Please eneter the product and quantity properly.";

            }
            var xmlObject = new XmlDocument();
            xmlObject.LoadXml(element.ToString());
            con = new SqlConnection(method.str);
            com = new SqlCommand("AddOrder", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", regno);
            com.Parameters.AddWithValue("@count", tempDt.Rows.Count);
            com.Parameters.AddWithValue("@amt", amt);
            com.Parameters.AddWithValue("@toAdd", txtAddress.Text.Trim());
            com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            status = com.Parameters["@flag"].Value.ToString();
            string OrderNo = com.Parameters["@InvNo"].Value.ToString();
            if (status == "1")
            {
                ViewState["product"] = tempDt;

                BindGrid();
            }
        }
        else
            lblMsg.Text = "Please enter some product names.";
        return status;
    }

    /// <summary>
    /// 
    /// </summary>
    private void BindAddress()
    {
        con = new SqlConnection(method.str);
        try
        {
            com = new SqlCommand("select 'State:'+ state +  char(13) +'City:' +  city + char(13)+'Address:' + address as Address1 from franchisemst  where franchiseid=@regno", con);
            //pass session id
            com.Parameters.AddWithValue("@regno", regno);
            con.Open();
            string address = com.ExecuteScalar().ToString();
            txtAddress.Text = address;
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Try again.";
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }


    private bool updateQuantity(string ProductName)
    {
        bool status = true;
        List<string> objlist = new List<string>();
        if (ViewState["product"] != null)
            dt = (DataTable)ViewState["product"];
        if (dt != null)
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                TextBox txtQuantity = (TextBox)row.Cells[2].FindControl("txtQuantity");
                string strProduct = ((TextBox)row.Cells[1].FindControl("txtProductNAme")).Text;
                string text = string.IsNullOrEmpty(txtQuantity.Text.Trim()) ? "0" : txtQuantity.Text.Trim();
                objUtil = new utility();
                if (!objUtil.IsNumeric(text))
                {
                    lblMsg.Text = "Invalid Quantity value: '" + txtQuantity.Text + "' entered. for the product: '" + strProduct + "'";
                    status = false;
                    return status;
                }
                else if (!string.IsNullOrEmpty(strProduct) && !IsProductExists(strProduct))
                {
                    lblMsg.Text = "Product named: '" + strProduct + "' not exists";
                    status = false;
                    return status;
                }
                else if (!string.IsNullOrEmpty(strProduct) && IsProductExists(strProduct))
                {
                    if (objlist.Where(o => o == strProduct).FirstOrDefault() != null && objlist.Where(o => o == strProduct).FirstOrDefault().Length > 0)
                    {
                        lblMsg.Text = "Product named: '" + strProduct + "' exists multiple times";
                        status = false;
                        return status;
                    }
                    else
                        objlist.Add(strProduct);
                }
                foreach (DataRow drow in dt.Rows)
                {
                    if (drow["id"].ToString() == GridView1.DataKeys[row.DataItemIndex].Values[0].ToString())
                    {
                        TextBox MRP = (TextBox)row.Cells[3].FindControl("txtMRP");
                        TextBox BV = (TextBox)row.Cells[4].FindControl("txtBV");
                        /*
                        if (string.IsNullOrEmpty(ProductName))
                        {
                            txtQuantity.ReadOnly = true;
                            txtQuantity.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
                            txtQuantity.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");
                        }
                        */

                        if (!string.IsNullOrEmpty(text))
                        {
                            //if Same product is added then increment the quantity value txtMRP
                            drow.BeginEdit();
                            drow["quantity"] = Convert.ToInt32(text);
                            drow["MRP"] = float.Parse(string.IsNullOrEmpty(MRP.Text.Trim()) ? "0" : MRP.Text.Trim());
                            drow["BV"] = float.Parse(string.IsNullOrEmpty(BV.Text.Trim()) ? "0" : BV.Text.Trim());
                            drow["pname"] = strProduct;
                            drow.EndEdit();
                        }
                        //Recalculate total column
                        drow["total"] = Convert.ToDouble(string.IsNullOrEmpty(drow["quantity"].ToString()) ? "0" : drow["quantity"].ToString()) * Convert.ToDouble(string.IsNullOrEmpty(drow["MRP"].ToString()) ? "0" : drow["MRP"].ToString());
                    }
                }
            }
            ViewState["product"] = dt;
        }
        return status;
    }


    /// <summary>
    /// 
    /// </summary>
    /// <param name="objList"></param>
    /// <param name="pname"></param>
    /// <returns></returns>
    private bool IsProductExists(string pname)
    {
        bool Status = false;
        List<string> objList = (List<string>)ViewState["pname"];
        if (objList.Where(o => o == pname).FirstOrDefault() != null && objList.Where(o => o == pname).FirstOrDefault().Length > 0)
            Status = true;
        else
            Status = false;
        return Status;
    }

    /// <summary>
    /// 
    /// </summary>
    private void BindGrid()
    {
        if (ViewState["product"] != null)
            dt = (DataTable)ViewState["product"];
        if (dt == null)
        {
            /*
            con = new SqlConnection(method.str);
            com = new SqlCommand("select  top 10 convert(int,ROW_NUMBER() OVER(ORDER BY productId Asc)) AS id, ProductId,ProductName from ShopProductMst where isdeleted=0 order by productId ", con);
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            if (!reader.HasRows)
                lblMsg.Text = "The product name not found.";
            */
            dt = new DataTable();
            //dt.Load(reader);
            DataColumn column = new DataColumn("id", typeof(Int32));
            column.DataType = System.Type.GetType("System.Int32");
            column.AutoIncrement = true;
            column.AutoIncrementSeed = 1;
            column.AutoIncrementStep = 1;
            dt.Columns.Add(column);
            DataColumn dcpnmae = new DataColumn("pname", typeof(string));
            dcpnmae.DefaultValue = string.Empty;
            dt.Columns.Add(dcpnmae);
            DataColumn dcMRP = new DataColumn("MRP", typeof(float));
            dcMRP.DefaultValue = 0;
            dt.Columns.Add(dcMRP);
            DataColumn dcBV = new DataColumn("BV", typeof(float));
            dcBV.DefaultValue = 0;
            dt.Columns.Add(dcBV);
            DataColumn dc = new DataColumn("quantity", typeof(int));
            dc.DefaultValue = 0;
            dt.Columns.Add(dc);
            DataColumn total = new DataColumn("total", typeof(double));
            total.DefaultValue = 0;
            dt.Columns.Add(total);
            //add 10 default row
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            /*
            foreach (DataRow drow in dt.Rows)
            {
                drow["total"] = Convert.ToDouble(drow["MRP"]);
            }
             * */
            // dt.PrimaryKey = new DataColumn[] { dt.Columns["ProductName"]};
            ViewState["product"] = dt;
        }

        GridView1.DataSource = dt;
        GridView1.DataBind();
         double totalamt=Convert.ToDouble(dt.Compute("sum(total)","true"));
        ((Label)GridView1.FooterRow.FindControl("lblMRPtotal")).Text = dt.Compute("sum(MRP)", "true").ToString().Trim();
        //((Label)GridView1.FooterRow.FindControl("lblDPtotal")).Text = dt.Compute("sum(DPAmt)", "true").ToString();
        ((Label)GridView1.FooterRow.FindControl("lblBVtotal")).Text = dt.Compute("sum(BV)", "true").ToString();
        ((Label)GridView1.FooterRow.FindControl("lblQtotal")).Text = dt.Compute("sum(quantity)", "true").ToString().Trim();
        ((Label)GridView1.FooterRow.FindControl("lblTotal")).Text = Convert.ToString(Math.Round(totalamt,2));
        //dt.Compute("(sum(total)", "true");

    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex >= 0)
        {
            ((TextBox)e.Row.Cells[2].FindControl("txtQuantity")).Attributes.Add("onchange", "javascript:calculate(" + (e.Row.RowIndex + 2).ToString() + ",this)");
            //onblur="ShowMRP();"
            ((TextBox)e.Row.Cells[1].FindControl("txtProductNAme")).Attributes.Add("onblur", "javascript:ShowMRP(" + (e.Row.RowIndex + 2).ToString() + ",this)");
        }
    }

    protected void btnAddMore_Click(object sender, EventArgs e)
    {
        //bind if grid view has valid entries
        if (updateQuantity(string.Empty))
        {
            if (ViewState["product"] != null)
            {
                dt = (DataTable)ViewState["product"];
                DataRow NewRow = dt.NewRow();
                NewRow["id"] = dt.Rows.Count + 1;

                dt.Rows.Add(NewRow);
                ViewState["product"] = dt;
            }
            BindGrid();
        }
    }


    private void BindProducts()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        //ViewState["Count"] = null;
        try
        {
            DataTable dt = new DataTable();
            da = new SqlDataAdapter("bindproduct", con);
            da.SelectCommand.Parameters.AddWithValue("@franchiseid", int.Parse(Session["franchiseid"].ToString()));
            da.SelectCommand.Parameters.AddWithValue("@distype", int.Parse(Session["frantypeid"].ToString()));
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.Fill(dt);

            List<string> objProductList = new List<string>(); ;
            String strPrdPrice = string.Empty;
            strPrdPrice += "<table id='tblMRP'>";
            divMRP.InnerHtml = string.Empty;
            divProduct.InnerText = string.Empty;
            foreach (DataRow drw in dt.Rows)
            {

                divProduct.InnerText += drw["ProductName"].ToString() + ",";
                strPrdPrice += "<tr><td>" + drw["ProductName"].ToString() + "</td><td>" + drw["DPWithTax"].ToString() + "</td><td>" + drw["Tax"].ToString() + "</td>" +
                    "<td>" + drw["DPAmt"].ToString() + "</td><td>" + drw["BV"].ToString() + "</td><td>" + drw["MaxAllowed"].ToString() + "</td></td><td>" + drw["productid"].ToString() + "</td><td>" + drw["QTY"].ToString() + "</td></tr>";
                objProductList.Add(drw["ProductName"].ToString());
            }
            strPrdPrice += "</table>";
            divMRP.InnerHtml = strPrdPrice;
            ViewState["pname"] = objProductList;

        }
        catch
        {
        }
        finally
        {
        }
    }
}
