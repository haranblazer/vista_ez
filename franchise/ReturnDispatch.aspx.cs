using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

public partial class franchise_ReturnDispatch : System.Web.UI.Page
{
    static string srno = "0";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");

        if (!IsPostBack)
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
            try
            {
                BindDispatchStatus();
                BindTransporter();
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["id"] != "")
                    {
                        utility obj = new utility();
                        srno = obj.base64Decode(Request.QueryString["id"].ToString());
                        BindDetail(srno);
                    }
                }
            }
            catch (Exception er) { }
        }
    }
    private void BindDetail(string srno)
    {
        lbl_msg.Text = "";
        SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@Srno", srno), new SqlParameter("@SalesRepId", Session["franchiseid"].ToString()) };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param1, "GetDispatchReturnData");

        if (dt.Rows.Count > 0)
        {
            lbl_InvoiceNo.Text = dt.Rows[0]["InvoiceNo"].ToString();
            lbl_InvoiceAmount.Text = dt.Rows[0]["Amount"].ToString();

            lbl_Date.Text = dt.Rows[0]["Date"].ToString();
            lbl_Month.Text = dt.Rows[0]["Month"].ToString();
            lbl_Depo.Text = dt.Rows[0]["SalesRepId"].ToString();
           // lbl_PODate.Text = dt.Rows[0]["PODate"].ToString();
            //lbl_PONo.Text = dt.Rows[0]["PONumber"].ToString();
            lbl_CustId.Text = dt.Rows[0]["CustID"].ToString();
            lbl_CustName.Text = dt.Rows[0]["NameofParty"].ToString();
            lbl_Location.Text = dt.Rows[0]["Location"].ToString();
            lbl_State.Text = dt.Rows[0]["State"].ToString();


            ddl_DispatchStatus.SelectedValue = dt.Rows[0]["DeliveryStatus"].ToString();
            txt_DispatchDate.Text = dt.Rows[0]["DispatchDate"].ToString();
            txt_DocketNo.Text = dt.Rows[0]["Tracking"].ToString();
            ddl_Transporter.SelectedValue = dt.Rows[0]["Transport"].ToString();
            txt_Deliverydate.Text = dt.Rows[0]["DeliveryDate"].ToString();

            txt_Durationdays.Text = dt.Rows[0]["DurationDays"].ToString();
            txt_Remarks.Text = dt.Rows[0]["DeliveryRemark"].ToString();
            txt_EwayNo.Text = dt.Rows[0]["EwayNo"].ToString();
            txt_ApprovedBy.Text = dt.Rows[0]["ApprovedBy"].ToString();



            txt_Boxes.Text = dt.Rows[0]["Boxes"].ToString();
            txt_Freight.Text = dt.Rows[0]["Freight"].ToString();
            txt_Weight.Text = dt.Rows[0]["WeightKG"].ToString();

            txt_FuelCharges.Text = dt.Rows[0]["FuelCharges"].ToString();
            txt_FOVChages.Text = dt.Rows[0]["FOVChages"].ToString();
            txt_DocketCharges.Text = dt.Rows[0]["DocketCharges"].ToString();
            txt_HandlingCharges.Text = dt.Rows[0]["HandlingCharges"].ToString();

            txt_ODA.Text = dt.Rows[0]["ODA"].ToString();
            txt_OtherChages.Text = dt.Rows[0]["OtherChages"].ToString();
            txt_TotalExpenses.Text = dt.Rows[0]["TotalExpenses"].ToString();
            txt_TallyDate.Text = dt.Rows[0]["TallyDate"].ToString();

            txt_TallyInvoice.Text = dt.Rows[0]["TallyInvoice"].ToString();
            txt_TallyAmount.Text = dt.Rows[0]["TallyAmount"].ToString();

            BindMode(dt.Rows[0]["Transport"].ToString());
            ddl_Mode.SelectedValue = dt.Rows[0]["TransportMode"].ToString();


            dvPreview.InnerHtml = @"<img src='../images/Slip/" + dt.Rows[0]["DispatchFileName"].ToString() + "' style='height:112px; width:105px' />";

            // hnd_img.Value = "~/images/Slip/" + dt.Rows[0]["DispatchFileName"].ToString();

        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lbl_msg.Text = "";
        try
        {
            string DispatchFileName = "noimage.png";
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();

                if (fuUpload.HasFile)
                {
                    DispatchFileName = Path.GetFileName(Guid.NewGuid().ToString() + fuUpload.PostedFile.FileName);
                }


                string DispatchDate = "01/01/1900", Deliverydate = "01/01/1900", TallyDate = "01/01/1900";
                try
                {
                    if (txt_DispatchDate.Text.Length > 0)
                    {
                        String[] Date = txt_DispatchDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                        DispatchDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                    }
                    if (txt_Deliverydate.Text.Length > 0)
                    {
                        String[] Date = txt_Deliverydate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                        Deliverydate = Date[1] + "/" + Date[0] + "/" + Date[2];
                    }
                    if (txt_TallyDate.Text.Length > 0)
                    {
                        String[] Date = txt_TallyDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                        TallyDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                    }
                }
                catch (Exception er) { }


                double Freight = Convert.ToDouble(txt_Freight.Text.Trim() == "" ? "0" : txt_Freight.Text.Trim());
                double FuelCharges = Convert.ToDouble(txt_FuelCharges.Text.Trim() == "" ? "0" : txt_FuelCharges.Text.Trim());
                double FOVChages = Convert.ToDouble(txt_FOVChages.Text.Trim() == "" ? "0" : txt_FOVChages.Text.Trim());
                double DocketCharges = Convert.ToDouble(txt_DocketCharges.Text.Trim() == "" ? "0" : txt_DocketCharges.Text.Trim());
                double HandlingCharges = Convert.ToDouble(txt_HandlingCharges.Text.Trim() == "" ? "0" : txt_HandlingCharges.Text.Trim());
                double ODA = Convert.ToDouble(txt_ODA.Text.Trim() == "" ? "0" : txt_ODA.Text.Trim());
                double OtherChages = Convert.ToDouble(txt_OtherChages.Text.Trim() == "" ? "0" : txt_OtherChages.Text.Trim());
                double TotalExpenses = (Freight + FuelCharges + FOVChages + DocketCharges + HandlingCharges + ODA + OtherChages);

                utility obj = new utility();
                srno = obj.base64Decode(Request.QueryString["id"].ToString());

                SqlParameter[] param = new SqlParameter[]
                {
                    new SqlParameter("@Srno", srno),
                    new SqlParameter("@SalesRepId", Session["franchiseid"].ToString()),
                    new SqlParameter("@DeliveryStatus", ddl_DispatchStatus.SelectedValue),
                    new SqlParameter("@DispatchDate", DispatchDate),
                    new SqlParameter("@DocketNo", txt_DocketNo.Text),
                    new SqlParameter("@Transport", ddl_Transporter.SelectedValue),
                    new SqlParameter("@Deliverydate", Deliverydate),
                    new SqlParameter("@Durationdays", txt_Durationdays.Text),
                    new SqlParameter("@Remarks", txt_Remarks.Text),
                    new SqlParameter("@EwayNo", txt_EwayNo.Text),
                    new SqlParameter("@ApprovedBy", txt_ApprovedBy.Text),
                    new SqlParameter("@TransportMode", ddl_Mode.SelectedValue),
                    new SqlParameter("@Boxes", txt_Boxes.Text),
                    new SqlParameter("@WeightKG", txt_Weight.Text),

                    new SqlParameter("@Freight", txt_Freight.Text.Trim() == "" ? "0" : txt_Freight.Text.Trim()),
                    new SqlParameter("@FuelCharges", txt_FuelCharges.Text.Trim() == "" ? "0" : txt_FuelCharges.Text.Trim()),
                    new SqlParameter("@FOVChages", txt_FOVChages.Text.Trim() == "" ? "0" : txt_FOVChages.Text.Trim()),
                    new SqlParameter("@DocketCharges", txt_DocketCharges.Text.Trim() == "" ? "0" : txt_DocketCharges.Text.Trim()),
                    new SqlParameter("@HandlingCharges", txt_HandlingCharges.Text.Trim() == "" ? "0" : txt_HandlingCharges.Text.Trim()),
                    new SqlParameter("@ODA", txt_ODA.Text.Trim() == "" ? "0" : txt_ODA.Text.Trim()),
                    new SqlParameter("@OtherChages", txt_OtherChages.Text.Trim() == "" ? "0" : txt_OtherChages.Text.Trim()),
                    new SqlParameter("@TotalExpenses", TotalExpenses),

                    new SqlParameter("@TallyDate", TallyDate),
                    new SqlParameter("@TallyInvoice", txt_TallyInvoice.Text),
                    new SqlParameter("@TallyAmount", txt_TallyAmount.Text.Trim() == "" ? "0" : txt_TallyAmount.Text.Trim()),
                    new SqlParameter("@DispatchFileName", DispatchFileName),
                };

                DataUtility objDu = new DataUtility();
                DataTable dt = objDu.GetDataTableSP(param, "Update_Return_Dispatch");
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["Error"].ToString() == "0")
                    {
                        if (fuUpload.HasFile)
                        {
                            fuUpload.PostedFile.SaveAs(Server.MapPath("~/images/Slip/" + DispatchFileName));
                        }

                        utility.MessageBox(this, "Dispatch details save successfully.!!");

                        BindDetail(srno);
                        lbl_msg.Text = "Dispatch details save successfully.!!";
                        lbl_msg.ForeColor = System.Drawing.Color.Green;
                    }
                }
                else
                {
                    lbl_msg.Text = dt.Rows[0]["Error"].ToString();
                    lbl_msg.ForeColor = System.Drawing.Color.Red;
                }

            }
            else
            {
                utility.MessageBox(this, "Don't refresh this page.!!");
                return;
            }
        }
        catch (Exception er)
        {
            utility.MessageBox(this, er.Message);
            return;
        }

    }

    protected void ddl_Transporter_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddl_Mode.Items.Clear();
        string Tid = ddl_Transporter.SelectedValue;
        BindMode(Tid);
    }

    private void BindMode(string Tid)
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@Tid", Tid) };
        DataTable dt = objDu.GetDataTable(param1, "Select RoleMode from TransporterMst Where Tid=@Tid");
        if (dt.Rows.Count > 0)
        {
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@RoleMode", dt.Rows[0]["RoleMode"].ToString()) };
            DataTable dt1 = objDu.GetDataTable(param, "Select UserVal, Item_Desc from Item_Collection where ItemId=8 and UserVal in(Select items From dbo.Split(@RoleMode, ','))");
            if (dt1.Rows.Count > 0)
            {
                ddl_Mode.Items.Clear();
                ddl_Mode.DataSource = dt1;
                ddl_Mode.DataTextField = "Item_Desc";
                ddl_Mode.DataValueField = "UserVal";
                ddl_Mode.DataBind();
            }
        }
    }


    private void BindTransporter()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Tid, TransporterName from TransporterMst Where Isactive=1 and Franchiseid=" + Session["franchiseid"].ToString());
        if (dt.Rows.Count > 0)
        {
            ddl_Transporter.Items.Clear();
            ddl_Transporter.DataSource = dt;
            ddl_Transporter.DataTextField = "TransporterName";
            ddl_Transporter.DataValueField = "Tid";
            ddl_Transporter.DataBind();
            ddl_Transporter.Items.Insert(0, new ListItem("Select Transporter", "0"));
        }
    }


    private void BindDispatchStatus()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select UserVal, Item_Desc from Item_Collection where ItemId=9");
        if (dt.Rows.Count > 0)
        {
            ddl_DispatchStatus.Items.Clear();
            ddl_DispatchStatus.DataSource = dt;
            ddl_DispatchStatus.DataTextField = "Item_Desc";
            ddl_DispatchStatus.DataValueField = "UserVal";
            ddl_DispatchStatus.DataBind();
            ddl_DispatchStatus.Items.Insert(0, new ListItem("Select Dispatch Status", "0"));
        }
    }




}