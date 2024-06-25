using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Xml;
using System.Xml.Linq;
using System.Data;

public partial class admin_AddInventory : System.Web.UI.Page
{
    SqlConnection con;
    SqlDataAdapter da;
    DataTable dt, dt1;
    SqlCommand cmd;
    int qnt;
    string commonbook;
    XmlDocument xmldoc;
    utility objUtil;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindProducts();
            ViewState["id"] = "0";
           
        }
    }
    private void BindProducts()
    {
        con = new SqlConnection(method.str);
       da = new SqlDataAdapter();
        try
        {
            dt = new DataTable();
            da = new SqlDataAdapter("select ProductName,productid,QTY from ShopProductMst where isdeleted=0 order by productId ", con);
            da.Fill(dt);
            if (!IsPostBack)
            {
                List<string> objProductList = new List<string>(); 
                String strPrdPrice = string.Empty;
                strPrdPrice += "<table id='tblMRP'>";
                divProduct.InnerText = string.Empty;
                divMRP.InnerHtml = string.Empty;
                foreach (DataRow drw in dt.Rows)
                {
                    divProduct.InnerText += drw["ProductName"].ToString() + ",";
                    strPrdPrice += "<tr><td>" + drw["ProductName"].ToString() + "</td><td>" + drw["QTY"].ToString() + "</td><td>" + drw["productid"].ToString() + "</td></tr>";
                    objProductList.Add(drw["ProductName"].ToString());
                }
                strPrdPrice += "</table>";
                divMRP.InnerHtml = strPrdPrice;
                ViewState["pname"] = objProductList;
            }
        }
        catch
        {
        }
        finally
        {
        }
    }
    private DataTable FindId(string pname)
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("select productid,qty from shopproductmst where productname=@pname",con);
        da.SelectCommand.Parameters.AddWithValue("@pname",pname);
        dt=new DataTable();
        da.Fill(dt);
        return (dt);
    }
    private DataTable  findDetails(string tname)
    {
        con = new SqlConnection(method.str);
        string query = "select detail from '" +tname + "' where salesrepid=1  and status=1";
        da = new SqlDataAdapter(query,con);
        dt = new DataTable();
        da.Fill(dt);
        return dt;
    }
    int q = 0;
    private int TotalQuantty(int totq,string tname,string pname)
    {
        q = totq;
        string xdata;
        xmldoc = new XmlDocument();
        dt1 = findDetails(tname);
        foreach (DataRow row in dt1.Rows)
        {
            xdata = row["detail"].ToString();
            if (xdata != "")
            {
                XDocument reportXmlDoc = XDocument.Parse(xdata); //This is the string var assigned with data above
                var filteredList = (from x in reportXmlDoc.Descendants("P")
                                    where x.Element("pname").Value == pname
                                    select new { qnt = Convert.ToInt32(x.Element("Qnt").Value) }).ToList();
                if(filteredList.Count>0)
                q += filteredList[0].qnt;

            }
        }
        return (q);
    }
    //void BindGrid(string pname,int id1,int qnt)
    //{
    //    q = TotalQuantty(q, "stockmst",pname);
    //    q = TotalQuantty(q, "Billmst",pname);
    //    DataTable dt_temp = new DataTable();
    //    DataColumn dcpnmae = new DataColumn("pname", typeof(string));
       
    //    dt_temp.Columns.Add(dcpnmae);
    //    DataColumn totin = new DataColumn("in", typeof(int));
       
    //    dt_temp.Columns.Add(totin);
    //    DataColumn totout = new DataColumn("out", typeof(int));
    //    dt_temp.Columns.Add(totout);

    //    DataColumn pr = new DataColumn("productid", typeof(int));
    //    dt_temp.Columns.Add(pr);

    //    DataColumn totqnt = new DataColumn("qty", typeof(int));
    //    dt_temp.Columns.Add(totqnt);

    //    DataRow dr = dt_temp.NewRow();
    //    dr["pname"] = pname;
    //    dr["in"] = totalinput(id1);
    //    dr["out"] = q;
    //    ViewState["id"] = dr["productid"] = id1;
    //    dr["qty"] = qnt;
    //    dt_temp.Rows.Add(dr);
    //    Grdreport.DataSource = dt_temp;
    //    Grdreport.DataBind();

    //}
    private int totalinput(int pid)
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("select sum(quantity) as q from addinventory where pid=@pid", con);
        da.SelectCommand.Parameters.AddWithValue("@pid",pid);
        dt = new DataTable();
        da.Fill(dt);
        if (string.IsNullOrEmpty(dt.Rows[0]["q"].ToString()))
        {
            return (0);
        }
        else
        return (Convert.ToInt32(dt.Rows[0]["q"].ToString()));
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {

            if (txtpname.Text.Trim().Length == 0)
            {
                utility.MessageBox(this, "Please enter product name !");
                return;
            }
            if (txtqnt.Text.Trim().Length == 0)
            {
                utility.MessageBox(this, "Please enter quantity !");
                return;
            }
            if (txtpCode.Text.Trim() == "0")
            {
                utility.MessageBox(this, "Please enter quantity quantity greater than 0 !");
                return;
            }

            dt1 = FindId(txtpname.Text);
            if (dt1.Rows.Count > 0)
            {
                con = new SqlConnection(method.str);
                cmd = new SqlCommand("productupdate", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@pid", int.Parse(dt1.Rows[0]["productid"].ToString()));
                cmd.Parameters.AddWithValue("@qty", int.Parse(txtqnt.Text));
                cmd.Parameters.AddWithValue("@pname", txtpname.Text);
                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                string msg = cmd.Parameters["@flag"].Value.ToString();
                {


                    if (msg == "1")
                    {
                        con.Close();
                        utility.MessageBox(this, "Inventory Added Successfully");
                       // BindGrid(txtpname.Text.Trim(), Convert.ToInt32(dt1.Rows[0]["productid"].ToString()), qnt);
                        txtpname.Text = txtqnt.Text = txtstock.Text = txtpCode.Text = "";

                    }

                }


            }


            else
            {
                utility.MessageBox(this, "This Product Does not Exist");

              
            }
        }
        //dt1 = FindId(txtpname.Text);
        //if (dt1.Rows.Count > 0)
        //{
        //    qnt = Convert.ToInt32(dt.Rows[0]["qty"].ToString());
        //    con = new SqlConnection(method.str);
        //    cmd = new SqlCommand("update shopproductmst set qty=@qty where productid=@pid",con);
        //    con.Open();
        //    qnt += Convert.ToInt32(txtqnt.Text);
        //    cmd.Parameters.AddWithValue("@qty", qnt);
        //    cmd.Parameters.AddWithValue("@pid", dt1.Rows[0]["productid"].ToString());
        //    int r = cmd.ExecuteNonQuery();
        //    if (r > 0)
        //    {
        //        da = new SqlDataAdapter("select * from AddInventory", con);
        //        dt = new DataTable();
        //        da.Fill(dt);
        //        DataRow dr = dt.NewRow();
        //        dr["Pid"] = dt1.Rows[0]["productid"].ToString();
        //        dr["Pname"] =txtpname.Text;
        //        dr["Quantity"] = txtqnt.Text;
        //        dr["Doe"] = DateTime.UtcNow.AddMinutes(330);
        //        dt.Rows.Add(dr);
        //        SqlCommandBuilder bl = new SqlCommandBuilder(da);
        //        da.Update(dt);
        //        utility.MessageBox(this, "Inventory Add successfully !");
        //        BindGrid(txtpname.Text.Trim(), Convert.ToInt32(dt1.Rows[0]["productid"].ToString()), qnt);
        //        txtpname.Text = txtqnt.Text = txtstock.Text = txtpCode.Text = "";
        //    }
        //    con.Close();
        //}
        //else
        //{
        //    utility.MessageBox(this, "Product not exists");
        //}


        catch (Exception ex)
        {

            utility.MessageBox(this,ex.ToString());
        }
    }
    protected void Grdreport_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        objUtil = new utility();
        if (e.CommandName == "In")
        {
            Response.Redirect("TotalIn.aspx?id="+objUtil.base64Encode(ViewState["id"].ToString()));
        }
        if (e.CommandName == "out")
        {
            Response.Redirect("TotalOut.aspx?id=" + objUtil.base64Encode(ViewState["id"].ToString()));
        }
    }
}