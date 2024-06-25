using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for common
/// </summary>
public class common
{
    public common()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static string ReturnJSON(DataTable dt)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        foreach (DataRow dr in dt.Rows)
        {
            row = new Dictionary<string, object>();
            foreach (DataColumn col in dt.Columns)
            {
                row.Add(col.ColumnName, dr[col]);
            }
            rows.Add(row);
        }
        string ret = serializer.Serialize(rows);
        return ret;
    }


    public static string CurrencyFormate(string Amount)
    {
        decimal Amt = Convert.ToDecimal(Amount, CultureInfo.InvariantCulture);
        //decimal parsed = decimal.Parse(Amount, CultureInfo.InvariantCulture);
        CultureInfo IN = new CultureInfo("en-IN");
        // string text = string.Format(hindi, "{0:c}", parsed);if you want Rs 77,43,450.00
        string FinalAamount = string.Format(IN, "{0:N}", Amt); 
        return FinalAamount.Substring(0, FinalAamount.Length - 3);  //if you want 77,43,450.00
    }
    public static string RS_Formate(string Amount)
    {
        decimal Amt = Convert.ToDecimal(Amount, CultureInfo.InvariantCulture);
        //decimal parsed = decimal.Parse(Amount, CultureInfo.InvariantCulture);
        CultureInfo IN = new CultureInfo("en-IN");
        // string text = string.Format(hindi, "{0:c}", parsed);if you want Rs 77,43,450.00
        return string.Format(IN, "{0:N}", Amt);  //if you want 77,43,450.00
    }
  
    public static TradeProp Trade_Income_slabs(string InvAmt, string OldAmt)
    {
        InvAmt = InvAmt == "" ? "0" : InvAmt;
        OldAmt = OldAmt == "" ? "0" : OldAmt;
  
        decimal TotalAmt = (Convert.ToDecimal(InvAmt) + Convert.ToDecimal(OldAmt));
        TradeProp objTrade = new TradeProp();
        objTrade.DISC_Perc = 0;
        objTrade.Delivery_Charges = 0;

        //if (TotalAmt >=9000)
        //{
        //    objTrade.DISC_Perc = 30;
        //}
        //else if (TotalAmt >= 5000 && TotalAmt <= 8999) 
        //{
        //    objTrade.DISC_Perc = 25;
        //}
        //else if (TotalAmt >= 2500 && TotalAmt <= 4999) 
        //{
        //    objTrade.DISC_Perc = 15;
        //} 
        //else if (TotalAmt <= 2499)
        //{
        //    objTrade.DISC_Perc = 5;
        //    objTrade.Delivery_Charges=90;
        //}
        return objTrade; 
    }

    

}
 public class TradeProp
{
    public decimal DISC_Perc { get; set; }
    public decimal Delivery_Charges { get; set; }
}