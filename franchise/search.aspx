<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    EnableEventValidation="false" CodeFile="search.aspx.cs" Inherits="admin_search" %>

<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>

        $(document).ready(function () {
            $('#<%=txtid.ClientID %>').autocomplete(document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(","));
            $('#<%=txtuname.ClientID %>').autocomplete(document.getElementById("<%=divUserName.ClientID%>").innerHTML.split(","));
            $('#<%=txtfname.ClientID %>').autocomplete(document.getElementById("<%=divName.ClientID%>").innerHTML.split(","));
            $('#<%=txtlname.ClientID %>').autocomplete(document.getElementById("<%=divLName.ClientID%>").innerHTML.split(","));
            $('#<%=txtcity.ClientID %>').autocomplete(document.getElementById("<%=divCity.ClientID%>").innerHTML.split(","));
            $('#<%=txtstate.ClientID %>').autocomplete(document.getElementById("<%=divState.ClientID%>").innerHTML.split(","));
            $('#<%=txtMobileNo.ClientID %>').autocomplete(document.getElementById("<%=divMobile.ClientID%>").innerHTML.split(","));
            $('#<%=txtPan.ClientID %>').autocomplete(document.getElementById("<%=divPAN.ClientID%>").innerHTML.split(","));
        });
       
    </script>
    
        <h2 class="head">
           <i class="fa fa-search" aria-hidden="true"></i>  Please enter search words</h2>
        <!-- TitleActions -->
   
    
    <div class="clearfix"> </div> <br />


    <asp:Panel ID="pnlSearch" DefaultButton="Button1" runat="server">

    <div class="form-group"> 
    <div class="col-md-2 col-xs-4"> <strong class="txt"> Id #:  </strong> </div>
    <div class="col-md-3 col-xs-8"> <asp:TextBox ID="txtid" runat="server" CssClass="form-control" ValidationGroup="p"></asp:TextBox> </div>
    </div>
    <div class="clearfix"> </div> <br />

     <div class="form-group"> 
    <div class="col-md-2 col-xs-4"> <strong class="txt"> User Name:  </strong> </div>
    <div class="col-md-3 col-xs-8"> <asp:TextBox ID="txtuname" CssClass="form-control" runat="server"></asp:TextBox> </div>
    </div>
    <div class="clearfix"> </div> <br />

     <div class="form-group"> 
    <div class="col-md-2 col-xs-4"> <strong class="txt"> First Name:  </strong> </div>
    <div class="col-md-3 col-xs-8"> <asp:TextBox ID="txtfname" runat="server" CssClass="form-control"></asp:TextBox> </div>
    </div>
    <div class="clearfix"> </div> <br />

     <div class="form-group" style="display:none;"> 
    <div class="col-md-2 col-xs-4" runat="server" id="lname"> <strong class="txt"> Last Name:  </strong> </div>
    <div class="col-md-3 col-xs-8"> <asp:TextBox ID="txtlname" runat="server" CssClass="form-control" ></asp:TextBox> </div>
    </div>
    <div class="clearfix"> </div> 

     <div class="form-group"> 
    <div class="col-md-2 col-xs-4"> <strong class="txt"> City:  </strong> </div>
    <div class="col-md-3 col-xs-8"> <asp:TextBox ID="txtcity" runat="server" CssClass="form-control"></asp:TextBox> </div>
    </div>
    <div class="clearfix"> </div> <br />

      <div class="form-group"> 
    <div class="col-md-2 col-xs-4"> <strong class="txt"> State:  </strong> </div>
    <div class="col-md-3 col-xs-8">  <asp:TextBox ID="txtstate" runat="server" CssClass="form-control"></asp:TextBox> </div>
    </div>
    <div class="clearfix"> </div> <br />

      <div class="form-group"> 
    <div class="col-md-2 col-xs-4"> <strong class="txt"> Mobile No:  </strong> </div>
    <div class="col-md-3 col-xs-8"> <asp:TextBox ID="txtMobileNo" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox> </div>
    </div>
    <div class="clearfix"> </div> <br />

     <div class="form-group"> 
    <div class="col-md-2 col-xs-4"> <strong class="txt"> PAN No.:  </strong> </div>
    <div class="col-md-3 col-xs-8"> <asp:TextBox ID="txtPan" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox> <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
                        ControlToValidate="txtPan" Display="None" ErrorMessage="Invalid Pan no!!!
                    Please enter starting 5 characters,4th charcter should be p,c,h,f,a,t,b,l,j,g then 4 numbers then 1 char in PAN No.!"
                        ForeColor="#C00000" ValidationExpression="^[a-zA-Z]{3}(p|P|c|C|h|H|f|F|a|A|t|T|b|B|l|L|j|J|g|G)[a-zA-Z][0-9]{4}[a-zA-Z]$"
                        ValidationGroup="p"></asp:RegularExpressionValidator> </div>

    <div class="col-md-3">   <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="p" /> </div>

    </div>
    <div class="clearfix"> </div> 
    
      <div class="form-group"> 
      <div class="col-md-2 col-xs-4"> </div>
    <div class="col-md-1 col-xs-3">  <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" ValidationGroup="p"
                        CssClass="btn btn-success" /> 
    </div>
    <div class="col-md-1 col-xs-3"> <asp:Button ID="Button2" runat="server" Text="Clear" OnClick="Button2_Click" CssClass="btn btn-success" /> </div>
    </div>
    <div class="clearfix"> </div> <br />
    
     
    </asp:Panel>

    <div class="clearfix"> </div> <br />

    <div class="table table-responsive">
    <table style="width: 100%">
        <tr id="export" runat="server">
            <td>
                <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
            </td>
            <td style="text-align: right">
                <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                    OnClick="ibtnExcelExport_Click" />
                <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
                <asp:ImageButton ID="ibtnPDFExport" runat="server" ImageUrl="images/pdf.gif" OnClick="ibtnPDFExport_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <cc1:PagingGridView ID="dgr" runat="server" AllowPaging="True" EmptyDataText="No record found"
                    AutoGenerateColumns="False" PageSize="25" CssClass="mygrd" OnPageIndexChanging="dgr_PageIndexChanging"
                    OnRowCommand="dgr_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="User Id">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnId" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    Text='<%# Eval("AppMstregno") %>' CommandName="EditProfile" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="AppmstFName" HeaderText="Name"></asp:BoundField>
                        <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile No"></asp:BoundField>
                        <asp:BoundField DataField="AppMstCity" HeaderText="City"></asp:BoundField>
                        <asp:BoundField DataField="AppmstState" HeaderText="State"></asp:BoundField>
                        <asp:BoundField DataField="panno" HeaderText="PAN No"></asp:BoundField>
                        <asp:BoundField DataField="SponsorID" HeaderText="Spnsor Id"></asp:BoundField>
                        <asp:BoundField DataField="AppmstDoj" HeaderText="Registration Date"></asp:BoundField>
                    </Columns>
                </cc1:PagingGridView>
            </td>
        </tr>
    </table>
    </div>
    <div class="clearfix"> </div> <br />
    <div id="divUserID" style="display: none;" runat="server">
    </div>
    <div id="divUserName" style="display: none;" runat="server">
    </div>
    <div id="divName" style="display: none;" runat="server">
    </div>
    <div id="divLName" style="display: none;" runat="server">
    </div>
    <div id="divCity" style="display: none;" runat="server">
    </div>
    <div id="divState" style="display: none;" runat="server">
    </div>
    <div id="divMobile" style="display: none;" runat="server">
    </div>
    <div id="divPAN" style="display: none;" runat="server">
    </div>
</asp:Content>
