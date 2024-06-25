<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IDCard.aspx.cs" Inherits="admin_IDCard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ID Card</title>
    <style type="text/css">
        .my-header {
            display: none;
        }

        #my-footer {
            display: none;
        }

        .image-resize {
            width: 142px;
            height: 142px;
            border-radius: 50%;
        }

        tr:nth-child(odd) {
            background-color: none !important;
            box-shadow: none !important;
            border: none;
        }

        tr:nth-child(even) {
            background-color: none !important;
            box-shadow: none !important;
            border: none;
        }

        /* *
        {
            margin: 0px;
            font-size: 9px;
            font-family: Arial, Helvetica, sans-serif;
            padding: 0px;
        }
        body
        {
            margin: 0;
            font-size: 9px !important;
            font-family: Arial, Helvetica, sans-serif !important;
        }*/
        .style1 {
            font-size: 6px;
        }

        table tr td {
            font-size: 15px;
            color: #315787;
            font-weight: bold;
        }

        .popup {
            position: relative;
            display: inline-block;
            cursor: pointer;
        }

            /* The actual popup (appears on top) */
            .popup .popuptext {
                visibility: hidden;
                width: 160px;
                background-color: #555;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 8px 0;
                position: absolute;
                z-index: 1;
                bottom: 125%;
                left: 50%;
                margin-left: -80px;
            }

                /* Popup arrow */
                .popup .popuptext::after {
                    content: "";
                    position: absolute;
                    top: 100%;
                    left: 50%;
                    margin-left: -5px;
                    border-width: 5px;
                    border-style: solid;
                    border-color: #555 transparent transparent transparent;
                }

            /* Toggle this class when clicking on the popup container (hide and show the popup) */
            .popup .show {
                visibility: visible;
                -webkit-animation: fadeIn 1s;
                animation: fadeIn 1s
            }

        /* Add animation (fade in the popup) */
        @-webkit-keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        blink {
            font-size: 18px;
            color: Red;
        }

        p {
            display: block;
            margin-block-start: 0em;
            margin-block-end: 0em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
        }

        [dir=ltr] p {
            margin-top: 0;
            margin-bottom: 0.20rem;
        }
    </style>
    <script language="javascript" type="text/javascript">
        function printDiv() {

            var divToPrint = document.getElementById('form1');

            var newWin = window.open('', 'Print-Window');

            newWin.document.open();

            newWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');

            newWin.document.close();

            setTimeout(function () { newWin.close(); }, 10);

        }
    </script>
</head>
<body>
    <form runat="server" id="form1">


        <table id="lblprint" runat="server" cellpadding="0">
            <tbody>
                <tr>
                    <td valign="top">
                        <asp:DataList ID="Datalist1" runat="server" RepeatDirection="Horizontal" CellPadding="3"
                            Font-Names="Verdana" RepeatColumns="4">
                            <ItemStyle BackColor="White" ForeColor="Black" />
                            <ItemTemplate>
                                <div style="background-image: url(images/staff-id1.jpg); border: 1px solid #000000; border-radius: 15px; font-size: 10px; background-repeat: no-repeat; height: 480px; width: 365px;">
                                                                    <div style="margin: 2.5em 0 0 4.5em;">
                                                                        <table width="100%">
                                                                            <tbody>
                                                                                <tr style="background: none!important">
                                                                                    <td align="center">
                                                                                         <asp:Image ID="Image2" runat="server" ImageUrl='<%# "~/images/"+Eval("CompanyLogo") %>' style="width: 200px; border-width: 0px;" />
                                                                                 
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div style="padding-left: 145px; margin-top: 2.2em;">
                                                                        <table>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td>
                                <asp:Image ID="Image1" runat="server" class="image-resize" ImageUrl='<%# "~/images/KYC/ProfileImage/"+Eval("imagename") %>' style="height: 142px; width: 142px; border-width: 0px; border: 2px solid #ff0041; border-radius: 10px;" />
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div style="padding-left: 100px; margin-top: 15px;" class="article">
                                                                        <table>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td>
                                                                                        <p style="font-size: 15px; color: #808080; font-weight: bold; line-height: 1.4; margin: 0px">
                                                                                            User Name :
                                                                                            <asp:Label ID="lblName" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
                                                                                        </p>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <p style="font-size: 15px; color: #808080; font-weight: bold; line-height: 1.4; margin: 0px">
                                                                                            User ID :
                                                                                             <asp:Label ID="Label7" runat="server" Text='<%# Bind("UserID") %>'></asp:Label>
                                                                                        </p>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <p style="font-size: 15px; color: #808080; font-weight: bold; line-height: 1.4; margin: 0px">
                                                                                            Rank :
                                                                                             <asp:Label ID="Label4" runat="server" Text='<%# Bind("Generation_Rank") %>'></asp:Label>
                                                                                        </p>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <p style="font-size: 15px; color: #808080; font-weight: bold; line-height: 1.4; margin: 0px">
                                                                                            State :
                                                                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("UserState") %>'></asp:Label>
                                                                                        </p>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div style="margin-top: 55px; text-align: center; background: #ff0041; color: #fff; border-radius: 0 0 15px 15px; padding: 5px; font-size: 12px;">
                                                                      <%=method.COMP_ADDRESS%>
                                                                            <asp:Label ID="Label6" runat="server"></asp:Label>
                                                                    </div>
                                                                </div>


                                <table cellspacing="5" cellpadding="3" border="0" style="display:none;">
                                    <tbody>
                                        <tr>
                                           
                                            <td>
                                                <td style="color: Black; background-color: White;">
                                                    <div style="border: 1px solid #000000; font-size: 10px; border-radius: 15px; background-repeat: no-repeat; height: 8.5cm; width: 5.5cm; margin-left: -1.5em;">

                                                        <table width="100%" style="">
                                                            <tbody>
                                                                <tr style="background: none!important">
                                                                    <td align="center">
                                                                        <p style="font-size: 9px; line-height: 1.4; color: #808080; font-weight: bold; margin-bottom: 0px; margin-top: 5px;">
                                                                            The Id holder is authorised to sell products of Toptime Network Pvt. Ltd.
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>


                                                        <table width="100%" style="">
                                                            <tbody>
                                                                <tr>
                                                                    <td align="center">
                                                                        <asp:Image ID="Image3" runat="server" ImageUrl='<%# "~/images/"+Eval("CompanyLogo") %>' Width="140px" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>


                                                        <table width="100%" style="">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <ul style="margin: 0px; font-size: 10px; line-height: 1.4; padding: 0 0 0 28px;">
                                                                            <li>Quality Products</li>
                                                                            <li>Transparent Business Plan</li>
                                                                            <li>World Class Own Manufacturing</li>
                                                                        </ul>

                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>

                                                        <center>
                                                            <hr style="margin: 2px 0 2px 0">
                                                        </center>
                                                        <div style="width: 90%; margin: auto;">
                                                            <p style="font-size: 9px; color: #808080; margin-bottom: 0.2em; line-height: 0.8; font-weight: bold;">
                                                                In case of loss/if found return it to:
                                                            </p>
                                                            <p style="font-size: 11px; color: #000; font-weight: bold; margin-bottom: 0.2em; line-height: 1;">
                                                                Toptime Network Pvt. Ltd.
                                                            </p>

                                                            <p style="font-size: 10px; color: #808080; margin-bottom: 0.2em; line-height: 1;">
                                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("CoAddres2") %>'></asp:Label>
                                                            </p>
                                                            <p style="font-size: 11px; color: #000; margin-bottom: 0.2em; font-weight: bold; line-height: 1;">
                                                                Corporate Office:
                                                            </p>
                                                            <p style="font-size: 10px; color: #808080; margin-bottom: 0.2em; line-height: 1;">
                                                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("CoAddress") %>'></asp:Label>
                                                            </p>

                                                            <hr style="margin: 0.5em 0;">
                                                            <center>
                                                                <p style="font-size: 11px; color: #808080; margin-top: 0.2em; line-height: 1;">
                                                                    This is computer generated card.
                                                                </p>
                                                            </center>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td></td>
                                        </tr>
                                    </tbody>
                                </table>

                            </ItemTemplate>
                        </asp:DataList>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <table id="tbl">
        <tr>
            <td style="text-align: center;">
                <%--   <asp:Button ID="Button1" runat="server" Text="PRINT" OnClientClick="PrintDiv()" />--%>
                <input type="button" onclick="printDiv()" class="btn btn-success" value="Print" />
            </td>
        </tr>
    </table>
</body>
</html>
