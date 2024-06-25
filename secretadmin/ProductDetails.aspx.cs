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
using System.Text;
public partial class admin_ProductDetails : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataReader rd;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            fillcategory();


    }
    protected void ddlcid_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlcid.SelectedIndex == 0)
        {
            btngetdata.Visible = false;
            lblError.Visible = true;
            lblError.Text = "Please Select a Category.....";
            GridView1.Visible = false;
            Button1.Visible = false;
        }
        else
        {
            btngetdata.Visible = true;
            lblError.Visible = false;
            Button1.Visible = false;
            GridView1.Visible = false;
        }
    }
    public void fillcategory()
    {

        string str = "select CategoryMstID,CategoryMstName from RCategory";
        cmd = new SqlCommand(str, con);
        con.Open();
        rd = cmd.ExecuteReader();
        if (rd.HasRows)
        {
            while (rd.Read())
            {
                ddlcid.Items.Add(rd.GetValue(0).ToString() + " " + rd.GetValue(1).ToString());
            }
        }
        con.Close();
    }
    protected void btngetdata_Click(object sender, EventArgs e)
    {

        checkForProduct();

    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }
    public void bindgrid()
    {
        GridView1.Visible = true;
        Button1.Visible = true;

        string[] cid = ddlcid.SelectedItem.Text.Split(' ');
        Button1.Visible = true;
        string str = "SELECT ProductCode,ProductName,Quantity,StockInHand,Description,BV,PV,DistibutorPrice,MRP,vat,ProductImage FROM ProductMaster where CategoryId='" + Int32.Parse(cid[0].ToString()) + "'";
        con.Close();
        cmd = new SqlCommand(str, con);
        con.Open();
        GridView1.DataSource = cmd.ExecuteReader();
        GridView1.DataBind();
        con.Close();



    }
    public void checkForProduct()
    {
        string[] cid1 = ddlcid.SelectedItem.Text.Split(' ');
        string str = "select ProductCode from ProductMaster where CategoryId='" + Int32.Parse(cid1[0].ToString()) + "'";
        cmd = new SqlCommand(str, con);
        con.Open();
        rd = cmd.ExecuteReader();
        if (rd.HasRows)
        {
            bindgrid();
            con.Close();
        }
        else
        {
            lblError.Visible = true;
            lblError.Text = "No Products Found, Please Try With Different Category.....";
        }
        rd.Close();
        con.Close();


    }



    protected void Button1_Click(object sender, EventArgs e)
    {

        //StringBuilder str = new StringBuilder();


        for (int i = 0; i < GridView1.Rows.Count; i++)
        {

            GridViewRow row = GridView1.Rows[i];
            bool isChecked = ((CheckBox)row.FindControl("chkSelect")).Checked;

            if (isChecked)
            {

                //str.Append(GridView1.Rows[i].Cells[3].Text);
                string str1 = (GridView1.Rows[i].Cells[2].Text);
                string str2 = "delete from ProductMaster where ProductCode='" + str1 + "'";
                con.Open();
                SqlCommand cmd2 = new SqlCommand(str2, con);
                cmd2.ExecuteNonQuery();
                con.Close();
                lblError.Text = "Item Removed SuccessFully.....";
            }


            else
            {
                lblError.Text = "Please Select The Items To be Removed.....";
            }


        }
        bindgrid();


    }
       
}
