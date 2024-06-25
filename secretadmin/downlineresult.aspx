<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="downlineresult.aspx.cs" Inherits="admin_downlineresult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div id="title" class="b2">
        <h2>
            Downline Result</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <table style="width:100%;">
  
        <tr id="Tr3" runat="server" visible="false">
            <td>
                <table>
                    <tr>
                        <td style="width: 49px; text-align: left">
                            <span style="font-size: 10pt; font-family: Arial"><strong>AXIS</strong></span></td>
                        <td style="width: 70px; text-align: left">
                            <asp:RadioButton ID="rbtnAxis" runat="server" Checked="True" Font-Bold="True" Font-Size="X-Small"
                                GroupName="r" Width="70px" CssClass="radios" /></td>
                        <td style="width: 32px; text-align: left">
                            <span style="font-size: 10pt; font-family: Arial"><strong>ICICI </strong></span>
                        </td>
                        <td style="width: 77px">
                            <asp:RadioButton ID="rbtnICICI" runat="server" Font-Bold="True" Font-Size="X-Small"
                                GroupName="r" Width="74px" CssClass="radios" /></td>
                        <td style="width: 24px; text-align: left">
                            <span style="font-size: 10pt; font-family: Arial"><strong>PNB </strong></span>
                        </td>
                        <td style="width: 85px">
                            <asp:RadioButton ID="rbtnPNB" runat="server" Font-Bold="True" Font-Size="X-Small"
                                GroupName="r" Width="71px" CssClass="radios" /></td>
                        <td style="width: 137px">
                            <strong><span style="font-size: 10pt; font-family: Arial">BANK OF BARODA</span></strong></td>
                        <td style="width: 75px">
                            <asp:RadioButton ID="rbtnBOB" runat="server" Font-Bold="True" Font-Size="X-Small"
                                GroupName="r" Width="68px" CssClass="radios" /></td>
                        <td style="width: 43px">
                            <strong><span style="font-size: 10pt; font-family: Arial">HDFC</span></strong></td>
                        <td style="width: 85px">
                            <asp:RadioButton ID="rbtnHDFC" runat="server" Font-Bold="True" Font-Size="X-Small"
                                GroupName="r" Width="76px" CssClass="radios" /></td>
                        <td style="width: 85px">
                            <strong><span style="font-size: 10pt; font-family: Arial">SBI</span></strong></td>
                        <td style="width: 85px">
                            <asp:RadioButton ID="rbtnSBI" runat="server" Font-Bold="True" Font-Size="X-Small"
                                GroupName="r" Width="66px" CssClass="radios" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="Tr4" runat="server" visible="false">
            <td style="width: 100%; height: 17px; text-align: center">
                <span style="font-size: 12pt; font-family: Arial; text-align: center"><strong>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 20%; text-align: left; height: 26px; font-family: Arial; font-size: 10pt">
                                Cheque number (from):&nbsp;
                            </td>
                            <td style="width: 30%; text-align: left; height: 26px;">
                                <asp:TextBox ID="TxtPaymentTrandraftid" runat="server"></asp:TextBox></td>
                            <td style="width: 20%; text-align: left; height: 26px; font-family: Arial; font-size: 10pt">
           
                                Cheque number (to):</td>
                            <td style="width: 30%; text-align: left; height: 26px; font-family: Arial; font-size: 10pt">
           
                            <asp:TextBox ID="TxtNoChq" runat="server"></asp:TextBox>
                <span style="font-size: 12pt; font-family: Arial; text-align: center"><strong>
                    &nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" CssClass="btn" />
                </strong></span>
                            </td>
                        </tr>
                    </table>
                </strong></span>
            </td>
        </tr>
       
        <tr>
            <td>
                <table>
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="User Id"></asp:Label>
                            &nbsp;<asp:Label ID="LblRegNo" runat="server" Font-Bold="True"></asp:Label>&nbsp;&nbsp;&nbsp;
                            <asp:Label ID="Label3" runat="server" Font-Bold="True" Text="Payout  Number"></asp:Label>&nbsp;<asp:Label 
                                ID="lblPayOutNo" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label>
                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
     
        <tr>
            <td>
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label></td>
        </tr>
        <tr>
            <td class="alignr" style="text-align: right">
                <asp:Label ID="Label4" runat="server" Font-Bold="True" ForeColor="White"></asp:Label>&nbsp;<asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                            OnClick="ibtnExcelExport_Click" />
                        <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
                        <asp:ImageButton ID="ibtnPDFExport" runat="server" 
                                 ImageUrl="images/pdf.gif" onclick="ibtnPDFExport_Click" /></td>
        </tr>
        <tr>
            <td>
                <center>
                    <asp:GridView ID="dgr" runat="server" AllowPaging="True" AutoGenerateColumns="False" EmptyDataText="record not found."
                        CellPadding="0" Font-Bold="False" Font-Size="10pt" ForeColor="#333333" GridLines="None"
                        OnPageIndexChanging="dgr_PageIndexChanging" PageSize="100" Width="100%" HorizontalAlign="Center"
                        CssClass="mygrd">
                        <FooterStyle BackColor="#108ACB" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO">
                                <ItemStyle Font-Bold="True" Height="20px" />
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="AppMstRegNo" HeaderText="Id No" />
                            <asp:BoundField DataField="PaymentTranDraftid" HeaderText="Cheque Number" />
                            <asp:BoundField DataField="name" HeaderText="Name">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TotalEarning" HeaderText="Total Earning" />
                            <asp:BoundField DataField="Tds" HeaderText="TDS" />
                            <asp:BoundField DataField="HandlingCharges" HeaderText="Handling Charges" />
                            <asp:BoundField DataField="DispachedAmt" HeaderText="Dispatched Amount" />
                        </Columns>
                    </asp:GridView>
                </center>
            </td>
        </tr>
    </table>

</asp:Content>
