<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true"
    CodeFile="PayOrderDetail.aspx.cs" Inherits="franchise_PayOrderDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <title>Order List</title>
    <script src="js/jquery-1.4.2.js" type="text/javascript"></script>
    <link rel="Stylesheet" type="text/css" href="datepick/jquery.datepick.css"></link>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="datepick/jquery.datepick.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });   
    </script>
    <script type="text/javascript">
        debugger;
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(16)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(16)").each(function () {
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
    <style>
        td, th
        {
            padding: 5px 5px;
            border-color: #ddd;
            font-size: 13px;
        }
    </style>
   
    <h2 class="head"> <i class="fa fa-file-text" aria-hidden="true"></i>  View Out PO </h2>
    
    <div class="clearfix"> </div> <br /> <br />

    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-2 control-label">
            From
        </label>
        <div class="col-sm-3 col-xs-10">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-2 control-label">
            To
        </label>
        <div class="col-sm-3 col-xs-10">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"> </asp:TextBox>
       </div>
    </div>
    <div class="clearfix"> </div> <br />

    <div class="form-group"> 
    <div class="col-sm-2 col-xs-2"> </div>
    <div class="col-sm-2 col-xs-10">  <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success"
                OnClick="btnSearch_Click" /> </div>
    </div>
    <div class="clearfix"> </div> <br />

    <div class="form-group">
        <div class="col-sm-3">
            <br />
            <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="green"></asp:Label>
            <div id="divUserID" style="display: none;" runat="server">
            </div>
        </div>
    </div>
    <div class="col-md-12" style="text-align: right;">
        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
            Width="25px" />
        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
            Style="margin-left: 0px" Width="26px" />
    </div>
    <div class="clearfix"> </div> <br />

    <div class="table-responsive">
        <table class="table">
            <tr>
                <td>
                    <asp:GridView AllowPaging="true" ID="GridView1" runat="server" AutoGenerateColumns="false"
                        PageSize="50" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Order No" DataField="orderno" />
                            <asp:BoundField HeaderText="PO From(ID)" DataField="orderby" />
                            <asp:BoundField HeaderText="PO From(Name)" DataField="orderbyname" />
                            <asp:BoundField HeaderText="PO TO(ID)" DataField="orderto" />
                            <asp:BoundField HeaderText="PO TO(Name)" DataField="ordertoname" />
                            <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                            <asp:BoundField HeaderText="Mode" DataField="mode" />
                            <asp:BoundField HeaderText="Bank" DataField="bank" />
                            <asp:BoundField HeaderText="A/C" DataField="accno" />
                            <asp:BoundField HeaderText="Branch" DataField="branch" />
                            <asp:BoundField HeaderText="IFS" DataField="ifs" />
                            <asp:BoundField HeaderText="Amt" DataField="depositedamt" />
                            <asp:BoundField HeaderText="Remarks" DataField="remarks" />
                            <asp:BoundField HeaderText="Doe" DataField="doe" />
                            <asp:BoundField HeaderText="PayDate" DataField="paydate" />
                            <asp:TemplateField HeaderText="Detail">
                                <ItemTemplate>
                                    <%--to bind the product detail--%>
                                    <span id="tblPrd" style="display: none;">
                                        <%#Eval("tbl") %>
                                    </span><a href="javascript:void" style="color: Blue;">View Detail</a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:HyperLinkField DataNavigateUrlFields="srno" Text="View PO" DataNavigateUrlFormatString="Purchaseorderbill.aspx?id={0}" />
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
