using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class User_EventImg : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.Count > 0)
        {
            if (Request.QueryString["Eid"] != null)
            {
                DataUtility objDu = new DataUtility();
                SqlParameter[] param1 = new SqlParameter[]
                {
                    new SqlParameter("@Eid", Request.QueryString["Eid"].ToString()),
                    new SqlParameter("@SessionUserId", Session["userId"].ToString())
                };
                DataTable dt = objDu.GetDataTable(param1, @"Select E_Type,
                Img1,Img2,Img3,Img4,Img5, Status1=isnull(Status1,0), Status2=isnull(Status2,0) 
                from tbl_UserEvent where SessionUserId=@SessionUserId and Eid=@Eid");
                if (dt.Rows.Count > 0)
                {
                    lbl_EventType.Text = dt.Rows[0]["E_Type"].ToString();
                    dvPreview1.InnerHtml = "<img src='../UploadAdmin/" + dt.Rows[0]["Img1"].ToString() + "' style='height:112px; width:105px'>";
                    dvPreview2.InnerHtml = "<img src='../UploadAdmin/" + dt.Rows[0]["Img2"].ToString() + "' style='height:112px; width:105px'>";
                    dvPreview3.InnerHtml = "<img src='../UploadAdmin/" + dt.Rows[0]["Img3"].ToString() + "' style='height:112px; width:105px'>";
                    dvPreview4.InnerHtml = "<img src='../UploadAdmin/" + dt.Rows[0]["Img4"].ToString() + "' style='height:112px; width:105px'>";
                    dvPreview5.InnerHtml = "<img src='../UploadAdmin/" + dt.Rows[0]["Img5"].ToString() + "' style='height:112px; width:105px'>";

                    hnd_Img1.Value = dt.Rows[0]["Img1"].ToString();
                    hnd_Img2.Value = dt.Rows[0]["Img2"].ToString();
                    hnd_Img3.Value = dt.Rows[0]["Img3"].ToString();
                    hnd_Img4.Value = dt.Rows[0]["Img4"].ToString();
                    hnd_Img5.Value = dt.Rows[0]["Img5"].ToString();
                }
                else
                {
                    btn_Submit.Visible = false;
                }
            }
        }
    }



    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        try
        {
            string Img1 = "", Img2 = "", Img3 = "", Img4 = "", Img5 = "";
            string Random = Guid.NewGuid().ToString();
            if (FU_Img1.HasFile)
            {
                Img1 = "Event1_" + Random + Path.GetExtension(FU_Img1.FileName);
                var Event1_Img = Server.MapPath("~/UploadAdmin/" + hnd_Img1.Value);
                if (File.Exists(Event1_Img))
                    File.Delete(Event1_Img);
            }
            if (FU_Img2.HasFile)
            {
                Img2 = "Event2_" + Random + Path.GetExtension(FU_Img2.FileName);
                var Event2_Img = Server.MapPath("~/UploadAdmin/" + hnd_Img2.Value);
                if (File.Exists(Event2_Img))
                    File.Delete(Event2_Img);
            }
            if (FU_Img3.HasFile)
            {
                Img3 = "Event3_" + Random + Path.GetExtension(FU_Img3.FileName);
                var Event3_Img = Server.MapPath("~/UploadAdmin/" + hnd_Img3.Value);
                if (File.Exists(Event3_Img))
                    File.Delete(Event3_Img);
            }
                
            if (FU_Img4.HasFile)
            {
                Img4 = "Event4_" + Random + Path.GetExtension(FU_Img4.FileName);
                var Event4_Img = Server.MapPath("~/UploadAdmin/" + hnd_Img4.Value);
                if (File.Exists(Event4_Img))
                    File.Delete(Event4_Img);
            }
                
            if (FU_Img5.HasFile)
            {
                Img5 = "Event5_" + Random + Path.GetExtension(FU_Img5.FileName);
                var Event5_Img = Server.MapPath("~/UploadAdmin/" + hnd_Img5.Value);
                if (File.Exists(Event5_Img))
                    File.Delete(Event5_Img);
            }
                

            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Eid", Request.QueryString["Eid"].ToString()),
                new SqlParameter("@SessionUserId", Session["userId"].ToString()),
                new SqlParameter("@Img1", Img1),
                new SqlParameter("@Img2", Img2),
                new SqlParameter("@Img3", Img3),
                new SqlParameter("@Img4", Img4),
                new SqlParameter("@Img5", Img5),
            };
            string Result = objDu.ExecuteSql(param, @"Update tbl_UserEvent Set 
            Img1 = (Case when @Img1 = '' then Img1 else @Img1 End),
	        Img2 = (Case when @Img2 = '' then Img2 else @Img2 End), 
	        Img3 = (Case when @Img3 = '' then Img3 else @Img3 End), 
	        Img4 = (Case when @Img4 = '' then Img4 else @Img4 End), 
	        Img5 = (Case when @Img5 = '' then Img5 else @Img5 End) 
	        where SessionUserId=@SessionUserId and Eid=@Eid").ToString();
            if (Result == "1")
            {
                if (FU_Img1.HasFile)
                    FU_Img1.PostedFile.SaveAs(Server.MapPath("~/UploadAdmin/" + Img1));
                if (FU_Img2.HasFile)
                    FU_Img2.PostedFile.SaveAs(Server.MapPath("~/UploadAdmin/" + Img2));
                if (FU_Img3.HasFile)
                    FU_Img3.PostedFile.SaveAs(Server.MapPath("~/UploadAdmin/" + Img3));
                if (FU_Img4.HasFile)
                    FU_Img4.PostedFile.SaveAs(Server.MapPath("~/UploadAdmin/" + Img4));
                if (FU_Img5.HasFile)
                    FU_Img5.PostedFile.SaveAs(Server.MapPath("~/UploadAdmin/" + Img5));

                Response.Redirect("AddUserEvent.aspx");
            }
            else
            {
                utility.MessageBox(this, "Error. Please try again.!!");
            }
        }
        catch (Exception ex) { }
    }
}