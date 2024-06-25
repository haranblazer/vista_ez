<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="TopperPayReport.aspx.cs" Inherits="admin_TopperPayReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <style>
        td, th
        {
            padding: 5px 5px;
            border-color: #ddd;
        }
    </style>
    <div id="title" class="b2">
        <h2>Report</h2>
    </div>
    <br />
    <div>
        <label for="MainContent_txtPassword" class="col-sm-1 control-label">From</label>
        <div class="col-sm-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div>
        <label for="MainContent_txtPassword" class="col-sm-1 control-label">To</label>
        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div>
        <div class="col-sm-2">
            <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text="Show" OnClick="Button1_Click" />
        </div>
    </div>
    <div>
        <div class="col-sm-2">
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click" />
        </div>
    </div>
<div class="clearfix"></div>
    <br />
    <div class="table-responsive">
       <asp:GridView ID="dgList" runat="server" Width="100%" DataKeyNames="userid" PageSize="50" CssClass="table table-striped table-hover mygrd"
                        AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle"
                        AllowPaging="True" OnPageIndexChanging="dgList_PageIndexChanging"
                        OnRowCommand="dgList_RowCommand" OnRowCreated="dgList_RowCreated">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="regno" HeaderText="User Id" />
                            <asp:BoundField DataField="username" HeaderText="Name" />
                            <asp:BoundField DataField="mobile" HeaderText="Mobile" />
                            <asp:BoundField DataField="sponsorid" HeaderText="Sponsorid" />
                            <asp:BoundField DataField="sponsorname" HeaderText="Sponsor Name" />
                            <asp:BoundField DataField="Doe" HeaderText="Doe" />
                            <asp:HyperLinkField ControlStyle-Width="30px" DataNavigateUrlFields="userid,doe"
                                HeaderText="Total" DataTextField="total" DataNavigateUrlFormatString="TopperDetail.aspx?t={0}&d={1}" />
                            <asp:HyperLinkField ControlStyle-Width="30px" DataNavigateUrlFields="userid,doe"
                                HeaderText="Amount" DataTextField="Amount" DataNavigateUrlFormatString="TopperDetail.aspx?a={0}&d={1}" />
                            <%-- <asp:TemplateField HeaderText="Total Topper">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnStatement" CommandName="Total"  CommandArgument='<%#((GridViewRow)Container).RowIndex %>' Text='<%# Bind("Total") %>' 
                                    runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnStatement" CommandName="Amount"  CommandArgument='<%#((GridViewRow)Container).RowIndex %>' Text='<%# Bind("Amount") %>' 
                                    runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <%-- <asp:BoundField DataField="Amount" HeaderText="Amount" />--%>
                            <%--  <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnStatement" CommandName="Statement" Text="Statement" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'
                                    runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        </Columns>
      </asp:GridView>
             
    </div>
</asp:Content>
