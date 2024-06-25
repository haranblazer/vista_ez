<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="tentative-payout.aspx.cs" Inherits="secretadmin_tentative_payout_" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
    <h2 class="head">
        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;Tentative Payout</h2>
    <div class="panel panel-default">
        <br />
        <div class="col-md-12">
            <div class="form-group">
                <div class="col-sm-2">
                    <div class="input-group">
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="From"
                            ToolTip="dd/mm/yyyy" Enabled="false"></asp:TextBox><span class="input-group-addon"><i
                                class="fa fa-calendar"></i></span>
                    </div>
                    <div class="clearfix">
                    </div>
                    <br />
                </div>
                <div class="col-sm-2">
                    <div class="input-group">
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="To"
                            ToolTip="dd/mm/yyyy"></asp:TextBox><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                    <div class="clearfix">
                    </div>
                    <br />
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtid" runat="server" ValidationGroup="p" CssClass="form-control"
                        placeholder="Search By User Id" ToolTip="Search By User Id"></asp:TextBox>
                    <div class="clearfix">
                    </div>
                    <br />
                </div>
                <div class="col-sm-2">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Style="margin-left: 0px"
                        Width="70px" Text="Search" CssClass="btn btn-success" />
                    <div class="clearfix">
                    </div>
                   
                </div>
            </div>
            <div class="row">
          <div class="col-md-6 ">
                        <asp:Label ID="Label2" runat="server" Font-Bold="true" ForeColor="Green" />
                        </div>
                    <div class="col-md-6 text-right">
                        <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged"
                            CssClass="form-control pull-right" Width="70px">
                            <asp:ListItem Value="25">25</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="100">100</asp:ListItem>
                            <asp:ListItem Value="All">All</asp:ListItem>
                        </asp:DropDownList>
                        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                            Width="25px" />
                        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                            Style="margin-right: 5px" Width="26px" />
                   </div>
                   </div>
                   <div class="clearfix"></div>
            <div class="table-responsive">
                <asp:Panel ID="Panel1" runat="server">
                    <asp:GridView ID="dglst" runat="server" AllowPaging="True" CssClass="table table-striped table-hover"
                        Font-Names="Arial" Font-Size="Small" ForeColor="#333333" CellPadding="4" CellSpacing="1"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" PageSize="50"
                        Width="100%" EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red"
                        AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging" OnRowDataBound="dglst_RowDataBound"
                        OnRowCommand="dglst_RowCommand" OnRowCreated="dglst_RowCreated" ShowFooter="true">
                        <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %></ItemTemplate>
                                <ItemStyle Font-Bold="True" Height="20px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="userid"></asp:BoundField>
                            <asp:BoundField DataField="name"></asp:BoundField>
                            <asp:BoundField DataField="Amount" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                            </asp:BoundField>
                            <asp:BoundField DataField="Direct" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                            </asp:BoundField>
                            <asp:BoundField DataField="Binary" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                            </asp:BoundField>
                            <asp:BoundField DataField="LDLGold" HeaderText="Gold" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LDLDiamond" HeaderText="Diamond" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LDLEmperor" HeaderText="Emperor" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LDLCrown" HeaderText="Crown" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LtheLDLGold" HeaderText="Gold" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LtheLDLDiamond" HeaderText="Diamond" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LtheLDLEmperor" HeaderText="Emperor" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="LtheLDLCrown" HeaderText="Crown" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" />
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>
            <div class="clearfix">
            </div>
            <br />
        </div>
        <div class="clearfix">
        </div>
    </div>
</asp:Content>
