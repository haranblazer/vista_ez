<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="tentative-payout.aspx.cs" Inherits="secretadmin_tentative_payout_" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $.noConflict();
        jQuery(document).ready(function ($) {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
     </script>
     <div class="container-fluid page__heading-container">
                        <div class="page__heading d-flex align-items-center">
                            <div class="flex">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="#">Financial Report</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Tentative Payout</li>
                                    </ol>
                                </nav>
                                <h1 class="m-0">Tentative Payout</h1>
                            </div>
                           <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
                        </div>
                    </div>
    <div class="container-fluid page__container">                 
         <div class="panel card card-body">
        <div class="panel panel-default">
            <div class="panel-body"> 
                    <div class="form-group card-group-row row">
                    <div class="col-sm-1">From</div>
                        <div class="col-sm-2">
                            <div class="input-group">
                                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="From"
                                    ToolTip="dd/mm/yyyy" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="clearfix">
                            </div>
                        </div>
                        <div class="col-sm-1">To</div>
                        <div class="col-sm-2">
                            <div class="input-group">
                                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="To"
                                    ToolTip="dd/mm/yyyy"></asp:TextBox>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                       <%--<div class="col-sm-2">
                            <asp:TextBox ID="txtid" runat="server" ValidationGroup="p" CssClass="form-control"
                                placeholder="Search By User Id" ToolTip="Search By User Id"></asp:TextBox>
                            <div class="clearfix">
                            </div>
                            <br />
                        </div>--%>
                        <div class="col-sm-2">
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Style="margin-left: 0px"
                                Width="70px" Text="Search" CssClass="btn btn-success" />
                            <div class="clearfix"></div>
                        </div>
                        <div class="col-sm-2">
                         <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged"
                                CssClass="form-control pull-right">
                                <asp:ListItem Value="25">25</asp:ListItem>
                                <asp:ListItem Value="50">50</asp:ListItem>
                                <asp:ListItem Value="100">100</asp:ListItem>
                                <asp:ListItem Value="All">All</asp:ListItem>
                            </asp:DropDownList>
                            </div>
                            <div class="col-md-2 text-right">
                             <asp:Label ID="Label2" runat="server" Font-Bold="true" ForeColor="Green" />
                            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                                Width="25px" />
                            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                Style="margin-right: 5px" Width="26px" />
                        </div>
                    </div>                 
                    <div class="clearfix">
                    </div>
                    <div class="table-responsive">
                        <asp:Panel ID="Panel1" runat="server">
                            <asp:GridView ID="dglst" runat="server" AllowPaging="True" CssClass="table"
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
                   </div>
                   </div>
                   </div>
                   </div>
    </div>
</asp:Content>
