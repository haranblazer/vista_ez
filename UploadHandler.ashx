<%@ WebHandler Language="C#" Class="UploadHandler" %>

using System;
using System.Web;

public class UploadHandler : IHttpHandler
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
                
                    Result = System.IO.Path.Combine(context.Server.MapPath("~/User/PaymentSlip/"),  Result);
                    file.SaveAs(Result);
                    
                }
            }
            context.Response.ContentType = "text/plain";
            //  context.Response.Write("File Uploaded Successfully!");
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