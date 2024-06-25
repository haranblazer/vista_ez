using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_UploadExcelFile : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");


        }
        catch
        {

        }
    }

    protected void btnbulkcopy_Click(object sender, EventArgs e)
    {
        try
        {

            if (FileUpload1.HasFile)
            {
                DataTable dt = new DataTable();
                dt = ReadCsvFile();

                if (dt.Rows.Count > 0)
                {
                    SqlCommand cmd = new SqlCommand(ddl_ExcelType.SelectedValue, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter tvparam = cmd.Parameters.AddWithValue("@dt", dt);
                    tvparam.SqlDbType = SqlDbType.Structured;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    //GridView1.DataSource = dt;
                    //GridView1.DataBind();

                    btnbulkcopy.Enabled = false;
                    lbl_Msg.Text = "Your details save successfully.!!";
                    //utility.MessageBox(this, "Your details save successfully.!!");
                    return;

                }
            }
            else
            {
                utility.MessageBox(this, "Please Select CSV File !!!");
            }
        }
        catch (Exception EX)
        {
            utility.MessageBox(this, EX.Message.ToString());

        }
    }


    private DataTable ReadCsvFile()
    {

        DataTable dtCsv = new DataTable();
        string Fulltext;
        if (FileUpload1.HasFile)
        {
            string FileName = Path.GetFileName(Guid.NewGuid().ToString() + FileUpload1.PostedFile.FileName);

            string FileSaveWithPath = Server.MapPath("~/secretadmin/ProductDoc/" + FileName);
            FileUpload1.SaveAs(FileSaveWithPath);
            using (StreamReader sr = new StreamReader(FileSaveWithPath))
            {
                while (!sr.EndOfStream)
                {
                    Fulltext = sr.ReadToEnd().ToString(); //read full file text  
                    string[] rows = Fulltext.Split('\n'); //split full file text into rows  
                    for (int i = 0; i < rows.Count() - 1; i++)
                    {
                        string[] rowValues = rows[i].Split(','); //split each row with comma to get individual values  
                        {
                            if (i == 0)
                            {
                                for (int j = 0; j < rowValues.Count(); j++)
                                {
                                    dtCsv.Columns.Add(rowValues[j]); //add headers  
                                }
                            }
                            else
                            {
                                DataRow dr = dtCsv.NewRow();
                                for (int k = 0; k < rowValues.Count(); k++)
                                {
                                    dr[k] = rowValues[k].ToString();
                                }
                                dtCsv.Rows.Add(dr); //add other rows  
                            }
                        }
                    }
                }
            }
        }
        return dtCsv;
    }

    [WebMethod]
    public static Daimond[] Get_Daimond()
    {
        List<Daimond> details = new List<Daimond>();
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReader("Select UserId, UserName, DOB, Achievement_Month, Rank, District, State, IsHideDiamond=isnull(e.IsHideDiamond,0) from tbl_Diamond t left join tbl_UserHideEvent e on t.UserId=e.AppmstRegNo");
        while (dr.Read())
        {
            Daimond data = new Daimond();
            data.UserId = dr["UserId"].ToString();
            data.UserName = dr["UserName"].ToString();
            data.DOB = dr["DOB"].ToString();
            data.Achievement_Month = dr["Achievement_Month"].ToString();
            data.Rank = dr["Rank"].ToString();
            data.District = dr["District"].ToString();
            data.State = dr["State"].ToString();
            data.IsHideDiamond = dr["IsHideDiamond"].ToString();
            details.Add(data);
        }
        return details.ToArray();
    }


    [WebMethod]
    public static Tour[] Get_TourAchiever()
    {
        List<Tour> details = new List<Tour>();
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReader("Select UserId, UserName, Period, Month, Offer_Tour, District, State, IsHideTour=isnull(e.IsHideTour,0) from tbl_Tour t left join tbl_UserHideEvent e on t.UserId=e.AppmstRegNo");
        while (dr.Read())
        {
            Tour data = new Tour();
            data.UserId = dr["UserId"].ToString();
            data.UserName = dr["UserName"].ToString();
            data.Period = dr["Period"].ToString();
            data.Month = dr["Month"].ToString();
            data.Offer_Tour = dr["Offer_Tour"].ToString();
            data.District = dr["District"].ToString();
            data.State = dr["State"].ToString();
            data.IsHideTour = dr["IsHideTour"].ToString();
            details.Add(data);
        }
        return details.ToArray();
    }


    [WebMethod]
    public static Offer[] Get_OfferAchiever()
    {
        List<Offer> details = new List<Offer>();
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReader("Select UserId, UserName, Period, Month, Offer_Reward, District, State, IsHideOffer=isnull(e.IsHideOffer,0) from tbl_Offer t left join tbl_UserHideEvent e on t.UserId=e.AppmstRegNo");
        while (dr.Read())
        {
            Offer data = new Offer();
            data.UserId = dr["UserId"].ToString();
            data.UserName = dr["UserName"].ToString();
            data.Period = dr["Period"].ToString();
            data.Month = dr["Month"].ToString();
            data.Offer_Reward = dr["Offer_Reward"].ToString();
            data.District = dr["District"].ToString();
            data.State = dr["State"].ToString();
            data.IsHideOffer = dr["IsHideOffer"].ToString();
            details.Add(data);
        }
        return details.ToArray();
    }

    [WebMethod]
    public static string Update_ShowHide(string Userid, string IsHideDiamond, string IsHideTour, string IsHideOffer)
    {
        string Result = "";
        try
        {
            SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
            outparam.Direction = ParameterDirection.Output;
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Userid", Userid),
                new SqlParameter("@IsHideDiamond", IsHideDiamond),
                new SqlParameter("@IsHideTour", IsHideTour),
                new SqlParameter("@IsHideOffer", IsHideOffer),
                outparam,
            };
            DataUtility objDu = new DataUtility();
            Result = objDu.ExecuteSqlSP(param, "sp_AddNewEvent").ToString();
        }
        catch (Exception er) { }
        return Result;
    }




    [WebMethod]
    public static string ResetData(string ExcelType)
    {
        string Result = "";
        try
        {
            DataUtility objDu = new DataUtility();
            
            if (ExcelType == "AddExcel_Diamond")
            {
                Result = objDu.ExecuteSql("truncate table tbl_Diamond").ToString();
            }
            else if (ExcelType == "AddExcel_Tour")
            {
                Result = objDu.ExecuteSql("truncate table tbl_Tour").ToString();
            }
            else if (ExcelType == "AddExcel_Offer")
            {
                Result = objDu.ExecuteSql("truncate table tbl_Offer").ToString();
            } 
        }
        catch (Exception er) { }
        return Result;
    }



    public class Daimond
    {
        public String UserId { get; set; }
        public String UserName { get; set; }
        public String DOB { get; set; }
        public String Achievement_Month { get; set; }
        public String Rank { get; set; }
        public String District { get; set; }
        public String State { get; set; }
        public String IsHideDiamond { get; set; }

    }

    public class Tour
    {
        public String UserId { get; set; }
        public String UserName { get; set; }
        public String Period { get; set; }
        public String Month { get; set; }
        public String Offer_Tour { get; set; }
        public String District { get; set; }
        public String State { get; set; }
        public String IsHideTour { get; set; }
    }

    public class Offer
    {
        public String UserId { get; set; }
        public String UserName { get; set; }
        public String Period { get; set; }
        public String Month { get; set; }
        public String Offer_Reward { get; set; }
        public String District { get; set; }
        public String State { get; set; }
        public String IsHideOffer { get; set; }
    }

}