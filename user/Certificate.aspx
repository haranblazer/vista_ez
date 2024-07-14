<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="Certificate.aspx.cs" Inherits="franchise_Certificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <table id="lblprint" cellpadding="0">
        <tbody>
            <tr>
                <td valign="top">
                    <div id="PrintID">
                        <table id="Datalist1" cellspacing="0" cellpadding="3" border="0" style="font-family: Verdana; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <td style="color: Black; background-color: White;">
                                        <table cellspacing="5" cellpadding="3" border="0">
                                            <tbody>
                                                <tr>
                                                    <td style="color: Black; background-color: White;">
                                                        <div class="article">
                                                            <div style="font-size: 10px; background-image: url(images/certificate.jpg); background-repeat: no-repeat; height: 707px; width: 1000px;">
                                                                <div style="padding-left: 145px; padding-top: 157px; display: none;">
                                                                    <table>
                                                                        <tbody>
                                                                            <tr>
                                                                                <td></td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                                <div style="padding-left: 440px;padding-top: 363px;" class="article">
                                                                    <table>
                                                                        <tbody>
                                                                            <tr>
                                                                                <td>
                                                                                    <p style="font-size: 15px; font-weight: bold;">
                                                                                        
                                                                                    </p>
                                                                                </td>
                                                                                <td>
                                                                                    <p style="font-size: 15px; font-weight: bold;">
                                                                                        
                                                                                    </p>
                                                                                </td>
                                                                                <td>
                                                                                    <p style="font-size: 17px;font-family: arial;font-weight: 600;">
                                                                                        Testing
                                                                                    </p>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <p style="font-size: 15px; font-weight: bold; margin-top: 15px;">
                                                                                       
                                                                                    </p>
                                                                                </td>
                                                                                <td>
                                                                                    <p style="font-size: 15px; font-weight: bold; margin-top: 15px;">
                                                                                       
                                                                                    </p>
                                                                                </td>
                                                                                <td>
                                                                                    <p style="font-size: 17px; font-family: arial;font-weight: 600;  padding-left: 70px; margin-top: -6px;">
                                                                                       01/01/2021
                                                                                    </p>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <p style="font-size: 15px;  margin-top: 15px;">
                                                                                    
                                                                                    </p>
                                                                                </td>
                                                                                <td>
                                                                                    <p style="font-size: 15px; font-weight: bold; margin-top: 15px;">
                                                                                       
                                                                                    </p>
                                                                                </td>
                                                                                <td>
                                                                                    <p style="font-weight: 600;
    padding-left: 56px; margin-top: -4px;">
                                                                                        Diamond
                                                                                    </p>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <p style="font-size: 15px; font-weight: bold; margin-top: 15px;">
                                                                                       
                                                                                    </p>
                                                                                </td>
                                                                                <td>
                                                                                    <p style="font-size: 15px; font-weight: bold; margin-top: 15px;">
                                                                                        
                                                                                    </p>
                                                                                </td>
                                                                                <td>
                                                                                    <p style="font-size: 15px; margin-top: 15px;">
                                                                                      
                                                                                    </p>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
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


                            .style1 {
                                font-size: 6px;
                            }

                            table tr td {
                                font-size: 15px;
                                color: #2B2A29;
                                font-weight: bold;
                            }

                                table tr td p {
                                    line-height: 2;
                                }

                            .popup {
                                position: relative;
                                display: inline-block;
                                cursor: pointer;
                            }

                            .alert-danger {
                                background-color: #e53935;
                                border-color: #e53935;
                                color: #fff;
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
                                animation: fadeIn 1s;
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
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</asp:Content>

