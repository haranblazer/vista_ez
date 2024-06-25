using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;



public partial class franchise_Add_Transportor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Session["franchiseid"] == null)
                    Response.Redirect("Logout.aspx");

                BindState();
                BindMode();
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["id"] != null)
                    {
                        BindDetails(Request.QueryString["id"].ToString());
                    }
                }
            }
        }
        catch (Exception er) { }
        {
        }
    }


    public void BindDetails(String TId)
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@" Select Tid, TransporterName, Address, MobileNo, Emailid, GSTNO,
        ContactPerson, Stateid=(Select id from stategstmst where Statename=t.State), 
        DistId=(Select id from DistrictMst Where DistrictName=t.District), Pincode, Freight, FuelCharges, FOVChages, DocketCharges, HandlingCharges, ODA, OtherChages, Isactive, 
        RoleMode from TransporterMst t where Franchiseid='" + Session["franchiseid"].ToString() + "' and Tid=" + TId);
        Session["dt"] = dt;
        if (dt.Rows.Count > 0)
        {

            txt_TransporterName.Text = dt.Rows[0]["TransporterName"].ToString();
            txt_Address.Text = dt.Rows[0]["Address"].ToString();
            txt_MobileNo.Text = dt.Rows[0]["MobileNo"].ToString();
            txt_Emailid.Text = dt.Rows[0]["Emailid"].ToString();
            txt_GSTNO.Text = dt.Rows[0]["GSTNO"].ToString();
            txt_ContactPerson.Text = dt.Rows[0]["ContactPerson"].ToString();
            DdlState.SelectedValue = dt.Rows[0]["Stateid"].ToString();
            BindDistrict(dt.Rows[0]["Stateid"].ToString());
            ddlDistrict.SelectedValue = dt.Rows[0]["DistId"].ToString();
            txt_Pincode.Text = dt.Rows[0]["Pincode"].ToString();
            txt_Freight.Text = dt.Rows[0]["Freight"].ToString();
            txt_DocketCharges.Text = dt.Rows[0]["DocketCharges"].ToString();
            txt_FOVChages.Text = dt.Rows[0]["FOVChages"].ToString();
            txt_FuelCharges.Text = dt.Rows[0]["FuelCharges"].ToString();
            txt_HandlingCharges.Text = dt.Rows[0]["HandlingCharges"].ToString();
            txt_ODA.Text = dt.Rows[0]["ODA"].ToString();
            txt_OtherChages.Text = dt.Rows[0]["OtherChages"].ToString();
            ddl_Isactive.SelectedValue = dt.Rows[0]["Isactive"].ToString();


            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@RoleMode", dt.Rows[0]["RoleMode"].ToString()) };
            DataTable dtNew = objDu.GetDataTable(param, "Select items From dbo.Split(@RoleMode, ',')");
            if (dtNew.Rows.Count > 0)
            {
                for (int i = 0; i < chk_mode.Items.Count; i++)
                {
                    foreach (DataRow dr in dtNew.Rows)
                    {
                        if (chk_mode.Items[i].Value == dr["items"].ToString())
                        {
                            chk_mode.Items[i].Selected = true;
                        }
                    }
                }
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            if (HttpContext.Current.Session["franchiseid"] == null)
            {
                Response.Redirect("Logout.aspx");
                return;
            }

            string Tid = "0";
            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["id"] != null)
                    Tid = Request.QueryString["id"].ToString();
            }

            string RoleMode = CheckedMode();
            if (string.IsNullOrEmpty(RoleMode))
            {
                utility.MessageBox(this, "Please Select Transport Mode.!!");
                return;
            }

            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@Tid", Tid),
                 new SqlParameter("@Franchiseid", HttpContext.Current.Session["franchiseid"].ToString()),
                 new SqlParameter("@TransporterName", txt_TransporterName.Text),
                 new SqlParameter("@Address", txt_Address.Text),
                 new SqlParameter("@MobileNo", txt_MobileNo.Text),
                 new SqlParameter("@Emailid", txt_Emailid.Text),
                 new SqlParameter("@GSTNO", txt_GSTNO.Text),
                 new SqlParameter("@RoleMode", RoleMode),

                 new SqlParameter("@ContactPerson", txt_ContactPerson.Text),
                 new SqlParameter("@State", DdlState.SelectedItem.Text),
                 new SqlParameter("@District", ddlDistrict.SelectedItem.Text),
                 new SqlParameter("@Pincode", txt_Pincode.Text),

                 new SqlParameter("@Freight", txt_Freight.Text.Trim() == "" ? "0" : txt_Freight.Text.Trim()),
                 new SqlParameter("@DocketCharges", txt_DocketCharges.Text.Trim() == "" ? "0" : txt_DocketCharges.Text.Trim()),
                 new SqlParameter("@FOVChages", txt_FOVChages.Text.Trim() == "" ? "0" : txt_FOVChages.Text.Trim()),
                 new SqlParameter("@FuelCharges", txt_FuelCharges.Text.Trim() == "" ? "0" : txt_FuelCharges.Text.Trim()),
                 new SqlParameter("@HandlingCharges", txt_HandlingCharges.Text.Trim() == "" ? "0" : txt_HandlingCharges.Text.Trim()),
                 new SqlParameter("@ODA", txt_ODA.Text.Trim() == "" ? "0" : txt_ODA.Text.Trim()),
                 new SqlParameter("@OtherChages", txt_OtherChages.Text.Trim() == "" ? "0" : txt_OtherChages.Text.Trim()),

                 new SqlParameter("@Isactive", ddl_Isactive.SelectedValue)
            };

            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "AddTransportor");
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Error"].ToString() == "0")
                {
                    //utility.MessageBox(this, "Transporter details save successfully.!!");
                    Response.Redirect("TransporterList.aspx");
                    return;
                }
                else
                {
                    utility.MessageBox(this, dt.Rows[0]["Error"].ToString());
                    return;
                }
            }
            else
            {
                utility.MessageBox(this, "Server error.!!");
                return;
            }
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.Message);
            return;
        }
    }


    public void BindState()
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] { };
        DataTable dt = objDu.GetDataTableSP(param1, "GetState");
        DdlState.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            DdlState.DataSource = dt;
            DdlState.DataTextField = "StateName";
            DdlState.DataValueField = "SId";
            DdlState.DataBind();
            DdlState.Items.Insert(0, new ListItem("Select", ""));
        }
        else
        {
            DdlState.Items.Insert(0, new ListItem("Select", ""));
        }
        ddlDistrict.Items.Clear();
        ddlDistrict.Items.Insert(0, new ListItem("Select", ""));
    }


    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDistrict(DdlState.SelectedValue);
    }

    public void BindDistrict(string value)
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("GetStateDistrict", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@state", value);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlDistrict.DataSource = dt;
                ddlDistrict.Items.Clear();
                ddlDistrict.DataTextField = "DistrictName";
                ddlDistrict.DataValueField = "Id";
                ddlDistrict.DataBind();
                ddlDistrict.Items.Insert(0, new ListItem("Select", ""));
            }
            else
            {
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, new ListItem("Select", ""));
            }
        }
        catch
        {
        }
    }

    private string CheckedMode()
    {
        string RoleMode = "";
        for (int i = 0; i < chk_mode.Items.Count; i++)
        {
            if (chk_mode.Items[i].Selected)
            {
                RoleMode += chk_mode.Items[i].Value + ",";
            }
        }
        return RoleMode;
    }


    private void BindMode()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select UserVal, Item_Desc='&nbsp;' + Item_Desc + '&nbsp;' from Item_Collection where ItemId=8");
        if (dt.Rows.Count > 0)
        {
            chk_mode.Items.Clear();
            chk_mode.DataSource = dt;
            chk_mode.DataTextField = "Item_Desc";
            chk_mode.DataValueField = "UserVal";
            chk_mode.DataBind();
        }
    }
    private void Reset()
    {
        txt_TransporterName.Text = "";
        txt_Address.Text = "";
        txt_MobileNo.Text = "";
        txt_Emailid.Text = "";
        txt_GSTNO.Text = "";
        //chk_mode
    }
}