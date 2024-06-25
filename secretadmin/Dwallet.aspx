<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="Dwallet.aspx.cs" MasterPageFile="MasterPage.master" Inherits="user_Dwallet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Wallet Passbook </h4>
    <div class="row">
        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" placeholder="Enter UserId."></asp:TextBox>
        </div>

        <div class="col-md-3">
            <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="btn btn-primary" />&nbsp;&nbsp;
        </div>
        <div class="col-sm-1 pull-right" style="text-align: right;">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                Width="25px" />
        </div>
    </div>


    <hr />


    <div class="table-responsive">
        <asp:GridView ID="dglst" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            CssClass="table table-striped table-hover mygrd" Width="100%" OnPageIndexChanging="dglst_PageIndexChanging"
            PageSize="50">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <ItemStyle Font-Bold="True" Height="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="doe" HeaderText="Date" />
                <asp:BoundField DataField="Userid" HeaderText="User Id" />
                <asp:BoundField DataField="UserName" HeaderText="User Name" />
                <asp:BoundField DataField="Credit" HeaderText="Credit" />
                <asp:BoundField DataField="Debit" HeaderText="Debit" />
                <asp:BoundField DataField="Balance" HeaderText="Balance" />
                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate>
                        <asp:Label ID="lbldesc" runat="server" Text='<%# Eval("descrip") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="Transactiontype" HeaderText="Transaction Type" />
                <asp:BoundField DataField="wtype" HeaderText="Wallet Type" />
                <asp:BoundField DataField="reason" HeaderText="Remarks" />
            </Columns>
        </asp:GridView>
    </div>


    <div class="clearfix">
    </div>
    <br />
    </div>

</asp:Content>
