using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class secretadmin_UploadTDS : System.Web.UI.Page
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
                    SqlCommand cmd = new SqlCommand("AddTDSFile", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter tvparam = cmd.Parameters.AddWithValue("@dt", dt);
                    tvparam.SqlDbType = SqlDbType.Structured;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    GridView1.DataSource = dt;
                    GridView1.DataBind();

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

}