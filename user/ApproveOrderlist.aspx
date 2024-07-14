<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true"
    CodeFile="ApproveOrderlist.aspx.cs" Inherits="User_ApproveOrderlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
					<h4 class="fs-20 font-w600  me-auto">Approve Order List</h4>					
				</div>

   
                    <div class="table-responsive">
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="GridView1" runat="server" AllowPaging="true" CssClass="table" PageSize="50"
                                        AutoGenerateColumns="false" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging">
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
               
</asp:Content>
