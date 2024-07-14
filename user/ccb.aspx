<%@ Page Title="" Language="C#" MasterPageFile="user.master"
    EnableEventValidation="false" AutoEventWireup="true" CodeFile="ccb.aspx.cs" Inherits="secretadmin_Title" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
     <div class="site-content">
      <div class="panel panel-default">
  <div class="panel-heading"
                <i class="fa fa-cart-arrow-down" aria-hidden="true"></i>&nbsp;Consumer Consistency Bonus
            </div> 
    <div class="panel-body">     
    <asp:Panel ID="Panel1" runat="server">
    <div class="form-group">
        <div class="col-sm-1">
            From
        </div>
        <div class="col-sm-2">
            <div class="input-group">
                <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                    MaxLength="10" CssClass="form-control" title="From date should be as dd/mm/yyyy"
                    required="required"></asp:TextBox>
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
        </div>
        <div class="col-sm-1">
            To 
        </div>
        <div class="col-sm-2">
            <div class="input-group">
                <asp:TextBox ID="txtToDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                    MaxLength="10" CssClass="form-control" title="To date should be as dd/mm/yyyy"
                    required="required"></asp:TextBox>
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
            <div class="clearfix"></div>
            <br />
        </div>
        <div class="col-sm-1">
            <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-success"
                OnClick="btnSearchByDate_Click" />
            <div class="clearfix">
            </div>
            <br />
        </div>
        <div class="col-sm-3">
            <asp:DropDownList ID="ddlTitleList" runat="server" AutoPostBack="true" CssClass="form-control"
                OnSelectedIndexChanged="ddlTitleList_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
        <div class=" pull-right">
            <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                OnClick="ibtnExcelExport_Click" />
            <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="col-sm-12">
        <asp:Label ID="lblMessage" runat="server" CssClass="control-label" Font-Bold="true"></asp:Label>
        <div class="table table-responsive">
            <table width="100%;" border="1" cellpadding=2 cellspacing=2 class="table table-striped table-hover">
                <tr style="padding: 10px; font-size: 16px">
                    <th>
                        Time Interval
                    </th>
                    <th>
                        Target Achieve CV
                    </th>
                    <th>
                        Status
                    </th>
                    <th>
                        Rewards
                    </th>
                </tr>
                <tr>
                    <td>
                        July (21th - 31th)
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                    <td rowspan="3">
                        Rs. 2500 Products Not Achieved
                    </td>
                </tr>
                <tr>
                    <td>
                        August
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                </tr>
                <tr>
                    <td>
                        September
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                </tr>
                <tr>
                    <td>
                        October
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                    <td rowspan="3">
                        Rs. 5000 Products Not Achieved
                    </td>
                </tr>
                <tr>
                    <td>
                        November
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                </tr>
                <tr>
                    <td>
                        December
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                </tr>
                <tr>
                    <td>
                        January
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                    <td rowspan="6">
                        Domestic Trip Not Achieved
                    </td>
                </tr>
                <tr>
                    <td>
                        February
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                </tr>
                <tr>
                    <td>
                        March
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                </tr>
                <tr>
                    <td>
                        April
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                </tr>
                <tr>
                    <td>
                        May
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                </tr>
                <tr>
                    <td>
                        June
                    </td>
                    <td>
                        2000 CV
                    </td>
                    <td>
                        x
                    </td>
                </tr>
            </table>
        </div>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Update" CssClass="btn btn-success"
            Visible="false" />
    </div>
    </asp:panel>
  
    </div>   <div class="clearfx">
    </div>
    </div>
    </div>
</asp:Content>
