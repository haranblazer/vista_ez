<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="OrderList.aspx.cs" Inherits="user_OrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Product Order List</h4>

    </div>
    
    
  
            <div class="table-responsive">
                
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                     
                            <asp:GridView ID="GridView1" runat="server" AllowPaging="true" CssClass="table"
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
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("Status") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                       
            </div>
      
   
</asp:Content>
