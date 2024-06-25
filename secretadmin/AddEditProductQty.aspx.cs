using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Xml.Linq;
using System.Xml;
using System.Text;
using System.Text.RegularExpressions;
using System.Globalization;
public partial class secretadmin_AddEditProductQty : System.Web.UI.Page
{
    SqlConnection con = null;
    utility ObjUtil = null;
    SqlCommand cmd = null;
    SqlDataAdapter sda = null;
    DataTable dt = null;
    SqlDataReader sdr;
    int productid = 0;
    int qnty;
    int stockqty=0;
    string status;
    int checkqty;
    string Productname = "";
    string msg = "";
    protected void Page_Load(object sender, EventArgs e)
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
        if (!IsPostBack)
        {
            gridbind();
        }
    }


    public void gridbind()
    {


        con = new SqlConnection(method.str);
        cmd = new SqlCommand("UpdateProductQty", con);
        cmd.Parameters.AddWithValue("@action","show"); 
        cmd.Parameters.AddWithValue("@productid", 0);
        cmd.Parameters.AddWithValue("@qty", 0);
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        GridView1.DataSource = cmd.ExecuteReader();
        GridView1.DataBind();
        con.Close();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {


          
                foreach (GridViewRow row in GridView1.Rows)
                {

                    productid = Convert.ToInt32(((Label)row.FindControl("lblproductid")).Text);
                    stockqty = Convert.ToInt32(((Label)row.FindControl("lblquantity")).Text);

                    Productname = ((Label)row.FindControl("lblproductname")).Text;
                    ViewState["productid"] = productid;
                    ViewState["stockqty"] = stockqty;
                    TextBox txtquantity = (TextBox)row.FindControl("txtquantity");

                    TextBox txtbatchno = (TextBox)row.FindControl("txtbatchno");

                    TextBox txtdoe = (TextBox)row.FindControl("txtdate");

                    ViewState["quantity"] = txtquantity.Text;

                    if ((Convert.ToInt32(txtquantity.Text) > 0) || (Convert.ToInt32(txtquantity.Text) < 0))
                    {
                        ViewState["checkqty"] = Convert.ToString(Convert.ToInt32(stockqty) + Convert.ToInt32(txtquantity.Text));

                        if (checkquantity() == false)
                        {

                            utility.MessageBox(this, "Please Enter Correct Quantity For " + Productname);
                            return;
                        }


                        con = new SqlConnection(method.str);
                        cmd = new SqlCommand("UpdateProductQty", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@action", "insert");
                        cmd.Parameters.AddWithValue("@productid", productid);
                        cmd.Parameters.AddWithValue("@mfgdoe", txtdoe.Text.Trim());
                        cmd.Parameters.AddWithValue("@batchno", txtbatchno.Text.Trim());

                        cmd.Parameters.AddWithValue("@qty", Convert.ToInt32(txtquantity.Text));
                        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        msg = cmd.Parameters["@flag"].Value.ToString();
                        if (msg == "1")
                        {
                            ViewState["checkvalue"] = "1";

                        }
                        con.Close();

                    }

                }

            }

        

        catch
        {

        }


        finally
        {
           
            utility.MessageBox(this, "Stock Updated Successfully");
            gridbind();
        }
          
           
        
                
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                try
                {
                    string pid = GridView1.DataKeys[e.Row.RowIndex].Values[0].ToString();
                    //string fid = GridView1.DataKeys[e.Row.RowIndex].Values[1].ToString();
                    TextBox ddlCountries = (e.Row.FindControl("txtquantity") as TextBox);
                    RangeValidator rv = (e.Row.FindControl("rg1") as RangeValidator);



                    con = new SqlConnection(method.str);
                    cmd = new SqlCommand("UpdateProductQty", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@action", "productqty");
                    cmd.Parameters.AddWithValue("@productid", pid);
                    cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    con.Open();
                    sdr = cmd.ExecuteReader();
                    while (sdr.Read())
                    {

                        rv.MinimumValue = sdr["minimumqty"].ToString();
                        rv.MaximumValue = sdr["qty"].ToString();
                        rv.Type = ValidationDataType.Integer;
                        rv.ToolTip = "Enter Quantiy between " + sdr["minimumqty"].ToString() + " To " + Convert.ToString(sdr["qty"].ToString());
                        rv.ErrorMessage = "Enter Quantiy between "+ sdr["minimumqty"].ToString() +" To "+ Convert.ToString(sdr["qty"].ToString());
                    }

                }

                catch (Exception ex)
                {
                    utility.MessageBox(this, ex.ToString());
                }

                finally
                {
                    sdr.Close();
                    con.Close();
                }

            }
        }
    }


    public Boolean checkquantity()
    {
       
        
        if ((Convert.ToInt32(ViewState["quantity"].ToString()) < 0) && (Convert.ToInt32(ViewState["checkqty"].ToString())<0))
        {      
                return false;           
        }
        

        

        return true;
    }
}