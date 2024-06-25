<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FranchiseIDCard.aspx.cs"
    Inherits="secretadmin_FranchiseIDCard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Franchise ID Card</title>
    <script language="javascript" type="text/javascript">
        function PrintDiv() {
            var myContentToPrint = document.getElementById("FranchiseIDPrint");
            var myWindowToPrint = window.open('', '', 'width=1200,height=800,toolbar=0,scrollbars=-1,status=0,resizable=-1,location=0,directories=0, font size=6, ');
            myWindowToPrint.document.write(myContentToPrint.innerHTML);
            myWindowToPrint.document.close();
            myWindowToPrint.focus();
            myWindowToPrint.print();
            myWindowToPrint.close();
        }
    </script>
</head>
<body>
    <form id="FranchiseIDPrint" runat="server">
    <table id="lblprint" runat="server" cellpadding="0">
        <tr>
            <td valign="top">
                <asp:DataList ID="DataFranIDCard" runat="server" RepeatDirection="Horizontal" CellPadding="3"
                    Font-Names="Verdana" RepeatColumns="4">
                    <ItemStyle BackColor="White" ForeColor="Black" />
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" style="width: 5cm; height: 8cm; border: solid 1px #D0D0D0;
                            margin: ">
                            <tr>
                                <td valign="top" colspan="2">
                                    <table style="width: 5.3cm; height: 2cm; border-bottom: solid 1px black;">
                                        <tr>
                                            <td style="text-align: center; width: 1cm;" valign="top">
                                                <img src="../images/logo.png" alt="logo" width="120px" style="text-align: center;" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center; width: 6cm;" valign="middle">
                                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("companyname") %>' Font-Bold="true"
                                                    Style="margin-top: 2px" Font-Size="9px"></asp:Label><br />
                                                <asp:Label ID="Label3" runat="server" Text="Franchise Card" Font-Bold="true" Style="margin-top: 2px"
                                                    Font-Size="9px"></asp:Label>
                                                <%--<asp:Label ID="Label3" runat="server" Text="LIMITED" Font-Bold="true" Font-Size="7px"></asp:Label>--%>
                                            </td>
                                        </tr>
                                        <tr valign="top">
                                            <td style="padding-left: 5px; width: 5cm;" colspan="2" align="center">
                                                <asp:Label ID="lblCAddress" runat="server" Text='<%# Bind("Address") %>' Font-Size="10px"
                                                    Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="width: 3.5cm; height: 2.2cm;text-align:left">
                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("UserName") %>' Font-Bold="true"
                                        Width="3.5cm" Font-Size="9px" Style="margin-left: 3px"></asp:Label><br />
                                    <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("UserAddress") %>' Font-Size="9px"
                                        Style="margin-left: 3px;" Width="3.0cm"></asp:Label>
                                    <%-- <table cellpadding="0" cellspacing="0" >
                                        <tr>
                                            <td style="padding-left: 5px; width: 3.5cm;" valign="top">
                                              
                                            </td>
                                        </tr>
                                    </table>--%>
                                </td>
                                <td valign="top" align="right" style="text-align: right;">
                                    <%--<div style="width: 1.5cm; height: 2.2cm; border: solid 1px #D0D0D0;">
                                    </div>--%>
                                    <table cellpadding="0" cellspacing="0" style="width: 1.7cm; height: 2.0cm; border: solid 1px #D0D0D0;">
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" colspan="2">
                                    <table cellpadding="0" cellspacing="0" style="width: 5cm; height: 1.5cm;">
                                        <tr>
                                            <td style="padding-left: 5px; font-size: 9px;">
                                                <span style="font-size: 9px;">MOBILE NO</span>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("MobileNo") %>' Font-Size="9px"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 5px; font-size: 9px;">
                                                <span style="font-size: 9px;">USER ID</span>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("UserId") %>' Font-Size="9px"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 5px; font-size: 9px;">
                                                <span style="font-size: 10px;">ISSUE DATE</span>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("DOJ","{0:dd/MM/yyyy}") %>'
                                                    Font-Size="9px"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="display: none">
                                            <td style="padding-left: 5px;">
                                                <span style="font-size: 9px;">SPONSOR ID</span>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("Sponsorid") %>' Font-Size="9px"></asp:Label>
                                            </td>
                                        </tr>
                                        <%--<tr>
                                            <td style="padding-left: 5px;">
                                                <span style="font-size: 9px;">Rank</span>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("Rank") %>' Font-Size="9px"></asp:Label>
                                            </td>
                                        </tr>--%>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-size: 8px; text-align: right; padding-right: 25px;" colspan="2">
                                    <br />
                                    Auth Sign
                                    <br />
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </td>
        </tr>
    </table>
    </form>
    <table id="tbl">
        <tr>
            <td style="text-align: center;">
                <input type="button" onclick="PrintDiv()" class="hide" value="Print" />
            </td>
        </tr>
    </table>
</body>
</html>
