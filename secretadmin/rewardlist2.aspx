<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="rewardlist2.aspx.cs" Inherits="Admin_rewardlist2" %>

<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <div style="padding-top:15px;">
    <h2 class="head">
        Reward List</h2>
        </div>
        <div class="clearfix"> </div>    <br />

    <div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Start Date</label>
        <div class="col-sm-3 col-xs-9" style="padding-bottom:15px;">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            End Date:</label>
        <div class="col-sm-3 col-xs-9" style="padding-bottom:15px;">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>

    </div>

    <div class="clearfix">
    </div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
        </label>
        <div class="col-sm-3 col-xs-9" style="padding-bottom:15px;">
            <asp:DropDownList ID="ddreward" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddreward_SelectedIndexChanged">
                <asp:ListItem>--Select Reward--</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
        </label>
        <div class="col-sm-3 col-xs-9" style="padding-bottom:15px;">
            <asp:RadioButtonList ID="rdolimit" runat="server" CssClass="form-control" RepeatDirection="Horizontal">
                <asp:ListItem class="txt" Selected="True" Value="0">Life Time</asp:ListItem>
                <asp:ListItem class="txt" Value="1">Time Limit</asp:ListItem>
                <asp:ListItem class="txt" Value="111">Tour</asp:ListItem>
            </asp:RadioButtonList>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
                CssClass="form-control">
                <asp:ListItem class="txt" Value="1">Dispatch</asp:ListItem>
                <asp:ListItem class="txt" Value="0">Not Dispatch</asp:ListItem>
                <asp:ListItem class="txt" Value="2">All</asp:ListItem>
            </asp:RadioButtonList>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Leader Id:
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtleader" CssClass="form-control" runat="server"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
    <div class="col-sm-2 col-xs-3"> </div>
        <div class="col-sm-2 col-xs-3">
            <asp:Button ID="btnlist" Text="Show List" CssClass="btn btn-success" runat="server"
                OnClick="btnlist_Click" />
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
   
    <table style="width: 80%; padding-left: 10%">
        <tr>
            <td style="text-align: left">
                <%--<asp:Button ID="Button2" runat="server" OnClick="Button1_Click" CssClass="btn" Text="Show" />--%>
            </td>
            <%--<td style="text-align: right">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/admin/images/excel.gif"
                        OnClick="imgbtnExcel_Click" Width="25px" />
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="~/admin/images/word.jpg"
                        OnClick="imgbtnWord_Click" Style="margin-left: 0px" Width="26px" />
                    <asp:ImageButton ID="imgbtnpdf" runat="server" ImageUrl="~/admin/images/pdf.gif"
                        OnClick="imgbtnpdf_Click" />
                </td>--%>
        </tr>
    </table>
    <div class="clearfix"> </div> <br />
    <div class="table-responsive" id="shwhid" runat="server">
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
       
        <tr>
            <td align="center" style="text-align: center;" valign="top">
             <div class="col-sm-3 pull-right">
                        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/secretadmin/images/excel.gif"
                            OnClick="imgbtnExcel_Click" Width="25px" />
                        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="~/secretadmin/images/word.jpg"
                            OnClick="imgbtnWord_Click" Style="margin-left: 0px" Width="26px" />
                        <asp:ImageButton ID="imgbtnpdf" Visible="false" runat="server" ImageUrl="~/secretadmin/images/pdf.gif"
                            OnClick="imgbtnpdf_Click" />
                    </div>

                    <div class="clearfix"></div>
                <asp:Panel ID="Panel1" runat="server">
                    <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover mygrd"
                        Font-Names="Arial" Font-Size="Small" ForeColor="#333333"  PageSize="50"
                        AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging">
                        <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %></ItemTemplate>
                                <ItemStyle Font-Bold="True" Height="20px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="appmstregno" HeaderText="Id No" />
                            <asp:BoundField DataField="appmstfname" HeaderText="Name" />
                            <asp:BoundField DataField="appmstmobile" HeaderText="Mobile" />
                            <asp:BoundField DataField="doe" HeaderText="Date of Joining" />
                            <asp:BoundField DataField="BankName" HeaderText="Bank Name" />
                            <asp:BoundField DataField="acountno" HeaderText="Acc. No." />
                            <asp:BoundField DataField="panno" HeaderText="Pan No." />
                            <asp:BoundField DataField="awardname" HeaderText="Recognition" />
                            <asp:BoundField DataField="achievedate" HeaderText="Activated On" />
                            <asp:BoundField DataField="AchivedThrough" HeaderText="Achived Through" />
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtRemarks" runat="server" Height="40px" Text='<%# Bind("comment") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="PRINT" CommandArgument='<%# Eval("Appmstregno") %>'
                                            CausesValidation="false">Invoice</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                
                <asp:Button ID="btnsave" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnsave_Click" />
                
            </td>
        </tr>
    </table>
  </div>
   <div class="clearfix"> </div> <br />
</asp:Content>
