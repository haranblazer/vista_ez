<%@ WebHandler Language="C#" Class="FranchiseHandler" %>

using System;
using System.Web;

public class FranchiseHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection files = context.Request.Files;
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFile file = files[i];
                    string Result = files.AllKeys[i].ToString().ToLower();
                    Result = System.IO.Path.Combine(context.Server.MapPath("~/images/KYC/AadharImage/Front/"), Result);
                    file.SaveAs(Result);
                }
            }
            context.Response.ContentType = "text/plain";
        }
        catch (Exception er)
        {
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}