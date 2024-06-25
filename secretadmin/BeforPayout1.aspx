<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="BeforPayout.aspx.cs" Inherits="admin_BeforPayout2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <table align="center" border="1" bordercolor="black" cellpadding="1" cellspacing="1"
        width="90%">
        <tr align="center" colspan="2">
            <td align="center" colspan="2" style="text-align: center">
                <font face="verdana,arial" size="2"><b>Payment Report</b></font>&nbsp;</td>
        </tr>
        <tr>
            <td align="center" valign="top" style="height: 33px">
                <font face="verdana,arial" size="2">From</font> <span style="font-family: Verdana">Date</span>
                &nbsp;<asp:TextBox ID="txtFddd" runat="server" MaxLength="2" Width="47px"></asp:TextBox>
                &nbsp; /<asp:TextBox ID="txtFmm" runat="server" MaxLength="2" Width="47px"></asp:TextBox>&nbsp;
                /&nbsp;
                <asp:TextBox ID="txtfyy" runat="server" MaxLength="4" Width="47px">200</asp:TextBox></td>
            <td align="center" valign="top" style="height: 33px">
                <font face="verdana,arial" size="2">To</font> Date&nbsp; &nbsp;
                <asp:TextBox ID="txttodd" runat="server" MaxLength="2" Width="47px"></asp:TextBox>&nbsp;
                /
                <asp:TextBox ID="txttomm" runat="server" MaxLength="2" Width="47px"></asp:TextBox>
                /&nbsp;
                <asp:TextBox ID="txttoyy" runat="server" MaxLength="4" Width="47px">200</asp:TextBox>
                <asp:Button ID="btnViewList" runat="server" Text="View List" Height="23px" /></td>
        </tr>
        <tr>
            <td align="center" colspan="2" style="height: 18px; text-align: left" valign="top">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
            </td>
        </tr>
    </table>
    <br />
    <table align="center" border="1" bordercolor="black" cellpadding="1" cellspacing="1"
        style="height: 207px" width="90%">
        <tr align="center" colspan="2">
            <td align="center" colspan="2" style="width: 583px; height: 98px; text-align: justify">
                <asp:GridView ID="grdPaymentReport" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84"
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" Height="53px"
                    HorizontalAlign="Center" Width="620px">
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <br />
    <table align="center" border="1" bordercolor="black" cellpadding="1" cellspacing="1"
        width="90%">
        <tr>
            <td align="center" colspan="2" style="height: 18px; text-align: center" valign="top">
                &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" ForeColor="Blue"
                    NavigateUrl="~/BeforPaymentReport.aspx" Width="46px">Back</asp:HyperLink></td>
        </tr>
    </table>
    <br />


</asp:Content>

