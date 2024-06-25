<%@ Page Language="C#" MasterPageFile="~/franchise/MasterPage.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="AddCompanyDetails.aspx.cs" Inherits="winneradmin_ADDProduct"
    Title="Add Bank Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
    td,
    th {
      padding:5px 5px; border-color:#ddd; font-size:13px;}
      .form-group{margin-bottom:0px;}
      
     </style>


     
      <h2 class="head"> <i class="fa fa-university" aria-hidden="true"></i>  Set Company's Bank Details </h2>
    
     <div class="clearfix"> </div> <br />


    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <asp:Panel ID="Panel1" runat="server">
   
    <div class="form-group"> 
    <div class="col-md-2"> <strong class="txt"> Bank Name: </strong> </div>
    <div class="col-md-3">  <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control">  </asp:TextBox> <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtBankName"
                        Display="None" ErrorMessage="Please enter bank name" ValidationGroup="aa"></asp:RequiredFieldValidator> </div>
    </div>
     <div class="clearfix"> </div> 
    
     <div class="form-group"> 
    <div class="col-md-2"> <strong class="txt">  Account Name: </strong> </div>
    <div class="col-md-3">  <asp:TextBox ID="txtaccountname" runat="server" CssClass="form-control"></asp:TextBox> <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtaccountname"
                        Display="None" ErrorMessage="Please enter  Account Name" ValidationGroup="aa"></asp:RequiredFieldValidator>
     </div>
    </div>
     <div class="clearfix"> </div> 

      <div class="form-group"> 
    <div class="col-md-2"> <strong class="txt"> Bank A/C No </strong> </div>
    <div class="col-md-3">  <asp:TextBox ID="txtAccNo" runat="server" CssClass="form-control"></asp:TextBox> <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAccNo"
                        Display="None" ErrorMessage="Please enter account number" ValidationGroup="aa"></asp:RequiredFieldValidator>
     </div>
    </div>
     <div class="clearfix"> </div> 

     
      <div class="form-group"> 
    <div class="col-md-2"> <strong class="txt"> Branch </strong> </div>
    <div class="col-md-3">   <asp:TextBox ID="txtbranch" runat="server" CssClass="form-control"></asp:TextBox> <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtbranch"
                        Display="None" ErrorMessage="Please enter  Branch" ValidationGroup="aa"></asp:RequiredFieldValidator>
     </div>
    </div>
     <div class="clearfix"> </div> 

      <div class="form-group"> 
    <div class="col-md-2"> <strong class="txt"> IFS Code </strong> </div>
    <div class="col-md-3">  <asp:TextBox ID="txtifs" runat="server" CssClass="form-control"  ></asp:TextBox> <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtifs"
                        Display="None" ErrorMessage="Please enter  IFS Code" ValidationGroup="aa"></asp:RequiredFieldValidator>
     </div>
    </div>
     <div class="clearfix"> </div> 

       <div class="form-group"> 
    <div class="col-md-2">   </div>
    <div class="col-md-1">  <asp:Button ID="btnInsert" runat="server" CssClass="btn btn-success" OnClick="btnInsert_Click"
                        Text="Submit" ValidationGroup="aa"  />
     </div>
     <div class="col-md-3">  <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="aa" /> </div>
    </div>
     <div class="clearfix"> </div>  <br />
    
       
        <h2 class="head"><i class="fa fa-cogs" aria-hidden="true"></i> Bank List </h2>
        
     <div class="clearfix"> </div>  <br />       

     <div>
        <div class="form-group" style="margin-bottom:15px;"> 
    <div class="col-md-2"> <strong class="txt">  By Bank Name/A/C No </strong> </div>
    <div class="col-md-2">   <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
     </div>
    </div> 

 <div class="form-group" style="margin-bottom:15px;"> 
    <div class="col-md-1"> <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" CssClass="btn btn-success" /> 
    </div>
     </div>
     
   <div class="form-group" style="margin-bottom:15px;"> 
    <div class="col-md-2">  <asp:DropDownList ID="ddSearch" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddSearch_SelectedIndexChanged">
                        <asp:ListItem Value="-1">All</asp:ListItem>
                        <asp:ListItem Value="1">Active</asp:ListItem>
                        <asp:ListItem Value="0">InActive</asp:ListItem>
                    </asp:DropDownList> 
        </div>
     </div>

<div class="form-group" style="margin-bottom:15px;"> 
    <div class="col-md-1"> <asp:Button ID="btnShow" runat="server" OnClick="btnShow_Click" Text="Show All" CssClass="btn btn-success" /> 
    </div>
     </div>

<div class="form-group" style="margin-bottom:15px;"> 
    <div class="col-md-1">  <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                        Style="margin-left: 0px" Width="23px" />
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />
    </div>
     </div>


    </div> 

     <div class="clearfix"> </div> <br />
     <div class="table table-responsive">
        <table class="style1" style="width: 100%;">
            <tr>
                <td class="style42">
                    <asp:Label ID="lblCount" runat="server" Font-Bold="true" ForeColor=" green"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style42">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="SrNo" Width="100%"
                                EmptyDataText="record not found." OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand"
                                AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5"
                                CssClass="mygrd">
                                <Columns>
                                    <asp:BoundField HeaderText="S.No" DataField="SrNo"></asp:BoundField>
                                    <asp:BoundField HeaderText="Bank Name" DataField="CompanyBank"></asp:BoundField>
                                    <asp:BoundField HeaderText="Account Name" DataField="AccountName"></asp:BoundField>
                                    <asp:BoundField HeaderText="Bank A/C No" DataField="CompanyAccNo"></asp:BoundField>
                                    <asp:BoundField HeaderText="Branch" DataField="branch"></asp:BoundField>
                                    <asp:BoundField HeaderText="IFS Code" DataField="ifs"></asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Image ID="imgStatus" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnStatus" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                                runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        </div>
    </asp:Panel>
 <div class="clearfix"> </div> 
</asp:Content>
