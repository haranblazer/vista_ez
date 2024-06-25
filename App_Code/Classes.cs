using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Classes
/// </summary>
public class Classes
{
    public Classes()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public class ProdDetails
    {
         public String Qury_product { get; set; }
        public String pname { get; set; }
        public String batchid { get; set; }
        public String ImageName { get; set; }
        public String MRP { get; set; }
        public String Descri { get; set; }
        public String MaxQty { get; set; }
        public String PackSizeName { get; set; }
        public String Pcode { get; set; }
       
    }


    public class VariantColorSize
    {
        public String Batchid { get; set; }
        public String balqty { get; set; }
        public String MRP { get; set; }
        public String ImageName { get; set; }

    }



}