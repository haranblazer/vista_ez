<%@ Page Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="downstatusUnpaid.aspx.cs" Inherits="user_downstatus" Title="Down Status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                                        <li class="breadcrumb-item"><a href="#"> My Business</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Inactive List</li>
                                    </ol>
                                </nav>
                <h1 class="m-0">
                    Inactive List</h1>
            </div>
            <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
        </div>
    </div>
    <div class="container-fluid page__container">
        <div class="panel card card-body">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="form-group  card-group-row row">
                        <div class="col-md-1">
                            <strong><span style="font-size: 10pt; font-family: Verdana">FROM </span></strong>
                        </div>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                            <div class="clearfix">
                            </div>
                        </div>
                        <div class="col-md-1">
                            <strong><span style="font-size: 10pt; font-family: Verdana">TO</span></strong>
                        </div>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                            <div class="clearfix">
                            </div>
                        </div>
                        <div class="col-md-1">
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Show" CssClass="btn btn-success" />
                        </div>
                        <div class="col-md-2">
                            <asp:DropDownList ID="ddPageSize" runat="server" CssClass="form-control" AutoPostBack="true"
                                OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged">
                                <asp:ListItem>25</asp:ListItem>
                                <asp:ListItem>50</asp:ListItem>
                                <asp:ListItem>100</asp:ListItem>
                                <asp:ListItem>All</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                                Width="25px" /></span> <span>
                                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                        Style="margin-left: 0px" Width="26px" /></span>
                            <%--  <asp:ImageButton ID="imgbtnpdf" runat="server" ImageUrl="~/user_images/pdf.gif" OnClick="imgbtnpdf_Click" />--%>
                        </div>
                        <div class="row" style="display: none">
                            <div class="col-sm-1">
                                <strong><span style="font-size: 10pt; font-family: Verdana">Type :</span></strong>
                            </div>
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddlMemberType" runat="server" AutoPostBack="True" CssClass="form-control"
                                    OnSelectedIndexChanged="ddlMemberType_SelectedIndexChanged">
                                    <%--<asp:ListItem Value="-1">All</asp:ListItem>--%>
                                    <%--<asp:ListItem Value="1">Active</asp:ListItem>--%>
                                    <asp:ListItem Value="0">Inactive</asp:ListItem>
                                    <%--<asp:ListItem Value="2">Repurchase Paid</asp:ListItem>--%>
                                </asp:DropDownList>
                                <div class="clearfix">
                                </div>
                                <br />
                            </div>
                            <br />
                        </div>
                        <div class="clearfix">
                        </div>
                        <div class="table-responsive">
                            <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>&nbsp;&nbsp;
                            <asp:Image ID="IPaid" runat="server" ImageUrl="images/grey.jpg" Width="20px" Visible="false" />&nbsp;
                            <asp:Label ID="lblPaid" runat="server" Text="Active" Visible="false"></asp:Label>&nbsp;
                            <asp:Image ID="IUnPaid" runat="server" ImageUrl="images/white.jpg" Width="20px" Style="border: 1px solis #333"
                                Visible="false" />&nbsp;
                            <asp:Label ID="lblUnPaid" runat="server" Text="Inactive" Visible="false"></asp:Label>&nbsp;
                            <asp:Image ID="IRepurchasepaid" runat="server" ImageUrl="images/BlueLight.jpg" Width="20px"
                                Visible="false" />&nbsp;
                            <asp:Label ID="lblRepurchasepaid" runat="server" Text="Repurchase Paid" Visible="false"></asp:Label>&nbsp;
                            <asp:GridView ID="GridView1" EmptyDataText="No record found" CssClass="table table-striped table-hover mygrd"
                                runat="server" AllowPaging="true" AutoGenerateColumns="false" OnPageIndexChanging="GridView1_PageIndexChanging"
                                CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle"
                                PageSize="50" Width="100%" Style="text-align: center" OnRowDataBound="GridView1_RowDataBound"
                                OnRowCommand="GridView1_RowCommand" DataKeyNames="appMstRegno">
                                <PagerSettings PageButtonCount="25" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No">
                                        <ItemStyle Height="20px" HorizontalAlign="Center" Font-Bold="True"></ItemStyle>
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstid" HeaderText="appmstId" Visible="false">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="appmstfname" HeaderText="Name">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="UserId">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppMstDOJ" HeaderText="Joining Date">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LR" HeaderText="Left/Right">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Appmststate" HeaderText="State">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="appmstcity" HeaderText="City">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <%-- <asp:BoundField DataField="AppMstLeftTotal" HeaderText="Total Left">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AppMstRightTotal" HeaderText="Total Right">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>

                            <asp:BoundField DataField="TotalNewLeft" HeaderText="New Left ">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>

                            <asp:BoundField DataField="TotalNewRight" HeaderText="New Right ">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>--%>
                                    <%--  <asp:BoundField DataField="Joinfor" HeaderText="JoiningFor" Visible="false">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="appmstpaid" HeaderText="Paid Status" Visible="false">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>--%>
                                    <%--  <asp:BoundField DataField="ProductName" HeaderText="ProductName">
                    <ItemStyle HorizontalAlign="Left" />
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>--%>
                                    <%--  <asp:BoundField DataField="AppmstDOJ" HeaderText="Joining Date" Visible="false">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                           
                            <asp:BoundField DataField="reappmstpaid1" HeaderText="" Visible="false">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="No Of Invoices">
                                <ItemTemplate>--%>
                                    <%-- <asp:LinkButton ID="lblin" CommandName="In" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'
                                        Text='<%# Eval("NoOfInvoices")%>' runat="server"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Net Amount">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblAM" CommandName="In" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'
                                        Text='<%# Eval("NetAmont")%>' runat="server"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CV">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblCV" CommandName="In" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'
                                        Text='<%# Eval("CV")%>' runat="server"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:BoundField DataField="paiddate" HeaderText="Paid Date">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>--%>
                                    <%--  <asp:BoundField DataField="NoOfInvoices" HeaderText="No Of Invoices" Visible="TRUE">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NetAmont" HeaderText="Net Amount" Visible="TRUE">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CV" HeaderText="CV" Visible="TRUE">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>--%>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</asp:Content>
