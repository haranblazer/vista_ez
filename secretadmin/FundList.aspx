<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="FundList.aspx.cs" Inherits="secretadmin_FundList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  
    <h2 class="head">
   <i class="fa fa-futbol-o" aria-hidden="true"></i>   Fund List(Tour Fund ,Car Fund List)</h2>


    <br />
    <div>
        <label for="MainContent_txtPassword" class="col-sm-2 col-xs-3 control-label">
            Payout No</label>
        <div class="col-sm-2 col-xs-9" style="margin-bottom: 15px;">
            <asp:DropDownList ID="ddlpayoutno" runat="server" OnSelectedIndexChanged="ddlpayoutno_SelectedIndexChanged"
                AutoPostBack="true">
            </asp:DropDownList>
        </div>
    </div>


    <div class="clearfix">
    </div>
    <br />
    <div id="div1" runat="server"  class="col-sm-2" >GRP:<asp:Label ID="lblgrp" runat="server"></asp:Label>
    </div>
    <div class="clearfix">
    </div>
    <br />

    <div class="table-responsive">
        <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
            AutoGenerateColumns="false" PageSize="50" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging">
            <Columns>
                <asp:BoundField HeaderText="User Id" DataField="regno" />
                <asp:BoundField HeaderText="Name" DataField="name" />
                <asp:BoundField HeaderText="Tour Fund" DataField="tf" />
                <asp:BoundField HeaderText="Car Fund" DataField="cf" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
