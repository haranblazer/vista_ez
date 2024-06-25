<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="PWallet.aspx.cs" Inherits="user_PWallet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
    <h2 class="head">
        <i class="fa fa-plus-circle" aria-hidden="true"></i>Payout Wallet Passbook
    </h2>
    <div class="panel panel-default">
        <div class="clearfix">
        </div>
        <br />
        <div class="col-md-12 indexmiddle">
            <div class="col-md-12">
                <div class="form-group">
                    <div class="col-md-1">
                        UserId</div>
                    <div class="col-md-2">
                        <asp:TextBox ID="txtuserid" runat="server"></asp:TextBox>
                    </div>

                     <div class="col-md-1">
                        Date</div>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <asp:TextBox ID="txtFromDate" runat="server" placeholder="From" ToolTip="dd/mm/yyyy"
                                CssClass="form-control" TabIndex="1">
                            </asp:TextBox><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <asp:TextBox ID="txtToDate" placeholder="To" ToolTip="dd/mm/yyyy" runat="server"
                                CssClass="form-control" TabIndex="2">
                            </asp:TextBox><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                    <div class="col-md-1">
                        <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CssClass="btn btn-success" />&nbsp;</div>
                    <div class="col-md-1">
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
                                                CssClass="table table-striped table-hover mygrd" Width="100%" OnPageIndexChanging="dglst_PageIndexChanging"
                                                PageSize="50" onrowcommand="dglst_RowCommand" DataKeyNames="BanktranId">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Sr.No">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %></ItemTemplate>
                                                        <ItemStyle Font-Bold="True" Height="20px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="userid" HeaderText="User Id" />

                                                     <asp:BoundField DataField="Credit" HeaderText="Credit" />
                                                    <asp:BoundField DataField="Debit" HeaderText="Debit" />
                                                    <asp:BoundField DataField="Balance" HeaderText="Balance" />
                                                    <asp:BoundField DataField="doe" HeaderText="Date" />
                                                    <asp:BoundField DataField="Transactiontype" HeaderText="Transaction Type" />
                                                    <%-- <asp:BoundField DataField="wtype" HeaderText="Wallet Type" />--%>
                                                    <%--<asp:BoundField DataField="descrip" HeaderText="Description" />--%>
                                                    <asp:TemplateField HeaderText="Description">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldesc" runat="server" Text='<%# Eval("descrip") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                   
                                                    <asp:TemplateField HeaderText="Remark" ControlStyle-Width="150px">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtremark" Width="150px" runat="server" Text='<%# Eval("Reason") %>'></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Add Remarks" ControlStyle-Width="50px">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btADD" Width="50px" runat="server" Text='ADD' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                                                CommandName='Add'><i class="fa fa-plus" aria-hidden="true"></i></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
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
        <div class="clearfix">
        </div>
    </div>
    </div>
</asp:Content>
