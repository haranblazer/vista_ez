<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" 
    EnableEventValidation="false" CodeFile="MonthlyAssociatePurchase.aspx.cs" Inherits="secretadmin_MonthlyAssociatePurchase" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });

        });

        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }
    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Monthly Associate Purchase List</h4>
   <div class="row">
                    <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Select From Date" MaxLength="10"></asp:TextBox>
                </div>

                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Select To Date" MaxLength="10"></asp:TextBox>
                </div>
                 <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_PackType" runat="server" CssClass="form-control">
                        <%--<asp:ListItem Value="3">RPV</asp:ListItem>
                        <asp:ListItem Value="1">TPV</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>

                <div class="col-sm-2">
                    <asp:TextBox ID="txt_userid" runat="server" CssClass="form-control" placeholder="Enter User Id." MaxLength="30"></asp:TextBox>
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txt_Amount" runat="server" CssClass="form-control" placeholder="Enter Invoice Amount." MaxLength="30"
                        onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
                </div>
                
                <div class="col-sm-1">
                    <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-primary"
                        OnClick="btnSearchByDate_Click" />
                </div>
                <div class="col-sm-1 pull-right">
                    <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                        OnClick="imgbtnExcel_Click" />
                </div>
                </div>

  
         
            <hr />
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
                    Font-Names="Arial" Font-Size="Small" PageSize="50" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging"
                    EmptyDataText="No Record Found." ShowFooter="true" FooterStyle-Font-Bold="true">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Buyer Id" DataField="AppMstRegNo" />
                        <asp:BoundField HeaderText="Buyer Name" DataField="AppMstFName" />
                        <asp:BoundField HeaderText="Buyer State" DataField="AppMstState" />
                        <asp:BoundField HeaderText="Buyer District" DataField="distt" />
                        <asp:BoundField HeaderText="Buyer Mobile No" DataField="AppMstMobile" />
                        <asp:BoundField HeaderText="Total Invoice Value" DataField="InvoiceValue" />
                        <asp:BoundField HeaderText="Total Net Value" DataField="TotalRPV" />
                    </Columns>
                </asp:GridView>
            </div>

      
</asp:Content>

