<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="downstatus1.aspx.cs" Inherits="user_downstatus" Title="Downline Status" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Downline / Upline</h4>
 <div class="row">
                   <div class="col-md-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                    <asp:DropDownList ID="ddlMemberType" runat="server" CssClass="form-control">
                        <asp:ListItem Value="-1">All</asp:ListItem>
                        <asp:ListItem Value="1">Paid</asp:ListItem>
                        <asp:ListItem Value="0">UnPaid</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <label class="col-md-1 control-label">Rank :</label>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddl_Rank" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>
            
                <div class="col-md-2">
                    <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" MaxLength="20" placeholder="Userid"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddl_UpDown" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0">Downline</asp:ListItem>
                        <asp:ListItem Value="1">Upline</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-1 col-xs-6">
                    <asp:Button ID="Button3" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="Button3_Click" />
                </div>
                <div class="col-md-1 col-xs-6 text-right">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user/images/excel.gif" OnClick="imgbtnExcel_Click" Width="25px" />
                </div>

                    <div class="col-sm-6">

                    <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
                </div>
                 <div class="col-sm-3">

                    <asp:Label ID="lbl_Left" runat="server" Font-Bold="True"></asp:Label>
                </div>
                 <div class="col-sm-3">

                    <asp:Label ID="lbl_Right" runat="server" Font-Bold="True"></asp:Label>
                </div>
                </div>

   
   <hr />

            <div class="table-responsive">

            

                    <asp:GridView ID="GridView1" EmptyDataText="No record found" CssClass="table table-striped table-hover"
                        runat="server" AllowPaging="true" AutoGenerateColumns="false" OnPageIndexChanging="GridView1_PageIndexChanging"
                        CellPadding="4" CellSpacing="1" PageSize="50" Width="100%" DataKeyNames="UserId" OnRowCommand="GridView1_RowCommand">
                        <PagerSettings PageButtonCount="25" />
                        <Columns>
                            <asp:TemplateField HeaderText="Sl No" >
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="UserId" HeaderText="User" />
                            <asp:BoundField DataField="UserName" HeaderText="User Name" />
                            <asp:BoundField DataField="ParentId" HeaderText="Sponsor ID" />
                            <asp:BoundField DataField="ParentName" HeaderText="Sponsor Name" />
                            <asp:BoundField DataField="User_Mobile" HeaderText="User Mobile No" />
                            <asp:BoundField DataField="District" HeaderText="User District" />
                            <asp:BoundField DataField="State" HeaderText="User State" />
                            <asp:TemplateField HeaderText="Paid Status">
                                <ItemTemplate>
                                    <%# Eval("IsPaid").ToString() == "1" ? "Paid" : "Unpaid"%>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="TopperStatus" HeaderText="Topper Status" />
                            <asp:BoundField DataField="IDStatus" HeaderText="ID Status" />
                            <asp:BoundField DataField="TotalLeft" HeaderText="TCC Left" />
                            <asp:BoundField DataField="TotalRight" HeaderText="TCC Right" />
                            <asp:BoundField DataField="Pairrank" HeaderText="TCC Matching" />
                            <asp:BoundField DataField="RankName" HeaderText="Topper PIN" />
                        </Columns>
                    </asp:GridView>
                </div>
          
     
</asp:Content>
