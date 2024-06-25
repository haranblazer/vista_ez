using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


public partial class Admin_AddItem : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = new DataTable();
    SqlCommand cmd;
    SqlDataAdapter adp;
    string pid = null;
    utility objUtil = new utility();
    int pno;
    protected void Page_Load(object sender, EventArgs e)
    {
        pno = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["id"].ToString()));

        if (!IsPostBack)
        {
            Bind();
        }

    }
    protected void Insert_Click(object sender, EventArgs e)
    {

        try
        {
            if (Insert.CommandName != "EditProduct")
            {
                SqlCommand cmd = new SqlCommand("insertitem", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@pid", pno);
                cmd.Parameters.AddWithValue("@pname", txtpname.Text);
                cmd.Parameters.AddWithValue("@pwt", txtpwt.Text);
                cmd.Parameters.AddWithValue("@tax", txttax.Text);
                cmd.Parameters.AddWithValue("@price", txtprice.Text);
                cmd.Parameters.AddWithValue("@quantity",txtquantity.Text);
                cmd.Parameters.AddWithValue("@taxamount", txtamount.Text);
                cmd.Parameters.AddWithValue("@toalprice",txtamountwithquanity.Text);
                cmd.Parameters.AddWithValue("@peritem", txtperitem.Text);
                //cmd.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output; @toalprice 
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                utility.MessageBox(this, "Item Insert Succesfully");
            }

            if (Insert.CommandName == "EditProduct")
            {
                SqlCommand cmd = new SqlCommand("updateitem", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@itemid", ViewState["pid"]);
                cmd.Parameters.AddWithValue("@pname", txtpname.Text);
                cmd.Parameters.AddWithValue("@pwt", txtpwt.Text);
                cmd.Parameters.AddWithValue("@tax", txttax.Text);
                cmd.Parameters.AddWithValue("@price", txtprice.Text);
                cmd.Parameters.AddWithValue("@quantity", txtquantity.Text);
                cmd.Parameters.AddWithValue("@taxamount", txtamount.Text);
                cmd.Parameters.AddWithValue("@toalprice",txtamountwithquanity.Text);
                cmd.Parameters.AddWithValue("@peritem", txtperitem.Text);
                //cmd.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                utility.MessageBox(this, "Item updated Succesfully");

            }

     

            txtperitem.Text =txtpname.Text = txtpwt.Text = txttax.Text = txtprice.Text = txtamount.Text =txtamountwithquanity.Text=txtquantity.Text= string.Empty;
            Bind();

           
        }
        catch
        {

        }

    }

    protected void txttax_TextChanged(object sender, EventArgs e)
    {
        txtamountwithquanity.Text = Convert.ToString((double.Parse(txtquantity.Text)) * (double.Parse(txtpwt.Text)));
        txtprice.Text = Convert.ToString(((double.Parse(txtamountwithquanity.Text)) * 100) / (100 + double.Parse(txttax.Text)));
        txtamount.Text = Convert.ToString((double.Parse(txtamountwithquanity.Text)) - (double.Parse(txtprice.Text)));

        txtperitem.Text = Convert.ToString(((double.Parse(txtpwt.Text)) * 100) / (100 + double.Parse(txttax.Text)));
      
       
    }

   
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Addproduct.aspx");
    }


    public void Bind()
    {



        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            da = new SqlDataAdapter("select * from itemmst  where productid='"+pno+"' order by itemid", con);
         
            da.Fill(dt);
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


        catch
        {
        }
        finally
        {
            con.Dispose();

        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "Page")
        {
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            ViewState["pid"] = pid = GridView1.DataKeys[row.RowIndex].Value.ToString();



            if (e.CommandName.Equals("EditProduct"))
            {
                //inset.CommandName = "EditProduct";

               Insert.CommandName = "EditProduct";

               txtpname.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
               txtpwt.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[7].Text;
               txtquantity.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text;
               txtamountwithquanity.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[4].Text;
               txttax.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[5].Text;
              txtamount.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[6].Text;
             txtprice.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[8].Text;

             txtperitem.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[3].Text;
           

            }


            if (e.CommandName.Equals("DeleteProduct"))
            {

             SqlCommand cmd = new SqlCommand("delete from itemmst  where itemid='" + pid + "'", con);       
             con.Open();
             cmd.ExecuteNonQuery();
             con.Close();
             utility.MessageBox(this, "Item deleted Succesfully");
             Bind();
            }

        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        Bind();
    }
    protected void txtquantity_TextChanged(object sender, EventArgs e)
    {
        //txtprice.Text = Convert.ToString(((double.Parse(txtpwt.Text)) * 100) / (100 + double.Parse(txttax.Text)));

        //txtperitem.Text = Convert.ToString(Math.Round(((double.Parse(txtpwt.Text)) * 100) / (100 + double.Parse(txttax.Text))));
        //txtamountwithquanity.Text = Convert.ToString((double.Parse(txtquantity.Text)) * (double.Parse(txtpwt.Text)));
        //txtprice.Text = Convert.ToString(Math.Round(((double.Parse(txtamountwithquanity.Text)) * 100) / (100 + double.Parse(txttax.Text)),2));
        //txtamount.Text = Convert.ToString(Math.Round((double.Parse(txtamountwithquanity.Text)) - (double.Parse(txtprice.Text)),2));

        txtamountwithquanity.Text = Convert.ToString((double.Parse(txtquantity.Text)) * (double.Parse(txtpwt.Text)));
        txtprice.Text = Convert.ToString(((double.Parse(txtamountwithquanity.Text)) * 100) / (100 + double.Parse(txttax.Text)));
        txtamount.Text = Convert.ToString((double.Parse(txtamountwithquanity.Text)) - (double.Parse(txtprice.Text)));

        txtperitem.Text = Convert.ToString(((double.Parse(txtpwt.Text)) * 100) / (100 + double.Parse(txttax.Text)));
       
    }
    protected void txtpwt_TextChanged(object sender, EventArgs e)
    {

        txtamountwithquanity.Text = Convert.ToString((double.Parse(txtquantity.Text)) * (double.Parse(txtpwt.Text)));
        txtprice.Text = Convert.ToString(((double.Parse(txtamountwithquanity.Text)) * 100) / (100 + double.Parse(txttax.Text)));
        txtamount.Text = Convert.ToString((double.Parse(txtamountwithquanity.Text)) - (double.Parse(txtprice.Text)));

        txtperitem.Text = Convert.ToString(((double.Parse(txtpwt.Text)) * 100) / (100 + double.Parse(txttax.Text)));
       
        //txtamountwithquanity.Text = Convert.ToString((double.Parse(txtquantity.Text)) * (double.Parse(txtpwt.Text)));
        //txtprice.Text = Convert.ToString(Math.Round(((double.Parse(txtamountwithquanity.Text)) * 100) / (100 + double.Parse(txttax.Text)), 2));
        //txtamount.Text = Convert.ToString(Math.Round((double.Parse(txtamountwithquanity.Text)) - (double.Parse(txtprice.Text)), 2));

    }
}
