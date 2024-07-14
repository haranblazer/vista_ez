<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="CancelOrderList.aspx.cs" Inherits="User_CancelOrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <script src="../d2000admin/js/jquery-1.4.2.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(4)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(4)").each(function () {
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
     <section class="page--header">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-6">
                            <!-- Page Title Start -->
                            <h2 class="page--title h5"> My Purchase</h2>
                            <!-- Page Title End -->
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item active"><span>Cancel Order List</span></li>
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
       
        <div class="clearfix">
        </div>
        <br />
       
            <div class="table-responsive">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="GridView1" runat="server" AllowPaging="true" CssClass="table table-striped table-hover mygrd"
                                PageSize="50" AutoGenerateColumns="false" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField HeaderText="SrNo.">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                                    <asp:BoundField HeaderText="Amount" DataField="amt" />
                                    <asp:BoundField HeaderText="Delivery Address" DataField="adrs" />
                                    <asp:TemplateField HeaderText="Detail">
                                        <ItemTemplate>
                                            <%--to bind the product detail--%>
                                            <span id="tblPrd" style="display: none;">
                                                <%#Eval("tbl") %>
                                            </span><a href="javascript:void" style="color: Blue;">View Detail</a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Order Date" DataField="doe" />
                                    
                                 
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    </div>
   
    </section>

</asp:Content>

