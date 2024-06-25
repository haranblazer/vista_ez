<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CompanySetting.aspx.cs" Inherits="admin_Pamentmst"
    MasterPageFile="MasterPage.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dotGreen
        {
            height: 25px;
            width: 25px;
            background-color:#569c49;
            display: inline-block;
            border-radius: 50%;
        }
        .dotGrey
        {
            height: 25px;
            width: 25px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>
    <%--<script src="\paymentmst/paymentmst.js" type="text/javascript"></script>--%>
    <%--<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />--%>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="css/AddCompany.css" rel="stylesheet" type="text/css" />
    <%-- <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtStartDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });

        });   
    </script>--%>
    <div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="pp"
            HeaderText="Please check the following errors......" ShowMessageBox="True" ShowSummary="False"
            Height="90px" Font-Bold="True" />
    </div>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Company Setting</h4>
<div class="row">
                   <div class="col-md-4">
                        <asp:Button ID="btn_BillInvReset" runat="server" Text="Reset All Billing Invoice No. Start at Financial year" CssClass="btn btn-primary" OnClick="btn_BillInvReset_Click" OnClientClick="return confirm('Are you sure you want to Reset All Billing Invoice No. by 1?')" />
                    
                    
       
        </div>
                    <div class="col-md-4 ">
                       <asp:Button ID="Button2" runat="server" Text="Reset All Stock Invoice No. Start at Financial year" CssClass="btn btn-primary" OnClick="btn_StockInvReset_Click" OnClientClick="return confirm('Are you sure you want to Reset All Stock Invoice No. by 1?？')" />
                    </div>
                    <div class="clearfix"></div>

                    <div class="col-md-1 control-label">
                        <asp:Label ID="lblCaption" runat="server" Text="Caption " CssClass="lbl"></asp:Label>
                    </div>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtCaption" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:Label ID="lblsno" runat="server" Text="0" Visible="false"></asp:Label>
                    </div>
                    <div class="col-md-1 control-label">
                        <asp:Label ID="lblUserValue" runat="server" Text="Value" CssClass="lbl"></asp:Label>
                    </div>
                    <div class="col-md-2 ">
                        <asp:TextBox ID="txtUserValue" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-1 control-label">
                        <asp:Label ID="lblIsactive" runat="server" Text="Active" CssClass="lbl"></asp:Label>
                    </div>
                    <div class="col-sm-1 control-label">
                        <asp:CheckBox ID="chkIsActive" runat="server" />
                    </div>
                    <div class="col-sm-1 control-label">
                        <asp:Label ID="lblDescription" runat="server" Text="Description" CssClass="lbl"></asp:Label>
                    </div>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-1">
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-success"/>
                    </div>



                </div>
   
 
            
                    
               
      <hr />
        <div class="table-responsive">
          
             <asp:GridView ID="GridView1" EmptyDataText="Record not found." DataKeyNames="sno"
                CssClass="table table-striped table-hover mygrd" runat="server" AutoGenerateColumns="False"
                AllowPaging="false" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand"
                OnRowEditing="GridView1_RowEditing">
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No" ItemStyle-Width="5%">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="Sno" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Text='<%# Eval("Sno") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Caption" ItemStyle-Width="15%">
                        <ItemTemplate>
                            <asp:Label ID="lblCaption" runat="server" Text='<%# Eval("Caption") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="User Value" DataField="UserVal" ReadOnly="True" ItemStyle-Width="30%"></asp:BoundField>
                    <asp:BoundField DataField="description" HeaderText="Description" ReadOnly="True" ItemStyle-Width="40%">
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="5%">
                        <ItemTemplate>
                            <%# Eval("IsActive").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="5%">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkedit" CommandName="Edit" Text="Edit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>



        </div>
      
         
</asp:Content>
