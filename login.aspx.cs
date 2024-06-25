using System;
using System.Data;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Text;
public partial class Login : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com = null;
    SqlDataReader dr = null;
    SqlDataAdapter sda;
    DataTable dt;
    Validation val = new Validation();
    StringBuilder sbnews = new StringBuilder();
    utility objUt = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["userId"] != null)
                Response.Cookies["userId"].Expires = DateTime.Now.AddDays(-1);

            checkpage();
            GetNews();
            Session["userId"] = null;
            Session["MemberId"] = null;
            Session["franchiseid"] = null;
            string value1 = HttpContext.Current.Request.Url.AbsoluteUri.Split('?').Last();

            if (Session["RootCart"] == null)
            {
                btn_preferredcust.Visible = false;
            }
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        chkUser();
    }
    protected void btn_preferredcust_Click(object sender, EventArgs e)
    {
        HttpContext.Current.Session["UserType"] = "1";
        Response.Redirect("Cart", false);
    }
    public void chkUser()
    {
        try
        {
            string ss = objUt.base64Encode(txtPassword.Text.Trim());
            if (!string.IsNullOrEmpty(txtUserName.Text.ToString()) && val.IsAlphaNumeric(txtUserName.Text.ToString()))
            {
                if (!string.IsNullOrEmpty(txtPassword.Text.ToString()))
                {
                    com = new SqlCommand("chkreg", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@userid", txtUserName.Text.Trim());
                    com.Parameters.AddWithValue("@pwd", txtPassword.Text.Trim());
                    com.Parameters.AddWithValue("@frantype", ddltype.SelectedValue);
                    con.Open();
                    dr = com.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        // utility objUt = new utility();
                        if (dr["appmstactivate"].ToString() == "1")
                        {

                            if (txtPassword.Text.Trim() == objUt.base64Decode(dr["PWD"].ToString()) && dr["value"].ToString() == "1")
                            {
                                Session["IsCustomer"] = dr["IsCustomer"].ToString();
                                Session["OldAmt"] = dr["jamount"].ToString();

                                if (dr["IsCustomer"].ToString() == "True")
                                {
                                    Session["MemberId"] = dr["AppMstRegNo"].ToString();
                                    if (Request.QueryString.Count > 0)
                                    {
                                        if (Request.QueryString["wl"] != "")
                                            Response.Redirect("products", false);
                                    }
                                    else
                                    {
                                        if (Session["RootCart"] != null)
                                            Response.Redirect("Cart", false);
                                        else
                                            Response.Redirect("member/welcome.aspx", false);
                                    }
                                }
                                else
                                {
                                    Session["userId"] = dr["AppMstRegNo"].ToString();
                                    if (Request.QueryString.Count > 0)
                                    {
                                        if (Request.QueryString["wl"] != "")
                                            Response.Redirect("products", false);
                                    }
                                    else
                                    {
                                        if (Session["RootCart"] != null)
                                        {
                                            HttpContext.Current.Session["UserType"] = "0";
                                            Update_Distributor_Cart();
                                            Response.Redirect("Cart", false);
                                        }
                                        else
                                            Response.Redirect("user/Dashboard.aspx", false);
                                    }
                                }

                            }

                            else if (txtPassword.Text.Trim() == objUt.base64Decode(dr["PWD"].ToString()) && dr["value"].ToString() == "2")
                            {
                                Session["franchiseid"] = dr["FranchiseId"].ToString().Trim();
                                Session["name"] = dr["FName"].ToString().Trim();
                                Session["frantype"] = "0";
                                Session["LogId"] = dr["FranchiseId"].ToString().Trim();
                                Response.Redirect("franchise/Welcome.aspx", false);
                            }
                            else
                            {
                                utility.MessageBox(this, "Invalid UserId or Password!");
                            }


                        }
                        else if (dr["appmstactivate"].ToString() == "0")
                        {
                            utility.MessageBox(this, "Your Id is Inactive. Please Contact to Administrator.!!");
                        }
                        else if (dr["appmstactivate"].ToString() == "2")
                        {
                            utility.MessageBox(this, "Your ID is Blocked. Please Contact to Administrator.!!");
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, "Invalid UserId or Password!");
                        con.Close();
                        con.Dispose();
                    }
                }
                else
                {
                    utility.MessageBox(this, "The password is required.");
                    txtPassword.Focus();
                    return;
                }
            }
            else
            {
                utility.MessageBox(this, "The user name is required and contains alphanumeric value.");
                txtUserName.Focus();
                return;
            }
        }
        catch (Exception ex)
        {
            string eee = ex.ToString();
            utility.MessageBox(this, "Id No or Password Mismatch!");
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }


    public void checkpage()
    {
        com = new SqlCommand("pageprocess", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@action", "1");
        con.Open();
        dr = com.ExecuteReader();
        while (dr.Read())
        {
            if (dr["logins"].ToString() == "OFF")
            {

                Response.Redirect("~/error.aspx", false);
            }
        }
        dr.Close();
    }



    protected void Logout()
    {
        Session.Abandon();
    }

    private void GetNews()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetNews", con);
            com.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(com);
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    sbnews.Append(dt.Rows[i]["photo"].ToString() + "<br/>" + dt.Rows[i]["NewsMstDiscription"].ToString() + "<br>" + "<br>");
                }
                divnews.InnerHtml = sbnews.ToString();
            }
        }
        catch
        {
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }


    private static void Update_Distributor_Cart()
    {
        if (HttpContext.Current.Session["RootCart"] != null)
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
            if (Cartdt.Rows.Count > 0)
            {
                foreach (DataRow dr in Cartdt.Rows)
                {
                    DataRow findrow = Cartdt.Select("batchid='" + dr["batchid"].ToString() + "'").FirstOrDefault();

                    int Qty = findrow == null ? 0 : findrow.Field<int>("qty");
                    double tax = findrow == null ? 0 : findrow.Field<double>("tax");

                    double BV = findrow == null ? 0 : findrow.Field<double>("BVAmt");
                    double Discount = findrow == null ? 0 : findrow.Field<double>("Discount");

                    string DiscounType = findrow == null ? "%" : findrow.Field<string>("DiscounType");
                    double Weight = findrow == null ? 0 : findrow.Field<double>("Weight");
                    double GSTAMT = 0, Gross = 0;

                    DataUtility objDu = new DataUtility();
                    SqlParameter[] param1 = new SqlParameter[]
                    {  new SqlParameter("@Batchid", dr["batchid"].ToString()) };
                    DataTable dt = objDu.GetDataTable(param1, "Select MRP, DPAmt, DPWithTax, Disc_Perc_Val=isnull(Disc_Perc_Val,0) from batchmst where Batchid=@Batchid");

                    double MRP = Math.Round(Convert.ToDouble(dt.Rows[0]["MRP"].ToString()), 2);
                    double DPWithTax = Math.Round(Convert.ToDouble(dt.Rows[0]["DPWithTax"].ToString()), 2);
                    double DPAmt = Math.Round(Convert.ToDouble(dt.Rows[0]["DPAmt"].ToString()), 2);
                    double Disc_Perc_Val = Math.Round(Convert.ToDouble(dt.Rows[0]["Disc_Perc_Val"].ToString()), 2);
                    findrow["MRP"] = MRP;
                    findrow["DPWithTax"] = DPWithTax;
                    findrow["DPAmt"] = DPAmt;

                    if (DiscounType == "%")
                    {
                        Gross = (DPAmt * Qty);
                        Discount = (MRP * Disc_Perc_Val / 100) * Qty;


                        GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 2, MidpointRounding.ToEven);
                        GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 2, MidpointRounding.ToEven);

                        findrow["GSTAMT"] = Math.Round(GSTAMT / Qty, 2);
                        findrow["TaxableAmt"] = Math.Round(Gross, 2);
                        findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                        findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                    }
                    else
                    {
                        Gross = (DPAmt * Qty);

                        GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 2, MidpointRounding.ToEven);
                        GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 2, MidpointRounding.ToEven);
                        findrow["GSTAMT"] = Math.Round(GSTAMT * Qty, 2);
                        findrow["TaxableAmt"] = Math.Round(Gross, 2);
                        findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                        findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                    } 
                    findrow["Disc_Perc_Val"] = Math.Round(Disc_Perc_Val, 2);
                    findrow["Gross"] = Math.Round(Gross, 2);
                    findrow["Discount"] = Math.Round(Discount, 2);
                    findrow["TotalWeight"] = (Weight * Qty);
                    findrow["totalbvamt"] = Qty * BV;

                    HttpContext.Current.Session["RootCart"] = Cartdt;
                }
            }
        }
    }




}