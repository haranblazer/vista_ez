using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class franchise_TransporterList : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");
         
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            
            string Query =@" Select Tid, TransporterName, Address, MobileNo, Emailid, GSTNO,
        ContactPerson, State, District, Pincode, Freight, FuelCharges, FOVChages, DocketCharges, HandlingCharges, ODA, OtherChages, Isactive, 
        RoleMode = (Select stuff((select Item_Desc + '<br/> ' from Item_Collection where ItemId = 8 and UserVal in(Select items From dbo.Split(RoleMode, ',')) 
        for xml path(''), type).value('.', 'nvarchar(max)'), 1, 0, '')) from TransporterMst where Franchiseid='" + HttpContext.Current.Session["franchiseid"].ToString() + "' order by TransporterName";
            SqlDataReader dr = objDu.GetDataReader(Query);
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails(); 
                data.Tid = dr["Tid"].ToString();
                data.TransporterName =  dr["TransporterName"].ToString();
                data.ContactPerson = dr["ContactPerson"].ToString();
                data.MobileNo = dr["MobileNo"].ToString();
                data.Emailid = dr["Emailid"].ToString();
                data.Isactive = dr["Isactive"].ToString();
                data.RoleMode = dr["RoleMode"].ToString();
                data.State = dr["State"].ToString();

                data.District = dr["District"].ToString();
                data.Pincode = dr["Pincode"].ToString();
                data.Address = dr["Address"].ToString();
                data.GSTNO = dr["GSTNO"].ToString();
                data.Freight = dr["Freight"].ToString();
                data.FuelCharges = dr["FuelCharges"].ToString();
                data.FOVChages = dr["FOVChages"].ToString();
                data.DocketCharges = dr["DocketCharges"].ToString();
                data.HandlingCharges = dr["HandlingCharges"].ToString();
                data.ODA = dr["ODA"].ToString();
                data.OtherChages = dr["OtherChages"].ToString(); 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
         public string Tid { get; set; }
        public string TransporterName { get; set; }
        public string ContactPerson { get; set; }
        public string MobileNo { get; set; }
        public string Emailid { get; set; }
        public string Isactive { get; set; }
        public string RoleMode { get; set; }
        public string State { get; set; } 
                   

        public string District { get; set; }
        public string Pincode { get; set; }
        public string Address { get; set; }
        public string GSTNO { get; set; }
        public string Freight { get; set; }
        public string FuelCharges { get; set; }
        public string FOVChages { get; set; }
        public string DocketCharges { get; set; }
        public string HandlingCharges { get; set; }
        public string ODA { get; set; }
        public string OtherChages { get; set; } 
    }

    #endregion



    //protected void btn_search_Click(object sender, EventArgs e)
    //{
    //    BindProduct();
    //}

    //public void BindProduct()
    //{
    //    DataUtility objDu = new DataUtility();
    //    DataTable dt = objDu.GetDataTable(@" Select Tid, TransporterName, Address, MobileNo, Emailid, GSTNO,
    //    ContactPerson, State, District, Pincode, Freight, FuelCharges, FOVChages, DocketCharges, HandlingCharges, ODA, OtherChages, Isactive, 
    //    RoleMode = (Select stuff((select Item_Desc + '<br/> ' from Item_Collection where ItemId = 8 and UserVal in(Select items From dbo.Split(RoleMode, ',')) 
    //    for xml path(''), type).value('.', 'nvarchar(max)'), 1, 0, '')) from TransporterMst where Franchiseid='"+ Session["franchiseid"].ToString()+"' order by TransporterName");
    //    Session["dt"] = dt;
    //    if (dt.Rows.Count > 0)
    //    {
    //        dglst.DataSource = dt;
    //        dglst.DataBind();
    //    }
    //    else
    //    {
    //        dglst.DataSource = null;
    //    }
    //}


    //protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    dglst.PageIndex = e.NewPageIndex;
    //    BindProduct();
    //}



    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        dt = (DataTable)Session["dt"];

    //        if (dt.Rows.Count > 0)
    //        {
    //            Response.ClearContent();
    //            Response.Buffer = true;
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "TransporterList.xls"));
    //            Response.ContentType = "application/ms-excel";
    //            string str = string.Empty;
    //            foreach (DataColumn dtcol in dt.Columns)
    //            {
    //                Response.Write(str + dtcol.ColumnName);
    //                str = "\t";
    //            }
    //            Response.Write("\n");
    //            foreach (DataRow dr in dt.Rows)
    //            {
    //                str = "";
    //                for (int j = 0; j < dt.Columns.Count; j++)
    //                {
    //                    Response.Write(str + Convert.ToString(dr[j]));
    //                    str = "\t";
    //                }
    //                Response.Write("\n");
    //            }
    //            Response.End();
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
    //        }
    //    }
    //    catch (Exception er) { }

    //}
     
}