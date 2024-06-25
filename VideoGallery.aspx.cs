using System; 
using System.Data.SqlClient;
using System.Data; 

public partial class VideoGallery : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetVideo();
            GetVideo2();
            GetVideo3();
            GetVideo4();

        }
    }

    private void GetVideo()
    {
        try
        {
            com = new SqlCommand("GetVideo", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@tid", 2);
            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
              //  DataRow dr = dt.Select("VendorID = " + Session["VendorId"].ToString());


                ddlVideo.DataSource = dt;
                ddlVideo.DataBind();
            }

        }

        catch
        {

        }

    }
    private void GetVideo2()
    {
        try
        {
            com = new SqlCommand("GetVideo", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@tid", 3);
            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                //  DataRow dr = dt.Select("VendorID = " + Session["VendorId"].ToString());
               

                ddlVideo2.DataSource = dt;
                ddlVideo2.DataBind();
            }

        }

        catch
        {

        }

    }

    private void GetVideo3()
    {
        try
        {
            com = new SqlCommand("GetVideo", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@tid", 4);
            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                //  DataRow dr = dt.Select("VendorID = " + Session["VendorId"].ToString());
            

                ddlVideo3.DataSource = dt;
                ddlVideo3.DataBind();
            }

        }

        catch
        {

        }

    }

    private void GetVideo4()
    {
        try
        {
            com = new SqlCommand("GetVideo", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@tid", 5);
            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                //  DataRow dr = dt.Select("VendorID = " + Session["VendorId"].ToString());


                ddlVideo4.DataSource = dt;
                ddlVideo4.DataBind();
            }

        }

        catch
        {

        }

    }

}