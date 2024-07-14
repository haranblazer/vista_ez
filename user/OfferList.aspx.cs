using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class user_OfferList : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand com = null;
    utility objUtil = null;
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindGrid(1);
        }

    }
    public void BindGrid(int active)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter da1;

            //da = new SqlDataAdapter("select id,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then(select 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria) as pf from offermst where offertype=2) when offerType=3 then(select 'BV on Rs-'+Convert(varchar(10),OfferCriteria) as pf1 from offermst where offertype=3)  end as offeron from offermst o where active=1 and vdata>=cast(cast(@vdata as float) as datetime) order by offertype", con);
            da = new SqlDataAdapter("select active,id,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria)  when offerType=3 then 'BV on Rs-'+Convert(varchar(10),OfferCriteria)  end as offeron from offermst o where active=@active   and vdata>=cast(cast(@vdata as float) as datetime) order by offertype", con);
            da.SelectCommand.Parameters.AddWithValue("@active", active);
            da.SelectCommand.Parameters.AddWithValue("@vdata", DateTime.UtcNow);
            dt = new DataTable();
            da.Fill(dt);
            //da1 = new SqlDataAdapter("select  p.productname,p.quantity,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then(select 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria) as pf from offermst where offertype=2) when offerType=3 then(select 'BV on Rs-'+Convert(varchar(10),OfferCriteria) as pf1 from offermst where offertype=3)  end as offeron,convert(varchar(10),vdata,103) as vdata,pamount,id from offermst o inner join offerproduct p on o.id=p.offerno where active=1 and vdata>=cast(cast(@vdata as float) as datetime)", con);
            da1 = new SqlDataAdapter("select p.productname,p.quantity,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria) when offerType=3 then 'BV on Rs-'+Convert(varchar(10),OfferCriteria)   end as offeron,convert(varchar(10),vdata,103) as vdata,pamount,id,p.productid from offermst o inner join offerproduct p on o.id=p.offerno where  o.active=@active and o.vdata>=cast(cast(@vdata as float) as datetime)", con);
            da1.SelectCommand.Parameters.AddWithValue("@active", active);
            da1.SelectCommand.Parameters.AddWithValue("@vdata", DateTime.UtcNow);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            if (dt.Rows.Count > 0)
            {
                ViewState["offer"] = dt1;
                grd1.DataSource = dt;
                grd1.DataBind();
            }
        }
        catch
        {
        }
    }
    //public void BindGrid()
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        SqlDataAdapter da1;
    //        //da = new SqlDataAdapter("select case when active=1 then 'Active' else 'Deactive' end as Actives,CONVERT(VARCHAR(15),VData,103)as VData,ID,PId,PName,Goffer,(case when OfferType=1 then NoOfProduct when OfferType=2 then Amount when OfferType=3 then BV end)as condition,(case when OfferType=1 then 'Product' when OfferType=2 then 'Amount' when OfferType=3 then 'BV' end)as PType from OfferMst  order by Id", con);
    //        da = new SqlDataAdapter("select convert(varchar(10),vdata,103) as vdata,id,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then(select 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria) as pf from offermst where offertype=2) when offerType=3 then(select 'BV on Rs-'+Convert(varchar(10),OfferCriteria) as pf1 from offermst where offertype=3)  end as offeron from offermst o where active=1 and vdata>=cast(cast(@vdata as float) as datetime) order by offertype", con);
    //        da.SelectCommand.Parameters.AddWithValue("@vdata", DateTime.UtcNow);
    //        dt = new DataTable();
    //        da.Fill(dt);
    //        da1 = new SqlDataAdapter("select  p.productname,p.quantity,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then(select 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria) as pf from offermst where offertype=2) when offerType=3 then(select 'BV on Rs-'+Convert(varchar(10),OfferCriteria) as pf1 from offermst where offertype=3)  end as offeron,convert(varchar(10),vdata,103) as vdata,pamount,id from offermst o inner join offerproduct p on o.id=p.offerno where active=1 and vdata>=cast(cast(@vdata as float) as datetime)", con);
    //        da1.SelectCommand.Parameters.AddWithValue("@vdata", DateTime.UtcNow);
    //        DataTable dt1 = new DataTable();
    //        da1.Fill(dt1);
    //        if (dt.Rows.Count > 0)
    //        {
    //            ViewState["offer"] = dt1;
    //            grd1.DataSource = dt;
    //            grd1.DataBind();
    //        }
    //    }
    //    catch
    //    {
    //    }
    //}
    protected void grd1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex >= 0)
        {
            if (ViewState["offer"] != null)
            {
                GridView gd = e.Row.FindControl("GridView2") as GridView;
                string offer = grd1.DataKeys[e.Row.RowIndex].Value.ToString();
                DataTable offerdt = ViewState["offer"] as DataTable;
                gd.DataSource = offerdt.Select("id=" + offer).CopyToDataTable();
                gd.DataBind();
            }
        }
    }
}