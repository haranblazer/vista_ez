<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="ClubReport.aspx.cs" Inherits="secretadmin_ClubReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
        <i class="fa fa-list" aria-hidden="true"></i>&nbsp;Club List</h2>
    <%-- <div class="col-sm-12">
        <asp:RadioButtonList ID="rbtClubList" runat="server" 
            RepeatDirection="Horizontal" AutoPostBack="true" 
            onselectedindexchanged="rbtClubList_SelectedIndexChanged">
            <asp:ListItem Value="1" Selected="True">Sliver Club</asp:ListItem>
            <asp:ListItem Value="2">Platinum Club</asp:ListItem>
            <asp:ListItem Value="3">Royal Club</asp:ListItem>
        </asp:RadioButtonList>
    </div>--%>
       <div class="panel panel-default">
        <div class="col-md-12">
    <div class="clearfx"></div>
    <br />
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
            <div class="clearfix">
            </div>
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
            <asp:DropDownList ID="ddlRewardList" runat="server" AutoPostBack="true" CssClass="form-control"
                OnSelectedIndexChanged="ddlRewardList_SelectedIndexChanged">
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
    <div class="table-responsive">
        <asp:GridView ID="GridClubList" runat="server" AutoGenerateColumns="false" AllowPaging="true"
            PageSize="50" Width="100%" CssClass="table table-hover mygrd" OnPageIndexChanging="GridClubList_PageIndexChanging"
            EmptyDataText="No Data Found.">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="AppMstRegNo" HeaderText="UserID" />
                <asp:BoundField DataField="name" HeaderText="Name" />
                <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile" />
               <%-- <asp:BoundField DataField="email" HeaderText="E-mail" />--%>
                <asp:BoundField DataField="sponsorid" HeaderText="Sponsor ID" visible="false"/>
                <asp:BoundField DataField="sponsorname" HeaderText="Sponsor Name" visible="false"/>
                <asp:TemplateField HeaderText="Bronze">
                    <ItemTemplate>
                        <asp:Label ID="lblSClub" runat="server" Text='<%# Eval("Bronze") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Silver">
                    <ItemTemplate>
                        <asp:Label ID="lblPClub" runat="server" Text='<%# Eval("Silver") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Gold">
                    <ItemTemplate>
                        <asp:Label ID="lblRClub" runat="server" Text='<%# Eval("Gold") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="Diamond">
                    <ItemTemplate>
                        <asp:Label ID="lblRClub" runat="server" Text='<%# Eval("Diamond") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                   <asp:TemplateField HeaderText="Emperor">
                    <ItemTemplate>
                        <asp:Label ID="lblRClub" runat="server" Text='<%# Eval("Emperor") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                   <asp:TemplateField HeaderText="Crown">
                    <ItemTemplate>
                        <asp:Label ID="lblRClub" runat="server" Text='<%# Eval("Crown") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               
            </Columns>
        </asp:GridView>
    </div>
     </div>
     </div>
    <div class="clearfix">
    </div>
    <br />
    </div>
   
</asp:Content>
