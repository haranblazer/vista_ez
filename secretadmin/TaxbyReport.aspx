<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="TaxbyReport.aspx.cs" Inherits="secretadmin_TaxbyReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <%-- <style media="print" type="text/css">
    .page {
        background-color: white !important;
    }
</style>--%>
    <div>
        <h2 class="head">
            <i class="fa fa-list" aria-hidden="true"></i>&nbsp; Details of Taxable Outward Supply
        </h2>
          <div class="panel panel-default">
  <div class="col-md-12">
    <br />
        <br />
        <div class="form-group">
            <div class="col-sm-1">
                <strong><span style="font-size: 10pt; font-family: Verdana">From</span></strong>
            </div>
            <div class="col-sm-2">
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
            </div>
            <div class="col-sm-1">
                <strong><span style="font-size: 10pt; font-family: Verdana">TO</span></strong>
            </div>
            <div class="col-sm-2">
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                <div class="clearfix">
                </div>
                <br />
            </div>
            <%--<div class="col-sm-1">
                <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" CssClass="btn btn-success" />
            </div>--%>
            <div class="col-sm-3 pull-right">
                <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                    Width="25px" />
                <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                    Style="margin-left: 0px" Width="26px" />
                      <div class="col-sm-7 pull-right">
            <asp:Label ID="lblCancel" runat="server" Text="Canceled Invoice"></asp:Label>&nbsp;</div>
            <div class="col-sm-2 pull-right" style="background-color:#ff9980; height:20px; width:10px;">
            </div>
            </div>

            <div class="col-sm-2">
             <asp:DropDownList ID="ddltype" runat="server" CssClass="form-control" 
                                  TabIndex="1"  >
                            <%--<asp:ListItem Value="0">Select</asp:ListItem>--%>
                            <asp:ListItem Value="1">Desending Order</asp:ListItem>
                            <asp:ListItem Value="2">Asending Order</asp:ListItem>         
                            </asp:DropDownList>                
            </div>
          <div class="col-sm-1">
                <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" CssClass="btn btn-success" />
          </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
        <div class="table-responsive">
            <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
                Font-Names="Arial" Font-Size="Small" PageSize="50" AutoGenerateColumns="False"
                EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="dglst_PageIndexChanging"
                OnRowDataBound="dglst_RowDataBound">
                <%-- <AlternatingRowStyle BackColor="#f3fbe5" />--%>
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Invoice NO" DataField="invoiceno" />
                    <asp:BoundField HeaderText="Invoice Date" DataField="doe" />
                    <asp:BoundField HeaderText="GSTN" DataField="soldgst" />
                    <asp:BoundField HeaderText="Name of Reciever" DataField="soldtogst" />
                    <asp:BoundField HeaderText="Invoice Amount" DataField="dp" />
                    <asp:BoundField HeaderText="Taxable Amount" DataField="dpwt" />
                    <asp:BoundField HeaderText="SGST" DataField="sgst" />
                    <asp:BoundField HeaderText="CGST" DataField="cgst" />
                    <asp:BoundField HeaderText="IGST" DataField="igst" />
                    <asp:BoundField HeaderText="POS" DataField="soldtostatecode" />
                </Columns>
            </asp:GridView>
        </div>
        </div>
        <div class="clearfix"></div></div>
</asp:Content>
