using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_Test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(method.str);
        using (SqlCommand cmd = new SqlCommand("GetBlogCategories_Tags", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            lstFruits.DataSource = ds.Tables[0];
            lstFruits.DataBind();
        }


        }

        protected void Submit(object sender, EventArgs e)
    {
        string message = "";
        foreach (ListItem item in lstFruits.Items)
        {
            if (item.Selected)
            {
                message += item.Text + " " + item.Value + "\\n";
            }
        }
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('"
        + message + "');", true);
    }
}