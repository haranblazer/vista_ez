using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_ProductSoon : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd = null;
    DataTable dt = null;
    SqlDataAdapter sda = null;
    SqlDataReader sdr;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            bind();
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        cmd = new SqlCommand("Promoproduct", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@pname", txtproduct.Text);
        cmd.Parameters.AddWithValue("@action", "insert");
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        utility.MessageBox(this, "Product Added Successfully");
        bind();

    }


    public void bind()
    {
        sda = new SqlDataAdapter("Promoproduct", con);
        sda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sda.SelectCommand.Parameters.AddWithValue("@action", "show");
        dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();

        }



    }

    //public List<Product> bind()
    //{
    //    using (SqlConnection con = new SqlConnection(method.str))
    //    {
    //        SqlCommand cmd = new SqlCommand("Promoproduct", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@action", "show");
    //        if (con.State == ConnectionState.Open)
    //            con.Close();
    //        else
    //            con.Open();

    //        using (SqlDataReader dr = cmd.ExecuteReader())
    //        {

    //            List<Product> p = new List<Product>();
    //            while(dr.Read())
    //            {
    //                p.Add(new Product());



    //            }



    //        }


    //    }

    //}



    //class Product
    //{


    //    public string pname
    //    {
    //        get;
    //    }


    //    public string pname
    //    {
    //        set;
    //    }

    //}


}