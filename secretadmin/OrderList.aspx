<%@ Page Title="Order List" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="OrderList.aspx.cs" Inherits="user_OrderList" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
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
    <script>
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(10)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(10)").each(function () {
                        $(this).find('a').css("display", "block");
                        $(this).find('span').css("display", "none");
                    });
                    //show specific span tag
                    $(this).parent().find('span').css("display", "block");
                    $(this).css("display", "none");
                });
            });
        });

    </script>
    <h1 class="head">
        <i class="fa fa-eye" aria-hidden="true"></i>&nbsp;View Purchase Order
    </h1>
    <div class="panel panel-default">
        <div class="clearfix">
        </div>
        <div>
            <div class="form-group">
                <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                        placeholder="From"></asp:TextBox>
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                        placeholder="To"></asp:TextBox>
                </div>
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                        placeholder="Status" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged"
                        AutoPostBack="true">
                        <asp:ListItem runat="server" Value="-1">All</asp:ListItem>
                        <asp:ListItem runat="server" Value="0">Pending</asp:ListItem>
                        <asp:ListItem runat="server" Value="1">Approved</asp:ListItem>
                        <asp:ListItem runat="server" Value="2">Rejected</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <label class="col-sm-2 control-label">
                    InvoiceNo/ User ID</label>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-sm-1 col-xs-6">
                    <button title="Search" id="btnSearch" runat="server" class="btn btn-success" onserverclick="btnSearch_Click">
                        <i class="fa fa-search"></i>&nbsp;Search
                    </button>
                </div>
                <div class="col-sm-1 col-xs-6 pull-right" style="text-align: right;">
                <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                    Width="25px" />
                <%--<asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                    Style="margin-left: 0px" Width="26px" />--%>
            </div>
            </div>
          
            
        </div>
        <div class="clearfix">
        </div>
        <br />
        <table style="width: 100%">
            <tr>
                <td colspan="3">
                    <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="Green"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                    </div>
                </td>
            </tr>
        </table>
        <div class=" table-responsive">
            <asp:GridView AllowPaging="true" ID="GridView1" runat="server" AutoGenerateColumns="false"
                CssClass="table table-striped table-hover mygrd" PageSize="50" DataKeyNames="srno"
                Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand"
                OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="SrNo.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Doe" DataField="doe" />
                    <asp:HyperLinkField DataNavigateUrlFields="srno,status" HeaderText="Order No" DataTextField="orderno"
                        DataNavigateUrlFormatString="orderbill.aspx?id={0}&st={1}" />
                    <%--<asp:BoundField HeaderText="PO ID" DataField="regno" />--%>
                    <asp:TemplateField HeaderText="PO ID">
                        <ItemTemplate>
                            <asp:Label ID="lblsoldto" runat="server" Text='<%#Eval("regno") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="PO Name" DataField="fname" />
                    <%--<asp:BoundField HeaderText="PO-TO(ID)" DataField="orderto" />--%>
                    <asp:TemplateField HeaderText="PO To(ID)">
                        <ItemTemplate>
                            <asp:Label ID="lblsoldby" runat="server" Text='<%#Eval("orderto") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="PO-TO(Name)" DataField="ordertoname" />
                    <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                    <asp:BoundField HeaderText="Amount" DataField="amt" />
                    <asp:TemplateField HeaderText="Address">
                        <ItemTemplate>
                            <asp:Label ID="lbladdress" runat="server" Text='<%#Eval("adrs") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Detail">
                        <ItemTemplate>
                            <%--to bind the product detail--%>
                            <span id="tblPrd" style="display: none;">
                                <%#Eval("tbl") %>
                            </span><a href="javascript:void" style="color: Blue;">View Detail</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:TemplateField HeaderText="PaymentSlip_Image">  
                            <ItemTemplate>
                                <a href="<%# Eval("PaymentSlip","../User/PaymentSlip/{0}") %>" data-fancybox="gallery">
                                    <asp:Image ID="bankimage" runat="server" Height="50px" ImageUrl='<%# Eval("PaymentSlip","../User/PaymentSlip/{0}") %>'
                                        Width="50px" />
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    <asp:BoundField HeaderText="Bank" DataField="BankName" />
                    <%-- <asp:BoundField HeaderText="Tran_No." DataField="TranNo" />--%>
                    <%--<asp:BoundField HeaderText="Tran_Date" DataField="TranDate" />--%>
                    <asp:BoundField HeaderText="Payment_Mode" DataField="PaymentMode" />
                    <%--<asp:TemplateField HeaderText="Remarks">
                            <ItemTemplate>
                                <asp:TextBox ID="txtcomment" runat="server" CssClass="form-control" Text='<%# Eval("remarks") %>'
                                    Style="max-width: 220px; min-width: 180px" placeholder="Enter Remarks" Enabled='<%# Eval("orderto").ToString() != "Admin"? false : true %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                        Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblSt" runat="server" Font-Size="XX-Large" Text='<%#Eval("Status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Font-Size="XX-Large" Text='<%#Eval("StatusVal") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" Text="Approve" CommandName="A" CssClass="btn btn-success btn-xs"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Enabled='<%# Eval("orderto").ToString() != "Admin"? false : true %>'
                                OnClientClick="return confirm('Are you sure you want to proceed？')" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Button ID="Button2" runat="server" Text="Reject" CommandName="B" CssClass="btn btn-success btn-xs"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Enabled='<%# Eval("orderto").ToString() != "Admin"? false : true %>'
                                OnClientClick="return confirm('Are you sure you want to proceed？')" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="clearfix">
        </div>
    </div>
      <script type = "text/javascript">
          var GridId = "<%=GridView1.ClientID %>";
          var ScrollHeight = 400;
          window.onload = function () {
              debugger;
              var grid = document.getElementById(GridId);
              var gridWidth = grid.offsetWidth;
              var gridHeight = grid.offsetHeight;
              var headerCellWidths = new Array();
              for (var i = 0; i < grid.getElementsByTagName("TH").length; i++) {
                  headerCellWidths[i] = grid.getElementsByTagName("TH")[i].offsetWidth;
              }
              grid.parentNode.appendChild(document.createElement("div"));
              var parentDiv = grid.parentNode;

              var table = document.createElement("table");
              for (i = 0; i < grid.attributes.length; i++) {
                  if (grid.attributes[i].specified && grid.attributes[i].name != "id") {
                      table.setAttribute(grid.attributes[i].name, grid.attributes[i].value);
                  }
              }
              table.style.cssText = grid.style.cssText;
              table.style.width = gridWidth + "px";
              table.appendChild(document.createElement("tbody"));
              table.getElementsByTagName("tbody")[0].appendChild(grid.getElementsByTagName("TR")[0]);
              var cells = table.getElementsByTagName("TH");

              var gridRow = grid.getElementsByTagName("TR")[0];
              for (var i = 0; i < cells.length; i++) {
                  var width;
                  if (headerCellWidths[i] > gridRow.getElementsByTagName("TD")[i].offsetWidth) {
                      width = headerCellWidths[i];
                  }
                  else {
                      width = gridRow.getElementsByTagName("TD")[i].offsetWidth;
                  }
                  cells[i].style.width = parseInt(width) + "px";
                  gridRow.getElementsByTagName("TD")[i].style.width = parseInt(width) + "px";
              }
              parentDiv.removeChild(grid);

              var dummyHeader = document.createElement("div");
              dummyHeader.appendChild(table);
              parentDiv.appendChild(dummyHeader);
              var scrollableDiv = document.createElement("div");
              if (parseInt(gridHeight) > ScrollHeight) {
                  gridWidth = parseInt(gridWidth) + 17;
              }
              scrollableDiv.style.cssText = "overflow:auto;height:" + ScrollHeight + "px;width:" + gridWidth + "px";
              scrollableDiv.appendChild(grid);
              parentDiv.appendChild(scrollableDiv);
          }
</script>
<style>
.table {    
    margin-bottom: 0px;
}
th
{ border:none;
    }
</style>
</asp:Content>
