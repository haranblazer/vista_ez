<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="RankQualifylist.aspx.cs" Inherits="secretadmin_RankQualifylist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="">
        <h2 class="head">
            <i class="fa fa-gift" aria-hidden="true"></i>&nbsp;Magic Bonus & Plan B(%) List
        </h2>
    </div>
    <div class="clearfx">
    </div>
    <br />
    <div class="form-group">
        <div class="col-sm-1">
            UserId
        </div>
        <div class="col-sm-2">
            <div class="input-group">
                <asp:TextBox ID="txtuserid" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        
        <div class="col-sm-1">
          Magic Qualified
        </div>
        <div class="col-sm-2">
            <div class="input-group">
                <asp:DropDownList ID="ddl_Qualified" runat="server" CssClass="form-control">
                </asp:DropDownList>
            </div>
            <div class="clearfix">
            </div>
            <br />
        </div>
        <div class="col-sm-1">
            Plan B(%)
        </div>
        <div class="col-sm-1">
            <div class="input-group">
                <asp:DropDownList ID="ddlpercentage" runat="server" CssClass="form-control">
                <asp:ListItem Selected="True" Value="0">All</asp:ListItem>
                <asp:ListItem Value="3">3 (%)</asp:ListItem>
                <asp:ListItem Value="5">5 (%)</asp:ListItem>
                <asp:ListItem Value="8">8 (%)</asp:ListItem>
                <asp:ListItem Value="11">11 (%)</asp:ListItem>
                <asp:ListItem Value="14">14 (%)</asp:ListItem>
                <asp:ListItem Value="17">17 (%)</asp:ListItem>
                <asp:ListItem Value="20">20 (%)</asp:ListItem>
                <asp:ListItem Value="25">25 (%)</asp:ListItem>
                
                </asp:DropDownList>
            </div>
        </div>

        <div class="col-sm-1">
            <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-success"
                OnClick="btnSearchByDate_Click" />
            <div class="clearfix">
            </div>
            <br />
        </div>
        <div class="col-sm-3">
        </div>
          <div class="clearfix">
    </div>
   
    <br />
         <hr />
        <div class=" pull-right">
            <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                OnClick="ibtnExcelExport_Click" />
            <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
        </div>
    </div>
  

    <div class="col-sm-12">
        <asp:Label ID="lblMessage" runat="server" CssClass="control-label" Font-Bold="true"></asp:Label>
        <div class="table table-responsive">
            <asp:GridView ID="gridlist" runat="server" CssClass="table table-striped table-hover mygrd"
                PageSize="50" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Record Found."
                AllowPaging="true">
                <Columns>
                    <asp:TemplateField HeaderText="Sr No.">
                        <ItemTemplate>
                            <asp:Label ID="lblsrno" runat="server" Text='<%# Container.DataItemIndex +1%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="AppMstRegNo" HeaderText="User ID" />
                    <asp:BoundField DataField="AppMstFName" HeaderText="User Name" />
                    <asp:BoundField DataField="pbvamt" HeaderText="PRP" />
                    <asp:BoundField DataField="gbvAmt" HeaderText="GRP" />
                    <asp:BoundField DataField="tlper" HeaderText="Plan B(%)" />
                    <asp:BoundField DataField="tour_qualify" HeaderText="Manager Clubs" />
                    <asp:BoundField DataField="Reward" HeaderText="Rewards" />
                     

                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
