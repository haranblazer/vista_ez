using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;

public partial class user_downstatus : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlDataAdapter da;
    DataTable dt = null;
    SqlCommand com;
    protected string cv, gcv;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
            utility.CheckSuperAdminLogin();
        else if (Convert.ToString(Session["admintype"]) == "a")
            utility.CheckAdminLogin();
        else
            Response.Redirect("logout.aspx");
         
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string UserId, string DOWNUP)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@Regno",UserId),
                new SqlParameter("@Type",DOWNUP),
            };

            SqlDataReader dr = objDu.GetDataReaderSP(sqlparam, "BianryTran_UpDownLine");
            // utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Appmstid = dr["Appmstid"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.MobileNo = dr["MobileNo"].ToString();
                data.ParentName = dr["ParentName"].ToString();
                data.ParentId = dr["ParentId"].ToString();
                data.Position = dr["Position"].ToString();
                data.TotalLeft = dr["TotalLeft"].ToString();
                data.TotalRight = dr["TotalRight"].ToString();
                data.NewLeft = dr["NewLeft"].ToString();
                data.NewRight = dr["NewRight"].ToString();
                data.Joinfor = dr["Joinfor"].ToString();
                data.Status = dr["Status"].ToString();
                data.IsPaid = dr["IsPaid"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {

        public string Appmstid { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string MobileNo { get; set; }
        public string ParentName { get; set; }
        public string ParentId { get; set; }

        public string Position { get; set; }
        public string TotalLeft { get; set; }
        public string TotalRight { get; set; }
        public string NewLeft { get; set; }
        public string NewRight { get; set; }
        public string Joinfor { get; set; }
        public string Status { get; set; }
        public string IsPaid { get; set; }




        [System.Web.Services.WebMethod]
        public static string GetExtremeUser(string Appmstid, string Position)
        {
            String Result = "";
            try
            {
                SqlParameter[] param1 = new SqlParameter[]
                {
               new SqlParameter("@Appmstid", Appmstid),
               new SqlParameter("@Position", Position)
                };
                DataUtility objDu = new DataUtility();
                DataTable dt = objDu.GetDataTable(param1, @"Select a.Appmstregno from Apptran t inner join Appmst a on t.Appmstid=a.Appmstid 
                where t.AppmstLeftRight= @Position and t.Parentid= @Appmstid and t.AppMstLevel = (Select max(AppMstLevel) from Apptran where AppmstLeftRight =@Position and Parentid = @Appmstid)");
                if (dt.Rows.Count > 0)
                    Result = dt.Rows[0]["Appmstregno"].ToString();

            }
            catch (Exception er) { Result = er.Message.ToString(); }
            return Result;
        }

    }


    #endregion


    //private void BindGrid()
    //{
    //    if (txtUserId.Text != "")
    //    {
    //        try
    //        {
    //            SqlParameter[] sqlparam = new SqlParameter[] {
    //                 new SqlParameter("@Regno",txtUserId.Text.Trim()),
    //                 new SqlParameter("@Type",ddlDOWNUP.SelectedValue.ToString())
    //            };
    //            DataUtility objDUT = new DataUtility();
    //            DataTable dt = objDUT.GetDataTableSP(sqlparam, "BianryTran_UpDownLine");
    //            if (dt.Rows.Count > 0)
    //            {
    //                lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
    //                GridView1.DataSource = dt;
    //                GridView1.DataBind();
    //            }
    //            else
    //            {
    //                lblTotal.Text = "";
    //                GridView1.DataSource = null;
    //                GridView1.DataBind();
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //        }
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Please enter User id.");
    //    }
    //}
    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    BindGrid();
    //}

    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //    try
    //    {
    //        String Result = "", Position = "2";
    //        string Appmstid = GridView1.DataKeys[row.RowIndex].Values[0].ToString();

    //        if (e.CommandName.Equals("ExtremeLeft"))
    //            Position = "0";
    //        else if (e.CommandName.Equals("ExtremeRight"))
    //            Position = "1";

    //        SqlParameter[] param1 = new SqlParameter[]
    //        {
    //                 new SqlParameter("@Appmstid", Appmstid),
    //                 new SqlParameter("@Position", Position)
    //        };
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTable(param1, @"Select a.Appmstregno from Apptran t inner join Appmst a on t.Appmstid=a.Appmstid 
    //            where t.AppmstLeftRight= @Position and t.Parentid= @Appmstid and t.AppMstLevel = (Select max(AppMstLevel) from Apptran where AppmstLeftRight =@Position and Parentid = @Appmstid)");
    //        if (dt.Rows.Count > 0)
    //            Result = dt.Rows[0]["Appmstregno"].ToString();


    //        string MSG = Position == "0" ? "Your Extreme Left " : "Your Extreme Right " + " User is: " + Result;

    //        utility.MessageBox(this, MSG);

    //    }
    //    catch (Exception ex)
    //    {
    //        utility.MessageBox(this, ex.ToString());
    //    }

    //}



    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindGrid();
    //}

    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}


    //protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        Response.Clear();
    //        Response.Buffer = true;
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_TopperDownUpList.xls");
    //        Response.Charset = "";
    //        Response.ContentType = "application/vnd.ms-excel";
    //        using (StringWriter sw = new StringWriter())
    //        {
    //            HtmlTextWriter hw = new HtmlTextWriter(sw);

    //            GridView1.AllowPaging = false;
    //            BindGrid();

    //            GridView1.HeaderRow.BackColor = System.Drawing.Color.White;
    //            foreach (TableCell cell in GridView1.HeaderRow.Cells)
    //            {
    //                cell.BackColor = GridView1.HeaderStyle.BackColor;
    //            }
    //            foreach (GridViewRow row in GridView1.Rows)
    //            {
    //                row.BackColor = System.Drawing.Color.White;
    //                foreach (TableCell cell in row.Cells)
    //                {
    //                    if (row.RowIndex % 2 == 0)
    //                    {
    //                        cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
    //                    }
    //                    else
    //                    {
    //                        cell.BackColor = GridView1.RowStyle.BackColor;
    //                    }
    //                    cell.CssClass = "textmode";


    //                    List<Control> controls = new List<Control>();

    //                    //Add controls to be removed to Generic List
    //                    foreach (Control control in cell.Controls)
    //                    {
    //                        controls.Add(control);
    //                    }

    //                    //Loop through the controls to be removed and replace with Literal
    //                    foreach (Control control in controls)
    //                    {
    //                        switch (control.GetType().Name)
    //                        {
    //                            case "HyperLink":
    //                                cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
    //                                break;
    //                            case "TextBox":
    //                                cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
    //                                break;
    //                            case "Label":
    //                                cell.Controls.Add(new Literal { Text = (control as Label).Text });
    //                                break;
    //                            case "LinkButton":
    //                                cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
    //                                break;
    //                        }
    //                        cell.Controls.Remove(control);
    //                    }
    //                }
    //            }

    //            GridView1.RenderControl(hw);
    //            //style to format numbers to string
    //            string style = @"<style> .textmode { } </style>";
    //            Response.Write(style);
    //            Response.Output.Write(sw.ToString());
    //            Response.Flush();
    //            Response.End();
    //        }
    //    }
    //    catch (Exception er) { }

    //}


    //protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    //{


    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        GridView1.Columns[12].Visible = false;
    //        //BindDataWithViewState();
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "AllotedPinList.doc");
    //        Response.Charset = "";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        GridView1.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Can't export as no data found.");
    //    }




    //}

}