<%@ Page Language="C#" AutoEventWireup="true" CodeFile="invoice-new.aspx.cs" Inherits="secretadmin_invoice_new" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     <div class="right-sign">
        <img src="images/right-sign.png">
     </div>
       <div class="tax-invoice">
        <img src="images/tax-invoice.png">
      </div>

    <header class="clearfix">
      <img src="images/logo.png" width="250px">
            
      <div class="clearfix"></div><br /><br />  

      <div id="project">
      <div ><span>Seller: </span></div>
        <div><span>User Id: </span> 12345</div>
        <div class="total-bold">TOPTIME NETWORK PRIVATE LIMITED</div>
        <div>E-58, Old Industrial Area,<br />
Haridwar, Uttarakhand, Pin Code: 249401</div>
<div><span>Tel : </span> 9761957347</div>
<div><span>Email:</span> support@toptimenet.com</div>
<br />
        <div><span>GSTIN :</span> J05AAFCT7889N1ZE</div>
        <div><span>PAN :</span> AAFCT7889N</div>
        <div><span>CIN :</span> U74999DL2016PTC300844</div>
        <div><span>Invoice No. :</span> CF12345/20/0816</div>
        <div><span>Invoice Date :</span> Sept. 9, 2020</div>
        <div><span>Date PO No. :</span>  FPO189791/20/9/6      </div>
        <div><span>E-Way Bill No. : </span>    NA    </div>
      </div>

      <div id="company" class="clearfix">

        <div ><span>Buyer: </span></div>
        <div><span>User Id: </span> 189791</div>
        <div class="total-bold">Jindal Distributors</div>
        <div>Shree shyam kunj, Chirwapatty road<br />
Tinsukia, Assam, Pin Code: 786125
</div>
<div><span>Tel : </span> 9435036035</div>
<div><span>Email:</span>  umeshjindal@rediffmail.com</div>
<br />
        <div><span>GSTIN :</span> 18ABMPA8791M1ZX</div>
        <div><span>PAN :</span> ABMPA8791M</div>
        <div><span>CIN :</span> NA</div>
        <div><span>Invoice No. :</span> NA</div>
        <div><span>Invoice Date :</span> NA</div>
        <div><span>Date PO No. :</span>  NA      </div>
        <div><span>E-Way Bill No. : </span>    NA    </div>

      </div>


    </header>
    <main>
      <table>
        <thead>
          <tr style="background:#f47d35;">
            <th class="service total-bold">#</th>
            <th class="desc total-bold">Product Name</th>
            <th class="total-bold">HSN CODE</th>
            <th class="total-bold">Unit Price</th>
            <th class="total-bold">Billed Qty</th>
            <th class="total-bold">Actual Qty.</th>
            <th class="total-bold">Value</th>
            <th class="total-bold">GST</th>
            <th class="total-bold">Tax</th>
            <th class="total-bold">Total</th>
            <th class="total-bold">PV</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="service">1</td>
            <td class="desc">Strechez Cream (50 gms) Batch No. TOP20H37 / MFG Dt. 8-2020 / EXP Dt. 7-2023</td>
            <td class="unit">30049011</td>
            <td class="qty">111.61</td>
            <td class="total">40</td>
             <td class="total">40</td>
              <td class="total">4464.40</td>
               <td class="total">12.0</td>
                <td class="total">535.73</td>
                <td class="total">5000.13</td>
                <td class="total">2840.0</td>
          </tr>
          <tr>
            <td class="service">1</td>
            <td class="desc">Strechez Cream (50 gms) Batch No. TOP20H37 / MFG Dt. 8-2020 / EXP Dt. 7-2023</td>
            <td class="unit">30049011</td>
            <td class="qty">111.61</td>
            <td class="total">40</td>
             <td class="total">40</td>
              <td class="total">4464.40</td>
               <td class="total">12.0</td>
                <td class="total">535.73</td>
                <td class="total">5000.13</td>
                <td class="total">2840.0</td>
          </tr>
          <tr>
            <td class="service">1</td>
            <td class="desc">Strechez Cream (50 gms) Batch No. TOP20H37 / MFG Dt. 8-2020 / EXP Dt. 7-2023</td>
            <td class="unit">30049011</td>
            <td class="qty">111.61</td>
            <td class="total">40</td>
             <td class="total">40</td>
              <td class="total">4464.40</td>
               <td class="total">12.0</td>
                <td class="total">535.73</td>
                <td class="total">5000.13</td>
                <td class="total">2840.0</td>
          </tr>
          <tr>
            <td class="service">1</td>
            <td class="desc">Strechez Cream (50 gms) Batch No. TOP20H37 / MFG Dt. 8-2020 / EXP Dt. 7-2023</td>
            <td class="unit">30049011</td>
            <td class="qty">111.61</td>
            <td class="total">40</td>
             <td class="total">40</td>
              <td class="total">4464.40</td>
               <td class="total">12.0</td>
                <td class="total">535.73</td>
                <td class="total">5000.13</td>
                <td class="total">2840.0</td>
          </tr>
          <tr>
            <td class="service">1</td>
            <td class="desc">Strechez Cream (50 gms) Batch No. TOP20H37 / MFG Dt. 8-2020 / EXP Dt. 7-2023</td>
            <td class="unit">30049011</td>
            <td class="qty">111.61</td>
            <td class="total">40</td>
             <td class="total">40</td>
              <td class="total">4464.40</td>
               <td class="total">12.0</td>
                <td class="total">535.73</td>
                <td class="total">5000.13</td>
                <td class="total">2840.0</td>
          </tr>

          <tr>
            <td class="service">1</td>
            <td class="desc">Strechez Cream (50 gms) Batch No. TOP20H37 / MFG Dt. 8-2020 / EXP Dt. 7-2023</td>
            <td class="unit">30049011</td>
            <td class="qty">111.61</td>
            <td class="total">40</td>
             <td class="total">40</td>
              <td class="total">4464.40</td>
               <td class="total">12.0</td>
                <td class="total">535.73</td>
                <td class="total">5000.13</td>
                <td class="total">2840.0</td>
          </tr>
           <tr>
            <td class="service">1</td>
            <td class="desc">Strechez Cream (50 gms) Batch No. TOP20H37 / MFG Dt. 8-2020 / EXP Dt. 7-2023</td>
            <td class="unit">30049011</td>
            <td class="qty">111.61</td>
            <td class="total">40</td>
             <td class="total">40</td>
              <td class="total">4464.40</td>
               <td class="total">12.0</td>
                <td class="total">535.73</td>
                <td class="total">5000.13</td>
                <td class="total">2840.0</td>
          </tr>
          <tr>
            <td class="service">1</td>
            <td class="desc">Strechez Cream (50 gms) Batch No. TOP20H37 / MFG Dt. 8-2020 / EXP Dt. 7-2023</td>
            <td class="unit">30049011</td>
            <td class="qty">111.61</td>
            <td class="total">40</td>
             <td class="total">40</td>
              <td class="total">4464.40</td>
               <td class="total">12.0</td>
                <td class="total">535.73</td>
                <td class="total">5000.13</td>
                <td class="total">2840.0</td>
          </tr>
          <tr>        
          
            <td colspan="5" style="text-align:left" class="total-bold">Total</td>
             <td class="total-bold">511</td>
              <td class="total-bold">511</td>
               <td class="total-bold">84650.70</td>
                <td class="total-bold">10737.44</td>
                <td class="total-bold">95388.14</td>
                <td class="total-bold"">71125.0</td>
          </tr>
          
        
        </tbody>
        </table>

         <table style="width:68%; float:left">
     <thead>
          <tr>           
            <th class="total-bold">HSN Code</th>
            <th class="total-bold">GST Rate</th>
            <th class="total-bold">Taxable Value</th>
            <th class="total-bold">CGST</th>
            <th class="total-bold">SGST</th>
            <th class="total-bold">IGST</th>           
          </tr>
        </thead>
        <tbody>
          <tr>            
            <td >63079090</td>
            <td>5.0</td>
            <td>5000.10</td>
            <td>0.00</td>
            <td>0.00</td>
            <td>250.00</td>
          </tr>
            <tr>            
            <td >63079090</td>
            <td>5.0</td>
            <td>5000.10</td>
            <td>0.00</td>
            <td>0.00</td>
            <td>250.00</td>
          </tr>
            <tr>            
            <td >63079090</td>
            <td>5.0</td>
            <td>5000.10</td>
            <td>0.00</td>
            <td>0.00</td>
            <td>250.00</td>
          </tr>
          <tr>        
          
            <td colspan="4" style="text-align:left" class="total-bold">Total</td>
         
                <td class="total-bold">95388.14</td>
                <td class="total-bold"">71125.0</td>
          </tr>
        
        </tbody>
      </table>
    
        <table style="width:30%; margin-left: 2%; float:left">
     
          <tr>
            <td style="border-bottom: none;" class="total-bold">Gross Total Value :</td>
            <td class="total" style="border-bottom: none;">95388.14</td>
          </tr>
          <tr>
            <td style="border-bottom: none;" class="total-bold">Discount :</td>
            <td class="total" style="border-bottom: none;">197.00</td>
          </tr>
          <tr>
            <td  class="total-bold" style="border-bottom: none;">Courier Charges</td>
            <td class="grand total" style="border-bottom: none;">0.00</td>
          </tr>
           <tr>
            <td  class="total-bold" >Net Total Value(Rs) :</td>
            <td class="grand total">95191.14</td>
          </tr>
          <tr>
            <td  class="total-bold">Gross Weight :</td>
            <td class="total-bold">105.505</td>
          </tr>
        
      </table>
    <hr />
      <div id="notices" style="width:45%;  float:left;">
        <div><b>Terms & Conditions:</b></div>
        <div class="notice">

1. All Disputes are subject to jurisdiction of Thane only.<br />
2. Company is not responsible after the goods leave the premises.<br />
3. Any inaccuracy in this bill must be notified within 7 days of receipt of Bill.<br />
4. Goods provided Free of Cost / Offer, subject to reversal of input tax credit of
GST as prevailing.<br />
5. Goods bought by the puchaser for self consumption purposes, ITC will not be
available.<br />
6. Goods bought by the puchaser for self consumption purposes, ITC will not be
available.<br /></div>
      </div>
      <div style="width:50%; float:left; margin-left:5%">
        <div>For</div>
        <div class="notice">

Seller Name: <b>TOPTIME NETWORK PRIVATE LIMITED</b>
This is computer generated invoice, thus any physical signature not
required.<br /></div>
      </div>
    </main>
      <br />  <br />  <br />
   <%-- <footer>
      Invoice was created on a computer and is valid without the signature and seal.
    </footer>--%>
    </form>
    <style>
    .clearfix:after {
  content: "";
  display: table;
  clear: both;
}

a {
  color: #5D6975;
  text-decoration: underline;
}

body {
  position: relative;
  width: 23cm;  
 /* height: 29.7cm; */
  margin: 0 auto; 
  color: #001028;
  background: #FFFFFF; 
  font-family: Arial, sans-serif; 
  font-size: 12px; 
  font-family: Arial;
}

header 
{
    position: relative;
 padding: 10px 0;
    margin-bottom: 30px;
    width: 17cm;
    margin: auto;

}
.right-sign
{
    position: absolute;
    }
    .tax-invoice{
    position: absolute;
    right: 220px;
    }

#logo {
  text-align: center;
  margin-bottom: 10px;
}

#logo img {
  width: 90px;
}

h1 {
  border-top: 1px solid  #5D6975;
  border-bottom: 1px solid  #5D6975;
  color: #5D6975;
  font-size: 2.4em;
  line-height: 1.4em;
  font-weight: normal;
  text-align: center;
  margin: 0 0 20px 0;
  background: url(dimension.png);
}
.total-bold
{
    font-weight:bold;
    }
#project {
     float: left;
    width: 40%;
}

#project span {
 color: #5D6975;
    text-align: left;
    width: 90px;
    margin-right: 10px;
    display: inline-block;
    font-size: 1.0em;
    line-height: 1.5;
}
#company span
{
    font-weight: bold;
     color: #5D6975;
    text-align: left;
    width: 90px;
    margin-right: 10px;
    display: inline-block;
    font-size: 1.0em;
    line-height: 1.5;
    }

#company {
      float: left;
    /* text-align: right; */
    width: 40%;
    margin-left: 20%;
}

#project div,
#company div {
  /*white-space: nowrap;   */     
}

table {
  width: 100%;
 /* border-collapse: collapse;*/
  border-spacing: 0;
  margin-bottom: 20px;
}

table tr td {
  /*background: #F5F5F5;*/
  border-bottom: 2px dotted #000;
}

table th,
table td {
  text-align: left;
}

table th {
  padding: 5px;
  color: #000;
      border-bottom: 2px dotted #000000;
  white-space: nowrap;        
  font-weight: normal;
}

table .service,
table .desc {
  text-align: left;
}

table td {
  padding: 5px;
  /*text-align: right;*/
}

table td.service,
table td.desc {
  vertical-align: top;
}

table td.unit,
table td.qty,
table td.total {
  font-size: 1.2em;
}

table td.grand {
  /*border-top: 1px solid #5D6975;*/
   border-bottom: 2px dotted #000;
}

#notices .notice {
  color: #5D6975;
  font-size: 1.2em;
}

footer {
  color: #5D6975;
  width: 100%;
  height: 30px;
  position: absolute;
  bottom: 0;
  border-top: 1px solid #C1CED9;
  padding: 8px 0;
  text-align: center;
}
#project span {
    font-weight: bold;
}
    </style>
</body>
</html>
