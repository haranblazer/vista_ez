<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="growthIncome.aspx.cs" Inherits="admin_growthIncome" Title="Search Closing Income : Admin Control" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="text-align: center">
        <div style="text-align: center">
            <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
                <tr>
                    <td style="width: 100px; height: 25px">
                    </td>
                    <td style="width: 600px; height: 25px">
                    </td>
                    <td style="width: 100px; height: 25px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 25px">
                    </td>
                    <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                        width: 600px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881A2">
                        <strong><span style="font-size: 16px; color: #ffffff">Search Closing Income List</span></strong></td>
                    <td style="width: 100px; height: 25px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 35px">
                    </td>
                    <td style="border-right: #000000 1px solid; border-left: #000000 1px solid; width: 600px;
                        height: 35px; background-color: #EDF0FD">
                        <asp:RadioButton ID="RadioButton1" runat="server" GroupName="p"
                            Text="Growth Income" />
                        &nbsp;
                        <asp:RadioButton ID="RadioButton2" runat="server" GroupName="p" Text="Sponser Growth List" /></td>
                    <td style="width: 100px; height: 35px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 35px">
                    </td>
                    <td style="border-right: #000000 1px solid; border-left: #000000 1px solid; width: 600px;
                        border-bottom: #000000 1px solid; height: 35px; background-color: #ffffff">
                    Enter Closing No. :
                        <asp:TextBox ID="txtColsingNo" runat="server" Style="position: relative" Width="103px"></asp:TextBox>&nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtColsingNo"
                            Display="Dynamic" ErrorMessage="Blank Closingno.">*</asp:RequiredFieldValidator>
                        <asp:RangeValidator
                        ID="RangeValidator1" runat="server" ControlToValidate="txtColsingNo" ErrorMessage="Wrong Choice"
                        MaximumValue="12" MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
                    <td style="width: 100px; height: 35px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="border-left-width: 1px; border-left-color: #000000; border-bottom-width: 1px;
                        border-bottom-color: #000000; width: 600px; border-right-width: 1px; border-right-color: #000000">
                        <asp:Label ID="Label1" runat="server" Style="position: relative" Text="Label" Width="171px" Font-Bold="True" ForeColor="Red"></asp:Label></td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 35px">
                    </td>
                    <td style="border-left-width: 1px; border-left-color: #000000; border-bottom-width: 1px;
                        border-bottom-color: #000000; width: 600px; height: 35px; border-right-width: 1px;
                        border-right-color: #000000">
                        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Style="position: relative"
                            Text="Submit" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
                    <td style="width: 100px; height: 35px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 35px">
                    </td>
                    <td style="border-left-width: 1px; border-left-color: #000000; border-bottom-width: 1px;
                        border-bottom-color: #000000; width: 600px; height: 35px; border-right-width: 1px;
                        border-right-color: #000000">
                        <asp:DataGrid 
                            ID="dgd123"
                             PagerStyle-Mode="NumericPages"
                            runat="server" AllowPaging="True"  OnPageIndexChanged="dgd123_PageIndexChanged" CellPadding="4" ForeColor="#333333" GridLines="None" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" PageSize="25" Width="600px">
                            <PagerStyle BackColor="#69B5D1" ForeColor="Black" HorizontalAlign="Center" Mode="NumericPages" />
                           
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditItemStyle BackColor="#2461BF" />
                            <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <AlternatingItemStyle BackColor="White" />
                            <ItemStyle BackColor="#EDF0FD" />
                            <HeaderStyle BackColor="#69B5D1" Font-Bold="True" Font-Size="X-Large" ForeColor="White" />
                        </asp:DataGrid></td>
                    <td style="width: 100px; height: 35px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 35px">
                    </td>
                    <td style="border-left-width: 1px; border-left-color: #000000; border-bottom-width: 1px;
                        border-bottom-color: #000000; width: 600px; height: 35px; border-right-width: 1px;
                        border-right-color: #000000">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" />
                    </td>
                    <td style="width: 100px; height: 35px">
                    </td>
                </tr>
            </table>
            <br />
        </div>
    </div>
</asp:Content>

