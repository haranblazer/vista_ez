<%@ Page Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="WithdrawReport.aspx.cs"
    Inherits="user_DownLineTurnOver" Title="Withdraw" %>

<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
     <script type="text/javascript">
         $.noConflict();
         jQuery(document).ready(function ($) {
             $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
             $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
         }); 
    </script>

     <div class="container-fluid page__heading-container">
                        <div class="page__heading d-flex align-items-center">
                            <div class="flex">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="#">Wallet</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Withdrawal Report</li>
                                    </ol>
                                </nav>
                                <h1 class="m-0">Withdrawal Report</h1>
                            </div>
                           <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
                        </div>
                    </div> 

 
                      <div class="container-fluid page__container">                 
         <div class="panel card card-body">
        <div class="panel panel-default">  
          
            <div class="panel-body">
                      
                            <!--<div class="row">-->
                            <div id="mws-wrapper">
                                <form id="test" name="frmSearch2" class="mws-form" method="get" action="" novalidate="novalidate">
                                <!--<form id="mws-validate-form-op" class="mws-form" name="frmReg" method="post" action="TRAN/tranOPform_cgi.php" onSubmit="return checkDivForm();" >-->
                                <div class="mws-panel grid_7">
                                    <div class="mws-panel-body no-padding">
                                  

                                    <div class="form-group card-group-row row">
                             <div class="col-md-1 col-xs-12 ">
                                     From :</div>
                                 <div class="col-md-2 col-xs-12 ">
                                 <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                                 </div>
                                
                             <div class="col-md-1 col-xs-12 ">
                                     To :</div>
                                 <div class="col-md-2 col-xs-12 ">
                                  <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                                 </div>

                                 <div class="col-md-2 col-xs-12 ">
                                  <asp:Button ID="Button1" runat="server" class="btn btn-success" OnClick="Button1_Click"
                                                Text="SHOW" ValidationGroup="Show" />
                                 </div>

                                  <div class="col-md-4 text-right">
                                     <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                                                            OnClick="ibtnExcelExport_Click" Style="width: 24px" />
                                                        &nbsp;<asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg"
                                                            OnClick="ibtnWordExport_Click" Style="width: 24px" />
                                                        &nbsp;<asp:ImageButton ID="ibtnPDFExport" runat="server" ImageUrl="images/pdf.gif"
                                                            OnClick="ibtnPDFExport_Click" />
                                    </div>
                                 </div>
                                     
                                    
                                      
                                    </div>
                                </div>
                                </form>
                                 <div class="clearfix"></div><br />
                                <div class="col-md-12">
                                  <asp:Label ID="LblTotalRecord" runat="server" Font-Bold="True" Font-Size="Larger"></asp:Label>
                                            <asp:Label ID="LblAmount" runat="server" Font-Bold="True" Font-Size="Larger"></asp:Label>
                                </div>
                                <div class="clearfix"></div>

                                  <div class="table-responsive" style="padding: 8px 8px;">
                                
                                            <cc1:PagingGridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                EmptyDataText="record not found." CssClass="table" Width="100%" OnPageIndexChanging="dglst_PageIndexChanging"
                                                PageSize="50" Font-Size="9pt">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SR.NO.">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <ItemStyle Font-Bold="True" Height="20px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="userid" HeaderText="UserId" />
                                                    <asp:BoundField DataField="fname" HeaderText="Name" />
                                                    <asp:BoundField DataField="wAmount" HeaderText="Withdrawl Amount" />
                                                    <asp:BoundField DataField="TDS" HeaderText="TDS" />
                                                    <asp:BoundField DataField="Handling" HeaderText="Admin Charges" />
                                                    <asp:BoundField DataField="dispatch" HeaderText="Net. Amt" />
                                                    <asp:BoundField DataField="chequeno" HeaderText="Transaction No." />
                                                    <asp:BoundField DataField="dot" HeaderText="Date of Transaction" />
                                                    <asp:BoundField DataField="Remarks" HeaderText="Remark" />
                                                </Columns>
                                                <HeaderStyle Font-Size="9pt" />
                                            </cc1:PagingGridView>
                                   
                                </div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please Enter From Date In (DD/MM/YYYY) Format !"
                                    ControlToValidate="txtFromDate" Font-Bold="False" ForeColor="#C00000" ValidationGroup="Show"
                                    Display="None"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Please Enter From Date In (DD/MM/YYYY) Format !"
                                    Font-Bold="False" ForeColor="#C00000" ControlToValidate="txtFromDate" ValidationExpression="^[0-9/]*"
                                    ValidationGroup="Show" Display="None"></asp:RegularExpressionValidator>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtToDate"
                                    ErrorMessage="Please Enter To Date In (DD/MM/YYYY) Format !" Font-Bold="False"
                                    ForeColor="#C00000" ValidationGroup="Show" Display="None"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Please Enter To Date In (DD/MM/YYYY) Format !"
                                    Font-Bold="False" ForeColor="#C00000" ControlToValidate="txtToDate" ValidationExpression="^[0-9/]*"
                                    ValidationGroup="Show" Display="None"></asp:RegularExpressionValidator>
                                <br />
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                    ShowSummary="False" ValidationGroup="Show" Width="220px" />
                                <!--
		<div class="clearfix"></div>  
		<div id="mws-footer" >Copyright CIBS 2015. All Rights Reserved.</div> 
		-->
                            </div>
                            <!-- mws-wrapper -->
                        </div>
                   </div>
                   </div>
                   </div>
   
    </div>
      

</asp:Content>
