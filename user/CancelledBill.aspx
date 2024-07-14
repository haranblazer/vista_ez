<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="CancelledBill.aspx.cs" Inherits="user_CancelledBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <%--<link rel="Stylesheet" type="text/css" href="../datepick/jquery.datepick.css"></link>
    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../datepick/jquery.datepick.js"></script>--%>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
    <script>
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(12)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(12)").each(function () {
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
        .form-group
        {
            margin-bottom: 0px;
        }
    </style>
    <section class="page--header">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-6">
                            <!-- Page Title Start -->
                            <h2 class="page--title h5"> My Purchase</h2>
                            <!-- Page Title End -->
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item active"><span>List Of Cancelled Product Bills</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>
     <section class="main--content">
             <br />
            
            <div class=" gutter-20">
            <div class="col-md-12">
        <div class="panel panel-default">
           
            <div class="panel-body">
                <div class="clearfix">
                </div>
                <br />
                <div class="row">
                    
                        <div class="col-md-1">
                            <label for="MainContent_txtPassword" class="control-label">
                                 From:</label>
                        </div>
                        <div class="col-md-2">
                            <div class="input-group">
                                <asp:TextBox ID="txtFromDate" CssClass="form-control" runat="server" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                                    title="Date should be correct in format ex:- 'dd/mm/yyyy'" required="required"></asp:TextBox>
                               
                            </div>
                           
                        </div>
                  
                    
                        <div class="col-md-1">
                            <label for="MainContent_txtPassword" class="control-label">
                                To :</label>
                        </div>
                        <div class="col-md-2">
                            <div class="input-group">
                                <asp:TextBox ID="txtToDate" CssClass="form-control" runat="server" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                                    title="Date should be correct in format ex:- 'dd/mm/yyyy'" required="required"></asp:TextBox>
                                
                            </div>
                            <div class="clearfix">
                            </div>
                            <br />
                        </div>
                        <div class="col-md-3">
                            <label for="MainContent_txtPassword" class=" control-label">
                                InvoiceNo/ User ID/ Name/ Amount:</label>
                        </div>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" pattern="^[a-zA-Z0-9/\s]+$"
                                title="Please enter only alphanumeric value."></asp:TextBox>
                            <div class="clearfix">
                            </div>
                            <br />
                        </div>
                        <div class="col-md-1">
                        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success ladda-button"
                            Text="Search" OnClick="btnSearch_Click" />
                    </div>
                    </div>
               
                <br />
                <div class="row">
                    <div class="col-md-6">
                        
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"
                            Visible="false">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem Value="1">Admin</asp:ListItem>
                            <asp:ListItem Value="2">Franchise</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
              
            </div>
            <div class="clearfix">
            </div>
            
            <div class="table-responsive" style="padding:20px">
                <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
                <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table"
                    AutoGenerateColumns="false" DataKeyNames="srno,appmstid,monthname" PageSize="50"
                    Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="SrNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Invoice No." DataField="srno" />
                        <asp:BoundField HeaderText="User ID" DataField="regno" />
                        <asp:BoundField HeaderText="Name" DataField="fname" />
                        <asp:BoundField HeaderText="Bill By" DataField="salesrep" />
                        <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                        <asp:BoundField HeaderText="Amount" DataField="amt" />
                        <asp:BoundField HeaderText="Gross" DataField="grossAmt" />
                        <asp:BoundField HeaderText="Tax Amount" DataField="tax" />
                        <asp:BoundField HeaderText="Delivery Charge(%)" DataField="DelCharge" />
                        <asp:BoundField HeaderText="Discount(%)" DataField="Discount" />
                        <asp:BoundField HeaderText="Net Amount" DataField="netAmt" />
                        <asp:BoundField HeaderText="Delivery Address" ItemStyle-Width="300px" DataField="adrs" />
                        <asp:BoundField HeaderText="Bill Date" DataField="doe" />
                        <%--BillingForm.aspx?i={0}&n={1}&s={2}--%>
                        <asp:HyperLinkField ControlStyle-Width="30px" DataNavigateUrlFields="srno,status"
                            Text="Print" DataNavigateUrlFormatString="PrintBill.aspx?id={0}&st={1}" Visible="false" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
    </div>
   
    </section>
    <br />
    <br />
</asp:Content>
