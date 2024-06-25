using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
public partial class d2000admin_ProductDetail : System.Web.UI.Page
{
    string srno;
    SqlConnection con = new SqlConnection(method.str);
    utility objUtil = new utility();
    SqlCommand com;
    protected void Page_Load(object sender, EventArgs e)
    {
        srno = objUtil.base64Decode(Convert.ToString(Request.QueryString["pd"]));
        
        InsertFunction.CheckAdminlogin();
        if (!Page.IsPostBack)
        {
            getProductImage();
        }
    }
    public void getProductImage()
    {
        try
        {
            com = new SqlCommand("getProductImage", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@SrNo", srno);
            con.Open();
            SqlDataReader sdr = com.ExecuteReader();
            if (sdr.Read())
            {
                if (sdr["ImageName"].ToString() != "0")
                {
                    if (sdr["ImageName"].ToString() != "")
                    {
                        imgProduct.ImageUrl = "~/ProductImages/" + sdr["ImageName"].ToString();
                        lblProductName.Text = sdr["ProductName"].ToString();
                        lblMRP.Text = "Rs. " + sdr["MRP"].ToString() + " /-";
                        lblDP.Text = sdr["DPAmt"].ToString();
                        lblBV.Text = sdr["BVAmt"].ToString();
                        lblDescription.Text = sdr["Description"].ToString();

                    }
                    else
                    {
                        imgProduct.ImageUrl = "images/noImage.jpeg";                      
                        lblProductName.Text = sdr["ProductName"].ToString();
                        lblMRP.Text = "Rs. " + sdr["MRP"].ToString() + " /-";
                        lblDP.Text = sdr["DPAmt"].ToString();
                        lblBV.Text = sdr["BVAmt"].ToString();
                        lblDescription.Text = sdr["Description"].ToString();
                    }
                }
                else
                {
                    imgProduct.ImageUrl = "images/noImage.jpeg";                   
                    lblProductName.Text = sdr["ProductName"].ToString();
                    lblMRP.Text = "Rs. " + sdr["MRP"].ToString() + " /-";
                    lblDP.Text = sdr["DPAmt"].ToString();
                    lblBV.Text = sdr["BVAmt"].ToString();
                    lblDescription.Text = sdr["Description"].ToString();
                }
                ViewState["ProductName"] = sdr["ProductName"].ToString();
                ViewState["ImageName"] = sdr["ImageName"].ToString();
                con.Close();
            }
            else
            {
                con.Close();
                imgProduct.ImageUrl = "images/noImage.jpeg"; ;
            }
            con.Close();
        }
        catch { }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddEditProduct.aspx");
    }
}
