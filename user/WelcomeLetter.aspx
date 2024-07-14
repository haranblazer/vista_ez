<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WelcomeLetter.aspx.cs" MasterPageFile="user.master" Inherits="admin_WelcomeLetter" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1">
        <title>Welcome Letter</title>
        <link href="css/Style.css" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
        <style>
            tr:nth-child(even) {
                background-color: #ffffff;
                box-shadow: none;
                border: none;
            }

            tr {
                white-space: normal;
            }

                tr:nth-child(odd) {
                    background-color: #ffffff;
                    box-shadow: none;
                    border: none;
                }
        </style>
        <script src="datepick/jquery-1.4.2.min.js"></script>
        <script type="text/javascript">
            function Print() {
                //var prtContent = document.getElementById('printarea');
                //var WinPrint = window.open('', '', 'letf=0,top=0,width=800,height=100,toolbar=0,scrollbars=0,status=0,dir=ltr');
                //WinPrint.document.write(prtContent.innerHTML);
                //WinPrint.document.close();
                //WinPrint.focus();
                //WinPrint.print();
                //WinPrint.close();
                //prtContent.innerHTML = strOldOne;

                var divToPrint = document.getElementById('printarea');
                var popupWin = window.open('', '_blank', 'width=800,height=400,location=no,left=100px');
                popupWin.document.open();
                popupWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</html>');
                popupWin.document.close();
            }
        </script>

    </head>
    <body>
 <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                <h4 class="fs-20 font-w600  me-auto">Welcome Letter</h4> 
     <center> <input id="btnprint" type="button" onclick="Print()" value="Print" class="btn btn-primary" /></center>
            </div>
        <div id="printarea">

           
            <div class="col-md-12">
                <br />
                <center>
                    <div class="table-responsive">
                        <table width="100%">
                            <tr>
                                <td width="35%" height="100px" style="text-align: right;">
                                    <h3 style="margin: 5px;"><%=method.COMP_NAME %></h3>
                                    <p style="margin: 5px;"><%=method.COMP_ADDRESS%></p>
                                    <p style="margin: 5px;"><%=method.COMP_EMAIL%></p>
                                    <p style="margin: 5px;"><%=method.WEB_URL%></p>
                                    <p></p>
                                </td>
                                <td width="65%" height="50px" style="text-align: right">
                                    <img src="../images/logo.png" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <p style="margin-bottom: 0em; margin-top: 0em;">
                                        <span style="font-size: 15px; color: #000026; font-weight: normal;">Dear </span>
                                        <span style="font-size: 15px; font-weight: normal;">
                                            <asp:Label ID="lblname2" runat="server" Text="Label"></asp:Label></span>
                                        <br />
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- <span><asp:Label ID="lblmobileno" runat="server" ></asp:Label> </span>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>
                                        <asp:Label ID="lblAdress" runat="server"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>
                                        <asp:Label ID="lblemailid" runat="server"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td>ID No.  <span>
                                    <asp:Label ID="lbluserid" runat="server"></asp:Label>
                                </span>
                                </td>
                            </tr>
                            <tr>
                                <td>D.O.J <span>
                                    <asp:Label ID="lbldoj" runat="server"></asp:Label>
                                </span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <p style="margin: 0em;">
                                       We warmly welcome you to the <%=method.COMP_SHORT_NAME %>. family as an Associate.
                                    </p>
                                    <p style="margin: 0.5em 0em 0em 0em; text-align: justify;">
                                        At <%=method.COMP_SHORT_NAME %>, we believe in the principle of Ayurveda that states "When the nutrition is wrong medicine is of no use, and when the nutrition is top, medicine has no use". Our objective is to ensure that everyone works towards achieving success, growth, and prosperity in a timely manner, while also prioritizing their health. As mentioned in the Atharva Veda, good health is the foundation for achieving success.

                                      
                                    </p>
                                    <p style="margin: 0.5em 0em 0em 0em; text-align: justify;">
                                       As part of the <%=method.COMP_SHORT_NAME %> family, we want to provide our associates with a lifetime opportunity to grow financially by promoting and using quality Ayurvedic and natural supplements, personal care supplements, beauty care supplements, healthy recreation & rejuvenation, lifestyle enhancement dietetics & products, and creating a value-based eco-friendly community.
                                    </p>
                                    <p style="margin: 0.5em 0em 0em 0em; text-align: justify;">
                                      <%=method.COMP_SHORT_NAME %> is known for manufacturing ayurvedic herbal products of international standards with superior efficacy and the highest safety. Their strong Research and Development Team has developed several products that have been launched in the Indian market. <%=method.COMP_SHORT_NAME %> has several quality certifications like ISO 9001:2008, ISO 22000:2005, HACCP, GMP, WHO GMP, and 100% Organic Certified Products.
                                    </p>
                                    <p style="margin: 0.5em 0em 0em 0em; text-align: justify;">
                                       <%=method.COMP_SHORT_NAME %> offers a unique purchase value-based business plan that ensures much higher returns for our associates in India. Our business plan includes several opportunities for funding, bonuses, tours, and rewards. These plans will not only enhance your trust and value within your team but also encourage you to develop instant bonding with them.
                                    </p>
                                    <p style="margin: 0.5em 0em 0em 0em; text-align: justify;">
                                        We assure you that you are in safe hands and welcome you to reach out to <%=method.COMP_SHORT_NAME %> leaders, staff, and management for any support you need in building your business. Please do not hesitate to provide us feedback or suggestions on any aspects of our working.
                                    </p>
                                    <p style="margin: 0.5em 0em 0em 0em; text-align: justify;">
                                       If you have any questions, please feel free to call us on our customer care number 0000000000.
                                    </p>
                                    <p style="margin: 0.5em 0em 0em 0em; text-align: justify; display:none;">
                                       We wish you all the best in your journey with <%=method.COMP_SHORT_NAME %> and assure you of our commitment to providing quality care in a warm and friendly environment.
                                    </p>
                                   
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <p style="font-size: 15px; margin: 1em 0em 0em 0em; float: left; color: #000026; font-weight: normal;">Best Wishes</p>

                                </td>
                            </tr>

                            <tr style="display: none;">
                                <td colspan="2">Regards<br />
                                    For (  <span>
                                        <asp:Label ID="lblcname" runat="server"></asp:Label>
                                    </span>)<br />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">

                                    <h4 style="margin: 0px; color: #000;"><%=coHeadName%></h4>
                                    <p style="margin: 0px;"><%=coHeadDesignation%></p>
                                    <p style="display: none;">
                                        <span style="font-size: 15px; display: none; color: #000026; font-weight: normal; margin-top: -20px">
                                            <asp:Label ID="lblcompanyaddress" runat="server"></asp:Label>
                                        </span>
                                    </p>
                                </td>

                            </tr>
                            <tr style="display: none;">
                                <td colspan="2">
                                    <p>
                                        If you have any suggestions to improve our services, Please write to us at   <span>
                                            <asp:Label ID="lblcemailid" runat="server"></asp:Label>
                                        </span>
                                    </p>

                                </td>

                            </tr>
                            <tr>
                                <td colspan="2">
                                    <p style="text-align: center; margin: 0px; text-align: right;">
                                        Computer generated document, no requirement of signature and seal.
                                    </p>
                                </td>
                            </tr>
                          <%--  <tr>
                                <td colspan="2" align="center">
                                    <img src="images/tag-line.jpg" width="100%" style="width: 400px;" />
                                </td>
                            </tr>--%>
                            <tr style="display: none;">
                                <td colspan="2">
                                    <p>
                                        Please contact us
                    for any clarification:   <span>
                        <asp:Label ID="lblcemailid2" runat="server"></asp:Label>
                    </span>
                                    </p>
                                    <br />
                                </td>
                            </tr>


                        </table>
                    </div>
                </center>
            </div>
        </div>
         <hr />
      
        <br />
    </body>
    </html>
</asp:Content>
