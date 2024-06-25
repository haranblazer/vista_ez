<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="ProductDetail.aspx.cs" Inherits="d2000admin_ProductDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="font-family: Arial; font-size: 10pt; width: 100%;">
        <tr>
            <td style="text-align: left; vertical-align: top;">
                <table class="style1">
                    <tr>
                        <td class="style2" colspan="2">
                            <asp:Label ID="lblMessage" Font-Bold="True" Font-Size="13px" runat="server" ForeColor="#C00000"
                                Text="Product Added Successfully!"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style3">
                            Product Name:
                        </td>
                        <td>
                            <asp:Label ID="lblProductName" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style3">
                            MRP:
                        </td>
                        <td>
                            <asp:Label ID="lblMRP" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style3">
                            DP:
                        </td>
                        <td>
                            <asp:Label ID="lblDP" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style3">
                            BV
                        </td>
                        <td>
                            <asp:Label ID="lblBV" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style3">
                            Description:
                        </td>
                        <td>
                            <asp:Label ID="lblDescription" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style3">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table class="style1">
                    <tr>
                        <td>
                            <asp:Image ID="imgProduct" runat="server" Width="200" ImageUrl="images/noImage.jpeg" />
                        </td>
                    </tr>
                </table>
                <table class="style1">
                    <tr>
                        <td class="style4">
                        </td>
                        <td style="vertical-align: bottom;">
                            <table id="Table1" class="style1" runat="server" visible="false">
                                <tr>
                                    <td>
                                        <asp:Image ID="imgThumbnail" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>Thumbnail View</b>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr runat="server" id="CI">
            <td style="text-align: left">
                <asp:Label ID="Label1" runat="server" ForeColor="White"></asp:Label>
                <br />
                <asp:Button ID="btnCancel" runat="server" Text="Go Back" OnClick="btnCancel_Click" />
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
