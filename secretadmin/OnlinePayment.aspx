<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="OnlinePayment.aspx.cs"
    Inherits="secretadmin_OnlinePayment" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">View Purchase Order</h4>
    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txt_userid" runat="server" placeholder="Enter Userid" CssClass="form-control" MaxLength="20"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Amount" runat="server" placeholder="Enter Amount" CssClass="form-control" MaxLength="20"></asp:TextBox>
        </div>





        <div class="col-sm-2">
            <asp:TextBox ID="txt_Orderid" runat="server" placeholder="Enter Order Id" CssClass="form-control" MaxLength="30"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Orderno" runat="server" placeholder="Enter Order No" CssClass="form-control" MaxLength="30"></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Success</asp:ListItem>
                <asp:ListItem Value="0">Fail</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_order" runat="server" CssClass="form-control">
            </asp:DropDownList>
            <%--   <asp:ListItem Value="-1">All</asp:ListItem>
                   <asp:ListItem Value="1"></asp:ListItem>
                    <asp:ListItem Value="1">Customer</asp:ListItem>--%>
        </div>
        <div class="col-sm-2">
            <asp:Button ID="Button1" runat="server" Text="Show" OnClick="Button1_Click" CssClass="btn btn-primary" />
        </div>

        <div class="col-md-1">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="25px" />
        </div>
    </div>


    <hr />
    <div class="table-responsive">
        <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="1" CssClass="table table-striped table-hover"
            AutoGenerateColumns="false" DataKeyNames="Srno, Amount, b_Srno"
            Font-Names="Arial" Font-Size="Small" PageSize="50" EmptyDataText="No Record Found." ShowFooter="true"
            OnRowCommand="dglst_RowCommand" OnPageIndexChanging="dglst_PageIndexChanging" OnRowDataBound="dglst_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="SNo">
                    <ItemTemplate>
                        <b><%#Container.DataItemIndex+1%></b>
                        <asp:HiddenField ID="hnd_invoiceno" runat="server" Value='<%#Eval("invoiceno") %>' />
                        <asp:HiddenField ID="hnd_Srno" runat="server" Value='<%#Eval("Srno") %>' />
                        <asp:HiddenField ID="hnd_b_Srno" runat="server" Value='<%#Eval("b_Srno") %>' />
                        <asp:HiddenField ID="hnd_PaymentStatus" runat="server" Value='<%#Eval("PaymentStatus") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="doe" HeaderText="Date" />
                <asp:BoundField DataField="OrderID" HeaderText="Order Id" />
                   <asp:TemplateField HeaderText="Order No." ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <a href="../Common/UserPOBill.aspx?id=<%#Eval("srno_Encript") %>" target="_blank" style="color:blue;"><%#Eval("OrderNo") %></a>
                    </ItemTemplate>
                </asp:TemplateField>
                 
                <%--<asp:HyperLinkField DataNavigateUrlFields="srno_Encript" HeaderText="Order No." ItemStyle-ForeColor="Blue"
                    DataTextField="OrderNo" DataNavigateUrlFormatString="../Common/UserPOBill.aspx?id={0}" />--%>
                <asp:TemplateField HeaderText="Payable Amount">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Amount" runat="server" Text='<%#Eval("Amount")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="PayMode" HeaderText="Payment Mode" />
                <asp:TemplateField HeaderText="Transaction Amount">
                    <ItemTemplate>
                        <asp:Label ID="lbl_PaybleAmount" runat="server" Text='<%#Eval("OnlineAmount")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Payment Status">
                    <ItemTemplate>
                        <asp:TextBox ID="txt_PayStatus" runat="server" Text='<%#Eval("OnlineStatus") %>' CssClass="form-control" Width="120px"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="	Invoice No." ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk_Success" runat="server" Text='Generate <br/> Invoice' CommandName="Success" Style="color: blue;"
                            OnClientClick="return confirm('Are you sure you want to generate this invoice?');"
                            CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>

                        <%--  <asp:LinkButton ID="lnkinvoiceno" Text='<%#Eval("invoiceno") %>' runat="server"
                                CommandName="Invoice" CommandArgument='<%#((GridViewRow)Container).RowIndex %>' />--%>

                        <%--  <asp:LinkButton ID="lnk_ViewDetail" runat="server" Text='View Detail' CommandName="ViewDetail" Style="color: blue;" 
                                CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>--%>
                       <%-- <asp:LinkButton ID="LinkButton1" Text='<%#Eval("invoiceno") %>' runat="server" Style="color: blue;"
                            CommandName="Invoice" CommandArgument='<%#((GridViewRow)Container).RowIndex %>' />--%>

                        <a href="../Common/Invoice.aspx?id=<%#Eval("b_Srno_Encript") %>" target="_blank" style="color:blue;"><%#Eval("invoiceno") %></a>
                        <%--<asp:LinkButton ID="lnkinvoiceno" Text='<%#Eval("invoiceno") %>' runat="server" DataTextField="InvoiceNo" PostBackUrl="../Common/Invoice.aspx?id={0}" />--%>
                    </ItemTemplate>
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="Remark">
                    <ItemTemplate>
                        <asp:TextBox ID="txt_UserRemark" runat="server" Text='<%#Eval("UserRemark") %>' CssClass="form-control" 
                            Width="120px" TextMode="MultiLine"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:BoundField DataField="OnlineMsg" HeaderText="Online Response" />
                <asp:BoundField DataField="BillingType" HeaderText="Billing Type" />


                <asp:BoundField DataField="SoldTo" HeaderText="Buyer Id" />
                <asp:BoundField DataField="Appmstfname" HeaderText="Buyer Name" />

                <asp:BoundField DataField="SalesRepId" HeaderText="Seller Id" />
                <asp:BoundField DataField="Fname" HeaderText="Seller Name" />
                <asp:TemplateField HeaderText="Customer Type">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Cust_Type" runat="server" Text='<%# Eval("IsCustomer").ToString() == "False" ? "Team Partner" : "Customer" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>

    <%-- <script type="text/javascript">
          var GridId = "<%=dglst.ClientID %>";
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
      </script>--%>
</asp:Content>

