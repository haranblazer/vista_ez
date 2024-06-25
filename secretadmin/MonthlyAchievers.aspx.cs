﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
public partial class secretadmin_MonthlyAchievers : System.Web.UI.Page
{
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
            txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");

            BindRank();
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string SearchType, string Userid, string RankId)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
               new SqlParameter("@SearchType", SearchType),
               new SqlParameter("@MinDate", min),
               new SqlParameter("@MaxDate", max),
               new SqlParameter("@Userid",  Userid),
               new SqlParameter("@RankId", RankId)
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetMonthlyAchievers");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.BackGroundImg = dr["BackGroundImg"].ToString();
                data.id = dr["id"].ToString();
                data.Date = dr["Date"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.Rank = dr["Rank"].ToString();
                data.MobileNo = dr["MobileNo"].ToString();

                data.District = dr["District"].ToString();
                data.State = dr["State"].ToString();
                data.AchievementType = dr["AchievementType"].ToString();
                data.Achievement = dr["Achievement"].ToString();
                data.PaidDate = dr["PaidDate"].ToString();
                data.AchivementDays = dr["AchivementDays"].ToString();
                data.imagename = dr["imagename"].ToString();
                data.Month = dr["Month"].ToString();
                 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string BackGroundImg { get; set; }
        public string id { get; set; }
        public string Date { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string Rank { get; set; }
        public string MobileNo { get; set; }
        public string District { get; set; }
        public string State { get; set; }
        public string AchievementType { get; set; }
        public string Achievement { get; set; }
        public string PaidDate { get; set; }
        public string AchivementDays { get; set; }
        public string imagename { get; set; }
        public string Month { get; set; }
        
    }


    public void BindRank()
    {
        string Qry = "";
        DataUtility objDu = new DataUtility();
        if (ddl_SearchType.SelectedValue == "TOPPER")
            Qry = "Select Rankid=LevelId, RankName from BinarySlab order by LevelId";
        if (ddl_SearchType.SelectedValue == "GENERATION")
            Qry = "Select Rankid, RankName from RePurchase_Slab order by Rankid";

        DataTable dt = objDu.GetDataTable(Qry);
        if (dt.Rows.Count > 0)
        {
            ddl_Rank.Items.Clear();
            ddl_Rank.DataSource = dt;
            ddl_Rank.DataTextField = "RankName";
            ddl_Rank.DataValueField = "Rankid";
            ddl_Rank.DataBind();
            ddl_Rank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
        else
        {
            ddl_Rank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
    }

    #endregion



    //public void getList()
    //{

    //    String fromDate = "", toDate = "";
    //    try
    //    {
    //        if (txtFromDate.Text.Trim().Length > 0)
    //        {
    //            String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //            fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //        }
    //        if (txtToDate.Text.Trim().Length > 0)
    //        {
    //            String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //            toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //        }
    //    }
    //    catch
    //    {
    //        utility.MessageBox(this, "Invalid date entry2.");
    //        return;
    //    }

    //    SqlParameter[] param = new SqlParameter[]
    //    {
    //       new SqlParameter("@SearchType", ddl_SearchType.SelectedValue),
    //       new SqlParameter("@MinDate", fromDate),
    //       new SqlParameter("@MaxDate", toDate),
    //       new SqlParameter("@Userid",  txt_userid.Text.Trim()),
    //       new SqlParameter("@RankId", ddl_Rank.SelectedValue)
    //    };
    //    DataUtility objDu = new DataUtility();
    //    DataTable dt = objDu.GetDataTableSP(param, "GetMonthlyAchievers");
    //    if (dt.Rows.Count > 0)
    //    {
    //        dgList.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
    //        dgList.Columns[0].FooterText = "Count :" + dt.Rows.Count.ToString();

    //        dgList.DataSource = dt;
    //        dgList.DataBind();
    //    }
    //    else
    //    {

    //        dgList.DataSource = null;
    //        dgList.DataBind();

    //    }
    //}




    //protected void ibtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        if (dgList.Rows.Count > 0)
    //        {
    //            Response.Clear();
    //            Response.Buffer = true;
    //            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_UserTourList.xls");
    //            Response.Charset = "";
    //            Response.ContentType = "application/vnd.ms-excel";
    //            using (StringWriter sw = new StringWriter())
    //            {
    //                HtmlTextWriter hw = new HtmlTextWriter(sw);

    //                dgList.AllowPaging = false;
    //                getList();
    //                //GridView1.Columns[30].Visible = false;
    //                dgList.HeaderRow.BackColor = System.Drawing.Color.White;
    //                foreach (TableCell cell in dgList.HeaderRow.Cells)
    //                {
    //                    cell.BackColor = dgList.HeaderStyle.BackColor;
    //                }
    //                foreach (GridViewRow row in dgList.Rows)
    //                {
    //                    row.BackColor = System.Drawing.Color.White;
    //                    foreach (TableCell cell in row.Cells)
    //                    {
    //                        if (row.RowIndex % 2 == 0)
    //                        {
    //                            cell.BackColor = dgList.AlternatingRowStyle.BackColor;
    //                        }
    //                        else
    //                        {
    //                            cell.BackColor = dgList.RowStyle.BackColor;
    //                        }
    //                        cell.CssClass = "textmode";


    //                        List<Control> controls = new List<Control>();

    //                        //Add controls to be removed to Generic List
    //                        foreach (Control control in cell.Controls)
    //                        {
    //                            controls.Add(control);
    //                        }

    //                        //Loop through the controls to be removed and replace with Literal
    //                        foreach (Control control in controls)
    //                        {
    //                            switch (control.GetType().Name)
    //                            {
    //                                case "HyperLink":
    //                                    cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
    //                                    break;
    //                                case "TextBox":
    //                                    cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
    //                                    break;
    //                                case "Label":
    //                                    cell.Controls.Add(new Literal { Text = (control as Label).Text });
    //                                    break;
    //                                case "LinkButton":
    //                                    cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
    //                                    break;
    //                            }
    //                            cell.Controls.Remove(control);
    //                        }
    //                    }
    //                }

    //                dgList.RenderControl(hw);
    //                //style to format numbers to string
    //                string style = @"<style> .textmode { } </style>";
    //                Response.Write(style);
    //                Response.Output.Write(sw.ToString());
    //                Response.Flush();
    //                Response.End();
    //            }
    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "Can't export as no data found.");
    //        }
    //    }
    //    catch (Exception er) { }

    //}

    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}

    //protected void btnSearchByDate_Click(object sender, EventArgs e)
    //{
    //    getList();
    //}
    //protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    getList();

    //}

    //protected void dgList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    dgList.PageIndex = e.NewPageIndex;
    //    getList();
    //}

    //protected void ddl_SearchType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    BindRank();
    //}
}