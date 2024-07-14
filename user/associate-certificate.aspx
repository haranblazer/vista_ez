<%@ Page Language="C#" AutoEventWireup="true" CodeFile="associate-certificate.aspx.cs" Inherits="user_associate_certificate" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
 


<body>
 <button id="print">Download Pdf</button>
  
    <form id="form1">   
   <div id="printcontent">
     <center>
            <table style="font-size: 10px;  height: 816px; width: 1056px; background-image:url(images/associate-certificates.png);background-color:#ffffff;border-radius: 15px;">
                                                  <tr>
                                                  <td width="20%" valign="top"> <img src="images/rank.png" width="205px" style="margin: 31px 0px 0px 81px;"></td>
                                                  <td width="80%" style="padding:60px;">
                                                    <div style="">
                                                        <table width="100%">
                                                            <tbody>
                                                                <tr>
                                                                    <td align="center">                                                                    
                                                                         <img src="../images/<%=imgLogo%>" width="250px">
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div <%--style="padding-left: 113px;"--%>>
                                                    <center><h1 style=" font-size: 30pt; line-height: 1; color: #315787;    font-weight: 100;">Certificate of<br /> RANK ACHIEVER</h1></center>
                                                    <p style="font-size: 20px; text-align: center; line-height: 1.5;">
                                                    This is to certify that we have appoint <br />
                                                    <b><%=username%> </b>  <br />
                                                    as I.B.D. (Independent Business Developer) of  <br />
                                                    <b><%=userstate%></b> as <b><%=userGRank%></b> <br />
                                                    and is hereby authorized to promote and sell the products  <br />
                                                    marketed by Toptime as Per Toptime's price list and guidelines.
                                                    </p>
                            <p style="font-size: 16px; text-align: right; margin: 0px 0px 10px;">From <%=coName%>.</p> 
                            <p style="font-size: 16px; text-align: left; margin:0px;">Date: <%=curDate%></p>
                            <p style="font-size: 20px; text-align: right; margin: 0px 0px 10px;"><%=coHead%></p>
                            <p style="font-size: 16px; text-align: right; margin: 0px 0px 10px;"><%=headDegn%></p>                               
                                    </td>
                                               </tr>
                                            </table>
   
 
  </center>
    </div>

    </form>
    
    <script type="text/javascript">
        
        $('#print').click(function () {
            var divToPrint = document.getElementById('printcontent');

            var newWin = window.open('', 'Print-Window');

            newWin.document.open();

            newWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');

            newWin.document.close();

            setTimeout(function () { newWin.close(); }, 10);
        });


    </script>
</body>
</html>
