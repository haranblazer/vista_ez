using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_Default2 : System.Web.UI.Page
{

    utility objUtil = new utility();
    DataUtility dutil = new DataUtility();
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    DataTable dt = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            update();
    }


    private static Random random = new Random();
    public static string RandomString(int length)
    {
        const string chars = "abcdefghijklmnpqrstuvwxyz123456789";
        return new string(Enumerable.Repeat(chars, length)
          .Select(s => s[random.Next(s.Length)]).ToArray());
    }

    //base64Encode
    //protected void btnsubmit_Click(object sender, EventArgs e)
    //{

    //    try
    //    {

    //        con = new SqlConnection(method.str);
    //        string query1 = "select appmstid from appmst where appmstpassword='0' ";

    //        SqlCommand cmd = new SqlCommand(query1, con);
    //        con.Open();
    //        using (SqlDataReader reader = cmd.ExecuteReader())
    //        {
    //            while (reader.Read())
    //            {
    //                var randomPassword = RandomString(8);
    //                var enc = objUtil.base64Encode(randomPassword);
    //                Console.WriteLine("Executing Update Command...");
    //                string query2 = "update appmst set password=" + enc + " ";

    //                SqlCommand cmd2 = new SqlCommand(query2, con);
    //                cmd2.ExecuteNonQuery();

    //                Console.WriteLine("Update Command Executed!");
    //            }

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }


    //}

    void update()
    {
        SqlParameter[] param1 = new SqlParameter[] { };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param1, "select id from franchisemst where password='0' order by id ");
        foreach (DataRow row in dt.Rows)
        {
            var enc = objUtil.base64Encode(RandomString(8));
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("update franchisemst set password='" + enc + "' where id=" + row["id"].ToString(), con);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 99999;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }


    }
}