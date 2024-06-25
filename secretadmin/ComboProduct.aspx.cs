using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

public partial class secretadmin_ComboProduct : System.Web.UI.Page
{

    static string Pid = "0";
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Convert.ToString(Session["admintype"]) == "sa")
        //{
        //    utility.CheckSuperAdminLogin();
        //}
        //else
        if (Session["admin"] == null)
        {
            Response.Redirect("adminLog.aspx");
             
        }
       
        if (!IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                HttpContext.Current.Session["Combo"] = null;
                if (Request.QueryString["pid"] != null)
                {
                    Pid = Request.QueryString["pid"].ToString();
                    BindProduct();
                    BindProductdetails();
                }

            }
        }
    }


    public void BindProduct()
    {
        try
        {
            string Locked = "0";
            DataUtility objDu = new DataUtility();
            try
            {
                SqlParameter[] paramNew = new SqlParameter[] { new SqlParameter("@PidNew", Pid) };
                Locked = objDu.GetScaler(paramNew, "Select SNo from AddInventory where Pid=@PidNew").ToString();
                btn_Search.Visible=false;
            }
            catch (Exception ex)
            {
                Locked = "0";
            }

            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Pid", Pid), new SqlParameter("@Locked", Locked) };

            string Qry = @"Select p.Productid,  p.ProductCode, ProductName=p.ProductName + SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)),
            IsComboPack=isnull((Select top 1 1 from ComboMst where Isactive=1 and C_Pid=p.Productid and Pid=@Pid),0) ,
            Qty=isnull((Select Qty from ComboMst where Isactive=1 and C_Pid=p.Productid and Pid=@Pid),0), Locked=@Locked
            from shopproductmst p inner join PackSizemst ps on p.PackSizeUnitId = ps.srno 
            where p.isDeleted=0 and isnull(p.IsComboPack,0)=0  order by p.ProductCode";

            //DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, Qry);

            DataView view = dt.DefaultView;
            view.Sort = "Qty Desc";
            DataTable dt_Sorted = view.ToTable();
             
            if (dt_Sorted.Rows.Count > 0)
            {
                GridView2.DataSource = dt_Sorted;
                GridView2.DataBind();
            }
            else
            {
                GridView2.DataSource = null;
                GridView2.DataBind();
            }
        }
        catch (Exception ex)
        {
            GridView2.DataSource = null;
            GridView2.DataBind();
        }
    }


    protected void btn_Search_Click(object sender, EventArgs e)
    {
        try
        {
            string IsSelected = "0";
            if (!string.IsNullOrEmpty(Pid))
            {

                if (HttpContext.Current.Session["Combo"] == null)
                    CreateStucture();

                DataTable dt_Combo = (DataTable)HttpContext.Current.Session["Combo"];


                foreach (GridViewRow row in GridView2.Rows)
                {
                    CheckBox chkProd = (CheckBox)row.FindControl("chkProd");
                    if (chkProd.Checked)
                    {
                        HiddenField hnd_productid = (HiddenField)row.FindControl("hnd_productid");
                        TextBox txtQty = (TextBox)row.FindControl("txtQty");
                        string Qty = "0";
                        if (string.IsNullOrEmpty(txtQty.Text.Trim()))
                            Qty = "0";
                        else
                            Qty = txtQty.Text.Trim();


                        DataRow dr = dt_Combo.NewRow();
                        dr["Pid"] = Pid;
                        dr["C_Pid"] = Convert.ToInt32(hnd_productid.Value);
                        dr["Qty"] = Qty;
                        dt_Combo.Rows.Add(dr);

                        IsSelected = "1";
                    }
                }

                if (IsSelected == "1")
                {

                    SqlConnection con = new SqlConnection(method.str);
                    SqlCommand cmd = new SqlCommand("SP_AddCombo", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter p_DT_Combo_Prod = new SqlParameter();
                    p_DT_Combo_Prod.ParameterName = "@DT_Combo_Prod";
                    p_DT_Combo_Prod.SqlDbType = SqlDbType.Structured;
                    p_DT_Combo_Prod.Direction = ParameterDirection.Input;
                    p_DT_Combo_Prod.Value = dt_Combo;
                    cmd.Parameters.Add(p_DT_Combo_Prod);

                    SqlParameter p_Pid = new SqlParameter();
                    p_Pid.ParameterName = "@Pid";
                    p_Pid.SqlDbType = SqlDbType.Int;
                    p_Pid.Direction = ParameterDirection.Input;
                    p_Pid.Value = Pid;
                    cmd.Parameters.Add(p_Pid);

                    SqlParameter flag = new SqlParameter("@flag", SqlDbType.VarChar, 500);
                    flag.Direction = ParameterDirection.Output; // Setting the direction  
                    cmd.Parameters.Add(flag);

                    con.Open();
                    cmd.CommandTimeout = 1900;
                    cmd.ExecuteNonQuery();
                    con.Close();

                    string status = cmd.Parameters["@flag"].Value.ToString();
                    if (status == "1")
                    {
                        BindProduct();
                        BindProductdetails();
                        div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your details has been save successfully.</div>";
                    }
                    else
                        utility.MessageBox(this, status);

                    HttpContext.Current.Session["Combo"] = null;
                }
                else
                {
                    div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select Combo Product.!!</div>";
                }

            }

        }
        catch (Exception ex) { }
    }



    public void BindProductdetails()
    {
        try
        {
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Pid", Pid) };

            string Qry = @"Select ProductName=p.ProductName + SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)) +' ('+ p.ProductCode +')'
            from shopproductmst p inner join PackSizemst ps on p.PackSizeUnitId = ps.srno 
            where p.isDeleted = 0  and p.Productid=@Pid";

            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, Qry);
            if (dt.Rows.Count > 0)
            {
                div_Product.InnerHtml = dt.Rows[0]["ProductName"].ToString();
            }
            else
            {
                GridView2.DataSource = null;
                GridView2.DataBind();
            }
        }
        catch (Exception ex)
        {
            GridView2.DataSource = null;
            GridView2.DataBind();
        }
    }



    #region
    private static void CreateStucture()
    {
        DataTable dtStuc = new DataTable();
        dtStuc.Columns.Add(new DataColumn("Pid", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("C_Pid", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("Qty", typeof(int)));
        HttpContext.Current.Session["Combo"] = dtStuc;
    }

    public class ProdDetails
    {
        public int Pid { get; set; }
        public int C_Pid { get; set; }
        public int Qty { get; set; }
    }
    #endregion
}