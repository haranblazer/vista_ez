using System;
using System.Data.SqlClient;
using System.Data;
public partial class secretadmin_AddSubCategory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getCategory();

            InsertFunction.CheckAdminlogin();
            txt_SubCat.Text = string.Empty; 
            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["id"] != null)
                { 
                    BindProduct(Request.QueryString["id"].ToString());
                }
            }

        }
    }

    public void BindProduct(String SubCatId)
    {
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@SubCatId", SubCatId) };
            DataTable dt = objDu.GetDataTable(param1, "select CatId,SubCatName, PriorityDisplay from SubCategoryMst where SubCatId=@SubCatId");
            if (dt.Rows.Count > 0)
            {
                ddlCategory.SelectedValue = dt.Rows[0]["CatId"].ToString();
                txt_SubCat.Text = dt.Rows[0]["SubCatName"].ToString();
                txt_priority.Text = dt.Rows[0]["PriorityDisplay"].ToString();
            }
        }
        catch (Exception er) { }
        {
        }
    }
    public void getCategory()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlDataAdapter da = new SqlDataAdapter("select CatId,CatName from  Categorymst ", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "CatName";
                ddlCategory.DataValueField = "CatId";
                ddlCategory.DataBind();
                // ddlCategory.Items.Insert(0, new ListItem("All", "0"));

            }
        }
        catch
        {
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string SubCatId = "0";
            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["id"] != null)
                    SubCatId = Request.QueryString["id"].ToString();
            }

            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("AddEditSubcategory", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@SubCatId", SubCatId);
            com.Parameters.AddWithValue("@CatId", ddlCategory.SelectedValue);
            com.Parameters.AddWithValue("@SubCatName", txt_SubCat.Text.Trim());
            com.Parameters.AddWithValue("@PriorityDisplay", txt_priority.Text.Trim() == "" ? "0" : txt_priority.Text.Trim());
            com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;

            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            utility.MessageBox(this, "sub-category added successfully!");
            txt_SubCat.Text = "";
            txt_priority.Text = "";
            if (com.Parameters["@flag"].Value.ToString() == "1")
            {


                Response.Redirect("SubCategoryList.aspx");
            }
            }
        catch (Exception ex) { }

    }
}