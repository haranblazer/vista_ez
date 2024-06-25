using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient; 

public partial class secretadmin_UserTourlist : System.Web.UI.Page
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
            BindTour();

            // getList();
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string Userid, string Tid, string RankId)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {  
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@Userid", Userid),
                new SqlParameter("@Tid", Tid),
                new SqlParameter("@Pack_rep", "1"),
                new SqlParameter("@RankId", RankId),
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetUserTourList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Date = dr["Date"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.MobileNumber = dr["MobileNumber"].ToString();
                data.TopperPIN = dr["TopperPIN"].ToString();
                data.District = dr["District"].ToString();
                data.Satate = dr["Satate"].ToString();
                data.Matching = dr["Matching"].ToString();
                data.TourName = dr["TourName"].ToString(); 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Date { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string MobileNumber { get; set; }
        public string TopperPIN { get; set; }
        public string District { get; set; }
        public string Satate { get; set; }
        public string Matching { get; set; }
        public string TourName { get; set; }
    }


    public void BindTour()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Tid, TourName=TourName +' '+ Convert(nvarchar(10), StartDate, 103)+' To '+ Convert(nvarchar(10), ExpDate, 103)+' (REQD: '+Cast(Cast(Condition as int) as nvarchar(10))+') ' from Tourmst Where Pack_Rep=1");
        if (dt.Rows.Count > 0)
        {
            ddl_Tour.Items.Clear();
            ddl_Tour.DataSource = dt;
            ddl_Tour.DataTextField = "TourName";
            ddl_Tour.DataValueField = "Tid";
            ddl_Tour.DataBind();
            ddl_Tour.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
        else
        {
            ddl_Tour.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
    }


    public void BindRank()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Rankid=LevelId, RankName from BinarySlab order by LevelId");
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

    //    System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //    dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //    DateTime fromDate = new DateTime();
    //    DateTime toDate = new DateTime();
    //    try
    //    {
    //        fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
    //        toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
    //    }
    //    catch
    //    {
    //        utility.MessageBox(this, "Invalid Date!");
    //        return;
    //    }


    //    SqlParameter[] param = new SqlParameter[]
    //   {
    //       new SqlParameter("@Min", fromDate),
    //       new SqlParameter("@Max", toDate),
    //       new SqlParameter("@Userid",  txt_userid.Text.Trim()),
    //       new SqlParameter("@Tid", ddl_Tour.SelectedValue),
    //       new SqlParameter("@Pack_rep", "1"),
    //       new SqlParameter("@RankId", ddl_Rank.SelectedValue)
    //   };
    //    DataUtility objDu = new DataUtility();
    //    DataTable dt = objDu.GetDataTableSP(param, "GetUserTourList");
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
    //protected void ibtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dgList.Rows.Count > 0)
    //    {
    //        dgList.AllowPaging = false;
    //        getList();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_UserTourList.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        this.dgList.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");

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


}