<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="EventHide.aspx.cs" Inherits="secretadmin_EventHide" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <%--  <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
        });
    </script>--%>
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Event Show/ Hide</h4>					
				</div>
   
            <div class="row" >
                <div class="col-sm-2">
                    <asp:TextBox ID="txtUserid" runat="server" CssClass="form-control" placeholder="Enter UserId"></asp:TextBox>
                </div>

                <%--  <label class="col-sm-1">Diamond Club</label>
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_Diamond" runat="server" CssClass="form-control">
                        <asp:ListItem Value="-1">Select</asp:ListItem>
                        <asp:ListItem Value="0">Show </asp:ListItem>
                        <asp:ListItem Value="1">Hide</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <label class="col-sm-1">Tour Achievers</label>
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_Tour" runat="server" CssClass="form-control">
                        <asp:ListItem Value="-1">Select</asp:ListItem>
                        <asp:ListItem Value="0">Show</asp:ListItem>
                        <asp:ListItem Value="1">Hide</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <label class="col-sm-1">Offer Achievers</label>
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_Offer" runat="server" CssClass="form-control">
                        <asp:ListItem Value="-1">Select</asp:ListItem>
                        <asp:ListItem Value="0">Show</asp:ListItem>
                        <asp:ListItem Value="1">Hide</asp:ListItem>
                    </asp:DropDownList>
                </div>--%>
                <div class="col-sm-1">
                    <asp:Button ID="Button1" runat="server" Text="Add" CssClass="btn btn-primary"
                        OnClientClick="return confirm('Are you sure you want to Add？')" OnClick="Button1_Click" />
                </div>
                <div class="col-sm-1">
                    <button id="btnSearch" runat="server" class="btn btn-primary" title="Search" onserverclick="btnSearch_Click">
                        Search
                    </button>
                </div>
           
                <div class="col-sm-1">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/secretadmin/images/excel.gif"
                        OnClick="imgbtnExcel_Click" Width="25px" />
                </div>
            </div>

            <div class="clearfix">
            </div>




            <div class="table-responsive">
                <asp:Panel ID="Panel1" runat="server">
                    <asp:GridView ID="dglst" class="gridd" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover mygrd"
                        PageSize="100" EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red" DataKeyNames="AppMstid"
                        AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging" OnRowCommand="dglst_RowCommand">
                        <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField HeaderText="Sl No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="User ID">
                                <ItemTemplate>
                                    <%# Eval("[AppMstRegno]") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="User Name">
                                <ItemTemplate>
                                    <%# Eval("[Appmstfname]") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Diamond Club" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="60px" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDiamond" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='Diamond'>&nbsp;<%# Eval("IsHideDiamond").ToString() == "0" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Tour Achievers" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="150px" HeaderStyle-Width="80px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkTour" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='Tour'>&nbsp;<%# Eval("IsHideTour").ToString() == "0" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Offer Achievers" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkOffer" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='Offer'>&nbsp;<%# Eval("IsHideOffer").ToString() == "0" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

</asp:Content>

