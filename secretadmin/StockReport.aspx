<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="StockReport.aspx.cs" Inherits="Admin_StockReport" %>

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
    <style type="text/css">
      tr, td, th{ border:1px solid #ddd}
    </style>       
    
    <div style="padding:15px 0px 0px 15px;">
        <h2 class="head">Stock</h2>  
        </div>
      <div class="clearfix"> </div>
    <br />


        <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-1 col-xs-2 control-label">
                From:</label>
            <div class="col-sm-2 col-xs-10">
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
         <div class="clearfix">
    </div>
    <br />
        <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-1 col-xs-2 control-label">
                To:</label>
            <div class="col-sm-2 col-xs-10" style="margin-bottom:15px;">
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <div class="col-sm-3 col-xs-2 btn1">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text="Show" OnClick="Button1_Click" />
                </div>
            </div>
            <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
            
        </div>
        <div class="clearfix">
    </div>
    <br />
        <div class=" col-sm-12">
                <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
                    GridLines="None" PageSize="50" Width="100%"
                    AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %></ItemTemplate>
                            <ItemStyle Font-Bold="True" Height="20px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="productid" HeaderText="Product ID" />
                        <asp:BoundField DataField="productname" HeaderText="Product Name" />
                        <asp:BoundField DataField="Qty" HeaderText="Qty" />
                    </Columns>
                </asp:GridView>
            </div>
  
</asp:Content>
