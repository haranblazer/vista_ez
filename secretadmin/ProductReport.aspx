<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="ProductReport.aspx.cs" Inherits="secretadmin_ProductReport" %>

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
        <h2 class="head">
            <i class="fa fa-arrows" aria-hidden="true"></i>&nbsp;Product Tax Report</h2>
        <div class="form-group">
            <div class="col-sm-1">
                <strong><span style="font-size: 10pt; font-family: Verdana">From</span></strong></div>
            <div class="col-sm-2">
                <div class="input-group">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox><span
                        class="input-group-addon"><i class="fa fa-calendar"></i></span></div>
            </div>
            <div class="col-sm-1">
                <strong><span style="font-size: 10pt; font-family: Verdana">TO</span></strong>
            </div>
            <div class="col-sm-2">
                <div class="input-group">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox><span
                        class="input-group-addon"><i class="fa fa-calendar"></i></span></div>
                <div class="clearfix">
                </div>
                <br />
            </div>
            <div class="col-sm-2">
                <button runat="server" id="Button1" title="Search" onserverclick="Button1_Click"
                    class="btn btn-success">
                    <i class="fa fa-search"></i>&nbsp;Search
                </button>
                <br />
                <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="table-responsive">
            <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover mygrd"
                Font-Names="Arial" Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50"
                AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging">
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Product Id" DataField="Productid" />
                    <asp:BoundField HeaderText="Product Name" DataField="ProductName" />
                    <asp:BoundField HeaderText="Qty 2%" DataField="qty2" />
                    <asp:BoundField HeaderText="Qty 4%" DataField="qty4" />
                    <asp:BoundField HeaderText="Qty 5%" DataField="qty5" />
                    <asp:BoundField HeaderText="Qty 6%" DataField="qty6" />
                    <asp:BoundField HeaderText="Qty 10%" DataField="qty10" />
                    <asp:BoundField HeaderText="Qty 12.5%" DataField="qty12" />
                    <asp:BoundField HeaderText="Tax 2" DataField="tax2" />
                    <asp:BoundField HeaderText="Tax 4" DataField="tax4" />
                    <asp:BoundField HeaderText="Tax 5" DataField="tax5" />
                    <asp:BoundField HeaderText="Tax 6" DataField="tax6" />
                    <asp:BoundField HeaderText="Tax 10" DataField="tax10" />
                    <asp:BoundField HeaderText="Tax 12.5" DataField="tax12" />
                    <asp:BoundField HeaderText="Amount 2" DataField="Amount2" />
                    <asp:BoundField HeaderText="Amount 4" DataField="Amount4" />
                    <asp:BoundField HeaderText="Amount 5" DataField="Amount5" />
                    <asp:BoundField HeaderText="Amount 6" DataField="Amount6" />
                    <asp:BoundField HeaderText="Amount 10" DataField="Amount10" />
                    <asp:BoundField HeaderText="Amount 12.5" DataField="Amount12" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
