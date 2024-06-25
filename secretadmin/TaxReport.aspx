<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="TaxReport.aspx.cs" Inherits="Admin_TaxReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <div>
        <h2>
            Tax Report</h2>
        <table style="width: 100%">
            <tr>
                <td>
                    <strong><span style="font-size: 10pt; font-family: Verdana">From</span></strong>
                    &nbsp;<asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox>
                    <strong><span style="font-size: 10pt; font-family: Verdana">TO</span></strong> &nbsp;<asp:TextBox
                        ID="txtToDate" runat="server"></asp:TextBox>
                    <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="mygrd"
                        Font-Names="Arial" Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50"
                        AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:BoundField HeaderText="User ID" DataField="regno" />
                            <asp:BoundField HeaderText="Name" DataField="name" />
                            <asp:BoundField HeaderText="DOE" DataField="Date" />
                            <asp:BoundField HeaderText="Invoice No" DataField="invoiceno" />
                            <asp:BoundField HeaderText="2% Tax" DataField="TAX2" />
                            <asp:BoundField HeaderText="4% Tax" DataField="TAX4" />
                            <asp:BoundField HeaderText="5% Tax" DataField="TAX5" />
                            <asp:BoundField HeaderText="10% Tax" DataField="TAX10" />
                            <asp:BoundField HeaderText="12.5% Tax" DataField="TAX12" />
                            <asp:BoundField HeaderText="2% Amt" DataField="Amount2" />
                            <asp:BoundField HeaderText="4% Amt" DataField="Amount4" />
                            <asp:BoundField HeaderText="5% Amt" DataField="Amount5" />
                            <asp:BoundField HeaderText="10% Amt" DataField="Amount10" />
                            <asp:BoundField HeaderText="12.5% Amt" DataField="Amount12" />
                           
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
