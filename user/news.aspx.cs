using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class user_news : System.Web.UI.Page
{
    SqlConnection con = null;
    InsertFunction insFunc = new InsertFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/Default.aspx");
        }

        if (!IsPostBack)
        {
            
            go();
        }
    }

    private void go()
    {
        String Result = "";
        DataUtility objDu = new DataUtility();
        DataSet ds = new DataSet();
        DataTable dt = objDu.GetDataTableSP("GetNews");
        RepterDetails.DataSource = dt;
        RepterDetails.DataBind();  
    }

    //private void go()
    //{
    //    String Result = "";
    //    DataUtility objDu = new DataUtility();
    //    DataTable dt = objDu.GetDataTableSP("GetNews");
    //    foreach (DataRow dr in dt.Rows)
    //    {
    //        Result += "<p class='text-dark-gray row align-items-center mt-3'><i class='material-icons icon-muted mr-2'>event</i> <strong>" + dr["doe"].ToString() + "</strong></p>";
    //        Result += " <div class='row align-items-center projects-item mb-1'>";
    //        Result += " <div class='col-sm-auto mb-1 mb-sm-0'> <div class='text-dark-gray'>" + dr["samay"].ToString() + "</div> </div>";
    //        Result += " <div class='col-sm'><div class='card m-0'><div class='px-4 py-3'> <div class='row align-items-center'> <div class='col' style='min-width: 300px'> ";
    //        Result += " <div class='d-flex align-items-center'> <a href='#' class='text-body'><strong class='text-15pt mr-2'>" + dr["NewsMstTitle"].ToString() + "</strong></a></div>";
    //        Result += "<div class=' card-group-row align-items-center'>";

    //        Result += "<div class='col-md-2 col-xs-12 zoom' style='z-index:999;'>";
    //        Result += "<input type='checkbox' id='zoomCheck'>";
    //        Result += "<label for='zoomCheck'>";
    //        Result += dr["photo"].ToString(); 
    //        Result += "</label>";
    //        Result += "</div>";
    //        Result += "<div class='col-md-10 col-xs-12'> <p>" + dr["newsmstdiscription"].ToString() + "</div></p>";
           
    //        Result +=   "</div>";
    //        Result +=   "</div>";
    //        Result += "</div>";
    //        Result +=  "</div>";
    //        Result +=" </div>";
    //        Result += "</div>";
    //        Result += "</div>";  
            
  


    //    }
    //    newsdata.InnerHtml = Result;
    //}

    
}