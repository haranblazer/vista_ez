<%@ Page Title="" Language="C#" EnableEventValidation="false" AutoEventWireup="true"
    MasterPageFile="MasterPage.master" CodeFile="FranchiseList.aspx.cs" Inherits="d2000admin_FranchiseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        $(function () {
            $.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <h2 class="head">
        <i class="fa fa-list" aria-hidden="true"></i>&nbsp;Franchise List
    </h2>

    <div class="panel panel-default">
        <div class="col-md-12">
            <div class="clearfix"></div>
            <br />
            <div class="row" style="padding-bottom: 10px;">
                <label class="col-sm-2">From</label>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
                </div>
                <label class="col-sm-2">To</label>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
                </div>
                <label class="col-sm-2">Franchise ID/Name</label>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search By Franchise Id / Name"></asp:TextBox>
                </div>
            </div>
            <div class="row" style="padding-bottom: 10px;">
                <label class="col-sm-2">State</label>
                <div class="col-sm-2 ">
                    <asp:DropDownList ID="ddl_State" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddl_State_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
                <label class="col-sm-2">District</label>
                <div class="col-sm-2 ">
                    <asp:UpdatePanel ID="UpdateDistrictPanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddl_District" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddl_State" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>


                </div>
                <label class="col-sm-2">City</label>
                <div class="col-sm-2 ">
                    <asp:TextBox ID="txt_City" runat="server" CssClass="form-control" placeholder="Search By City"></asp:TextBox>
                </div>

            </div>
            <div class="row" style="padding-bottom: 10px;">
                <label class="col-sm-2">PIN</label>
                <div class="col-sm-2 ">
                    <asp:TextBox ID="txt_PIN" runat="server" CssClass="form-control" placeholder="Search By Pin Code"></asp:TextBox>
                </div>
                <label class="col-sm-2">Franchise Type</label>
                <div class="col-sm-2 ">
                    <asp:DropDownList ID="ddl_Type" CssClass="form-control" runat="server">
                    </asp:DropDownList>
                </div>
                <label class="col-sm-2">Status</label>
                <div class="col-sm-2 ">
                    <asp:DropDownList ID="ddl_IsActive" CssClass="form-control" runat="server">
                        <asp:ListItem Value="-1">All</asp:ListItem>
                        <asp:ListItem Value="1">Active</asp:ListItem>
                        <asp:ListItem Value="0">InActive</asp:ListItem>
                    </asp:DropDownList>
                </div>

            </div>
            <div class="row" style="padding-bottom: 10px;">
                <label class="col-sm-2">Pan No.</label>
                <div class="col-sm-2 ">
                    <asp:TextBox ID="txt_PanNo" runat="server" CssClass="form-control" placeholder="Search By Pan No."></asp:TextBox>
                </div>
                <label class="col-sm-2">GST</label>
                <div class="col-sm-2 ">
                    <asp:TextBox ID="txt_GST" runat="server" CssClass="form-control" placeholder="Search By GST"></asp:TextBox>
                </div>
                <div class="col-sm-10">
                </div>
                <div class="col-sm-2">
                    <button id="btnSearch" runat="server" class="btn btn-success" title="Search" onserverclick="btnSearch_Click">
                        <i class="fa fa-search"></i>&nbsp;Search
                    </button>
                </div>
            </div>
            <div class="row" style="padding-bottom: 10px;">
                <div class="col-sm-9">
                    <asp:Label ID="lblCount" runat="server" Font-Bold="true"></asp:Label>
                </div>
                <div class="col-sm-1">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                        Style="margin-left: 0px" Width="23px" />
                </div>
                <div class="col-sm-2  pull-right">
                    <asp:DropDownList ID="ddPageSize" runat="server" CssClass="form-control" AutoPostBack="true"
                        OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged">
                        <asp:ListItem>100</asp:ListItem>
                        <asp:ListItem>500</asp:ListItem>
                        <asp:ListItem>All</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="row" style="padding-bottom: 10px;">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover"
                    DataKeyNames="FranchiseId,FranchiseName,type" EmptyDataText="Record not found." EmptyDataRowStyle-ForeColor="Red"
                    OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand" AllowPaging="True"
                    OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5">
                    <Columns>
                        <asp:TemplateField HeaderText="Franchise Id">
                            <ItemTemplate>
                                <%# Eval("FranchiseId")%>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Franchise Name">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbl_TI" runat="server" Text='<%# Eval("FranchiseName")%>' Style="color: blue;" CommandName="login" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Type" DataField="Type"></asp:BoundField>

                        <asp:TemplateField HeaderText="Status" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkStatus" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='Status'>&nbsp;<%# Eval("Status").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Vendor Authorization" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkIsVendorAuth" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='VendorAuth'>&nbsp;<%# Eval("IsVendorAuth").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Is Return" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkIsReturn" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='IsReturn'>&nbsp;<%# Eval("IsReturn").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Contact Person" DataField="ContactPerson"></asp:BoundField>
                        <asp:BoundField HeaderText="Mobile No." DataField="MobileNo"></asp:BoundField>

                        <asp:BoundField HeaderText="State" DataField="State"></asp:BoundField>
                        <asp:BoundField HeaderText="District" DataField="District"></asp:BoundField>
                        <asp:BoundField HeaderText="City" DataField="City"></asp:BoundField>
                        <asp:BoundField HeaderText="PIN" DataField="PIN"></asp:BoundField>
                        <asp:BoundField HeaderText="Address" DataField="Address"></asp:BoundField>
                        <asp:BoundField HeaderText="PAN" DataField="PAN"></asp:BoundField>
                        <asp:BoundField HeaderText="BankName" DataField="BankName"></asp:BoundField>

                        <asp:BoundField HeaderText="Account No" DataField="AccountNo"></asp:BoundField>
                        <asp:BoundField HeaderText="IFSC Code" DataField="IFSCCode"></asp:BoundField>
                        <asp:BoundField HeaderText="Registration Date" DataField="RegistrationDate"></asp:BoundField>
                        <asp:BoundField HeaderText="Sponsor ID" DataField="SponsorID"></asp:BoundField>
                        <asp:BoundField HeaderText="Sponsor Name" DataField="SponsorName"></asp:BoundField>
                        <asp:BoundField HeaderText="Opening Amount" DataField="OpeningAmount"></asp:BoundField>
                        <%--<asp:BoundField HeaderText="Status" DataField="Status"></asp:BoundField>--%>



                        <asp:HyperLinkField DataNavigateUrlFields="FranchiseId" HeaderText="Action" Text="Edit"
                            DataNavigateUrlFormatString="../secretadmin/CreateFranchise.aspx?n={0}" />

                        <%--   <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Image ID="imgStatus" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                     <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnStatus" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    runat="server" OnClientClick="return confirm('Are you sure?')" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnEdit" Text="Edit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    CommandName="Edit" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Bill Inv No" DataField="InvNo" ReadOnly="true"></asp:BoundField>
                        <asp:BoundField HeaderText="Stock Inv No" DataField="StockInv" ReadOnly="true"></asp:BoundField>
                        --%>

                        <%-- <asp:TemplateField HeaderText="Action" ItemStyle-Width="120px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnEdit2" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    CommandName="login" runat="server"><i class="fa fa-sign-in" aria-hidden="true"></i>&nbsp;Login</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div class="clearfix">
        </div>
    </div>
</asp:Content>
