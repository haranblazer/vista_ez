<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="FranWalReqApp.aspx.cs" MasterPageFile="MasterPage.master"
    Inherits="secretadmin_userWalletRequestApproved" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromdate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtTodate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>


    <h2 class="head">
        <i class="fa fa-plus-circle" aria-hidden="true"></i>Wallet Request Approved List
    </h2>
    <div class="panel panel-default">
        <div class="col-md-12">
            <br />
            <br />
            <div class="form-group">
                <div class="col-sm-2">
                    Request From:
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtFromdate" runat="server" CausesValidation="True" CssClass="form-control"
                        ToolTip="dd/mm/yyyy" ValidationGroup="a"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFromDate" runat="server" ControlToValidate="txtFromdate"
                        ErrorMessage="From date require." SetFocusOnError="True" ValidationGroup="a"></asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-1">
                    To:
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtTodate" runat="server" CausesValidation="True" ToolTip="dd/mm/yyyy"
                        CssClass="form-control" ValidationGroup="a"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvToDate" runat="server" ControlToValidate="txtTodate"
                        Display="Dynamic" ErrorMessage="To date require." ValidationGroup="a"></asp:RequiredFieldValidator>
                    <div class="clearfix">
                    </div>
                    <br />
                </div>
                <div class="col-sm-3">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" OnClick="Button1_Click"
                        Text="SHOW" ValidationGroup="tv" />
                    <asp:Button ID="Button2" runat="server" CssClass="btn btn-success" OnClick="Button2_Click"
                        Text="SHOW ALL" ValidationGroup="tv" />
                </div>
                <div class="pull-right">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />&nbsp;
                        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click" />&nbsp;
                        <asp:ImageButton ID="imgbtnPdf" runat="server" ImageUrl="images/pdf.gif" OnClick="imgbtnPdf_Click" />
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <asp:Label ID="LblTotalRecord" runat="server" Font-Bold="True"></asp:Label>
                <asp:Label ID="LblAmount" runat="server" Font-Bold="True"></asp:Label>
            </div>
            <div class="table-responsive">
                <asp:GridView ID="GridView1" DataKeyNames="srno" EmptyDataText="No data found." runat="server"
                    AllowPaging="True" AutoGenerateColumns="False" CssClass="table table-hover mygrd"
                    Width="100%" OnPageIndexChanging="dglst_PageIndexChanging" PageSize="50" Font-Size="9pt">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="True" Height="20px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="userid" HeaderText="UserId" />
                        <asp:BoundField DataField="fname" HeaderText="Name" />
                        <asp:BoundField DataField="amt" HeaderText="Amount" />
                        <asp:BoundField DataField="redate" HeaderText="Request Date" />
                        <asp:BoundField DataField="status" HeaderText="Status" />
                        <asp:BoundField DataField="apdate" HeaderText="Approved Date" />
                    </Columns>
                    <HeaderStyle Font-Size="9pt" />
                </asp:GridView>
            </div>
            <script type="text/javascript">
                $(document).ready(

 function () {

     $('.6').show();
 }
);
            </script>
        </div>
        <div class="clearfix">
        </div>
    </div>
</asp:Content>
