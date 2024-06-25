using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;

public partial class AddPacked : System.Web.UI.Page
{
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["franchiseid"] == null)
                Response.Redirect("Logout.aspx");

            if (!IsPostBack)
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();
                BindProduct();
                BindGrid();
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void btn_Packed_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();

                if (HttpContext.Current.Session["franchiseid"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                string Pid=ddl_prod.SelectedValue;
                string Qty = txt_Qty.Text.Trim() == "" ? "0" : txt_Qty.Text.Trim();
                if (Pid == "0")
                {
                    div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select Product.</div>";
                    return;
                }
                if (string.IsNullOrEmpty(Qty) || Qty=="0")
                {
                    div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Enter Qty.!!</div>"; 
                    return;
                }
                

                SqlConnection con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("Update_Combo_Qty", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@FranchiseId", HttpContext.Current.Session["franchiseid"].ToString());
                cmd.Parameters.AddWithValue("@Pid", Pid);
                cmd.Parameters.AddWithValue("@ReqQty", Qty);
                cmd.Parameters.AddWithValue("@ActionTyp", ddl_Typ.SelectedValue);

                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                string msg = cmd.Parameters["@flag"].Value.ToString();
                if (msg == "1")
                {
                    div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your details has been save successfully.</div>";
                    BindProduct();
                }
                else
                {
                    div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong>" + msg + "</div>";
                }
                con.Close();
            }
            else
            {
                div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Don't refresh the page.!!</div>";
            }
        }
        catch (Exception ex)
        {
            div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> " + ex.ToString() + "</div>";
        }


    }

    protected void ddl_prod_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }

    public void BindProduct()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@soldby", HttpContext.Current.Session["franchiseid"].ToString()) };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param, @"select s.productid, productname=s.productname +' ('+Cast(s.productCode as varchar(50))+') ' + s.PackSize +SPACE(1)+ Cast(ps.PackSize as varchar(50))+
        ' (Qty ' + isnull((Select Cast(ProdBalQty as varchar(50)) from addinventory where sno=(Select max(Sno) from addinventory where pid=s.productid and soldby=@soldby)),0) +')'
        from shopproductmst s inner join PackSizemst ps on s.PackSizeUnitId = ps.srno where s.isDeleted = 0 and isnull(s.IsComboPack,0)=1 order by s.productname");
        if (dt.Rows.Count > 0)
        {
            ddl_prod.DataTextField = "productname";
            ddl_prod.DataValueField = "productid";
            ddl_prod.DataSource = dt;
            ddl_prod.DataBind();
            ddl_prod.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Product", "0"));
        }
        else
            ddl_prod.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Product", "0"));
    }

    public void BindGrid()
    {
        try
        {
            string Pid = ddl_prod.SelectedValue;
            if (Pid != "0")
            {
                SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Pid", Pid), new SqlParameter("@soldby", Session["franchiseid"].ToString()) };
                string Qry = @" Select p.Productid,  p.ProductCode, ProductName=p.ProductName + SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)),
                Qty=isnull((Select Qty from ComboMst where Isactive=1 and C_Pid=p.Productid and Pid=@Pid),0),
                AvaiQty=(Select ProdBalQty from addinventory where sno=(Select max(Sno) from addinventory where pid=c.C_Pid and soldby=@soldby))
                from shopproductmst p inner join ComboMst c on c.C_Pid=p.Productid and c.Pid=@Pid
                inner join PackSizemst ps on p.PackSizeUnitId = ps.srno
                where p.isDeleted = 0  order by p.ProductCode";
                DataUtility objDu = new DataUtility();
                DataTable dt = objDu.GetDataTable(param, Qry);
                if (dt.Rows.Count > 0)
                {
                    GridView2.DataSource = dt;
                    GridView2.DataBind();
                }
                else
                {
                    GridView2.DataSource = null;
                    GridView2.DataBind();
                }
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




}



