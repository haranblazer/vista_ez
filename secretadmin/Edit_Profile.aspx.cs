using System; 
using System.Data.SqlClient;
using System.Data; 
using System.Web;
using System.Web.Services; 
using System.Web.UI.WebControls;
using System.IO;
using System.Collections;

public partial class secretadmin_Edit_Profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
        {
            Response.Redirect("logout.aspx");
        }
        else
        {
            if (Request.QueryString.Count != 0 && Request.QueryString["n"] != null)
            {
                if (!IsPostBack)
                {
                    hdn_userid.Value = Request.QueryString["n"].ToString();

                    txtDOB.Text = DateTime.Now.AddYears(-18).ToString("dd/MM/yyyy").Replace("-", "/");
                    // GetCountries();
                    BindBank();
                    BindState();
                    //
                    //BindUserDetails();
                }
            }
            else
            {
                Response.Redirect("adchangeprofile.aspx");
            }
        }
    }

    public void BindBank()
    {
        try
        {
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP("GetBank");
            ddlBankName.DataSource = dt;
            ddlBankName.DataTextField = "BankName";
            ddlBankName.DataValueField = "BankName";
            ddlBankName.DataBind();
            ddlBankName.Items.Insert(0, new ListItem("Select Bank", ""));
        }
        catch
        {

        }
    }



    [WebMethod]
    public static string Upload_Pan(string PANNo, string ImgName_Pan, string Id)
    {
        string result = "0";
        try
        {
            SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@Regno", Id)
        };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select sd.PanImage from AppMst a inner join scandocs sd on a.appmstid=sd.appmstid where a.appmstregno=@regno");
            foreach (DataRow dr in dt.Rows)
            {


                string IMG = dr["PanImage"].ToString();

                string path = HttpContext.Current.Server.MapPath("~/images/KYC/PanImage/" + IMG);
                if (ImgName_Pan != "")
                {
                    FileInfo file = new FileInfo(path);
                    if (file.Exists)
                    {
                        file.Delete();
                    }
                }
            }
            if (Id != null)
            {
                InsertFunction insFunc = new InsertFunction();
                string imagename = insFunc.insertPanDetail(PANNo, Id, ImgName_Pan);
                result = "1";
            }
        }
        catch (Exception er) { result = er.Message; }
        return result;
    }
    //public void GetCountries()
    //{
    //    mst_class objmst = new mst_class();
    //    DataTable dt = objmst.GetCountries();
    //    ddl_Countries.Items.Clear();
    //    if (dt.Rows.Count > 0)
    //    {
    //        ddl_Countries.DataSource = dt;
    //        ddl_Countries.DataTextField = "CountryName";
    //        ddl_Countries.DataValueField = "CId";
    //        ddl_Countries.DataBind();
    //        ddl_Countries.Items.Insert(0, new ListItem("Select Country", ""));
    //        ddl_Countries.SelectedValue = "101";
    //    }
    //    else
    //    {
    //        ddl_Countries.Items.Insert(0, new ListItem("Select Country", ""));
    //    }
    //    ddlState.Items.Clear();
    //    ddlState.Items.Insert(0, new ListItem("Select State", ""));

    //    ddl_City.Items.Clear();
    //    ddl_City.Items.Insert(0, new ListItem("Select City", ""));
    //}


    [WebMethod]
    public static string Upload_Bank(string ImgName_Bank, string Bank_Name, string Acc_Type, string Acc_No, string IFSC, string Branch, string Id)
    {
        string result = "0";
        try
        {
            SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@Regno", Id)
        };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select sd.BankImage from AppMst a inner join scandocs sd on a.appmstid=sd.appmstid where a.appmstregno=@regno");
            foreach (DataRow dr in dt.Rows)
            {

                //HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/"+ dr["BankImage"].ToString());
                string IMG = dr["BankImage"].ToString();
                //string path = "~/images/KYC/BankImage/" + IMG + "";
                string path = HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/" + IMG);
                if (ImgName_Bank != "")
                {
                    FileInfo file = new FileInfo(path);
                    if (file.Exists)
                    {
                        file.Delete();
                    }
                }
            }
            //    string ID = HttpContext.Current.Session["userId"].ToString();
            //SqlConnection con = new SqlConnection(method.str);
            //SqlCommand cmd = new SqlCommand(@"Select sd.BankImage from AppMst a inner join scandocs sd on a.appmstid=sd.appmstid where a.appmstregno="+ID+" ", con);
            //cmd.CommandType = CommandType.Text;
            //con.Open();
            //cmd.Parameters.AddWithValue("@action", "B");
            //SqlDataAdapter sda = new SqlDataAdapter(cmd);

            //    Directory.GetFiles("");
            //File.Delete("");

            //string Random = Guid.NewGuid().ToString();

            //string fileName =HttpContext.Current.Path.GetFileName(Random + Path.GetExtension(fileCancelCq.FileName));
            //string filePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), Guid.NewGuid().ToString() + fileName);
            //if (System.IO.File.Exists(filePath))
            //{
            //    System.IO.File.Delete(filePath);

            //}
            if (Id != null)
            {
                InsertFunction insFunc = new InsertFunction();
                string imagename = insFunc.insertBankDetail(ImgName_Bank, Bank_Name, Acc_Type, Acc_No, IFSC, Branch, Id);
                result = "1";
            }
        }
        catch (Exception er) { result = er.Message; }
        return result;
    }

    [WebMethod]
    public static string btnApproveKYC_Click(string kycid, string regno, string name, string mobile)
    {
        SqlConnection con = new SqlConnection(method.str);
        if (string.IsNullOrEmpty(regno))
        {
            return "SessionOut";
        }

        if (kycid == "1")
        {
            try
            {
                con = new SqlConnection(method.str);
                string querry = "select appmstmobile from AppMst where AppMstRegNo='" + regno + "'";
                SqlCommand cmd1 = new SqlCommand(querry, con);
                con.Open();
                cmd1.ExecuteScalar();
                using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    while (reader.Read())
                    {
                        mobile = reader["appmstmobile"].ToString();
                    }
                }
                string upStatus = "Update scandocs set PStatus=2, panDateApproved=getdate() from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + regno + "'";
                SqlCommand cmd = new SqlCommand(upStatus, con);
                con.Open();
                cmd.ExecuteNonQuery();
                string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
                string UserName = name;
                string subUserName, text = "";
                if (UserName.Length > 20)
                {
                    subUserName = UserName.Substring(0, 20).ToString();
                    text = "Dear " + subUserName + " ID No :" + regno + " KYC for Pan Approved ";
                }
                else
                {
                    text = "Dear " + UserName + " ID No :" + regno + " KYC for Pan Approved ";
                }


                DataUtility objDu = new DataUtility();
                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", regno),
                    new SqlParameter("@modifiedby", HttpContext.Current.Session["admin"].ToString()),
                    new SqlParameter("@Remark", "Approved Pan")

                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");

                utility objUt = new utility();
                objUt.sendSMSByBilling(mobile, text, "KYC");
                return "Pan Approved";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        if (kycid == "2")
        {
            try
            {
                con = new SqlConnection(method.str);
                string querry = "select appmstmobile from  AppMst where AppMstRegNo='" + regno + "'";
                SqlCommand cmd1 = new SqlCommand(querry, con);
                con.Open();
                cmd1.ExecuteScalar();
                using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    while (reader.Read())
                    {
                        mobile = reader["appmstmobile"].ToString();
                    }
                }
                string upStatus = "Update scandocs set bankstatus=2, bankDateApproved=getdate() from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + regno + "'";
                SqlCommand cmd = new SqlCommand(upStatus, con);
                con.Open();
                cmd.ExecuteNonQuery();
                string UserName = name;
                string subUserName, text = "";
                if (UserName.Length > 20)
                {
                    subUserName = UserName.Substring(0, 20).ToString();
                    text = "Dear " + subUserName + " ID No :" + regno + " KYC for Bank Approved ";
                }
                else
                {
                    text = "Dear " + UserName + " ID No :" + regno + " KYC for Bank Approved ";
                }

                DataUtility objDu = new DataUtility(); SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", regno),
                    new SqlParameter("@modifiedby", HttpContext.Current.Session["admin"].ToString()),
                    new SqlParameter("@Remark", "Approved Bank")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");

                utility objUt = new utility();
                objUt.sendSMSByBilling(mobile, text, "KYC");
                return "Bank approved";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        if (kycid == "3")
        {
            try
            {
                con = new SqlConnection(method.str);
                string querry = "select appmstmobile from  AppMst where AppMstRegNo='" + regno + "'";
                SqlCommand cmd1 = new SqlCommand(querry, con);
                con.Open();
                cmd1.ExecuteScalar();
                using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    while (reader.Read())
                    {
                        mobile = reader["appmstmobile"].ToString();
                    }
                }
                string upstatus = "Update scandocs set AaStatus=2, docDateApproved=getdate() from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + regno + "'";
                SqlCommand cmd = new SqlCommand(upstatus, con);
                con.Open();
                cmd.ExecuteNonQuery();
                string UserName = name;
                string subUserName, text = "";
                if (UserName.Length > 20)
                {
                    subUserName = UserName.Substring(0, 20).ToString();
                    text = "Dear " + subUserName + " ID No :" + regno + " KYC for Address Approved ";
                }
                else
                {
                    text = "Dear " + UserName + " ID No :" + regno + " KYC for Address Approved ";
                }


                DataUtility objDu = new DataUtility(); SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", regno),
                    new SqlParameter("@modifiedby", HttpContext.Current.Session["admin"].ToString()),
                    new SqlParameter("@Remark", "Approved Aadhar")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");


                utility objUt = new utility();
                objUt.sendSMSByBilling(mobile, text, "KYC");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        return "there is an issue";


    }

    [WebMethod]
    public static string UpdateReject(string kycid, string Userid)
    {
        SqlConnection con = new SqlConnection(method.str);

        string admin = "";
        if (HttpContext.Current.Session["admin"] != null)
            admin = HttpContext.Current.Session["admin"].ToString();

        DataUtility objDu = new DataUtility();
        SqlParameter[] prm = new SqlParameter[] { new SqlParameter("@Userid1", Userid) };

        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Userid", Userid) };

        if (kycid == "1")
        {
            try
            {

                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", Userid),
                    new SqlParameter("@modifiedby", admin),
                    new SqlParameter("@Remark", "Reject Pan")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");



                string OldImgName = objDu.GetScaler(prm, "Select PanImage from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();

                string upStatus = "Update Appmst set verified=0, panno='' where AppMstRegNo =@Userid; Update scandocs set PStatus=0, PanImage=null from scandocs s inner join AppMst a on s.Appmstid=a.AppMstID where  a.AppMstRegNo =@Userid";
                objDu.ExecuteSql(param, upStatus);

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("../images/KYC/PanImage/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
                string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
                return "Pan Deleted";
            }
            catch (Exception ex)
            {
            }
        }

        if (kycid == "2")
        {
            try
            {
                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", Userid),
                    new SqlParameter("@modifiedby", admin),
                    new SqlParameter("@Remark", "Reject Bank")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");



                string OldImgName = objDu.GetScaler(prm, "select BankImage from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();

                string upStatus = "Update Appmst set verified=0, BankName='', Branch='', AcountNo='', Type='', IFSCode='' where AppMstRegNo =@Userid; Update scandocs set bankstatus=0, BankImage=null from scandocs s inner join AppMst a on s.Appmstid=a.AppMstID where a.AppMstRegNo =@Userid";
                objDu.ExecuteSql(param, upStatus);

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("../images/KYC/BankImage/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
                return "Bank Deleted";
            }
            catch (Exception ex)
            {
                //throw ex;
            }
        }
        if (kycid == "3")
        {
            try
            {

                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;
                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", Userid),
                    new SqlParameter("@modifiedby", admin),
                    new SqlParameter("@Remark", "Reject Aadhar")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");


                string Aadhar_F_img = objDu.GetScaler(prm, "select AadharFront from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();
                string Aadhar_B_img = objDu.GetScaler(prm, "select AadharBack from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();

                string upStatus = "Update Appmst set verified=0, Aadharno='' where AppMstRegNo =@Userid; Update scandocs set AaStatus=0, AadharFront=null, AadharBack=null from scandocs s inner join AppMst a on s.Appmstid=a.AppMstID where a.AppMstRegNo=@Userid";
                objDu.ExecuteSql(param, upStatus);

                string filePath1 = Path.Combine(HttpContext.Current.Server.MapPath("../images/KYC/AadharImage/Front/"), Aadhar_F_img);
                if (System.IO.File.Exists(filePath1))
                {
                    System.IO.File.Delete(filePath1);
                }

                string filePath2 = Path.Combine(HttpContext.Current.Server.MapPath("../images/KYC/AadharImage/Back/"), Aadhar_B_img);
                if (System.IO.File.Exists(filePath2))
                {
                    System.IO.File.Delete(filePath2);
                }



            }
            catch (Exception ex)
            {

            }
        }
        return "there is an issue";
    }


    [System.Web.Services.WebMethod]
    public static string AllKYC_Reject(string UId)
    {

        DataUtility objDu = new DataUtility();
        SqlParameter[] prm = new SqlParameter[] { new SqlParameter("@Userid1", UId) };
        string Result = "";
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("Del_KYC_Detail", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", UId);
            cmd.Parameters.AddWithValue("@modifiedby", HttpContext.Current.Session["admin"].ToString());
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            Result = cmd.Parameters["@flag"].Value.ToString();

            string Aadhar_F_img = objDu.GetScaler(prm, "select AadharFront from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();
            string Aadhar_B_img = objDu.GetScaler(prm, "select AadharBack from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();


            string filePath1 = Path.Combine(HttpContext.Current.Server.MapPath("../images/KYC/AadharImage/Front/"), Aadhar_F_img);
            if (System.IO.File.Exists(filePath1))
            {
                System.IO.File.Delete(filePath1);
            }

            string filePath2 = Path.Combine(HttpContext.Current.Server.MapPath("../images/KYC/AadharImage/Back/"), Aadhar_B_img);
            if (System.IO.File.Exists(filePath2))
            {
                System.IO.File.Delete(filePath2);
            }


            string OldImg_Name = objDu.GetScaler(prm, "select BankImage from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();


            string filePath = Path.Combine(HttpContext.Current.Server.MapPath("../images/KYC/BankImage/"), OldImg_Name);
            if (System.IO.File.Exists(filePath))
            {
                System.IO.File.Delete(filePath);
            }

            string OldImgName = objDu.GetScaler(prm, "Select PanImage from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();



            string file_Path = Path.Combine(HttpContext.Current.Server.MapPath("../images/KYC/PanImage/"), OldImgName);
            if (System.IO.File.Exists(file_Path))
            {
                System.IO.File.Delete(file_Path);
            }
            // utility.MessageBox(this, flag);
            // Response.Redirect(Request.RawUrl);
        }
        catch (Exception er) { }
        return Result;
    }

    [WebMethod]
    public static ArrayList GetDistrict(string StateId)
    {
        ArrayList list = new ArrayList();
        try
        {
            DataUtility objDUT = new DataUtility();
            SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@state", StateId) };
            DataTable dt = objDUT.GetDataTableSP(sqlparam, "GetStateDistrict");
            foreach (DataRow dr in dt.Rows)
            { list.Add(new ListItem(dr["DistrictName"].ToString(), dr["id"].ToString())); }
        }
        catch (Exception er) { }
        return list;
    }


    [WebMethod]
    public static string Upload_Aadhar(string ImgName_Aadhar_Front, string ImgName_Aadhar_Back, string AdhaarNo, string Id)
    {
        string msg = "0";
        try
        {
            SqlParameter[] param = new SqlParameter[]
       {
             new SqlParameter("@Regno", Id)
       };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select sd.AadharFront, sd.AadharBack from AppMst a inner join scandocs sd on a.appmstid=sd.appmstid where a.appmstregno=@regno");
            foreach (DataRow dr in dt.Rows)
            {

                //HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/"+ dr["BankImage"].ToString());
                string IMG_F = dr["AadharFront"].ToString();
                string IMG_B = dr["AadharBack"].ToString();
                //string path = "~/images/KYC/BankImage/" + IMG + "";
                string pathF = HttpContext.Current.Server.MapPath("~/images/KYC/AadharImage/Front/" + IMG_F);
                string pathB = HttpContext.Current.Server.MapPath("~/images/KYC/AadharImage/Back/" + IMG_B);
                if (ImgName_Aadhar_Front != "" && ImgName_Aadhar_Back != "")
                {
                    FileInfo fileF = new FileInfo(pathF);
                    if (fileF.Exists)
                    {
                        fileF.Delete();
                    }
                    FileInfo fileB = new FileInfo(pathB);
                    if (fileB.Exists)
                    {
                        fileB.Delete();
                    }
                }
            }
            if (Id != null)
            {
                string imgFront, imgback, Userid = Id;
                InsertFunction insFunc = new InsertFunction();
                insFunc.insertAddressProof(ImgName_Aadhar_Front, ImgName_Aadhar_Back, Userid, AdhaarNo, out imgFront, out imgback, out msg);
            }
        }
        catch (Exception er) { msg = er.Message; }
        return msg;
    }

    [System.Web.Services.WebMethod]
    public static string UpdatePersonal(string UId, string UName, string Gender, string DOB, string Email, string Address, string District, string State, string City, string PinCode, string Nom_Name, string Relation, string Mob, string Sponsor_Status, string PSWRD)
    {
        string result = "";
        try
        {

            {
                if (HttpContext.Current.Session["admin"] != null)
                {
                   

                    if (DOB.Trim().Length > 0)
                    {
                        String[] Date = DOB.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                        DOB = Date[2] + "/" + Date[1] + "/" + Date[0];
                    }


                    utility objU = new utility();

                    DataUtility objDu = new DataUtility();

                    SqlParameter outparam = new SqlParameter("@strResult", SqlDbType.VarChar, 100);
                    outparam.Direction = ParameterDirection.Output;
                    SqlParameter[] param = new SqlParameter[]
                    {
                        outparam, 
                        new SqlParameter("@modifiedby", HttpContext.Current.Session["admin"].ToString()),
                        new SqlParameter("@appmstregno", UId),
                        new SqlParameter("@title1", ""),
                        new SqlParameter("@GTitle1", ""),
                        new SqlParameter("@GName1", ""),
                        new SqlParameter("@fname1", UName),
                        new SqlParameter("@gender", Gender),
                        new SqlParameter("@userdob1", DOB),
                        new SqlParameter("@email1", Email),
                        //new SqlParameter("@Country", Country),
                        new SqlParameter("@address1", Address),
                        new SqlParameter("@State1", State),
                        new SqlParameter("@City1", City),
                        new SqlParameter("@distt1", District),
                        new SqlParameter("@PinCode1", PinCode),
                        //new SqlParameter("@PinArea", PinArea),
                        new SqlParameter("@nomname1", Nom_Name),
                        new SqlParameter("@nomrela1", Relation),
                        new SqlParameter("@Mobile1", Mob),
                        new SqlParameter("@activate1",Sponsor_Status),
                        //new SqlParameter("@AppMstDOJ", DOJ),
                        new SqlParameter("@pswrd", objU.base64Encode(PSWRD)),
                        //new SqlParameter("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output),
                        //new SqlParameter("@DisplayName", DisplayName),
                        new SqlParameter("@Mname1", ""),
                    };
                    result = objDu.ExecuteSqlSPS(param, "insertmodifyprofile").ToString();
                }
                else
                {
                    return "Session Logged Out.";
                }
            }
        }
        catch (Exception er)
        {
            result = er.Message;
        }
        return result;
    }


    public void BindState()
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] { };
        DataTable dt = objDu.GetDataTableSP(param1, "GetState");
        ddlState.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddlState.DataSource = dt;
            ddlState.DataTextField = "StateName";
            ddlState.DataValueField = "SId";
            ddlState.DataBind();
            ddlState.Items.Insert(0, new ListItem("Select State", ""));
        }
        else
        {
            ddlState.Items.Insert(0, new ListItem("Select State", ""));
        }
        ddlDistrict.Items.Clear();
        ddlDistrict.Items.Insert(0, new ListItem("Select District", ""));
    }


    [WebMethod]
    public static UserDetails GetUser(string UId)
    {
        UserDetails objUser = new UserDetails();
        try
        {
            utility utility = new utility();
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand(@"select a.AppMstRegNo, a.AppMstTitle, a.AppMstFName, sponsorid=(Select Appmstregno from Appmst where Appmstid=a.sponsorid), a.Gtitle, a.GName, a.MName, a.Gender, a.gtitle, a.AppMstAddress1,
            a.AppMstCity, a.AppMstState, a.AppMstMobile, a.AppMstPinCode, a.BankName, a.branch, a.acountno, a.[type], a.panno, a.Aadharno, 
            a.email, a.nom_name, a.nom_rela, a.distt, CONVERT(VARCHAR(10), a.userdob, 103) as userdob, 
            CONVERT(VARCHAR(10), a.AppMstDOJ, 103) as AppMstDOJ, 
            a.appmstactivate,                        
            a.IFSCode, a.MICRCode, a. panstatus, (case when a.imagename!='' then a.imagename else 'noimage.png' end)as imagename,  Verified, a.isProUp, 
            s.pstatus, a.panno, s.panImage, s.bankstatus, s.BankImage, s.Aadharfront, s.AadharBack,aastatus=isnull(s.aastatus,0),st.ID as SID,did=d.id,  s.OnlinePanVerify,s.PANDetails
            , a.AppMstPassword from scandocs s, AppMst a left join Stategstmst st on a.Appmststate=st.StateName left join districtmst d on d.DistrictName=a.distt  where s.Appmstid=a.AppMstID and a.AppMstRegNo=@AppMstRegNo", con);
            SqlDataReader dr;
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@AppMstRegNo", UId);
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                //select AppMstRegNo, AppMstTitle, appmstpassword, AppMstFName, sponsorid, Gtitle, GName, MName, Gender,
                //gtitle, AppMstAddress1, AppMstCity, AppMstState,
                // AppMstMobile, AppMstPinCode, BankName, branch, acountno,[type], panno, Aadharno, email, nom_name, nom_rela, distt = ISNULL(distt, 0), CONVERT(VARCHAR(10), userdob, 103) as userdob,                            
                //IFSCode,MICRCode,panstatus,case when imagename!= '' then imagename else 'noimage.png' end imagename, ePassword, Verified, isProUp, s.statename,s.Id
                //objUser.Id = HttpContext.Current.Session["userId"].ToString();
                objUser.UName = dr["AppMstFName"].ToString();
                objUser.Title = dr["AppMstTitle"].ToString();
                objUser.Name = dr["AppMstFName"].ToString();
                objUser.GTitle = dr["Gtitle"].ToString();
                objUser.GName = dr["GName"].ToString();
                objUser.Gender = dr["Gender"].ToString();
                objUser.DOB = dr["userdob"].ToString();
                objUser.Mobile = dr["AppMstMobile"].ToString();
                objUser.Email = dr["email"].ToString();
                objUser.Address = dr["AppMstAddress1"].ToString();
                objUser.State = dr["SID"].ToString();
                objUser.City = dr["AppMstCity"].ToString();
                //objUser.Country = dr[""].ToString();
                objUser.District = dr["distt"].ToString();
                objUser.PinCode = dr["AppMstPinCode"].ToString();
                objUser.Nominee = dr["nom_name"].ToString();
                objUser.Relation = dr["nom_rela"].ToString();
                objUser.PAN = dr["panno"].ToString();
                objUser.Bank = dr["BankName"].ToString();
                objUser.AccType = dr["type"].ToString();
                objUser.AccNo = dr["acountno"].ToString();
                objUser.Branch = dr["branch"].ToString();
                objUser.IFSC = dr["IFSCode"].ToString();
                objUser.AadhaarNo = dr["Aadharno"].ToString();
                objUser.did = dr["did"].ToString();
                objUser.isProUp = dr["isProUp"].ToString();

                objUser.PanImage = dr["PanImage"].ToString();
                objUser.PStatus = dr["PStatus"].ToString();
                objUser.bankstatus = dr["bankstatus"].ToString();
                objUser.BankImage = dr["BankImage"].ToString();
                objUser.AadharFront = dr["AadharFront"].ToString();
                objUser.AadharBack = dr["AadharBack"].ToString();
                objUser.AaStatus = dr["AaStatus"].ToString();
                objUser.SponsorId = dr["sponsorid"].ToString();
                objUser.SponsorStatus = dr["AppmstActivate"].ToString();
                //OnlineBankVerify OnlinePanVerify
                // objUser.OnlinePanVerify = dr["OnlinePanVerify"].ToString();
                objUser.DOJ = dr["Appmstdoj"].ToString();
                objUser.Statename = dr["Appmststate"].ToString();
                // objUser.OnlineBankVerify = dr["OnlineBankVerify"].ToString();
                // s.PANDetails, s.BankDetails
                // objUser.PANDetail = dr["PANDetails"].ToString();
                // objUser.BANKDetail = dr["BankDetails"].ToString(); 
                // objUser.DisplayName = dr["DisplayName"].ToString();
                objUser.PSWRD = utility.base64Decode(dr["AppMstPassword"].ToString());
            }
            else
            {

            }
            dr.Close();
            con.Close();
        }
        catch (Exception er) { }
        return objUser;
    }


    public class UserDetails
    {
        public String Id { get; set; }
        public String UName { get; set; }
        public String Title { get; set; }
        public String Name { get; set; }
        public String GTitle { get; set; }
        public String GName { get; set; }
        public String Gender { get; set; }
        public String DOB { get; set; }
        public String Mobile { get; set; }
        public String Email { get; set; }
        public String Address { get; set; }
        public String Country { get; set; }
        public String State { get; set; }
        public String City { get; set; }
        public String District { get; set; }
        public String DOJ { get; set; }

        public String PinCode { get; set; }
        public String Nominee { get; set; }
        public String Relation { get; set; }
        public String OTP { get; set; }
        public String PAN { get; set; }
        public String Bank { get; set; }
        public String AccType { get; set; }
        public String AccNo { get; set; }
        public String Branch { get; set; }
        public String IFSC { get; set; }
        public String AadhaarNo { get; set; }
        public String isProUp { get; set; }

        public String PanImage { get; set; }
        public String PStatus { get; set; }
        public String bankstatus { get; set; }
        public String BankImage { get; set; }
        public String AadharFront { get; set; }
        public String AadharBack { get; set; }
        public String AaStatus { get; set; }
        public String SponsorId { get; set; }

        public String SponsorStatus { get; set; }
        public String Alt_MobNo { get; set; }
        public String did { get; set; }
        public String Statename { get; set; }

        public String OnlinePanVerify { get; set; }
        public String OnlineBankVerify { get; set; }
        public String PANDetail { get; set; }
        public String BANKDetail { get; set; }
        public String DisplayName { get; set; }
        public String PSWRD { get; set; }
    }
}