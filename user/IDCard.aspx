<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IDCard.aspx.cs" MasterPageFile="user.master" Inherits="admin_IDCard" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
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

            tr {
                white-space: normal;
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
        </style>
        
 
        <script>
            function printDiv(divName) {

                var printContents = document.getElementById(divName).innerHTML;

                var originalContents = document.body.innerHTML;

                document.body.innerHTML = printContents;

                window.print();

                document.body.innerHTML = originalContents;

            }
        </script>
        <script>
            // When the user clicks on <div>, open the popup
            function myFunction() {
                var popup = document.getElementById("myPopup");
                popup.classList.toggle("show");
            }
        </script>
    </head>
    <body>
        <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
            <h4 class="fs-20 font-w600  me-auto">ID Card</h4>
            <input type="button" onclick="printDiv('printableArea')" class="btn btn-primary" value="Print" />

        </div>
        <div class="table-responsive">
            <center>
                <div id="printableArea">
                      
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
                                                                    <asp:Image ID="Image2" runat="server" ImageUrl='<%# "~/images/"+Eval("CompanyLogo") %>' Width="200px" />
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
                                                                    <asp:Image ID="Image1" runat="server" class="image-resize" ImageUrl='<%# "~/images/KYC/ProfileImage/"+Eval("imagename") %>' Width="142px" Height="142px" Style="border: 2px solid #ff0041; border-radius: 10px;" />
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
                                                                    <p style="font-size: 15px; color: #808080; font-weight: bold; line-height: 1.4; margin:0px">
                                                                        User Name :                                                                           
                                                                            <asp:Label ID="lblName" runat="server" Text='<%# Bind("appmstfname") %>'></asp:Label>
                                                                    </p>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <p style="font-size: 15px; color: #808080; font-weight: bold; line-height: 1.4; margin:0px">
                                                                        User ID :                                                                           
                                                                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("appmstregno") %>'></asp:Label>
                                                                    </p>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <p style="font-size: 15px; color: #808080; font-weight: bold; line-height: 1.4; margin:0px">
                                                                        Rank :
                                                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("RePurchase_rankName") %>'></asp:Label>
                                                                    </p>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <p style="font-size: 15px; color: #808080; font-weight: bold; line-height: 1.4; margin:0px">
                                                                        State :                                                                     
                                                                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("Appmststate") %>'></asp:Label>
                                                                    </p>
                                                                </td>
                                                            </tr>

                                                         
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div style="margin-top: 82px; text-align: center; background: #ff0041; color: #fff; border-radius: 0 0 15px 15px; padding: 5px; font-size: 12px;">
                                                    
                                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("address") %>'></asp:Label></div>
                                            </div>

                                            <td style="color: Black; background-color: White; display: none">
                                                <div style="border: 1px solid #000000; font-size: 10px; border-radius: 15px; background-repeat: no-repeat; height: 8.5cm; width: 5.5cm; margin-left: -0.1em;">

                                                    <table width="100%" style="">
                                                        <tbody>
                                                            <tr style="background: none!important">
                                                                <td align="center">
                                                                    <p style="font-size: 9px; line-height: 1.4; color: #808080; font-weight: bold; margin-bottom: 0px; margin-top: 5px;">
                                                                        The Id holder is authorised to sell products of <%=method.COMP_NAME %>
                                                                    </p>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>


                                                    <table width="100%" style="">
                                                        <tbody>
                                                            <tr>
                                                                <td align="center">
                                                                    <img src="<%=method.COMP_MAIN_LOGO %>" style="width: 140px;" />

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
                                                        <p style="font-size: 11px; color: #000; font-weight: bold; margin-bottom: 0.2em; line-height: 1; display: none;">
                                                            <%=method.COMP_NAME %>
                                                        </p>

                                                        <p style="font-size: 10px; color: #808080; margin-bottom: 0.2em; line-height: 1; display: none;">
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("CoAddres2") %>'></asp:Label>
                                                        </p>
                                                        <p style="font-size: 11px; color: #000; margin-bottom: 0.2em; font-weight: bold; line-height: 1;">
                                                            Corporate Office:
                                                        </p>
                                                        <p style="font-size: 10px; color: #808080; margin-bottom: 0.2em; line-height: 1;">
                                                            <%=method.COMP_ADDRESS %>
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


                                        </ItemTemplate>
                                    </asp:DataList>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <style>
                             p {
                display: block;
                margin-block-start: 0em;
                margin-block-end: 0em;
                margin-inline-start: 0px;
                margin-inline-end: 0px;
            }
                        </style>
                </div>
                <table id="tbl">
                    <tr>
                        <td style="text-align: center;">
                            <%--   <asp:Button ID="Button1" runat="server" Text="PRINT" OnClientClick="PrintDiv()" />--%>
               
                        </td>
                    </tr>
                </table>


            </center>
        </div>
        <br />
        <div class="popup" onclick="myFunction()">
            <blink>Printer Setting ?</blink>
            <span class="popuptext" id="myPopup">
                <img src="images/popup.jpg" class="img-responsive" /></span>
        </div>

        <%---------------------New--------------- --%>
        <%--  <table cellpadding="0" style="display:none;">
         
        </table>--%>

        <script type="text/javascript">
            function blink() {
                var blinks = document.getElementsByTagName('blink');
                for (var i = blinks.length - 1; i >= 0; i--) {
                    var s = blinks[i];
                    s.style.visibility = (s.style.visibility === 'visible') ? 'hidden' : 'visible';
                }
                window.setTimeout(blink, 1000);
            }
            if (document.addEventListener) document.addEventListener("DOMContentLoaded", blink, false);
            else if (window.addEventListener) window.addEventListener("load", blink, false);
            else if (window.attachEvent) window.attachEvent("onload", blink);
            else window.onload = blink;
        </script>
       
    </body>
    </html>

</asp:Content>
