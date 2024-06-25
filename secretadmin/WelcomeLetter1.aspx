<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WelcomeLetter1.aspx.cs" Inherits="yesadmin_WelcomeLetter1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
            <center>

                            
            <asp:Repeater ID="Repeater1" runat="server" 
                    onitemdatabound="Repeater1_ItemDataBound">
                <HeaderTemplate></HeaderTemplate>
                <ItemTemplate>
            <table cellpadding="0" cellspacing="0" id="AutoNumber1" class="datatable" style="width: 692px;">

                <tr>
                     
                    <td>
                        <p class="MsoNormal" style="margin: 0in 0in 10pt; text-align: left;">
                            <span style="font-size: 8pt; text-transform: uppercase; color: #3e3f41; line-height: 115%;
                                font-family: 'Trebuchet MS','sans-serif'">
                                <asp:Image ID="imgLogo" runat="server" Height="100px"  Width="270px" ImageUrl="~/images/logo.png"  /></span></p>
                    </td>
                </tr>

                </tr>


                <tr>

                    <td style="height: 23px; text-align: left">
                        <asp:Label ID="lblDOJ" runat="server" Font-Bold="False" Font-Names="Arial" Font-Size="10pt" Text='<%#Eval("appmstdoj")%>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="text-align: left">&nbsp;</td>
                </tr>
                <tr id="print_click">
                    <td style="height: 23px; text-align: left;">
                        <table id="Table1" cellspacing="0" runat="server">
                            <tr>
                                <td style="width: 80px;">
                                    <span style="font-size: 9pt; font-family: Arial"><strong>
                                        <asp:Label ID="Label1" runat="server" Font-Names="Arial" Font-Size="9pt" Text='<%#Eval("appmsttitle")%>'></asp:Label>
                                        <asp:Label ID="lblClientName" runat="server" Font-Names="Arial" Font-Size="9pt" Text='<%#Eval("appmstfname")%>'></asp:Label></strong></span></td>
                                <td style="width: 12px">
                                    <strong></strong>
                                </td>
                                <td style="text-align: left"></td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-family: Arial">
                                        <asp:Label ID="lblAdress" runat="server" Width="250px" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("AppMstAddress1")%>'></asp:Label><br />
                                        <asp:Label ID="lblCity" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("AppMstCity")%>'></asp:Label>
                                        <asp:Label ID="lblState" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("AppMstState")%>'></asp:Label>
                                        <asp:Label ID="lblpincode" runat="server" Font-Size="9pt" Font-Names="Arial" Text='<%#Eval("AppMstPinCode")%>'></asp:Label></span></td>
                                <td style="width: 12px"></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-size: 9pt; font-family: Arial"><strong>User Id: &nbsp;<asp:Label
                                        ID="lblID" runat="server" Font-Names="Arial" Font-Bold="false" Font-Size="9pt" Text='<%#Eval("Appmstregno")%>' ></asp:Label></strong></span></td>
                                <td style="width: 12px;"></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-size: 9pt; font-family: Arial"><strong>&nbsp;</strong></span></td>
                                <td style="width: 12px">
                                    <strong></strong>
                                </td>
                                <td style="text-align: left"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: justify; line-height: 18px; width: 100%;">
                        <span style="text-transform: none; line-height: 115%; font-family: Tahoma; mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: 'Times New Roman'; mso-bidi-theme-font: minor-bidi; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">
                            <table cellspacing="0" style="font-size: 10pt" width="100%">

                                <tr>
                                    <td style="width: 100%">
                                        <span style="font-family: Arial">DEAR </span>
                                        <asp:Label ID="lblfname" runat="server" Font-Bold="true"
                                            Font-Names="Arial" Font-Size="10pt" Text='<%#Eval("appmsttitle")%>' ></asp:Label><%#Eval("appmstfname")%><span style="font-family: Arial"></span></td>
                                </tr>
                                <tr style="font-family: Arial">
                                    <td style="width: 100%; height: 15px;"></td>
                                </tr>
                                <tr style="font-family: Arial">
                                    <td style="width: 100%"> We take a great pleasure in welcoming you to the
                                         <asp:Label ID="lblCompanyName1" runat="server" Text='<%#Eval("companyname")%>'></asp:Label>
&nbsp;Family.<br />
                                        <br />
                                        Starting today, you are in the company of one of the India's premier direct marketing Company
                                        (<span style="text-transform: none; line-height: 115%; font-family: Tahoma; mso-fareast-font-family: Calibri;
                            mso-fareast-theme-font: minor-latin; mso-bidi-font-family: 'Times New Roman';
                            mso-bidi-theme-font: minor-bidi; mso-ansi-language: EN-US; mso-fareast-language: EN-US;
                            mso-bidi-language: AR-SA">
                             <asp:Label ID="lblCompanyName2" runat="server" Text='<%#Eval("companyname")%>'></asp:Label>
                        </span>) 
                       offering best products and services encompass every sphere of life. This includes a wide array of products and services.<br />
                                        <br />
                                        To avail these services, please meet your introducer or our Relationship Manager.
                                        Do not forget to quote your User Id as mentioned below, which is a unique identifier
                                        for all your  transactions.<br />
                                        <br />
                                        Your Unique User Id:
                                        <asp:Label ID="lblUniqueID" runat="server" Font-Names="Arial" Font-Size="9pt" Text='<%#Eval("Appmstregno")%>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td style="width: 100%; height: 34px;">Please note that your User Id is valid for 
                        <span style="text-transform: none; line-height: 115%; font-family: Tahoma; mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: 'Times New Roman'; mso-bidi-theme-font: minor-bidi; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">
                            <span style="text-transform: none; line-height: 115%; font-family: Tahoma; mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: 'Times New Roman'; mso-bidi-theme-font: minor-bidi; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">
                                <asp:Label ID="lblCompanyName3" runat="server" Text='<%#Eval("companyname")%>' ></asp:Label>
                            </span>
                        </span>&nbsp;account(s):
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100%; padding-left: 50px;">
                                        <table style="width: 50%; border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid;">
                                            <tr>
                                                <td style="border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; background-color: #000000; text-align: center; color: #ffffff;">User Id</td>
                                                <td style="border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; background-color: #000000; text-align: center; color: #ffffff;">Password</td>
                                                <td style="border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; background-color: #000000; text-align: center; color: #ffffff;">Package</td>
                                                <td style="border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; background-color: #000000; text-align: center; color: #ffffff;">Amount</td>
                                            </tr>
                                            <tr>
                                                <td style="border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; text-align: center;">
                                                    <asp:Label ID="lblID1" runat="server" Font-Names="Arial" Font-Size="9pt" Text='<%#Eval("Appmstregno")%>'></asp:Label></td>
                                                <td style="border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; text-align: center;">
                                                    <asp:Label ID="lblPwd" runat="server" Font-Names="Arial" Font-Size="9pt" Text='<%#Eval("AppMstPassword")%>'></asp:Label></td>
                                                <td style="border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; text-align: center;">
                                                    <asp:Label ID="lblPackgName" runat="server"  Text='<%#Eval("productname")%>' ></asp:Label></td>
                                                <td style="border-right: #dddddd 1px solid; border-top: #dddddd 1px solid; border-left: #dddddd 1px solid; border-bottom: #dddddd 1px solid; text-align: center;" >
                                                    <asp:Label ID="lblAmount" runat="server"  Text='<%#Eval("productamount")%>'></asp:Label></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100%; height:30px">
                                    We, at <asp:Label ID="lblcompany" runat="server" Font-Bold="False" Font-Names="Arial" Font-Size="10pt" Text='<%#Eval("companyname")%>'></asp:Label>
                                     believe in providing world class services to our customers. 
                                    </td>

                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100%; height: 30px">Assuring you of our best services at all times. We look forward to a long and
                                         mutually beneficial relationship.
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100%; height: 2px"></td>
                                </tr>
                            </table>
                        </span><span style="font-size: 10pt; font-family: Arial"></span>
                    </td>
                </tr>

                <tr style="font-size: 10pt; font-family: Arial">
                    <td style="width: 100%; line-height: 15px; text-align: justify">
                        <span style="font-family: Arial; font-size: 10pt;">Warm regards,</span></td>
                </tr>


                <tr style="font-size: 10pt; font-family: Arial">
                    <td style="width: 100%; line-height: 18px; text-align: justify">
                        <asp:Label ID="lblCompnyHead" runat="server" Font-Names="Arial" Font-Size="10pt" Text='<%#Eval("CompanyHead")%>'></asp:Label></td>
                </tr>
                <tr style="font-size: 10pt; font-family: Arial">
                    <td style="width: 100%; line-height: 18px; text-align: justify">
                        Group Head - Advisory</td>
                </tr>
                <tr style="font-size: 10pt; font-family: Arial">
                    <td style="width: 100%; line-height: 18px; text-align: justify">
                        <asp:Label ID="lblCName3" runat="server" Font-Bold="False" Font-Names="Arial" Font-Size="10pt" Text='<%#Eval("companyname")%>'></asp:Label></td>
                </tr>
                <tr>


                </tr>

              

                </table>
                <pre></pre>
           
                     </ItemTemplate>

                <FooterTemplate>

                 
                
                  </FooterTemplate>
                  <SeparatorTemplate>
                            <pre style="page-break-before: always">
                            </pre>
                        </SeparatorTemplate>
              

                 
            </asp:Repeater>

            <h2></h2>
        </center>
    
    </form>
</body>
</html>
