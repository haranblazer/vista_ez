using System;
using System.Data.SqlClient;
using System.Web;

public partial class franchise_Certificate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (HttpContext.Current.Session["franchiseid"] != null)
            {
                SqlParameter[] param = new SqlParameter[]
               {
                new SqlParameter("@Franchiseid", Session["franchiseid"].ToString())
               };
                DataUtility objDu = new DataUtility();
                SqlDataReader dr = objDu.GetDataReader(param,
                @"Select FName, doe=convert(varchar(20), doe ,103), 
                TypeName=(Select Item_Desc from Item_Collection where Itemid=4 and UserVal=f.Frantype), 
                f.Frantype, f.State, f.City, f.distt
                from FranchiseMst f where Franchiseid=@Franchiseid");
                while (dr.Read())
                {
                    lbl_Name.Text = dr["FName"].ToString();
                    lbl_Doe1.Text = dr["doe"].ToString();
                    lbl_Type.Text = dr["TypeName"].ToString();
                    if (dr["Frantype"].ToString() == "2" || dr["Frantype"].ToString() == "3")
                        lbl_Area.Text = dr["State"].ToString(); 
                    else if (dr["Frantype"].ToString() == "4")
                        lbl_Area.Text = dr["State"].ToString() + " "+ dr["distt"].ToString();
                    else if(dr["Frantype"].ToString() == "5" || dr["Frantype"].ToString() == "6")
                        lbl_Area.Text = dr["State"].ToString() + " " + dr["distt"].ToString() + " " + dr["City"].ToString();

                }
            }
        }
    }
}