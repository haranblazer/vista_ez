<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="PrintCoupon.aspx.cs" Inherits="secretadmin_PrintCoupon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Print Coupon</h4>
   <div class="row">
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy" placeholder="From"></asp:TextBox>
                        </div>

                        <div class="col-sm-2">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy" placeholder="To"></asp:TextBox>
                        </div>

                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" placeholder="Enter UserId"></asp:TextBox>
                        </div>

                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_Coupon" runat="server" CssClass="form-control" placeholder="Enter Coupon"></asp:TextBox>
                        </div>

                        <div class="col-sm-2" style="display: none;">
                            <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                                <asp:ListItem Value="-1" Selected="True">All</asp:ListItem>
                                <asp:ListItem Value="1">Active</asp:ListItem>
                                <asp:ListItem Value="2">Lucky Draw</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2 ">

                            <button title="Search" id="btnSearch" runat="server" class="btn btn-primary" onserverclick="btnSearch_Click"
                                validationgroup="Show">
                                Search
                            </button>

                        </div>
                        <div class="col-sm-2 ">
                            <input id="btnPrint" type="button" value="Print Coupon" onclick="return PrintPanel();" class="btn btn-primary" />
                        </div>
                    </div>




    <div class="clearfix">
    </div>
    <hr />
    <div class="table-responsive">
        <asp:Panel ID="PnlID" runat="server">
            <asp:DataList ID="DL_Coupon" runat="server" RepeatColumns="3" Width="100%"
                CellSpacing="10" CellPadding="10">
                <ItemTemplate>

                    <div class="row" style="padding-top: 5px; padding-bottom: 4px;">
                        <div class="col-sm-11">

                            <table class="table" width="100%">
                                <tr>
                                    <th colspan="2"><b>Coupon: <%# Eval("L_Counpon") %></b> </th>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <b>UserId: <%# Eval("RegNo") %></b><br />
                                        <%# Eval("appmstfname") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">State:<%# Eval("AppMstState")%> </td>
                                </tr>
                                <tr>
                                    <td colspan="2">Dist: <%# Eval("distt")%></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>

            <style type="text/css">
                body {
                    font-family: Arial;
                    font-size: 10pt;
                }

                .table {
                    border: 1px solid #ccc;
                    border-collapse: collapse;
                    /*width: 200px;*/
                }

                    .table th {
                        background-color: #F7F7F7;
                        color: #333;
                        font-weight: bold;
                    }

                    .table th, .table td {
                        padding: 5px;
                        border: 1px solid #ccc;
                    }
            </style>



        </asp:Panel>
    </div>




    <script type="text/javascript">
        function PrintPanel() {
            var panel = document.getElementById("<%=PnlID.ClientID %>");
            var printWindow = window.open('', '', 'height=400,width=800');
            printWindow.document.write('<html><head><title>Print ICard</title>');
            printWindow.document.write('</head><body >');
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            setTimeout(function () {
                printWindow.print();
            }, 500);
            return false;
        }
    </script>


    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>

</asp:Content>

