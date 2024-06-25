using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Data;

public partial class secretadmin_CalculateBinaryDirect : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter sda;
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
            ViewState["Tpair"] = "0";
            getLastPayoutDate();
            txtFromDate.Text = DateTime.Now.AddDays(-6).Date.ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            
        }

    }
    public void getLastPayoutDate()
    {
        sda = new SqlDataAdapter("select convert(varchar(20),paytodate,103) as pdate,convert(varchar(20),dateadd(day,1,paytodate),103)  fromdate from rDate where payoutno=(select max(payoutno) from rDate )", con);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            lblLastPayoutDate.Text = "Last payout was generated on : " + dt.Rows[0]["pdate"].ToString();
            txtFromDate.Text = dt.Rows[0]["pdate"].ToString();
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        if (Regex.Match(txtFromDate.Text + txtFromDate.Text, @"^[0-9/]*$").Success)
        {
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
            if (fromDate <= toDate)
            {
                try
                {
                    com = new SqlCommand("CalculateBinaryDirect", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@min", fromDate);
                    com.Parameters.AddWithValue("@max", toDate);
                    com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    if (com.Parameters["@flag"].Value.ToString() == "1")
                    {
                        con.Close();
                        go();
                        utility.MessageBox(this, "Income Calculated successfully.");
                    }
                    else
                    {
                        con.Close();
                        utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
                    }
                }
                catch
                {
                }
            }
            else
            {
                utility.MessageBox(this, "Wrong date!");
            }
        }
        else
        {
            utility.MessageBox(this, "Invalid date !");
        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        go();
    }



    protected void btn_updateBinaryInc_Click(object sender, EventArgs e)
    {
        //if (!Regex.Match(txt_Binary1.Text.Trim(), @"^[0-9]*$").Success && !Regex.Match(txt_Binary2.Text.Trim(), @"^[0-9]*$").Success && !Regex.Match(txt_Binary3.Text.Trim(), @"^[0-9]*$").Success && !Regex.Match(txt_Binary4.Text.Trim(), @"^[0-9]*$").Success && !Regex.Match(txt_Binary5.Text.Trim(), @"^[0-9]*$").Success)
        //{
        //    utility.MessageBox(this, "Invalid Amount !");
        //    return;
        //}

        if (Regex.Match(txtFromDate.Text + txtFromDate.Text, @"^[0-9/]*$").Success)
        {
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
            if (fromDate <= toDate)
            {
                try
                {
                    com = new SqlCommand("UpdateBinaryInc", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@min", fromDate);
                    com.Parameters.AddWithValue("@max", toDate);
                    com.Parameters.AddWithValue("@BinaryInc1", txt_PTR1.Text.Trim());
                    com.Parameters.AddWithValue("@BinaryInc2", txt_PTR2.Text.Trim());
                    com.Parameters.AddWithValue("@BinaryInc3", txt_PTR3.Text.Trim());
                    com.Parameters.AddWithValue("@BinaryInc4", txt_PTR4.Text.Trim());
                    com.Parameters.AddWithValue("@BinaryInc5", txt_PTR5.Text.Trim());
                    com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    if (com.Parameters["@flag"].Value.ToString() == "1")
                    {
                        con.Close();
                        go();
                    }
                    else
                    {
                        con.Close();
                        utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
                    }
                }
                catch
                {
                }
            }
            else
            {
                utility.MessageBox(this, "Wrong date!");
            }
        }
        else
        {
            utility.MessageBox(this, "Invalid date !");
        }
    }

    public void go()
    {
        if (Regex.Match(txtFromDate.Text + txtFromDate.Text, @"^[0-9/]*$").Success)
        {
            try
            {
                tbl_binary.Visible = false;
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
                if (fromDate <= toDate)
                {
                    com = new SqlCommand("GetBinaryCause", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@min", fromDate);
                    com.Parameters.AddWithValue("@max", toDate);
                    con.Open();
                    sdr = com.ExecuteReader();
                    double Amount = 0, Percent = 0;
                    if (sdr.HasRows)
                    {
                        tbl_binary.Visible = true;
                        while (sdr.Read())
                        {
                            Amount += Convert.ToDouble(sdr["Amount"].ToString());
                            Percent += Convert.ToDouble(sdr["Per"].ToString());

                            lbl_Per.Text = Percent.ToString() + "%";
                            lbl_Amt.Text = Amount.ToString() + ".00";


                            lblBV1.Text = lblBV2.Text = lblBV3.Text = lblBV4.Text = lblBV5.Text = sdr["BV"].ToString();
                            if (sdr["PayCause"].ToString() == "b1")
                            {
                                lbl1.InnerText = "Binary " + sdr["Condition"].ToString();
                                txt_Binary1.Text = sdr["Amount"].ToString();
                                lbl_B1.Text = sdr["Per"].ToString() + "%";
                                txt_PTR1.Text = sdr["PointRate"].ToString();
                                lbl_CC1.Text = sdr["Ceiling_Capping"].ToString();
                            }
                            else if (sdr["PayCause"].ToString() == "b2")
                            {
                                lbl2.InnerText = "Binary " + sdr["Condition"].ToString();
                                txt_Binary2.Text = sdr["Amount"].ToString();
                                lbl_B2.Text = sdr["Per"].ToString() + "%";
                                txt_PTR2.Text = sdr["PointRate"].ToString();
                                lbl_CC2.Text = sdr["Ceiling_Capping"].ToString();
                            }
                            else if (sdr["PayCause"].ToString() == "b3")
                            {
                                lbl3.InnerText = "Binary " + sdr["Condition"].ToString();
                                txt_Binary3.Text = sdr["Amount"].ToString();
                                lbl_B3.Text = sdr["Per"].ToString() + "%";
                                txt_PTR3.Text = sdr["PointRate"].ToString();
                                lbl_CC3.Text = sdr["Ceiling_Capping"].ToString();
                            }
                            else if (sdr["PayCause"].ToString() == "b4")
                            {
                                lbl4.InnerText = "Binary " + sdr["Condition"].ToString();
                                txt_Binary4.Text = sdr["Amount"].ToString();
                                lbl_B4.Text = sdr["Per"].ToString() + "%";
                                txt_PTR4.Text = sdr["PointRate"].ToString();
                                lbl_CC4.Text = sdr["Ceiling_Capping"].ToString();
                            }
                            else if (sdr["PayCause"].ToString() == "b5")
                            {
                                lbl5.InnerText = "Binary " + sdr["Condition"].ToString();
                                txt_Binary5.Text = sdr["Amount"].ToString();
                                lbl_B5.Text = sdr["Per"].ToString() + "%";
                                txt_PTR5.Text = sdr["PointRate"].ToString();
                                lbl_CC5.Text = sdr["Ceiling_Capping"].ToString();
                            }
                        }
                    }
                }
                else
                {
                    utility.MessageBox(this, "Wrong date !");
                }
            }
            catch
            {
            }
        }
        else
        {
            utility.MessageBox(this, "Invalid Date !");
        }
    }



}
