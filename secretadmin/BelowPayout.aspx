<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="BelowPayout.aspx.cs" Inherits="secretadmin_BelowPayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding-top:0px;">
        <h2 class="head">
           <i class="fa fa-list-ol" aria-hidden="true"></i>  Payout Less Than 100</h2>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <asp:Panel ID="pnlUtility" runat="server">
        <div class="form-group">
            <div class="col-md-2">
                <strong>Select Closing </strong>
            </div>
            <div class="col-md-3">
                <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="form-control" AutoPostBack="True"
                    OnSelectedIndexChanged="ddlDateRange_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

               <div id="DwnWordExcel" runat="server" class="col-sm-2 pull-right">
        <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
            OnClick="ibtnExcelExport_Click" />
        <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
    </div>
        </div>
    </asp:Panel>
    <div class="clearfix">
    </div>
    <br />
 
    <div class="clearfix">
    </div>
    <br />
    <div class="table-responsive">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
            <tr id="trGrid" runat="server">
                <td style="width: 700px; height: 35px; text-align: center">
                    <asp:GridView ID="dgList" runat="server" Width="100%" DataKeyNames="payoutno,appmstregno"
                        AutoGenerateColumns="False" OnPageIndexChanging="dgList_PageIndexChanging" CssClass="table table-striped table-hover mygrd"
                        AllowPaging="True" ShowFooter="True">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="appmstregno" HeaderText="User Id" ReadOnly="True" />
                            <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" />
                            <asp:BoundField DataField="appmstaddress1" HeaderText="Address" ReadOnly="True" />
                            <asp:BoundField DataField="bankname" HeaderText="Bank Name" ReadOnly="True" />
                            <asp:BoundField DataField="branch" HeaderText="Branch" ReadOnly="True" />
                            <asp:BoundField DataField="AcountNo" HeaderText="A/c No." ReadOnly="True" />
                            <asp:BoundField DataField="IFSCode" HeaderText="IFSC" ReadOnly="True" />
                            <asp:BoundField DataField="appmstmobile" HeaderText="Mobile no" ReadOnly="True" />
                            <asp:BoundField DataField="panno" HeaderText="Pan No" ReadOnly="True" />
                            <asp:TemplateField HeaderText="Amount">
                                <ItemTemplate>
                                    <asp:Label ID="lbamount" runat="server" Text='<%#Eval("amount").ToString()%>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
