<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="Dwallet.aspx.cs" Inherits="user_Dwallet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="middle">
        <!-- middle content -->
        <div class="col-md-12 indexmiddle" style="padding-top: 25px;">
            <div class="col-md-10">
                <div class="welcome">
                    Welcome Back
                    <asp:Label ID="lblusername" runat="server" Text="Label"></asp:Label>
                    Your Last Login is on
                    <asp:Label ID="lbllasttime" runat="server" Text="Label"></asp:Label>&nbsp;<br />
                    You have agreed and accepted
                    <asp:Label ID="lblcname" runat="server" Text="Label"></asp:Label>
                    Terms and Conditions on
                    <asp:Label ID="lbljointime" runat="server" Text="Label"></asp:Label>
                </div>
                <h3>
                    <img src="images/ewtrans.gif" width="35" height="35">D-Wallet Transaction
                </h3>
            </div>
        </div>
        <div class="col-md-12">
            <h3 style="background: #C20913; color: #fff; padding: 8px 8px; margin: 0px;">
                Transaction History
            </h3>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="col-md-12 indexmiddle">
            <div class="col-md-12">
                <div class="form-group">
                    <div class="col-md-2">
                        E-Wallet Balance :</div>
                    <div class="col-md-2">
                        <asp:Label ID="lblewallet" runat="server"></asp:Label>
                    </div>
                    <div class="col-md-2">
                        Transaction Month :</div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddlmonth" runat="server" CssClass="form-control">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="form-group">
                    <div class="col-md-2">
                        Transaction Year :</div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddlyear" runat="server" CssClass="form-control">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem Value="2">2017</asp:ListItem>
                            <asp:ListItem Value="3">2018</asp:ListItem>
                            <asp:ListItem Value="4">2019</asp:ListItem>
                            <asp:ListItem Value="5">2020</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="primaryAction" />&nbsp;&nbsp;
                        <input onclick="history.back(-1)" value="<< Back" type="button" class="btn btn-success" />
                    </div>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="col-md-12">
                <div class="table-responsive">
                    <table width="100%" class="indexmiddle">
                        <tr>
                            <td colspan="2">
                                <table id="highlight" class="hilite" border="0" cellspacing="0" cellpadding="5" width="100%">
                                    <tr>
                                        <td>
                                            <asp:GridView ID="dglst" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                CssClass="table table-striped table-hover mygrd" Width="100%" HeaderStyle-BackColor="#8CC63F"
                                                OnPageIndexChanging="dglst_PageIndexChanging" PageSize="50">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Sr.No">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %></ItemTemplate>
                                                        <ItemStyle Font-Bold="True" Height="20px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="doe" HeaderText="Date" />
                                                    <asp:BoundField DataField="Transactiontype" HeaderText="Transaction Type" />
                                                    <asp:BoundField DataField="wtype" HeaderText="Wallet Type" />
                                                    <%--   <asp:BoundField DataField="descrip" HeaderText="Description" />--%>
                                                    <asp:TemplateField HeaderText="Description">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldesc" runat="server" Text='<%# Eval("descrip") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Credit" HeaderText="Credit" />
                                                    <asp:BoundField DataField="Debit" HeaderText="Debit" />
                                                    <asp:BoundField DataField="Balance" HeaderText="Balance" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- middle content -->
            <div class="clearfix">
            </div>
            <br />
        </div>
    </div>
</asp:Content>
