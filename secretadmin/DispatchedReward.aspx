<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="DispatchedReward.aspx.cs" Inherits="SIMadmin_DispatchedReward" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="130">
            <tr>
                <td colspan="3" style="height: 25px; text-align: center">
                </td>
            </tr>
            <tr>
                <td colspan="3" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                    border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                    background-color: #2881a2; text-align: center">
                    <strong><span style="color: #ffffff; font-family: Arial;">Reward List For Eligible Candidate</span></strong></td>
            </tr>
            <tr>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: blue;
                    border-bottom-width: 1px; border-bottom-color: blue; width: 69px; border-top-color: blue;
                    height: 22px; border-right-width: 1px; border-right-color: blue">
                </td>
                <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: blue;
                    border-bottom-width: 1px; border-bottom-color: blue; width: 79px; border-top-color: blue;
                    height: 22px; border-right-width: 1px; border-right-color: blue">
                </td>
            </tr>
            <tr>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 69px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rdbtnDVDPlayer" runat="server" Font-Bold="True" GroupName="r" Text="DVD PLAYER"
                        Width="184px" Font-Names="Arial" Font-Size="10pt" Checked="True" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 79px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rdbtnDigitalCamera" runat="server" Font-Bold="True" GroupName="r" Text="DIGITAL CAMERA"
                        Width="217px" Font-Names="Arial" Font-Size="10pt" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 100px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rdbtnRefrigrator" runat="server" Font-Bold="True" GroupName="r"
                        Text="REFRIGERATOR" Width="252px" Font-Names="Arial" Font-Size="10pt" /></td>
            </tr>
            <tr>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 69px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rbtnLaptop" runat="server" Font-Bold="True" GroupName="r"
                        Text="LAPTOP" Width="226px" Font-Names="Arial" Font-Size="10pt" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 79px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rdbtnBike" runat="server" Font-Bold="True" GroupName="r"
                        Text='BIKE' Width="212px" Font-Names="Arial" Font-Size="10pt" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 100px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rbtnNanoCar" runat="server" Font-Bold="True" GroupName="r"
                        Text="NANO CAR" Width="234px" Font-Names="Arial" Font-Size="10pt" /></td>
            </tr>
            <tr>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 69px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left"><asp:RadioButton ID="rbtnAltoSparkCar" runat="server" Font-Bold="True" GroupName="r"
                        Text="ALTO / SPARK CAR" Width="234px" Font-Names="Arial" Font-Size="10pt" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 79px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left"><asp:RadioButton ID="rbtnSwift" runat="server" Font-Bold="True" GroupName="r"
                        Text="SWIFT DEZIRE" Width="234px" Font-Names="Arial" Font-Size="10pt" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 100px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left"><asp:RadioButton ID="rbtnSkoda" runat="server" Font-Bold="True" GroupName="r"
                        Text="SKODA" Width="234px" Font-Names="Arial" Font-Size="10pt" /></td>
            </tr>
            <tr>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 69px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rbtnMerceces" runat="server" Font-Bold="True" GroupName="r"
                        Text="MERCEDES" Width="234px" Font-Names="Arial" Font-Size="10pt" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 79px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                    <asp:RadioButton ID="rbtnCash" runat="server" Font-Bold="True" GroupName="r"
                        Text="CASH" Width="234px" Font-Names="Arial" Font-Size="10pt" /></td>
                <td style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 100px;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: left">
                </td>
            </tr>
            <tr>
                <td colspan="3" style="border-right: blue 1px groove; padding-right: 0px; border-top: blue 1px groove;
                    padding-left: 0px; padding-bottom: 0px; border-left: blue 1px groove; width: 100%;
                    padding-top: 0px; border-bottom: blue 1px groove; height: 22px; text-align: center">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="10pt" ForeColor="#C00000" Visible="False" Width="208px" Font-Names="Arial"></asp:Label>
                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="10pt" ForeColor="#C00000" Visible="False" Width="208px" Font-Names="Arial"></asp:Label>&nbsp;</td>
            </tr>
            <tr>
                <td colspan="3" style="border-top-width: 1px; border-left-width: 1px; border-left-color: blue;
                    border-bottom-width: 1px;
                    height: 23px; text-align: center; border-right-width: 1px; border-right-color: blue">
                    <asp:Button ID="btnshow" runat="server" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid"
                        BorderWidth="1px" Font-Bold="True" ForeColor="White" OnClick="Button1_Click"
                        Text="Show" Width="82px" />
                   </td>
            </tr>
            <tr>
                <td colspan="3" style="border-top-width: 1px; border-left-width: 1px; border-left-color: blue;
                    border-bottom-width: 1px; height: 23px; text-align: right; border-right-width: 1px;
                    border-right-color: blue">
                    <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/admin_images/excel.gif" /><asp:Button
                            ID="Button3" runat="server" BackColor="Green" BorderStyle="None" Font-Bold="True"
                            Font-Italic="True" ForeColor="White" OnClick="Button3_Click" Text="EXPORT" Width="80px" /></td>
            </tr>
            <tr>
                <td colspan="3" style="border-top-width: 1px; border-left-width: 1px; border-left-color: blue;
                    border-bottom-width: 1px; border-bottom-color: blue; width: 800px; border-top-color: blue;
                    height: 35px; text-align: center; border-right-width: 1px; border-right-color: blue">
                    &nbsp;<span style="font-size: 11pt; font-family: Arial">Total Selected Member</span>&nbsp;
                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Style="left: 1px" Text="0" Font-Names="Arial" Font-Size="10pt"></asp:Label>
                    &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                    border-left: #000000 1px solid; border-bottom: #000000 1px solid">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                        DataKeyNames="AppMstRegNo" ForeColor="#333333" GridLines="None"
                        Width="100%" Font-Names="Arial" Font-Size="10pt">
                        <Columns>
                          <asp:BoundField HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="srno" HeaderText="SrNo." />
                            <asp:BoundField HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="AppMstRegNo" HeaderText="User Id" />
                            <asp:BoundField HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="uname" HeaderText="Name" />
                            <asp:BoundField  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="AwardName" HeaderText="Award Name" />
                                                        <asp:BoundField  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="Amount" HeaderText="Amount" />
                            <asp:BoundField HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField ="AwardDispatchDate" HeaderText ="Award Dispatched Date" />
                            
                        </Columns>
                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EDF0FD" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="height: 15px; text-align: center">
                    &nbsp; &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td id="Td1" colspan="3" style="height: 15px; text-align: center" runat="server" visible="false">
                    </td>
            </tr>
        </table>
    
    </div>
    </asp:content>
