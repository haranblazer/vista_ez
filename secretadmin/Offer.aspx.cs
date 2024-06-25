using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

public partial class admin_Offer : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand com = null;
    utility objUtil = null;
    SqlDataAdapter da;
    DataTable dt;
    string DDate = "",OfferType="",PType="";int qnt;
    float offercriteria;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        { 
            BindProducts();
            BindGrid1();
            BindGrid(1);
        }
    }
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
    private bool updateQuantity(string ProductName)
    {
        bool status = true;
        List<string> objlist = new List<string>();
        if (ViewState["product"] != null)
        {
            dt = (DataTable)ViewState["product"];
        }
        if (dt != null)
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                TextBox cd = (TextBox)row.Cells[1].FindControl("txtcode");
    
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
                       
                        
                        if (!string.IsNullOrEmpty(text))
                        {
                            //if Same product is added then increment the quantity value txtMRP
                            drow.BeginEdit();
                            drow["cd"] = cd.Text;
                            drow["quantity"] = Convert.ToInt32(text);
                            drow["pname"] = strProduct;
                            drow.EndEdit();
                        }
                        
                    }
                }
            }
            ViewState["product"] = dt;

        }
        return status;
    }
    public void BindProduct()
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter da = new SqlDataAdapter();
            da = new SqlDataAdapter("select ProductName,productId from ShopProductMst  order by productId ", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            divProduct.InnerText = string.Empty;
            //foreach (DataRow drw in dt.Rows)
            //{
            //    divProduct.InnerText += drw["ProductName"].ToString().Trim() + ",";
            //}
            //GridView1.DataSource = dt;
            //GridView1.DataBind();
        }
        catch
        {
        }
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {

        if (updateQuantity(string.Empty) == false)
        {
            utility.MessageBox(this, "Please Select Offered Product");
            return;
        }
        dt = (DataTable)ViewState["product"];
        DataTable tempDt = new DataTable();
        tempDt = dt.Copy();
        List<DataRow> objRows = tempDt.AsEnumerable().Where(o => string.IsNullOrEmpty(o.Field<string>("pname")) || o.Field<int>("quantity") == 0).ToList();
        foreach (DataRow row in objRows)
        {
            tempDt.Rows.Remove(row);
            tempDt.AcceptChanges();
        }
        if (tempDt.Rows.Count <= 0)
        {
            utility.MessageBox(this,"Please Select Offered Product");
            return;
        }
        if (validate())
        {
            string query = string.Empty;
            try
            {
                if (OfferType == "1")
                {
                    query = "select count(*) from OfferMst where OfferCriteria=@oc and PType=@ptb and active=1 and vdata>=cast(cast(@vdata as float) as datetime)";
                }
                else if (OfferType == "2")
                {
                    query = "select count(*) from OfferMst where OfferType=2  and active=1 and vdata>=cast(cast(@vdata as float) as datetime)";
                }
                else if (OfferType == "3")
                {
                    query = "select count(*) from OfferMst where OfferType=3 and active=1 and vdata>=cast(cast(@vdata as float) as datetime)";
                }
                //query = "select count(*) from OfferMst where OfferCriteria=@oc and PType=@ptb and active=1 and vdata>=cast(cast(@vdata as float) as datetime)";
                con = new SqlConnection(method.str);
                com = new SqlCommand(query, con);
                com.CommandType = CommandType.Text;
                 if (OfferType == "1")
                {
                    com.Parameters.AddWithValue("@oc", offercriteria);
                    com.Parameters.AddWithValue("@ptb", "Product");
                }
                com.Parameters.AddWithValue("@vdata", DateTime.UtcNow);
                con.Open();
                int J = Convert.ToInt32(com.ExecuteScalar());
                con.Close();
                    con = new SqlConnection(method.str);
                    com = new SqlCommand("insert into OfferMst (OfferType,OfferCriteria,Cquantity,doe,VData,Active,Pamount,PType)values(@OType,@OCriteria,@Cquantity,@Doe,@Vdata,@active,@Pamt,@PType)", con);
                    com.Parameters.AddWithValue("@OType",Convert.ToInt32(OfferType));
                    com.Parameters.AddWithValue("@OCriteria",Convert.ToSingle(offercriteria));
                    com.Parameters.AddWithValue("@Cquantity", qnt);
                    //com.Parameters.AddWithValue("@Offer", ddl_Offer.SelectedValue.ToString());
                    //com.Parameters.AddWithValue("@quantity",txtGOffer.Text);
                    com.Parameters.AddWithValue("@Doe", DateTime.UtcNow.AddMinutes(330));
                    com.Parameters.AddWithValue("@Vdata", DDate);
                    com.Parameters.AddWithValue("@PType", PType);
                    com.Parameters.AddWithValue("@Pamt", txt_PlusAmt.Text);
                    com.Parameters.AddWithValue("@active", 1);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    if (i == 1)
                    {
                        int id = FindId();
                        saveoproduct(id, tempDt);
                        utility.MessageBox(this, "Offer Product Save Successfully.");
                    }
                    con.Close();
                    BindGrid(1);
                    clear();
                    tbl1.Visible = false;
            
                clear();
                tbl1.Visible = false; return;
            }
            catch
            {
            }
        }
    }
    private DataTable CreateStructure()
    {
        DataTable dt_temp = new DataTable();
        //dt.Load(reader);
        DataColumn column = new DataColumn("id", typeof(Int32));
        column.DataType = System.Type.GetType("System.Int32");
        column.AutoIncrement = true;
        column.AutoIncrementSeed = 1;
        column.AutoIncrementStep = 1;
        dt_temp.Columns.Add(column);
        DataColumn dcpnmae = new DataColumn("pname", typeof(string));
        dcpnmae.DefaultValue = string.Empty;
        dt_temp.Columns.Add(dcpnmae);
        DataColumn dcMRP = new DataColumn("quantity", typeof(int));
        dcMRP.DefaultValue = 0;
        dt_temp.Columns.Add(dcMRP);
        DataColumn code = new DataColumn("cd", typeof(float));
        code.DefaultValue = 0;
        dt_temp.Columns.Add(code);
        return dt_temp;
    }
    private void BindGrid1()
    {
       
        if (ViewState["product"] != null)
            dt = (DataTable)ViewState["product"];
        if (dt == null)
        {
            dt = CreateStructure().Clone();

            //add 10 default row
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            ViewState["product"] = dt;
        }
        GridView1.DataSource = dt;
        GridView1.DataBind();
        //CalculateTotal(dt);
    }
    private void BindProducts()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        //ViewState["Count"] = null;
        try
        {
            DataTable dt = new DataTable();
            da = new SqlDataAdapter("select ProductName,DPWithTax,Tax,DPAmt,BVAmt as BV,MaxAllowed,productid,QTY from ShopProductMst where isdeleted=0 order by productId ", con);
            da.Fill(dt);
            if (!IsPostBack)
            {
                List<string> objProductList = new List<string>(); ;
                String strPrdPrice = string.Empty;
                strPrdPrice += "<table id='tblMRP'>";
                divMRP.InnerHtml = string.Empty;
                divProduct.InnerText = string.Empty;
                foreach (DataRow drw in dt.Rows)
                {

                    divProduct.InnerText += drw["ProductName"].ToString().Trim() + ",";
                    strPrdPrice += "<tr><td>" + drw["ProductName"].ToString() + "</td><td>" + drw["DPWithTax"].ToString() + "</td><td>" + drw["Tax"].ToString() + "</td>" +
                        "<td>" + drw["DPAmt"].ToString() + "</td><td>" + drw["BV"].ToString() + "</td><td>" + drw["MaxAllowed"].ToString() + "</td></td><td>" + drw["productid"].ToString() + "</td><td>" + drw["QTY"].ToString() + "</td></tr>";
                    objProductList.Add(drw["ProductName"].ToString().Trim());
                }
                strPrdPrice += "</table>";
                divMRP.InnerHtml = strPrdPrice;
                ViewState["pname"] = objProductList;
                string [] x=divProduct.InnerText.Split(',');
            }
        }
        catch
        {
        }
        finally
        {
        }
    }
    private int FindId()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("select max(id) from offermst", con);
        con.Open();
        object o = com.ExecuteScalar();
        con.Close();
        return(Convert.ToInt32(o));
        
    }
    void saveoproduct( int offerno,DataTable dtTemp)
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("select * from offerproduct", con);
        dt = new DataTable();
        da.Fill(dt);
        foreach ( DataRow row in dtTemp.Rows)
        {
            
                DataRow dr = dt.NewRow();
                dr["offerno"] = offerno;
                dr["productid"] = Convert.ToInt32(row["cd"].ToString());
                dr["Productname"] = row["pname"].ToString();
                dr["quantity"] = row["quantity"].ToString();
                dt.Rows.Add(dr);
                SqlCommandBuilder bl = new SqlCommandBuilder(da);
                da.Update(dt);
            }
        ViewState["product"] = null;
        dt = null;
        BindGrid1();
        }
    public void BindGrid(int active)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter da1;
            
            //da = new SqlDataAdapter("select id,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then(select 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria) as pf from offermst where offertype=2) when offerType=3 then(select 'BV on Rs-'+Convert(varchar(10),OfferCriteria) as pf1 from offermst where offertype=3)  end as offeron from offermst o where active=1 and vdata>=cast(cast(@vdata as float) as datetime) order by offertype", con);
            da = new SqlDataAdapter("select active,id,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria)  when offerType=3 then 'BV on Rs-'+Convert(varchar(10),OfferCriteria)  end as offeron from offermst o where active=@active   and vdata>=cast(cast(@vdata as float) as datetime) order by offertype", con);
            da.SelectCommand.Parameters.AddWithValue("@active", active);
            da.SelectCommand.Parameters.AddWithValue("@vdata", DateTime.UtcNow);
            dt = new DataTable();
            da.Fill(dt);
            //da1 = new SqlDataAdapter("select  p.productname,p.quantity,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then(select 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria) as pf from offermst where offertype=2) when offerType=3 then(select 'BV on Rs-'+Convert(varchar(10),OfferCriteria) as pf1 from offermst where offertype=3)  end as offeron,convert(varchar(10),vdata,103) as vdata,pamount,id from offermst o inner join offerproduct p on o.id=p.offerno where active=1 and vdata>=cast(cast(@vdata as float) as datetime)", con);
            da1 = new SqlDataAdapter("select p.productname,p.quantity,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria) when offerType=3 then 'BV on Rs-'+Convert(varchar(10),OfferCriteria)   end as offeron,convert(varchar(10),vdata,103) as vdata,pamount,id,p.productid from offermst o inner join offerproduct p on o.id=p.offerno where  o.active=@active and o.vdata>=cast(cast(@vdata as float) as datetime)", con);
            da1.SelectCommand.Parameters.AddWithValue("@active", active);
            da1.SelectCommand.Parameters.AddWithValue("@vdata", DateTime.UtcNow);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            if (dt.Rows.Count > 0)
            {
                ViewState["offer"] = dt1;
                grd1.DataSource = dt;
                grd1.DataBind();
            }
        }
        catch
        {
        }
    }
    int updatestatus(int status,int id)
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("update offermst set active=@sts where id=@id", con);
        com.Parameters.AddWithValue("@sts", status);
        com.Parameters.AddWithValue("@id",id);
        con.Open();
       int res= com.ExecuteNonQuery();
        if(res>0)
        {
             con.Close();
            return(1);
        }
        else
        {
            con.Close();
            return(0);
       
        }
       
    }
    protected void grd1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeActivate")
        {
            if (updatestatus(0, Convert.ToInt32(e.CommandArgument)) > 0)
            {
                BindGrid(1);
                utility.MessageBox(this,"Offer Deactivated Susscessfully");
            }
        }
        else if (e.CommandName == "Activate")
        {
            if (updatestatus(1, Convert.ToInt32(e.CommandArgument)) > 0)
            {
                BindGrid(0);
                utility.MessageBox(this, "Offer activated Susscessfully");
            }
        }
        else if (e.CommandName == "EDIT")
        {
            try
            {
                BindProduct();
                con = new SqlConnection(method.str);
                da = new SqlDataAdapter();
                da = new SqlDataAdapter("select * from OfferMst where id=" + e.CommandArgument.ToString(), con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    ViewState["id"] = e.CommandArgument.ToString();
                    btn_submit.Visible = false;
                    btn_Update.Visible = true;
                    tbl1.Visible = true;

                    txtPName.Enabled = false;
                    // txtGOffer.Text = dt.Rows[0]["quantity"].ToString();
                    string[] date = dt.Rows[0]["VData"].ToString().Split('/');
                    string DD = date[0];
                    string MM = date[1];
                    string YEAR = date[2];
                    txt_Date.Text = MM + "-" + DD + "-" + YEAR;
                    //ddl_Offer.ClearSelection();
                    //ddl_Offer.Items.FindByValue(dt.Rows[0]["offer"].ToString()).Selected = true;
                    txt_PlusAmt.Text = dt.Rows[0]["Pamount"].ToString();
                    string OfferT = dt.Rows[0]["OfferType"].ToString();
                    if (OfferT == "1")
                    {
                        txtNoOfproduct.Text = dt.Rows[0]["cquantity"].ToString();
                        RdoOffer.SelectedValue = "1";
                        id_NoOfP.Attributes["style"] = "display:block;";
                        id_Product.Attributes["style"] = "display:block;";
                        id_amt.Attributes["style"] = "display:none;";
                        id_BVAmt.Attributes["style"] = "display:none;";
                        txtPName.Text = dt.Rows[0]["offercriteria"].ToString();

                    }
                    if (OfferT == "2")
                    {
                        RdoOffer.SelectedValue = "2";
                        txt_Amt.Text = dt.Rows[0]["offercriteria"].ToString();
                        id_NoOfP.Attributes["style"] = "display:none;";
                        id_amt.Attributes["style"] = "display:block;";
                        id_BVAmt.Attributes["style"] = "display:none;";
                        id_Product.Attributes["style"] = "display:none;";
                        txtPName.Enabled = false;
                    }
                    if (OfferT == "3")
                    {
                        txt_BV.Text = dt.Rows[0]["offercriteria"].ToString();
                        RdoOffer.SelectedValue = "3";
                        id_NoOfP.Attributes["style"] = "display:none;";
                        id_amt.Attributes["style"] = "display:none;";
                        id_BVAmt.Attributes["style"] = "display:block;";
                        id_Product.Attributes["style"] = "display:none;";
                        txtPName.Enabled = false;

                    }
                }
            }
            catch
            {
            }
        }

    }
    private int FindPId(string productname)
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("select productid from shopproductmst where productname=@pname", con);
        da.SelectCommand.Parameters.AddWithValue("@pname",productname);
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            return (Convert.ToInt32(dt.Rows[0]["productid"].ToString()));
        }
        else
            return (0);
    }
    protected bool validate()
    {
        
        if (RdoOffer.SelectedValue == "1")
        {
            OfferType = "1";
            PType = "Product";
            txt_Amt.Text = "";
            txt_BV.Text = "";
            if (txtNoOfproduct.Text == "")
            {
                utility.MessageBox(this, "please Enter No Of Product.");
                return false;
            }
            if (Regex.Match(txtNoOfproduct.Text, @"^[0-9]*$").Success)
            {
            }
            else
            {
                utility.MessageBox(this, "Please Enter Numeric Value .");
                return false;
            }
            offercriteria =FindPId(txtPName.Text);
            if (offercriteria <= 0)
            {
                utility.MessageBox(this,"Product Name not exist,Please enter valid product name");
            }
            qnt = Convert.ToInt32(txtNoOfproduct.Text);
        }
        if (RdoOffer.SelectedValue =="2")
        {
            OfferType = "2";
            PType = "Amount";
            txtNoOfproduct.Text = "";
            txt_BV.Text = "";
            if (txt_Amt.Text == "")
            {
                utility.MessageBox(this, "Please Enter amount.");
                return false;
            }
            if (Regex.Match(txt_Amt.Text, @"^[0-9]*$").Success)
            {
            }
            else
            {
                utility.MessageBox(this, "Amount Not Valid.");
                return false;
            }
            qnt = 0;
            offercriteria = Convert.ToSingle(txt_Amt.Text);
        }
        if (RdoOffer.SelectedValue == "3")
        {
            OfferType = "3";
            PType = "BV";
            txtNoOfproduct.Text = "";
            txt_Amt.Text = "";
            if (txt_BV.Text == "")
            {
                utility.MessageBox(this, "please Enter BV Amount.");
                return false;
            }
            if (Regex.Match(txt_BV.Text, @"^[0-9]*$").Success)
            {
            }
            else
            {
                utility.MessageBox(this, "BV Amount Not Valid.");
                return false;
            }
            qnt = 0;
            offercriteria = Convert.ToSingle(txt_BV.Text);
        }
        if (txt_Date.Text == "")
        {
            utility.MessageBox(this, "please Enter Offer Till Date.");
            return false;
        }
        else
        {
            string todaydate = DateTime.Now.ToString("MM-dd-yyyy");
            string[] date = txt_Date.Text.Split('-');
            string DD = date[0];
            string MM = date[1];
            string YEAR = date[2];
            DDate = MM + "-" + DD + "-" + YEAR;
            if (Convert.ToDateTime(DDate) < Convert.ToDateTime(todaydate))
            {
                utility.MessageBox(this, "Offer Date can't less than ToDay Date");
                return false;
            }
        }
        return true;
    }
    protected void grd1_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }
    protected void btn_Update_Click(object sender, EventArgs e)
    {
        if (validate())
        {
            try
            {
                //com = new SqlCommand("insert into OfferMst (OfferType,OfferCriteria,Cquantity,offer,quantity,doe,VData,Active,Pamount,PType)values(@OType,@OCriteria,@Cquantity,@Offer,@quantity,@Doe,@Vdata,@active,@Pamt,@PType)", con);
                con = new SqlConnection(method.str);
                com = new SqlCommand("update  OfferMst set OfferType=@OType,OfferCriteria=@OCriteria,Cquantity=@Cquantity,offer=@Offer,quantity=@quantity,VData=@VData,Active=@active,PType=@PType,doe=@Doe where id=" + ViewState["id"].ToString(), con);
                com.Parameters.AddWithValue("@OType", Convert.ToInt32(OfferType));
                com.Parameters.AddWithValue("@OCriteria", Convert.ToSingle(offercriteria));
                com.Parameters.AddWithValue("@Cquantity", qnt);
                //com.Parameters.AddWithValue("@Offer", ddl_Offer.SelectedValue.ToString());
                //com.Parameters.AddWithValue("@quantity", txtGOffer.Text);
                com.Parameters.AddWithValue("@Doe", DateTime.UtcNow);
                com.Parameters.AddWithValue("@Vdata", DDate);
                com.Parameters.AddWithValue("@PType", PType);
                com.Parameters.AddWithValue("@Pamt", txt_PlusAmt.Text);
                com.Parameters.AddWithValue("@active",1);
                con.Open();
                int i = com.ExecuteNonQuery();
                con.Close();
                BindGrid(1);
                tbl1.Visible = false;
            }
            catch
            {
            }
        }
    }
    protected void btn_Add_Click(object sender, EventArgs e)
    {
        txtPName.Enabled = true;
        tbl1.Visible = true;
        RdoOffer.Items[0].Selected = true;
        clear();
    }
    public void clear()
    {
        txt_Amt.Text = "";
        txt_BV.Text = "";
        txt_Date.Text = "";
        txtNoOfproduct.Text = "";
        RdoOffer.SelectedValue = "1";
        txtPName.Text = "";
        //foreach (DataListItem item in GridView1.Items)
        //{
            //CheckBox chk = (CheckBox)item.FindControl("CheckBox1");
            //TextBox txtqnt = (TextBox)item.FindControl("TextBox1");
            //txtqnt.Text = "0";
            //chk.Checked = false;
            //txtqnt.Enabled = false;
        //}
    }
    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        clear();
        tbl1.Visible = false;
    }
    protected void GridView1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "check")
        {
            TextBox t = e.Item.FindControl("TextBox1") as TextBox;
            t.Text = "1";
        }
    }
    protected void btnAddMore_Click(object sender, ImageClickEventArgs e)
    {
        //bind if grid view has valid entries
       
            if (ViewState["product"] != null)
            {
                dt = (DataTable)ViewState["product"];
                DataRow NewRow = dt.NewRow();
                NewRow["id"] = dt.Rows.Count + 1;
                dt.Rows.Add(NewRow);
                ViewState["product"] = dt;
            }
            BindGrid1();
      
    }
    protected void grd1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex >= 0)
        {
            
            if (ViewState["offer"] != null)
            {
                GridView gd = e.Row.FindControl("GridView2") as GridView;
                string offer = grd1.DataKeys[e.Row.RowIndex].Value.ToString();
                DataTable offerdt = ViewState["offer"] as DataTable;
                gd.DataSource = offerdt.Select("id=" + offer).CopyToDataTable();
                gd.DataBind();
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lbnactive");
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "active")) == "1")
            {
               
                lnkbtn.Text = "De Activate";
                lnkbtn.CommandName = "DeActivate";
            }
            else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "active")) == "0")
            {
                
                lnkbtn.Text = "Activate";
                lnkbtn.CommandName = "Activate";
            }
        }
    }
    protected void GridView1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
  
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex >= 0)
        {

            ((TextBox)e.Row.Cells[2].FindControl("txtProductNAme")).Attributes.Add("onblur", "javascript:ShowMRP(" + (e.Row.RowIndex + 2).ToString() + ",this)");
           
        }
    }
    protected void ddlActive_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BindGrid(Convert.ToInt32(ddlActive.SelectedValue.ToString()));
        }
        catch { }
    }
}