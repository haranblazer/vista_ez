<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="franchiseReport.aspx.cs" Inherits="admin_franchiseReport" %>

<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <script type="text/javascript">
         $(function () {
             $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
             $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
         });
    </script>

    <div id="title" class="b2">
        <h2>Franchise Pins</h2>
    </div>



    <div runat="server" id="d">
     <asp:Panel ID="pnlDateRange" runat="server" DefaultButton="Button1">
    <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
            From :
             </label>
            <div class="col-sm-3">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TabIndex="1">
                                        </asp:TextBox>
            </div>
            </div>
            <div class="clearfix"></div><br />
            <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
            To :
             </label>
            <div class="col-sm-3">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TabIndex="2">
                                        </asp:TextBox>
            </div>
            </div>
            <div class="clearfix"></div><br />
            <div class="form-group">
           
            <div class="col-sm-8 pull-right">
                <asp:Button ID="Button1" OnClick="Button1_Click" runat="server" Text="Show " ValidationGroup="Show"
                                            CssClass="btn btn-success" TabIndex="3"></asp:Button>
            </div>
            </div>
            
            </asp:Panel>
             <asp:Panel ID="UserPanel" runat="server" Width="170px" Visible="false">
              <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
            Select User:
             </label>
            <div class="col-sm-3" id="Td1" runat="server">
            <asp:DropDownList ID="ddlUser" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged"
                                            Height="25px" Width="95px">
                                            <asp:ListItem Value="All">All</asp:ListItem>
                                            <asp:ListItem Value="1">Paid</asp:ListItem>
                                            <asp:ListItem Value="0">UpPaid</asp:ListItem>
                                        </asp:DropDownList>
            </div>
            </div>
            </asp:Panel>

        <asp:Panel ID="pnlUtility" runat="server"  >
                                         <div class="clearfix"></div><br />
            <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
          <asp:Label ID="lblAvailableOptions" CssClass="btn" runat="server" Text="Available Options">
                                        </asp:Label>
             </label>
            <div class="col-sm-3"><asp:DropDownList ID="ddlPageSize" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                                           <%-- <asp:ListItem Value="25">25</asp:ListItem>--%>
                                            <asp:ListItem Value="50">50</asp:ListItem>
                                            <asp:ListItem Value="100">100</asp:ListItem>
                                            <asp:ListItem>All</asp:ListItem>
                                        </asp:DropDownList></div>
            </div>
                                        
                                        
                                    <div class="col-sm-2 pull-right">
                                        <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                                            OnClick="ibtnExcelExport_Click" />
                                        <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
                                        <asp:ImageButton ID="ibtnPDFExport" runat="server" ImageUrl="images/pdf.gif" OnClick="ibtnPDFExport_Click" />
                                    </div>
                                    </asp:Panel>
<div class="col-sm-12>

<div style="overflow:auto;">
        <table style="width: 100%">
            <tr>
                <td>
                    <asp:Label ID="lblcount" runat="server" Font-Bold="True" ForeColor="#000000"></asp:Label>
                  
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:PagingGridView ID="dglst" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                        EmptyDataText="Record not found." OnPageIndexChanging="dglst_PageIndexChanging"
                        CssClass="table table-striped table-hover" Width="100%" 
                        ShowFooter="True" OnRowCommand="dglst_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="SrNo." Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server"  Text='<%# Eval("appmstid") %>' ></asp:Label>   
                                </ItemTemplate>
                            </asp:TemplateField>
                          
                            <asp:BoundField DataField="appmstid" HeaderText="Appmstid" Visible="false"></asp:BoundField>
                           
                            <asp:BoundField DataField="fname" HeaderText="Franchise Name"></asp:BoundField>
                     <%--       <asp:BoundField DataField="totalpin" HeaderText="Total Pins"></asp:BoundField>--%>
                            <asp:BoundField DataField="amount" HeaderText="Total Amount"></asp:BoundField>
                              <asp:TemplateField HeaderText="Total Pins">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnId" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                        Text='<%# Eval("totalpin") %>' CommandName="getpins" runat="server" />
                                </ItemTemplate>
                                
                            </asp:TemplateField>
                            
                    
                           
                        </Columns>
                    </cc1:PagingGridView>
                </td>
            </tr>
        </table>
        </div>
        </div>
        </div>
</asp:Content>

