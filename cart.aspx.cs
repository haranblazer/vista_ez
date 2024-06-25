using System; 
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class cart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindState();
            if (Session["userId"] != null)
            {
                txt_Userid.Text= Session["userId"].ToString();
                rdo_UserType.Visible = false;
            }
        }
    }

    public void BindState()
    {
        DataUtility objDUT = new DataUtility(); 
        DataTable dt = objDUT.GetDataTable("GetState");
        ddl_state.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl_state.DataSource = dt;
            ddl_state.DataTextField = "StateName";
            ddl_state.DataValueField = "Id";
            ddl_state.DataBind();
        }
        ddl_state.Items.Insert(0, new ListItem("Select State", "0"));
    }


    [WebMethod]
    public static string UserType(string UserTypeVal)
    {
        string Result = "0";

        if (UserTypeVal != "") 
            HttpContext.Current.Session["UserType"] = UserTypeVal; 
        
        if (HttpContext.Current.Session["UserType"] == null)
            Result = "0";
        else
            Result = HttpContext.Current.Session["UserType"].ToString();
        return Result;
    }

    


}